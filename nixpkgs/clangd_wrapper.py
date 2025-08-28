#!/usr/bin/env python3

import os
import sys
import json


def main():
    CCDB = "compile_commands.json"
    exec_args = ["clangd", *sys.argv[1:]]

    if os.path.isfile(CCDB):
        with open(CCDB, "r") as f:
            ccdb_json = json.load(f)

        nix_drivers = set()
        for entry in ccdb_json:
            command = entry.get("command", "")
            parts = command.split()
            for part in parts:
                if part.startswith("/nix/store"):
                    nix_drivers.add(part)
        if nix_drivers:
            drivers = ",".join(nix_drivers)
            exec_args = ["clangd", f"--query-driver={drivers}", *sys.argv[1:]]

    os.execvp(exec_args[0], exec_args)


if __name__ == "__main__":
    main()
