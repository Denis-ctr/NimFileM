include term 
import os, strutils, terminal

#main 
proc main() =
  var currentPath = getCurrentDir()
  
  printHeader("═════════════════")
  printHeader("  File Manager  ")
  printHeader("═════════════════")
  
  while true:
    showMenu()
    let choice = readLine(stdin).strip()
    echo ""
    
    case choice
    of "-l":
      listFiles(currentPath)   
    of "cd":
      stdout.write("file name: ")
      stdout.flushFile()
      let dirName = readLine(stdin).strip()
      let newPath = currentPath / dirName
      
      if dirExists(newPath):
        currentPath = newPath
        listFiles(currentPath)
      else:
        stdout.styledWrite(fgRed, "error : path not exist\n")
        stdout.flushFile()
    
    of "up":
      currentPath = parentDir(currentPath)
      listFiles(currentPath)
    
    of "cat":
      stdout.write("File name: ")
      stdout.flushFile()
      let fileName = readLine(stdin).strip()
      let filePath = currentPath / fileName
      showFileContent(filePath)
    of "mv":
        stdout.write("Source: ")
        stdout.flushFile()
        let sourceName = readLine(stdin).strip()
        let sourcePath = currentPath / sourceName
        stdout.write("Destination: ")
        stdout.flushFile()
        let destName = readLine(stdin).strip()
        let destPath = currentPath / destName

        if fileExists(destPath) or dirExists(sourcePath):
            moveFile(sourcePath, destPath)
            stdout.styledWrite(fgGreen, "Success: File/Folder moved.\n")
            stdout.flushFile()
        
        else:
            stdout.styledWrite(fgRed, "error : Source not exist\n")
            stdout.flushFile()

    of "rm":
        stdout.write("File/Folder name: ")
        stdout.flushFile()
        let targetName = readLine(stdin).strip()
        let TargetPath = currentPath / targetName

        if fileExists(TargetPath):
            removeFile(TargetPath)
            stdout.styledWrite(fgGreen, "Success: File deleted \n")
            stdout.flushFile()
        elif dirExists(TargetPath):
            removeDir(TargetPath)
            stdout.styledWrite(fgGreen, "Success: Folder deleted \n")
            stdout.flushFile()
        else:
            stdout.styledWrite(fgRed, "error : File/Folder not exist\n")
            stdout.flushFile()

    of "e":
      break
    
    else:
      stdout.styledWrite(fgRed, "error : false choice\n")
      stdout.flushFile()

when isMainModule:
  main()