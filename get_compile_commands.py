#!/usr/bin/python

import os
import json

hated_dirs = [ ".cache", ".git", ".svn" ]
# wanted_dirs = [ "kernel", os.path.join("include", "linux") ]
wanted_dirs = []
header_dir_backtrace_level = 1
compile_commands_json = "compile_commands.json"

def is_header_file(file):
    return file.endswith(".h")

def is_source_file(file):
    return file.endswith(".c")

def contains_include(path):
    return "include" in path

def contains_wanted_dir(dir):
    for tdir in wanted_dirs:
        if tdir in dir:
            return True

    return False

def is_wanted_dir(root, cwd, dir):
    # for thedir in [os.path.join(root, _) for _ in wanted_dirs]:
    for thedir in wanted_dirs:
        if thedir.startswith(os.path.join(cwd, dir)) or os.path.join(cwd, dir).startswith(thedir):
            return True

    return False

def filter_wanted_dir(root, cwd, dirs):
    return [dir for dir in dirs if is_wanted_dir(root, cwd, dir)] if wanted_dirs else dirs

def is_hated_dir(root, cwd, dir):
    # for thedir in [os.path.join(root, _) for _ in hated_dirs]:
    for thedir in hated_dirs:
        if os.path.join(cwd, dir).startswith(thedir):
            return True

    return False

def filter_hated_dir(root, cwd, dirs):
    return [dir for dir in dirs if not is_hated_dir(root, cwd, dir)] if hated_dirs else dirs

def all_files(root):
    for cwd, dirs, files in os.walk(root):
        # dirs[:] = [dir for dir in dirs if dir not in hated_dirs]
        dirs[:] = filter_hated_dir(root, cwd, dirs)
        dirs[:] = filter_wanted_dir(root, cwd, dirs)

        for file in files:
            yield (file, os.path.join(cwd, file), cwd)

def scan_files(root):
    header_dirs = list()
    source_files = list()

    for (file, filepath, cwd) in all_files(root):
        if is_header_file(file) and cwd not in header_dirs:
            header_dirs.append(cwd)
        elif is_source_file(file):
            source_files.append(filepath)

    return header_dirs, source_files

def fetch_upper_dirs(dir):
    for _ in range(header_dir_backtrace_level):
        dir = os.path.dirname(dir)
        yield dir

def cook_header_dirs(root, header_dirs):
    for dir in header_dirs:
        for upperdir in fetch_upper_dirs(dir):
            if contains_include(dir) and not contains_include(upperdir):
                continue
            if not root.startswith(upperdir) and upperdir not in header_dirs:
                header_dirs.append(upperdir)

def canonical_path(root, path):
    return path.replace(root, ".")

def gen_arguments(root, header_dirs):
    arguments = [ "gcc" ]

    for dir in header_dirs:
        arguments.append("-I")
        arguments.append(canonical_path(root, dir))

    return arguments

def gen_compile_commands(root, header_dirs, source_files):
    for filepath in source_files:
        desc = { "directory": root, "file": canonical_path(root, filepath) }
        desc["arguments"] = gen_arguments(root, header_dirs)
        yield desc

def write_file(path, content):
    with open(path, 'w') as f:
        f.write(content)

def write_file_append(path, content):
    with open(path, 'a') as f:
        f.write(content)

def clear_file(path):
    write_file(path, "")

def make_json_file(root, header_dirs, source_files):
    is_first_desc = True
    clear_file(compile_commands_json)

    write_file_append(compile_commands_json, "[")

    for desc in gen_compile_commands(root, header_dirs, source_files):
        if not is_first_desc:
            write_file_append(compile_commands_json, ",")
        else:
            is_first_desc = False
        write_file_append(compile_commands_json, json.dumps(desc))

    write_file_append(compile_commands_json, "]")

def preproccess(root):
    global wanted_dirs
    global hated_dirs

    hated_dirs[:] = [os.path.join(root, _) for _ in hated_dirs]
    wanted_dirs[:] = [os.path.join(root, _) for _ in wanted_dirs]

def main(root):
    preproccess(root)
    header_dirs, source_files = scan_files(root)
    cook_header_dirs(root, header_dirs)
    make_json_file(root, header_dirs, source_files)

if __name__ == "__main__":
    main(os.getcwd())
