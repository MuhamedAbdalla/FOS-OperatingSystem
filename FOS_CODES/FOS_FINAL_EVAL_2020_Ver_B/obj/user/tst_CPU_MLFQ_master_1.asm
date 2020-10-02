
obj/user/tst_CPU_MLFQ_master_1:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 8a 01 00 00       	call   8001c0 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	// For EXIT
	int ID = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 90 f4 52 00 00    	mov    0x52f4(%eax),%edx
  800049:	a1 20 30 80 00       	mov    0x803020,%eax
  80004e:	8b 80 34 53 00 00    	mov    0x5334(%eax),%eax
  800054:	89 c1                	mov    %eax,%ecx
  800056:	a1 20 30 80 00       	mov    0x803020,%eax
  80005b:	8b 40 74             	mov    0x74(%eax),%eax
  80005e:	52                   	push   %edx
  80005f:	51                   	push   %ecx
  800060:	50                   	push   %eax
  800061:	68 c0 1c 80 00       	push   $0x801cc0
  800066:	e8 7c 16 00 00       	call   8016e7 <sys_create_env>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  800071:	83 ec 0c             	sub    $0xc,%esp
  800074:	ff 75 f0             	pushl  -0x10(%ebp)
  800077:	e8 89 16 00 00       	call   801705 <sys_run_env>
  80007c:	83 c4 10             	add    $0x10,%esp
	ID = sys_create_env("fos_add", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  80007f:	a1 20 30 80 00       	mov    0x803020,%eax
  800084:	8b 90 f4 52 00 00    	mov    0x52f4(%eax),%edx
  80008a:	a1 20 30 80 00       	mov    0x803020,%eax
  80008f:	8b 80 34 53 00 00    	mov    0x5334(%eax),%eax
  800095:	89 c1                	mov    %eax,%ecx
  800097:	a1 20 30 80 00       	mov    0x803020,%eax
  80009c:	8b 40 74             	mov    0x74(%eax),%eax
  80009f:	52                   	push   %edx
  8000a0:	51                   	push   %ecx
  8000a1:	50                   	push   %eax
  8000a2:	68 cf 1c 80 00       	push   $0x801ccf
  8000a7:	e8 3b 16 00 00       	call   8016e7 <sys_create_env>
  8000ac:	83 c4 10             	add    $0x10,%esp
  8000af:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	ff 75 f0             	pushl  -0x10(%ebp)
  8000b8:	e8 48 16 00 00       	call   801705 <sys_run_env>
  8000bd:	83 c4 10             	add    $0x10,%esp
	//============

	for (int i = 0; i < 3; ++i) {
  8000c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000c7:	eb 5e                	jmp    800127 <_main+0xef>
			ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  8000c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ce:	8b 90 f4 52 00 00    	mov    0x52f4(%eax),%edx
  8000d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d9:	8b 80 34 53 00 00    	mov    0x5334(%eax),%eax
  8000df:	89 c1                	mov    %eax,%ecx
  8000e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e6:	8b 40 74             	mov    0x74(%eax),%eax
  8000e9:	52                   	push   %edx
  8000ea:	51                   	push   %ecx
  8000eb:	50                   	push   %eax
  8000ec:	68 d7 1c 80 00       	push   $0x801cd7
  8000f1:	e8 f1 15 00 00       	call   8016e7 <sys_create_env>
  8000f6:	83 c4 10             	add    $0x10,%esp
  8000f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
			if (ID == E_ENV_CREATION_ERROR)
  8000fc:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  800100:	75 14                	jne    800116 <_main+0xde>
				panic("RUNNING OUT OF ENV!! terminating...");
  800102:	83 ec 04             	sub    $0x4,%esp
  800105:	68 e8 1c 80 00       	push   $0x801ce8
  80010a:	6a 0f                	push   $0xf
  80010c:	68 0c 1d 80 00       	push   $0x801d0c
  800111:	e8 cf 01 00 00       	call   8002e5 <_panic>
			sys_run_env(ID);
  800116:	83 ec 0c             	sub    $0xc,%esp
  800119:	ff 75 f0             	pushl  -0x10(%ebp)
  80011c:	e8 e4 15 00 00       	call   801705 <sys_run_env>
  800121:	83 c4 10             	add    $0x10,%esp
	sys_run_env(ID);
	ID = sys_create_env("fos_add", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
	sys_run_env(ID);
	//============

	for (int i = 0; i < 3; ++i) {
  800124:	ff 45 f4             	incl   -0xc(%ebp)
  800127:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  80012b:	7e 9c                	jle    8000c9 <_main+0x91>
			ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
			if (ID == E_ENV_CREATION_ERROR)
				panic("RUNNING OUT OF ENV!! terminating...");
			sys_run_env(ID);
		}
	env_sleep(10000);
  80012d:	83 ec 0c             	sub    $0xc,%esp
  800130:	68 10 27 00 00       	push   $0x2710
  800135:	e8 65 18 00 00       	call   80199f <env_sleep>
  80013a:	83 c4 10             	add    $0x10,%esp

	ID = sys_create_env("cpuMLFQ1Slave_1", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  80013d:	a1 20 30 80 00       	mov    0x803020,%eax
  800142:	8b 90 f4 52 00 00    	mov    0x52f4(%eax),%edx
  800148:	a1 20 30 80 00       	mov    0x803020,%eax
  80014d:	8b 80 34 53 00 00    	mov    0x5334(%eax),%eax
  800153:	89 c1                	mov    %eax,%ecx
  800155:	a1 20 30 80 00       	mov    0x803020,%eax
  80015a:	8b 40 74             	mov    0x74(%eax),%eax
  80015d:	52                   	push   %edx
  80015e:	51                   	push   %ecx
  80015f:	50                   	push   %eax
  800160:	68 29 1d 80 00       	push   $0x801d29
  800165:	e8 7d 15 00 00       	call   8016e7 <sys_create_env>
  80016a:	83 c4 10             	add    $0x10,%esp
  80016d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (ID == E_ENV_CREATION_ERROR)
  800170:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  800174:	75 14                	jne    80018a <_main+0x152>
		panic("RUNNING OUT OF ENV!! terminating...");
  800176:	83 ec 04             	sub    $0x4,%esp
  800179:	68 e8 1c 80 00       	push   $0x801ce8
  80017e:	6a 16                	push   $0x16
  800180:	68 0c 1d 80 00       	push   $0x801d0c
  800185:	e8 5b 01 00 00       	call   8002e5 <_panic>
	sys_run_env(ID);
  80018a:	83 ec 0c             	sub    $0xc,%esp
  80018d:	ff 75 f0             	pushl  -0x10(%ebp)
  800190:	e8 70 15 00 00       	call   801705 <sys_run_env>
  800195:	83 c4 10             	add    $0x10,%esp

	// To wait till other queues filled with other processes
	env_sleep(10000);
  800198:	83 ec 0c             	sub    $0xc,%esp
  80019b:	68 10 27 00 00       	push   $0x2710
  8001a0:	e8 fa 17 00 00       	call   80199f <env_sleep>
  8001a5:	83 c4 10             	add    $0x10,%esp


	// To check that the slave environments completed successfully
	rsttst();
  8001a8:	e8 22 16 00 00       	call   8017cf <rsttst>

	env_sleep(200);
  8001ad:	83 ec 0c             	sub    $0xc,%esp
  8001b0:	68 c8 00 00 00       	push   $0xc8
  8001b5:	e8 e5 17 00 00       	call   80199f <env_sleep>
  8001ba:	83 c4 10             	add    $0x10,%esp
}
  8001bd:	90                   	nop
  8001be:	c9                   	leave  
  8001bf:	c3                   	ret    

008001c0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001c0:	55                   	push   %ebp
  8001c1:	89 e5                	mov    %esp,%ebp
  8001c3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001c6:	e8 fc 11 00 00       	call   8013c7 <sys_getenvindex>
  8001cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001d1:	89 d0                	mov    %edx,%eax
  8001d3:	c1 e0 03             	shl    $0x3,%eax
  8001d6:	01 d0                	add    %edx,%eax
  8001d8:	c1 e0 02             	shl    $0x2,%eax
  8001db:	01 d0                	add    %edx,%eax
  8001dd:	c1 e0 06             	shl    $0x6,%eax
  8001e0:	29 d0                	sub    %edx,%eax
  8001e2:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001e9:	01 c8                	add    %ecx,%eax
  8001eb:	01 d0                	add    %edx,%eax
  8001ed:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8001f2:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001f7:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fc:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  800202:	84 c0                	test   %al,%al
  800204:	74 0f                	je     800215 <libmain+0x55>
		binaryname = myEnv->prog_name;
  800206:	a1 20 30 80 00       	mov    0x803020,%eax
  80020b:	05 b0 52 00 00       	add    $0x52b0,%eax
  800210:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800215:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800219:	7e 0a                	jle    800225 <libmain+0x65>
		binaryname = argv[0];
  80021b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021e:	8b 00                	mov    (%eax),%eax
  800220:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800225:	83 ec 08             	sub    $0x8,%esp
  800228:	ff 75 0c             	pushl  0xc(%ebp)
  80022b:	ff 75 08             	pushl  0x8(%ebp)
  80022e:	e8 05 fe ff ff       	call   800038 <_main>
  800233:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800236:	e8 27 13 00 00       	call   801562 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80023b:	83 ec 0c             	sub    $0xc,%esp
  80023e:	68 54 1d 80 00       	push   $0x801d54
  800243:	e8 54 03 00 00       	call   80059c <cprintf>
  800248:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80024b:	a1 20 30 80 00       	mov    0x803020,%eax
  800250:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800256:	a1 20 30 80 00       	mov    0x803020,%eax
  80025b:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800261:	83 ec 04             	sub    $0x4,%esp
  800264:	52                   	push   %edx
  800265:	50                   	push   %eax
  800266:	68 7c 1d 80 00       	push   $0x801d7c
  80026b:	e8 2c 03 00 00       	call   80059c <cprintf>
  800270:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800273:	a1 20 30 80 00       	mov    0x803020,%eax
  800278:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  80027e:	a1 20 30 80 00       	mov    0x803020,%eax
  800283:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800289:	a1 20 30 80 00       	mov    0x803020,%eax
  80028e:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800294:	51                   	push   %ecx
  800295:	52                   	push   %edx
  800296:	50                   	push   %eax
  800297:	68 a4 1d 80 00       	push   $0x801da4
  80029c:	e8 fb 02 00 00       	call   80059c <cprintf>
  8002a1:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8002a4:	83 ec 0c             	sub    $0xc,%esp
  8002a7:	68 54 1d 80 00       	push   $0x801d54
  8002ac:	e8 eb 02 00 00       	call   80059c <cprintf>
  8002b1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002b4:	e8 c3 12 00 00       	call   80157c <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002b9:	e8 19 00 00 00       	call   8002d7 <exit>
}
  8002be:	90                   	nop
  8002bf:	c9                   	leave  
  8002c0:	c3                   	ret    

008002c1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002c1:	55                   	push   %ebp
  8002c2:	89 e5                	mov    %esp,%ebp
  8002c4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002c7:	83 ec 0c             	sub    $0xc,%esp
  8002ca:	6a 00                	push   $0x0
  8002cc:	e8 c2 10 00 00       	call   801393 <sys_env_destroy>
  8002d1:	83 c4 10             	add    $0x10,%esp
}
  8002d4:	90                   	nop
  8002d5:	c9                   	leave  
  8002d6:	c3                   	ret    

008002d7 <exit>:

void
exit(void)
{
  8002d7:	55                   	push   %ebp
  8002d8:	89 e5                	mov    %esp,%ebp
  8002da:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002dd:	e8 17 11 00 00       	call   8013f9 <sys_env_exit>
}
  8002e2:	90                   	nop
  8002e3:	c9                   	leave  
  8002e4:	c3                   	ret    

008002e5 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002e5:	55                   	push   %ebp
  8002e6:	89 e5                	mov    %esp,%ebp
  8002e8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002eb:	8d 45 10             	lea    0x10(%ebp),%eax
  8002ee:	83 c0 04             	add    $0x4,%eax
  8002f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002f4:	a1 18 31 80 00       	mov    0x803118,%eax
  8002f9:	85 c0                	test   %eax,%eax
  8002fb:	74 16                	je     800313 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002fd:	a1 18 31 80 00       	mov    0x803118,%eax
  800302:	83 ec 08             	sub    $0x8,%esp
  800305:	50                   	push   %eax
  800306:	68 fc 1d 80 00       	push   $0x801dfc
  80030b:	e8 8c 02 00 00       	call   80059c <cprintf>
  800310:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800313:	a1 00 30 80 00       	mov    0x803000,%eax
  800318:	ff 75 0c             	pushl  0xc(%ebp)
  80031b:	ff 75 08             	pushl  0x8(%ebp)
  80031e:	50                   	push   %eax
  80031f:	68 01 1e 80 00       	push   $0x801e01
  800324:	e8 73 02 00 00       	call   80059c <cprintf>
  800329:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80032c:	8b 45 10             	mov    0x10(%ebp),%eax
  80032f:	83 ec 08             	sub    $0x8,%esp
  800332:	ff 75 f4             	pushl  -0xc(%ebp)
  800335:	50                   	push   %eax
  800336:	e8 f6 01 00 00       	call   800531 <vcprintf>
  80033b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80033e:	83 ec 08             	sub    $0x8,%esp
  800341:	6a 00                	push   $0x0
  800343:	68 1d 1e 80 00       	push   $0x801e1d
  800348:	e8 e4 01 00 00       	call   800531 <vcprintf>
  80034d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800350:	e8 82 ff ff ff       	call   8002d7 <exit>

	// should not return here
	while (1) ;
  800355:	eb fe                	jmp    800355 <_panic+0x70>

00800357 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800357:	55                   	push   %ebp
  800358:	89 e5                	mov    %esp,%ebp
  80035a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80035d:	a1 20 30 80 00       	mov    0x803020,%eax
  800362:	8b 50 74             	mov    0x74(%eax),%edx
  800365:	8b 45 0c             	mov    0xc(%ebp),%eax
  800368:	39 c2                	cmp    %eax,%edx
  80036a:	74 14                	je     800380 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80036c:	83 ec 04             	sub    $0x4,%esp
  80036f:	68 20 1e 80 00       	push   $0x801e20
  800374:	6a 26                	push   $0x26
  800376:	68 6c 1e 80 00       	push   $0x801e6c
  80037b:	e8 65 ff ff ff       	call   8002e5 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800380:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800387:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80038e:	e9 c4 00 00 00       	jmp    800457 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800393:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800396:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80039d:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a0:	01 d0                	add    %edx,%eax
  8003a2:	8b 00                	mov    (%eax),%eax
  8003a4:	85 c0                	test   %eax,%eax
  8003a6:	75 08                	jne    8003b0 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003a8:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003ab:	e9 a4 00 00 00       	jmp    800454 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8003b0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003b7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003be:	eb 6b                	jmp    80042b <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c5:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8003cb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003ce:	89 d0                	mov    %edx,%eax
  8003d0:	c1 e0 02             	shl    $0x2,%eax
  8003d3:	01 d0                	add    %edx,%eax
  8003d5:	c1 e0 02             	shl    $0x2,%eax
  8003d8:	01 c8                	add    %ecx,%eax
  8003da:	8a 40 04             	mov    0x4(%eax),%al
  8003dd:	84 c0                	test   %al,%al
  8003df:	75 47                	jne    800428 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e6:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8003ec:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003ef:	89 d0                	mov    %edx,%eax
  8003f1:	c1 e0 02             	shl    $0x2,%eax
  8003f4:	01 d0                	add    %edx,%eax
  8003f6:	c1 e0 02             	shl    $0x2,%eax
  8003f9:	01 c8                	add    %ecx,%eax
  8003fb:	8b 00                	mov    (%eax),%eax
  8003fd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800400:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800403:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800408:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80040a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80040d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800414:	8b 45 08             	mov    0x8(%ebp),%eax
  800417:	01 c8                	add    %ecx,%eax
  800419:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80041b:	39 c2                	cmp    %eax,%edx
  80041d:	75 09                	jne    800428 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80041f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800426:	eb 12                	jmp    80043a <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800428:	ff 45 e8             	incl   -0x18(%ebp)
  80042b:	a1 20 30 80 00       	mov    0x803020,%eax
  800430:	8b 50 74             	mov    0x74(%eax),%edx
  800433:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800436:	39 c2                	cmp    %eax,%edx
  800438:	77 86                	ja     8003c0 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80043a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80043e:	75 14                	jne    800454 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800440:	83 ec 04             	sub    $0x4,%esp
  800443:	68 78 1e 80 00       	push   $0x801e78
  800448:	6a 3a                	push   $0x3a
  80044a:	68 6c 1e 80 00       	push   $0x801e6c
  80044f:	e8 91 fe ff ff       	call   8002e5 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800454:	ff 45 f0             	incl   -0x10(%ebp)
  800457:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80045a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80045d:	0f 8c 30 ff ff ff    	jl     800393 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800463:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80046a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800471:	eb 27                	jmp    80049a <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800473:	a1 20 30 80 00       	mov    0x803020,%eax
  800478:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80047e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800481:	89 d0                	mov    %edx,%eax
  800483:	c1 e0 02             	shl    $0x2,%eax
  800486:	01 d0                	add    %edx,%eax
  800488:	c1 e0 02             	shl    $0x2,%eax
  80048b:	01 c8                	add    %ecx,%eax
  80048d:	8a 40 04             	mov    0x4(%eax),%al
  800490:	3c 01                	cmp    $0x1,%al
  800492:	75 03                	jne    800497 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800494:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800497:	ff 45 e0             	incl   -0x20(%ebp)
  80049a:	a1 20 30 80 00       	mov    0x803020,%eax
  80049f:	8b 50 74             	mov    0x74(%eax),%edx
  8004a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004a5:	39 c2                	cmp    %eax,%edx
  8004a7:	77 ca                	ja     800473 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004ac:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004af:	74 14                	je     8004c5 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8004b1:	83 ec 04             	sub    $0x4,%esp
  8004b4:	68 cc 1e 80 00       	push   $0x801ecc
  8004b9:	6a 44                	push   $0x44
  8004bb:	68 6c 1e 80 00       	push   $0x801e6c
  8004c0:	e8 20 fe ff ff       	call   8002e5 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004c5:	90                   	nop
  8004c6:	c9                   	leave  
  8004c7:	c3                   	ret    

008004c8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004c8:	55                   	push   %ebp
  8004c9:	89 e5                	mov    %esp,%ebp
  8004cb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d1:	8b 00                	mov    (%eax),%eax
  8004d3:	8d 48 01             	lea    0x1(%eax),%ecx
  8004d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004d9:	89 0a                	mov    %ecx,(%edx)
  8004db:	8b 55 08             	mov    0x8(%ebp),%edx
  8004de:	88 d1                	mov    %dl,%cl
  8004e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004e3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ea:	8b 00                	mov    (%eax),%eax
  8004ec:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004f1:	75 2c                	jne    80051f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004f3:	a0 24 30 80 00       	mov    0x803024,%al
  8004f8:	0f b6 c0             	movzbl %al,%eax
  8004fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004fe:	8b 12                	mov    (%edx),%edx
  800500:	89 d1                	mov    %edx,%ecx
  800502:	8b 55 0c             	mov    0xc(%ebp),%edx
  800505:	83 c2 08             	add    $0x8,%edx
  800508:	83 ec 04             	sub    $0x4,%esp
  80050b:	50                   	push   %eax
  80050c:	51                   	push   %ecx
  80050d:	52                   	push   %edx
  80050e:	e8 3e 0e 00 00       	call   801351 <sys_cputs>
  800513:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800516:	8b 45 0c             	mov    0xc(%ebp),%eax
  800519:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80051f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800522:	8b 40 04             	mov    0x4(%eax),%eax
  800525:	8d 50 01             	lea    0x1(%eax),%edx
  800528:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80052e:	90                   	nop
  80052f:	c9                   	leave  
  800530:	c3                   	ret    

00800531 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800531:	55                   	push   %ebp
  800532:	89 e5                	mov    %esp,%ebp
  800534:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80053a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800541:	00 00 00 
	b.cnt = 0;
  800544:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80054b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80054e:	ff 75 0c             	pushl  0xc(%ebp)
  800551:	ff 75 08             	pushl  0x8(%ebp)
  800554:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80055a:	50                   	push   %eax
  80055b:	68 c8 04 80 00       	push   $0x8004c8
  800560:	e8 11 02 00 00       	call   800776 <vprintfmt>
  800565:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800568:	a0 24 30 80 00       	mov    0x803024,%al
  80056d:	0f b6 c0             	movzbl %al,%eax
  800570:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800576:	83 ec 04             	sub    $0x4,%esp
  800579:	50                   	push   %eax
  80057a:	52                   	push   %edx
  80057b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800581:	83 c0 08             	add    $0x8,%eax
  800584:	50                   	push   %eax
  800585:	e8 c7 0d 00 00       	call   801351 <sys_cputs>
  80058a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80058d:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800594:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80059a:	c9                   	leave  
  80059b:	c3                   	ret    

0080059c <cprintf>:

int cprintf(const char *fmt, ...) {
  80059c:	55                   	push   %ebp
  80059d:	89 e5                	mov    %esp,%ebp
  80059f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005a2:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005a9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005af:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b2:	83 ec 08             	sub    $0x8,%esp
  8005b5:	ff 75 f4             	pushl  -0xc(%ebp)
  8005b8:	50                   	push   %eax
  8005b9:	e8 73 ff ff ff       	call   800531 <vcprintf>
  8005be:	83 c4 10             	add    $0x10,%esp
  8005c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005c7:	c9                   	leave  
  8005c8:	c3                   	ret    

008005c9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005c9:	55                   	push   %ebp
  8005ca:	89 e5                	mov    %esp,%ebp
  8005cc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005cf:	e8 8e 0f 00 00       	call   801562 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005d4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005da:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dd:	83 ec 08             	sub    $0x8,%esp
  8005e0:	ff 75 f4             	pushl  -0xc(%ebp)
  8005e3:	50                   	push   %eax
  8005e4:	e8 48 ff ff ff       	call   800531 <vcprintf>
  8005e9:	83 c4 10             	add    $0x10,%esp
  8005ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005ef:	e8 88 0f 00 00       	call   80157c <sys_enable_interrupt>
	return cnt;
  8005f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005f7:	c9                   	leave  
  8005f8:	c3                   	ret    

008005f9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005f9:	55                   	push   %ebp
  8005fa:	89 e5                	mov    %esp,%ebp
  8005fc:	53                   	push   %ebx
  8005fd:	83 ec 14             	sub    $0x14,%esp
  800600:	8b 45 10             	mov    0x10(%ebp),%eax
  800603:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800606:	8b 45 14             	mov    0x14(%ebp),%eax
  800609:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80060c:	8b 45 18             	mov    0x18(%ebp),%eax
  80060f:	ba 00 00 00 00       	mov    $0x0,%edx
  800614:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800617:	77 55                	ja     80066e <printnum+0x75>
  800619:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80061c:	72 05                	jb     800623 <printnum+0x2a>
  80061e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800621:	77 4b                	ja     80066e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800623:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800626:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800629:	8b 45 18             	mov    0x18(%ebp),%eax
  80062c:	ba 00 00 00 00       	mov    $0x0,%edx
  800631:	52                   	push   %edx
  800632:	50                   	push   %eax
  800633:	ff 75 f4             	pushl  -0xc(%ebp)
  800636:	ff 75 f0             	pushl  -0x10(%ebp)
  800639:	e8 16 14 00 00       	call   801a54 <__udivdi3>
  80063e:	83 c4 10             	add    $0x10,%esp
  800641:	83 ec 04             	sub    $0x4,%esp
  800644:	ff 75 20             	pushl  0x20(%ebp)
  800647:	53                   	push   %ebx
  800648:	ff 75 18             	pushl  0x18(%ebp)
  80064b:	52                   	push   %edx
  80064c:	50                   	push   %eax
  80064d:	ff 75 0c             	pushl  0xc(%ebp)
  800650:	ff 75 08             	pushl  0x8(%ebp)
  800653:	e8 a1 ff ff ff       	call   8005f9 <printnum>
  800658:	83 c4 20             	add    $0x20,%esp
  80065b:	eb 1a                	jmp    800677 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80065d:	83 ec 08             	sub    $0x8,%esp
  800660:	ff 75 0c             	pushl  0xc(%ebp)
  800663:	ff 75 20             	pushl  0x20(%ebp)
  800666:	8b 45 08             	mov    0x8(%ebp),%eax
  800669:	ff d0                	call   *%eax
  80066b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80066e:	ff 4d 1c             	decl   0x1c(%ebp)
  800671:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800675:	7f e6                	jg     80065d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800677:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80067a:	bb 00 00 00 00       	mov    $0x0,%ebx
  80067f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800682:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800685:	53                   	push   %ebx
  800686:	51                   	push   %ecx
  800687:	52                   	push   %edx
  800688:	50                   	push   %eax
  800689:	e8 d6 14 00 00       	call   801b64 <__umoddi3>
  80068e:	83 c4 10             	add    $0x10,%esp
  800691:	05 34 21 80 00       	add    $0x802134,%eax
  800696:	8a 00                	mov    (%eax),%al
  800698:	0f be c0             	movsbl %al,%eax
  80069b:	83 ec 08             	sub    $0x8,%esp
  80069e:	ff 75 0c             	pushl  0xc(%ebp)
  8006a1:	50                   	push   %eax
  8006a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a5:	ff d0                	call   *%eax
  8006a7:	83 c4 10             	add    $0x10,%esp
}
  8006aa:	90                   	nop
  8006ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006ae:	c9                   	leave  
  8006af:	c3                   	ret    

008006b0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006b0:	55                   	push   %ebp
  8006b1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006b3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006b7:	7e 1c                	jle    8006d5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	8b 00                	mov    (%eax),%eax
  8006be:	8d 50 08             	lea    0x8(%eax),%edx
  8006c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c4:	89 10                	mov    %edx,(%eax)
  8006c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c9:	8b 00                	mov    (%eax),%eax
  8006cb:	83 e8 08             	sub    $0x8,%eax
  8006ce:	8b 50 04             	mov    0x4(%eax),%edx
  8006d1:	8b 00                	mov    (%eax),%eax
  8006d3:	eb 40                	jmp    800715 <getuint+0x65>
	else if (lflag)
  8006d5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006d9:	74 1e                	je     8006f9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006db:	8b 45 08             	mov    0x8(%ebp),%eax
  8006de:	8b 00                	mov    (%eax),%eax
  8006e0:	8d 50 04             	lea    0x4(%eax),%edx
  8006e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e6:	89 10                	mov    %edx,(%eax)
  8006e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006eb:	8b 00                	mov    (%eax),%eax
  8006ed:	83 e8 04             	sub    $0x4,%eax
  8006f0:	8b 00                	mov    (%eax),%eax
  8006f2:	ba 00 00 00 00       	mov    $0x0,%edx
  8006f7:	eb 1c                	jmp    800715 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fc:	8b 00                	mov    (%eax),%eax
  8006fe:	8d 50 04             	lea    0x4(%eax),%edx
  800701:	8b 45 08             	mov    0x8(%ebp),%eax
  800704:	89 10                	mov    %edx,(%eax)
  800706:	8b 45 08             	mov    0x8(%ebp),%eax
  800709:	8b 00                	mov    (%eax),%eax
  80070b:	83 e8 04             	sub    $0x4,%eax
  80070e:	8b 00                	mov    (%eax),%eax
  800710:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800715:	5d                   	pop    %ebp
  800716:	c3                   	ret    

00800717 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800717:	55                   	push   %ebp
  800718:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80071a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80071e:	7e 1c                	jle    80073c <getint+0x25>
		return va_arg(*ap, long long);
  800720:	8b 45 08             	mov    0x8(%ebp),%eax
  800723:	8b 00                	mov    (%eax),%eax
  800725:	8d 50 08             	lea    0x8(%eax),%edx
  800728:	8b 45 08             	mov    0x8(%ebp),%eax
  80072b:	89 10                	mov    %edx,(%eax)
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	8b 00                	mov    (%eax),%eax
  800732:	83 e8 08             	sub    $0x8,%eax
  800735:	8b 50 04             	mov    0x4(%eax),%edx
  800738:	8b 00                	mov    (%eax),%eax
  80073a:	eb 38                	jmp    800774 <getint+0x5d>
	else if (lflag)
  80073c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800740:	74 1a                	je     80075c <getint+0x45>
		return va_arg(*ap, long);
  800742:	8b 45 08             	mov    0x8(%ebp),%eax
  800745:	8b 00                	mov    (%eax),%eax
  800747:	8d 50 04             	lea    0x4(%eax),%edx
  80074a:	8b 45 08             	mov    0x8(%ebp),%eax
  80074d:	89 10                	mov    %edx,(%eax)
  80074f:	8b 45 08             	mov    0x8(%ebp),%eax
  800752:	8b 00                	mov    (%eax),%eax
  800754:	83 e8 04             	sub    $0x4,%eax
  800757:	8b 00                	mov    (%eax),%eax
  800759:	99                   	cltd   
  80075a:	eb 18                	jmp    800774 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80075c:	8b 45 08             	mov    0x8(%ebp),%eax
  80075f:	8b 00                	mov    (%eax),%eax
  800761:	8d 50 04             	lea    0x4(%eax),%edx
  800764:	8b 45 08             	mov    0x8(%ebp),%eax
  800767:	89 10                	mov    %edx,(%eax)
  800769:	8b 45 08             	mov    0x8(%ebp),%eax
  80076c:	8b 00                	mov    (%eax),%eax
  80076e:	83 e8 04             	sub    $0x4,%eax
  800771:	8b 00                	mov    (%eax),%eax
  800773:	99                   	cltd   
}
  800774:	5d                   	pop    %ebp
  800775:	c3                   	ret    

00800776 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800776:	55                   	push   %ebp
  800777:	89 e5                	mov    %esp,%ebp
  800779:	56                   	push   %esi
  80077a:	53                   	push   %ebx
  80077b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80077e:	eb 17                	jmp    800797 <vprintfmt+0x21>
			if (ch == '\0')
  800780:	85 db                	test   %ebx,%ebx
  800782:	0f 84 af 03 00 00    	je     800b37 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800788:	83 ec 08             	sub    $0x8,%esp
  80078b:	ff 75 0c             	pushl  0xc(%ebp)
  80078e:	53                   	push   %ebx
  80078f:	8b 45 08             	mov    0x8(%ebp),%eax
  800792:	ff d0                	call   *%eax
  800794:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800797:	8b 45 10             	mov    0x10(%ebp),%eax
  80079a:	8d 50 01             	lea    0x1(%eax),%edx
  80079d:	89 55 10             	mov    %edx,0x10(%ebp)
  8007a0:	8a 00                	mov    (%eax),%al
  8007a2:	0f b6 d8             	movzbl %al,%ebx
  8007a5:	83 fb 25             	cmp    $0x25,%ebx
  8007a8:	75 d6                	jne    800780 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007aa:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007ae:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007b5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007bc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007c3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8007cd:	8d 50 01             	lea    0x1(%eax),%edx
  8007d0:	89 55 10             	mov    %edx,0x10(%ebp)
  8007d3:	8a 00                	mov    (%eax),%al
  8007d5:	0f b6 d8             	movzbl %al,%ebx
  8007d8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007db:	83 f8 55             	cmp    $0x55,%eax
  8007de:	0f 87 2b 03 00 00    	ja     800b0f <vprintfmt+0x399>
  8007e4:	8b 04 85 58 21 80 00 	mov    0x802158(,%eax,4),%eax
  8007eb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007ed:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007f1:	eb d7                	jmp    8007ca <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007f3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007f7:	eb d1                	jmp    8007ca <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007f9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800800:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800803:	89 d0                	mov    %edx,%eax
  800805:	c1 e0 02             	shl    $0x2,%eax
  800808:	01 d0                	add    %edx,%eax
  80080a:	01 c0                	add    %eax,%eax
  80080c:	01 d8                	add    %ebx,%eax
  80080e:	83 e8 30             	sub    $0x30,%eax
  800811:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800814:	8b 45 10             	mov    0x10(%ebp),%eax
  800817:	8a 00                	mov    (%eax),%al
  800819:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80081c:	83 fb 2f             	cmp    $0x2f,%ebx
  80081f:	7e 3e                	jle    80085f <vprintfmt+0xe9>
  800821:	83 fb 39             	cmp    $0x39,%ebx
  800824:	7f 39                	jg     80085f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800826:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800829:	eb d5                	jmp    800800 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80082b:	8b 45 14             	mov    0x14(%ebp),%eax
  80082e:	83 c0 04             	add    $0x4,%eax
  800831:	89 45 14             	mov    %eax,0x14(%ebp)
  800834:	8b 45 14             	mov    0x14(%ebp),%eax
  800837:	83 e8 04             	sub    $0x4,%eax
  80083a:	8b 00                	mov    (%eax),%eax
  80083c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80083f:	eb 1f                	jmp    800860 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800841:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800845:	79 83                	jns    8007ca <vprintfmt+0x54>
				width = 0;
  800847:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80084e:	e9 77 ff ff ff       	jmp    8007ca <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800853:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80085a:	e9 6b ff ff ff       	jmp    8007ca <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80085f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800860:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800864:	0f 89 60 ff ff ff    	jns    8007ca <vprintfmt+0x54>
				width = precision, precision = -1;
  80086a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80086d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800870:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800877:	e9 4e ff ff ff       	jmp    8007ca <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80087c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80087f:	e9 46 ff ff ff       	jmp    8007ca <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800884:	8b 45 14             	mov    0x14(%ebp),%eax
  800887:	83 c0 04             	add    $0x4,%eax
  80088a:	89 45 14             	mov    %eax,0x14(%ebp)
  80088d:	8b 45 14             	mov    0x14(%ebp),%eax
  800890:	83 e8 04             	sub    $0x4,%eax
  800893:	8b 00                	mov    (%eax),%eax
  800895:	83 ec 08             	sub    $0x8,%esp
  800898:	ff 75 0c             	pushl  0xc(%ebp)
  80089b:	50                   	push   %eax
  80089c:	8b 45 08             	mov    0x8(%ebp),%eax
  80089f:	ff d0                	call   *%eax
  8008a1:	83 c4 10             	add    $0x10,%esp
			break;
  8008a4:	e9 89 02 00 00       	jmp    800b32 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ac:	83 c0 04             	add    $0x4,%eax
  8008af:	89 45 14             	mov    %eax,0x14(%ebp)
  8008b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b5:	83 e8 04             	sub    $0x4,%eax
  8008b8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008ba:	85 db                	test   %ebx,%ebx
  8008bc:	79 02                	jns    8008c0 <vprintfmt+0x14a>
				err = -err;
  8008be:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008c0:	83 fb 64             	cmp    $0x64,%ebx
  8008c3:	7f 0b                	jg     8008d0 <vprintfmt+0x15a>
  8008c5:	8b 34 9d a0 1f 80 00 	mov    0x801fa0(,%ebx,4),%esi
  8008cc:	85 f6                	test   %esi,%esi
  8008ce:	75 19                	jne    8008e9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008d0:	53                   	push   %ebx
  8008d1:	68 45 21 80 00       	push   $0x802145
  8008d6:	ff 75 0c             	pushl  0xc(%ebp)
  8008d9:	ff 75 08             	pushl  0x8(%ebp)
  8008dc:	e8 5e 02 00 00       	call   800b3f <printfmt>
  8008e1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008e4:	e9 49 02 00 00       	jmp    800b32 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008e9:	56                   	push   %esi
  8008ea:	68 4e 21 80 00       	push   $0x80214e
  8008ef:	ff 75 0c             	pushl  0xc(%ebp)
  8008f2:	ff 75 08             	pushl  0x8(%ebp)
  8008f5:	e8 45 02 00 00       	call   800b3f <printfmt>
  8008fa:	83 c4 10             	add    $0x10,%esp
			break;
  8008fd:	e9 30 02 00 00       	jmp    800b32 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800902:	8b 45 14             	mov    0x14(%ebp),%eax
  800905:	83 c0 04             	add    $0x4,%eax
  800908:	89 45 14             	mov    %eax,0x14(%ebp)
  80090b:	8b 45 14             	mov    0x14(%ebp),%eax
  80090e:	83 e8 04             	sub    $0x4,%eax
  800911:	8b 30                	mov    (%eax),%esi
  800913:	85 f6                	test   %esi,%esi
  800915:	75 05                	jne    80091c <vprintfmt+0x1a6>
				p = "(null)";
  800917:	be 51 21 80 00       	mov    $0x802151,%esi
			if (width > 0 && padc != '-')
  80091c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800920:	7e 6d                	jle    80098f <vprintfmt+0x219>
  800922:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800926:	74 67                	je     80098f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800928:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80092b:	83 ec 08             	sub    $0x8,%esp
  80092e:	50                   	push   %eax
  80092f:	56                   	push   %esi
  800930:	e8 0c 03 00 00       	call   800c41 <strnlen>
  800935:	83 c4 10             	add    $0x10,%esp
  800938:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80093b:	eb 16                	jmp    800953 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80093d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800941:	83 ec 08             	sub    $0x8,%esp
  800944:	ff 75 0c             	pushl  0xc(%ebp)
  800947:	50                   	push   %eax
  800948:	8b 45 08             	mov    0x8(%ebp),%eax
  80094b:	ff d0                	call   *%eax
  80094d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800950:	ff 4d e4             	decl   -0x1c(%ebp)
  800953:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800957:	7f e4                	jg     80093d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800959:	eb 34                	jmp    80098f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80095b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80095f:	74 1c                	je     80097d <vprintfmt+0x207>
  800961:	83 fb 1f             	cmp    $0x1f,%ebx
  800964:	7e 05                	jle    80096b <vprintfmt+0x1f5>
  800966:	83 fb 7e             	cmp    $0x7e,%ebx
  800969:	7e 12                	jle    80097d <vprintfmt+0x207>
					putch('?', putdat);
  80096b:	83 ec 08             	sub    $0x8,%esp
  80096e:	ff 75 0c             	pushl  0xc(%ebp)
  800971:	6a 3f                	push   $0x3f
  800973:	8b 45 08             	mov    0x8(%ebp),%eax
  800976:	ff d0                	call   *%eax
  800978:	83 c4 10             	add    $0x10,%esp
  80097b:	eb 0f                	jmp    80098c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80097d:	83 ec 08             	sub    $0x8,%esp
  800980:	ff 75 0c             	pushl  0xc(%ebp)
  800983:	53                   	push   %ebx
  800984:	8b 45 08             	mov    0x8(%ebp),%eax
  800987:	ff d0                	call   *%eax
  800989:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80098c:	ff 4d e4             	decl   -0x1c(%ebp)
  80098f:	89 f0                	mov    %esi,%eax
  800991:	8d 70 01             	lea    0x1(%eax),%esi
  800994:	8a 00                	mov    (%eax),%al
  800996:	0f be d8             	movsbl %al,%ebx
  800999:	85 db                	test   %ebx,%ebx
  80099b:	74 24                	je     8009c1 <vprintfmt+0x24b>
  80099d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009a1:	78 b8                	js     80095b <vprintfmt+0x1e5>
  8009a3:	ff 4d e0             	decl   -0x20(%ebp)
  8009a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009aa:	79 af                	jns    80095b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009ac:	eb 13                	jmp    8009c1 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009ae:	83 ec 08             	sub    $0x8,%esp
  8009b1:	ff 75 0c             	pushl  0xc(%ebp)
  8009b4:	6a 20                	push   $0x20
  8009b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b9:	ff d0                	call   *%eax
  8009bb:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009be:	ff 4d e4             	decl   -0x1c(%ebp)
  8009c1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009c5:	7f e7                	jg     8009ae <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009c7:	e9 66 01 00 00       	jmp    800b32 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009cc:	83 ec 08             	sub    $0x8,%esp
  8009cf:	ff 75 e8             	pushl  -0x18(%ebp)
  8009d2:	8d 45 14             	lea    0x14(%ebp),%eax
  8009d5:	50                   	push   %eax
  8009d6:	e8 3c fd ff ff       	call   800717 <getint>
  8009db:	83 c4 10             	add    $0x10,%esp
  8009de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009ea:	85 d2                	test   %edx,%edx
  8009ec:	79 23                	jns    800a11 <vprintfmt+0x29b>
				putch('-', putdat);
  8009ee:	83 ec 08             	sub    $0x8,%esp
  8009f1:	ff 75 0c             	pushl  0xc(%ebp)
  8009f4:	6a 2d                	push   $0x2d
  8009f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f9:	ff d0                	call   *%eax
  8009fb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a01:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a04:	f7 d8                	neg    %eax
  800a06:	83 d2 00             	adc    $0x0,%edx
  800a09:	f7 da                	neg    %edx
  800a0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a0e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a11:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a18:	e9 bc 00 00 00       	jmp    800ad9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a1d:	83 ec 08             	sub    $0x8,%esp
  800a20:	ff 75 e8             	pushl  -0x18(%ebp)
  800a23:	8d 45 14             	lea    0x14(%ebp),%eax
  800a26:	50                   	push   %eax
  800a27:	e8 84 fc ff ff       	call   8006b0 <getuint>
  800a2c:	83 c4 10             	add    $0x10,%esp
  800a2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a32:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a35:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a3c:	e9 98 00 00 00       	jmp    800ad9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a41:	83 ec 08             	sub    $0x8,%esp
  800a44:	ff 75 0c             	pushl  0xc(%ebp)
  800a47:	6a 58                	push   $0x58
  800a49:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4c:	ff d0                	call   *%eax
  800a4e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a51:	83 ec 08             	sub    $0x8,%esp
  800a54:	ff 75 0c             	pushl  0xc(%ebp)
  800a57:	6a 58                	push   $0x58
  800a59:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5c:	ff d0                	call   *%eax
  800a5e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a61:	83 ec 08             	sub    $0x8,%esp
  800a64:	ff 75 0c             	pushl  0xc(%ebp)
  800a67:	6a 58                	push   $0x58
  800a69:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6c:	ff d0                	call   *%eax
  800a6e:	83 c4 10             	add    $0x10,%esp
			break;
  800a71:	e9 bc 00 00 00       	jmp    800b32 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a76:	83 ec 08             	sub    $0x8,%esp
  800a79:	ff 75 0c             	pushl  0xc(%ebp)
  800a7c:	6a 30                	push   $0x30
  800a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a81:	ff d0                	call   *%eax
  800a83:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a86:	83 ec 08             	sub    $0x8,%esp
  800a89:	ff 75 0c             	pushl  0xc(%ebp)
  800a8c:	6a 78                	push   $0x78
  800a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a91:	ff d0                	call   *%eax
  800a93:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a96:	8b 45 14             	mov    0x14(%ebp),%eax
  800a99:	83 c0 04             	add    $0x4,%eax
  800a9c:	89 45 14             	mov    %eax,0x14(%ebp)
  800a9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa2:	83 e8 04             	sub    $0x4,%eax
  800aa5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800aa7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aaa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ab1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ab8:	eb 1f                	jmp    800ad9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800aba:	83 ec 08             	sub    $0x8,%esp
  800abd:	ff 75 e8             	pushl  -0x18(%ebp)
  800ac0:	8d 45 14             	lea    0x14(%ebp),%eax
  800ac3:	50                   	push   %eax
  800ac4:	e8 e7 fb ff ff       	call   8006b0 <getuint>
  800ac9:	83 c4 10             	add    $0x10,%esp
  800acc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800acf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ad2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ad9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800add:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ae0:	83 ec 04             	sub    $0x4,%esp
  800ae3:	52                   	push   %edx
  800ae4:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ae7:	50                   	push   %eax
  800ae8:	ff 75 f4             	pushl  -0xc(%ebp)
  800aeb:	ff 75 f0             	pushl  -0x10(%ebp)
  800aee:	ff 75 0c             	pushl  0xc(%ebp)
  800af1:	ff 75 08             	pushl  0x8(%ebp)
  800af4:	e8 00 fb ff ff       	call   8005f9 <printnum>
  800af9:	83 c4 20             	add    $0x20,%esp
			break;
  800afc:	eb 34                	jmp    800b32 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800afe:	83 ec 08             	sub    $0x8,%esp
  800b01:	ff 75 0c             	pushl  0xc(%ebp)
  800b04:	53                   	push   %ebx
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	ff d0                	call   *%eax
  800b0a:	83 c4 10             	add    $0x10,%esp
			break;
  800b0d:	eb 23                	jmp    800b32 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b0f:	83 ec 08             	sub    $0x8,%esp
  800b12:	ff 75 0c             	pushl  0xc(%ebp)
  800b15:	6a 25                	push   $0x25
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1a:	ff d0                	call   *%eax
  800b1c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b1f:	ff 4d 10             	decl   0x10(%ebp)
  800b22:	eb 03                	jmp    800b27 <vprintfmt+0x3b1>
  800b24:	ff 4d 10             	decl   0x10(%ebp)
  800b27:	8b 45 10             	mov    0x10(%ebp),%eax
  800b2a:	48                   	dec    %eax
  800b2b:	8a 00                	mov    (%eax),%al
  800b2d:	3c 25                	cmp    $0x25,%al
  800b2f:	75 f3                	jne    800b24 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b31:	90                   	nop
		}
	}
  800b32:	e9 47 fc ff ff       	jmp    80077e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b37:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b38:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b3b:	5b                   	pop    %ebx
  800b3c:	5e                   	pop    %esi
  800b3d:	5d                   	pop    %ebp
  800b3e:	c3                   	ret    

00800b3f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b3f:	55                   	push   %ebp
  800b40:	89 e5                	mov    %esp,%ebp
  800b42:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b45:	8d 45 10             	lea    0x10(%ebp),%eax
  800b48:	83 c0 04             	add    $0x4,%eax
  800b4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b51:	ff 75 f4             	pushl  -0xc(%ebp)
  800b54:	50                   	push   %eax
  800b55:	ff 75 0c             	pushl  0xc(%ebp)
  800b58:	ff 75 08             	pushl  0x8(%ebp)
  800b5b:	e8 16 fc ff ff       	call   800776 <vprintfmt>
  800b60:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b63:	90                   	nop
  800b64:	c9                   	leave  
  800b65:	c3                   	ret    

00800b66 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b66:	55                   	push   %ebp
  800b67:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6c:	8b 40 08             	mov    0x8(%eax),%eax
  800b6f:	8d 50 01             	lea    0x1(%eax),%edx
  800b72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b75:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7b:	8b 10                	mov    (%eax),%edx
  800b7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b80:	8b 40 04             	mov    0x4(%eax),%eax
  800b83:	39 c2                	cmp    %eax,%edx
  800b85:	73 12                	jae    800b99 <sprintputch+0x33>
		*b->buf++ = ch;
  800b87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8a:	8b 00                	mov    (%eax),%eax
  800b8c:	8d 48 01             	lea    0x1(%eax),%ecx
  800b8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b92:	89 0a                	mov    %ecx,(%edx)
  800b94:	8b 55 08             	mov    0x8(%ebp),%edx
  800b97:	88 10                	mov    %dl,(%eax)
}
  800b99:	90                   	nop
  800b9a:	5d                   	pop    %ebp
  800b9b:	c3                   	ret    

00800b9c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b9c:	55                   	push   %ebp
  800b9d:	89 e5                	mov    %esp,%ebp
  800b9f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ba8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bab:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bae:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb1:	01 d0                	add    %edx,%eax
  800bb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bb6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bbd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bc1:	74 06                	je     800bc9 <vsnprintf+0x2d>
  800bc3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc7:	7f 07                	jg     800bd0 <vsnprintf+0x34>
		return -E_INVAL;
  800bc9:	b8 03 00 00 00       	mov    $0x3,%eax
  800bce:	eb 20                	jmp    800bf0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bd0:	ff 75 14             	pushl  0x14(%ebp)
  800bd3:	ff 75 10             	pushl  0x10(%ebp)
  800bd6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bd9:	50                   	push   %eax
  800bda:	68 66 0b 80 00       	push   $0x800b66
  800bdf:	e8 92 fb ff ff       	call   800776 <vprintfmt>
  800be4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800be7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bea:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bed:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800bf0:	c9                   	leave  
  800bf1:	c3                   	ret    

00800bf2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bf2:	55                   	push   %ebp
  800bf3:	89 e5                	mov    %esp,%ebp
  800bf5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bf8:	8d 45 10             	lea    0x10(%ebp),%eax
  800bfb:	83 c0 04             	add    $0x4,%eax
  800bfe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c01:	8b 45 10             	mov    0x10(%ebp),%eax
  800c04:	ff 75 f4             	pushl  -0xc(%ebp)
  800c07:	50                   	push   %eax
  800c08:	ff 75 0c             	pushl  0xc(%ebp)
  800c0b:	ff 75 08             	pushl  0x8(%ebp)
  800c0e:	e8 89 ff ff ff       	call   800b9c <vsnprintf>
  800c13:	83 c4 10             	add    $0x10,%esp
  800c16:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c19:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c1c:	c9                   	leave  
  800c1d:	c3                   	ret    

00800c1e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c1e:	55                   	push   %ebp
  800c1f:	89 e5                	mov    %esp,%ebp
  800c21:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c24:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c2b:	eb 06                	jmp    800c33 <strlen+0x15>
		n++;
  800c2d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c30:	ff 45 08             	incl   0x8(%ebp)
  800c33:	8b 45 08             	mov    0x8(%ebp),%eax
  800c36:	8a 00                	mov    (%eax),%al
  800c38:	84 c0                	test   %al,%al
  800c3a:	75 f1                	jne    800c2d <strlen+0xf>
		n++;
	return n;
  800c3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c3f:	c9                   	leave  
  800c40:	c3                   	ret    

00800c41 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c41:	55                   	push   %ebp
  800c42:	89 e5                	mov    %esp,%ebp
  800c44:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c47:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c4e:	eb 09                	jmp    800c59 <strnlen+0x18>
		n++;
  800c50:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c53:	ff 45 08             	incl   0x8(%ebp)
  800c56:	ff 4d 0c             	decl   0xc(%ebp)
  800c59:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c5d:	74 09                	je     800c68 <strnlen+0x27>
  800c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c62:	8a 00                	mov    (%eax),%al
  800c64:	84 c0                	test   %al,%al
  800c66:	75 e8                	jne    800c50 <strnlen+0xf>
		n++;
	return n;
  800c68:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c6b:	c9                   	leave  
  800c6c:	c3                   	ret    

00800c6d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c6d:	55                   	push   %ebp
  800c6e:	89 e5                	mov    %esp,%ebp
  800c70:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c79:	90                   	nop
  800c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7d:	8d 50 01             	lea    0x1(%eax),%edx
  800c80:	89 55 08             	mov    %edx,0x8(%ebp)
  800c83:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c86:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c89:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c8c:	8a 12                	mov    (%edx),%dl
  800c8e:	88 10                	mov    %dl,(%eax)
  800c90:	8a 00                	mov    (%eax),%al
  800c92:	84 c0                	test   %al,%al
  800c94:	75 e4                	jne    800c7a <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c96:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c99:	c9                   	leave  
  800c9a:	c3                   	ret    

00800c9b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c9b:	55                   	push   %ebp
  800c9c:	89 e5                	mov    %esp,%ebp
  800c9e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ca7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cae:	eb 1f                	jmp    800ccf <strncpy+0x34>
		*dst++ = *src;
  800cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb3:	8d 50 01             	lea    0x1(%eax),%edx
  800cb6:	89 55 08             	mov    %edx,0x8(%ebp)
  800cb9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cbc:	8a 12                	mov    (%edx),%dl
  800cbe:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc3:	8a 00                	mov    (%eax),%al
  800cc5:	84 c0                	test   %al,%al
  800cc7:	74 03                	je     800ccc <strncpy+0x31>
			src++;
  800cc9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ccc:	ff 45 fc             	incl   -0x4(%ebp)
  800ccf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cd2:	3b 45 10             	cmp    0x10(%ebp),%eax
  800cd5:	72 d9                	jb     800cb0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800cd7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800cda:	c9                   	leave  
  800cdb:	c3                   	ret    

00800cdc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800cdc:	55                   	push   %ebp
  800cdd:	89 e5                	mov    %esp,%ebp
  800cdf:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ce8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cec:	74 30                	je     800d1e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800cee:	eb 16                	jmp    800d06 <strlcpy+0x2a>
			*dst++ = *src++;
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	8d 50 01             	lea    0x1(%eax),%edx
  800cf6:	89 55 08             	mov    %edx,0x8(%ebp)
  800cf9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cfc:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cff:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d02:	8a 12                	mov    (%edx),%dl
  800d04:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d06:	ff 4d 10             	decl   0x10(%ebp)
  800d09:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d0d:	74 09                	je     800d18 <strlcpy+0x3c>
  800d0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d12:	8a 00                	mov    (%eax),%al
  800d14:	84 c0                	test   %al,%al
  800d16:	75 d8                	jne    800cf0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d1e:	8b 55 08             	mov    0x8(%ebp),%edx
  800d21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d24:	29 c2                	sub    %eax,%edx
  800d26:	89 d0                	mov    %edx,%eax
}
  800d28:	c9                   	leave  
  800d29:	c3                   	ret    

00800d2a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d2a:	55                   	push   %ebp
  800d2b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d2d:	eb 06                	jmp    800d35 <strcmp+0xb>
		p++, q++;
  800d2f:	ff 45 08             	incl   0x8(%ebp)
  800d32:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8a 00                	mov    (%eax),%al
  800d3a:	84 c0                	test   %al,%al
  800d3c:	74 0e                	je     800d4c <strcmp+0x22>
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	8a 10                	mov    (%eax),%dl
  800d43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d46:	8a 00                	mov    (%eax),%al
  800d48:	38 c2                	cmp    %al,%dl
  800d4a:	74 e3                	je     800d2f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	0f b6 d0             	movzbl %al,%edx
  800d54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d57:	8a 00                	mov    (%eax),%al
  800d59:	0f b6 c0             	movzbl %al,%eax
  800d5c:	29 c2                	sub    %eax,%edx
  800d5e:	89 d0                	mov    %edx,%eax
}
  800d60:	5d                   	pop    %ebp
  800d61:	c3                   	ret    

00800d62 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d62:	55                   	push   %ebp
  800d63:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d65:	eb 09                	jmp    800d70 <strncmp+0xe>
		n--, p++, q++;
  800d67:	ff 4d 10             	decl   0x10(%ebp)
  800d6a:	ff 45 08             	incl   0x8(%ebp)
  800d6d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d70:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d74:	74 17                	je     800d8d <strncmp+0x2b>
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	8a 00                	mov    (%eax),%al
  800d7b:	84 c0                	test   %al,%al
  800d7d:	74 0e                	je     800d8d <strncmp+0x2b>
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	8a 10                	mov    (%eax),%dl
  800d84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d87:	8a 00                	mov    (%eax),%al
  800d89:	38 c2                	cmp    %al,%dl
  800d8b:	74 da                	je     800d67 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d8d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d91:	75 07                	jne    800d9a <strncmp+0x38>
		return 0;
  800d93:	b8 00 00 00 00       	mov    $0x0,%eax
  800d98:	eb 14                	jmp    800dae <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9d:	8a 00                	mov    (%eax),%al
  800d9f:	0f b6 d0             	movzbl %al,%edx
  800da2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da5:	8a 00                	mov    (%eax),%al
  800da7:	0f b6 c0             	movzbl %al,%eax
  800daa:	29 c2                	sub    %eax,%edx
  800dac:	89 d0                	mov    %edx,%eax
}
  800dae:	5d                   	pop    %ebp
  800daf:	c3                   	ret    

00800db0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800db0:	55                   	push   %ebp
  800db1:	89 e5                	mov    %esp,%ebp
  800db3:	83 ec 04             	sub    $0x4,%esp
  800db6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dbc:	eb 12                	jmp    800dd0 <strchr+0x20>
		if (*s == c)
  800dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc1:	8a 00                	mov    (%eax),%al
  800dc3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dc6:	75 05                	jne    800dcd <strchr+0x1d>
			return (char *) s;
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	eb 11                	jmp    800dde <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dcd:	ff 45 08             	incl   0x8(%ebp)
  800dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd3:	8a 00                	mov    (%eax),%al
  800dd5:	84 c0                	test   %al,%al
  800dd7:	75 e5                	jne    800dbe <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800dd9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800dde:	c9                   	leave  
  800ddf:	c3                   	ret    

00800de0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800de0:	55                   	push   %ebp
  800de1:	89 e5                	mov    %esp,%ebp
  800de3:	83 ec 04             	sub    $0x4,%esp
  800de6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dec:	eb 0d                	jmp    800dfb <strfind+0x1b>
		if (*s == c)
  800dee:	8b 45 08             	mov    0x8(%ebp),%eax
  800df1:	8a 00                	mov    (%eax),%al
  800df3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800df6:	74 0e                	je     800e06 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800df8:	ff 45 08             	incl   0x8(%ebp)
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfe:	8a 00                	mov    (%eax),%al
  800e00:	84 c0                	test   %al,%al
  800e02:	75 ea                	jne    800dee <strfind+0xe>
  800e04:	eb 01                	jmp    800e07 <strfind+0x27>
		if (*s == c)
			break;
  800e06:	90                   	nop
	return (char *) s;
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e0a:	c9                   	leave  
  800e0b:	c3                   	ret    

00800e0c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e0c:	55                   	push   %ebp
  800e0d:	89 e5                	mov    %esp,%ebp
  800e0f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e18:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e1e:	eb 0e                	jmp    800e2e <memset+0x22>
		*p++ = c;
  800e20:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e23:	8d 50 01             	lea    0x1(%eax),%edx
  800e26:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e29:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e2c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e2e:	ff 4d f8             	decl   -0x8(%ebp)
  800e31:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e35:	79 e9                	jns    800e20 <memset+0x14>
		*p++ = c;

	return v;
  800e37:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e3a:	c9                   	leave  
  800e3b:	c3                   	ret    

00800e3c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e3c:	55                   	push   %ebp
  800e3d:	89 e5                	mov    %esp,%ebp
  800e3f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e45:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e4e:	eb 16                	jmp    800e66 <memcpy+0x2a>
		*d++ = *s++;
  800e50:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e53:	8d 50 01             	lea    0x1(%eax),%edx
  800e56:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e59:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e5c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e5f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e62:	8a 12                	mov    (%edx),%dl
  800e64:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e66:	8b 45 10             	mov    0x10(%ebp),%eax
  800e69:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e6c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e6f:	85 c0                	test   %eax,%eax
  800e71:	75 dd                	jne    800e50 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e73:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e76:	c9                   	leave  
  800e77:	c3                   	ret    

00800e78 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e78:	55                   	push   %ebp
  800e79:	89 e5                	mov    %esp,%ebp
  800e7b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e81:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e8a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e8d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e90:	73 50                	jae    800ee2 <memmove+0x6a>
  800e92:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e95:	8b 45 10             	mov    0x10(%ebp),%eax
  800e98:	01 d0                	add    %edx,%eax
  800e9a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e9d:	76 43                	jbe    800ee2 <memmove+0x6a>
		s += n;
  800e9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ea5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800eab:	eb 10                	jmp    800ebd <memmove+0x45>
			*--d = *--s;
  800ead:	ff 4d f8             	decl   -0x8(%ebp)
  800eb0:	ff 4d fc             	decl   -0x4(%ebp)
  800eb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb6:	8a 10                	mov    (%eax),%dl
  800eb8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ebb:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ebd:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec3:	89 55 10             	mov    %edx,0x10(%ebp)
  800ec6:	85 c0                	test   %eax,%eax
  800ec8:	75 e3                	jne    800ead <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800eca:	eb 23                	jmp    800eef <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ecc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ecf:	8d 50 01             	lea    0x1(%eax),%edx
  800ed2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ed5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ed8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800edb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ede:	8a 12                	mov    (%edx),%dl
  800ee0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ee2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ee8:	89 55 10             	mov    %edx,0x10(%ebp)
  800eeb:	85 c0                	test   %eax,%eax
  800eed:	75 dd                	jne    800ecc <memmove+0x54>
			*d++ = *s++;

	return dst;
  800eef:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ef2:	c9                   	leave  
  800ef3:	c3                   	ret    

00800ef4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ef4:	55                   	push   %ebp
  800ef5:	89 e5                	mov    %esp,%ebp
  800ef7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800efa:	8b 45 08             	mov    0x8(%ebp),%eax
  800efd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f03:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f06:	eb 2a                	jmp    800f32 <memcmp+0x3e>
		if (*s1 != *s2)
  800f08:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f0b:	8a 10                	mov    (%eax),%dl
  800f0d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	38 c2                	cmp    %al,%dl
  800f14:	74 16                	je     800f2c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f19:	8a 00                	mov    (%eax),%al
  800f1b:	0f b6 d0             	movzbl %al,%edx
  800f1e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f21:	8a 00                	mov    (%eax),%al
  800f23:	0f b6 c0             	movzbl %al,%eax
  800f26:	29 c2                	sub    %eax,%edx
  800f28:	89 d0                	mov    %edx,%eax
  800f2a:	eb 18                	jmp    800f44 <memcmp+0x50>
		s1++, s2++;
  800f2c:	ff 45 fc             	incl   -0x4(%ebp)
  800f2f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f32:	8b 45 10             	mov    0x10(%ebp),%eax
  800f35:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f38:	89 55 10             	mov    %edx,0x10(%ebp)
  800f3b:	85 c0                	test   %eax,%eax
  800f3d:	75 c9                	jne    800f08 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f3f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f44:	c9                   	leave  
  800f45:	c3                   	ret    

00800f46 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f46:	55                   	push   %ebp
  800f47:	89 e5                	mov    %esp,%ebp
  800f49:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f4c:	8b 55 08             	mov    0x8(%ebp),%edx
  800f4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f52:	01 d0                	add    %edx,%eax
  800f54:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f57:	eb 15                	jmp    800f6e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	8a 00                	mov    (%eax),%al
  800f5e:	0f b6 d0             	movzbl %al,%edx
  800f61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f64:	0f b6 c0             	movzbl %al,%eax
  800f67:	39 c2                	cmp    %eax,%edx
  800f69:	74 0d                	je     800f78 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f6b:	ff 45 08             	incl   0x8(%ebp)
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f71:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f74:	72 e3                	jb     800f59 <memfind+0x13>
  800f76:	eb 01                	jmp    800f79 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f78:	90                   	nop
	return (void *) s;
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f7c:	c9                   	leave  
  800f7d:	c3                   	ret    

00800f7e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f7e:	55                   	push   %ebp
  800f7f:	89 e5                	mov    %esp,%ebp
  800f81:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f84:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f8b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f92:	eb 03                	jmp    800f97 <strtol+0x19>
		s++;
  800f94:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	3c 20                	cmp    $0x20,%al
  800f9e:	74 f4                	je     800f94 <strtol+0x16>
  800fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa3:	8a 00                	mov    (%eax),%al
  800fa5:	3c 09                	cmp    $0x9,%al
  800fa7:	74 eb                	je     800f94 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800fa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fac:	8a 00                	mov    (%eax),%al
  800fae:	3c 2b                	cmp    $0x2b,%al
  800fb0:	75 05                	jne    800fb7 <strtol+0x39>
		s++;
  800fb2:	ff 45 08             	incl   0x8(%ebp)
  800fb5:	eb 13                	jmp    800fca <strtol+0x4c>
	else if (*s == '-')
  800fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	3c 2d                	cmp    $0x2d,%al
  800fbe:	75 0a                	jne    800fca <strtol+0x4c>
		s++, neg = 1;
  800fc0:	ff 45 08             	incl   0x8(%ebp)
  800fc3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fce:	74 06                	je     800fd6 <strtol+0x58>
  800fd0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fd4:	75 20                	jne    800ff6 <strtol+0x78>
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd9:	8a 00                	mov    (%eax),%al
  800fdb:	3c 30                	cmp    $0x30,%al
  800fdd:	75 17                	jne    800ff6 <strtol+0x78>
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe2:	40                   	inc    %eax
  800fe3:	8a 00                	mov    (%eax),%al
  800fe5:	3c 78                	cmp    $0x78,%al
  800fe7:	75 0d                	jne    800ff6 <strtol+0x78>
		s += 2, base = 16;
  800fe9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fed:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ff4:	eb 28                	jmp    80101e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ff6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ffa:	75 15                	jne    801011 <strtol+0x93>
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	8a 00                	mov    (%eax),%al
  801001:	3c 30                	cmp    $0x30,%al
  801003:	75 0c                	jne    801011 <strtol+0x93>
		s++, base = 8;
  801005:	ff 45 08             	incl   0x8(%ebp)
  801008:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80100f:	eb 0d                	jmp    80101e <strtol+0xa0>
	else if (base == 0)
  801011:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801015:	75 07                	jne    80101e <strtol+0xa0>
		base = 10;
  801017:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80101e:	8b 45 08             	mov    0x8(%ebp),%eax
  801021:	8a 00                	mov    (%eax),%al
  801023:	3c 2f                	cmp    $0x2f,%al
  801025:	7e 19                	jle    801040 <strtol+0xc2>
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	8a 00                	mov    (%eax),%al
  80102c:	3c 39                	cmp    $0x39,%al
  80102e:	7f 10                	jg     801040 <strtol+0xc2>
			dig = *s - '0';
  801030:	8b 45 08             	mov    0x8(%ebp),%eax
  801033:	8a 00                	mov    (%eax),%al
  801035:	0f be c0             	movsbl %al,%eax
  801038:	83 e8 30             	sub    $0x30,%eax
  80103b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80103e:	eb 42                	jmp    801082 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801040:	8b 45 08             	mov    0x8(%ebp),%eax
  801043:	8a 00                	mov    (%eax),%al
  801045:	3c 60                	cmp    $0x60,%al
  801047:	7e 19                	jle    801062 <strtol+0xe4>
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	8a 00                	mov    (%eax),%al
  80104e:	3c 7a                	cmp    $0x7a,%al
  801050:	7f 10                	jg     801062 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	8a 00                	mov    (%eax),%al
  801057:	0f be c0             	movsbl %al,%eax
  80105a:	83 e8 57             	sub    $0x57,%eax
  80105d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801060:	eb 20                	jmp    801082 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801062:	8b 45 08             	mov    0x8(%ebp),%eax
  801065:	8a 00                	mov    (%eax),%al
  801067:	3c 40                	cmp    $0x40,%al
  801069:	7e 39                	jle    8010a4 <strtol+0x126>
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	8a 00                	mov    (%eax),%al
  801070:	3c 5a                	cmp    $0x5a,%al
  801072:	7f 30                	jg     8010a4 <strtol+0x126>
			dig = *s - 'A' + 10;
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	8a 00                	mov    (%eax),%al
  801079:	0f be c0             	movsbl %al,%eax
  80107c:	83 e8 37             	sub    $0x37,%eax
  80107f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801082:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801085:	3b 45 10             	cmp    0x10(%ebp),%eax
  801088:	7d 19                	jge    8010a3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80108a:	ff 45 08             	incl   0x8(%ebp)
  80108d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801090:	0f af 45 10          	imul   0x10(%ebp),%eax
  801094:	89 c2                	mov    %eax,%edx
  801096:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801099:	01 d0                	add    %edx,%eax
  80109b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80109e:	e9 7b ff ff ff       	jmp    80101e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010a3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010a4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010a8:	74 08                	je     8010b2 <strtol+0x134>
		*endptr = (char *) s;
  8010aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ad:	8b 55 08             	mov    0x8(%ebp),%edx
  8010b0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010b2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010b6:	74 07                	je     8010bf <strtol+0x141>
  8010b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010bb:	f7 d8                	neg    %eax
  8010bd:	eb 03                	jmp    8010c2 <strtol+0x144>
  8010bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010c2:	c9                   	leave  
  8010c3:	c3                   	ret    

008010c4 <ltostr>:

void
ltostr(long value, char *str)
{
  8010c4:	55                   	push   %ebp
  8010c5:	89 e5                	mov    %esp,%ebp
  8010c7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010d8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010dc:	79 13                	jns    8010f1 <ltostr+0x2d>
	{
		neg = 1;
  8010de:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010eb:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010ee:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010f9:	99                   	cltd   
  8010fa:	f7 f9                	idiv   %ecx
  8010fc:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801102:	8d 50 01             	lea    0x1(%eax),%edx
  801105:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801108:	89 c2                	mov    %eax,%edx
  80110a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110d:	01 d0                	add    %edx,%eax
  80110f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801112:	83 c2 30             	add    $0x30,%edx
  801115:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801117:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80111a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80111f:	f7 e9                	imul   %ecx
  801121:	c1 fa 02             	sar    $0x2,%edx
  801124:	89 c8                	mov    %ecx,%eax
  801126:	c1 f8 1f             	sar    $0x1f,%eax
  801129:	29 c2                	sub    %eax,%edx
  80112b:	89 d0                	mov    %edx,%eax
  80112d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801130:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801133:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801138:	f7 e9                	imul   %ecx
  80113a:	c1 fa 02             	sar    $0x2,%edx
  80113d:	89 c8                	mov    %ecx,%eax
  80113f:	c1 f8 1f             	sar    $0x1f,%eax
  801142:	29 c2                	sub    %eax,%edx
  801144:	89 d0                	mov    %edx,%eax
  801146:	c1 e0 02             	shl    $0x2,%eax
  801149:	01 d0                	add    %edx,%eax
  80114b:	01 c0                	add    %eax,%eax
  80114d:	29 c1                	sub    %eax,%ecx
  80114f:	89 ca                	mov    %ecx,%edx
  801151:	85 d2                	test   %edx,%edx
  801153:	75 9c                	jne    8010f1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801155:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80115c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80115f:	48                   	dec    %eax
  801160:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801163:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801167:	74 3d                	je     8011a6 <ltostr+0xe2>
		start = 1 ;
  801169:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801170:	eb 34                	jmp    8011a6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801172:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801175:	8b 45 0c             	mov    0xc(%ebp),%eax
  801178:	01 d0                	add    %edx,%eax
  80117a:	8a 00                	mov    (%eax),%al
  80117c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80117f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801182:	8b 45 0c             	mov    0xc(%ebp),%eax
  801185:	01 c2                	add    %eax,%edx
  801187:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80118a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118d:	01 c8                	add    %ecx,%eax
  80118f:	8a 00                	mov    (%eax),%al
  801191:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801193:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801196:	8b 45 0c             	mov    0xc(%ebp),%eax
  801199:	01 c2                	add    %eax,%edx
  80119b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80119e:	88 02                	mov    %al,(%edx)
		start++ ;
  8011a0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011a3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011a9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011ac:	7c c4                	jl     801172 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011ae:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b4:	01 d0                	add    %edx,%eax
  8011b6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011b9:	90                   	nop
  8011ba:	c9                   	leave  
  8011bb:	c3                   	ret    

008011bc <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011bc:	55                   	push   %ebp
  8011bd:	89 e5                	mov    %esp,%ebp
  8011bf:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011c2:	ff 75 08             	pushl  0x8(%ebp)
  8011c5:	e8 54 fa ff ff       	call   800c1e <strlen>
  8011ca:	83 c4 04             	add    $0x4,%esp
  8011cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011d0:	ff 75 0c             	pushl  0xc(%ebp)
  8011d3:	e8 46 fa ff ff       	call   800c1e <strlen>
  8011d8:	83 c4 04             	add    $0x4,%esp
  8011db:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011ec:	eb 17                	jmp    801205 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f4:	01 c2                	add    %eax,%edx
  8011f6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fc:	01 c8                	add    %ecx,%eax
  8011fe:	8a 00                	mov    (%eax),%al
  801200:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801202:	ff 45 fc             	incl   -0x4(%ebp)
  801205:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801208:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80120b:	7c e1                	jl     8011ee <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80120d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801214:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80121b:	eb 1f                	jmp    80123c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80121d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801220:	8d 50 01             	lea    0x1(%eax),%edx
  801223:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801226:	89 c2                	mov    %eax,%edx
  801228:	8b 45 10             	mov    0x10(%ebp),%eax
  80122b:	01 c2                	add    %eax,%edx
  80122d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801230:	8b 45 0c             	mov    0xc(%ebp),%eax
  801233:	01 c8                	add    %ecx,%eax
  801235:	8a 00                	mov    (%eax),%al
  801237:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801239:	ff 45 f8             	incl   -0x8(%ebp)
  80123c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80123f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801242:	7c d9                	jl     80121d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801244:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801247:	8b 45 10             	mov    0x10(%ebp),%eax
  80124a:	01 d0                	add    %edx,%eax
  80124c:	c6 00 00             	movb   $0x0,(%eax)
}
  80124f:	90                   	nop
  801250:	c9                   	leave  
  801251:	c3                   	ret    

00801252 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801252:	55                   	push   %ebp
  801253:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801255:	8b 45 14             	mov    0x14(%ebp),%eax
  801258:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80125e:	8b 45 14             	mov    0x14(%ebp),%eax
  801261:	8b 00                	mov    (%eax),%eax
  801263:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80126a:	8b 45 10             	mov    0x10(%ebp),%eax
  80126d:	01 d0                	add    %edx,%eax
  80126f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801275:	eb 0c                	jmp    801283 <strsplit+0x31>
			*string++ = 0;
  801277:	8b 45 08             	mov    0x8(%ebp),%eax
  80127a:	8d 50 01             	lea    0x1(%eax),%edx
  80127d:	89 55 08             	mov    %edx,0x8(%ebp)
  801280:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801283:	8b 45 08             	mov    0x8(%ebp),%eax
  801286:	8a 00                	mov    (%eax),%al
  801288:	84 c0                	test   %al,%al
  80128a:	74 18                	je     8012a4 <strsplit+0x52>
  80128c:	8b 45 08             	mov    0x8(%ebp),%eax
  80128f:	8a 00                	mov    (%eax),%al
  801291:	0f be c0             	movsbl %al,%eax
  801294:	50                   	push   %eax
  801295:	ff 75 0c             	pushl  0xc(%ebp)
  801298:	e8 13 fb ff ff       	call   800db0 <strchr>
  80129d:	83 c4 08             	add    $0x8,%esp
  8012a0:	85 c0                	test   %eax,%eax
  8012a2:	75 d3                	jne    801277 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	8a 00                	mov    (%eax),%al
  8012a9:	84 c0                	test   %al,%al
  8012ab:	74 5a                	je     801307 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8012ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b0:	8b 00                	mov    (%eax),%eax
  8012b2:	83 f8 0f             	cmp    $0xf,%eax
  8012b5:	75 07                	jne    8012be <strsplit+0x6c>
		{
			return 0;
  8012b7:	b8 00 00 00 00       	mov    $0x0,%eax
  8012bc:	eb 66                	jmp    801324 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012be:	8b 45 14             	mov    0x14(%ebp),%eax
  8012c1:	8b 00                	mov    (%eax),%eax
  8012c3:	8d 48 01             	lea    0x1(%eax),%ecx
  8012c6:	8b 55 14             	mov    0x14(%ebp),%edx
  8012c9:	89 0a                	mov    %ecx,(%edx)
  8012cb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d5:	01 c2                	add    %eax,%edx
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012da:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012dc:	eb 03                	jmp    8012e1 <strsplit+0x8f>
			string++;
  8012de:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e4:	8a 00                	mov    (%eax),%al
  8012e6:	84 c0                	test   %al,%al
  8012e8:	74 8b                	je     801275 <strsplit+0x23>
  8012ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ed:	8a 00                	mov    (%eax),%al
  8012ef:	0f be c0             	movsbl %al,%eax
  8012f2:	50                   	push   %eax
  8012f3:	ff 75 0c             	pushl  0xc(%ebp)
  8012f6:	e8 b5 fa ff ff       	call   800db0 <strchr>
  8012fb:	83 c4 08             	add    $0x8,%esp
  8012fe:	85 c0                	test   %eax,%eax
  801300:	74 dc                	je     8012de <strsplit+0x8c>
			string++;
	}
  801302:	e9 6e ff ff ff       	jmp    801275 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801307:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801308:	8b 45 14             	mov    0x14(%ebp),%eax
  80130b:	8b 00                	mov    (%eax),%eax
  80130d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801314:	8b 45 10             	mov    0x10(%ebp),%eax
  801317:	01 d0                	add    %edx,%eax
  801319:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80131f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801324:	c9                   	leave  
  801325:	c3                   	ret    

00801326 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801326:	55                   	push   %ebp
  801327:	89 e5                	mov    %esp,%ebp
  801329:	57                   	push   %edi
  80132a:	56                   	push   %esi
  80132b:	53                   	push   %ebx
  80132c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80132f:	8b 45 08             	mov    0x8(%ebp),%eax
  801332:	8b 55 0c             	mov    0xc(%ebp),%edx
  801335:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801338:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80133b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80133e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801341:	cd 30                	int    $0x30
  801343:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801346:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801349:	83 c4 10             	add    $0x10,%esp
  80134c:	5b                   	pop    %ebx
  80134d:	5e                   	pop    %esi
  80134e:	5f                   	pop    %edi
  80134f:	5d                   	pop    %ebp
  801350:	c3                   	ret    

00801351 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
  801354:	83 ec 04             	sub    $0x4,%esp
  801357:	8b 45 10             	mov    0x10(%ebp),%eax
  80135a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80135d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	52                   	push   %edx
  801369:	ff 75 0c             	pushl  0xc(%ebp)
  80136c:	50                   	push   %eax
  80136d:	6a 00                	push   $0x0
  80136f:	e8 b2 ff ff ff       	call   801326 <syscall>
  801374:	83 c4 18             	add    $0x18,%esp
}
  801377:	90                   	nop
  801378:	c9                   	leave  
  801379:	c3                   	ret    

0080137a <sys_cgetc>:

int
sys_cgetc(void)
{
  80137a:	55                   	push   %ebp
  80137b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80137d:	6a 00                	push   $0x0
  80137f:	6a 00                	push   $0x0
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	6a 00                	push   $0x0
  801387:	6a 01                	push   $0x1
  801389:	e8 98 ff ff ff       	call   801326 <syscall>
  80138e:	83 c4 18             	add    $0x18,%esp
}
  801391:	c9                   	leave  
  801392:	c3                   	ret    

00801393 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801393:	55                   	push   %ebp
  801394:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	6a 00                	push   $0x0
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	50                   	push   %eax
  8013a2:	6a 05                	push   $0x5
  8013a4:	e8 7d ff ff ff       	call   801326 <syscall>
  8013a9:	83 c4 18             	add    $0x18,%esp
}
  8013ac:	c9                   	leave  
  8013ad:	c3                   	ret    

008013ae <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 02                	push   $0x2
  8013bd:	e8 64 ff ff ff       	call   801326 <syscall>
  8013c2:	83 c4 18             	add    $0x18,%esp
}
  8013c5:	c9                   	leave  
  8013c6:	c3                   	ret    

008013c7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013c7:	55                   	push   %ebp
  8013c8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 03                	push   $0x3
  8013d6:	e8 4b ff ff ff       	call   801326 <syscall>
  8013db:	83 c4 18             	add    $0x18,%esp
}
  8013de:	c9                   	leave  
  8013df:	c3                   	ret    

008013e0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013e0:	55                   	push   %ebp
  8013e1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 04                	push   $0x4
  8013ef:	e8 32 ff ff ff       	call   801326 <syscall>
  8013f4:	83 c4 18             	add    $0x18,%esp
}
  8013f7:	c9                   	leave  
  8013f8:	c3                   	ret    

008013f9 <sys_env_exit>:


void sys_env_exit(void)
{
  8013f9:	55                   	push   %ebp
  8013fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 06                	push   $0x6
  801408:	e8 19 ff ff ff       	call   801326 <syscall>
  80140d:	83 c4 18             	add    $0x18,%esp
}
  801410:	90                   	nop
  801411:	c9                   	leave  
  801412:	c3                   	ret    

00801413 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801413:	55                   	push   %ebp
  801414:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801416:	8b 55 0c             	mov    0xc(%ebp),%edx
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	52                   	push   %edx
  801423:	50                   	push   %eax
  801424:	6a 07                	push   $0x7
  801426:	e8 fb fe ff ff       	call   801326 <syscall>
  80142b:	83 c4 18             	add    $0x18,%esp
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
  801433:	56                   	push   %esi
  801434:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801435:	8b 75 18             	mov    0x18(%ebp),%esi
  801438:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80143b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80143e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	56                   	push   %esi
  801445:	53                   	push   %ebx
  801446:	51                   	push   %ecx
  801447:	52                   	push   %edx
  801448:	50                   	push   %eax
  801449:	6a 08                	push   $0x8
  80144b:	e8 d6 fe ff ff       	call   801326 <syscall>
  801450:	83 c4 18             	add    $0x18,%esp
}
  801453:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801456:	5b                   	pop    %ebx
  801457:	5e                   	pop    %esi
  801458:	5d                   	pop    %ebp
  801459:	c3                   	ret    

0080145a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80145a:	55                   	push   %ebp
  80145b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80145d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801460:	8b 45 08             	mov    0x8(%ebp),%eax
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	52                   	push   %edx
  80146a:	50                   	push   %eax
  80146b:	6a 09                	push   $0x9
  80146d:	e8 b4 fe ff ff       	call   801326 <syscall>
  801472:	83 c4 18             	add    $0x18,%esp
}
  801475:	c9                   	leave  
  801476:	c3                   	ret    

00801477 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	ff 75 0c             	pushl  0xc(%ebp)
  801483:	ff 75 08             	pushl  0x8(%ebp)
  801486:	6a 0a                	push   $0xa
  801488:	e8 99 fe ff ff       	call   801326 <syscall>
  80148d:	83 c4 18             	add    $0x18,%esp
}
  801490:	c9                   	leave  
  801491:	c3                   	ret    

00801492 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801492:	55                   	push   %ebp
  801493:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	6a 0b                	push   $0xb
  8014a1:	e8 80 fe ff ff       	call   801326 <syscall>
  8014a6:	83 c4 18             	add    $0x18,%esp
}
  8014a9:	c9                   	leave  
  8014aa:	c3                   	ret    

008014ab <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014ab:	55                   	push   %ebp
  8014ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 0c                	push   $0xc
  8014ba:	e8 67 fe ff ff       	call   801326 <syscall>
  8014bf:	83 c4 18             	add    $0x18,%esp
}
  8014c2:	c9                   	leave  
  8014c3:	c3                   	ret    

008014c4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014c4:	55                   	push   %ebp
  8014c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 0d                	push   $0xd
  8014d3:	e8 4e fe ff ff       	call   801326 <syscall>
  8014d8:	83 c4 18             	add    $0x18,%esp
}
  8014db:	c9                   	leave  
  8014dc:	c3                   	ret    

008014dd <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014dd:	55                   	push   %ebp
  8014de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	ff 75 0c             	pushl  0xc(%ebp)
  8014e9:	ff 75 08             	pushl  0x8(%ebp)
  8014ec:	6a 11                	push   $0x11
  8014ee:	e8 33 fe ff ff       	call   801326 <syscall>
  8014f3:	83 c4 18             	add    $0x18,%esp
	return;
  8014f6:	90                   	nop
}
  8014f7:	c9                   	leave  
  8014f8:	c3                   	ret    

008014f9 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8014f9:	55                   	push   %ebp
  8014fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	ff 75 0c             	pushl  0xc(%ebp)
  801505:	ff 75 08             	pushl  0x8(%ebp)
  801508:	6a 12                	push   $0x12
  80150a:	e8 17 fe ff ff       	call   801326 <syscall>
  80150f:	83 c4 18             	add    $0x18,%esp
	return ;
  801512:	90                   	nop
}
  801513:	c9                   	leave  
  801514:	c3                   	ret    

00801515 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801515:	55                   	push   %ebp
  801516:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	6a 00                	push   $0x0
  801522:	6a 0e                	push   $0xe
  801524:	e8 fd fd ff ff       	call   801326 <syscall>
  801529:	83 c4 18             	add    $0x18,%esp
}
  80152c:	c9                   	leave  
  80152d:	c3                   	ret    

0080152e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	ff 75 08             	pushl  0x8(%ebp)
  80153c:	6a 0f                	push   $0xf
  80153e:	e8 e3 fd ff ff       	call   801326 <syscall>
  801543:	83 c4 18             	add    $0x18,%esp
}
  801546:	c9                   	leave  
  801547:	c3                   	ret    

00801548 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801548:	55                   	push   %ebp
  801549:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 10                	push   $0x10
  801557:	e8 ca fd ff ff       	call   801326 <syscall>
  80155c:	83 c4 18             	add    $0x18,%esp
}
  80155f:	90                   	nop
  801560:	c9                   	leave  
  801561:	c3                   	ret    

00801562 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801562:	55                   	push   %ebp
  801563:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 14                	push   $0x14
  801571:	e8 b0 fd ff ff       	call   801326 <syscall>
  801576:	83 c4 18             	add    $0x18,%esp
}
  801579:	90                   	nop
  80157a:	c9                   	leave  
  80157b:	c3                   	ret    

0080157c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80157c:	55                   	push   %ebp
  80157d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 15                	push   $0x15
  80158b:	e8 96 fd ff ff       	call   801326 <syscall>
  801590:	83 c4 18             	add    $0x18,%esp
}
  801593:	90                   	nop
  801594:	c9                   	leave  
  801595:	c3                   	ret    

00801596 <sys_cputc>:


void
sys_cputc(const char c)
{
  801596:	55                   	push   %ebp
  801597:	89 e5                	mov    %esp,%ebp
  801599:	83 ec 04             	sub    $0x4,%esp
  80159c:	8b 45 08             	mov    0x8(%ebp),%eax
  80159f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015a2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	50                   	push   %eax
  8015af:	6a 16                	push   $0x16
  8015b1:	e8 70 fd ff ff       	call   801326 <syscall>
  8015b6:	83 c4 18             	add    $0x18,%esp
}
  8015b9:	90                   	nop
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 17                	push   $0x17
  8015cb:	e8 56 fd ff ff       	call   801326 <syscall>
  8015d0:	83 c4 18             	add    $0x18,%esp
}
  8015d3:	90                   	nop
  8015d4:	c9                   	leave  
  8015d5:	c3                   	ret    

008015d6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	ff 75 0c             	pushl  0xc(%ebp)
  8015e5:	50                   	push   %eax
  8015e6:	6a 18                	push   $0x18
  8015e8:	e8 39 fd ff ff       	call   801326 <syscall>
  8015ed:	83 c4 18             	add    $0x18,%esp
}
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	52                   	push   %edx
  801602:	50                   	push   %eax
  801603:	6a 1b                	push   $0x1b
  801605:	e8 1c fd ff ff       	call   801326 <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801612:	8b 55 0c             	mov    0xc(%ebp),%edx
  801615:	8b 45 08             	mov    0x8(%ebp),%eax
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	52                   	push   %edx
  80161f:	50                   	push   %eax
  801620:	6a 19                	push   $0x19
  801622:	e8 ff fc ff ff       	call   801326 <syscall>
  801627:	83 c4 18             	add    $0x18,%esp
}
  80162a:	90                   	nop
  80162b:	c9                   	leave  
  80162c:	c3                   	ret    

0080162d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80162d:	55                   	push   %ebp
  80162e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801630:	8b 55 0c             	mov    0xc(%ebp),%edx
  801633:	8b 45 08             	mov    0x8(%ebp),%eax
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	52                   	push   %edx
  80163d:	50                   	push   %eax
  80163e:	6a 1a                	push   $0x1a
  801640:	e8 e1 fc ff ff       	call   801326 <syscall>
  801645:	83 c4 18             	add    $0x18,%esp
}
  801648:	90                   	nop
  801649:	c9                   	leave  
  80164a:	c3                   	ret    

0080164b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80164b:	55                   	push   %ebp
  80164c:	89 e5                	mov    %esp,%ebp
  80164e:	83 ec 04             	sub    $0x4,%esp
  801651:	8b 45 10             	mov    0x10(%ebp),%eax
  801654:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801657:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80165a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	6a 00                	push   $0x0
  801663:	51                   	push   %ecx
  801664:	52                   	push   %edx
  801665:	ff 75 0c             	pushl  0xc(%ebp)
  801668:	50                   	push   %eax
  801669:	6a 1c                	push   $0x1c
  80166b:	e8 b6 fc ff ff       	call   801326 <syscall>
  801670:	83 c4 18             	add    $0x18,%esp
}
  801673:	c9                   	leave  
  801674:	c3                   	ret    

00801675 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801675:	55                   	push   %ebp
  801676:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801678:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	52                   	push   %edx
  801685:	50                   	push   %eax
  801686:	6a 1d                	push   $0x1d
  801688:	e8 99 fc ff ff       	call   801326 <syscall>
  80168d:	83 c4 18             	add    $0x18,%esp
}
  801690:	c9                   	leave  
  801691:	c3                   	ret    

00801692 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801692:	55                   	push   %ebp
  801693:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801695:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801698:	8b 55 0c             	mov    0xc(%ebp),%edx
  80169b:	8b 45 08             	mov    0x8(%ebp),%eax
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	51                   	push   %ecx
  8016a3:	52                   	push   %edx
  8016a4:	50                   	push   %eax
  8016a5:	6a 1e                	push   $0x1e
  8016a7:	e8 7a fc ff ff       	call   801326 <syscall>
  8016ac:	83 c4 18             	add    $0x18,%esp
}
  8016af:	c9                   	leave  
  8016b0:	c3                   	ret    

008016b1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016b1:	55                   	push   %ebp
  8016b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	52                   	push   %edx
  8016c1:	50                   	push   %eax
  8016c2:	6a 1f                	push   $0x1f
  8016c4:	e8 5d fc ff ff       	call   801326 <syscall>
  8016c9:	83 c4 18             	add    $0x18,%esp
}
  8016cc:	c9                   	leave  
  8016cd:	c3                   	ret    

008016ce <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016ce:	55                   	push   %ebp
  8016cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 20                	push   $0x20
  8016dd:	e8 44 fc ff ff       	call   801326 <syscall>
  8016e2:	83 c4 18             	add    $0x18,%esp
}
  8016e5:	c9                   	leave  
  8016e6:	c3                   	ret    

008016e7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8016ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ed:	6a 00                	push   $0x0
  8016ef:	ff 75 14             	pushl  0x14(%ebp)
  8016f2:	ff 75 10             	pushl  0x10(%ebp)
  8016f5:	ff 75 0c             	pushl  0xc(%ebp)
  8016f8:	50                   	push   %eax
  8016f9:	6a 21                	push   $0x21
  8016fb:	e8 26 fc ff ff       	call   801326 <syscall>
  801700:	83 c4 18             	add    $0x18,%esp
}
  801703:	c9                   	leave  
  801704:	c3                   	ret    

00801705 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801705:	55                   	push   %ebp
  801706:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801708:	8b 45 08             	mov    0x8(%ebp),%eax
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	50                   	push   %eax
  801714:	6a 22                	push   $0x22
  801716:	e8 0b fc ff ff       	call   801326 <syscall>
  80171b:	83 c4 18             	add    $0x18,%esp
}
  80171e:	90                   	nop
  80171f:	c9                   	leave  
  801720:	c3                   	ret    

00801721 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801721:	55                   	push   %ebp
  801722:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801724:	8b 45 08             	mov    0x8(%ebp),%eax
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	50                   	push   %eax
  801730:	6a 23                	push   $0x23
  801732:	e8 ef fb ff ff       	call   801326 <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	90                   	nop
  80173b:	c9                   	leave  
  80173c:	c3                   	ret    

0080173d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80173d:	55                   	push   %ebp
  80173e:	89 e5                	mov    %esp,%ebp
  801740:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801743:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801746:	8d 50 04             	lea    0x4(%eax),%edx
  801749:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	52                   	push   %edx
  801753:	50                   	push   %eax
  801754:	6a 24                	push   $0x24
  801756:	e8 cb fb ff ff       	call   801326 <syscall>
  80175b:	83 c4 18             	add    $0x18,%esp
	return result;
  80175e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801761:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801764:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801767:	89 01                	mov    %eax,(%ecx)
  801769:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80176c:	8b 45 08             	mov    0x8(%ebp),%eax
  80176f:	c9                   	leave  
  801770:	c2 04 00             	ret    $0x4

00801773 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	ff 75 10             	pushl  0x10(%ebp)
  80177d:	ff 75 0c             	pushl  0xc(%ebp)
  801780:	ff 75 08             	pushl  0x8(%ebp)
  801783:	6a 13                	push   $0x13
  801785:	e8 9c fb ff ff       	call   801326 <syscall>
  80178a:	83 c4 18             	add    $0x18,%esp
	return ;
  80178d:	90                   	nop
}
  80178e:	c9                   	leave  
  80178f:	c3                   	ret    

00801790 <sys_rcr2>:
uint32 sys_rcr2()
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 25                	push   $0x25
  80179f:	e8 82 fb ff ff       	call   801326 <syscall>
  8017a4:	83 c4 18             	add    $0x18,%esp
}
  8017a7:	c9                   	leave  
  8017a8:	c3                   	ret    

008017a9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017a9:	55                   	push   %ebp
  8017aa:	89 e5                	mov    %esp,%ebp
  8017ac:	83 ec 04             	sub    $0x4,%esp
  8017af:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017b5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	50                   	push   %eax
  8017c2:	6a 26                	push   $0x26
  8017c4:	e8 5d fb ff ff       	call   801326 <syscall>
  8017c9:	83 c4 18             	add    $0x18,%esp
	return ;
  8017cc:	90                   	nop
}
  8017cd:	c9                   	leave  
  8017ce:	c3                   	ret    

008017cf <rsttst>:
void rsttst()
{
  8017cf:	55                   	push   %ebp
  8017d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 28                	push   $0x28
  8017de:	e8 43 fb ff ff       	call   801326 <syscall>
  8017e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8017e6:	90                   	nop
}
  8017e7:	c9                   	leave  
  8017e8:	c3                   	ret    

008017e9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8017e9:	55                   	push   %ebp
  8017ea:	89 e5                	mov    %esp,%ebp
  8017ec:	83 ec 04             	sub    $0x4,%esp
  8017ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8017f2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8017f5:	8b 55 18             	mov    0x18(%ebp),%edx
  8017f8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017fc:	52                   	push   %edx
  8017fd:	50                   	push   %eax
  8017fe:	ff 75 10             	pushl  0x10(%ebp)
  801801:	ff 75 0c             	pushl  0xc(%ebp)
  801804:	ff 75 08             	pushl  0x8(%ebp)
  801807:	6a 27                	push   $0x27
  801809:	e8 18 fb ff ff       	call   801326 <syscall>
  80180e:	83 c4 18             	add    $0x18,%esp
	return ;
  801811:	90                   	nop
}
  801812:	c9                   	leave  
  801813:	c3                   	ret    

00801814 <chktst>:
void chktst(uint32 n)
{
  801814:	55                   	push   %ebp
  801815:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	ff 75 08             	pushl  0x8(%ebp)
  801822:	6a 29                	push   $0x29
  801824:	e8 fd fa ff ff       	call   801326 <syscall>
  801829:	83 c4 18             	add    $0x18,%esp
	return ;
  80182c:	90                   	nop
}
  80182d:	c9                   	leave  
  80182e:	c3                   	ret    

0080182f <inctst>:

void inctst()
{
  80182f:	55                   	push   %ebp
  801830:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 2a                	push   $0x2a
  80183e:	e8 e3 fa ff ff       	call   801326 <syscall>
  801843:	83 c4 18             	add    $0x18,%esp
	return ;
  801846:	90                   	nop
}
  801847:	c9                   	leave  
  801848:	c3                   	ret    

00801849 <gettst>:
uint32 gettst()
{
  801849:	55                   	push   %ebp
  80184a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	6a 2b                	push   $0x2b
  801858:	e8 c9 fa ff ff       	call   801326 <syscall>
  80185d:	83 c4 18             	add    $0x18,%esp
}
  801860:	c9                   	leave  
  801861:	c3                   	ret    

00801862 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801862:	55                   	push   %ebp
  801863:	89 e5                	mov    %esp,%ebp
  801865:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 2c                	push   $0x2c
  801874:	e8 ad fa ff ff       	call   801326 <syscall>
  801879:	83 c4 18             	add    $0x18,%esp
  80187c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80187f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801883:	75 07                	jne    80188c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801885:	b8 01 00 00 00       	mov    $0x1,%eax
  80188a:	eb 05                	jmp    801891 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80188c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801891:	c9                   	leave  
  801892:	c3                   	ret    

00801893 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801893:	55                   	push   %ebp
  801894:	89 e5                	mov    %esp,%ebp
  801896:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 2c                	push   $0x2c
  8018a5:	e8 7c fa ff ff       	call   801326 <syscall>
  8018aa:	83 c4 18             	add    $0x18,%esp
  8018ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018b0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018b4:	75 07                	jne    8018bd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8018bb:	eb 05                	jmp    8018c2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018bd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018c2:	c9                   	leave  
  8018c3:	c3                   	ret    

008018c4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018c4:	55                   	push   %ebp
  8018c5:	89 e5                	mov    %esp,%ebp
  8018c7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 2c                	push   $0x2c
  8018d6:	e8 4b fa ff ff       	call   801326 <syscall>
  8018db:	83 c4 18             	add    $0x18,%esp
  8018de:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018e1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8018e5:	75 07                	jne    8018ee <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8018e7:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ec:	eb 05                	jmp    8018f3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8018ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018f3:	c9                   	leave  
  8018f4:	c3                   	ret    

008018f5 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8018f5:	55                   	push   %ebp
  8018f6:	89 e5                	mov    %esp,%ebp
  8018f8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	6a 00                	push   $0x0
  801905:	6a 2c                	push   $0x2c
  801907:	e8 1a fa ff ff       	call   801326 <syscall>
  80190c:	83 c4 18             	add    $0x18,%esp
  80190f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801912:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801916:	75 07                	jne    80191f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801918:	b8 01 00 00 00       	mov    $0x1,%eax
  80191d:	eb 05                	jmp    801924 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80191f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801924:	c9                   	leave  
  801925:	c3                   	ret    

00801926 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801926:	55                   	push   %ebp
  801927:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	ff 75 08             	pushl  0x8(%ebp)
  801934:	6a 2d                	push   $0x2d
  801936:	e8 eb f9 ff ff       	call   801326 <syscall>
  80193b:	83 c4 18             	add    $0x18,%esp
	return ;
  80193e:	90                   	nop
}
  80193f:	c9                   	leave  
  801940:	c3                   	ret    

00801941 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801941:	55                   	push   %ebp
  801942:	89 e5                	mov    %esp,%ebp
  801944:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801945:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801948:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80194b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80194e:	8b 45 08             	mov    0x8(%ebp),%eax
  801951:	6a 00                	push   $0x0
  801953:	53                   	push   %ebx
  801954:	51                   	push   %ecx
  801955:	52                   	push   %edx
  801956:	50                   	push   %eax
  801957:	6a 2e                	push   $0x2e
  801959:	e8 c8 f9 ff ff       	call   801326 <syscall>
  80195e:	83 c4 18             	add    $0x18,%esp
}
  801961:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801964:	c9                   	leave  
  801965:	c3                   	ret    

00801966 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801966:	55                   	push   %ebp
  801967:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801969:	8b 55 0c             	mov    0xc(%ebp),%edx
  80196c:	8b 45 08             	mov    0x8(%ebp),%eax
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	52                   	push   %edx
  801976:	50                   	push   %eax
  801977:	6a 2f                	push   $0x2f
  801979:	e8 a8 f9 ff ff       	call   801326 <syscall>
  80197e:	83 c4 18             	add    $0x18,%esp
}
  801981:	c9                   	leave  
  801982:	c3                   	ret    

00801983 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801983:	55                   	push   %ebp
  801984:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	ff 75 0c             	pushl  0xc(%ebp)
  80198f:	ff 75 08             	pushl  0x8(%ebp)
  801992:	6a 30                	push   $0x30
  801994:	e8 8d f9 ff ff       	call   801326 <syscall>
  801999:	83 c4 18             	add    $0x18,%esp
	return ;
  80199c:	90                   	nop
}
  80199d:	c9                   	leave  
  80199e:	c3                   	ret    

0080199f <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  80199f:	55                   	push   %ebp
  8019a0:	89 e5                	mov    %esp,%ebp
  8019a2:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8019a5:	8b 55 08             	mov    0x8(%ebp),%edx
  8019a8:	89 d0                	mov    %edx,%eax
  8019aa:	c1 e0 02             	shl    $0x2,%eax
  8019ad:	01 d0                	add    %edx,%eax
  8019af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019b6:	01 d0                	add    %edx,%eax
  8019b8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019bf:	01 d0                	add    %edx,%eax
  8019c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019c8:	01 d0                	add    %edx,%eax
  8019ca:	c1 e0 04             	shl    $0x4,%eax
  8019cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8019d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8019d7:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8019da:	83 ec 0c             	sub    $0xc,%esp
  8019dd:	50                   	push   %eax
  8019de:	e8 5a fd ff ff       	call   80173d <sys_get_virtual_time>
  8019e3:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8019e6:	eb 41                	jmp    801a29 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8019e8:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8019eb:	83 ec 0c             	sub    $0xc,%esp
  8019ee:	50                   	push   %eax
  8019ef:	e8 49 fd ff ff       	call   80173d <sys_get_virtual_time>
  8019f4:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8019f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019fd:	29 c2                	sub    %eax,%edx
  8019ff:	89 d0                	mov    %edx,%eax
  801a01:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801a04:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801a07:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a0a:	89 d1                	mov    %edx,%ecx
  801a0c:	29 c1                	sub    %eax,%ecx
  801a0e:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a11:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a14:	39 c2                	cmp    %eax,%edx
  801a16:	0f 97 c0             	seta   %al
  801a19:	0f b6 c0             	movzbl %al,%eax
  801a1c:	29 c1                	sub    %eax,%ecx
  801a1e:	89 c8                	mov    %ecx,%eax
  801a20:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801a23:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a26:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a29:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a2c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a2f:	72 b7                	jb     8019e8 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a31:	90                   	nop
  801a32:	c9                   	leave  
  801a33:	c3                   	ret    

00801a34 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801a34:	55                   	push   %ebp
  801a35:	89 e5                	mov    %esp,%ebp
  801a37:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801a3a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801a41:	eb 03                	jmp    801a46 <busy_wait+0x12>
  801a43:	ff 45 fc             	incl   -0x4(%ebp)
  801a46:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a49:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a4c:	72 f5                	jb     801a43 <busy_wait+0xf>
	return i;
  801a4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801a51:	c9                   	leave  
  801a52:	c3                   	ret    
  801a53:	90                   	nop

00801a54 <__udivdi3>:
  801a54:	55                   	push   %ebp
  801a55:	57                   	push   %edi
  801a56:	56                   	push   %esi
  801a57:	53                   	push   %ebx
  801a58:	83 ec 1c             	sub    $0x1c,%esp
  801a5b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a5f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a63:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a67:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a6b:	89 ca                	mov    %ecx,%edx
  801a6d:	89 f8                	mov    %edi,%eax
  801a6f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a73:	85 f6                	test   %esi,%esi
  801a75:	75 2d                	jne    801aa4 <__udivdi3+0x50>
  801a77:	39 cf                	cmp    %ecx,%edi
  801a79:	77 65                	ja     801ae0 <__udivdi3+0x8c>
  801a7b:	89 fd                	mov    %edi,%ebp
  801a7d:	85 ff                	test   %edi,%edi
  801a7f:	75 0b                	jne    801a8c <__udivdi3+0x38>
  801a81:	b8 01 00 00 00       	mov    $0x1,%eax
  801a86:	31 d2                	xor    %edx,%edx
  801a88:	f7 f7                	div    %edi
  801a8a:	89 c5                	mov    %eax,%ebp
  801a8c:	31 d2                	xor    %edx,%edx
  801a8e:	89 c8                	mov    %ecx,%eax
  801a90:	f7 f5                	div    %ebp
  801a92:	89 c1                	mov    %eax,%ecx
  801a94:	89 d8                	mov    %ebx,%eax
  801a96:	f7 f5                	div    %ebp
  801a98:	89 cf                	mov    %ecx,%edi
  801a9a:	89 fa                	mov    %edi,%edx
  801a9c:	83 c4 1c             	add    $0x1c,%esp
  801a9f:	5b                   	pop    %ebx
  801aa0:	5e                   	pop    %esi
  801aa1:	5f                   	pop    %edi
  801aa2:	5d                   	pop    %ebp
  801aa3:	c3                   	ret    
  801aa4:	39 ce                	cmp    %ecx,%esi
  801aa6:	77 28                	ja     801ad0 <__udivdi3+0x7c>
  801aa8:	0f bd fe             	bsr    %esi,%edi
  801aab:	83 f7 1f             	xor    $0x1f,%edi
  801aae:	75 40                	jne    801af0 <__udivdi3+0x9c>
  801ab0:	39 ce                	cmp    %ecx,%esi
  801ab2:	72 0a                	jb     801abe <__udivdi3+0x6a>
  801ab4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ab8:	0f 87 9e 00 00 00    	ja     801b5c <__udivdi3+0x108>
  801abe:	b8 01 00 00 00       	mov    $0x1,%eax
  801ac3:	89 fa                	mov    %edi,%edx
  801ac5:	83 c4 1c             	add    $0x1c,%esp
  801ac8:	5b                   	pop    %ebx
  801ac9:	5e                   	pop    %esi
  801aca:	5f                   	pop    %edi
  801acb:	5d                   	pop    %ebp
  801acc:	c3                   	ret    
  801acd:	8d 76 00             	lea    0x0(%esi),%esi
  801ad0:	31 ff                	xor    %edi,%edi
  801ad2:	31 c0                	xor    %eax,%eax
  801ad4:	89 fa                	mov    %edi,%edx
  801ad6:	83 c4 1c             	add    $0x1c,%esp
  801ad9:	5b                   	pop    %ebx
  801ada:	5e                   	pop    %esi
  801adb:	5f                   	pop    %edi
  801adc:	5d                   	pop    %ebp
  801add:	c3                   	ret    
  801ade:	66 90                	xchg   %ax,%ax
  801ae0:	89 d8                	mov    %ebx,%eax
  801ae2:	f7 f7                	div    %edi
  801ae4:	31 ff                	xor    %edi,%edi
  801ae6:	89 fa                	mov    %edi,%edx
  801ae8:	83 c4 1c             	add    $0x1c,%esp
  801aeb:	5b                   	pop    %ebx
  801aec:	5e                   	pop    %esi
  801aed:	5f                   	pop    %edi
  801aee:	5d                   	pop    %ebp
  801aef:	c3                   	ret    
  801af0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801af5:	89 eb                	mov    %ebp,%ebx
  801af7:	29 fb                	sub    %edi,%ebx
  801af9:	89 f9                	mov    %edi,%ecx
  801afb:	d3 e6                	shl    %cl,%esi
  801afd:	89 c5                	mov    %eax,%ebp
  801aff:	88 d9                	mov    %bl,%cl
  801b01:	d3 ed                	shr    %cl,%ebp
  801b03:	89 e9                	mov    %ebp,%ecx
  801b05:	09 f1                	or     %esi,%ecx
  801b07:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b0b:	89 f9                	mov    %edi,%ecx
  801b0d:	d3 e0                	shl    %cl,%eax
  801b0f:	89 c5                	mov    %eax,%ebp
  801b11:	89 d6                	mov    %edx,%esi
  801b13:	88 d9                	mov    %bl,%cl
  801b15:	d3 ee                	shr    %cl,%esi
  801b17:	89 f9                	mov    %edi,%ecx
  801b19:	d3 e2                	shl    %cl,%edx
  801b1b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b1f:	88 d9                	mov    %bl,%cl
  801b21:	d3 e8                	shr    %cl,%eax
  801b23:	09 c2                	or     %eax,%edx
  801b25:	89 d0                	mov    %edx,%eax
  801b27:	89 f2                	mov    %esi,%edx
  801b29:	f7 74 24 0c          	divl   0xc(%esp)
  801b2d:	89 d6                	mov    %edx,%esi
  801b2f:	89 c3                	mov    %eax,%ebx
  801b31:	f7 e5                	mul    %ebp
  801b33:	39 d6                	cmp    %edx,%esi
  801b35:	72 19                	jb     801b50 <__udivdi3+0xfc>
  801b37:	74 0b                	je     801b44 <__udivdi3+0xf0>
  801b39:	89 d8                	mov    %ebx,%eax
  801b3b:	31 ff                	xor    %edi,%edi
  801b3d:	e9 58 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b42:	66 90                	xchg   %ax,%ax
  801b44:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b48:	89 f9                	mov    %edi,%ecx
  801b4a:	d3 e2                	shl    %cl,%edx
  801b4c:	39 c2                	cmp    %eax,%edx
  801b4e:	73 e9                	jae    801b39 <__udivdi3+0xe5>
  801b50:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b53:	31 ff                	xor    %edi,%edi
  801b55:	e9 40 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b5a:	66 90                	xchg   %ax,%ax
  801b5c:	31 c0                	xor    %eax,%eax
  801b5e:	e9 37 ff ff ff       	jmp    801a9a <__udivdi3+0x46>
  801b63:	90                   	nop

00801b64 <__umoddi3>:
  801b64:	55                   	push   %ebp
  801b65:	57                   	push   %edi
  801b66:	56                   	push   %esi
  801b67:	53                   	push   %ebx
  801b68:	83 ec 1c             	sub    $0x1c,%esp
  801b6b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b6f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b73:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b77:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b7b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b7f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b83:	89 f3                	mov    %esi,%ebx
  801b85:	89 fa                	mov    %edi,%edx
  801b87:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b8b:	89 34 24             	mov    %esi,(%esp)
  801b8e:	85 c0                	test   %eax,%eax
  801b90:	75 1a                	jne    801bac <__umoddi3+0x48>
  801b92:	39 f7                	cmp    %esi,%edi
  801b94:	0f 86 a2 00 00 00    	jbe    801c3c <__umoddi3+0xd8>
  801b9a:	89 c8                	mov    %ecx,%eax
  801b9c:	89 f2                	mov    %esi,%edx
  801b9e:	f7 f7                	div    %edi
  801ba0:	89 d0                	mov    %edx,%eax
  801ba2:	31 d2                	xor    %edx,%edx
  801ba4:	83 c4 1c             	add    $0x1c,%esp
  801ba7:	5b                   	pop    %ebx
  801ba8:	5e                   	pop    %esi
  801ba9:	5f                   	pop    %edi
  801baa:	5d                   	pop    %ebp
  801bab:	c3                   	ret    
  801bac:	39 f0                	cmp    %esi,%eax
  801bae:	0f 87 ac 00 00 00    	ja     801c60 <__umoddi3+0xfc>
  801bb4:	0f bd e8             	bsr    %eax,%ebp
  801bb7:	83 f5 1f             	xor    $0x1f,%ebp
  801bba:	0f 84 ac 00 00 00    	je     801c6c <__umoddi3+0x108>
  801bc0:	bf 20 00 00 00       	mov    $0x20,%edi
  801bc5:	29 ef                	sub    %ebp,%edi
  801bc7:	89 fe                	mov    %edi,%esi
  801bc9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bcd:	89 e9                	mov    %ebp,%ecx
  801bcf:	d3 e0                	shl    %cl,%eax
  801bd1:	89 d7                	mov    %edx,%edi
  801bd3:	89 f1                	mov    %esi,%ecx
  801bd5:	d3 ef                	shr    %cl,%edi
  801bd7:	09 c7                	or     %eax,%edi
  801bd9:	89 e9                	mov    %ebp,%ecx
  801bdb:	d3 e2                	shl    %cl,%edx
  801bdd:	89 14 24             	mov    %edx,(%esp)
  801be0:	89 d8                	mov    %ebx,%eax
  801be2:	d3 e0                	shl    %cl,%eax
  801be4:	89 c2                	mov    %eax,%edx
  801be6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bea:	d3 e0                	shl    %cl,%eax
  801bec:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bf0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bf4:	89 f1                	mov    %esi,%ecx
  801bf6:	d3 e8                	shr    %cl,%eax
  801bf8:	09 d0                	or     %edx,%eax
  801bfa:	d3 eb                	shr    %cl,%ebx
  801bfc:	89 da                	mov    %ebx,%edx
  801bfe:	f7 f7                	div    %edi
  801c00:	89 d3                	mov    %edx,%ebx
  801c02:	f7 24 24             	mull   (%esp)
  801c05:	89 c6                	mov    %eax,%esi
  801c07:	89 d1                	mov    %edx,%ecx
  801c09:	39 d3                	cmp    %edx,%ebx
  801c0b:	0f 82 87 00 00 00    	jb     801c98 <__umoddi3+0x134>
  801c11:	0f 84 91 00 00 00    	je     801ca8 <__umoddi3+0x144>
  801c17:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c1b:	29 f2                	sub    %esi,%edx
  801c1d:	19 cb                	sbb    %ecx,%ebx
  801c1f:	89 d8                	mov    %ebx,%eax
  801c21:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c25:	d3 e0                	shl    %cl,%eax
  801c27:	89 e9                	mov    %ebp,%ecx
  801c29:	d3 ea                	shr    %cl,%edx
  801c2b:	09 d0                	or     %edx,%eax
  801c2d:	89 e9                	mov    %ebp,%ecx
  801c2f:	d3 eb                	shr    %cl,%ebx
  801c31:	89 da                	mov    %ebx,%edx
  801c33:	83 c4 1c             	add    $0x1c,%esp
  801c36:	5b                   	pop    %ebx
  801c37:	5e                   	pop    %esi
  801c38:	5f                   	pop    %edi
  801c39:	5d                   	pop    %ebp
  801c3a:	c3                   	ret    
  801c3b:	90                   	nop
  801c3c:	89 fd                	mov    %edi,%ebp
  801c3e:	85 ff                	test   %edi,%edi
  801c40:	75 0b                	jne    801c4d <__umoddi3+0xe9>
  801c42:	b8 01 00 00 00       	mov    $0x1,%eax
  801c47:	31 d2                	xor    %edx,%edx
  801c49:	f7 f7                	div    %edi
  801c4b:	89 c5                	mov    %eax,%ebp
  801c4d:	89 f0                	mov    %esi,%eax
  801c4f:	31 d2                	xor    %edx,%edx
  801c51:	f7 f5                	div    %ebp
  801c53:	89 c8                	mov    %ecx,%eax
  801c55:	f7 f5                	div    %ebp
  801c57:	89 d0                	mov    %edx,%eax
  801c59:	e9 44 ff ff ff       	jmp    801ba2 <__umoddi3+0x3e>
  801c5e:	66 90                	xchg   %ax,%ax
  801c60:	89 c8                	mov    %ecx,%eax
  801c62:	89 f2                	mov    %esi,%edx
  801c64:	83 c4 1c             	add    $0x1c,%esp
  801c67:	5b                   	pop    %ebx
  801c68:	5e                   	pop    %esi
  801c69:	5f                   	pop    %edi
  801c6a:	5d                   	pop    %ebp
  801c6b:	c3                   	ret    
  801c6c:	3b 04 24             	cmp    (%esp),%eax
  801c6f:	72 06                	jb     801c77 <__umoddi3+0x113>
  801c71:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c75:	77 0f                	ja     801c86 <__umoddi3+0x122>
  801c77:	89 f2                	mov    %esi,%edx
  801c79:	29 f9                	sub    %edi,%ecx
  801c7b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c7f:	89 14 24             	mov    %edx,(%esp)
  801c82:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c86:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c8a:	8b 14 24             	mov    (%esp),%edx
  801c8d:	83 c4 1c             	add    $0x1c,%esp
  801c90:	5b                   	pop    %ebx
  801c91:	5e                   	pop    %esi
  801c92:	5f                   	pop    %edi
  801c93:	5d                   	pop    %ebp
  801c94:	c3                   	ret    
  801c95:	8d 76 00             	lea    0x0(%esi),%esi
  801c98:	2b 04 24             	sub    (%esp),%eax
  801c9b:	19 fa                	sbb    %edi,%edx
  801c9d:	89 d1                	mov    %edx,%ecx
  801c9f:	89 c6                	mov    %eax,%esi
  801ca1:	e9 71 ff ff ff       	jmp    801c17 <__umoddi3+0xb3>
  801ca6:	66 90                	xchg   %ax,%ax
  801ca8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801cac:	72 ea                	jb     801c98 <__umoddi3+0x134>
  801cae:	89 d9                	mov    %ebx,%ecx
  801cb0:	e9 62 ff ff ff       	jmp    801c17 <__umoddi3+0xb3>
