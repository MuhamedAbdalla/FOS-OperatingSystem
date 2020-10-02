
obj/user/tst_page_replacement_stack:     file format elf32-i386


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
  800031:	e8 f9 00 00 00       	call   80012f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 14 a0 00 00    	sub    $0xa014,%esp
	char arr[PAGE_SIZE*10];

	uint32 kilo = 1024;
  800042:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)

//	cprintf("envID = %d\n",envID);

	int freePages = sys_calculate_free_frames();
  800049:	e8 b3 13 00 00       	call   801401 <sys_calculate_free_frames>
  80004e:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  800051:	e8 2e 14 00 00       	call   801484 <sys_pf_calculate_allocated_pages>
  800056:	89 45 e8             	mov    %eax,-0x18(%ebp)

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800059:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800060:	eb 15                	jmp    800077 <_main+0x3f>
		arr[i] = -1 ;
  800062:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  800068:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80006b:	01 d0                	add    %edx,%eax
  80006d:	c6 00 ff             	movb   $0xff,(%eax)

	int freePages = sys_calculate_free_frames();
	int usedDiskPages = sys_pf_calculate_allocated_pages();

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800070:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800077:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  80007e:	7e e2                	jle    800062 <_main+0x2a>
		arr[i] = -1 ;


	cprintf("checking REPLACEMENT fault handling of STACK pages... \n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 80 1b 80 00       	push   $0x801b80
  800088:	e8 7e 04 00 00       	call   80050b <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800097:	eb 2c                	jmp    8000c5 <_main+0x8d>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");
  800099:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  80009f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000a2:	01 d0                	add    %edx,%eax
  8000a4:	8a 00                	mov    (%eax),%al
  8000a6:	3c ff                	cmp    $0xff,%al
  8000a8:	74 14                	je     8000be <_main+0x86>
  8000aa:	83 ec 04             	sub    $0x4,%esp
  8000ad:	68 b8 1b 80 00       	push   $0x801bb8
  8000b2:	6a 1a                	push   $0x1a
  8000b4:	68 e8 1b 80 00       	push   $0x801be8
  8000b9:	e8 96 01 00 00       	call   800254 <_panic>
		arr[i] = -1 ;


	cprintf("checking REPLACEMENT fault handling of STACK pages... \n");
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000be:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8000c5:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  8000cc:	7e cb                	jle    800099 <_main+0x61>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  9) panic("Unexpected extra/less pages have been added to page file");
  8000ce:	e8 b1 13 00 00       	call   801484 <sys_pf_calculate_allocated_pages>
  8000d3:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d6:	83 f8 09             	cmp    $0x9,%eax
  8000d9:	74 14                	je     8000ef <_main+0xb7>
  8000db:	83 ec 04             	sub    $0x4,%esp
  8000de:	68 0c 1c 80 00       	push   $0x801c0c
  8000e3:	6a 1c                	push   $0x1c
  8000e5:	68 e8 1b 80 00       	push   $0x801be8
  8000ea:	e8 65 01 00 00       	call   800254 <_panic>

		if( (freePages - (sys_calculate_free_frames() + sys_calculate_modified_frames())) != 0 ) panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  8000ef:	e8 0d 13 00 00       	call   801401 <sys_calculate_free_frames>
  8000f4:	89 c3                	mov    %eax,%ebx
  8000f6:	e8 1f 13 00 00       	call   80141a <sys_calculate_modified_frames>
  8000fb:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  8000fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800101:	39 c2                	cmp    %eax,%edx
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 48 1c 80 00       	push   $0x801c48
  80010d:	6a 1e                	push   $0x1e
  80010f:	68 e8 1b 80 00       	push   $0x801be8
  800114:	e8 3b 01 00 00       	call   800254 <_panic>
	}

	cprintf("Congratulations: stack pages created, modified and read successfully!\n\n");
  800119:	83 ec 0c             	sub    $0xc,%esp
  80011c:	68 ac 1c 80 00       	push   $0x801cac
  800121:	e8 e5 03 00 00       	call   80050b <cprintf>
  800126:	83 c4 10             	add    $0x10,%esp


	return;
  800129:	90                   	nop
}
  80012a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80012d:	c9                   	leave  
  80012e:	c3                   	ret    

0080012f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80012f:	55                   	push   %ebp
  800130:	89 e5                	mov    %esp,%ebp
  800132:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800135:	e8 fc 11 00 00       	call   801336 <sys_getenvindex>
  80013a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80013d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800140:	89 d0                	mov    %edx,%eax
  800142:	c1 e0 03             	shl    $0x3,%eax
  800145:	01 d0                	add    %edx,%eax
  800147:	c1 e0 02             	shl    $0x2,%eax
  80014a:	01 d0                	add    %edx,%eax
  80014c:	c1 e0 06             	shl    $0x6,%eax
  80014f:	29 d0                	sub    %edx,%eax
  800151:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800158:	01 c8                	add    %ecx,%eax
  80015a:	01 d0                	add    %edx,%eax
  80015c:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800161:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800166:	a1 20 30 80 00       	mov    0x803020,%eax
  80016b:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  800171:	84 c0                	test   %al,%al
  800173:	74 0f                	je     800184 <libmain+0x55>
		binaryname = myEnv->prog_name;
  800175:	a1 20 30 80 00       	mov    0x803020,%eax
  80017a:	05 b0 52 00 00       	add    $0x52b0,%eax
  80017f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800184:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800188:	7e 0a                	jle    800194 <libmain+0x65>
		binaryname = argv[0];
  80018a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800194:	83 ec 08             	sub    $0x8,%esp
  800197:	ff 75 0c             	pushl  0xc(%ebp)
  80019a:	ff 75 08             	pushl  0x8(%ebp)
  80019d:	e8 96 fe ff ff       	call   800038 <_main>
  8001a2:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001a5:	e8 27 13 00 00       	call   8014d1 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001aa:	83 ec 0c             	sub    $0xc,%esp
  8001ad:	68 0c 1d 80 00       	push   $0x801d0c
  8001b2:	e8 54 03 00 00       	call   80050b <cprintf>
  8001b7:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bf:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  8001c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ca:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  8001d0:	83 ec 04             	sub    $0x4,%esp
  8001d3:	52                   	push   %edx
  8001d4:	50                   	push   %eax
  8001d5:	68 34 1d 80 00       	push   $0x801d34
  8001da:	e8 2c 03 00 00       	call   80050b <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8001e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e7:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  8001ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f2:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  8001f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fd:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800203:	51                   	push   %ecx
  800204:	52                   	push   %edx
  800205:	50                   	push   %eax
  800206:	68 5c 1d 80 00       	push   $0x801d5c
  80020b:	e8 fb 02 00 00       	call   80050b <cprintf>
  800210:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800213:	83 ec 0c             	sub    $0xc,%esp
  800216:	68 0c 1d 80 00       	push   $0x801d0c
  80021b:	e8 eb 02 00 00       	call   80050b <cprintf>
  800220:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800223:	e8 c3 12 00 00       	call   8014eb <sys_enable_interrupt>

	// exit gracefully
	exit();
  800228:	e8 19 00 00 00       	call   800246 <exit>
}
  80022d:	90                   	nop
  80022e:	c9                   	leave  
  80022f:	c3                   	ret    

00800230 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800230:	55                   	push   %ebp
  800231:	89 e5                	mov    %esp,%ebp
  800233:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800236:	83 ec 0c             	sub    $0xc,%esp
  800239:	6a 00                	push   $0x0
  80023b:	e8 c2 10 00 00       	call   801302 <sys_env_destroy>
  800240:	83 c4 10             	add    $0x10,%esp
}
  800243:	90                   	nop
  800244:	c9                   	leave  
  800245:	c3                   	ret    

00800246 <exit>:

void
exit(void)
{
  800246:	55                   	push   %ebp
  800247:	89 e5                	mov    %esp,%ebp
  800249:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80024c:	e8 17 11 00 00       	call   801368 <sys_env_exit>
}
  800251:	90                   	nop
  800252:	c9                   	leave  
  800253:	c3                   	ret    

00800254 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800254:	55                   	push   %ebp
  800255:	89 e5                	mov    %esp,%ebp
  800257:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80025a:	8d 45 10             	lea    0x10(%ebp),%eax
  80025d:	83 c0 04             	add    $0x4,%eax
  800260:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800263:	a1 18 31 80 00       	mov    0x803118,%eax
  800268:	85 c0                	test   %eax,%eax
  80026a:	74 16                	je     800282 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80026c:	a1 18 31 80 00       	mov    0x803118,%eax
  800271:	83 ec 08             	sub    $0x8,%esp
  800274:	50                   	push   %eax
  800275:	68 b4 1d 80 00       	push   $0x801db4
  80027a:	e8 8c 02 00 00       	call   80050b <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800282:	a1 00 30 80 00       	mov    0x803000,%eax
  800287:	ff 75 0c             	pushl  0xc(%ebp)
  80028a:	ff 75 08             	pushl  0x8(%ebp)
  80028d:	50                   	push   %eax
  80028e:	68 b9 1d 80 00       	push   $0x801db9
  800293:	e8 73 02 00 00       	call   80050b <cprintf>
  800298:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80029b:	8b 45 10             	mov    0x10(%ebp),%eax
  80029e:	83 ec 08             	sub    $0x8,%esp
  8002a1:	ff 75 f4             	pushl  -0xc(%ebp)
  8002a4:	50                   	push   %eax
  8002a5:	e8 f6 01 00 00       	call   8004a0 <vcprintf>
  8002aa:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002ad:	83 ec 08             	sub    $0x8,%esp
  8002b0:	6a 00                	push   $0x0
  8002b2:	68 d5 1d 80 00       	push   $0x801dd5
  8002b7:	e8 e4 01 00 00       	call   8004a0 <vcprintf>
  8002bc:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002bf:	e8 82 ff ff ff       	call   800246 <exit>

	// should not return here
	while (1) ;
  8002c4:	eb fe                	jmp    8002c4 <_panic+0x70>

008002c6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002c6:	55                   	push   %ebp
  8002c7:	89 e5                	mov    %esp,%ebp
  8002c9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d1:	8b 50 74             	mov    0x74(%eax),%edx
  8002d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002d7:	39 c2                	cmp    %eax,%edx
  8002d9:	74 14                	je     8002ef <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002db:	83 ec 04             	sub    $0x4,%esp
  8002de:	68 d8 1d 80 00       	push   $0x801dd8
  8002e3:	6a 26                	push   $0x26
  8002e5:	68 24 1e 80 00       	push   $0x801e24
  8002ea:	e8 65 ff ff ff       	call   800254 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002fd:	e9 c4 00 00 00       	jmp    8003c6 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800302:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800305:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80030c:	8b 45 08             	mov    0x8(%ebp),%eax
  80030f:	01 d0                	add    %edx,%eax
  800311:	8b 00                	mov    (%eax),%eax
  800313:	85 c0                	test   %eax,%eax
  800315:	75 08                	jne    80031f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800317:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80031a:	e9 a4 00 00 00       	jmp    8003c3 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  80031f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800326:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80032d:	eb 6b                	jmp    80039a <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80032f:	a1 20 30 80 00       	mov    0x803020,%eax
  800334:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80033a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80033d:	89 d0                	mov    %edx,%eax
  80033f:	c1 e0 02             	shl    $0x2,%eax
  800342:	01 d0                	add    %edx,%eax
  800344:	c1 e0 02             	shl    $0x2,%eax
  800347:	01 c8                	add    %ecx,%eax
  800349:	8a 40 04             	mov    0x4(%eax),%al
  80034c:	84 c0                	test   %al,%al
  80034e:	75 47                	jne    800397 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800350:	a1 20 30 80 00       	mov    0x803020,%eax
  800355:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80035b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80035e:	89 d0                	mov    %edx,%eax
  800360:	c1 e0 02             	shl    $0x2,%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	c1 e0 02             	shl    $0x2,%eax
  800368:	01 c8                	add    %ecx,%eax
  80036a:	8b 00                	mov    (%eax),%eax
  80036c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80036f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800372:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800377:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800379:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80037c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800383:	8b 45 08             	mov    0x8(%ebp),%eax
  800386:	01 c8                	add    %ecx,%eax
  800388:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80038a:	39 c2                	cmp    %eax,%edx
  80038c:	75 09                	jne    800397 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80038e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800395:	eb 12                	jmp    8003a9 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800397:	ff 45 e8             	incl   -0x18(%ebp)
  80039a:	a1 20 30 80 00       	mov    0x803020,%eax
  80039f:	8b 50 74             	mov    0x74(%eax),%edx
  8003a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003a5:	39 c2                	cmp    %eax,%edx
  8003a7:	77 86                	ja     80032f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003a9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003ad:	75 14                	jne    8003c3 <CheckWSWithoutLastIndex+0xfd>
			panic(
  8003af:	83 ec 04             	sub    $0x4,%esp
  8003b2:	68 30 1e 80 00       	push   $0x801e30
  8003b7:	6a 3a                	push   $0x3a
  8003b9:	68 24 1e 80 00       	push   $0x801e24
  8003be:	e8 91 fe ff ff       	call   800254 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003c3:	ff 45 f0             	incl   -0x10(%ebp)
  8003c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003cc:	0f 8c 30 ff ff ff    	jl     800302 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003d2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003d9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003e0:	eb 27                	jmp    800409 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e7:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8003ed:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003f0:	89 d0                	mov    %edx,%eax
  8003f2:	c1 e0 02             	shl    $0x2,%eax
  8003f5:	01 d0                	add    %edx,%eax
  8003f7:	c1 e0 02             	shl    $0x2,%eax
  8003fa:	01 c8                	add    %ecx,%eax
  8003fc:	8a 40 04             	mov    0x4(%eax),%al
  8003ff:	3c 01                	cmp    $0x1,%al
  800401:	75 03                	jne    800406 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800403:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800406:	ff 45 e0             	incl   -0x20(%ebp)
  800409:	a1 20 30 80 00       	mov    0x803020,%eax
  80040e:	8b 50 74             	mov    0x74(%eax),%edx
  800411:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800414:	39 c2                	cmp    %eax,%edx
  800416:	77 ca                	ja     8003e2 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800418:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80041b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80041e:	74 14                	je     800434 <CheckWSWithoutLastIndex+0x16e>
		panic(
  800420:	83 ec 04             	sub    $0x4,%esp
  800423:	68 84 1e 80 00       	push   $0x801e84
  800428:	6a 44                	push   $0x44
  80042a:	68 24 1e 80 00       	push   $0x801e24
  80042f:	e8 20 fe ff ff       	call   800254 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800434:	90                   	nop
  800435:	c9                   	leave  
  800436:	c3                   	ret    

00800437 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800437:	55                   	push   %ebp
  800438:	89 e5                	mov    %esp,%ebp
  80043a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80043d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800440:	8b 00                	mov    (%eax),%eax
  800442:	8d 48 01             	lea    0x1(%eax),%ecx
  800445:	8b 55 0c             	mov    0xc(%ebp),%edx
  800448:	89 0a                	mov    %ecx,(%edx)
  80044a:	8b 55 08             	mov    0x8(%ebp),%edx
  80044d:	88 d1                	mov    %dl,%cl
  80044f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800452:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800456:	8b 45 0c             	mov    0xc(%ebp),%eax
  800459:	8b 00                	mov    (%eax),%eax
  80045b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800460:	75 2c                	jne    80048e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800462:	a0 24 30 80 00       	mov    0x803024,%al
  800467:	0f b6 c0             	movzbl %al,%eax
  80046a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80046d:	8b 12                	mov    (%edx),%edx
  80046f:	89 d1                	mov    %edx,%ecx
  800471:	8b 55 0c             	mov    0xc(%ebp),%edx
  800474:	83 c2 08             	add    $0x8,%edx
  800477:	83 ec 04             	sub    $0x4,%esp
  80047a:	50                   	push   %eax
  80047b:	51                   	push   %ecx
  80047c:	52                   	push   %edx
  80047d:	e8 3e 0e 00 00       	call   8012c0 <sys_cputs>
  800482:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800485:	8b 45 0c             	mov    0xc(%ebp),%eax
  800488:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80048e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800491:	8b 40 04             	mov    0x4(%eax),%eax
  800494:	8d 50 01             	lea    0x1(%eax),%edx
  800497:	8b 45 0c             	mov    0xc(%ebp),%eax
  80049a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80049d:	90                   	nop
  80049e:	c9                   	leave  
  80049f:	c3                   	ret    

008004a0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004a0:	55                   	push   %ebp
  8004a1:	89 e5                	mov    %esp,%ebp
  8004a3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004a9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004b0:	00 00 00 
	b.cnt = 0;
  8004b3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004ba:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004bd:	ff 75 0c             	pushl  0xc(%ebp)
  8004c0:	ff 75 08             	pushl  0x8(%ebp)
  8004c3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004c9:	50                   	push   %eax
  8004ca:	68 37 04 80 00       	push   $0x800437
  8004cf:	e8 11 02 00 00       	call   8006e5 <vprintfmt>
  8004d4:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004d7:	a0 24 30 80 00       	mov    0x803024,%al
  8004dc:	0f b6 c0             	movzbl %al,%eax
  8004df:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004e5:	83 ec 04             	sub    $0x4,%esp
  8004e8:	50                   	push   %eax
  8004e9:	52                   	push   %edx
  8004ea:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004f0:	83 c0 08             	add    $0x8,%eax
  8004f3:	50                   	push   %eax
  8004f4:	e8 c7 0d 00 00       	call   8012c0 <sys_cputs>
  8004f9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004fc:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800503:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800509:	c9                   	leave  
  80050a:	c3                   	ret    

0080050b <cprintf>:

int cprintf(const char *fmt, ...) {
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800511:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800518:	8d 45 0c             	lea    0xc(%ebp),%eax
  80051b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80051e:	8b 45 08             	mov    0x8(%ebp),%eax
  800521:	83 ec 08             	sub    $0x8,%esp
  800524:	ff 75 f4             	pushl  -0xc(%ebp)
  800527:	50                   	push   %eax
  800528:	e8 73 ff ff ff       	call   8004a0 <vcprintf>
  80052d:	83 c4 10             	add    $0x10,%esp
  800530:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800533:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800536:	c9                   	leave  
  800537:	c3                   	ret    

00800538 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800538:	55                   	push   %ebp
  800539:	89 e5                	mov    %esp,%ebp
  80053b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80053e:	e8 8e 0f 00 00       	call   8014d1 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800543:	8d 45 0c             	lea    0xc(%ebp),%eax
  800546:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800549:	8b 45 08             	mov    0x8(%ebp),%eax
  80054c:	83 ec 08             	sub    $0x8,%esp
  80054f:	ff 75 f4             	pushl  -0xc(%ebp)
  800552:	50                   	push   %eax
  800553:	e8 48 ff ff ff       	call   8004a0 <vcprintf>
  800558:	83 c4 10             	add    $0x10,%esp
  80055b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80055e:	e8 88 0f 00 00       	call   8014eb <sys_enable_interrupt>
	return cnt;
  800563:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800566:	c9                   	leave  
  800567:	c3                   	ret    

00800568 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800568:	55                   	push   %ebp
  800569:	89 e5                	mov    %esp,%ebp
  80056b:	53                   	push   %ebx
  80056c:	83 ec 14             	sub    $0x14,%esp
  80056f:	8b 45 10             	mov    0x10(%ebp),%eax
  800572:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800575:	8b 45 14             	mov    0x14(%ebp),%eax
  800578:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80057b:	8b 45 18             	mov    0x18(%ebp),%eax
  80057e:	ba 00 00 00 00       	mov    $0x0,%edx
  800583:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800586:	77 55                	ja     8005dd <printnum+0x75>
  800588:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80058b:	72 05                	jb     800592 <printnum+0x2a>
  80058d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800590:	77 4b                	ja     8005dd <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800592:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800595:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800598:	8b 45 18             	mov    0x18(%ebp),%eax
  80059b:	ba 00 00 00 00       	mov    $0x0,%edx
  8005a0:	52                   	push   %edx
  8005a1:	50                   	push   %eax
  8005a2:	ff 75 f4             	pushl  -0xc(%ebp)
  8005a5:	ff 75 f0             	pushl  -0x10(%ebp)
  8005a8:	e8 63 13 00 00       	call   801910 <__udivdi3>
  8005ad:	83 c4 10             	add    $0x10,%esp
  8005b0:	83 ec 04             	sub    $0x4,%esp
  8005b3:	ff 75 20             	pushl  0x20(%ebp)
  8005b6:	53                   	push   %ebx
  8005b7:	ff 75 18             	pushl  0x18(%ebp)
  8005ba:	52                   	push   %edx
  8005bb:	50                   	push   %eax
  8005bc:	ff 75 0c             	pushl  0xc(%ebp)
  8005bf:	ff 75 08             	pushl  0x8(%ebp)
  8005c2:	e8 a1 ff ff ff       	call   800568 <printnum>
  8005c7:	83 c4 20             	add    $0x20,%esp
  8005ca:	eb 1a                	jmp    8005e6 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005cc:	83 ec 08             	sub    $0x8,%esp
  8005cf:	ff 75 0c             	pushl  0xc(%ebp)
  8005d2:	ff 75 20             	pushl  0x20(%ebp)
  8005d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d8:	ff d0                	call   *%eax
  8005da:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005dd:	ff 4d 1c             	decl   0x1c(%ebp)
  8005e0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005e4:	7f e6                	jg     8005cc <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005e6:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005e9:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005f4:	53                   	push   %ebx
  8005f5:	51                   	push   %ecx
  8005f6:	52                   	push   %edx
  8005f7:	50                   	push   %eax
  8005f8:	e8 23 14 00 00       	call   801a20 <__umoddi3>
  8005fd:	83 c4 10             	add    $0x10,%esp
  800600:	05 f4 20 80 00       	add    $0x8020f4,%eax
  800605:	8a 00                	mov    (%eax),%al
  800607:	0f be c0             	movsbl %al,%eax
  80060a:	83 ec 08             	sub    $0x8,%esp
  80060d:	ff 75 0c             	pushl  0xc(%ebp)
  800610:	50                   	push   %eax
  800611:	8b 45 08             	mov    0x8(%ebp),%eax
  800614:	ff d0                	call   *%eax
  800616:	83 c4 10             	add    $0x10,%esp
}
  800619:	90                   	nop
  80061a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80061d:	c9                   	leave  
  80061e:	c3                   	ret    

0080061f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80061f:	55                   	push   %ebp
  800620:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800622:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800626:	7e 1c                	jle    800644 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800628:	8b 45 08             	mov    0x8(%ebp),%eax
  80062b:	8b 00                	mov    (%eax),%eax
  80062d:	8d 50 08             	lea    0x8(%eax),%edx
  800630:	8b 45 08             	mov    0x8(%ebp),%eax
  800633:	89 10                	mov    %edx,(%eax)
  800635:	8b 45 08             	mov    0x8(%ebp),%eax
  800638:	8b 00                	mov    (%eax),%eax
  80063a:	83 e8 08             	sub    $0x8,%eax
  80063d:	8b 50 04             	mov    0x4(%eax),%edx
  800640:	8b 00                	mov    (%eax),%eax
  800642:	eb 40                	jmp    800684 <getuint+0x65>
	else if (lflag)
  800644:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800648:	74 1e                	je     800668 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80064a:	8b 45 08             	mov    0x8(%ebp),%eax
  80064d:	8b 00                	mov    (%eax),%eax
  80064f:	8d 50 04             	lea    0x4(%eax),%edx
  800652:	8b 45 08             	mov    0x8(%ebp),%eax
  800655:	89 10                	mov    %edx,(%eax)
  800657:	8b 45 08             	mov    0x8(%ebp),%eax
  80065a:	8b 00                	mov    (%eax),%eax
  80065c:	83 e8 04             	sub    $0x4,%eax
  80065f:	8b 00                	mov    (%eax),%eax
  800661:	ba 00 00 00 00       	mov    $0x0,%edx
  800666:	eb 1c                	jmp    800684 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800668:	8b 45 08             	mov    0x8(%ebp),%eax
  80066b:	8b 00                	mov    (%eax),%eax
  80066d:	8d 50 04             	lea    0x4(%eax),%edx
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	89 10                	mov    %edx,(%eax)
  800675:	8b 45 08             	mov    0x8(%ebp),%eax
  800678:	8b 00                	mov    (%eax),%eax
  80067a:	83 e8 04             	sub    $0x4,%eax
  80067d:	8b 00                	mov    (%eax),%eax
  80067f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800684:	5d                   	pop    %ebp
  800685:	c3                   	ret    

00800686 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800686:	55                   	push   %ebp
  800687:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800689:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80068d:	7e 1c                	jle    8006ab <getint+0x25>
		return va_arg(*ap, long long);
  80068f:	8b 45 08             	mov    0x8(%ebp),%eax
  800692:	8b 00                	mov    (%eax),%eax
  800694:	8d 50 08             	lea    0x8(%eax),%edx
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	89 10                	mov    %edx,(%eax)
  80069c:	8b 45 08             	mov    0x8(%ebp),%eax
  80069f:	8b 00                	mov    (%eax),%eax
  8006a1:	83 e8 08             	sub    $0x8,%eax
  8006a4:	8b 50 04             	mov    0x4(%eax),%edx
  8006a7:	8b 00                	mov    (%eax),%eax
  8006a9:	eb 38                	jmp    8006e3 <getint+0x5d>
	else if (lflag)
  8006ab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006af:	74 1a                	je     8006cb <getint+0x45>
		return va_arg(*ap, long);
  8006b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b4:	8b 00                	mov    (%eax),%eax
  8006b6:	8d 50 04             	lea    0x4(%eax),%edx
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	89 10                	mov    %edx,(%eax)
  8006be:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c1:	8b 00                	mov    (%eax),%eax
  8006c3:	83 e8 04             	sub    $0x4,%eax
  8006c6:	8b 00                	mov    (%eax),%eax
  8006c8:	99                   	cltd   
  8006c9:	eb 18                	jmp    8006e3 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ce:	8b 00                	mov    (%eax),%eax
  8006d0:	8d 50 04             	lea    0x4(%eax),%edx
  8006d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d6:	89 10                	mov    %edx,(%eax)
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	8b 00                	mov    (%eax),%eax
  8006dd:	83 e8 04             	sub    $0x4,%eax
  8006e0:	8b 00                	mov    (%eax),%eax
  8006e2:	99                   	cltd   
}
  8006e3:	5d                   	pop    %ebp
  8006e4:	c3                   	ret    

008006e5 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006e5:	55                   	push   %ebp
  8006e6:	89 e5                	mov    %esp,%ebp
  8006e8:	56                   	push   %esi
  8006e9:	53                   	push   %ebx
  8006ea:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006ed:	eb 17                	jmp    800706 <vprintfmt+0x21>
			if (ch == '\0')
  8006ef:	85 db                	test   %ebx,%ebx
  8006f1:	0f 84 af 03 00 00    	je     800aa6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006f7:	83 ec 08             	sub    $0x8,%esp
  8006fa:	ff 75 0c             	pushl  0xc(%ebp)
  8006fd:	53                   	push   %ebx
  8006fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800701:	ff d0                	call   *%eax
  800703:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800706:	8b 45 10             	mov    0x10(%ebp),%eax
  800709:	8d 50 01             	lea    0x1(%eax),%edx
  80070c:	89 55 10             	mov    %edx,0x10(%ebp)
  80070f:	8a 00                	mov    (%eax),%al
  800711:	0f b6 d8             	movzbl %al,%ebx
  800714:	83 fb 25             	cmp    $0x25,%ebx
  800717:	75 d6                	jne    8006ef <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800719:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80071d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800724:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80072b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800732:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800739:	8b 45 10             	mov    0x10(%ebp),%eax
  80073c:	8d 50 01             	lea    0x1(%eax),%edx
  80073f:	89 55 10             	mov    %edx,0x10(%ebp)
  800742:	8a 00                	mov    (%eax),%al
  800744:	0f b6 d8             	movzbl %al,%ebx
  800747:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80074a:	83 f8 55             	cmp    $0x55,%eax
  80074d:	0f 87 2b 03 00 00    	ja     800a7e <vprintfmt+0x399>
  800753:	8b 04 85 18 21 80 00 	mov    0x802118(,%eax,4),%eax
  80075a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80075c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800760:	eb d7                	jmp    800739 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800762:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800766:	eb d1                	jmp    800739 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800768:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80076f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800772:	89 d0                	mov    %edx,%eax
  800774:	c1 e0 02             	shl    $0x2,%eax
  800777:	01 d0                	add    %edx,%eax
  800779:	01 c0                	add    %eax,%eax
  80077b:	01 d8                	add    %ebx,%eax
  80077d:	83 e8 30             	sub    $0x30,%eax
  800780:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800783:	8b 45 10             	mov    0x10(%ebp),%eax
  800786:	8a 00                	mov    (%eax),%al
  800788:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80078b:	83 fb 2f             	cmp    $0x2f,%ebx
  80078e:	7e 3e                	jle    8007ce <vprintfmt+0xe9>
  800790:	83 fb 39             	cmp    $0x39,%ebx
  800793:	7f 39                	jg     8007ce <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800795:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800798:	eb d5                	jmp    80076f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80079a:	8b 45 14             	mov    0x14(%ebp),%eax
  80079d:	83 c0 04             	add    $0x4,%eax
  8007a0:	89 45 14             	mov    %eax,0x14(%ebp)
  8007a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a6:	83 e8 04             	sub    $0x4,%eax
  8007a9:	8b 00                	mov    (%eax),%eax
  8007ab:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007ae:	eb 1f                	jmp    8007cf <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007b0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007b4:	79 83                	jns    800739 <vprintfmt+0x54>
				width = 0;
  8007b6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007bd:	e9 77 ff ff ff       	jmp    800739 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007c2:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007c9:	e9 6b ff ff ff       	jmp    800739 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007ce:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007cf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d3:	0f 89 60 ff ff ff    	jns    800739 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007df:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007e6:	e9 4e ff ff ff       	jmp    800739 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007eb:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007ee:	e9 46 ff ff ff       	jmp    800739 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f6:	83 c0 04             	add    $0x4,%eax
  8007f9:	89 45 14             	mov    %eax,0x14(%ebp)
  8007fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ff:	83 e8 04             	sub    $0x4,%eax
  800802:	8b 00                	mov    (%eax),%eax
  800804:	83 ec 08             	sub    $0x8,%esp
  800807:	ff 75 0c             	pushl  0xc(%ebp)
  80080a:	50                   	push   %eax
  80080b:	8b 45 08             	mov    0x8(%ebp),%eax
  80080e:	ff d0                	call   *%eax
  800810:	83 c4 10             	add    $0x10,%esp
			break;
  800813:	e9 89 02 00 00       	jmp    800aa1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800818:	8b 45 14             	mov    0x14(%ebp),%eax
  80081b:	83 c0 04             	add    $0x4,%eax
  80081e:	89 45 14             	mov    %eax,0x14(%ebp)
  800821:	8b 45 14             	mov    0x14(%ebp),%eax
  800824:	83 e8 04             	sub    $0x4,%eax
  800827:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800829:	85 db                	test   %ebx,%ebx
  80082b:	79 02                	jns    80082f <vprintfmt+0x14a>
				err = -err;
  80082d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80082f:	83 fb 64             	cmp    $0x64,%ebx
  800832:	7f 0b                	jg     80083f <vprintfmt+0x15a>
  800834:	8b 34 9d 60 1f 80 00 	mov    0x801f60(,%ebx,4),%esi
  80083b:	85 f6                	test   %esi,%esi
  80083d:	75 19                	jne    800858 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80083f:	53                   	push   %ebx
  800840:	68 05 21 80 00       	push   $0x802105
  800845:	ff 75 0c             	pushl  0xc(%ebp)
  800848:	ff 75 08             	pushl  0x8(%ebp)
  80084b:	e8 5e 02 00 00       	call   800aae <printfmt>
  800850:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800853:	e9 49 02 00 00       	jmp    800aa1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800858:	56                   	push   %esi
  800859:	68 0e 21 80 00       	push   $0x80210e
  80085e:	ff 75 0c             	pushl  0xc(%ebp)
  800861:	ff 75 08             	pushl  0x8(%ebp)
  800864:	e8 45 02 00 00       	call   800aae <printfmt>
  800869:	83 c4 10             	add    $0x10,%esp
			break;
  80086c:	e9 30 02 00 00       	jmp    800aa1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800871:	8b 45 14             	mov    0x14(%ebp),%eax
  800874:	83 c0 04             	add    $0x4,%eax
  800877:	89 45 14             	mov    %eax,0x14(%ebp)
  80087a:	8b 45 14             	mov    0x14(%ebp),%eax
  80087d:	83 e8 04             	sub    $0x4,%eax
  800880:	8b 30                	mov    (%eax),%esi
  800882:	85 f6                	test   %esi,%esi
  800884:	75 05                	jne    80088b <vprintfmt+0x1a6>
				p = "(null)";
  800886:	be 11 21 80 00       	mov    $0x802111,%esi
			if (width > 0 && padc != '-')
  80088b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80088f:	7e 6d                	jle    8008fe <vprintfmt+0x219>
  800891:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800895:	74 67                	je     8008fe <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800897:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80089a:	83 ec 08             	sub    $0x8,%esp
  80089d:	50                   	push   %eax
  80089e:	56                   	push   %esi
  80089f:	e8 0c 03 00 00       	call   800bb0 <strnlen>
  8008a4:	83 c4 10             	add    $0x10,%esp
  8008a7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008aa:	eb 16                	jmp    8008c2 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008ac:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008b0:	83 ec 08             	sub    $0x8,%esp
  8008b3:	ff 75 0c             	pushl  0xc(%ebp)
  8008b6:	50                   	push   %eax
  8008b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ba:	ff d0                	call   *%eax
  8008bc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008bf:	ff 4d e4             	decl   -0x1c(%ebp)
  8008c2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008c6:	7f e4                	jg     8008ac <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008c8:	eb 34                	jmp    8008fe <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008ca:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008ce:	74 1c                	je     8008ec <vprintfmt+0x207>
  8008d0:	83 fb 1f             	cmp    $0x1f,%ebx
  8008d3:	7e 05                	jle    8008da <vprintfmt+0x1f5>
  8008d5:	83 fb 7e             	cmp    $0x7e,%ebx
  8008d8:	7e 12                	jle    8008ec <vprintfmt+0x207>
					putch('?', putdat);
  8008da:	83 ec 08             	sub    $0x8,%esp
  8008dd:	ff 75 0c             	pushl  0xc(%ebp)
  8008e0:	6a 3f                	push   $0x3f
  8008e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e5:	ff d0                	call   *%eax
  8008e7:	83 c4 10             	add    $0x10,%esp
  8008ea:	eb 0f                	jmp    8008fb <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008ec:	83 ec 08             	sub    $0x8,%esp
  8008ef:	ff 75 0c             	pushl  0xc(%ebp)
  8008f2:	53                   	push   %ebx
  8008f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f6:	ff d0                	call   *%eax
  8008f8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008fb:	ff 4d e4             	decl   -0x1c(%ebp)
  8008fe:	89 f0                	mov    %esi,%eax
  800900:	8d 70 01             	lea    0x1(%eax),%esi
  800903:	8a 00                	mov    (%eax),%al
  800905:	0f be d8             	movsbl %al,%ebx
  800908:	85 db                	test   %ebx,%ebx
  80090a:	74 24                	je     800930 <vprintfmt+0x24b>
  80090c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800910:	78 b8                	js     8008ca <vprintfmt+0x1e5>
  800912:	ff 4d e0             	decl   -0x20(%ebp)
  800915:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800919:	79 af                	jns    8008ca <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80091b:	eb 13                	jmp    800930 <vprintfmt+0x24b>
				putch(' ', putdat);
  80091d:	83 ec 08             	sub    $0x8,%esp
  800920:	ff 75 0c             	pushl  0xc(%ebp)
  800923:	6a 20                	push   $0x20
  800925:	8b 45 08             	mov    0x8(%ebp),%eax
  800928:	ff d0                	call   *%eax
  80092a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80092d:	ff 4d e4             	decl   -0x1c(%ebp)
  800930:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800934:	7f e7                	jg     80091d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800936:	e9 66 01 00 00       	jmp    800aa1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80093b:	83 ec 08             	sub    $0x8,%esp
  80093e:	ff 75 e8             	pushl  -0x18(%ebp)
  800941:	8d 45 14             	lea    0x14(%ebp),%eax
  800944:	50                   	push   %eax
  800945:	e8 3c fd ff ff       	call   800686 <getint>
  80094a:	83 c4 10             	add    $0x10,%esp
  80094d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800950:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800953:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800956:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800959:	85 d2                	test   %edx,%edx
  80095b:	79 23                	jns    800980 <vprintfmt+0x29b>
				putch('-', putdat);
  80095d:	83 ec 08             	sub    $0x8,%esp
  800960:	ff 75 0c             	pushl  0xc(%ebp)
  800963:	6a 2d                	push   $0x2d
  800965:	8b 45 08             	mov    0x8(%ebp),%eax
  800968:	ff d0                	call   *%eax
  80096a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80096d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800970:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800973:	f7 d8                	neg    %eax
  800975:	83 d2 00             	adc    $0x0,%edx
  800978:	f7 da                	neg    %edx
  80097a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80097d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800980:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800987:	e9 bc 00 00 00       	jmp    800a48 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80098c:	83 ec 08             	sub    $0x8,%esp
  80098f:	ff 75 e8             	pushl  -0x18(%ebp)
  800992:	8d 45 14             	lea    0x14(%ebp),%eax
  800995:	50                   	push   %eax
  800996:	e8 84 fc ff ff       	call   80061f <getuint>
  80099b:	83 c4 10             	add    $0x10,%esp
  80099e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009a4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009ab:	e9 98 00 00 00       	jmp    800a48 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009b0:	83 ec 08             	sub    $0x8,%esp
  8009b3:	ff 75 0c             	pushl  0xc(%ebp)
  8009b6:	6a 58                	push   $0x58
  8009b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bb:	ff d0                	call   *%eax
  8009bd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009c0:	83 ec 08             	sub    $0x8,%esp
  8009c3:	ff 75 0c             	pushl  0xc(%ebp)
  8009c6:	6a 58                	push   $0x58
  8009c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cb:	ff d0                	call   *%eax
  8009cd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009d0:	83 ec 08             	sub    $0x8,%esp
  8009d3:	ff 75 0c             	pushl  0xc(%ebp)
  8009d6:	6a 58                	push   $0x58
  8009d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009db:	ff d0                	call   *%eax
  8009dd:	83 c4 10             	add    $0x10,%esp
			break;
  8009e0:	e9 bc 00 00 00       	jmp    800aa1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009e5:	83 ec 08             	sub    $0x8,%esp
  8009e8:	ff 75 0c             	pushl  0xc(%ebp)
  8009eb:	6a 30                	push   $0x30
  8009ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f0:	ff d0                	call   *%eax
  8009f2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009f5:	83 ec 08             	sub    $0x8,%esp
  8009f8:	ff 75 0c             	pushl  0xc(%ebp)
  8009fb:	6a 78                	push   $0x78
  8009fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800a00:	ff d0                	call   *%eax
  800a02:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a05:	8b 45 14             	mov    0x14(%ebp),%eax
  800a08:	83 c0 04             	add    $0x4,%eax
  800a0b:	89 45 14             	mov    %eax,0x14(%ebp)
  800a0e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a11:	83 e8 04             	sub    $0x4,%eax
  800a14:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a19:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a20:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a27:	eb 1f                	jmp    800a48 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a29:	83 ec 08             	sub    $0x8,%esp
  800a2c:	ff 75 e8             	pushl  -0x18(%ebp)
  800a2f:	8d 45 14             	lea    0x14(%ebp),%eax
  800a32:	50                   	push   %eax
  800a33:	e8 e7 fb ff ff       	call   80061f <getuint>
  800a38:	83 c4 10             	add    $0x10,%esp
  800a3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a41:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a48:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a4f:	83 ec 04             	sub    $0x4,%esp
  800a52:	52                   	push   %edx
  800a53:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a56:	50                   	push   %eax
  800a57:	ff 75 f4             	pushl  -0xc(%ebp)
  800a5a:	ff 75 f0             	pushl  -0x10(%ebp)
  800a5d:	ff 75 0c             	pushl  0xc(%ebp)
  800a60:	ff 75 08             	pushl  0x8(%ebp)
  800a63:	e8 00 fb ff ff       	call   800568 <printnum>
  800a68:	83 c4 20             	add    $0x20,%esp
			break;
  800a6b:	eb 34                	jmp    800aa1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a6d:	83 ec 08             	sub    $0x8,%esp
  800a70:	ff 75 0c             	pushl  0xc(%ebp)
  800a73:	53                   	push   %ebx
  800a74:	8b 45 08             	mov    0x8(%ebp),%eax
  800a77:	ff d0                	call   *%eax
  800a79:	83 c4 10             	add    $0x10,%esp
			break;
  800a7c:	eb 23                	jmp    800aa1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a7e:	83 ec 08             	sub    $0x8,%esp
  800a81:	ff 75 0c             	pushl  0xc(%ebp)
  800a84:	6a 25                	push   $0x25
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	ff d0                	call   *%eax
  800a8b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a8e:	ff 4d 10             	decl   0x10(%ebp)
  800a91:	eb 03                	jmp    800a96 <vprintfmt+0x3b1>
  800a93:	ff 4d 10             	decl   0x10(%ebp)
  800a96:	8b 45 10             	mov    0x10(%ebp),%eax
  800a99:	48                   	dec    %eax
  800a9a:	8a 00                	mov    (%eax),%al
  800a9c:	3c 25                	cmp    $0x25,%al
  800a9e:	75 f3                	jne    800a93 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800aa0:	90                   	nop
		}
	}
  800aa1:	e9 47 fc ff ff       	jmp    8006ed <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800aa6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800aa7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800aaa:	5b                   	pop    %ebx
  800aab:	5e                   	pop    %esi
  800aac:	5d                   	pop    %ebp
  800aad:	c3                   	ret    

00800aae <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800aae:	55                   	push   %ebp
  800aaf:	89 e5                	mov    %esp,%ebp
  800ab1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ab4:	8d 45 10             	lea    0x10(%ebp),%eax
  800ab7:	83 c0 04             	add    $0x4,%eax
  800aba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800abd:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac0:	ff 75 f4             	pushl  -0xc(%ebp)
  800ac3:	50                   	push   %eax
  800ac4:	ff 75 0c             	pushl  0xc(%ebp)
  800ac7:	ff 75 08             	pushl  0x8(%ebp)
  800aca:	e8 16 fc ff ff       	call   8006e5 <vprintfmt>
  800acf:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ad2:	90                   	nop
  800ad3:	c9                   	leave  
  800ad4:	c3                   	ret    

00800ad5 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ad5:	55                   	push   %ebp
  800ad6:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ad8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adb:	8b 40 08             	mov    0x8(%eax),%eax
  800ade:	8d 50 01             	lea    0x1(%eax),%edx
  800ae1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae4:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ae7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aea:	8b 10                	mov    (%eax),%edx
  800aec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aef:	8b 40 04             	mov    0x4(%eax),%eax
  800af2:	39 c2                	cmp    %eax,%edx
  800af4:	73 12                	jae    800b08 <sprintputch+0x33>
		*b->buf++ = ch;
  800af6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af9:	8b 00                	mov    (%eax),%eax
  800afb:	8d 48 01             	lea    0x1(%eax),%ecx
  800afe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b01:	89 0a                	mov    %ecx,(%edx)
  800b03:	8b 55 08             	mov    0x8(%ebp),%edx
  800b06:	88 10                	mov    %dl,(%eax)
}
  800b08:	90                   	nop
  800b09:	5d                   	pop    %ebp
  800b0a:	c3                   	ret    

00800b0b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b0b:	55                   	push   %ebp
  800b0c:	89 e5                	mov    %esp,%ebp
  800b0e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b11:	8b 45 08             	mov    0x8(%ebp),%eax
  800b14:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	01 d0                	add    %edx,%eax
  800b22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b2c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b30:	74 06                	je     800b38 <vsnprintf+0x2d>
  800b32:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b36:	7f 07                	jg     800b3f <vsnprintf+0x34>
		return -E_INVAL;
  800b38:	b8 03 00 00 00       	mov    $0x3,%eax
  800b3d:	eb 20                	jmp    800b5f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b3f:	ff 75 14             	pushl  0x14(%ebp)
  800b42:	ff 75 10             	pushl  0x10(%ebp)
  800b45:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b48:	50                   	push   %eax
  800b49:	68 d5 0a 80 00       	push   $0x800ad5
  800b4e:	e8 92 fb ff ff       	call   8006e5 <vprintfmt>
  800b53:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b56:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b59:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b5f:	c9                   	leave  
  800b60:	c3                   	ret    

00800b61 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b61:	55                   	push   %ebp
  800b62:	89 e5                	mov    %esp,%ebp
  800b64:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b67:	8d 45 10             	lea    0x10(%ebp),%eax
  800b6a:	83 c0 04             	add    $0x4,%eax
  800b6d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b70:	8b 45 10             	mov    0x10(%ebp),%eax
  800b73:	ff 75 f4             	pushl  -0xc(%ebp)
  800b76:	50                   	push   %eax
  800b77:	ff 75 0c             	pushl  0xc(%ebp)
  800b7a:	ff 75 08             	pushl  0x8(%ebp)
  800b7d:	e8 89 ff ff ff       	call   800b0b <vsnprintf>
  800b82:	83 c4 10             	add    $0x10,%esp
  800b85:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b88:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b8b:	c9                   	leave  
  800b8c:	c3                   	ret    

00800b8d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b8d:	55                   	push   %ebp
  800b8e:	89 e5                	mov    %esp,%ebp
  800b90:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b93:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b9a:	eb 06                	jmp    800ba2 <strlen+0x15>
		n++;
  800b9c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b9f:	ff 45 08             	incl   0x8(%ebp)
  800ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba5:	8a 00                	mov    (%eax),%al
  800ba7:	84 c0                	test   %al,%al
  800ba9:	75 f1                	jne    800b9c <strlen+0xf>
		n++;
	return n;
  800bab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bae:	c9                   	leave  
  800baf:	c3                   	ret    

00800bb0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bb0:	55                   	push   %ebp
  800bb1:	89 e5                	mov    %esp,%ebp
  800bb3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bb6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bbd:	eb 09                	jmp    800bc8 <strnlen+0x18>
		n++;
  800bbf:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bc2:	ff 45 08             	incl   0x8(%ebp)
  800bc5:	ff 4d 0c             	decl   0xc(%ebp)
  800bc8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bcc:	74 09                	je     800bd7 <strnlen+0x27>
  800bce:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd1:	8a 00                	mov    (%eax),%al
  800bd3:	84 c0                	test   %al,%al
  800bd5:	75 e8                	jne    800bbf <strnlen+0xf>
		n++;
	return n;
  800bd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bda:	c9                   	leave  
  800bdb:	c3                   	ret    

00800bdc <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bdc:	55                   	push   %ebp
  800bdd:	89 e5                	mov    %esp,%ebp
  800bdf:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
  800be5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800be8:	90                   	nop
  800be9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bec:	8d 50 01             	lea    0x1(%eax),%edx
  800bef:	89 55 08             	mov    %edx,0x8(%ebp)
  800bf2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bf8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bfb:	8a 12                	mov    (%edx),%dl
  800bfd:	88 10                	mov    %dl,(%eax)
  800bff:	8a 00                	mov    (%eax),%al
  800c01:	84 c0                	test   %al,%al
  800c03:	75 e4                	jne    800be9 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c05:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c08:	c9                   	leave  
  800c09:	c3                   	ret    

00800c0a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c0a:	55                   	push   %ebp
  800c0b:	89 e5                	mov    %esp,%ebp
  800c0d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c16:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c1d:	eb 1f                	jmp    800c3e <strncpy+0x34>
		*dst++ = *src;
  800c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c22:	8d 50 01             	lea    0x1(%eax),%edx
  800c25:	89 55 08             	mov    %edx,0x8(%ebp)
  800c28:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c2b:	8a 12                	mov    (%edx),%dl
  800c2d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c32:	8a 00                	mov    (%eax),%al
  800c34:	84 c0                	test   %al,%al
  800c36:	74 03                	je     800c3b <strncpy+0x31>
			src++;
  800c38:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c3b:	ff 45 fc             	incl   -0x4(%ebp)
  800c3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c41:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c44:	72 d9                	jb     800c1f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c46:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c49:	c9                   	leave  
  800c4a:	c3                   	ret    

00800c4b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c4b:	55                   	push   %ebp
  800c4c:	89 e5                	mov    %esp,%ebp
  800c4e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c51:	8b 45 08             	mov    0x8(%ebp),%eax
  800c54:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c57:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c5b:	74 30                	je     800c8d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c5d:	eb 16                	jmp    800c75 <strlcpy+0x2a>
			*dst++ = *src++;
  800c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c62:	8d 50 01             	lea    0x1(%eax),%edx
  800c65:	89 55 08             	mov    %edx,0x8(%ebp)
  800c68:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c6b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c6e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c71:	8a 12                	mov    (%edx),%dl
  800c73:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c75:	ff 4d 10             	decl   0x10(%ebp)
  800c78:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7c:	74 09                	je     800c87 <strlcpy+0x3c>
  800c7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c81:	8a 00                	mov    (%eax),%al
  800c83:	84 c0                	test   %al,%al
  800c85:	75 d8                	jne    800c5f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c8d:	8b 55 08             	mov    0x8(%ebp),%edx
  800c90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c93:	29 c2                	sub    %eax,%edx
  800c95:	89 d0                	mov    %edx,%eax
}
  800c97:	c9                   	leave  
  800c98:	c3                   	ret    

00800c99 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c99:	55                   	push   %ebp
  800c9a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c9c:	eb 06                	jmp    800ca4 <strcmp+0xb>
		p++, q++;
  800c9e:	ff 45 08             	incl   0x8(%ebp)
  800ca1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	8a 00                	mov    (%eax),%al
  800ca9:	84 c0                	test   %al,%al
  800cab:	74 0e                	je     800cbb <strcmp+0x22>
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	8a 10                	mov    (%eax),%dl
  800cb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb5:	8a 00                	mov    (%eax),%al
  800cb7:	38 c2                	cmp    %al,%dl
  800cb9:	74 e3                	je     800c9e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	8a 00                	mov    (%eax),%al
  800cc0:	0f b6 d0             	movzbl %al,%edx
  800cc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc6:	8a 00                	mov    (%eax),%al
  800cc8:	0f b6 c0             	movzbl %al,%eax
  800ccb:	29 c2                	sub    %eax,%edx
  800ccd:	89 d0                	mov    %edx,%eax
}
  800ccf:	5d                   	pop    %ebp
  800cd0:	c3                   	ret    

00800cd1 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cd1:	55                   	push   %ebp
  800cd2:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cd4:	eb 09                	jmp    800cdf <strncmp+0xe>
		n--, p++, q++;
  800cd6:	ff 4d 10             	decl   0x10(%ebp)
  800cd9:	ff 45 08             	incl   0x8(%ebp)
  800cdc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cdf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce3:	74 17                	je     800cfc <strncmp+0x2b>
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	84 c0                	test   %al,%al
  800cec:	74 0e                	je     800cfc <strncmp+0x2b>
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	8a 10                	mov    (%eax),%dl
  800cf3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf6:	8a 00                	mov    (%eax),%al
  800cf8:	38 c2                	cmp    %al,%dl
  800cfa:	74 da                	je     800cd6 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cfc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d00:	75 07                	jne    800d09 <strncmp+0x38>
		return 0;
  800d02:	b8 00 00 00 00       	mov    $0x0,%eax
  800d07:	eb 14                	jmp    800d1d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	8a 00                	mov    (%eax),%al
  800d0e:	0f b6 d0             	movzbl %al,%edx
  800d11:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d14:	8a 00                	mov    (%eax),%al
  800d16:	0f b6 c0             	movzbl %al,%eax
  800d19:	29 c2                	sub    %eax,%edx
  800d1b:	89 d0                	mov    %edx,%eax
}
  800d1d:	5d                   	pop    %ebp
  800d1e:	c3                   	ret    

00800d1f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d1f:	55                   	push   %ebp
  800d20:	89 e5                	mov    %esp,%ebp
  800d22:	83 ec 04             	sub    $0x4,%esp
  800d25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d28:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d2b:	eb 12                	jmp    800d3f <strchr+0x20>
		if (*s == c)
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	8a 00                	mov    (%eax),%al
  800d32:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d35:	75 05                	jne    800d3c <strchr+0x1d>
			return (char *) s;
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	eb 11                	jmp    800d4d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d3c:	ff 45 08             	incl   0x8(%ebp)
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	8a 00                	mov    (%eax),%al
  800d44:	84 c0                	test   %al,%al
  800d46:	75 e5                	jne    800d2d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d48:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d4d:	c9                   	leave  
  800d4e:	c3                   	ret    

00800d4f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d4f:	55                   	push   %ebp
  800d50:	89 e5                	mov    %esp,%ebp
  800d52:	83 ec 04             	sub    $0x4,%esp
  800d55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d58:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d5b:	eb 0d                	jmp    800d6a <strfind+0x1b>
		if (*s == c)
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	8a 00                	mov    (%eax),%al
  800d62:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d65:	74 0e                	je     800d75 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d67:	ff 45 08             	incl   0x8(%ebp)
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	8a 00                	mov    (%eax),%al
  800d6f:	84 c0                	test   %al,%al
  800d71:	75 ea                	jne    800d5d <strfind+0xe>
  800d73:	eb 01                	jmp    800d76 <strfind+0x27>
		if (*s == c)
			break;
  800d75:	90                   	nop
	return (char *) s;
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d79:	c9                   	leave  
  800d7a:	c3                   	ret    

00800d7b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d7b:	55                   	push   %ebp
  800d7c:	89 e5                	mov    %esp,%ebp
  800d7e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d87:	8b 45 10             	mov    0x10(%ebp),%eax
  800d8a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d8d:	eb 0e                	jmp    800d9d <memset+0x22>
		*p++ = c;
  800d8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d92:	8d 50 01             	lea    0x1(%eax),%edx
  800d95:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d98:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d9b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d9d:	ff 4d f8             	decl   -0x8(%ebp)
  800da0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800da4:	79 e9                	jns    800d8f <memset+0x14>
		*p++ = c;

	return v;
  800da6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800da9:	c9                   	leave  
  800daa:	c3                   	ret    

00800dab <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800dab:	55                   	push   %ebp
  800dac:	89 e5                	mov    %esp,%ebp
  800dae:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800db1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800db7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dba:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800dbd:	eb 16                	jmp    800dd5 <memcpy+0x2a>
		*d++ = *s++;
  800dbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc2:	8d 50 01             	lea    0x1(%eax),%edx
  800dc5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dc8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dcb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dce:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dd1:	8a 12                	mov    (%edx),%dl
  800dd3:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ddb:	89 55 10             	mov    %edx,0x10(%ebp)
  800dde:	85 c0                	test   %eax,%eax
  800de0:	75 dd                	jne    800dbf <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800de2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800de5:	c9                   	leave  
  800de6:	c3                   	ret    

00800de7 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800de7:	55                   	push   %ebp
  800de8:	89 e5                	mov    %esp,%ebp
  800dea:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ded:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800df9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dfc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dff:	73 50                	jae    800e51 <memmove+0x6a>
  800e01:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e04:	8b 45 10             	mov    0x10(%ebp),%eax
  800e07:	01 d0                	add    %edx,%eax
  800e09:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e0c:	76 43                	jbe    800e51 <memmove+0x6a>
		s += n;
  800e0e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e11:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e14:	8b 45 10             	mov    0x10(%ebp),%eax
  800e17:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e1a:	eb 10                	jmp    800e2c <memmove+0x45>
			*--d = *--s;
  800e1c:	ff 4d f8             	decl   -0x8(%ebp)
  800e1f:	ff 4d fc             	decl   -0x4(%ebp)
  800e22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e25:	8a 10                	mov    (%eax),%dl
  800e27:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e32:	89 55 10             	mov    %edx,0x10(%ebp)
  800e35:	85 c0                	test   %eax,%eax
  800e37:	75 e3                	jne    800e1c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e39:	eb 23                	jmp    800e5e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3e:	8d 50 01             	lea    0x1(%eax),%edx
  800e41:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e44:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e47:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e4a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e4d:	8a 12                	mov    (%edx),%dl
  800e4f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e51:	8b 45 10             	mov    0x10(%ebp),%eax
  800e54:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e57:	89 55 10             	mov    %edx,0x10(%ebp)
  800e5a:	85 c0                	test   %eax,%eax
  800e5c:	75 dd                	jne    800e3b <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e61:	c9                   	leave  
  800e62:	c3                   	ret    

00800e63 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e63:	55                   	push   %ebp
  800e64:	89 e5                	mov    %esp,%ebp
  800e66:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e72:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e75:	eb 2a                	jmp    800ea1 <memcmp+0x3e>
		if (*s1 != *s2)
  800e77:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7a:	8a 10                	mov    (%eax),%dl
  800e7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e7f:	8a 00                	mov    (%eax),%al
  800e81:	38 c2                	cmp    %al,%dl
  800e83:	74 16                	je     800e9b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e85:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e88:	8a 00                	mov    (%eax),%al
  800e8a:	0f b6 d0             	movzbl %al,%edx
  800e8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e90:	8a 00                	mov    (%eax),%al
  800e92:	0f b6 c0             	movzbl %al,%eax
  800e95:	29 c2                	sub    %eax,%edx
  800e97:	89 d0                	mov    %edx,%eax
  800e99:	eb 18                	jmp    800eb3 <memcmp+0x50>
		s1++, s2++;
  800e9b:	ff 45 fc             	incl   -0x4(%ebp)
  800e9e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ea1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ea7:	89 55 10             	mov    %edx,0x10(%ebp)
  800eaa:	85 c0                	test   %eax,%eax
  800eac:	75 c9                	jne    800e77 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800eae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800eb3:	c9                   	leave  
  800eb4:	c3                   	ret    

00800eb5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800eb5:	55                   	push   %ebp
  800eb6:	89 e5                	mov    %esp,%ebp
  800eb8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ebb:	8b 55 08             	mov    0x8(%ebp),%edx
  800ebe:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec1:	01 d0                	add    %edx,%eax
  800ec3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ec6:	eb 15                	jmp    800edd <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ec8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecb:	8a 00                	mov    (%eax),%al
  800ecd:	0f b6 d0             	movzbl %al,%edx
  800ed0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed3:	0f b6 c0             	movzbl %al,%eax
  800ed6:	39 c2                	cmp    %eax,%edx
  800ed8:	74 0d                	je     800ee7 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800eda:	ff 45 08             	incl   0x8(%ebp)
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ee3:	72 e3                	jb     800ec8 <memfind+0x13>
  800ee5:	eb 01                	jmp    800ee8 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ee7:	90                   	nop
	return (void *) s;
  800ee8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eeb:	c9                   	leave  
  800eec:	c3                   	ret    

00800eed <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800eed:	55                   	push   %ebp
  800eee:	89 e5                	mov    %esp,%ebp
  800ef0:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ef3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800efa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f01:	eb 03                	jmp    800f06 <strtol+0x19>
		s++;
  800f03:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
  800f09:	8a 00                	mov    (%eax),%al
  800f0b:	3c 20                	cmp    $0x20,%al
  800f0d:	74 f4                	je     800f03 <strtol+0x16>
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	8a 00                	mov    (%eax),%al
  800f14:	3c 09                	cmp    $0x9,%al
  800f16:	74 eb                	je     800f03 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	3c 2b                	cmp    $0x2b,%al
  800f1f:	75 05                	jne    800f26 <strtol+0x39>
		s++;
  800f21:	ff 45 08             	incl   0x8(%ebp)
  800f24:	eb 13                	jmp    800f39 <strtol+0x4c>
	else if (*s == '-')
  800f26:	8b 45 08             	mov    0x8(%ebp),%eax
  800f29:	8a 00                	mov    (%eax),%al
  800f2b:	3c 2d                	cmp    $0x2d,%al
  800f2d:	75 0a                	jne    800f39 <strtol+0x4c>
		s++, neg = 1;
  800f2f:	ff 45 08             	incl   0x8(%ebp)
  800f32:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f39:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3d:	74 06                	je     800f45 <strtol+0x58>
  800f3f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f43:	75 20                	jne    800f65 <strtol+0x78>
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	3c 30                	cmp    $0x30,%al
  800f4c:	75 17                	jne    800f65 <strtol+0x78>
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	40                   	inc    %eax
  800f52:	8a 00                	mov    (%eax),%al
  800f54:	3c 78                	cmp    $0x78,%al
  800f56:	75 0d                	jne    800f65 <strtol+0x78>
		s += 2, base = 16;
  800f58:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f5c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f63:	eb 28                	jmp    800f8d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f65:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f69:	75 15                	jne    800f80 <strtol+0x93>
  800f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6e:	8a 00                	mov    (%eax),%al
  800f70:	3c 30                	cmp    $0x30,%al
  800f72:	75 0c                	jne    800f80 <strtol+0x93>
		s++, base = 8;
  800f74:	ff 45 08             	incl   0x8(%ebp)
  800f77:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f7e:	eb 0d                	jmp    800f8d <strtol+0xa0>
	else if (base == 0)
  800f80:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f84:	75 07                	jne    800f8d <strtol+0xa0>
		base = 10;
  800f86:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	3c 2f                	cmp    $0x2f,%al
  800f94:	7e 19                	jle    800faf <strtol+0xc2>
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	3c 39                	cmp    $0x39,%al
  800f9d:	7f 10                	jg     800faf <strtol+0xc2>
			dig = *s - '0';
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	8a 00                	mov    (%eax),%al
  800fa4:	0f be c0             	movsbl %al,%eax
  800fa7:	83 e8 30             	sub    $0x30,%eax
  800faa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fad:	eb 42                	jmp    800ff1 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	8a 00                	mov    (%eax),%al
  800fb4:	3c 60                	cmp    $0x60,%al
  800fb6:	7e 19                	jle    800fd1 <strtol+0xe4>
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	3c 7a                	cmp    $0x7a,%al
  800fbf:	7f 10                	jg     800fd1 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	8a 00                	mov    (%eax),%al
  800fc6:	0f be c0             	movsbl %al,%eax
  800fc9:	83 e8 57             	sub    $0x57,%eax
  800fcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fcf:	eb 20                	jmp    800ff1 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	3c 40                	cmp    $0x40,%al
  800fd8:	7e 39                	jle    801013 <strtol+0x126>
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	3c 5a                	cmp    $0x5a,%al
  800fe1:	7f 30                	jg     801013 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	0f be c0             	movsbl %al,%eax
  800feb:	83 e8 37             	sub    $0x37,%eax
  800fee:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800ff1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ff4:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ff7:	7d 19                	jge    801012 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800ff9:	ff 45 08             	incl   0x8(%ebp)
  800ffc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fff:	0f af 45 10          	imul   0x10(%ebp),%eax
  801003:	89 c2                	mov    %eax,%edx
  801005:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801008:	01 d0                	add    %edx,%eax
  80100a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80100d:	e9 7b ff ff ff       	jmp    800f8d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801012:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801013:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801017:	74 08                	je     801021 <strtol+0x134>
		*endptr = (char *) s;
  801019:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101c:	8b 55 08             	mov    0x8(%ebp),%edx
  80101f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801021:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801025:	74 07                	je     80102e <strtol+0x141>
  801027:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80102a:	f7 d8                	neg    %eax
  80102c:	eb 03                	jmp    801031 <strtol+0x144>
  80102e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801031:	c9                   	leave  
  801032:	c3                   	ret    

00801033 <ltostr>:

void
ltostr(long value, char *str)
{
  801033:	55                   	push   %ebp
  801034:	89 e5                	mov    %esp,%ebp
  801036:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801039:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801040:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801047:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80104b:	79 13                	jns    801060 <ltostr+0x2d>
	{
		neg = 1;
  80104d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801054:	8b 45 0c             	mov    0xc(%ebp),%eax
  801057:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80105a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80105d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801068:	99                   	cltd   
  801069:	f7 f9                	idiv   %ecx
  80106b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80106e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801071:	8d 50 01             	lea    0x1(%eax),%edx
  801074:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801077:	89 c2                	mov    %eax,%edx
  801079:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107c:	01 d0                	add    %edx,%eax
  80107e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801081:	83 c2 30             	add    $0x30,%edx
  801084:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801086:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801089:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80108e:	f7 e9                	imul   %ecx
  801090:	c1 fa 02             	sar    $0x2,%edx
  801093:	89 c8                	mov    %ecx,%eax
  801095:	c1 f8 1f             	sar    $0x1f,%eax
  801098:	29 c2                	sub    %eax,%edx
  80109a:	89 d0                	mov    %edx,%eax
  80109c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80109f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010a2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010a7:	f7 e9                	imul   %ecx
  8010a9:	c1 fa 02             	sar    $0x2,%edx
  8010ac:	89 c8                	mov    %ecx,%eax
  8010ae:	c1 f8 1f             	sar    $0x1f,%eax
  8010b1:	29 c2                	sub    %eax,%edx
  8010b3:	89 d0                	mov    %edx,%eax
  8010b5:	c1 e0 02             	shl    $0x2,%eax
  8010b8:	01 d0                	add    %edx,%eax
  8010ba:	01 c0                	add    %eax,%eax
  8010bc:	29 c1                	sub    %eax,%ecx
  8010be:	89 ca                	mov    %ecx,%edx
  8010c0:	85 d2                	test   %edx,%edx
  8010c2:	75 9c                	jne    801060 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ce:	48                   	dec    %eax
  8010cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010d2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010d6:	74 3d                	je     801115 <ltostr+0xe2>
		start = 1 ;
  8010d8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010df:	eb 34                	jmp    801115 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e7:	01 d0                	add    %edx,%eax
  8010e9:	8a 00                	mov    (%eax),%al
  8010eb:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f4:	01 c2                	add    %eax,%edx
  8010f6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fc:	01 c8                	add    %ecx,%eax
  8010fe:	8a 00                	mov    (%eax),%al
  801100:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801102:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801105:	8b 45 0c             	mov    0xc(%ebp),%eax
  801108:	01 c2                	add    %eax,%edx
  80110a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80110d:	88 02                	mov    %al,(%edx)
		start++ ;
  80110f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801112:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801115:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801118:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80111b:	7c c4                	jl     8010e1 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80111d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801120:	8b 45 0c             	mov    0xc(%ebp),%eax
  801123:	01 d0                	add    %edx,%eax
  801125:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801128:	90                   	nop
  801129:	c9                   	leave  
  80112a:	c3                   	ret    

0080112b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80112b:	55                   	push   %ebp
  80112c:	89 e5                	mov    %esp,%ebp
  80112e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801131:	ff 75 08             	pushl  0x8(%ebp)
  801134:	e8 54 fa ff ff       	call   800b8d <strlen>
  801139:	83 c4 04             	add    $0x4,%esp
  80113c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80113f:	ff 75 0c             	pushl  0xc(%ebp)
  801142:	e8 46 fa ff ff       	call   800b8d <strlen>
  801147:	83 c4 04             	add    $0x4,%esp
  80114a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80114d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801154:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80115b:	eb 17                	jmp    801174 <strcconcat+0x49>
		final[s] = str1[s] ;
  80115d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801160:	8b 45 10             	mov    0x10(%ebp),%eax
  801163:	01 c2                	add    %eax,%edx
  801165:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801168:	8b 45 08             	mov    0x8(%ebp),%eax
  80116b:	01 c8                	add    %ecx,%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801171:	ff 45 fc             	incl   -0x4(%ebp)
  801174:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801177:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80117a:	7c e1                	jl     80115d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80117c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801183:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80118a:	eb 1f                	jmp    8011ab <strcconcat+0x80>
		final[s++] = str2[i] ;
  80118c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80118f:	8d 50 01             	lea    0x1(%eax),%edx
  801192:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801195:	89 c2                	mov    %eax,%edx
  801197:	8b 45 10             	mov    0x10(%ebp),%eax
  80119a:	01 c2                	add    %eax,%edx
  80119c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80119f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a2:	01 c8                	add    %ecx,%eax
  8011a4:	8a 00                	mov    (%eax),%al
  8011a6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011a8:	ff 45 f8             	incl   -0x8(%ebp)
  8011ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ae:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011b1:	7c d9                	jl     80118c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011b3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b9:	01 d0                	add    %edx,%eax
  8011bb:	c6 00 00             	movb   $0x0,(%eax)
}
  8011be:	90                   	nop
  8011bf:	c9                   	leave  
  8011c0:	c3                   	ret    

008011c1 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011c1:	55                   	push   %ebp
  8011c2:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d0:	8b 00                	mov    (%eax),%eax
  8011d2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011dc:	01 d0                	add    %edx,%eax
  8011de:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011e4:	eb 0c                	jmp    8011f2 <strsplit+0x31>
			*string++ = 0;
  8011e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e9:	8d 50 01             	lea    0x1(%eax),%edx
  8011ec:	89 55 08             	mov    %edx,0x8(%ebp)
  8011ef:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f5:	8a 00                	mov    (%eax),%al
  8011f7:	84 c0                	test   %al,%al
  8011f9:	74 18                	je     801213 <strsplit+0x52>
  8011fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fe:	8a 00                	mov    (%eax),%al
  801200:	0f be c0             	movsbl %al,%eax
  801203:	50                   	push   %eax
  801204:	ff 75 0c             	pushl  0xc(%ebp)
  801207:	e8 13 fb ff ff       	call   800d1f <strchr>
  80120c:	83 c4 08             	add    $0x8,%esp
  80120f:	85 c0                	test   %eax,%eax
  801211:	75 d3                	jne    8011e6 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801213:	8b 45 08             	mov    0x8(%ebp),%eax
  801216:	8a 00                	mov    (%eax),%al
  801218:	84 c0                	test   %al,%al
  80121a:	74 5a                	je     801276 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80121c:	8b 45 14             	mov    0x14(%ebp),%eax
  80121f:	8b 00                	mov    (%eax),%eax
  801221:	83 f8 0f             	cmp    $0xf,%eax
  801224:	75 07                	jne    80122d <strsplit+0x6c>
		{
			return 0;
  801226:	b8 00 00 00 00       	mov    $0x0,%eax
  80122b:	eb 66                	jmp    801293 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80122d:	8b 45 14             	mov    0x14(%ebp),%eax
  801230:	8b 00                	mov    (%eax),%eax
  801232:	8d 48 01             	lea    0x1(%eax),%ecx
  801235:	8b 55 14             	mov    0x14(%ebp),%edx
  801238:	89 0a                	mov    %ecx,(%edx)
  80123a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801241:	8b 45 10             	mov    0x10(%ebp),%eax
  801244:	01 c2                	add    %eax,%edx
  801246:	8b 45 08             	mov    0x8(%ebp),%eax
  801249:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80124b:	eb 03                	jmp    801250 <strsplit+0x8f>
			string++;
  80124d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	8a 00                	mov    (%eax),%al
  801255:	84 c0                	test   %al,%al
  801257:	74 8b                	je     8011e4 <strsplit+0x23>
  801259:	8b 45 08             	mov    0x8(%ebp),%eax
  80125c:	8a 00                	mov    (%eax),%al
  80125e:	0f be c0             	movsbl %al,%eax
  801261:	50                   	push   %eax
  801262:	ff 75 0c             	pushl  0xc(%ebp)
  801265:	e8 b5 fa ff ff       	call   800d1f <strchr>
  80126a:	83 c4 08             	add    $0x8,%esp
  80126d:	85 c0                	test   %eax,%eax
  80126f:	74 dc                	je     80124d <strsplit+0x8c>
			string++;
	}
  801271:	e9 6e ff ff ff       	jmp    8011e4 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801276:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801277:	8b 45 14             	mov    0x14(%ebp),%eax
  80127a:	8b 00                	mov    (%eax),%eax
  80127c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801283:	8b 45 10             	mov    0x10(%ebp),%eax
  801286:	01 d0                	add    %edx,%eax
  801288:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80128e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801293:	c9                   	leave  
  801294:	c3                   	ret    

00801295 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801295:	55                   	push   %ebp
  801296:	89 e5                	mov    %esp,%ebp
  801298:	57                   	push   %edi
  801299:	56                   	push   %esi
  80129a:	53                   	push   %ebx
  80129b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80129e:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012a7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012aa:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012ad:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012b0:	cd 30                	int    $0x30
  8012b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012b8:	83 c4 10             	add    $0x10,%esp
  8012bb:	5b                   	pop    %ebx
  8012bc:	5e                   	pop    %esi
  8012bd:	5f                   	pop    %edi
  8012be:	5d                   	pop    %ebp
  8012bf:	c3                   	ret    

008012c0 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012c0:	55                   	push   %ebp
  8012c1:	89 e5                	mov    %esp,%ebp
  8012c3:	83 ec 04             	sub    $0x4,%esp
  8012c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012cc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d3:	6a 00                	push   $0x0
  8012d5:	6a 00                	push   $0x0
  8012d7:	52                   	push   %edx
  8012d8:	ff 75 0c             	pushl  0xc(%ebp)
  8012db:	50                   	push   %eax
  8012dc:	6a 00                	push   $0x0
  8012de:	e8 b2 ff ff ff       	call   801295 <syscall>
  8012e3:	83 c4 18             	add    $0x18,%esp
}
  8012e6:	90                   	nop
  8012e7:	c9                   	leave  
  8012e8:	c3                   	ret    

008012e9 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012e9:	55                   	push   %ebp
  8012ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 01                	push   $0x1
  8012f8:	e8 98 ff ff ff       	call   801295 <syscall>
  8012fd:	83 c4 18             	add    $0x18,%esp
}
  801300:	c9                   	leave  
  801301:	c3                   	ret    

00801302 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801305:	8b 45 08             	mov    0x8(%ebp),%eax
  801308:	6a 00                	push   $0x0
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	50                   	push   %eax
  801311:	6a 05                	push   $0x5
  801313:	e8 7d ff ff ff       	call   801295 <syscall>
  801318:	83 c4 18             	add    $0x18,%esp
}
  80131b:	c9                   	leave  
  80131c:	c3                   	ret    

0080131d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801320:	6a 00                	push   $0x0
  801322:	6a 00                	push   $0x0
  801324:	6a 00                	push   $0x0
  801326:	6a 00                	push   $0x0
  801328:	6a 00                	push   $0x0
  80132a:	6a 02                	push   $0x2
  80132c:	e8 64 ff ff ff       	call   801295 <syscall>
  801331:	83 c4 18             	add    $0x18,%esp
}
  801334:	c9                   	leave  
  801335:	c3                   	ret    

00801336 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801336:	55                   	push   %ebp
  801337:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	6a 03                	push   $0x3
  801345:	e8 4b ff ff ff       	call   801295 <syscall>
  80134a:	83 c4 18             	add    $0x18,%esp
}
  80134d:	c9                   	leave  
  80134e:	c3                   	ret    

0080134f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80134f:	55                   	push   %ebp
  801350:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	6a 00                	push   $0x0
  801358:	6a 00                	push   $0x0
  80135a:	6a 00                	push   $0x0
  80135c:	6a 04                	push   $0x4
  80135e:	e8 32 ff ff ff       	call   801295 <syscall>
  801363:	83 c4 18             	add    $0x18,%esp
}
  801366:	c9                   	leave  
  801367:	c3                   	ret    

00801368 <sys_env_exit>:


void sys_env_exit(void)
{
  801368:	55                   	push   %ebp
  801369:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80136b:	6a 00                	push   $0x0
  80136d:	6a 00                	push   $0x0
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	6a 00                	push   $0x0
  801375:	6a 06                	push   $0x6
  801377:	e8 19 ff ff ff       	call   801295 <syscall>
  80137c:	83 c4 18             	add    $0x18,%esp
}
  80137f:	90                   	nop
  801380:	c9                   	leave  
  801381:	c3                   	ret    

00801382 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801382:	55                   	push   %ebp
  801383:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801385:	8b 55 0c             	mov    0xc(%ebp),%edx
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	6a 00                	push   $0x0
  80138d:	6a 00                	push   $0x0
  80138f:	6a 00                	push   $0x0
  801391:	52                   	push   %edx
  801392:	50                   	push   %eax
  801393:	6a 07                	push   $0x7
  801395:	e8 fb fe ff ff       	call   801295 <syscall>
  80139a:	83 c4 18             	add    $0x18,%esp
}
  80139d:	c9                   	leave  
  80139e:	c3                   	ret    

0080139f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80139f:	55                   	push   %ebp
  8013a0:	89 e5                	mov    %esp,%ebp
  8013a2:	56                   	push   %esi
  8013a3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013a4:	8b 75 18             	mov    0x18(%ebp),%esi
  8013a7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013aa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	56                   	push   %esi
  8013b4:	53                   	push   %ebx
  8013b5:	51                   	push   %ecx
  8013b6:	52                   	push   %edx
  8013b7:	50                   	push   %eax
  8013b8:	6a 08                	push   $0x8
  8013ba:	e8 d6 fe ff ff       	call   801295 <syscall>
  8013bf:	83 c4 18             	add    $0x18,%esp
}
  8013c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013c5:	5b                   	pop    %ebx
  8013c6:	5e                   	pop    %esi
  8013c7:	5d                   	pop    %ebp
  8013c8:	c3                   	ret    

008013c9 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	52                   	push   %edx
  8013d9:	50                   	push   %eax
  8013da:	6a 09                	push   $0x9
  8013dc:	e8 b4 fe ff ff       	call   801295 <syscall>
  8013e1:	83 c4 18             	add    $0x18,%esp
}
  8013e4:	c9                   	leave  
  8013e5:	c3                   	ret    

008013e6 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013e6:	55                   	push   %ebp
  8013e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	ff 75 0c             	pushl  0xc(%ebp)
  8013f2:	ff 75 08             	pushl  0x8(%ebp)
  8013f5:	6a 0a                	push   $0xa
  8013f7:	e8 99 fe ff ff       	call   801295 <syscall>
  8013fc:	83 c4 18             	add    $0x18,%esp
}
  8013ff:	c9                   	leave  
  801400:	c3                   	ret    

00801401 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801401:	55                   	push   %ebp
  801402:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	6a 00                	push   $0x0
  80140e:	6a 0b                	push   $0xb
  801410:	e8 80 fe ff ff       	call   801295 <syscall>
  801415:	83 c4 18             	add    $0x18,%esp
}
  801418:	c9                   	leave  
  801419:	c3                   	ret    

0080141a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80141a:	55                   	push   %ebp
  80141b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 0c                	push   $0xc
  801429:	e8 67 fe ff ff       	call   801295 <syscall>
  80142e:	83 c4 18             	add    $0x18,%esp
}
  801431:	c9                   	leave  
  801432:	c3                   	ret    

00801433 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801433:	55                   	push   %ebp
  801434:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	6a 0d                	push   $0xd
  801442:	e8 4e fe ff ff       	call   801295 <syscall>
  801447:	83 c4 18             	add    $0x18,%esp
}
  80144a:	c9                   	leave  
  80144b:	c3                   	ret    

0080144c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80144c:	55                   	push   %ebp
  80144d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	ff 75 0c             	pushl  0xc(%ebp)
  801458:	ff 75 08             	pushl  0x8(%ebp)
  80145b:	6a 11                	push   $0x11
  80145d:	e8 33 fe ff ff       	call   801295 <syscall>
  801462:	83 c4 18             	add    $0x18,%esp
	return;
  801465:	90                   	nop
}
  801466:	c9                   	leave  
  801467:	c3                   	ret    

00801468 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801468:	55                   	push   %ebp
  801469:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80146b:	6a 00                	push   $0x0
  80146d:	6a 00                	push   $0x0
  80146f:	6a 00                	push   $0x0
  801471:	ff 75 0c             	pushl  0xc(%ebp)
  801474:	ff 75 08             	pushl  0x8(%ebp)
  801477:	6a 12                	push   $0x12
  801479:	e8 17 fe ff ff       	call   801295 <syscall>
  80147e:	83 c4 18             	add    $0x18,%esp
	return ;
  801481:	90                   	nop
}
  801482:	c9                   	leave  
  801483:	c3                   	ret    

00801484 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801484:	55                   	push   %ebp
  801485:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801487:	6a 00                	push   $0x0
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 0e                	push   $0xe
  801493:	e8 fd fd ff ff       	call   801295 <syscall>
  801498:	83 c4 18             	add    $0x18,%esp
}
  80149b:	c9                   	leave  
  80149c:	c3                   	ret    

0080149d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80149d:	55                   	push   %ebp
  80149e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	ff 75 08             	pushl  0x8(%ebp)
  8014ab:	6a 0f                	push   $0xf
  8014ad:	e8 e3 fd ff ff       	call   801295 <syscall>
  8014b2:	83 c4 18             	add    $0x18,%esp
}
  8014b5:	c9                   	leave  
  8014b6:	c3                   	ret    

008014b7 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014b7:	55                   	push   %ebp
  8014b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 10                	push   $0x10
  8014c6:	e8 ca fd ff ff       	call   801295 <syscall>
  8014cb:	83 c4 18             	add    $0x18,%esp
}
  8014ce:	90                   	nop
  8014cf:	c9                   	leave  
  8014d0:	c3                   	ret    

008014d1 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014d1:	55                   	push   %ebp
  8014d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 14                	push   $0x14
  8014e0:	e8 b0 fd ff ff       	call   801295 <syscall>
  8014e5:	83 c4 18             	add    $0x18,%esp
}
  8014e8:	90                   	nop
  8014e9:	c9                   	leave  
  8014ea:	c3                   	ret    

008014eb <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014eb:	55                   	push   %ebp
  8014ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 15                	push   $0x15
  8014fa:	e8 96 fd ff ff       	call   801295 <syscall>
  8014ff:	83 c4 18             	add    $0x18,%esp
}
  801502:	90                   	nop
  801503:	c9                   	leave  
  801504:	c3                   	ret    

00801505 <sys_cputc>:


void
sys_cputc(const char c)
{
  801505:	55                   	push   %ebp
  801506:	89 e5                	mov    %esp,%ebp
  801508:	83 ec 04             	sub    $0x4,%esp
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801511:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	50                   	push   %eax
  80151e:	6a 16                	push   $0x16
  801520:	e8 70 fd ff ff       	call   801295 <syscall>
  801525:	83 c4 18             	add    $0x18,%esp
}
  801528:	90                   	nop
  801529:	c9                   	leave  
  80152a:	c3                   	ret    

0080152b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 17                	push   $0x17
  80153a:	e8 56 fd ff ff       	call   801295 <syscall>
  80153f:	83 c4 18             	add    $0x18,%esp
}
  801542:	90                   	nop
  801543:	c9                   	leave  
  801544:	c3                   	ret    

00801545 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801548:	8b 45 08             	mov    0x8(%ebp),%eax
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	ff 75 0c             	pushl  0xc(%ebp)
  801554:	50                   	push   %eax
  801555:	6a 18                	push   $0x18
  801557:	e8 39 fd ff ff       	call   801295 <syscall>
  80155c:	83 c4 18             	add    $0x18,%esp
}
  80155f:	c9                   	leave  
  801560:	c3                   	ret    

00801561 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801561:	55                   	push   %ebp
  801562:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801564:	8b 55 0c             	mov    0xc(%ebp),%edx
  801567:	8b 45 08             	mov    0x8(%ebp),%eax
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	52                   	push   %edx
  801571:	50                   	push   %eax
  801572:	6a 1b                	push   $0x1b
  801574:	e8 1c fd ff ff       	call   801295 <syscall>
  801579:	83 c4 18             	add    $0x18,%esp
}
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801581:	8b 55 0c             	mov    0xc(%ebp),%edx
  801584:	8b 45 08             	mov    0x8(%ebp),%eax
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	52                   	push   %edx
  80158e:	50                   	push   %eax
  80158f:	6a 19                	push   $0x19
  801591:	e8 ff fc ff ff       	call   801295 <syscall>
  801596:	83 c4 18             	add    $0x18,%esp
}
  801599:	90                   	nop
  80159a:	c9                   	leave  
  80159b:	c3                   	ret    

0080159c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80159c:	55                   	push   %ebp
  80159d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80159f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	52                   	push   %edx
  8015ac:	50                   	push   %eax
  8015ad:	6a 1a                	push   $0x1a
  8015af:	e8 e1 fc ff ff       	call   801295 <syscall>
  8015b4:	83 c4 18             	add    $0x18,%esp
}
  8015b7:	90                   	nop
  8015b8:	c9                   	leave  
  8015b9:	c3                   	ret    

008015ba <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015ba:	55                   	push   %ebp
  8015bb:	89 e5                	mov    %esp,%ebp
  8015bd:	83 ec 04             	sub    $0x4,%esp
  8015c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c3:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015c6:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015c9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d0:	6a 00                	push   $0x0
  8015d2:	51                   	push   %ecx
  8015d3:	52                   	push   %edx
  8015d4:	ff 75 0c             	pushl  0xc(%ebp)
  8015d7:	50                   	push   %eax
  8015d8:	6a 1c                	push   $0x1c
  8015da:	e8 b6 fc ff ff       	call   801295 <syscall>
  8015df:	83 c4 18             	add    $0x18,%esp
}
  8015e2:	c9                   	leave  
  8015e3:	c3                   	ret    

008015e4 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015e4:	55                   	push   %ebp
  8015e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	52                   	push   %edx
  8015f4:	50                   	push   %eax
  8015f5:	6a 1d                	push   $0x1d
  8015f7:	e8 99 fc ff ff       	call   801295 <syscall>
  8015fc:	83 c4 18             	add    $0x18,%esp
}
  8015ff:	c9                   	leave  
  801600:	c3                   	ret    

00801601 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801601:	55                   	push   %ebp
  801602:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801604:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801607:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160a:	8b 45 08             	mov    0x8(%ebp),%eax
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	51                   	push   %ecx
  801612:	52                   	push   %edx
  801613:	50                   	push   %eax
  801614:	6a 1e                	push   $0x1e
  801616:	e8 7a fc ff ff       	call   801295 <syscall>
  80161b:	83 c4 18             	add    $0x18,%esp
}
  80161e:	c9                   	leave  
  80161f:	c3                   	ret    

00801620 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801620:	55                   	push   %ebp
  801621:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801623:	8b 55 0c             	mov    0xc(%ebp),%edx
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	52                   	push   %edx
  801630:	50                   	push   %eax
  801631:	6a 1f                	push   $0x1f
  801633:	e8 5d fc ff ff       	call   801295 <syscall>
  801638:	83 c4 18             	add    $0x18,%esp
}
  80163b:	c9                   	leave  
  80163c:	c3                   	ret    

0080163d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80163d:	55                   	push   %ebp
  80163e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 20                	push   $0x20
  80164c:	e8 44 fc ff ff       	call   801295 <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
}
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801659:	8b 45 08             	mov    0x8(%ebp),%eax
  80165c:	6a 00                	push   $0x0
  80165e:	ff 75 14             	pushl  0x14(%ebp)
  801661:	ff 75 10             	pushl  0x10(%ebp)
  801664:	ff 75 0c             	pushl  0xc(%ebp)
  801667:	50                   	push   %eax
  801668:	6a 21                	push   $0x21
  80166a:	e8 26 fc ff ff       	call   801295 <syscall>
  80166f:	83 c4 18             	add    $0x18,%esp
}
  801672:	c9                   	leave  
  801673:	c3                   	ret    

00801674 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801674:	55                   	push   %ebp
  801675:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	50                   	push   %eax
  801683:	6a 22                	push   $0x22
  801685:	e8 0b fc ff ff       	call   801295 <syscall>
  80168a:	83 c4 18             	add    $0x18,%esp
}
  80168d:	90                   	nop
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	50                   	push   %eax
  80169f:	6a 23                	push   $0x23
  8016a1:	e8 ef fb ff ff       	call   801295 <syscall>
  8016a6:	83 c4 18             	add    $0x18,%esp
}
  8016a9:	90                   	nop
  8016aa:	c9                   	leave  
  8016ab:	c3                   	ret    

008016ac <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016ac:	55                   	push   %ebp
  8016ad:	89 e5                	mov    %esp,%ebp
  8016af:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016b2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016b5:	8d 50 04             	lea    0x4(%eax),%edx
  8016b8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	52                   	push   %edx
  8016c2:	50                   	push   %eax
  8016c3:	6a 24                	push   $0x24
  8016c5:	e8 cb fb ff ff       	call   801295 <syscall>
  8016ca:	83 c4 18             	add    $0x18,%esp
	return result;
  8016cd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016d6:	89 01                	mov    %eax,(%ecx)
  8016d8:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
  8016de:	c9                   	leave  
  8016df:	c2 04 00             	ret    $0x4

008016e2 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	ff 75 10             	pushl  0x10(%ebp)
  8016ec:	ff 75 0c             	pushl  0xc(%ebp)
  8016ef:	ff 75 08             	pushl  0x8(%ebp)
  8016f2:	6a 13                	push   $0x13
  8016f4:	e8 9c fb ff ff       	call   801295 <syscall>
  8016f9:	83 c4 18             	add    $0x18,%esp
	return ;
  8016fc:	90                   	nop
}
  8016fd:	c9                   	leave  
  8016fe:	c3                   	ret    

008016ff <sys_rcr2>:
uint32 sys_rcr2()
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 25                	push   $0x25
  80170e:	e8 82 fb ff ff       	call   801295 <syscall>
  801713:	83 c4 18             	add    $0x18,%esp
}
  801716:	c9                   	leave  
  801717:	c3                   	ret    

00801718 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
  80171b:	83 ec 04             	sub    $0x4,%esp
  80171e:	8b 45 08             	mov    0x8(%ebp),%eax
  801721:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801724:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	50                   	push   %eax
  801731:	6a 26                	push   $0x26
  801733:	e8 5d fb ff ff       	call   801295 <syscall>
  801738:	83 c4 18             	add    $0x18,%esp
	return ;
  80173b:	90                   	nop
}
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <rsttst>:
void rsttst()
{
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 28                	push   $0x28
  80174d:	e8 43 fb ff ff       	call   801295 <syscall>
  801752:	83 c4 18             	add    $0x18,%esp
	return ;
  801755:	90                   	nop
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
  80175b:	83 ec 04             	sub    $0x4,%esp
  80175e:	8b 45 14             	mov    0x14(%ebp),%eax
  801761:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801764:	8b 55 18             	mov    0x18(%ebp),%edx
  801767:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80176b:	52                   	push   %edx
  80176c:	50                   	push   %eax
  80176d:	ff 75 10             	pushl  0x10(%ebp)
  801770:	ff 75 0c             	pushl  0xc(%ebp)
  801773:	ff 75 08             	pushl  0x8(%ebp)
  801776:	6a 27                	push   $0x27
  801778:	e8 18 fb ff ff       	call   801295 <syscall>
  80177d:	83 c4 18             	add    $0x18,%esp
	return ;
  801780:	90                   	nop
}
  801781:	c9                   	leave  
  801782:	c3                   	ret    

00801783 <chktst>:
void chktst(uint32 n)
{
  801783:	55                   	push   %ebp
  801784:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	ff 75 08             	pushl  0x8(%ebp)
  801791:	6a 29                	push   $0x29
  801793:	e8 fd fa ff ff       	call   801295 <syscall>
  801798:	83 c4 18             	add    $0x18,%esp
	return ;
  80179b:	90                   	nop
}
  80179c:	c9                   	leave  
  80179d:	c3                   	ret    

0080179e <inctst>:

void inctst()
{
  80179e:	55                   	push   %ebp
  80179f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 2a                	push   $0x2a
  8017ad:	e8 e3 fa ff ff       	call   801295 <syscall>
  8017b2:	83 c4 18             	add    $0x18,%esp
	return ;
  8017b5:	90                   	nop
}
  8017b6:	c9                   	leave  
  8017b7:	c3                   	ret    

008017b8 <gettst>:
uint32 gettst()
{
  8017b8:	55                   	push   %ebp
  8017b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 2b                	push   $0x2b
  8017c7:	e8 c9 fa ff ff       	call   801295 <syscall>
  8017cc:	83 c4 18             	add    $0x18,%esp
}
  8017cf:	c9                   	leave  
  8017d0:	c3                   	ret    

008017d1 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017d1:	55                   	push   %ebp
  8017d2:	89 e5                	mov    %esp,%ebp
  8017d4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 2c                	push   $0x2c
  8017e3:	e8 ad fa ff ff       	call   801295 <syscall>
  8017e8:	83 c4 18             	add    $0x18,%esp
  8017eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017ee:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017f2:	75 07                	jne    8017fb <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017f4:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f9:	eb 05                	jmp    801800 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801800:	c9                   	leave  
  801801:	c3                   	ret    

00801802 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801802:	55                   	push   %ebp
  801803:	89 e5                	mov    %esp,%ebp
  801805:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 2c                	push   $0x2c
  801814:	e8 7c fa ff ff       	call   801295 <syscall>
  801819:	83 c4 18             	add    $0x18,%esp
  80181c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80181f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801823:	75 07                	jne    80182c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801825:	b8 01 00 00 00       	mov    $0x1,%eax
  80182a:	eb 05                	jmp    801831 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80182c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
  801836:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 2c                	push   $0x2c
  801845:	e8 4b fa ff ff       	call   801295 <syscall>
  80184a:	83 c4 18             	add    $0x18,%esp
  80184d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801850:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801854:	75 07                	jne    80185d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801856:	b8 01 00 00 00       	mov    $0x1,%eax
  80185b:	eb 05                	jmp    801862 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80185d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801862:	c9                   	leave  
  801863:	c3                   	ret    

00801864 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
  801867:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 2c                	push   $0x2c
  801876:	e8 1a fa ff ff       	call   801295 <syscall>
  80187b:	83 c4 18             	add    $0x18,%esp
  80187e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801881:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801885:	75 07                	jne    80188e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801887:	b8 01 00 00 00       	mov    $0x1,%eax
  80188c:	eb 05                	jmp    801893 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80188e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801893:	c9                   	leave  
  801894:	c3                   	ret    

00801895 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801895:	55                   	push   %ebp
  801896:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	ff 75 08             	pushl  0x8(%ebp)
  8018a3:	6a 2d                	push   $0x2d
  8018a5:	e8 eb f9 ff ff       	call   801295 <syscall>
  8018aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ad:	90                   	nop
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
  8018b3:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018b4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c0:	6a 00                	push   $0x0
  8018c2:	53                   	push   %ebx
  8018c3:	51                   	push   %ecx
  8018c4:	52                   	push   %edx
  8018c5:	50                   	push   %eax
  8018c6:	6a 2e                	push   $0x2e
  8018c8:	e8 c8 f9 ff ff       	call   801295 <syscall>
  8018cd:	83 c4 18             	add    $0x18,%esp
}
  8018d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018d3:	c9                   	leave  
  8018d4:	c3                   	ret    

008018d5 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018d5:	55                   	push   %ebp
  8018d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018db:	8b 45 08             	mov    0x8(%ebp),%eax
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	52                   	push   %edx
  8018e5:	50                   	push   %eax
  8018e6:	6a 2f                	push   $0x2f
  8018e8:	e8 a8 f9 ff ff       	call   801295 <syscall>
  8018ed:	83 c4 18             	add    $0x18,%esp
}
  8018f0:	c9                   	leave  
  8018f1:	c3                   	ret    

008018f2 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8018f2:	55                   	push   %ebp
  8018f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	ff 75 0c             	pushl  0xc(%ebp)
  8018fe:	ff 75 08             	pushl  0x8(%ebp)
  801901:	6a 30                	push   $0x30
  801903:	e8 8d f9 ff ff       	call   801295 <syscall>
  801908:	83 c4 18             	add    $0x18,%esp
	return ;
  80190b:	90                   	nop
}
  80190c:	c9                   	leave  
  80190d:	c3                   	ret    
  80190e:	66 90                	xchg   %ax,%ax

00801910 <__udivdi3>:
  801910:	55                   	push   %ebp
  801911:	57                   	push   %edi
  801912:	56                   	push   %esi
  801913:	53                   	push   %ebx
  801914:	83 ec 1c             	sub    $0x1c,%esp
  801917:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80191b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80191f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801923:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801927:	89 ca                	mov    %ecx,%edx
  801929:	89 f8                	mov    %edi,%eax
  80192b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80192f:	85 f6                	test   %esi,%esi
  801931:	75 2d                	jne    801960 <__udivdi3+0x50>
  801933:	39 cf                	cmp    %ecx,%edi
  801935:	77 65                	ja     80199c <__udivdi3+0x8c>
  801937:	89 fd                	mov    %edi,%ebp
  801939:	85 ff                	test   %edi,%edi
  80193b:	75 0b                	jne    801948 <__udivdi3+0x38>
  80193d:	b8 01 00 00 00       	mov    $0x1,%eax
  801942:	31 d2                	xor    %edx,%edx
  801944:	f7 f7                	div    %edi
  801946:	89 c5                	mov    %eax,%ebp
  801948:	31 d2                	xor    %edx,%edx
  80194a:	89 c8                	mov    %ecx,%eax
  80194c:	f7 f5                	div    %ebp
  80194e:	89 c1                	mov    %eax,%ecx
  801950:	89 d8                	mov    %ebx,%eax
  801952:	f7 f5                	div    %ebp
  801954:	89 cf                	mov    %ecx,%edi
  801956:	89 fa                	mov    %edi,%edx
  801958:	83 c4 1c             	add    $0x1c,%esp
  80195b:	5b                   	pop    %ebx
  80195c:	5e                   	pop    %esi
  80195d:	5f                   	pop    %edi
  80195e:	5d                   	pop    %ebp
  80195f:	c3                   	ret    
  801960:	39 ce                	cmp    %ecx,%esi
  801962:	77 28                	ja     80198c <__udivdi3+0x7c>
  801964:	0f bd fe             	bsr    %esi,%edi
  801967:	83 f7 1f             	xor    $0x1f,%edi
  80196a:	75 40                	jne    8019ac <__udivdi3+0x9c>
  80196c:	39 ce                	cmp    %ecx,%esi
  80196e:	72 0a                	jb     80197a <__udivdi3+0x6a>
  801970:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801974:	0f 87 9e 00 00 00    	ja     801a18 <__udivdi3+0x108>
  80197a:	b8 01 00 00 00       	mov    $0x1,%eax
  80197f:	89 fa                	mov    %edi,%edx
  801981:	83 c4 1c             	add    $0x1c,%esp
  801984:	5b                   	pop    %ebx
  801985:	5e                   	pop    %esi
  801986:	5f                   	pop    %edi
  801987:	5d                   	pop    %ebp
  801988:	c3                   	ret    
  801989:	8d 76 00             	lea    0x0(%esi),%esi
  80198c:	31 ff                	xor    %edi,%edi
  80198e:	31 c0                	xor    %eax,%eax
  801990:	89 fa                	mov    %edi,%edx
  801992:	83 c4 1c             	add    $0x1c,%esp
  801995:	5b                   	pop    %ebx
  801996:	5e                   	pop    %esi
  801997:	5f                   	pop    %edi
  801998:	5d                   	pop    %ebp
  801999:	c3                   	ret    
  80199a:	66 90                	xchg   %ax,%ax
  80199c:	89 d8                	mov    %ebx,%eax
  80199e:	f7 f7                	div    %edi
  8019a0:	31 ff                	xor    %edi,%edi
  8019a2:	89 fa                	mov    %edi,%edx
  8019a4:	83 c4 1c             	add    $0x1c,%esp
  8019a7:	5b                   	pop    %ebx
  8019a8:	5e                   	pop    %esi
  8019a9:	5f                   	pop    %edi
  8019aa:	5d                   	pop    %ebp
  8019ab:	c3                   	ret    
  8019ac:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019b1:	89 eb                	mov    %ebp,%ebx
  8019b3:	29 fb                	sub    %edi,%ebx
  8019b5:	89 f9                	mov    %edi,%ecx
  8019b7:	d3 e6                	shl    %cl,%esi
  8019b9:	89 c5                	mov    %eax,%ebp
  8019bb:	88 d9                	mov    %bl,%cl
  8019bd:	d3 ed                	shr    %cl,%ebp
  8019bf:	89 e9                	mov    %ebp,%ecx
  8019c1:	09 f1                	or     %esi,%ecx
  8019c3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019c7:	89 f9                	mov    %edi,%ecx
  8019c9:	d3 e0                	shl    %cl,%eax
  8019cb:	89 c5                	mov    %eax,%ebp
  8019cd:	89 d6                	mov    %edx,%esi
  8019cf:	88 d9                	mov    %bl,%cl
  8019d1:	d3 ee                	shr    %cl,%esi
  8019d3:	89 f9                	mov    %edi,%ecx
  8019d5:	d3 e2                	shl    %cl,%edx
  8019d7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019db:	88 d9                	mov    %bl,%cl
  8019dd:	d3 e8                	shr    %cl,%eax
  8019df:	09 c2                	or     %eax,%edx
  8019e1:	89 d0                	mov    %edx,%eax
  8019e3:	89 f2                	mov    %esi,%edx
  8019e5:	f7 74 24 0c          	divl   0xc(%esp)
  8019e9:	89 d6                	mov    %edx,%esi
  8019eb:	89 c3                	mov    %eax,%ebx
  8019ed:	f7 e5                	mul    %ebp
  8019ef:	39 d6                	cmp    %edx,%esi
  8019f1:	72 19                	jb     801a0c <__udivdi3+0xfc>
  8019f3:	74 0b                	je     801a00 <__udivdi3+0xf0>
  8019f5:	89 d8                	mov    %ebx,%eax
  8019f7:	31 ff                	xor    %edi,%edi
  8019f9:	e9 58 ff ff ff       	jmp    801956 <__udivdi3+0x46>
  8019fe:	66 90                	xchg   %ax,%ax
  801a00:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a04:	89 f9                	mov    %edi,%ecx
  801a06:	d3 e2                	shl    %cl,%edx
  801a08:	39 c2                	cmp    %eax,%edx
  801a0a:	73 e9                	jae    8019f5 <__udivdi3+0xe5>
  801a0c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a0f:	31 ff                	xor    %edi,%edi
  801a11:	e9 40 ff ff ff       	jmp    801956 <__udivdi3+0x46>
  801a16:	66 90                	xchg   %ax,%ax
  801a18:	31 c0                	xor    %eax,%eax
  801a1a:	e9 37 ff ff ff       	jmp    801956 <__udivdi3+0x46>
  801a1f:	90                   	nop

00801a20 <__umoddi3>:
  801a20:	55                   	push   %ebp
  801a21:	57                   	push   %edi
  801a22:	56                   	push   %esi
  801a23:	53                   	push   %ebx
  801a24:	83 ec 1c             	sub    $0x1c,%esp
  801a27:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a2b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a33:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a37:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a3b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a3f:	89 f3                	mov    %esi,%ebx
  801a41:	89 fa                	mov    %edi,%edx
  801a43:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a47:	89 34 24             	mov    %esi,(%esp)
  801a4a:	85 c0                	test   %eax,%eax
  801a4c:	75 1a                	jne    801a68 <__umoddi3+0x48>
  801a4e:	39 f7                	cmp    %esi,%edi
  801a50:	0f 86 a2 00 00 00    	jbe    801af8 <__umoddi3+0xd8>
  801a56:	89 c8                	mov    %ecx,%eax
  801a58:	89 f2                	mov    %esi,%edx
  801a5a:	f7 f7                	div    %edi
  801a5c:	89 d0                	mov    %edx,%eax
  801a5e:	31 d2                	xor    %edx,%edx
  801a60:	83 c4 1c             	add    $0x1c,%esp
  801a63:	5b                   	pop    %ebx
  801a64:	5e                   	pop    %esi
  801a65:	5f                   	pop    %edi
  801a66:	5d                   	pop    %ebp
  801a67:	c3                   	ret    
  801a68:	39 f0                	cmp    %esi,%eax
  801a6a:	0f 87 ac 00 00 00    	ja     801b1c <__umoddi3+0xfc>
  801a70:	0f bd e8             	bsr    %eax,%ebp
  801a73:	83 f5 1f             	xor    $0x1f,%ebp
  801a76:	0f 84 ac 00 00 00    	je     801b28 <__umoddi3+0x108>
  801a7c:	bf 20 00 00 00       	mov    $0x20,%edi
  801a81:	29 ef                	sub    %ebp,%edi
  801a83:	89 fe                	mov    %edi,%esi
  801a85:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a89:	89 e9                	mov    %ebp,%ecx
  801a8b:	d3 e0                	shl    %cl,%eax
  801a8d:	89 d7                	mov    %edx,%edi
  801a8f:	89 f1                	mov    %esi,%ecx
  801a91:	d3 ef                	shr    %cl,%edi
  801a93:	09 c7                	or     %eax,%edi
  801a95:	89 e9                	mov    %ebp,%ecx
  801a97:	d3 e2                	shl    %cl,%edx
  801a99:	89 14 24             	mov    %edx,(%esp)
  801a9c:	89 d8                	mov    %ebx,%eax
  801a9e:	d3 e0                	shl    %cl,%eax
  801aa0:	89 c2                	mov    %eax,%edx
  801aa2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aa6:	d3 e0                	shl    %cl,%eax
  801aa8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801aac:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ab0:	89 f1                	mov    %esi,%ecx
  801ab2:	d3 e8                	shr    %cl,%eax
  801ab4:	09 d0                	or     %edx,%eax
  801ab6:	d3 eb                	shr    %cl,%ebx
  801ab8:	89 da                	mov    %ebx,%edx
  801aba:	f7 f7                	div    %edi
  801abc:	89 d3                	mov    %edx,%ebx
  801abe:	f7 24 24             	mull   (%esp)
  801ac1:	89 c6                	mov    %eax,%esi
  801ac3:	89 d1                	mov    %edx,%ecx
  801ac5:	39 d3                	cmp    %edx,%ebx
  801ac7:	0f 82 87 00 00 00    	jb     801b54 <__umoddi3+0x134>
  801acd:	0f 84 91 00 00 00    	je     801b64 <__umoddi3+0x144>
  801ad3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ad7:	29 f2                	sub    %esi,%edx
  801ad9:	19 cb                	sbb    %ecx,%ebx
  801adb:	89 d8                	mov    %ebx,%eax
  801add:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ae1:	d3 e0                	shl    %cl,%eax
  801ae3:	89 e9                	mov    %ebp,%ecx
  801ae5:	d3 ea                	shr    %cl,%edx
  801ae7:	09 d0                	or     %edx,%eax
  801ae9:	89 e9                	mov    %ebp,%ecx
  801aeb:	d3 eb                	shr    %cl,%ebx
  801aed:	89 da                	mov    %ebx,%edx
  801aef:	83 c4 1c             	add    $0x1c,%esp
  801af2:	5b                   	pop    %ebx
  801af3:	5e                   	pop    %esi
  801af4:	5f                   	pop    %edi
  801af5:	5d                   	pop    %ebp
  801af6:	c3                   	ret    
  801af7:	90                   	nop
  801af8:	89 fd                	mov    %edi,%ebp
  801afa:	85 ff                	test   %edi,%edi
  801afc:	75 0b                	jne    801b09 <__umoddi3+0xe9>
  801afe:	b8 01 00 00 00       	mov    $0x1,%eax
  801b03:	31 d2                	xor    %edx,%edx
  801b05:	f7 f7                	div    %edi
  801b07:	89 c5                	mov    %eax,%ebp
  801b09:	89 f0                	mov    %esi,%eax
  801b0b:	31 d2                	xor    %edx,%edx
  801b0d:	f7 f5                	div    %ebp
  801b0f:	89 c8                	mov    %ecx,%eax
  801b11:	f7 f5                	div    %ebp
  801b13:	89 d0                	mov    %edx,%eax
  801b15:	e9 44 ff ff ff       	jmp    801a5e <__umoddi3+0x3e>
  801b1a:	66 90                	xchg   %ax,%ax
  801b1c:	89 c8                	mov    %ecx,%eax
  801b1e:	89 f2                	mov    %esi,%edx
  801b20:	83 c4 1c             	add    $0x1c,%esp
  801b23:	5b                   	pop    %ebx
  801b24:	5e                   	pop    %esi
  801b25:	5f                   	pop    %edi
  801b26:	5d                   	pop    %ebp
  801b27:	c3                   	ret    
  801b28:	3b 04 24             	cmp    (%esp),%eax
  801b2b:	72 06                	jb     801b33 <__umoddi3+0x113>
  801b2d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b31:	77 0f                	ja     801b42 <__umoddi3+0x122>
  801b33:	89 f2                	mov    %esi,%edx
  801b35:	29 f9                	sub    %edi,%ecx
  801b37:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b3b:	89 14 24             	mov    %edx,(%esp)
  801b3e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b42:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b46:	8b 14 24             	mov    (%esp),%edx
  801b49:	83 c4 1c             	add    $0x1c,%esp
  801b4c:	5b                   	pop    %ebx
  801b4d:	5e                   	pop    %esi
  801b4e:	5f                   	pop    %edi
  801b4f:	5d                   	pop    %ebp
  801b50:	c3                   	ret    
  801b51:	8d 76 00             	lea    0x0(%esi),%esi
  801b54:	2b 04 24             	sub    (%esp),%eax
  801b57:	19 fa                	sbb    %edi,%edx
  801b59:	89 d1                	mov    %edx,%ecx
  801b5b:	89 c6                	mov    %eax,%esi
  801b5d:	e9 71 ff ff ff       	jmp    801ad3 <__umoddi3+0xb3>
  801b62:	66 90                	xchg   %ax,%ax
  801b64:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b68:	72 ea                	jb     801b54 <__umoddi3+0x134>
  801b6a:	89 d9                	mov    %ebx,%ecx
  801b6c:	e9 62 ff ff ff       	jmp    801ad3 <__umoddi3+0xb3>
