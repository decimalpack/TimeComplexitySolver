import std/[monotimes, times, parseopt, strutils, os, osproc, strformat, sequtils, sugar, math]

proc runProgram(name:string,N:int64) =
    discard execCmdEx(fmt"{name} {N}")


proc main(programName:string,MIN_N:int, MAX_N:int64, warmup:int64) {.gcsafe}=
    var N = MIN_N
    for i in 1..warmup:
        runProgram(programName,i*N)
    var timingData = newSeq[float64](0)
    N = MIN_N
    while N<=MAX_N:
        let startTime = getMonoTime()
        runProgram(programName,N)
        let endTime = getMonoTime()
        stdout.write fmt"Input {N} took {endTime - startTime}"
        stdout.write "\r"
        stdout.flushFile
        timingData.add((endTime - startTime).inNanoseconds.float64)
        N*=2
    stdout.write "\n"
    let
        convergeTime= (0..<timingData.len-1)
                        .toSeq
                        .map(i => timingData[i+1] / timingData[i])
                        .max
                        .ceil
        b = convergeTime.log2
        a = timingData[0] / MIN_N.toFloat.pow(b)
    echo fmt"{a} * N^{b.toInt}"


proc writeHelp() = 
    echo fmt"Usage: {getAppFileName()} --minimum_size=64 --Maximum_size=8192 --warmup=10 program_name"

proc parse_args() = 
    var p = initOptParser(commandLineParams(),shortNoVal={'h'},longNoVal= @["help",])
    var programName = ""
    var N=64
    var warmup = 10
    var Maximum_size = 8192
    for kind,key,val in p.getopt:
        case kind
        of cmdArgument:
            programName=key
        of cmdLongOption,cmdShortOption:
            case key
            of "Maximum_size","M":
                Maximum_size = val.parseInt
            of "minimum_size","m":
                N = val.parseInt
            of "warmup","w":
                warmup = val.parseInt
            of "help","h":
                writeHelp()
                quit(0)
        of cmdEnd:
            assert false 
    if programName == "":
        writeHelp()
    else:
        main(programName,N,Maximum_size,warmup)
when isMainModule:
    parse_args()