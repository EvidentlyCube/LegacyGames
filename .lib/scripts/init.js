/**
 * Initialize the repository to allow building projects and running scripts.
 */

import { spawn } from 'node:child_process';
import { resolve } from 'node:path';
const __dirname = import.meta.dirname;

process.chdir(resolve(__dirname, ".."));

async function init() {
    console.log("Install dependencies");
    await runCommand("npm", ['install']);

    console.log("Install submodules");
    await runCommand('git', ['submodule', 'update', '--init', '--recursive']);


async function runCommand(command, args = []) {
    return new Promise((resolve, reject) => {
        const child = spawn(command, args, {
            stdio: 'inherit',
            shell: true,
        });

        child.on('error', reject);
        child.on('close', resolve);
    })
}

init().then(
    () => console.log("Initialized"),
    e => console.log("Error occurred during initialization: " + String(e))
)