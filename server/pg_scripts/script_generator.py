import json


class ScriptGenerator:

    def __init__(self):
        self.script_filename = 'script.sql'

    def make_script(self):
        self.load_general()

    def load_general(self):
        with open(self.script_filename, mode='w', encoding='UTF-8') as script_file:
            script_file.write(self.read_text_file('resources/create.sql'))
            script_file.write(self.read_text_file('resources/exercise_types.sql'))

    @staticmethod
    def read_text_file(filename) -> str:
        with open(filename, mode='r', encoding='UTF-8') as file:
            content = file.read()
        return content

    @staticmethod
    def read_json_file(filename) -> dict:
        with open(filename, mode='r', encoding='UTF-8') as file:
            content = json.load(file)
        return content

    @staticmethod
    def quotify(input) -> str:
        return '\'%s\'' % input

    @staticmethod
    def get_insert(table, **kwargs):
        keys = ["%s" % k for k in kwargs]
        values = ["%s" % v for v in kwargs.values()]
        sql = list()
        sql.append('INSERT INTO %s (' % table)
        sql.append(', '.join(keys))
        sql.append(')\nVALUES (')
        sql.append(', '.join(values))
        sql.append(');\n\n')
        return ''.join(sql)
