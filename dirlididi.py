#!/usr/bin/python
try:
    # Python3
    import urllib.request, urllib.error, urllib.parse
except:
    import urllib2

try:
    # Python 2.6
    import json
except:
    import simplejson as json

import os
import subprocess
import sys


def _run(filename):
    shell = os.name == 'nt'
    if filename.endswith('py'):
        executor = ['python', filename]
        return subprocess.Popen(executor, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, shell=shell)
    elif filename.endswith('sh'):
        executor = ['bash', filename]
        return subprocess.Popen(executor, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, shell=shell)
    elif filename.endswith('f90'):
        executor = ['gfortran', filename]
        exect = subprocess.Popen(executor, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, shell=shell)
        output, output_err = exect.communicate()
        return_code = exect.wait()
        if return_code:
            print(ERROR % ('Compiling...', output_err))
            exit(return_code)
        return subprocess.Popen('./a.out', stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, shell=shell)
    elif filename.endswith('c'):
        executor = ['gcc', filename]
        exect = subprocess.Popen(executor, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, shell=shell)
        output, output_err = exect.communicate()
        return_code = exect.wait()
        if return_code:
            print(ERROR % ('Compiling...', output_err))
            exit(return_code)
        return subprocess.Popen('./a.out', stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, shell=shell)
    elif filename.endswith('java'):
        executor = ['javac', filename]
        exect = subprocess.Popen(executor, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, shell=shell)
        output, output_err = exect.communicate()
        return_code = exect.wait()
        if return_code:
            print(ERROR % ('Compiling...', output_err))
            exit(return_code)
        executor = ['java', '-Duser.language=en', filename[:-len('.java')]]
        return subprocess.Popen(executor, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, shell=shell)
    elif filename.endswith('pl'):
        executor = ['swipl', '-q', '-f', filename]
        return subprocess.Popen(executor, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, shell=shell)
    elif os.access(filename, os.X_OK):
        executor = [os.path.abspath(filename)]
        return subprocess.Popen(executor, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)      


def http_get(url):
    if sys.version_info[0] < 3:
        response = urllib2.urlopen(url).read().decode('utf-8')
    else:
        response = urllib.request.urlopen(url).read().decode('utf-8')
    return json.loads(response)


def http_post(url, data):
    if sys.version_info[0] < 3:
        response = urllib2.urlopen(url=url, data=data).read().decode('utf-8')
    else:
        response = urllib.request.urlopen(url=url, data=data.encode('utf-8')).read().decode('utf-8')
    return json.loads(response)


BASE = 'http://dirlididi.com/api/'

HEAD = """= PROBLEM NAME
%s
= PROBLEM DESCRIPTION
%s
"""
TEST = """== TEST - %s
%s
== INPUT:
%s
== OUTPUT:
%s
"""
ERROR = """==ERROR FOR INPUT:
%s
== ERROR MSG:
%s
"""
FAILURE = """== FAILED FOR INPUT:
%s
== FAILED OUTPUT:
%s
"""


def get_problem(key):
    return http_get(BASE + 'problem/' + key)


def submit_code(token, key, code, tests_result):
    result = {'tests': tests_result, 'key': key, 'code': code, 'token': token}
    data = json.dumps(result)
    url = BASE + 'code/' + key
    return http_post(url, data)
 

def has_failure(results):
    return results.replace('.', '')


def _get(key):
    problem = get_problem(key)
    print(HEAD % (problem["name"], problem["description"]))
    published_tests = [x for x in problem['tests'] if x['publish']]
    if published_tests:
        print("= PROGRAM EXAMPLES")
        for test in published_tests:
            print(TEST % (test['description'], test.get('tip', ''), test['input'], test['output']))


def _submit(key, token, filename, source):
    problem = get_problem(key)
    tests_result = []
    for test in problem['tests']:
        exect = _run(filename)
        input_ = test['input']
        output, output_err = exect.communicate(input_)
        return_code = exect.wait()
        if return_code:
            print(ERROR % (input_, output_err))
            exit(return_code)
        tests_result.append((test['key'], output))
    content = submit_code(token, key, open(source).read(), tests_result)
    print("Results: " + content['result'])
    if has_failure(content['result']):
        for result_i in range(len(content['result'])):
            if content['result'][result_i] != '.':
                failed_test = tests_result[result_i]
                print(FAILURE % (problem['tests'][result_i]['input'], failed_test[1]))


def _usage():
    print('Usage:\n %s get <problem_key>\n %s submit <problem_key> <token> <filename> [filename_src]' % (sys.argv[0], sys.argv[0]))
    exit()


def main():
    if len(sys.argv) < 3:
        _usage()
    command = sys.argv[1]
    key = sys.argv[2]
    if command.lower() == 'get':
        _get(key)
    elif command.lower() == 'submit':
        if len(sys.argv) != 5 and len(sys.argv) != 6:
            _usage()
        token = sys.argv[3]
        filename = sys.argv[4]
        source = filename
        if len(sys.argv) == 6:
            source = sys.argv[5]
        _submit(key, token, filename, source)
    else:
        _usage()


if __name__ == "__main__":
    main()