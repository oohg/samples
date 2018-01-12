## TStream class

TStream class is designed to simplify data stream management.
It allows to receive (and send) raw data from "any" source, to store it on it's own buffer, and to provide it on the required way.
For example, you can store it until an EOL character is received, or until it reaches a specific lenght.

Taking advantage of the flexibility of classes, it's possible to use the same code to process data from different sources with the same code (you can get data from a file, network socket, serial port or memory).
Another use is for data uncompress and or conversion.

Sample classes are:
* TStreamBase:   Read data sequentially or line by line from a memory buffer. See TStream.prg
* TStreamFile:   Reads data from a file. See TStream.prg
* TStreamSocket: Reads/writes data from a network socket. See TStreamSocket.prg
* TStreamSerial: Reads/writes data from a serial port. See TStreamSerial.prg
* TStreamSSL:    Reads/writes data over a SSL connection (requires OpenSSL library). See TStreamSSL.prg
* TStreamUnZip:  Reads compressed data and returns it uncompressed. See TStreamZip.prg

See in TSmtpClient.prg a basic SMTP client using TStreamSocket class.
