[Read more at git-secret.io](https://git-secret.io/)

git-secret - bash tool to store private data inside a git repo
==============================================================

Usage: Setting up git-secret in a repository
--------------------------------------------

These steps cover the basic process of using `git-secret` to specify users and files that will interact with `git-secret`, and to encrypt and decrypt secrets.

1. Before starting, [make sure you have created a `gpg` RSA key-pair](#using-gpg): which are a public key and a secret key pair, identified by your email address and stored with your gpg configuration. Generally this gpg configuration and keys will be stored somewhere in your home directory.

2. Begin with an existing or new git repository.

3. Initialize the `git-secret` repository by running `git secret init`. The `.gitsecret/` folder will be created, with subdirectories `keys/` and `paths/`, `.gitsecret/keys/random_seed` will be added to `.gitignore`, and `.gitignore` will be configured to _not_ ignore `.secret` files.

**Note** all the contents of the `.gitsecret/` folder should be checked in, **/except/** the `random_seed` file. This also means that of all the files in `.gitsecret/`, only the `random_seed` file should be mentioned in your `.gitignore` file.

1. Add the first user to the `git-secret` repo keyring by running `git secret tell your@email.id`.

2. Now it’s time to add files you wish to encrypt inside the `git-secret` repository. This can be done by running `git secret add <filenames...>` command, which will also (as of 0.2.6) add entries to `.gitignore`, stopping those files from being added or committed to the repo unencrypted.

3. Then run `git secret hide` to encrypt the files you added with `git secret add`. The files will be encrypted with the public keys in your git-secret repo’s keyring, each corresponding to a user’s email that you used with `tell`.

After using `git secret hide` to encrypt your data, it is safe to commit your changes. **NOTE:** It’s recommended to add the `git secret hide` command to your `pre-commit` hook, so you won’t miss any changes.

1. Later you can decrypt files with the `git secret reveal` command, or print their contents to stdout with the `git secret cat` command. If you used a password on your GPG key (always recommended), it will ask you for your password. And you’re done!

### Usage: Adding someone to a repository using git-secret

1. [Get their `gpg` public-key](#using-gpg). **You won’t need their secret key.** They can export their public key for you using a command like: `gpg --armor --export their@email.id > public_key.txt # --armor here makes it ascii`

2. Import this key into your `gpg` keyring (in `~/.gnupg` or similar) by running `gpg --import public_key.txt`

3. Now add this person to your secrets repo by running `git secret tell their@email.id` (this will be the email address associated with their public key)

4. Now remove the other user’s public key from your personal keyring with `gpg --delete-keys their@email.id`

5. The newly added user cannot yet read the encrypted files. Now, re-encrypt the files using `git secret reveal; git secret hide -d`, and then commit and push the newly encrypted files. (The -d options deletes the unencrypted file after re-encrypting it). Now the newly added user will be able to decrypt the files in the repo using `git-secret reveal`.

Note that when you first add a user to a git-secret repo, they will not be able to decrypt existing files until another user re-encrypts the files with the new keyring.

If you do not want unexpected keys added, you can configure some server-side security policy with the `pre-receive` hook.
