
obj/user/sc_CPU_MLFQ_slave_1_1:     file format elf32-i386


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
  800031:	e8 80 01 00 00       	call   8001b6 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int ID;
	for (int i = 0; i < 5; ++i) {
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 5e                	jmp    8000a5 <_main+0x6d>
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800047:	a1 20 30 80 00       	mov    0x803020,%eax
  80004c:	8b 90 f4 52 00 00    	mov    0x52f4(%eax),%edx
  800052:	a1 20 30 80 00       	mov    0x803020,%eax
  800057:	8b 80 34 53 00 00    	mov    0x5334(%eax),%eax
  80005d:	89 c1                	mov    %eax,%ecx
  80005f:	a1 20 30 80 00       	mov    0x803020,%eax
  800064:	8b 40 74             	mov    0x74(%eax),%eax
  800067:	52                   	push   %edx
  800068:	51                   	push   %ecx
  800069:	50                   	push   %eax
  80006a:	68 c0 1c 80 00       	push   $0x801cc0
  80006f:	e8 69 16 00 00       	call   8016dd <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (ID == E_ENV_CREATION_ERROR)
  80007a:	83 7d ec ef          	cmpl   $0xffffffef,-0x14(%ebp)
  80007e:	75 14                	jne    800094 <_main+0x5c>
				panic("RUNNING OUT OF ENV!! terminating...");
  800080:	83 ec 04             	sub    $0x4,%esp
  800083:	68 c8 1c 80 00       	push   $0x801cc8
  800088:	6a 0a                	push   $0xa
  80008a:	68 ec 1c 80 00       	push   $0x801cec
  80008f:	e8 47 02 00 00       	call   8002db <_panic>

			sys_run_env(ID);
  800094:	83 ec 0c             	sub    $0xc,%esp
  800097:	ff 75 ec             	pushl  -0x14(%ebp)
  80009a:	e8 5c 16 00 00       	call   8016fb <sys_run_env>
  80009f:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 5; ++i) {
  8000a2:	ff 45 f4             	incl   -0xc(%ebp)
  8000a5:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
  8000a9:	7e 9c                	jle    800047 <_main+0xf>

			sys_run_env(ID);
		}
	//cprintf("done\n");
	//env_sleep(5000);
	int x = busy_wait(1000000);
  8000ab:	83 ec 0c             	sub    $0xc,%esp
  8000ae:	68 40 42 0f 00       	push   $0xf4240
  8000b3:	e8 72 19 00 00       	call   801a2a <busy_wait>
  8000b8:	83 c4 10             	add    $0x10,%esp
  8000bb:	89 45 e8             	mov    %eax,-0x18(%ebp)

	for (int i = 0; i < 5; ++i) {
  8000be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000c5:	e9 cc 00 00 00       	jmp    800196 <_main+0x15e>
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  8000ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8000cf:	8b 90 f4 52 00 00    	mov    0x52f4(%eax),%edx
  8000d5:	a1 20 30 80 00       	mov    0x803020,%eax
  8000da:	8b 80 34 53 00 00    	mov    0x5334(%eax),%eax
  8000e0:	89 c1                	mov    %eax,%ecx
  8000e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e7:	8b 40 74             	mov    0x74(%eax),%eax
  8000ea:	52                   	push   %edx
  8000eb:	51                   	push   %ecx
  8000ec:	50                   	push   %eax
  8000ed:	68 c0 1c 80 00       	push   $0x801cc0
  8000f2:	e8 e6 15 00 00       	call   8016dd <sys_create_env>
  8000f7:	83 c4 10             	add    $0x10,%esp
  8000fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (ID == E_ENV_CREATION_ERROR)
  8000fd:	83 7d ec ef          	cmpl   $0xffffffef,-0x14(%ebp)
  800101:	75 14                	jne    800117 <_main+0xdf>
				panic("RUNNING OUT OF ENV!! terminating...");
  800103:	83 ec 04             	sub    $0x4,%esp
  800106:	68 c8 1c 80 00       	push   $0x801cc8
  80010b:	6a 15                	push   $0x15
  80010d:	68 ec 1c 80 00       	push   $0x801cec
  800112:	e8 c4 01 00 00       	call   8002db <_panic>
			sys_run_env(ID);
  800117:	83 ec 0c             	sub    $0xc,%esp
  80011a:	ff 75 ec             	pushl  -0x14(%ebp)
  80011d:	e8 d9 15 00 00       	call   8016fb <sys_run_env>
  800122:	83 c4 10             	add    $0x10,%esp
			x = busy_wait(10000);
  800125:	83 ec 0c             	sub    $0xc,%esp
  800128:	68 10 27 00 00       	push   $0x2710
  80012d:	e8 f8 18 00 00       	call   801a2a <busy_wait>
  800132:	83 c4 10             	add    $0x10,%esp
  800135:	89 45 e8             	mov    %eax,-0x18(%ebp)
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  800138:	a1 20 30 80 00       	mov    0x803020,%eax
  80013d:	8b 90 f4 52 00 00    	mov    0x52f4(%eax),%edx
  800143:	a1 20 30 80 00       	mov    0x803020,%eax
  800148:	8b 80 34 53 00 00    	mov    0x5334(%eax),%eax
  80014e:	89 c1                	mov    %eax,%ecx
  800150:	a1 20 30 80 00       	mov    0x803020,%eax
  800155:	8b 40 74             	mov    0x74(%eax),%eax
  800158:	52                   	push   %edx
  800159:	51                   	push   %ecx
  80015a:	50                   	push   %eax
  80015b:	68 c0 1c 80 00       	push   $0x801cc0
  800160:	e8 78 15 00 00       	call   8016dd <sys_create_env>
  800165:	83 c4 10             	add    $0x10,%esp
  800168:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (ID == E_ENV_CREATION_ERROR)
  80016b:	83 7d ec ef          	cmpl   $0xffffffef,-0x14(%ebp)
  80016f:	75 14                	jne    800185 <_main+0x14d>
				panic("RUNNING OUT OF ENV!! terminating...");
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 c8 1c 80 00       	push   $0x801cc8
  800179:	6a 1a                	push   $0x1a
  80017b:	68 ec 1c 80 00       	push   $0x801cec
  800180:	e8 56 01 00 00       	call   8002db <_panic>
			sys_run_env(ID);
  800185:	83 ec 0c             	sub    $0xc,%esp
  800188:	ff 75 ec             	pushl  -0x14(%ebp)
  80018b:	e8 6b 15 00 00       	call   8016fb <sys_run_env>
  800190:	83 c4 10             	add    $0x10,%esp
		}
	//cprintf("done\n");
	//env_sleep(5000);
	int x = busy_wait(1000000);

	for (int i = 0; i < 5; ++i) {
  800193:	ff 45 f0             	incl   -0x10(%ebp)
  800196:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
  80019a:	0f 8e 2a ff ff ff    	jle    8000ca <_main+0x92>
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
			if (ID == E_ENV_CREATION_ERROR)
				panic("RUNNING OUT OF ENV!! terminating...");
			sys_run_env(ID);
		}
	x = busy_wait(1000000);
  8001a0:	83 ec 0c             	sub    $0xc,%esp
  8001a3:	68 40 42 0f 00       	push   $0xf4240
  8001a8:	e8 7d 18 00 00       	call   801a2a <busy_wait>
  8001ad:	83 c4 10             	add    $0x10,%esp
  8001b0:	89 45 e8             	mov    %eax,-0x18(%ebp)

}
  8001b3:	90                   	nop
  8001b4:	c9                   	leave  
  8001b5:	c3                   	ret    

008001b6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001b6:	55                   	push   %ebp
  8001b7:	89 e5                	mov    %esp,%ebp
  8001b9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001bc:	e8 fc 11 00 00       	call   8013bd <sys_getenvindex>
  8001c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001c7:	89 d0                	mov    %edx,%eax
  8001c9:	c1 e0 03             	shl    $0x3,%eax
  8001cc:	01 d0                	add    %edx,%eax
  8001ce:	c1 e0 02             	shl    $0x2,%eax
  8001d1:	01 d0                	add    %edx,%eax
  8001d3:	c1 e0 06             	shl    $0x6,%eax
  8001d6:	29 d0                	sub    %edx,%eax
  8001d8:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001df:	01 c8                	add    %ecx,%eax
  8001e1:	01 d0                	add    %edx,%eax
  8001e3:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8001e8:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f2:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8001f8:	84 c0                	test   %al,%al
  8001fa:	74 0f                	je     80020b <libmain+0x55>
		binaryname = myEnv->prog_name;
  8001fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800201:	05 b0 52 00 00       	add    $0x52b0,%eax
  800206:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80020b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80020f:	7e 0a                	jle    80021b <libmain+0x65>
		binaryname = argv[0];
  800211:	8b 45 0c             	mov    0xc(%ebp),%eax
  800214:	8b 00                	mov    (%eax),%eax
  800216:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80021b:	83 ec 08             	sub    $0x8,%esp
  80021e:	ff 75 0c             	pushl  0xc(%ebp)
  800221:	ff 75 08             	pushl  0x8(%ebp)
  800224:	e8 0f fe ff ff       	call   800038 <_main>
  800229:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80022c:	e8 27 13 00 00       	call   801558 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800231:	83 ec 0c             	sub    $0xc,%esp
  800234:	68 24 1d 80 00       	push   $0x801d24
  800239:	e8 54 03 00 00       	call   800592 <cprintf>
  80023e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800241:	a1 20 30 80 00       	mov    0x803020,%eax
  800246:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  80024c:	a1 20 30 80 00       	mov    0x803020,%eax
  800251:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800257:	83 ec 04             	sub    $0x4,%esp
  80025a:	52                   	push   %edx
  80025b:	50                   	push   %eax
  80025c:	68 4c 1d 80 00       	push   $0x801d4c
  800261:	e8 2c 03 00 00       	call   800592 <cprintf>
  800266:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800269:	a1 20 30 80 00       	mov    0x803020,%eax
  80026e:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800274:	a1 20 30 80 00       	mov    0x803020,%eax
  800279:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  80027f:	a1 20 30 80 00       	mov    0x803020,%eax
  800284:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  80028a:	51                   	push   %ecx
  80028b:	52                   	push   %edx
  80028c:	50                   	push   %eax
  80028d:	68 74 1d 80 00       	push   $0x801d74
  800292:	e8 fb 02 00 00       	call   800592 <cprintf>
  800297:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	68 24 1d 80 00       	push   $0x801d24
  8002a2:	e8 eb 02 00 00       	call   800592 <cprintf>
  8002a7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002aa:	e8 c3 12 00 00       	call   801572 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002af:	e8 19 00 00 00       	call   8002cd <exit>
}
  8002b4:	90                   	nop
  8002b5:	c9                   	leave  
  8002b6:	c3                   	ret    

008002b7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002b7:	55                   	push   %ebp
  8002b8:	89 e5                	mov    %esp,%ebp
  8002ba:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002bd:	83 ec 0c             	sub    $0xc,%esp
  8002c0:	6a 00                	push   $0x0
  8002c2:	e8 c2 10 00 00       	call   801389 <sys_env_destroy>
  8002c7:	83 c4 10             	add    $0x10,%esp
}
  8002ca:	90                   	nop
  8002cb:	c9                   	leave  
  8002cc:	c3                   	ret    

008002cd <exit>:

void
exit(void)
{
  8002cd:	55                   	push   %ebp
  8002ce:	89 e5                	mov    %esp,%ebp
  8002d0:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002d3:	e8 17 11 00 00       	call   8013ef <sys_env_exit>
}
  8002d8:	90                   	nop
  8002d9:	c9                   	leave  
  8002da:	c3                   	ret    

008002db <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002db:	55                   	push   %ebp
  8002dc:	89 e5                	mov    %esp,%ebp
  8002de:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002e1:	8d 45 10             	lea    0x10(%ebp),%eax
  8002e4:	83 c0 04             	add    $0x4,%eax
  8002e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002ea:	a1 18 31 80 00       	mov    0x803118,%eax
  8002ef:	85 c0                	test   %eax,%eax
  8002f1:	74 16                	je     800309 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002f3:	a1 18 31 80 00       	mov    0x803118,%eax
  8002f8:	83 ec 08             	sub    $0x8,%esp
  8002fb:	50                   	push   %eax
  8002fc:	68 cc 1d 80 00       	push   $0x801dcc
  800301:	e8 8c 02 00 00       	call   800592 <cprintf>
  800306:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800309:	a1 00 30 80 00       	mov    0x803000,%eax
  80030e:	ff 75 0c             	pushl  0xc(%ebp)
  800311:	ff 75 08             	pushl  0x8(%ebp)
  800314:	50                   	push   %eax
  800315:	68 d1 1d 80 00       	push   $0x801dd1
  80031a:	e8 73 02 00 00       	call   800592 <cprintf>
  80031f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800322:	8b 45 10             	mov    0x10(%ebp),%eax
  800325:	83 ec 08             	sub    $0x8,%esp
  800328:	ff 75 f4             	pushl  -0xc(%ebp)
  80032b:	50                   	push   %eax
  80032c:	e8 f6 01 00 00       	call   800527 <vcprintf>
  800331:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800334:	83 ec 08             	sub    $0x8,%esp
  800337:	6a 00                	push   $0x0
  800339:	68 ed 1d 80 00       	push   $0x801ded
  80033e:	e8 e4 01 00 00       	call   800527 <vcprintf>
  800343:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800346:	e8 82 ff ff ff       	call   8002cd <exit>

	// should not return here
	while (1) ;
  80034b:	eb fe                	jmp    80034b <_panic+0x70>

0080034d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80034d:	55                   	push   %ebp
  80034e:	89 e5                	mov    %esp,%ebp
  800350:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800353:	a1 20 30 80 00       	mov    0x803020,%eax
  800358:	8b 50 74             	mov    0x74(%eax),%edx
  80035b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80035e:	39 c2                	cmp    %eax,%edx
  800360:	74 14                	je     800376 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800362:	83 ec 04             	sub    $0x4,%esp
  800365:	68 f0 1d 80 00       	push   $0x801df0
  80036a:	6a 26                	push   $0x26
  80036c:	68 3c 1e 80 00       	push   $0x801e3c
  800371:	e8 65 ff ff ff       	call   8002db <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800376:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80037d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800384:	e9 c4 00 00 00       	jmp    80044d <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800389:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80038c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800393:	8b 45 08             	mov    0x8(%ebp),%eax
  800396:	01 d0                	add    %edx,%eax
  800398:	8b 00                	mov    (%eax),%eax
  80039a:	85 c0                	test   %eax,%eax
  80039c:	75 08                	jne    8003a6 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80039e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003a1:	e9 a4 00 00 00       	jmp    80044a <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8003a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003ad:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003b4:	eb 6b                	jmp    800421 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bb:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8003c1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003c4:	89 d0                	mov    %edx,%eax
  8003c6:	c1 e0 02             	shl    $0x2,%eax
  8003c9:	01 d0                	add    %edx,%eax
  8003cb:	c1 e0 02             	shl    $0x2,%eax
  8003ce:	01 c8                	add    %ecx,%eax
  8003d0:	8a 40 04             	mov    0x4(%eax),%al
  8003d3:	84 c0                	test   %al,%al
  8003d5:	75 47                	jne    80041e <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003dc:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8003e2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003e5:	89 d0                	mov    %edx,%eax
  8003e7:	c1 e0 02             	shl    $0x2,%eax
  8003ea:	01 d0                	add    %edx,%eax
  8003ec:	c1 e0 02             	shl    $0x2,%eax
  8003ef:	01 c8                	add    %ecx,%eax
  8003f1:	8b 00                	mov    (%eax),%eax
  8003f3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003f6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003fe:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800400:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800403:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80040a:	8b 45 08             	mov    0x8(%ebp),%eax
  80040d:	01 c8                	add    %ecx,%eax
  80040f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800411:	39 c2                	cmp    %eax,%edx
  800413:	75 09                	jne    80041e <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800415:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80041c:	eb 12                	jmp    800430 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80041e:	ff 45 e8             	incl   -0x18(%ebp)
  800421:	a1 20 30 80 00       	mov    0x803020,%eax
  800426:	8b 50 74             	mov    0x74(%eax),%edx
  800429:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80042c:	39 c2                	cmp    %eax,%edx
  80042e:	77 86                	ja     8003b6 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800430:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800434:	75 14                	jne    80044a <CheckWSWithoutLastIndex+0xfd>
			panic(
  800436:	83 ec 04             	sub    $0x4,%esp
  800439:	68 48 1e 80 00       	push   $0x801e48
  80043e:	6a 3a                	push   $0x3a
  800440:	68 3c 1e 80 00       	push   $0x801e3c
  800445:	e8 91 fe ff ff       	call   8002db <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80044a:	ff 45 f0             	incl   -0x10(%ebp)
  80044d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800450:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800453:	0f 8c 30 ff ff ff    	jl     800389 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800459:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800460:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800467:	eb 27                	jmp    800490 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800469:	a1 20 30 80 00       	mov    0x803020,%eax
  80046e:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800474:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800477:	89 d0                	mov    %edx,%eax
  800479:	c1 e0 02             	shl    $0x2,%eax
  80047c:	01 d0                	add    %edx,%eax
  80047e:	c1 e0 02             	shl    $0x2,%eax
  800481:	01 c8                	add    %ecx,%eax
  800483:	8a 40 04             	mov    0x4(%eax),%al
  800486:	3c 01                	cmp    $0x1,%al
  800488:	75 03                	jne    80048d <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  80048a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80048d:	ff 45 e0             	incl   -0x20(%ebp)
  800490:	a1 20 30 80 00       	mov    0x803020,%eax
  800495:	8b 50 74             	mov    0x74(%eax),%edx
  800498:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80049b:	39 c2                	cmp    %eax,%edx
  80049d:	77 ca                	ja     800469 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80049f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004a2:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004a5:	74 14                	je     8004bb <CheckWSWithoutLastIndex+0x16e>
		panic(
  8004a7:	83 ec 04             	sub    $0x4,%esp
  8004aa:	68 9c 1e 80 00       	push   $0x801e9c
  8004af:	6a 44                	push   $0x44
  8004b1:	68 3c 1e 80 00       	push   $0x801e3c
  8004b6:	e8 20 fe ff ff       	call   8002db <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004bb:	90                   	nop
  8004bc:	c9                   	leave  
  8004bd:	c3                   	ret    

008004be <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004be:	55                   	push   %ebp
  8004bf:	89 e5                	mov    %esp,%ebp
  8004c1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c7:	8b 00                	mov    (%eax),%eax
  8004c9:	8d 48 01             	lea    0x1(%eax),%ecx
  8004cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004cf:	89 0a                	mov    %ecx,(%edx)
  8004d1:	8b 55 08             	mov    0x8(%ebp),%edx
  8004d4:	88 d1                	mov    %dl,%cl
  8004d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004d9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e0:	8b 00                	mov    (%eax),%eax
  8004e2:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004e7:	75 2c                	jne    800515 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004e9:	a0 24 30 80 00       	mov    0x803024,%al
  8004ee:	0f b6 c0             	movzbl %al,%eax
  8004f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004f4:	8b 12                	mov    (%edx),%edx
  8004f6:	89 d1                	mov    %edx,%ecx
  8004f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004fb:	83 c2 08             	add    $0x8,%edx
  8004fe:	83 ec 04             	sub    $0x4,%esp
  800501:	50                   	push   %eax
  800502:	51                   	push   %ecx
  800503:	52                   	push   %edx
  800504:	e8 3e 0e 00 00       	call   801347 <sys_cputs>
  800509:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80050c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80050f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800515:	8b 45 0c             	mov    0xc(%ebp),%eax
  800518:	8b 40 04             	mov    0x4(%eax),%eax
  80051b:	8d 50 01             	lea    0x1(%eax),%edx
  80051e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800521:	89 50 04             	mov    %edx,0x4(%eax)
}
  800524:	90                   	nop
  800525:	c9                   	leave  
  800526:	c3                   	ret    

00800527 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800527:	55                   	push   %ebp
  800528:	89 e5                	mov    %esp,%ebp
  80052a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800530:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800537:	00 00 00 
	b.cnt = 0;
  80053a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800541:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800544:	ff 75 0c             	pushl  0xc(%ebp)
  800547:	ff 75 08             	pushl  0x8(%ebp)
  80054a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800550:	50                   	push   %eax
  800551:	68 be 04 80 00       	push   $0x8004be
  800556:	e8 11 02 00 00       	call   80076c <vprintfmt>
  80055b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80055e:	a0 24 30 80 00       	mov    0x803024,%al
  800563:	0f b6 c0             	movzbl %al,%eax
  800566:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80056c:	83 ec 04             	sub    $0x4,%esp
  80056f:	50                   	push   %eax
  800570:	52                   	push   %edx
  800571:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800577:	83 c0 08             	add    $0x8,%eax
  80057a:	50                   	push   %eax
  80057b:	e8 c7 0d 00 00       	call   801347 <sys_cputs>
  800580:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800583:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80058a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800590:	c9                   	leave  
  800591:	c3                   	ret    

00800592 <cprintf>:

int cprintf(const char *fmt, ...) {
  800592:	55                   	push   %ebp
  800593:	89 e5                	mov    %esp,%ebp
  800595:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800598:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80059f:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a8:	83 ec 08             	sub    $0x8,%esp
  8005ab:	ff 75 f4             	pushl  -0xc(%ebp)
  8005ae:	50                   	push   %eax
  8005af:	e8 73 ff ff ff       	call   800527 <vcprintf>
  8005b4:	83 c4 10             	add    $0x10,%esp
  8005b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005bd:	c9                   	leave  
  8005be:	c3                   	ret    

008005bf <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005bf:	55                   	push   %ebp
  8005c0:	89 e5                	mov    %esp,%ebp
  8005c2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005c5:	e8 8e 0f 00 00       	call   801558 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005ca:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d3:	83 ec 08             	sub    $0x8,%esp
  8005d6:	ff 75 f4             	pushl  -0xc(%ebp)
  8005d9:	50                   	push   %eax
  8005da:	e8 48 ff ff ff       	call   800527 <vcprintf>
  8005df:	83 c4 10             	add    $0x10,%esp
  8005e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005e5:	e8 88 0f 00 00       	call   801572 <sys_enable_interrupt>
	return cnt;
  8005ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005ed:	c9                   	leave  
  8005ee:	c3                   	ret    

008005ef <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005ef:	55                   	push   %ebp
  8005f0:	89 e5                	mov    %esp,%ebp
  8005f2:	53                   	push   %ebx
  8005f3:	83 ec 14             	sub    $0x14,%esp
  8005f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8005f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800602:	8b 45 18             	mov    0x18(%ebp),%eax
  800605:	ba 00 00 00 00       	mov    $0x0,%edx
  80060a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80060d:	77 55                	ja     800664 <printnum+0x75>
  80060f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800612:	72 05                	jb     800619 <printnum+0x2a>
  800614:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800617:	77 4b                	ja     800664 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800619:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80061c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80061f:	8b 45 18             	mov    0x18(%ebp),%eax
  800622:	ba 00 00 00 00       	mov    $0x0,%edx
  800627:	52                   	push   %edx
  800628:	50                   	push   %eax
  800629:	ff 75 f4             	pushl  -0xc(%ebp)
  80062c:	ff 75 f0             	pushl  -0x10(%ebp)
  80062f:	e8 18 14 00 00       	call   801a4c <__udivdi3>
  800634:	83 c4 10             	add    $0x10,%esp
  800637:	83 ec 04             	sub    $0x4,%esp
  80063a:	ff 75 20             	pushl  0x20(%ebp)
  80063d:	53                   	push   %ebx
  80063e:	ff 75 18             	pushl  0x18(%ebp)
  800641:	52                   	push   %edx
  800642:	50                   	push   %eax
  800643:	ff 75 0c             	pushl  0xc(%ebp)
  800646:	ff 75 08             	pushl  0x8(%ebp)
  800649:	e8 a1 ff ff ff       	call   8005ef <printnum>
  80064e:	83 c4 20             	add    $0x20,%esp
  800651:	eb 1a                	jmp    80066d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800653:	83 ec 08             	sub    $0x8,%esp
  800656:	ff 75 0c             	pushl  0xc(%ebp)
  800659:	ff 75 20             	pushl  0x20(%ebp)
  80065c:	8b 45 08             	mov    0x8(%ebp),%eax
  80065f:	ff d0                	call   *%eax
  800661:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800664:	ff 4d 1c             	decl   0x1c(%ebp)
  800667:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80066b:	7f e6                	jg     800653 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80066d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800670:	bb 00 00 00 00       	mov    $0x0,%ebx
  800675:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800678:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80067b:	53                   	push   %ebx
  80067c:	51                   	push   %ecx
  80067d:	52                   	push   %edx
  80067e:	50                   	push   %eax
  80067f:	e8 d8 14 00 00       	call   801b5c <__umoddi3>
  800684:	83 c4 10             	add    $0x10,%esp
  800687:	05 14 21 80 00       	add    $0x802114,%eax
  80068c:	8a 00                	mov    (%eax),%al
  80068e:	0f be c0             	movsbl %al,%eax
  800691:	83 ec 08             	sub    $0x8,%esp
  800694:	ff 75 0c             	pushl  0xc(%ebp)
  800697:	50                   	push   %eax
  800698:	8b 45 08             	mov    0x8(%ebp),%eax
  80069b:	ff d0                	call   *%eax
  80069d:	83 c4 10             	add    $0x10,%esp
}
  8006a0:	90                   	nop
  8006a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006a4:	c9                   	leave  
  8006a5:	c3                   	ret    

008006a6 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006a6:	55                   	push   %ebp
  8006a7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006a9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006ad:	7e 1c                	jle    8006cb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006af:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b2:	8b 00                	mov    (%eax),%eax
  8006b4:	8d 50 08             	lea    0x8(%eax),%edx
  8006b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ba:	89 10                	mov    %edx,(%eax)
  8006bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bf:	8b 00                	mov    (%eax),%eax
  8006c1:	83 e8 08             	sub    $0x8,%eax
  8006c4:	8b 50 04             	mov    0x4(%eax),%edx
  8006c7:	8b 00                	mov    (%eax),%eax
  8006c9:	eb 40                	jmp    80070b <getuint+0x65>
	else if (lflag)
  8006cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006cf:	74 1e                	je     8006ef <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d4:	8b 00                	mov    (%eax),%eax
  8006d6:	8d 50 04             	lea    0x4(%eax),%edx
  8006d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dc:	89 10                	mov    %edx,(%eax)
  8006de:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e1:	8b 00                	mov    (%eax),%eax
  8006e3:	83 e8 04             	sub    $0x4,%eax
  8006e6:	8b 00                	mov    (%eax),%eax
  8006e8:	ba 00 00 00 00       	mov    $0x0,%edx
  8006ed:	eb 1c                	jmp    80070b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f2:	8b 00                	mov    (%eax),%eax
  8006f4:	8d 50 04             	lea    0x4(%eax),%edx
  8006f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fa:	89 10                	mov    %edx,(%eax)
  8006fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ff:	8b 00                	mov    (%eax),%eax
  800701:	83 e8 04             	sub    $0x4,%eax
  800704:	8b 00                	mov    (%eax),%eax
  800706:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80070b:	5d                   	pop    %ebp
  80070c:	c3                   	ret    

0080070d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80070d:	55                   	push   %ebp
  80070e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800710:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800714:	7e 1c                	jle    800732 <getint+0x25>
		return va_arg(*ap, long long);
  800716:	8b 45 08             	mov    0x8(%ebp),%eax
  800719:	8b 00                	mov    (%eax),%eax
  80071b:	8d 50 08             	lea    0x8(%eax),%edx
  80071e:	8b 45 08             	mov    0x8(%ebp),%eax
  800721:	89 10                	mov    %edx,(%eax)
  800723:	8b 45 08             	mov    0x8(%ebp),%eax
  800726:	8b 00                	mov    (%eax),%eax
  800728:	83 e8 08             	sub    $0x8,%eax
  80072b:	8b 50 04             	mov    0x4(%eax),%edx
  80072e:	8b 00                	mov    (%eax),%eax
  800730:	eb 38                	jmp    80076a <getint+0x5d>
	else if (lflag)
  800732:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800736:	74 1a                	je     800752 <getint+0x45>
		return va_arg(*ap, long);
  800738:	8b 45 08             	mov    0x8(%ebp),%eax
  80073b:	8b 00                	mov    (%eax),%eax
  80073d:	8d 50 04             	lea    0x4(%eax),%edx
  800740:	8b 45 08             	mov    0x8(%ebp),%eax
  800743:	89 10                	mov    %edx,(%eax)
  800745:	8b 45 08             	mov    0x8(%ebp),%eax
  800748:	8b 00                	mov    (%eax),%eax
  80074a:	83 e8 04             	sub    $0x4,%eax
  80074d:	8b 00                	mov    (%eax),%eax
  80074f:	99                   	cltd   
  800750:	eb 18                	jmp    80076a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800752:	8b 45 08             	mov    0x8(%ebp),%eax
  800755:	8b 00                	mov    (%eax),%eax
  800757:	8d 50 04             	lea    0x4(%eax),%edx
  80075a:	8b 45 08             	mov    0x8(%ebp),%eax
  80075d:	89 10                	mov    %edx,(%eax)
  80075f:	8b 45 08             	mov    0x8(%ebp),%eax
  800762:	8b 00                	mov    (%eax),%eax
  800764:	83 e8 04             	sub    $0x4,%eax
  800767:	8b 00                	mov    (%eax),%eax
  800769:	99                   	cltd   
}
  80076a:	5d                   	pop    %ebp
  80076b:	c3                   	ret    

0080076c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80076c:	55                   	push   %ebp
  80076d:	89 e5                	mov    %esp,%ebp
  80076f:	56                   	push   %esi
  800770:	53                   	push   %ebx
  800771:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800774:	eb 17                	jmp    80078d <vprintfmt+0x21>
			if (ch == '\0')
  800776:	85 db                	test   %ebx,%ebx
  800778:	0f 84 af 03 00 00    	je     800b2d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80077e:	83 ec 08             	sub    $0x8,%esp
  800781:	ff 75 0c             	pushl  0xc(%ebp)
  800784:	53                   	push   %ebx
  800785:	8b 45 08             	mov    0x8(%ebp),%eax
  800788:	ff d0                	call   *%eax
  80078a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80078d:	8b 45 10             	mov    0x10(%ebp),%eax
  800790:	8d 50 01             	lea    0x1(%eax),%edx
  800793:	89 55 10             	mov    %edx,0x10(%ebp)
  800796:	8a 00                	mov    (%eax),%al
  800798:	0f b6 d8             	movzbl %al,%ebx
  80079b:	83 fb 25             	cmp    $0x25,%ebx
  80079e:	75 d6                	jne    800776 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007a0:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007a4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007ab:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007b2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007b9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c3:	8d 50 01             	lea    0x1(%eax),%edx
  8007c6:	89 55 10             	mov    %edx,0x10(%ebp)
  8007c9:	8a 00                	mov    (%eax),%al
  8007cb:	0f b6 d8             	movzbl %al,%ebx
  8007ce:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007d1:	83 f8 55             	cmp    $0x55,%eax
  8007d4:	0f 87 2b 03 00 00    	ja     800b05 <vprintfmt+0x399>
  8007da:	8b 04 85 38 21 80 00 	mov    0x802138(,%eax,4),%eax
  8007e1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007e3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007e7:	eb d7                	jmp    8007c0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007e9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007ed:	eb d1                	jmp    8007c0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007ef:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007f6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007f9:	89 d0                	mov    %edx,%eax
  8007fb:	c1 e0 02             	shl    $0x2,%eax
  8007fe:	01 d0                	add    %edx,%eax
  800800:	01 c0                	add    %eax,%eax
  800802:	01 d8                	add    %ebx,%eax
  800804:	83 e8 30             	sub    $0x30,%eax
  800807:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80080a:	8b 45 10             	mov    0x10(%ebp),%eax
  80080d:	8a 00                	mov    (%eax),%al
  80080f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800812:	83 fb 2f             	cmp    $0x2f,%ebx
  800815:	7e 3e                	jle    800855 <vprintfmt+0xe9>
  800817:	83 fb 39             	cmp    $0x39,%ebx
  80081a:	7f 39                	jg     800855 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80081c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80081f:	eb d5                	jmp    8007f6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800821:	8b 45 14             	mov    0x14(%ebp),%eax
  800824:	83 c0 04             	add    $0x4,%eax
  800827:	89 45 14             	mov    %eax,0x14(%ebp)
  80082a:	8b 45 14             	mov    0x14(%ebp),%eax
  80082d:	83 e8 04             	sub    $0x4,%eax
  800830:	8b 00                	mov    (%eax),%eax
  800832:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800835:	eb 1f                	jmp    800856 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800837:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80083b:	79 83                	jns    8007c0 <vprintfmt+0x54>
				width = 0;
  80083d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800844:	e9 77 ff ff ff       	jmp    8007c0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800849:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800850:	e9 6b ff ff ff       	jmp    8007c0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800855:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800856:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80085a:	0f 89 60 ff ff ff    	jns    8007c0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800860:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800863:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800866:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80086d:	e9 4e ff ff ff       	jmp    8007c0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800872:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800875:	e9 46 ff ff ff       	jmp    8007c0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80087a:	8b 45 14             	mov    0x14(%ebp),%eax
  80087d:	83 c0 04             	add    $0x4,%eax
  800880:	89 45 14             	mov    %eax,0x14(%ebp)
  800883:	8b 45 14             	mov    0x14(%ebp),%eax
  800886:	83 e8 04             	sub    $0x4,%eax
  800889:	8b 00                	mov    (%eax),%eax
  80088b:	83 ec 08             	sub    $0x8,%esp
  80088e:	ff 75 0c             	pushl  0xc(%ebp)
  800891:	50                   	push   %eax
  800892:	8b 45 08             	mov    0x8(%ebp),%eax
  800895:	ff d0                	call   *%eax
  800897:	83 c4 10             	add    $0x10,%esp
			break;
  80089a:	e9 89 02 00 00       	jmp    800b28 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80089f:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a2:	83 c0 04             	add    $0x4,%eax
  8008a5:	89 45 14             	mov    %eax,0x14(%ebp)
  8008a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ab:	83 e8 04             	sub    $0x4,%eax
  8008ae:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008b0:	85 db                	test   %ebx,%ebx
  8008b2:	79 02                	jns    8008b6 <vprintfmt+0x14a>
				err = -err;
  8008b4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008b6:	83 fb 64             	cmp    $0x64,%ebx
  8008b9:	7f 0b                	jg     8008c6 <vprintfmt+0x15a>
  8008bb:	8b 34 9d 80 1f 80 00 	mov    0x801f80(,%ebx,4),%esi
  8008c2:	85 f6                	test   %esi,%esi
  8008c4:	75 19                	jne    8008df <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008c6:	53                   	push   %ebx
  8008c7:	68 25 21 80 00       	push   $0x802125
  8008cc:	ff 75 0c             	pushl  0xc(%ebp)
  8008cf:	ff 75 08             	pushl  0x8(%ebp)
  8008d2:	e8 5e 02 00 00       	call   800b35 <printfmt>
  8008d7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008da:	e9 49 02 00 00       	jmp    800b28 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008df:	56                   	push   %esi
  8008e0:	68 2e 21 80 00       	push   $0x80212e
  8008e5:	ff 75 0c             	pushl  0xc(%ebp)
  8008e8:	ff 75 08             	pushl  0x8(%ebp)
  8008eb:	e8 45 02 00 00       	call   800b35 <printfmt>
  8008f0:	83 c4 10             	add    $0x10,%esp
			break;
  8008f3:	e9 30 02 00 00       	jmp    800b28 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8008fb:	83 c0 04             	add    $0x4,%eax
  8008fe:	89 45 14             	mov    %eax,0x14(%ebp)
  800901:	8b 45 14             	mov    0x14(%ebp),%eax
  800904:	83 e8 04             	sub    $0x4,%eax
  800907:	8b 30                	mov    (%eax),%esi
  800909:	85 f6                	test   %esi,%esi
  80090b:	75 05                	jne    800912 <vprintfmt+0x1a6>
				p = "(null)";
  80090d:	be 31 21 80 00       	mov    $0x802131,%esi
			if (width > 0 && padc != '-')
  800912:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800916:	7e 6d                	jle    800985 <vprintfmt+0x219>
  800918:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80091c:	74 67                	je     800985 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80091e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800921:	83 ec 08             	sub    $0x8,%esp
  800924:	50                   	push   %eax
  800925:	56                   	push   %esi
  800926:	e8 0c 03 00 00       	call   800c37 <strnlen>
  80092b:	83 c4 10             	add    $0x10,%esp
  80092e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800931:	eb 16                	jmp    800949 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800933:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800937:	83 ec 08             	sub    $0x8,%esp
  80093a:	ff 75 0c             	pushl  0xc(%ebp)
  80093d:	50                   	push   %eax
  80093e:	8b 45 08             	mov    0x8(%ebp),%eax
  800941:	ff d0                	call   *%eax
  800943:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800946:	ff 4d e4             	decl   -0x1c(%ebp)
  800949:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80094d:	7f e4                	jg     800933 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80094f:	eb 34                	jmp    800985 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800951:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800955:	74 1c                	je     800973 <vprintfmt+0x207>
  800957:	83 fb 1f             	cmp    $0x1f,%ebx
  80095a:	7e 05                	jle    800961 <vprintfmt+0x1f5>
  80095c:	83 fb 7e             	cmp    $0x7e,%ebx
  80095f:	7e 12                	jle    800973 <vprintfmt+0x207>
					putch('?', putdat);
  800961:	83 ec 08             	sub    $0x8,%esp
  800964:	ff 75 0c             	pushl  0xc(%ebp)
  800967:	6a 3f                	push   $0x3f
  800969:	8b 45 08             	mov    0x8(%ebp),%eax
  80096c:	ff d0                	call   *%eax
  80096e:	83 c4 10             	add    $0x10,%esp
  800971:	eb 0f                	jmp    800982 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800973:	83 ec 08             	sub    $0x8,%esp
  800976:	ff 75 0c             	pushl  0xc(%ebp)
  800979:	53                   	push   %ebx
  80097a:	8b 45 08             	mov    0x8(%ebp),%eax
  80097d:	ff d0                	call   *%eax
  80097f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800982:	ff 4d e4             	decl   -0x1c(%ebp)
  800985:	89 f0                	mov    %esi,%eax
  800987:	8d 70 01             	lea    0x1(%eax),%esi
  80098a:	8a 00                	mov    (%eax),%al
  80098c:	0f be d8             	movsbl %al,%ebx
  80098f:	85 db                	test   %ebx,%ebx
  800991:	74 24                	je     8009b7 <vprintfmt+0x24b>
  800993:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800997:	78 b8                	js     800951 <vprintfmt+0x1e5>
  800999:	ff 4d e0             	decl   -0x20(%ebp)
  80099c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009a0:	79 af                	jns    800951 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009a2:	eb 13                	jmp    8009b7 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009a4:	83 ec 08             	sub    $0x8,%esp
  8009a7:	ff 75 0c             	pushl  0xc(%ebp)
  8009aa:	6a 20                	push   $0x20
  8009ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8009af:	ff d0                	call   *%eax
  8009b1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009b4:	ff 4d e4             	decl   -0x1c(%ebp)
  8009b7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009bb:	7f e7                	jg     8009a4 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009bd:	e9 66 01 00 00       	jmp    800b28 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009c2:	83 ec 08             	sub    $0x8,%esp
  8009c5:	ff 75 e8             	pushl  -0x18(%ebp)
  8009c8:	8d 45 14             	lea    0x14(%ebp),%eax
  8009cb:	50                   	push   %eax
  8009cc:	e8 3c fd ff ff       	call   80070d <getint>
  8009d1:	83 c4 10             	add    $0x10,%esp
  8009d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009e0:	85 d2                	test   %edx,%edx
  8009e2:	79 23                	jns    800a07 <vprintfmt+0x29b>
				putch('-', putdat);
  8009e4:	83 ec 08             	sub    $0x8,%esp
  8009e7:	ff 75 0c             	pushl  0xc(%ebp)
  8009ea:	6a 2d                	push   $0x2d
  8009ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ef:	ff d0                	call   *%eax
  8009f1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009fa:	f7 d8                	neg    %eax
  8009fc:	83 d2 00             	adc    $0x0,%edx
  8009ff:	f7 da                	neg    %edx
  800a01:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a04:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a07:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a0e:	e9 bc 00 00 00       	jmp    800acf <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a13:	83 ec 08             	sub    $0x8,%esp
  800a16:	ff 75 e8             	pushl  -0x18(%ebp)
  800a19:	8d 45 14             	lea    0x14(%ebp),%eax
  800a1c:	50                   	push   %eax
  800a1d:	e8 84 fc ff ff       	call   8006a6 <getuint>
  800a22:	83 c4 10             	add    $0x10,%esp
  800a25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a28:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a2b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a32:	e9 98 00 00 00       	jmp    800acf <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a37:	83 ec 08             	sub    $0x8,%esp
  800a3a:	ff 75 0c             	pushl  0xc(%ebp)
  800a3d:	6a 58                	push   $0x58
  800a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a42:	ff d0                	call   *%eax
  800a44:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a47:	83 ec 08             	sub    $0x8,%esp
  800a4a:	ff 75 0c             	pushl  0xc(%ebp)
  800a4d:	6a 58                	push   $0x58
  800a4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a52:	ff d0                	call   *%eax
  800a54:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a57:	83 ec 08             	sub    $0x8,%esp
  800a5a:	ff 75 0c             	pushl  0xc(%ebp)
  800a5d:	6a 58                	push   $0x58
  800a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a62:	ff d0                	call   *%eax
  800a64:	83 c4 10             	add    $0x10,%esp
			break;
  800a67:	e9 bc 00 00 00       	jmp    800b28 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a6c:	83 ec 08             	sub    $0x8,%esp
  800a6f:	ff 75 0c             	pushl  0xc(%ebp)
  800a72:	6a 30                	push   $0x30
  800a74:	8b 45 08             	mov    0x8(%ebp),%eax
  800a77:	ff d0                	call   *%eax
  800a79:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a7c:	83 ec 08             	sub    $0x8,%esp
  800a7f:	ff 75 0c             	pushl  0xc(%ebp)
  800a82:	6a 78                	push   $0x78
  800a84:	8b 45 08             	mov    0x8(%ebp),%eax
  800a87:	ff d0                	call   *%eax
  800a89:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a8c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a8f:	83 c0 04             	add    $0x4,%eax
  800a92:	89 45 14             	mov    %eax,0x14(%ebp)
  800a95:	8b 45 14             	mov    0x14(%ebp),%eax
  800a98:	83 e8 04             	sub    $0x4,%eax
  800a9b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aa0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800aa7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800aae:	eb 1f                	jmp    800acf <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ab0:	83 ec 08             	sub    $0x8,%esp
  800ab3:	ff 75 e8             	pushl  -0x18(%ebp)
  800ab6:	8d 45 14             	lea    0x14(%ebp),%eax
  800ab9:	50                   	push   %eax
  800aba:	e8 e7 fb ff ff       	call   8006a6 <getuint>
  800abf:	83 c4 10             	add    $0x10,%esp
  800ac2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ac8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800acf:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ad3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ad6:	83 ec 04             	sub    $0x4,%esp
  800ad9:	52                   	push   %edx
  800ada:	ff 75 e4             	pushl  -0x1c(%ebp)
  800add:	50                   	push   %eax
  800ade:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae1:	ff 75 f0             	pushl  -0x10(%ebp)
  800ae4:	ff 75 0c             	pushl  0xc(%ebp)
  800ae7:	ff 75 08             	pushl  0x8(%ebp)
  800aea:	e8 00 fb ff ff       	call   8005ef <printnum>
  800aef:	83 c4 20             	add    $0x20,%esp
			break;
  800af2:	eb 34                	jmp    800b28 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800af4:	83 ec 08             	sub    $0x8,%esp
  800af7:	ff 75 0c             	pushl  0xc(%ebp)
  800afa:	53                   	push   %ebx
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	ff d0                	call   *%eax
  800b00:	83 c4 10             	add    $0x10,%esp
			break;
  800b03:	eb 23                	jmp    800b28 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b05:	83 ec 08             	sub    $0x8,%esp
  800b08:	ff 75 0c             	pushl  0xc(%ebp)
  800b0b:	6a 25                	push   $0x25
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	ff d0                	call   *%eax
  800b12:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b15:	ff 4d 10             	decl   0x10(%ebp)
  800b18:	eb 03                	jmp    800b1d <vprintfmt+0x3b1>
  800b1a:	ff 4d 10             	decl   0x10(%ebp)
  800b1d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b20:	48                   	dec    %eax
  800b21:	8a 00                	mov    (%eax),%al
  800b23:	3c 25                	cmp    $0x25,%al
  800b25:	75 f3                	jne    800b1a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b27:	90                   	nop
		}
	}
  800b28:	e9 47 fc ff ff       	jmp    800774 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b2d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b2e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b31:	5b                   	pop    %ebx
  800b32:	5e                   	pop    %esi
  800b33:	5d                   	pop    %ebp
  800b34:	c3                   	ret    

00800b35 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b35:	55                   	push   %ebp
  800b36:	89 e5                	mov    %esp,%ebp
  800b38:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b3b:	8d 45 10             	lea    0x10(%ebp),%eax
  800b3e:	83 c0 04             	add    $0x4,%eax
  800b41:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b44:	8b 45 10             	mov    0x10(%ebp),%eax
  800b47:	ff 75 f4             	pushl  -0xc(%ebp)
  800b4a:	50                   	push   %eax
  800b4b:	ff 75 0c             	pushl  0xc(%ebp)
  800b4e:	ff 75 08             	pushl  0x8(%ebp)
  800b51:	e8 16 fc ff ff       	call   80076c <vprintfmt>
  800b56:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b59:	90                   	nop
  800b5a:	c9                   	leave  
  800b5b:	c3                   	ret    

00800b5c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b5c:	55                   	push   %ebp
  800b5d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b62:	8b 40 08             	mov    0x8(%eax),%eax
  800b65:	8d 50 01             	lea    0x1(%eax),%edx
  800b68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b71:	8b 10                	mov    (%eax),%edx
  800b73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b76:	8b 40 04             	mov    0x4(%eax),%eax
  800b79:	39 c2                	cmp    %eax,%edx
  800b7b:	73 12                	jae    800b8f <sprintputch+0x33>
		*b->buf++ = ch;
  800b7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b80:	8b 00                	mov    (%eax),%eax
  800b82:	8d 48 01             	lea    0x1(%eax),%ecx
  800b85:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b88:	89 0a                	mov    %ecx,(%edx)
  800b8a:	8b 55 08             	mov    0x8(%ebp),%edx
  800b8d:	88 10                	mov    %dl,(%eax)
}
  800b8f:	90                   	nop
  800b90:	5d                   	pop    %ebp
  800b91:	c3                   	ret    

00800b92 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b92:	55                   	push   %ebp
  800b93:	89 e5                	mov    %esp,%ebp
  800b95:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	01 d0                	add    %edx,%eax
  800ba9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bb3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bb7:	74 06                	je     800bbf <vsnprintf+0x2d>
  800bb9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bbd:	7f 07                	jg     800bc6 <vsnprintf+0x34>
		return -E_INVAL;
  800bbf:	b8 03 00 00 00       	mov    $0x3,%eax
  800bc4:	eb 20                	jmp    800be6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bc6:	ff 75 14             	pushl  0x14(%ebp)
  800bc9:	ff 75 10             	pushl  0x10(%ebp)
  800bcc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bcf:	50                   	push   %eax
  800bd0:	68 5c 0b 80 00       	push   $0x800b5c
  800bd5:	e8 92 fb ff ff       	call   80076c <vprintfmt>
  800bda:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bdd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800be0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800be3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800be6:	c9                   	leave  
  800be7:	c3                   	ret    

00800be8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800be8:	55                   	push   %ebp
  800be9:	89 e5                	mov    %esp,%ebp
  800beb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bee:	8d 45 10             	lea    0x10(%ebp),%eax
  800bf1:	83 c0 04             	add    $0x4,%eax
  800bf4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bf7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfa:	ff 75 f4             	pushl  -0xc(%ebp)
  800bfd:	50                   	push   %eax
  800bfe:	ff 75 0c             	pushl  0xc(%ebp)
  800c01:	ff 75 08             	pushl  0x8(%ebp)
  800c04:	e8 89 ff ff ff       	call   800b92 <vsnprintf>
  800c09:	83 c4 10             	add    $0x10,%esp
  800c0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c12:	c9                   	leave  
  800c13:	c3                   	ret    

00800c14 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c14:	55                   	push   %ebp
  800c15:	89 e5                	mov    %esp,%ebp
  800c17:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c1a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c21:	eb 06                	jmp    800c29 <strlen+0x15>
		n++;
  800c23:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c26:	ff 45 08             	incl   0x8(%ebp)
  800c29:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2c:	8a 00                	mov    (%eax),%al
  800c2e:	84 c0                	test   %al,%al
  800c30:	75 f1                	jne    800c23 <strlen+0xf>
		n++;
	return n;
  800c32:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c35:	c9                   	leave  
  800c36:	c3                   	ret    

00800c37 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c37:	55                   	push   %ebp
  800c38:	89 e5                	mov    %esp,%ebp
  800c3a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c3d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c44:	eb 09                	jmp    800c4f <strnlen+0x18>
		n++;
  800c46:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c49:	ff 45 08             	incl   0x8(%ebp)
  800c4c:	ff 4d 0c             	decl   0xc(%ebp)
  800c4f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c53:	74 09                	je     800c5e <strnlen+0x27>
  800c55:	8b 45 08             	mov    0x8(%ebp),%eax
  800c58:	8a 00                	mov    (%eax),%al
  800c5a:	84 c0                	test   %al,%al
  800c5c:	75 e8                	jne    800c46 <strnlen+0xf>
		n++;
	return n;
  800c5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c61:	c9                   	leave  
  800c62:	c3                   	ret    

00800c63 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c63:	55                   	push   %ebp
  800c64:	89 e5                	mov    %esp,%ebp
  800c66:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c6f:	90                   	nop
  800c70:	8b 45 08             	mov    0x8(%ebp),%eax
  800c73:	8d 50 01             	lea    0x1(%eax),%edx
  800c76:	89 55 08             	mov    %edx,0x8(%ebp)
  800c79:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c7c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c7f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c82:	8a 12                	mov    (%edx),%dl
  800c84:	88 10                	mov    %dl,(%eax)
  800c86:	8a 00                	mov    (%eax),%al
  800c88:	84 c0                	test   %al,%al
  800c8a:	75 e4                	jne    800c70 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c8f:	c9                   	leave  
  800c90:	c3                   	ret    

00800c91 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c91:	55                   	push   %ebp
  800c92:	89 e5                	mov    %esp,%ebp
  800c94:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c9d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ca4:	eb 1f                	jmp    800cc5 <strncpy+0x34>
		*dst++ = *src;
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	8d 50 01             	lea    0x1(%eax),%edx
  800cac:	89 55 08             	mov    %edx,0x8(%ebp)
  800caf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cb2:	8a 12                	mov    (%edx),%dl
  800cb4:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb9:	8a 00                	mov    (%eax),%al
  800cbb:	84 c0                	test   %al,%al
  800cbd:	74 03                	je     800cc2 <strncpy+0x31>
			src++;
  800cbf:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800cc2:	ff 45 fc             	incl   -0x4(%ebp)
  800cc5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cc8:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ccb:	72 d9                	jb     800ca6 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ccd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800cd0:	c9                   	leave  
  800cd1:	c3                   	ret    

00800cd2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800cd2:	55                   	push   %ebp
  800cd3:	89 e5                	mov    %esp,%ebp
  800cd5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cde:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce2:	74 30                	je     800d14 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ce4:	eb 16                	jmp    800cfc <strlcpy+0x2a>
			*dst++ = *src++;
  800ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce9:	8d 50 01             	lea    0x1(%eax),%edx
  800cec:	89 55 08             	mov    %edx,0x8(%ebp)
  800cef:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cf5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cf8:	8a 12                	mov    (%edx),%dl
  800cfa:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800cfc:	ff 4d 10             	decl   0x10(%ebp)
  800cff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d03:	74 09                	je     800d0e <strlcpy+0x3c>
  800d05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d08:	8a 00                	mov    (%eax),%al
  800d0a:	84 c0                	test   %al,%al
  800d0c:	75 d8                	jne    800ce6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d11:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d14:	8b 55 08             	mov    0x8(%ebp),%edx
  800d17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d1a:	29 c2                	sub    %eax,%edx
  800d1c:	89 d0                	mov    %edx,%eax
}
  800d1e:	c9                   	leave  
  800d1f:	c3                   	ret    

00800d20 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d20:	55                   	push   %ebp
  800d21:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d23:	eb 06                	jmp    800d2b <strcmp+0xb>
		p++, q++;
  800d25:	ff 45 08             	incl   0x8(%ebp)
  800d28:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	8a 00                	mov    (%eax),%al
  800d30:	84 c0                	test   %al,%al
  800d32:	74 0e                	je     800d42 <strcmp+0x22>
  800d34:	8b 45 08             	mov    0x8(%ebp),%eax
  800d37:	8a 10                	mov    (%eax),%dl
  800d39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3c:	8a 00                	mov    (%eax),%al
  800d3e:	38 c2                	cmp    %al,%dl
  800d40:	74 e3                	je     800d25 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	8a 00                	mov    (%eax),%al
  800d47:	0f b6 d0             	movzbl %al,%edx
  800d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4d:	8a 00                	mov    (%eax),%al
  800d4f:	0f b6 c0             	movzbl %al,%eax
  800d52:	29 c2                	sub    %eax,%edx
  800d54:	89 d0                	mov    %edx,%eax
}
  800d56:	5d                   	pop    %ebp
  800d57:	c3                   	ret    

00800d58 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d58:	55                   	push   %ebp
  800d59:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d5b:	eb 09                	jmp    800d66 <strncmp+0xe>
		n--, p++, q++;
  800d5d:	ff 4d 10             	decl   0x10(%ebp)
  800d60:	ff 45 08             	incl   0x8(%ebp)
  800d63:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d66:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d6a:	74 17                	je     800d83 <strncmp+0x2b>
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	8a 00                	mov    (%eax),%al
  800d71:	84 c0                	test   %al,%al
  800d73:	74 0e                	je     800d83 <strncmp+0x2b>
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	8a 10                	mov    (%eax),%dl
  800d7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	38 c2                	cmp    %al,%dl
  800d81:	74 da                	je     800d5d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d87:	75 07                	jne    800d90 <strncmp+0x38>
		return 0;
  800d89:	b8 00 00 00 00       	mov    $0x0,%eax
  800d8e:	eb 14                	jmp    800da4 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d90:	8b 45 08             	mov    0x8(%ebp),%eax
  800d93:	8a 00                	mov    (%eax),%al
  800d95:	0f b6 d0             	movzbl %al,%edx
  800d98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9b:	8a 00                	mov    (%eax),%al
  800d9d:	0f b6 c0             	movzbl %al,%eax
  800da0:	29 c2                	sub    %eax,%edx
  800da2:	89 d0                	mov    %edx,%eax
}
  800da4:	5d                   	pop    %ebp
  800da5:	c3                   	ret    

00800da6 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800da6:	55                   	push   %ebp
  800da7:	89 e5                	mov    %esp,%ebp
  800da9:	83 ec 04             	sub    $0x4,%esp
  800dac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800daf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800db2:	eb 12                	jmp    800dc6 <strchr+0x20>
		if (*s == c)
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	8a 00                	mov    (%eax),%al
  800db9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dbc:	75 05                	jne    800dc3 <strchr+0x1d>
			return (char *) s;
  800dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc1:	eb 11                	jmp    800dd4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dc3:	ff 45 08             	incl   0x8(%ebp)
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	8a 00                	mov    (%eax),%al
  800dcb:	84 c0                	test   %al,%al
  800dcd:	75 e5                	jne    800db4 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800dcf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800dd4:	c9                   	leave  
  800dd5:	c3                   	ret    

00800dd6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800dd6:	55                   	push   %ebp
  800dd7:	89 e5                	mov    %esp,%ebp
  800dd9:	83 ec 04             	sub    $0x4,%esp
  800ddc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ddf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800de2:	eb 0d                	jmp    800df1 <strfind+0x1b>
		if (*s == c)
  800de4:	8b 45 08             	mov    0x8(%ebp),%eax
  800de7:	8a 00                	mov    (%eax),%al
  800de9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dec:	74 0e                	je     800dfc <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800dee:	ff 45 08             	incl   0x8(%ebp)
  800df1:	8b 45 08             	mov    0x8(%ebp),%eax
  800df4:	8a 00                	mov    (%eax),%al
  800df6:	84 c0                	test   %al,%al
  800df8:	75 ea                	jne    800de4 <strfind+0xe>
  800dfa:	eb 01                	jmp    800dfd <strfind+0x27>
		if (*s == c)
			break;
  800dfc:	90                   	nop
	return (char *) s;
  800dfd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e00:	c9                   	leave  
  800e01:	c3                   	ret    

00800e02 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e02:	55                   	push   %ebp
  800e03:	89 e5                	mov    %esp,%ebp
  800e05:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e0e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e11:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e14:	eb 0e                	jmp    800e24 <memset+0x22>
		*p++ = c;
  800e16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e19:	8d 50 01             	lea    0x1(%eax),%edx
  800e1c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e22:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e24:	ff 4d f8             	decl   -0x8(%ebp)
  800e27:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e2b:	79 e9                	jns    800e16 <memset+0x14>
		*p++ = c;

	return v;
  800e2d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e30:	c9                   	leave  
  800e31:	c3                   	ret    

00800e32 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e32:	55                   	push   %ebp
  800e33:	89 e5                	mov    %esp,%ebp
  800e35:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e44:	eb 16                	jmp    800e5c <memcpy+0x2a>
		*d++ = *s++;
  800e46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e49:	8d 50 01             	lea    0x1(%eax),%edx
  800e4c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e4f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e52:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e55:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e58:	8a 12                	mov    (%edx),%dl
  800e5a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e62:	89 55 10             	mov    %edx,0x10(%ebp)
  800e65:	85 c0                	test   %eax,%eax
  800e67:	75 dd                	jne    800e46 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e6c:	c9                   	leave  
  800e6d:	c3                   	ret    

00800e6e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e6e:	55                   	push   %ebp
  800e6f:	89 e5                	mov    %esp,%ebp
  800e71:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e77:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e80:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e83:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e86:	73 50                	jae    800ed8 <memmove+0x6a>
  800e88:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8e:	01 d0                	add    %edx,%eax
  800e90:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e93:	76 43                	jbe    800ed8 <memmove+0x6a>
		s += n;
  800e95:	8b 45 10             	mov    0x10(%ebp),%eax
  800e98:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ea1:	eb 10                	jmp    800eb3 <memmove+0x45>
			*--d = *--s;
  800ea3:	ff 4d f8             	decl   -0x8(%ebp)
  800ea6:	ff 4d fc             	decl   -0x4(%ebp)
  800ea9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eac:	8a 10                	mov    (%eax),%dl
  800eae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eb1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800eb3:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eb9:	89 55 10             	mov    %edx,0x10(%ebp)
  800ebc:	85 c0                	test   %eax,%eax
  800ebe:	75 e3                	jne    800ea3 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ec0:	eb 23                	jmp    800ee5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ec2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ec5:	8d 50 01             	lea    0x1(%eax),%edx
  800ec8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ecb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ece:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ed1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ed4:	8a 12                	mov    (%edx),%dl
  800ed6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ed8:	8b 45 10             	mov    0x10(%ebp),%eax
  800edb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ede:	89 55 10             	mov    %edx,0x10(%ebp)
  800ee1:	85 c0                	test   %eax,%eax
  800ee3:	75 dd                	jne    800ec2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee8:	c9                   	leave  
  800ee9:	c3                   	ret    

00800eea <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800eea:	55                   	push   %ebp
  800eeb:	89 e5                	mov    %esp,%ebp
  800eed:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ef6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef9:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800efc:	eb 2a                	jmp    800f28 <memcmp+0x3e>
		if (*s1 != *s2)
  800efe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f01:	8a 10                	mov    (%eax),%dl
  800f03:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f06:	8a 00                	mov    (%eax),%al
  800f08:	38 c2                	cmp    %al,%dl
  800f0a:	74 16                	je     800f22 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f0f:	8a 00                	mov    (%eax),%al
  800f11:	0f b6 d0             	movzbl %al,%edx
  800f14:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f17:	8a 00                	mov    (%eax),%al
  800f19:	0f b6 c0             	movzbl %al,%eax
  800f1c:	29 c2                	sub    %eax,%edx
  800f1e:	89 d0                	mov    %edx,%eax
  800f20:	eb 18                	jmp    800f3a <memcmp+0x50>
		s1++, s2++;
  800f22:	ff 45 fc             	incl   -0x4(%ebp)
  800f25:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f28:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f2e:	89 55 10             	mov    %edx,0x10(%ebp)
  800f31:	85 c0                	test   %eax,%eax
  800f33:	75 c9                	jne    800efe <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f35:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f3a:	c9                   	leave  
  800f3b:	c3                   	ret    

00800f3c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f3c:	55                   	push   %ebp
  800f3d:	89 e5                	mov    %esp,%ebp
  800f3f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f42:	8b 55 08             	mov    0x8(%ebp),%edx
  800f45:	8b 45 10             	mov    0x10(%ebp),%eax
  800f48:	01 d0                	add    %edx,%eax
  800f4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f4d:	eb 15                	jmp    800f64 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	8a 00                	mov    (%eax),%al
  800f54:	0f b6 d0             	movzbl %al,%edx
  800f57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5a:	0f b6 c0             	movzbl %al,%eax
  800f5d:	39 c2                	cmp    %eax,%edx
  800f5f:	74 0d                	je     800f6e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f61:	ff 45 08             	incl   0x8(%ebp)
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f6a:	72 e3                	jb     800f4f <memfind+0x13>
  800f6c:	eb 01                	jmp    800f6f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f6e:	90                   	nop
	return (void *) s;
  800f6f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f72:	c9                   	leave  
  800f73:	c3                   	ret    

00800f74 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f74:	55                   	push   %ebp
  800f75:	89 e5                	mov    %esp,%ebp
  800f77:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f7a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f81:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f88:	eb 03                	jmp    800f8d <strtol+0x19>
		s++;
  800f8a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	3c 20                	cmp    $0x20,%al
  800f94:	74 f4                	je     800f8a <strtol+0x16>
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	3c 09                	cmp    $0x9,%al
  800f9d:	74 eb                	je     800f8a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	8a 00                	mov    (%eax),%al
  800fa4:	3c 2b                	cmp    $0x2b,%al
  800fa6:	75 05                	jne    800fad <strtol+0x39>
		s++;
  800fa8:	ff 45 08             	incl   0x8(%ebp)
  800fab:	eb 13                	jmp    800fc0 <strtol+0x4c>
	else if (*s == '-')
  800fad:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb0:	8a 00                	mov    (%eax),%al
  800fb2:	3c 2d                	cmp    $0x2d,%al
  800fb4:	75 0a                	jne    800fc0 <strtol+0x4c>
		s++, neg = 1;
  800fb6:	ff 45 08             	incl   0x8(%ebp)
  800fb9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fc0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fc4:	74 06                	je     800fcc <strtol+0x58>
  800fc6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fca:	75 20                	jne    800fec <strtol+0x78>
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	3c 30                	cmp    $0x30,%al
  800fd3:	75 17                	jne    800fec <strtol+0x78>
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd8:	40                   	inc    %eax
  800fd9:	8a 00                	mov    (%eax),%al
  800fdb:	3c 78                	cmp    $0x78,%al
  800fdd:	75 0d                	jne    800fec <strtol+0x78>
		s += 2, base = 16;
  800fdf:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fe3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fea:	eb 28                	jmp    801014 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ff0:	75 15                	jne    801007 <strtol+0x93>
  800ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff5:	8a 00                	mov    (%eax),%al
  800ff7:	3c 30                	cmp    $0x30,%al
  800ff9:	75 0c                	jne    801007 <strtol+0x93>
		s++, base = 8;
  800ffb:	ff 45 08             	incl   0x8(%ebp)
  800ffe:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801005:	eb 0d                	jmp    801014 <strtol+0xa0>
	else if (base == 0)
  801007:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80100b:	75 07                	jne    801014 <strtol+0xa0>
		base = 10;
  80100d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801014:	8b 45 08             	mov    0x8(%ebp),%eax
  801017:	8a 00                	mov    (%eax),%al
  801019:	3c 2f                	cmp    $0x2f,%al
  80101b:	7e 19                	jle    801036 <strtol+0xc2>
  80101d:	8b 45 08             	mov    0x8(%ebp),%eax
  801020:	8a 00                	mov    (%eax),%al
  801022:	3c 39                	cmp    $0x39,%al
  801024:	7f 10                	jg     801036 <strtol+0xc2>
			dig = *s - '0';
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	8a 00                	mov    (%eax),%al
  80102b:	0f be c0             	movsbl %al,%eax
  80102e:	83 e8 30             	sub    $0x30,%eax
  801031:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801034:	eb 42                	jmp    801078 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
  801039:	8a 00                	mov    (%eax),%al
  80103b:	3c 60                	cmp    $0x60,%al
  80103d:	7e 19                	jle    801058 <strtol+0xe4>
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	8a 00                	mov    (%eax),%al
  801044:	3c 7a                	cmp    $0x7a,%al
  801046:	7f 10                	jg     801058 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801048:	8b 45 08             	mov    0x8(%ebp),%eax
  80104b:	8a 00                	mov    (%eax),%al
  80104d:	0f be c0             	movsbl %al,%eax
  801050:	83 e8 57             	sub    $0x57,%eax
  801053:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801056:	eb 20                	jmp    801078 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801058:	8b 45 08             	mov    0x8(%ebp),%eax
  80105b:	8a 00                	mov    (%eax),%al
  80105d:	3c 40                	cmp    $0x40,%al
  80105f:	7e 39                	jle    80109a <strtol+0x126>
  801061:	8b 45 08             	mov    0x8(%ebp),%eax
  801064:	8a 00                	mov    (%eax),%al
  801066:	3c 5a                	cmp    $0x5a,%al
  801068:	7f 30                	jg     80109a <strtol+0x126>
			dig = *s - 'A' + 10;
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	0f be c0             	movsbl %al,%eax
  801072:	83 e8 37             	sub    $0x37,%eax
  801075:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801078:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80107b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80107e:	7d 19                	jge    801099 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801080:	ff 45 08             	incl   0x8(%ebp)
  801083:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801086:	0f af 45 10          	imul   0x10(%ebp),%eax
  80108a:	89 c2                	mov    %eax,%edx
  80108c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80108f:	01 d0                	add    %edx,%eax
  801091:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801094:	e9 7b ff ff ff       	jmp    801014 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801099:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80109a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80109e:	74 08                	je     8010a8 <strtol+0x134>
		*endptr = (char *) s;
  8010a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a3:	8b 55 08             	mov    0x8(%ebp),%edx
  8010a6:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010a8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010ac:	74 07                	je     8010b5 <strtol+0x141>
  8010ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b1:	f7 d8                	neg    %eax
  8010b3:	eb 03                	jmp    8010b8 <strtol+0x144>
  8010b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010b8:	c9                   	leave  
  8010b9:	c3                   	ret    

008010ba <ltostr>:

void
ltostr(long value, char *str)
{
  8010ba:	55                   	push   %ebp
  8010bb:	89 e5                	mov    %esp,%ebp
  8010bd:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010c7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010ce:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010d2:	79 13                	jns    8010e7 <ltostr+0x2d>
	{
		neg = 1;
  8010d4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010de:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010e1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010e4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ea:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010ef:	99                   	cltd   
  8010f0:	f7 f9                	idiv   %ecx
  8010f2:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f8:	8d 50 01             	lea    0x1(%eax),%edx
  8010fb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010fe:	89 c2                	mov    %eax,%edx
  801100:	8b 45 0c             	mov    0xc(%ebp),%eax
  801103:	01 d0                	add    %edx,%eax
  801105:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801108:	83 c2 30             	add    $0x30,%edx
  80110b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80110d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801110:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801115:	f7 e9                	imul   %ecx
  801117:	c1 fa 02             	sar    $0x2,%edx
  80111a:	89 c8                	mov    %ecx,%eax
  80111c:	c1 f8 1f             	sar    $0x1f,%eax
  80111f:	29 c2                	sub    %eax,%edx
  801121:	89 d0                	mov    %edx,%eax
  801123:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801126:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801129:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80112e:	f7 e9                	imul   %ecx
  801130:	c1 fa 02             	sar    $0x2,%edx
  801133:	89 c8                	mov    %ecx,%eax
  801135:	c1 f8 1f             	sar    $0x1f,%eax
  801138:	29 c2                	sub    %eax,%edx
  80113a:	89 d0                	mov    %edx,%eax
  80113c:	c1 e0 02             	shl    $0x2,%eax
  80113f:	01 d0                	add    %edx,%eax
  801141:	01 c0                	add    %eax,%eax
  801143:	29 c1                	sub    %eax,%ecx
  801145:	89 ca                	mov    %ecx,%edx
  801147:	85 d2                	test   %edx,%edx
  801149:	75 9c                	jne    8010e7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80114b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801152:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801155:	48                   	dec    %eax
  801156:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801159:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80115d:	74 3d                	je     80119c <ltostr+0xe2>
		start = 1 ;
  80115f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801166:	eb 34                	jmp    80119c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801168:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80116b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116e:	01 d0                	add    %edx,%eax
  801170:	8a 00                	mov    (%eax),%al
  801172:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801175:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801178:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117b:	01 c2                	add    %eax,%edx
  80117d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801180:	8b 45 0c             	mov    0xc(%ebp),%eax
  801183:	01 c8                	add    %ecx,%eax
  801185:	8a 00                	mov    (%eax),%al
  801187:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801189:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80118c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118f:	01 c2                	add    %eax,%edx
  801191:	8a 45 eb             	mov    -0x15(%ebp),%al
  801194:	88 02                	mov    %al,(%edx)
		start++ ;
  801196:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801199:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80119c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80119f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011a2:	7c c4                	jl     801168 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011a4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011aa:	01 d0                	add    %edx,%eax
  8011ac:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011af:	90                   	nop
  8011b0:	c9                   	leave  
  8011b1:	c3                   	ret    

008011b2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011b2:	55                   	push   %ebp
  8011b3:	89 e5                	mov    %esp,%ebp
  8011b5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011b8:	ff 75 08             	pushl  0x8(%ebp)
  8011bb:	e8 54 fa ff ff       	call   800c14 <strlen>
  8011c0:	83 c4 04             	add    $0x4,%esp
  8011c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011c6:	ff 75 0c             	pushl  0xc(%ebp)
  8011c9:	e8 46 fa ff ff       	call   800c14 <strlen>
  8011ce:	83 c4 04             	add    $0x4,%esp
  8011d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011d4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011e2:	eb 17                	jmp    8011fb <strcconcat+0x49>
		final[s] = str1[s] ;
  8011e4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ea:	01 c2                	add    %eax,%edx
  8011ec:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	01 c8                	add    %ecx,%eax
  8011f4:	8a 00                	mov    (%eax),%al
  8011f6:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011f8:	ff 45 fc             	incl   -0x4(%ebp)
  8011fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011fe:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801201:	7c e1                	jl     8011e4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801203:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80120a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801211:	eb 1f                	jmp    801232 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801213:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801216:	8d 50 01             	lea    0x1(%eax),%edx
  801219:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80121c:	89 c2                	mov    %eax,%edx
  80121e:	8b 45 10             	mov    0x10(%ebp),%eax
  801221:	01 c2                	add    %eax,%edx
  801223:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801226:	8b 45 0c             	mov    0xc(%ebp),%eax
  801229:	01 c8                	add    %ecx,%eax
  80122b:	8a 00                	mov    (%eax),%al
  80122d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80122f:	ff 45 f8             	incl   -0x8(%ebp)
  801232:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801235:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801238:	7c d9                	jl     801213 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80123a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80123d:	8b 45 10             	mov    0x10(%ebp),%eax
  801240:	01 d0                	add    %edx,%eax
  801242:	c6 00 00             	movb   $0x0,(%eax)
}
  801245:	90                   	nop
  801246:	c9                   	leave  
  801247:	c3                   	ret    

00801248 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801248:	55                   	push   %ebp
  801249:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80124b:	8b 45 14             	mov    0x14(%ebp),%eax
  80124e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801254:	8b 45 14             	mov    0x14(%ebp),%eax
  801257:	8b 00                	mov    (%eax),%eax
  801259:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801260:	8b 45 10             	mov    0x10(%ebp),%eax
  801263:	01 d0                	add    %edx,%eax
  801265:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80126b:	eb 0c                	jmp    801279 <strsplit+0x31>
			*string++ = 0;
  80126d:	8b 45 08             	mov    0x8(%ebp),%eax
  801270:	8d 50 01             	lea    0x1(%eax),%edx
  801273:	89 55 08             	mov    %edx,0x8(%ebp)
  801276:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801279:	8b 45 08             	mov    0x8(%ebp),%eax
  80127c:	8a 00                	mov    (%eax),%al
  80127e:	84 c0                	test   %al,%al
  801280:	74 18                	je     80129a <strsplit+0x52>
  801282:	8b 45 08             	mov    0x8(%ebp),%eax
  801285:	8a 00                	mov    (%eax),%al
  801287:	0f be c0             	movsbl %al,%eax
  80128a:	50                   	push   %eax
  80128b:	ff 75 0c             	pushl  0xc(%ebp)
  80128e:	e8 13 fb ff ff       	call   800da6 <strchr>
  801293:	83 c4 08             	add    $0x8,%esp
  801296:	85 c0                	test   %eax,%eax
  801298:	75 d3                	jne    80126d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80129a:	8b 45 08             	mov    0x8(%ebp),%eax
  80129d:	8a 00                	mov    (%eax),%al
  80129f:	84 c0                	test   %al,%al
  8012a1:	74 5a                	je     8012fd <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8012a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a6:	8b 00                	mov    (%eax),%eax
  8012a8:	83 f8 0f             	cmp    $0xf,%eax
  8012ab:	75 07                	jne    8012b4 <strsplit+0x6c>
		{
			return 0;
  8012ad:	b8 00 00 00 00       	mov    $0x0,%eax
  8012b2:	eb 66                	jmp    80131a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b7:	8b 00                	mov    (%eax),%eax
  8012b9:	8d 48 01             	lea    0x1(%eax),%ecx
  8012bc:	8b 55 14             	mov    0x14(%ebp),%edx
  8012bf:	89 0a                	mov    %ecx,(%edx)
  8012c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cb:	01 c2                	add    %eax,%edx
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012d2:	eb 03                	jmp    8012d7 <strsplit+0x8f>
			string++;
  8012d4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012da:	8a 00                	mov    (%eax),%al
  8012dc:	84 c0                	test   %al,%al
  8012de:	74 8b                	je     80126b <strsplit+0x23>
  8012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e3:	8a 00                	mov    (%eax),%al
  8012e5:	0f be c0             	movsbl %al,%eax
  8012e8:	50                   	push   %eax
  8012e9:	ff 75 0c             	pushl  0xc(%ebp)
  8012ec:	e8 b5 fa ff ff       	call   800da6 <strchr>
  8012f1:	83 c4 08             	add    $0x8,%esp
  8012f4:	85 c0                	test   %eax,%eax
  8012f6:	74 dc                	je     8012d4 <strsplit+0x8c>
			string++;
	}
  8012f8:	e9 6e ff ff ff       	jmp    80126b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012fd:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012fe:	8b 45 14             	mov    0x14(%ebp),%eax
  801301:	8b 00                	mov    (%eax),%eax
  801303:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80130a:	8b 45 10             	mov    0x10(%ebp),%eax
  80130d:	01 d0                	add    %edx,%eax
  80130f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801315:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80131a:	c9                   	leave  
  80131b:	c3                   	ret    

0080131c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80131c:	55                   	push   %ebp
  80131d:	89 e5                	mov    %esp,%ebp
  80131f:	57                   	push   %edi
  801320:	56                   	push   %esi
  801321:	53                   	push   %ebx
  801322:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801325:	8b 45 08             	mov    0x8(%ebp),%eax
  801328:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80132e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801331:	8b 7d 18             	mov    0x18(%ebp),%edi
  801334:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801337:	cd 30                	int    $0x30
  801339:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80133c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80133f:	83 c4 10             	add    $0x10,%esp
  801342:	5b                   	pop    %ebx
  801343:	5e                   	pop    %esi
  801344:	5f                   	pop    %edi
  801345:	5d                   	pop    %ebp
  801346:	c3                   	ret    

00801347 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801347:	55                   	push   %ebp
  801348:	89 e5                	mov    %esp,%ebp
  80134a:	83 ec 04             	sub    $0x4,%esp
  80134d:	8b 45 10             	mov    0x10(%ebp),%eax
  801350:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801353:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	52                   	push   %edx
  80135f:	ff 75 0c             	pushl  0xc(%ebp)
  801362:	50                   	push   %eax
  801363:	6a 00                	push   $0x0
  801365:	e8 b2 ff ff ff       	call   80131c <syscall>
  80136a:	83 c4 18             	add    $0x18,%esp
}
  80136d:	90                   	nop
  80136e:	c9                   	leave  
  80136f:	c3                   	ret    

00801370 <sys_cgetc>:

int
sys_cgetc(void)
{
  801370:	55                   	push   %ebp
  801371:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801373:	6a 00                	push   $0x0
  801375:	6a 00                	push   $0x0
  801377:	6a 00                	push   $0x0
  801379:	6a 00                	push   $0x0
  80137b:	6a 00                	push   $0x0
  80137d:	6a 01                	push   $0x1
  80137f:	e8 98 ff ff ff       	call   80131c <syscall>
  801384:	83 c4 18             	add    $0x18,%esp
}
  801387:	c9                   	leave  
  801388:	c3                   	ret    

00801389 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801389:	55                   	push   %ebp
  80138a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80138c:	8b 45 08             	mov    0x8(%ebp),%eax
  80138f:	6a 00                	push   $0x0
  801391:	6a 00                	push   $0x0
  801393:	6a 00                	push   $0x0
  801395:	6a 00                	push   $0x0
  801397:	50                   	push   %eax
  801398:	6a 05                	push   $0x5
  80139a:	e8 7d ff ff ff       	call   80131c <syscall>
  80139f:	83 c4 18             	add    $0x18,%esp
}
  8013a2:	c9                   	leave  
  8013a3:	c3                   	ret    

008013a4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013a4:	55                   	push   %ebp
  8013a5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013a7:	6a 00                	push   $0x0
  8013a9:	6a 00                	push   $0x0
  8013ab:	6a 00                	push   $0x0
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 02                	push   $0x2
  8013b3:	e8 64 ff ff ff       	call   80131c <syscall>
  8013b8:	83 c4 18             	add    $0x18,%esp
}
  8013bb:	c9                   	leave  
  8013bc:	c3                   	ret    

008013bd <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013bd:	55                   	push   %ebp
  8013be:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	6a 00                	push   $0x0
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 03                	push   $0x3
  8013cc:	e8 4b ff ff ff       	call   80131c <syscall>
  8013d1:	83 c4 18             	add    $0x18,%esp
}
  8013d4:	c9                   	leave  
  8013d5:	c3                   	ret    

008013d6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013d6:	55                   	push   %ebp
  8013d7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 04                	push   $0x4
  8013e5:	e8 32 ff ff ff       	call   80131c <syscall>
  8013ea:	83 c4 18             	add    $0x18,%esp
}
  8013ed:	c9                   	leave  
  8013ee:	c3                   	ret    

008013ef <sys_env_exit>:


void sys_env_exit(void)
{
  8013ef:	55                   	push   %ebp
  8013f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 00                	push   $0x0
  8013fa:	6a 00                	push   $0x0
  8013fc:	6a 06                	push   $0x6
  8013fe:	e8 19 ff ff ff       	call   80131c <syscall>
  801403:	83 c4 18             	add    $0x18,%esp
}
  801406:	90                   	nop
  801407:	c9                   	leave  
  801408:	c3                   	ret    

00801409 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801409:	55                   	push   %ebp
  80140a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80140c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	52                   	push   %edx
  801419:	50                   	push   %eax
  80141a:	6a 07                	push   $0x7
  80141c:	e8 fb fe ff ff       	call   80131c <syscall>
  801421:	83 c4 18             	add    $0x18,%esp
}
  801424:	c9                   	leave  
  801425:	c3                   	ret    

00801426 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801426:	55                   	push   %ebp
  801427:	89 e5                	mov    %esp,%ebp
  801429:	56                   	push   %esi
  80142a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80142b:	8b 75 18             	mov    0x18(%ebp),%esi
  80142e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801431:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801434:	8b 55 0c             	mov    0xc(%ebp),%edx
  801437:	8b 45 08             	mov    0x8(%ebp),%eax
  80143a:	56                   	push   %esi
  80143b:	53                   	push   %ebx
  80143c:	51                   	push   %ecx
  80143d:	52                   	push   %edx
  80143e:	50                   	push   %eax
  80143f:	6a 08                	push   $0x8
  801441:	e8 d6 fe ff ff       	call   80131c <syscall>
  801446:	83 c4 18             	add    $0x18,%esp
}
  801449:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80144c:	5b                   	pop    %ebx
  80144d:	5e                   	pop    %esi
  80144e:	5d                   	pop    %ebp
  80144f:	c3                   	ret    

00801450 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801450:	55                   	push   %ebp
  801451:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801453:	8b 55 0c             	mov    0xc(%ebp),%edx
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	52                   	push   %edx
  801460:	50                   	push   %eax
  801461:	6a 09                	push   $0x9
  801463:	e8 b4 fe ff ff       	call   80131c <syscall>
  801468:	83 c4 18             	add    $0x18,%esp
}
  80146b:	c9                   	leave  
  80146c:	c3                   	ret    

0080146d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80146d:	55                   	push   %ebp
  80146e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801470:	6a 00                	push   $0x0
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	ff 75 0c             	pushl  0xc(%ebp)
  801479:	ff 75 08             	pushl  0x8(%ebp)
  80147c:	6a 0a                	push   $0xa
  80147e:	e8 99 fe ff ff       	call   80131c <syscall>
  801483:	83 c4 18             	add    $0x18,%esp
}
  801486:	c9                   	leave  
  801487:	c3                   	ret    

00801488 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801488:	55                   	push   %ebp
  801489:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 0b                	push   $0xb
  801497:	e8 80 fe ff ff       	call   80131c <syscall>
  80149c:	83 c4 18             	add    $0x18,%esp
}
  80149f:	c9                   	leave  
  8014a0:	c3                   	ret    

008014a1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014a1:	55                   	push   %ebp
  8014a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 0c                	push   $0xc
  8014b0:	e8 67 fe ff ff       	call   80131c <syscall>
  8014b5:	83 c4 18             	add    $0x18,%esp
}
  8014b8:	c9                   	leave  
  8014b9:	c3                   	ret    

008014ba <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014ba:	55                   	push   %ebp
  8014bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 0d                	push   $0xd
  8014c9:	e8 4e fe ff ff       	call   80131c <syscall>
  8014ce:	83 c4 18             	add    $0x18,%esp
}
  8014d1:	c9                   	leave  
  8014d2:	c3                   	ret    

008014d3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014d3:	55                   	push   %ebp
  8014d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	ff 75 0c             	pushl  0xc(%ebp)
  8014df:	ff 75 08             	pushl  0x8(%ebp)
  8014e2:	6a 11                	push   $0x11
  8014e4:	e8 33 fe ff ff       	call   80131c <syscall>
  8014e9:	83 c4 18             	add    $0x18,%esp
	return;
  8014ec:	90                   	nop
}
  8014ed:	c9                   	leave  
  8014ee:	c3                   	ret    

008014ef <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8014ef:	55                   	push   %ebp
  8014f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	ff 75 0c             	pushl  0xc(%ebp)
  8014fb:	ff 75 08             	pushl  0x8(%ebp)
  8014fe:	6a 12                	push   $0x12
  801500:	e8 17 fe ff ff       	call   80131c <syscall>
  801505:	83 c4 18             	add    $0x18,%esp
	return ;
  801508:	90                   	nop
}
  801509:	c9                   	leave  
  80150a:	c3                   	ret    

0080150b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80150b:	55                   	push   %ebp
  80150c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 0e                	push   $0xe
  80151a:	e8 fd fd ff ff       	call   80131c <syscall>
  80151f:	83 c4 18             	add    $0x18,%esp
}
  801522:	c9                   	leave  
  801523:	c3                   	ret    

00801524 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801524:	55                   	push   %ebp
  801525:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	ff 75 08             	pushl  0x8(%ebp)
  801532:	6a 0f                	push   $0xf
  801534:	e8 e3 fd ff ff       	call   80131c <syscall>
  801539:	83 c4 18             	add    $0x18,%esp
}
  80153c:	c9                   	leave  
  80153d:	c3                   	ret    

0080153e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80153e:	55                   	push   %ebp
  80153f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 10                	push   $0x10
  80154d:	e8 ca fd ff ff       	call   80131c <syscall>
  801552:	83 c4 18             	add    $0x18,%esp
}
  801555:	90                   	nop
  801556:	c9                   	leave  
  801557:	c3                   	ret    

00801558 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801558:	55                   	push   %ebp
  801559:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 14                	push   $0x14
  801567:	e8 b0 fd ff ff       	call   80131c <syscall>
  80156c:	83 c4 18             	add    $0x18,%esp
}
  80156f:	90                   	nop
  801570:	c9                   	leave  
  801571:	c3                   	ret    

00801572 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801572:	55                   	push   %ebp
  801573:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 15                	push   $0x15
  801581:	e8 96 fd ff ff       	call   80131c <syscall>
  801586:	83 c4 18             	add    $0x18,%esp
}
  801589:	90                   	nop
  80158a:	c9                   	leave  
  80158b:	c3                   	ret    

0080158c <sys_cputc>:


void
sys_cputc(const char c)
{
  80158c:	55                   	push   %ebp
  80158d:	89 e5                	mov    %esp,%ebp
  80158f:	83 ec 04             	sub    $0x4,%esp
  801592:	8b 45 08             	mov    0x8(%ebp),%eax
  801595:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801598:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	50                   	push   %eax
  8015a5:	6a 16                	push   $0x16
  8015a7:	e8 70 fd ff ff       	call   80131c <syscall>
  8015ac:	83 c4 18             	add    $0x18,%esp
}
  8015af:	90                   	nop
  8015b0:	c9                   	leave  
  8015b1:	c3                   	ret    

008015b2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015b2:	55                   	push   %ebp
  8015b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 17                	push   $0x17
  8015c1:	e8 56 fd ff ff       	call   80131c <syscall>
  8015c6:	83 c4 18             	add    $0x18,%esp
}
  8015c9:	90                   	nop
  8015ca:	c9                   	leave  
  8015cb:	c3                   	ret    

008015cc <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	ff 75 0c             	pushl  0xc(%ebp)
  8015db:	50                   	push   %eax
  8015dc:	6a 18                	push   $0x18
  8015de:	e8 39 fd ff ff       	call   80131c <syscall>
  8015e3:	83 c4 18             	add    $0x18,%esp
}
  8015e6:	c9                   	leave  
  8015e7:	c3                   	ret    

008015e8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	52                   	push   %edx
  8015f8:	50                   	push   %eax
  8015f9:	6a 1b                	push   $0x1b
  8015fb:	e8 1c fd ff ff       	call   80131c <syscall>
  801600:	83 c4 18             	add    $0x18,%esp
}
  801603:	c9                   	leave  
  801604:	c3                   	ret    

00801605 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801605:	55                   	push   %ebp
  801606:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801608:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160b:	8b 45 08             	mov    0x8(%ebp),%eax
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	52                   	push   %edx
  801615:	50                   	push   %eax
  801616:	6a 19                	push   $0x19
  801618:	e8 ff fc ff ff       	call   80131c <syscall>
  80161d:	83 c4 18             	add    $0x18,%esp
}
  801620:	90                   	nop
  801621:	c9                   	leave  
  801622:	c3                   	ret    

00801623 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801623:	55                   	push   %ebp
  801624:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801626:	8b 55 0c             	mov    0xc(%ebp),%edx
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	52                   	push   %edx
  801633:	50                   	push   %eax
  801634:	6a 1a                	push   $0x1a
  801636:	e8 e1 fc ff ff       	call   80131c <syscall>
  80163b:	83 c4 18             	add    $0x18,%esp
}
  80163e:	90                   	nop
  80163f:	c9                   	leave  
  801640:	c3                   	ret    

00801641 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801641:	55                   	push   %ebp
  801642:	89 e5                	mov    %esp,%ebp
  801644:	83 ec 04             	sub    $0x4,%esp
  801647:	8b 45 10             	mov    0x10(%ebp),%eax
  80164a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80164d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801650:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	6a 00                	push   $0x0
  801659:	51                   	push   %ecx
  80165a:	52                   	push   %edx
  80165b:	ff 75 0c             	pushl  0xc(%ebp)
  80165e:	50                   	push   %eax
  80165f:	6a 1c                	push   $0x1c
  801661:	e8 b6 fc ff ff       	call   80131c <syscall>
  801666:	83 c4 18             	add    $0x18,%esp
}
  801669:	c9                   	leave  
  80166a:	c3                   	ret    

0080166b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80166b:	55                   	push   %ebp
  80166c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80166e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	52                   	push   %edx
  80167b:	50                   	push   %eax
  80167c:	6a 1d                	push   $0x1d
  80167e:	e8 99 fc ff ff       	call   80131c <syscall>
  801683:	83 c4 18             	add    $0x18,%esp
}
  801686:	c9                   	leave  
  801687:	c3                   	ret    

00801688 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801688:	55                   	push   %ebp
  801689:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80168b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80168e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801691:	8b 45 08             	mov    0x8(%ebp),%eax
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	51                   	push   %ecx
  801699:	52                   	push   %edx
  80169a:	50                   	push   %eax
  80169b:	6a 1e                	push   $0x1e
  80169d:	e8 7a fc ff ff       	call   80131c <syscall>
  8016a2:	83 c4 18             	add    $0x18,%esp
}
  8016a5:	c9                   	leave  
  8016a6:	c3                   	ret    

008016a7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016a7:	55                   	push   %ebp
  8016a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	52                   	push   %edx
  8016b7:	50                   	push   %eax
  8016b8:	6a 1f                	push   $0x1f
  8016ba:	e8 5d fc ff ff       	call   80131c <syscall>
  8016bf:	83 c4 18             	add    $0x18,%esp
}
  8016c2:	c9                   	leave  
  8016c3:	c3                   	ret    

008016c4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016c4:	55                   	push   %ebp
  8016c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	6a 00                	push   $0x0
  8016d1:	6a 20                	push   $0x20
  8016d3:	e8 44 fc ff ff       	call   80131c <syscall>
  8016d8:	83 c4 18             	add    $0x18,%esp
}
  8016db:	c9                   	leave  
  8016dc:	c3                   	ret    

008016dd <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8016dd:	55                   	push   %ebp
  8016de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8016e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e3:	6a 00                	push   $0x0
  8016e5:	ff 75 14             	pushl  0x14(%ebp)
  8016e8:	ff 75 10             	pushl  0x10(%ebp)
  8016eb:	ff 75 0c             	pushl  0xc(%ebp)
  8016ee:	50                   	push   %eax
  8016ef:	6a 21                	push   $0x21
  8016f1:	e8 26 fc ff ff       	call   80131c <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
}
  8016f9:	c9                   	leave  
  8016fa:	c3                   	ret    

008016fb <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8016fb:	55                   	push   %ebp
  8016fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	50                   	push   %eax
  80170a:	6a 22                	push   $0x22
  80170c:	e8 0b fc ff ff       	call   80131c <syscall>
  801711:	83 c4 18             	add    $0x18,%esp
}
  801714:	90                   	nop
  801715:	c9                   	leave  
  801716:	c3                   	ret    

00801717 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801717:	55                   	push   %ebp
  801718:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80171a:	8b 45 08             	mov    0x8(%ebp),%eax
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	50                   	push   %eax
  801726:	6a 23                	push   $0x23
  801728:	e8 ef fb ff ff       	call   80131c <syscall>
  80172d:	83 c4 18             	add    $0x18,%esp
}
  801730:	90                   	nop
  801731:	c9                   	leave  
  801732:	c3                   	ret    

00801733 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801733:	55                   	push   %ebp
  801734:	89 e5                	mov    %esp,%ebp
  801736:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801739:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80173c:	8d 50 04             	lea    0x4(%eax),%edx
  80173f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	52                   	push   %edx
  801749:	50                   	push   %eax
  80174a:	6a 24                	push   $0x24
  80174c:	e8 cb fb ff ff       	call   80131c <syscall>
  801751:	83 c4 18             	add    $0x18,%esp
	return result;
  801754:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801757:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80175a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80175d:	89 01                	mov    %eax,(%ecx)
  80175f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801762:	8b 45 08             	mov    0x8(%ebp),%eax
  801765:	c9                   	leave  
  801766:	c2 04 00             	ret    $0x4

00801769 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801769:	55                   	push   %ebp
  80176a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	ff 75 10             	pushl  0x10(%ebp)
  801773:	ff 75 0c             	pushl  0xc(%ebp)
  801776:	ff 75 08             	pushl  0x8(%ebp)
  801779:	6a 13                	push   $0x13
  80177b:	e8 9c fb ff ff       	call   80131c <syscall>
  801780:	83 c4 18             	add    $0x18,%esp
	return ;
  801783:	90                   	nop
}
  801784:	c9                   	leave  
  801785:	c3                   	ret    

00801786 <sys_rcr2>:
uint32 sys_rcr2()
{
  801786:	55                   	push   %ebp
  801787:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 25                	push   $0x25
  801795:	e8 82 fb ff ff       	call   80131c <syscall>
  80179a:	83 c4 18             	add    $0x18,%esp
}
  80179d:	c9                   	leave  
  80179e:	c3                   	ret    

0080179f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80179f:	55                   	push   %ebp
  8017a0:	89 e5                	mov    %esp,%ebp
  8017a2:	83 ec 04             	sub    $0x4,%esp
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017ab:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	50                   	push   %eax
  8017b8:	6a 26                	push   $0x26
  8017ba:	e8 5d fb ff ff       	call   80131c <syscall>
  8017bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c2:	90                   	nop
}
  8017c3:	c9                   	leave  
  8017c4:	c3                   	ret    

008017c5 <rsttst>:
void rsttst()
{
  8017c5:	55                   	push   %ebp
  8017c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 28                	push   $0x28
  8017d4:	e8 43 fb ff ff       	call   80131c <syscall>
  8017d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8017dc:	90                   	nop
}
  8017dd:	c9                   	leave  
  8017de:	c3                   	ret    

008017df <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8017df:	55                   	push   %ebp
  8017e0:	89 e5                	mov    %esp,%ebp
  8017e2:	83 ec 04             	sub    $0x4,%esp
  8017e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8017e8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8017eb:	8b 55 18             	mov    0x18(%ebp),%edx
  8017ee:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017f2:	52                   	push   %edx
  8017f3:	50                   	push   %eax
  8017f4:	ff 75 10             	pushl  0x10(%ebp)
  8017f7:	ff 75 0c             	pushl  0xc(%ebp)
  8017fa:	ff 75 08             	pushl  0x8(%ebp)
  8017fd:	6a 27                	push   $0x27
  8017ff:	e8 18 fb ff ff       	call   80131c <syscall>
  801804:	83 c4 18             	add    $0x18,%esp
	return ;
  801807:	90                   	nop
}
  801808:	c9                   	leave  
  801809:	c3                   	ret    

0080180a <chktst>:
void chktst(uint32 n)
{
  80180a:	55                   	push   %ebp
  80180b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	ff 75 08             	pushl  0x8(%ebp)
  801818:	6a 29                	push   $0x29
  80181a:	e8 fd fa ff ff       	call   80131c <syscall>
  80181f:	83 c4 18             	add    $0x18,%esp
	return ;
  801822:	90                   	nop
}
  801823:	c9                   	leave  
  801824:	c3                   	ret    

00801825 <inctst>:

void inctst()
{
  801825:	55                   	push   %ebp
  801826:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 2a                	push   $0x2a
  801834:	e8 e3 fa ff ff       	call   80131c <syscall>
  801839:	83 c4 18             	add    $0x18,%esp
	return ;
  80183c:	90                   	nop
}
  80183d:	c9                   	leave  
  80183e:	c3                   	ret    

0080183f <gettst>:
uint32 gettst()
{
  80183f:	55                   	push   %ebp
  801840:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 2b                	push   $0x2b
  80184e:	e8 c9 fa ff ff       	call   80131c <syscall>
  801853:	83 c4 18             	add    $0x18,%esp
}
  801856:	c9                   	leave  
  801857:	c3                   	ret    

00801858 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801858:	55                   	push   %ebp
  801859:	89 e5                	mov    %esp,%ebp
  80185b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	6a 2c                	push   $0x2c
  80186a:	e8 ad fa ff ff       	call   80131c <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
  801872:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801875:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801879:	75 07                	jne    801882 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80187b:	b8 01 00 00 00       	mov    $0x1,%eax
  801880:	eb 05                	jmp    801887 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801882:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801887:	c9                   	leave  
  801888:	c3                   	ret    

00801889 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801889:	55                   	push   %ebp
  80188a:	89 e5                	mov    %esp,%ebp
  80188c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 2c                	push   $0x2c
  80189b:	e8 7c fa ff ff       	call   80131c <syscall>
  8018a0:	83 c4 18             	add    $0x18,%esp
  8018a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018a6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018aa:	75 07                	jne    8018b3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018ac:	b8 01 00 00 00       	mov    $0x1,%eax
  8018b1:	eb 05                	jmp    8018b8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018b8:	c9                   	leave  
  8018b9:	c3                   	ret    

008018ba <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018ba:	55                   	push   %ebp
  8018bb:	89 e5                	mov    %esp,%ebp
  8018bd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 2c                	push   $0x2c
  8018cc:	e8 4b fa ff ff       	call   80131c <syscall>
  8018d1:	83 c4 18             	add    $0x18,%esp
  8018d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018d7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8018db:	75 07                	jne    8018e4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8018dd:	b8 01 00 00 00       	mov    $0x1,%eax
  8018e2:	eb 05                	jmp    8018e9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8018e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018e9:	c9                   	leave  
  8018ea:	c3                   	ret    

008018eb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8018eb:	55                   	push   %ebp
  8018ec:	89 e5                	mov    %esp,%ebp
  8018ee:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 2c                	push   $0x2c
  8018fd:	e8 1a fa ff ff       	call   80131c <syscall>
  801902:	83 c4 18             	add    $0x18,%esp
  801905:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801908:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80190c:	75 07                	jne    801915 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80190e:	b8 01 00 00 00       	mov    $0x1,%eax
  801913:	eb 05                	jmp    80191a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801915:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80191a:	c9                   	leave  
  80191b:	c3                   	ret    

0080191c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80191c:	55                   	push   %ebp
  80191d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	ff 75 08             	pushl  0x8(%ebp)
  80192a:	6a 2d                	push   $0x2d
  80192c:	e8 eb f9 ff ff       	call   80131c <syscall>
  801931:	83 c4 18             	add    $0x18,%esp
	return ;
  801934:	90                   	nop
}
  801935:	c9                   	leave  
  801936:	c3                   	ret    

00801937 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801937:	55                   	push   %ebp
  801938:	89 e5                	mov    %esp,%ebp
  80193a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80193b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80193e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801941:	8b 55 0c             	mov    0xc(%ebp),%edx
  801944:	8b 45 08             	mov    0x8(%ebp),%eax
  801947:	6a 00                	push   $0x0
  801949:	53                   	push   %ebx
  80194a:	51                   	push   %ecx
  80194b:	52                   	push   %edx
  80194c:	50                   	push   %eax
  80194d:	6a 2e                	push   $0x2e
  80194f:	e8 c8 f9 ff ff       	call   80131c <syscall>
  801954:	83 c4 18             	add    $0x18,%esp
}
  801957:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80195a:	c9                   	leave  
  80195b:	c3                   	ret    

0080195c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80195c:	55                   	push   %ebp
  80195d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80195f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801962:	8b 45 08             	mov    0x8(%ebp),%eax
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	52                   	push   %edx
  80196c:	50                   	push   %eax
  80196d:	6a 2f                	push   $0x2f
  80196f:	e8 a8 f9 ff ff       	call   80131c <syscall>
  801974:	83 c4 18             	add    $0x18,%esp
}
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	ff 75 0c             	pushl  0xc(%ebp)
  801985:	ff 75 08             	pushl  0x8(%ebp)
  801988:	6a 30                	push   $0x30
  80198a:	e8 8d f9 ff ff       	call   80131c <syscall>
  80198f:	83 c4 18             	add    $0x18,%esp
	return ;
  801992:	90                   	nop
}
  801993:	c9                   	leave  
  801994:	c3                   	ret    

00801995 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
  801998:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80199b:	8b 55 08             	mov    0x8(%ebp),%edx
  80199e:	89 d0                	mov    %edx,%eax
  8019a0:	c1 e0 02             	shl    $0x2,%eax
  8019a3:	01 d0                	add    %edx,%eax
  8019a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019ac:	01 d0                	add    %edx,%eax
  8019ae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019b5:	01 d0                	add    %edx,%eax
  8019b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019be:	01 d0                	add    %edx,%eax
  8019c0:	c1 e0 04             	shl    $0x4,%eax
  8019c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8019c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8019cd:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8019d0:	83 ec 0c             	sub    $0xc,%esp
  8019d3:	50                   	push   %eax
  8019d4:	e8 5a fd ff ff       	call   801733 <sys_get_virtual_time>
  8019d9:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8019dc:	eb 41                	jmp    801a1f <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8019de:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8019e1:	83 ec 0c             	sub    $0xc,%esp
  8019e4:	50                   	push   %eax
  8019e5:	e8 49 fd ff ff       	call   801733 <sys_get_virtual_time>
  8019ea:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8019ed:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019f0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019f3:	29 c2                	sub    %eax,%edx
  8019f5:	89 d0                	mov    %edx,%eax
  8019f7:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8019fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8019fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a00:	89 d1                	mov    %edx,%ecx
  801a02:	29 c1                	sub    %eax,%ecx
  801a04:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a07:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a0a:	39 c2                	cmp    %eax,%edx
  801a0c:	0f 97 c0             	seta   %al
  801a0f:	0f b6 c0             	movzbl %al,%eax
  801a12:	29 c1                	sub    %eax,%ecx
  801a14:	89 c8                	mov    %ecx,%eax
  801a16:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801a19:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a22:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a25:	72 b7                	jb     8019de <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a27:	90                   	nop
  801a28:	c9                   	leave  
  801a29:	c3                   	ret    

00801a2a <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
  801a2d:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801a30:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801a37:	eb 03                	jmp    801a3c <busy_wait+0x12>
  801a39:	ff 45 fc             	incl   -0x4(%ebp)
  801a3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a3f:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a42:	72 f5                	jb     801a39 <busy_wait+0xf>
	return i;
  801a44:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801a47:	c9                   	leave  
  801a48:	c3                   	ret    
  801a49:	66 90                	xchg   %ax,%ax
  801a4b:	90                   	nop

00801a4c <__udivdi3>:
  801a4c:	55                   	push   %ebp
  801a4d:	57                   	push   %edi
  801a4e:	56                   	push   %esi
  801a4f:	53                   	push   %ebx
  801a50:	83 ec 1c             	sub    $0x1c,%esp
  801a53:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a57:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a5b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a5f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a63:	89 ca                	mov    %ecx,%edx
  801a65:	89 f8                	mov    %edi,%eax
  801a67:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a6b:	85 f6                	test   %esi,%esi
  801a6d:	75 2d                	jne    801a9c <__udivdi3+0x50>
  801a6f:	39 cf                	cmp    %ecx,%edi
  801a71:	77 65                	ja     801ad8 <__udivdi3+0x8c>
  801a73:	89 fd                	mov    %edi,%ebp
  801a75:	85 ff                	test   %edi,%edi
  801a77:	75 0b                	jne    801a84 <__udivdi3+0x38>
  801a79:	b8 01 00 00 00       	mov    $0x1,%eax
  801a7e:	31 d2                	xor    %edx,%edx
  801a80:	f7 f7                	div    %edi
  801a82:	89 c5                	mov    %eax,%ebp
  801a84:	31 d2                	xor    %edx,%edx
  801a86:	89 c8                	mov    %ecx,%eax
  801a88:	f7 f5                	div    %ebp
  801a8a:	89 c1                	mov    %eax,%ecx
  801a8c:	89 d8                	mov    %ebx,%eax
  801a8e:	f7 f5                	div    %ebp
  801a90:	89 cf                	mov    %ecx,%edi
  801a92:	89 fa                	mov    %edi,%edx
  801a94:	83 c4 1c             	add    $0x1c,%esp
  801a97:	5b                   	pop    %ebx
  801a98:	5e                   	pop    %esi
  801a99:	5f                   	pop    %edi
  801a9a:	5d                   	pop    %ebp
  801a9b:	c3                   	ret    
  801a9c:	39 ce                	cmp    %ecx,%esi
  801a9e:	77 28                	ja     801ac8 <__udivdi3+0x7c>
  801aa0:	0f bd fe             	bsr    %esi,%edi
  801aa3:	83 f7 1f             	xor    $0x1f,%edi
  801aa6:	75 40                	jne    801ae8 <__udivdi3+0x9c>
  801aa8:	39 ce                	cmp    %ecx,%esi
  801aaa:	72 0a                	jb     801ab6 <__udivdi3+0x6a>
  801aac:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ab0:	0f 87 9e 00 00 00    	ja     801b54 <__udivdi3+0x108>
  801ab6:	b8 01 00 00 00       	mov    $0x1,%eax
  801abb:	89 fa                	mov    %edi,%edx
  801abd:	83 c4 1c             	add    $0x1c,%esp
  801ac0:	5b                   	pop    %ebx
  801ac1:	5e                   	pop    %esi
  801ac2:	5f                   	pop    %edi
  801ac3:	5d                   	pop    %ebp
  801ac4:	c3                   	ret    
  801ac5:	8d 76 00             	lea    0x0(%esi),%esi
  801ac8:	31 ff                	xor    %edi,%edi
  801aca:	31 c0                	xor    %eax,%eax
  801acc:	89 fa                	mov    %edi,%edx
  801ace:	83 c4 1c             	add    $0x1c,%esp
  801ad1:	5b                   	pop    %ebx
  801ad2:	5e                   	pop    %esi
  801ad3:	5f                   	pop    %edi
  801ad4:	5d                   	pop    %ebp
  801ad5:	c3                   	ret    
  801ad6:	66 90                	xchg   %ax,%ax
  801ad8:	89 d8                	mov    %ebx,%eax
  801ada:	f7 f7                	div    %edi
  801adc:	31 ff                	xor    %edi,%edi
  801ade:	89 fa                	mov    %edi,%edx
  801ae0:	83 c4 1c             	add    $0x1c,%esp
  801ae3:	5b                   	pop    %ebx
  801ae4:	5e                   	pop    %esi
  801ae5:	5f                   	pop    %edi
  801ae6:	5d                   	pop    %ebp
  801ae7:	c3                   	ret    
  801ae8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801aed:	89 eb                	mov    %ebp,%ebx
  801aef:	29 fb                	sub    %edi,%ebx
  801af1:	89 f9                	mov    %edi,%ecx
  801af3:	d3 e6                	shl    %cl,%esi
  801af5:	89 c5                	mov    %eax,%ebp
  801af7:	88 d9                	mov    %bl,%cl
  801af9:	d3 ed                	shr    %cl,%ebp
  801afb:	89 e9                	mov    %ebp,%ecx
  801afd:	09 f1                	or     %esi,%ecx
  801aff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b03:	89 f9                	mov    %edi,%ecx
  801b05:	d3 e0                	shl    %cl,%eax
  801b07:	89 c5                	mov    %eax,%ebp
  801b09:	89 d6                	mov    %edx,%esi
  801b0b:	88 d9                	mov    %bl,%cl
  801b0d:	d3 ee                	shr    %cl,%esi
  801b0f:	89 f9                	mov    %edi,%ecx
  801b11:	d3 e2                	shl    %cl,%edx
  801b13:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b17:	88 d9                	mov    %bl,%cl
  801b19:	d3 e8                	shr    %cl,%eax
  801b1b:	09 c2                	or     %eax,%edx
  801b1d:	89 d0                	mov    %edx,%eax
  801b1f:	89 f2                	mov    %esi,%edx
  801b21:	f7 74 24 0c          	divl   0xc(%esp)
  801b25:	89 d6                	mov    %edx,%esi
  801b27:	89 c3                	mov    %eax,%ebx
  801b29:	f7 e5                	mul    %ebp
  801b2b:	39 d6                	cmp    %edx,%esi
  801b2d:	72 19                	jb     801b48 <__udivdi3+0xfc>
  801b2f:	74 0b                	je     801b3c <__udivdi3+0xf0>
  801b31:	89 d8                	mov    %ebx,%eax
  801b33:	31 ff                	xor    %edi,%edi
  801b35:	e9 58 ff ff ff       	jmp    801a92 <__udivdi3+0x46>
  801b3a:	66 90                	xchg   %ax,%ax
  801b3c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b40:	89 f9                	mov    %edi,%ecx
  801b42:	d3 e2                	shl    %cl,%edx
  801b44:	39 c2                	cmp    %eax,%edx
  801b46:	73 e9                	jae    801b31 <__udivdi3+0xe5>
  801b48:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b4b:	31 ff                	xor    %edi,%edi
  801b4d:	e9 40 ff ff ff       	jmp    801a92 <__udivdi3+0x46>
  801b52:	66 90                	xchg   %ax,%ax
  801b54:	31 c0                	xor    %eax,%eax
  801b56:	e9 37 ff ff ff       	jmp    801a92 <__udivdi3+0x46>
  801b5b:	90                   	nop

00801b5c <__umoddi3>:
  801b5c:	55                   	push   %ebp
  801b5d:	57                   	push   %edi
  801b5e:	56                   	push   %esi
  801b5f:	53                   	push   %ebx
  801b60:	83 ec 1c             	sub    $0x1c,%esp
  801b63:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b67:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b6b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b6f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b73:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b77:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b7b:	89 f3                	mov    %esi,%ebx
  801b7d:	89 fa                	mov    %edi,%edx
  801b7f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b83:	89 34 24             	mov    %esi,(%esp)
  801b86:	85 c0                	test   %eax,%eax
  801b88:	75 1a                	jne    801ba4 <__umoddi3+0x48>
  801b8a:	39 f7                	cmp    %esi,%edi
  801b8c:	0f 86 a2 00 00 00    	jbe    801c34 <__umoddi3+0xd8>
  801b92:	89 c8                	mov    %ecx,%eax
  801b94:	89 f2                	mov    %esi,%edx
  801b96:	f7 f7                	div    %edi
  801b98:	89 d0                	mov    %edx,%eax
  801b9a:	31 d2                	xor    %edx,%edx
  801b9c:	83 c4 1c             	add    $0x1c,%esp
  801b9f:	5b                   	pop    %ebx
  801ba0:	5e                   	pop    %esi
  801ba1:	5f                   	pop    %edi
  801ba2:	5d                   	pop    %ebp
  801ba3:	c3                   	ret    
  801ba4:	39 f0                	cmp    %esi,%eax
  801ba6:	0f 87 ac 00 00 00    	ja     801c58 <__umoddi3+0xfc>
  801bac:	0f bd e8             	bsr    %eax,%ebp
  801baf:	83 f5 1f             	xor    $0x1f,%ebp
  801bb2:	0f 84 ac 00 00 00    	je     801c64 <__umoddi3+0x108>
  801bb8:	bf 20 00 00 00       	mov    $0x20,%edi
  801bbd:	29 ef                	sub    %ebp,%edi
  801bbf:	89 fe                	mov    %edi,%esi
  801bc1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bc5:	89 e9                	mov    %ebp,%ecx
  801bc7:	d3 e0                	shl    %cl,%eax
  801bc9:	89 d7                	mov    %edx,%edi
  801bcb:	89 f1                	mov    %esi,%ecx
  801bcd:	d3 ef                	shr    %cl,%edi
  801bcf:	09 c7                	or     %eax,%edi
  801bd1:	89 e9                	mov    %ebp,%ecx
  801bd3:	d3 e2                	shl    %cl,%edx
  801bd5:	89 14 24             	mov    %edx,(%esp)
  801bd8:	89 d8                	mov    %ebx,%eax
  801bda:	d3 e0                	shl    %cl,%eax
  801bdc:	89 c2                	mov    %eax,%edx
  801bde:	8b 44 24 08          	mov    0x8(%esp),%eax
  801be2:	d3 e0                	shl    %cl,%eax
  801be4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801be8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bec:	89 f1                	mov    %esi,%ecx
  801bee:	d3 e8                	shr    %cl,%eax
  801bf0:	09 d0                	or     %edx,%eax
  801bf2:	d3 eb                	shr    %cl,%ebx
  801bf4:	89 da                	mov    %ebx,%edx
  801bf6:	f7 f7                	div    %edi
  801bf8:	89 d3                	mov    %edx,%ebx
  801bfa:	f7 24 24             	mull   (%esp)
  801bfd:	89 c6                	mov    %eax,%esi
  801bff:	89 d1                	mov    %edx,%ecx
  801c01:	39 d3                	cmp    %edx,%ebx
  801c03:	0f 82 87 00 00 00    	jb     801c90 <__umoddi3+0x134>
  801c09:	0f 84 91 00 00 00    	je     801ca0 <__umoddi3+0x144>
  801c0f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c13:	29 f2                	sub    %esi,%edx
  801c15:	19 cb                	sbb    %ecx,%ebx
  801c17:	89 d8                	mov    %ebx,%eax
  801c19:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c1d:	d3 e0                	shl    %cl,%eax
  801c1f:	89 e9                	mov    %ebp,%ecx
  801c21:	d3 ea                	shr    %cl,%edx
  801c23:	09 d0                	or     %edx,%eax
  801c25:	89 e9                	mov    %ebp,%ecx
  801c27:	d3 eb                	shr    %cl,%ebx
  801c29:	89 da                	mov    %ebx,%edx
  801c2b:	83 c4 1c             	add    $0x1c,%esp
  801c2e:	5b                   	pop    %ebx
  801c2f:	5e                   	pop    %esi
  801c30:	5f                   	pop    %edi
  801c31:	5d                   	pop    %ebp
  801c32:	c3                   	ret    
  801c33:	90                   	nop
  801c34:	89 fd                	mov    %edi,%ebp
  801c36:	85 ff                	test   %edi,%edi
  801c38:	75 0b                	jne    801c45 <__umoddi3+0xe9>
  801c3a:	b8 01 00 00 00       	mov    $0x1,%eax
  801c3f:	31 d2                	xor    %edx,%edx
  801c41:	f7 f7                	div    %edi
  801c43:	89 c5                	mov    %eax,%ebp
  801c45:	89 f0                	mov    %esi,%eax
  801c47:	31 d2                	xor    %edx,%edx
  801c49:	f7 f5                	div    %ebp
  801c4b:	89 c8                	mov    %ecx,%eax
  801c4d:	f7 f5                	div    %ebp
  801c4f:	89 d0                	mov    %edx,%eax
  801c51:	e9 44 ff ff ff       	jmp    801b9a <__umoddi3+0x3e>
  801c56:	66 90                	xchg   %ax,%ax
  801c58:	89 c8                	mov    %ecx,%eax
  801c5a:	89 f2                	mov    %esi,%edx
  801c5c:	83 c4 1c             	add    $0x1c,%esp
  801c5f:	5b                   	pop    %ebx
  801c60:	5e                   	pop    %esi
  801c61:	5f                   	pop    %edi
  801c62:	5d                   	pop    %ebp
  801c63:	c3                   	ret    
  801c64:	3b 04 24             	cmp    (%esp),%eax
  801c67:	72 06                	jb     801c6f <__umoddi3+0x113>
  801c69:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c6d:	77 0f                	ja     801c7e <__umoddi3+0x122>
  801c6f:	89 f2                	mov    %esi,%edx
  801c71:	29 f9                	sub    %edi,%ecx
  801c73:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c77:	89 14 24             	mov    %edx,(%esp)
  801c7a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c7e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c82:	8b 14 24             	mov    (%esp),%edx
  801c85:	83 c4 1c             	add    $0x1c,%esp
  801c88:	5b                   	pop    %ebx
  801c89:	5e                   	pop    %esi
  801c8a:	5f                   	pop    %edi
  801c8b:	5d                   	pop    %ebp
  801c8c:	c3                   	ret    
  801c8d:	8d 76 00             	lea    0x0(%esi),%esi
  801c90:	2b 04 24             	sub    (%esp),%eax
  801c93:	19 fa                	sbb    %edi,%edx
  801c95:	89 d1                	mov    %edx,%ecx
  801c97:	89 c6                	mov    %eax,%esi
  801c99:	e9 71 ff ff ff       	jmp    801c0f <__umoddi3+0xb3>
  801c9e:	66 90                	xchg   %ax,%ax
  801ca0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ca4:	72 ea                	jb     801c90 <__umoddi3+0x134>
  801ca6:	89 d9                	mov    %ebx,%ecx
  801ca8:	e9 62 ff ff ff       	jmp    801c0f <__umoddi3+0xb3>
