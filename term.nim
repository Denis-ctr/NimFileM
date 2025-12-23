import os, strutils, terminal

# reng
proc printHeader(text: string) =
  stdout.styledWrite(fgGreen, styleBright, text, "\n")
  stdout.flushFile()

proc printFile(name: string) =
  stdout.styledWrite(fgWhite, "  📄 ", name, "\n")
  stdout.flushFile()

proc printDir(name: string) =
  stdout.styledWrite(fgCyan, styleBright, "  📁 ", name, "/\n")
  stdout.flushFile()

proc listFiles(path: string) =
  # cari file
  printHeader("folder/path : " & path)
  echo ""
  
  var dirs: seq[string] = @[]
  var files: seq[string] = @[]
  
  # file ayr
  for kind, entry in walkDir(path):
    case kind
    of pcDir:
      dirs.add(extractFilename(entry))
    of pcFile:
      files.add(extractFilename(entry))
    else:
      discard
  

  if dirs.len > 0:
    printHeader("Folders:")
    for dir in dirs:
      printDir(dir)
    echo ""
  
  if files.len > 0:
    printHeader("Files:")
    for file in files:
      printFile(file)
    echo ""

proc showMenu() =
  stdout.styledWrite(fgYellow , "Commands : \n-l -list files and folders\ncd <dir> - enter the path or folder\nup - back to last path\ncat <file> - read the file\ne - exit file manager\nmv <source> <destination> - move file or folder\nrm <file/folder> - delete file or folder\n")
  
  stdout.write("\n[ filemanager@ ~]$ ")
  stdout.flushFile()

proc showFileContent(path: string) =
  if fileExists(path):
    printHeader("file: " & path)
    echo ""
    let content = readFile(path)
    echo content
  else:
    stdout.styledWrite(fgRed, "error : File not exist\n")
    stdout.flushFile()