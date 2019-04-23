import os

from pg_scripts.script_generator import ScriptGenerator


class SampleCourseGenerator(ScriptGenerator):
    def __init__(self):
        super().__init__()
        self.root = 'resources/sample_course'
        self.game_config = []
        self.game_config_8 = []

    def make_script(self):
        super().make_script()
        self.game_config = self.get_files('game_config')
        self.game_config_8 = self.get_files('game_config_8')
        self.load_content()

    def get_files(self, directory) -> list:
        files = []
        path = '%s/exercise_contents/%s' % (self.root, directory)
        for r, d, f in os.walk(path):
            for filename in f:
                file_data = {
                    'filename': self.quotify(filename),
                    'content': self.quotify(self.read_text_file('%s/%s' % (r, filename)).replace("'", "''"))
                }
                files.append(file_data)
        return files

    def load_content(self):
        courses_data = self.read_json_file('%s/courses.json' % self.root)
        course_id_counter, lesson_id_counter, exercise_id_counter = 0, 0, 0
        for course in courses_data:
            course_id_counter += 1
            course['id'] = course_id_counter
            self.append_to_script(self.get_insert('courses', **course))

        lessons_data = self.read_json_file('%s/lessons.json' % self.root)
        for course_id, lessons in lessons_data.items():
            for lesson in lessons:
                lesson_id_counter += 1
                lesson['id'] = lesson_id_counter
                lesson['course_id'] = int(course_id)
                self.append_to_script(self.get_insert('lessons', **lesson))

        exercises_data = self.read_json_file('%s/exercises.json' % self.root)
        for lesson_id, exercises in exercises_data.items():
            for exercise in exercises:
                exercise_id_counter += 1
                exercise['id'] = exercise_id_counter
                exercise['lesson_id'] = int(lesson_id)
                exercise['description'] = self.read_description(exercise_id_counter)
                exercise['solved'] = False
                self.append_to_script(self.get_insert('exercises', **exercise))

        bugs_number_data = self.read_json_file('%s/bugs_number.json' % self.root)
        for exercise_id, number in bugs_number_data.items():
            bugs_number = {
                'exercise_id': exercise_id,
                'number': number
            }
            self.append_to_script(self.get_insert('bugs_number', **bugs_number))

        exercise_content_data = self.read_json_file('%s/exercise_content.json' % self.root)
        for i in range(len(exercise_content_data)):
            exercise_content = exercise_content_data[i]
            self.handle_exercise_content(exercise_content, i + 1)

    def read_description(self, exercise_id):
        try:
            filename = '%s/exercise_contents/%s/description/description.txt' % (self.root, exercise_id)
            return self.quotify(self.read_text_file(filename).replace('\\n', '<br>').replace("'", "''"))
        except FileNotFoundError:
            return "'todo'"

    def handle_exercise_content(self, exercise_content_data, exercise_id):
        try:
            source_test = exercise_content_data['source_test']
            for exercise_content in source_test:
                exercise_content['exercise_id'] = int(exercise_id)
                exercise_content['content'] = self.read_exercise_content(exercise_content)
                self.append_to_script(self.get_insert('exercise_content', **exercise_content))
            file_dir = exercise_content_data['file']
            if file_dir == 'game_config':
                self.handle_files(exercise_id, self.game_config)
            elif file_dir == 'game_config_8':
                self.handle_files(exercise_id, self.game_config_8)
        except KeyError:
            return

    def handle_files(self, exercise_id, files):
        for file in files:
            for exercise_content_type in ['\'private_file\'', '\'public_file\'']:
                file['exercise_id'] = int(exercise_id)
                file['exercise_content_type'] = exercise_content_type
                self.append_to_script(self.get_insert('exercise_content', **file))

    def append_to_script(self, content):
        with open(self.script_filename, mode='a', encoding='UTF-8') as script_file:
            script_file.write(content)

    def read_exercise_content(self, exercise_content):
        content = self.read_text_file('%s/exercise_contents/%s/%s/%s' % (
            self.root,
            exercise_content['exercise_id'],
            exercise_content['exercise_content_type'][1:-1],
            exercise_content['filename'][1:-1]))
        return self.quotify(content.replace("'", "''"))


if __name__ == '__main__':
    sg = SampleCourseGenerator()
    sg.make_script()
