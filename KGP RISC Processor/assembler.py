import json
import re
import sys
from fileinput import filename

sys.stdout = open("test.coe", "w")

MAX_16 = int(65536)


def parse_lines(reg_dict, line, instr_dict):
    encoded = None

    if (line[0] == 'add'):
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{reg_dict[line[2]]:05b}"
        shamt = f"{0:05b}"
        func = instr_dict[line[0]][-1]
        encoded = opcode+rs+rt+shamt+func

    elif (line[0] == 'comp'):
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{reg_dict[line[2]]:05b}"
        shamt = f"{0:05b}"
        func = instr_dict[line[0]][-1]
        encoded = opcode+rs+rt+shamt+func

    elif (line[0] == 'diff'):
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{reg_dict[line[2]]:05b}"
        shamt = f"{0:05b}"
        func = instr_dict[line[0]][-1]
        encoded = opcode+rs+rt+shamt+func

    elif (line[0] == 'and'):
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{reg_dict[line[2]]:05b}"
        shamt = f"{0:05b}"
        func = instr_dict[line[0]][-1]
        encoded = opcode+rs+rt+shamt+func

    elif (line[0] == 'xor'):
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{reg_dict[line[2]]:05b}"
        shamt = f"{0:05b}"
        func = instr_dict[line[0]][-1]
        encoded = opcode+rs+rt+shamt+func

    elif (line[0] == 'shll'):
        # Example shll $1, 2
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{0:05b}"
        sh = line[2]
        sh = format(int(sh), '05b')
        func = instr_dict[line[0]][-1]
        encoded = opcode+rs+rt+sh+func

    elif (line[0] == 'shrl'):
        # Example shrl $1, 5
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{0:05b}"
        sh = line[2]
        sh = format(int(sh), '05b')
        func = instr_dict[line[0]][-1]
        encoded = opcode+rs+rt+sh+func

    elif (line[0] == 'shllv'):
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{reg_dict[line[2]]:05b}"
        shamt = f"{0:05b}"
        func = instr_dict[line[0]][-1]
        encoded = opcode+rs+rt+shamt+func

    elif (line[0] == 'shrlv'):
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{reg_dict[line[2]]:05b}"
        shamt = f"{0:05b}"
        func = instr_dict[line[0]][-1]
        encoded = opcode+rs+rt+shamt+func

    elif (line[0] == 'shra'):
        # Example shra $1, 2
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{0:05b}"
        sh = line[2]
        sh = format(int(sh), '05b')
        func = instr_dict[line[0]][-1]
        encoded = opcode+rs+rt+sh+func

    elif (line[0] == 'shrav'):
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{reg_dict[line[2]]:05b}"
        shamt = f"{0:05b}"
        func = instr_dict[line[0]][-1]
        encoded = opcode+rs+rt+shamt+func

    elif (line[0] == 'addi'):
        # Example addi $1, 30
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{0:05b}"
        imm = int(line[2])
        if imm < 0:
            imm = MAX_16+imm
        imm = format(int(imm), '016b')
        encoded = opcode+rs+rt+imm

    elif (line[0] == 'compi'):
        # Example compi $1, 30
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{0:05b}"
        imm = int(line[2])
        if imm < 0:
            imm = MAX_16+imm
        imm = format(int(imm), '016b')
        encoded = opcode+rs+rt+imm

    elif (line[0] == 'lw'):
        # Example lw $1, $2, 10
        opcode = instr_dict[line[0]][0]
        rt = f"{reg_dict[line[1]]:05b}"
        rs = f"{reg_dict[line[3]]:05b}"
        offset = line[2]
        offset = format(int(offset), '016b')
        encoded = opcode+rs+rt+offset

    elif (line[0] == 'sw'):
        # Example sw $1, $2, 10
        opcode = instr_dict[line[0]][0]
        rt = f"{reg_dict[line[1]]:05b}"
        rs = f"{reg_dict[line[3]]:05b}"
        offset = line[2]
        offset = format(int(offset), '016b')
        encoded = opcode+rs+rt+offset

    elif (line[0] == 'bltz'):
        # Example bltz $1, 10
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{0:05b}"
        offset = int(line[2])
        if offset < 0:
            offset = MAX_16+offset
        offset = format(int(offset), '016b')
        encoded = opcode+rs+rt+offset

    elif (line[0] == 'bz'):
        # Example bltz $1, 10
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{0:05b}"
        offset = int(line[2])
        if offset < 0:
            offset = MAX_16+offset
        offset = format(int(offset), '016b')
        encoded = opcode+rs+rt+offset

    elif (line[0] == 'bnz'):
        # Example bltz $1, 10
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{0:05b}"
        offset = int(line[2])
        if offset < 0:
            offset = MAX_16+offset
        offset = format(int(offset), '016b')
        encoded = opcode+rs+rt+offset

    elif (line[0] == 'br'):
        opcode = instr_dict[line[0]][0]
        rs = f"{reg_dict[line[1]]:05b}"
        rt = f"{0:05b}"
        dc = f"{0:016b}"
        encoded = opcode+rs+rt+dc

    elif (line[0] == 'b'):
        # Example b 10
        opcode = instr_dict[line[0]][0]
        offset = line[1]
        offset = format(int(offset), '026b')
        encoded = opcode+offset

    elif (line[0] == 'bl'):
        # Example bl 10
        opcode = instr_dict[line[0]][0]
        offset = line[1]
        offset = format(int(offset), '026b')
        encoded = opcode+offset

    elif (line[0] == 'bcy'):
        # Example bcy 10
        opcode = instr_dict[line[0]][0]
        offset = line[1]
        offset = format(int(offset), '026b')
        encoded = opcode+offset

    elif (line[0] == 'bncy'):
        # Example b 10
        opcode = instr_dict[line[0]][0]
        offset = line[1]
        offset = format(int(offset), '026b')
        encoded = opcode+offset

    else:
        print(f"Error 1 in Source file, Line:{line}")

    return encoded


if __name__ == '__main__':
    with open('regs.json', 'r') as f:
        reg_dict = json.load(f)

    with open("instr.json", 'r') as f:
        instr_dict = json.load(f)

    filename = sys.argv[1]

    print("memory_initialization_radix=2;")
    print("memory_initialization_vector=")
    print("00000000000000000000000000000000")

    with open(filename, 'r') as f:
        lines = f.readlines()
        for line in lines:
            line.strip()
            line = re.sub(re.compile("/'''.*?\'''", re.DOTALL), "", line)
            line = re.sub(re.compile("#.*?\n"), "", line)
            line = line.replace(',', ' ').replace(')', ' ').replace('(', ' ').split()

            opcode = None
            if len(line):
                opcode = parse_lines(reg_dict, line, instr_dict)

            if (opcode is None):
                continue
            if len(opcode) != 32:
                print(f"Error 2 in Source file, Line:{line}")
            print(opcode+',')

    print("00000000000000000000000000000000;")
