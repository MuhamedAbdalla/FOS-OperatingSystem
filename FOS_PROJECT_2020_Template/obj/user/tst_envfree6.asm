
obj/user/tst_envfree6:     file format elf32-i386


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
  800031:	e8 5c 01 00 00       	call   800192 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests the usage of shared variables
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	// Testing scenario 6: Semaphores & shared variables
	// Testing removing the shared variables and semaphores
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  80003e:	83 ec 04             	sub    $0x4,%esp
  800041:	6a 01                	push   $0x1
  800043:	6a 04                	push   $0x4
  800045:	68 60 20 80 00       	push   $0x802060
  80004a:	e8 86 14 00 00       	call   8014d5 <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*numOfFinished = 0 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	int freeFrames_before = sys_calculate_free_frames() ;
  80005e:	e8 eb 17 00 00       	call   80184e <sys_calculate_free_frames>
  800063:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800066:	e8 66 18 00 00       	call   8018d1 <sys_pf_calculate_allocated_pages>
  80006b:	89 45 ec             	mov    %eax,-0x14(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80006e:	83 ec 08             	sub    $0x8,%esp
  800071:	ff 75 f0             	pushl  -0x10(%ebp)
  800074:	68 70 20 80 00       	push   $0x802070
  800079:	e8 fb 04 00 00       	call   800579 <cprintf>
  80007e:	83 c4 10             	add    $0x10,%esp

	int32 envIdProcessA = sys_create_env("ef_tshr1", 2000, (myEnv->SecondListSize),50);
  800081:	a1 20 30 80 00       	mov    0x803020,%eax
  800086:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80008c:	6a 32                	push   $0x32
  80008e:	50                   	push   %eax
  80008f:	68 d0 07 00 00       	push   $0x7d0
  800094:	68 a3 20 80 00       	push   $0x8020a3
  800099:	e8 05 1a 00 00       	call   801aa3 <sys_create_env>
  80009e:	83 c4 10             	add    $0x10,%esp
  8000a1:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int32 envIdProcessB = sys_create_env("ef_midterm", 20,(myEnv->SecondListSize), 50);
  8000a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a9:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000af:	6a 32                	push   $0x32
  8000b1:	50                   	push   %eax
  8000b2:	6a 14                	push   $0x14
  8000b4:	68 ac 20 80 00       	push   $0x8020ac
  8000b9:	e8 e5 19 00 00       	call   801aa3 <sys_create_env>
  8000be:	83 c4 10             	add    $0x10,%esp
  8000c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	sys_run_env(envIdProcessA);
  8000c4:	83 ec 0c             	sub    $0xc,%esp
  8000c7:	ff 75 e8             	pushl  -0x18(%ebp)
  8000ca:	e8 f2 19 00 00       	call   801ac1 <sys_run_env>
  8000cf:	83 c4 10             	add    $0x10,%esp
	env_sleep(10000);
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 10 27 00 00       	push   $0x2710
  8000da:	e8 60 1c 00 00       	call   801d3f <env_sleep>
  8000df:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000e8:	e8 d4 19 00 00       	call   801ac1 <sys_run_env>
  8000ed:	83 c4 10             	add    $0x10,%esp

	while (*numOfFinished != 2) ;
  8000f0:	90                   	nop
  8000f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000f4:	8b 00                	mov    (%eax),%eax
  8000f6:	83 f8 02             	cmp    $0x2,%eax
  8000f9:	75 f6                	jne    8000f1 <_main+0xb9>
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000fb:	e8 4e 17 00 00       	call   80184e <sys_calculate_free_frames>
  800100:	83 ec 08             	sub    $0x8,%esp
  800103:	50                   	push   %eax
  800104:	68 b8 20 80 00       	push   $0x8020b8
  800109:	e8 6b 04 00 00       	call   800579 <cprintf>
  80010e:	83 c4 10             	add    $0x10,%esp

	sys_free_env(envIdProcessA);
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	ff 75 e8             	pushl  -0x18(%ebp)
  800117:	e8 c1 19 00 00       	call   801add <sys_free_env>
  80011c:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessB);
  80011f:	83 ec 0c             	sub    $0xc,%esp
  800122:	ff 75 e4             	pushl  -0x1c(%ebp)
  800125:	e8 b3 19 00 00       	call   801add <sys_free_env>
  80012a:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  80012d:	e8 1c 17 00 00       	call   80184e <sys_calculate_free_frames>
  800132:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  800135:	e8 97 17 00 00       	call   8018d1 <sys_pf_calculate_allocated_pages>
  80013a:	89 45 dc             	mov    %eax,-0x24(%ebp)

	if ((freeFrames_after - freeFrames_before) != 0) {
  80013d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800140:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800143:	74 27                	je     80016c <_main+0x134>
		cprintf("\n---# of free frames after closing running programs not as before running = %d\n",
  800145:	83 ec 08             	sub    $0x8,%esp
  800148:	ff 75 e0             	pushl  -0x20(%ebp)
  80014b:	68 ec 20 80 00       	push   $0x8020ec
  800150:	e8 24 04 00 00       	call   800579 <cprintf>
  800155:	83 c4 10             	add    $0x10,%esp
				freeFrames_after);
		panic("env_free() does not work correctly... check it again.");
  800158:	83 ec 04             	sub    $0x4,%esp
  80015b:	68 3c 21 80 00       	push   $0x80213c
  800160:	6a 23                	push   $0x23
  800162:	68 72 21 80 00       	push   $0x802172
  800167:	e8 6b 01 00 00       	call   8002d7 <_panic>
	}

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  80016c:	83 ec 08             	sub    $0x8,%esp
  80016f:	ff 75 e0             	pushl  -0x20(%ebp)
  800172:	68 88 21 80 00       	push   $0x802188
  800177:	e8 fd 03 00 00       	call   800579 <cprintf>
  80017c:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 6 for envfree completed successfully.\n");
  80017f:	83 ec 0c             	sub    $0xc,%esp
  800182:	68 e8 21 80 00       	push   $0x8021e8
  800187:	e8 ed 03 00 00       	call   800579 <cprintf>
  80018c:	83 c4 10             	add    $0x10,%esp
	return;
  80018f:	90                   	nop
}
  800190:	c9                   	leave  
  800191:	c3                   	ret    

00800192 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800192:	55                   	push   %ebp
  800193:	89 e5                	mov    %esp,%ebp
  800195:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800198:	e8 e6 15 00 00       	call   801783 <sys_getenvindex>
  80019d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001a3:	89 d0                	mov    %edx,%eax
  8001a5:	c1 e0 03             	shl    $0x3,%eax
  8001a8:	01 d0                	add    %edx,%eax
  8001aa:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001b1:	01 c8                	add    %ecx,%eax
  8001b3:	01 c0                	add    %eax,%eax
  8001b5:	01 d0                	add    %edx,%eax
  8001b7:	01 c0                	add    %eax,%eax
  8001b9:	01 d0                	add    %edx,%eax
  8001bb:	89 c2                	mov    %eax,%edx
  8001bd:	c1 e2 05             	shl    $0x5,%edx
  8001c0:	29 c2                	sub    %eax,%edx
  8001c2:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001c9:	89 c2                	mov    %eax,%edx
  8001cb:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001d1:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001db:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001e1:	84 c0                	test   %al,%al
  8001e3:	74 0f                	je     8001f4 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001e5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ea:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001ef:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001f4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001f8:	7e 0a                	jle    800204 <libmain+0x72>
		binaryname = argv[0];
  8001fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001fd:	8b 00                	mov    (%eax),%eax
  8001ff:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800204:	83 ec 08             	sub    $0x8,%esp
  800207:	ff 75 0c             	pushl  0xc(%ebp)
  80020a:	ff 75 08             	pushl  0x8(%ebp)
  80020d:	e8 26 fe ff ff       	call   800038 <_main>
  800212:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800215:	e8 04 17 00 00       	call   80191e <sys_disable_interrupt>
	cprintf("**************************************\n");
  80021a:	83 ec 0c             	sub    $0xc,%esp
  80021d:	68 4c 22 80 00       	push   $0x80224c
  800222:	e8 52 03 00 00       	call   800579 <cprintf>
  800227:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80022a:	a1 20 30 80 00       	mov    0x803020,%eax
  80022f:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800235:	a1 20 30 80 00       	mov    0x803020,%eax
  80023a:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800240:	83 ec 04             	sub    $0x4,%esp
  800243:	52                   	push   %edx
  800244:	50                   	push   %eax
  800245:	68 74 22 80 00       	push   $0x802274
  80024a:	e8 2a 03 00 00       	call   800579 <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800252:	a1 20 30 80 00       	mov    0x803020,%eax
  800257:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80025d:	a1 20 30 80 00       	mov    0x803020,%eax
  800262:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800268:	83 ec 04             	sub    $0x4,%esp
  80026b:	52                   	push   %edx
  80026c:	50                   	push   %eax
  80026d:	68 9c 22 80 00       	push   $0x80229c
  800272:	e8 02 03 00 00       	call   800579 <cprintf>
  800277:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80027a:	a1 20 30 80 00       	mov    0x803020,%eax
  80027f:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800285:	83 ec 08             	sub    $0x8,%esp
  800288:	50                   	push   %eax
  800289:	68 dd 22 80 00       	push   $0x8022dd
  80028e:	e8 e6 02 00 00       	call   800579 <cprintf>
  800293:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800296:	83 ec 0c             	sub    $0xc,%esp
  800299:	68 4c 22 80 00       	push   $0x80224c
  80029e:	e8 d6 02 00 00       	call   800579 <cprintf>
  8002a3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002a6:	e8 8d 16 00 00       	call   801938 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002ab:	e8 19 00 00 00       	call   8002c9 <exit>
}
  8002b0:	90                   	nop
  8002b1:	c9                   	leave  
  8002b2:	c3                   	ret    

008002b3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002b3:	55                   	push   %ebp
  8002b4:	89 e5                	mov    %esp,%ebp
  8002b6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002b9:	83 ec 0c             	sub    $0xc,%esp
  8002bc:	6a 00                	push   $0x0
  8002be:	e8 8c 14 00 00       	call   80174f <sys_env_destroy>
  8002c3:	83 c4 10             	add    $0x10,%esp
}
  8002c6:	90                   	nop
  8002c7:	c9                   	leave  
  8002c8:	c3                   	ret    

008002c9 <exit>:

void
exit(void)
{
  8002c9:	55                   	push   %ebp
  8002ca:	89 e5                	mov    %esp,%ebp
  8002cc:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002cf:	e8 e1 14 00 00       	call   8017b5 <sys_env_exit>
}
  8002d4:	90                   	nop
  8002d5:	c9                   	leave  
  8002d6:	c3                   	ret    

008002d7 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002d7:	55                   	push   %ebp
  8002d8:	89 e5                	mov    %esp,%ebp
  8002da:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002dd:	8d 45 10             	lea    0x10(%ebp),%eax
  8002e0:	83 c0 04             	add    $0x4,%eax
  8002e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002e6:	a1 18 31 80 00       	mov    0x803118,%eax
  8002eb:	85 c0                	test   %eax,%eax
  8002ed:	74 16                	je     800305 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002ef:	a1 18 31 80 00       	mov    0x803118,%eax
  8002f4:	83 ec 08             	sub    $0x8,%esp
  8002f7:	50                   	push   %eax
  8002f8:	68 f4 22 80 00       	push   $0x8022f4
  8002fd:	e8 77 02 00 00       	call   800579 <cprintf>
  800302:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800305:	a1 00 30 80 00       	mov    0x803000,%eax
  80030a:	ff 75 0c             	pushl  0xc(%ebp)
  80030d:	ff 75 08             	pushl  0x8(%ebp)
  800310:	50                   	push   %eax
  800311:	68 f9 22 80 00       	push   $0x8022f9
  800316:	e8 5e 02 00 00       	call   800579 <cprintf>
  80031b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80031e:	8b 45 10             	mov    0x10(%ebp),%eax
  800321:	83 ec 08             	sub    $0x8,%esp
  800324:	ff 75 f4             	pushl  -0xc(%ebp)
  800327:	50                   	push   %eax
  800328:	e8 e1 01 00 00       	call   80050e <vcprintf>
  80032d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800330:	83 ec 08             	sub    $0x8,%esp
  800333:	6a 00                	push   $0x0
  800335:	68 15 23 80 00       	push   $0x802315
  80033a:	e8 cf 01 00 00       	call   80050e <vcprintf>
  80033f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800342:	e8 82 ff ff ff       	call   8002c9 <exit>

	// should not return here
	while (1) ;
  800347:	eb fe                	jmp    800347 <_panic+0x70>

00800349 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800349:	55                   	push   %ebp
  80034a:	89 e5                	mov    %esp,%ebp
  80034c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80034f:	a1 20 30 80 00       	mov    0x803020,%eax
  800354:	8b 50 74             	mov    0x74(%eax),%edx
  800357:	8b 45 0c             	mov    0xc(%ebp),%eax
  80035a:	39 c2                	cmp    %eax,%edx
  80035c:	74 14                	je     800372 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80035e:	83 ec 04             	sub    $0x4,%esp
  800361:	68 18 23 80 00       	push   $0x802318
  800366:	6a 26                	push   $0x26
  800368:	68 64 23 80 00       	push   $0x802364
  80036d:	e8 65 ff ff ff       	call   8002d7 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800372:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800379:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800380:	e9 b6 00 00 00       	jmp    80043b <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800385:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800388:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80038f:	8b 45 08             	mov    0x8(%ebp),%eax
  800392:	01 d0                	add    %edx,%eax
  800394:	8b 00                	mov    (%eax),%eax
  800396:	85 c0                	test   %eax,%eax
  800398:	75 08                	jne    8003a2 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80039a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80039d:	e9 96 00 00 00       	jmp    800438 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8003a2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003a9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003b0:	eb 5d                	jmp    80040f <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003bd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003c0:	c1 e2 04             	shl    $0x4,%edx
  8003c3:	01 d0                	add    %edx,%eax
  8003c5:	8a 40 04             	mov    0x4(%eax),%al
  8003c8:	84 c0                	test   %al,%al
  8003ca:	75 40                	jne    80040c <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003d7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003da:	c1 e2 04             	shl    $0x4,%edx
  8003dd:	01 d0                	add    %edx,%eax
  8003df:	8b 00                	mov    (%eax),%eax
  8003e1:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003e4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003e7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003ec:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fb:	01 c8                	add    %ecx,%eax
  8003fd:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003ff:	39 c2                	cmp    %eax,%edx
  800401:	75 09                	jne    80040c <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800403:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80040a:	eb 12                	jmp    80041e <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80040c:	ff 45 e8             	incl   -0x18(%ebp)
  80040f:	a1 20 30 80 00       	mov    0x803020,%eax
  800414:	8b 50 74             	mov    0x74(%eax),%edx
  800417:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80041a:	39 c2                	cmp    %eax,%edx
  80041c:	77 94                	ja     8003b2 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80041e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800422:	75 14                	jne    800438 <CheckWSWithoutLastIndex+0xef>
			panic(
  800424:	83 ec 04             	sub    $0x4,%esp
  800427:	68 70 23 80 00       	push   $0x802370
  80042c:	6a 3a                	push   $0x3a
  80042e:	68 64 23 80 00       	push   $0x802364
  800433:	e8 9f fe ff ff       	call   8002d7 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800438:	ff 45 f0             	incl   -0x10(%ebp)
  80043b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80043e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800441:	0f 8c 3e ff ff ff    	jl     800385 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800447:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80044e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800455:	eb 20                	jmp    800477 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800457:	a1 20 30 80 00       	mov    0x803020,%eax
  80045c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800462:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800465:	c1 e2 04             	shl    $0x4,%edx
  800468:	01 d0                	add    %edx,%eax
  80046a:	8a 40 04             	mov    0x4(%eax),%al
  80046d:	3c 01                	cmp    $0x1,%al
  80046f:	75 03                	jne    800474 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800471:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800474:	ff 45 e0             	incl   -0x20(%ebp)
  800477:	a1 20 30 80 00       	mov    0x803020,%eax
  80047c:	8b 50 74             	mov    0x74(%eax),%edx
  80047f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800482:	39 c2                	cmp    %eax,%edx
  800484:	77 d1                	ja     800457 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800486:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800489:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80048c:	74 14                	je     8004a2 <CheckWSWithoutLastIndex+0x159>
		panic(
  80048e:	83 ec 04             	sub    $0x4,%esp
  800491:	68 c4 23 80 00       	push   $0x8023c4
  800496:	6a 44                	push   $0x44
  800498:	68 64 23 80 00       	push   $0x802364
  80049d:	e8 35 fe ff ff       	call   8002d7 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004a2:	90                   	nop
  8004a3:	c9                   	leave  
  8004a4:	c3                   	ret    

008004a5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004a5:	55                   	push   %ebp
  8004a6:	89 e5                	mov    %esp,%ebp
  8004a8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ae:	8b 00                	mov    (%eax),%eax
  8004b0:	8d 48 01             	lea    0x1(%eax),%ecx
  8004b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b6:	89 0a                	mov    %ecx,(%edx)
  8004b8:	8b 55 08             	mov    0x8(%ebp),%edx
  8004bb:	88 d1                	mov    %dl,%cl
  8004bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c0:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c7:	8b 00                	mov    (%eax),%eax
  8004c9:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004ce:	75 2c                	jne    8004fc <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004d0:	a0 24 30 80 00       	mov    0x803024,%al
  8004d5:	0f b6 c0             	movzbl %al,%eax
  8004d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004db:	8b 12                	mov    (%edx),%edx
  8004dd:	89 d1                	mov    %edx,%ecx
  8004df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004e2:	83 c2 08             	add    $0x8,%edx
  8004e5:	83 ec 04             	sub    $0x4,%esp
  8004e8:	50                   	push   %eax
  8004e9:	51                   	push   %ecx
  8004ea:	52                   	push   %edx
  8004eb:	e8 1d 12 00 00       	call   80170d <sys_cputs>
  8004f0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ff:	8b 40 04             	mov    0x4(%eax),%eax
  800502:	8d 50 01             	lea    0x1(%eax),%edx
  800505:	8b 45 0c             	mov    0xc(%ebp),%eax
  800508:	89 50 04             	mov    %edx,0x4(%eax)
}
  80050b:	90                   	nop
  80050c:	c9                   	leave  
  80050d:	c3                   	ret    

0080050e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80050e:	55                   	push   %ebp
  80050f:	89 e5                	mov    %esp,%ebp
  800511:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800517:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80051e:	00 00 00 
	b.cnt = 0;
  800521:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800528:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80052b:	ff 75 0c             	pushl  0xc(%ebp)
  80052e:	ff 75 08             	pushl  0x8(%ebp)
  800531:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800537:	50                   	push   %eax
  800538:	68 a5 04 80 00       	push   $0x8004a5
  80053d:	e8 11 02 00 00       	call   800753 <vprintfmt>
  800542:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800545:	a0 24 30 80 00       	mov    0x803024,%al
  80054a:	0f b6 c0             	movzbl %al,%eax
  80054d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800553:	83 ec 04             	sub    $0x4,%esp
  800556:	50                   	push   %eax
  800557:	52                   	push   %edx
  800558:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80055e:	83 c0 08             	add    $0x8,%eax
  800561:	50                   	push   %eax
  800562:	e8 a6 11 00 00       	call   80170d <sys_cputs>
  800567:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80056a:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800571:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800577:	c9                   	leave  
  800578:	c3                   	ret    

00800579 <cprintf>:

int cprintf(const char *fmt, ...) {
  800579:	55                   	push   %ebp
  80057a:	89 e5                	mov    %esp,%ebp
  80057c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80057f:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800586:	8d 45 0c             	lea    0xc(%ebp),%eax
  800589:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80058c:	8b 45 08             	mov    0x8(%ebp),%eax
  80058f:	83 ec 08             	sub    $0x8,%esp
  800592:	ff 75 f4             	pushl  -0xc(%ebp)
  800595:	50                   	push   %eax
  800596:	e8 73 ff ff ff       	call   80050e <vcprintf>
  80059b:	83 c4 10             	add    $0x10,%esp
  80059e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005a4:	c9                   	leave  
  8005a5:	c3                   	ret    

008005a6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005a6:	55                   	push   %ebp
  8005a7:	89 e5                	mov    %esp,%ebp
  8005a9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005ac:	e8 6d 13 00 00       	call   80191e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005b1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ba:	83 ec 08             	sub    $0x8,%esp
  8005bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c0:	50                   	push   %eax
  8005c1:	e8 48 ff ff ff       	call   80050e <vcprintf>
  8005c6:	83 c4 10             	add    $0x10,%esp
  8005c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005cc:	e8 67 13 00 00       	call   801938 <sys_enable_interrupt>
	return cnt;
  8005d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005d4:	c9                   	leave  
  8005d5:	c3                   	ret    

008005d6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005d6:	55                   	push   %ebp
  8005d7:	89 e5                	mov    %esp,%ebp
  8005d9:	53                   	push   %ebx
  8005da:	83 ec 14             	sub    $0x14,%esp
  8005dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8005e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005e9:	8b 45 18             	mov    0x18(%ebp),%eax
  8005ec:	ba 00 00 00 00       	mov    $0x0,%edx
  8005f1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005f4:	77 55                	ja     80064b <printnum+0x75>
  8005f6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005f9:	72 05                	jb     800600 <printnum+0x2a>
  8005fb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005fe:	77 4b                	ja     80064b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800600:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800603:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800606:	8b 45 18             	mov    0x18(%ebp),%eax
  800609:	ba 00 00 00 00       	mov    $0x0,%edx
  80060e:	52                   	push   %edx
  80060f:	50                   	push   %eax
  800610:	ff 75 f4             	pushl  -0xc(%ebp)
  800613:	ff 75 f0             	pushl  -0x10(%ebp)
  800616:	e8 d9 17 00 00       	call   801df4 <__udivdi3>
  80061b:	83 c4 10             	add    $0x10,%esp
  80061e:	83 ec 04             	sub    $0x4,%esp
  800621:	ff 75 20             	pushl  0x20(%ebp)
  800624:	53                   	push   %ebx
  800625:	ff 75 18             	pushl  0x18(%ebp)
  800628:	52                   	push   %edx
  800629:	50                   	push   %eax
  80062a:	ff 75 0c             	pushl  0xc(%ebp)
  80062d:	ff 75 08             	pushl  0x8(%ebp)
  800630:	e8 a1 ff ff ff       	call   8005d6 <printnum>
  800635:	83 c4 20             	add    $0x20,%esp
  800638:	eb 1a                	jmp    800654 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80063a:	83 ec 08             	sub    $0x8,%esp
  80063d:	ff 75 0c             	pushl  0xc(%ebp)
  800640:	ff 75 20             	pushl  0x20(%ebp)
  800643:	8b 45 08             	mov    0x8(%ebp),%eax
  800646:	ff d0                	call   *%eax
  800648:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80064b:	ff 4d 1c             	decl   0x1c(%ebp)
  80064e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800652:	7f e6                	jg     80063a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800654:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800657:	bb 00 00 00 00       	mov    $0x0,%ebx
  80065c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80065f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800662:	53                   	push   %ebx
  800663:	51                   	push   %ecx
  800664:	52                   	push   %edx
  800665:	50                   	push   %eax
  800666:	e8 99 18 00 00       	call   801f04 <__umoddi3>
  80066b:	83 c4 10             	add    $0x10,%esp
  80066e:	05 34 26 80 00       	add    $0x802634,%eax
  800673:	8a 00                	mov    (%eax),%al
  800675:	0f be c0             	movsbl %al,%eax
  800678:	83 ec 08             	sub    $0x8,%esp
  80067b:	ff 75 0c             	pushl  0xc(%ebp)
  80067e:	50                   	push   %eax
  80067f:	8b 45 08             	mov    0x8(%ebp),%eax
  800682:	ff d0                	call   *%eax
  800684:	83 c4 10             	add    $0x10,%esp
}
  800687:	90                   	nop
  800688:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80068b:	c9                   	leave  
  80068c:	c3                   	ret    

0080068d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80068d:	55                   	push   %ebp
  80068e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800690:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800694:	7e 1c                	jle    8006b2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800696:	8b 45 08             	mov    0x8(%ebp),%eax
  800699:	8b 00                	mov    (%eax),%eax
  80069b:	8d 50 08             	lea    0x8(%eax),%edx
  80069e:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a1:	89 10                	mov    %edx,(%eax)
  8006a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a6:	8b 00                	mov    (%eax),%eax
  8006a8:	83 e8 08             	sub    $0x8,%eax
  8006ab:	8b 50 04             	mov    0x4(%eax),%edx
  8006ae:	8b 00                	mov    (%eax),%eax
  8006b0:	eb 40                	jmp    8006f2 <getuint+0x65>
	else if (lflag)
  8006b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006b6:	74 1e                	je     8006d6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bb:	8b 00                	mov    (%eax),%eax
  8006bd:	8d 50 04             	lea    0x4(%eax),%edx
  8006c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c3:	89 10                	mov    %edx,(%eax)
  8006c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c8:	8b 00                	mov    (%eax),%eax
  8006ca:	83 e8 04             	sub    $0x4,%eax
  8006cd:	8b 00                	mov    (%eax),%eax
  8006cf:	ba 00 00 00 00       	mov    $0x0,%edx
  8006d4:	eb 1c                	jmp    8006f2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d9:	8b 00                	mov    (%eax),%eax
  8006db:	8d 50 04             	lea    0x4(%eax),%edx
  8006de:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e1:	89 10                	mov    %edx,(%eax)
  8006e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e6:	8b 00                	mov    (%eax),%eax
  8006e8:	83 e8 04             	sub    $0x4,%eax
  8006eb:	8b 00                	mov    (%eax),%eax
  8006ed:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006f2:	5d                   	pop    %ebp
  8006f3:	c3                   	ret    

008006f4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006f4:	55                   	push   %ebp
  8006f5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006f7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006fb:	7e 1c                	jle    800719 <getint+0x25>
		return va_arg(*ap, long long);
  8006fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800700:	8b 00                	mov    (%eax),%eax
  800702:	8d 50 08             	lea    0x8(%eax),%edx
  800705:	8b 45 08             	mov    0x8(%ebp),%eax
  800708:	89 10                	mov    %edx,(%eax)
  80070a:	8b 45 08             	mov    0x8(%ebp),%eax
  80070d:	8b 00                	mov    (%eax),%eax
  80070f:	83 e8 08             	sub    $0x8,%eax
  800712:	8b 50 04             	mov    0x4(%eax),%edx
  800715:	8b 00                	mov    (%eax),%eax
  800717:	eb 38                	jmp    800751 <getint+0x5d>
	else if (lflag)
  800719:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80071d:	74 1a                	je     800739 <getint+0x45>
		return va_arg(*ap, long);
  80071f:	8b 45 08             	mov    0x8(%ebp),%eax
  800722:	8b 00                	mov    (%eax),%eax
  800724:	8d 50 04             	lea    0x4(%eax),%edx
  800727:	8b 45 08             	mov    0x8(%ebp),%eax
  80072a:	89 10                	mov    %edx,(%eax)
  80072c:	8b 45 08             	mov    0x8(%ebp),%eax
  80072f:	8b 00                	mov    (%eax),%eax
  800731:	83 e8 04             	sub    $0x4,%eax
  800734:	8b 00                	mov    (%eax),%eax
  800736:	99                   	cltd   
  800737:	eb 18                	jmp    800751 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800739:	8b 45 08             	mov    0x8(%ebp),%eax
  80073c:	8b 00                	mov    (%eax),%eax
  80073e:	8d 50 04             	lea    0x4(%eax),%edx
  800741:	8b 45 08             	mov    0x8(%ebp),%eax
  800744:	89 10                	mov    %edx,(%eax)
  800746:	8b 45 08             	mov    0x8(%ebp),%eax
  800749:	8b 00                	mov    (%eax),%eax
  80074b:	83 e8 04             	sub    $0x4,%eax
  80074e:	8b 00                	mov    (%eax),%eax
  800750:	99                   	cltd   
}
  800751:	5d                   	pop    %ebp
  800752:	c3                   	ret    

00800753 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800753:	55                   	push   %ebp
  800754:	89 e5                	mov    %esp,%ebp
  800756:	56                   	push   %esi
  800757:	53                   	push   %ebx
  800758:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80075b:	eb 17                	jmp    800774 <vprintfmt+0x21>
			if (ch == '\0')
  80075d:	85 db                	test   %ebx,%ebx
  80075f:	0f 84 af 03 00 00    	je     800b14 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800765:	83 ec 08             	sub    $0x8,%esp
  800768:	ff 75 0c             	pushl  0xc(%ebp)
  80076b:	53                   	push   %ebx
  80076c:	8b 45 08             	mov    0x8(%ebp),%eax
  80076f:	ff d0                	call   *%eax
  800771:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800774:	8b 45 10             	mov    0x10(%ebp),%eax
  800777:	8d 50 01             	lea    0x1(%eax),%edx
  80077a:	89 55 10             	mov    %edx,0x10(%ebp)
  80077d:	8a 00                	mov    (%eax),%al
  80077f:	0f b6 d8             	movzbl %al,%ebx
  800782:	83 fb 25             	cmp    $0x25,%ebx
  800785:	75 d6                	jne    80075d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800787:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80078b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800792:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800799:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007a0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8007aa:	8d 50 01             	lea    0x1(%eax),%edx
  8007ad:	89 55 10             	mov    %edx,0x10(%ebp)
  8007b0:	8a 00                	mov    (%eax),%al
  8007b2:	0f b6 d8             	movzbl %al,%ebx
  8007b5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007b8:	83 f8 55             	cmp    $0x55,%eax
  8007bb:	0f 87 2b 03 00 00    	ja     800aec <vprintfmt+0x399>
  8007c1:	8b 04 85 58 26 80 00 	mov    0x802658(,%eax,4),%eax
  8007c8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007ca:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007ce:	eb d7                	jmp    8007a7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007d0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007d4:	eb d1                	jmp    8007a7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007d6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007dd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007e0:	89 d0                	mov    %edx,%eax
  8007e2:	c1 e0 02             	shl    $0x2,%eax
  8007e5:	01 d0                	add    %edx,%eax
  8007e7:	01 c0                	add    %eax,%eax
  8007e9:	01 d8                	add    %ebx,%eax
  8007eb:	83 e8 30             	sub    $0x30,%eax
  8007ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f4:	8a 00                	mov    (%eax),%al
  8007f6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007f9:	83 fb 2f             	cmp    $0x2f,%ebx
  8007fc:	7e 3e                	jle    80083c <vprintfmt+0xe9>
  8007fe:	83 fb 39             	cmp    $0x39,%ebx
  800801:	7f 39                	jg     80083c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800803:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800806:	eb d5                	jmp    8007dd <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800808:	8b 45 14             	mov    0x14(%ebp),%eax
  80080b:	83 c0 04             	add    $0x4,%eax
  80080e:	89 45 14             	mov    %eax,0x14(%ebp)
  800811:	8b 45 14             	mov    0x14(%ebp),%eax
  800814:	83 e8 04             	sub    $0x4,%eax
  800817:	8b 00                	mov    (%eax),%eax
  800819:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80081c:	eb 1f                	jmp    80083d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80081e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800822:	79 83                	jns    8007a7 <vprintfmt+0x54>
				width = 0;
  800824:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80082b:	e9 77 ff ff ff       	jmp    8007a7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800830:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800837:	e9 6b ff ff ff       	jmp    8007a7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80083c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80083d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800841:	0f 89 60 ff ff ff    	jns    8007a7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800847:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80084a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80084d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800854:	e9 4e ff ff ff       	jmp    8007a7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800859:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80085c:	e9 46 ff ff ff       	jmp    8007a7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800861:	8b 45 14             	mov    0x14(%ebp),%eax
  800864:	83 c0 04             	add    $0x4,%eax
  800867:	89 45 14             	mov    %eax,0x14(%ebp)
  80086a:	8b 45 14             	mov    0x14(%ebp),%eax
  80086d:	83 e8 04             	sub    $0x4,%eax
  800870:	8b 00                	mov    (%eax),%eax
  800872:	83 ec 08             	sub    $0x8,%esp
  800875:	ff 75 0c             	pushl  0xc(%ebp)
  800878:	50                   	push   %eax
  800879:	8b 45 08             	mov    0x8(%ebp),%eax
  80087c:	ff d0                	call   *%eax
  80087e:	83 c4 10             	add    $0x10,%esp
			break;
  800881:	e9 89 02 00 00       	jmp    800b0f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800886:	8b 45 14             	mov    0x14(%ebp),%eax
  800889:	83 c0 04             	add    $0x4,%eax
  80088c:	89 45 14             	mov    %eax,0x14(%ebp)
  80088f:	8b 45 14             	mov    0x14(%ebp),%eax
  800892:	83 e8 04             	sub    $0x4,%eax
  800895:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800897:	85 db                	test   %ebx,%ebx
  800899:	79 02                	jns    80089d <vprintfmt+0x14a>
				err = -err;
  80089b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80089d:	83 fb 64             	cmp    $0x64,%ebx
  8008a0:	7f 0b                	jg     8008ad <vprintfmt+0x15a>
  8008a2:	8b 34 9d a0 24 80 00 	mov    0x8024a0(,%ebx,4),%esi
  8008a9:	85 f6                	test   %esi,%esi
  8008ab:	75 19                	jne    8008c6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008ad:	53                   	push   %ebx
  8008ae:	68 45 26 80 00       	push   $0x802645
  8008b3:	ff 75 0c             	pushl  0xc(%ebp)
  8008b6:	ff 75 08             	pushl  0x8(%ebp)
  8008b9:	e8 5e 02 00 00       	call   800b1c <printfmt>
  8008be:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008c1:	e9 49 02 00 00       	jmp    800b0f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008c6:	56                   	push   %esi
  8008c7:	68 4e 26 80 00       	push   $0x80264e
  8008cc:	ff 75 0c             	pushl  0xc(%ebp)
  8008cf:	ff 75 08             	pushl  0x8(%ebp)
  8008d2:	e8 45 02 00 00       	call   800b1c <printfmt>
  8008d7:	83 c4 10             	add    $0x10,%esp
			break;
  8008da:	e9 30 02 00 00       	jmp    800b0f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008df:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e2:	83 c0 04             	add    $0x4,%eax
  8008e5:	89 45 14             	mov    %eax,0x14(%ebp)
  8008e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8008eb:	83 e8 04             	sub    $0x4,%eax
  8008ee:	8b 30                	mov    (%eax),%esi
  8008f0:	85 f6                	test   %esi,%esi
  8008f2:	75 05                	jne    8008f9 <vprintfmt+0x1a6>
				p = "(null)";
  8008f4:	be 51 26 80 00       	mov    $0x802651,%esi
			if (width > 0 && padc != '-')
  8008f9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008fd:	7e 6d                	jle    80096c <vprintfmt+0x219>
  8008ff:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800903:	74 67                	je     80096c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800905:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800908:	83 ec 08             	sub    $0x8,%esp
  80090b:	50                   	push   %eax
  80090c:	56                   	push   %esi
  80090d:	e8 0c 03 00 00       	call   800c1e <strnlen>
  800912:	83 c4 10             	add    $0x10,%esp
  800915:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800918:	eb 16                	jmp    800930 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80091a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80091e:	83 ec 08             	sub    $0x8,%esp
  800921:	ff 75 0c             	pushl  0xc(%ebp)
  800924:	50                   	push   %eax
  800925:	8b 45 08             	mov    0x8(%ebp),%eax
  800928:	ff d0                	call   *%eax
  80092a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80092d:	ff 4d e4             	decl   -0x1c(%ebp)
  800930:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800934:	7f e4                	jg     80091a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800936:	eb 34                	jmp    80096c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800938:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80093c:	74 1c                	je     80095a <vprintfmt+0x207>
  80093e:	83 fb 1f             	cmp    $0x1f,%ebx
  800941:	7e 05                	jle    800948 <vprintfmt+0x1f5>
  800943:	83 fb 7e             	cmp    $0x7e,%ebx
  800946:	7e 12                	jle    80095a <vprintfmt+0x207>
					putch('?', putdat);
  800948:	83 ec 08             	sub    $0x8,%esp
  80094b:	ff 75 0c             	pushl  0xc(%ebp)
  80094e:	6a 3f                	push   $0x3f
  800950:	8b 45 08             	mov    0x8(%ebp),%eax
  800953:	ff d0                	call   *%eax
  800955:	83 c4 10             	add    $0x10,%esp
  800958:	eb 0f                	jmp    800969 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80095a:	83 ec 08             	sub    $0x8,%esp
  80095d:	ff 75 0c             	pushl  0xc(%ebp)
  800960:	53                   	push   %ebx
  800961:	8b 45 08             	mov    0x8(%ebp),%eax
  800964:	ff d0                	call   *%eax
  800966:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800969:	ff 4d e4             	decl   -0x1c(%ebp)
  80096c:	89 f0                	mov    %esi,%eax
  80096e:	8d 70 01             	lea    0x1(%eax),%esi
  800971:	8a 00                	mov    (%eax),%al
  800973:	0f be d8             	movsbl %al,%ebx
  800976:	85 db                	test   %ebx,%ebx
  800978:	74 24                	je     80099e <vprintfmt+0x24b>
  80097a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80097e:	78 b8                	js     800938 <vprintfmt+0x1e5>
  800980:	ff 4d e0             	decl   -0x20(%ebp)
  800983:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800987:	79 af                	jns    800938 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800989:	eb 13                	jmp    80099e <vprintfmt+0x24b>
				putch(' ', putdat);
  80098b:	83 ec 08             	sub    $0x8,%esp
  80098e:	ff 75 0c             	pushl  0xc(%ebp)
  800991:	6a 20                	push   $0x20
  800993:	8b 45 08             	mov    0x8(%ebp),%eax
  800996:	ff d0                	call   *%eax
  800998:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80099b:	ff 4d e4             	decl   -0x1c(%ebp)
  80099e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009a2:	7f e7                	jg     80098b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009a4:	e9 66 01 00 00       	jmp    800b0f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009a9:	83 ec 08             	sub    $0x8,%esp
  8009ac:	ff 75 e8             	pushl  -0x18(%ebp)
  8009af:	8d 45 14             	lea    0x14(%ebp),%eax
  8009b2:	50                   	push   %eax
  8009b3:	e8 3c fd ff ff       	call   8006f4 <getint>
  8009b8:	83 c4 10             	add    $0x10,%esp
  8009bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009be:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009c7:	85 d2                	test   %edx,%edx
  8009c9:	79 23                	jns    8009ee <vprintfmt+0x29b>
				putch('-', putdat);
  8009cb:	83 ec 08             	sub    $0x8,%esp
  8009ce:	ff 75 0c             	pushl  0xc(%ebp)
  8009d1:	6a 2d                	push   $0x2d
  8009d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d6:	ff d0                	call   *%eax
  8009d8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009e1:	f7 d8                	neg    %eax
  8009e3:	83 d2 00             	adc    $0x0,%edx
  8009e6:	f7 da                	neg    %edx
  8009e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009ee:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009f5:	e9 bc 00 00 00       	jmp    800ab6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009fa:	83 ec 08             	sub    $0x8,%esp
  8009fd:	ff 75 e8             	pushl  -0x18(%ebp)
  800a00:	8d 45 14             	lea    0x14(%ebp),%eax
  800a03:	50                   	push   %eax
  800a04:	e8 84 fc ff ff       	call   80068d <getuint>
  800a09:	83 c4 10             	add    $0x10,%esp
  800a0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a0f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a12:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a19:	e9 98 00 00 00       	jmp    800ab6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a1e:	83 ec 08             	sub    $0x8,%esp
  800a21:	ff 75 0c             	pushl  0xc(%ebp)
  800a24:	6a 58                	push   $0x58
  800a26:	8b 45 08             	mov    0x8(%ebp),%eax
  800a29:	ff d0                	call   *%eax
  800a2b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a2e:	83 ec 08             	sub    $0x8,%esp
  800a31:	ff 75 0c             	pushl  0xc(%ebp)
  800a34:	6a 58                	push   $0x58
  800a36:	8b 45 08             	mov    0x8(%ebp),%eax
  800a39:	ff d0                	call   *%eax
  800a3b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a3e:	83 ec 08             	sub    $0x8,%esp
  800a41:	ff 75 0c             	pushl  0xc(%ebp)
  800a44:	6a 58                	push   $0x58
  800a46:	8b 45 08             	mov    0x8(%ebp),%eax
  800a49:	ff d0                	call   *%eax
  800a4b:	83 c4 10             	add    $0x10,%esp
			break;
  800a4e:	e9 bc 00 00 00       	jmp    800b0f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a53:	83 ec 08             	sub    $0x8,%esp
  800a56:	ff 75 0c             	pushl  0xc(%ebp)
  800a59:	6a 30                	push   $0x30
  800a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5e:	ff d0                	call   *%eax
  800a60:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a63:	83 ec 08             	sub    $0x8,%esp
  800a66:	ff 75 0c             	pushl  0xc(%ebp)
  800a69:	6a 78                	push   $0x78
  800a6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6e:	ff d0                	call   *%eax
  800a70:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a73:	8b 45 14             	mov    0x14(%ebp),%eax
  800a76:	83 c0 04             	add    $0x4,%eax
  800a79:	89 45 14             	mov    %eax,0x14(%ebp)
  800a7c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a7f:	83 e8 04             	sub    $0x4,%eax
  800a82:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a84:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a8e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a95:	eb 1f                	jmp    800ab6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a97:	83 ec 08             	sub    $0x8,%esp
  800a9a:	ff 75 e8             	pushl  -0x18(%ebp)
  800a9d:	8d 45 14             	lea    0x14(%ebp),%eax
  800aa0:	50                   	push   %eax
  800aa1:	e8 e7 fb ff ff       	call   80068d <getuint>
  800aa6:	83 c4 10             	add    $0x10,%esp
  800aa9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aac:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800aaf:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ab6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800aba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800abd:	83 ec 04             	sub    $0x4,%esp
  800ac0:	52                   	push   %edx
  800ac1:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ac4:	50                   	push   %eax
  800ac5:	ff 75 f4             	pushl  -0xc(%ebp)
  800ac8:	ff 75 f0             	pushl  -0x10(%ebp)
  800acb:	ff 75 0c             	pushl  0xc(%ebp)
  800ace:	ff 75 08             	pushl  0x8(%ebp)
  800ad1:	e8 00 fb ff ff       	call   8005d6 <printnum>
  800ad6:	83 c4 20             	add    $0x20,%esp
			break;
  800ad9:	eb 34                	jmp    800b0f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800adb:	83 ec 08             	sub    $0x8,%esp
  800ade:	ff 75 0c             	pushl  0xc(%ebp)
  800ae1:	53                   	push   %ebx
  800ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae5:	ff d0                	call   *%eax
  800ae7:	83 c4 10             	add    $0x10,%esp
			break;
  800aea:	eb 23                	jmp    800b0f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800aec:	83 ec 08             	sub    $0x8,%esp
  800aef:	ff 75 0c             	pushl  0xc(%ebp)
  800af2:	6a 25                	push   $0x25
  800af4:	8b 45 08             	mov    0x8(%ebp),%eax
  800af7:	ff d0                	call   *%eax
  800af9:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800afc:	ff 4d 10             	decl   0x10(%ebp)
  800aff:	eb 03                	jmp    800b04 <vprintfmt+0x3b1>
  800b01:	ff 4d 10             	decl   0x10(%ebp)
  800b04:	8b 45 10             	mov    0x10(%ebp),%eax
  800b07:	48                   	dec    %eax
  800b08:	8a 00                	mov    (%eax),%al
  800b0a:	3c 25                	cmp    $0x25,%al
  800b0c:	75 f3                	jne    800b01 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b0e:	90                   	nop
		}
	}
  800b0f:	e9 47 fc ff ff       	jmp    80075b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b14:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b15:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b18:	5b                   	pop    %ebx
  800b19:	5e                   	pop    %esi
  800b1a:	5d                   	pop    %ebp
  800b1b:	c3                   	ret    

00800b1c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b1c:	55                   	push   %ebp
  800b1d:	89 e5                	mov    %esp,%ebp
  800b1f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b22:	8d 45 10             	lea    0x10(%ebp),%eax
  800b25:	83 c0 04             	add    $0x4,%eax
  800b28:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b2e:	ff 75 f4             	pushl  -0xc(%ebp)
  800b31:	50                   	push   %eax
  800b32:	ff 75 0c             	pushl  0xc(%ebp)
  800b35:	ff 75 08             	pushl  0x8(%ebp)
  800b38:	e8 16 fc ff ff       	call   800753 <vprintfmt>
  800b3d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b40:	90                   	nop
  800b41:	c9                   	leave  
  800b42:	c3                   	ret    

00800b43 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b43:	55                   	push   %ebp
  800b44:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b49:	8b 40 08             	mov    0x8(%eax),%eax
  800b4c:	8d 50 01             	lea    0x1(%eax),%edx
  800b4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b52:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b58:	8b 10                	mov    (%eax),%edx
  800b5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5d:	8b 40 04             	mov    0x4(%eax),%eax
  800b60:	39 c2                	cmp    %eax,%edx
  800b62:	73 12                	jae    800b76 <sprintputch+0x33>
		*b->buf++ = ch;
  800b64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b67:	8b 00                	mov    (%eax),%eax
  800b69:	8d 48 01             	lea    0x1(%eax),%ecx
  800b6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b6f:	89 0a                	mov    %ecx,(%edx)
  800b71:	8b 55 08             	mov    0x8(%ebp),%edx
  800b74:	88 10                	mov    %dl,(%eax)
}
  800b76:	90                   	nop
  800b77:	5d                   	pop    %ebp
  800b78:	c3                   	ret    

00800b79 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b79:	55                   	push   %ebp
  800b7a:	89 e5                	mov    %esp,%ebp
  800b7c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b88:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8e:	01 d0                	add    %edx,%eax
  800b90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b9a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b9e:	74 06                	je     800ba6 <vsnprintf+0x2d>
  800ba0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ba4:	7f 07                	jg     800bad <vsnprintf+0x34>
		return -E_INVAL;
  800ba6:	b8 03 00 00 00       	mov    $0x3,%eax
  800bab:	eb 20                	jmp    800bcd <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bad:	ff 75 14             	pushl  0x14(%ebp)
  800bb0:	ff 75 10             	pushl  0x10(%ebp)
  800bb3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bb6:	50                   	push   %eax
  800bb7:	68 43 0b 80 00       	push   $0x800b43
  800bbc:	e8 92 fb ff ff       	call   800753 <vprintfmt>
  800bc1:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bc4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bc7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bca:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800bcd:	c9                   	leave  
  800bce:	c3                   	ret    

00800bcf <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bcf:	55                   	push   %ebp
  800bd0:	89 e5                	mov    %esp,%ebp
  800bd2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bd5:	8d 45 10             	lea    0x10(%ebp),%eax
  800bd8:	83 c0 04             	add    $0x4,%eax
  800bdb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bde:	8b 45 10             	mov    0x10(%ebp),%eax
  800be1:	ff 75 f4             	pushl  -0xc(%ebp)
  800be4:	50                   	push   %eax
  800be5:	ff 75 0c             	pushl  0xc(%ebp)
  800be8:	ff 75 08             	pushl  0x8(%ebp)
  800beb:	e8 89 ff ff ff       	call   800b79 <vsnprintf>
  800bf0:	83 c4 10             	add    $0x10,%esp
  800bf3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800bf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bf9:	c9                   	leave  
  800bfa:	c3                   	ret    

00800bfb <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bfb:	55                   	push   %ebp
  800bfc:	89 e5                	mov    %esp,%ebp
  800bfe:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c01:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c08:	eb 06                	jmp    800c10 <strlen+0x15>
		n++;
  800c0a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c0d:	ff 45 08             	incl   0x8(%ebp)
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	8a 00                	mov    (%eax),%al
  800c15:	84 c0                	test   %al,%al
  800c17:	75 f1                	jne    800c0a <strlen+0xf>
		n++;
	return n;
  800c19:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c1c:	c9                   	leave  
  800c1d:	c3                   	ret    

00800c1e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c1e:	55                   	push   %ebp
  800c1f:	89 e5                	mov    %esp,%ebp
  800c21:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c24:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c2b:	eb 09                	jmp    800c36 <strnlen+0x18>
		n++;
  800c2d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c30:	ff 45 08             	incl   0x8(%ebp)
  800c33:	ff 4d 0c             	decl   0xc(%ebp)
  800c36:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c3a:	74 09                	je     800c45 <strnlen+0x27>
  800c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3f:	8a 00                	mov    (%eax),%al
  800c41:	84 c0                	test   %al,%al
  800c43:	75 e8                	jne    800c2d <strnlen+0xf>
		n++;
	return n;
  800c45:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c48:	c9                   	leave  
  800c49:	c3                   	ret    

00800c4a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c4a:	55                   	push   %ebp
  800c4b:	89 e5                	mov    %esp,%ebp
  800c4d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c50:	8b 45 08             	mov    0x8(%ebp),%eax
  800c53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c56:	90                   	nop
  800c57:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5a:	8d 50 01             	lea    0x1(%eax),%edx
  800c5d:	89 55 08             	mov    %edx,0x8(%ebp)
  800c60:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c63:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c66:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c69:	8a 12                	mov    (%edx),%dl
  800c6b:	88 10                	mov    %dl,(%eax)
  800c6d:	8a 00                	mov    (%eax),%al
  800c6f:	84 c0                	test   %al,%al
  800c71:	75 e4                	jne    800c57 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c73:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c76:	c9                   	leave  
  800c77:	c3                   	ret    

00800c78 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c78:	55                   	push   %ebp
  800c79:	89 e5                	mov    %esp,%ebp
  800c7b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c84:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c8b:	eb 1f                	jmp    800cac <strncpy+0x34>
		*dst++ = *src;
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	8d 50 01             	lea    0x1(%eax),%edx
  800c93:	89 55 08             	mov    %edx,0x8(%ebp)
  800c96:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c99:	8a 12                	mov    (%edx),%dl
  800c9b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	84 c0                	test   %al,%al
  800ca4:	74 03                	je     800ca9 <strncpy+0x31>
			src++;
  800ca6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ca9:	ff 45 fc             	incl   -0x4(%ebp)
  800cac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800caf:	3b 45 10             	cmp    0x10(%ebp),%eax
  800cb2:	72 d9                	jb     800c8d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800cb4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800cb7:	c9                   	leave  
  800cb8:	c3                   	ret    

00800cb9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800cb9:	55                   	push   %ebp
  800cba:	89 e5                	mov    %esp,%ebp
  800cbc:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cc5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc9:	74 30                	je     800cfb <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ccb:	eb 16                	jmp    800ce3 <strlcpy+0x2a>
			*dst++ = *src++;
  800ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd0:	8d 50 01             	lea    0x1(%eax),%edx
  800cd3:	89 55 08             	mov    %edx,0x8(%ebp)
  800cd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cd9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cdc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cdf:	8a 12                	mov    (%edx),%dl
  800ce1:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ce3:	ff 4d 10             	decl   0x10(%ebp)
  800ce6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cea:	74 09                	je     800cf5 <strlcpy+0x3c>
  800cec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cef:	8a 00                	mov    (%eax),%al
  800cf1:	84 c0                	test   %al,%al
  800cf3:	75 d8                	jne    800ccd <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf8:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cfb:	8b 55 08             	mov    0x8(%ebp),%edx
  800cfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d01:	29 c2                	sub    %eax,%edx
  800d03:	89 d0                	mov    %edx,%eax
}
  800d05:	c9                   	leave  
  800d06:	c3                   	ret    

00800d07 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d07:	55                   	push   %ebp
  800d08:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d0a:	eb 06                	jmp    800d12 <strcmp+0xb>
		p++, q++;
  800d0c:	ff 45 08             	incl   0x8(%ebp)
  800d0f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d12:	8b 45 08             	mov    0x8(%ebp),%eax
  800d15:	8a 00                	mov    (%eax),%al
  800d17:	84 c0                	test   %al,%al
  800d19:	74 0e                	je     800d29 <strcmp+0x22>
  800d1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1e:	8a 10                	mov    (%eax),%dl
  800d20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d23:	8a 00                	mov    (%eax),%al
  800d25:	38 c2                	cmp    %al,%dl
  800d27:	74 e3                	je     800d0c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	8a 00                	mov    (%eax),%al
  800d2e:	0f b6 d0             	movzbl %al,%edx
  800d31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d34:	8a 00                	mov    (%eax),%al
  800d36:	0f b6 c0             	movzbl %al,%eax
  800d39:	29 c2                	sub    %eax,%edx
  800d3b:	89 d0                	mov    %edx,%eax
}
  800d3d:	5d                   	pop    %ebp
  800d3e:	c3                   	ret    

00800d3f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d3f:	55                   	push   %ebp
  800d40:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d42:	eb 09                	jmp    800d4d <strncmp+0xe>
		n--, p++, q++;
  800d44:	ff 4d 10             	decl   0x10(%ebp)
  800d47:	ff 45 08             	incl   0x8(%ebp)
  800d4a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d4d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d51:	74 17                	je     800d6a <strncmp+0x2b>
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	8a 00                	mov    (%eax),%al
  800d58:	84 c0                	test   %al,%al
  800d5a:	74 0e                	je     800d6a <strncmp+0x2b>
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	8a 10                	mov    (%eax),%dl
  800d61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d64:	8a 00                	mov    (%eax),%al
  800d66:	38 c2                	cmp    %al,%dl
  800d68:	74 da                	je     800d44 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d6a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d6e:	75 07                	jne    800d77 <strncmp+0x38>
		return 0;
  800d70:	b8 00 00 00 00       	mov    $0x0,%eax
  800d75:	eb 14                	jmp    800d8b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	8a 00                	mov    (%eax),%al
  800d7c:	0f b6 d0             	movzbl %al,%edx
  800d7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d82:	8a 00                	mov    (%eax),%al
  800d84:	0f b6 c0             	movzbl %al,%eax
  800d87:	29 c2                	sub    %eax,%edx
  800d89:	89 d0                	mov    %edx,%eax
}
  800d8b:	5d                   	pop    %ebp
  800d8c:	c3                   	ret    

00800d8d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d8d:	55                   	push   %ebp
  800d8e:	89 e5                	mov    %esp,%ebp
  800d90:	83 ec 04             	sub    $0x4,%esp
  800d93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d96:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d99:	eb 12                	jmp    800dad <strchr+0x20>
		if (*s == c)
  800d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9e:	8a 00                	mov    (%eax),%al
  800da0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800da3:	75 05                	jne    800daa <strchr+0x1d>
			return (char *) s;
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	eb 11                	jmp    800dbb <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800daa:	ff 45 08             	incl   0x8(%ebp)
  800dad:	8b 45 08             	mov    0x8(%ebp),%eax
  800db0:	8a 00                	mov    (%eax),%al
  800db2:	84 c0                	test   %al,%al
  800db4:	75 e5                	jne    800d9b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800db6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800dbb:	c9                   	leave  
  800dbc:	c3                   	ret    

00800dbd <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800dbd:	55                   	push   %ebp
  800dbe:	89 e5                	mov    %esp,%ebp
  800dc0:	83 ec 04             	sub    $0x4,%esp
  800dc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dc9:	eb 0d                	jmp    800dd8 <strfind+0x1b>
		if (*s == c)
  800dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dce:	8a 00                	mov    (%eax),%al
  800dd0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dd3:	74 0e                	je     800de3 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800dd5:	ff 45 08             	incl   0x8(%ebp)
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	8a 00                	mov    (%eax),%al
  800ddd:	84 c0                	test   %al,%al
  800ddf:	75 ea                	jne    800dcb <strfind+0xe>
  800de1:	eb 01                	jmp    800de4 <strfind+0x27>
		if (*s == c)
			break;
  800de3:	90                   	nop
	return (char *) s;
  800de4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800de7:	c9                   	leave  
  800de8:	c3                   	ret    

00800de9 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800de9:	55                   	push   %ebp
  800dea:	89 e5                	mov    %esp,%ebp
  800dec:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800def:	8b 45 08             	mov    0x8(%ebp),%eax
  800df2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800df5:	8b 45 10             	mov    0x10(%ebp),%eax
  800df8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800dfb:	eb 0e                	jmp    800e0b <memset+0x22>
		*p++ = c;
  800dfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e00:	8d 50 01             	lea    0x1(%eax),%edx
  800e03:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e06:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e09:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e0b:	ff 4d f8             	decl   -0x8(%ebp)
  800e0e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e12:	79 e9                	jns    800dfd <memset+0x14>
		*p++ = c;

	return v;
  800e14:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e17:	c9                   	leave  
  800e18:	c3                   	ret    

00800e19 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e19:	55                   	push   %ebp
  800e1a:	89 e5                	mov    %esp,%ebp
  800e1c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e22:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e2b:	eb 16                	jmp    800e43 <memcpy+0x2a>
		*d++ = *s++;
  800e2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e30:	8d 50 01             	lea    0x1(%eax),%edx
  800e33:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e36:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e39:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e3c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e3f:	8a 12                	mov    (%edx),%dl
  800e41:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e43:	8b 45 10             	mov    0x10(%ebp),%eax
  800e46:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e49:	89 55 10             	mov    %edx,0x10(%ebp)
  800e4c:	85 c0                	test   %eax,%eax
  800e4e:	75 dd                	jne    800e2d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e50:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e53:	c9                   	leave  
  800e54:	c3                   	ret    

00800e55 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e55:	55                   	push   %ebp
  800e56:	89 e5                	mov    %esp,%ebp
  800e58:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e61:	8b 45 08             	mov    0x8(%ebp),%eax
  800e64:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e67:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e6d:	73 50                	jae    800ebf <memmove+0x6a>
  800e6f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e72:	8b 45 10             	mov    0x10(%ebp),%eax
  800e75:	01 d0                	add    %edx,%eax
  800e77:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e7a:	76 43                	jbe    800ebf <memmove+0x6a>
		s += n;
  800e7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e7f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e82:	8b 45 10             	mov    0x10(%ebp),%eax
  800e85:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e88:	eb 10                	jmp    800e9a <memmove+0x45>
			*--d = *--s;
  800e8a:	ff 4d f8             	decl   -0x8(%ebp)
  800e8d:	ff 4d fc             	decl   -0x4(%ebp)
  800e90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e93:	8a 10                	mov    (%eax),%dl
  800e95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e98:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ea0:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea3:	85 c0                	test   %eax,%eax
  800ea5:	75 e3                	jne    800e8a <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ea7:	eb 23                	jmp    800ecc <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ea9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eac:	8d 50 01             	lea    0x1(%eax),%edx
  800eaf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800eb2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eb5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eb8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ebb:	8a 12                	mov    (%edx),%dl
  800ebd:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ebf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec5:	89 55 10             	mov    %edx,0x10(%ebp)
  800ec8:	85 c0                	test   %eax,%eax
  800eca:	75 dd                	jne    800ea9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ecf:	c9                   	leave  
  800ed0:	c3                   	ret    

00800ed1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ed1:	55                   	push   %ebp
  800ed2:	89 e5                	mov    %esp,%ebp
  800ed4:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eda:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800edd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee0:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ee3:	eb 2a                	jmp    800f0f <memcmp+0x3e>
		if (*s1 != *s2)
  800ee5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee8:	8a 10                	mov    (%eax),%dl
  800eea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	38 c2                	cmp    %al,%dl
  800ef1:	74 16                	je     800f09 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ef3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef6:	8a 00                	mov    (%eax),%al
  800ef8:	0f b6 d0             	movzbl %al,%edx
  800efb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800efe:	8a 00                	mov    (%eax),%al
  800f00:	0f b6 c0             	movzbl %al,%eax
  800f03:	29 c2                	sub    %eax,%edx
  800f05:	89 d0                	mov    %edx,%eax
  800f07:	eb 18                	jmp    800f21 <memcmp+0x50>
		s1++, s2++;
  800f09:	ff 45 fc             	incl   -0x4(%ebp)
  800f0c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f12:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f15:	89 55 10             	mov    %edx,0x10(%ebp)
  800f18:	85 c0                	test   %eax,%eax
  800f1a:	75 c9                	jne    800ee5 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f1c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f21:	c9                   	leave  
  800f22:	c3                   	ret    

00800f23 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f23:	55                   	push   %ebp
  800f24:	89 e5                	mov    %esp,%ebp
  800f26:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f29:	8b 55 08             	mov    0x8(%ebp),%edx
  800f2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2f:	01 d0                	add    %edx,%eax
  800f31:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f34:	eb 15                	jmp    800f4b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f36:	8b 45 08             	mov    0x8(%ebp),%eax
  800f39:	8a 00                	mov    (%eax),%al
  800f3b:	0f b6 d0             	movzbl %al,%edx
  800f3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f41:	0f b6 c0             	movzbl %al,%eax
  800f44:	39 c2                	cmp    %eax,%edx
  800f46:	74 0d                	je     800f55 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f48:	ff 45 08             	incl   0x8(%ebp)
  800f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f51:	72 e3                	jb     800f36 <memfind+0x13>
  800f53:	eb 01                	jmp    800f56 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f55:	90                   	nop
	return (void *) s;
  800f56:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f59:	c9                   	leave  
  800f5a:	c3                   	ret    

00800f5b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f5b:	55                   	push   %ebp
  800f5c:	89 e5                	mov    %esp,%ebp
  800f5e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f61:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f68:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f6f:	eb 03                	jmp    800f74 <strtol+0x19>
		s++;
  800f71:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	8a 00                	mov    (%eax),%al
  800f79:	3c 20                	cmp    $0x20,%al
  800f7b:	74 f4                	je     800f71 <strtol+0x16>
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	3c 09                	cmp    $0x9,%al
  800f84:	74 eb                	je     800f71 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	8a 00                	mov    (%eax),%al
  800f8b:	3c 2b                	cmp    $0x2b,%al
  800f8d:	75 05                	jne    800f94 <strtol+0x39>
		s++;
  800f8f:	ff 45 08             	incl   0x8(%ebp)
  800f92:	eb 13                	jmp    800fa7 <strtol+0x4c>
	else if (*s == '-')
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	8a 00                	mov    (%eax),%al
  800f99:	3c 2d                	cmp    $0x2d,%al
  800f9b:	75 0a                	jne    800fa7 <strtol+0x4c>
		s++, neg = 1;
  800f9d:	ff 45 08             	incl   0x8(%ebp)
  800fa0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fa7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fab:	74 06                	je     800fb3 <strtol+0x58>
  800fad:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fb1:	75 20                	jne    800fd3 <strtol+0x78>
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	8a 00                	mov    (%eax),%al
  800fb8:	3c 30                	cmp    $0x30,%al
  800fba:	75 17                	jne    800fd3 <strtol+0x78>
  800fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbf:	40                   	inc    %eax
  800fc0:	8a 00                	mov    (%eax),%al
  800fc2:	3c 78                	cmp    $0x78,%al
  800fc4:	75 0d                	jne    800fd3 <strtol+0x78>
		s += 2, base = 16;
  800fc6:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fca:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fd1:	eb 28                	jmp    800ffb <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fd3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fd7:	75 15                	jne    800fee <strtol+0x93>
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdc:	8a 00                	mov    (%eax),%al
  800fde:	3c 30                	cmp    $0x30,%al
  800fe0:	75 0c                	jne    800fee <strtol+0x93>
		s++, base = 8;
  800fe2:	ff 45 08             	incl   0x8(%ebp)
  800fe5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fec:	eb 0d                	jmp    800ffb <strtol+0xa0>
	else if (base == 0)
  800fee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ff2:	75 07                	jne    800ffb <strtol+0xa0>
		base = 10;
  800ff4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	8a 00                	mov    (%eax),%al
  801000:	3c 2f                	cmp    $0x2f,%al
  801002:	7e 19                	jle    80101d <strtol+0xc2>
  801004:	8b 45 08             	mov    0x8(%ebp),%eax
  801007:	8a 00                	mov    (%eax),%al
  801009:	3c 39                	cmp    $0x39,%al
  80100b:	7f 10                	jg     80101d <strtol+0xc2>
			dig = *s - '0';
  80100d:	8b 45 08             	mov    0x8(%ebp),%eax
  801010:	8a 00                	mov    (%eax),%al
  801012:	0f be c0             	movsbl %al,%eax
  801015:	83 e8 30             	sub    $0x30,%eax
  801018:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80101b:	eb 42                	jmp    80105f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80101d:	8b 45 08             	mov    0x8(%ebp),%eax
  801020:	8a 00                	mov    (%eax),%al
  801022:	3c 60                	cmp    $0x60,%al
  801024:	7e 19                	jle    80103f <strtol+0xe4>
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	8a 00                	mov    (%eax),%al
  80102b:	3c 7a                	cmp    $0x7a,%al
  80102d:	7f 10                	jg     80103f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	8a 00                	mov    (%eax),%al
  801034:	0f be c0             	movsbl %al,%eax
  801037:	83 e8 57             	sub    $0x57,%eax
  80103a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80103d:	eb 20                	jmp    80105f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	8a 00                	mov    (%eax),%al
  801044:	3c 40                	cmp    $0x40,%al
  801046:	7e 39                	jle    801081 <strtol+0x126>
  801048:	8b 45 08             	mov    0x8(%ebp),%eax
  80104b:	8a 00                	mov    (%eax),%al
  80104d:	3c 5a                	cmp    $0x5a,%al
  80104f:	7f 30                	jg     801081 <strtol+0x126>
			dig = *s - 'A' + 10;
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	8a 00                	mov    (%eax),%al
  801056:	0f be c0             	movsbl %al,%eax
  801059:	83 e8 37             	sub    $0x37,%eax
  80105c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80105f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801062:	3b 45 10             	cmp    0x10(%ebp),%eax
  801065:	7d 19                	jge    801080 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801067:	ff 45 08             	incl   0x8(%ebp)
  80106a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801071:	89 c2                	mov    %eax,%edx
  801073:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801076:	01 d0                	add    %edx,%eax
  801078:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80107b:	e9 7b ff ff ff       	jmp    800ffb <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801080:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801081:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801085:	74 08                	je     80108f <strtol+0x134>
		*endptr = (char *) s;
  801087:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108a:	8b 55 08             	mov    0x8(%ebp),%edx
  80108d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80108f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801093:	74 07                	je     80109c <strtol+0x141>
  801095:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801098:	f7 d8                	neg    %eax
  80109a:	eb 03                	jmp    80109f <strtol+0x144>
  80109c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80109f:	c9                   	leave  
  8010a0:	c3                   	ret    

008010a1 <ltostr>:

void
ltostr(long value, char *str)
{
  8010a1:	55                   	push   %ebp
  8010a2:	89 e5                	mov    %esp,%ebp
  8010a4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010ae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010b5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010b9:	79 13                	jns    8010ce <ltostr+0x2d>
	{
		neg = 1;
  8010bb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c5:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010c8:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010cb:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010d6:	99                   	cltd   
  8010d7:	f7 f9                	idiv   %ecx
  8010d9:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010df:	8d 50 01             	lea    0x1(%eax),%edx
  8010e2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010e5:	89 c2                	mov    %eax,%edx
  8010e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ea:	01 d0                	add    %edx,%eax
  8010ec:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010ef:	83 c2 30             	add    $0x30,%edx
  8010f2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010f7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010fc:	f7 e9                	imul   %ecx
  8010fe:	c1 fa 02             	sar    $0x2,%edx
  801101:	89 c8                	mov    %ecx,%eax
  801103:	c1 f8 1f             	sar    $0x1f,%eax
  801106:	29 c2                	sub    %eax,%edx
  801108:	89 d0                	mov    %edx,%eax
  80110a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80110d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801110:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801115:	f7 e9                	imul   %ecx
  801117:	c1 fa 02             	sar    $0x2,%edx
  80111a:	89 c8                	mov    %ecx,%eax
  80111c:	c1 f8 1f             	sar    $0x1f,%eax
  80111f:	29 c2                	sub    %eax,%edx
  801121:	89 d0                	mov    %edx,%eax
  801123:	c1 e0 02             	shl    $0x2,%eax
  801126:	01 d0                	add    %edx,%eax
  801128:	01 c0                	add    %eax,%eax
  80112a:	29 c1                	sub    %eax,%ecx
  80112c:	89 ca                	mov    %ecx,%edx
  80112e:	85 d2                	test   %edx,%edx
  801130:	75 9c                	jne    8010ce <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801132:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801139:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80113c:	48                   	dec    %eax
  80113d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801140:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801144:	74 3d                	je     801183 <ltostr+0xe2>
		start = 1 ;
  801146:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80114d:	eb 34                	jmp    801183 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80114f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801152:	8b 45 0c             	mov    0xc(%ebp),%eax
  801155:	01 d0                	add    %edx,%eax
  801157:	8a 00                	mov    (%eax),%al
  801159:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80115c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80115f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801162:	01 c2                	add    %eax,%edx
  801164:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801167:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116a:	01 c8                	add    %ecx,%eax
  80116c:	8a 00                	mov    (%eax),%al
  80116e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801170:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801173:	8b 45 0c             	mov    0xc(%ebp),%eax
  801176:	01 c2                	add    %eax,%edx
  801178:	8a 45 eb             	mov    -0x15(%ebp),%al
  80117b:	88 02                	mov    %al,(%edx)
		start++ ;
  80117d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801180:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801183:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801186:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801189:	7c c4                	jl     80114f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80118b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80118e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801191:	01 d0                	add    %edx,%eax
  801193:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801196:	90                   	nop
  801197:	c9                   	leave  
  801198:	c3                   	ret    

00801199 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801199:	55                   	push   %ebp
  80119a:	89 e5                	mov    %esp,%ebp
  80119c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80119f:	ff 75 08             	pushl  0x8(%ebp)
  8011a2:	e8 54 fa ff ff       	call   800bfb <strlen>
  8011a7:	83 c4 04             	add    $0x4,%esp
  8011aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011ad:	ff 75 0c             	pushl  0xc(%ebp)
  8011b0:	e8 46 fa ff ff       	call   800bfb <strlen>
  8011b5:	83 c4 04             	add    $0x4,%esp
  8011b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011c9:	eb 17                	jmp    8011e2 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d1:	01 c2                	add    %eax,%edx
  8011d3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	01 c8                	add    %ecx,%eax
  8011db:	8a 00                	mov    (%eax),%al
  8011dd:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011df:	ff 45 fc             	incl   -0x4(%ebp)
  8011e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011e5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011e8:	7c e1                	jl     8011cb <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011ea:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011f1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011f8:	eb 1f                	jmp    801219 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011fd:	8d 50 01             	lea    0x1(%eax),%edx
  801200:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801203:	89 c2                	mov    %eax,%edx
  801205:	8b 45 10             	mov    0x10(%ebp),%eax
  801208:	01 c2                	add    %eax,%edx
  80120a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80120d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801210:	01 c8                	add    %ecx,%eax
  801212:	8a 00                	mov    (%eax),%al
  801214:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801216:	ff 45 f8             	incl   -0x8(%ebp)
  801219:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80121c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80121f:	7c d9                	jl     8011fa <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801221:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801224:	8b 45 10             	mov    0x10(%ebp),%eax
  801227:	01 d0                	add    %edx,%eax
  801229:	c6 00 00             	movb   $0x0,(%eax)
}
  80122c:	90                   	nop
  80122d:	c9                   	leave  
  80122e:	c3                   	ret    

0080122f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80122f:	55                   	push   %ebp
  801230:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801232:	8b 45 14             	mov    0x14(%ebp),%eax
  801235:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80123b:	8b 45 14             	mov    0x14(%ebp),%eax
  80123e:	8b 00                	mov    (%eax),%eax
  801240:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801247:	8b 45 10             	mov    0x10(%ebp),%eax
  80124a:	01 d0                	add    %edx,%eax
  80124c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801252:	eb 0c                	jmp    801260 <strsplit+0x31>
			*string++ = 0;
  801254:	8b 45 08             	mov    0x8(%ebp),%eax
  801257:	8d 50 01             	lea    0x1(%eax),%edx
  80125a:	89 55 08             	mov    %edx,0x8(%ebp)
  80125d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801260:	8b 45 08             	mov    0x8(%ebp),%eax
  801263:	8a 00                	mov    (%eax),%al
  801265:	84 c0                	test   %al,%al
  801267:	74 18                	je     801281 <strsplit+0x52>
  801269:	8b 45 08             	mov    0x8(%ebp),%eax
  80126c:	8a 00                	mov    (%eax),%al
  80126e:	0f be c0             	movsbl %al,%eax
  801271:	50                   	push   %eax
  801272:	ff 75 0c             	pushl  0xc(%ebp)
  801275:	e8 13 fb ff ff       	call   800d8d <strchr>
  80127a:	83 c4 08             	add    $0x8,%esp
  80127d:	85 c0                	test   %eax,%eax
  80127f:	75 d3                	jne    801254 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	8a 00                	mov    (%eax),%al
  801286:	84 c0                	test   %al,%al
  801288:	74 5a                	je     8012e4 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80128a:	8b 45 14             	mov    0x14(%ebp),%eax
  80128d:	8b 00                	mov    (%eax),%eax
  80128f:	83 f8 0f             	cmp    $0xf,%eax
  801292:	75 07                	jne    80129b <strsplit+0x6c>
		{
			return 0;
  801294:	b8 00 00 00 00       	mov    $0x0,%eax
  801299:	eb 66                	jmp    801301 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80129b:	8b 45 14             	mov    0x14(%ebp),%eax
  80129e:	8b 00                	mov    (%eax),%eax
  8012a0:	8d 48 01             	lea    0x1(%eax),%ecx
  8012a3:	8b 55 14             	mov    0x14(%ebp),%edx
  8012a6:	89 0a                	mov    %ecx,(%edx)
  8012a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012af:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b2:	01 c2                	add    %eax,%edx
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012b9:	eb 03                	jmp    8012be <strsplit+0x8f>
			string++;
  8012bb:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012be:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c1:	8a 00                	mov    (%eax),%al
  8012c3:	84 c0                	test   %al,%al
  8012c5:	74 8b                	je     801252 <strsplit+0x23>
  8012c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ca:	8a 00                	mov    (%eax),%al
  8012cc:	0f be c0             	movsbl %al,%eax
  8012cf:	50                   	push   %eax
  8012d0:	ff 75 0c             	pushl  0xc(%ebp)
  8012d3:	e8 b5 fa ff ff       	call   800d8d <strchr>
  8012d8:	83 c4 08             	add    $0x8,%esp
  8012db:	85 c0                	test   %eax,%eax
  8012dd:	74 dc                	je     8012bb <strsplit+0x8c>
			string++;
	}
  8012df:	e9 6e ff ff ff       	jmp    801252 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012e4:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8012e8:	8b 00                	mov    (%eax),%eax
  8012ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f4:	01 d0                	add    %edx,%eax
  8012f6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012fc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801301:	c9                   	leave  
  801302:	c3                   	ret    

00801303 <malloc>:
//==================================================================================//
int FirstTimeFlag = 1;
int allocated[MAXN];

void* malloc(uint32 size)
{
  801303:	55                   	push   %ebp
  801304:	89 e5                	mov    %esp,%ebp
  801306:	83 ec 28             	sub    $0x28,%esp
	//DON'T CHANGE THIS CODE
	if(FirstTimeFlag)
  801309:	a1 04 30 80 00       	mov    0x803004,%eax
  80130e:	85 c0                	test   %eax,%eax
  801310:	74 0f                	je     801321 <malloc+0x1e>
	{
		initialize_buddy();
  801312:	e8 a4 02 00 00       	call   8015bb <initialize_buddy>
		FirstTimeFlag = 0;
  801317:	c7 05 04 30 80 00 00 	movl   $0x0,0x803004
  80131e:	00 00 00 
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
  801321:	81 7d 08 00 08 00 00 	cmpl   $0x800,0x8(%ebp)
  801328:	0f 86 0b 01 00 00    	jbe    801439 <malloc+0x136>
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
  80132e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801335:	8b 45 08             	mov    0x8(%ebp),%eax
  801338:	c1 e8 0c             	shr    $0xc,%eax
  80133b:	89 c2                	mov    %eax,%edx
  80133d:	8b 45 08             	mov    0x8(%ebp),%eax
  801340:	25 ff 0f 00 00       	and    $0xfff,%eax
  801345:	85 c0                	test   %eax,%eax
  801347:	74 07                	je     801350 <malloc+0x4d>
  801349:	b8 01 00 00 00       	mov    $0x1,%eax
  80134e:	eb 05                	jmp    801355 <malloc+0x52>
  801350:	b8 00 00 00 00       	mov    $0x0,%eax
  801355:	01 d0                	add    %edx,%eax
  801357:	89 45 e8             	mov    %eax,-0x18(%ebp)
  80135a:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  801361:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
		for(i = 0; i < MAXN; i++) {
  801368:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80136f:	eb 5c                	jmp    8013cd <malloc+0xca>
			if(allocated[i] != 0) continue;
  801371:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801374:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80137b:	85 c0                	test   %eax,%eax
  80137d:	75 4a                	jne    8013c9 <malloc+0xc6>
			j = 1;
  80137f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
			i++;
  801386:	ff 45 f4             	incl   -0xc(%ebp)
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  801389:	eb 06                	jmp    801391 <malloc+0x8e>
				i++;
  80138b:	ff 45 f4             	incl   -0xc(%ebp)
				j++;
  80138e:	ff 45 ec             	incl   -0x14(%ebp)
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
			j = 1;
			i++;
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  801391:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801394:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801399:	77 16                	ja     8013b1 <malloc+0xae>
  80139b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80139e:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8013a5:	85 c0                	test   %eax,%eax
  8013a7:	75 08                	jne    8013b1 <malloc+0xae>
  8013a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013ac:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8013af:	7c da                	jl     80138b <malloc+0x88>
				i++;
				j++;
			}
			if(j == sizeToPage) {
  8013b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013b4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8013b7:	75 0b                	jne    8013c4 <malloc+0xc1>
				indx = i - j;
  8013b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013bc:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8013bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
				break;
  8013c2:	eb 13                	jmp    8013d7 <malloc+0xd4>
			}
			i--;
  8013c4:	ff 4d f4             	decl   -0xc(%ebp)
  8013c7:	eb 01                	jmp    8013ca <malloc+0xc7>
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
  8013c9:	90                   	nop
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
  8013ca:	ff 45 f4             	incl   -0xc(%ebp)
  8013cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013d0:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8013d5:	76 9a                	jbe    801371 <malloc+0x6e>
				indx = i - j;
				break;
			}
			i--;
		}
		if(indx == -1) {
  8013d7:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
  8013db:	75 07                	jne    8013e4 <malloc+0xe1>
			return NULL;
  8013dd:	b8 00 00 00 00       	mov    $0x0,%eax
  8013e2:	eb 5a                	jmp    80143e <malloc+0x13b>
		}
		i = indx;
  8013e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
		while(i < j + indx) {
  8013ea:	eb 13                	jmp    8013ff <malloc+0xfc>
			allocated[i++] = j;
  8013ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ef:	8d 50 01             	lea    0x1(%eax),%edx
  8013f2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8013f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013f8:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		}
		if(indx == -1) {
			return NULL;
		}
		i = indx;
		while(i < j + indx) {
  8013ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801402:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801405:	01 d0                	add    %edx,%eax
  801407:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80140a:	7f e0                	jg     8013ec <malloc+0xe9>
			allocated[i++] = j;
		}
		uint32 *address = (uint32 *)(USER_HEAP_START + (indx * PAGE_SIZE));
  80140c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80140f:	c1 e0 0c             	shl    $0xc,%eax
  801412:	05 00 00 00 80       	add    $0x80000000,%eax
  801417:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		sys_allocateMem(USER_HEAP_START + (indx * PAGE_SIZE), size);
  80141a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80141d:	c1 e0 0c             	shl    $0xc,%eax
  801420:	05 00 00 00 80       	add    $0x80000000,%eax
  801425:	83 ec 08             	sub    $0x8,%esp
  801428:	ff 75 08             	pushl  0x8(%ebp)
  80142b:	50                   	push   %eax
  80142c:	e8 84 04 00 00       	call   8018b5 <sys_allocateMem>
  801431:	83 c4 10             	add    $0x10,%esp
		return address;
  801434:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801437:	eb 05                	jmp    80143e <malloc+0x13b>
	//1) FIRST FIT strategy (if size > 2 KB)
	//2) Buddy System (if size <= 2 KB)

	//refer to the project presentation and documentation for details

	return NULL;
  801439:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80143e:	c9                   	leave  
  80143f:	c3                   	ret    

00801440 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801440:	55                   	push   %ebp
  801441:	89 e5                	mov    %esp,%ebp
  801443:	83 ec 18             	sub    $0x18,%esp
	//TODO: [PROJECT 2020 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80144c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80144f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801454:	89 45 08             	mov    %eax,0x8(%ebp)
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
  801457:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	05 00 00 00 80       	add    $0x80000000,%eax
  801466:	c1 e8 0c             	shr    $0xc,%eax
  801469:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int removable_size = allocated[indx];
  80146c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80146f:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801476:	89 45 e8             	mov    %eax,-0x18(%ebp)
	size = allocated[indx];
  801479:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80147c:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801483:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while(size > 0) {
  801486:	eb 17                	jmp    80149f <free+0x5f>
		allocated[indx++] = 0;
  801488:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80148b:	8d 50 01             	lea    0x1(%eax),%edx
  80148e:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801491:	c7 04 85 20 31 80 00 	movl   $0x0,0x803120(,%eax,4)
  801498:	00 00 00 00 
		size--;
  80149c:	ff 4d f4             	decl   -0xc(%ebp)
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
	int removable_size = allocated[indx];
	size = allocated[indx];
	while(size > 0) {
  80149f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8014a3:	7f e3                	jg     801488 <free+0x48>
		allocated[indx++] = 0;
		size--;
	}
	sys_freeMem((uint32)virtual_address, removable_size);
  8014a5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8014a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ab:	83 ec 08             	sub    $0x8,%esp
  8014ae:	52                   	push   %edx
  8014af:	50                   	push   %eax
  8014b0:	e8 e4 03 00 00       	call   801899 <sys_freeMem>
  8014b5:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details

}
  8014b8:	90                   	nop
  8014b9:	c9                   	leave  
  8014ba:	c3                   	ret    

008014bb <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8014bb:	55                   	push   %ebp
  8014bc:	89 e5                	mov    %esp,%ebp
  8014be:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - BONUS2] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8014c1:	83 ec 04             	sub    $0x4,%esp
  8014c4:	68 b0 27 80 00       	push   $0x8027b0
  8014c9:	6a 7a                	push   $0x7a
  8014cb:	68 d6 27 80 00       	push   $0x8027d6
  8014d0:	e8 02 ee ff ff       	call   8002d7 <_panic>

008014d5 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8014d5:	55                   	push   %ebp
  8014d6:	89 e5                	mov    %esp,%ebp
  8014d8:	83 ec 18             	sub    $0x18,%esp
  8014db:	8b 45 10             	mov    0x10(%ebp),%eax
  8014de:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8014e1:	83 ec 04             	sub    $0x4,%esp
  8014e4:	68 e4 27 80 00       	push   $0x8027e4
  8014e9:	68 84 00 00 00       	push   $0x84
  8014ee:	68 d6 27 80 00       	push   $0x8027d6
  8014f3:	e8 df ed ff ff       	call   8002d7 <_panic>

008014f8 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8014f8:	55                   	push   %ebp
  8014f9:	89 e5                	mov    %esp,%ebp
  8014fb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014fe:	83 ec 04             	sub    $0x4,%esp
  801501:	68 e4 27 80 00       	push   $0x8027e4
  801506:	68 8a 00 00 00       	push   $0x8a
  80150b:	68 d6 27 80 00       	push   $0x8027d6
  801510:	e8 c2 ed ff ff       	call   8002d7 <_panic>

00801515 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801515:	55                   	push   %ebp
  801516:	89 e5                	mov    %esp,%ebp
  801518:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80151b:	83 ec 04             	sub    $0x4,%esp
  80151e:	68 e4 27 80 00       	push   $0x8027e4
  801523:	68 90 00 00 00       	push   $0x90
  801528:	68 d6 27 80 00       	push   $0x8027d6
  80152d:	e8 a5 ed ff ff       	call   8002d7 <_panic>

00801532 <expand>:
}

void expand(uint32 newSize)
{
  801532:	55                   	push   %ebp
  801533:	89 e5                	mov    %esp,%ebp
  801535:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801538:	83 ec 04             	sub    $0x4,%esp
  80153b:	68 e4 27 80 00       	push   $0x8027e4
  801540:	68 95 00 00 00       	push   $0x95
  801545:	68 d6 27 80 00       	push   $0x8027d6
  80154a:	e8 88 ed ff ff       	call   8002d7 <_panic>

0080154f <shrink>:
}
void shrink(uint32 newSize)
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
  801552:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801555:	83 ec 04             	sub    $0x4,%esp
  801558:	68 e4 27 80 00       	push   $0x8027e4
  80155d:	68 99 00 00 00       	push   $0x99
  801562:	68 d6 27 80 00       	push   $0x8027d6
  801567:	e8 6b ed ff ff       	call   8002d7 <_panic>

0080156c <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  80156c:	55                   	push   %ebp
  80156d:	89 e5                	mov    %esp,%ebp
  80156f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801572:	83 ec 04             	sub    $0x4,%esp
  801575:	68 e4 27 80 00       	push   $0x8027e4
  80157a:	68 9e 00 00 00       	push   $0x9e
  80157f:	68 d6 27 80 00       	push   $0x8027d6
  801584:	e8 4e ed ff ff       	call   8002d7 <_panic>

00801589 <ClearNodeData>:
 * inside the user heap
 */
 
struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  801593:	8b 45 08             	mov    0x8(%ebp),%eax
  801596:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  80159a:	8b 45 08             	mov    0x8(%ebp),%eax
  80159d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  8015a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a7:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  8015ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b1:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  8015b8:	90                   	nop
  8015b9:	5d                   	pop    %ebp
  8015ba:	c3                   	ret    

008015bb <initialize_buddy>:

void initialize_buddy()
{
  8015bb:	55                   	push   %ebp
  8015bc:	89 e5                	mov    %esp,%ebp
  8015be:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  8015c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015c8:	e9 b7 00 00 00       	jmp    801684 <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  8015cd:	8b 15 04 31 80 00    	mov    0x803104,%edx
  8015d3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015d6:	89 c8                	mov    %ecx,%eax
  8015d8:	01 c0                	add    %eax,%eax
  8015da:	01 c8                	add    %ecx,%eax
  8015dc:	c1 e0 03             	shl    $0x3,%eax
  8015df:	05 20 31 88 00       	add    $0x883120,%eax
  8015e4:	89 10                	mov    %edx,(%eax)
  8015e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015e9:	89 d0                	mov    %edx,%eax
  8015eb:	01 c0                	add    %eax,%eax
  8015ed:	01 d0                	add    %edx,%eax
  8015ef:	c1 e0 03             	shl    $0x3,%eax
  8015f2:	05 20 31 88 00       	add    $0x883120,%eax
  8015f7:	8b 00                	mov    (%eax),%eax
  8015f9:	85 c0                	test   %eax,%eax
  8015fb:	74 1c                	je     801619 <initialize_buddy+0x5e>
  8015fd:	8b 15 04 31 80 00    	mov    0x803104,%edx
  801603:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801606:	89 c8                	mov    %ecx,%eax
  801608:	01 c0                	add    %eax,%eax
  80160a:	01 c8                	add    %ecx,%eax
  80160c:	c1 e0 03             	shl    $0x3,%eax
  80160f:	05 20 31 88 00       	add    $0x883120,%eax
  801614:	89 42 04             	mov    %eax,0x4(%edx)
  801617:	eb 16                	jmp    80162f <initialize_buddy+0x74>
  801619:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80161c:	89 d0                	mov    %edx,%eax
  80161e:	01 c0                	add    %eax,%eax
  801620:	01 d0                	add    %edx,%eax
  801622:	c1 e0 03             	shl    $0x3,%eax
  801625:	05 20 31 88 00       	add    $0x883120,%eax
  80162a:	a3 08 31 80 00       	mov    %eax,0x803108
  80162f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801632:	89 d0                	mov    %edx,%eax
  801634:	01 c0                	add    %eax,%eax
  801636:	01 d0                	add    %edx,%eax
  801638:	c1 e0 03             	shl    $0x3,%eax
  80163b:	05 20 31 88 00       	add    $0x883120,%eax
  801640:	a3 04 31 80 00       	mov    %eax,0x803104
  801645:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801648:	89 d0                	mov    %edx,%eax
  80164a:	01 c0                	add    %eax,%eax
  80164c:	01 d0                	add    %edx,%eax
  80164e:	c1 e0 03             	shl    $0x3,%eax
  801651:	05 24 31 88 00       	add    $0x883124,%eax
  801656:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  80165c:	a1 10 31 80 00       	mov    0x803110,%eax
  801661:	40                   	inc    %eax
  801662:	a3 10 31 80 00       	mov    %eax,0x803110
		ClearNodeData(&(FreeNodes[i]));
  801667:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80166a:	89 d0                	mov    %edx,%eax
  80166c:	01 c0                	add    %eax,%eax
  80166e:	01 d0                	add    %edx,%eax
  801670:	c1 e0 03             	shl    $0x3,%eax
  801673:	05 20 31 88 00       	add    $0x883120,%eax
  801678:	50                   	push   %eax
  801679:	e8 0b ff ff ff       	call   801589 <ClearNodeData>
  80167e:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801681:	ff 45 fc             	incl   -0x4(%ebp)
  801684:	81 7d fc 3f 9c 00 00 	cmpl   $0x9c3f,-0x4(%ebp)
  80168b:	0f 8e 3c ff ff ff    	jle    8015cd <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  801691:	90                   	nop
  801692:	c9                   	leave  
  801693:	c3                   	ret    

00801694 <CreateNewBuddySpace>:
/*===============================================================*/

//TODO: [PROJECT 2020 - BONUS4] Expand Buddy Free Node List

void CreateNewBuddySpace()
{
  801694:	55                   	push   %ebp
  801695:	89 e5                	mov    %esp,%ebp
  801697:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Create New Buddy Block]
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  80169a:	83 ec 04             	sub    $0x4,%esp
  80169d:	68 08 28 80 00       	push   $0x802808
  8016a2:	6a 22                	push   $0x22
  8016a4:	68 3a 28 80 00       	push   $0x80283a
  8016a9:	e8 29 ec ff ff       	call   8002d7 <_panic>

008016ae <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  8016ae:	55                   	push   %ebp
  8016af:	89 e5                	mov    %esp,%ebp
  8016b1:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Get Allocation]
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  8016b4:	83 ec 04             	sub    $0x4,%esp
  8016b7:	68 48 28 80 00       	push   $0x802848
  8016bc:	6a 2a                	push   $0x2a
  8016be:	68 3a 28 80 00       	push   $0x80283a
  8016c3:	e8 0f ec ff ff       	call   8002d7 <_panic>

008016c8 <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  8016c8:	55                   	push   %ebp
  8016c9:	89 e5                	mov    %esp,%ebp
  8016cb:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Free Allocation]
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  8016ce:	83 ec 04             	sub    $0x4,%esp
  8016d1:	68 80 28 80 00       	push   $0x802880
  8016d6:	6a 31                	push   $0x31
  8016d8:	68 3a 28 80 00       	push   $0x80283a
  8016dd:	e8 f5 eb ff ff       	call   8002d7 <_panic>

008016e2 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
  8016e5:	57                   	push   %edi
  8016e6:	56                   	push   %esi
  8016e7:	53                   	push   %ebx
  8016e8:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016f4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016f7:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016fa:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016fd:	cd 30                	int    $0x30
  8016ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801702:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801705:	83 c4 10             	add    $0x10,%esp
  801708:	5b                   	pop    %ebx
  801709:	5e                   	pop    %esi
  80170a:	5f                   	pop    %edi
  80170b:	5d                   	pop    %ebp
  80170c:	c3                   	ret    

0080170d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80170d:	55                   	push   %ebp
  80170e:	89 e5                	mov    %esp,%ebp
  801710:	83 ec 04             	sub    $0x4,%esp
  801713:	8b 45 10             	mov    0x10(%ebp),%eax
  801716:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801719:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80171d:	8b 45 08             	mov    0x8(%ebp),%eax
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	52                   	push   %edx
  801725:	ff 75 0c             	pushl  0xc(%ebp)
  801728:	50                   	push   %eax
  801729:	6a 00                	push   $0x0
  80172b:	e8 b2 ff ff ff       	call   8016e2 <syscall>
  801730:	83 c4 18             	add    $0x18,%esp
}
  801733:	90                   	nop
  801734:	c9                   	leave  
  801735:	c3                   	ret    

00801736 <sys_cgetc>:

int
sys_cgetc(void)
{
  801736:	55                   	push   %ebp
  801737:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	6a 01                	push   $0x1
  801745:	e8 98 ff ff ff       	call   8016e2 <syscall>
  80174a:	83 c4 18             	add    $0x18,%esp
}
  80174d:	c9                   	leave  
  80174e:	c3                   	ret    

0080174f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80174f:	55                   	push   %ebp
  801750:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801752:	8b 45 08             	mov    0x8(%ebp),%eax
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	50                   	push   %eax
  80175e:	6a 05                	push   $0x5
  801760:	e8 7d ff ff ff       	call   8016e2 <syscall>
  801765:	83 c4 18             	add    $0x18,%esp
}
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 02                	push   $0x2
  801779:	e8 64 ff ff ff       	call   8016e2 <syscall>
  80177e:	83 c4 18             	add    $0x18,%esp
}
  801781:	c9                   	leave  
  801782:	c3                   	ret    

00801783 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801783:	55                   	push   %ebp
  801784:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 03                	push   $0x3
  801792:	e8 4b ff ff ff       	call   8016e2 <syscall>
  801797:	83 c4 18             	add    $0x18,%esp
}
  80179a:	c9                   	leave  
  80179b:	c3                   	ret    

0080179c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80179c:	55                   	push   %ebp
  80179d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 04                	push   $0x4
  8017ab:	e8 32 ff ff ff       	call   8016e2 <syscall>
  8017b0:	83 c4 18             	add    $0x18,%esp
}
  8017b3:	c9                   	leave  
  8017b4:	c3                   	ret    

008017b5 <sys_env_exit>:


void sys_env_exit(void)
{
  8017b5:	55                   	push   %ebp
  8017b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 06                	push   $0x6
  8017c4:	e8 19 ff ff ff       	call   8016e2 <syscall>
  8017c9:	83 c4 18             	add    $0x18,%esp
}
  8017cc:	90                   	nop
  8017cd:	c9                   	leave  
  8017ce:	c3                   	ret    

008017cf <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017cf:	55                   	push   %ebp
  8017d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	52                   	push   %edx
  8017df:	50                   	push   %eax
  8017e0:	6a 07                	push   $0x7
  8017e2:	e8 fb fe ff ff       	call   8016e2 <syscall>
  8017e7:	83 c4 18             	add    $0x18,%esp
}
  8017ea:	c9                   	leave  
  8017eb:	c3                   	ret    

008017ec <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017ec:	55                   	push   %ebp
  8017ed:	89 e5                	mov    %esp,%ebp
  8017ef:	56                   	push   %esi
  8017f0:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017f1:	8b 75 18             	mov    0x18(%ebp),%esi
  8017f4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801800:	56                   	push   %esi
  801801:	53                   	push   %ebx
  801802:	51                   	push   %ecx
  801803:	52                   	push   %edx
  801804:	50                   	push   %eax
  801805:	6a 08                	push   $0x8
  801807:	e8 d6 fe ff ff       	call   8016e2 <syscall>
  80180c:	83 c4 18             	add    $0x18,%esp
}
  80180f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801812:	5b                   	pop    %ebx
  801813:	5e                   	pop    %esi
  801814:	5d                   	pop    %ebp
  801815:	c3                   	ret    

00801816 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801816:	55                   	push   %ebp
  801817:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801819:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181c:	8b 45 08             	mov    0x8(%ebp),%eax
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	52                   	push   %edx
  801826:	50                   	push   %eax
  801827:	6a 09                	push   $0x9
  801829:	e8 b4 fe ff ff       	call   8016e2 <syscall>
  80182e:	83 c4 18             	add    $0x18,%esp
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	ff 75 0c             	pushl  0xc(%ebp)
  80183f:	ff 75 08             	pushl  0x8(%ebp)
  801842:	6a 0a                	push   $0xa
  801844:	e8 99 fe ff ff       	call   8016e2 <syscall>
  801849:	83 c4 18             	add    $0x18,%esp
}
  80184c:	c9                   	leave  
  80184d:	c3                   	ret    

0080184e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80184e:	55                   	push   %ebp
  80184f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 0b                	push   $0xb
  80185d:	e8 80 fe ff ff       	call   8016e2 <syscall>
  801862:	83 c4 18             	add    $0x18,%esp
}
  801865:	c9                   	leave  
  801866:	c3                   	ret    

00801867 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801867:	55                   	push   %ebp
  801868:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 0c                	push   $0xc
  801876:	e8 67 fe ff ff       	call   8016e2 <syscall>
  80187b:	83 c4 18             	add    $0x18,%esp
}
  80187e:	c9                   	leave  
  80187f:	c3                   	ret    

00801880 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801880:	55                   	push   %ebp
  801881:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 0d                	push   $0xd
  80188f:	e8 4e fe ff ff       	call   8016e2 <syscall>
  801894:	83 c4 18             	add    $0x18,%esp
}
  801897:	c9                   	leave  
  801898:	c3                   	ret    

00801899 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801899:	55                   	push   %ebp
  80189a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	ff 75 0c             	pushl  0xc(%ebp)
  8018a5:	ff 75 08             	pushl  0x8(%ebp)
  8018a8:	6a 11                	push   $0x11
  8018aa:	e8 33 fe ff ff       	call   8016e2 <syscall>
  8018af:	83 c4 18             	add    $0x18,%esp
	return;
  8018b2:	90                   	nop
}
  8018b3:	c9                   	leave  
  8018b4:	c3                   	ret    

008018b5 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018b5:	55                   	push   %ebp
  8018b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	ff 75 0c             	pushl  0xc(%ebp)
  8018c1:	ff 75 08             	pushl  0x8(%ebp)
  8018c4:	6a 12                	push   $0x12
  8018c6:	e8 17 fe ff ff       	call   8016e2 <syscall>
  8018cb:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ce:	90                   	nop
}
  8018cf:	c9                   	leave  
  8018d0:	c3                   	ret    

008018d1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 0e                	push   $0xe
  8018e0:	e8 fd fd ff ff       	call   8016e2 <syscall>
  8018e5:	83 c4 18             	add    $0x18,%esp
}
  8018e8:	c9                   	leave  
  8018e9:	c3                   	ret    

008018ea <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018ea:	55                   	push   %ebp
  8018eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	ff 75 08             	pushl  0x8(%ebp)
  8018f8:	6a 0f                	push   $0xf
  8018fa:	e8 e3 fd ff ff       	call   8016e2 <syscall>
  8018ff:	83 c4 18             	add    $0x18,%esp
}
  801902:	c9                   	leave  
  801903:	c3                   	ret    

00801904 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801904:	55                   	push   %ebp
  801905:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 10                	push   $0x10
  801913:	e8 ca fd ff ff       	call   8016e2 <syscall>
  801918:	83 c4 18             	add    $0x18,%esp
}
  80191b:	90                   	nop
  80191c:	c9                   	leave  
  80191d:	c3                   	ret    

0080191e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80191e:	55                   	push   %ebp
  80191f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 14                	push   $0x14
  80192d:	e8 b0 fd ff ff       	call   8016e2 <syscall>
  801932:	83 c4 18             	add    $0x18,%esp
}
  801935:	90                   	nop
  801936:	c9                   	leave  
  801937:	c3                   	ret    

00801938 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801938:	55                   	push   %ebp
  801939:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 15                	push   $0x15
  801947:	e8 96 fd ff ff       	call   8016e2 <syscall>
  80194c:	83 c4 18             	add    $0x18,%esp
}
  80194f:	90                   	nop
  801950:	c9                   	leave  
  801951:	c3                   	ret    

00801952 <sys_cputc>:


void
sys_cputc(const char c)
{
  801952:	55                   	push   %ebp
  801953:	89 e5                	mov    %esp,%ebp
  801955:	83 ec 04             	sub    $0x4,%esp
  801958:	8b 45 08             	mov    0x8(%ebp),%eax
  80195b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80195e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	50                   	push   %eax
  80196b:	6a 16                	push   $0x16
  80196d:	e8 70 fd ff ff       	call   8016e2 <syscall>
  801972:	83 c4 18             	add    $0x18,%esp
}
  801975:	90                   	nop
  801976:	c9                   	leave  
  801977:	c3                   	ret    

00801978 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801978:	55                   	push   %ebp
  801979:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 17                	push   $0x17
  801987:	e8 56 fd ff ff       	call   8016e2 <syscall>
  80198c:	83 c4 18             	add    $0x18,%esp
}
  80198f:	90                   	nop
  801990:	c9                   	leave  
  801991:	c3                   	ret    

00801992 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801992:	55                   	push   %ebp
  801993:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801995:	8b 45 08             	mov    0x8(%ebp),%eax
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	ff 75 0c             	pushl  0xc(%ebp)
  8019a1:	50                   	push   %eax
  8019a2:	6a 18                	push   $0x18
  8019a4:	e8 39 fd ff ff       	call   8016e2 <syscall>
  8019a9:	83 c4 18             	add    $0x18,%esp
}
  8019ac:	c9                   	leave  
  8019ad:	c3                   	ret    

008019ae <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019ae:	55                   	push   %ebp
  8019af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	52                   	push   %edx
  8019be:	50                   	push   %eax
  8019bf:	6a 1b                	push   $0x1b
  8019c1:	e8 1c fd ff ff       	call   8016e2 <syscall>
  8019c6:	83 c4 18             	add    $0x18,%esp
}
  8019c9:	c9                   	leave  
  8019ca:	c3                   	ret    

008019cb <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019cb:	55                   	push   %ebp
  8019cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	52                   	push   %edx
  8019db:	50                   	push   %eax
  8019dc:	6a 19                	push   $0x19
  8019de:	e8 ff fc ff ff       	call   8016e2 <syscall>
  8019e3:	83 c4 18             	add    $0x18,%esp
}
  8019e6:	90                   	nop
  8019e7:	c9                   	leave  
  8019e8:	c3                   	ret    

008019e9 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019e9:	55                   	push   %ebp
  8019ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	52                   	push   %edx
  8019f9:	50                   	push   %eax
  8019fa:	6a 1a                	push   $0x1a
  8019fc:	e8 e1 fc ff ff       	call   8016e2 <syscall>
  801a01:	83 c4 18             	add    $0x18,%esp
}
  801a04:	90                   	nop
  801a05:	c9                   	leave  
  801a06:	c3                   	ret    

00801a07 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a07:	55                   	push   %ebp
  801a08:	89 e5                	mov    %esp,%ebp
  801a0a:	83 ec 04             	sub    $0x4,%esp
  801a0d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a10:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a13:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a16:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1d:	6a 00                	push   $0x0
  801a1f:	51                   	push   %ecx
  801a20:	52                   	push   %edx
  801a21:	ff 75 0c             	pushl  0xc(%ebp)
  801a24:	50                   	push   %eax
  801a25:	6a 1c                	push   $0x1c
  801a27:	e8 b6 fc ff ff       	call   8016e2 <syscall>
  801a2c:	83 c4 18             	add    $0x18,%esp
}
  801a2f:	c9                   	leave  
  801a30:	c3                   	ret    

00801a31 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a31:	55                   	push   %ebp
  801a32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a37:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	52                   	push   %edx
  801a41:	50                   	push   %eax
  801a42:	6a 1d                	push   $0x1d
  801a44:	e8 99 fc ff ff       	call   8016e2 <syscall>
  801a49:	83 c4 18             	add    $0x18,%esp
}
  801a4c:	c9                   	leave  
  801a4d:	c3                   	ret    

00801a4e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a4e:	55                   	push   %ebp
  801a4f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a51:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a57:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	51                   	push   %ecx
  801a5f:	52                   	push   %edx
  801a60:	50                   	push   %eax
  801a61:	6a 1e                	push   $0x1e
  801a63:	e8 7a fc ff ff       	call   8016e2 <syscall>
  801a68:	83 c4 18             	add    $0x18,%esp
}
  801a6b:	c9                   	leave  
  801a6c:	c3                   	ret    

00801a6d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a6d:	55                   	push   %ebp
  801a6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a70:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a73:	8b 45 08             	mov    0x8(%ebp),%eax
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	52                   	push   %edx
  801a7d:	50                   	push   %eax
  801a7e:	6a 1f                	push   $0x1f
  801a80:	e8 5d fc ff ff       	call   8016e2 <syscall>
  801a85:	83 c4 18             	add    $0x18,%esp
}
  801a88:	c9                   	leave  
  801a89:	c3                   	ret    

00801a8a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a8a:	55                   	push   %ebp
  801a8b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 20                	push   $0x20
  801a99:	e8 44 fc ff ff       	call   8016e2 <syscall>
  801a9e:	83 c4 18             	add    $0x18,%esp
}
  801aa1:	c9                   	leave  
  801aa2:	c3                   	ret    

00801aa3 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801aa3:	55                   	push   %ebp
  801aa4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa9:	6a 00                	push   $0x0
  801aab:	ff 75 14             	pushl  0x14(%ebp)
  801aae:	ff 75 10             	pushl  0x10(%ebp)
  801ab1:	ff 75 0c             	pushl  0xc(%ebp)
  801ab4:	50                   	push   %eax
  801ab5:	6a 21                	push   $0x21
  801ab7:	e8 26 fc ff ff       	call   8016e2 <syscall>
  801abc:	83 c4 18             	add    $0x18,%esp
}
  801abf:	c9                   	leave  
  801ac0:	c3                   	ret    

00801ac1 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801ac1:	55                   	push   %ebp
  801ac2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	50                   	push   %eax
  801ad0:	6a 22                	push   $0x22
  801ad2:	e8 0b fc ff ff       	call   8016e2 <syscall>
  801ad7:	83 c4 18             	add    $0x18,%esp
}
  801ada:	90                   	nop
  801adb:	c9                   	leave  
  801adc:	c3                   	ret    

00801add <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801add:	55                   	push   %ebp
  801ade:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	50                   	push   %eax
  801aec:	6a 23                	push   $0x23
  801aee:	e8 ef fb ff ff       	call   8016e2 <syscall>
  801af3:	83 c4 18             	add    $0x18,%esp
}
  801af6:	90                   	nop
  801af7:	c9                   	leave  
  801af8:	c3                   	ret    

00801af9 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801af9:	55                   	push   %ebp
  801afa:	89 e5                	mov    %esp,%ebp
  801afc:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801aff:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b02:	8d 50 04             	lea    0x4(%eax),%edx
  801b05:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	52                   	push   %edx
  801b0f:	50                   	push   %eax
  801b10:	6a 24                	push   $0x24
  801b12:	e8 cb fb ff ff       	call   8016e2 <syscall>
  801b17:	83 c4 18             	add    $0x18,%esp
	return result;
  801b1a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b1d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b20:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b23:	89 01                	mov    %eax,(%ecx)
  801b25:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b28:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2b:	c9                   	leave  
  801b2c:	c2 04 00             	ret    $0x4

00801b2f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b2f:	55                   	push   %ebp
  801b30:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	ff 75 10             	pushl  0x10(%ebp)
  801b39:	ff 75 0c             	pushl  0xc(%ebp)
  801b3c:	ff 75 08             	pushl  0x8(%ebp)
  801b3f:	6a 13                	push   $0x13
  801b41:	e8 9c fb ff ff       	call   8016e2 <syscall>
  801b46:	83 c4 18             	add    $0x18,%esp
	return ;
  801b49:	90                   	nop
}
  801b4a:	c9                   	leave  
  801b4b:	c3                   	ret    

00801b4c <sys_rcr2>:
uint32 sys_rcr2()
{
  801b4c:	55                   	push   %ebp
  801b4d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	6a 25                	push   $0x25
  801b5b:	e8 82 fb ff ff       	call   8016e2 <syscall>
  801b60:	83 c4 18             	add    $0x18,%esp
}
  801b63:	c9                   	leave  
  801b64:	c3                   	ret    

00801b65 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b65:	55                   	push   %ebp
  801b66:	89 e5                	mov    %esp,%ebp
  801b68:	83 ec 04             	sub    $0x4,%esp
  801b6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b71:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	50                   	push   %eax
  801b7e:	6a 26                	push   $0x26
  801b80:	e8 5d fb ff ff       	call   8016e2 <syscall>
  801b85:	83 c4 18             	add    $0x18,%esp
	return ;
  801b88:	90                   	nop
}
  801b89:	c9                   	leave  
  801b8a:	c3                   	ret    

00801b8b <rsttst>:
void rsttst()
{
  801b8b:	55                   	push   %ebp
  801b8c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	6a 28                	push   $0x28
  801b9a:	e8 43 fb ff ff       	call   8016e2 <syscall>
  801b9f:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba2:	90                   	nop
}
  801ba3:	c9                   	leave  
  801ba4:	c3                   	ret    

00801ba5 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
  801ba8:	83 ec 04             	sub    $0x4,%esp
  801bab:	8b 45 14             	mov    0x14(%ebp),%eax
  801bae:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bb1:	8b 55 18             	mov    0x18(%ebp),%edx
  801bb4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bb8:	52                   	push   %edx
  801bb9:	50                   	push   %eax
  801bba:	ff 75 10             	pushl  0x10(%ebp)
  801bbd:	ff 75 0c             	pushl  0xc(%ebp)
  801bc0:	ff 75 08             	pushl  0x8(%ebp)
  801bc3:	6a 27                	push   $0x27
  801bc5:	e8 18 fb ff ff       	call   8016e2 <syscall>
  801bca:	83 c4 18             	add    $0x18,%esp
	return ;
  801bcd:	90                   	nop
}
  801bce:	c9                   	leave  
  801bcf:	c3                   	ret    

00801bd0 <chktst>:
void chktst(uint32 n)
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	ff 75 08             	pushl  0x8(%ebp)
  801bde:	6a 29                	push   $0x29
  801be0:	e8 fd fa ff ff       	call   8016e2 <syscall>
  801be5:	83 c4 18             	add    $0x18,%esp
	return ;
  801be8:	90                   	nop
}
  801be9:	c9                   	leave  
  801bea:	c3                   	ret    

00801beb <inctst>:

void inctst()
{
  801beb:	55                   	push   %ebp
  801bec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 00                	push   $0x0
  801bf2:	6a 00                	push   $0x0
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 2a                	push   $0x2a
  801bfa:	e8 e3 fa ff ff       	call   8016e2 <syscall>
  801bff:	83 c4 18             	add    $0x18,%esp
	return ;
  801c02:	90                   	nop
}
  801c03:	c9                   	leave  
  801c04:	c3                   	ret    

00801c05 <gettst>:
uint32 gettst()
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 2b                	push   $0x2b
  801c14:	e8 c9 fa ff ff       	call   8016e2 <syscall>
  801c19:	83 c4 18             	add    $0x18,%esp
}
  801c1c:	c9                   	leave  
  801c1d:	c3                   	ret    

00801c1e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c1e:	55                   	push   %ebp
  801c1f:	89 e5                	mov    %esp,%ebp
  801c21:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c24:	6a 00                	push   $0x0
  801c26:	6a 00                	push   $0x0
  801c28:	6a 00                	push   $0x0
  801c2a:	6a 00                	push   $0x0
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 2c                	push   $0x2c
  801c30:	e8 ad fa ff ff       	call   8016e2 <syscall>
  801c35:	83 c4 18             	add    $0x18,%esp
  801c38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c3b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c3f:	75 07                	jne    801c48 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c41:	b8 01 00 00 00       	mov    $0x1,%eax
  801c46:	eb 05                	jmp    801c4d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c48:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c4d:	c9                   	leave  
  801c4e:	c3                   	ret    

00801c4f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c4f:	55                   	push   %ebp
  801c50:	89 e5                	mov    %esp,%ebp
  801c52:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 2c                	push   $0x2c
  801c61:	e8 7c fa ff ff       	call   8016e2 <syscall>
  801c66:	83 c4 18             	add    $0x18,%esp
  801c69:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c6c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c70:	75 07                	jne    801c79 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c72:	b8 01 00 00 00       	mov    $0x1,%eax
  801c77:	eb 05                	jmp    801c7e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c79:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c7e:	c9                   	leave  
  801c7f:	c3                   	ret    

00801c80 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c80:	55                   	push   %ebp
  801c81:	89 e5                	mov    %esp,%ebp
  801c83:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 2c                	push   $0x2c
  801c92:	e8 4b fa ff ff       	call   8016e2 <syscall>
  801c97:	83 c4 18             	add    $0x18,%esp
  801c9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801c9d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ca1:	75 07                	jne    801caa <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ca3:	b8 01 00 00 00       	mov    $0x1,%eax
  801ca8:	eb 05                	jmp    801caf <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801caa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801caf:	c9                   	leave  
  801cb0:	c3                   	ret    

00801cb1 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cb1:	55                   	push   %ebp
  801cb2:	89 e5                	mov    %esp,%ebp
  801cb4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cb7:	6a 00                	push   $0x0
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 2c                	push   $0x2c
  801cc3:	e8 1a fa ff ff       	call   8016e2 <syscall>
  801cc8:	83 c4 18             	add    $0x18,%esp
  801ccb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cce:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cd2:	75 07                	jne    801cdb <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cd4:	b8 01 00 00 00       	mov    $0x1,%eax
  801cd9:	eb 05                	jmp    801ce0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801cdb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ce0:	c9                   	leave  
  801ce1:	c3                   	ret    

00801ce2 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ce2:	55                   	push   %ebp
  801ce3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	ff 75 08             	pushl  0x8(%ebp)
  801cf0:	6a 2d                	push   $0x2d
  801cf2:	e8 eb f9 ff ff       	call   8016e2 <syscall>
  801cf7:	83 c4 18             	add    $0x18,%esp
	return ;
  801cfa:	90                   	nop
}
  801cfb:	c9                   	leave  
  801cfc:	c3                   	ret    

00801cfd <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801cfd:	55                   	push   %ebp
  801cfe:	89 e5                	mov    %esp,%ebp
  801d00:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d01:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d04:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d07:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0d:	6a 00                	push   $0x0
  801d0f:	53                   	push   %ebx
  801d10:	51                   	push   %ecx
  801d11:	52                   	push   %edx
  801d12:	50                   	push   %eax
  801d13:	6a 2e                	push   $0x2e
  801d15:	e8 c8 f9 ff ff       	call   8016e2 <syscall>
  801d1a:	83 c4 18             	add    $0x18,%esp
}
  801d1d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d20:	c9                   	leave  
  801d21:	c3                   	ret    

00801d22 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d22:	55                   	push   %ebp
  801d23:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d25:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d28:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	6a 00                	push   $0x0
  801d31:	52                   	push   %edx
  801d32:	50                   	push   %eax
  801d33:	6a 2f                	push   $0x2f
  801d35:	e8 a8 f9 ff ff       	call   8016e2 <syscall>
  801d3a:	83 c4 18             	add    $0x18,%esp
}
  801d3d:	c9                   	leave  
  801d3e:	c3                   	ret    

00801d3f <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801d3f:	55                   	push   %ebp
  801d40:	89 e5                	mov    %esp,%ebp
  801d42:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801d45:	8b 55 08             	mov    0x8(%ebp),%edx
  801d48:	89 d0                	mov    %edx,%eax
  801d4a:	c1 e0 02             	shl    $0x2,%eax
  801d4d:	01 d0                	add    %edx,%eax
  801d4f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d56:	01 d0                	add    %edx,%eax
  801d58:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d5f:	01 d0                	add    %edx,%eax
  801d61:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d68:	01 d0                	add    %edx,%eax
  801d6a:	c1 e0 04             	shl    $0x4,%eax
  801d6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801d70:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801d77:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801d7a:	83 ec 0c             	sub    $0xc,%esp
  801d7d:	50                   	push   %eax
  801d7e:	e8 76 fd ff ff       	call   801af9 <sys_get_virtual_time>
  801d83:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801d86:	eb 41                	jmp    801dc9 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801d88:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801d8b:	83 ec 0c             	sub    $0xc,%esp
  801d8e:	50                   	push   %eax
  801d8f:	e8 65 fd ff ff       	call   801af9 <sys_get_virtual_time>
  801d94:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801d97:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d9a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d9d:	29 c2                	sub    %eax,%edx
  801d9f:	89 d0                	mov    %edx,%eax
  801da1:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801da4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801da7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801daa:	89 d1                	mov    %edx,%ecx
  801dac:	29 c1                	sub    %eax,%ecx
  801dae:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801db1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801db4:	39 c2                	cmp    %eax,%edx
  801db6:	0f 97 c0             	seta   %al
  801db9:	0f b6 c0             	movzbl %al,%eax
  801dbc:	29 c1                	sub    %eax,%ecx
  801dbe:	89 c8                	mov    %ecx,%eax
  801dc0:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801dc3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801dc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801dc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dcc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801dcf:	72 b7                	jb     801d88 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801dd1:	90                   	nop
  801dd2:	c9                   	leave  
  801dd3:	c3                   	ret    

00801dd4 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801dd4:	55                   	push   %ebp
  801dd5:	89 e5                	mov    %esp,%ebp
  801dd7:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801dda:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801de1:	eb 03                	jmp    801de6 <busy_wait+0x12>
  801de3:	ff 45 fc             	incl   -0x4(%ebp)
  801de6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801de9:	3b 45 08             	cmp    0x8(%ebp),%eax
  801dec:	72 f5                	jb     801de3 <busy_wait+0xf>
	return i;
  801dee:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801df1:	c9                   	leave  
  801df2:	c3                   	ret    
  801df3:	90                   	nop

00801df4 <__udivdi3>:
  801df4:	55                   	push   %ebp
  801df5:	57                   	push   %edi
  801df6:	56                   	push   %esi
  801df7:	53                   	push   %ebx
  801df8:	83 ec 1c             	sub    $0x1c,%esp
  801dfb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801dff:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e03:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e07:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e0b:	89 ca                	mov    %ecx,%edx
  801e0d:	89 f8                	mov    %edi,%eax
  801e0f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e13:	85 f6                	test   %esi,%esi
  801e15:	75 2d                	jne    801e44 <__udivdi3+0x50>
  801e17:	39 cf                	cmp    %ecx,%edi
  801e19:	77 65                	ja     801e80 <__udivdi3+0x8c>
  801e1b:	89 fd                	mov    %edi,%ebp
  801e1d:	85 ff                	test   %edi,%edi
  801e1f:	75 0b                	jne    801e2c <__udivdi3+0x38>
  801e21:	b8 01 00 00 00       	mov    $0x1,%eax
  801e26:	31 d2                	xor    %edx,%edx
  801e28:	f7 f7                	div    %edi
  801e2a:	89 c5                	mov    %eax,%ebp
  801e2c:	31 d2                	xor    %edx,%edx
  801e2e:	89 c8                	mov    %ecx,%eax
  801e30:	f7 f5                	div    %ebp
  801e32:	89 c1                	mov    %eax,%ecx
  801e34:	89 d8                	mov    %ebx,%eax
  801e36:	f7 f5                	div    %ebp
  801e38:	89 cf                	mov    %ecx,%edi
  801e3a:	89 fa                	mov    %edi,%edx
  801e3c:	83 c4 1c             	add    $0x1c,%esp
  801e3f:	5b                   	pop    %ebx
  801e40:	5e                   	pop    %esi
  801e41:	5f                   	pop    %edi
  801e42:	5d                   	pop    %ebp
  801e43:	c3                   	ret    
  801e44:	39 ce                	cmp    %ecx,%esi
  801e46:	77 28                	ja     801e70 <__udivdi3+0x7c>
  801e48:	0f bd fe             	bsr    %esi,%edi
  801e4b:	83 f7 1f             	xor    $0x1f,%edi
  801e4e:	75 40                	jne    801e90 <__udivdi3+0x9c>
  801e50:	39 ce                	cmp    %ecx,%esi
  801e52:	72 0a                	jb     801e5e <__udivdi3+0x6a>
  801e54:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e58:	0f 87 9e 00 00 00    	ja     801efc <__udivdi3+0x108>
  801e5e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e63:	89 fa                	mov    %edi,%edx
  801e65:	83 c4 1c             	add    $0x1c,%esp
  801e68:	5b                   	pop    %ebx
  801e69:	5e                   	pop    %esi
  801e6a:	5f                   	pop    %edi
  801e6b:	5d                   	pop    %ebp
  801e6c:	c3                   	ret    
  801e6d:	8d 76 00             	lea    0x0(%esi),%esi
  801e70:	31 ff                	xor    %edi,%edi
  801e72:	31 c0                	xor    %eax,%eax
  801e74:	89 fa                	mov    %edi,%edx
  801e76:	83 c4 1c             	add    $0x1c,%esp
  801e79:	5b                   	pop    %ebx
  801e7a:	5e                   	pop    %esi
  801e7b:	5f                   	pop    %edi
  801e7c:	5d                   	pop    %ebp
  801e7d:	c3                   	ret    
  801e7e:	66 90                	xchg   %ax,%ax
  801e80:	89 d8                	mov    %ebx,%eax
  801e82:	f7 f7                	div    %edi
  801e84:	31 ff                	xor    %edi,%edi
  801e86:	89 fa                	mov    %edi,%edx
  801e88:	83 c4 1c             	add    $0x1c,%esp
  801e8b:	5b                   	pop    %ebx
  801e8c:	5e                   	pop    %esi
  801e8d:	5f                   	pop    %edi
  801e8e:	5d                   	pop    %ebp
  801e8f:	c3                   	ret    
  801e90:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e95:	89 eb                	mov    %ebp,%ebx
  801e97:	29 fb                	sub    %edi,%ebx
  801e99:	89 f9                	mov    %edi,%ecx
  801e9b:	d3 e6                	shl    %cl,%esi
  801e9d:	89 c5                	mov    %eax,%ebp
  801e9f:	88 d9                	mov    %bl,%cl
  801ea1:	d3 ed                	shr    %cl,%ebp
  801ea3:	89 e9                	mov    %ebp,%ecx
  801ea5:	09 f1                	or     %esi,%ecx
  801ea7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801eab:	89 f9                	mov    %edi,%ecx
  801ead:	d3 e0                	shl    %cl,%eax
  801eaf:	89 c5                	mov    %eax,%ebp
  801eb1:	89 d6                	mov    %edx,%esi
  801eb3:	88 d9                	mov    %bl,%cl
  801eb5:	d3 ee                	shr    %cl,%esi
  801eb7:	89 f9                	mov    %edi,%ecx
  801eb9:	d3 e2                	shl    %cl,%edx
  801ebb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ebf:	88 d9                	mov    %bl,%cl
  801ec1:	d3 e8                	shr    %cl,%eax
  801ec3:	09 c2                	or     %eax,%edx
  801ec5:	89 d0                	mov    %edx,%eax
  801ec7:	89 f2                	mov    %esi,%edx
  801ec9:	f7 74 24 0c          	divl   0xc(%esp)
  801ecd:	89 d6                	mov    %edx,%esi
  801ecf:	89 c3                	mov    %eax,%ebx
  801ed1:	f7 e5                	mul    %ebp
  801ed3:	39 d6                	cmp    %edx,%esi
  801ed5:	72 19                	jb     801ef0 <__udivdi3+0xfc>
  801ed7:	74 0b                	je     801ee4 <__udivdi3+0xf0>
  801ed9:	89 d8                	mov    %ebx,%eax
  801edb:	31 ff                	xor    %edi,%edi
  801edd:	e9 58 ff ff ff       	jmp    801e3a <__udivdi3+0x46>
  801ee2:	66 90                	xchg   %ax,%ax
  801ee4:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ee8:	89 f9                	mov    %edi,%ecx
  801eea:	d3 e2                	shl    %cl,%edx
  801eec:	39 c2                	cmp    %eax,%edx
  801eee:	73 e9                	jae    801ed9 <__udivdi3+0xe5>
  801ef0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ef3:	31 ff                	xor    %edi,%edi
  801ef5:	e9 40 ff ff ff       	jmp    801e3a <__udivdi3+0x46>
  801efa:	66 90                	xchg   %ax,%ax
  801efc:	31 c0                	xor    %eax,%eax
  801efe:	e9 37 ff ff ff       	jmp    801e3a <__udivdi3+0x46>
  801f03:	90                   	nop

00801f04 <__umoddi3>:
  801f04:	55                   	push   %ebp
  801f05:	57                   	push   %edi
  801f06:	56                   	push   %esi
  801f07:	53                   	push   %ebx
  801f08:	83 ec 1c             	sub    $0x1c,%esp
  801f0b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f0f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f13:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f17:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f1b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f1f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f23:	89 f3                	mov    %esi,%ebx
  801f25:	89 fa                	mov    %edi,%edx
  801f27:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f2b:	89 34 24             	mov    %esi,(%esp)
  801f2e:	85 c0                	test   %eax,%eax
  801f30:	75 1a                	jne    801f4c <__umoddi3+0x48>
  801f32:	39 f7                	cmp    %esi,%edi
  801f34:	0f 86 a2 00 00 00    	jbe    801fdc <__umoddi3+0xd8>
  801f3a:	89 c8                	mov    %ecx,%eax
  801f3c:	89 f2                	mov    %esi,%edx
  801f3e:	f7 f7                	div    %edi
  801f40:	89 d0                	mov    %edx,%eax
  801f42:	31 d2                	xor    %edx,%edx
  801f44:	83 c4 1c             	add    $0x1c,%esp
  801f47:	5b                   	pop    %ebx
  801f48:	5e                   	pop    %esi
  801f49:	5f                   	pop    %edi
  801f4a:	5d                   	pop    %ebp
  801f4b:	c3                   	ret    
  801f4c:	39 f0                	cmp    %esi,%eax
  801f4e:	0f 87 ac 00 00 00    	ja     802000 <__umoddi3+0xfc>
  801f54:	0f bd e8             	bsr    %eax,%ebp
  801f57:	83 f5 1f             	xor    $0x1f,%ebp
  801f5a:	0f 84 ac 00 00 00    	je     80200c <__umoddi3+0x108>
  801f60:	bf 20 00 00 00       	mov    $0x20,%edi
  801f65:	29 ef                	sub    %ebp,%edi
  801f67:	89 fe                	mov    %edi,%esi
  801f69:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f6d:	89 e9                	mov    %ebp,%ecx
  801f6f:	d3 e0                	shl    %cl,%eax
  801f71:	89 d7                	mov    %edx,%edi
  801f73:	89 f1                	mov    %esi,%ecx
  801f75:	d3 ef                	shr    %cl,%edi
  801f77:	09 c7                	or     %eax,%edi
  801f79:	89 e9                	mov    %ebp,%ecx
  801f7b:	d3 e2                	shl    %cl,%edx
  801f7d:	89 14 24             	mov    %edx,(%esp)
  801f80:	89 d8                	mov    %ebx,%eax
  801f82:	d3 e0                	shl    %cl,%eax
  801f84:	89 c2                	mov    %eax,%edx
  801f86:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f8a:	d3 e0                	shl    %cl,%eax
  801f8c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f90:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f94:	89 f1                	mov    %esi,%ecx
  801f96:	d3 e8                	shr    %cl,%eax
  801f98:	09 d0                	or     %edx,%eax
  801f9a:	d3 eb                	shr    %cl,%ebx
  801f9c:	89 da                	mov    %ebx,%edx
  801f9e:	f7 f7                	div    %edi
  801fa0:	89 d3                	mov    %edx,%ebx
  801fa2:	f7 24 24             	mull   (%esp)
  801fa5:	89 c6                	mov    %eax,%esi
  801fa7:	89 d1                	mov    %edx,%ecx
  801fa9:	39 d3                	cmp    %edx,%ebx
  801fab:	0f 82 87 00 00 00    	jb     802038 <__umoddi3+0x134>
  801fb1:	0f 84 91 00 00 00    	je     802048 <__umoddi3+0x144>
  801fb7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801fbb:	29 f2                	sub    %esi,%edx
  801fbd:	19 cb                	sbb    %ecx,%ebx
  801fbf:	89 d8                	mov    %ebx,%eax
  801fc1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801fc5:	d3 e0                	shl    %cl,%eax
  801fc7:	89 e9                	mov    %ebp,%ecx
  801fc9:	d3 ea                	shr    %cl,%edx
  801fcb:	09 d0                	or     %edx,%eax
  801fcd:	89 e9                	mov    %ebp,%ecx
  801fcf:	d3 eb                	shr    %cl,%ebx
  801fd1:	89 da                	mov    %ebx,%edx
  801fd3:	83 c4 1c             	add    $0x1c,%esp
  801fd6:	5b                   	pop    %ebx
  801fd7:	5e                   	pop    %esi
  801fd8:	5f                   	pop    %edi
  801fd9:	5d                   	pop    %ebp
  801fda:	c3                   	ret    
  801fdb:	90                   	nop
  801fdc:	89 fd                	mov    %edi,%ebp
  801fde:	85 ff                	test   %edi,%edi
  801fe0:	75 0b                	jne    801fed <__umoddi3+0xe9>
  801fe2:	b8 01 00 00 00       	mov    $0x1,%eax
  801fe7:	31 d2                	xor    %edx,%edx
  801fe9:	f7 f7                	div    %edi
  801feb:	89 c5                	mov    %eax,%ebp
  801fed:	89 f0                	mov    %esi,%eax
  801fef:	31 d2                	xor    %edx,%edx
  801ff1:	f7 f5                	div    %ebp
  801ff3:	89 c8                	mov    %ecx,%eax
  801ff5:	f7 f5                	div    %ebp
  801ff7:	89 d0                	mov    %edx,%eax
  801ff9:	e9 44 ff ff ff       	jmp    801f42 <__umoddi3+0x3e>
  801ffe:	66 90                	xchg   %ax,%ax
  802000:	89 c8                	mov    %ecx,%eax
  802002:	89 f2                	mov    %esi,%edx
  802004:	83 c4 1c             	add    $0x1c,%esp
  802007:	5b                   	pop    %ebx
  802008:	5e                   	pop    %esi
  802009:	5f                   	pop    %edi
  80200a:	5d                   	pop    %ebp
  80200b:	c3                   	ret    
  80200c:	3b 04 24             	cmp    (%esp),%eax
  80200f:	72 06                	jb     802017 <__umoddi3+0x113>
  802011:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802015:	77 0f                	ja     802026 <__umoddi3+0x122>
  802017:	89 f2                	mov    %esi,%edx
  802019:	29 f9                	sub    %edi,%ecx
  80201b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80201f:	89 14 24             	mov    %edx,(%esp)
  802022:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802026:	8b 44 24 04          	mov    0x4(%esp),%eax
  80202a:	8b 14 24             	mov    (%esp),%edx
  80202d:	83 c4 1c             	add    $0x1c,%esp
  802030:	5b                   	pop    %ebx
  802031:	5e                   	pop    %esi
  802032:	5f                   	pop    %edi
  802033:	5d                   	pop    %ebp
  802034:	c3                   	ret    
  802035:	8d 76 00             	lea    0x0(%esi),%esi
  802038:	2b 04 24             	sub    (%esp),%eax
  80203b:	19 fa                	sbb    %edi,%edx
  80203d:	89 d1                	mov    %edx,%ecx
  80203f:	89 c6                	mov    %eax,%esi
  802041:	e9 71 ff ff ff       	jmp    801fb7 <__umoddi3+0xb3>
  802046:	66 90                	xchg   %ax,%ax
  802048:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80204c:	72 ea                	jb     802038 <__umoddi3+0x134>
  80204e:	89 d9                	mov    %ebx,%ecx
  802050:	e9 62 ff ff ff       	jmp    801fb7 <__umoddi3+0xb3>
