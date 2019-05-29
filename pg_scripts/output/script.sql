drop table if exists courses CASCADE;
create table courses (
	id serial primary key,
	name text,
    description text,
	created timestamp
);

drop table if exists lessons CASCADE;
create table lessons (
	id serial primary key,
	name text,
    description text,
    index int,
    created timestamp,
	course_id int references courses on delete cascade
);

drop table if exists exercise_types CASCADE;
create table exercise_types (
	id serial primary key,
	name text,
	value text,
	constraint unique_name unique (name),
	constraint unique_value unique (value)
);

drop table if exists exercises CASCADE;
create table exercises (
	id serial primary key,
	name text,
    description text,
	index int,
    created timestamp,
    solved boolean,
    type_id int references exercise_types on delete cascade,
	lesson_id int references lessons on delete cascade
);

drop table if exists exercise_content cascade;
create table exercise_content (
    id serial primary key,
    filename text,
    content text,
    exercise_id int references exercises on delete cascade,
    exercise_content_type text
);

drop table if exists bugs_number cascade;
create table bugs_number (
    id serial primary key,
    exercise_id int references exercises on delete cascade,
    number int,
    constraint unique_exercise_id unique (exercise_id)
);

drop table if exists solutions cascade;
create table solutions (
	id serial primary key,
    created timestamp,
	exercise_id int references exercises on delete cascade
);

drop table if exists solution_content cascade;
create table solution_content (
    id serial primary key,
    filename text,
    content text,
    solution_id int references solutions on delete cascade,
    solution_content_type text
);

drop table if exists solution_estimation cascade;
create table solution_estimation (
	id serial primary key,
	solution_id int,
	estimation text,
	value int,
    solved boolean,
    created timestamp
);

INSERT INTO exercise_types (id, name, value)
VALUES  (1, 'Theory', 'theory'),
        (2, 'Interactive Exercise', 'whitebox'),
        (3, 'Interactive Exercise with Files', 'whitebox-file'),
        (4, 'Black Box', 'blackbox'),
        (5, 'Black Box with Files', 'blackbox-file');


INSERT INTO courses (name, created, description, id)
VALUES ('Sample course', '2019-03-28 11:08:09.851', 'Web application functionality overview. Use agile programming methods to build a game, based on a legacy content', 1);

INSERT INTO lessons (name, created, description, id, index, course_id)
VALUES ('Debugging a legacy program', '2019-03-28 11:08:09.851', 'Exercises on finding and fixing bugs in a legacy program', 1, 0, 1);

INSERT INTO lessons (name, created, description, id, index, course_id)
VALUES ('Adding new features to the legacy program', '2019-03-28 11:08:09.851', 'Exercise on adding a new feature to the legacy program', 2, 1, 1);

INSERT INTO lessons (name, created, description, id, index, course_id)
VALUES ('Refactoring the legacy program', '2019-03-28 11:08:09.851', 'Exercises on refactoring the content of the legacy program', 3, 2, 1);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Intro', 1, '2019-03-28 11:08:09.851', 1, 0, 1, '<h2>Course overview</h2><p>In this course you would work on an interactive Reversi game, based on a legacy program.</p><p>The work on the project would be done in three lessons, which represent iterations of the work on the program. Each lesson would have exercises, which would provide feedback and lead through the work on the project.</p><p>While working on project you would learn Extreme programming methods and apply your skills. Most of the exercises would cover several of these skills, like test-driven development, unit testing, refactoring and working with legacy code.</p><h4>Testing</h4><p>The first iteration provides exercises on debugging the legacy program. The aim is to find bugs in the legacy program and fix them, but keep the original structure of the code. Writing own tests is necessary to achieve it. The second iteration is aimed to add some features to the code, bud to keep the original structure of the code as well. Tests, used in a previous iteration, with the new tests would be needed to accomplish the iteration requirements. The last iteration is made up with numerous exercises on refactoring. The tests are essential to proof that the program would remain correct.</p><h4>Refactoring</h4><p>The refactoring exercises take place in the third, last iteration. At this moment, after the previous two iterations are completed successfully and passed all the tests, the code would be correct. Each of the numerous exercises is about a single step of the code change, exercise description and title would reference to the book "Clean Code" by Robert C. Martin. It is one of the mostly recommended books for software development, and for a good reason. During and after refactoring the code should maintain correct, and it can be provided by tests, written by the user.</p><h4>Legacy program overview</h4><p>The legacy program is a two-player interactive Reversi game. The rules can be found here&nbsp;<a href="http://www.flyordie.com/games/help/reversi/en/games_rules_reversi.html" target="_blank">http://www.flyordie.com/games/help/reversi/en/games_rules_reversi.html</a></p><p>The game is played from console. The state of the game is read from configuration files, which have the following structure:</p><ul><li>first row has "B" or "W", which means the player on turn,</li><li>the second row contains the pieces of the player, whose color is black,</li><li>and the third row contains the pieces of the player, whose color is white.</li></ul><p>Pieces are represented by two numbers, which mean row and column index started from 0 (e.g. 01).</p><p>These numbers are separated by space, and each pair of them is separated by comma.</p><p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAKQAAACwCAYAAACB8sXMAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAASdEVYdFNvZnR3YXJlAEdyZWVuc2hvdF5VCAUAABk0SURBVHhe7d0HeFNV/wfwb5K2SdpmdBcKyGyBMirIngIKIshUESnIel+xIkNAQBBQRJaMynxRAV9BRChDhoBAQQRkySxDyiwddJN0ZN5/Uo8v0KTJDST+72N/H58+5JxzE+9Nfrnn3JszRJwFCBEIMfuXEEGggCSCQgFJBIUCkggKBSQRFApIIigUkERQ/p6AzD6O6a0qI6hidcQnXmeZrrl/9Ct069sD2y8XshzXcCcS0KNOHSgDgjFz5wWW6woNflnxNqQyP0S/MARXWe6TODuvJ1p2W4ksluZLcykBrzYPRUhoBVQIUcOn3gjcZGWuOrBwGioEBaJy665IvJ3Pcp374s0QhIRVRIUKln2oEIawsJ7YklbASp+e5wMy9wYmfbgKL+6+i+zUi8C+2diaVMQKeTDdxLSxvbH192C0aV8dN+4/wcHnHkT11h9gzJHLeJB7C4YlcYhdepgV8lGIHUOmYI05FrriApyeqUL9gK6szEVJG9Ev8TYkx29bXtU1BSnnEdBvKTLvpyEtMw/6i8tRjZXxp8HaEU3wHeojLTsHd4/sQvtnVKzMGRNMYdH49nQq0tIs+5B2F9M7REKX82QnCXs8HpCpd07D4P06WiqtKV/0aNoYZ3/bB94/D0mqYcaCBPwrrgfUBTqIxCJWwJ8pLQtxh39H+yBryh/vfzYZolNbkW4oKebBF92+Xoyv3mlVkpI1W4iZxiws5X9iYYowa846vN2pC7xlrr/1IrHEcoaWs9STuX/8M1x6dj1WjenLclwhwegFiehciSVTjuBYLRlaVAlhGU/P4wFZeC0RdxvVYCnLR6vMxb37WTCzNH86y/fzyUjqvopxzf1ZCjiTuAnFdV5EuDfLcFXWFsyKaYMRfE8sTPHtnbhwuw6GDm0Og07PcvkTS8TYPaU7wsIjEFy7BcYfymYl/O2J/x112hvRr3V1hEb0wm5LpfWkki+kQZYWCJWCZbiBxwPSXFQEjfnh+ZAziyARi+H6ec49bu3/AJ9faIU1E7qwHNe8FyWCKHI25s6b4PKbN3VgLCIXzYZCKbWkvCH7M5u3kA4f4noWh4z0e8i6kog6q3pj6m+uNGEe4E7SXUx9ay5eW5uM+/cW4+ra+dh/hxW76LejPyCiYzeoWdodPB6QEn8FQnM1LGVJe5lh4kz8q2y30ePshmmYuEmKjV8NtlTCTyb+Kgcu3fJBTu6B9a58kCkLMf+wHLc2z8Gn45fgUtYBbDh08wlqir9I8Vb/2jh8xJXLmiKcPXcJbUbMRO8a1lNCFTRsI0PB6Se7RLufqkfjdjVZyj08HpC+dTtBce/8/wLw9sVQhPtWtrRGXOUDL4kXvLx9WNo1v66JwxfXK2HF8o/xdK0wC5/mGNXpLJb86EIjMvBV7NqzHv1aNsbzbeojSFYZkbVDn+oDyMu4BJ3eyFJ8hOH1wbWhkT1sa+g0uch7kvc0ew+OZnVGuwos7S7W7mceZX7AHVw1k1u3/Qx38dgebtrk0dyxNFbGi45LS77CJZ0+yo17uwc3auXP3OWL57hsHSvm4fyMulyDDvO483dvcElJl7kDaz7kXhv5PpfG9zUyz3ODerfhRv5nFXftynVux7r3ObmsP3eHFbtEr+eyzsziaopjuWNGlsdHUQY3KbYF99acxdwlyzEc3jKfqxTQgzvCinnT/8z1r1WXW3vsPHd6/SKue98p3DkNK3PB+ZnRXIPFt1nKff6W/pCGlMuYMfMTJOXL8e7k5ehQ35VvZCYSZs/G+pN3oVBZLtX1BSgweeHdxf9F21C2iRPXtk7E9M33LDtiKKkizSYToruPxMSBbS0VH0/GPHy5fDJ27k+HKLwuPpgxE83CWJkLUo5ux6xl/0WhTzAaPD8MI2MbW1qTfBXjl68/wqJdf0CtboBhE6ajRaTrrfH8pB8xde5/kGZohilzp6BhBCtwweXNE5DZdi7auu8CuwR10CWC4vE2JCGuoIAkgkIBSQSFApIICgUkERQKSCIoFJBEUCggiaBQQBJB4RGQHDa/Ux9Vxd6o1bYPklguIZ7gNCAPDeyKg8Mu4JbZgD++bIWP3tv7/9B1jJQXTgIyCStyumBRI5aMHIsXU0diWw5LE+JmjgPy7lUcDBPDiyWtvBT3kE8BSTzEyRmSg6lU/cxZwlPMo+VJyJNwHFpqNaql5bLEn7y9C6DnPVqPENc4DkhFa/T1S8F+lgRuYdeP49ApiiUJcTPnHXRzd2PUhN9Rua4cpsuJkMcl4L2Gro+IIYQPXj3GbyZuwq6kDATWfAFvvBjJcglxPxrCQASFrpeJoHjuDMndwdJ/j8aXJ2/D28frsZkqzCYjvPxD8MmGn9ApnGXaobv2Lbp3n40ctZ/NOG5DkQb1Y+di1fhuKHsMYxa+mzwWC3ZehEjm/dg+WA/boNdj6o9n0bsyy7RHsx9dG41ERqDisfuxVsbiAtToNgbLZgxFcOnC/ynA3oXjMW31MRjlPjZngIL8LIzelIxh9ViGPYYTiG3+Ni6JveBdam4jo74IFZu/hsWfT0H1Mmc/4HDq20kYPfsn6PykNvtQrMlB3y9OYWpHB3PDmC5i/Mtx2JdVCKnk8VcwGfQIiGqJecuXIuYpp7HwYJVtRpFGi2KTGSKRyCYYrPxUang7GsVp1iEvrxCwvAGlN+PMJkhk/lBYPuSycdAVaFGoN5VMUlV6HzjObNmHQPg4rCcMyM/WgPOS2NkHM8Q+cij8ZDZljzIUaVFQbLDUR7bHYf1yylVBkDm8TjTiQa4GZuv7aPl7lPUYRF5SKPx9HVZ3Rl0BtIX6MvbBBKkiEL4Ox+OaLF8eDfSWj05sbx/E3vBX+EPi6I3ggdqQRFAcnhsI+btRQBJBoYAkgkIBSQSFX0CaiqEtKKSOucTjHAekOQuJiXuwbf5Y1OryMnZecd/k5oTY4zggOQ7FBRo0fSUOb3ZtDdFTzPdKCB+OA1ISgi4v90WFqACICoupyiYex68NaTBTMJK/Bb+AJORvQgFJBIVfQErV8PXzg1L1cPEhQjzBcecK8y0sifsQ25KScfLSVYRXrYfatSIxcclXaF6yTBsh7uWkt48BOakZeGDgIPXxgtlogAkShFSMgJyG1RAPoO5nRFDoooYIiucCkruO6V1iIJf7QaVWQ/3In1Lhj8BKtbDlLtu2DMUX4lFDJIF/qedb/3y9RWg/fj10bFv70rFscDsopb42+6BSKSGXyfB1Mtu0LHlbESUS2d0HP6kXmgye42SZYw02TXoFQd5yKO28hpfltWefYpuWRZ+Itv6+8FWqbJ7vL/dBdPd3cUXLtrXLjMPxAxEqkdrdBx/LPsRtdTI/jvEU+teqCJm/wub5Cj85qrXogWOuL05rg6psIihUZRNBoYAkgkIBSQSFApIICgUkERQeV9kcru7bi98yMhFULQYvt3I0xQIhT8dpQB4f3w+TkkPQ6Tk/3D9+GPm9vsaawbVZKSHu5TggM3aj0tBEXN4xBwqWNaxRRby8MxW9KrAMQtzIcRsy7CWkPBKMgBY54iAopCxJiJu5cFGjxfqJQxAUtxOdAlkWIW7GMyD12DD/LZwIG4xVg6uwPELcj0dA5mJt3Es4qZiIRWNeYnmEeIbjgLx/FkvGfQyvQd/g838/V5KVlDAZJ7NKHhLidg6vsjP3fojIzrOA8HCIi4pgsuQVFhdhzVUd+j/z5zaEuBN1PyOC4sJVNiGeRwFJBMVzVTZ3A7N6x2LhkWT4SO2swqAMx9IDZ9E9gmXaUXxpBZo2+QCZgQqbVRj0hQ/Q+J0vsXXmayj7Pn0GVo14C9N+OA2RzOexfbAetl6nwwLLFVpsNZZpT/4OPBv2BtKCVTarMBiKtaj96jRsjB+DsDInjNdi6/SheC/+AIy+tisgaHPv46Mjeox9lmXYo/8Fnav0xe9iL/iUXoVBV4Qq7d/Ct2s+R6Qfy7Rhxq/L30bspAQU+8ts9qEoPwuDvkvDgm4BLMcO4xkMea4ftqdrIfN6/BVMBh2C6nXA1z98j6ZPeY+a2pBEUKjKJoJCAUkEhQKSCAoFJBEUCkgiKDwCsgA/rpiK/v0HYNKSbSyPEM9wHJDmDMTXfgVbfFti/PjhqH02Fs+N/5kVlh9jG3ojIEwFkagfsmDE54OaQOIXhKjG7bDhkvOFAMyXN6FNvUqIqBxeMvWI0l+GZ2LicMLxPDDlk/U+pCsGohn3k4Elyomz2z/jViy/XPL4+vHfufySBzM41ZSLJXn8bOG6dtvAHnPcHxuncA0aduXOlrwY+Ytrbcjsb3G88UtoWuba0P9MamUQbl8/a3l0DTHNn8XHezRASioqKxwtjVxKvhZ45BeOkKrPIrJq0KNZxILX26G9ewW9KokgqrMZ352aBgc/MP0jeUujIFGakHNoBbSV+8Dv0En8emQfXmxZi23Bg1yFC1tfgzo4EAFqFQLa/xtNR69GNM2S/RheAelfuTa2pHDI3R2JyW0n4hbLLy+CQootAXkT3y3Zjs/WzIWywlFcvimxBBbbgI+ifNTvuRF5WTnIzcuH+fxu7BzbFKvdMYfdP4hLFYa68RwMqD4Hy/cYWU75IFWEIiv1KFbuaIPeHQLA6bNxZH0Umrs4Z4K+MJ89sqjxHJYN6YszJ86zDGLlMCDNF9cjpuubuMUuJLVnZ+KdhF54vXM5a0QqVDCfOIALNWog0tJgqZZ+BmuLUvHnoA6eVP7w8Xk4oNhyysSCw/sQHk1d7x/DLm7KlnKMa9rEh/OVyjhRw1e5Oyy7fHnAbRj7Mjfqm+slqfxf53ENek0uecyHKekHrnV0BFexUhinUqk4lVLByQIjuOH/Oca2IH+h7mdEUOimAxEUD54hi3H7QhLuPiiCWCwu1Vvb0igVeyOqUVMEObiVxxWm4uTJZBh9Hu9xbmVdM8c/ojYaVA+1KXvIgLSrSbiRqYVIUnofOJhNJtRq0gZhMpYpVFw+zv16AVrL+ygWPX601mOQqsMRXbcm5A5OL/mpV5GUnAnOS2Lzfll7fIdHt0bNIEfXBlpcOXERWQYzJKV6rXNmE7z8AlCnXjQUT3l54cGATMcPsxZgW1I6vLwffxOsByCWqzHi03g0cbAimOHObowduxb5CrnNEAajrhA1uo7ElAGtbYYWPJSHvcsWYd2vyRCVCmrrYRsNBgxdsA7Ph7FMoTJewrQhs3FDLClZteFR1mAKrt8J40YPQcUyx3JwuLx7KRasPQa93MemWtQV5KPj+G8wtImDm6LmG4gfPQe/5RXDx/LlfpT15KB4pgHemzgBkU95X5XakERQqA1JBIUCkggKBSQRFApIIigUkERQeAfk/V/i0S5qEJJYmhBP4BeQuntYuG41jl1LhcNFR/+hNr9XEyKRCL5+SgQEqiATheHZuBWs1Lk/Ns2Cwvp8nwgMnHsK0P4AqbdXyWtGDFvHtiJWvALydMJ83EmLQueQqiVzRJY3feIvYtHkT3Hj5gPk5uSjmMvAmydHYMAutoETtfr2Rb9GU1Gov4cvu+sxd3dt6AxGfDx3BtZOfpVtRax4BOQDrBl5FAOWT0WoRFMuA9I6rfWDIj0e/oJQiNSMKmhYlyWdikBT/9PYYgYOLh2FD/rPs+RlQZefA7GImvGPcvpu/DIqGgdn7sBLFZXQGb0g9J99PUOKoNx9iKroC3VgAFRSBRJajsOoqqzYKT+oKpqQfSkNB0JqoItPMpafzoHCnI7wkHLWt9QJxwGpPYiR8TmoeusbzJ/xMU5kH8Hq5UdRxIrLDx2yA17A1dRC5OXkIl9nwuEuZxHZfonlXMlP8zbZ2L03GQGaaEyaI8OhE0Z4iQLhXeY0fuWT44D0aYgVR7ZhWLOaiGkUjWBZKGo0iHAwH+M/lZflPxMe5GtYGqgy6Cu8kboBJwwsw4nQsNpI2LAYRcrn0bZ/LC6u/BjQtEQwLUL1GCcBGYjmrTqhZ68eaN2gMmRGf0REhfFpeP6jGNMu48adO0hKOo9r167gj+Q7WPfZ89jcYQra8zzDyWIaA6c2obiV5d/Argg79z0OIqDcjeB0hldvn+LMu5g99l+4IlZCrXwVs77oi/K0mNfhZcOx8FABvDk9jEbLlYlJD13Vjti8eAz/NrX5EmaPWYces2ehjhw4tHoEUqpPwZvtHEwhXA5R9zMiKOWt9iUC58EzZDZ+Xr0Oh29mQ1Kq27y1x7hIqkDfd8ahropl2mFMP4qFC3egwM92onajvgiVWr2OoS/F2PQmf0iL45vW46dzKRBZfxlhuVbWwzYaDeg5ZiYaC739YbqBlR+vwT17PcaNeqhrNMWAN15BSJnDQTjcOvoD1u24AKPM22YIg75IiyaxM9CjrqUtURbzPWxYsBaXtHp4ix//NKyLGPiG10S/QQNRxZdlPiEPBqQGZ/cewPkMDSSlx7OYzZYAkaN19z4OD8CcexkJW35Dscy2231J1/267dC5SXUHp/kiXDmSiFM3siAq/aWwHLbJ8ka26DUItR4dLi1E5nTsWrcP2ZZAkJQKSLPJAL8KUejQvjlUDm5pZiQdxoETt2C2Mz7JoCtCVMdYNK/iaIBTNg4l/IzbRUZ4lRpTYw1IWUAE2r3QESFPedeA2pBEUKgNSQSFApIICgUkERQKSCIoFJBEUJwG5JWFjSES+yMwQA0/qQgNhm8up30iyd/BaUBqslLw0QUtcnLzUKDjcH5VHwc3ogl5Os6rbI57pKc0IZ7lNCDVVerhkxg/BCh8IanzIr6+ThU28RwXf6kpwISu7dBw5Sm8WZllEeJGLl5l+6FrGwWuXitmaULcy3FAGguRkZ3HEn86cvwkFArqd088w2GVzd3ch54TVqJlq0j4ej+DzFMbcUD3Pg6s7woX1rAihDfnbUhjDvZtWoekTA4hwc3Q941mFIzEY6j7GREUFy9qCPEsz50hubtYETcOq0/fgXepXsrWlQO8/IMx7b/b0cHBhPP6P75D7z7zkKPys/l1yFCkRb03P8WyMY7as9nY+NEELP7pEkTSx7vuWw/boNdjUsIJ9KzEMu3RHESPFmNwP0BhM7m+deL96i+9i8VTByO4zN7ahfg5fhI++eY4jHYmnC/Mz8a7G5Iw2NG0LIZTGNL2XSSJveBdqre2UV+Mis36YP6ciahW5ggEDmfWT8W4+Xuh85Pa7EOxJhe9F/6KSc87GE9iSsKknqOwP7sQ0lKT3psMegREtsCsLxahoYOX4MODVbYJ2txcFOjNEFnexNLBYPlfQxUcAqmjc7SpEJn3H9hdyqJkKQpfNQIVjgaimi0feB40xUa7+2AdSqEMDXe4nIZ11orMtNwy90EiUyDA8oUp+yU46LR5yC/QW+qjx4dyWFmHUSiCK8DP4YwqBuRk5MAoshxDqSEM1mMQ+8gREKB0+JOuoTAfuQ+KgVLDSaysQxDkAeFQSkuXPMqIvMwc6CwfXemlSazLvIgkPiXTzHg7egkeqA1JBMXhuYGQvxsFJBEUCkgiKBSQRFBcuKjhoNVoLdetgNzP3+b2AyHuwO8MeXc/ZscNQ8e2HdG+ex9su5rFCghxLx5nyHzM6zMA6g/nY3ijKJZHiGc4PUPmbPwX0kf8WBKMRQXFNJyBeJTTgPzpexG4e8vwfItGqN+4Mz6cnohsVkaIuzkJyDwUZJ/DqqXXsfDAGVy/cgi9Yy5g884cVk6IezkJSCWybqWg+TtTEcN+uA8O0iLt1Lk/E4S4mZOAFGPSrtG48N1ylgbO/H4P3o0asBQh7sXjKptDwvDOWJKuhyxLDnVMfyxYGotwp61PQlzH88a4Afdu3oBGL0OVGs/AlxafIh5C3c+IoFDFSwTFcwHJXcf0LjGQy/2gUquhfuRPqfBHYKVa2HKXbVuG4gvxqCGSwL/U861/vt4itB+/Hjq2rX3pWDa4HZRSX5t9UKmUkMtk+DqZbVqWvK2IEons7oOf1AtNBs9BusPl5TTYNOkVBHnLobTzGtZVFWafYpuWRZ+Itv6+8FWqbJ7vL/dBdPd3ccXhQuZmHI4fiFCJ1O4++Fj2IW6rk1t5xlPoX6siZP4Km+cr/OSo1qIHjrnhBjVV2URQqMomgkIBSQSFApIICgUkERQKSCIoDq+yjXl38NvJM0jXcLCOWDCbzQio2BhtWlQFz3XLCXGJw4BM2TQcdT44htH9+8BoNEGquontk1T4nluGWmwbQtzJYUCaCrKQblQiQsVmz8legYj3I3BvTfc/04S4mUs3xvcMqIijE1Ixg3qfEQ9x4aImCXOOtceAaJYkxAP4B+T5w9C+3B61aNUk4kG8A3L/nkL07tCMpQjxDH4BqbuDH29dRmT1KiyDEM/gFZD6jHswGjNQrVIAyyHEM6j7GREUF66yCfE8CkgiKJ4LSC4Zn3RvApUqECGhoQh95C84KBDh1epiWwrbtgzFF5eitpccgaWeb/1T+8vwwsQNToYwZGDl8E4IVqht9iEkJBgqpRJrb7BNy5K3HfXEUrv7YF0ht+Xw+U6GMGiRMLU3KvipEGznNXy9RJh3mm1aFv0hdAxUQx0cYvP8QJU/YnqNxtUCtq1dZhxZMgSV5Eq7++AvFWPUdmdDGE5jYN2qUAYG2Tw/KECFqLZ9cNwNE5pQG5IIClXZRFAoIImgUEASQaGAJAIC/B+utn1bFC2mtgAAAABJRU5ErkJggg=="></p>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Finding the Bugs in Legacy Program', 5, '2019-03-28 11:08:09.851', 2, 1, 1, '<h2>Objective</h2><p>You need to find bugs in the legacy program, but the source code is not available.</p><p>Write own tests to find the bugs.</p><p>All the exercises are provided with configuration files for initial states of the game. You can access them with also provided GameConfig utility class.</p><h3><strong>User stories</strong></h3><ul><li>find&nbsp;<strong>three&nbsp;</strong>bugs.</li></ul><h2>Source code structure</h2><pre class=\"ql-syntax\" spellcheck=\"false\">public class Reversi {<br><br>    int[][] playground;<br>    int leftB = 0;<br>    int leftW = 0;<br>    private int[] players = new int[] { 1, 0 };<br>    int onTurn = -1;<br>    int winner = -1;<br>    boolean ended = false;<br><br>    Reversi() { }<br>    Reversi(Path gameFilePath) {...}<br><br>    String[] readGameConfig(Path gameFilePath) {...}<br>    void initGame(String[] gameConfig) {...}<br>    void initPiecesCount() {...}<br>    private void run() {...}<br>    private void printPiecesLeftCount() {...}<br>    int getLeftB() {...}<br>    int getLeftW() {...}<br>    void move(int r, int c) {...}<br>    boolean areValidMoves() {...}<br>    List&lt;String&gt; getPossibleMoves() {...}<br>    public static void main(String[] args) {...}<br>}<br></pre>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Debugging the Legacy Program', 3, '2019-03-28 11:08:09.851', 3, 2, 1, '<h2>Objective</h2><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">Fix bugs in the legacy program from previous exercise. You can use tests you wrote to find the bugs.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">When fixing the legacy program, you should keep the original core structure of the code. The program should pass all your and hidden tests.</span></p><p></p><h3><strong>User stories</strong></h3><ul><li>fix <strong>three </strong>bugs</li><li>do not make more.</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Adding New Feature: Board Size', 3, '2019-03-28 11:08:09.851', 4, 0, 2, '<h2>Objective</h2><p>Add a new feature to the legacy code: the board can be of any size, defined in a configurations file.</p><p>Fist, you should use <em>size</em> variable to represent the size value instead of magic constants in legacy program.&nbsp;As a result, this repeatedly used variable gets a name, which describes its meaning, and it becomes easier to read, maintain and change the code.</p><p>There are techniques for working with legacy code, which respect the properties, functionality and structure of the existing code, no matter how good it is. One of this techniques is called&nbsp;<em>sprout</em>, it uses isolating a new code in an existing one, so existing code is not changed. New code may be tested independently and its influence of the existing functionality is limited and observable. A sprout method, which provides a new functionality, is called withing an existing code. When it is needed to add a sequence of actions and changes, which are related to each other, creating a sprout method may be not enough. In this case a sprout class may be used, with new variables and methods.</p><p>After refactoring, use sprout technique to add a new feature. Configuration files contain one more line for configuring a board size, create sprout methods to read that line and store a size value to the created variable.</p><p>This exercise is provided with new configuration files, which have one more row with size value. You can access them with updated GameConfig utility class.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>The board&nbsp;should&nbsp;be of size, defined by a configurations file</li><li>Use <em>size </em>variable to represent the board size</li><li>Board enumeration should be used on printed out playground</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Adding New Feature: Show Hints', 3, '2019-03-28 11:08:09.851', 5, 1, 2, '<h2>Objective</h2><p>Add a new feature to the legacy code: printing out the possible moves on the board.</p><p>Use <em>sprout </em>technique to add this feature, keep the original code unchanged.</p><p>Here is an example of board with hints:</p><p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJoAAAC8CAYAAACACrc8AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAASdEVYdFNvZnR3YXJlAEdyZWVuc2hvdF5VCAUAAAAhdEVYdENyZWF0aW9uIFRpbWUAMjAxOTowNTowMiAxNDoxODoxNCxjzHsAACVsSURBVHhe7d0HXFPX2wfwXyDsPRVcKNaJ27rqplZt3atatzjraKVaZ6vWuletddQ9amvde6K4FRcCCrKX7BUII/u8N3AUISEJ/Ze8Vc63n3zqOeeG3Nw899xzb56cyyMcMEwFM6D/Z5gKxQKN0QsWaIxevDeBJs/NwN4tvyBcQCuY98p7E2gyYQYObPsN4Vm0gjo5xRa8hoNwOTyf1qiSZp9DNx4PRqbGGLYrlNYy+qQx0BTh59CvIQ88ni3qudeGS1UnDJuxEhECOV1Cf0xc6uFWSAQ+r00rqEG/C7DNqxbiBQpao8rIpi98uZNr6bWZSM/OpbWMPmkMNIOP+uLs6RVwXHYfYZHRSEpOw8oOTti9fB9EdBmA4N7B+RgyeDAGTpyDyxESWl8s+clvmDZmML6a8A0OHvkLxx4G0RYq+yqWfT0EAwcOxJoD93DZ5yASC2gbcnFz3SIMGzQY01bsQayQVr9BcpAPC5iIn+CXySMxcNAErDobQhtLyhcUcDsNj5ZKijq+gXvuUAwdPBDL9/vQWh1kPMTUqVOxbsd+rJk+CKtORCD53kaM6TsdPsklrxwVvLoA74kDMXjIUCz68yGtBSSpL7BuzjBMmuKFqfPWID4nFTtmT8L4yZMwdNpqJGaKC5eTRvhhttdIDB06BFMWrUNCemH1O+SIub0eXiMHY/TUhfjryB78/TiGthVTboOytkOFUV5H0+jRQmK34DEtEFIQe53MnfwDiSss5ZFjm+eQhRtPkYDAAPLikQ/5vm8fciq7sLFQRuhtMrTtaHLuWRCJiYgmR+YNJR3nHaStSgVkmmtXsvb6IxIVEUYCTh4n3b7oTJ5k0mYiI+mRoeTZrfNkitdQcimSVr8lItunNCX2jk3IzpPPSOijW2TB4DrkywMRtL1Y3tlppPv6p7RUTP5oPek37jdyLzqchIdFkMv7V5OJS/8iQtqukUJMnp+aSczgQnb/voeMtnAhLdqvIJc2TCGOPVfRhThpf5N+A+aTG4+CSEDAc3Ji7Xzy/fYzRKxsk0tIxtUFXFR2IM+y0olULiWpMdHEswrIt4dDC59OBCFk+YyvyTZffxIZFk4C7hwnA3p7k+ii1kLx986QwZ5TyfXAlyQ2LIbs+boL6bjch7YWU37sunz0/ybtYzS+CbIDr+DO9cu4dPkS1qw6D5tx36EG15Qd9hyRaU6YO3sAmjZpisYfe2LN7s8xafRfRc/lGPBTUNPFGXlZqVyvmIYO847izurRtFUpEU4uTjAnBQgPS4aiQQfcOH8LrexoMwzhUKceWnzSHu5VLKC6H8pQIKqPiQcvYdLAFqj3cWesPH4e4ukLEU+X0CwPKze+QJ8BNSCOiEZkdBTMqnnAPuM0DvuVPe57i2eMZk0aov+0g/CaPAGTZ+Zj9N8L0ct7FFqLZHQh4NCEnZh2ahW6feyBpk2bYdDcaUh/fh9+sXncRjKCfY+VuDQuBDseOoBvwIdT1jZk1N6PTV/VK3x+wMObSBHZoT4/GxFRkUiRuWJeF38M2BBX2K5kYJQBN25bZqUmISwmA73X3MSdxZ60tRj3uRc+9El7oBnyoYh6Bt+bt3Dlwjk0HrcUi9rbFDYJ0p8hJaw2TApLlHM3DD97C8G0aFtnCOYv74JX107hhs8DHFqxBLf8k2mrUh0su/kzyN0juODzCDf2b8OBv+9yB4FSJBLIFWo2DpFD5lELTV2K1qlIQ3h2TMWjHFrUhLxGhjATd31u4eq1a/C5dhXnLt+ArHoPfOJmSBfSTCqVwii/6MXyuLgRZXP/4Hac4jALwu1zDeBGS0Uc0StZjOAs5cJFPp04Fpfm/FT4732T18Ft0djCfytJXj+B/6tYXL18GT4+Prh64SSOpn0M766WdAnA9ePxmP2NB/yvnMHNa/ewe8lS+IX+R07TC/s1Tfx/JI7LgmmhpNwoXzJvpheJVtAKpch1xH7kKVpQlXFpAek6fR0tqZEbSiYNbUduxtPyW1lk/Q9e5EYCLb4lI1vHDiIzjofRstI90tN8JEmhpTfkV2aSzza/oKU3CsihSaPJAZXXK4fIbWSc19nCf16eZUPWFR7trpEe3VcX1ikdHWFPNr17nJOFk5HTFpCH8QW0QklEZn9Rh9x86kvqNZ1IEmmtUpTvTvLD6uO0pJuEI+NJ29n7aOn/l+FSDo05VaIsBJ7cgY2+Qng6CxCaawn3qta0ETC2c4Es6QVOXAyHND8FUSFPsWXNDSw9tBhu/KJljkyrgt733dBemoSXEYG4dCAA9XuMRocmToXtuQd6wWR9AjpaEESFh8Dv4hlkCHpg8JgWMOfapYJY3L9zCy/8A3D5yhVkEyeI0qKRb1EdVa34yAo4hZ3H9uLSH+egMKsJScITrP5uO9ocOY4eVQpfAsmBF+Dz9DVe3jqO4yGGaGaZgSeJUtSv6QwDHh9Nu1pjUtuhyDS3RG5KIsISb2HJ2rUoqPopmrqaFv2RssiycPHYHhy5mI1+Xp5IurAYZ/NH4ssGAuxefx4e3buiirMFmvRshS1fb4HMjIf4qDD4HjkJ8yafYmineu8cVviwSgxG9yGz8NHcLfimg3KAUsTOzQ3P9izChkuv4GAsw6vEl7hxcAoWvGiPMW0cC5f5Zaw9Jr+ojxb5cQiK9MeFPWFoM8ILbeu+29sXnQwsW7YMmj76f5vGL9VJ8jNs3HsGefliZOUIYdtxIpYMa0Fbi/mf3YB9PrFQ2FTHiMne+KQGjTJO/KOjeC6tgdzrp3E/W45GvQdi6qefvB1rScMu4VR2bVj5HcGtVxkwbN0W340eBXt61MqPe4Df9/yBOC7ILS3MIBcJkUtM0XHUXAxrZovnf32HXYkd8P3ohrj+6148yzZBs8HjMalr3aI/wAk6Nh/b70hgaWkFS0MJcoS5ENb+FL/O7A+TN5+yPBA7Vu1GSKoB+O71MHmoF+q7lhgUqCcIxE+bjnLbyAztv5qGlrl/4LfbfEybMhD++35HmHVPzJrSvnCnkcTcxqbdR5GQw0ednhPw7RdNi/7GO/KSQrgAPYXm3t7oUq10kOfB7/hGHLrFbScHW7TqMgJjutWnbUDEg6MIl1VB2tXz8BMboGXfYfDq1Iq2Fntzxqnho//XsewNRi+0nwwwzL+ABRqjFyzQGL1ggcboBQs0Ri9YoDF6wQKN0QsWaIxesEBj9EIvgRbt+wsmNXaFU5VqmPH7MZTOXdSI5CEs7CWubfkGLi0aY+8TXVIyShPj4qwv0bBqLTg6W2H4oh2IK06t0EnmjdPwHtcdVtZWcPdohO1qEgp1k4VZzXmwdl+FNFqjq7i/xsDS3ABVXVxQxcEKpm0Wc++s/HKDz+PbvgNgZWmOuv29EJ6tmqyqjjTpMbrZ88CzdIELtw7V3KzB4zXCDdquSYUHWl60PzbvycAPLxORlpKAjhmBuPo8lbbqgOQi4PFNOLeegFlj+8NQNYFIq4w7G/B1UC08SY5FeqoQvfL8sOTX87RVFwUIDxai87zTEOYIEXljHnb0nK1jvltJCbuW40qtfujtpOXLejXkcoJR+8KRnJSElAwhRI9+LpmipYOCpOtY9etRdFr9O4S5+Yg4swcf2RjTVs0Mrapj3pEzKMhNQhK3DgkxwRj66WA0oO2aVHigJSfdg3WroahJy52bGOPmvXu0pAODKhg6cjqatXcHT5hfmBpaXjYeI3Hj7FpY0HLvvu2RGxnMhY+uzNB2xmgMaEgzV5zHokdOAu7okBdZQl4IJh8KxZ7JHSEokNJK3RGFFBLJP+nDij06tQ2NvA9icGOa2lIOBlxP1uuzfniziwhv7oa4R1O40rImFR5owmA/vHC0oiXuBfki5IvKv5HBbeR/+u0/364W6rxZBXkcNh2+g86jvbjwKb+Xd69h+8/j4LPpF3ylTMkoh2t7lqN2t0Xo2M4FYmn5e2Yb9w6IXNkRDvYOsP2oDYZvv4myf5Kj3pWDaXh5dTmqV7NHTbcvsf984j/crnKcPpGHpvbutKxZxY/RDAzfpqUU4cFA3z+MeCsV6xdMh0PPHzGznQOtKw8Fnl7ah/PcoX+IUXEqlE6ET/DrgXh8tawDYMmHibEFinNjdePwySzcCslERmYGBOGPMCrgO8x9QBt1EoMXfg/gE1QdAQmZiItZi+zwm3iVUN5w5RTEIcggHd066nLg1EOgmTo4oU5sceq2EZ9AKv8HPdr/ShaB1WMnQdZ6BeZ++RGtLC8DjFnxJy4cPw+Xe4Ow+FY5ziie7Mf5Z3fRy9kFTlVH42rASszd+/gf99JK3Tq7IJgLPN1ZcONKGcbMHI+i3cwO/Oww5CWWY8xM5acZwFjujFp1devWKzzQqrYaATPJU7w5V7x6xRbtPdrRUjkY2MDc3BQWViWzRXUhTQ7Ez3NWwvXHQ5g/TJlsKMTr5BTdDzuiTDzx90f226MdDxkCMRRG5dh83X4rTDTMSU1CWtZx9Gm9DFsmfKzmxzZlkAgRGPAUyaI3oUmw58gd1HUvznjWzgnL13WH33XaDYqT8NrACjwn+6JyOby6sxpJNYbCXceOXQ+Jj1IEHNmGLReCuGARw6V5D3wzYwwcjWizVqk4uW4zLgdF4Y7fPVjU+QRt6rliwpINaK3j9jkzmodh13th8vC6kOTJkRF0FpGNvsWD3XPeDmw1EkRi/cZNeJQRDzuJK2JTnkNqPwdX9w/mzoLLJ8b3GDb+9gO2nLTCb/dPYHr7N6dJWuQlYdvm1QhJiEa+xAUkIwnhiiG4cXoMdN6UHFnqHSyduhBRDnXBi5Ghet8pWDqrY7nHqztGWSJmci5Wd6YVWugnw7ZAiOeBz5EtM4FHszZwKNfgRISYwCDEcT2IqakJiEzMhS4fDVq3g6NuZ+UQxPkjJFEEhUxOD1U8OLh5oGH18vSOcoQGP0ZKGnfWZ+GENq0b6RakpQgTI/EiOhmGRmawr14XdV3L0yMRJIc94d5LPiwsqsKjVX2Y/4NjkjgrFv4vo0BM3dCyRW2YlHdv4WTEBcCoWjNY6/hclsrN6EXFn3UyDIcFGqMXLNAYvWCBxugFCzRGL1igMXrBAo3RCxZojF7odMFWHOMHv7AcGLnWQ3uPWrSWYXSnPdBen8XcdddgVCBDdk4IGv18E9OLJ+phGJ1oDbTt9b6EWfDfGFf4Lb0fvh3ghx9Oz6JpJgyjG81jtBwfHPrscxpkSm3RxM4bZyNokWF0pDnQsrPxKqd4jlUlOSxgXM7kUobRHGhEAQW/ZFQZ8BRg+R5MeWkOtJoN0P1VJC0UyU22hUV5k92ZSk/LdbQmmNM7B9vexFryLpyTb0G/onmOGUZnOlxHK8C8jq2w2T8aNT1G4OaDvXDVEp4MUxrLsGX0gvVNjF6wQGP0ouICTRGGRZ4eMDO3hK2tbYmHtZUlnOs0xYVEumwZMh+sQm0eH1alnq98mBvx0GOJtolaYrFmUFtYmlnAptTzbaytYONUDUeL79mlljx8J+ryDNWvg7EBOnsfgOYpOFKw3asrrE3MVdbB1sYGZqam2FvyxF5V5knU5/FgWfr53MPChI+2kzYiTeNvsgU4/N0XsDM2U10H7mHI/e0tb27eVRbRNbQ05MPCRvX5lqZGaD58EWI0TGbCxmiMXrBDJ6MXLNAYvWCBxugFCzRGL1igMXqhU6Cl+J/Gup0HEJf9DyZsYxiO5kCTvMDMyUNw2Sccl/zv4WWS7rO+Msy7NAeasQe27DyOsXPHoqWzA3SfNY5hStJtjCYSQSZnh03mn2MnA4xesEBj9IIFGqMXugWaqSPMLMxh6/Dm3iMMUz6aszcUwZjTaRC2BCTDwcoMkoJcGLt6YL/vA3xW/ju8MJUYSxNi9IKN0Ri9qMAeTYT4kDAk5YpV7/3EvSSPbwJ3j6aw1XA3BnluIgKD4iEzMlS5VkzkMlhWa4CG1W1pjToSJIaFIUFQAJ6B6tVmbi3g3rQV7DXdr0CcCv9n0WWug3nVumhYy1HDHitDSlQY4tLz1K6DQi5H7eZt4aTpfojyTDx/FAapEV91HRRymDnWRIPaLuCr/nlKjozYcEQn5wCGqmsql0pQq0UHVNV04wSSjUC/VxDz1WwHbh1M7FzRoG4NGJexDhUXaCQRfyxZjbOhqTDiVu5dyhUzsq6Cmas2a7z7SW7oCXh//yeElqYqH6RMlIcGQxZj2YjWtEadNJxcsw5Hn8bBkAuUdxGiAPhmmL5hLz7R8DtVknQV06bsQDY3RlVZB3E+6n4+Cz9O6KbhvpkCXP5tPQ7cCoeBylwSBFKJFFO2HINnVVqlTu4DTB+xBhnWFip3apFLClCz6zgsntpPw80l8nB730bsvBAEhYmRSqAUCLPgtfUivqhBK9SRBsB72E9INDdVXQepCC5tBmLBrFFwLmOnZWM0Ri/YGI3RCxZojF6wQGP0ggUaoxcs0Bi90CHQMrHhs0/h4OSEThNW0DqGKR8tgZaFiS4NETZrKzLS0nCoXSzsuq9CyclGGUY7zdfRMp7i+xvA2qGtaAWwvBUP1Y4RTKhDKyoNGXwOrMDFQCEU9u6Y8c001GUzX+qsfBds0/+Gfe/7ePF4M1xpVeWQjl0/rUWafXN41LSAgSQTF48+xNSjv6MpXYLRQhloOkk+R/r1Gk0Cc2i5Enl9/W+yaucRIqNlJanvd6T5/Hu0xGij01kneXEYXy8+ja83bEETK1pZiUSHRECeVaPEd3z8rn3Q+ehVvKZlRjPtgZZ5EsPmX8HQtbvRs5ENraxcaribI13+EiV+B/b8Nu706IDqtMhopnGMVvBgHdr3v4jNTw+hWp4QxNgSu6fWRMMdBOMq1clAItbOWQGzNqPQo4ktDPLi8evS3zH49Al0Yzf30InGQBOGXsSabYcQligH4f5TyGWwq90S3kt/QKNKdwgV48jqyTh8TwB51cZYuWYlmmtIcWJKYmlCjF6wr6AYvai4Ho2k4dLv+3ErNgv8UunDyuxWvoU9hs+Yg4bWtFKNgtgb2Lj5EvLNTVSyQpWZpW6eEzGlZ0Nao04WfPcfxLVXKTDgl9qnuLdN+CYYNvtHNNOUDf4/y8X9owdx4Wk8eKWyfJVkUikGfb8GbTTdlzI/CKsXHkCOmkxjuVSMqq37YOLgLrAos9sQ4dnZP3DqbgQ3zlYdVIrzc9B/3q/oqOmXbbIwbJy/C+mmJirroJBJ4Ni4G8YP7w27MlLzK/DQKUTA9VsISc+HYalceWWgGZhYosNnX8DVjFaqIUl/iYuXAyBRk35c9Oa6wrNpNVqjTh6Cb99BUGI2DErnyisDzYCPdp8PQk1zWlchRAh/eBf+MRngqcvXl8nwcd8RcNf0LYMkHmf/vg2RqbHqdpBLYcONm7u1aQCT0o1vSRHz7C4eh6aA2+tpXTGpOB+t+o1FfQ07PRTJuPjXDQiNjVQDjRu7W1VvhC7tm8GijHRyNkZj9KLMzpZh/k0s0Bi9YIHG6AULNEYvWKAxeqE10MSPL2Jc/2YwNuLDvX1vPJfQhkokOfoVQsNeITgkCQRyJMeGI/hVOGLiXiNX482+KFEmwsPDERUVjpCQEIQEByMqQUAbKwnl5Y0yKTLIUa8l5Gx6UVHmN4PUcptDcouKlYSUTGtuTOo2bEeGfbWbK8vJgRUziGcDc4K208gLum00kUdcIuN61ybGpo3Jl18OJgMG9COtPHqQJX89Jgq6zIdOc6CpMRptyFUpLbxHEq9vJF2b1yC13BuQsb/50lrd3N+3gew6EM79S0ymeo4mvsrkz8eLSbMNrwrbdZK6n4ybdJUWCBH67SCeQ8aSmEqy1+o0RlNIJUiKjcWJTUPxavMe9HjPUmPS7izG9OP2OPk4DjERIZhheAVjNh7nDoK6cXK0QIwgHAWhW7Hj+jmEPMhA1JMHaPuRG11CB7kFSI8PQmJSLKJiIrF9hy9qNhoK10oyiaZOgSbOTMKOBcOw8EQelnSoSWvfF2IcWvwC328bCzu6g7SeOgGKB08QlC0rqtDC2NQOPL4UTy4eRauxS5AWeA9PwvxRv46muaZKMTRA2K1dmPmNN7y/9ca9hHxY1jRFZUln0ynQzKrUwrI//RB6ZxtuLPkER8Jpw3vhBZ7fdkfJWaFc0DUmCyEiMS1r5lqNj3yDOJzeaojZU9sgzyIb8VEN4aRhuisVMjnajNiIE0dP4PTpMzh9cSeM/9yJX32T6QIfNs2BJs5GZHwSLXB4bjBTREE5n9v7oxWGeR/G4Qe0qJRwD/vb1kYPW92OW3wrJwSdWYkjNoMxsl0TWIUegs8ZN7Rzpgvowozr/RTvHKwNq6Jza3PkKES04sOm+Uv1WF98tXgXnBo6cH1ATQQF/olM219wfkcXlcnY/tPS72De4pOwrGHPfdjccElQAI9+4zC6Sz26gBaycIxvWA/HPr+F3M2dcdO7BbptqsedSP1NF9CMJD/HpnXfYdMJK3wzox1EIjlyBNG4HOeAI3tXo5FlmWkXHwzt2RvybJy/eAZZmdxn5OCO0X0+eS+v8kqSg3Dx1lNkS4xQo+Wn6N64PNOKSxDx8DYktbuhURVDyFKfwyfKHL3a6RaoJOMVTvkGQnnqJSqQFqYoKYws0aLTZ/BwrdAcpf8MlibE6MX72Dkx76GK69EU0Vg7cjJ2P3sN49ITFStkMLavhQ0nrqC7hiOY4NlWfNF/A7JszFX2CGl+DlrP2IfD3p605gMmuISujaYixd5KZWysnDS6/uCF2LdiEuzLvFaSg9PLZ+GH/fehMFPN0s0TpOFH3xSM/4hWqCO+g8/rj0WUpbnKJRm5uABuPadi1/q5qF7GzN4VeuiUS6WQc3+99OzvSsqXNTJWfdMlEDkkErn6qduJAjxDYxgZfvgDae7dQiKWqt0OyvEeDPgwKv2biFKU6dbKW2Hy1HwYRKEA30T1twAlaVsHQ5XZ19/FxmiMXrAxGqMXLNAYvWCBxugFCzRGL3QPNGkekhPTdU6tYZh36XjWqcDZTV+gv3c4HpAItKO1lQPB4zNb4RspBWQSyOVyyGW26DxxIjq7aLotXrGkp744e/8RkjNM0GbgSPR2CcPibTfhaGEAm7YjMb7z+5Z6VX469WiS+Ac4cSYWbugADXc9/EDx4GQjwfG952BsYo8atdxgp4jDt9094ZtBF9HCjheClWt94VG/NlxcnQDnGqhnnY/tJ68gR1JJRi/KHk2bPaOak4Xb9pAJLqPIfVpXucSR77yWl5jD9shwEzLpoq457dFkbtVp3F8h5MoET4Leyt8eJJIR81eSsIxy/GogNYQsGfYRMTI2JXy31mTViRDa8N+nfXdKWI5fHg/Eimk9kJdXOXKnVMlhlBOAHxcux/qNm7Bk1hD8FDoPa3rrmh/rhjotohCYmglfSRbMfe9DkBqHKkYimJnp+M1GdhiWrf0FbZaHQSIugDT6MRpc8oLXg/dj1Kwl0JKwyHM3Bt38sbBkxLeApglnPlwEhGcCRycnODk5oEF9T3Rwvo4t94W0Xbsq1aIQ9iwS8laD8FPX+9j2SAJrUwn4OsZqpN89GFr0QI93MpMG7JqD2K+3QPe1+P+jOdAyQnGXL8fGRo5wdmyMPzIPYFDnLUijzZWHHAWmteE1aSrGjh6DEdOnYdfp7QgeMxMv6RLatO7gjp07b8Nc0BqDJrXCxdMJsDKqD3MdB70ScTZEuaU/Lns4pGQil5b+yzQHmkNX3HrxGjmZ6UhNj8ekKlNx7fZMlCdV/sNgDQtTU+4wR4ucnPgnkLaoBl3nKbc1t8ary/tQpdPHqD3oSyTtmQKRQV2djxAN27RFgfw0HiXQCk7Qz2uRsfVbuNDyfxodq2mUmxBJZnaxV14GIW2+OkQyaX1lcWxeW+6980ljj+akVauWpHWL5sSpZXuy66GYLqGDwGXc33Akx5VnBERIehmCzNr6rLBJNwry+vElMndkJ249mpDGnXqTOauOvTc/5tbtOhq3SEF+PgxNjKCQ8GCqa3//gVDOiCjnGUIhkyt3zMLtYWBiATOj8qUoEWWazttZH2XcyI+vOU1KDSLNR65YwR2L+LAyLyP56z+IpQkxeqHlrJNh/h0VF2iKMCzy9ICZuSVsbW1LPKytLOFcpykuJNJly5D5YBVq87hDRKnnKx/m3GGrx5LzdMmyxGLN4LawNLNQeb6NtRVsnKrhaBxd9IMmwOHvvoCdsTlsSm0H5cOQx8OWYLpoWUTX0NKQDws1z7c0NULz4YsQU0CXVYMdOhm9YIdORi9YoDF6wQKN0QsWaIxesEBj9ELrWafw1UXsuRgMwjOEXCqCfdMhGN/ro3Jf0WYqN609Wtih0Tgc5QgHa3NYmJvD1OS9mrCK+Y/Q2qM9XuSMS6NS8aOmuxUyuiEipKVkQKrgwcTGGQ4WlWViUR0C7ekiR3ilLse0JvnIsnDHGK8BcKVtTDmQeOxYsBqXnz9Hep4BHBp1x4yvp6JHs/ciyed/pjXQciN8cPhqKBQGhuDLhXgSbYhF673x4f9u598Vums49jlvwOr+9P6ir86hz+5AbF26CLU03avzQ6EMtPI48X17svKOhJYY3YSRmZZeJIiWigjJ3sGzyd7AJFr+sJX78oaBIhVSCft6tHycULVmON5JjuWIkGjOh52xbr8Nfd9pDDRF2DkMmDoPbyYoL4jcidl/1IJn58qxcf49tpiyyRXrv7lKy9y29D2GR1Wd0cHdntZ84GjPVqaoe0fJoOYGxMjMlDR0H0tuFqYiM/9E4J+LSNPqfGJiYkbaTt9OkvNpQyXA0oQYvWBfQTF6UYE9mhy5WQLkS+Vq5k3lXpJnABt7RxhrCHUiy0N6em7hfZRKIwo5jCzsYWepabyoQJ5AgDyJTP3crdxq2Dg6wUTT7qYoQHpqDojadVCAb24De6sK/pEIESM9RQAFtw4qW5Jw62BqBTtrcw1fCxKIhALk5Kufg1Y5v62VkwvMNX7pI0FGchbkZayDoYkF7Gwsy+y5Ki7QSCy2TPHGoYBENbNyy2FsVx0/7T+GThp+JJoTuBfDR22FwNpM5Q1IC4RoPnELfp/Wmdaok4R93nOx824EDI1LXYXnNg4xssCSv67hMw3XTBVxJ9Dvi5+RaWOhsg7KGbEbDf8J2+b0RYWGWvZ19O/wHVLtLFVn5Rbno26f2diyaPTbm6qpEuLihgVY9ddjKEyNVAIlPzsDc8+EYEQdWqGO5CGGt52OGAsz1Vm5JQWo0W0cfvlpJlzLuA8bG6MxeqHpoMEw/xoWaIxesEBj9IIFGqMXLNAYvdA50KIu/4k+3bujU59BOB+m4+StDEPpdHnj5eY+WBjSAiu/nw4nK0NY2TnATMtNrhjmXdoDTfA7Ri6sisPb+tMKhik/rd3Sjfln0WbBp1g/ox9aNBuCU88UtIVhdKcl0OTIyDHG9i+/RFb7n+DjtwKpu5fiRCxtZhgdaQm0XAT7ngPp+CNWjGwOB9P6+Pzb2kg6+YS2M4xutASaDXoPbgy4udEy18clJiBV3V1oGUYDrWO0Nr/tw0ffN8fR6Bzg9UPMW+6PpgNa0VaG0Y1u2RtxPhgzeSb8YutjzeHTGNCS1jOMjliaEKMXWg+dDPNvqMAeTYCHpy/CP1kIfqk06MLUX1NreA4ZATdzWqmGOOUpjhz1g1hNVqhcKoZL6z7o36b4REWVEM8uXcbj2EwYlE7F5t42MTBC9+HjUVfTL8WzX+LQgZsoMDNWuw7OTT9Fv44NVLJOixXgxY3LuB+aAh5fNVdaJpOh68hpaKjpFiriSPyx4xLyzE1UegaFTAL7+p+gb9fmMC2z25Ag7O4V3ApMAEplOytJCvLQafS3aGpHK9SRx+PI9rPINjFWsw5S2NRpiS8+bQerMtLBy1y1/50CBblCZGdnq33kCIWQabn2S2RiCAUCtc/PzhYgVySjS5ZFAVFerprn0kdODqTa1kEuQU6Z65CN3AKJ8hcQGiggztewDtz7kGi7Bk6kEHLLqX++ch3E3KtoQiAR5al9btFDALHWm+TJkKv2uUUPYb4ICg0bgo3RGL2owB6NYYqxQGP0ggUaoxcs0Bi9YIHG6IXGQEvzXYGGVXiwsrGDra0drG1M0LjlurfTWDGMrjQGmqG5E/quvwthdhYEgizkZN9B9XwZ3rnjM8PopFzX0QR722KIuS98hmu4nM8wapRjjEaw+ScDjPRkQcaUn+6BFvUHdjTqhfEaZv9hmLLoHGixjzPxeZ9PaIlhykfHQBPg/PNUdG3Jbp/C/DM6BRpJCsfNhJeoVZ3ejIFhykmns06ZMBmBr0LxUcsuZeYbMYwmLE2I0YtyXN5gmH+u4no08hq7vBfj6MtktZMlG9m6Yv5ve9HegVaqIQw+jIlT9yDHSs1kyaJcNBm1GhvGt6c16qTgzx+W4ODDaJXJkpXp5DAyx9ydJ9CtCq1UQ/H6HEaN2IhMa3PViYpFeag/aAHWTu+pYbLkLJxZuxQ7rr4Cz4RfMh2c2/RSqRTfHriGzzXdMlB4G6N6/YB0W3WTJRegds+pWO09DLZlDmty4bN1OX456a9+suScTMz44wEG16IV6kifYOJn3yPeXN1kySJU6zgCK+ZPRFX9T5YsRXp8ArJEyqnXadVb3EsaGMGllhssNIz5FKJMxMSmF057XpoyWE0dqqOGgwWtUUeGzMQEZORJ1E//zm3yqm7usCo74Z97G9mIikyGQk2+v3IdTOxcUMPJWuXDKyaHIDkRaTki9VOvKxSoWrserI1ohTqKXESHJUCudh0UMLZ2QvWqdipBWEwBYVoiUrIKuO2uZh1kUjjXaQhbjXdeykdMaDykhoYq71W50yqn4q/u4gh+GRuCjdEYPQD+D/X7e9bPWwX9AAAAAElFTkSuQmCC"></p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Every time when a player is on turn, print the current board with hints, marked as ''o''</li><li>Use sprout method</li><li>Do not make changes to the legacy code, only add new</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Constants versus Enums', 3, '2019-03-28 11:08:09.851', 6, 0, 3, '<h2>Objective</h2><blockquote><em>Now that enums have been added to the language (Java 5), use them! Don’t keep using the old trick of public static final ints. The meaning of ints can get lost. The meaning of enums cannot, because they belong to an enumeration that is named. What’s more, study the syntax for enums carefully. They can have methods and fields. This makes them very powerful tools that allow much more expression and flexibility than ints.&nbsp;<br>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Use&nbsp;Player&nbsp;enum&nbsp;to represent the players'' values:</p><ul><li>Player.W&nbsp;for ''W'' instead of 0;</li><li>Player.B&nbsp;for ''B'' instead of 1;</li><li>Player.NONE&nbsp;for no player instead of -1.</li></ul><p>Use new enum for initialing the game and to print out the current state.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Use&nbsp;Player&nbsp;enum&nbsp;to represent the players'' values.</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('No Duplication', 3, '2019-03-28 11:08:09.851', 7, 1, 3, '<h2>Objective</h2><blockquote><em>Duplication is the primary enemy of a well-designed system. It represents additional work, additional risk, and additional unnecessary complexity. Duplication manifests itself in many forms. Lines of code that look exactly alike are, of course, duplication. Lines of code that are similar can often be massaged to look even more alike so that they can be more easily refactored.&nbsp;<br>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Make the code way more readable and maintainable with extracting the duplicate code into functions.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Extract function&nbsp;<em>isPieceInputCorrect&nbsp;</em>from functions&nbsp;<em>setPiece&nbsp;</em>and&nbsp;<em>execute</em></li><li>Extract function&nbsp;<em>isWithinPlayground&nbsp;</em>from functions&nbsp;<em>move&nbsp;</em>and&nbsp;<em>getPiecesToFlip.</em></li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Do One Thing', 3, '2019-03-28 11:08:09.851', 8, 2, 3, '<h2>Objective</h2><blockquote><em>Functions should do one thing. They should do it well. They should do it only.&nbsp;So, another way to know that a function is doing more than “one thing” is if you can extract another function from it with a name that is not merely a restatement of its implementation.&nbsp;</em><br><em>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>The legacy program contains numerous example of such a functions. Reversi constructor reads a configurations file and checks if the config file has the required lines number. This functinality should be extracted and called after the file reading. Function&nbsp;<em>initGame&nbsp;</em>does not initialize game only, but also sets a player on turn, creates and fills playground, and places the pieces on it. Function&nbsp;<em>run&nbsp;</em>contains execution of the read line, which should be extracted as well. Function&nbsp;<em>move&nbsp;</em>does multiple things as well: it ends the game, finds pieces to flip, and flips them. Function&nbsp;<em>areValidMoves&nbsp;</em>gets possible moves. It also finds pieces to flip as well as&nbsp;<em>move</em>&nbsp;function with the use of duplicate code.</p><p>Make the current code way more readable and maintainable with extracting the functions from the ones, which do multiple things.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Extract function <em>checkLength</em> from Reversi contructor</li><li>Extract functions <em>setSize</em>,&nbsp;<em>setOnTurn</em>,&nbsp;<em>createPlayground</em>,&nbsp;<em>fillPlayground&nbsp;</em>and&nbsp;<em>setPiece&nbsp;</em>from function&nbsp;<em>initGame</em></li><li>Extract function&nbsp;<em>execute&nbsp;</em>from function&nbsp;<em>run</em></li><li>Extract function&nbsp;<em>endGame</em>,&nbsp;<em>flipPieces</em>,&nbsp;<em>getPiecesToFlip&nbsp;</em>from function&nbsp;<em>move</em></li><li>Extract functions&nbsp;<em>getPiecesToFlip&nbsp;</em>from function&nbsp;<em>areValidMoves</em>.</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('One Level of Abstraction per Function', 3, '2019-03-28 11:08:09.851', 9, 3, 3, '<h2>Objective</h2><blockquote><em>Mixing levels of abstraction within a function is always confusing. Readers may not be able to tell whether a particular expression is an essential concept or a detail. Worse, like broken windows, once details are mixed with essential concepts, more and more details tend to accrete within the function.&nbsp;<br>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Functions setOnTurn and move do not hold the same abstraction level.</p><p>Make the current code way more readable and maintainable with extracting the functions, which hold lower abstraction levels, should be extracted.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Extract functions&nbsp;<em>isOnTurnInputCorrect</em>, from function&nbsp;<em>setOnTurn</em></li><li>Extract functions&nbsp;<em>isEmpty</em>,&nbsp;<em>isGameOver&nbsp;</em>and&nbsp;<em>swapPlayerOnTurn&nbsp;</em>from function&nbsp;<em>move</em>.</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Small!', 3, '2019-03-28 11:08:09.851', 10, 4, 3, '<h2>Objective</h2><blockquote><em>The first rule of functions is that they should be small. The second rule of functions is that they should be smaller than that.<br>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Most of the large code was refactored in previous steps because of extracting the function from large ones. But there are more ways to reduce function size without lost of readability.</p><p>Make the code functions a way more readable with changing the structure of variable <em>left</em>.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><h3><strong>User stories</strong></h3><ul><li>Use map <em>left </em>to store the values of variables <em>leftB </em>and <em>leftW</em>.</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Error Handling I', 3, '2019-03-28 11:08:09.851', 11, 5, 3, '<h2>Objective</h2><p>This exercise focuses on handling exceptions. Errors handling not only makes code robust, but also clean.</p><p>In the legacy code, when an error occurs, the message is printed out to console right where it was occurred. Errors should be thrown instead and handled on higher level, with the use of&nbsp;<em>try/catch/finally</em>&nbsp;block. Use custom <em>IncorrectGameConfigFileException</em> instead and add pass it a message, which is originally printed to the console when an error occurs.</p><p>Function <em>checkLength</em> throws an unspecific Exception, which tells nothing about the error, so should be avoided. Use a custom <em>IncorrectGameConfigFileException </em>instead<em>.</em></p><p>When error is caught at a high level of interaction with user, an error message is printed to console. Create a function <em>printIncorrectConfig</em> at PlaygroundPrinter to print this message.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Use custom exception <em>IncorrectGameConfigFileException</em> to handle errors when reading game configuration file</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Error Handling II', 3, '2019-03-28 11:08:09.851', 12, 6, 3, '<h2>Objective</h2><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">This exercise focuses on handling exceptions, as well as previous one.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">In the legacy code, when an error occurs, the message is printed out to console right where it was occurred. Errors should be thrown instead and handled on higher level, with the use of&nbsp;</span><em style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">try/catch/finally</em><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">&nbsp;block.</span></p><p>When error is caught at a high level of interaction with user, an error message is printed to console. Create a function <em>printNotPermittedMove</em> at PlaygroundPrinter to print this message.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><h3><strong>User stories</strong></h3><ul><li>Use custom exception <em>IncorrectGameConfigFileException </em><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">&nbsp;to handle errors on user input</span></li></ul>', False);

INSERT INTO bugs_number (exercise_id, number)
VALUES (2, 3);

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_source', 'Reversi.java', 2, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private int[] players = new int[] { 1, 0 };
    int onTurn = -1;
    int winner = -1;
    boolean ended = false;

    private BlackBoxSwitcher switcher = new BlackBoxSwitcher();

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            int configFileLinesNumber = 3;
            if (gameConfig.length != configFileLinesNumber) {
                throw new Exception("Game configuration must contain " + configFileLinesNumber + " lines");
            }
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[0])) {
                onTurn = 1;
            } else if ("W".equals(gameConfig[0])) {
                onTurn = 0;
            }
            playground = new int[8][8];
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c < 8; c++) {
                    playground[r][c] = -1;
                }
            }
            int[] piecesPositions = new int[] {1, 2};
            for (int piecePosition : piecesPositions) {
                String[] pieces = gameConfig[piecePosition].split(",");
                for (String piece : pieces) {
                    if (!piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    String[] coordinates = piece.trim().split(" ");
                    int r = Integer.parseInt(coordinates[0]);
                    int c = Integer.parseInt(coordinates[1]);
                    if (r >= 8 || c >= 8) {
                        return;
                    }
                    playground[r][c] = players[piecePosition - 1];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c <= 7; c++) {
                    if (playground[r][c] == 1) {
                        leftB++;
                    } else if (playground[r][c] == 0) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!line.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                String[] coordinates = line.trim().split(" ");
                int r = Integer.parseInt(coordinates[0]);
                int c = Integer.parseInt(coordinates[1]);
                move(r, c);
                printPiecesLeftCount();
                printPiecesLeftCount();
                if (! areValidMoves()) {
                    printPiecesLeftCount();
                    ended = true;
                    if (getLeftB() > getLeftW()) winner = 1;
                    else if (getLeftW() > getLeftB()) winner = 0;
                }
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (! switcher.BUGS[0]) {
            if (!(r >= 0 && c >= 0 && r <= 7 && c < 8)) {
                System.out.println("Move out of bounds is not permitted");
                return;
            }
        }
        if (! switcher.BUGS[1]) {
            if (playground[r][c] != -1) {
                System.out.println("Move on not empty piece is not permitted");
                return;
            }
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        List<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        int opposite = -1;
        if (onTurn == 0) opposite = 1;
        else if (onTurn == 1) opposite = 0;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (! switcher.BUGS[2]) {
                if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            }
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC < 8)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == -1) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == 0) onTurn = 1;
        else if (onTurn == 1) onTurn = 0;
    }

    boolean areValidMoves() {
        return !getPossibleMoves().isEmpty();
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                List<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                int opposite  = -1;
                if (onTurn == 0) opposite = 1;
                else if (onTurn == 1) opposite = 0;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC <= 7)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_source', 'PlaygroundPrinter.java', 2, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(int[][] playground) {
        printUpperEnumeration(8);
        for (int r = 0; r < 8; r++) {
            printLeftEnumeration(r, 8);
            for (int c = 0; c <= 7; c++) {
                if (playground[r][c] == -1) {
                    printPiece("_", 8);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", 8);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", 8);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printMoveOnTurn(int onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_source', 'GameConfig.java', 2, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 2, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }


}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', 'W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', 'W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', 'B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', 'B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', 'B
3 4, 4 3
3 3, 4 4
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', 'B
3 4, 4 3
3 3, 4 4
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', 'W
3 4, 4 3
3 3, 4 4
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', 'W
3 4, 4 3
3 3, 4 4
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', 'B
E 4, D 5
D 4, E 5
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', 'B
E 4, D 5
D 4, E 5
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '3 4, 4 3
3 3, 4 4
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '3 4, 4 3
3 3, 4 4
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', 'B
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', 'B
', 2, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 3, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private int[] players = new int[] { 1, 0 };
    int onTurn = -1;
    int winner = -1;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            int configFileLinesNumber = 3;
            if (gameConfig.length != configFileLinesNumber) {
                throw new Exception("Game configuration must contain " + configFileLinesNumber + " lines");
            }
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[0])) {
                onTurn = 1;
            } else if ("W".equals(gameConfig[0])) {
                onTurn = 0;
            }
            playground = new int[8][8];
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c < 8; c++) {
                    playground[r][c] = -1;
                }
            }
            int[] piecesPositions = new int[] {1, 2};
            for (int piecePosition : piecesPositions) {
                String[] pieces = gameConfig[piecePosition].split(",");
                for (String piece : pieces) {
                    if (!piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    String[] coordinates = piece.trim().split(" ");
                    int r = Integer.parseInt(coordinates[0]);
                    int c = Integer.parseInt(coordinates[1]);
                    if (r >= 8 || c >= 8) {
                        return;
                    }
                    playground[r][c] = players[piecePosition - 1];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c <= 7; c++) {
                    if (playground[r][c] == 1) {
                        leftB++;
                    } else if (playground[r][c] == 0) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!line.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                String[] coordinates = line.trim().split(" ");
                int r = Integer.parseInt(coordinates[0]);
                int c = Integer.parseInt(coordinates[1]);
                move(r, c);
                printPiecesLeftCount();
                if (! areValidMoves()) {
                    printPiecesLeftCount();
                    ended = true;
                    if (getLeftB() > getLeftW()) winner = 1;
                    else if (getLeftW() > getLeftB()) winner = 0;
                }
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        List<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        int opposite = -1;
        if (onTurn == 0) opposite = 1;
        else if (onTurn == 1) opposite = 0;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC < 8)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == -1) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == 0) onTurn = 1;
        else if (onTurn == 1) onTurn = 0;
    }

    boolean areValidMoves() {
        return !getPossibleMoves().isEmpty();
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                List<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                int opposite  = -1;
                if (onTurn == 0) opposite = 1;
                else if (onTurn == 1) opposite = 0;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC <= 7)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 3, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(int[][] playground) {
        printUpperEnumeration(8);
        for (int r = 0; r < 8; r++) {
            printLeftEnumeration(r, 8);
            for (int c = 0; c <= 7; c++) {
                if (playground[r][c] == -1) {
                    printPiece("_", 8);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", 8);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", 8);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printMoveOnTurn(int onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 3, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 3, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 3, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "B", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "3 4, 4 3", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 3, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "W", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "3 4, 4 3", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigFourLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFourLines);

        assertEquals("Lines number of gameFourLines config file", 4, gameConfig.length);
        assertEquals("1st line of gameFourLines config file", "B", gameConfig[0]);
        assertEquals("2nd line of gameFourLines config file", "3 4, 4 3", gameConfig[1]);
        assertEquals("3rd line of gameFourLines config file", "3 3, 4 4", gameConfig[2]);
        assertEquals("4th line of gameFourLines config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 3, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "B", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "E 4, D 5", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "D 4, E 5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(2, gameConfig.length);
        assertEquals("3 4, 4 3", gameConfig[0]);
        assertEquals("3 3, 4 4", gameConfig[1]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(1, gameConfig.length);
        assertEquals("B", gameConfig[0]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 3, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 1, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 0, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        Assert.assertArrayEquals(null, game.playground);
    }

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", 0, game.onTurn);
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testFourLines() {
        Reversi game = new Reversi(GameConfig.gameFourLines);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 3, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printMoveOnTurn

    @Test
    public void testPrintMoveOnTurn8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. 1 is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintMoveOnTurn8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. 0 is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printPiecesNumber

    @Test
    public void testPrintPiecesNumber8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPiecesNumber(game.getLeftB(), game.getLeftW());
        String expected = "Number of pieces: B: 2; W: 2" + System.lineSeparator() + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 3, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", 1, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", 1, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", 0, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", 0, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 3, 'import java.util.List;


class TestUtils {

    static int getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static int[][] getEmptyPlayground() {
        int[][] empty = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = -1;
            }
        }
        return empty;
    }

    static int[][] getInitPlayground() {
        int[][] init = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = -1;
            }
        }
        init[3][3] = 0;
        init[4][4] = 0;
        init[3][4] = 1;
        init[4][3] = 1;
        return init;
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 3, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }


}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', 'W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', 'W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', 'B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', 'B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', 'B
3 4, 4 3
3 3, 4 4
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', 'B
3 4, 4 3
3 3, 4 4
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', 'W
3 4, 4 3
3 3, 4 4
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', 'W
3 4, 4 3
3 3, 4 4
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', 'B
E 4, D 5
D 4, E 5
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', 'B
E 4, D 5
D 4, E 5
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '3 4, 4 3
3 3, 4 4
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '3 4, 4 3
3 3, 4 4
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', 'B
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', 'B
', 3, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 4, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private int[] players = new int[] { 1, 0 };
    int onTurn = -1;
    int winner = -1;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            int configFileLinesNumber = 3;
            if (gameConfig.length != configFileLinesNumber) {
                throw new Exception("Game configuration must contain " + configFileLinesNumber + " lines");
            }
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[0])) {
                onTurn = 1;
            } else if ("W".equals(gameConfig[0])) {
                onTurn = 0;
            }
            playground = new int[8][8];
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c < 8; c++) {
                    playground[r][c] = -1;
                }
            }
            int[] piecesPositions = new int[] {1, 2};
            for (int piecePosition : piecesPositions) {
                String[] pieces = gameConfig[piecePosition].split(",");
                for (String piece : pieces) {
                    if (!piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    String[] coordinates = piece.trim().split(" ");
                    int r = Integer.parseInt(coordinates[0]);
                    int c = Integer.parseInt(coordinates[1]);
                    if (r >= 8 || c >= 8) {
                        return;
                    }
                    playground[r][c] = players[piecePosition - 1];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c <= 7; c++) {
                    if (playground[r][c] == 1) {
                        leftB++;
                    } else if (playground[r][c] == 0) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!line.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                String[] coordinates = line.trim().split(" ");
                int r = Integer.parseInt(coordinates[0]);
                int c = Integer.parseInt(coordinates[1]);
                move(r, c);
                printPiecesLeftCount();
                if (! areValidMoves()) {
                    printPiecesLeftCount();
                    ended = true;
                    if (getLeftB() > getLeftW()) winner = 1;
                    else if (getLeftW() > getLeftB()) winner = 0;
                }
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!(r >= 0 && c >= 0 && r <= 7 && c < 8)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != -1) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        List<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        int opposite = -1;
        if (onTurn == 0) opposite = 1;
        else if (onTurn == 1) opposite = 0;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC < 8)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == -1) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == 0) onTurn = 1;
        else if (onTurn == 1) onTurn = 0;
    }

    boolean areValidMoves() {
        return !getPossibleMoves().isEmpty();
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                List<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                int opposite  = -1;
                if (onTurn == 0) opposite = 1;
                else if (onTurn == 1) opposite = 0;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC <= 7)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 4, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(int[][] playground) {
        printUpperEnumeration(8);
        for (int r = 0; r < 8; r++) {
            printLeftEnumeration(r, 8);
            for (int c = 0; c <= 7; c++) {
                if (playground[r][c] == -1) {
                    printPiece("_", 8);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", 8);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", 8);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printMoveOnTurn(int onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 4, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";;
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 4, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }


    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 4, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;

public class InitGameTest {

    private Reversi rev = new Reversi();


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", 1, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", 0, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", 1, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoSize() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    
    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", 0, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 4, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printMoveOnTurn

    @Test
    public void testPrintMoveOnTurn8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. 1 is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintMoveOnTurn8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. 0 is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printPiecesNumber

    @Test
    public void testPrintPiecesNumber8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPiecesNumber(game.getLeftB(), game.getLeftW());
        String expected = "Number of pieces: B: 2; W: 2" + System.lineSeparator() + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 4, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;

public class MoveTest {

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", 1, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", 1, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", 0, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", 0, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 4, 'import java.util.List;


class TestUtils {

    static int getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static int[][] getEmptyPlayground() {
        int[][] empty = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = -1;
            }
        }
        return empty;
    }

    static int[][] getInitPlayground() {
        int[][] init = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = -1;
            }
        }
        init[3][3] = 0;
        init[4][4] = 0;
        init[3][4] = 1;
        init[4][3] = 1;
        return init;
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 4, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }


}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 4, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 5, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    int[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private int[] players = new int[] { 1, 0 };
    int onTurn = -1;
    int winner = -1;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            int configFileLinesNumber = 4;
            if (gameConfig.length != configFileLinesNumber) {
                throw new Exception("Game configuration must contain " + configFileLinesNumber + " lines");
            }
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        try {
            if (!gameConfig[0].matches("[0-9]+")) {
                System.out.println("Incorrect size input");
                return;
            }
            size = Integer.parseInt(gameConfig[0]);
            if (gameConfig[1] == null || !gameConfig[1].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[1])) {
                onTurn = 1;
            } else if ("W".equals(gameConfig[1])) {
                onTurn = 0;
            }
            playground = new int[size][size];
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    playground[r][c] = -1;
                }
            }
            int[] piecesPositions = new int[] {2, 3};
            for (int piecePosition : piecesPositions) {
                String[] pieces = gameConfig[piecePosition].split(",");
                for (String piece : pieces) {
                    if (!piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    String[] coordinates = piece.trim().split(" ");
                    int r = Integer.parseInt(coordinates[0]);
                    int c = Integer.parseInt(coordinates[1]);
                    if (r >= size || c >= size) {
                        return;
                    }
                    playground[r][c] = players[piecePosition - 2];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == 1) {
                        leftB++;
                    } else if (playground[r][c] == 0) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground, size);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!line.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                String[] coordinates = line.trim().split(" ");
                int r = Integer.parseInt(coordinates[0]);
                int c = Integer.parseInt(coordinates[1]);
                move(r, c);
                printPiecesLeftCount();
                if (! areValidMoves()) {
                    printPiecesLeftCount();
                    ended = true;
                    if (getLeftB() > getLeftW()) winner = 1;
                    else if (getLeftW() > getLeftB()) winner = 0;
                }
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!(r >= 0 && c >= 0 && r < size && c < size)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != -1) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        int opposite = -1;
        if (onTurn == 0) opposite = 1;
        else if (onTurn == 1) opposite = 0;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == -1) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == 0) onTurn = 1;
        else if (onTurn == 1) onTurn = 0;
    }

    boolean areValidMoves() {
        return !getPossibleMoves().isEmpty();
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != -1) continue;
                List<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                int opposite  = -1;
                if (onTurn == 0) opposite = 1;
                else if (onTurn == 1) opposite = 0;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 5, 'import java.util.Collections;
import java.util.List;

class PlaygroundPrinter {

    static void printPlayground(int[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == -1) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printMoveOnTurn(int onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 5, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";;
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 5, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }


    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 5, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", 1, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", 0, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", 1, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoSize() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    
    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", 0, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertTrue(game.ended);
        assertEquals(-1, game.winner);
    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 5, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // hints

    @Test
    public void testPrintHints8bInit() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ _ B W o _ _ " + System.lineSeparator() +
                "5 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8wInit() {
        Reversi reversi = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ o B W _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints10bInit() {
        Reversi reversi = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "4 _ _ _ o W B _ _ _ _ " + System.lineSeparator() +
                "5 _ _ _ _ B W o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bAlmostComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B W B B W W B B " + System.lineSeparator() +
                "1 W W B W B W W W " + System.lineSeparator() +
                "2 B W B W B B W B " + System.lineSeparator() +
                "3 W W B B o W W B " + System.lineSeparator() +
                "4 B B B W B B B B " + System.lineSeparator() +
                "5 W W B W W W W W " + System.lineSeparator() +
                "6 B B B W B B W B " + System.lineSeparator() +
                "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B B B B B B B B " + System.lineSeparator() +
                "1 B W W W W W W B " + System.lineSeparator() +
                "2 B W W B W B W B " + System.lineSeparator() +
                "3 B B W W B W B B " + System.lineSeparator() +
                "4 B B B W B B W B " + System.lineSeparator() +
                "5 B B W W B W W B " + System.lineSeparator() +
                "6 B B B B B B W B " + System.lineSeparator() +
                "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHintsExecuteB54() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.move(5, 4);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ _ B B _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o B o _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }

    @Test
    public void testPrintHintsExecuteB54W53() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.move(5, 4);
        reversi.move(5, 3);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ o W B _ _ _ " + System.lineSeparator() +
                "5 _ _ o W B _ _ _ " + System.lineSeparator() +
                "6 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }


    // printMoveOnTurn

    @Test
    public void testPrintMoveOnTurn8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. 1 is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintMoveOnTurn8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. 0 is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printPiecesNumber

    @Test
    public void testPrintPiecesNumber8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPiecesNumber(game.getLeftB(), game.getLeftW());
        String expected = "Number of pieces: B: 2; W: 2" + System.lineSeparator() + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 5, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", 1, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", 1, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", 0, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", 0, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 5, 'import java.util.List;


class TestUtils {

    static int getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static int[][] getEmptyPlayground() {
        int[][] empty = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = -1;
            }
        }
        return empty;
    }

    static int[][] getInitPlayground() {
        int[][] init = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = -1;
            }
        }
        init[3][3] = 0;
        init[4][4] = 0;
        init[3][4] = 1;
        init[4][3] = 1;
        return init;
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 5, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }


}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 5, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 6, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    int[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private int[] players = new int[] { 1, 0 };
    int onTurn = -1;
    int winner = -1;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            int configFileLinesNumber = 4;
            if (gameConfig.length != configFileLinesNumber) {
                throw new Exception("Game configuration must contain " + configFileLinesNumber + " lines");
            }
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        try {
            if (!gameConfig[0].matches("[0-9]+")) {
                System.out.println("Incorrect size input");
                return;
            }
            size = Integer.parseInt(gameConfig[0]);
            if (gameConfig[1] == null || !gameConfig[1].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[1])) {
                onTurn = 1;
            } else if ("W".equals(gameConfig[1])) {
                onTurn = 0;
            }
            playground = new int[size][size];
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    playground[r][c] = -1;
                }
            }
            int[] piecesPositions = new int[] {2, 3};
            for (int piecePosition : piecesPositions) {
                String[] pieces = gameConfig[piecePosition].split(",");
                for (String piece : pieces) {
                    if (!piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    String[] coordinates = piece.trim().split(" ");
                    int r = Integer.parseInt(coordinates[0]);
                    int c = Integer.parseInt(coordinates[1]);
                    if (r >= size || c >= size) {
                        return;
                    }
                    playground[r][c] = players[piecePosition - 2];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == 1) {
                        leftB++;
                    } else if (playground[r][c] == 0) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printHints(playground, size, getPossibleMoves());
                PlaygroundPrinter.printPlayground(playground, size);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!line.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                String[] coordinates = line.trim().split(" ");
                int r = Integer.parseInt(coordinates[0]);
                int c = Integer.parseInt(coordinates[1]);
                move(r, c);
                printPiecesLeftCount();
                if (! areValidMoves()) {
                    printPiecesLeftCount();
                    ended = true;
                    if (getLeftB() > getLeftW()) winner = 1;
                    else if (getLeftW() > getLeftB()) winner = 0;
                }
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!(r >= 0 && c >= 0 && r < size && c < size)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != -1) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        List<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        int opposite = -1;
        if (onTurn == 0) opposite = 1;
        else if (onTurn == 1) opposite = 0;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == -1) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == 0) onTurn = 1;
        else if (onTurn == 1) onTurn = 0;
    }

    boolean areValidMoves() {
        return !getPossibleMoves().isEmpty();
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != -1) continue;
                List<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                int opposite  = -1;
                if (onTurn == 0) opposite = 1;
                else if (onTurn == 1) opposite = 0;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 6, 'import java.util.Collections;
import java.util.List;

class PlaygroundPrinter {

    static void printPlayground(int[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == -1) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printHints(int[][] playground, int size, List<String> possibleMoves) {
        System.out.println("Possible moves:");
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (possibleMoves.contains(String.format("%d %d", r, c))) {
                    System.out.print("o ");
                } else if (playground[r][c] == -1) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    static void printMoveOnTurn(int onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 6, 'public enum Player {
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 6, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";;
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 6, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 6, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }


    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 6, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoSize() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 6, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                        " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // hints

    @Test
    public void testPrintHints8bInit() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ _ B W o _ _ " + System.lineSeparator() +
                "5 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8wInit() {
        Reversi reversi = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ o B W _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints10bInit() {
        Reversi reversi = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "4 _ _ _ o W B _ _ _ _ " + System.lineSeparator() +
                "5 _ _ _ _ B W o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bAlmostComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B W B B W W B B " + System.lineSeparator() +
                "1 W W B W B W W W " + System.lineSeparator() +
                "2 B W B W B B W B " + System.lineSeparator() +
                "3 W W B B o W W B " + System.lineSeparator() +
                "4 B B B W B B B B " + System.lineSeparator() +
                "5 W W B W W W W W " + System.lineSeparator() +
                "6 B B B W B B W B " + System.lineSeparator() +
                "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B B B B B B B B " + System.lineSeparator() +
                "1 B W W W W W W B " + System.lineSeparator() +
                "2 B W W B W B W B " + System.lineSeparator() +
                "3 B B W W B W B B " + System.lineSeparator() +
                "4 B B B W B B W B " + System.lineSeparator() +
                "5 B B W W B W W B " + System.lineSeparator() +
                "6 B B B B B B W B " + System.lineSeparator() +
                "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHintsExecuteB54() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.move(5, 4);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ _ B B _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o B o _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }

    @Test
    public void testPrintHintsExecuteB54W53() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.move(5, 4);
        reversi.move(5, 3);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ o W B _ _ _ " + System.lineSeparator() +
                "5 _ _ o W B _ _ _ " + System.lineSeparator() +
                "6 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }


    // printMoveOnTurn

    @Test
    public void testPrintMoveOnTurn8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. B is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintMoveOnTurn8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. W is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printPiecesNumber

    @Test
    public void testPrintPiecesNumber8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPiecesNumber(game.getLeftB(), game.getLeftW());
        String expected = "Number of pieces: B: 2; W: 2" + System.lineSeparator() + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 6, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 6, 'import java.util.List;


public class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
        Player[][] init = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = Player.NONE;
            }
        }
        init[3][3] = Player.W;
        init[4][4] = Player.W;
        init[3][4] = Player.B;
        init[4][3] = Player.B;
        return init;
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 6, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }


}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 6, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 7, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            int configFileLinesNumber = 4;
            if (gameConfig.length != configFileLinesNumber) {
                throw new Exception("Game configuration must contain " + configFileLinesNumber + " lines");
            }
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig){
        try {
            if (!gameConfig[0].matches("[0-9]+")) {
                System.out.println("Incorrect size input");
                return;
            }
            size = Integer.parseInt(gameConfig[0]);
            if (gameConfig[1] == null || !gameConfig[1].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[1])) {
                onTurn = Player.B;
            } else if ("W".equals(gameConfig[1])) {
                onTurn = Player.W;
            }
            playground = new Player[size][size];
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    playground[r][c] = Player.NONE;
                }
            }
            int[] piecesPositions = new int[] {2, 3};
            for (int piecePosition : piecesPositions) {
                String[] pieces = gameConfig[piecePosition].split(",");
                for (String piece : pieces) {
                    if (!piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    String[] coordinates = piece.trim().split(" ");
                    int r = Integer.parseInt(coordinates[0]);
                    int c = Integer.parseInt(coordinates[1]);
                    if (r >= size || c >= size) {
                        return;
                    }
                    playground[r][c] = players[piecePosition - 2];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        leftB++;
                    } else if (playground[r][c] == Player.W) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printHints(playground, size, getPossibleMoves());
                PlaygroundPrinter.printPlayground(playground, size);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                if (!line.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                String[] coordinates = line.trim().split(" ");
                int r = Integer.parseInt(coordinates[0]);
                int c = Integer.parseInt(coordinates[1]);
                move(r, c);
                printPiecesLeftCount();
                if (! areValidMoves()) {
                    printPiecesLeftCount();
                    ended = true;
                    if (getLeftB() > getLeftW()) winner = Player.B;
                    else if (getLeftW() > getLeftB()) winner = Player.W;
                }
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!(r >= 0 && c >= 0 && r < size && c < size)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != Player.NONE) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (winner != Player.NONE) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        List<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        Player opposite = Player.NONE;
        if (onTurn == Player.W) opposite = Player.B;
        else if (onTurn == Player.B) opposite = Player.W;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = Player.NONE;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == Player.NONE) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == Player.B) leftB++;
                else if (onTurn == Player.W) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == Player.B) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    boolean areValidMoves() {
        return !getPossibleMoves().isEmpty();
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                List<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                Player opposite  = Player.NONE;
                if (onTurn == Player.W) opposite = Player.B;
                else if (onTurn == Player.B) opposite = Player.W;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = Player.NONE;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 7, 'import java.util.Collections;
import java.util.List;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printHints(Player[][] playground, int size, List<String> possibleMoves) {
        System.out.println("Possible moves:");
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (possibleMoves.contains(String.format("%d %d", r, c))) {
                    System.out.print("o ");
                } else if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    static void printMoveOnTurn(Player onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 7, 'public enum Player {
    B(1), W(0), NONE(-1);

    private final int value;

    Player(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 7, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";;
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 7, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 7, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }


    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 7, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertFalse;

public class InitGameTest {

    private Reversi rev = new Reversi();


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }
    

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }

    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 7, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // hints

    @Test
    public void testPrintHints8bInit() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ _ B W o _ _ " + System.lineSeparator() +
                "5 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8wInit() {
        Reversi reversi = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ o B W _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints10bInit() {
        Reversi reversi = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "4 _ _ _ o W B _ _ _ _ " + System.lineSeparator() +
                "5 _ _ _ _ B W o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bAlmostComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B W B B W W B B " + System.lineSeparator() +
                "1 W W B W B W W W " + System.lineSeparator() +
                "2 B W B W B B W B " + System.lineSeparator() +
                "3 W W B B o W W B " + System.lineSeparator() +
                "4 B B B W B B B B " + System.lineSeparator() +
                "5 W W B W W W W W " + System.lineSeparator() +
                "6 B B B W B B W B " + System.lineSeparator() +
                "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B B B B B B B B " + System.lineSeparator() +
                "1 B W W W W W W B " + System.lineSeparator() +
                "2 B W W B W B W B " + System.lineSeparator() +
                "3 B B W W B W B B " + System.lineSeparator() +
                "4 B B B W B B W B " + System.lineSeparator() +
                "5 B B W W B W W B " + System.lineSeparator() +
                "6 B B B B B B W B " + System.lineSeparator() +
                "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHintsExecuteB54() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.move(5, 4);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ _ B B _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o B o _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }

    @Test
    public void testPrintHintsExecuteB54W53() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.move(5, 4);
        reversi.move(5, 3);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ o W B _ _ _ " + System.lineSeparator() +
                "5 _ _ o W B _ _ _ " + System.lineSeparator() +
                "6 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }


    // printMoveOnTurn

    @Test
    public void testPrintMoveOnTurn8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. B is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintMoveOnTurn8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. W is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printPiecesNumber

    @Test
    public void testPrintPiecesNumber8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPiecesNumber(game.getLeftB(), game.getLeftW());
        String expected = "Number of pieces: B: 2; W: 2" + System.lineSeparator() + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 7, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 7, 'import java.util.List;


class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
        Player[][] init = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = Player.NONE;
            }
        }
        init[3][3] = Player.W;
        init[4][4] = Player.W;
        init[3][4] = Player.B;
        init[4][3] = Player.B;
        return init;
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 7, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }


}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 7, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 8, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            int configFileLinesNumber = 4;
            if (gameConfig.length != configFileLinesNumber) {
                throw new Exception("Game configuration must contain " + configFileLinesNumber + " lines");
            }
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        try {
            if (!gameConfig[0].matches("[0-9]+")) {
                System.out.println("Incorrect size input");
                return;
            }
            size = Integer.parseInt(gameConfig[0]);
            if (gameConfig[1] == null || !gameConfig[1].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[1])) {
                onTurn = Player.B;
            } else if ("W".equals(gameConfig[1])) {
                onTurn = Player.W;
            }
            playground = new Player[size][size];
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    playground[r][c] = Player.NONE;
                }
            }
            int[] piecesPositions = new int[] {2, 3};
            for (int piecePosition : piecesPositions) {
                String[] pieces = gameConfig[piecePosition].split(",");
                for (String piece : pieces) {
                    if (!isPieceInputCorrect(piece)) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    int[] coordinates = getCoordinates(piece);
                    int r = coordinates[0];
                    int c = coordinates[1];
                    if (r >= size || c >= size) {
                        return;
                    }
                    playground[r][c] = players[piecePosition - 2];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    boolean isPieceInputCorrect(String piece) {
        return piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String piece) {
        String[] coordinates = piece.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        leftB++;
                    } else if (playground[r][c] == Player.W) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printHints(playground, size, getPossibleMoves());
                PlaygroundPrinter.printPlayground(playground, size);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                if (!isPieceInputCorrect(line)) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                int[] coordinates = getCoordinates(line);
                move(coordinates[0], coordinates[1]);
                printPiecesLeftCount();
                if (! areValidMoves()) {
                    printPiecesLeftCount();
                    ended = true;
                    if (getLeftB() > getLeftW()) winner = Player.B;
                    else if (getLeftW() > getLeftB()) winner = Player.W;
                }
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != Player.NONE) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (winner != Player.NONE) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        List<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        Player opposite = Player.NONE;
        if (onTurn == Player.W) opposite = Player.B;
        else if (onTurn == Player.B) opposite = Player.W;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (isWithinPlayground(dirR, dirC) && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!isWithinPlayground(dirR, dirC)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!isWithinPlayground(dirR, dirC)) break;
            }
            if (!isWithinPlayground(dirR, dirC)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = Player.NONE;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == Player.NONE) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == Player.B) leftB++;
                else if (onTurn == Player.W) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == Player.B) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    boolean areValidMoves() {
        return !getPossibleMoves().isEmpty();
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                List<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                Player opposite  = Player.NONE;
                if (onTurn == Player.W) opposite = Player.B;
                else if (onTurn == Player.B) opposite = Player.W;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (isWithinPlayground(dirR, dirC) && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!isWithinPlayground(dirR, dirC)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!isWithinPlayground(dirR, dirC)) break;
                    }
                    if (!isWithinPlayground(dirR, dirC)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = Player.NONE;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 8, 'import java.util.Collections;
import java.util.List;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printHints(Player[][] playground, int size, List<String> possibleMoves) {
        System.out.println("Possible moves:");
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (possibleMoves.contains(String.format("%d %d", r, c))) {
                    System.out.print("o ");
                } else if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    static void printMoveOnTurn(Player onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 8, 'public enum Player {
    B(1), W(0), NONE(-1);

    private final int value;

    Player(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 8, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";;
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 8, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 8, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    // checkGameConfig

    @Test
    public void testCheckGameConfig8bInit() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigEmpty() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigFiveLines() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoSize() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoOnTurn() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }


    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 8, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertArrayEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();

    
    //setSize

    @Test
    public void testSetSize8() {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() {
        Reversi game = rev;
        game.setSize("-8");

        assertEquals("set size -8", 0, game.size);
    }

    @Test
    public void testSetSizeA() {
        Reversi game = rev;
        game.setSize("A");

        assertEquals("set size A", 0, game.size);
    }


    // setOnTurn

    @Test
    public void testSetOnTurnB() {
        Reversi game = rev;
        game.setOnTurn("B");

        assertEquals("set player on turn: B", Player.B, game.onTurn);
    }

    @Test
    public void testSetOnTurnW() {
        Reversi game = rev;
        game.setOnTurn("W");

        assertEquals("set player on turn: W", Player.W, game.onTurn);
    }

    @Test
    public void testSetOnTurnA() {
        Reversi game = rev;
        game.setOnTurn("A");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnNone() {
        Reversi game = rev;
        game.setOnTurn("NONE");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnnull() {
        Reversi game = rev;
        game.setOnTurn(null);

        assertEquals(Player.NONE, game.onTurn);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D 3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, TestUtils.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 0}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece08() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 8}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece88() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 8}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[]{"one"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 8, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // hints

    @Test
    public void testPrintHints8bInit() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ _ B W o _ _ " + System.lineSeparator() +
                "5 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8wInit() {
        Reversi reversi = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ o B W _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints10bInit() {
        Reversi reversi = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "4 _ _ _ o W B _ _ _ _ " + System.lineSeparator() +
                "5 _ _ _ _ B W o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bAlmostComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B W B B W W B B " + System.lineSeparator() +
                "1 W W B W B W W W " + System.lineSeparator() +
                "2 B W B W B B W B " + System.lineSeparator() +
                "3 W W B B o W W B " + System.lineSeparator() +
                "4 B B B W B B B B " + System.lineSeparator() +
                "5 W W B W W W W W " + System.lineSeparator() +
                "6 B B B W B B W B " + System.lineSeparator() +
                "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B B B B B B B B " + System.lineSeparator() +
                "1 B W W W W W W B " + System.lineSeparator() +
                "2 B W W B W B W B " + System.lineSeparator() +
                "3 B B W W B W B B " + System.lineSeparator() +
                "4 B B B W B B W B " + System.lineSeparator() +
                "5 B B W W B W W B " + System.lineSeparator() +
                "6 B B B B B B W B " + System.lineSeparator() +
                "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHintsExecuteB54() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ _ B B _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o B o _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }

    @Test
    public void testPrintHintsExecuteB54W53() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        reversi.execute("5 3");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ o W B _ _ _ " + System.lineSeparator() +
                "5 _ _ o W B _ _ _ " + System.lineSeparator() +
                "6 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }


    // printMoveOnTurn

    @Test
    public void testPrintMoveOnTurn8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. B is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintMoveOnTurn8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. W is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printPiecesNumber

    @Test
    public void testPrintPiecesNumber8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPiecesNumber(game.getLeftB(), game.getLeftW());
        String expected = "Number of pieces: B: 2; W: 2" + System.lineSeparator() + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 8, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;

public class MoveTest {


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(3, 2);
        List<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("pieces to flip on onit - (3, 2)", 2, pieces.size());
        assertEquals(expected.get(0).get(0), pieces.get(0).get(0));
        assertEquals(expected.get(0).get(1), pieces.get(0).get(1));
        assertEquals(expected.get(1).get(0), pieces.get(1).get(0));
        assertEquals(expected.get(1).get(1), pieces.get(1).get(1));
    }

    @Test
    public void testGetPiecesToFlipInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals("...", Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals("...", Player.B, TestUtils.getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }

    // endGame

    @Test
    public void testEndGame() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        assertTrue(game.ended);
        assertEquals(Player.B, game.winner);
    }
    
    
    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ExecuteTest.java', 8, 'import org.junit.Assert;
import org.junit.Test;

public class ExecuteTest {

    @Test
    public void testExecute() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 8, 'import java.util.List;


class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
        Player[][] init = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = Player.NONE;
            }
        }
        init[3][3] = Player.W;
        init[4][4] = Player.W;
        init[3][4] = Player.B;
        init[4][3] = Player.B;
        return init;
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 8, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }


}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 8, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 9, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            checkLength(gameConfig);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void checkLength(String[] gameConfig) throws Exception {
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            throw new Exception("Game configuration must contain " + configFileLinesNumber + " lines");
        }
    }

    void initGame(String[] gameConfig) {
        setSize(gameConfig[0]);
        setOnTurn(gameConfig[1]);
        createPlayground();
        fillPlayground(gameConfig);
    }

    void setSize(String size) {
        if (!size.matches("[0-9]+")) {
            System.out.println("Incorrect size input");
            return;
        }
        this.size = Integer.parseInt(size);
    }

    void setOnTurn(String onTurn) {
        if (onTurn == null || !onTurn.matches("[B|W]")) {
            System.out.println("Incorrect player on turn input");
            return;
        }
        if ("B".equals(onTurn)) {
            this.onTurn = Player.B;
        } else if ("W".equals(onTurn)) {
            this.onTurn = Player.W;
        }
    }

    private void createPlayground() {
        playground = new Player[size][size];
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) {
        try {
            int[] piecesPositions = new int[] {2, 3};
            for (int piecePosition : piecesPositions) {
                String[] pieces = gameConfig[piecePosition].split(",");
                for (String piece : pieces) {
                    if (!isPieceInputCorrect(piece)) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    int[] coordinates = getCoordinates(piece);
                    setPiece(coordinates, players[piecePosition - 2]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect");
        }
    }

    boolean isPieceInputCorrect(String piece) {
        return piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String piece) {
        String[] coordinates = piece.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void setPiece(int[] coordinates, Player player) {
        int r = coordinates[0];
        int c = coordinates[1];
        if (r >= size || c >= size) {
            return;
        }
        playground[r][c] = player;
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        leftB++;
                    } else if (playground[r][c] == Player.W) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printHints(playground, size, getPossibleMoves());
                PlaygroundPrinter.printPlayground(playground, size);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    void execute(String line) {
        if (!isPieceInputCorrect(line)) {
            System.out.println("Incorrect piece input");
            return;
        }
        int[] coordinates = getCoordinates(line);
        move(coordinates[0], coordinates[1]);
        if (! areValidMoves()) {
            endGame();
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != Player.NONE) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (winner != Player.NONE) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        List<List<Integer>> piecesToFlip = getPiecesToFlip(r, c);
        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        flipPieces(piecesToFlip);

        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    List<List<Integer>> getPiecesToFlip(int r0, int c0) {
        List<List<Integer>> toFlip = new ArrayList<>();
        playground[r0][c0] = onTurn;
        Player opposite = Player.NONE;
        if (onTurn == Player.W) opposite = Player.B;
        else if (onTurn == Player.B) opposite = Player.W;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int r = r0;
            int c = c0;
            r += direction[0];
            c += direction[1];
            if (isWithinPlayground(r, c) && playground[r][c] != opposite) continue;
            r += direction[0];
            c += direction[1];
            if (!isWithinPlayground(r, c)) continue;
            while (playground[r][c] == opposite) {
                r += direction[0];
                c += direction[1];
                if (!isWithinPlayground(r, c)) break;
            }
            if (!isWithinPlayground(r, c)) continue;
            if (playground[r][c] != onTurn) continue;
            while (true) {
                r -= direction[0];
                c -= direction[1];
                if (r == r0 && c == c0) break;
                toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (!toFlip.isEmpty()) {
            toFlip.add(new ArrayList<>(Arrays.asList(r0, c0)));
        }
        return toFlip;
    }

    void flipPieces(List<List<Integer>> pieces) {
        for (List<Integer> piece : pieces) {
            int r = piece.get(0);
            int c = piece.get(1);
            if (playground[r][c] == onTurn) break;
            if (playground[r][c] == Player.NONE) {
                playground[r][c] = onTurn;
                if (onTurn == Player.B) leftB++;
                else if (onTurn == Player.W) leftW++;
            } else {
                playground[r][c] = onTurn;
                if (onTurn == Player.B) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }
    }

    boolean areValidMoves() {
        return !getPossibleMoves().isEmpty();
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getPiecesToFlip(r, c).isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    void endGame() {
        printPiecesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 9, 'import java.util.Collections;
import java.util.List;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printHints(Player[][] playground, int size, List<String> possibleMoves) {
        System.out.println("Possible moves:");
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (possibleMoves.contains(String.format("%d %d", r, c))) {
                    System.out.print("o ");
                } else if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    static void printMoveOnTurn(Player onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 9, 'public enum Player {
    B(1), W(0), NONE(-1);

    private final int value;

    Player(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 9, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";;
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 9, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 9, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    // checkGameConfig

    @Test
    public void testCheckGameConfig8bInit() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigEmpty() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigFiveLines() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoSize() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoOnTurn() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }


    // readGameConfig

    @Test
    public void testCheckGameConfigNoPieces() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 9, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();

    //setSize

    @Test
    public void testSetSize8() {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() {
        Reversi game = rev;
        game.setSize("-8");

        assertEquals("set size -8", 0, game.size);
    }

    @Test
    public void testSetSizeA() {
        Reversi game = rev;
        game.setSize("A");

        assertEquals("set size A", 0, game.size);
    }

    // setOnTurnInputCorrect

    @Test
    public void testIsOnTurnInputCorrectB() {
        Reversi game = rev;

        assertTrue("on turn value of config file: B", game.isOnTurnInputCorrect("B"));
    }

    @Test
    public void testIsOnTurnInputCorrectW() {
        Reversi game = rev;

        assertTrue("on turn value of config file: W", game.isOnTurnInputCorrect("W"));
    }

    @Test
    public void testIsOnTurnInputCorrectA() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("A"));
    }

    @Test
    public void testIsOnTurnInputCorrectNONE() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("NONE"));
    }

    @Test
    public void testIsOnTurnInputCorrectnull() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect(null));
    }


    // setOnTurn

    @Test
    public void testSetOnTurnB() {
        Reversi game = rev;
        game.setOnTurn("B");

        assertEquals("set player on turn: B", Player.B, game.onTurn);
    }

    @Test
    public void testSetOnTurnW() {
        Reversi game = rev;
        game.setOnTurn("W");

        assertEquals("set player on turn: W", Player.W, game.onTurn);
    }

    @Test
    public void testSetOnTurnA() {
        Reversi game = rev;
        game.setOnTurn("A");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnNone() {
        Reversi game = rev;
        game.setOnTurn("NONE");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnnull() {
        Reversi game = rev;
        game.setOnTurn(null);

        assertEquals(Player.NONE, game.onTurn);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D 3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[] {0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, TestUtils.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[] {8, 0}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece08() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[] {0, 8}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece88() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[] {8, 8}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[]{"one"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 8, game.size);
        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 8, game.size);
        assertEquals("init playground on initial game config", Player.W, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 10, game.size);
        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }


    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 9, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // hints

    @Test
    public void testPrintHints8bInit() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ _ B W o _ _ " + System.lineSeparator() +
                "5 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8wInit() {
        Reversi reversi = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ o B W _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints10bInit() {
        Reversi reversi = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "4 _ _ _ o W B _ _ _ _ " + System.lineSeparator() +
                "5 _ _ _ _ B W o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bAlmostComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B W B B W W B B " + System.lineSeparator() +
                "1 W W B W B W W W " + System.lineSeparator() +
                "2 B W B W B B W B " + System.lineSeparator() +
                "3 W W B B o W W B " + System.lineSeparator() +
                "4 B B B W B B B B " + System.lineSeparator() +
                "5 W W B W W W W W " + System.lineSeparator() +
                "6 B B B W B B W B " + System.lineSeparator() +
                "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B B B B B B B B " + System.lineSeparator() +
                "1 B W W W W W W B " + System.lineSeparator() +
                "2 B W W B W B W B " + System.lineSeparator() +
                "3 B B W W B W B B " + System.lineSeparator() +
                "4 B B B W B B W B " + System.lineSeparator() +
                "5 B B W W B W W B " + System.lineSeparator() +
                "6 B B B B B B W B " + System.lineSeparator() +
                "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHintsExecuteB54() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ _ B B _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o B o _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }

    @Test
    public void testPrintHintsExecuteB54W53() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        reversi.execute("5 3");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ o W B _ _ _ " + System.lineSeparator() +
                "5 _ _ o W B _ _ _ " + System.lineSeparator() +
                "6 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }


    // printMoveOnTurn

    @Test
    public void testPrintMoveOnTurn8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. B is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintMoveOnTurn8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. W is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printPiecesNumber

    @Test
    public void testPrintPiecesNumber8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPiecesNumber(game.getLeftB(), game.getLeftW());
        String expected = "Number of pieces: B: 2; W: 2" + System.lineSeparator() + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 9, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // TestUtils.getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(3, 2);
        List<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("pieces to flip on onit - (3, 2)", 2, pieces.size());
        assertEquals(expected.get(0).get(0), pieces.get(0).get(0));
        assertEquals(expected.get(0).get(1), pieces.get(0).get(1));
        assertEquals(expected.get(1).get(0), pieces.get(1).get(0));
        assertEquals(expected.get(1).get(1), pieces.get(1).get(1));
    }

    @Test
    public void testGetPiecesToFlipInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals(Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals(Player.B, TestUtils.getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.B, game.onTurn);
    }


    // endGame

    @Test
    public void testEndGame() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        assertTrue(game.ended);
        assertEquals(Player.B, game.winner);
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ExecuteTest.java', 9, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

public class ExecuteTest {

    @Test
    public void testExecute32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testExecuteFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 39, game.getLeftW());
        assertEquals("B left", 25, game.getLeftB());
        assertEquals("winner", Player.W, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 9, 'import java.util.List;

class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
        Player[][] init = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = Player.NONE;
            }
        }
        init[3][3] = Player.W;
        init[4][4] = Player.W;
        init[3][4] = Player.B;
        init[4][3] = Player.B;
        return init;
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 9, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }


}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 9, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 10, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            checkLength(gameConfig);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void checkLength(String[] gameConfig) throws Exception {
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            throw new Exception("Game configuration must contain " + configFileLinesNumber + " lines");
        }
    }

    void initGame(String[] gameConfig) {
        setSize(gameConfig[0]);
        setOnTurn(gameConfig[1]);
        createPlayground();
        fillPlayground(gameConfig);
    }

    void setSize(String size) {
        if (!size.matches("[0-9]+")) {
            System.out.println("Incorrect size input");
            return;
        }
        this.size = Integer.parseInt(size);
    }

    void setOnTurn(String onTurn) {
        if (!isOnTurnInputCorrect(onTurn)) {
            System.out.println("Incorrect player on turn input");
            return;
        }
        if ("B".equals(onTurn)) {
            this.onTurn = Player.B;
        } else if ("W".equals(onTurn)) {
            this.onTurn = Player.W;
        }
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    private void createPlayground() {
        playground = new Player[size][size];
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) {
        try {
            int[] piecesPositions = new int[] {2, 3};
            for (int piecePosition : piecesPositions) {
                String[] pieces = gameConfig[piecePosition].split(",");
                for (String piece : pieces) {
                    if (!isPieceInputCorrect(piece)) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    int[] coordinates = getCoordinates(piece);
                    setPiece(coordinates, players[piecePosition - 2]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect");
        }
    }

    boolean isPieceInputCorrect(String piece) {
        return piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String piece) {
        String[] coordinates = piece.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void setPiece(int[] coordinates, Player player) {
        int r = coordinates[0];
        int c = coordinates[1];
        if (r >= size || c >= size) {
            return;
        }
        playground[r][c] = player;
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        leftB++;
                    } else if (playground[r][c] == Player.W) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printHints(playground, size, getPossibleMoves());
                PlaygroundPrinter.printPlayground(playground, size);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    void execute(String line) {
        if (!isPieceInputCorrect(line)) {
            System.out.println("Incorrect piece input");
            return;
        }
        int[] coordinates = getCoordinates(line);
        move(coordinates[0], coordinates[1]);
        if (! areValidMoves()) {
            endGame();
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        List<List<Integer>> piecesToFlip = getPiecesToFlip(r, c);
        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        flipPieces(piecesToFlip);

        swapPlayerOnTurn();
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    List<List<Integer>> getPiecesToFlip(int r0, int c0) {
        List<List<Integer>> toFlip = new ArrayList<>();
        playground[r0][c0] = onTurn;
        Player opposite = Player.NONE;
        if (onTurn == Player.W) opposite = Player.B;
        else if (onTurn == Player.B) opposite = Player.W;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int r = r0;
            int c = c0;
            r += direction[0];
            c += direction[1];
            if (isWithinPlayground(r, c) && playground[r][c] != opposite) continue;
            r += direction[0];
            c += direction[1];
            if (!isWithinPlayground(r, c)) continue;
            while (playground[r][c] == opposite) {
                r += direction[0];
                c += direction[1];
                if (!isWithinPlayground(r, c)) break;
            }
            if (!isWithinPlayground(r, c)) continue;
            if (playground[r][c] != onTurn) continue;
            while (true) {
                r -= direction[0];
                c -= direction[1];
                if (r == r0 && c == c0) break;
                toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (!toFlip.isEmpty()) {
            toFlip.add(new ArrayList<>(Arrays.asList(r0, c0)));
        }
        return toFlip;
    }

    void flipPieces(List<List<Integer>> pieces) {
        for (List<Integer> piece : pieces) {
            int r = piece.get(0);
            int c = piece.get(1);
            if (playground[r][c] == onTurn) break;
            if (playground[r][c] == Player.NONE) {
                playground[r][c] = onTurn;
                if (onTurn == Player.B) leftB++;
                else if (onTurn == Player.W) leftW++;
            } else {
                playground[r][c] = onTurn;
                if (onTurn == Player.B) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    boolean areValidMoves() {
        int movesNum = getPossibleMoves().size();
        return movesNum != 0;
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getPiecesToFlip(r, c).isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    void endGame() {
        printPiecesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 10, 'import java.util.Collections;
import java.util.List;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printHints(Player[][] playground, int size, List<String> possibleMoves) {
        System.out.println("Possible moves:");
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (possibleMoves.contains(String.format("%d %d", r, c))) {
                    System.out.print("o ");
                } else if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    static void printMoveOnTurn(Player onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 10, 'public enum Player {
    B(1), W(0), NONE(-1);

    private final int value;

    Player(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 10, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";;
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 10, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 10, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    // checkGameConfig

    @Test
    public void testCheckGameConfig8bInit() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigEmpty() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigFiveLines() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoSize() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoOnTurn() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoPieces() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }


    // readGameConfig

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }


    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 10, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertArrayEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();

    //setSize

    @Test
    public void testSetSize8() {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() {
        Reversi game = rev;
        game.setSize("-8");

        assertEquals("set size -8", 0, game.size);
    }

    @Test
    public void testSetSizeA() {
        Reversi game = rev;
        game.setSize("A");

        assertEquals("set size A", 0, game.size);
    }

    // setOnTurnInputCorrect

    @Test
    public void testIsOnTurnInputCorrectB() {
        Reversi game = rev;

        assertTrue("on turn value of config file: B", game.isOnTurnInputCorrect("B"));
    }

    @Test
    public void testIsOnTurnInputCorrectW() {
        Reversi game = rev;

        assertTrue("on turn value of config file: W", game.isOnTurnInputCorrect("W"));
    }

    @Test
    public void testIsOnTurnInputCorrectA() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("A"));
    }

    @Test
    public void testIsOnTurnInputCorrectNONE() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("NONE"));
    }

    @Test
    public void testIsOnTurnInputCorrectnull() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect(null));
    }


    // setOnTurn

    @Test
    public void testSetOnTurnB() {
        Reversi game = rev;
        game.setOnTurn("B");

        assertEquals("set player on turn: B", Player.B, game.onTurn);
    }

    @Test
    public void testSetOnTurnW() {
        Reversi game = rev;
        game.setOnTurn("W");

        assertEquals("set player on turn: W", Player.W, game.onTurn);
    }

    @Test
    public void testSetOnTurnA() {
        Reversi game = rev;
        game.setOnTurn("A");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnNone() {
        Reversi game = rev;
        game.setOnTurn("NONE");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnnull() {
        Reversi game = rev;
        game.setOnTurn(null);

        assertEquals(Player.NONE, game.onTurn);
    }



    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, TestUtils.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 0}, Player.B);

        Player[][] expectedPlayground = InitGameTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece08() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 8}, Player.B);

        Player[][] expectedPlayground = InitGameTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece88() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 8}, Player.B);

        Player[][] expectedPlayground = InitGameTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[] {"one"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() {
        String[] gameConfig = new String[] {"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGamer

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    static Player[][] getInitPlayground() {
        Player[][] init = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = Player.NONE;
            }
        }
        init[3][3] = Player.W;
        init[4][4] = Player.W;
        init[3][4] = Player.B;
        init[4][3] = Player.B;
        return init;
    }

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertTrue(game.ended);
        assertEquals(Player.NONE, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 10, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // hints

    @Test
    public void testPrintHints8bInit() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ _ B W o _ _ " + System.lineSeparator() +
                "5 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8wInit() {
        Reversi reversi = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ o B W _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints10bInit() {
        Reversi reversi = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "4 _ _ _ o W B _ _ _ _ " + System.lineSeparator() +
                "5 _ _ _ _ B W o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bAlmostComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B W B B W W B B " + System.lineSeparator() +
                "1 W W B W B W W W " + System.lineSeparator() +
                "2 B W B W B B W B " + System.lineSeparator() +
                "3 W W B B o W W B " + System.lineSeparator() +
                "4 B B B W B B B B " + System.lineSeparator() +
                "5 W W B W W W W W " + System.lineSeparator() +
                "6 B B B W B B W B " + System.lineSeparator() +
                "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bComplete() {
        Reversi reversi = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B B B B B B B B " + System.lineSeparator() +
                "1 B W W W W W W B " + System.lineSeparator() +
                "2 B W W B W B W B " + System.lineSeparator() +
                "3 B B W W B W B B " + System.lineSeparator() +
                "4 B B B W B B W B " + System.lineSeparator() +
                "5 B B W W B W W B " + System.lineSeparator() +
                "6 B B B B B B W B " + System.lineSeparator() +
                "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHintsExecuteB54() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ _ B B _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o B o _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }

    @Test
    public void testPrintHintsExecuteB54W53() {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        reversi.execute("5 3");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ o W B _ _ _ " + System.lineSeparator() +
                "5 _ _ o W B _ _ _ " + System.lineSeparator() +
                "6 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }


    // printMoveOnTurn

    @Test
    public void testPrintMoveOnTurn8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. B is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintMoveOnTurn8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. W is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printPiecesNumber

    @Test
    public void testPrintPiecesNumber8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPiecesNumber(game.getLeftB(), game.getLeftW());
        String expected = "Number of pieces: B: 2; W: 2" + System.lineSeparator() + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 10, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // TestUtils.getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(3, 2);
        List<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("pieces to flip on onit - (3, 2)", 2, pieces.size());
        assertEquals(expected.get(0).get(0), pieces.get(0).get(0));
        assertEquals(expected.get(0).get(1), pieces.get(0).get(1));
        assertEquals(expected.get(1).get(0), pieces.get(1).get(0));
        assertEquals(expected.get(1).get(1), pieces.get(1).get(1));
    }

    @Test
    public void testGetPiecesToFlipInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals(Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals(Player.B, TestUtils.getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.B, game.onTurn);
    }


    // endGame

    @Test
    public void testEndGame() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        assertTrue(game.ended);
        assertEquals(Player.B, game.winner);
    }
    
    
    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ExecuteTest.java', 10, 'import org.junit.Assert;
import org.junit.Test;

public class ExecuteTest {

    @Test
    public void testExecute32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn''t change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 10, 'import java.util.List;


class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 10, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }


}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 10, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 11, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private HashMap<Player, Integer> left = new HashMap<Player, Integer>() {{ put(Player.B, 0); put(Player.W, 0); }};
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            checkLength(gameConfig);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void checkLength(String[] gameConfig) throws Exception {
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            throw new Exception("Game configuration must contain " + configFileLinesNumber + " lines");
        }
    }

    void initGame(String[] gameConfig) {
        setSize(gameConfig[0]);
        setOnTurn(gameConfig[1]);
        createPlayground();
        fillPlayground(gameConfig);
    }

    void setSize(String size) {
        if (!size.matches("[0-9]+")) {
            System.out.println("Incorrect size input");
            return;
        }
        this.size = Integer.parseInt(size);
    }

    void setOnTurn(String onTurn) {
        if (!isOnTurnInputCorrect(onTurn)) {
            System.out.println("Incorrect player on turn input");
            return;
        }
        if ("B".equals(onTurn)) {
            this.onTurn = Player.B;
        } else if ("W".equals(onTurn)) {
            this.onTurn = Player.W;
        }
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    private void createPlayground() {
        playground = new Player[size][size];
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) {
        try {
            int[] piecesPositions = new int[] {2, 3};
            for (int piecePosition : piecesPositions) {
                String[] pieces = gameConfig[piecePosition].split(",");
                for (String piece : pieces) {
                    if (!isPieceInputCorrect(piece)) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    int[] coordinates = getCoordinates(piece);
                    setPiece(coordinates, players[piecePosition - 2]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect");
        }
    }

    boolean isPieceInputCorrect(String piece) {
        return piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String piece) {
        String[] coordinates = piece.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void setPiece(int[] coordinates, Player player) {
        int r = coordinates[0];
        int c = coordinates[1];
        if (r >= size || c >= size) {
            return;
        }
        playground[r][c] = player;
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.NONE) {
                        continue;
                    }
                    left.put(playground[r][c], left.get(playground[r][c]) + 1);
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printHints(playground, size, getPossibleMoves());
                PlaygroundPrinter.printPlayground(playground, size);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    void execute(String line) {
        if (!isPieceInputCorrect(line)) {
            System.out.println("Incorrect piece input");
            return;
        }
        int[] coordinates = getCoordinates(line);
        move(coordinates[0], coordinates[1]);
        if (! areValidMoves()) {
            endGame();
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return left.get(Player.B);
    }

    int getLeftW() {
        return left.get(Player.W);
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        List<List<Integer>> piecesToFlip = getPiecesToFlip(r, c);
        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        flipPieces(piecesToFlip);

        swapPlayerOnTurn();
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    List<List<Integer>> getPiecesToFlip(int r0, int c0) {
        List<List<Integer>> toFlip = new ArrayList<>();
        playground[r0][c0] = onTurn;
        Player opposite = Player.NONE;
        if (onTurn == Player.W) opposite = Player.B;
        else if (onTurn == Player.B) opposite = Player.W;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int r = r0;
            int c = c0;
            r += direction[0];
            c += direction[1];
            if (isWithinPlayground(r, c) && playground[r][c] != opposite) continue;
            r += direction[0];
            c += direction[1];
            if (!isWithinPlayground(r, c)) continue;
            while (playground[r][c] == opposite) {
                r += direction[0];
                c += direction[1];
                if (!isWithinPlayground(r, c)) break;
            }
            if (!isWithinPlayground(r, c)) continue;
            if (playground[r][c] != onTurn) continue;
            while (true) {
                r -= direction[0];
                c -= direction[1];
                if (r == r0 && c == c0) break;
                toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (!toFlip.isEmpty()) {
            toFlip.add(new ArrayList<>(Arrays.asList(r0, c0)));
        }
        return toFlip;
    }

    void flipPieces(List<List<Integer>> pieces) {
        pieces.forEach(piece -> {
            Player previous = playground[piece.get(0)][piece.get(1)];
            playground[piece.get(0)][piece.get(1)] = onTurn;
            if (previous == Player.NONE) {
                left.put(onTurn, left.get(onTurn) + 1);
            } else if (previous != onTurn) {
                left.put(previous, left.get(previous) - 1);
                left.put(onTurn, left.get(onTurn) + 1);
            }
        });
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    boolean areValidMoves() {
        int movesNum = getPossibleMoves().size();
        return movesNum != 0;
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getPiecesToFlip(r, c).isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    void endGame() {
        printPiecesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 11, 'import java.util.Collections;
import java.util.List;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printHints(Player[][] playground, int size, List<String> possibleMoves) {
        System.out.println("Possible moves:");
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (possibleMoves.contains(String.format("%d %d", r, c))) {
                    System.out.print("o ");
                } else if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    static void printMoveOnTurn(Player onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 11, 'public enum Player {
    B(1), W(0), NONE(-1);

    private final int value;

    Player(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'IncorrectGameConfigFileException.java', 11, 'public class IncorrectGameConfigFileException extends Exception {

    public IncorrectGameConfigFileException(String message) {
        super(message);
    }

    public IncorrectGameConfigFileException(String message, Throwable cause) {
        super(message, cause);
    }


}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 11, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";;
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 11, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 11, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    // checkGameConfig

    @Test
    public void testCheckGameConfig8bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigEmpty() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigFiveLines() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoSize() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoOnTurn() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoPieces() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }


    // readGameConfig


    @Test
    public void testReadGameConfig8bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file does not exist");
        game.readGameConfig(GameConfig.gameNotExisting);
    }


    @Test
    public void testReadGameConfigFiveLines() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals(5, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
        assertEquals("3 4, 4 3", gameConfig[2]);
        assertEquals("3 3, 4 4", gameConfig[3]);
        assertEquals("3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals(4, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
        assertEquals("E 4, D 5", gameConfig[2]);
        assertEquals("D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 11, 'import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();


    //setSize

    @Test
    public void testSetSize8() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect size input");
        game.setSize("-8");
    }

    @Test
    public void testSetSizeA() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect size input");
        game.setSize("A");
    }

    // setOnTurnInputCorrect

    @Test
    public void testIsOnTurnInputCorrectB() {
        Reversi game = rev;

        assertTrue("on turn value of config file: B", game.isOnTurnInputCorrect("B"));
    }

    @Test
    public void testIsOnTurnInputCorrectW() {
        Reversi game = rev;

        assertTrue("on turn value of config file: W", game.isOnTurnInputCorrect("W"));
    }

    @Test
    public void testIsOnTurnInputCorrectA() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("A"));
    }

    @Test
    public void testIsOnTurnInputCorrectNONE() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("NONE"));
    }

    @Test
    public void testIsOnTurnInputCorrectnull() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect(null));
    }


    // setOnTurn

    @Test
    public void testSetOnTurnB() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setOnTurn("B");

        assertEquals("set player on turn: B", Player.B, game.onTurn);
    }

    @Test
    public void testSetOnTurnW() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setOnTurn("W");

        assertEquals("set player on turn: W", Player.W, game.onTurn);
    }

    @Test
    public void testSetOnTurnA() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn("A");
    }

    @Test
    public void testSetOnTurnNone() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn("NONE");
    }

    @Test
    public void testSetOnTurnnull() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn(null);
    }



    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, TestUtils.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[]{8, 0}, Player.B);
    }

    @Test
    public void testSetPiece08() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[]{0, 8}, Player.B);
    }

    @Test
    public void testSetPiece88() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[]{8, 8}, Player.B);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"one"};
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(gameConfig);
    }

    @Test
    public void testFillPlaygroundNull() throws IncorrectGameConfigFileException {
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(null);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.fillPlayground(gameConfig);
    }


    // initGame

    @Rule
    public ExpectedException expectedException = ExpectedException.none();

    @Test
    public void testInitGame8bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameAlpha() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.initGame(gameConfig);
    }

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameEmpty);
    }

    @Test
    public void testNotExisting() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file does not exist");
        new Reversi(GameConfig.gameNotExisting);
    }

    @Test
    public void testFiveLines() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameFiveLines);
    }

    @Test
    public void testAlpha() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        new Reversi(GameConfig.gameAlpha);
    }

    @Test
    public void testNoSize() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoSize);
    }

    @Test
    public void testNoOnTurn() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoOnTurn);
    }

    @Test
    public void testNoPieces() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoPieces);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 11, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.nio.file.Path;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // hints

    @Test
    public void testPrintHints8bInit() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ _ B W o _ _ " + System.lineSeparator() +
                "5 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8wInit() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ o B W _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints10bInit() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "4 _ _ _ o W B _ _ _ _ " + System.lineSeparator() +
                "5 _ _ _ _ B W o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bAlmostComplete() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B W B B W W B B " + System.lineSeparator() +
                "1 W W B W B W W W " + System.lineSeparator() +
                "2 B W B W B B W B " + System.lineSeparator() +
                "3 W W B B o W W B " + System.lineSeparator() +
                "4 B B B W B B B B " + System.lineSeparator() +
                "5 W W B W W W W W " + System.lineSeparator() +
                "6 B B B W B B W B " + System.lineSeparator() +
                "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bComplete() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B B B B B B B B " + System.lineSeparator() +
                "1 B W W W W W W B " + System.lineSeparator() +
                "2 B W W B W B W B " + System.lineSeparator() +
                "3 B B W W B W B B " + System.lineSeparator() +
                "4 B B B W B B W B " + System.lineSeparator() +
                "5 B B W W B W W B " + System.lineSeparator() +
                "6 B B B B B B W B " + System.lineSeparator() +
                "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHintsExecuteB54() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ _ B B _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o B o _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }

    @Test
    public void testPrintHintsExecuteB54W53() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        reversi.execute("5 3");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ o W B _ _ _ " + System.lineSeparator() +
                "5 _ _ o W B _ _ _ " + System.lineSeparator() +
                "6 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }


    // printMoveOnTurn

    @Test
    public void testPrintMoveOnTurn8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. B is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintMoveOnTurn8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. W is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printPiecesNumber

    @Test
    public void testPrintPiecesNumber8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPiecesNumber(game.getLeftB(), game.getLeftW());
        String expected = "Number of pieces: B: 2; W: 2" + System.lineSeparator() + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // IncorrectConfig

    @Test
    public void testPrintIncorrectConfig8bInit() {
        Path gameFilePath = GameConfig.gameNoPieces;
        Reversi rev;
        try {
            rev = new Reversi(gameFilePath);
            rev.run();
        } catch (IncorrectGameConfigFileException e) {
            PlaygroundPrinter.printIncorrectConfig(e);
        }
        String expected = "Incorrect game config: Game configuration must contain 4 lines" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 11, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {
    

    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(3, 2);
        List<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("pieces to flip on onit - (3, 2)", 2, pieces.size());
        assertEquals(expected.get(0).get(0), pieces.get(0).get(0));
        assertEquals(expected.get(0).get(1), pieces.get(0).get(1));
        assertEquals(expected.get(1).get(0), pieces.get(1).get(0));
        assertEquals(expected.get(1).get(1), pieces.get(1).get(1));
    }

    @Test
    public void testGetPiecesToFlipInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals(Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals(Player.B, TestUtils.getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.B, game.onTurn);
    }


    // endGame

    @Test
    public void testEndGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        Assert.assertTrue(game.ended);
        Assert.assertEquals(Player.B, game.winner);
    }

    
    // move

    @Test
    public void testMoveOnNotEmpty() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ExecuteTest.java', 11, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

public class ExecuteTest {



    @Test
    public void testExecute32() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testExecuteFinishGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 39, game.getLeftW());
        assertEquals("B left", 25, game.getLeftB());
        assertEquals("winner", Player.W, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 11, 'import java.util.List;


class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) throws IncorrectGameConfigFileException {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
        Player[][] init = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = Player.NONE;
            }
        }
        init[3][3] = Player.W;
        init[4][4] = Player.W;
        init[3][4] = Player.B;
        init[4][3] = Player.B;
        return init;
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 11, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() throws IncorrectGameConfigFileException {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }


}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 11, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 12, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private HashMap<Player, Integer> left = new HashMap<Player, Integer>() {{ put(Player.B, 0); put(Player.W, 0); }};
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) throws IncorrectGameConfigFileException {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            checkLength(gameConfig);
            initGame(gameConfig);
            initPiecesCount();
        } catch (IncorrectGameConfigFileException e) {
            ended = true;
            throw new IncorrectGameConfigFileException(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) throws IncorrectGameConfigFileException {
        String[] gameConfig;
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            throw new IncorrectGameConfigFileException("Game configuration file does not exist");
        } catch (IOException e) {
            throw new IncorrectGameConfigFileException("Could not read game configuration file");
        }
        return gameConfig;
    }

    void checkLength(String[] gameConfig) throws IncorrectGameConfigFileException {
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            throw new IncorrectGameConfigFileException("Game configuration must contain " + configFileLinesNumber + " lines");
        }
    }

    void initGame(String[] gameConfig) throws IncorrectGameConfigFileException {
        setSize(gameConfig[0]);
        setOnTurn(gameConfig[1]);
        createPlayground();
        fillPlayground(gameConfig);
    }

    void setSize(String size) throws IncorrectGameConfigFileException {
        if (!size.matches("[0-9]+")) {
            throw new IncorrectGameConfigFileException("Incorrect size input");
        }
        this.size = Integer.parseInt(size);
    }

    void setOnTurn(String onTurn) throws IncorrectGameConfigFileException {
        if (!isOnTurnInputCorrect(onTurn)) {
            throw new IncorrectGameConfigFileException("Incorrect player on turn input");
        }
        if ("B".equals(onTurn)) {
            this.onTurn = Player.B;
        } else if ("W".equals(onTurn)) {
            this.onTurn = Player.W;
        }
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    private void createPlayground() {
        playground = new Player[size][size];
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) throws IncorrectGameConfigFileException {
        try {
            int[] piecesPositions = new int[] {2, 3};
            for (int piecePosition : piecesPositions) {
                String[] pieces = gameConfig[piecePosition].split(",");
                for (String piece : pieces) {
                    if (!isPieceInputCorrect(piece)) {
                        throw new IncorrectGameConfigFileException("Incorrect piece input");
                    }
                    int[] coordinates = getCoordinates(piece);
                    setPiece(coordinates, players[piecePosition - 2]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            throw new IncorrectGameConfigFileException("Game configuration file is incorrect");
        }
    }

    boolean isPieceInputCorrect(String piece) {
        return piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String piece) {
        String[] coordinates = piece.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void setPiece(int[] coordinates, Player player) throws IncorrectGameConfigFileException {
        int r = coordinates[0];
        int c = coordinates[1];
        if (r >= size || c >= size) {
            throw new IncorrectGameConfigFileException("Incorrect piece input");
        }
        playground[r][c] = player;
    }

    void initPiecesCount() throws IncorrectGameConfigFileException {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.NONE) {
                        continue;
                    }
                    left.put(playground[r][c], left.get(playground[r][c]) + 1);
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            throw new IncorrectGameConfigFileException("Playground  is not valid", e);
        }
    }

    void run() throws IncorrectGameConfigFileException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printHints(playground, size, getPossibleMoves());
                PlaygroundPrinter.printPlayground(playground, size);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            throw new IncorrectGameConfigFileException("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    void execute(String line) {
        if (!isPieceInputCorrect(line)) {
            System.out.println("Incorrect piece input");
            return;
        }
        int[] coordinates = getCoordinates(line);
        move(coordinates[0], coordinates[1]);
        if (! areValidMoves()) {
            endGame();
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return left.get(Player.B);
    }

    int getLeftW() {
        return left.get(Player.W);
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        List<List<Integer>> piecesToFlip = getPiecesToFlip(r, c);
        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        flipPieces(piecesToFlip);

        swapPlayerOnTurn();
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    List<List<Integer>> getPiecesToFlip(int r0, int c0) {
        List<List<Integer>> toFlip = new ArrayList<>();
        playground[r0][c0] = onTurn;
        Player opposite = Player.NONE;
        if (onTurn == Player.W) opposite = Player.B;
        else if (onTurn == Player.B) opposite = Player.W;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int r = r0;
            int c = c0;
            r += direction[0];
            c += direction[1];
            if (isWithinPlayground(r, c) && playground[r][c] != opposite) continue;
            r += direction[0];
            c += direction[1];
            if (!isWithinPlayground(r, c)) continue;
            while (playground[r][c] == opposite) {
                r += direction[0];
                c += direction[1];
                if (!isWithinPlayground(r, c)) break;
            }
            if (!isWithinPlayground(r, c)) continue;
            if (playground[r][c] != onTurn) continue;
            while (true) {
                r -= direction[0];
                c -= direction[1];
                if (r == r0 && c == c0) break;
                toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (!toFlip.isEmpty()) {
            toFlip.add(new ArrayList<>(Arrays.asList(r0, c0)));
        }
        return toFlip;
    }

    void flipPieces(List<List<Integer>> pieces) {
        pieces.forEach(piece -> {
            Player previous = playground[piece.get(0)][piece.get(1)];
            playground[piece.get(0)][piece.get(1)] = onTurn;
            if (previous == Player.NONE) {
                left.put(onTurn, left.get(onTurn) + 1);
            } else if (previous != onTurn) {
                left.put(previous, left.get(previous) - 1);
                left.put(onTurn, left.get(onTurn) + 1);
            }
        });
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    boolean areValidMoves() {
        int movesNum = getPossibleMoves().size();
        return movesNum != 0;
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getPiecesToFlip(r, c).isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    void endGame() {
        printPiecesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev;
        try {
            rev = new Reversi(gameFilePath);
            rev.run();
        } catch (IncorrectGameConfigFileException e) {
            PlaygroundPrinter.printIncorrectConfig(e);
        }

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 12, 'import java.util.Collections;
import java.util.List;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printHints(Player[][] playground, int size, List<String> possibleMoves) {
        System.out.println("Possible moves:");
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (possibleMoves.contains(String.format("%d %d", r, c))) {
                    System.out.print("o ");
                } else if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    static void printMoveOnTurn(Player onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }

    static void printIncorrectConfig(IncorrectGameConfigFileException e) {
        System.out.println("Incorrect game config: " + e.getMessage());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 12, 'public enum Player {
    B(1), W(0), NONE(-1);

    private final int value;

    Player(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'IncorrectGameConfigFileException.java', 12, 'public class IncorrectGameConfigFileException extends Exception {

    public IncorrectGameConfigFileException(String message) {
        super(message);
    }

    public IncorrectGameConfigFileException(String message, Throwable cause) {
        super(message, cause);
    }


}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'NotPermittedMoveException.java', 12, 'public class NotPermittedMoveException extends Exception {

    public NotPermittedMoveException(String message) {
        super(message);
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 12, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";;
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 12, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 12, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    // checkGameConfig

    @Test
    public void testCheckGameConfig8bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigEmpty() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigFiveLines() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoSize() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoOnTurn() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoPieces() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }


    // readGameConfig

    @Test
    public void testReadGameConfig8bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file does not exist");
        game.readGameConfig(GameConfig.gameNotExisting);
    }


    @Test
    public void testReadGameConfigFiveLines() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 12, 'import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    //setSize

    @Test
    public void testSetSize8() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect size input");
        game.setSize("-8");
    }

    @Test
    public void testSetSizeA() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect size input");
        game.setSize("A");
    }


    // setOnTurnInputCorrect

    @Test
    public void testIsOnTurnInputCorrectB() {
        Reversi game = rev;

        assertTrue("on turn value of config file: B", game.isOnTurnInputCorrect("B"));
    }

    @Test
    public void testIsOnTurnInputCorrectW() {
        Reversi game = rev;

        assertTrue("on turn value of config file: W", game.isOnTurnInputCorrect("W"));
    }

    @Test
    public void testIsOnTurnInputCorrectA() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("A"));
    }

    @Test
    public void testIsOnTurnInputCorrectNONE() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("NONE"));
    }

    @Test
    public void testIsOnTurnInputCorrectnull() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect(null));
    }


    // setOnTurn

    @Test
    public void testSetOnTurnB() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setOnTurn("B");

        assertEquals("set player on turn: B", Player.B, game.onTurn);
    }

    @Test
    public void testSetOnTurnW() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setOnTurn("W");

        assertEquals("set player on turn: W", Player.W, game.onTurn);
    }

    @Test
    public void testSetOnTurnA() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn("A");
    }

    @Test
    public void testSetOnTurnNone() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn("NONE");
    }

    @Test
    public void testSetOnTurnnull() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn(null);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[] {0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, TestUtils.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[] {8, 0}, Player.B);
    }

    @Test
    public void testSetPiece08() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[] {0, 8}, Player.B);
    }

    @Test
    public void testSetPiece88() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[] {8, 8}, Player.B);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"one"};
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(gameConfig);
    }

    @Test
    public void testFillPlaygroundNull() throws IncorrectGameConfigFileException {
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(null);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.fillPlayground(gameConfig);
    }
    
    
    // initGame

    @Test
    public void testInitGame8bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }


    @Test
    public void testInitGameAlpha() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.initGame(gameConfig);
    }
    
    
    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameEmpty);
    }

    @Test
    public void testNotExisting() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file does not exist");
        new Reversi(GameConfig.gameNotExisting);
    }

    @Test
    public void testFiveLines() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameFiveLines);
    }

    @Test
    public void testAlpha() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        new Reversi(GameConfig.gameAlpha);
    }

    @Test
    public void testNoSize() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoSize);
    }

    @Test
    public void testNoOnTurn() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoOnTurn);
    }

    @Test
    public void testNoPieces() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoPieces);
    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 12, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.nio.file.Path;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // hints

    @Test
    public void testPrintHints8bInit() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ _ B W o _ _ " + System.lineSeparator() +
                "5 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8wInit() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ o B W _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints10bInit() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "4 _ _ _ o W B _ _ _ _ " + System.lineSeparator() +
                "5 _ _ _ _ B W o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bAlmostComplete() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B W B B W W B B " + System.lineSeparator() +
                "1 W W B W B W W W " + System.lineSeparator() +
                "2 B W B W B B W B " + System.lineSeparator() +
                "3 W W B B o W W B " + System.lineSeparator() +
                "4 B B B W B B B B " + System.lineSeparator() +
                "5 W W B W W W W W " + System.lineSeparator() +
                "6 B B B W B B W B " + System.lineSeparator() +
                "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bComplete() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B B B B B B B B " + System.lineSeparator() +
                "1 B W W W W W W B " + System.lineSeparator() +
                "2 B W W B W B W B " + System.lineSeparator() +
                "3 B B W W B W B B " + System.lineSeparator() +
                "4 B B B W B B W B " + System.lineSeparator() +
                "5 B B W W B W W B " + System.lineSeparator() +
                "6 B B B B B B W B " + System.lineSeparator() +
                "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHintsExecuteB54() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ _ B B _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o B o _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }

    @Test
    public void testPrintHintsExecuteB54W53() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        reversi.execute("5 3");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ o W B _ _ _ " + System.lineSeparator() +
                "5 _ _ o W B _ _ _ " + System.lineSeparator() +
                "6 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }


    // printMoveOnTurn

    @Test
    public void testPrintMoveOnTurn8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. B is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintMoveOnTurn8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printMoveOnTurn(game.onTurn);
        String expected = "Make a move. W is on turn" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // printPiecesNumber

    @Test
    public void testPrintPiecesNumber8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPiecesNumber(game.getLeftB(), game.getLeftW());
        String expected = "Number of pieces: B: 2; W: 2" + System.lineSeparator() + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // IncorrectConfig

    @Test
    public void testPrintIncorrectConfig8bInit() {
        Path gameFilePath = GameConfig.gameNoPieces;
        Reversi rev;
        try {
            rev = new Reversi(gameFilePath);
            rev.run();
        } catch (IncorrectGameConfigFileException e) {
            PlaygroundPrinter.printIncorrectConfig(e);
        }
        String expected = "Incorrect game config: Game configuration must contain 4 lines" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // NotPermittedMove

    @Test
    public void testPrintNotPermittedMove8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        try {
            game.move(0, 0);
        } catch (NotPermittedMoveException e) {
            PlaygroundPrinter.printNotPermittedMove(e);
        }
        String expected = "Move is not permitted" + System.lineSeparator() +
                "Try again" + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 12, 'import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {
    
    @Rule
    public ExpectedException expectedException = ExpectedException.none();

    
    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // TestUtils.getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(3, 2);
        List<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("pieces to flip on onit - (3, 2)", 2, pieces.size());
        assertEquals(expected.get(0).get(0), pieces.get(0).get(0));
        assertEquals(expected.get(0).get(1), pieces.get(0).get(1));
        assertEquals(expected.get(1).get(0), pieces.get(1).get(0));
        assertEquals(expected.get(1).get(1), pieces.get(1).get(1));
    }

    @Test
    public void testGetPiecesToFlipInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals(Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals(Player.B, TestUtils.getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.B, game.onTurn);
    }


    // endGame

    @Test
    public void testEndGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        assertTrue(game.ended);
        assertEquals(Player.B, game.winner);
    }
    
    
    // move

    @Test
    public void testMoveOnNotEmpty() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move on not empty piece is not permitted");
        game.move(4, 4);
    }

    @Test
    public void testMoveOutOfBoundsBelow() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move out of bounds is not permitted");
        game.move(8, 0);
    }

    @Test
    public void testMoveOutOfBoundsAbove() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move out of bounds is not permitted");
        game.move(-1, 0);
    }

    @Test
    public void testMoveOnNotAdjacent() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move is not permitted");
        game.move(0, 0);
    }

    @Test
    public void testMoveFlipRight() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ExecuteTest.java', 12, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

public class ExecuteTest {

    @Test
    public void testExecute32() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testExecuteFinishGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 39, game.getLeftW());
        assertEquals("B left", 25, game.getLeftB());
        assertEquals("winner", Player.W, game.winner);
    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 12, 'import java.util.List;


class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) throws IncorrectGameConfigFileException {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
        Player[][] init = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = Player.NONE;
            }
        }
        init[3][3] = Player.W;
        init[4][4] = Player.W;
        init[3][4] = Player.B;
        init[4][3] = Player.B;
        return init;
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 12, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() throws IncorrectGameConfigFileException {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }


}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 12, 'public_file');

