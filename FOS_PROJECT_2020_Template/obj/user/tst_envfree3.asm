
obj/user/tst_envfree3:     file format elf32-i386


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
  800031:	e8 5f 01 00 00       	call   800195 <libmain>
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
	// Testing scenario 3: Freeing the allocated shared variables [covers: smalloc (1 env) & sget (multiple envs)]
	// Testing removing the shared variables
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  80003e:	83 ec 04             	sub    $0x4,%esp
  800041:	6a 01                	push   $0x1
  800043:	6a 04                	push   $0x4
  800045:	68 60 20 80 00       	push   $0x802060
  80004a:	e8 89 14 00 00       	call   8014d8 <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*numOfFinished = 0 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	int freeFrames_before = sys_calculate_free_frames() ;
  80005e:	e8 ee 17 00 00       	call   801851 <sys_calculate_free_frames>
  800063:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800066:	e8 69 18 00 00       	call   8018d4 <sys_pf_calculate_allocated_pages>
  80006b:	89 45 ec             	mov    %eax,-0x14(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80006e:	83 ec 08             	sub    $0x8,%esp
  800071:	ff 75 f0             	pushl  -0x10(%ebp)
  800074:	68 70 20 80 00       	push   $0x802070
  800079:	e8 fe 04 00 00       	call   80057c <cprintf>
  80007e:	83 c4 10             	add    $0x10,%esp

	int32 envIdProcessA = sys_create_env("ef_tshr1", 2000,(myEnv->SecondListSize), 50);
  800081:	a1 20 30 80 00       	mov    0x803020,%eax
  800086:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80008c:	6a 32                	push   $0x32
  80008e:	50                   	push   %eax
  80008f:	68 d0 07 00 00       	push   $0x7d0
  800094:	68 a3 20 80 00       	push   $0x8020a3
  800099:	e8 08 1a 00 00       	call   801aa6 <sys_create_env>
  80009e:	83 c4 10             	add    $0x10,%esp
  8000a1:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int32 envIdProcessB = sys_create_env("ef_tshr2", 2000,(myEnv->SecondListSize), 50);
  8000a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a9:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000af:	6a 32                	push   $0x32
  8000b1:	50                   	push   %eax
  8000b2:	68 d0 07 00 00       	push   $0x7d0
  8000b7:	68 ac 20 80 00       	push   $0x8020ac
  8000bc:	e8 e5 19 00 00       	call   801aa6 <sys_create_env>
  8000c1:	83 c4 10             	add    $0x10,%esp
  8000c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	sys_run_env(envIdProcessA);
  8000c7:	83 ec 0c             	sub    $0xc,%esp
  8000ca:	ff 75 e8             	pushl  -0x18(%ebp)
  8000cd:	e8 f2 19 00 00       	call   801ac4 <sys_run_env>
  8000d2:	83 c4 10             	add    $0x10,%esp
	env_sleep(5000) ;
  8000d5:	83 ec 0c             	sub    $0xc,%esp
  8000d8:	68 88 13 00 00       	push   $0x1388
  8000dd:	e8 60 1c 00 00       	call   801d42 <env_sleep>
  8000e2:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000eb:	e8 d4 19 00 00       	call   801ac4 <sys_run_env>
  8000f0:	83 c4 10             	add    $0x10,%esp

	while (*numOfFinished != 2) ;
  8000f3:	90                   	nop
  8000f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000f7:	8b 00                	mov    (%eax),%eax
  8000f9:	83 f8 02             	cmp    $0x2,%eax
  8000fc:	75 f6                	jne    8000f4 <_main+0xbc>
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000fe:	e8 4e 17 00 00       	call   801851 <sys_calculate_free_frames>
  800103:	83 ec 08             	sub    $0x8,%esp
  800106:	50                   	push   %eax
  800107:	68 b8 20 80 00       	push   $0x8020b8
  80010c:	e8 6b 04 00 00       	call   80057c <cprintf>
  800111:	83 c4 10             	add    $0x10,%esp

	sys_free_env(envIdProcessA);
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	ff 75 e8             	pushl  -0x18(%ebp)
  80011a:	e8 c1 19 00 00       	call   801ae0 <sys_free_env>
  80011f:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessB);
  800122:	83 ec 0c             	sub    $0xc,%esp
  800125:	ff 75 e4             	pushl  -0x1c(%ebp)
  800128:	e8 b3 19 00 00       	call   801ae0 <sys_free_env>
  80012d:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  800130:	e8 1c 17 00 00       	call   801851 <sys_calculate_free_frames>
  800135:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  800138:	e8 97 17 00 00       	call   8018d4 <sys_pf_calculate_allocated_pages>
  80013d:	89 45 dc             	mov    %eax,-0x24(%ebp)

	if ((freeFrames_after - freeFrames_before) != 0) {
  800140:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800143:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800146:	74 27                	je     80016f <_main+0x137>
		cprintf("\n---# of free frames after closing running programs not as before running = %d\n",
  800148:	83 ec 08             	sub    $0x8,%esp
  80014b:	ff 75 e0             	pushl  -0x20(%ebp)
  80014e:	68 ec 20 80 00       	push   $0x8020ec
  800153:	e8 24 04 00 00       	call   80057c <cprintf>
  800158:	83 c4 10             	add    $0x10,%esp
				freeFrames_after);
		panic("env_free() does not work correctly... check it again.");
  80015b:	83 ec 04             	sub    $0x4,%esp
  80015e:	68 3c 21 80 00       	push   $0x80213c
  800163:	6a 23                	push   $0x23
  800165:	68 72 21 80 00       	push   $0x802172
  80016a:	e8 6b 01 00 00       	call   8002da <_panic>
	}

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  80016f:	83 ec 08             	sub    $0x8,%esp
  800172:	ff 75 e0             	pushl  -0x20(%ebp)
  800175:	68 88 21 80 00       	push   $0x802188
  80017a:	e8 fd 03 00 00       	call   80057c <cprintf>
  80017f:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 3 for envfree completed successfully.\n");
  800182:	83 ec 0c             	sub    $0xc,%esp
  800185:	68 e8 21 80 00       	push   $0x8021e8
  80018a:	e8 ed 03 00 00       	call   80057c <cprintf>
  80018f:	83 c4 10             	add    $0x10,%esp
	return;
  800192:	90                   	nop
}
  800193:	c9                   	leave  
  800194:	c3                   	ret    

00800195 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800195:	55                   	push   %ebp
  800196:	89 e5                	mov    %esp,%ebp
  800198:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80019b:	e8 e6 15 00 00       	call   801786 <sys_getenvindex>
  8001a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001a6:	89 d0                	mov    %edx,%eax
  8001a8:	c1 e0 03             	shl    $0x3,%eax
  8001ab:	01 d0                	add    %edx,%eax
  8001ad:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001b4:	01 c8                	add    %ecx,%eax
  8001b6:	01 c0                	add    %eax,%eax
  8001b8:	01 d0                	add    %edx,%eax
  8001ba:	01 c0                	add    %eax,%eax
  8001bc:	01 d0                	add    %edx,%eax
  8001be:	89 c2                	mov    %eax,%edx
  8001c0:	c1 e2 05             	shl    $0x5,%edx
  8001c3:	29 c2                	sub    %eax,%edx
  8001c5:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001cc:	89 c2                	mov    %eax,%edx
  8001ce:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001d4:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001de:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001e4:	84 c0                	test   %al,%al
  8001e6:	74 0f                	je     8001f7 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ed:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001f2:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001fb:	7e 0a                	jle    800207 <libmain+0x72>
		binaryname = argv[0];
  8001fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800200:	8b 00                	mov    (%eax),%eax
  800202:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800207:	83 ec 08             	sub    $0x8,%esp
  80020a:	ff 75 0c             	pushl  0xc(%ebp)
  80020d:	ff 75 08             	pushl  0x8(%ebp)
  800210:	e8 23 fe ff ff       	call   800038 <_main>
  800215:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800218:	e8 04 17 00 00       	call   801921 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80021d:	83 ec 0c             	sub    $0xc,%esp
  800220:	68 4c 22 80 00       	push   $0x80224c
  800225:	e8 52 03 00 00       	call   80057c <cprintf>
  80022a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80022d:	a1 20 30 80 00       	mov    0x803020,%eax
  800232:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800238:	a1 20 30 80 00       	mov    0x803020,%eax
  80023d:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	52                   	push   %edx
  800247:	50                   	push   %eax
  800248:	68 74 22 80 00       	push   $0x802274
  80024d:	e8 2a 03 00 00       	call   80057c <cprintf>
  800252:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800255:	a1 20 30 80 00       	mov    0x803020,%eax
  80025a:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800260:	a1 20 30 80 00       	mov    0x803020,%eax
  800265:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80026b:	83 ec 04             	sub    $0x4,%esp
  80026e:	52                   	push   %edx
  80026f:	50                   	push   %eax
  800270:	68 9c 22 80 00       	push   $0x80229c
  800275:	e8 02 03 00 00       	call   80057c <cprintf>
  80027a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80027d:	a1 20 30 80 00       	mov    0x803020,%eax
  800282:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800288:	83 ec 08             	sub    $0x8,%esp
  80028b:	50                   	push   %eax
  80028c:	68 dd 22 80 00       	push   $0x8022dd
  800291:	e8 e6 02 00 00       	call   80057c <cprintf>
  800296:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	68 4c 22 80 00       	push   $0x80224c
  8002a1:	e8 d6 02 00 00       	call   80057c <cprintf>
  8002a6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002a9:	e8 8d 16 00 00       	call   80193b <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002ae:	e8 19 00 00 00       	call   8002cc <exit>
}
  8002b3:	90                   	nop
  8002b4:	c9                   	leave  
  8002b5:	c3                   	ret    

008002b6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002b6:	55                   	push   %ebp
  8002b7:	89 e5                	mov    %esp,%ebp
  8002b9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002bc:	83 ec 0c             	sub    $0xc,%esp
  8002bf:	6a 00                	push   $0x0
  8002c1:	e8 8c 14 00 00       	call   801752 <sys_env_destroy>
  8002c6:	83 c4 10             	add    $0x10,%esp
}
  8002c9:	90                   	nop
  8002ca:	c9                   	leave  
  8002cb:	c3                   	ret    

008002cc <exit>:

void
exit(void)
{
  8002cc:	55                   	push   %ebp
  8002cd:	89 e5                	mov    %esp,%ebp
  8002cf:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002d2:	e8 e1 14 00 00       	call   8017b8 <sys_env_exit>
}
  8002d7:	90                   	nop
  8002d8:	c9                   	leave  
  8002d9:	c3                   	ret    

008002da <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002da:	55                   	push   %ebp
  8002db:	89 e5                	mov    %esp,%ebp
  8002dd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002e0:	8d 45 10             	lea    0x10(%ebp),%eax
  8002e3:	83 c0 04             	add    $0x4,%eax
  8002e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002e9:	a1 18 31 80 00       	mov    0x803118,%eax
  8002ee:	85 c0                	test   %eax,%eax
  8002f0:	74 16                	je     800308 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002f2:	a1 18 31 80 00       	mov    0x803118,%eax
  8002f7:	83 ec 08             	sub    $0x8,%esp
  8002fa:	50                   	push   %eax
  8002fb:	68 f4 22 80 00       	push   $0x8022f4
  800300:	e8 77 02 00 00       	call   80057c <cprintf>
  800305:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800308:	a1 00 30 80 00       	mov    0x803000,%eax
  80030d:	ff 75 0c             	pushl  0xc(%ebp)
  800310:	ff 75 08             	pushl  0x8(%ebp)
  800313:	50                   	push   %eax
  800314:	68 f9 22 80 00       	push   $0x8022f9
  800319:	e8 5e 02 00 00       	call   80057c <cprintf>
  80031e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800321:	8b 45 10             	mov    0x10(%ebp),%eax
  800324:	83 ec 08             	sub    $0x8,%esp
  800327:	ff 75 f4             	pushl  -0xc(%ebp)
  80032a:	50                   	push   %eax
  80032b:	e8 e1 01 00 00       	call   800511 <vcprintf>
  800330:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800333:	83 ec 08             	sub    $0x8,%esp
  800336:	6a 00                	push   $0x0
  800338:	68 15 23 80 00       	push   $0x802315
  80033d:	e8 cf 01 00 00       	call   800511 <vcprintf>
  800342:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800345:	e8 82 ff ff ff       	call   8002cc <exit>

	// should not return here
	while (1) ;
  80034a:	eb fe                	jmp    80034a <_panic+0x70>

0080034c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80034c:	55                   	push   %ebp
  80034d:	89 e5                	mov    %esp,%ebp
  80034f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800352:	a1 20 30 80 00       	mov    0x803020,%eax
  800357:	8b 50 74             	mov    0x74(%eax),%edx
  80035a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80035d:	39 c2                	cmp    %eax,%edx
  80035f:	74 14                	je     800375 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800361:	83 ec 04             	sub    $0x4,%esp
  800364:	68 18 23 80 00       	push   $0x802318
  800369:	6a 26                	push   $0x26
  80036b:	68 64 23 80 00       	push   $0x802364
  800370:	e8 65 ff ff ff       	call   8002da <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800375:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80037c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800383:	e9 b6 00 00 00       	jmp    80043e <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800388:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80038b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800392:	8b 45 08             	mov    0x8(%ebp),%eax
  800395:	01 d0                	add    %edx,%eax
  800397:	8b 00                	mov    (%eax),%eax
  800399:	85 c0                	test   %eax,%eax
  80039b:	75 08                	jne    8003a5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80039d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003a0:	e9 96 00 00 00       	jmp    80043b <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8003a5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003ac:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003b3:	eb 5d                	jmp    800412 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ba:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003c0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003c3:	c1 e2 04             	shl    $0x4,%edx
  8003c6:	01 d0                	add    %edx,%eax
  8003c8:	8a 40 04             	mov    0x4(%eax),%al
  8003cb:	84 c0                	test   %al,%al
  8003cd:	75 40                	jne    80040f <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003da:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003dd:	c1 e2 04             	shl    $0x4,%edx
  8003e0:	01 d0                	add    %edx,%eax
  8003e2:	8b 00                	mov    (%eax),%eax
  8003e4:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003e7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003ea:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003ef:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fe:	01 c8                	add    %ecx,%eax
  800400:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800402:	39 c2                	cmp    %eax,%edx
  800404:	75 09                	jne    80040f <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800406:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80040d:	eb 12                	jmp    800421 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80040f:	ff 45 e8             	incl   -0x18(%ebp)
  800412:	a1 20 30 80 00       	mov    0x803020,%eax
  800417:	8b 50 74             	mov    0x74(%eax),%edx
  80041a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80041d:	39 c2                	cmp    %eax,%edx
  80041f:	77 94                	ja     8003b5 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800421:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800425:	75 14                	jne    80043b <CheckWSWithoutLastIndex+0xef>
			panic(
  800427:	83 ec 04             	sub    $0x4,%esp
  80042a:	68 70 23 80 00       	push   $0x802370
  80042f:	6a 3a                	push   $0x3a
  800431:	68 64 23 80 00       	push   $0x802364
  800436:	e8 9f fe ff ff       	call   8002da <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80043b:	ff 45 f0             	incl   -0x10(%ebp)
  80043e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800441:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800444:	0f 8c 3e ff ff ff    	jl     800388 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80044a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800451:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800458:	eb 20                	jmp    80047a <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80045a:	a1 20 30 80 00       	mov    0x803020,%eax
  80045f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800465:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800468:	c1 e2 04             	shl    $0x4,%edx
  80046b:	01 d0                	add    %edx,%eax
  80046d:	8a 40 04             	mov    0x4(%eax),%al
  800470:	3c 01                	cmp    $0x1,%al
  800472:	75 03                	jne    800477 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800474:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800477:	ff 45 e0             	incl   -0x20(%ebp)
  80047a:	a1 20 30 80 00       	mov    0x803020,%eax
  80047f:	8b 50 74             	mov    0x74(%eax),%edx
  800482:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800485:	39 c2                	cmp    %eax,%edx
  800487:	77 d1                	ja     80045a <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800489:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80048c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80048f:	74 14                	je     8004a5 <CheckWSWithoutLastIndex+0x159>
		panic(
  800491:	83 ec 04             	sub    $0x4,%esp
  800494:	68 c4 23 80 00       	push   $0x8023c4
  800499:	6a 44                	push   $0x44
  80049b:	68 64 23 80 00       	push   $0x802364
  8004a0:	e8 35 fe ff ff       	call   8002da <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004a5:	90                   	nop
  8004a6:	c9                   	leave  
  8004a7:	c3                   	ret    

008004a8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004a8:	55                   	push   %ebp
  8004a9:	89 e5                	mov    %esp,%ebp
  8004ab:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b1:	8b 00                	mov    (%eax),%eax
  8004b3:	8d 48 01             	lea    0x1(%eax),%ecx
  8004b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b9:	89 0a                	mov    %ecx,(%edx)
  8004bb:	8b 55 08             	mov    0x8(%ebp),%edx
  8004be:	88 d1                	mov    %dl,%cl
  8004c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ca:	8b 00                	mov    (%eax),%eax
  8004cc:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004d1:	75 2c                	jne    8004ff <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004d3:	a0 24 30 80 00       	mov    0x803024,%al
  8004d8:	0f b6 c0             	movzbl %al,%eax
  8004db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004de:	8b 12                	mov    (%edx),%edx
  8004e0:	89 d1                	mov    %edx,%ecx
  8004e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004e5:	83 c2 08             	add    $0x8,%edx
  8004e8:	83 ec 04             	sub    $0x4,%esp
  8004eb:	50                   	push   %eax
  8004ec:	51                   	push   %ecx
  8004ed:	52                   	push   %edx
  8004ee:	e8 1d 12 00 00       	call   801710 <sys_cputs>
  8004f3:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800502:	8b 40 04             	mov    0x4(%eax),%eax
  800505:	8d 50 01             	lea    0x1(%eax),%edx
  800508:	8b 45 0c             	mov    0xc(%ebp),%eax
  80050b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80050e:	90                   	nop
  80050f:	c9                   	leave  
  800510:	c3                   	ret    

00800511 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800511:	55                   	push   %ebp
  800512:	89 e5                	mov    %esp,%ebp
  800514:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80051a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800521:	00 00 00 
	b.cnt = 0;
  800524:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80052b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80052e:	ff 75 0c             	pushl  0xc(%ebp)
  800531:	ff 75 08             	pushl  0x8(%ebp)
  800534:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80053a:	50                   	push   %eax
  80053b:	68 a8 04 80 00       	push   $0x8004a8
  800540:	e8 11 02 00 00       	call   800756 <vprintfmt>
  800545:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800548:	a0 24 30 80 00       	mov    0x803024,%al
  80054d:	0f b6 c0             	movzbl %al,%eax
  800550:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800556:	83 ec 04             	sub    $0x4,%esp
  800559:	50                   	push   %eax
  80055a:	52                   	push   %edx
  80055b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800561:	83 c0 08             	add    $0x8,%eax
  800564:	50                   	push   %eax
  800565:	e8 a6 11 00 00       	call   801710 <sys_cputs>
  80056a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80056d:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800574:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80057a:	c9                   	leave  
  80057b:	c3                   	ret    

0080057c <cprintf>:

int cprintf(const char *fmt, ...) {
  80057c:	55                   	push   %ebp
  80057d:	89 e5                	mov    %esp,%ebp
  80057f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800582:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800589:	8d 45 0c             	lea    0xc(%ebp),%eax
  80058c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80058f:	8b 45 08             	mov    0x8(%ebp),%eax
  800592:	83 ec 08             	sub    $0x8,%esp
  800595:	ff 75 f4             	pushl  -0xc(%ebp)
  800598:	50                   	push   %eax
  800599:	e8 73 ff ff ff       	call   800511 <vcprintf>
  80059e:	83 c4 10             	add    $0x10,%esp
  8005a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005a7:	c9                   	leave  
  8005a8:	c3                   	ret    

008005a9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005a9:	55                   	push   %ebp
  8005aa:	89 e5                	mov    %esp,%ebp
  8005ac:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005af:	e8 6d 13 00 00       	call   801921 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005b4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bd:	83 ec 08             	sub    $0x8,%esp
  8005c0:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c3:	50                   	push   %eax
  8005c4:	e8 48 ff ff ff       	call   800511 <vcprintf>
  8005c9:	83 c4 10             	add    $0x10,%esp
  8005cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005cf:	e8 67 13 00 00       	call   80193b <sys_enable_interrupt>
	return cnt;
  8005d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005d7:	c9                   	leave  
  8005d8:	c3                   	ret    

008005d9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005d9:	55                   	push   %ebp
  8005da:	89 e5                	mov    %esp,%ebp
  8005dc:	53                   	push   %ebx
  8005dd:	83 ec 14             	sub    $0x14,%esp
  8005e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8005e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005ec:	8b 45 18             	mov    0x18(%ebp),%eax
  8005ef:	ba 00 00 00 00       	mov    $0x0,%edx
  8005f4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005f7:	77 55                	ja     80064e <printnum+0x75>
  8005f9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005fc:	72 05                	jb     800603 <printnum+0x2a>
  8005fe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800601:	77 4b                	ja     80064e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800603:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800606:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800609:	8b 45 18             	mov    0x18(%ebp),%eax
  80060c:	ba 00 00 00 00       	mov    $0x0,%edx
  800611:	52                   	push   %edx
  800612:	50                   	push   %eax
  800613:	ff 75 f4             	pushl  -0xc(%ebp)
  800616:	ff 75 f0             	pushl  -0x10(%ebp)
  800619:	e8 da 17 00 00       	call   801df8 <__udivdi3>
  80061e:	83 c4 10             	add    $0x10,%esp
  800621:	83 ec 04             	sub    $0x4,%esp
  800624:	ff 75 20             	pushl  0x20(%ebp)
  800627:	53                   	push   %ebx
  800628:	ff 75 18             	pushl  0x18(%ebp)
  80062b:	52                   	push   %edx
  80062c:	50                   	push   %eax
  80062d:	ff 75 0c             	pushl  0xc(%ebp)
  800630:	ff 75 08             	pushl  0x8(%ebp)
  800633:	e8 a1 ff ff ff       	call   8005d9 <printnum>
  800638:	83 c4 20             	add    $0x20,%esp
  80063b:	eb 1a                	jmp    800657 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80063d:	83 ec 08             	sub    $0x8,%esp
  800640:	ff 75 0c             	pushl  0xc(%ebp)
  800643:	ff 75 20             	pushl  0x20(%ebp)
  800646:	8b 45 08             	mov    0x8(%ebp),%eax
  800649:	ff d0                	call   *%eax
  80064b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80064e:	ff 4d 1c             	decl   0x1c(%ebp)
  800651:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800655:	7f e6                	jg     80063d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800657:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80065a:	bb 00 00 00 00       	mov    $0x0,%ebx
  80065f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800662:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800665:	53                   	push   %ebx
  800666:	51                   	push   %ecx
  800667:	52                   	push   %edx
  800668:	50                   	push   %eax
  800669:	e8 9a 18 00 00       	call   801f08 <__umoddi3>
  80066e:	83 c4 10             	add    $0x10,%esp
  800671:	05 34 26 80 00       	add    $0x802634,%eax
  800676:	8a 00                	mov    (%eax),%al
  800678:	0f be c0             	movsbl %al,%eax
  80067b:	83 ec 08             	sub    $0x8,%esp
  80067e:	ff 75 0c             	pushl  0xc(%ebp)
  800681:	50                   	push   %eax
  800682:	8b 45 08             	mov    0x8(%ebp),%eax
  800685:	ff d0                	call   *%eax
  800687:	83 c4 10             	add    $0x10,%esp
}
  80068a:	90                   	nop
  80068b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80068e:	c9                   	leave  
  80068f:	c3                   	ret    

00800690 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800690:	55                   	push   %ebp
  800691:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800693:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800697:	7e 1c                	jle    8006b5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	8b 00                	mov    (%eax),%eax
  80069e:	8d 50 08             	lea    0x8(%eax),%edx
  8006a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a4:	89 10                	mov    %edx,(%eax)
  8006a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a9:	8b 00                	mov    (%eax),%eax
  8006ab:	83 e8 08             	sub    $0x8,%eax
  8006ae:	8b 50 04             	mov    0x4(%eax),%edx
  8006b1:	8b 00                	mov    (%eax),%eax
  8006b3:	eb 40                	jmp    8006f5 <getuint+0x65>
	else if (lflag)
  8006b5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006b9:	74 1e                	je     8006d9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006be:	8b 00                	mov    (%eax),%eax
  8006c0:	8d 50 04             	lea    0x4(%eax),%edx
  8006c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c6:	89 10                	mov    %edx,(%eax)
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	8b 00                	mov    (%eax),%eax
  8006cd:	83 e8 04             	sub    $0x4,%eax
  8006d0:	8b 00                	mov    (%eax),%eax
  8006d2:	ba 00 00 00 00       	mov    $0x0,%edx
  8006d7:	eb 1c                	jmp    8006f5 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dc:	8b 00                	mov    (%eax),%eax
  8006de:	8d 50 04             	lea    0x4(%eax),%edx
  8006e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e4:	89 10                	mov    %edx,(%eax)
  8006e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e9:	8b 00                	mov    (%eax),%eax
  8006eb:	83 e8 04             	sub    $0x4,%eax
  8006ee:	8b 00                	mov    (%eax),%eax
  8006f0:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006f5:	5d                   	pop    %ebp
  8006f6:	c3                   	ret    

008006f7 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006f7:	55                   	push   %ebp
  8006f8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006fa:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006fe:	7e 1c                	jle    80071c <getint+0x25>
		return va_arg(*ap, long long);
  800700:	8b 45 08             	mov    0x8(%ebp),%eax
  800703:	8b 00                	mov    (%eax),%eax
  800705:	8d 50 08             	lea    0x8(%eax),%edx
  800708:	8b 45 08             	mov    0x8(%ebp),%eax
  80070b:	89 10                	mov    %edx,(%eax)
  80070d:	8b 45 08             	mov    0x8(%ebp),%eax
  800710:	8b 00                	mov    (%eax),%eax
  800712:	83 e8 08             	sub    $0x8,%eax
  800715:	8b 50 04             	mov    0x4(%eax),%edx
  800718:	8b 00                	mov    (%eax),%eax
  80071a:	eb 38                	jmp    800754 <getint+0x5d>
	else if (lflag)
  80071c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800720:	74 1a                	je     80073c <getint+0x45>
		return va_arg(*ap, long);
  800722:	8b 45 08             	mov    0x8(%ebp),%eax
  800725:	8b 00                	mov    (%eax),%eax
  800727:	8d 50 04             	lea    0x4(%eax),%edx
  80072a:	8b 45 08             	mov    0x8(%ebp),%eax
  80072d:	89 10                	mov    %edx,(%eax)
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	8b 00                	mov    (%eax),%eax
  800734:	83 e8 04             	sub    $0x4,%eax
  800737:	8b 00                	mov    (%eax),%eax
  800739:	99                   	cltd   
  80073a:	eb 18                	jmp    800754 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80073c:	8b 45 08             	mov    0x8(%ebp),%eax
  80073f:	8b 00                	mov    (%eax),%eax
  800741:	8d 50 04             	lea    0x4(%eax),%edx
  800744:	8b 45 08             	mov    0x8(%ebp),%eax
  800747:	89 10                	mov    %edx,(%eax)
  800749:	8b 45 08             	mov    0x8(%ebp),%eax
  80074c:	8b 00                	mov    (%eax),%eax
  80074e:	83 e8 04             	sub    $0x4,%eax
  800751:	8b 00                	mov    (%eax),%eax
  800753:	99                   	cltd   
}
  800754:	5d                   	pop    %ebp
  800755:	c3                   	ret    

00800756 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800756:	55                   	push   %ebp
  800757:	89 e5                	mov    %esp,%ebp
  800759:	56                   	push   %esi
  80075a:	53                   	push   %ebx
  80075b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80075e:	eb 17                	jmp    800777 <vprintfmt+0x21>
			if (ch == '\0')
  800760:	85 db                	test   %ebx,%ebx
  800762:	0f 84 af 03 00 00    	je     800b17 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800768:	83 ec 08             	sub    $0x8,%esp
  80076b:	ff 75 0c             	pushl  0xc(%ebp)
  80076e:	53                   	push   %ebx
  80076f:	8b 45 08             	mov    0x8(%ebp),%eax
  800772:	ff d0                	call   *%eax
  800774:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800777:	8b 45 10             	mov    0x10(%ebp),%eax
  80077a:	8d 50 01             	lea    0x1(%eax),%edx
  80077d:	89 55 10             	mov    %edx,0x10(%ebp)
  800780:	8a 00                	mov    (%eax),%al
  800782:	0f b6 d8             	movzbl %al,%ebx
  800785:	83 fb 25             	cmp    $0x25,%ebx
  800788:	75 d6                	jne    800760 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80078a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80078e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800795:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80079c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007a3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ad:	8d 50 01             	lea    0x1(%eax),%edx
  8007b0:	89 55 10             	mov    %edx,0x10(%ebp)
  8007b3:	8a 00                	mov    (%eax),%al
  8007b5:	0f b6 d8             	movzbl %al,%ebx
  8007b8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007bb:	83 f8 55             	cmp    $0x55,%eax
  8007be:	0f 87 2b 03 00 00    	ja     800aef <vprintfmt+0x399>
  8007c4:	8b 04 85 58 26 80 00 	mov    0x802658(,%eax,4),%eax
  8007cb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007cd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007d1:	eb d7                	jmp    8007aa <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007d3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007d7:	eb d1                	jmp    8007aa <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007d9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007e0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007e3:	89 d0                	mov    %edx,%eax
  8007e5:	c1 e0 02             	shl    $0x2,%eax
  8007e8:	01 d0                	add    %edx,%eax
  8007ea:	01 c0                	add    %eax,%eax
  8007ec:	01 d8                	add    %ebx,%eax
  8007ee:	83 e8 30             	sub    $0x30,%eax
  8007f1:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f7:	8a 00                	mov    (%eax),%al
  8007f9:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007fc:	83 fb 2f             	cmp    $0x2f,%ebx
  8007ff:	7e 3e                	jle    80083f <vprintfmt+0xe9>
  800801:	83 fb 39             	cmp    $0x39,%ebx
  800804:	7f 39                	jg     80083f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800806:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800809:	eb d5                	jmp    8007e0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80080b:	8b 45 14             	mov    0x14(%ebp),%eax
  80080e:	83 c0 04             	add    $0x4,%eax
  800811:	89 45 14             	mov    %eax,0x14(%ebp)
  800814:	8b 45 14             	mov    0x14(%ebp),%eax
  800817:	83 e8 04             	sub    $0x4,%eax
  80081a:	8b 00                	mov    (%eax),%eax
  80081c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80081f:	eb 1f                	jmp    800840 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800821:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800825:	79 83                	jns    8007aa <vprintfmt+0x54>
				width = 0;
  800827:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80082e:	e9 77 ff ff ff       	jmp    8007aa <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800833:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80083a:	e9 6b ff ff ff       	jmp    8007aa <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80083f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800840:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800844:	0f 89 60 ff ff ff    	jns    8007aa <vprintfmt+0x54>
				width = precision, precision = -1;
  80084a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80084d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800850:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800857:	e9 4e ff ff ff       	jmp    8007aa <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80085c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80085f:	e9 46 ff ff ff       	jmp    8007aa <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800864:	8b 45 14             	mov    0x14(%ebp),%eax
  800867:	83 c0 04             	add    $0x4,%eax
  80086a:	89 45 14             	mov    %eax,0x14(%ebp)
  80086d:	8b 45 14             	mov    0x14(%ebp),%eax
  800870:	83 e8 04             	sub    $0x4,%eax
  800873:	8b 00                	mov    (%eax),%eax
  800875:	83 ec 08             	sub    $0x8,%esp
  800878:	ff 75 0c             	pushl  0xc(%ebp)
  80087b:	50                   	push   %eax
  80087c:	8b 45 08             	mov    0x8(%ebp),%eax
  80087f:	ff d0                	call   *%eax
  800881:	83 c4 10             	add    $0x10,%esp
			break;
  800884:	e9 89 02 00 00       	jmp    800b12 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800889:	8b 45 14             	mov    0x14(%ebp),%eax
  80088c:	83 c0 04             	add    $0x4,%eax
  80088f:	89 45 14             	mov    %eax,0x14(%ebp)
  800892:	8b 45 14             	mov    0x14(%ebp),%eax
  800895:	83 e8 04             	sub    $0x4,%eax
  800898:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80089a:	85 db                	test   %ebx,%ebx
  80089c:	79 02                	jns    8008a0 <vprintfmt+0x14a>
				err = -err;
  80089e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008a0:	83 fb 64             	cmp    $0x64,%ebx
  8008a3:	7f 0b                	jg     8008b0 <vprintfmt+0x15a>
  8008a5:	8b 34 9d a0 24 80 00 	mov    0x8024a0(,%ebx,4),%esi
  8008ac:	85 f6                	test   %esi,%esi
  8008ae:	75 19                	jne    8008c9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008b0:	53                   	push   %ebx
  8008b1:	68 45 26 80 00       	push   $0x802645
  8008b6:	ff 75 0c             	pushl  0xc(%ebp)
  8008b9:	ff 75 08             	pushl  0x8(%ebp)
  8008bc:	e8 5e 02 00 00       	call   800b1f <printfmt>
  8008c1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008c4:	e9 49 02 00 00       	jmp    800b12 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008c9:	56                   	push   %esi
  8008ca:	68 4e 26 80 00       	push   $0x80264e
  8008cf:	ff 75 0c             	pushl  0xc(%ebp)
  8008d2:	ff 75 08             	pushl  0x8(%ebp)
  8008d5:	e8 45 02 00 00       	call   800b1f <printfmt>
  8008da:	83 c4 10             	add    $0x10,%esp
			break;
  8008dd:	e9 30 02 00 00       	jmp    800b12 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e5:	83 c0 04             	add    $0x4,%eax
  8008e8:	89 45 14             	mov    %eax,0x14(%ebp)
  8008eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ee:	83 e8 04             	sub    $0x4,%eax
  8008f1:	8b 30                	mov    (%eax),%esi
  8008f3:	85 f6                	test   %esi,%esi
  8008f5:	75 05                	jne    8008fc <vprintfmt+0x1a6>
				p = "(null)";
  8008f7:	be 51 26 80 00       	mov    $0x802651,%esi
			if (width > 0 && padc != '-')
  8008fc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800900:	7e 6d                	jle    80096f <vprintfmt+0x219>
  800902:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800906:	74 67                	je     80096f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800908:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80090b:	83 ec 08             	sub    $0x8,%esp
  80090e:	50                   	push   %eax
  80090f:	56                   	push   %esi
  800910:	e8 0c 03 00 00       	call   800c21 <strnlen>
  800915:	83 c4 10             	add    $0x10,%esp
  800918:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80091b:	eb 16                	jmp    800933 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80091d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800921:	83 ec 08             	sub    $0x8,%esp
  800924:	ff 75 0c             	pushl  0xc(%ebp)
  800927:	50                   	push   %eax
  800928:	8b 45 08             	mov    0x8(%ebp),%eax
  80092b:	ff d0                	call   *%eax
  80092d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800930:	ff 4d e4             	decl   -0x1c(%ebp)
  800933:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800937:	7f e4                	jg     80091d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800939:	eb 34                	jmp    80096f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80093b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80093f:	74 1c                	je     80095d <vprintfmt+0x207>
  800941:	83 fb 1f             	cmp    $0x1f,%ebx
  800944:	7e 05                	jle    80094b <vprintfmt+0x1f5>
  800946:	83 fb 7e             	cmp    $0x7e,%ebx
  800949:	7e 12                	jle    80095d <vprintfmt+0x207>
					putch('?', putdat);
  80094b:	83 ec 08             	sub    $0x8,%esp
  80094e:	ff 75 0c             	pushl  0xc(%ebp)
  800951:	6a 3f                	push   $0x3f
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	ff d0                	call   *%eax
  800958:	83 c4 10             	add    $0x10,%esp
  80095b:	eb 0f                	jmp    80096c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80095d:	83 ec 08             	sub    $0x8,%esp
  800960:	ff 75 0c             	pushl  0xc(%ebp)
  800963:	53                   	push   %ebx
  800964:	8b 45 08             	mov    0x8(%ebp),%eax
  800967:	ff d0                	call   *%eax
  800969:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80096c:	ff 4d e4             	decl   -0x1c(%ebp)
  80096f:	89 f0                	mov    %esi,%eax
  800971:	8d 70 01             	lea    0x1(%eax),%esi
  800974:	8a 00                	mov    (%eax),%al
  800976:	0f be d8             	movsbl %al,%ebx
  800979:	85 db                	test   %ebx,%ebx
  80097b:	74 24                	je     8009a1 <vprintfmt+0x24b>
  80097d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800981:	78 b8                	js     80093b <vprintfmt+0x1e5>
  800983:	ff 4d e0             	decl   -0x20(%ebp)
  800986:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80098a:	79 af                	jns    80093b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80098c:	eb 13                	jmp    8009a1 <vprintfmt+0x24b>
				putch(' ', putdat);
  80098e:	83 ec 08             	sub    $0x8,%esp
  800991:	ff 75 0c             	pushl  0xc(%ebp)
  800994:	6a 20                	push   $0x20
  800996:	8b 45 08             	mov    0x8(%ebp),%eax
  800999:	ff d0                	call   *%eax
  80099b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80099e:	ff 4d e4             	decl   -0x1c(%ebp)
  8009a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009a5:	7f e7                	jg     80098e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009a7:	e9 66 01 00 00       	jmp    800b12 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009ac:	83 ec 08             	sub    $0x8,%esp
  8009af:	ff 75 e8             	pushl  -0x18(%ebp)
  8009b2:	8d 45 14             	lea    0x14(%ebp),%eax
  8009b5:	50                   	push   %eax
  8009b6:	e8 3c fd ff ff       	call   8006f7 <getint>
  8009bb:	83 c4 10             	add    $0x10,%esp
  8009be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009ca:	85 d2                	test   %edx,%edx
  8009cc:	79 23                	jns    8009f1 <vprintfmt+0x29b>
				putch('-', putdat);
  8009ce:	83 ec 08             	sub    $0x8,%esp
  8009d1:	ff 75 0c             	pushl  0xc(%ebp)
  8009d4:	6a 2d                	push   $0x2d
  8009d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d9:	ff d0                	call   *%eax
  8009db:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009e4:	f7 d8                	neg    %eax
  8009e6:	83 d2 00             	adc    $0x0,%edx
  8009e9:	f7 da                	neg    %edx
  8009eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ee:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009f1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009f8:	e9 bc 00 00 00       	jmp    800ab9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009fd:	83 ec 08             	sub    $0x8,%esp
  800a00:	ff 75 e8             	pushl  -0x18(%ebp)
  800a03:	8d 45 14             	lea    0x14(%ebp),%eax
  800a06:	50                   	push   %eax
  800a07:	e8 84 fc ff ff       	call   800690 <getuint>
  800a0c:	83 c4 10             	add    $0x10,%esp
  800a0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a12:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a15:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a1c:	e9 98 00 00 00       	jmp    800ab9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a21:	83 ec 08             	sub    $0x8,%esp
  800a24:	ff 75 0c             	pushl  0xc(%ebp)
  800a27:	6a 58                	push   $0x58
  800a29:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2c:	ff d0                	call   *%eax
  800a2e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a31:	83 ec 08             	sub    $0x8,%esp
  800a34:	ff 75 0c             	pushl  0xc(%ebp)
  800a37:	6a 58                	push   $0x58
  800a39:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3c:	ff d0                	call   *%eax
  800a3e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a41:	83 ec 08             	sub    $0x8,%esp
  800a44:	ff 75 0c             	pushl  0xc(%ebp)
  800a47:	6a 58                	push   $0x58
  800a49:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4c:	ff d0                	call   *%eax
  800a4e:	83 c4 10             	add    $0x10,%esp
			break;
  800a51:	e9 bc 00 00 00       	jmp    800b12 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a56:	83 ec 08             	sub    $0x8,%esp
  800a59:	ff 75 0c             	pushl  0xc(%ebp)
  800a5c:	6a 30                	push   $0x30
  800a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a61:	ff d0                	call   *%eax
  800a63:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a66:	83 ec 08             	sub    $0x8,%esp
  800a69:	ff 75 0c             	pushl  0xc(%ebp)
  800a6c:	6a 78                	push   $0x78
  800a6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a71:	ff d0                	call   *%eax
  800a73:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a76:	8b 45 14             	mov    0x14(%ebp),%eax
  800a79:	83 c0 04             	add    $0x4,%eax
  800a7c:	89 45 14             	mov    %eax,0x14(%ebp)
  800a7f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a82:	83 e8 04             	sub    $0x4,%eax
  800a85:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a87:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a8a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a91:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a98:	eb 1f                	jmp    800ab9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a9a:	83 ec 08             	sub    $0x8,%esp
  800a9d:	ff 75 e8             	pushl  -0x18(%ebp)
  800aa0:	8d 45 14             	lea    0x14(%ebp),%eax
  800aa3:	50                   	push   %eax
  800aa4:	e8 e7 fb ff ff       	call   800690 <getuint>
  800aa9:	83 c4 10             	add    $0x10,%esp
  800aac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aaf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ab2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ab9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800abd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ac0:	83 ec 04             	sub    $0x4,%esp
  800ac3:	52                   	push   %edx
  800ac4:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ac7:	50                   	push   %eax
  800ac8:	ff 75 f4             	pushl  -0xc(%ebp)
  800acb:	ff 75 f0             	pushl  -0x10(%ebp)
  800ace:	ff 75 0c             	pushl  0xc(%ebp)
  800ad1:	ff 75 08             	pushl  0x8(%ebp)
  800ad4:	e8 00 fb ff ff       	call   8005d9 <printnum>
  800ad9:	83 c4 20             	add    $0x20,%esp
			break;
  800adc:	eb 34                	jmp    800b12 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ade:	83 ec 08             	sub    $0x8,%esp
  800ae1:	ff 75 0c             	pushl  0xc(%ebp)
  800ae4:	53                   	push   %ebx
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	ff d0                	call   *%eax
  800aea:	83 c4 10             	add    $0x10,%esp
			break;
  800aed:	eb 23                	jmp    800b12 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800aef:	83 ec 08             	sub    $0x8,%esp
  800af2:	ff 75 0c             	pushl  0xc(%ebp)
  800af5:	6a 25                	push   $0x25
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	ff d0                	call   *%eax
  800afc:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800aff:	ff 4d 10             	decl   0x10(%ebp)
  800b02:	eb 03                	jmp    800b07 <vprintfmt+0x3b1>
  800b04:	ff 4d 10             	decl   0x10(%ebp)
  800b07:	8b 45 10             	mov    0x10(%ebp),%eax
  800b0a:	48                   	dec    %eax
  800b0b:	8a 00                	mov    (%eax),%al
  800b0d:	3c 25                	cmp    $0x25,%al
  800b0f:	75 f3                	jne    800b04 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b11:	90                   	nop
		}
	}
  800b12:	e9 47 fc ff ff       	jmp    80075e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b17:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b18:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b1b:	5b                   	pop    %ebx
  800b1c:	5e                   	pop    %esi
  800b1d:	5d                   	pop    %ebp
  800b1e:	c3                   	ret    

00800b1f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b1f:	55                   	push   %ebp
  800b20:	89 e5                	mov    %esp,%ebp
  800b22:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b25:	8d 45 10             	lea    0x10(%ebp),%eax
  800b28:	83 c0 04             	add    $0x4,%eax
  800b2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b31:	ff 75 f4             	pushl  -0xc(%ebp)
  800b34:	50                   	push   %eax
  800b35:	ff 75 0c             	pushl  0xc(%ebp)
  800b38:	ff 75 08             	pushl  0x8(%ebp)
  800b3b:	e8 16 fc ff ff       	call   800756 <vprintfmt>
  800b40:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b43:	90                   	nop
  800b44:	c9                   	leave  
  800b45:	c3                   	ret    

00800b46 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b46:	55                   	push   %ebp
  800b47:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4c:	8b 40 08             	mov    0x8(%eax),%eax
  800b4f:	8d 50 01             	lea    0x1(%eax),%edx
  800b52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b55:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5b:	8b 10                	mov    (%eax),%edx
  800b5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b60:	8b 40 04             	mov    0x4(%eax),%eax
  800b63:	39 c2                	cmp    %eax,%edx
  800b65:	73 12                	jae    800b79 <sprintputch+0x33>
		*b->buf++ = ch;
  800b67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6a:	8b 00                	mov    (%eax),%eax
  800b6c:	8d 48 01             	lea    0x1(%eax),%ecx
  800b6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b72:	89 0a                	mov    %ecx,(%edx)
  800b74:	8b 55 08             	mov    0x8(%ebp),%edx
  800b77:	88 10                	mov    %dl,(%eax)
}
  800b79:	90                   	nop
  800b7a:	5d                   	pop    %ebp
  800b7b:	c3                   	ret    

00800b7c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b7c:	55                   	push   %ebp
  800b7d:	89 e5                	mov    %esp,%ebp
  800b7f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
  800b85:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	01 d0                	add    %edx,%eax
  800b93:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b96:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b9d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ba1:	74 06                	je     800ba9 <vsnprintf+0x2d>
  800ba3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ba7:	7f 07                	jg     800bb0 <vsnprintf+0x34>
		return -E_INVAL;
  800ba9:	b8 03 00 00 00       	mov    $0x3,%eax
  800bae:	eb 20                	jmp    800bd0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bb0:	ff 75 14             	pushl  0x14(%ebp)
  800bb3:	ff 75 10             	pushl  0x10(%ebp)
  800bb6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bb9:	50                   	push   %eax
  800bba:	68 46 0b 80 00       	push   $0x800b46
  800bbf:	e8 92 fb ff ff       	call   800756 <vprintfmt>
  800bc4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bc7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bca:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800bd0:	c9                   	leave  
  800bd1:	c3                   	ret    

00800bd2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bd2:	55                   	push   %ebp
  800bd3:	89 e5                	mov    %esp,%ebp
  800bd5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bd8:	8d 45 10             	lea    0x10(%ebp),%eax
  800bdb:	83 c0 04             	add    $0x4,%eax
  800bde:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800be1:	8b 45 10             	mov    0x10(%ebp),%eax
  800be4:	ff 75 f4             	pushl  -0xc(%ebp)
  800be7:	50                   	push   %eax
  800be8:	ff 75 0c             	pushl  0xc(%ebp)
  800beb:	ff 75 08             	pushl  0x8(%ebp)
  800bee:	e8 89 ff ff ff       	call   800b7c <vsnprintf>
  800bf3:	83 c4 10             	add    $0x10,%esp
  800bf6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800bf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bfc:	c9                   	leave  
  800bfd:	c3                   	ret    

00800bfe <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bfe:	55                   	push   %ebp
  800bff:	89 e5                	mov    %esp,%ebp
  800c01:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c0b:	eb 06                	jmp    800c13 <strlen+0x15>
		n++;
  800c0d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c10:	ff 45 08             	incl   0x8(%ebp)
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	8a 00                	mov    (%eax),%al
  800c18:	84 c0                	test   %al,%al
  800c1a:	75 f1                	jne    800c0d <strlen+0xf>
		n++;
	return n;
  800c1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c1f:	c9                   	leave  
  800c20:	c3                   	ret    

00800c21 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c21:	55                   	push   %ebp
  800c22:	89 e5                	mov    %esp,%ebp
  800c24:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c27:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c2e:	eb 09                	jmp    800c39 <strnlen+0x18>
		n++;
  800c30:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c33:	ff 45 08             	incl   0x8(%ebp)
  800c36:	ff 4d 0c             	decl   0xc(%ebp)
  800c39:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c3d:	74 09                	je     800c48 <strnlen+0x27>
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	8a 00                	mov    (%eax),%al
  800c44:	84 c0                	test   %al,%al
  800c46:	75 e8                	jne    800c30 <strnlen+0xf>
		n++;
	return n;
  800c48:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c4b:	c9                   	leave  
  800c4c:	c3                   	ret    

00800c4d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c4d:	55                   	push   %ebp
  800c4e:	89 e5                	mov    %esp,%ebp
  800c50:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
  800c56:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c59:	90                   	nop
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	8d 50 01             	lea    0x1(%eax),%edx
  800c60:	89 55 08             	mov    %edx,0x8(%ebp)
  800c63:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c66:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c69:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c6c:	8a 12                	mov    (%edx),%dl
  800c6e:	88 10                	mov    %dl,(%eax)
  800c70:	8a 00                	mov    (%eax),%al
  800c72:	84 c0                	test   %al,%al
  800c74:	75 e4                	jne    800c5a <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c76:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c79:	c9                   	leave  
  800c7a:	c3                   	ret    

00800c7b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c7b:	55                   	push   %ebp
  800c7c:	89 e5                	mov    %esp,%ebp
  800c7e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c87:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c8e:	eb 1f                	jmp    800caf <strncpy+0x34>
		*dst++ = *src;
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	8d 50 01             	lea    0x1(%eax),%edx
  800c96:	89 55 08             	mov    %edx,0x8(%ebp)
  800c99:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c9c:	8a 12                	mov    (%edx),%dl
  800c9e:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ca0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca3:	8a 00                	mov    (%eax),%al
  800ca5:	84 c0                	test   %al,%al
  800ca7:	74 03                	je     800cac <strncpy+0x31>
			src++;
  800ca9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800cac:	ff 45 fc             	incl   -0x4(%ebp)
  800caf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb2:	3b 45 10             	cmp    0x10(%ebp),%eax
  800cb5:	72 d9                	jb     800c90 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800cb7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800cba:	c9                   	leave  
  800cbb:	c3                   	ret    

00800cbc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800cbc:	55                   	push   %ebp
  800cbd:	89 e5                	mov    %esp,%ebp
  800cbf:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cc8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ccc:	74 30                	je     800cfe <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800cce:	eb 16                	jmp    800ce6 <strlcpy+0x2a>
			*dst++ = *src++;
  800cd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd3:	8d 50 01             	lea    0x1(%eax),%edx
  800cd6:	89 55 08             	mov    %edx,0x8(%ebp)
  800cd9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cdc:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cdf:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ce2:	8a 12                	mov    (%edx),%dl
  800ce4:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ce6:	ff 4d 10             	decl   0x10(%ebp)
  800ce9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ced:	74 09                	je     800cf8 <strlcpy+0x3c>
  800cef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf2:	8a 00                	mov    (%eax),%al
  800cf4:	84 c0                	test   %al,%al
  800cf6:	75 d8                	jne    800cd0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfb:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cfe:	8b 55 08             	mov    0x8(%ebp),%edx
  800d01:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d04:	29 c2                	sub    %eax,%edx
  800d06:	89 d0                	mov    %edx,%eax
}
  800d08:	c9                   	leave  
  800d09:	c3                   	ret    

00800d0a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d0a:	55                   	push   %ebp
  800d0b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d0d:	eb 06                	jmp    800d15 <strcmp+0xb>
		p++, q++;
  800d0f:	ff 45 08             	incl   0x8(%ebp)
  800d12:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d15:	8b 45 08             	mov    0x8(%ebp),%eax
  800d18:	8a 00                	mov    (%eax),%al
  800d1a:	84 c0                	test   %al,%al
  800d1c:	74 0e                	je     800d2c <strcmp+0x22>
  800d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d21:	8a 10                	mov    (%eax),%dl
  800d23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	38 c2                	cmp    %al,%dl
  800d2a:	74 e3                	je     800d0f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	8a 00                	mov    (%eax),%al
  800d31:	0f b6 d0             	movzbl %al,%edx
  800d34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d37:	8a 00                	mov    (%eax),%al
  800d39:	0f b6 c0             	movzbl %al,%eax
  800d3c:	29 c2                	sub    %eax,%edx
  800d3e:	89 d0                	mov    %edx,%eax
}
  800d40:	5d                   	pop    %ebp
  800d41:	c3                   	ret    

00800d42 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d42:	55                   	push   %ebp
  800d43:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d45:	eb 09                	jmp    800d50 <strncmp+0xe>
		n--, p++, q++;
  800d47:	ff 4d 10             	decl   0x10(%ebp)
  800d4a:	ff 45 08             	incl   0x8(%ebp)
  800d4d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d50:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d54:	74 17                	je     800d6d <strncmp+0x2b>
  800d56:	8b 45 08             	mov    0x8(%ebp),%eax
  800d59:	8a 00                	mov    (%eax),%al
  800d5b:	84 c0                	test   %al,%al
  800d5d:	74 0e                	je     800d6d <strncmp+0x2b>
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	8a 10                	mov    (%eax),%dl
  800d64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d67:	8a 00                	mov    (%eax),%al
  800d69:	38 c2                	cmp    %al,%dl
  800d6b:	74 da                	je     800d47 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d6d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d71:	75 07                	jne    800d7a <strncmp+0x38>
		return 0;
  800d73:	b8 00 00 00 00       	mov    $0x0,%eax
  800d78:	eb 14                	jmp    800d8e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	0f b6 d0             	movzbl %al,%edx
  800d82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d85:	8a 00                	mov    (%eax),%al
  800d87:	0f b6 c0             	movzbl %al,%eax
  800d8a:	29 c2                	sub    %eax,%edx
  800d8c:	89 d0                	mov    %edx,%eax
}
  800d8e:	5d                   	pop    %ebp
  800d8f:	c3                   	ret    

00800d90 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d90:	55                   	push   %ebp
  800d91:	89 e5                	mov    %esp,%ebp
  800d93:	83 ec 04             	sub    $0x4,%esp
  800d96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d99:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d9c:	eb 12                	jmp    800db0 <strchr+0x20>
		if (*s == c)
  800d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800da1:	8a 00                	mov    (%eax),%al
  800da3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800da6:	75 05                	jne    800dad <strchr+0x1d>
			return (char *) s;
  800da8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dab:	eb 11                	jmp    800dbe <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dad:	ff 45 08             	incl   0x8(%ebp)
  800db0:	8b 45 08             	mov    0x8(%ebp),%eax
  800db3:	8a 00                	mov    (%eax),%al
  800db5:	84 c0                	test   %al,%al
  800db7:	75 e5                	jne    800d9e <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800db9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800dbe:	c9                   	leave  
  800dbf:	c3                   	ret    

00800dc0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800dc0:	55                   	push   %ebp
  800dc1:	89 e5                	mov    %esp,%ebp
  800dc3:	83 ec 04             	sub    $0x4,%esp
  800dc6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dcc:	eb 0d                	jmp    800ddb <strfind+0x1b>
		if (*s == c)
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	8a 00                	mov    (%eax),%al
  800dd3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dd6:	74 0e                	je     800de6 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800dd8:	ff 45 08             	incl   0x8(%ebp)
  800ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dde:	8a 00                	mov    (%eax),%al
  800de0:	84 c0                	test   %al,%al
  800de2:	75 ea                	jne    800dce <strfind+0xe>
  800de4:	eb 01                	jmp    800de7 <strfind+0x27>
		if (*s == c)
			break;
  800de6:	90                   	nop
	return (char *) s;
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dea:	c9                   	leave  
  800deb:	c3                   	ret    

00800dec <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800dec:	55                   	push   %ebp
  800ded:	89 e5                	mov    %esp,%ebp
  800def:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800df2:	8b 45 08             	mov    0x8(%ebp),%eax
  800df5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800df8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800dfe:	eb 0e                	jmp    800e0e <memset+0x22>
		*p++ = c;
  800e00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e03:	8d 50 01             	lea    0x1(%eax),%edx
  800e06:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e09:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e0c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e0e:	ff 4d f8             	decl   -0x8(%ebp)
  800e11:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e15:	79 e9                	jns    800e00 <memset+0x14>
		*p++ = c;

	return v;
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e1a:	c9                   	leave  
  800e1b:	c3                   	ret    

00800e1c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e1c:	55                   	push   %ebp
  800e1d:	89 e5                	mov    %esp,%ebp
  800e1f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e25:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e2e:	eb 16                	jmp    800e46 <memcpy+0x2a>
		*d++ = *s++;
  800e30:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e33:	8d 50 01             	lea    0x1(%eax),%edx
  800e36:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e39:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e3c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e3f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e42:	8a 12                	mov    (%edx),%dl
  800e44:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e46:	8b 45 10             	mov    0x10(%ebp),%eax
  800e49:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e4c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e4f:	85 c0                	test   %eax,%eax
  800e51:	75 dd                	jne    800e30 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e56:	c9                   	leave  
  800e57:	c3                   	ret    

00800e58 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e58:	55                   	push   %ebp
  800e59:	89 e5                	mov    %esp,%ebp
  800e5b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e61:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e70:	73 50                	jae    800ec2 <memmove+0x6a>
  800e72:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e75:	8b 45 10             	mov    0x10(%ebp),%eax
  800e78:	01 d0                	add    %edx,%eax
  800e7a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e7d:	76 43                	jbe    800ec2 <memmove+0x6a>
		s += n;
  800e7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e82:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e85:	8b 45 10             	mov    0x10(%ebp),%eax
  800e88:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e8b:	eb 10                	jmp    800e9d <memmove+0x45>
			*--d = *--s;
  800e8d:	ff 4d f8             	decl   -0x8(%ebp)
  800e90:	ff 4d fc             	decl   -0x4(%ebp)
  800e93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e96:	8a 10                	mov    (%eax),%dl
  800e98:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9b:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e9d:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ea3:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea6:	85 c0                	test   %eax,%eax
  800ea8:	75 e3                	jne    800e8d <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800eaa:	eb 23                	jmp    800ecf <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800eac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eaf:	8d 50 01             	lea    0x1(%eax),%edx
  800eb2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800eb5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eb8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ebb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ebe:	8a 12                	mov    (%edx),%dl
  800ec0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ec2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec8:	89 55 10             	mov    %edx,0x10(%ebp)
  800ecb:	85 c0                	test   %eax,%eax
  800ecd:	75 dd                	jne    800eac <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ecf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ed2:	c9                   	leave  
  800ed3:	c3                   	ret    

00800ed4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ed4:	55                   	push   %ebp
  800ed5:	89 e5                	mov    %esp,%ebp
  800ed7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ee0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee3:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ee6:	eb 2a                	jmp    800f12 <memcmp+0x3e>
		if (*s1 != *s2)
  800ee8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eeb:	8a 10                	mov    (%eax),%dl
  800eed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	38 c2                	cmp    %al,%dl
  800ef4:	74 16                	je     800f0c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ef6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	0f b6 d0             	movzbl %al,%edx
  800efe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	0f b6 c0             	movzbl %al,%eax
  800f06:	29 c2                	sub    %eax,%edx
  800f08:	89 d0                	mov    %edx,%eax
  800f0a:	eb 18                	jmp    800f24 <memcmp+0x50>
		s1++, s2++;
  800f0c:	ff 45 fc             	incl   -0x4(%ebp)
  800f0f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f12:	8b 45 10             	mov    0x10(%ebp),%eax
  800f15:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f18:	89 55 10             	mov    %edx,0x10(%ebp)
  800f1b:	85 c0                	test   %eax,%eax
  800f1d:	75 c9                	jne    800ee8 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f1f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f24:	c9                   	leave  
  800f25:	c3                   	ret    

00800f26 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f26:	55                   	push   %ebp
  800f27:	89 e5                	mov    %esp,%ebp
  800f29:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f2c:	8b 55 08             	mov    0x8(%ebp),%edx
  800f2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f32:	01 d0                	add    %edx,%eax
  800f34:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f37:	eb 15                	jmp    800f4e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f39:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3c:	8a 00                	mov    (%eax),%al
  800f3e:	0f b6 d0             	movzbl %al,%edx
  800f41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f44:	0f b6 c0             	movzbl %al,%eax
  800f47:	39 c2                	cmp    %eax,%edx
  800f49:	74 0d                	je     800f58 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f4b:	ff 45 08             	incl   0x8(%ebp)
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f54:	72 e3                	jb     800f39 <memfind+0x13>
  800f56:	eb 01                	jmp    800f59 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f58:	90                   	nop
	return (void *) s;
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f5c:	c9                   	leave  
  800f5d:	c3                   	ret    

00800f5e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f5e:	55                   	push   %ebp
  800f5f:	89 e5                	mov    %esp,%ebp
  800f61:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f6b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f72:	eb 03                	jmp    800f77 <strtol+0x19>
		s++;
  800f74:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	3c 20                	cmp    $0x20,%al
  800f7e:	74 f4                	je     800f74 <strtol+0x16>
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	8a 00                	mov    (%eax),%al
  800f85:	3c 09                	cmp    $0x9,%al
  800f87:	74 eb                	je     800f74 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	8a 00                	mov    (%eax),%al
  800f8e:	3c 2b                	cmp    $0x2b,%al
  800f90:	75 05                	jne    800f97 <strtol+0x39>
		s++;
  800f92:	ff 45 08             	incl   0x8(%ebp)
  800f95:	eb 13                	jmp    800faa <strtol+0x4c>
	else if (*s == '-')
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	3c 2d                	cmp    $0x2d,%al
  800f9e:	75 0a                	jne    800faa <strtol+0x4c>
		s++, neg = 1;
  800fa0:	ff 45 08             	incl   0x8(%ebp)
  800fa3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800faa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fae:	74 06                	je     800fb6 <strtol+0x58>
  800fb0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fb4:	75 20                	jne    800fd6 <strtol+0x78>
  800fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb9:	8a 00                	mov    (%eax),%al
  800fbb:	3c 30                	cmp    $0x30,%al
  800fbd:	75 17                	jne    800fd6 <strtol+0x78>
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc2:	40                   	inc    %eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	3c 78                	cmp    $0x78,%al
  800fc7:	75 0d                	jne    800fd6 <strtol+0x78>
		s += 2, base = 16;
  800fc9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fcd:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fd4:	eb 28                	jmp    800ffe <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fd6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fda:	75 15                	jne    800ff1 <strtol+0x93>
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	8a 00                	mov    (%eax),%al
  800fe1:	3c 30                	cmp    $0x30,%al
  800fe3:	75 0c                	jne    800ff1 <strtol+0x93>
		s++, base = 8;
  800fe5:	ff 45 08             	incl   0x8(%ebp)
  800fe8:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fef:	eb 0d                	jmp    800ffe <strtol+0xa0>
	else if (base == 0)
  800ff1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ff5:	75 07                	jne    800ffe <strtol+0xa0>
		base = 10;
  800ff7:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  801001:	8a 00                	mov    (%eax),%al
  801003:	3c 2f                	cmp    $0x2f,%al
  801005:	7e 19                	jle    801020 <strtol+0xc2>
  801007:	8b 45 08             	mov    0x8(%ebp),%eax
  80100a:	8a 00                	mov    (%eax),%al
  80100c:	3c 39                	cmp    $0x39,%al
  80100e:	7f 10                	jg     801020 <strtol+0xc2>
			dig = *s - '0';
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	8a 00                	mov    (%eax),%al
  801015:	0f be c0             	movsbl %al,%eax
  801018:	83 e8 30             	sub    $0x30,%eax
  80101b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80101e:	eb 42                	jmp    801062 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801020:	8b 45 08             	mov    0x8(%ebp),%eax
  801023:	8a 00                	mov    (%eax),%al
  801025:	3c 60                	cmp    $0x60,%al
  801027:	7e 19                	jle    801042 <strtol+0xe4>
  801029:	8b 45 08             	mov    0x8(%ebp),%eax
  80102c:	8a 00                	mov    (%eax),%al
  80102e:	3c 7a                	cmp    $0x7a,%al
  801030:	7f 10                	jg     801042 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	8a 00                	mov    (%eax),%al
  801037:	0f be c0             	movsbl %al,%eax
  80103a:	83 e8 57             	sub    $0x57,%eax
  80103d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801040:	eb 20                	jmp    801062 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	8a 00                	mov    (%eax),%al
  801047:	3c 40                	cmp    $0x40,%al
  801049:	7e 39                	jle    801084 <strtol+0x126>
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	8a 00                	mov    (%eax),%al
  801050:	3c 5a                	cmp    $0x5a,%al
  801052:	7f 30                	jg     801084 <strtol+0x126>
			dig = *s - 'A' + 10;
  801054:	8b 45 08             	mov    0x8(%ebp),%eax
  801057:	8a 00                	mov    (%eax),%al
  801059:	0f be c0             	movsbl %al,%eax
  80105c:	83 e8 37             	sub    $0x37,%eax
  80105f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801062:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801065:	3b 45 10             	cmp    0x10(%ebp),%eax
  801068:	7d 19                	jge    801083 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80106a:	ff 45 08             	incl   0x8(%ebp)
  80106d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801070:	0f af 45 10          	imul   0x10(%ebp),%eax
  801074:	89 c2                	mov    %eax,%edx
  801076:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801079:	01 d0                	add    %edx,%eax
  80107b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80107e:	e9 7b ff ff ff       	jmp    800ffe <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801083:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801084:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801088:	74 08                	je     801092 <strtol+0x134>
		*endptr = (char *) s;
  80108a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108d:	8b 55 08             	mov    0x8(%ebp),%edx
  801090:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801092:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801096:	74 07                	je     80109f <strtol+0x141>
  801098:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109b:	f7 d8                	neg    %eax
  80109d:	eb 03                	jmp    8010a2 <strtol+0x144>
  80109f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <ltostr>:

void
ltostr(long value, char *str)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
  8010a7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010b1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010b8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010bc:	79 13                	jns    8010d1 <ltostr+0x2d>
	{
		neg = 1;
  8010be:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010cb:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010ce:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010d9:	99                   	cltd   
  8010da:	f7 f9                	idiv   %ecx
  8010dc:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e2:	8d 50 01             	lea    0x1(%eax),%edx
  8010e5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010e8:	89 c2                	mov    %eax,%edx
  8010ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ed:	01 d0                	add    %edx,%eax
  8010ef:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010f2:	83 c2 30             	add    $0x30,%edx
  8010f5:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010fa:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010ff:	f7 e9                	imul   %ecx
  801101:	c1 fa 02             	sar    $0x2,%edx
  801104:	89 c8                	mov    %ecx,%eax
  801106:	c1 f8 1f             	sar    $0x1f,%eax
  801109:	29 c2                	sub    %eax,%edx
  80110b:	89 d0                	mov    %edx,%eax
  80110d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801110:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801113:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801118:	f7 e9                	imul   %ecx
  80111a:	c1 fa 02             	sar    $0x2,%edx
  80111d:	89 c8                	mov    %ecx,%eax
  80111f:	c1 f8 1f             	sar    $0x1f,%eax
  801122:	29 c2                	sub    %eax,%edx
  801124:	89 d0                	mov    %edx,%eax
  801126:	c1 e0 02             	shl    $0x2,%eax
  801129:	01 d0                	add    %edx,%eax
  80112b:	01 c0                	add    %eax,%eax
  80112d:	29 c1                	sub    %eax,%ecx
  80112f:	89 ca                	mov    %ecx,%edx
  801131:	85 d2                	test   %edx,%edx
  801133:	75 9c                	jne    8010d1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801135:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80113c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80113f:	48                   	dec    %eax
  801140:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801143:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801147:	74 3d                	je     801186 <ltostr+0xe2>
		start = 1 ;
  801149:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801150:	eb 34                	jmp    801186 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801152:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801155:	8b 45 0c             	mov    0xc(%ebp),%eax
  801158:	01 d0                	add    %edx,%eax
  80115a:	8a 00                	mov    (%eax),%al
  80115c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80115f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801162:	8b 45 0c             	mov    0xc(%ebp),%eax
  801165:	01 c2                	add    %eax,%edx
  801167:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80116a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116d:	01 c8                	add    %ecx,%eax
  80116f:	8a 00                	mov    (%eax),%al
  801171:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801173:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801176:	8b 45 0c             	mov    0xc(%ebp),%eax
  801179:	01 c2                	add    %eax,%edx
  80117b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80117e:	88 02                	mov    %al,(%edx)
		start++ ;
  801180:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801183:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801186:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801189:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80118c:	7c c4                	jl     801152 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80118e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801191:	8b 45 0c             	mov    0xc(%ebp),%eax
  801194:	01 d0                	add    %edx,%eax
  801196:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801199:	90                   	nop
  80119a:	c9                   	leave  
  80119b:	c3                   	ret    

0080119c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80119c:	55                   	push   %ebp
  80119d:	89 e5                	mov    %esp,%ebp
  80119f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011a2:	ff 75 08             	pushl  0x8(%ebp)
  8011a5:	e8 54 fa ff ff       	call   800bfe <strlen>
  8011aa:	83 c4 04             	add    $0x4,%esp
  8011ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011b0:	ff 75 0c             	pushl  0xc(%ebp)
  8011b3:	e8 46 fa ff ff       	call   800bfe <strlen>
  8011b8:	83 c4 04             	add    $0x4,%esp
  8011bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011cc:	eb 17                	jmp    8011e5 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011ce:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d4:	01 c2                	add    %eax,%edx
  8011d6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dc:	01 c8                	add    %ecx,%eax
  8011de:	8a 00                	mov    (%eax),%al
  8011e0:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011e2:	ff 45 fc             	incl   -0x4(%ebp)
  8011e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011e8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011eb:	7c e1                	jl     8011ce <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011ed:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011f4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011fb:	eb 1f                	jmp    80121c <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801200:	8d 50 01             	lea    0x1(%eax),%edx
  801203:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801206:	89 c2                	mov    %eax,%edx
  801208:	8b 45 10             	mov    0x10(%ebp),%eax
  80120b:	01 c2                	add    %eax,%edx
  80120d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801210:	8b 45 0c             	mov    0xc(%ebp),%eax
  801213:	01 c8                	add    %ecx,%eax
  801215:	8a 00                	mov    (%eax),%al
  801217:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801219:	ff 45 f8             	incl   -0x8(%ebp)
  80121c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80121f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801222:	7c d9                	jl     8011fd <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801224:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801227:	8b 45 10             	mov    0x10(%ebp),%eax
  80122a:	01 d0                	add    %edx,%eax
  80122c:	c6 00 00             	movb   $0x0,(%eax)
}
  80122f:	90                   	nop
  801230:	c9                   	leave  
  801231:	c3                   	ret    

00801232 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801232:	55                   	push   %ebp
  801233:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801235:	8b 45 14             	mov    0x14(%ebp),%eax
  801238:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80123e:	8b 45 14             	mov    0x14(%ebp),%eax
  801241:	8b 00                	mov    (%eax),%eax
  801243:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80124a:	8b 45 10             	mov    0x10(%ebp),%eax
  80124d:	01 d0                	add    %edx,%eax
  80124f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801255:	eb 0c                	jmp    801263 <strsplit+0x31>
			*string++ = 0;
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
  80125a:	8d 50 01             	lea    0x1(%eax),%edx
  80125d:	89 55 08             	mov    %edx,0x8(%ebp)
  801260:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	8a 00                	mov    (%eax),%al
  801268:	84 c0                	test   %al,%al
  80126a:	74 18                	je     801284 <strsplit+0x52>
  80126c:	8b 45 08             	mov    0x8(%ebp),%eax
  80126f:	8a 00                	mov    (%eax),%al
  801271:	0f be c0             	movsbl %al,%eax
  801274:	50                   	push   %eax
  801275:	ff 75 0c             	pushl  0xc(%ebp)
  801278:	e8 13 fb ff ff       	call   800d90 <strchr>
  80127d:	83 c4 08             	add    $0x8,%esp
  801280:	85 c0                	test   %eax,%eax
  801282:	75 d3                	jne    801257 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801284:	8b 45 08             	mov    0x8(%ebp),%eax
  801287:	8a 00                	mov    (%eax),%al
  801289:	84 c0                	test   %al,%al
  80128b:	74 5a                	je     8012e7 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80128d:	8b 45 14             	mov    0x14(%ebp),%eax
  801290:	8b 00                	mov    (%eax),%eax
  801292:	83 f8 0f             	cmp    $0xf,%eax
  801295:	75 07                	jne    80129e <strsplit+0x6c>
		{
			return 0;
  801297:	b8 00 00 00 00       	mov    $0x0,%eax
  80129c:	eb 66                	jmp    801304 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80129e:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a1:	8b 00                	mov    (%eax),%eax
  8012a3:	8d 48 01             	lea    0x1(%eax),%ecx
  8012a6:	8b 55 14             	mov    0x14(%ebp),%edx
  8012a9:	89 0a                	mov    %ecx,(%edx)
  8012ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b5:	01 c2                	add    %eax,%edx
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ba:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012bc:	eb 03                	jmp    8012c1 <strsplit+0x8f>
			string++;
  8012be:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	8a 00                	mov    (%eax),%al
  8012c6:	84 c0                	test   %al,%al
  8012c8:	74 8b                	je     801255 <strsplit+0x23>
  8012ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cd:	8a 00                	mov    (%eax),%al
  8012cf:	0f be c0             	movsbl %al,%eax
  8012d2:	50                   	push   %eax
  8012d3:	ff 75 0c             	pushl  0xc(%ebp)
  8012d6:	e8 b5 fa ff ff       	call   800d90 <strchr>
  8012db:	83 c4 08             	add    $0x8,%esp
  8012de:	85 c0                	test   %eax,%eax
  8012e0:	74 dc                	je     8012be <strsplit+0x8c>
			string++;
	}
  8012e2:	e9 6e ff ff ff       	jmp    801255 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012e7:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8012eb:	8b 00                	mov    (%eax),%eax
  8012ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f7:	01 d0                	add    %edx,%eax
  8012f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012ff:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801304:	c9                   	leave  
  801305:	c3                   	ret    

00801306 <malloc>:
//==================================================================================//
int FirstTimeFlag = 1;
int allocated[MAXN];

void* malloc(uint32 size)
{
  801306:	55                   	push   %ebp
  801307:	89 e5                	mov    %esp,%ebp
  801309:	83 ec 28             	sub    $0x28,%esp
	//DON'T CHANGE THIS CODE
	if(FirstTimeFlag)
  80130c:	a1 04 30 80 00       	mov    0x803004,%eax
  801311:	85 c0                	test   %eax,%eax
  801313:	74 0f                	je     801324 <malloc+0x1e>
	{
		initialize_buddy();
  801315:	e8 a4 02 00 00       	call   8015be <initialize_buddy>
		FirstTimeFlag = 0;
  80131a:	c7 05 04 30 80 00 00 	movl   $0x0,0x803004
  801321:	00 00 00 
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
  801324:	81 7d 08 00 08 00 00 	cmpl   $0x800,0x8(%ebp)
  80132b:	0f 86 0b 01 00 00    	jbe    80143c <malloc+0x136>
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
  801331:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801338:	8b 45 08             	mov    0x8(%ebp),%eax
  80133b:	c1 e8 0c             	shr    $0xc,%eax
  80133e:	89 c2                	mov    %eax,%edx
  801340:	8b 45 08             	mov    0x8(%ebp),%eax
  801343:	25 ff 0f 00 00       	and    $0xfff,%eax
  801348:	85 c0                	test   %eax,%eax
  80134a:	74 07                	je     801353 <malloc+0x4d>
  80134c:	b8 01 00 00 00       	mov    $0x1,%eax
  801351:	eb 05                	jmp    801358 <malloc+0x52>
  801353:	b8 00 00 00 00       	mov    $0x0,%eax
  801358:	01 d0                	add    %edx,%eax
  80135a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  80135d:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  801364:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
		for(i = 0; i < MAXN; i++) {
  80136b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801372:	eb 5c                	jmp    8013d0 <malloc+0xca>
			if(allocated[i] != 0) continue;
  801374:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801377:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80137e:	85 c0                	test   %eax,%eax
  801380:	75 4a                	jne    8013cc <malloc+0xc6>
			j = 1;
  801382:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
			i++;
  801389:	ff 45 f4             	incl   -0xc(%ebp)
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  80138c:	eb 06                	jmp    801394 <malloc+0x8e>
				i++;
  80138e:	ff 45 f4             	incl   -0xc(%ebp)
				j++;
  801391:	ff 45 ec             	incl   -0x14(%ebp)
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
			j = 1;
			i++;
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  801394:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801397:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80139c:	77 16                	ja     8013b4 <malloc+0xae>
  80139e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013a1:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8013a8:	85 c0                	test   %eax,%eax
  8013aa:	75 08                	jne    8013b4 <malloc+0xae>
  8013ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013af:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8013b2:	7c da                	jl     80138e <malloc+0x88>
				i++;
				j++;
			}
			if(j == sizeToPage) {
  8013b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013b7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8013ba:	75 0b                	jne    8013c7 <malloc+0xc1>
				indx = i - j;
  8013bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013bf:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8013c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
				break;
  8013c5:	eb 13                	jmp    8013da <malloc+0xd4>
			}
			i--;
  8013c7:	ff 4d f4             	decl   -0xc(%ebp)
  8013ca:	eb 01                	jmp    8013cd <malloc+0xc7>
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
  8013cc:	90                   	nop
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
  8013cd:	ff 45 f4             	incl   -0xc(%ebp)
  8013d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013d3:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8013d8:	76 9a                	jbe    801374 <malloc+0x6e>
				indx = i - j;
				break;
			}
			i--;
		}
		if(indx == -1) {
  8013da:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
  8013de:	75 07                	jne    8013e7 <malloc+0xe1>
			return NULL;
  8013e0:	b8 00 00 00 00       	mov    $0x0,%eax
  8013e5:	eb 5a                	jmp    801441 <malloc+0x13b>
		}
		i = indx;
  8013e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
		while(i < j + indx) {
  8013ed:	eb 13                	jmp    801402 <malloc+0xfc>
			allocated[i++] = j;
  8013ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013f2:	8d 50 01             	lea    0x1(%eax),%edx
  8013f5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8013f8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013fb:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		}
		if(indx == -1) {
			return NULL;
		}
		i = indx;
		while(i < j + indx) {
  801402:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801405:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801408:	01 d0                	add    %edx,%eax
  80140a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80140d:	7f e0                	jg     8013ef <malloc+0xe9>
			allocated[i++] = j;
		}
		uint32 *address = (uint32 *)(USER_HEAP_START + (indx * PAGE_SIZE));
  80140f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801412:	c1 e0 0c             	shl    $0xc,%eax
  801415:	05 00 00 00 80       	add    $0x80000000,%eax
  80141a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		sys_allocateMem(USER_HEAP_START + (indx * PAGE_SIZE), size);
  80141d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801420:	c1 e0 0c             	shl    $0xc,%eax
  801423:	05 00 00 00 80       	add    $0x80000000,%eax
  801428:	83 ec 08             	sub    $0x8,%esp
  80142b:	ff 75 08             	pushl  0x8(%ebp)
  80142e:	50                   	push   %eax
  80142f:	e8 84 04 00 00       	call   8018b8 <sys_allocateMem>
  801434:	83 c4 10             	add    $0x10,%esp
		return address;
  801437:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80143a:	eb 05                	jmp    801441 <malloc+0x13b>
	//1) FIRST FIT strategy (if size > 2 KB)
	//2) Buddy System (if size <= 2 KB)

	//refer to the project presentation and documentation for details

	return NULL;
  80143c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801441:	c9                   	leave  
  801442:	c3                   	ret    

00801443 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801443:	55                   	push   %ebp
  801444:	89 e5                	mov    %esp,%ebp
  801446:	83 ec 18             	sub    $0x18,%esp
	//TODO: [PROJECT 2020 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
  801449:	8b 45 08             	mov    0x8(%ebp),%eax
  80144c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80144f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801452:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801457:	89 45 08             	mov    %eax,0x8(%ebp)
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
  80145a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801461:	8b 45 08             	mov    0x8(%ebp),%eax
  801464:	05 00 00 00 80       	add    $0x80000000,%eax
  801469:	c1 e8 0c             	shr    $0xc,%eax
  80146c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int removable_size = allocated[indx];
  80146f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801472:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801479:	89 45 e8             	mov    %eax,-0x18(%ebp)
	size = allocated[indx];
  80147c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80147f:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801486:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while(size > 0) {
  801489:	eb 17                	jmp    8014a2 <free+0x5f>
		allocated[indx++] = 0;
  80148b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80148e:	8d 50 01             	lea    0x1(%eax),%edx
  801491:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801494:	c7 04 85 20 31 80 00 	movl   $0x0,0x803120(,%eax,4)
  80149b:	00 00 00 00 
		size--;
  80149f:	ff 4d f4             	decl   -0xc(%ebp)
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
	int removable_size = allocated[indx];
	size = allocated[indx];
	while(size > 0) {
  8014a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8014a6:	7f e3                	jg     80148b <free+0x48>
		allocated[indx++] = 0;
		size--;
	}
	sys_freeMem((uint32)virtual_address, removable_size);
  8014a8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	83 ec 08             	sub    $0x8,%esp
  8014b1:	52                   	push   %edx
  8014b2:	50                   	push   %eax
  8014b3:	e8 e4 03 00 00       	call   80189c <sys_freeMem>
  8014b8:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details

}
  8014bb:	90                   	nop
  8014bc:	c9                   	leave  
  8014bd:	c3                   	ret    

008014be <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8014be:	55                   	push   %ebp
  8014bf:	89 e5                	mov    %esp,%ebp
  8014c1:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - BONUS2] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8014c4:	83 ec 04             	sub    $0x4,%esp
  8014c7:	68 b0 27 80 00       	push   $0x8027b0
  8014cc:	6a 7a                	push   $0x7a
  8014ce:	68 d6 27 80 00       	push   $0x8027d6
  8014d3:	e8 02 ee ff ff       	call   8002da <_panic>

008014d8 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8014d8:	55                   	push   %ebp
  8014d9:	89 e5                	mov    %esp,%ebp
  8014db:	83 ec 18             	sub    $0x18,%esp
  8014de:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e1:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8014e4:	83 ec 04             	sub    $0x4,%esp
  8014e7:	68 e4 27 80 00       	push   $0x8027e4
  8014ec:	68 84 00 00 00       	push   $0x84
  8014f1:	68 d6 27 80 00       	push   $0x8027d6
  8014f6:	e8 df ed ff ff       	call   8002da <_panic>

008014fb <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
  8014fe:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801501:	83 ec 04             	sub    $0x4,%esp
  801504:	68 e4 27 80 00       	push   $0x8027e4
  801509:	68 8a 00 00 00       	push   $0x8a
  80150e:	68 d6 27 80 00       	push   $0x8027d6
  801513:	e8 c2 ed ff ff       	call   8002da <_panic>

00801518 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801518:	55                   	push   %ebp
  801519:	89 e5                	mov    %esp,%ebp
  80151b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80151e:	83 ec 04             	sub    $0x4,%esp
  801521:	68 e4 27 80 00       	push   $0x8027e4
  801526:	68 90 00 00 00       	push   $0x90
  80152b:	68 d6 27 80 00       	push   $0x8027d6
  801530:	e8 a5 ed ff ff       	call   8002da <_panic>

00801535 <expand>:
}

void expand(uint32 newSize)
{
  801535:	55                   	push   %ebp
  801536:	89 e5                	mov    %esp,%ebp
  801538:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80153b:	83 ec 04             	sub    $0x4,%esp
  80153e:	68 e4 27 80 00       	push   $0x8027e4
  801543:	68 95 00 00 00       	push   $0x95
  801548:	68 d6 27 80 00       	push   $0x8027d6
  80154d:	e8 88 ed ff ff       	call   8002da <_panic>

00801552 <shrink>:
}
void shrink(uint32 newSize)
{
  801552:	55                   	push   %ebp
  801553:	89 e5                	mov    %esp,%ebp
  801555:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801558:	83 ec 04             	sub    $0x4,%esp
  80155b:	68 e4 27 80 00       	push   $0x8027e4
  801560:	68 99 00 00 00       	push   $0x99
  801565:	68 d6 27 80 00       	push   $0x8027d6
  80156a:	e8 6b ed ff ff       	call   8002da <_panic>

0080156f <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  80156f:	55                   	push   %ebp
  801570:	89 e5                	mov    %esp,%ebp
  801572:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801575:	83 ec 04             	sub    $0x4,%esp
  801578:	68 e4 27 80 00       	push   $0x8027e4
  80157d:	68 9e 00 00 00       	push   $0x9e
  801582:	68 d6 27 80 00       	push   $0x8027d6
  801587:	e8 4e ed ff ff       	call   8002da <_panic>

0080158c <ClearNodeData>:
 * inside the user heap
 */
 
struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  80158c:	55                   	push   %ebp
  80158d:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  80158f:	8b 45 08             	mov    0x8(%ebp),%eax
  801592:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  801596:	8b 45 08             	mov    0x8(%ebp),%eax
  801599:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  80159d:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  8015b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b4:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  8015bb:	90                   	nop
  8015bc:	5d                   	pop    %ebp
  8015bd:	c3                   	ret    

008015be <initialize_buddy>:

void initialize_buddy()
{
  8015be:	55                   	push   %ebp
  8015bf:	89 e5                	mov    %esp,%ebp
  8015c1:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  8015c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015cb:	e9 b7 00 00 00       	jmp    801687 <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  8015d0:	8b 15 04 31 80 00    	mov    0x803104,%edx
  8015d6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015d9:	89 c8                	mov    %ecx,%eax
  8015db:	01 c0                	add    %eax,%eax
  8015dd:	01 c8                	add    %ecx,%eax
  8015df:	c1 e0 03             	shl    $0x3,%eax
  8015e2:	05 20 31 88 00       	add    $0x883120,%eax
  8015e7:	89 10                	mov    %edx,(%eax)
  8015e9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015ec:	89 d0                	mov    %edx,%eax
  8015ee:	01 c0                	add    %eax,%eax
  8015f0:	01 d0                	add    %edx,%eax
  8015f2:	c1 e0 03             	shl    $0x3,%eax
  8015f5:	05 20 31 88 00       	add    $0x883120,%eax
  8015fa:	8b 00                	mov    (%eax),%eax
  8015fc:	85 c0                	test   %eax,%eax
  8015fe:	74 1c                	je     80161c <initialize_buddy+0x5e>
  801600:	8b 15 04 31 80 00    	mov    0x803104,%edx
  801606:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801609:	89 c8                	mov    %ecx,%eax
  80160b:	01 c0                	add    %eax,%eax
  80160d:	01 c8                	add    %ecx,%eax
  80160f:	c1 e0 03             	shl    $0x3,%eax
  801612:	05 20 31 88 00       	add    $0x883120,%eax
  801617:	89 42 04             	mov    %eax,0x4(%edx)
  80161a:	eb 16                	jmp    801632 <initialize_buddy+0x74>
  80161c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80161f:	89 d0                	mov    %edx,%eax
  801621:	01 c0                	add    %eax,%eax
  801623:	01 d0                	add    %edx,%eax
  801625:	c1 e0 03             	shl    $0x3,%eax
  801628:	05 20 31 88 00       	add    $0x883120,%eax
  80162d:	a3 08 31 80 00       	mov    %eax,0x803108
  801632:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801635:	89 d0                	mov    %edx,%eax
  801637:	01 c0                	add    %eax,%eax
  801639:	01 d0                	add    %edx,%eax
  80163b:	c1 e0 03             	shl    $0x3,%eax
  80163e:	05 20 31 88 00       	add    $0x883120,%eax
  801643:	a3 04 31 80 00       	mov    %eax,0x803104
  801648:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80164b:	89 d0                	mov    %edx,%eax
  80164d:	01 c0                	add    %eax,%eax
  80164f:	01 d0                	add    %edx,%eax
  801651:	c1 e0 03             	shl    $0x3,%eax
  801654:	05 24 31 88 00       	add    $0x883124,%eax
  801659:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  80165f:	a1 10 31 80 00       	mov    0x803110,%eax
  801664:	40                   	inc    %eax
  801665:	a3 10 31 80 00       	mov    %eax,0x803110
		ClearNodeData(&(FreeNodes[i]));
  80166a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80166d:	89 d0                	mov    %edx,%eax
  80166f:	01 c0                	add    %eax,%eax
  801671:	01 d0                	add    %edx,%eax
  801673:	c1 e0 03             	shl    $0x3,%eax
  801676:	05 20 31 88 00       	add    $0x883120,%eax
  80167b:	50                   	push   %eax
  80167c:	e8 0b ff ff ff       	call   80158c <ClearNodeData>
  801681:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801684:	ff 45 fc             	incl   -0x4(%ebp)
  801687:	81 7d fc 3f 9c 00 00 	cmpl   $0x9c3f,-0x4(%ebp)
  80168e:	0f 8e 3c ff ff ff    	jle    8015d0 <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  801694:	90                   	nop
  801695:	c9                   	leave  
  801696:	c3                   	ret    

00801697 <CreateNewBuddySpace>:
/*===============================================================*/

//TODO: [PROJECT 2020 - BONUS4] Expand Buddy Free Node List

void CreateNewBuddySpace()
{
  801697:	55                   	push   %ebp
  801698:	89 e5                	mov    %esp,%ebp
  80169a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Create New Buddy Block]
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  80169d:	83 ec 04             	sub    $0x4,%esp
  8016a0:	68 08 28 80 00       	push   $0x802808
  8016a5:	6a 22                	push   $0x22
  8016a7:	68 3a 28 80 00       	push   $0x80283a
  8016ac:	e8 29 ec ff ff       	call   8002da <_panic>

008016b1 <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  8016b1:	55                   	push   %ebp
  8016b2:	89 e5                	mov    %esp,%ebp
  8016b4:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Get Allocation]
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  8016b7:	83 ec 04             	sub    $0x4,%esp
  8016ba:	68 48 28 80 00       	push   $0x802848
  8016bf:	6a 2a                	push   $0x2a
  8016c1:	68 3a 28 80 00       	push   $0x80283a
  8016c6:	e8 0f ec ff ff       	call   8002da <_panic>

008016cb <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  8016cb:	55                   	push   %ebp
  8016cc:	89 e5                	mov    %esp,%ebp
  8016ce:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Free Allocation]
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  8016d1:	83 ec 04             	sub    $0x4,%esp
  8016d4:	68 80 28 80 00       	push   $0x802880
  8016d9:	6a 31                	push   $0x31
  8016db:	68 3a 28 80 00       	push   $0x80283a
  8016e0:	e8 f5 eb ff ff       	call   8002da <_panic>

008016e5 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016e5:	55                   	push   %ebp
  8016e6:	89 e5                	mov    %esp,%ebp
  8016e8:	57                   	push   %edi
  8016e9:	56                   	push   %esi
  8016ea:	53                   	push   %ebx
  8016eb:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016f7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016fa:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016fd:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801700:	cd 30                	int    $0x30
  801702:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801705:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801708:	83 c4 10             	add    $0x10,%esp
  80170b:	5b                   	pop    %ebx
  80170c:	5e                   	pop    %esi
  80170d:	5f                   	pop    %edi
  80170e:	5d                   	pop    %ebp
  80170f:	c3                   	ret    

00801710 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801710:	55                   	push   %ebp
  801711:	89 e5                	mov    %esp,%ebp
  801713:	83 ec 04             	sub    $0x4,%esp
  801716:	8b 45 10             	mov    0x10(%ebp),%eax
  801719:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80171c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801720:	8b 45 08             	mov    0x8(%ebp),%eax
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	52                   	push   %edx
  801728:	ff 75 0c             	pushl  0xc(%ebp)
  80172b:	50                   	push   %eax
  80172c:	6a 00                	push   $0x0
  80172e:	e8 b2 ff ff ff       	call   8016e5 <syscall>
  801733:	83 c4 18             	add    $0x18,%esp
}
  801736:	90                   	nop
  801737:	c9                   	leave  
  801738:	c3                   	ret    

00801739 <sys_cgetc>:

int
sys_cgetc(void)
{
  801739:	55                   	push   %ebp
  80173a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 01                	push   $0x1
  801748:	e8 98 ff ff ff       	call   8016e5 <syscall>
  80174d:	83 c4 18             	add    $0x18,%esp
}
  801750:	c9                   	leave  
  801751:	c3                   	ret    

00801752 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801752:	55                   	push   %ebp
  801753:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801755:	8b 45 08             	mov    0x8(%ebp),%eax
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	50                   	push   %eax
  801761:	6a 05                	push   $0x5
  801763:	e8 7d ff ff ff       	call   8016e5 <syscall>
  801768:	83 c4 18             	add    $0x18,%esp
}
  80176b:	c9                   	leave  
  80176c:	c3                   	ret    

0080176d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80176d:	55                   	push   %ebp
  80176e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 02                	push   $0x2
  80177c:	e8 64 ff ff ff       	call   8016e5 <syscall>
  801781:	83 c4 18             	add    $0x18,%esp
}
  801784:	c9                   	leave  
  801785:	c3                   	ret    

00801786 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801786:	55                   	push   %ebp
  801787:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 03                	push   $0x3
  801795:	e8 4b ff ff ff       	call   8016e5 <syscall>
  80179a:	83 c4 18             	add    $0x18,%esp
}
  80179d:	c9                   	leave  
  80179e:	c3                   	ret    

0080179f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80179f:	55                   	push   %ebp
  8017a0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 04                	push   $0x4
  8017ae:	e8 32 ff ff ff       	call   8016e5 <syscall>
  8017b3:	83 c4 18             	add    $0x18,%esp
}
  8017b6:	c9                   	leave  
  8017b7:	c3                   	ret    

008017b8 <sys_env_exit>:


void sys_env_exit(void)
{
  8017b8:	55                   	push   %ebp
  8017b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 06                	push   $0x6
  8017c7:	e8 19 ff ff ff       	call   8016e5 <syscall>
  8017cc:	83 c4 18             	add    $0x18,%esp
}
  8017cf:	90                   	nop
  8017d0:	c9                   	leave  
  8017d1:	c3                   	ret    

008017d2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017d2:	55                   	push   %ebp
  8017d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	52                   	push   %edx
  8017e2:	50                   	push   %eax
  8017e3:	6a 07                	push   $0x7
  8017e5:	e8 fb fe ff ff       	call   8016e5 <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
  8017f2:	56                   	push   %esi
  8017f3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017f4:	8b 75 18             	mov    0x18(%ebp),%esi
  8017f7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017fa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801800:	8b 45 08             	mov    0x8(%ebp),%eax
  801803:	56                   	push   %esi
  801804:	53                   	push   %ebx
  801805:	51                   	push   %ecx
  801806:	52                   	push   %edx
  801807:	50                   	push   %eax
  801808:	6a 08                	push   $0x8
  80180a:	e8 d6 fe ff ff       	call   8016e5 <syscall>
  80180f:	83 c4 18             	add    $0x18,%esp
}
  801812:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801815:	5b                   	pop    %ebx
  801816:	5e                   	pop    %esi
  801817:	5d                   	pop    %ebp
  801818:	c3                   	ret    

00801819 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801819:	55                   	push   %ebp
  80181a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80181c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181f:	8b 45 08             	mov    0x8(%ebp),%eax
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	52                   	push   %edx
  801829:	50                   	push   %eax
  80182a:	6a 09                	push   $0x9
  80182c:	e8 b4 fe ff ff       	call   8016e5 <syscall>
  801831:	83 c4 18             	add    $0x18,%esp
}
  801834:	c9                   	leave  
  801835:	c3                   	ret    

00801836 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	ff 75 0c             	pushl  0xc(%ebp)
  801842:	ff 75 08             	pushl  0x8(%ebp)
  801845:	6a 0a                	push   $0xa
  801847:	e8 99 fe ff ff       	call   8016e5 <syscall>
  80184c:	83 c4 18             	add    $0x18,%esp
}
  80184f:	c9                   	leave  
  801850:	c3                   	ret    

00801851 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801851:	55                   	push   %ebp
  801852:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 0b                	push   $0xb
  801860:	e8 80 fe ff ff       	call   8016e5 <syscall>
  801865:	83 c4 18             	add    $0x18,%esp
}
  801868:	c9                   	leave  
  801869:	c3                   	ret    

0080186a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80186a:	55                   	push   %ebp
  80186b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 0c                	push   $0xc
  801879:	e8 67 fe ff ff       	call   8016e5 <syscall>
  80187e:	83 c4 18             	add    $0x18,%esp
}
  801881:	c9                   	leave  
  801882:	c3                   	ret    

00801883 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801883:	55                   	push   %ebp
  801884:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 0d                	push   $0xd
  801892:	e8 4e fe ff ff       	call   8016e5 <syscall>
  801897:	83 c4 18             	add    $0x18,%esp
}
  80189a:	c9                   	leave  
  80189b:	c3                   	ret    

0080189c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80189c:	55                   	push   %ebp
  80189d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	ff 75 0c             	pushl  0xc(%ebp)
  8018a8:	ff 75 08             	pushl  0x8(%ebp)
  8018ab:	6a 11                	push   $0x11
  8018ad:	e8 33 fe ff ff       	call   8016e5 <syscall>
  8018b2:	83 c4 18             	add    $0x18,%esp
	return;
  8018b5:	90                   	nop
}
  8018b6:	c9                   	leave  
  8018b7:	c3                   	ret    

008018b8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018b8:	55                   	push   %ebp
  8018b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	ff 75 0c             	pushl  0xc(%ebp)
  8018c4:	ff 75 08             	pushl  0x8(%ebp)
  8018c7:	6a 12                	push   $0x12
  8018c9:	e8 17 fe ff ff       	call   8016e5 <syscall>
  8018ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d1:	90                   	nop
}
  8018d2:	c9                   	leave  
  8018d3:	c3                   	ret    

008018d4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018d4:	55                   	push   %ebp
  8018d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 0e                	push   $0xe
  8018e3:	e8 fd fd ff ff       	call   8016e5 <syscall>
  8018e8:	83 c4 18             	add    $0x18,%esp
}
  8018eb:	c9                   	leave  
  8018ec:	c3                   	ret    

008018ed <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018ed:	55                   	push   %ebp
  8018ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	ff 75 08             	pushl  0x8(%ebp)
  8018fb:	6a 0f                	push   $0xf
  8018fd:	e8 e3 fd ff ff       	call   8016e5 <syscall>
  801902:	83 c4 18             	add    $0x18,%esp
}
  801905:	c9                   	leave  
  801906:	c3                   	ret    

00801907 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801907:	55                   	push   %ebp
  801908:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 10                	push   $0x10
  801916:	e8 ca fd ff ff       	call   8016e5 <syscall>
  80191b:	83 c4 18             	add    $0x18,%esp
}
  80191e:	90                   	nop
  80191f:	c9                   	leave  
  801920:	c3                   	ret    

00801921 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801921:	55                   	push   %ebp
  801922:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 14                	push   $0x14
  801930:	e8 b0 fd ff ff       	call   8016e5 <syscall>
  801935:	83 c4 18             	add    $0x18,%esp
}
  801938:	90                   	nop
  801939:	c9                   	leave  
  80193a:	c3                   	ret    

0080193b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80193b:	55                   	push   %ebp
  80193c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	6a 00                	push   $0x0
  801946:	6a 00                	push   $0x0
  801948:	6a 15                	push   $0x15
  80194a:	e8 96 fd ff ff       	call   8016e5 <syscall>
  80194f:	83 c4 18             	add    $0x18,%esp
}
  801952:	90                   	nop
  801953:	c9                   	leave  
  801954:	c3                   	ret    

00801955 <sys_cputc>:


void
sys_cputc(const char c)
{
  801955:	55                   	push   %ebp
  801956:	89 e5                	mov    %esp,%ebp
  801958:	83 ec 04             	sub    $0x4,%esp
  80195b:	8b 45 08             	mov    0x8(%ebp),%eax
  80195e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801961:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	50                   	push   %eax
  80196e:	6a 16                	push   $0x16
  801970:	e8 70 fd ff ff       	call   8016e5 <syscall>
  801975:	83 c4 18             	add    $0x18,%esp
}
  801978:	90                   	nop
  801979:	c9                   	leave  
  80197a:	c3                   	ret    

0080197b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80197b:	55                   	push   %ebp
  80197c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	6a 17                	push   $0x17
  80198a:	e8 56 fd ff ff       	call   8016e5 <syscall>
  80198f:	83 c4 18             	add    $0x18,%esp
}
  801992:	90                   	nop
  801993:	c9                   	leave  
  801994:	c3                   	ret    

00801995 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801998:	8b 45 08             	mov    0x8(%ebp),%eax
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	ff 75 0c             	pushl  0xc(%ebp)
  8019a4:	50                   	push   %eax
  8019a5:	6a 18                	push   $0x18
  8019a7:	e8 39 fd ff ff       	call   8016e5 <syscall>
  8019ac:	83 c4 18             	add    $0x18,%esp
}
  8019af:	c9                   	leave  
  8019b0:	c3                   	ret    

008019b1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019b1:	55                   	push   %ebp
  8019b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	52                   	push   %edx
  8019c1:	50                   	push   %eax
  8019c2:	6a 1b                	push   $0x1b
  8019c4:	e8 1c fd ff ff       	call   8016e5 <syscall>
  8019c9:	83 c4 18             	add    $0x18,%esp
}
  8019cc:	c9                   	leave  
  8019cd:	c3                   	ret    

008019ce <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019ce:	55                   	push   %ebp
  8019cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	52                   	push   %edx
  8019de:	50                   	push   %eax
  8019df:	6a 19                	push   $0x19
  8019e1:	e8 ff fc ff ff       	call   8016e5 <syscall>
  8019e6:	83 c4 18             	add    $0x18,%esp
}
  8019e9:	90                   	nop
  8019ea:	c9                   	leave  
  8019eb:	c3                   	ret    

008019ec <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	52                   	push   %edx
  8019fc:	50                   	push   %eax
  8019fd:	6a 1a                	push   $0x1a
  8019ff:	e8 e1 fc ff ff       	call   8016e5 <syscall>
  801a04:	83 c4 18             	add    $0x18,%esp
}
  801a07:	90                   	nop
  801a08:	c9                   	leave  
  801a09:	c3                   	ret    

00801a0a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a0a:	55                   	push   %ebp
  801a0b:	89 e5                	mov    %esp,%ebp
  801a0d:	83 ec 04             	sub    $0x4,%esp
  801a10:	8b 45 10             	mov    0x10(%ebp),%eax
  801a13:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a16:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a19:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a20:	6a 00                	push   $0x0
  801a22:	51                   	push   %ecx
  801a23:	52                   	push   %edx
  801a24:	ff 75 0c             	pushl  0xc(%ebp)
  801a27:	50                   	push   %eax
  801a28:	6a 1c                	push   $0x1c
  801a2a:	e8 b6 fc ff ff       	call   8016e5 <syscall>
  801a2f:	83 c4 18             	add    $0x18,%esp
}
  801a32:	c9                   	leave  
  801a33:	c3                   	ret    

00801a34 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a34:	55                   	push   %ebp
  801a35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a37:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	52                   	push   %edx
  801a44:	50                   	push   %eax
  801a45:	6a 1d                	push   $0x1d
  801a47:	e8 99 fc ff ff       	call   8016e5 <syscall>
  801a4c:	83 c4 18             	add    $0x18,%esp
}
  801a4f:	c9                   	leave  
  801a50:	c3                   	ret    

00801a51 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a51:	55                   	push   %ebp
  801a52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a54:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a57:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	51                   	push   %ecx
  801a62:	52                   	push   %edx
  801a63:	50                   	push   %eax
  801a64:	6a 1e                	push   $0x1e
  801a66:	e8 7a fc ff ff       	call   8016e5 <syscall>
  801a6b:	83 c4 18             	add    $0x18,%esp
}
  801a6e:	c9                   	leave  
  801a6f:	c3                   	ret    

00801a70 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a70:	55                   	push   %ebp
  801a71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a73:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a76:	8b 45 08             	mov    0x8(%ebp),%eax
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	52                   	push   %edx
  801a80:	50                   	push   %eax
  801a81:	6a 1f                	push   $0x1f
  801a83:	e8 5d fc ff ff       	call   8016e5 <syscall>
  801a88:	83 c4 18             	add    $0x18,%esp
}
  801a8b:	c9                   	leave  
  801a8c:	c3                   	ret    

00801a8d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a8d:	55                   	push   %ebp
  801a8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 20                	push   $0x20
  801a9c:	e8 44 fc ff ff       	call   8016e5 <syscall>
  801aa1:	83 c4 18             	add    $0x18,%esp
}
  801aa4:	c9                   	leave  
  801aa5:	c3                   	ret    

00801aa6 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801aa6:	55                   	push   %ebp
  801aa7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  801aac:	6a 00                	push   $0x0
  801aae:	ff 75 14             	pushl  0x14(%ebp)
  801ab1:	ff 75 10             	pushl  0x10(%ebp)
  801ab4:	ff 75 0c             	pushl  0xc(%ebp)
  801ab7:	50                   	push   %eax
  801ab8:	6a 21                	push   $0x21
  801aba:	e8 26 fc ff ff       	call   8016e5 <syscall>
  801abf:	83 c4 18             	add    $0x18,%esp
}
  801ac2:	c9                   	leave  
  801ac3:	c3                   	ret    

00801ac4 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801ac4:	55                   	push   %ebp
  801ac5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	50                   	push   %eax
  801ad3:	6a 22                	push   $0x22
  801ad5:	e8 0b fc ff ff       	call   8016e5 <syscall>
  801ada:	83 c4 18             	add    $0x18,%esp
}
  801add:	90                   	nop
  801ade:	c9                   	leave  
  801adf:	c3                   	ret    

00801ae0 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ae0:	55                   	push   %ebp
  801ae1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	50                   	push   %eax
  801aef:	6a 23                	push   $0x23
  801af1:	e8 ef fb ff ff       	call   8016e5 <syscall>
  801af6:	83 c4 18             	add    $0x18,%esp
}
  801af9:	90                   	nop
  801afa:	c9                   	leave  
  801afb:	c3                   	ret    

00801afc <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801afc:	55                   	push   %ebp
  801afd:	89 e5                	mov    %esp,%ebp
  801aff:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b02:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b05:	8d 50 04             	lea    0x4(%eax),%edx
  801b08:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	52                   	push   %edx
  801b12:	50                   	push   %eax
  801b13:	6a 24                	push   $0x24
  801b15:	e8 cb fb ff ff       	call   8016e5 <syscall>
  801b1a:	83 c4 18             	add    $0x18,%esp
	return result;
  801b1d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b20:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b23:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b26:	89 01                	mov    %eax,(%ecx)
  801b28:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2e:	c9                   	leave  
  801b2f:	c2 04 00             	ret    $0x4

00801b32 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b32:	55                   	push   %ebp
  801b33:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b35:	6a 00                	push   $0x0
  801b37:	6a 00                	push   $0x0
  801b39:	ff 75 10             	pushl  0x10(%ebp)
  801b3c:	ff 75 0c             	pushl  0xc(%ebp)
  801b3f:	ff 75 08             	pushl  0x8(%ebp)
  801b42:	6a 13                	push   $0x13
  801b44:	e8 9c fb ff ff       	call   8016e5 <syscall>
  801b49:	83 c4 18             	add    $0x18,%esp
	return ;
  801b4c:	90                   	nop
}
  801b4d:	c9                   	leave  
  801b4e:	c3                   	ret    

00801b4f <sys_rcr2>:
uint32 sys_rcr2()
{
  801b4f:	55                   	push   %ebp
  801b50:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b52:	6a 00                	push   $0x0
  801b54:	6a 00                	push   $0x0
  801b56:	6a 00                	push   $0x0
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 25                	push   $0x25
  801b5e:	e8 82 fb ff ff       	call   8016e5 <syscall>
  801b63:	83 c4 18             	add    $0x18,%esp
}
  801b66:	c9                   	leave  
  801b67:	c3                   	ret    

00801b68 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b68:	55                   	push   %ebp
  801b69:	89 e5                	mov    %esp,%ebp
  801b6b:	83 ec 04             	sub    $0x4,%esp
  801b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b71:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b74:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	50                   	push   %eax
  801b81:	6a 26                	push   $0x26
  801b83:	e8 5d fb ff ff       	call   8016e5 <syscall>
  801b88:	83 c4 18             	add    $0x18,%esp
	return ;
  801b8b:	90                   	nop
}
  801b8c:	c9                   	leave  
  801b8d:	c3                   	ret    

00801b8e <rsttst>:
void rsttst()
{
  801b8e:	55                   	push   %ebp
  801b8f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 28                	push   $0x28
  801b9d:	e8 43 fb ff ff       	call   8016e5 <syscall>
  801ba2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba5:	90                   	nop
}
  801ba6:	c9                   	leave  
  801ba7:	c3                   	ret    

00801ba8 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ba8:	55                   	push   %ebp
  801ba9:	89 e5                	mov    %esp,%ebp
  801bab:	83 ec 04             	sub    $0x4,%esp
  801bae:	8b 45 14             	mov    0x14(%ebp),%eax
  801bb1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bb4:	8b 55 18             	mov    0x18(%ebp),%edx
  801bb7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bbb:	52                   	push   %edx
  801bbc:	50                   	push   %eax
  801bbd:	ff 75 10             	pushl  0x10(%ebp)
  801bc0:	ff 75 0c             	pushl  0xc(%ebp)
  801bc3:	ff 75 08             	pushl  0x8(%ebp)
  801bc6:	6a 27                	push   $0x27
  801bc8:	e8 18 fb ff ff       	call   8016e5 <syscall>
  801bcd:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd0:	90                   	nop
}
  801bd1:	c9                   	leave  
  801bd2:	c3                   	ret    

00801bd3 <chktst>:
void chktst(uint32 n)
{
  801bd3:	55                   	push   %ebp
  801bd4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	ff 75 08             	pushl  0x8(%ebp)
  801be1:	6a 29                	push   $0x29
  801be3:	e8 fd fa ff ff       	call   8016e5 <syscall>
  801be8:	83 c4 18             	add    $0x18,%esp
	return ;
  801beb:	90                   	nop
}
  801bec:	c9                   	leave  
  801bed:	c3                   	ret    

00801bee <inctst>:

void inctst()
{
  801bee:	55                   	push   %ebp
  801bef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 2a                	push   $0x2a
  801bfd:	e8 e3 fa ff ff       	call   8016e5 <syscall>
  801c02:	83 c4 18             	add    $0x18,%esp
	return ;
  801c05:	90                   	nop
}
  801c06:	c9                   	leave  
  801c07:	c3                   	ret    

00801c08 <gettst>:
uint32 gettst()
{
  801c08:	55                   	push   %ebp
  801c09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 2b                	push   $0x2b
  801c17:	e8 c9 fa ff ff       	call   8016e5 <syscall>
  801c1c:	83 c4 18             	add    $0x18,%esp
}
  801c1f:	c9                   	leave  
  801c20:	c3                   	ret    

00801c21 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c21:	55                   	push   %ebp
  801c22:	89 e5                	mov    %esp,%ebp
  801c24:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 2c                	push   $0x2c
  801c33:	e8 ad fa ff ff       	call   8016e5 <syscall>
  801c38:	83 c4 18             	add    $0x18,%esp
  801c3b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c3e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c42:	75 07                	jne    801c4b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c44:	b8 01 00 00 00       	mov    $0x1,%eax
  801c49:	eb 05                	jmp    801c50 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c4b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c50:	c9                   	leave  
  801c51:	c3                   	ret    

00801c52 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c52:	55                   	push   %ebp
  801c53:	89 e5                	mov    %esp,%ebp
  801c55:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 00                	push   $0x0
  801c62:	6a 2c                	push   $0x2c
  801c64:	e8 7c fa ff ff       	call   8016e5 <syscall>
  801c69:	83 c4 18             	add    $0x18,%esp
  801c6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c6f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c73:	75 07                	jne    801c7c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c75:	b8 01 00 00 00       	mov    $0x1,%eax
  801c7a:	eb 05                	jmp    801c81 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c7c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c81:	c9                   	leave  
  801c82:	c3                   	ret    

00801c83 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c83:	55                   	push   %ebp
  801c84:	89 e5                	mov    %esp,%ebp
  801c86:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 2c                	push   $0x2c
  801c95:	e8 4b fa ff ff       	call   8016e5 <syscall>
  801c9a:	83 c4 18             	add    $0x18,%esp
  801c9d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ca0:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ca4:	75 07                	jne    801cad <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ca6:	b8 01 00 00 00       	mov    $0x1,%eax
  801cab:	eb 05                	jmp    801cb2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cad:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cb2:	c9                   	leave  
  801cb3:	c3                   	ret    

00801cb4 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cb4:	55                   	push   %ebp
  801cb5:	89 e5                	mov    %esp,%ebp
  801cb7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 2c                	push   $0x2c
  801cc6:	e8 1a fa ff ff       	call   8016e5 <syscall>
  801ccb:	83 c4 18             	add    $0x18,%esp
  801cce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cd1:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cd5:	75 07                	jne    801cde <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cd7:	b8 01 00 00 00       	mov    $0x1,%eax
  801cdc:	eb 05                	jmp    801ce3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801cde:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ce3:	c9                   	leave  
  801ce4:	c3                   	ret    

00801ce5 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ce5:	55                   	push   %ebp
  801ce6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	ff 75 08             	pushl  0x8(%ebp)
  801cf3:	6a 2d                	push   $0x2d
  801cf5:	e8 eb f9 ff ff       	call   8016e5 <syscall>
  801cfa:	83 c4 18             	add    $0x18,%esp
	return ;
  801cfd:	90                   	nop
}
  801cfe:	c9                   	leave  
  801cff:	c3                   	ret    

00801d00 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d00:	55                   	push   %ebp
  801d01:	89 e5                	mov    %esp,%ebp
  801d03:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d04:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d07:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d10:	6a 00                	push   $0x0
  801d12:	53                   	push   %ebx
  801d13:	51                   	push   %ecx
  801d14:	52                   	push   %edx
  801d15:	50                   	push   %eax
  801d16:	6a 2e                	push   $0x2e
  801d18:	e8 c8 f9 ff ff       	call   8016e5 <syscall>
  801d1d:	83 c4 18             	add    $0x18,%esp
}
  801d20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d23:	c9                   	leave  
  801d24:	c3                   	ret    

00801d25 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d25:	55                   	push   %ebp
  801d26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d28:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 00                	push   $0x0
  801d34:	52                   	push   %edx
  801d35:	50                   	push   %eax
  801d36:	6a 2f                	push   $0x2f
  801d38:	e8 a8 f9 ff ff       	call   8016e5 <syscall>
  801d3d:	83 c4 18             	add    $0x18,%esp
}
  801d40:	c9                   	leave  
  801d41:	c3                   	ret    

00801d42 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801d42:	55                   	push   %ebp
  801d43:	89 e5                	mov    %esp,%ebp
  801d45:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801d48:	8b 55 08             	mov    0x8(%ebp),%edx
  801d4b:	89 d0                	mov    %edx,%eax
  801d4d:	c1 e0 02             	shl    $0x2,%eax
  801d50:	01 d0                	add    %edx,%eax
  801d52:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d59:	01 d0                	add    %edx,%eax
  801d5b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d62:	01 d0                	add    %edx,%eax
  801d64:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d6b:	01 d0                	add    %edx,%eax
  801d6d:	c1 e0 04             	shl    $0x4,%eax
  801d70:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801d73:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801d7a:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801d7d:	83 ec 0c             	sub    $0xc,%esp
  801d80:	50                   	push   %eax
  801d81:	e8 76 fd ff ff       	call   801afc <sys_get_virtual_time>
  801d86:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801d89:	eb 41                	jmp    801dcc <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801d8b:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801d8e:	83 ec 0c             	sub    $0xc,%esp
  801d91:	50                   	push   %eax
  801d92:	e8 65 fd ff ff       	call   801afc <sys_get_virtual_time>
  801d97:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801d9a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d9d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801da0:	29 c2                	sub    %eax,%edx
  801da2:	89 d0                	mov    %edx,%eax
  801da4:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801da7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801daa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801dad:	89 d1                	mov    %edx,%ecx
  801daf:	29 c1                	sub    %eax,%ecx
  801db1:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801db4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801db7:	39 c2                	cmp    %eax,%edx
  801db9:	0f 97 c0             	seta   %al
  801dbc:	0f b6 c0             	movzbl %al,%eax
  801dbf:	29 c1                	sub    %eax,%ecx
  801dc1:	89 c8                	mov    %ecx,%eax
  801dc3:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801dc6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801dc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801dcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dcf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801dd2:	72 b7                	jb     801d8b <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801dd4:	90                   	nop
  801dd5:	c9                   	leave  
  801dd6:	c3                   	ret    

00801dd7 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801dd7:	55                   	push   %ebp
  801dd8:	89 e5                	mov    %esp,%ebp
  801dda:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801ddd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801de4:	eb 03                	jmp    801de9 <busy_wait+0x12>
  801de6:	ff 45 fc             	incl   -0x4(%ebp)
  801de9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801dec:	3b 45 08             	cmp    0x8(%ebp),%eax
  801def:	72 f5                	jb     801de6 <busy_wait+0xf>
	return i;
  801df1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801df4:	c9                   	leave  
  801df5:	c3                   	ret    
  801df6:	66 90                	xchg   %ax,%ax

00801df8 <__udivdi3>:
  801df8:	55                   	push   %ebp
  801df9:	57                   	push   %edi
  801dfa:	56                   	push   %esi
  801dfb:	53                   	push   %ebx
  801dfc:	83 ec 1c             	sub    $0x1c,%esp
  801dff:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e03:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e07:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e0b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e0f:	89 ca                	mov    %ecx,%edx
  801e11:	89 f8                	mov    %edi,%eax
  801e13:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e17:	85 f6                	test   %esi,%esi
  801e19:	75 2d                	jne    801e48 <__udivdi3+0x50>
  801e1b:	39 cf                	cmp    %ecx,%edi
  801e1d:	77 65                	ja     801e84 <__udivdi3+0x8c>
  801e1f:	89 fd                	mov    %edi,%ebp
  801e21:	85 ff                	test   %edi,%edi
  801e23:	75 0b                	jne    801e30 <__udivdi3+0x38>
  801e25:	b8 01 00 00 00       	mov    $0x1,%eax
  801e2a:	31 d2                	xor    %edx,%edx
  801e2c:	f7 f7                	div    %edi
  801e2e:	89 c5                	mov    %eax,%ebp
  801e30:	31 d2                	xor    %edx,%edx
  801e32:	89 c8                	mov    %ecx,%eax
  801e34:	f7 f5                	div    %ebp
  801e36:	89 c1                	mov    %eax,%ecx
  801e38:	89 d8                	mov    %ebx,%eax
  801e3a:	f7 f5                	div    %ebp
  801e3c:	89 cf                	mov    %ecx,%edi
  801e3e:	89 fa                	mov    %edi,%edx
  801e40:	83 c4 1c             	add    $0x1c,%esp
  801e43:	5b                   	pop    %ebx
  801e44:	5e                   	pop    %esi
  801e45:	5f                   	pop    %edi
  801e46:	5d                   	pop    %ebp
  801e47:	c3                   	ret    
  801e48:	39 ce                	cmp    %ecx,%esi
  801e4a:	77 28                	ja     801e74 <__udivdi3+0x7c>
  801e4c:	0f bd fe             	bsr    %esi,%edi
  801e4f:	83 f7 1f             	xor    $0x1f,%edi
  801e52:	75 40                	jne    801e94 <__udivdi3+0x9c>
  801e54:	39 ce                	cmp    %ecx,%esi
  801e56:	72 0a                	jb     801e62 <__udivdi3+0x6a>
  801e58:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e5c:	0f 87 9e 00 00 00    	ja     801f00 <__udivdi3+0x108>
  801e62:	b8 01 00 00 00       	mov    $0x1,%eax
  801e67:	89 fa                	mov    %edi,%edx
  801e69:	83 c4 1c             	add    $0x1c,%esp
  801e6c:	5b                   	pop    %ebx
  801e6d:	5e                   	pop    %esi
  801e6e:	5f                   	pop    %edi
  801e6f:	5d                   	pop    %ebp
  801e70:	c3                   	ret    
  801e71:	8d 76 00             	lea    0x0(%esi),%esi
  801e74:	31 ff                	xor    %edi,%edi
  801e76:	31 c0                	xor    %eax,%eax
  801e78:	89 fa                	mov    %edi,%edx
  801e7a:	83 c4 1c             	add    $0x1c,%esp
  801e7d:	5b                   	pop    %ebx
  801e7e:	5e                   	pop    %esi
  801e7f:	5f                   	pop    %edi
  801e80:	5d                   	pop    %ebp
  801e81:	c3                   	ret    
  801e82:	66 90                	xchg   %ax,%ax
  801e84:	89 d8                	mov    %ebx,%eax
  801e86:	f7 f7                	div    %edi
  801e88:	31 ff                	xor    %edi,%edi
  801e8a:	89 fa                	mov    %edi,%edx
  801e8c:	83 c4 1c             	add    $0x1c,%esp
  801e8f:	5b                   	pop    %ebx
  801e90:	5e                   	pop    %esi
  801e91:	5f                   	pop    %edi
  801e92:	5d                   	pop    %ebp
  801e93:	c3                   	ret    
  801e94:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e99:	89 eb                	mov    %ebp,%ebx
  801e9b:	29 fb                	sub    %edi,%ebx
  801e9d:	89 f9                	mov    %edi,%ecx
  801e9f:	d3 e6                	shl    %cl,%esi
  801ea1:	89 c5                	mov    %eax,%ebp
  801ea3:	88 d9                	mov    %bl,%cl
  801ea5:	d3 ed                	shr    %cl,%ebp
  801ea7:	89 e9                	mov    %ebp,%ecx
  801ea9:	09 f1                	or     %esi,%ecx
  801eab:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801eaf:	89 f9                	mov    %edi,%ecx
  801eb1:	d3 e0                	shl    %cl,%eax
  801eb3:	89 c5                	mov    %eax,%ebp
  801eb5:	89 d6                	mov    %edx,%esi
  801eb7:	88 d9                	mov    %bl,%cl
  801eb9:	d3 ee                	shr    %cl,%esi
  801ebb:	89 f9                	mov    %edi,%ecx
  801ebd:	d3 e2                	shl    %cl,%edx
  801ebf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ec3:	88 d9                	mov    %bl,%cl
  801ec5:	d3 e8                	shr    %cl,%eax
  801ec7:	09 c2                	or     %eax,%edx
  801ec9:	89 d0                	mov    %edx,%eax
  801ecb:	89 f2                	mov    %esi,%edx
  801ecd:	f7 74 24 0c          	divl   0xc(%esp)
  801ed1:	89 d6                	mov    %edx,%esi
  801ed3:	89 c3                	mov    %eax,%ebx
  801ed5:	f7 e5                	mul    %ebp
  801ed7:	39 d6                	cmp    %edx,%esi
  801ed9:	72 19                	jb     801ef4 <__udivdi3+0xfc>
  801edb:	74 0b                	je     801ee8 <__udivdi3+0xf0>
  801edd:	89 d8                	mov    %ebx,%eax
  801edf:	31 ff                	xor    %edi,%edi
  801ee1:	e9 58 ff ff ff       	jmp    801e3e <__udivdi3+0x46>
  801ee6:	66 90                	xchg   %ax,%ax
  801ee8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801eec:	89 f9                	mov    %edi,%ecx
  801eee:	d3 e2                	shl    %cl,%edx
  801ef0:	39 c2                	cmp    %eax,%edx
  801ef2:	73 e9                	jae    801edd <__udivdi3+0xe5>
  801ef4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ef7:	31 ff                	xor    %edi,%edi
  801ef9:	e9 40 ff ff ff       	jmp    801e3e <__udivdi3+0x46>
  801efe:	66 90                	xchg   %ax,%ax
  801f00:	31 c0                	xor    %eax,%eax
  801f02:	e9 37 ff ff ff       	jmp    801e3e <__udivdi3+0x46>
  801f07:	90                   	nop

00801f08 <__umoddi3>:
  801f08:	55                   	push   %ebp
  801f09:	57                   	push   %edi
  801f0a:	56                   	push   %esi
  801f0b:	53                   	push   %ebx
  801f0c:	83 ec 1c             	sub    $0x1c,%esp
  801f0f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f13:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f17:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f1b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f1f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f23:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f27:	89 f3                	mov    %esi,%ebx
  801f29:	89 fa                	mov    %edi,%edx
  801f2b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f2f:	89 34 24             	mov    %esi,(%esp)
  801f32:	85 c0                	test   %eax,%eax
  801f34:	75 1a                	jne    801f50 <__umoddi3+0x48>
  801f36:	39 f7                	cmp    %esi,%edi
  801f38:	0f 86 a2 00 00 00    	jbe    801fe0 <__umoddi3+0xd8>
  801f3e:	89 c8                	mov    %ecx,%eax
  801f40:	89 f2                	mov    %esi,%edx
  801f42:	f7 f7                	div    %edi
  801f44:	89 d0                	mov    %edx,%eax
  801f46:	31 d2                	xor    %edx,%edx
  801f48:	83 c4 1c             	add    $0x1c,%esp
  801f4b:	5b                   	pop    %ebx
  801f4c:	5e                   	pop    %esi
  801f4d:	5f                   	pop    %edi
  801f4e:	5d                   	pop    %ebp
  801f4f:	c3                   	ret    
  801f50:	39 f0                	cmp    %esi,%eax
  801f52:	0f 87 ac 00 00 00    	ja     802004 <__umoddi3+0xfc>
  801f58:	0f bd e8             	bsr    %eax,%ebp
  801f5b:	83 f5 1f             	xor    $0x1f,%ebp
  801f5e:	0f 84 ac 00 00 00    	je     802010 <__umoddi3+0x108>
  801f64:	bf 20 00 00 00       	mov    $0x20,%edi
  801f69:	29 ef                	sub    %ebp,%edi
  801f6b:	89 fe                	mov    %edi,%esi
  801f6d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f71:	89 e9                	mov    %ebp,%ecx
  801f73:	d3 e0                	shl    %cl,%eax
  801f75:	89 d7                	mov    %edx,%edi
  801f77:	89 f1                	mov    %esi,%ecx
  801f79:	d3 ef                	shr    %cl,%edi
  801f7b:	09 c7                	or     %eax,%edi
  801f7d:	89 e9                	mov    %ebp,%ecx
  801f7f:	d3 e2                	shl    %cl,%edx
  801f81:	89 14 24             	mov    %edx,(%esp)
  801f84:	89 d8                	mov    %ebx,%eax
  801f86:	d3 e0                	shl    %cl,%eax
  801f88:	89 c2                	mov    %eax,%edx
  801f8a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f8e:	d3 e0                	shl    %cl,%eax
  801f90:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f94:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f98:	89 f1                	mov    %esi,%ecx
  801f9a:	d3 e8                	shr    %cl,%eax
  801f9c:	09 d0                	or     %edx,%eax
  801f9e:	d3 eb                	shr    %cl,%ebx
  801fa0:	89 da                	mov    %ebx,%edx
  801fa2:	f7 f7                	div    %edi
  801fa4:	89 d3                	mov    %edx,%ebx
  801fa6:	f7 24 24             	mull   (%esp)
  801fa9:	89 c6                	mov    %eax,%esi
  801fab:	89 d1                	mov    %edx,%ecx
  801fad:	39 d3                	cmp    %edx,%ebx
  801faf:	0f 82 87 00 00 00    	jb     80203c <__umoddi3+0x134>
  801fb5:	0f 84 91 00 00 00    	je     80204c <__umoddi3+0x144>
  801fbb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801fbf:	29 f2                	sub    %esi,%edx
  801fc1:	19 cb                	sbb    %ecx,%ebx
  801fc3:	89 d8                	mov    %ebx,%eax
  801fc5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801fc9:	d3 e0                	shl    %cl,%eax
  801fcb:	89 e9                	mov    %ebp,%ecx
  801fcd:	d3 ea                	shr    %cl,%edx
  801fcf:	09 d0                	or     %edx,%eax
  801fd1:	89 e9                	mov    %ebp,%ecx
  801fd3:	d3 eb                	shr    %cl,%ebx
  801fd5:	89 da                	mov    %ebx,%edx
  801fd7:	83 c4 1c             	add    $0x1c,%esp
  801fda:	5b                   	pop    %ebx
  801fdb:	5e                   	pop    %esi
  801fdc:	5f                   	pop    %edi
  801fdd:	5d                   	pop    %ebp
  801fde:	c3                   	ret    
  801fdf:	90                   	nop
  801fe0:	89 fd                	mov    %edi,%ebp
  801fe2:	85 ff                	test   %edi,%edi
  801fe4:	75 0b                	jne    801ff1 <__umoddi3+0xe9>
  801fe6:	b8 01 00 00 00       	mov    $0x1,%eax
  801feb:	31 d2                	xor    %edx,%edx
  801fed:	f7 f7                	div    %edi
  801fef:	89 c5                	mov    %eax,%ebp
  801ff1:	89 f0                	mov    %esi,%eax
  801ff3:	31 d2                	xor    %edx,%edx
  801ff5:	f7 f5                	div    %ebp
  801ff7:	89 c8                	mov    %ecx,%eax
  801ff9:	f7 f5                	div    %ebp
  801ffb:	89 d0                	mov    %edx,%eax
  801ffd:	e9 44 ff ff ff       	jmp    801f46 <__umoddi3+0x3e>
  802002:	66 90                	xchg   %ax,%ax
  802004:	89 c8                	mov    %ecx,%eax
  802006:	89 f2                	mov    %esi,%edx
  802008:	83 c4 1c             	add    $0x1c,%esp
  80200b:	5b                   	pop    %ebx
  80200c:	5e                   	pop    %esi
  80200d:	5f                   	pop    %edi
  80200e:	5d                   	pop    %ebp
  80200f:	c3                   	ret    
  802010:	3b 04 24             	cmp    (%esp),%eax
  802013:	72 06                	jb     80201b <__umoddi3+0x113>
  802015:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802019:	77 0f                	ja     80202a <__umoddi3+0x122>
  80201b:	89 f2                	mov    %esi,%edx
  80201d:	29 f9                	sub    %edi,%ecx
  80201f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802023:	89 14 24             	mov    %edx,(%esp)
  802026:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80202a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80202e:	8b 14 24             	mov    (%esp),%edx
  802031:	83 c4 1c             	add    $0x1c,%esp
  802034:	5b                   	pop    %ebx
  802035:	5e                   	pop    %esi
  802036:	5f                   	pop    %edi
  802037:	5d                   	pop    %ebp
  802038:	c3                   	ret    
  802039:	8d 76 00             	lea    0x0(%esi),%esi
  80203c:	2b 04 24             	sub    (%esp),%eax
  80203f:	19 fa                	sbb    %edi,%edx
  802041:	89 d1                	mov    %edx,%ecx
  802043:	89 c6                	mov    %eax,%esi
  802045:	e9 71 ff ff ff       	jmp    801fbb <__umoddi3+0xb3>
  80204a:	66 90                	xchg   %ax,%ax
  80204c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802050:	72 ea                	jb     80203c <__umoddi3+0x134>
  802052:	89 d9                	mov    %ebx,%ecx
  802054:	e9 62 ff ff ff       	jmp    801fbb <__umoddi3+0xb3>
