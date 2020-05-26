# Encrypt/Decrypt files and DBF fields

* This sample shows how to encrypt/decrypt the header of a file so it can't be opened by USE command. Note that the DBF records are not modified.
https://github.com/oohg/samples/blob/master/encrypt/s001.prg
* This sample shows how to encrypt/decrypt the content of the CHARACTER fields of a DBF file. Note that the file is encrypted over himself, so you must consider copying it before encryption just in case something goes wrong.
https://github.com/oohg/samples/blob/master/encrypt/s002.prg
* This sample shows how to encrypt/decrypt a file (any kind). Note that the encrypted file will start with this text "ENCRYPTED FILE (C) ODESSA 2002" immediately followed by the encryption password encrypted (10 chars).
https://github.com/oohg/samples/blob/master/encrypt/s003.prg
