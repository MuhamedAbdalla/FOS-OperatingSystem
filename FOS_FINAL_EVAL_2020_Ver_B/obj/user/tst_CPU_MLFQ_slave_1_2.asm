
obj/user/tst_CPU_MLFQ_slave_1_2:     file format elf32-i386


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
  800031:	e8 98 00 00 00       	call   8000ce <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 5e                	jmp    8000a5 <_main+0x6d>
	{
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
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
  80006a:	68 e0 1b 80 00       	push   $0x801be0
  80006f:	e8 81 15 00 00       	call   8015f5 <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if (ID == E_ENV_CREATION_ERROR)
  80007a:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  80007e:	75 14                	jne    800094 <_main+0x5c>
			panic("RUNNING OUT OF ENV!! terminating...");
  800080:	83 ec 04             	sub    $0x4,%esp
  800083:	68 f0 1b 80 00       	push   $0x801bf0
  800088:	6a 0b                	push   $0xb
  80008a:	68 14 1c 80 00       	push   $0x801c14
  80008f:	e8 5f 01 00 00       	call   8001f3 <_panic>
		sys_run_env(ID);
  800094:	83 ec 0c             	sub    $0xc,%esp
  800097:	ff 75 f0             	pushl  -0x10(%ebp)
  80009a:	e8 74 15 00 00       	call   801613 <sys_run_env>
  80009f:	83 c4 10             	add    $0x10,%esp

void _main(void)
{
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  8000a2:	ff 45 f4             	incl   -0xc(%ebp)
  8000a5:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  8000a9:	7e 9c                	jle    800047 <_main+0xf>
		if (ID == E_ENV_CREATION_ERROR)
			panic("RUNNING OUT OF ENV!! terminating...");
		sys_run_env(ID);
	}

	env_sleep(100000);
  8000ab:	83 ec 0c             	sub    $0xc,%esp
  8000ae:	68 a0 86 01 00       	push   $0x186a0
  8000b3:	e8 f5 17 00 00       	call   8018ad <env_sleep>
  8000b8:	83 c4 10             	add    $0x10,%esp
	// To ensure that the slave environments completed successfully
	cprintf("Congratulations!! test CPU SCHEDULING using MLFQ is completed successfully.\n");
  8000bb:	83 ec 0c             	sub    $0xc,%esp
  8000be:	68 34 1c 80 00       	push   $0x801c34
  8000c3:	e8 e2 03 00 00       	call   8004aa <cprintf>
  8000c8:	83 c4 10             	add    $0x10,%esp

	return;
  8000cb:	90                   	nop
}
  8000cc:	c9                   	leave  
  8000cd:	c3                   	ret    

008000ce <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000ce:	55                   	push   %ebp
  8000cf:	89 e5                	mov    %esp,%ebp
  8000d1:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000d4:	e8 fc 11 00 00       	call   8012d5 <sys_getenvindex>
  8000d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000df:	89 d0                	mov    %edx,%eax
  8000e1:	c1 e0 03             	shl    $0x3,%eax
  8000e4:	01 d0                	add    %edx,%eax
  8000e6:	c1 e0 02             	shl    $0x2,%eax
  8000e9:	01 d0                	add    %edx,%eax
  8000eb:	c1 e0 06             	shl    $0x6,%eax
  8000ee:	29 d0                	sub    %edx,%eax
  8000f0:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000f7:	01 c8                	add    %ecx,%eax
  8000f9:	01 d0                	add    %edx,%eax
  8000fb:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800100:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800105:	a1 20 30 80 00       	mov    0x803020,%eax
  80010a:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  800110:	84 c0                	test   %al,%al
  800112:	74 0f                	je     800123 <libmain+0x55>
		binaryname = myEnv->prog_name;
  800114:	a1 20 30 80 00       	mov    0x803020,%eax
  800119:	05 b0 52 00 00       	add    $0x52b0,%eax
  80011e:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800123:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800127:	7e 0a                	jle    800133 <libmain+0x65>
		binaryname = argv[0];
  800129:	8b 45 0c             	mov    0xc(%ebp),%eax
  80012c:	8b 00                	mov    (%eax),%eax
  80012e:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800133:	83 ec 08             	sub    $0x8,%esp
  800136:	ff 75 0c             	pushl  0xc(%ebp)
  800139:	ff 75 08             	pushl  0x8(%ebp)
  80013c:	e8 f7 fe ff ff       	call   800038 <_main>
  800141:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800144:	e8 27 13 00 00       	call   801470 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800149:	83 ec 0c             	sub    $0xc,%esp
  80014c:	68 9c 1c 80 00       	push   $0x801c9c
  800151:	e8 54 03 00 00       	call   8004aa <cprintf>
  800156:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800159:	a1 20 30 80 00       	mov    0x803020,%eax
  80015e:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800164:	a1 20 30 80 00       	mov    0x803020,%eax
  800169:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  80016f:	83 ec 04             	sub    $0x4,%esp
  800172:	52                   	push   %edx
  800173:	50                   	push   %eax
  800174:	68 c4 1c 80 00       	push   $0x801cc4
  800179:	e8 2c 03 00 00       	call   8004aa <cprintf>
  80017e:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800181:	a1 20 30 80 00       	mov    0x803020,%eax
  800186:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  80018c:	a1 20 30 80 00       	mov    0x803020,%eax
  800191:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800197:	a1 20 30 80 00       	mov    0x803020,%eax
  80019c:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  8001a2:	51                   	push   %ecx
  8001a3:	52                   	push   %edx
  8001a4:	50                   	push   %eax
  8001a5:	68 ec 1c 80 00       	push   $0x801cec
  8001aa:	e8 fb 02 00 00       	call   8004aa <cprintf>
  8001af:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8001b2:	83 ec 0c             	sub    $0xc,%esp
  8001b5:	68 9c 1c 80 00       	push   $0x801c9c
  8001ba:	e8 eb 02 00 00       	call   8004aa <cprintf>
  8001bf:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001c2:	e8 c3 12 00 00       	call   80148a <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001c7:	e8 19 00 00 00       	call   8001e5 <exit>
}
  8001cc:	90                   	nop
  8001cd:	c9                   	leave  
  8001ce:	c3                   	ret    

008001cf <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001cf:	55                   	push   %ebp
  8001d0:	89 e5                	mov    %esp,%ebp
  8001d2:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001d5:	83 ec 0c             	sub    $0xc,%esp
  8001d8:	6a 00                	push   $0x0
  8001da:	e8 c2 10 00 00       	call   8012a1 <sys_env_destroy>
  8001df:	83 c4 10             	add    $0x10,%esp
}
  8001e2:	90                   	nop
  8001e3:	c9                   	leave  
  8001e4:	c3                   	ret    

008001e5 <exit>:

void
exit(void)
{
  8001e5:	55                   	push   %ebp
  8001e6:	89 e5                	mov    %esp,%ebp
  8001e8:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001eb:	e8 17 11 00 00       	call   801307 <sys_env_exit>
}
  8001f0:	90                   	nop
  8001f1:	c9                   	leave  
  8001f2:	c3                   	ret    

008001f3 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8001f3:	55                   	push   %ebp
  8001f4:	89 e5                	mov    %esp,%ebp
  8001f6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8001f9:	8d 45 10             	lea    0x10(%ebp),%eax
  8001fc:	83 c0 04             	add    $0x4,%eax
  8001ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800202:	a1 18 31 80 00       	mov    0x803118,%eax
  800207:	85 c0                	test   %eax,%eax
  800209:	74 16                	je     800221 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80020b:	a1 18 31 80 00       	mov    0x803118,%eax
  800210:	83 ec 08             	sub    $0x8,%esp
  800213:	50                   	push   %eax
  800214:	68 44 1d 80 00       	push   $0x801d44
  800219:	e8 8c 02 00 00       	call   8004aa <cprintf>
  80021e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800221:	a1 00 30 80 00       	mov    0x803000,%eax
  800226:	ff 75 0c             	pushl  0xc(%ebp)
  800229:	ff 75 08             	pushl  0x8(%ebp)
  80022c:	50                   	push   %eax
  80022d:	68 49 1d 80 00       	push   $0x801d49
  800232:	e8 73 02 00 00       	call   8004aa <cprintf>
  800237:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80023a:	8b 45 10             	mov    0x10(%ebp),%eax
  80023d:	83 ec 08             	sub    $0x8,%esp
  800240:	ff 75 f4             	pushl  -0xc(%ebp)
  800243:	50                   	push   %eax
  800244:	e8 f6 01 00 00       	call   80043f <vcprintf>
  800249:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80024c:	83 ec 08             	sub    $0x8,%esp
  80024f:	6a 00                	push   $0x0
  800251:	68 65 1d 80 00       	push   $0x801d65
  800256:	e8 e4 01 00 00       	call   80043f <vcprintf>
  80025b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80025e:	e8 82 ff ff ff       	call   8001e5 <exit>

	// should not return here
	while (1) ;
  800263:	eb fe                	jmp    800263 <_panic+0x70>

00800265 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800265:	55                   	push   %ebp
  800266:	89 e5                	mov    %esp,%ebp
  800268:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80026b:	a1 20 30 80 00       	mov    0x803020,%eax
  800270:	8b 50 74             	mov    0x74(%eax),%edx
  800273:	8b 45 0c             	mov    0xc(%ebp),%eax
  800276:	39 c2                	cmp    %eax,%edx
  800278:	74 14                	je     80028e <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80027a:	83 ec 04             	sub    $0x4,%esp
  80027d:	68 68 1d 80 00       	push   $0x801d68
  800282:	6a 26                	push   $0x26
  800284:	68 b4 1d 80 00       	push   $0x801db4
  800289:	e8 65 ff ff ff       	call   8001f3 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80028e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800295:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80029c:	e9 c4 00 00 00       	jmp    800365 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8002a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002a4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ae:	01 d0                	add    %edx,%eax
  8002b0:	8b 00                	mov    (%eax),%eax
  8002b2:	85 c0                	test   %eax,%eax
  8002b4:	75 08                	jne    8002be <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8002b6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8002b9:	e9 a4 00 00 00       	jmp    800362 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8002be:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002c5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002cc:	eb 6b                	jmp    800339 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8002ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d3:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8002d9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002dc:	89 d0                	mov    %edx,%eax
  8002de:	c1 e0 02             	shl    $0x2,%eax
  8002e1:	01 d0                	add    %edx,%eax
  8002e3:	c1 e0 02             	shl    $0x2,%eax
  8002e6:	01 c8                	add    %ecx,%eax
  8002e8:	8a 40 04             	mov    0x4(%eax),%al
  8002eb:	84 c0                	test   %al,%al
  8002ed:	75 47                	jne    800336 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f4:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8002fa:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002fd:	89 d0                	mov    %edx,%eax
  8002ff:	c1 e0 02             	shl    $0x2,%eax
  800302:	01 d0                	add    %edx,%eax
  800304:	c1 e0 02             	shl    $0x2,%eax
  800307:	01 c8                	add    %ecx,%eax
  800309:	8b 00                	mov    (%eax),%eax
  80030b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80030e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800311:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800316:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800318:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80031b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800322:	8b 45 08             	mov    0x8(%ebp),%eax
  800325:	01 c8                	add    %ecx,%eax
  800327:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800329:	39 c2                	cmp    %eax,%edx
  80032b:	75 09                	jne    800336 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80032d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800334:	eb 12                	jmp    800348 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800336:	ff 45 e8             	incl   -0x18(%ebp)
  800339:	a1 20 30 80 00       	mov    0x803020,%eax
  80033e:	8b 50 74             	mov    0x74(%eax),%edx
  800341:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800344:	39 c2                	cmp    %eax,%edx
  800346:	77 86                	ja     8002ce <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800348:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80034c:	75 14                	jne    800362 <CheckWSWithoutLastIndex+0xfd>
			panic(
  80034e:	83 ec 04             	sub    $0x4,%esp
  800351:	68 c0 1d 80 00       	push   $0x801dc0
  800356:	6a 3a                	push   $0x3a
  800358:	68 b4 1d 80 00       	push   $0x801db4
  80035d:	e8 91 fe ff ff       	call   8001f3 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800362:	ff 45 f0             	incl   -0x10(%ebp)
  800365:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800368:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80036b:	0f 8c 30 ff ff ff    	jl     8002a1 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800371:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800378:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80037f:	eb 27                	jmp    8003a8 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800381:	a1 20 30 80 00       	mov    0x803020,%eax
  800386:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80038c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80038f:	89 d0                	mov    %edx,%eax
  800391:	c1 e0 02             	shl    $0x2,%eax
  800394:	01 d0                	add    %edx,%eax
  800396:	c1 e0 02             	shl    $0x2,%eax
  800399:	01 c8                	add    %ecx,%eax
  80039b:	8a 40 04             	mov    0x4(%eax),%al
  80039e:	3c 01                	cmp    $0x1,%al
  8003a0:	75 03                	jne    8003a5 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8003a2:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003a5:	ff 45 e0             	incl   -0x20(%ebp)
  8003a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ad:	8b 50 74             	mov    0x74(%eax),%edx
  8003b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003b3:	39 c2                	cmp    %eax,%edx
  8003b5:	77 ca                	ja     800381 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8003b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ba:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8003bd:	74 14                	je     8003d3 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8003bf:	83 ec 04             	sub    $0x4,%esp
  8003c2:	68 14 1e 80 00       	push   $0x801e14
  8003c7:	6a 44                	push   $0x44
  8003c9:	68 b4 1d 80 00       	push   $0x801db4
  8003ce:	e8 20 fe ff ff       	call   8001f3 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8003d3:	90                   	nop
  8003d4:	c9                   	leave  
  8003d5:	c3                   	ret    

008003d6 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8003d6:	55                   	push   %ebp
  8003d7:	89 e5                	mov    %esp,%ebp
  8003d9:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8003dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003df:	8b 00                	mov    (%eax),%eax
  8003e1:	8d 48 01             	lea    0x1(%eax),%ecx
  8003e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003e7:	89 0a                	mov    %ecx,(%edx)
  8003e9:	8b 55 08             	mov    0x8(%ebp),%edx
  8003ec:	88 d1                	mov    %dl,%cl
  8003ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003f1:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8003f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f8:	8b 00                	mov    (%eax),%eax
  8003fa:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003ff:	75 2c                	jne    80042d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800401:	a0 24 30 80 00       	mov    0x803024,%al
  800406:	0f b6 c0             	movzbl %al,%eax
  800409:	8b 55 0c             	mov    0xc(%ebp),%edx
  80040c:	8b 12                	mov    (%edx),%edx
  80040e:	89 d1                	mov    %edx,%ecx
  800410:	8b 55 0c             	mov    0xc(%ebp),%edx
  800413:	83 c2 08             	add    $0x8,%edx
  800416:	83 ec 04             	sub    $0x4,%esp
  800419:	50                   	push   %eax
  80041a:	51                   	push   %ecx
  80041b:	52                   	push   %edx
  80041c:	e8 3e 0e 00 00       	call   80125f <sys_cputs>
  800421:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800424:	8b 45 0c             	mov    0xc(%ebp),%eax
  800427:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80042d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800430:	8b 40 04             	mov    0x4(%eax),%eax
  800433:	8d 50 01             	lea    0x1(%eax),%edx
  800436:	8b 45 0c             	mov    0xc(%ebp),%eax
  800439:	89 50 04             	mov    %edx,0x4(%eax)
}
  80043c:	90                   	nop
  80043d:	c9                   	leave  
  80043e:	c3                   	ret    

0080043f <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80043f:	55                   	push   %ebp
  800440:	89 e5                	mov    %esp,%ebp
  800442:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800448:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80044f:	00 00 00 
	b.cnt = 0;
  800452:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800459:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80045c:	ff 75 0c             	pushl  0xc(%ebp)
  80045f:	ff 75 08             	pushl  0x8(%ebp)
  800462:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800468:	50                   	push   %eax
  800469:	68 d6 03 80 00       	push   $0x8003d6
  80046e:	e8 11 02 00 00       	call   800684 <vprintfmt>
  800473:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800476:	a0 24 30 80 00       	mov    0x803024,%al
  80047b:	0f b6 c0             	movzbl %al,%eax
  80047e:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800484:	83 ec 04             	sub    $0x4,%esp
  800487:	50                   	push   %eax
  800488:	52                   	push   %edx
  800489:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80048f:	83 c0 08             	add    $0x8,%eax
  800492:	50                   	push   %eax
  800493:	e8 c7 0d 00 00       	call   80125f <sys_cputs>
  800498:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80049b:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8004a2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004a8:	c9                   	leave  
  8004a9:	c3                   	ret    

008004aa <cprintf>:

int cprintf(const char *fmt, ...) {
  8004aa:	55                   	push   %ebp
  8004ab:	89 e5                	mov    %esp,%ebp
  8004ad:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004b0:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8004b7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c0:	83 ec 08             	sub    $0x8,%esp
  8004c3:	ff 75 f4             	pushl  -0xc(%ebp)
  8004c6:	50                   	push   %eax
  8004c7:	e8 73 ff ff ff       	call   80043f <vcprintf>
  8004cc:	83 c4 10             	add    $0x10,%esp
  8004cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8004d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004d5:	c9                   	leave  
  8004d6:	c3                   	ret    

008004d7 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8004d7:	55                   	push   %ebp
  8004d8:	89 e5                	mov    %esp,%ebp
  8004da:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8004dd:	e8 8e 0f 00 00       	call   801470 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8004e2:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004eb:	83 ec 08             	sub    $0x8,%esp
  8004ee:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f1:	50                   	push   %eax
  8004f2:	e8 48 ff ff ff       	call   80043f <vcprintf>
  8004f7:	83 c4 10             	add    $0x10,%esp
  8004fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8004fd:	e8 88 0f 00 00       	call   80148a <sys_enable_interrupt>
	return cnt;
  800502:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800505:	c9                   	leave  
  800506:	c3                   	ret    

00800507 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800507:	55                   	push   %ebp
  800508:	89 e5                	mov    %esp,%ebp
  80050a:	53                   	push   %ebx
  80050b:	83 ec 14             	sub    $0x14,%esp
  80050e:	8b 45 10             	mov    0x10(%ebp),%eax
  800511:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800514:	8b 45 14             	mov    0x14(%ebp),%eax
  800517:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80051a:	8b 45 18             	mov    0x18(%ebp),%eax
  80051d:	ba 00 00 00 00       	mov    $0x0,%edx
  800522:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800525:	77 55                	ja     80057c <printnum+0x75>
  800527:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80052a:	72 05                	jb     800531 <printnum+0x2a>
  80052c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80052f:	77 4b                	ja     80057c <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800531:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800534:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800537:	8b 45 18             	mov    0x18(%ebp),%eax
  80053a:	ba 00 00 00 00       	mov    $0x0,%edx
  80053f:	52                   	push   %edx
  800540:	50                   	push   %eax
  800541:	ff 75 f4             	pushl  -0xc(%ebp)
  800544:	ff 75 f0             	pushl  -0x10(%ebp)
  800547:	e8 18 14 00 00       	call   801964 <__udivdi3>
  80054c:	83 c4 10             	add    $0x10,%esp
  80054f:	83 ec 04             	sub    $0x4,%esp
  800552:	ff 75 20             	pushl  0x20(%ebp)
  800555:	53                   	push   %ebx
  800556:	ff 75 18             	pushl  0x18(%ebp)
  800559:	52                   	push   %edx
  80055a:	50                   	push   %eax
  80055b:	ff 75 0c             	pushl  0xc(%ebp)
  80055e:	ff 75 08             	pushl  0x8(%ebp)
  800561:	e8 a1 ff ff ff       	call   800507 <printnum>
  800566:	83 c4 20             	add    $0x20,%esp
  800569:	eb 1a                	jmp    800585 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80056b:	83 ec 08             	sub    $0x8,%esp
  80056e:	ff 75 0c             	pushl  0xc(%ebp)
  800571:	ff 75 20             	pushl  0x20(%ebp)
  800574:	8b 45 08             	mov    0x8(%ebp),%eax
  800577:	ff d0                	call   *%eax
  800579:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80057c:	ff 4d 1c             	decl   0x1c(%ebp)
  80057f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800583:	7f e6                	jg     80056b <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800585:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800588:	bb 00 00 00 00       	mov    $0x0,%ebx
  80058d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800590:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800593:	53                   	push   %ebx
  800594:	51                   	push   %ecx
  800595:	52                   	push   %edx
  800596:	50                   	push   %eax
  800597:	e8 d8 14 00 00       	call   801a74 <__umoddi3>
  80059c:	83 c4 10             	add    $0x10,%esp
  80059f:	05 74 20 80 00       	add    $0x802074,%eax
  8005a4:	8a 00                	mov    (%eax),%al
  8005a6:	0f be c0             	movsbl %al,%eax
  8005a9:	83 ec 08             	sub    $0x8,%esp
  8005ac:	ff 75 0c             	pushl  0xc(%ebp)
  8005af:	50                   	push   %eax
  8005b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b3:	ff d0                	call   *%eax
  8005b5:	83 c4 10             	add    $0x10,%esp
}
  8005b8:	90                   	nop
  8005b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005bc:	c9                   	leave  
  8005bd:	c3                   	ret    

008005be <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8005be:	55                   	push   %ebp
  8005bf:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005c1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005c5:	7e 1c                	jle    8005e3 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8005c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ca:	8b 00                	mov    (%eax),%eax
  8005cc:	8d 50 08             	lea    0x8(%eax),%edx
  8005cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d2:	89 10                	mov    %edx,(%eax)
  8005d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d7:	8b 00                	mov    (%eax),%eax
  8005d9:	83 e8 08             	sub    $0x8,%eax
  8005dc:	8b 50 04             	mov    0x4(%eax),%edx
  8005df:	8b 00                	mov    (%eax),%eax
  8005e1:	eb 40                	jmp    800623 <getuint+0x65>
	else if (lflag)
  8005e3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005e7:	74 1e                	je     800607 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ec:	8b 00                	mov    (%eax),%eax
  8005ee:	8d 50 04             	lea    0x4(%eax),%edx
  8005f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f4:	89 10                	mov    %edx,(%eax)
  8005f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f9:	8b 00                	mov    (%eax),%eax
  8005fb:	83 e8 04             	sub    $0x4,%eax
  8005fe:	8b 00                	mov    (%eax),%eax
  800600:	ba 00 00 00 00       	mov    $0x0,%edx
  800605:	eb 1c                	jmp    800623 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800607:	8b 45 08             	mov    0x8(%ebp),%eax
  80060a:	8b 00                	mov    (%eax),%eax
  80060c:	8d 50 04             	lea    0x4(%eax),%edx
  80060f:	8b 45 08             	mov    0x8(%ebp),%eax
  800612:	89 10                	mov    %edx,(%eax)
  800614:	8b 45 08             	mov    0x8(%ebp),%eax
  800617:	8b 00                	mov    (%eax),%eax
  800619:	83 e8 04             	sub    $0x4,%eax
  80061c:	8b 00                	mov    (%eax),%eax
  80061e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800623:	5d                   	pop    %ebp
  800624:	c3                   	ret    

00800625 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800625:	55                   	push   %ebp
  800626:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800628:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80062c:	7e 1c                	jle    80064a <getint+0x25>
		return va_arg(*ap, long long);
  80062e:	8b 45 08             	mov    0x8(%ebp),%eax
  800631:	8b 00                	mov    (%eax),%eax
  800633:	8d 50 08             	lea    0x8(%eax),%edx
  800636:	8b 45 08             	mov    0x8(%ebp),%eax
  800639:	89 10                	mov    %edx,(%eax)
  80063b:	8b 45 08             	mov    0x8(%ebp),%eax
  80063e:	8b 00                	mov    (%eax),%eax
  800640:	83 e8 08             	sub    $0x8,%eax
  800643:	8b 50 04             	mov    0x4(%eax),%edx
  800646:	8b 00                	mov    (%eax),%eax
  800648:	eb 38                	jmp    800682 <getint+0x5d>
	else if (lflag)
  80064a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80064e:	74 1a                	je     80066a <getint+0x45>
		return va_arg(*ap, long);
  800650:	8b 45 08             	mov    0x8(%ebp),%eax
  800653:	8b 00                	mov    (%eax),%eax
  800655:	8d 50 04             	lea    0x4(%eax),%edx
  800658:	8b 45 08             	mov    0x8(%ebp),%eax
  80065b:	89 10                	mov    %edx,(%eax)
  80065d:	8b 45 08             	mov    0x8(%ebp),%eax
  800660:	8b 00                	mov    (%eax),%eax
  800662:	83 e8 04             	sub    $0x4,%eax
  800665:	8b 00                	mov    (%eax),%eax
  800667:	99                   	cltd   
  800668:	eb 18                	jmp    800682 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80066a:	8b 45 08             	mov    0x8(%ebp),%eax
  80066d:	8b 00                	mov    (%eax),%eax
  80066f:	8d 50 04             	lea    0x4(%eax),%edx
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	89 10                	mov    %edx,(%eax)
  800677:	8b 45 08             	mov    0x8(%ebp),%eax
  80067a:	8b 00                	mov    (%eax),%eax
  80067c:	83 e8 04             	sub    $0x4,%eax
  80067f:	8b 00                	mov    (%eax),%eax
  800681:	99                   	cltd   
}
  800682:	5d                   	pop    %ebp
  800683:	c3                   	ret    

00800684 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800684:	55                   	push   %ebp
  800685:	89 e5                	mov    %esp,%ebp
  800687:	56                   	push   %esi
  800688:	53                   	push   %ebx
  800689:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80068c:	eb 17                	jmp    8006a5 <vprintfmt+0x21>
			if (ch == '\0')
  80068e:	85 db                	test   %ebx,%ebx
  800690:	0f 84 af 03 00 00    	je     800a45 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800696:	83 ec 08             	sub    $0x8,%esp
  800699:	ff 75 0c             	pushl  0xc(%ebp)
  80069c:	53                   	push   %ebx
  80069d:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a0:	ff d0                	call   *%eax
  8006a2:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8006a8:	8d 50 01             	lea    0x1(%eax),%edx
  8006ab:	89 55 10             	mov    %edx,0x10(%ebp)
  8006ae:	8a 00                	mov    (%eax),%al
  8006b0:	0f b6 d8             	movzbl %al,%ebx
  8006b3:	83 fb 25             	cmp    $0x25,%ebx
  8006b6:	75 d6                	jne    80068e <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8006b8:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8006bc:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8006c3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8006ca:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8006d1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8006d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8006db:	8d 50 01             	lea    0x1(%eax),%edx
  8006de:	89 55 10             	mov    %edx,0x10(%ebp)
  8006e1:	8a 00                	mov    (%eax),%al
  8006e3:	0f b6 d8             	movzbl %al,%ebx
  8006e6:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006e9:	83 f8 55             	cmp    $0x55,%eax
  8006ec:	0f 87 2b 03 00 00    	ja     800a1d <vprintfmt+0x399>
  8006f2:	8b 04 85 98 20 80 00 	mov    0x802098(,%eax,4),%eax
  8006f9:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006fb:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006ff:	eb d7                	jmp    8006d8 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800701:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800705:	eb d1                	jmp    8006d8 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800707:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80070e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800711:	89 d0                	mov    %edx,%eax
  800713:	c1 e0 02             	shl    $0x2,%eax
  800716:	01 d0                	add    %edx,%eax
  800718:	01 c0                	add    %eax,%eax
  80071a:	01 d8                	add    %ebx,%eax
  80071c:	83 e8 30             	sub    $0x30,%eax
  80071f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800722:	8b 45 10             	mov    0x10(%ebp),%eax
  800725:	8a 00                	mov    (%eax),%al
  800727:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80072a:	83 fb 2f             	cmp    $0x2f,%ebx
  80072d:	7e 3e                	jle    80076d <vprintfmt+0xe9>
  80072f:	83 fb 39             	cmp    $0x39,%ebx
  800732:	7f 39                	jg     80076d <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800734:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800737:	eb d5                	jmp    80070e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800739:	8b 45 14             	mov    0x14(%ebp),%eax
  80073c:	83 c0 04             	add    $0x4,%eax
  80073f:	89 45 14             	mov    %eax,0x14(%ebp)
  800742:	8b 45 14             	mov    0x14(%ebp),%eax
  800745:	83 e8 04             	sub    $0x4,%eax
  800748:	8b 00                	mov    (%eax),%eax
  80074a:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80074d:	eb 1f                	jmp    80076e <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80074f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800753:	79 83                	jns    8006d8 <vprintfmt+0x54>
				width = 0;
  800755:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80075c:	e9 77 ff ff ff       	jmp    8006d8 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800761:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800768:	e9 6b ff ff ff       	jmp    8006d8 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80076d:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80076e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800772:	0f 89 60 ff ff ff    	jns    8006d8 <vprintfmt+0x54>
				width = precision, precision = -1;
  800778:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80077b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80077e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800785:	e9 4e ff ff ff       	jmp    8006d8 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80078a:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80078d:	e9 46 ff ff ff       	jmp    8006d8 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800792:	8b 45 14             	mov    0x14(%ebp),%eax
  800795:	83 c0 04             	add    $0x4,%eax
  800798:	89 45 14             	mov    %eax,0x14(%ebp)
  80079b:	8b 45 14             	mov    0x14(%ebp),%eax
  80079e:	83 e8 04             	sub    $0x4,%eax
  8007a1:	8b 00                	mov    (%eax),%eax
  8007a3:	83 ec 08             	sub    $0x8,%esp
  8007a6:	ff 75 0c             	pushl  0xc(%ebp)
  8007a9:	50                   	push   %eax
  8007aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ad:	ff d0                	call   *%eax
  8007af:	83 c4 10             	add    $0x10,%esp
			break;
  8007b2:	e9 89 02 00 00       	jmp    800a40 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ba:	83 c0 04             	add    $0x4,%eax
  8007bd:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c3:	83 e8 04             	sub    $0x4,%eax
  8007c6:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8007c8:	85 db                	test   %ebx,%ebx
  8007ca:	79 02                	jns    8007ce <vprintfmt+0x14a>
				err = -err;
  8007cc:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8007ce:	83 fb 64             	cmp    $0x64,%ebx
  8007d1:	7f 0b                	jg     8007de <vprintfmt+0x15a>
  8007d3:	8b 34 9d e0 1e 80 00 	mov    0x801ee0(,%ebx,4),%esi
  8007da:	85 f6                	test   %esi,%esi
  8007dc:	75 19                	jne    8007f7 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8007de:	53                   	push   %ebx
  8007df:	68 85 20 80 00       	push   $0x802085
  8007e4:	ff 75 0c             	pushl  0xc(%ebp)
  8007e7:	ff 75 08             	pushl  0x8(%ebp)
  8007ea:	e8 5e 02 00 00       	call   800a4d <printfmt>
  8007ef:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007f2:	e9 49 02 00 00       	jmp    800a40 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007f7:	56                   	push   %esi
  8007f8:	68 8e 20 80 00       	push   $0x80208e
  8007fd:	ff 75 0c             	pushl  0xc(%ebp)
  800800:	ff 75 08             	pushl  0x8(%ebp)
  800803:	e8 45 02 00 00       	call   800a4d <printfmt>
  800808:	83 c4 10             	add    $0x10,%esp
			break;
  80080b:	e9 30 02 00 00       	jmp    800a40 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800810:	8b 45 14             	mov    0x14(%ebp),%eax
  800813:	83 c0 04             	add    $0x4,%eax
  800816:	89 45 14             	mov    %eax,0x14(%ebp)
  800819:	8b 45 14             	mov    0x14(%ebp),%eax
  80081c:	83 e8 04             	sub    $0x4,%eax
  80081f:	8b 30                	mov    (%eax),%esi
  800821:	85 f6                	test   %esi,%esi
  800823:	75 05                	jne    80082a <vprintfmt+0x1a6>
				p = "(null)";
  800825:	be 91 20 80 00       	mov    $0x802091,%esi
			if (width > 0 && padc != '-')
  80082a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80082e:	7e 6d                	jle    80089d <vprintfmt+0x219>
  800830:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800834:	74 67                	je     80089d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800836:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800839:	83 ec 08             	sub    $0x8,%esp
  80083c:	50                   	push   %eax
  80083d:	56                   	push   %esi
  80083e:	e8 0c 03 00 00       	call   800b4f <strnlen>
  800843:	83 c4 10             	add    $0x10,%esp
  800846:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800849:	eb 16                	jmp    800861 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80084b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80084f:	83 ec 08             	sub    $0x8,%esp
  800852:	ff 75 0c             	pushl  0xc(%ebp)
  800855:	50                   	push   %eax
  800856:	8b 45 08             	mov    0x8(%ebp),%eax
  800859:	ff d0                	call   *%eax
  80085b:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80085e:	ff 4d e4             	decl   -0x1c(%ebp)
  800861:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800865:	7f e4                	jg     80084b <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800867:	eb 34                	jmp    80089d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800869:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80086d:	74 1c                	je     80088b <vprintfmt+0x207>
  80086f:	83 fb 1f             	cmp    $0x1f,%ebx
  800872:	7e 05                	jle    800879 <vprintfmt+0x1f5>
  800874:	83 fb 7e             	cmp    $0x7e,%ebx
  800877:	7e 12                	jle    80088b <vprintfmt+0x207>
					putch('?', putdat);
  800879:	83 ec 08             	sub    $0x8,%esp
  80087c:	ff 75 0c             	pushl  0xc(%ebp)
  80087f:	6a 3f                	push   $0x3f
  800881:	8b 45 08             	mov    0x8(%ebp),%eax
  800884:	ff d0                	call   *%eax
  800886:	83 c4 10             	add    $0x10,%esp
  800889:	eb 0f                	jmp    80089a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80088b:	83 ec 08             	sub    $0x8,%esp
  80088e:	ff 75 0c             	pushl  0xc(%ebp)
  800891:	53                   	push   %ebx
  800892:	8b 45 08             	mov    0x8(%ebp),%eax
  800895:	ff d0                	call   *%eax
  800897:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80089a:	ff 4d e4             	decl   -0x1c(%ebp)
  80089d:	89 f0                	mov    %esi,%eax
  80089f:	8d 70 01             	lea    0x1(%eax),%esi
  8008a2:	8a 00                	mov    (%eax),%al
  8008a4:	0f be d8             	movsbl %al,%ebx
  8008a7:	85 db                	test   %ebx,%ebx
  8008a9:	74 24                	je     8008cf <vprintfmt+0x24b>
  8008ab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008af:	78 b8                	js     800869 <vprintfmt+0x1e5>
  8008b1:	ff 4d e0             	decl   -0x20(%ebp)
  8008b4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008b8:	79 af                	jns    800869 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008ba:	eb 13                	jmp    8008cf <vprintfmt+0x24b>
				putch(' ', putdat);
  8008bc:	83 ec 08             	sub    $0x8,%esp
  8008bf:	ff 75 0c             	pushl  0xc(%ebp)
  8008c2:	6a 20                	push   $0x20
  8008c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c7:	ff d0                	call   *%eax
  8008c9:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008cc:	ff 4d e4             	decl   -0x1c(%ebp)
  8008cf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008d3:	7f e7                	jg     8008bc <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8008d5:	e9 66 01 00 00       	jmp    800a40 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8008da:	83 ec 08             	sub    $0x8,%esp
  8008dd:	ff 75 e8             	pushl  -0x18(%ebp)
  8008e0:	8d 45 14             	lea    0x14(%ebp),%eax
  8008e3:	50                   	push   %eax
  8008e4:	e8 3c fd ff ff       	call   800625 <getint>
  8008e9:	83 c4 10             	add    $0x10,%esp
  8008ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ef:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008f8:	85 d2                	test   %edx,%edx
  8008fa:	79 23                	jns    80091f <vprintfmt+0x29b>
				putch('-', putdat);
  8008fc:	83 ec 08             	sub    $0x8,%esp
  8008ff:	ff 75 0c             	pushl  0xc(%ebp)
  800902:	6a 2d                	push   $0x2d
  800904:	8b 45 08             	mov    0x8(%ebp),%eax
  800907:	ff d0                	call   *%eax
  800909:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80090c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80090f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800912:	f7 d8                	neg    %eax
  800914:	83 d2 00             	adc    $0x0,%edx
  800917:	f7 da                	neg    %edx
  800919:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80091c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80091f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800926:	e9 bc 00 00 00       	jmp    8009e7 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80092b:	83 ec 08             	sub    $0x8,%esp
  80092e:	ff 75 e8             	pushl  -0x18(%ebp)
  800931:	8d 45 14             	lea    0x14(%ebp),%eax
  800934:	50                   	push   %eax
  800935:	e8 84 fc ff ff       	call   8005be <getuint>
  80093a:	83 c4 10             	add    $0x10,%esp
  80093d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800940:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800943:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80094a:	e9 98 00 00 00       	jmp    8009e7 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80094f:	83 ec 08             	sub    $0x8,%esp
  800952:	ff 75 0c             	pushl  0xc(%ebp)
  800955:	6a 58                	push   $0x58
  800957:	8b 45 08             	mov    0x8(%ebp),%eax
  80095a:	ff d0                	call   *%eax
  80095c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80095f:	83 ec 08             	sub    $0x8,%esp
  800962:	ff 75 0c             	pushl  0xc(%ebp)
  800965:	6a 58                	push   $0x58
  800967:	8b 45 08             	mov    0x8(%ebp),%eax
  80096a:	ff d0                	call   *%eax
  80096c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80096f:	83 ec 08             	sub    $0x8,%esp
  800972:	ff 75 0c             	pushl  0xc(%ebp)
  800975:	6a 58                	push   $0x58
  800977:	8b 45 08             	mov    0x8(%ebp),%eax
  80097a:	ff d0                	call   *%eax
  80097c:	83 c4 10             	add    $0x10,%esp
			break;
  80097f:	e9 bc 00 00 00       	jmp    800a40 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800984:	83 ec 08             	sub    $0x8,%esp
  800987:	ff 75 0c             	pushl  0xc(%ebp)
  80098a:	6a 30                	push   $0x30
  80098c:	8b 45 08             	mov    0x8(%ebp),%eax
  80098f:	ff d0                	call   *%eax
  800991:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800994:	83 ec 08             	sub    $0x8,%esp
  800997:	ff 75 0c             	pushl  0xc(%ebp)
  80099a:	6a 78                	push   $0x78
  80099c:	8b 45 08             	mov    0x8(%ebp),%eax
  80099f:	ff d0                	call   *%eax
  8009a1:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a7:	83 c0 04             	add    $0x4,%eax
  8009aa:	89 45 14             	mov    %eax,0x14(%ebp)
  8009ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b0:	83 e8 04             	sub    $0x4,%eax
  8009b3:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8009bf:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8009c6:	eb 1f                	jmp    8009e7 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8009c8:	83 ec 08             	sub    $0x8,%esp
  8009cb:	ff 75 e8             	pushl  -0x18(%ebp)
  8009ce:	8d 45 14             	lea    0x14(%ebp),%eax
  8009d1:	50                   	push   %eax
  8009d2:	e8 e7 fb ff ff       	call   8005be <getuint>
  8009d7:	83 c4 10             	add    $0x10,%esp
  8009da:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009dd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8009e0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009e7:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009ee:	83 ec 04             	sub    $0x4,%esp
  8009f1:	52                   	push   %edx
  8009f2:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009f5:	50                   	push   %eax
  8009f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f9:	ff 75 f0             	pushl  -0x10(%ebp)
  8009fc:	ff 75 0c             	pushl  0xc(%ebp)
  8009ff:	ff 75 08             	pushl  0x8(%ebp)
  800a02:	e8 00 fb ff ff       	call   800507 <printnum>
  800a07:	83 c4 20             	add    $0x20,%esp
			break;
  800a0a:	eb 34                	jmp    800a40 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a0c:	83 ec 08             	sub    $0x8,%esp
  800a0f:	ff 75 0c             	pushl  0xc(%ebp)
  800a12:	53                   	push   %ebx
  800a13:	8b 45 08             	mov    0x8(%ebp),%eax
  800a16:	ff d0                	call   *%eax
  800a18:	83 c4 10             	add    $0x10,%esp
			break;
  800a1b:	eb 23                	jmp    800a40 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a1d:	83 ec 08             	sub    $0x8,%esp
  800a20:	ff 75 0c             	pushl  0xc(%ebp)
  800a23:	6a 25                	push   $0x25
  800a25:	8b 45 08             	mov    0x8(%ebp),%eax
  800a28:	ff d0                	call   *%eax
  800a2a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a2d:	ff 4d 10             	decl   0x10(%ebp)
  800a30:	eb 03                	jmp    800a35 <vprintfmt+0x3b1>
  800a32:	ff 4d 10             	decl   0x10(%ebp)
  800a35:	8b 45 10             	mov    0x10(%ebp),%eax
  800a38:	48                   	dec    %eax
  800a39:	8a 00                	mov    (%eax),%al
  800a3b:	3c 25                	cmp    $0x25,%al
  800a3d:	75 f3                	jne    800a32 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a3f:	90                   	nop
		}
	}
  800a40:	e9 47 fc ff ff       	jmp    80068c <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a45:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a46:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a49:	5b                   	pop    %ebx
  800a4a:	5e                   	pop    %esi
  800a4b:	5d                   	pop    %ebp
  800a4c:	c3                   	ret    

00800a4d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a4d:	55                   	push   %ebp
  800a4e:	89 e5                	mov    %esp,%ebp
  800a50:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a53:	8d 45 10             	lea    0x10(%ebp),%eax
  800a56:	83 c0 04             	add    $0x4,%eax
  800a59:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800a5f:	ff 75 f4             	pushl  -0xc(%ebp)
  800a62:	50                   	push   %eax
  800a63:	ff 75 0c             	pushl  0xc(%ebp)
  800a66:	ff 75 08             	pushl  0x8(%ebp)
  800a69:	e8 16 fc ff ff       	call   800684 <vprintfmt>
  800a6e:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a71:	90                   	nop
  800a72:	c9                   	leave  
  800a73:	c3                   	ret    

00800a74 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a74:	55                   	push   %ebp
  800a75:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7a:	8b 40 08             	mov    0x8(%eax),%eax
  800a7d:	8d 50 01             	lea    0x1(%eax),%edx
  800a80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a83:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a89:	8b 10                	mov    (%eax),%edx
  800a8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8e:	8b 40 04             	mov    0x4(%eax),%eax
  800a91:	39 c2                	cmp    %eax,%edx
  800a93:	73 12                	jae    800aa7 <sprintputch+0x33>
		*b->buf++ = ch;
  800a95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a98:	8b 00                	mov    (%eax),%eax
  800a9a:	8d 48 01             	lea    0x1(%eax),%ecx
  800a9d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aa0:	89 0a                	mov    %ecx,(%edx)
  800aa2:	8b 55 08             	mov    0x8(%ebp),%edx
  800aa5:	88 10                	mov    %dl,(%eax)
}
  800aa7:	90                   	nop
  800aa8:	5d                   	pop    %ebp
  800aa9:	c3                   	ret    

00800aaa <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800aaa:	55                   	push   %ebp
  800aab:	89 e5                	mov    %esp,%ebp
  800aad:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ab6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800abc:	8b 45 08             	mov    0x8(%ebp),%eax
  800abf:	01 d0                	add    %edx,%eax
  800ac1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800acb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800acf:	74 06                	je     800ad7 <vsnprintf+0x2d>
  800ad1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ad5:	7f 07                	jg     800ade <vsnprintf+0x34>
		return -E_INVAL;
  800ad7:	b8 03 00 00 00       	mov    $0x3,%eax
  800adc:	eb 20                	jmp    800afe <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ade:	ff 75 14             	pushl  0x14(%ebp)
  800ae1:	ff 75 10             	pushl  0x10(%ebp)
  800ae4:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ae7:	50                   	push   %eax
  800ae8:	68 74 0a 80 00       	push   $0x800a74
  800aed:	e8 92 fb ff ff       	call   800684 <vprintfmt>
  800af2:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800af5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800af8:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800afe:	c9                   	leave  
  800aff:	c3                   	ret    

00800b00 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b00:	55                   	push   %ebp
  800b01:	89 e5                	mov    %esp,%ebp
  800b03:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b06:	8d 45 10             	lea    0x10(%ebp),%eax
  800b09:	83 c0 04             	add    $0x4,%eax
  800b0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b12:	ff 75 f4             	pushl  -0xc(%ebp)
  800b15:	50                   	push   %eax
  800b16:	ff 75 0c             	pushl  0xc(%ebp)
  800b19:	ff 75 08             	pushl  0x8(%ebp)
  800b1c:	e8 89 ff ff ff       	call   800aaa <vsnprintf>
  800b21:	83 c4 10             	add    $0x10,%esp
  800b24:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b27:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b2a:	c9                   	leave  
  800b2b:	c3                   	ret    

00800b2c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b2c:	55                   	push   %ebp
  800b2d:	89 e5                	mov    %esp,%ebp
  800b2f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b32:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b39:	eb 06                	jmp    800b41 <strlen+0x15>
		n++;
  800b3b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b3e:	ff 45 08             	incl   0x8(%ebp)
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	8a 00                	mov    (%eax),%al
  800b46:	84 c0                	test   %al,%al
  800b48:	75 f1                	jne    800b3b <strlen+0xf>
		n++;
	return n;
  800b4a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b4d:	c9                   	leave  
  800b4e:	c3                   	ret    

00800b4f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b4f:	55                   	push   %ebp
  800b50:	89 e5                	mov    %esp,%ebp
  800b52:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b55:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b5c:	eb 09                	jmp    800b67 <strnlen+0x18>
		n++;
  800b5e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b61:	ff 45 08             	incl   0x8(%ebp)
  800b64:	ff 4d 0c             	decl   0xc(%ebp)
  800b67:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b6b:	74 09                	je     800b76 <strnlen+0x27>
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	8a 00                	mov    (%eax),%al
  800b72:	84 c0                	test   %al,%al
  800b74:	75 e8                	jne    800b5e <strnlen+0xf>
		n++;
	return n;
  800b76:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b79:	c9                   	leave  
  800b7a:	c3                   	ret    

00800b7b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b7b:	55                   	push   %ebp
  800b7c:	89 e5                	mov    %esp,%ebp
  800b7e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b87:	90                   	nop
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	8d 50 01             	lea    0x1(%eax),%edx
  800b8e:	89 55 08             	mov    %edx,0x8(%ebp)
  800b91:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b94:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b97:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b9a:	8a 12                	mov    (%edx),%dl
  800b9c:	88 10                	mov    %dl,(%eax)
  800b9e:	8a 00                	mov    (%eax),%al
  800ba0:	84 c0                	test   %al,%al
  800ba2:	75 e4                	jne    800b88 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ba4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba7:	c9                   	leave  
  800ba8:	c3                   	ret    

00800ba9 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ba9:	55                   	push   %ebp
  800baa:	89 e5                	mov    %esp,%ebp
  800bac:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800baf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bb5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bbc:	eb 1f                	jmp    800bdd <strncpy+0x34>
		*dst++ = *src;
  800bbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc1:	8d 50 01             	lea    0x1(%eax),%edx
  800bc4:	89 55 08             	mov    %edx,0x8(%ebp)
  800bc7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bca:	8a 12                	mov    (%edx),%dl
  800bcc:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd1:	8a 00                	mov    (%eax),%al
  800bd3:	84 c0                	test   %al,%al
  800bd5:	74 03                	je     800bda <strncpy+0x31>
			src++;
  800bd7:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bda:	ff 45 fc             	incl   -0x4(%ebp)
  800bdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800be0:	3b 45 10             	cmp    0x10(%ebp),%eax
  800be3:	72 d9                	jb     800bbe <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800be5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800be8:	c9                   	leave  
  800be9:	c3                   	ret    

00800bea <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800bea:	55                   	push   %ebp
  800beb:	89 e5                	mov    %esp,%ebp
  800bed:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800bf6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bfa:	74 30                	je     800c2c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bfc:	eb 16                	jmp    800c14 <strlcpy+0x2a>
			*dst++ = *src++;
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	8d 50 01             	lea    0x1(%eax),%edx
  800c04:	89 55 08             	mov    %edx,0x8(%ebp)
  800c07:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c0a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c0d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c10:	8a 12                	mov    (%edx),%dl
  800c12:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c14:	ff 4d 10             	decl   0x10(%ebp)
  800c17:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c1b:	74 09                	je     800c26 <strlcpy+0x3c>
  800c1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c20:	8a 00                	mov    (%eax),%al
  800c22:	84 c0                	test   %al,%al
  800c24:	75 d8                	jne    800bfe <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c26:	8b 45 08             	mov    0x8(%ebp),%eax
  800c29:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c2c:	8b 55 08             	mov    0x8(%ebp),%edx
  800c2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c32:	29 c2                	sub    %eax,%edx
  800c34:	89 d0                	mov    %edx,%eax
}
  800c36:	c9                   	leave  
  800c37:	c3                   	ret    

00800c38 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c38:	55                   	push   %ebp
  800c39:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c3b:	eb 06                	jmp    800c43 <strcmp+0xb>
		p++, q++;
  800c3d:	ff 45 08             	incl   0x8(%ebp)
  800c40:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c43:	8b 45 08             	mov    0x8(%ebp),%eax
  800c46:	8a 00                	mov    (%eax),%al
  800c48:	84 c0                	test   %al,%al
  800c4a:	74 0e                	je     800c5a <strcmp+0x22>
  800c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4f:	8a 10                	mov    (%eax),%dl
  800c51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c54:	8a 00                	mov    (%eax),%al
  800c56:	38 c2                	cmp    %al,%dl
  800c58:	74 e3                	je     800c3d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	8a 00                	mov    (%eax),%al
  800c5f:	0f b6 d0             	movzbl %al,%edx
  800c62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c65:	8a 00                	mov    (%eax),%al
  800c67:	0f b6 c0             	movzbl %al,%eax
  800c6a:	29 c2                	sub    %eax,%edx
  800c6c:	89 d0                	mov    %edx,%eax
}
  800c6e:	5d                   	pop    %ebp
  800c6f:	c3                   	ret    

00800c70 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c70:	55                   	push   %ebp
  800c71:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c73:	eb 09                	jmp    800c7e <strncmp+0xe>
		n--, p++, q++;
  800c75:	ff 4d 10             	decl   0x10(%ebp)
  800c78:	ff 45 08             	incl   0x8(%ebp)
  800c7b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c7e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c82:	74 17                	je     800c9b <strncmp+0x2b>
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	8a 00                	mov    (%eax),%al
  800c89:	84 c0                	test   %al,%al
  800c8b:	74 0e                	je     800c9b <strncmp+0x2b>
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	8a 10                	mov    (%eax),%dl
  800c92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c95:	8a 00                	mov    (%eax),%al
  800c97:	38 c2                	cmp    %al,%dl
  800c99:	74 da                	je     800c75 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c9b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9f:	75 07                	jne    800ca8 <strncmp+0x38>
		return 0;
  800ca1:	b8 00 00 00 00       	mov    $0x0,%eax
  800ca6:	eb 14                	jmp    800cbc <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	8a 00                	mov    (%eax),%al
  800cad:	0f b6 d0             	movzbl %al,%edx
  800cb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb3:	8a 00                	mov    (%eax),%al
  800cb5:	0f b6 c0             	movzbl %al,%eax
  800cb8:	29 c2                	sub    %eax,%edx
  800cba:	89 d0                	mov    %edx,%eax
}
  800cbc:	5d                   	pop    %ebp
  800cbd:	c3                   	ret    

00800cbe <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cbe:	55                   	push   %ebp
  800cbf:	89 e5                	mov    %esp,%ebp
  800cc1:	83 ec 04             	sub    $0x4,%esp
  800cc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cca:	eb 12                	jmp    800cde <strchr+0x20>
		if (*s == c)
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	8a 00                	mov    (%eax),%al
  800cd1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cd4:	75 05                	jne    800cdb <strchr+0x1d>
			return (char *) s;
  800cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd9:	eb 11                	jmp    800cec <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cdb:	ff 45 08             	incl   0x8(%ebp)
  800cde:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce1:	8a 00                	mov    (%eax),%al
  800ce3:	84 c0                	test   %al,%al
  800ce5:	75 e5                	jne    800ccc <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ce7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cec:	c9                   	leave  
  800ced:	c3                   	ret    

00800cee <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800cee:	55                   	push   %ebp
  800cef:	89 e5                	mov    %esp,%ebp
  800cf1:	83 ec 04             	sub    $0x4,%esp
  800cf4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cfa:	eb 0d                	jmp    800d09 <strfind+0x1b>
		if (*s == c)
  800cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cff:	8a 00                	mov    (%eax),%al
  800d01:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d04:	74 0e                	je     800d14 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d06:	ff 45 08             	incl   0x8(%ebp)
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	8a 00                	mov    (%eax),%al
  800d0e:	84 c0                	test   %al,%al
  800d10:	75 ea                	jne    800cfc <strfind+0xe>
  800d12:	eb 01                	jmp    800d15 <strfind+0x27>
		if (*s == c)
			break;
  800d14:	90                   	nop
	return (char *) s;
  800d15:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d18:	c9                   	leave  
  800d19:	c3                   	ret    

00800d1a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d1a:	55                   	push   %ebp
  800d1b:	89 e5                	mov    %esp,%ebp
  800d1d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d26:	8b 45 10             	mov    0x10(%ebp),%eax
  800d29:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d2c:	eb 0e                	jmp    800d3c <memset+0x22>
		*p++ = c;
  800d2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d31:	8d 50 01             	lea    0x1(%eax),%edx
  800d34:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d37:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d3a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d3c:	ff 4d f8             	decl   -0x8(%ebp)
  800d3f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d43:	79 e9                	jns    800d2e <memset+0x14>
		*p++ = c;

	return v;
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d48:	c9                   	leave  
  800d49:	c3                   	ret    

00800d4a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d4a:	55                   	push   %ebp
  800d4b:	89 e5                	mov    %esp,%ebp
  800d4d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d56:	8b 45 08             	mov    0x8(%ebp),%eax
  800d59:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d5c:	eb 16                	jmp    800d74 <memcpy+0x2a>
		*d++ = *s++;
  800d5e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d61:	8d 50 01             	lea    0x1(%eax),%edx
  800d64:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d67:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d6a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d6d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d70:	8a 12                	mov    (%edx),%dl
  800d72:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d74:	8b 45 10             	mov    0x10(%ebp),%eax
  800d77:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d7a:	89 55 10             	mov    %edx,0x10(%ebp)
  800d7d:	85 c0                	test   %eax,%eax
  800d7f:	75 dd                	jne    800d5e <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d84:	c9                   	leave  
  800d85:	c3                   	ret    

00800d86 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d86:	55                   	push   %ebp
  800d87:	89 e5                	mov    %esp,%ebp
  800d89:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d92:	8b 45 08             	mov    0x8(%ebp),%eax
  800d95:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d98:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d9b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d9e:	73 50                	jae    800df0 <memmove+0x6a>
  800da0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800da3:	8b 45 10             	mov    0x10(%ebp),%eax
  800da6:	01 d0                	add    %edx,%eax
  800da8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dab:	76 43                	jbe    800df0 <memmove+0x6a>
		s += n;
  800dad:	8b 45 10             	mov    0x10(%ebp),%eax
  800db0:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800db3:	8b 45 10             	mov    0x10(%ebp),%eax
  800db6:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800db9:	eb 10                	jmp    800dcb <memmove+0x45>
			*--d = *--s;
  800dbb:	ff 4d f8             	decl   -0x8(%ebp)
  800dbe:	ff 4d fc             	decl   -0x4(%ebp)
  800dc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc4:	8a 10                	mov    (%eax),%dl
  800dc6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc9:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dcb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dce:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dd1:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd4:	85 c0                	test   %eax,%eax
  800dd6:	75 e3                	jne    800dbb <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800dd8:	eb 23                	jmp    800dfd <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800dda:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ddd:	8d 50 01             	lea    0x1(%eax),%edx
  800de0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800de3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800de6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800de9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dec:	8a 12                	mov    (%edx),%dl
  800dee:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800df0:	8b 45 10             	mov    0x10(%ebp),%eax
  800df3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df6:	89 55 10             	mov    %edx,0x10(%ebp)
  800df9:	85 c0                	test   %eax,%eax
  800dfb:	75 dd                	jne    800dda <memmove+0x54>
			*d++ = *s++;

	return dst;
  800dfd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e00:	c9                   	leave  
  800e01:	c3                   	ret    

00800e02 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e02:	55                   	push   %ebp
  800e03:	89 e5                	mov    %esp,%ebp
  800e05:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e11:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e14:	eb 2a                	jmp    800e40 <memcmp+0x3e>
		if (*s1 != *s2)
  800e16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e19:	8a 10                	mov    (%eax),%dl
  800e1b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1e:	8a 00                	mov    (%eax),%al
  800e20:	38 c2                	cmp    %al,%dl
  800e22:	74 16                	je     800e3a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e27:	8a 00                	mov    (%eax),%al
  800e29:	0f b6 d0             	movzbl %al,%edx
  800e2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2f:	8a 00                	mov    (%eax),%al
  800e31:	0f b6 c0             	movzbl %al,%eax
  800e34:	29 c2                	sub    %eax,%edx
  800e36:	89 d0                	mov    %edx,%eax
  800e38:	eb 18                	jmp    800e52 <memcmp+0x50>
		s1++, s2++;
  800e3a:	ff 45 fc             	incl   -0x4(%ebp)
  800e3d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e40:	8b 45 10             	mov    0x10(%ebp),%eax
  800e43:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e46:	89 55 10             	mov    %edx,0x10(%ebp)
  800e49:	85 c0                	test   %eax,%eax
  800e4b:	75 c9                	jne    800e16 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e4d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e52:	c9                   	leave  
  800e53:	c3                   	ret    

00800e54 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e54:	55                   	push   %ebp
  800e55:	89 e5                	mov    %esp,%ebp
  800e57:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e5a:	8b 55 08             	mov    0x8(%ebp),%edx
  800e5d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e60:	01 d0                	add    %edx,%eax
  800e62:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e65:	eb 15                	jmp    800e7c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e67:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6a:	8a 00                	mov    (%eax),%al
  800e6c:	0f b6 d0             	movzbl %al,%edx
  800e6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e72:	0f b6 c0             	movzbl %al,%eax
  800e75:	39 c2                	cmp    %eax,%edx
  800e77:	74 0d                	je     800e86 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e79:	ff 45 08             	incl   0x8(%ebp)
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e82:	72 e3                	jb     800e67 <memfind+0x13>
  800e84:	eb 01                	jmp    800e87 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e86:	90                   	nop
	return (void *) s;
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e8a:	c9                   	leave  
  800e8b:	c3                   	ret    

00800e8c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e8c:	55                   	push   %ebp
  800e8d:	89 e5                	mov    %esp,%ebp
  800e8f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e92:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e99:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ea0:	eb 03                	jmp    800ea5 <strtol+0x19>
		s++;
  800ea2:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	8a 00                	mov    (%eax),%al
  800eaa:	3c 20                	cmp    $0x20,%al
  800eac:	74 f4                	je     800ea2 <strtol+0x16>
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	8a 00                	mov    (%eax),%al
  800eb3:	3c 09                	cmp    $0x9,%al
  800eb5:	74 eb                	je     800ea2 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eba:	8a 00                	mov    (%eax),%al
  800ebc:	3c 2b                	cmp    $0x2b,%al
  800ebe:	75 05                	jne    800ec5 <strtol+0x39>
		s++;
  800ec0:	ff 45 08             	incl   0x8(%ebp)
  800ec3:	eb 13                	jmp    800ed8 <strtol+0x4c>
	else if (*s == '-')
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	8a 00                	mov    (%eax),%al
  800eca:	3c 2d                	cmp    $0x2d,%al
  800ecc:	75 0a                	jne    800ed8 <strtol+0x4c>
		s++, neg = 1;
  800ece:	ff 45 08             	incl   0x8(%ebp)
  800ed1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ed8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800edc:	74 06                	je     800ee4 <strtol+0x58>
  800ede:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ee2:	75 20                	jne    800f04 <strtol+0x78>
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	8a 00                	mov    (%eax),%al
  800ee9:	3c 30                	cmp    $0x30,%al
  800eeb:	75 17                	jne    800f04 <strtol+0x78>
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	40                   	inc    %eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	3c 78                	cmp    $0x78,%al
  800ef5:	75 0d                	jne    800f04 <strtol+0x78>
		s += 2, base = 16;
  800ef7:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800efb:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f02:	eb 28                	jmp    800f2c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f04:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f08:	75 15                	jne    800f1f <strtol+0x93>
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	3c 30                	cmp    $0x30,%al
  800f11:	75 0c                	jne    800f1f <strtol+0x93>
		s++, base = 8;
  800f13:	ff 45 08             	incl   0x8(%ebp)
  800f16:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f1d:	eb 0d                	jmp    800f2c <strtol+0xa0>
	else if (base == 0)
  800f1f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f23:	75 07                	jne    800f2c <strtol+0xa0>
		base = 10;
  800f25:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	3c 2f                	cmp    $0x2f,%al
  800f33:	7e 19                	jle    800f4e <strtol+0xc2>
  800f35:	8b 45 08             	mov    0x8(%ebp),%eax
  800f38:	8a 00                	mov    (%eax),%al
  800f3a:	3c 39                	cmp    $0x39,%al
  800f3c:	7f 10                	jg     800f4e <strtol+0xc2>
			dig = *s - '0';
  800f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f41:	8a 00                	mov    (%eax),%al
  800f43:	0f be c0             	movsbl %al,%eax
  800f46:	83 e8 30             	sub    $0x30,%eax
  800f49:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f4c:	eb 42                	jmp    800f90 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	8a 00                	mov    (%eax),%al
  800f53:	3c 60                	cmp    $0x60,%al
  800f55:	7e 19                	jle    800f70 <strtol+0xe4>
  800f57:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5a:	8a 00                	mov    (%eax),%al
  800f5c:	3c 7a                	cmp    $0x7a,%al
  800f5e:	7f 10                	jg     800f70 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	0f be c0             	movsbl %al,%eax
  800f68:	83 e8 57             	sub    $0x57,%eax
  800f6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f6e:	eb 20                	jmp    800f90 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	8a 00                	mov    (%eax),%al
  800f75:	3c 40                	cmp    $0x40,%al
  800f77:	7e 39                	jle    800fb2 <strtol+0x126>
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	3c 5a                	cmp    $0x5a,%al
  800f80:	7f 30                	jg     800fb2 <strtol+0x126>
			dig = *s - 'A' + 10;
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	0f be c0             	movsbl %al,%eax
  800f8a:	83 e8 37             	sub    $0x37,%eax
  800f8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f90:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f93:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f96:	7d 19                	jge    800fb1 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f98:	ff 45 08             	incl   0x8(%ebp)
  800f9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f9e:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fa2:	89 c2                	mov    %eax,%edx
  800fa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fa7:	01 d0                	add    %edx,%eax
  800fa9:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fac:	e9 7b ff ff ff       	jmp    800f2c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fb1:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fb2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fb6:	74 08                	je     800fc0 <strtol+0x134>
		*endptr = (char *) s;
  800fb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbb:	8b 55 08             	mov    0x8(%ebp),%edx
  800fbe:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fc0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fc4:	74 07                	je     800fcd <strtol+0x141>
  800fc6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc9:	f7 d8                	neg    %eax
  800fcb:	eb 03                	jmp    800fd0 <strtol+0x144>
  800fcd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fd0:	c9                   	leave  
  800fd1:	c3                   	ret    

00800fd2 <ltostr>:

void
ltostr(long value, char *str)
{
  800fd2:	55                   	push   %ebp
  800fd3:	89 e5                	mov    %esp,%ebp
  800fd5:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fd8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fdf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800fe6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fea:	79 13                	jns    800fff <ltostr+0x2d>
	{
		neg = 1;
  800fec:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ff3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff6:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800ff9:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800ffc:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800fff:	8b 45 08             	mov    0x8(%ebp),%eax
  801002:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801007:	99                   	cltd   
  801008:	f7 f9                	idiv   %ecx
  80100a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80100d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801010:	8d 50 01             	lea    0x1(%eax),%edx
  801013:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801016:	89 c2                	mov    %eax,%edx
  801018:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101b:	01 d0                	add    %edx,%eax
  80101d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801020:	83 c2 30             	add    $0x30,%edx
  801023:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801025:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801028:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80102d:	f7 e9                	imul   %ecx
  80102f:	c1 fa 02             	sar    $0x2,%edx
  801032:	89 c8                	mov    %ecx,%eax
  801034:	c1 f8 1f             	sar    $0x1f,%eax
  801037:	29 c2                	sub    %eax,%edx
  801039:	89 d0                	mov    %edx,%eax
  80103b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80103e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801041:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801046:	f7 e9                	imul   %ecx
  801048:	c1 fa 02             	sar    $0x2,%edx
  80104b:	89 c8                	mov    %ecx,%eax
  80104d:	c1 f8 1f             	sar    $0x1f,%eax
  801050:	29 c2                	sub    %eax,%edx
  801052:	89 d0                	mov    %edx,%eax
  801054:	c1 e0 02             	shl    $0x2,%eax
  801057:	01 d0                	add    %edx,%eax
  801059:	01 c0                	add    %eax,%eax
  80105b:	29 c1                	sub    %eax,%ecx
  80105d:	89 ca                	mov    %ecx,%edx
  80105f:	85 d2                	test   %edx,%edx
  801061:	75 9c                	jne    800fff <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801063:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80106a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106d:	48                   	dec    %eax
  80106e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801071:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801075:	74 3d                	je     8010b4 <ltostr+0xe2>
		start = 1 ;
  801077:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80107e:	eb 34                	jmp    8010b4 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801080:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801083:	8b 45 0c             	mov    0xc(%ebp),%eax
  801086:	01 d0                	add    %edx,%eax
  801088:	8a 00                	mov    (%eax),%al
  80108a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80108d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801090:	8b 45 0c             	mov    0xc(%ebp),%eax
  801093:	01 c2                	add    %eax,%edx
  801095:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801098:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109b:	01 c8                	add    %ecx,%eax
  80109d:	8a 00                	mov    (%eax),%al
  80109f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010a1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a7:	01 c2                	add    %eax,%edx
  8010a9:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010ac:	88 02                	mov    %al,(%edx)
		start++ ;
  8010ae:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010b1:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010b7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010ba:	7c c4                	jl     801080 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010bc:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c2:	01 d0                	add    %edx,%eax
  8010c4:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010c7:	90                   	nop
  8010c8:	c9                   	leave  
  8010c9:	c3                   	ret    

008010ca <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010ca:	55                   	push   %ebp
  8010cb:	89 e5                	mov    %esp,%ebp
  8010cd:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010d0:	ff 75 08             	pushl  0x8(%ebp)
  8010d3:	e8 54 fa ff ff       	call   800b2c <strlen>
  8010d8:	83 c4 04             	add    $0x4,%esp
  8010db:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010de:	ff 75 0c             	pushl  0xc(%ebp)
  8010e1:	e8 46 fa ff ff       	call   800b2c <strlen>
  8010e6:	83 c4 04             	add    $0x4,%esp
  8010e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010fa:	eb 17                	jmp    801113 <strcconcat+0x49>
		final[s] = str1[s] ;
  8010fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801102:	01 c2                	add    %eax,%edx
  801104:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801107:	8b 45 08             	mov    0x8(%ebp),%eax
  80110a:	01 c8                	add    %ecx,%eax
  80110c:	8a 00                	mov    (%eax),%al
  80110e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801110:	ff 45 fc             	incl   -0x4(%ebp)
  801113:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801116:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801119:	7c e1                	jl     8010fc <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80111b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801122:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801129:	eb 1f                	jmp    80114a <strcconcat+0x80>
		final[s++] = str2[i] ;
  80112b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80112e:	8d 50 01             	lea    0x1(%eax),%edx
  801131:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801134:	89 c2                	mov    %eax,%edx
  801136:	8b 45 10             	mov    0x10(%ebp),%eax
  801139:	01 c2                	add    %eax,%edx
  80113b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80113e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801141:	01 c8                	add    %ecx,%eax
  801143:	8a 00                	mov    (%eax),%al
  801145:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801147:	ff 45 f8             	incl   -0x8(%ebp)
  80114a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80114d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801150:	7c d9                	jl     80112b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801152:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801155:	8b 45 10             	mov    0x10(%ebp),%eax
  801158:	01 d0                	add    %edx,%eax
  80115a:	c6 00 00             	movb   $0x0,(%eax)
}
  80115d:	90                   	nop
  80115e:	c9                   	leave  
  80115f:	c3                   	ret    

00801160 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801160:	55                   	push   %ebp
  801161:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801163:	8b 45 14             	mov    0x14(%ebp),%eax
  801166:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80116c:	8b 45 14             	mov    0x14(%ebp),%eax
  80116f:	8b 00                	mov    (%eax),%eax
  801171:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801178:	8b 45 10             	mov    0x10(%ebp),%eax
  80117b:	01 d0                	add    %edx,%eax
  80117d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801183:	eb 0c                	jmp    801191 <strsplit+0x31>
			*string++ = 0;
  801185:	8b 45 08             	mov    0x8(%ebp),%eax
  801188:	8d 50 01             	lea    0x1(%eax),%edx
  80118b:	89 55 08             	mov    %edx,0x8(%ebp)
  80118e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801191:	8b 45 08             	mov    0x8(%ebp),%eax
  801194:	8a 00                	mov    (%eax),%al
  801196:	84 c0                	test   %al,%al
  801198:	74 18                	je     8011b2 <strsplit+0x52>
  80119a:	8b 45 08             	mov    0x8(%ebp),%eax
  80119d:	8a 00                	mov    (%eax),%al
  80119f:	0f be c0             	movsbl %al,%eax
  8011a2:	50                   	push   %eax
  8011a3:	ff 75 0c             	pushl  0xc(%ebp)
  8011a6:	e8 13 fb ff ff       	call   800cbe <strchr>
  8011ab:	83 c4 08             	add    $0x8,%esp
  8011ae:	85 c0                	test   %eax,%eax
  8011b0:	75 d3                	jne    801185 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b5:	8a 00                	mov    (%eax),%al
  8011b7:	84 c0                	test   %al,%al
  8011b9:	74 5a                	je     801215 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8011be:	8b 00                	mov    (%eax),%eax
  8011c0:	83 f8 0f             	cmp    $0xf,%eax
  8011c3:	75 07                	jne    8011cc <strsplit+0x6c>
		{
			return 0;
  8011c5:	b8 00 00 00 00       	mov    $0x0,%eax
  8011ca:	eb 66                	jmp    801232 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cf:	8b 00                	mov    (%eax),%eax
  8011d1:	8d 48 01             	lea    0x1(%eax),%ecx
  8011d4:	8b 55 14             	mov    0x14(%ebp),%edx
  8011d7:	89 0a                	mov    %ecx,(%edx)
  8011d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e3:	01 c2                	add    %eax,%edx
  8011e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e8:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011ea:	eb 03                	jmp    8011ef <strsplit+0x8f>
			string++;
  8011ec:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	8a 00                	mov    (%eax),%al
  8011f4:	84 c0                	test   %al,%al
  8011f6:	74 8b                	je     801183 <strsplit+0x23>
  8011f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fb:	8a 00                	mov    (%eax),%al
  8011fd:	0f be c0             	movsbl %al,%eax
  801200:	50                   	push   %eax
  801201:	ff 75 0c             	pushl  0xc(%ebp)
  801204:	e8 b5 fa ff ff       	call   800cbe <strchr>
  801209:	83 c4 08             	add    $0x8,%esp
  80120c:	85 c0                	test   %eax,%eax
  80120e:	74 dc                	je     8011ec <strsplit+0x8c>
			string++;
	}
  801210:	e9 6e ff ff ff       	jmp    801183 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801215:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801216:	8b 45 14             	mov    0x14(%ebp),%eax
  801219:	8b 00                	mov    (%eax),%eax
  80121b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801222:	8b 45 10             	mov    0x10(%ebp),%eax
  801225:	01 d0                	add    %edx,%eax
  801227:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80122d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801232:	c9                   	leave  
  801233:	c3                   	ret    

00801234 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801234:	55                   	push   %ebp
  801235:	89 e5                	mov    %esp,%ebp
  801237:	57                   	push   %edi
  801238:	56                   	push   %esi
  801239:	53                   	push   %ebx
  80123a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	8b 55 0c             	mov    0xc(%ebp),%edx
  801243:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801246:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801249:	8b 7d 18             	mov    0x18(%ebp),%edi
  80124c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80124f:	cd 30                	int    $0x30
  801251:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801254:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801257:	83 c4 10             	add    $0x10,%esp
  80125a:	5b                   	pop    %ebx
  80125b:	5e                   	pop    %esi
  80125c:	5f                   	pop    %edi
  80125d:	5d                   	pop    %ebp
  80125e:	c3                   	ret    

0080125f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80125f:	55                   	push   %ebp
  801260:	89 e5                	mov    %esp,%ebp
  801262:	83 ec 04             	sub    $0x4,%esp
  801265:	8b 45 10             	mov    0x10(%ebp),%eax
  801268:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80126b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80126f:	8b 45 08             	mov    0x8(%ebp),%eax
  801272:	6a 00                	push   $0x0
  801274:	6a 00                	push   $0x0
  801276:	52                   	push   %edx
  801277:	ff 75 0c             	pushl  0xc(%ebp)
  80127a:	50                   	push   %eax
  80127b:	6a 00                	push   $0x0
  80127d:	e8 b2 ff ff ff       	call   801234 <syscall>
  801282:	83 c4 18             	add    $0x18,%esp
}
  801285:	90                   	nop
  801286:	c9                   	leave  
  801287:	c3                   	ret    

00801288 <sys_cgetc>:

int
sys_cgetc(void)
{
  801288:	55                   	push   %ebp
  801289:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	6a 00                	push   $0x0
  801295:	6a 01                	push   $0x1
  801297:	e8 98 ff ff ff       	call   801234 <syscall>
  80129c:	83 c4 18             	add    $0x18,%esp
}
  80129f:	c9                   	leave  
  8012a0:	c3                   	ret    

008012a1 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012a1:	55                   	push   %ebp
  8012a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 00                	push   $0x0
  8012af:	50                   	push   %eax
  8012b0:	6a 05                	push   $0x5
  8012b2:	e8 7d ff ff ff       	call   801234 <syscall>
  8012b7:	83 c4 18             	add    $0x18,%esp
}
  8012ba:	c9                   	leave  
  8012bb:	c3                   	ret    

008012bc <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012bc:	55                   	push   %ebp
  8012bd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 00                	push   $0x0
  8012c9:	6a 02                	push   $0x2
  8012cb:	e8 64 ff ff ff       	call   801234 <syscall>
  8012d0:	83 c4 18             	add    $0x18,%esp
}
  8012d3:	c9                   	leave  
  8012d4:	c3                   	ret    

008012d5 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012d5:	55                   	push   %ebp
  8012d6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 00                	push   $0x0
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 00                	push   $0x0
  8012e2:	6a 03                	push   $0x3
  8012e4:	e8 4b ff ff ff       	call   801234 <syscall>
  8012e9:	83 c4 18             	add    $0x18,%esp
}
  8012ec:	c9                   	leave  
  8012ed:	c3                   	ret    

008012ee <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8012ee:	55                   	push   %ebp
  8012ef:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 00                	push   $0x0
  8012f7:	6a 00                	push   $0x0
  8012f9:	6a 00                	push   $0x0
  8012fb:	6a 04                	push   $0x4
  8012fd:	e8 32 ff ff ff       	call   801234 <syscall>
  801302:	83 c4 18             	add    $0x18,%esp
}
  801305:	c9                   	leave  
  801306:	c3                   	ret    

00801307 <sys_env_exit>:


void sys_env_exit(void)
{
  801307:	55                   	push   %ebp
  801308:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	6a 00                	push   $0x0
  801314:	6a 06                	push   $0x6
  801316:	e8 19 ff ff ff       	call   801234 <syscall>
  80131b:	83 c4 18             	add    $0x18,%esp
}
  80131e:	90                   	nop
  80131f:	c9                   	leave  
  801320:	c3                   	ret    

00801321 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801321:	55                   	push   %ebp
  801322:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801324:	8b 55 0c             	mov    0xc(%ebp),%edx
  801327:	8b 45 08             	mov    0x8(%ebp),%eax
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	52                   	push   %edx
  801331:	50                   	push   %eax
  801332:	6a 07                	push   $0x7
  801334:	e8 fb fe ff ff       	call   801234 <syscall>
  801339:	83 c4 18             	add    $0x18,%esp
}
  80133c:	c9                   	leave  
  80133d:	c3                   	ret    

0080133e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80133e:	55                   	push   %ebp
  80133f:	89 e5                	mov    %esp,%ebp
  801341:	56                   	push   %esi
  801342:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801343:	8b 75 18             	mov    0x18(%ebp),%esi
  801346:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801349:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80134c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	56                   	push   %esi
  801353:	53                   	push   %ebx
  801354:	51                   	push   %ecx
  801355:	52                   	push   %edx
  801356:	50                   	push   %eax
  801357:	6a 08                	push   $0x8
  801359:	e8 d6 fe ff ff       	call   801234 <syscall>
  80135e:	83 c4 18             	add    $0x18,%esp
}
  801361:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801364:	5b                   	pop    %ebx
  801365:	5e                   	pop    %esi
  801366:	5d                   	pop    %ebp
  801367:	c3                   	ret    

00801368 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801368:	55                   	push   %ebp
  801369:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80136b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136e:	8b 45 08             	mov    0x8(%ebp),%eax
  801371:	6a 00                	push   $0x0
  801373:	6a 00                	push   $0x0
  801375:	6a 00                	push   $0x0
  801377:	52                   	push   %edx
  801378:	50                   	push   %eax
  801379:	6a 09                	push   $0x9
  80137b:	e8 b4 fe ff ff       	call   801234 <syscall>
  801380:	83 c4 18             	add    $0x18,%esp
}
  801383:	c9                   	leave  
  801384:	c3                   	ret    

00801385 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801385:	55                   	push   %ebp
  801386:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	ff 75 0c             	pushl  0xc(%ebp)
  801391:	ff 75 08             	pushl  0x8(%ebp)
  801394:	6a 0a                	push   $0xa
  801396:	e8 99 fe ff ff       	call   801234 <syscall>
  80139b:	83 c4 18             	add    $0x18,%esp
}
  80139e:	c9                   	leave  
  80139f:	c3                   	ret    

008013a0 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013a0:	55                   	push   %ebp
  8013a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 00                	push   $0x0
  8013a7:	6a 00                	push   $0x0
  8013a9:	6a 00                	push   $0x0
  8013ab:	6a 00                	push   $0x0
  8013ad:	6a 0b                	push   $0xb
  8013af:	e8 80 fe ff ff       	call   801234 <syscall>
  8013b4:	83 c4 18             	add    $0x18,%esp
}
  8013b7:	c9                   	leave  
  8013b8:	c3                   	ret    

008013b9 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013b9:	55                   	push   %ebp
  8013ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	6a 00                	push   $0x0
  8013c6:	6a 0c                	push   $0xc
  8013c8:	e8 67 fe ff ff       	call   801234 <syscall>
  8013cd:	83 c4 18             	add    $0x18,%esp
}
  8013d0:	c9                   	leave  
  8013d1:	c3                   	ret    

008013d2 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013d2:	55                   	push   %ebp
  8013d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013d5:	6a 00                	push   $0x0
  8013d7:	6a 00                	push   $0x0
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 0d                	push   $0xd
  8013e1:	e8 4e fe ff ff       	call   801234 <syscall>
  8013e6:	83 c4 18             	add    $0x18,%esp
}
  8013e9:	c9                   	leave  
  8013ea:	c3                   	ret    

008013eb <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8013eb:	55                   	push   %ebp
  8013ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 00                	push   $0x0
  8013f4:	ff 75 0c             	pushl  0xc(%ebp)
  8013f7:	ff 75 08             	pushl  0x8(%ebp)
  8013fa:	6a 11                	push   $0x11
  8013fc:	e8 33 fe ff ff       	call   801234 <syscall>
  801401:	83 c4 18             	add    $0x18,%esp
	return;
  801404:	90                   	nop
}
  801405:	c9                   	leave  
  801406:	c3                   	ret    

00801407 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801407:	55                   	push   %ebp
  801408:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80140a:	6a 00                	push   $0x0
  80140c:	6a 00                	push   $0x0
  80140e:	6a 00                	push   $0x0
  801410:	ff 75 0c             	pushl  0xc(%ebp)
  801413:	ff 75 08             	pushl  0x8(%ebp)
  801416:	6a 12                	push   $0x12
  801418:	e8 17 fe ff ff       	call   801234 <syscall>
  80141d:	83 c4 18             	add    $0x18,%esp
	return ;
  801420:	90                   	nop
}
  801421:	c9                   	leave  
  801422:	c3                   	ret    

00801423 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801423:	55                   	push   %ebp
  801424:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801426:	6a 00                	push   $0x0
  801428:	6a 00                	push   $0x0
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	6a 0e                	push   $0xe
  801432:	e8 fd fd ff ff       	call   801234 <syscall>
  801437:	83 c4 18             	add    $0x18,%esp
}
  80143a:	c9                   	leave  
  80143b:	c3                   	ret    

0080143c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80143c:	55                   	push   %ebp
  80143d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	6a 00                	push   $0x0
  801447:	ff 75 08             	pushl  0x8(%ebp)
  80144a:	6a 0f                	push   $0xf
  80144c:	e8 e3 fd ff ff       	call   801234 <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	6a 10                	push   $0x10
  801465:	e8 ca fd ff ff       	call   801234 <syscall>
  80146a:	83 c4 18             	add    $0x18,%esp
}
  80146d:	90                   	nop
  80146e:	c9                   	leave  
  80146f:	c3                   	ret    

00801470 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801470:	55                   	push   %ebp
  801471:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 14                	push   $0x14
  80147f:	e8 b0 fd ff ff       	call   801234 <syscall>
  801484:	83 c4 18             	add    $0x18,%esp
}
  801487:	90                   	nop
  801488:	c9                   	leave  
  801489:	c3                   	ret    

0080148a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80148a:	55                   	push   %ebp
  80148b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 15                	push   $0x15
  801499:	e8 96 fd ff ff       	call   801234 <syscall>
  80149e:	83 c4 18             	add    $0x18,%esp
}
  8014a1:	90                   	nop
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
  8014a7:	83 ec 04             	sub    $0x4,%esp
  8014aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ad:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014b0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	50                   	push   %eax
  8014bd:	6a 16                	push   $0x16
  8014bf:	e8 70 fd ff ff       	call   801234 <syscall>
  8014c4:	83 c4 18             	add    $0x18,%esp
}
  8014c7:	90                   	nop
  8014c8:	c9                   	leave  
  8014c9:	c3                   	ret    

008014ca <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014ca:	55                   	push   %ebp
  8014cb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 17                	push   $0x17
  8014d9:	e8 56 fd ff ff       	call   801234 <syscall>
  8014de:	83 c4 18             	add    $0x18,%esp
}
  8014e1:	90                   	nop
  8014e2:	c9                   	leave  
  8014e3:	c3                   	ret    

008014e4 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014e4:	55                   	push   %ebp
  8014e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	ff 75 0c             	pushl  0xc(%ebp)
  8014f3:	50                   	push   %eax
  8014f4:	6a 18                	push   $0x18
  8014f6:	e8 39 fd ff ff       	call   801234 <syscall>
  8014fb:	83 c4 18             	add    $0x18,%esp
}
  8014fe:	c9                   	leave  
  8014ff:	c3                   	ret    

00801500 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801500:	55                   	push   %ebp
  801501:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801503:	8b 55 0c             	mov    0xc(%ebp),%edx
  801506:	8b 45 08             	mov    0x8(%ebp),%eax
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	52                   	push   %edx
  801510:	50                   	push   %eax
  801511:	6a 1b                	push   $0x1b
  801513:	e8 1c fd ff ff       	call   801234 <syscall>
  801518:	83 c4 18             	add    $0x18,%esp
}
  80151b:	c9                   	leave  
  80151c:	c3                   	ret    

0080151d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80151d:	55                   	push   %ebp
  80151e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801520:	8b 55 0c             	mov    0xc(%ebp),%edx
  801523:	8b 45 08             	mov    0x8(%ebp),%eax
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	52                   	push   %edx
  80152d:	50                   	push   %eax
  80152e:	6a 19                	push   $0x19
  801530:	e8 ff fc ff ff       	call   801234 <syscall>
  801535:	83 c4 18             	add    $0x18,%esp
}
  801538:	90                   	nop
  801539:	c9                   	leave  
  80153a:	c3                   	ret    

0080153b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80153b:	55                   	push   %ebp
  80153c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80153e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801541:	8b 45 08             	mov    0x8(%ebp),%eax
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	52                   	push   %edx
  80154b:	50                   	push   %eax
  80154c:	6a 1a                	push   $0x1a
  80154e:	e8 e1 fc ff ff       	call   801234 <syscall>
  801553:	83 c4 18             	add    $0x18,%esp
}
  801556:	90                   	nop
  801557:	c9                   	leave  
  801558:	c3                   	ret    

00801559 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801559:	55                   	push   %ebp
  80155a:	89 e5                	mov    %esp,%ebp
  80155c:	83 ec 04             	sub    $0x4,%esp
  80155f:	8b 45 10             	mov    0x10(%ebp),%eax
  801562:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801565:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801568:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80156c:	8b 45 08             	mov    0x8(%ebp),%eax
  80156f:	6a 00                	push   $0x0
  801571:	51                   	push   %ecx
  801572:	52                   	push   %edx
  801573:	ff 75 0c             	pushl  0xc(%ebp)
  801576:	50                   	push   %eax
  801577:	6a 1c                	push   $0x1c
  801579:	e8 b6 fc ff ff       	call   801234 <syscall>
  80157e:	83 c4 18             	add    $0x18,%esp
}
  801581:	c9                   	leave  
  801582:	c3                   	ret    

00801583 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801583:	55                   	push   %ebp
  801584:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801586:	8b 55 0c             	mov    0xc(%ebp),%edx
  801589:	8b 45 08             	mov    0x8(%ebp),%eax
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	52                   	push   %edx
  801593:	50                   	push   %eax
  801594:	6a 1d                	push   $0x1d
  801596:	e8 99 fc ff ff       	call   801234 <syscall>
  80159b:	83 c4 18             	add    $0x18,%esp
}
  80159e:	c9                   	leave  
  80159f:	c3                   	ret    

008015a0 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015a0:	55                   	push   %ebp
  8015a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015a3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	51                   	push   %ecx
  8015b1:	52                   	push   %edx
  8015b2:	50                   	push   %eax
  8015b3:	6a 1e                	push   $0x1e
  8015b5:	e8 7a fc ff ff       	call   801234 <syscall>
  8015ba:	83 c4 18             	add    $0x18,%esp
}
  8015bd:	c9                   	leave  
  8015be:	c3                   	ret    

008015bf <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015bf:	55                   	push   %ebp
  8015c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	52                   	push   %edx
  8015cf:	50                   	push   %eax
  8015d0:	6a 1f                	push   $0x1f
  8015d2:	e8 5d fc ff ff       	call   801234 <syscall>
  8015d7:	83 c4 18             	add    $0x18,%esp
}
  8015da:	c9                   	leave  
  8015db:	c3                   	ret    

008015dc <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015dc:	55                   	push   %ebp
  8015dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 20                	push   $0x20
  8015eb:	e8 44 fc ff ff       	call   801234 <syscall>
  8015f0:	83 c4 18             	add    $0x18,%esp
}
  8015f3:	c9                   	leave  
  8015f4:	c3                   	ret    

008015f5 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8015f5:	55                   	push   %ebp
  8015f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	6a 00                	push   $0x0
  8015fd:	ff 75 14             	pushl  0x14(%ebp)
  801600:	ff 75 10             	pushl  0x10(%ebp)
  801603:	ff 75 0c             	pushl  0xc(%ebp)
  801606:	50                   	push   %eax
  801607:	6a 21                	push   $0x21
  801609:	e8 26 fc ff ff       	call   801234 <syscall>
  80160e:	83 c4 18             	add    $0x18,%esp
}
  801611:	c9                   	leave  
  801612:	c3                   	ret    

00801613 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801613:	55                   	push   %ebp
  801614:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	6a 00                	push   $0x0
  801621:	50                   	push   %eax
  801622:	6a 22                	push   $0x22
  801624:	e8 0b fc ff ff       	call   801234 <syscall>
  801629:	83 c4 18             	add    $0x18,%esp
}
  80162c:	90                   	nop
  80162d:	c9                   	leave  
  80162e:	c3                   	ret    

0080162f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80162f:	55                   	push   %ebp
  801630:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	50                   	push   %eax
  80163e:	6a 23                	push   $0x23
  801640:	e8 ef fb ff ff       	call   801234 <syscall>
  801645:	83 c4 18             	add    $0x18,%esp
}
  801648:	90                   	nop
  801649:	c9                   	leave  
  80164a:	c3                   	ret    

0080164b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80164b:	55                   	push   %ebp
  80164c:	89 e5                	mov    %esp,%ebp
  80164e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801651:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801654:	8d 50 04             	lea    0x4(%eax),%edx
  801657:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	52                   	push   %edx
  801661:	50                   	push   %eax
  801662:	6a 24                	push   $0x24
  801664:	e8 cb fb ff ff       	call   801234 <syscall>
  801669:	83 c4 18             	add    $0x18,%esp
	return result;
  80166c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80166f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801672:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801675:	89 01                	mov    %eax,(%ecx)
  801677:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	c9                   	leave  
  80167e:	c2 04 00             	ret    $0x4

00801681 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801681:	55                   	push   %ebp
  801682:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	ff 75 10             	pushl  0x10(%ebp)
  80168b:	ff 75 0c             	pushl  0xc(%ebp)
  80168e:	ff 75 08             	pushl  0x8(%ebp)
  801691:	6a 13                	push   $0x13
  801693:	e8 9c fb ff ff       	call   801234 <syscall>
  801698:	83 c4 18             	add    $0x18,%esp
	return ;
  80169b:	90                   	nop
}
  80169c:	c9                   	leave  
  80169d:	c3                   	ret    

0080169e <sys_rcr2>:
uint32 sys_rcr2()
{
  80169e:	55                   	push   %ebp
  80169f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 25                	push   $0x25
  8016ad:	e8 82 fb ff ff       	call   801234 <syscall>
  8016b2:	83 c4 18             	add    $0x18,%esp
}
  8016b5:	c9                   	leave  
  8016b6:	c3                   	ret    

008016b7 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
  8016ba:	83 ec 04             	sub    $0x4,%esp
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016c3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	50                   	push   %eax
  8016d0:	6a 26                	push   $0x26
  8016d2:	e8 5d fb ff ff       	call   801234 <syscall>
  8016d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8016da:	90                   	nop
}
  8016db:	c9                   	leave  
  8016dc:	c3                   	ret    

008016dd <rsttst>:
void rsttst()
{
  8016dd:	55                   	push   %ebp
  8016de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 28                	push   $0x28
  8016ec:	e8 43 fb ff ff       	call   801234 <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f4:	90                   	nop
}
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
  8016fa:	83 ec 04             	sub    $0x4,%esp
  8016fd:	8b 45 14             	mov    0x14(%ebp),%eax
  801700:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801703:	8b 55 18             	mov    0x18(%ebp),%edx
  801706:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80170a:	52                   	push   %edx
  80170b:	50                   	push   %eax
  80170c:	ff 75 10             	pushl  0x10(%ebp)
  80170f:	ff 75 0c             	pushl  0xc(%ebp)
  801712:	ff 75 08             	pushl  0x8(%ebp)
  801715:	6a 27                	push   $0x27
  801717:	e8 18 fb ff ff       	call   801234 <syscall>
  80171c:	83 c4 18             	add    $0x18,%esp
	return ;
  80171f:	90                   	nop
}
  801720:	c9                   	leave  
  801721:	c3                   	ret    

00801722 <chktst>:
void chktst(uint32 n)
{
  801722:	55                   	push   %ebp
  801723:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	ff 75 08             	pushl  0x8(%ebp)
  801730:	6a 29                	push   $0x29
  801732:	e8 fd fa ff ff       	call   801234 <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
	return ;
  80173a:	90                   	nop
}
  80173b:	c9                   	leave  
  80173c:	c3                   	ret    

0080173d <inctst>:

void inctst()
{
  80173d:	55                   	push   %ebp
  80173e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 2a                	push   $0x2a
  80174c:	e8 e3 fa ff ff       	call   801234 <syscall>
  801751:	83 c4 18             	add    $0x18,%esp
	return ;
  801754:	90                   	nop
}
  801755:	c9                   	leave  
  801756:	c3                   	ret    

00801757 <gettst>:
uint32 gettst()
{
  801757:	55                   	push   %ebp
  801758:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 2b                	push   $0x2b
  801766:	e8 c9 fa ff ff       	call   801234 <syscall>
  80176b:	83 c4 18             	add    $0x18,%esp
}
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
  801773:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 2c                	push   $0x2c
  801782:	e8 ad fa ff ff       	call   801234 <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
  80178a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80178d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801791:	75 07                	jne    80179a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801793:	b8 01 00 00 00       	mov    $0x1,%eax
  801798:	eb 05                	jmp    80179f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80179a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80179f:	c9                   	leave  
  8017a0:	c3                   	ret    

008017a1 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017a1:	55                   	push   %ebp
  8017a2:	89 e5                	mov    %esp,%ebp
  8017a4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 2c                	push   $0x2c
  8017b3:	e8 7c fa ff ff       	call   801234 <syscall>
  8017b8:	83 c4 18             	add    $0x18,%esp
  8017bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017be:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017c2:	75 07                	jne    8017cb <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017c4:	b8 01 00 00 00       	mov    $0x1,%eax
  8017c9:	eb 05                	jmp    8017d0 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017d0:	c9                   	leave  
  8017d1:	c3                   	ret    

008017d2 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017d2:	55                   	push   %ebp
  8017d3:	89 e5                	mov    %esp,%ebp
  8017d5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 2c                	push   $0x2c
  8017e4:	e8 4b fa ff ff       	call   801234 <syscall>
  8017e9:	83 c4 18             	add    $0x18,%esp
  8017ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8017ef:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8017f3:	75 07                	jne    8017fc <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8017f5:	b8 01 00 00 00       	mov    $0x1,%eax
  8017fa:	eb 05                	jmp    801801 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8017fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801801:	c9                   	leave  
  801802:	c3                   	ret    

00801803 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801803:	55                   	push   %ebp
  801804:	89 e5                	mov    %esp,%ebp
  801806:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 2c                	push   $0x2c
  801815:	e8 1a fa ff ff       	call   801234 <syscall>
  80181a:	83 c4 18             	add    $0x18,%esp
  80181d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801820:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801824:	75 07                	jne    80182d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801826:	b8 01 00 00 00       	mov    $0x1,%eax
  80182b:	eb 05                	jmp    801832 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80182d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801832:	c9                   	leave  
  801833:	c3                   	ret    

00801834 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	ff 75 08             	pushl  0x8(%ebp)
  801842:	6a 2d                	push   $0x2d
  801844:	e8 eb f9 ff ff       	call   801234 <syscall>
  801849:	83 c4 18             	add    $0x18,%esp
	return ;
  80184c:	90                   	nop
}
  80184d:	c9                   	leave  
  80184e:	c3                   	ret    

0080184f <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80184f:	55                   	push   %ebp
  801850:	89 e5                	mov    %esp,%ebp
  801852:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801853:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801856:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801859:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185c:	8b 45 08             	mov    0x8(%ebp),%eax
  80185f:	6a 00                	push   $0x0
  801861:	53                   	push   %ebx
  801862:	51                   	push   %ecx
  801863:	52                   	push   %edx
  801864:	50                   	push   %eax
  801865:	6a 2e                	push   $0x2e
  801867:	e8 c8 f9 ff ff       	call   801234 <syscall>
  80186c:	83 c4 18             	add    $0x18,%esp
}
  80186f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801872:	c9                   	leave  
  801873:	c3                   	ret    

00801874 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801874:	55                   	push   %ebp
  801875:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801877:	8b 55 0c             	mov    0xc(%ebp),%edx
  80187a:	8b 45 08             	mov    0x8(%ebp),%eax
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	52                   	push   %edx
  801884:	50                   	push   %eax
  801885:	6a 2f                	push   $0x2f
  801887:	e8 a8 f9 ff ff       	call   801234 <syscall>
  80188c:	83 c4 18             	add    $0x18,%esp
}
  80188f:	c9                   	leave  
  801890:	c3                   	ret    

00801891 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801891:	55                   	push   %ebp
  801892:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	ff 75 0c             	pushl  0xc(%ebp)
  80189d:	ff 75 08             	pushl  0x8(%ebp)
  8018a0:	6a 30                	push   $0x30
  8018a2:	e8 8d f9 ff ff       	call   801234 <syscall>
  8018a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8018aa:	90                   	nop
}
  8018ab:	c9                   	leave  
  8018ac:	c3                   	ret    

008018ad <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018ad:	55                   	push   %ebp
  8018ae:	89 e5                	mov    %esp,%ebp
  8018b0:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8018b6:	89 d0                	mov    %edx,%eax
  8018b8:	c1 e0 02             	shl    $0x2,%eax
  8018bb:	01 d0                	add    %edx,%eax
  8018bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018c4:	01 d0                	add    %edx,%eax
  8018c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018cd:	01 d0                	add    %edx,%eax
  8018cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d6:	01 d0                	add    %edx,%eax
  8018d8:	c1 e0 04             	shl    $0x4,%eax
  8018db:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8018de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8018e5:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8018e8:	83 ec 0c             	sub    $0xc,%esp
  8018eb:	50                   	push   %eax
  8018ec:	e8 5a fd ff ff       	call   80164b <sys_get_virtual_time>
  8018f1:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8018f4:	eb 41                	jmp    801937 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8018f6:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8018f9:	83 ec 0c             	sub    $0xc,%esp
  8018fc:	50                   	push   %eax
  8018fd:	e8 49 fd ff ff       	call   80164b <sys_get_virtual_time>
  801902:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801905:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801908:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80190b:	29 c2                	sub    %eax,%edx
  80190d:	89 d0                	mov    %edx,%eax
  80190f:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801912:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801915:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801918:	89 d1                	mov    %edx,%ecx
  80191a:	29 c1                	sub    %eax,%ecx
  80191c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80191f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801922:	39 c2                	cmp    %eax,%edx
  801924:	0f 97 c0             	seta   %al
  801927:	0f b6 c0             	movzbl %al,%eax
  80192a:	29 c1                	sub    %eax,%ecx
  80192c:	89 c8                	mov    %ecx,%eax
  80192e:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801931:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801934:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801937:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80193a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80193d:	72 b7                	jb     8018f6 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80193f:	90                   	nop
  801940:	c9                   	leave  
  801941:	c3                   	ret    

00801942 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801942:	55                   	push   %ebp
  801943:	89 e5                	mov    %esp,%ebp
  801945:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801948:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80194f:	eb 03                	jmp    801954 <busy_wait+0x12>
  801951:	ff 45 fc             	incl   -0x4(%ebp)
  801954:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801957:	3b 45 08             	cmp    0x8(%ebp),%eax
  80195a:	72 f5                	jb     801951 <busy_wait+0xf>
	return i;
  80195c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80195f:	c9                   	leave  
  801960:	c3                   	ret    
  801961:	66 90                	xchg   %ax,%ax
  801963:	90                   	nop

00801964 <__udivdi3>:
  801964:	55                   	push   %ebp
  801965:	57                   	push   %edi
  801966:	56                   	push   %esi
  801967:	53                   	push   %ebx
  801968:	83 ec 1c             	sub    $0x1c,%esp
  80196b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80196f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801973:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801977:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80197b:	89 ca                	mov    %ecx,%edx
  80197d:	89 f8                	mov    %edi,%eax
  80197f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801983:	85 f6                	test   %esi,%esi
  801985:	75 2d                	jne    8019b4 <__udivdi3+0x50>
  801987:	39 cf                	cmp    %ecx,%edi
  801989:	77 65                	ja     8019f0 <__udivdi3+0x8c>
  80198b:	89 fd                	mov    %edi,%ebp
  80198d:	85 ff                	test   %edi,%edi
  80198f:	75 0b                	jne    80199c <__udivdi3+0x38>
  801991:	b8 01 00 00 00       	mov    $0x1,%eax
  801996:	31 d2                	xor    %edx,%edx
  801998:	f7 f7                	div    %edi
  80199a:	89 c5                	mov    %eax,%ebp
  80199c:	31 d2                	xor    %edx,%edx
  80199e:	89 c8                	mov    %ecx,%eax
  8019a0:	f7 f5                	div    %ebp
  8019a2:	89 c1                	mov    %eax,%ecx
  8019a4:	89 d8                	mov    %ebx,%eax
  8019a6:	f7 f5                	div    %ebp
  8019a8:	89 cf                	mov    %ecx,%edi
  8019aa:	89 fa                	mov    %edi,%edx
  8019ac:	83 c4 1c             	add    $0x1c,%esp
  8019af:	5b                   	pop    %ebx
  8019b0:	5e                   	pop    %esi
  8019b1:	5f                   	pop    %edi
  8019b2:	5d                   	pop    %ebp
  8019b3:	c3                   	ret    
  8019b4:	39 ce                	cmp    %ecx,%esi
  8019b6:	77 28                	ja     8019e0 <__udivdi3+0x7c>
  8019b8:	0f bd fe             	bsr    %esi,%edi
  8019bb:	83 f7 1f             	xor    $0x1f,%edi
  8019be:	75 40                	jne    801a00 <__udivdi3+0x9c>
  8019c0:	39 ce                	cmp    %ecx,%esi
  8019c2:	72 0a                	jb     8019ce <__udivdi3+0x6a>
  8019c4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019c8:	0f 87 9e 00 00 00    	ja     801a6c <__udivdi3+0x108>
  8019ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8019d3:	89 fa                	mov    %edi,%edx
  8019d5:	83 c4 1c             	add    $0x1c,%esp
  8019d8:	5b                   	pop    %ebx
  8019d9:	5e                   	pop    %esi
  8019da:	5f                   	pop    %edi
  8019db:	5d                   	pop    %ebp
  8019dc:	c3                   	ret    
  8019dd:	8d 76 00             	lea    0x0(%esi),%esi
  8019e0:	31 ff                	xor    %edi,%edi
  8019e2:	31 c0                	xor    %eax,%eax
  8019e4:	89 fa                	mov    %edi,%edx
  8019e6:	83 c4 1c             	add    $0x1c,%esp
  8019e9:	5b                   	pop    %ebx
  8019ea:	5e                   	pop    %esi
  8019eb:	5f                   	pop    %edi
  8019ec:	5d                   	pop    %ebp
  8019ed:	c3                   	ret    
  8019ee:	66 90                	xchg   %ax,%ax
  8019f0:	89 d8                	mov    %ebx,%eax
  8019f2:	f7 f7                	div    %edi
  8019f4:	31 ff                	xor    %edi,%edi
  8019f6:	89 fa                	mov    %edi,%edx
  8019f8:	83 c4 1c             	add    $0x1c,%esp
  8019fb:	5b                   	pop    %ebx
  8019fc:	5e                   	pop    %esi
  8019fd:	5f                   	pop    %edi
  8019fe:	5d                   	pop    %ebp
  8019ff:	c3                   	ret    
  801a00:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a05:	89 eb                	mov    %ebp,%ebx
  801a07:	29 fb                	sub    %edi,%ebx
  801a09:	89 f9                	mov    %edi,%ecx
  801a0b:	d3 e6                	shl    %cl,%esi
  801a0d:	89 c5                	mov    %eax,%ebp
  801a0f:	88 d9                	mov    %bl,%cl
  801a11:	d3 ed                	shr    %cl,%ebp
  801a13:	89 e9                	mov    %ebp,%ecx
  801a15:	09 f1                	or     %esi,%ecx
  801a17:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a1b:	89 f9                	mov    %edi,%ecx
  801a1d:	d3 e0                	shl    %cl,%eax
  801a1f:	89 c5                	mov    %eax,%ebp
  801a21:	89 d6                	mov    %edx,%esi
  801a23:	88 d9                	mov    %bl,%cl
  801a25:	d3 ee                	shr    %cl,%esi
  801a27:	89 f9                	mov    %edi,%ecx
  801a29:	d3 e2                	shl    %cl,%edx
  801a2b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a2f:	88 d9                	mov    %bl,%cl
  801a31:	d3 e8                	shr    %cl,%eax
  801a33:	09 c2                	or     %eax,%edx
  801a35:	89 d0                	mov    %edx,%eax
  801a37:	89 f2                	mov    %esi,%edx
  801a39:	f7 74 24 0c          	divl   0xc(%esp)
  801a3d:	89 d6                	mov    %edx,%esi
  801a3f:	89 c3                	mov    %eax,%ebx
  801a41:	f7 e5                	mul    %ebp
  801a43:	39 d6                	cmp    %edx,%esi
  801a45:	72 19                	jb     801a60 <__udivdi3+0xfc>
  801a47:	74 0b                	je     801a54 <__udivdi3+0xf0>
  801a49:	89 d8                	mov    %ebx,%eax
  801a4b:	31 ff                	xor    %edi,%edi
  801a4d:	e9 58 ff ff ff       	jmp    8019aa <__udivdi3+0x46>
  801a52:	66 90                	xchg   %ax,%ax
  801a54:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a58:	89 f9                	mov    %edi,%ecx
  801a5a:	d3 e2                	shl    %cl,%edx
  801a5c:	39 c2                	cmp    %eax,%edx
  801a5e:	73 e9                	jae    801a49 <__udivdi3+0xe5>
  801a60:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a63:	31 ff                	xor    %edi,%edi
  801a65:	e9 40 ff ff ff       	jmp    8019aa <__udivdi3+0x46>
  801a6a:	66 90                	xchg   %ax,%ax
  801a6c:	31 c0                	xor    %eax,%eax
  801a6e:	e9 37 ff ff ff       	jmp    8019aa <__udivdi3+0x46>
  801a73:	90                   	nop

00801a74 <__umoddi3>:
  801a74:	55                   	push   %ebp
  801a75:	57                   	push   %edi
  801a76:	56                   	push   %esi
  801a77:	53                   	push   %ebx
  801a78:	83 ec 1c             	sub    $0x1c,%esp
  801a7b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a7f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a83:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a87:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a8b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a8f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a93:	89 f3                	mov    %esi,%ebx
  801a95:	89 fa                	mov    %edi,%edx
  801a97:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a9b:	89 34 24             	mov    %esi,(%esp)
  801a9e:	85 c0                	test   %eax,%eax
  801aa0:	75 1a                	jne    801abc <__umoddi3+0x48>
  801aa2:	39 f7                	cmp    %esi,%edi
  801aa4:	0f 86 a2 00 00 00    	jbe    801b4c <__umoddi3+0xd8>
  801aaa:	89 c8                	mov    %ecx,%eax
  801aac:	89 f2                	mov    %esi,%edx
  801aae:	f7 f7                	div    %edi
  801ab0:	89 d0                	mov    %edx,%eax
  801ab2:	31 d2                	xor    %edx,%edx
  801ab4:	83 c4 1c             	add    $0x1c,%esp
  801ab7:	5b                   	pop    %ebx
  801ab8:	5e                   	pop    %esi
  801ab9:	5f                   	pop    %edi
  801aba:	5d                   	pop    %ebp
  801abb:	c3                   	ret    
  801abc:	39 f0                	cmp    %esi,%eax
  801abe:	0f 87 ac 00 00 00    	ja     801b70 <__umoddi3+0xfc>
  801ac4:	0f bd e8             	bsr    %eax,%ebp
  801ac7:	83 f5 1f             	xor    $0x1f,%ebp
  801aca:	0f 84 ac 00 00 00    	je     801b7c <__umoddi3+0x108>
  801ad0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ad5:	29 ef                	sub    %ebp,%edi
  801ad7:	89 fe                	mov    %edi,%esi
  801ad9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801add:	89 e9                	mov    %ebp,%ecx
  801adf:	d3 e0                	shl    %cl,%eax
  801ae1:	89 d7                	mov    %edx,%edi
  801ae3:	89 f1                	mov    %esi,%ecx
  801ae5:	d3 ef                	shr    %cl,%edi
  801ae7:	09 c7                	or     %eax,%edi
  801ae9:	89 e9                	mov    %ebp,%ecx
  801aeb:	d3 e2                	shl    %cl,%edx
  801aed:	89 14 24             	mov    %edx,(%esp)
  801af0:	89 d8                	mov    %ebx,%eax
  801af2:	d3 e0                	shl    %cl,%eax
  801af4:	89 c2                	mov    %eax,%edx
  801af6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801afa:	d3 e0                	shl    %cl,%eax
  801afc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b00:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b04:	89 f1                	mov    %esi,%ecx
  801b06:	d3 e8                	shr    %cl,%eax
  801b08:	09 d0                	or     %edx,%eax
  801b0a:	d3 eb                	shr    %cl,%ebx
  801b0c:	89 da                	mov    %ebx,%edx
  801b0e:	f7 f7                	div    %edi
  801b10:	89 d3                	mov    %edx,%ebx
  801b12:	f7 24 24             	mull   (%esp)
  801b15:	89 c6                	mov    %eax,%esi
  801b17:	89 d1                	mov    %edx,%ecx
  801b19:	39 d3                	cmp    %edx,%ebx
  801b1b:	0f 82 87 00 00 00    	jb     801ba8 <__umoddi3+0x134>
  801b21:	0f 84 91 00 00 00    	je     801bb8 <__umoddi3+0x144>
  801b27:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b2b:	29 f2                	sub    %esi,%edx
  801b2d:	19 cb                	sbb    %ecx,%ebx
  801b2f:	89 d8                	mov    %ebx,%eax
  801b31:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b35:	d3 e0                	shl    %cl,%eax
  801b37:	89 e9                	mov    %ebp,%ecx
  801b39:	d3 ea                	shr    %cl,%edx
  801b3b:	09 d0                	or     %edx,%eax
  801b3d:	89 e9                	mov    %ebp,%ecx
  801b3f:	d3 eb                	shr    %cl,%ebx
  801b41:	89 da                	mov    %ebx,%edx
  801b43:	83 c4 1c             	add    $0x1c,%esp
  801b46:	5b                   	pop    %ebx
  801b47:	5e                   	pop    %esi
  801b48:	5f                   	pop    %edi
  801b49:	5d                   	pop    %ebp
  801b4a:	c3                   	ret    
  801b4b:	90                   	nop
  801b4c:	89 fd                	mov    %edi,%ebp
  801b4e:	85 ff                	test   %edi,%edi
  801b50:	75 0b                	jne    801b5d <__umoddi3+0xe9>
  801b52:	b8 01 00 00 00       	mov    $0x1,%eax
  801b57:	31 d2                	xor    %edx,%edx
  801b59:	f7 f7                	div    %edi
  801b5b:	89 c5                	mov    %eax,%ebp
  801b5d:	89 f0                	mov    %esi,%eax
  801b5f:	31 d2                	xor    %edx,%edx
  801b61:	f7 f5                	div    %ebp
  801b63:	89 c8                	mov    %ecx,%eax
  801b65:	f7 f5                	div    %ebp
  801b67:	89 d0                	mov    %edx,%eax
  801b69:	e9 44 ff ff ff       	jmp    801ab2 <__umoddi3+0x3e>
  801b6e:	66 90                	xchg   %ax,%ax
  801b70:	89 c8                	mov    %ecx,%eax
  801b72:	89 f2                	mov    %esi,%edx
  801b74:	83 c4 1c             	add    $0x1c,%esp
  801b77:	5b                   	pop    %ebx
  801b78:	5e                   	pop    %esi
  801b79:	5f                   	pop    %edi
  801b7a:	5d                   	pop    %ebp
  801b7b:	c3                   	ret    
  801b7c:	3b 04 24             	cmp    (%esp),%eax
  801b7f:	72 06                	jb     801b87 <__umoddi3+0x113>
  801b81:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b85:	77 0f                	ja     801b96 <__umoddi3+0x122>
  801b87:	89 f2                	mov    %esi,%edx
  801b89:	29 f9                	sub    %edi,%ecx
  801b8b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b8f:	89 14 24             	mov    %edx,(%esp)
  801b92:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b96:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b9a:	8b 14 24             	mov    (%esp),%edx
  801b9d:	83 c4 1c             	add    $0x1c,%esp
  801ba0:	5b                   	pop    %ebx
  801ba1:	5e                   	pop    %esi
  801ba2:	5f                   	pop    %edi
  801ba3:	5d                   	pop    %ebp
  801ba4:	c3                   	ret    
  801ba5:	8d 76 00             	lea    0x0(%esi),%esi
  801ba8:	2b 04 24             	sub    (%esp),%eax
  801bab:	19 fa                	sbb    %edi,%edx
  801bad:	89 d1                	mov    %edx,%ecx
  801baf:	89 c6                	mov    %eax,%esi
  801bb1:	e9 71 ff ff ff       	jmp    801b27 <__umoddi3+0xb3>
  801bb6:	66 90                	xchg   %ax,%ax
  801bb8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801bbc:	72 ea                	jb     801ba8 <__umoddi3+0x134>
  801bbe:	89 d9                	mov    %ebx,%ecx
  801bc0:	e9 62 ff ff ff       	jmp    801b27 <__umoddi3+0xb3>
