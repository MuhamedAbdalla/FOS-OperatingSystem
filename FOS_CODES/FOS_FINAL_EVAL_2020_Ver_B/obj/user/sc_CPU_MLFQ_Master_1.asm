
obj/user/sc_CPU_MLFQ_Master_1:     file format elf32-i386


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
  800031:	e8 8b 00 00 00       	call   8000c1 <libmain>
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
			ID = sys_create_env("tmlfq_1", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
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
  80006a:	68 c0 1b 80 00       	push   $0x801bc0
  80006f:	e8 74 15 00 00       	call   8015e8 <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)
			if (ID == E_ENV_CREATION_ERROR)
  80007a:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  80007e:	75 14                	jne    800094 <_main+0x5c>
				panic("RUNNING OUT OF ENV!! terminating...");
  800080:	83 ec 04             	sub    $0x4,%esp
  800083:	68 c8 1b 80 00       	push   $0x801bc8
  800088:	6a 0a                	push   $0xa
  80008a:	68 ec 1b 80 00       	push   $0x801bec
  80008f:	e8 52 01 00 00       	call   8001e6 <_panic>
			sys_run_env(ID);
  800094:	83 ec 0c             	sub    $0xc,%esp
  800097:	ff 75 f0             	pushl  -0x10(%ebp)
  80009a:	e8 67 15 00 00       	call   801606 <sys_run_env>
  80009f:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 5; ++i) {
  8000a2:	ff 45 f4             	incl   -0xc(%ebp)
  8000a5:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
  8000a9:	7e 9c                	jle    800047 <_main+0xf>
				panic("RUNNING OUT OF ENV!! terminating...");
			sys_run_env(ID);
		}

		//env_sleep(80000);
		int x = busy_wait(50000000);
  8000ab:	83 ec 0c             	sub    $0xc,%esp
  8000ae:	68 80 f0 fa 02       	push   $0x2faf080
  8000b3:	e8 7d 18 00 00       	call   801935 <busy_wait>
  8000b8:	83 c4 10             	add    $0x10,%esp
  8000bb:	89 45 ec             	mov    %eax,-0x14(%ebp)

}
  8000be:	90                   	nop
  8000bf:	c9                   	leave  
  8000c0:	c3                   	ret    

008000c1 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000c1:	55                   	push   %ebp
  8000c2:	89 e5                	mov    %esp,%ebp
  8000c4:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000c7:	e8 fc 11 00 00       	call   8012c8 <sys_getenvindex>
  8000cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000d2:	89 d0                	mov    %edx,%eax
  8000d4:	c1 e0 03             	shl    $0x3,%eax
  8000d7:	01 d0                	add    %edx,%eax
  8000d9:	c1 e0 02             	shl    $0x2,%eax
  8000dc:	01 d0                	add    %edx,%eax
  8000de:	c1 e0 06             	shl    $0x6,%eax
  8000e1:	29 d0                	sub    %edx,%eax
  8000e3:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000ea:	01 c8                	add    %ecx,%eax
  8000ec:	01 d0                	add    %edx,%eax
  8000ee:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000f3:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000fd:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  800103:	84 c0                	test   %al,%al
  800105:	74 0f                	je     800116 <libmain+0x55>
		binaryname = myEnv->prog_name;
  800107:	a1 20 30 80 00       	mov    0x803020,%eax
  80010c:	05 b0 52 00 00       	add    $0x52b0,%eax
  800111:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800116:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80011a:	7e 0a                	jle    800126 <libmain+0x65>
		binaryname = argv[0];
  80011c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80011f:	8b 00                	mov    (%eax),%eax
  800121:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800126:	83 ec 08             	sub    $0x8,%esp
  800129:	ff 75 0c             	pushl  0xc(%ebp)
  80012c:	ff 75 08             	pushl  0x8(%ebp)
  80012f:	e8 04 ff ff ff       	call   800038 <_main>
  800134:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800137:	e8 27 13 00 00       	call   801463 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80013c:	83 ec 0c             	sub    $0xc,%esp
  80013f:	68 20 1c 80 00       	push   $0x801c20
  800144:	e8 54 03 00 00       	call   80049d <cprintf>
  800149:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80014c:	a1 20 30 80 00       	mov    0x803020,%eax
  800151:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800157:	a1 20 30 80 00       	mov    0x803020,%eax
  80015c:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800162:	83 ec 04             	sub    $0x4,%esp
  800165:	52                   	push   %edx
  800166:	50                   	push   %eax
  800167:	68 48 1c 80 00       	push   $0x801c48
  80016c:	e8 2c 03 00 00       	call   80049d <cprintf>
  800171:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800174:	a1 20 30 80 00       	mov    0x803020,%eax
  800179:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  80018a:	a1 20 30 80 00       	mov    0x803020,%eax
  80018f:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800195:	51                   	push   %ecx
  800196:	52                   	push   %edx
  800197:	50                   	push   %eax
  800198:	68 70 1c 80 00       	push   $0x801c70
  80019d:	e8 fb 02 00 00       	call   80049d <cprintf>
  8001a2:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8001a5:	83 ec 0c             	sub    $0xc,%esp
  8001a8:	68 20 1c 80 00       	push   $0x801c20
  8001ad:	e8 eb 02 00 00       	call   80049d <cprintf>
  8001b2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001b5:	e8 c3 12 00 00       	call   80147d <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001ba:	e8 19 00 00 00       	call   8001d8 <exit>
}
  8001bf:	90                   	nop
  8001c0:	c9                   	leave  
  8001c1:	c3                   	ret    

008001c2 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001c2:	55                   	push   %ebp
  8001c3:	89 e5                	mov    %esp,%ebp
  8001c5:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001c8:	83 ec 0c             	sub    $0xc,%esp
  8001cb:	6a 00                	push   $0x0
  8001cd:	e8 c2 10 00 00       	call   801294 <sys_env_destroy>
  8001d2:	83 c4 10             	add    $0x10,%esp
}
  8001d5:	90                   	nop
  8001d6:	c9                   	leave  
  8001d7:	c3                   	ret    

008001d8 <exit>:

void
exit(void)
{
  8001d8:	55                   	push   %ebp
  8001d9:	89 e5                	mov    %esp,%ebp
  8001db:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001de:	e8 17 11 00 00       	call   8012fa <sys_env_exit>
}
  8001e3:	90                   	nop
  8001e4:	c9                   	leave  
  8001e5:	c3                   	ret    

008001e6 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8001e6:	55                   	push   %ebp
  8001e7:	89 e5                	mov    %esp,%ebp
  8001e9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8001ec:	8d 45 10             	lea    0x10(%ebp),%eax
  8001ef:	83 c0 04             	add    $0x4,%eax
  8001f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8001f5:	a1 18 31 80 00       	mov    0x803118,%eax
  8001fa:	85 c0                	test   %eax,%eax
  8001fc:	74 16                	je     800214 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8001fe:	a1 18 31 80 00       	mov    0x803118,%eax
  800203:	83 ec 08             	sub    $0x8,%esp
  800206:	50                   	push   %eax
  800207:	68 c8 1c 80 00       	push   $0x801cc8
  80020c:	e8 8c 02 00 00       	call   80049d <cprintf>
  800211:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800214:	a1 00 30 80 00       	mov    0x803000,%eax
  800219:	ff 75 0c             	pushl  0xc(%ebp)
  80021c:	ff 75 08             	pushl  0x8(%ebp)
  80021f:	50                   	push   %eax
  800220:	68 cd 1c 80 00       	push   $0x801ccd
  800225:	e8 73 02 00 00       	call   80049d <cprintf>
  80022a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80022d:	8b 45 10             	mov    0x10(%ebp),%eax
  800230:	83 ec 08             	sub    $0x8,%esp
  800233:	ff 75 f4             	pushl  -0xc(%ebp)
  800236:	50                   	push   %eax
  800237:	e8 f6 01 00 00       	call   800432 <vcprintf>
  80023c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80023f:	83 ec 08             	sub    $0x8,%esp
  800242:	6a 00                	push   $0x0
  800244:	68 e9 1c 80 00       	push   $0x801ce9
  800249:	e8 e4 01 00 00       	call   800432 <vcprintf>
  80024e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800251:	e8 82 ff ff ff       	call   8001d8 <exit>

	// should not return here
	while (1) ;
  800256:	eb fe                	jmp    800256 <_panic+0x70>

00800258 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800258:	55                   	push   %ebp
  800259:	89 e5                	mov    %esp,%ebp
  80025b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80025e:	a1 20 30 80 00       	mov    0x803020,%eax
  800263:	8b 50 74             	mov    0x74(%eax),%edx
  800266:	8b 45 0c             	mov    0xc(%ebp),%eax
  800269:	39 c2                	cmp    %eax,%edx
  80026b:	74 14                	je     800281 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80026d:	83 ec 04             	sub    $0x4,%esp
  800270:	68 ec 1c 80 00       	push   $0x801cec
  800275:	6a 26                	push   $0x26
  800277:	68 38 1d 80 00       	push   $0x801d38
  80027c:	e8 65 ff ff ff       	call   8001e6 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800281:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800288:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80028f:	e9 c4 00 00 00       	jmp    800358 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800294:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800297:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80029e:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a1:	01 d0                	add    %edx,%eax
  8002a3:	8b 00                	mov    (%eax),%eax
  8002a5:	85 c0                	test   %eax,%eax
  8002a7:	75 08                	jne    8002b1 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8002a9:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8002ac:	e9 a4 00 00 00       	jmp    800355 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8002b1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002b8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002bf:	eb 6b                	jmp    80032c <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8002c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c6:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8002cc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002cf:	89 d0                	mov    %edx,%eax
  8002d1:	c1 e0 02             	shl    $0x2,%eax
  8002d4:	01 d0                	add    %edx,%eax
  8002d6:	c1 e0 02             	shl    $0x2,%eax
  8002d9:	01 c8                	add    %ecx,%eax
  8002db:	8a 40 04             	mov    0x4(%eax),%al
  8002de:	84 c0                	test   %al,%al
  8002e0:	75 47                	jne    800329 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e7:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8002ed:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002f0:	89 d0                	mov    %edx,%eax
  8002f2:	c1 e0 02             	shl    $0x2,%eax
  8002f5:	01 d0                	add    %edx,%eax
  8002f7:	c1 e0 02             	shl    $0x2,%eax
  8002fa:	01 c8                	add    %ecx,%eax
  8002fc:	8b 00                	mov    (%eax),%eax
  8002fe:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800301:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800304:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800309:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80030b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80030e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800315:	8b 45 08             	mov    0x8(%ebp),%eax
  800318:	01 c8                	add    %ecx,%eax
  80031a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80031c:	39 c2                	cmp    %eax,%edx
  80031e:	75 09                	jne    800329 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800320:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800327:	eb 12                	jmp    80033b <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800329:	ff 45 e8             	incl   -0x18(%ebp)
  80032c:	a1 20 30 80 00       	mov    0x803020,%eax
  800331:	8b 50 74             	mov    0x74(%eax),%edx
  800334:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800337:	39 c2                	cmp    %eax,%edx
  800339:	77 86                	ja     8002c1 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80033b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80033f:	75 14                	jne    800355 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800341:	83 ec 04             	sub    $0x4,%esp
  800344:	68 44 1d 80 00       	push   $0x801d44
  800349:	6a 3a                	push   $0x3a
  80034b:	68 38 1d 80 00       	push   $0x801d38
  800350:	e8 91 fe ff ff       	call   8001e6 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800355:	ff 45 f0             	incl   -0x10(%ebp)
  800358:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80035b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80035e:	0f 8c 30 ff ff ff    	jl     800294 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800364:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80036b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800372:	eb 27                	jmp    80039b <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800374:	a1 20 30 80 00       	mov    0x803020,%eax
  800379:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80037f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800382:	89 d0                	mov    %edx,%eax
  800384:	c1 e0 02             	shl    $0x2,%eax
  800387:	01 d0                	add    %edx,%eax
  800389:	c1 e0 02             	shl    $0x2,%eax
  80038c:	01 c8                	add    %ecx,%eax
  80038e:	8a 40 04             	mov    0x4(%eax),%al
  800391:	3c 01                	cmp    $0x1,%al
  800393:	75 03                	jne    800398 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800395:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800398:	ff 45 e0             	incl   -0x20(%ebp)
  80039b:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a0:	8b 50 74             	mov    0x74(%eax),%edx
  8003a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003a6:	39 c2                	cmp    %eax,%edx
  8003a8:	77 ca                	ja     800374 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8003aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ad:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8003b0:	74 14                	je     8003c6 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8003b2:	83 ec 04             	sub    $0x4,%esp
  8003b5:	68 98 1d 80 00       	push   $0x801d98
  8003ba:	6a 44                	push   $0x44
  8003bc:	68 38 1d 80 00       	push   $0x801d38
  8003c1:	e8 20 fe ff ff       	call   8001e6 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8003c6:	90                   	nop
  8003c7:	c9                   	leave  
  8003c8:	c3                   	ret    

008003c9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8003c9:	55                   	push   %ebp
  8003ca:	89 e5                	mov    %esp,%ebp
  8003cc:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8003cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003d2:	8b 00                	mov    (%eax),%eax
  8003d4:	8d 48 01             	lea    0x1(%eax),%ecx
  8003d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003da:	89 0a                	mov    %ecx,(%edx)
  8003dc:	8b 55 08             	mov    0x8(%ebp),%edx
  8003df:	88 d1                	mov    %dl,%cl
  8003e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003e4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8003e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003eb:	8b 00                	mov    (%eax),%eax
  8003ed:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003f2:	75 2c                	jne    800420 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8003f4:	a0 24 30 80 00       	mov    0x803024,%al
  8003f9:	0f b6 c0             	movzbl %al,%eax
  8003fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003ff:	8b 12                	mov    (%edx),%edx
  800401:	89 d1                	mov    %edx,%ecx
  800403:	8b 55 0c             	mov    0xc(%ebp),%edx
  800406:	83 c2 08             	add    $0x8,%edx
  800409:	83 ec 04             	sub    $0x4,%esp
  80040c:	50                   	push   %eax
  80040d:	51                   	push   %ecx
  80040e:	52                   	push   %edx
  80040f:	e8 3e 0e 00 00       	call   801252 <sys_cputs>
  800414:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800417:	8b 45 0c             	mov    0xc(%ebp),%eax
  80041a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800420:	8b 45 0c             	mov    0xc(%ebp),%eax
  800423:	8b 40 04             	mov    0x4(%eax),%eax
  800426:	8d 50 01             	lea    0x1(%eax),%edx
  800429:	8b 45 0c             	mov    0xc(%ebp),%eax
  80042c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80042f:	90                   	nop
  800430:	c9                   	leave  
  800431:	c3                   	ret    

00800432 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800432:	55                   	push   %ebp
  800433:	89 e5                	mov    %esp,%ebp
  800435:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80043b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800442:	00 00 00 
	b.cnt = 0;
  800445:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80044c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80044f:	ff 75 0c             	pushl  0xc(%ebp)
  800452:	ff 75 08             	pushl  0x8(%ebp)
  800455:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80045b:	50                   	push   %eax
  80045c:	68 c9 03 80 00       	push   $0x8003c9
  800461:	e8 11 02 00 00       	call   800677 <vprintfmt>
  800466:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800469:	a0 24 30 80 00       	mov    0x803024,%al
  80046e:	0f b6 c0             	movzbl %al,%eax
  800471:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800477:	83 ec 04             	sub    $0x4,%esp
  80047a:	50                   	push   %eax
  80047b:	52                   	push   %edx
  80047c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800482:	83 c0 08             	add    $0x8,%eax
  800485:	50                   	push   %eax
  800486:	e8 c7 0d 00 00       	call   801252 <sys_cputs>
  80048b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80048e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800495:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80049b:	c9                   	leave  
  80049c:	c3                   	ret    

0080049d <cprintf>:

int cprintf(const char *fmt, ...) {
  80049d:	55                   	push   %ebp
  80049e:	89 e5                	mov    %esp,%ebp
  8004a0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004a3:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8004aa:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b3:	83 ec 08             	sub    $0x8,%esp
  8004b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8004b9:	50                   	push   %eax
  8004ba:	e8 73 ff ff ff       	call   800432 <vcprintf>
  8004bf:	83 c4 10             	add    $0x10,%esp
  8004c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8004c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004c8:	c9                   	leave  
  8004c9:	c3                   	ret    

008004ca <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8004ca:	55                   	push   %ebp
  8004cb:	89 e5                	mov    %esp,%ebp
  8004cd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8004d0:	e8 8e 0f 00 00       	call   801463 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8004d5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004db:	8b 45 08             	mov    0x8(%ebp),%eax
  8004de:	83 ec 08             	sub    $0x8,%esp
  8004e1:	ff 75 f4             	pushl  -0xc(%ebp)
  8004e4:	50                   	push   %eax
  8004e5:	e8 48 ff ff ff       	call   800432 <vcprintf>
  8004ea:	83 c4 10             	add    $0x10,%esp
  8004ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8004f0:	e8 88 0f 00 00       	call   80147d <sys_enable_interrupt>
	return cnt;
  8004f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004f8:	c9                   	leave  
  8004f9:	c3                   	ret    

008004fa <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004fa:	55                   	push   %ebp
  8004fb:	89 e5                	mov    %esp,%ebp
  8004fd:	53                   	push   %ebx
  8004fe:	83 ec 14             	sub    $0x14,%esp
  800501:	8b 45 10             	mov    0x10(%ebp),%eax
  800504:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800507:	8b 45 14             	mov    0x14(%ebp),%eax
  80050a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80050d:	8b 45 18             	mov    0x18(%ebp),%eax
  800510:	ba 00 00 00 00       	mov    $0x0,%edx
  800515:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800518:	77 55                	ja     80056f <printnum+0x75>
  80051a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80051d:	72 05                	jb     800524 <printnum+0x2a>
  80051f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800522:	77 4b                	ja     80056f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800524:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800527:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80052a:	8b 45 18             	mov    0x18(%ebp),%eax
  80052d:	ba 00 00 00 00       	mov    $0x0,%edx
  800532:	52                   	push   %edx
  800533:	50                   	push   %eax
  800534:	ff 75 f4             	pushl  -0xc(%ebp)
  800537:	ff 75 f0             	pushl  -0x10(%ebp)
  80053a:	e8 15 14 00 00       	call   801954 <__udivdi3>
  80053f:	83 c4 10             	add    $0x10,%esp
  800542:	83 ec 04             	sub    $0x4,%esp
  800545:	ff 75 20             	pushl  0x20(%ebp)
  800548:	53                   	push   %ebx
  800549:	ff 75 18             	pushl  0x18(%ebp)
  80054c:	52                   	push   %edx
  80054d:	50                   	push   %eax
  80054e:	ff 75 0c             	pushl  0xc(%ebp)
  800551:	ff 75 08             	pushl  0x8(%ebp)
  800554:	e8 a1 ff ff ff       	call   8004fa <printnum>
  800559:	83 c4 20             	add    $0x20,%esp
  80055c:	eb 1a                	jmp    800578 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80055e:	83 ec 08             	sub    $0x8,%esp
  800561:	ff 75 0c             	pushl  0xc(%ebp)
  800564:	ff 75 20             	pushl  0x20(%ebp)
  800567:	8b 45 08             	mov    0x8(%ebp),%eax
  80056a:	ff d0                	call   *%eax
  80056c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80056f:	ff 4d 1c             	decl   0x1c(%ebp)
  800572:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800576:	7f e6                	jg     80055e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800578:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80057b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800580:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800583:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800586:	53                   	push   %ebx
  800587:	51                   	push   %ecx
  800588:	52                   	push   %edx
  800589:	50                   	push   %eax
  80058a:	e8 d5 14 00 00       	call   801a64 <__umoddi3>
  80058f:	83 c4 10             	add    $0x10,%esp
  800592:	05 14 20 80 00       	add    $0x802014,%eax
  800597:	8a 00                	mov    (%eax),%al
  800599:	0f be c0             	movsbl %al,%eax
  80059c:	83 ec 08             	sub    $0x8,%esp
  80059f:	ff 75 0c             	pushl  0xc(%ebp)
  8005a2:	50                   	push   %eax
  8005a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a6:	ff d0                	call   *%eax
  8005a8:	83 c4 10             	add    $0x10,%esp
}
  8005ab:	90                   	nop
  8005ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005af:	c9                   	leave  
  8005b0:	c3                   	ret    

008005b1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8005b1:	55                   	push   %ebp
  8005b2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005b4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005b8:	7e 1c                	jle    8005d6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8005ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bd:	8b 00                	mov    (%eax),%eax
  8005bf:	8d 50 08             	lea    0x8(%eax),%edx
  8005c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c5:	89 10                	mov    %edx,(%eax)
  8005c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ca:	8b 00                	mov    (%eax),%eax
  8005cc:	83 e8 08             	sub    $0x8,%eax
  8005cf:	8b 50 04             	mov    0x4(%eax),%edx
  8005d2:	8b 00                	mov    (%eax),%eax
  8005d4:	eb 40                	jmp    800616 <getuint+0x65>
	else if (lflag)
  8005d6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005da:	74 1e                	je     8005fa <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005df:	8b 00                	mov    (%eax),%eax
  8005e1:	8d 50 04             	lea    0x4(%eax),%edx
  8005e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e7:	89 10                	mov    %edx,(%eax)
  8005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ec:	8b 00                	mov    (%eax),%eax
  8005ee:	83 e8 04             	sub    $0x4,%eax
  8005f1:	8b 00                	mov    (%eax),%eax
  8005f3:	ba 00 00 00 00       	mov    $0x0,%edx
  8005f8:	eb 1c                	jmp    800616 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fd:	8b 00                	mov    (%eax),%eax
  8005ff:	8d 50 04             	lea    0x4(%eax),%edx
  800602:	8b 45 08             	mov    0x8(%ebp),%eax
  800605:	89 10                	mov    %edx,(%eax)
  800607:	8b 45 08             	mov    0x8(%ebp),%eax
  80060a:	8b 00                	mov    (%eax),%eax
  80060c:	83 e8 04             	sub    $0x4,%eax
  80060f:	8b 00                	mov    (%eax),%eax
  800611:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800616:	5d                   	pop    %ebp
  800617:	c3                   	ret    

00800618 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800618:	55                   	push   %ebp
  800619:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80061b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80061f:	7e 1c                	jle    80063d <getint+0x25>
		return va_arg(*ap, long long);
  800621:	8b 45 08             	mov    0x8(%ebp),%eax
  800624:	8b 00                	mov    (%eax),%eax
  800626:	8d 50 08             	lea    0x8(%eax),%edx
  800629:	8b 45 08             	mov    0x8(%ebp),%eax
  80062c:	89 10                	mov    %edx,(%eax)
  80062e:	8b 45 08             	mov    0x8(%ebp),%eax
  800631:	8b 00                	mov    (%eax),%eax
  800633:	83 e8 08             	sub    $0x8,%eax
  800636:	8b 50 04             	mov    0x4(%eax),%edx
  800639:	8b 00                	mov    (%eax),%eax
  80063b:	eb 38                	jmp    800675 <getint+0x5d>
	else if (lflag)
  80063d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800641:	74 1a                	je     80065d <getint+0x45>
		return va_arg(*ap, long);
  800643:	8b 45 08             	mov    0x8(%ebp),%eax
  800646:	8b 00                	mov    (%eax),%eax
  800648:	8d 50 04             	lea    0x4(%eax),%edx
  80064b:	8b 45 08             	mov    0x8(%ebp),%eax
  80064e:	89 10                	mov    %edx,(%eax)
  800650:	8b 45 08             	mov    0x8(%ebp),%eax
  800653:	8b 00                	mov    (%eax),%eax
  800655:	83 e8 04             	sub    $0x4,%eax
  800658:	8b 00                	mov    (%eax),%eax
  80065a:	99                   	cltd   
  80065b:	eb 18                	jmp    800675 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80065d:	8b 45 08             	mov    0x8(%ebp),%eax
  800660:	8b 00                	mov    (%eax),%eax
  800662:	8d 50 04             	lea    0x4(%eax),%edx
  800665:	8b 45 08             	mov    0x8(%ebp),%eax
  800668:	89 10                	mov    %edx,(%eax)
  80066a:	8b 45 08             	mov    0x8(%ebp),%eax
  80066d:	8b 00                	mov    (%eax),%eax
  80066f:	83 e8 04             	sub    $0x4,%eax
  800672:	8b 00                	mov    (%eax),%eax
  800674:	99                   	cltd   
}
  800675:	5d                   	pop    %ebp
  800676:	c3                   	ret    

00800677 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800677:	55                   	push   %ebp
  800678:	89 e5                	mov    %esp,%ebp
  80067a:	56                   	push   %esi
  80067b:	53                   	push   %ebx
  80067c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80067f:	eb 17                	jmp    800698 <vprintfmt+0x21>
			if (ch == '\0')
  800681:	85 db                	test   %ebx,%ebx
  800683:	0f 84 af 03 00 00    	je     800a38 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800689:	83 ec 08             	sub    $0x8,%esp
  80068c:	ff 75 0c             	pushl  0xc(%ebp)
  80068f:	53                   	push   %ebx
  800690:	8b 45 08             	mov    0x8(%ebp),%eax
  800693:	ff d0                	call   *%eax
  800695:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800698:	8b 45 10             	mov    0x10(%ebp),%eax
  80069b:	8d 50 01             	lea    0x1(%eax),%edx
  80069e:	89 55 10             	mov    %edx,0x10(%ebp)
  8006a1:	8a 00                	mov    (%eax),%al
  8006a3:	0f b6 d8             	movzbl %al,%ebx
  8006a6:	83 fb 25             	cmp    $0x25,%ebx
  8006a9:	75 d6                	jne    800681 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8006ab:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8006af:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8006b6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8006bd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8006c4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8006cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8006ce:	8d 50 01             	lea    0x1(%eax),%edx
  8006d1:	89 55 10             	mov    %edx,0x10(%ebp)
  8006d4:	8a 00                	mov    (%eax),%al
  8006d6:	0f b6 d8             	movzbl %al,%ebx
  8006d9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006dc:	83 f8 55             	cmp    $0x55,%eax
  8006df:	0f 87 2b 03 00 00    	ja     800a10 <vprintfmt+0x399>
  8006e5:	8b 04 85 38 20 80 00 	mov    0x802038(,%eax,4),%eax
  8006ec:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006ee:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006f2:	eb d7                	jmp    8006cb <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006f4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006f8:	eb d1                	jmp    8006cb <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006fa:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800701:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800704:	89 d0                	mov    %edx,%eax
  800706:	c1 e0 02             	shl    $0x2,%eax
  800709:	01 d0                	add    %edx,%eax
  80070b:	01 c0                	add    %eax,%eax
  80070d:	01 d8                	add    %ebx,%eax
  80070f:	83 e8 30             	sub    $0x30,%eax
  800712:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800715:	8b 45 10             	mov    0x10(%ebp),%eax
  800718:	8a 00                	mov    (%eax),%al
  80071a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80071d:	83 fb 2f             	cmp    $0x2f,%ebx
  800720:	7e 3e                	jle    800760 <vprintfmt+0xe9>
  800722:	83 fb 39             	cmp    $0x39,%ebx
  800725:	7f 39                	jg     800760 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800727:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80072a:	eb d5                	jmp    800701 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80072c:	8b 45 14             	mov    0x14(%ebp),%eax
  80072f:	83 c0 04             	add    $0x4,%eax
  800732:	89 45 14             	mov    %eax,0x14(%ebp)
  800735:	8b 45 14             	mov    0x14(%ebp),%eax
  800738:	83 e8 04             	sub    $0x4,%eax
  80073b:	8b 00                	mov    (%eax),%eax
  80073d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800740:	eb 1f                	jmp    800761 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800742:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800746:	79 83                	jns    8006cb <vprintfmt+0x54>
				width = 0;
  800748:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80074f:	e9 77 ff ff ff       	jmp    8006cb <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800754:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80075b:	e9 6b ff ff ff       	jmp    8006cb <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800760:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800761:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800765:	0f 89 60 ff ff ff    	jns    8006cb <vprintfmt+0x54>
				width = precision, precision = -1;
  80076b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80076e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800771:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800778:	e9 4e ff ff ff       	jmp    8006cb <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80077d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800780:	e9 46 ff ff ff       	jmp    8006cb <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800785:	8b 45 14             	mov    0x14(%ebp),%eax
  800788:	83 c0 04             	add    $0x4,%eax
  80078b:	89 45 14             	mov    %eax,0x14(%ebp)
  80078e:	8b 45 14             	mov    0x14(%ebp),%eax
  800791:	83 e8 04             	sub    $0x4,%eax
  800794:	8b 00                	mov    (%eax),%eax
  800796:	83 ec 08             	sub    $0x8,%esp
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	50                   	push   %eax
  80079d:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a0:	ff d0                	call   *%eax
  8007a2:	83 c4 10             	add    $0x10,%esp
			break;
  8007a5:	e9 89 02 00 00       	jmp    800a33 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ad:	83 c0 04             	add    $0x4,%eax
  8007b0:	89 45 14             	mov    %eax,0x14(%ebp)
  8007b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b6:	83 e8 04             	sub    $0x4,%eax
  8007b9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8007bb:	85 db                	test   %ebx,%ebx
  8007bd:	79 02                	jns    8007c1 <vprintfmt+0x14a>
				err = -err;
  8007bf:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8007c1:	83 fb 64             	cmp    $0x64,%ebx
  8007c4:	7f 0b                	jg     8007d1 <vprintfmt+0x15a>
  8007c6:	8b 34 9d 80 1e 80 00 	mov    0x801e80(,%ebx,4),%esi
  8007cd:	85 f6                	test   %esi,%esi
  8007cf:	75 19                	jne    8007ea <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8007d1:	53                   	push   %ebx
  8007d2:	68 25 20 80 00       	push   $0x802025
  8007d7:	ff 75 0c             	pushl  0xc(%ebp)
  8007da:	ff 75 08             	pushl  0x8(%ebp)
  8007dd:	e8 5e 02 00 00       	call   800a40 <printfmt>
  8007e2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007e5:	e9 49 02 00 00       	jmp    800a33 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007ea:	56                   	push   %esi
  8007eb:	68 2e 20 80 00       	push   $0x80202e
  8007f0:	ff 75 0c             	pushl  0xc(%ebp)
  8007f3:	ff 75 08             	pushl  0x8(%ebp)
  8007f6:	e8 45 02 00 00       	call   800a40 <printfmt>
  8007fb:	83 c4 10             	add    $0x10,%esp
			break;
  8007fe:	e9 30 02 00 00       	jmp    800a33 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800803:	8b 45 14             	mov    0x14(%ebp),%eax
  800806:	83 c0 04             	add    $0x4,%eax
  800809:	89 45 14             	mov    %eax,0x14(%ebp)
  80080c:	8b 45 14             	mov    0x14(%ebp),%eax
  80080f:	83 e8 04             	sub    $0x4,%eax
  800812:	8b 30                	mov    (%eax),%esi
  800814:	85 f6                	test   %esi,%esi
  800816:	75 05                	jne    80081d <vprintfmt+0x1a6>
				p = "(null)";
  800818:	be 31 20 80 00       	mov    $0x802031,%esi
			if (width > 0 && padc != '-')
  80081d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800821:	7e 6d                	jle    800890 <vprintfmt+0x219>
  800823:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800827:	74 67                	je     800890 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800829:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80082c:	83 ec 08             	sub    $0x8,%esp
  80082f:	50                   	push   %eax
  800830:	56                   	push   %esi
  800831:	e8 0c 03 00 00       	call   800b42 <strnlen>
  800836:	83 c4 10             	add    $0x10,%esp
  800839:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80083c:	eb 16                	jmp    800854 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80083e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800842:	83 ec 08             	sub    $0x8,%esp
  800845:	ff 75 0c             	pushl  0xc(%ebp)
  800848:	50                   	push   %eax
  800849:	8b 45 08             	mov    0x8(%ebp),%eax
  80084c:	ff d0                	call   *%eax
  80084e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800851:	ff 4d e4             	decl   -0x1c(%ebp)
  800854:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800858:	7f e4                	jg     80083e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80085a:	eb 34                	jmp    800890 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80085c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800860:	74 1c                	je     80087e <vprintfmt+0x207>
  800862:	83 fb 1f             	cmp    $0x1f,%ebx
  800865:	7e 05                	jle    80086c <vprintfmt+0x1f5>
  800867:	83 fb 7e             	cmp    $0x7e,%ebx
  80086a:	7e 12                	jle    80087e <vprintfmt+0x207>
					putch('?', putdat);
  80086c:	83 ec 08             	sub    $0x8,%esp
  80086f:	ff 75 0c             	pushl  0xc(%ebp)
  800872:	6a 3f                	push   $0x3f
  800874:	8b 45 08             	mov    0x8(%ebp),%eax
  800877:	ff d0                	call   *%eax
  800879:	83 c4 10             	add    $0x10,%esp
  80087c:	eb 0f                	jmp    80088d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80087e:	83 ec 08             	sub    $0x8,%esp
  800881:	ff 75 0c             	pushl  0xc(%ebp)
  800884:	53                   	push   %ebx
  800885:	8b 45 08             	mov    0x8(%ebp),%eax
  800888:	ff d0                	call   *%eax
  80088a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80088d:	ff 4d e4             	decl   -0x1c(%ebp)
  800890:	89 f0                	mov    %esi,%eax
  800892:	8d 70 01             	lea    0x1(%eax),%esi
  800895:	8a 00                	mov    (%eax),%al
  800897:	0f be d8             	movsbl %al,%ebx
  80089a:	85 db                	test   %ebx,%ebx
  80089c:	74 24                	je     8008c2 <vprintfmt+0x24b>
  80089e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008a2:	78 b8                	js     80085c <vprintfmt+0x1e5>
  8008a4:	ff 4d e0             	decl   -0x20(%ebp)
  8008a7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008ab:	79 af                	jns    80085c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008ad:	eb 13                	jmp    8008c2 <vprintfmt+0x24b>
				putch(' ', putdat);
  8008af:	83 ec 08             	sub    $0x8,%esp
  8008b2:	ff 75 0c             	pushl  0xc(%ebp)
  8008b5:	6a 20                	push   $0x20
  8008b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ba:	ff d0                	call   *%eax
  8008bc:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008bf:	ff 4d e4             	decl   -0x1c(%ebp)
  8008c2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008c6:	7f e7                	jg     8008af <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8008c8:	e9 66 01 00 00       	jmp    800a33 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8008cd:	83 ec 08             	sub    $0x8,%esp
  8008d0:	ff 75 e8             	pushl  -0x18(%ebp)
  8008d3:	8d 45 14             	lea    0x14(%ebp),%eax
  8008d6:	50                   	push   %eax
  8008d7:	e8 3c fd ff ff       	call   800618 <getint>
  8008dc:	83 c4 10             	add    $0x10,%esp
  8008df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008eb:	85 d2                	test   %edx,%edx
  8008ed:	79 23                	jns    800912 <vprintfmt+0x29b>
				putch('-', putdat);
  8008ef:	83 ec 08             	sub    $0x8,%esp
  8008f2:	ff 75 0c             	pushl  0xc(%ebp)
  8008f5:	6a 2d                	push   $0x2d
  8008f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fa:	ff d0                	call   *%eax
  8008fc:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800902:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800905:	f7 d8                	neg    %eax
  800907:	83 d2 00             	adc    $0x0,%edx
  80090a:	f7 da                	neg    %edx
  80090c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80090f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800912:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800919:	e9 bc 00 00 00       	jmp    8009da <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80091e:	83 ec 08             	sub    $0x8,%esp
  800921:	ff 75 e8             	pushl  -0x18(%ebp)
  800924:	8d 45 14             	lea    0x14(%ebp),%eax
  800927:	50                   	push   %eax
  800928:	e8 84 fc ff ff       	call   8005b1 <getuint>
  80092d:	83 c4 10             	add    $0x10,%esp
  800930:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800933:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800936:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80093d:	e9 98 00 00 00       	jmp    8009da <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800942:	83 ec 08             	sub    $0x8,%esp
  800945:	ff 75 0c             	pushl  0xc(%ebp)
  800948:	6a 58                	push   $0x58
  80094a:	8b 45 08             	mov    0x8(%ebp),%eax
  80094d:	ff d0                	call   *%eax
  80094f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800952:	83 ec 08             	sub    $0x8,%esp
  800955:	ff 75 0c             	pushl  0xc(%ebp)
  800958:	6a 58                	push   $0x58
  80095a:	8b 45 08             	mov    0x8(%ebp),%eax
  80095d:	ff d0                	call   *%eax
  80095f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800962:	83 ec 08             	sub    $0x8,%esp
  800965:	ff 75 0c             	pushl  0xc(%ebp)
  800968:	6a 58                	push   $0x58
  80096a:	8b 45 08             	mov    0x8(%ebp),%eax
  80096d:	ff d0                	call   *%eax
  80096f:	83 c4 10             	add    $0x10,%esp
			break;
  800972:	e9 bc 00 00 00       	jmp    800a33 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800977:	83 ec 08             	sub    $0x8,%esp
  80097a:	ff 75 0c             	pushl  0xc(%ebp)
  80097d:	6a 30                	push   $0x30
  80097f:	8b 45 08             	mov    0x8(%ebp),%eax
  800982:	ff d0                	call   *%eax
  800984:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800987:	83 ec 08             	sub    $0x8,%esp
  80098a:	ff 75 0c             	pushl  0xc(%ebp)
  80098d:	6a 78                	push   $0x78
  80098f:	8b 45 08             	mov    0x8(%ebp),%eax
  800992:	ff d0                	call   *%eax
  800994:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800997:	8b 45 14             	mov    0x14(%ebp),%eax
  80099a:	83 c0 04             	add    $0x4,%eax
  80099d:	89 45 14             	mov    %eax,0x14(%ebp)
  8009a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a3:	83 e8 04             	sub    $0x4,%eax
  8009a6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8009b2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8009b9:	eb 1f                	jmp    8009da <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8009bb:	83 ec 08             	sub    $0x8,%esp
  8009be:	ff 75 e8             	pushl  -0x18(%ebp)
  8009c1:	8d 45 14             	lea    0x14(%ebp),%eax
  8009c4:	50                   	push   %eax
  8009c5:	e8 e7 fb ff ff       	call   8005b1 <getuint>
  8009ca:	83 c4 10             	add    $0x10,%esp
  8009cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009d0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8009d3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009da:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009de:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009e1:	83 ec 04             	sub    $0x4,%esp
  8009e4:	52                   	push   %edx
  8009e5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009e8:	50                   	push   %eax
  8009e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ec:	ff 75 f0             	pushl  -0x10(%ebp)
  8009ef:	ff 75 0c             	pushl  0xc(%ebp)
  8009f2:	ff 75 08             	pushl  0x8(%ebp)
  8009f5:	e8 00 fb ff ff       	call   8004fa <printnum>
  8009fa:	83 c4 20             	add    $0x20,%esp
			break;
  8009fd:	eb 34                	jmp    800a33 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009ff:	83 ec 08             	sub    $0x8,%esp
  800a02:	ff 75 0c             	pushl  0xc(%ebp)
  800a05:	53                   	push   %ebx
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	ff d0                	call   *%eax
  800a0b:	83 c4 10             	add    $0x10,%esp
			break;
  800a0e:	eb 23                	jmp    800a33 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a10:	83 ec 08             	sub    $0x8,%esp
  800a13:	ff 75 0c             	pushl  0xc(%ebp)
  800a16:	6a 25                	push   $0x25
  800a18:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1b:	ff d0                	call   *%eax
  800a1d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a20:	ff 4d 10             	decl   0x10(%ebp)
  800a23:	eb 03                	jmp    800a28 <vprintfmt+0x3b1>
  800a25:	ff 4d 10             	decl   0x10(%ebp)
  800a28:	8b 45 10             	mov    0x10(%ebp),%eax
  800a2b:	48                   	dec    %eax
  800a2c:	8a 00                	mov    (%eax),%al
  800a2e:	3c 25                	cmp    $0x25,%al
  800a30:	75 f3                	jne    800a25 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a32:	90                   	nop
		}
	}
  800a33:	e9 47 fc ff ff       	jmp    80067f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a38:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a39:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a3c:	5b                   	pop    %ebx
  800a3d:	5e                   	pop    %esi
  800a3e:	5d                   	pop    %ebp
  800a3f:	c3                   	ret    

00800a40 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a40:	55                   	push   %ebp
  800a41:	89 e5                	mov    %esp,%ebp
  800a43:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a46:	8d 45 10             	lea    0x10(%ebp),%eax
  800a49:	83 c0 04             	add    $0x4,%eax
  800a4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800a52:	ff 75 f4             	pushl  -0xc(%ebp)
  800a55:	50                   	push   %eax
  800a56:	ff 75 0c             	pushl  0xc(%ebp)
  800a59:	ff 75 08             	pushl  0x8(%ebp)
  800a5c:	e8 16 fc ff ff       	call   800677 <vprintfmt>
  800a61:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a64:	90                   	nop
  800a65:	c9                   	leave  
  800a66:	c3                   	ret    

00800a67 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a67:	55                   	push   %ebp
  800a68:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6d:	8b 40 08             	mov    0x8(%eax),%eax
  800a70:	8d 50 01             	lea    0x1(%eax),%edx
  800a73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a76:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7c:	8b 10                	mov    (%eax),%edx
  800a7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a81:	8b 40 04             	mov    0x4(%eax),%eax
  800a84:	39 c2                	cmp    %eax,%edx
  800a86:	73 12                	jae    800a9a <sprintputch+0x33>
		*b->buf++ = ch;
  800a88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8b:	8b 00                	mov    (%eax),%eax
  800a8d:	8d 48 01             	lea    0x1(%eax),%ecx
  800a90:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a93:	89 0a                	mov    %ecx,(%edx)
  800a95:	8b 55 08             	mov    0x8(%ebp),%edx
  800a98:	88 10                	mov    %dl,(%eax)
}
  800a9a:	90                   	nop
  800a9b:	5d                   	pop    %ebp
  800a9c:	c3                   	ret    

00800a9d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a9d:	55                   	push   %ebp
  800a9e:	89 e5                	mov    %esp,%ebp
  800aa0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800aa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aac:	8d 50 ff             	lea    -0x1(%eax),%edx
  800aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab2:	01 d0                	add    %edx,%eax
  800ab4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ab7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800abe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ac2:	74 06                	je     800aca <vsnprintf+0x2d>
  800ac4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ac8:	7f 07                	jg     800ad1 <vsnprintf+0x34>
		return -E_INVAL;
  800aca:	b8 03 00 00 00       	mov    $0x3,%eax
  800acf:	eb 20                	jmp    800af1 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ad1:	ff 75 14             	pushl  0x14(%ebp)
  800ad4:	ff 75 10             	pushl  0x10(%ebp)
  800ad7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ada:	50                   	push   %eax
  800adb:	68 67 0a 80 00       	push   $0x800a67
  800ae0:	e8 92 fb ff ff       	call   800677 <vprintfmt>
  800ae5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ae8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800aeb:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800aee:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800af1:	c9                   	leave  
  800af2:	c3                   	ret    

00800af3 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800af3:	55                   	push   %ebp
  800af4:	89 e5                	mov    %esp,%ebp
  800af6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800af9:	8d 45 10             	lea    0x10(%ebp),%eax
  800afc:	83 c0 04             	add    $0x4,%eax
  800aff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b02:	8b 45 10             	mov    0x10(%ebp),%eax
  800b05:	ff 75 f4             	pushl  -0xc(%ebp)
  800b08:	50                   	push   %eax
  800b09:	ff 75 0c             	pushl  0xc(%ebp)
  800b0c:	ff 75 08             	pushl  0x8(%ebp)
  800b0f:	e8 89 ff ff ff       	call   800a9d <vsnprintf>
  800b14:	83 c4 10             	add    $0x10,%esp
  800b17:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b1d:	c9                   	leave  
  800b1e:	c3                   	ret    

00800b1f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b1f:	55                   	push   %ebp
  800b20:	89 e5                	mov    %esp,%ebp
  800b22:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b2c:	eb 06                	jmp    800b34 <strlen+0x15>
		n++;
  800b2e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b31:	ff 45 08             	incl   0x8(%ebp)
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	8a 00                	mov    (%eax),%al
  800b39:	84 c0                	test   %al,%al
  800b3b:	75 f1                	jne    800b2e <strlen+0xf>
		n++;
	return n;
  800b3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b40:	c9                   	leave  
  800b41:	c3                   	ret    

00800b42 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b42:	55                   	push   %ebp
  800b43:	89 e5                	mov    %esp,%ebp
  800b45:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b48:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b4f:	eb 09                	jmp    800b5a <strnlen+0x18>
		n++;
  800b51:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b54:	ff 45 08             	incl   0x8(%ebp)
  800b57:	ff 4d 0c             	decl   0xc(%ebp)
  800b5a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b5e:	74 09                	je     800b69 <strnlen+0x27>
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	8a 00                	mov    (%eax),%al
  800b65:	84 c0                	test   %al,%al
  800b67:	75 e8                	jne    800b51 <strnlen+0xf>
		n++;
	return n;
  800b69:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b6c:	c9                   	leave  
  800b6d:	c3                   	ret    

00800b6e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b6e:	55                   	push   %ebp
  800b6f:	89 e5                	mov    %esp,%ebp
  800b71:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b7a:	90                   	nop
  800b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7e:	8d 50 01             	lea    0x1(%eax),%edx
  800b81:	89 55 08             	mov    %edx,0x8(%ebp)
  800b84:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b87:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b8a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b8d:	8a 12                	mov    (%edx),%dl
  800b8f:	88 10                	mov    %dl,(%eax)
  800b91:	8a 00                	mov    (%eax),%al
  800b93:	84 c0                	test   %al,%al
  800b95:	75 e4                	jne    800b7b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b97:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b9a:	c9                   	leave  
  800b9b:	c3                   	ret    

00800b9c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b9c:	55                   	push   %ebp
  800b9d:	89 e5                	mov    %esp,%ebp
  800b9f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ba8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800baf:	eb 1f                	jmp    800bd0 <strncpy+0x34>
		*dst++ = *src;
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	8d 50 01             	lea    0x1(%eax),%edx
  800bb7:	89 55 08             	mov    %edx,0x8(%ebp)
  800bba:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bbd:	8a 12                	mov    (%edx),%dl
  800bbf:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc4:	8a 00                	mov    (%eax),%al
  800bc6:	84 c0                	test   %al,%al
  800bc8:	74 03                	je     800bcd <strncpy+0x31>
			src++;
  800bca:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bcd:	ff 45 fc             	incl   -0x4(%ebp)
  800bd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bd3:	3b 45 10             	cmp    0x10(%ebp),%eax
  800bd6:	72 d9                	jb     800bb1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800bd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800bdb:	c9                   	leave  
  800bdc:	c3                   	ret    

00800bdd <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800bdd:	55                   	push   %ebp
  800bde:	89 e5                	mov    %esp,%ebp
  800be0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800be3:	8b 45 08             	mov    0x8(%ebp),%eax
  800be6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800be9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bed:	74 30                	je     800c1f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bef:	eb 16                	jmp    800c07 <strlcpy+0x2a>
			*dst++ = *src++;
  800bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf4:	8d 50 01             	lea    0x1(%eax),%edx
  800bf7:	89 55 08             	mov    %edx,0x8(%ebp)
  800bfa:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bfd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c00:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c03:	8a 12                	mov    (%edx),%dl
  800c05:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c07:	ff 4d 10             	decl   0x10(%ebp)
  800c0a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c0e:	74 09                	je     800c19 <strlcpy+0x3c>
  800c10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c13:	8a 00                	mov    (%eax),%al
  800c15:	84 c0                	test   %al,%al
  800c17:	75 d8                	jne    800bf1 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c1f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c25:	29 c2                	sub    %eax,%edx
  800c27:	89 d0                	mov    %edx,%eax
}
  800c29:	c9                   	leave  
  800c2a:	c3                   	ret    

00800c2b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c2b:	55                   	push   %ebp
  800c2c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c2e:	eb 06                	jmp    800c36 <strcmp+0xb>
		p++, q++;
  800c30:	ff 45 08             	incl   0x8(%ebp)
  800c33:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c36:	8b 45 08             	mov    0x8(%ebp),%eax
  800c39:	8a 00                	mov    (%eax),%al
  800c3b:	84 c0                	test   %al,%al
  800c3d:	74 0e                	je     800c4d <strcmp+0x22>
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	8a 10                	mov    (%eax),%dl
  800c44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c47:	8a 00                	mov    (%eax),%al
  800c49:	38 c2                	cmp    %al,%dl
  800c4b:	74 e3                	je     800c30 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c50:	8a 00                	mov    (%eax),%al
  800c52:	0f b6 d0             	movzbl %al,%edx
  800c55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c58:	8a 00                	mov    (%eax),%al
  800c5a:	0f b6 c0             	movzbl %al,%eax
  800c5d:	29 c2                	sub    %eax,%edx
  800c5f:	89 d0                	mov    %edx,%eax
}
  800c61:	5d                   	pop    %ebp
  800c62:	c3                   	ret    

00800c63 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c63:	55                   	push   %ebp
  800c64:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c66:	eb 09                	jmp    800c71 <strncmp+0xe>
		n--, p++, q++;
  800c68:	ff 4d 10             	decl   0x10(%ebp)
  800c6b:	ff 45 08             	incl   0x8(%ebp)
  800c6e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c71:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c75:	74 17                	je     800c8e <strncmp+0x2b>
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7a:	8a 00                	mov    (%eax),%al
  800c7c:	84 c0                	test   %al,%al
  800c7e:	74 0e                	je     800c8e <strncmp+0x2b>
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	8a 10                	mov    (%eax),%dl
  800c85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c88:	8a 00                	mov    (%eax),%al
  800c8a:	38 c2                	cmp    %al,%dl
  800c8c:	74 da                	je     800c68 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c92:	75 07                	jne    800c9b <strncmp+0x38>
		return 0;
  800c94:	b8 00 00 00 00       	mov    $0x0,%eax
  800c99:	eb 14                	jmp    800caf <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	8a 00                	mov    (%eax),%al
  800ca0:	0f b6 d0             	movzbl %al,%edx
  800ca3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca6:	8a 00                	mov    (%eax),%al
  800ca8:	0f b6 c0             	movzbl %al,%eax
  800cab:	29 c2                	sub    %eax,%edx
  800cad:	89 d0                	mov    %edx,%eax
}
  800caf:	5d                   	pop    %ebp
  800cb0:	c3                   	ret    

00800cb1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cb1:	55                   	push   %ebp
  800cb2:	89 e5                	mov    %esp,%ebp
  800cb4:	83 ec 04             	sub    $0x4,%esp
  800cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cba:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cbd:	eb 12                	jmp    800cd1 <strchr+0x20>
		if (*s == c)
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	8a 00                	mov    (%eax),%al
  800cc4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cc7:	75 05                	jne    800cce <strchr+0x1d>
			return (char *) s;
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	eb 11                	jmp    800cdf <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cce:	ff 45 08             	incl   0x8(%ebp)
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	8a 00                	mov    (%eax),%al
  800cd6:	84 c0                	test   %al,%al
  800cd8:	75 e5                	jne    800cbf <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800cda:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cdf:	c9                   	leave  
  800ce0:	c3                   	ret    

00800ce1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ce1:	55                   	push   %ebp
  800ce2:	89 e5                	mov    %esp,%ebp
  800ce4:	83 ec 04             	sub    $0x4,%esp
  800ce7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cea:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ced:	eb 0d                	jmp    800cfc <strfind+0x1b>
		if (*s == c)
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	8a 00                	mov    (%eax),%al
  800cf4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cf7:	74 0e                	je     800d07 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cf9:	ff 45 08             	incl   0x8(%ebp)
  800cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cff:	8a 00                	mov    (%eax),%al
  800d01:	84 c0                	test   %al,%al
  800d03:	75 ea                	jne    800cef <strfind+0xe>
  800d05:	eb 01                	jmp    800d08 <strfind+0x27>
		if (*s == c)
			break;
  800d07:	90                   	nop
	return (char *) s;
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d0b:	c9                   	leave  
  800d0c:	c3                   	ret    

00800d0d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d0d:	55                   	push   %ebp
  800d0e:	89 e5                	mov    %esp,%ebp
  800d10:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d19:	8b 45 10             	mov    0x10(%ebp),%eax
  800d1c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d1f:	eb 0e                	jmp    800d2f <memset+0x22>
		*p++ = c;
  800d21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d24:	8d 50 01             	lea    0x1(%eax),%edx
  800d27:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d2d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d2f:	ff 4d f8             	decl   -0x8(%ebp)
  800d32:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d36:	79 e9                	jns    800d21 <memset+0x14>
		*p++ = c;

	return v;
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d3b:	c9                   	leave  
  800d3c:	c3                   	ret    

00800d3d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d3d:	55                   	push   %ebp
  800d3e:	89 e5                	mov    %esp,%ebp
  800d40:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d46:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d4f:	eb 16                	jmp    800d67 <memcpy+0x2a>
		*d++ = *s++;
  800d51:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d54:	8d 50 01             	lea    0x1(%eax),%edx
  800d57:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d5a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d5d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d60:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d63:	8a 12                	mov    (%edx),%dl
  800d65:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d67:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d6d:	89 55 10             	mov    %edx,0x10(%ebp)
  800d70:	85 c0                	test   %eax,%eax
  800d72:	75 dd                	jne    800d51 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d77:	c9                   	leave  
  800d78:	c3                   	ret    

00800d79 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d79:	55                   	push   %ebp
  800d7a:	89 e5                	mov    %esp,%ebp
  800d7c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d82:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d8e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d91:	73 50                	jae    800de3 <memmove+0x6a>
  800d93:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d96:	8b 45 10             	mov    0x10(%ebp),%eax
  800d99:	01 d0                	add    %edx,%eax
  800d9b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d9e:	76 43                	jbe    800de3 <memmove+0x6a>
		s += n;
  800da0:	8b 45 10             	mov    0x10(%ebp),%eax
  800da3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800da6:	8b 45 10             	mov    0x10(%ebp),%eax
  800da9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dac:	eb 10                	jmp    800dbe <memmove+0x45>
			*--d = *--s;
  800dae:	ff 4d f8             	decl   -0x8(%ebp)
  800db1:	ff 4d fc             	decl   -0x4(%ebp)
  800db4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db7:	8a 10                	mov    (%eax),%dl
  800db9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dbc:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dc4:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc7:	85 c0                	test   %eax,%eax
  800dc9:	75 e3                	jne    800dae <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800dcb:	eb 23                	jmp    800df0 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800dcd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd0:	8d 50 01             	lea    0x1(%eax),%edx
  800dd3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dd6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dd9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ddc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ddf:	8a 12                	mov    (%edx),%dl
  800de1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800de3:	8b 45 10             	mov    0x10(%ebp),%eax
  800de6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800de9:	89 55 10             	mov    %edx,0x10(%ebp)
  800dec:	85 c0                	test   %eax,%eax
  800dee:	75 dd                	jne    800dcd <memmove+0x54>
			*d++ = *s++;

	return dst;
  800df0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800df3:	c9                   	leave  
  800df4:	c3                   	ret    

00800df5 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800df5:	55                   	push   %ebp
  800df6:	89 e5                	mov    %esp,%ebp
  800df8:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e04:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e07:	eb 2a                	jmp    800e33 <memcmp+0x3e>
		if (*s1 != *s2)
  800e09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e0c:	8a 10                	mov    (%eax),%dl
  800e0e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e11:	8a 00                	mov    (%eax),%al
  800e13:	38 c2                	cmp    %al,%dl
  800e15:	74 16                	je     800e2d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1a:	8a 00                	mov    (%eax),%al
  800e1c:	0f b6 d0             	movzbl %al,%edx
  800e1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e22:	8a 00                	mov    (%eax),%al
  800e24:	0f b6 c0             	movzbl %al,%eax
  800e27:	29 c2                	sub    %eax,%edx
  800e29:	89 d0                	mov    %edx,%eax
  800e2b:	eb 18                	jmp    800e45 <memcmp+0x50>
		s1++, s2++;
  800e2d:	ff 45 fc             	incl   -0x4(%ebp)
  800e30:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e33:	8b 45 10             	mov    0x10(%ebp),%eax
  800e36:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e39:	89 55 10             	mov    %edx,0x10(%ebp)
  800e3c:	85 c0                	test   %eax,%eax
  800e3e:	75 c9                	jne    800e09 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e40:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e45:	c9                   	leave  
  800e46:	c3                   	ret    

00800e47 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e47:	55                   	push   %ebp
  800e48:	89 e5                	mov    %esp,%ebp
  800e4a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e4d:	8b 55 08             	mov    0x8(%ebp),%edx
  800e50:	8b 45 10             	mov    0x10(%ebp),%eax
  800e53:	01 d0                	add    %edx,%eax
  800e55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e58:	eb 15                	jmp    800e6f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	8a 00                	mov    (%eax),%al
  800e5f:	0f b6 d0             	movzbl %al,%edx
  800e62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e65:	0f b6 c0             	movzbl %al,%eax
  800e68:	39 c2                	cmp    %eax,%edx
  800e6a:	74 0d                	je     800e79 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e6c:	ff 45 08             	incl   0x8(%ebp)
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e75:	72 e3                	jb     800e5a <memfind+0x13>
  800e77:	eb 01                	jmp    800e7a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e79:	90                   	nop
	return (void *) s;
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e7d:	c9                   	leave  
  800e7e:	c3                   	ret    

00800e7f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e7f:	55                   	push   %ebp
  800e80:	89 e5                	mov    %esp,%ebp
  800e82:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e85:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e8c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e93:	eb 03                	jmp    800e98 <strtol+0x19>
		s++;
  800e95:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e98:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9b:	8a 00                	mov    (%eax),%al
  800e9d:	3c 20                	cmp    $0x20,%al
  800e9f:	74 f4                	je     800e95 <strtol+0x16>
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea4:	8a 00                	mov    (%eax),%al
  800ea6:	3c 09                	cmp    $0x9,%al
  800ea8:	74 eb                	je     800e95 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ead:	8a 00                	mov    (%eax),%al
  800eaf:	3c 2b                	cmp    $0x2b,%al
  800eb1:	75 05                	jne    800eb8 <strtol+0x39>
		s++;
  800eb3:	ff 45 08             	incl   0x8(%ebp)
  800eb6:	eb 13                	jmp    800ecb <strtol+0x4c>
	else if (*s == '-')
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	8a 00                	mov    (%eax),%al
  800ebd:	3c 2d                	cmp    $0x2d,%al
  800ebf:	75 0a                	jne    800ecb <strtol+0x4c>
		s++, neg = 1;
  800ec1:	ff 45 08             	incl   0x8(%ebp)
  800ec4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ecb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ecf:	74 06                	je     800ed7 <strtol+0x58>
  800ed1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ed5:	75 20                	jne    800ef7 <strtol+0x78>
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	3c 30                	cmp    $0x30,%al
  800ede:	75 17                	jne    800ef7 <strtol+0x78>
  800ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee3:	40                   	inc    %eax
  800ee4:	8a 00                	mov    (%eax),%al
  800ee6:	3c 78                	cmp    $0x78,%al
  800ee8:	75 0d                	jne    800ef7 <strtol+0x78>
		s += 2, base = 16;
  800eea:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800eee:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ef5:	eb 28                	jmp    800f1f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ef7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800efb:	75 15                	jne    800f12 <strtol+0x93>
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
  800f00:	8a 00                	mov    (%eax),%al
  800f02:	3c 30                	cmp    $0x30,%al
  800f04:	75 0c                	jne    800f12 <strtol+0x93>
		s++, base = 8;
  800f06:	ff 45 08             	incl   0x8(%ebp)
  800f09:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f10:	eb 0d                	jmp    800f1f <strtol+0xa0>
	else if (base == 0)
  800f12:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f16:	75 07                	jne    800f1f <strtol+0xa0>
		base = 10;
  800f18:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f22:	8a 00                	mov    (%eax),%al
  800f24:	3c 2f                	cmp    $0x2f,%al
  800f26:	7e 19                	jle    800f41 <strtol+0xc2>
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	8a 00                	mov    (%eax),%al
  800f2d:	3c 39                	cmp    $0x39,%al
  800f2f:	7f 10                	jg     800f41 <strtol+0xc2>
			dig = *s - '0';
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	8a 00                	mov    (%eax),%al
  800f36:	0f be c0             	movsbl %al,%eax
  800f39:	83 e8 30             	sub    $0x30,%eax
  800f3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f3f:	eb 42                	jmp    800f83 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f41:	8b 45 08             	mov    0x8(%ebp),%eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	3c 60                	cmp    $0x60,%al
  800f48:	7e 19                	jle    800f63 <strtol+0xe4>
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	8a 00                	mov    (%eax),%al
  800f4f:	3c 7a                	cmp    $0x7a,%al
  800f51:	7f 10                	jg     800f63 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	0f be c0             	movsbl %al,%eax
  800f5b:	83 e8 57             	sub    $0x57,%eax
  800f5e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f61:	eb 20                	jmp    800f83 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	8a 00                	mov    (%eax),%al
  800f68:	3c 40                	cmp    $0x40,%al
  800f6a:	7e 39                	jle    800fa5 <strtol+0x126>
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	3c 5a                	cmp    $0x5a,%al
  800f73:	7f 30                	jg     800fa5 <strtol+0x126>
			dig = *s - 'A' + 10;
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	0f be c0             	movsbl %al,%eax
  800f7d:	83 e8 37             	sub    $0x37,%eax
  800f80:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f86:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f89:	7d 19                	jge    800fa4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f8b:	ff 45 08             	incl   0x8(%ebp)
  800f8e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f91:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f95:	89 c2                	mov    %eax,%edx
  800f97:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f9a:	01 d0                	add    %edx,%eax
  800f9c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f9f:	e9 7b ff ff ff       	jmp    800f1f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fa4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fa5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fa9:	74 08                	je     800fb3 <strtol+0x134>
		*endptr = (char *) s;
  800fab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fae:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fb3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fb7:	74 07                	je     800fc0 <strtol+0x141>
  800fb9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fbc:	f7 d8                	neg    %eax
  800fbe:	eb 03                	jmp    800fc3 <strtol+0x144>
  800fc0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fc3:	c9                   	leave  
  800fc4:	c3                   	ret    

00800fc5 <ltostr>:

void
ltostr(long value, char *str)
{
  800fc5:	55                   	push   %ebp
  800fc6:	89 e5                	mov    %esp,%ebp
  800fc8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fcb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fd2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800fd9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fdd:	79 13                	jns    800ff2 <ltostr+0x2d>
	{
		neg = 1;
  800fdf:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800fe6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800fec:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800fef:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800ffa:	99                   	cltd   
  800ffb:	f7 f9                	idiv   %ecx
  800ffd:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801000:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801003:	8d 50 01             	lea    0x1(%eax),%edx
  801006:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801009:	89 c2                	mov    %eax,%edx
  80100b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100e:	01 d0                	add    %edx,%eax
  801010:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801013:	83 c2 30             	add    $0x30,%edx
  801016:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801018:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80101b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801020:	f7 e9                	imul   %ecx
  801022:	c1 fa 02             	sar    $0x2,%edx
  801025:	89 c8                	mov    %ecx,%eax
  801027:	c1 f8 1f             	sar    $0x1f,%eax
  80102a:	29 c2                	sub    %eax,%edx
  80102c:	89 d0                	mov    %edx,%eax
  80102e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801031:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801034:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801039:	f7 e9                	imul   %ecx
  80103b:	c1 fa 02             	sar    $0x2,%edx
  80103e:	89 c8                	mov    %ecx,%eax
  801040:	c1 f8 1f             	sar    $0x1f,%eax
  801043:	29 c2                	sub    %eax,%edx
  801045:	89 d0                	mov    %edx,%eax
  801047:	c1 e0 02             	shl    $0x2,%eax
  80104a:	01 d0                	add    %edx,%eax
  80104c:	01 c0                	add    %eax,%eax
  80104e:	29 c1                	sub    %eax,%ecx
  801050:	89 ca                	mov    %ecx,%edx
  801052:	85 d2                	test   %edx,%edx
  801054:	75 9c                	jne    800ff2 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801056:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80105d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801060:	48                   	dec    %eax
  801061:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801064:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801068:	74 3d                	je     8010a7 <ltostr+0xe2>
		start = 1 ;
  80106a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801071:	eb 34                	jmp    8010a7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801073:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801076:	8b 45 0c             	mov    0xc(%ebp),%eax
  801079:	01 d0                	add    %edx,%eax
  80107b:	8a 00                	mov    (%eax),%al
  80107d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801080:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801083:	8b 45 0c             	mov    0xc(%ebp),%eax
  801086:	01 c2                	add    %eax,%edx
  801088:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80108b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108e:	01 c8                	add    %ecx,%eax
  801090:	8a 00                	mov    (%eax),%al
  801092:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801094:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801097:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109a:	01 c2                	add    %eax,%edx
  80109c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80109f:	88 02                	mov    %al,(%edx)
		start++ ;
  8010a1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010a4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010ad:	7c c4                	jl     801073 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010af:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b5:	01 d0                	add    %edx,%eax
  8010b7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010ba:	90                   	nop
  8010bb:	c9                   	leave  
  8010bc:	c3                   	ret    

008010bd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010bd:	55                   	push   %ebp
  8010be:	89 e5                	mov    %esp,%ebp
  8010c0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010c3:	ff 75 08             	pushl  0x8(%ebp)
  8010c6:	e8 54 fa ff ff       	call   800b1f <strlen>
  8010cb:	83 c4 04             	add    $0x4,%esp
  8010ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010d1:	ff 75 0c             	pushl  0xc(%ebp)
  8010d4:	e8 46 fa ff ff       	call   800b1f <strlen>
  8010d9:	83 c4 04             	add    $0x4,%esp
  8010dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010ed:	eb 17                	jmp    801106 <strcconcat+0x49>
		final[s] = str1[s] ;
  8010ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f5:	01 c2                	add    %eax,%edx
  8010f7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fd:	01 c8                	add    %ecx,%eax
  8010ff:	8a 00                	mov    (%eax),%al
  801101:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801103:	ff 45 fc             	incl   -0x4(%ebp)
  801106:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801109:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80110c:	7c e1                	jl     8010ef <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80110e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801115:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80111c:	eb 1f                	jmp    80113d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80111e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801121:	8d 50 01             	lea    0x1(%eax),%edx
  801124:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801127:	89 c2                	mov    %eax,%edx
  801129:	8b 45 10             	mov    0x10(%ebp),%eax
  80112c:	01 c2                	add    %eax,%edx
  80112e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801131:	8b 45 0c             	mov    0xc(%ebp),%eax
  801134:	01 c8                	add    %ecx,%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80113a:	ff 45 f8             	incl   -0x8(%ebp)
  80113d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801140:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801143:	7c d9                	jl     80111e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801145:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801148:	8b 45 10             	mov    0x10(%ebp),%eax
  80114b:	01 d0                	add    %edx,%eax
  80114d:	c6 00 00             	movb   $0x0,(%eax)
}
  801150:	90                   	nop
  801151:	c9                   	leave  
  801152:	c3                   	ret    

00801153 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801153:	55                   	push   %ebp
  801154:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801156:	8b 45 14             	mov    0x14(%ebp),%eax
  801159:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80115f:	8b 45 14             	mov    0x14(%ebp),%eax
  801162:	8b 00                	mov    (%eax),%eax
  801164:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80116b:	8b 45 10             	mov    0x10(%ebp),%eax
  80116e:	01 d0                	add    %edx,%eax
  801170:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801176:	eb 0c                	jmp    801184 <strsplit+0x31>
			*string++ = 0;
  801178:	8b 45 08             	mov    0x8(%ebp),%eax
  80117b:	8d 50 01             	lea    0x1(%eax),%edx
  80117e:	89 55 08             	mov    %edx,0x8(%ebp)
  801181:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801184:	8b 45 08             	mov    0x8(%ebp),%eax
  801187:	8a 00                	mov    (%eax),%al
  801189:	84 c0                	test   %al,%al
  80118b:	74 18                	je     8011a5 <strsplit+0x52>
  80118d:	8b 45 08             	mov    0x8(%ebp),%eax
  801190:	8a 00                	mov    (%eax),%al
  801192:	0f be c0             	movsbl %al,%eax
  801195:	50                   	push   %eax
  801196:	ff 75 0c             	pushl  0xc(%ebp)
  801199:	e8 13 fb ff ff       	call   800cb1 <strchr>
  80119e:	83 c4 08             	add    $0x8,%esp
  8011a1:	85 c0                	test   %eax,%eax
  8011a3:	75 d3                	jne    801178 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a8:	8a 00                	mov    (%eax),%al
  8011aa:	84 c0                	test   %al,%al
  8011ac:	74 5a                	je     801208 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b1:	8b 00                	mov    (%eax),%eax
  8011b3:	83 f8 0f             	cmp    $0xf,%eax
  8011b6:	75 07                	jne    8011bf <strsplit+0x6c>
		{
			return 0;
  8011b8:	b8 00 00 00 00       	mov    $0x0,%eax
  8011bd:	eb 66                	jmp    801225 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c2:	8b 00                	mov    (%eax),%eax
  8011c4:	8d 48 01             	lea    0x1(%eax),%ecx
  8011c7:	8b 55 14             	mov    0x14(%ebp),%edx
  8011ca:	89 0a                	mov    %ecx,(%edx)
  8011cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d6:	01 c2                	add    %eax,%edx
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011db:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011dd:	eb 03                	jmp    8011e2 <strsplit+0x8f>
			string++;
  8011df:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	84 c0                	test   %al,%al
  8011e9:	74 8b                	je     801176 <strsplit+0x23>
  8011eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ee:	8a 00                	mov    (%eax),%al
  8011f0:	0f be c0             	movsbl %al,%eax
  8011f3:	50                   	push   %eax
  8011f4:	ff 75 0c             	pushl  0xc(%ebp)
  8011f7:	e8 b5 fa ff ff       	call   800cb1 <strchr>
  8011fc:	83 c4 08             	add    $0x8,%esp
  8011ff:	85 c0                	test   %eax,%eax
  801201:	74 dc                	je     8011df <strsplit+0x8c>
			string++;
	}
  801203:	e9 6e ff ff ff       	jmp    801176 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801208:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801209:	8b 45 14             	mov    0x14(%ebp),%eax
  80120c:	8b 00                	mov    (%eax),%eax
  80120e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801215:	8b 45 10             	mov    0x10(%ebp),%eax
  801218:	01 d0                	add    %edx,%eax
  80121a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801220:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801225:	c9                   	leave  
  801226:	c3                   	ret    

00801227 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801227:	55                   	push   %ebp
  801228:	89 e5                	mov    %esp,%ebp
  80122a:	57                   	push   %edi
  80122b:	56                   	push   %esi
  80122c:	53                   	push   %ebx
  80122d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801230:	8b 45 08             	mov    0x8(%ebp),%eax
  801233:	8b 55 0c             	mov    0xc(%ebp),%edx
  801236:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801239:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80123c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80123f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801242:	cd 30                	int    $0x30
  801244:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801247:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80124a:	83 c4 10             	add    $0x10,%esp
  80124d:	5b                   	pop    %ebx
  80124e:	5e                   	pop    %esi
  80124f:	5f                   	pop    %edi
  801250:	5d                   	pop    %ebp
  801251:	c3                   	ret    

00801252 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801252:	55                   	push   %ebp
  801253:	89 e5                	mov    %esp,%ebp
  801255:	83 ec 04             	sub    $0x4,%esp
  801258:	8b 45 10             	mov    0x10(%ebp),%eax
  80125b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80125e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801262:	8b 45 08             	mov    0x8(%ebp),%eax
  801265:	6a 00                	push   $0x0
  801267:	6a 00                	push   $0x0
  801269:	52                   	push   %edx
  80126a:	ff 75 0c             	pushl  0xc(%ebp)
  80126d:	50                   	push   %eax
  80126e:	6a 00                	push   $0x0
  801270:	e8 b2 ff ff ff       	call   801227 <syscall>
  801275:	83 c4 18             	add    $0x18,%esp
}
  801278:	90                   	nop
  801279:	c9                   	leave  
  80127a:	c3                   	ret    

0080127b <sys_cgetc>:

int
sys_cgetc(void)
{
  80127b:	55                   	push   %ebp
  80127c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	6a 00                	push   $0x0
  801286:	6a 00                	push   $0x0
  801288:	6a 01                	push   $0x1
  80128a:	e8 98 ff ff ff       	call   801227 <syscall>
  80128f:	83 c4 18             	add    $0x18,%esp
}
  801292:	c9                   	leave  
  801293:	c3                   	ret    

00801294 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801294:	55                   	push   %ebp
  801295:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 00                	push   $0x0
  8012a2:	50                   	push   %eax
  8012a3:	6a 05                	push   $0x5
  8012a5:	e8 7d ff ff ff       	call   801227 <syscall>
  8012aa:	83 c4 18             	add    $0x18,%esp
}
  8012ad:	c9                   	leave  
  8012ae:	c3                   	ret    

008012af <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012af:	55                   	push   %ebp
  8012b0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 02                	push   $0x2
  8012be:	e8 64 ff ff ff       	call   801227 <syscall>
  8012c3:	83 c4 18             	add    $0x18,%esp
}
  8012c6:	c9                   	leave  
  8012c7:	c3                   	ret    

008012c8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012c8:	55                   	push   %ebp
  8012c9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 00                	push   $0x0
  8012d5:	6a 03                	push   $0x3
  8012d7:	e8 4b ff ff ff       	call   801227 <syscall>
  8012dc:	83 c4 18             	add    $0x18,%esp
}
  8012df:	c9                   	leave  
  8012e0:	c3                   	ret    

008012e1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8012e1:	55                   	push   %ebp
  8012e2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 04                	push   $0x4
  8012f0:	e8 32 ff ff ff       	call   801227 <syscall>
  8012f5:	83 c4 18             	add    $0x18,%esp
}
  8012f8:	c9                   	leave  
  8012f9:	c3                   	ret    

008012fa <sys_env_exit>:


void sys_env_exit(void)
{
  8012fa:	55                   	push   %ebp
  8012fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	6a 06                	push   $0x6
  801309:	e8 19 ff ff ff       	call   801227 <syscall>
  80130e:	83 c4 18             	add    $0x18,%esp
}
  801311:	90                   	nop
  801312:	c9                   	leave  
  801313:	c3                   	ret    

00801314 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801314:	55                   	push   %ebp
  801315:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801317:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131a:	8b 45 08             	mov    0x8(%ebp),%eax
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	52                   	push   %edx
  801324:	50                   	push   %eax
  801325:	6a 07                	push   $0x7
  801327:	e8 fb fe ff ff       	call   801227 <syscall>
  80132c:	83 c4 18             	add    $0x18,%esp
}
  80132f:	c9                   	leave  
  801330:	c3                   	ret    

00801331 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801331:	55                   	push   %ebp
  801332:	89 e5                	mov    %esp,%ebp
  801334:	56                   	push   %esi
  801335:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801336:	8b 75 18             	mov    0x18(%ebp),%esi
  801339:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80133c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80133f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	56                   	push   %esi
  801346:	53                   	push   %ebx
  801347:	51                   	push   %ecx
  801348:	52                   	push   %edx
  801349:	50                   	push   %eax
  80134a:	6a 08                	push   $0x8
  80134c:	e8 d6 fe ff ff       	call   801227 <syscall>
  801351:	83 c4 18             	add    $0x18,%esp
}
  801354:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801357:	5b                   	pop    %ebx
  801358:	5e                   	pop    %esi
  801359:	5d                   	pop    %ebp
  80135a:	c3                   	ret    

0080135b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80135b:	55                   	push   %ebp
  80135c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80135e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	52                   	push   %edx
  80136b:	50                   	push   %eax
  80136c:	6a 09                	push   $0x9
  80136e:	e8 b4 fe ff ff       	call   801227 <syscall>
  801373:	83 c4 18             	add    $0x18,%esp
}
  801376:	c9                   	leave  
  801377:	c3                   	ret    

00801378 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801378:	55                   	push   %ebp
  801379:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	6a 00                	push   $0x0
  801381:	ff 75 0c             	pushl  0xc(%ebp)
  801384:	ff 75 08             	pushl  0x8(%ebp)
  801387:	6a 0a                	push   $0xa
  801389:	e8 99 fe ff ff       	call   801227 <syscall>
  80138e:	83 c4 18             	add    $0x18,%esp
}
  801391:	c9                   	leave  
  801392:	c3                   	ret    

00801393 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801393:	55                   	push   %ebp
  801394:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 00                	push   $0x0
  8013a0:	6a 0b                	push   $0xb
  8013a2:	e8 80 fe ff ff       	call   801227 <syscall>
  8013a7:	83 c4 18             	add    $0x18,%esp
}
  8013aa:	c9                   	leave  
  8013ab:	c3                   	ret    

008013ac <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013ac:	55                   	push   %ebp
  8013ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 0c                	push   $0xc
  8013bb:	e8 67 fe ff ff       	call   801227 <syscall>
  8013c0:	83 c4 18             	add    $0x18,%esp
}
  8013c3:	c9                   	leave  
  8013c4:	c3                   	ret    

008013c5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013c5:	55                   	push   %ebp
  8013c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 0d                	push   $0xd
  8013d4:	e8 4e fe ff ff       	call   801227 <syscall>
  8013d9:	83 c4 18             	add    $0x18,%esp
}
  8013dc:	c9                   	leave  
  8013dd:	c3                   	ret    

008013de <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8013de:	55                   	push   %ebp
  8013df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	ff 75 0c             	pushl  0xc(%ebp)
  8013ea:	ff 75 08             	pushl  0x8(%ebp)
  8013ed:	6a 11                	push   $0x11
  8013ef:	e8 33 fe ff ff       	call   801227 <syscall>
  8013f4:	83 c4 18             	add    $0x18,%esp
	return;
  8013f7:	90                   	nop
}
  8013f8:	c9                   	leave  
  8013f9:	c3                   	ret    

008013fa <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8013fa:	55                   	push   %ebp
  8013fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	ff 75 0c             	pushl  0xc(%ebp)
  801406:	ff 75 08             	pushl  0x8(%ebp)
  801409:	6a 12                	push   $0x12
  80140b:	e8 17 fe ff ff       	call   801227 <syscall>
  801410:	83 c4 18             	add    $0x18,%esp
	return ;
  801413:	90                   	nop
}
  801414:	c9                   	leave  
  801415:	c3                   	ret    

00801416 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801416:	55                   	push   %ebp
  801417:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 0e                	push   $0xe
  801425:	e8 fd fd ff ff       	call   801227 <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
}
  80142d:	c9                   	leave  
  80142e:	c3                   	ret    

0080142f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80142f:	55                   	push   %ebp
  801430:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801432:	6a 00                	push   $0x0
  801434:	6a 00                	push   $0x0
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	ff 75 08             	pushl  0x8(%ebp)
  80143d:	6a 0f                	push   $0xf
  80143f:	e8 e3 fd ff ff       	call   801227 <syscall>
  801444:	83 c4 18             	add    $0x18,%esp
}
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80144c:	6a 00                	push   $0x0
  80144e:	6a 00                	push   $0x0
  801450:	6a 00                	push   $0x0
  801452:	6a 00                	push   $0x0
  801454:	6a 00                	push   $0x0
  801456:	6a 10                	push   $0x10
  801458:	e8 ca fd ff ff       	call   801227 <syscall>
  80145d:	83 c4 18             	add    $0x18,%esp
}
  801460:	90                   	nop
  801461:	c9                   	leave  
  801462:	c3                   	ret    

00801463 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801463:	55                   	push   %ebp
  801464:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	6a 14                	push   $0x14
  801472:	e8 b0 fd ff ff       	call   801227 <syscall>
  801477:	83 c4 18             	add    $0x18,%esp
}
  80147a:	90                   	nop
  80147b:	c9                   	leave  
  80147c:	c3                   	ret    

0080147d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80147d:	55                   	push   %ebp
  80147e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 15                	push   $0x15
  80148c:	e8 96 fd ff ff       	call   801227 <syscall>
  801491:	83 c4 18             	add    $0x18,%esp
}
  801494:	90                   	nop
  801495:	c9                   	leave  
  801496:	c3                   	ret    

00801497 <sys_cputc>:


void
sys_cputc(const char c)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
  80149a:	83 ec 04             	sub    $0x4,%esp
  80149d:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014a3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	50                   	push   %eax
  8014b0:	6a 16                	push   $0x16
  8014b2:	e8 70 fd ff ff       	call   801227 <syscall>
  8014b7:	83 c4 18             	add    $0x18,%esp
}
  8014ba:	90                   	nop
  8014bb:	c9                   	leave  
  8014bc:	c3                   	ret    

008014bd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014bd:	55                   	push   %ebp
  8014be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 17                	push   $0x17
  8014cc:	e8 56 fd ff ff       	call   801227 <syscall>
  8014d1:	83 c4 18             	add    $0x18,%esp
}
  8014d4:	90                   	nop
  8014d5:	c9                   	leave  
  8014d6:	c3                   	ret    

008014d7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014d7:	55                   	push   %ebp
  8014d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014da:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	ff 75 0c             	pushl  0xc(%ebp)
  8014e6:	50                   	push   %eax
  8014e7:	6a 18                	push   $0x18
  8014e9:	e8 39 fd ff ff       	call   801227 <syscall>
  8014ee:	83 c4 18             	add    $0x18,%esp
}
  8014f1:	c9                   	leave  
  8014f2:	c3                   	ret    

008014f3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	52                   	push   %edx
  801503:	50                   	push   %eax
  801504:	6a 1b                	push   $0x1b
  801506:	e8 1c fd ff ff       	call   801227 <syscall>
  80150b:	83 c4 18             	add    $0x18,%esp
}
  80150e:	c9                   	leave  
  80150f:	c3                   	ret    

00801510 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801510:	55                   	push   %ebp
  801511:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801513:	8b 55 0c             	mov    0xc(%ebp),%edx
  801516:	8b 45 08             	mov    0x8(%ebp),%eax
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	52                   	push   %edx
  801520:	50                   	push   %eax
  801521:	6a 19                	push   $0x19
  801523:	e8 ff fc ff ff       	call   801227 <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
}
  80152b:	90                   	nop
  80152c:	c9                   	leave  
  80152d:	c3                   	ret    

0080152e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801531:	8b 55 0c             	mov    0xc(%ebp),%edx
  801534:	8b 45 08             	mov    0x8(%ebp),%eax
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	52                   	push   %edx
  80153e:	50                   	push   %eax
  80153f:	6a 1a                	push   $0x1a
  801541:	e8 e1 fc ff ff       	call   801227 <syscall>
  801546:	83 c4 18             	add    $0x18,%esp
}
  801549:	90                   	nop
  80154a:	c9                   	leave  
  80154b:	c3                   	ret    

0080154c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
  80154f:	83 ec 04             	sub    $0x4,%esp
  801552:	8b 45 10             	mov    0x10(%ebp),%eax
  801555:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801558:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80155b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80155f:	8b 45 08             	mov    0x8(%ebp),%eax
  801562:	6a 00                	push   $0x0
  801564:	51                   	push   %ecx
  801565:	52                   	push   %edx
  801566:	ff 75 0c             	pushl  0xc(%ebp)
  801569:	50                   	push   %eax
  80156a:	6a 1c                	push   $0x1c
  80156c:	e8 b6 fc ff ff       	call   801227 <syscall>
  801571:	83 c4 18             	add    $0x18,%esp
}
  801574:	c9                   	leave  
  801575:	c3                   	ret    

00801576 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801576:	55                   	push   %ebp
  801577:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801579:	8b 55 0c             	mov    0xc(%ebp),%edx
  80157c:	8b 45 08             	mov    0x8(%ebp),%eax
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	52                   	push   %edx
  801586:	50                   	push   %eax
  801587:	6a 1d                	push   $0x1d
  801589:	e8 99 fc ff ff       	call   801227 <syscall>
  80158e:	83 c4 18             	add    $0x18,%esp
}
  801591:	c9                   	leave  
  801592:	c3                   	ret    

00801593 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801593:	55                   	push   %ebp
  801594:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801596:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801599:	8b 55 0c             	mov    0xc(%ebp),%edx
  80159c:	8b 45 08             	mov    0x8(%ebp),%eax
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	51                   	push   %ecx
  8015a4:	52                   	push   %edx
  8015a5:	50                   	push   %eax
  8015a6:	6a 1e                	push   $0x1e
  8015a8:	e8 7a fc ff ff       	call   801227 <syscall>
  8015ad:	83 c4 18             	add    $0x18,%esp
}
  8015b0:	c9                   	leave  
  8015b1:	c3                   	ret    

008015b2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015b2:	55                   	push   %ebp
  8015b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	52                   	push   %edx
  8015c2:	50                   	push   %eax
  8015c3:	6a 1f                	push   $0x1f
  8015c5:	e8 5d fc ff ff       	call   801227 <syscall>
  8015ca:	83 c4 18             	add    $0x18,%esp
}
  8015cd:	c9                   	leave  
  8015ce:	c3                   	ret    

008015cf <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015cf:	55                   	push   %ebp
  8015d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 20                	push   $0x20
  8015de:	e8 44 fc ff ff       	call   801227 <syscall>
  8015e3:	83 c4 18             	add    $0x18,%esp
}
  8015e6:	c9                   	leave  
  8015e7:	c3                   	ret    

008015e8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8015eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ee:	6a 00                	push   $0x0
  8015f0:	ff 75 14             	pushl  0x14(%ebp)
  8015f3:	ff 75 10             	pushl  0x10(%ebp)
  8015f6:	ff 75 0c             	pushl  0xc(%ebp)
  8015f9:	50                   	push   %eax
  8015fa:	6a 21                	push   $0x21
  8015fc:	e8 26 fc ff ff       	call   801227 <syscall>
  801601:	83 c4 18             	add    $0x18,%esp
}
  801604:	c9                   	leave  
  801605:	c3                   	ret    

00801606 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801606:	55                   	push   %ebp
  801607:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	50                   	push   %eax
  801615:	6a 22                	push   $0x22
  801617:	e8 0b fc ff ff       	call   801227 <syscall>
  80161c:	83 c4 18             	add    $0x18,%esp
}
  80161f:	90                   	nop
  801620:	c9                   	leave  
  801621:	c3                   	ret    

00801622 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801622:	55                   	push   %ebp
  801623:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801625:	8b 45 08             	mov    0x8(%ebp),%eax
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	50                   	push   %eax
  801631:	6a 23                	push   $0x23
  801633:	e8 ef fb ff ff       	call   801227 <syscall>
  801638:	83 c4 18             	add    $0x18,%esp
}
  80163b:	90                   	nop
  80163c:	c9                   	leave  
  80163d:	c3                   	ret    

0080163e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80163e:	55                   	push   %ebp
  80163f:	89 e5                	mov    %esp,%ebp
  801641:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801644:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801647:	8d 50 04             	lea    0x4(%eax),%edx
  80164a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	52                   	push   %edx
  801654:	50                   	push   %eax
  801655:	6a 24                	push   $0x24
  801657:	e8 cb fb ff ff       	call   801227 <syscall>
  80165c:	83 c4 18             	add    $0x18,%esp
	return result;
  80165f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801662:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801665:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801668:	89 01                	mov    %eax,(%ecx)
  80166a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80166d:	8b 45 08             	mov    0x8(%ebp),%eax
  801670:	c9                   	leave  
  801671:	c2 04 00             	ret    $0x4

00801674 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801674:	55                   	push   %ebp
  801675:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	ff 75 10             	pushl  0x10(%ebp)
  80167e:	ff 75 0c             	pushl  0xc(%ebp)
  801681:	ff 75 08             	pushl  0x8(%ebp)
  801684:	6a 13                	push   $0x13
  801686:	e8 9c fb ff ff       	call   801227 <syscall>
  80168b:	83 c4 18             	add    $0x18,%esp
	return ;
  80168e:	90                   	nop
}
  80168f:	c9                   	leave  
  801690:	c3                   	ret    

00801691 <sys_rcr2>:
uint32 sys_rcr2()
{
  801691:	55                   	push   %ebp
  801692:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 25                	push   $0x25
  8016a0:	e8 82 fb ff ff       	call   801227 <syscall>
  8016a5:	83 c4 18             	add    $0x18,%esp
}
  8016a8:	c9                   	leave  
  8016a9:	c3                   	ret    

008016aa <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
  8016ad:	83 ec 04             	sub    $0x4,%esp
  8016b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016b6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	50                   	push   %eax
  8016c3:	6a 26                	push   $0x26
  8016c5:	e8 5d fb ff ff       	call   801227 <syscall>
  8016ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8016cd:	90                   	nop
}
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <rsttst>:
void rsttst()
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 28                	push   $0x28
  8016df:	e8 43 fb ff ff       	call   801227 <syscall>
  8016e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8016e7:	90                   	nop
}
  8016e8:	c9                   	leave  
  8016e9:	c3                   	ret    

008016ea <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8016ea:	55                   	push   %ebp
  8016eb:	89 e5                	mov    %esp,%ebp
  8016ed:	83 ec 04             	sub    $0x4,%esp
  8016f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8016f3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016f6:	8b 55 18             	mov    0x18(%ebp),%edx
  8016f9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016fd:	52                   	push   %edx
  8016fe:	50                   	push   %eax
  8016ff:	ff 75 10             	pushl  0x10(%ebp)
  801702:	ff 75 0c             	pushl  0xc(%ebp)
  801705:	ff 75 08             	pushl  0x8(%ebp)
  801708:	6a 27                	push   $0x27
  80170a:	e8 18 fb ff ff       	call   801227 <syscall>
  80170f:	83 c4 18             	add    $0x18,%esp
	return ;
  801712:	90                   	nop
}
  801713:	c9                   	leave  
  801714:	c3                   	ret    

00801715 <chktst>:
void chktst(uint32 n)
{
  801715:	55                   	push   %ebp
  801716:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	ff 75 08             	pushl  0x8(%ebp)
  801723:	6a 29                	push   $0x29
  801725:	e8 fd fa ff ff       	call   801227 <syscall>
  80172a:	83 c4 18             	add    $0x18,%esp
	return ;
  80172d:	90                   	nop
}
  80172e:	c9                   	leave  
  80172f:	c3                   	ret    

00801730 <inctst>:

void inctst()
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 2a                	push   $0x2a
  80173f:	e8 e3 fa ff ff       	call   801227 <syscall>
  801744:	83 c4 18             	add    $0x18,%esp
	return ;
  801747:	90                   	nop
}
  801748:	c9                   	leave  
  801749:	c3                   	ret    

0080174a <gettst>:
uint32 gettst()
{
  80174a:	55                   	push   %ebp
  80174b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 00                	push   $0x0
  801757:	6a 2b                	push   $0x2b
  801759:	e8 c9 fa ff ff       	call   801227 <syscall>
  80175e:	83 c4 18             	add    $0x18,%esp
}
  801761:	c9                   	leave  
  801762:	c3                   	ret    

00801763 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801763:	55                   	push   %ebp
  801764:	89 e5                	mov    %esp,%ebp
  801766:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 2c                	push   $0x2c
  801775:	e8 ad fa ff ff       	call   801227 <syscall>
  80177a:	83 c4 18             	add    $0x18,%esp
  80177d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801780:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801784:	75 07                	jne    80178d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801786:	b8 01 00 00 00       	mov    $0x1,%eax
  80178b:	eb 05                	jmp    801792 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80178d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801792:	c9                   	leave  
  801793:	c3                   	ret    

00801794 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801794:	55                   	push   %ebp
  801795:	89 e5                	mov    %esp,%ebp
  801797:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 2c                	push   $0x2c
  8017a6:	e8 7c fa ff ff       	call   801227 <syscall>
  8017ab:	83 c4 18             	add    $0x18,%esp
  8017ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017b1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017b5:	75 07                	jne    8017be <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017b7:	b8 01 00 00 00       	mov    $0x1,%eax
  8017bc:	eb 05                	jmp    8017c3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017be:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017c3:	c9                   	leave  
  8017c4:	c3                   	ret    

008017c5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017c5:	55                   	push   %ebp
  8017c6:	89 e5                	mov    %esp,%ebp
  8017c8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 2c                	push   $0x2c
  8017d7:	e8 4b fa ff ff       	call   801227 <syscall>
  8017dc:	83 c4 18             	add    $0x18,%esp
  8017df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8017e2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8017e6:	75 07                	jne    8017ef <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8017e8:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ed:	eb 05                	jmp    8017f4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8017ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
  8017f9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 2c                	push   $0x2c
  801808:	e8 1a fa ff ff       	call   801227 <syscall>
  80180d:	83 c4 18             	add    $0x18,%esp
  801810:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801813:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801817:	75 07                	jne    801820 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801819:	b8 01 00 00 00       	mov    $0x1,%eax
  80181e:	eb 05                	jmp    801825 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801820:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801825:	c9                   	leave  
  801826:	c3                   	ret    

00801827 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801827:	55                   	push   %ebp
  801828:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	ff 75 08             	pushl  0x8(%ebp)
  801835:	6a 2d                	push   $0x2d
  801837:	e8 eb f9 ff ff       	call   801227 <syscall>
  80183c:	83 c4 18             	add    $0x18,%esp
	return ;
  80183f:	90                   	nop
}
  801840:	c9                   	leave  
  801841:	c3                   	ret    

00801842 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801842:	55                   	push   %ebp
  801843:	89 e5                	mov    %esp,%ebp
  801845:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801846:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801849:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80184c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80184f:	8b 45 08             	mov    0x8(%ebp),%eax
  801852:	6a 00                	push   $0x0
  801854:	53                   	push   %ebx
  801855:	51                   	push   %ecx
  801856:	52                   	push   %edx
  801857:	50                   	push   %eax
  801858:	6a 2e                	push   $0x2e
  80185a:	e8 c8 f9 ff ff       	call   801227 <syscall>
  80185f:	83 c4 18             	add    $0x18,%esp
}
  801862:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801865:	c9                   	leave  
  801866:	c3                   	ret    

00801867 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801867:	55                   	push   %ebp
  801868:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80186a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80186d:	8b 45 08             	mov    0x8(%ebp),%eax
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	52                   	push   %edx
  801877:	50                   	push   %eax
  801878:	6a 2f                	push   $0x2f
  80187a:	e8 a8 f9 ff ff       	call   801227 <syscall>
  80187f:	83 c4 18             	add    $0x18,%esp
}
  801882:	c9                   	leave  
  801883:	c3                   	ret    

00801884 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	ff 75 0c             	pushl  0xc(%ebp)
  801890:	ff 75 08             	pushl  0x8(%ebp)
  801893:	6a 30                	push   $0x30
  801895:	e8 8d f9 ff ff       	call   801227 <syscall>
  80189a:	83 c4 18             	add    $0x18,%esp
	return ;
  80189d:	90                   	nop
}
  80189e:	c9                   	leave  
  80189f:	c3                   	ret    

008018a0 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018a0:	55                   	push   %ebp
  8018a1:	89 e5                	mov    %esp,%ebp
  8018a3:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018a6:	8b 55 08             	mov    0x8(%ebp),%edx
  8018a9:	89 d0                	mov    %edx,%eax
  8018ab:	c1 e0 02             	shl    $0x2,%eax
  8018ae:	01 d0                	add    %edx,%eax
  8018b0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018b7:	01 d0                	add    %edx,%eax
  8018b9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018c0:	01 d0                	add    %edx,%eax
  8018c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018c9:	01 d0                	add    %edx,%eax
  8018cb:	c1 e0 04             	shl    $0x4,%eax
  8018ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8018d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8018d8:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8018db:	83 ec 0c             	sub    $0xc,%esp
  8018de:	50                   	push   %eax
  8018df:	e8 5a fd ff ff       	call   80163e <sys_get_virtual_time>
  8018e4:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8018e7:	eb 41                	jmp    80192a <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8018e9:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8018ec:	83 ec 0c             	sub    $0xc,%esp
  8018ef:	50                   	push   %eax
  8018f0:	e8 49 fd ff ff       	call   80163e <sys_get_virtual_time>
  8018f5:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8018f8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8018fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018fe:	29 c2                	sub    %eax,%edx
  801900:	89 d0                	mov    %edx,%eax
  801902:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801905:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801908:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80190b:	89 d1                	mov    %edx,%ecx
  80190d:	29 c1                	sub    %eax,%ecx
  80190f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801912:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801915:	39 c2                	cmp    %eax,%edx
  801917:	0f 97 c0             	seta   %al
  80191a:	0f b6 c0             	movzbl %al,%eax
  80191d:	29 c1                	sub    %eax,%ecx
  80191f:	89 c8                	mov    %ecx,%eax
  801921:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801924:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801927:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80192a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80192d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801930:	72 b7                	jb     8018e9 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801932:	90                   	nop
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
  801938:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80193b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801942:	eb 03                	jmp    801947 <busy_wait+0x12>
  801944:	ff 45 fc             	incl   -0x4(%ebp)
  801947:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80194a:	3b 45 08             	cmp    0x8(%ebp),%eax
  80194d:	72 f5                	jb     801944 <busy_wait+0xf>
	return i;
  80194f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801952:	c9                   	leave  
  801953:	c3                   	ret    

00801954 <__udivdi3>:
  801954:	55                   	push   %ebp
  801955:	57                   	push   %edi
  801956:	56                   	push   %esi
  801957:	53                   	push   %ebx
  801958:	83 ec 1c             	sub    $0x1c,%esp
  80195b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80195f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801963:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801967:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80196b:	89 ca                	mov    %ecx,%edx
  80196d:	89 f8                	mov    %edi,%eax
  80196f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801973:	85 f6                	test   %esi,%esi
  801975:	75 2d                	jne    8019a4 <__udivdi3+0x50>
  801977:	39 cf                	cmp    %ecx,%edi
  801979:	77 65                	ja     8019e0 <__udivdi3+0x8c>
  80197b:	89 fd                	mov    %edi,%ebp
  80197d:	85 ff                	test   %edi,%edi
  80197f:	75 0b                	jne    80198c <__udivdi3+0x38>
  801981:	b8 01 00 00 00       	mov    $0x1,%eax
  801986:	31 d2                	xor    %edx,%edx
  801988:	f7 f7                	div    %edi
  80198a:	89 c5                	mov    %eax,%ebp
  80198c:	31 d2                	xor    %edx,%edx
  80198e:	89 c8                	mov    %ecx,%eax
  801990:	f7 f5                	div    %ebp
  801992:	89 c1                	mov    %eax,%ecx
  801994:	89 d8                	mov    %ebx,%eax
  801996:	f7 f5                	div    %ebp
  801998:	89 cf                	mov    %ecx,%edi
  80199a:	89 fa                	mov    %edi,%edx
  80199c:	83 c4 1c             	add    $0x1c,%esp
  80199f:	5b                   	pop    %ebx
  8019a0:	5e                   	pop    %esi
  8019a1:	5f                   	pop    %edi
  8019a2:	5d                   	pop    %ebp
  8019a3:	c3                   	ret    
  8019a4:	39 ce                	cmp    %ecx,%esi
  8019a6:	77 28                	ja     8019d0 <__udivdi3+0x7c>
  8019a8:	0f bd fe             	bsr    %esi,%edi
  8019ab:	83 f7 1f             	xor    $0x1f,%edi
  8019ae:	75 40                	jne    8019f0 <__udivdi3+0x9c>
  8019b0:	39 ce                	cmp    %ecx,%esi
  8019b2:	72 0a                	jb     8019be <__udivdi3+0x6a>
  8019b4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019b8:	0f 87 9e 00 00 00    	ja     801a5c <__udivdi3+0x108>
  8019be:	b8 01 00 00 00       	mov    $0x1,%eax
  8019c3:	89 fa                	mov    %edi,%edx
  8019c5:	83 c4 1c             	add    $0x1c,%esp
  8019c8:	5b                   	pop    %ebx
  8019c9:	5e                   	pop    %esi
  8019ca:	5f                   	pop    %edi
  8019cb:	5d                   	pop    %ebp
  8019cc:	c3                   	ret    
  8019cd:	8d 76 00             	lea    0x0(%esi),%esi
  8019d0:	31 ff                	xor    %edi,%edi
  8019d2:	31 c0                	xor    %eax,%eax
  8019d4:	89 fa                	mov    %edi,%edx
  8019d6:	83 c4 1c             	add    $0x1c,%esp
  8019d9:	5b                   	pop    %ebx
  8019da:	5e                   	pop    %esi
  8019db:	5f                   	pop    %edi
  8019dc:	5d                   	pop    %ebp
  8019dd:	c3                   	ret    
  8019de:	66 90                	xchg   %ax,%ax
  8019e0:	89 d8                	mov    %ebx,%eax
  8019e2:	f7 f7                	div    %edi
  8019e4:	31 ff                	xor    %edi,%edi
  8019e6:	89 fa                	mov    %edi,%edx
  8019e8:	83 c4 1c             	add    $0x1c,%esp
  8019eb:	5b                   	pop    %ebx
  8019ec:	5e                   	pop    %esi
  8019ed:	5f                   	pop    %edi
  8019ee:	5d                   	pop    %ebp
  8019ef:	c3                   	ret    
  8019f0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019f5:	89 eb                	mov    %ebp,%ebx
  8019f7:	29 fb                	sub    %edi,%ebx
  8019f9:	89 f9                	mov    %edi,%ecx
  8019fb:	d3 e6                	shl    %cl,%esi
  8019fd:	89 c5                	mov    %eax,%ebp
  8019ff:	88 d9                	mov    %bl,%cl
  801a01:	d3 ed                	shr    %cl,%ebp
  801a03:	89 e9                	mov    %ebp,%ecx
  801a05:	09 f1                	or     %esi,%ecx
  801a07:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a0b:	89 f9                	mov    %edi,%ecx
  801a0d:	d3 e0                	shl    %cl,%eax
  801a0f:	89 c5                	mov    %eax,%ebp
  801a11:	89 d6                	mov    %edx,%esi
  801a13:	88 d9                	mov    %bl,%cl
  801a15:	d3 ee                	shr    %cl,%esi
  801a17:	89 f9                	mov    %edi,%ecx
  801a19:	d3 e2                	shl    %cl,%edx
  801a1b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a1f:	88 d9                	mov    %bl,%cl
  801a21:	d3 e8                	shr    %cl,%eax
  801a23:	09 c2                	or     %eax,%edx
  801a25:	89 d0                	mov    %edx,%eax
  801a27:	89 f2                	mov    %esi,%edx
  801a29:	f7 74 24 0c          	divl   0xc(%esp)
  801a2d:	89 d6                	mov    %edx,%esi
  801a2f:	89 c3                	mov    %eax,%ebx
  801a31:	f7 e5                	mul    %ebp
  801a33:	39 d6                	cmp    %edx,%esi
  801a35:	72 19                	jb     801a50 <__udivdi3+0xfc>
  801a37:	74 0b                	je     801a44 <__udivdi3+0xf0>
  801a39:	89 d8                	mov    %ebx,%eax
  801a3b:	31 ff                	xor    %edi,%edi
  801a3d:	e9 58 ff ff ff       	jmp    80199a <__udivdi3+0x46>
  801a42:	66 90                	xchg   %ax,%ax
  801a44:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a48:	89 f9                	mov    %edi,%ecx
  801a4a:	d3 e2                	shl    %cl,%edx
  801a4c:	39 c2                	cmp    %eax,%edx
  801a4e:	73 e9                	jae    801a39 <__udivdi3+0xe5>
  801a50:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a53:	31 ff                	xor    %edi,%edi
  801a55:	e9 40 ff ff ff       	jmp    80199a <__udivdi3+0x46>
  801a5a:	66 90                	xchg   %ax,%ax
  801a5c:	31 c0                	xor    %eax,%eax
  801a5e:	e9 37 ff ff ff       	jmp    80199a <__udivdi3+0x46>
  801a63:	90                   	nop

00801a64 <__umoddi3>:
  801a64:	55                   	push   %ebp
  801a65:	57                   	push   %edi
  801a66:	56                   	push   %esi
  801a67:	53                   	push   %ebx
  801a68:	83 ec 1c             	sub    $0x1c,%esp
  801a6b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a6f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a73:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a77:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a7b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a7f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a83:	89 f3                	mov    %esi,%ebx
  801a85:	89 fa                	mov    %edi,%edx
  801a87:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a8b:	89 34 24             	mov    %esi,(%esp)
  801a8e:	85 c0                	test   %eax,%eax
  801a90:	75 1a                	jne    801aac <__umoddi3+0x48>
  801a92:	39 f7                	cmp    %esi,%edi
  801a94:	0f 86 a2 00 00 00    	jbe    801b3c <__umoddi3+0xd8>
  801a9a:	89 c8                	mov    %ecx,%eax
  801a9c:	89 f2                	mov    %esi,%edx
  801a9e:	f7 f7                	div    %edi
  801aa0:	89 d0                	mov    %edx,%eax
  801aa2:	31 d2                	xor    %edx,%edx
  801aa4:	83 c4 1c             	add    $0x1c,%esp
  801aa7:	5b                   	pop    %ebx
  801aa8:	5e                   	pop    %esi
  801aa9:	5f                   	pop    %edi
  801aaa:	5d                   	pop    %ebp
  801aab:	c3                   	ret    
  801aac:	39 f0                	cmp    %esi,%eax
  801aae:	0f 87 ac 00 00 00    	ja     801b60 <__umoddi3+0xfc>
  801ab4:	0f bd e8             	bsr    %eax,%ebp
  801ab7:	83 f5 1f             	xor    $0x1f,%ebp
  801aba:	0f 84 ac 00 00 00    	je     801b6c <__umoddi3+0x108>
  801ac0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ac5:	29 ef                	sub    %ebp,%edi
  801ac7:	89 fe                	mov    %edi,%esi
  801ac9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801acd:	89 e9                	mov    %ebp,%ecx
  801acf:	d3 e0                	shl    %cl,%eax
  801ad1:	89 d7                	mov    %edx,%edi
  801ad3:	89 f1                	mov    %esi,%ecx
  801ad5:	d3 ef                	shr    %cl,%edi
  801ad7:	09 c7                	or     %eax,%edi
  801ad9:	89 e9                	mov    %ebp,%ecx
  801adb:	d3 e2                	shl    %cl,%edx
  801add:	89 14 24             	mov    %edx,(%esp)
  801ae0:	89 d8                	mov    %ebx,%eax
  801ae2:	d3 e0                	shl    %cl,%eax
  801ae4:	89 c2                	mov    %eax,%edx
  801ae6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aea:	d3 e0                	shl    %cl,%eax
  801aec:	89 44 24 04          	mov    %eax,0x4(%esp)
  801af0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801af4:	89 f1                	mov    %esi,%ecx
  801af6:	d3 e8                	shr    %cl,%eax
  801af8:	09 d0                	or     %edx,%eax
  801afa:	d3 eb                	shr    %cl,%ebx
  801afc:	89 da                	mov    %ebx,%edx
  801afe:	f7 f7                	div    %edi
  801b00:	89 d3                	mov    %edx,%ebx
  801b02:	f7 24 24             	mull   (%esp)
  801b05:	89 c6                	mov    %eax,%esi
  801b07:	89 d1                	mov    %edx,%ecx
  801b09:	39 d3                	cmp    %edx,%ebx
  801b0b:	0f 82 87 00 00 00    	jb     801b98 <__umoddi3+0x134>
  801b11:	0f 84 91 00 00 00    	je     801ba8 <__umoddi3+0x144>
  801b17:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b1b:	29 f2                	sub    %esi,%edx
  801b1d:	19 cb                	sbb    %ecx,%ebx
  801b1f:	89 d8                	mov    %ebx,%eax
  801b21:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b25:	d3 e0                	shl    %cl,%eax
  801b27:	89 e9                	mov    %ebp,%ecx
  801b29:	d3 ea                	shr    %cl,%edx
  801b2b:	09 d0                	or     %edx,%eax
  801b2d:	89 e9                	mov    %ebp,%ecx
  801b2f:	d3 eb                	shr    %cl,%ebx
  801b31:	89 da                	mov    %ebx,%edx
  801b33:	83 c4 1c             	add    $0x1c,%esp
  801b36:	5b                   	pop    %ebx
  801b37:	5e                   	pop    %esi
  801b38:	5f                   	pop    %edi
  801b39:	5d                   	pop    %ebp
  801b3a:	c3                   	ret    
  801b3b:	90                   	nop
  801b3c:	89 fd                	mov    %edi,%ebp
  801b3e:	85 ff                	test   %edi,%edi
  801b40:	75 0b                	jne    801b4d <__umoddi3+0xe9>
  801b42:	b8 01 00 00 00       	mov    $0x1,%eax
  801b47:	31 d2                	xor    %edx,%edx
  801b49:	f7 f7                	div    %edi
  801b4b:	89 c5                	mov    %eax,%ebp
  801b4d:	89 f0                	mov    %esi,%eax
  801b4f:	31 d2                	xor    %edx,%edx
  801b51:	f7 f5                	div    %ebp
  801b53:	89 c8                	mov    %ecx,%eax
  801b55:	f7 f5                	div    %ebp
  801b57:	89 d0                	mov    %edx,%eax
  801b59:	e9 44 ff ff ff       	jmp    801aa2 <__umoddi3+0x3e>
  801b5e:	66 90                	xchg   %ax,%ax
  801b60:	89 c8                	mov    %ecx,%eax
  801b62:	89 f2                	mov    %esi,%edx
  801b64:	83 c4 1c             	add    $0x1c,%esp
  801b67:	5b                   	pop    %ebx
  801b68:	5e                   	pop    %esi
  801b69:	5f                   	pop    %edi
  801b6a:	5d                   	pop    %ebp
  801b6b:	c3                   	ret    
  801b6c:	3b 04 24             	cmp    (%esp),%eax
  801b6f:	72 06                	jb     801b77 <__umoddi3+0x113>
  801b71:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b75:	77 0f                	ja     801b86 <__umoddi3+0x122>
  801b77:	89 f2                	mov    %esi,%edx
  801b79:	29 f9                	sub    %edi,%ecx
  801b7b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b7f:	89 14 24             	mov    %edx,(%esp)
  801b82:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b86:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b8a:	8b 14 24             	mov    (%esp),%edx
  801b8d:	83 c4 1c             	add    $0x1c,%esp
  801b90:	5b                   	pop    %ebx
  801b91:	5e                   	pop    %esi
  801b92:	5f                   	pop    %edi
  801b93:	5d                   	pop    %ebp
  801b94:	c3                   	ret    
  801b95:	8d 76 00             	lea    0x0(%esi),%esi
  801b98:	2b 04 24             	sub    (%esp),%eax
  801b9b:	19 fa                	sbb    %edi,%edx
  801b9d:	89 d1                	mov    %edx,%ecx
  801b9f:	89 c6                	mov    %eax,%esi
  801ba1:	e9 71 ff ff ff       	jmp    801b17 <__umoddi3+0xb3>
  801ba6:	66 90                	xchg   %ax,%ax
  801ba8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801bac:	72 ea                	jb     801b98 <__umoddi3+0x134>
  801bae:	89 d9                	mov    %ebx,%ecx
  801bb0:	e9 62 ff ff ff       	jmp    801b17 <__umoddi3+0xb3>
