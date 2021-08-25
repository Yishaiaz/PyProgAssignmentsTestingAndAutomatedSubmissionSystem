import os.path
import pandas as pd
from solution import *
from AssignmentSolutionTemplate import *

summation_txt = ''
total_tests_to_execute = 2
total_tests_passed = 0

grading_key = {'0': 100,
               '1': 100,
               '2': 90,
               '3': 90,
               '4': 80,
               '5': 80,
               '6': 70,
               '7': 70,
               '8': 60
               }


def test1():
    global summation_txt
    global total_tests_passed
    arg1 = 'a'
    arg2 = 'b'
    arguments = (arg1, arg2)
    expected_result = sol_func1(*arguments)
    try:
        result = func1(*arguments)
        if result == expected_result:
            total_tests_passed += 1

    except Exception as e:
        summation_txt += 'Failed at test 1\n'


def test2():
    global summation_txt
    global total_tests_passed
    arg1 = 'a'
    arg2 = 'b'
    arguments = (arg1, arg2)
    expected_result = sol_func2(*arguments)
    try:
        result = func2(*arguments)
        if result == expected_result:
            total_tests_passed += 1

    except Exception as e:
        summation_txt += 'Failed at test 2\n'


if __name__ == '__main__':
    student_id = get_id()

    summation_for_student = ''

    test1()
    test2()

    df = {'ID': [student_id],
          'Grade': [0],
          'Failed Tests': ['']}

    df['Failed Tests'][0] = summation_txt

    summation_for_student += f'ID:{student_id}\nSUMMATION: {total_tests_passed}/{total_tests_to_execute}\n'

    tests_failed = total_tests_to_execute - total_tests_passed

    assignment_grade = grading_key.get(str(tests_failed), 0)

    df['Grade'][0] = assignment_grade

    if len(student_id) != 9:
        summation_for_student = "ID is not Valid!"
    else:
        if not os.path.isfile('results.csv'):
            pd.DataFrame.from_dict(df).set_index('ID').to_csv('results.csv')
        else:
            all_results_df = pd.read_csv('results.csv', index_col='ID')
            all_results_df.append(pd.DataFrame.from_dict(df).set_index('ID')).drop_duplicates().to_csv('results.csv')

    with open(f'submission/student_summation.txt', 'w') as f:
        f.write(summation_for_student)

