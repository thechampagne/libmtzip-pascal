{*
 * Copyright (c) 2022 XXIV
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *}
unit mtzip;

{$ifdef fpc}
{$packrecords c}
{$endif}

interface

uses mtzip.raw,
     ctypes;

type
   TZipArchive = record
		   zip_archive : mtzip_zip_archive_t;
		end;


function TZipArchiveDefault:TZipArchive;

function TZipArchiveAddFile(var zip_archive:TZipArchive; fsPath: string; archiveName: string):integer;

function TZipArchiveAddFileFromBytes(var zip_archive:TZipArchive; data: array of cuint8; archiveName: string):integer;

function TZipArchiveAddDirectory(var zip_archive:TZipArchive; archiveName: string):integer;

function TZipArchiveCompress(var zip_archive:TZipArchive; threads: integer):integer;

function TZipArchiveWrite(var zip_archive:TZipArchive; fileName:string; threads:integer):integer;

procedure TZipArchiveClean(var zip_archive:TZipArchive);

implementation

function TZipArchiveDefault:TZipArchive;
var
   zip_archive : TZipArchive;
begin
   zip_archive.zip_archive := mtzip_zip_archive_default;
   TZipArchiveDefault := zip_archive;
end;

function TZipArchiveAddFile(var zip_archive:TZipArchive; fsPath: string; archiveName: string):integer;
var
   arr1	 : array of char;
   arr2	 : array of char;
   i1	 : integer;
   i2	 : integer;
   stri1 : integer = 1;
   stri2 : integer = 1;
   res	 : integer;
begin
   setlength(arr1,byte(fsPath[0]) + 1);
   setlength(arr2,byte(archiveName[0]) + 1);
   for i1 := 0 to byte(fsPath[0]) do
   begin
      arr1[i1] := fsPath[stri1];
      stri1 := stri1 + 1;
   end;
   for i2 := 0 to byte(archiveName[0]) do
   begin
      arr2[i2] := archiveName[stri2];
      stri2 := stri2 + 1;
   end;
   arr1[byte(fsPath[0])] := #0;
   arr2[byte(archiveName[0])] := #0;
   res := mtzip_zip_archive_add_file(@zip_archive.zip_archive, pchar(arr1), pchar(arr2));
   if res <> 0 then
      TZipArchiveAddFile := -1
   else
      TZipArchiveAddFile := 0;
end;

function TZipArchiveAddFileFromBytes(var zip_archive:TZipArchive; data: array of cuint8; archiveName: string):integer;
var
   arr	 : array of char;
   i	 : integer;
   stri : integer = 1;
   res	 : integer;
begin
   setlength(arr,byte(archiveName[0]) + 1);
   for i := 0 to byte(archiveName[0]) do
   begin
      arr[i] := archiveName[stri];
      stri := stri + 1;
   end;
   arr[byte(archiveName[0])] := #0;
   res := mtzip_zip_archive_add_file_from_bytes(@(zip_archive.zip_archive), data, length(data), pchar(arr));
   if res <> 0 then
      TZipArchiveAddFileFromBytes := -1
   else
      TZipArchiveAddFileFromBytes := 0;
end;

function TZipArchiveAddDirectory(var zip_archive:TZipArchive; archiveName: string):integer;
var
   arr	 : array of char;
   i	 : integer;
   stri : integer = 1;
   res	 : integer;
begin
   setlength(arr,byte(archiveName[0]) + 1);
   for i := 0 to byte(archiveName[0]) do
   begin
      arr[i] := archiveName[stri];
      stri := stri + 1;
   end;
   arr[byte(archiveName[0])] := #0;
   res := mtzip_zip_archive_add_directory(@(zip_archive.zip_archive), pchar(arr));
   if res <> 0 then
      TZipArchiveAddDirectory := -1
   else
      TZipArchiveAddDirectory := 0;
end;

function TZipArchiveCompress(var zip_archive:TZipArchive; threads: integer):integer;
var
   res : integer;
begin
   res := mtzip_zip_archive_compress(@zip_archive.zip_archive, threads);
   if res <> 0 then
      TZipArchiveCompress := -1
   else
      TZipArchiveCompress := 0;
end;

function TZipArchiveWrite(var zip_archive:TZipArchive; fileName:string; threads:integer):integer;
var
   arr	 : array of char;
   i	 : integer;
   stri : integer = 1;
   res	 : integer;
begin
   setlength(arr,byte(fileName[0]) + 1);
   for i := 0 to byte(fileName[0]) do
   begin
      arr[i] := fileName[stri];
      stri := stri + 1;
   end;
   arr[byte(fileName[0])] := #0;
   res := mtzip_zip_archive_write(@(zip_archive.zip_archive), pchar(arr), threads);
   if res <> 0 then
      TZipArchiveWrite := -1
   else
      TZipArchiveWrite := 0;
end;

procedure TZipArchiveClean(var zip_archive:TZipArchive);
begin
   mtzip_zip_archive_clean(@(zip_archive.zip_archive));
end;

end.
