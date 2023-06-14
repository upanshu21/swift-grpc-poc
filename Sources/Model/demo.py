import re

def get_struct_name(line):
    match = re.search(r'public struct ([a-zA-Z0-9_]+) {', line)
    if match:
        return match.group(1).split('_')
    return None, None

def get_property(line):
    match = re.search(r'public var ([a-zA-Z0-9_]+): ([a-zA-Z0-9.]+)', line)
    if match:
        return match.group(1), match.group(2)
    return None

def main():
    with open('helloworld.pb.swift') as infile:
        lines = infile.readlines()

    structs = {}
    current_struct_name = None
    current_struct_prefix = None
    for line in lines:
        stripped = line.strip()
        
        struct_prefix, struct_name = get_struct_name(stripped)
        if struct_name:
            current_struct_name = struct_name
            current_struct_prefix = struct_prefix
            structs[current_struct_name] = []
            continue

        if current_struct_name:
            property = get_property(stripped)
            if property:
                structs[current_struct_name].append(property)
            elif stripped == '}':
                current_struct_name = None

    with open('new.swift', 'w') as outfile:
        for struct_name, properties in structs.items():
            outfile.write(f'public struct {struct_name} {{\n')
            for name, type in properties:
                outfile.write(f'    public var {name}: {type}\n')
            parameters = ', '.join([f'_{name}: {type}' for name, type in properties])
            assignments = '\n        '.join([f'self.{name} = _{name}' for name, _ in properties])
            outfile.write(f'\n    public init({parameters}) {{\n        {assignments}\n    }}\n')
            outfile.write(f'\n    public func {current_struct_prefix.lower()}{struct_name}() -> {current_struct_prefix}_{struct_name} {{\n')
            outfile.write(f'        return {current_struct_prefix}_{struct_name}.with {{\n')
            outfile.write('\n'.join([f'            $0.{name} = self.{name}' for name, _ in properties]))
            outfile.write('\n        }\n    }\n}\n\n')

if __name__ == '__main__':
    main()
