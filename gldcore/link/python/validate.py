import sys
assert(sys.version_info.major>2)

import my_test
a = my_test.MyTest(name='my_test')
print(a.name)
#a.output("my test")

import gridlabd
gridlabd.command('validate.glm')
gridlabd.command('-D')
gridlabd.command('suppress_repeat_messages=FALSE')
gridlabd.command('--warn')
gridlabd.start('wait')
gridlabd.save('done.json');
gridlabd.save('done.glm');



