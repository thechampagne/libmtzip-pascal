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
unit mtzip.raw;

{$ifdef fpc}
{$packrecords c}
{$endif}

interface

uses ctypes;

type
   Puint8  = ^cuint8;

type
   mtzip_zip_archive_t  = record
			     zip_archive : pointer;
			  end;		 
   Pmtzip_zip_archive_t  = ^mtzip_zip_archive_t;


function mtzip_zip_archive_default:mtzip_zip_archive_t;cdecl; external;

function mtzip_zip_archive_add_file(zip_archive:Pmtzip_zip_archive_t; fs_path:Pchar; archive_name:Pchar):longint;cdecl; external;

function mtzip_zip_archive_add_file_from_bytes(zip_archive:Pmtzip_zip_archive_t; data:Puint8; data_len:csize_t; archive_name:Pchar):longint;cdecl; external;

function mtzip_zip_archive_add_directory(zip_archive:Pmtzip_zip_archive_t; archive_name:Pchar):longint;cdecl; external;

function mtzip_zip_archive_compress(zip_archive:Pmtzip_zip_archive_t; threads:csize_t):longint;cdecl; external;

function mtzip_zip_archive_write(zip_archive:Pmtzip_zip_archive_t; file_name:Pchar; threads:csize_t):longint;cdecl; external;

procedure mtzip_zip_archive_clean(zip_archive:Pmtzip_zip_archive_t);cdecl; external;

implementation

end.
