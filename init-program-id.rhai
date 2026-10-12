// Give every generated project its own program ID, like `anchor init` does: create the
// program keypair, then let Anchor write its address into lib.rs and Anchor.toml.
// cargo-generate asks before running it (or pass --allow-commands) and removes this file.
let crate_name = variable::get("crate_name");
let keypair = `target/deploy/${crate_name}-keypair.json`;

try {
    let output = system::command(
        `mkdir -p target/deploy && solana-keygen new --no-bip39-passphrase --silent --outfile ${keypair} && anchor keys sync >/dev/null && solana-keygen pubkey ${keypair}`
    );
    print(`Program ID: ${output}`);
} catch (err) {
    print(`Could not set up the program ID automatically: ${err}`);
    print("Inside the project, run `anchor build && anchor keys sync` instead.");
}
