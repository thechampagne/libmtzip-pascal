# libmtzip-pascal

[![](https://img.shields.io/github/v/tag/thechampagne/libmtzip-pascal?label=version)](https://github.com/thechampagne/libmtzip-pascal/releases/latest) [![](https://img.shields.io/github/license/thechampagne/libmtzip-pascal)](https://github.com/thechampagne/libmtzip-pascal/blob/main/LICENSE)

Pascal binding for **libmtzip** a library for making zip files, focused on multithreading the process.

### Example

```pas
program example;

uses mtzip;

var
   zip : TZipArchive;

begin
   zip := TZipArchiveDefault;
   TZipArchiveAddFile(zip, 'file.txt', 'file.txt');
   TZipArchiveWrite(zip,'file.zip', 1);
   TZipArchiveClean(zip);
end.
```

### References
 - [libmtzip](https://github.com/thechampagne/libmtzip)

### License

This repo is released under the [MIT](https://github.com/thechampagne/libmtzip-pascal/blob/main/LICENSE).
