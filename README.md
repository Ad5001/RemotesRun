# RemotesRun
---
*Run several scripts on remote servers automatically.*

This script allows you to execute common sequencially scripts on various servers. It can be use to quickly run maintainance scripts on several servers while having proper feedback when things go wrong.

## Dependencies:
This script has several dependencies:
- bash
- awk
- sshpass
- docker on remote server if it does not have it.

## How to use

### Creating scripts
First of all, you will need create the scripts that will be executed on the remote servers.     
1. Head to the `remotes` directory
2. Create a new directory named using the `user`@`host` pattern for the remote host and the user on it you want to execute the script on. (e.g: `root@example.org`) if it does not exist.
3. Create a new script (the file name will be used as script name when it's executed at runtime).
4. (optional) You can import common libraries by adding a comment on line two following this pattern : `# Requires: libraries/<path/to/library>.sh`. You can import several libraries by separating them by a space. You can see the various default included libraries in the `libraries` directory.

**Note**: The libraries/common.sh library will always be imported into the server so you don't need to reference it there.

You can see an example in `remotes/root@example.org/Update.sh`.

### Run all scripts

To run all of thoses scripts, it's fairly simple: just execute the `run_all.sh` script.   
It will prompt you for the various passwords of the various hosts, or the passphrases if you have ssh keys setup, and then execute the scripts sequencially.  

**Note**: If you enter skip in the password field, the current host will be skipped.

If you want to use another directory for your remotes scripts, you can set the `REMOTES` environement variable before launching the `run_all.sh` script like this:
```bash
REMOTES=/path/to/remotes ./run_all.sh
```
