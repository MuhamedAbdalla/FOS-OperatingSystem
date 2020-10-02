
obj/user/tst_CPU_MLFQ_slave_1_1:     file format elf32-i386


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
  800031:	e8 f0 00 00 00       	call   800126 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int ID;
	for (int i = 0; i < 3; ++i) {
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 5e                	jmp    8000a5 <_main+0x6d>
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
  80006a:	68 20 1c 80 00       	push   $0x801c20
  80006f:	e8 d9 15 00 00       	call   80164d <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if (ID == E_ENV_CREATION_ERROR)
  80007a:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  80007e:	75 14                	jne    800094 <_main+0x5c>
			panic("RUNNING OUT OF ENV!! terminating...");
  800080:	83 ec 04             	sub    $0x4,%esp
  800083:	68 30 1c 80 00       	push   $0x801c30
  800088:	6a 09                	push   $0x9
  80008a:	68 54 1c 80 00       	push   $0x801c54
  80008f:	e8 b7 01 00 00       	call   80024b <_panic>
		sys_run_env(ID);
  800094:	83 ec 0c             	sub    $0xc,%esp
  800097:	ff 75 f0             	pushl  -0x10(%ebp)
  80009a:	e8 cc 15 00 00       	call   80166b <sys_run_env>
  80009f:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 3; ++i) {
  8000a2:	ff 45 f4             	incl   -0xc(%ebp)
  8000a5:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  8000a9:	7e 9c                	jle    800047 <_main+0xf>
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
		if (ID == E_ENV_CREATION_ERROR)
			panic("RUNNING OUT OF ENV!! terminating...");
		sys_run_env(ID);
	}
	env_sleep(50);
  8000ab:	83 ec 0c             	sub    $0xc,%esp
  8000ae:	6a 32                	push   $0x32
  8000b0:	e8 50 18 00 00       	call   801905 <env_sleep>
  8000b5:	83 c4 10             	add    $0x10,%esp

	ID = sys_create_env("cpuMLFQ1Slave_2", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000bd:	8b 90 f4 52 00 00    	mov    0x52f4(%eax),%edx
  8000c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c8:	8b 80 34 53 00 00    	mov    0x5334(%eax),%eax
  8000ce:	89 c1                	mov    %eax,%ecx
  8000d0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d5:	8b 40 74             	mov    0x74(%eax),%eax
  8000d8:	52                   	push   %edx
  8000d9:	51                   	push   %ecx
  8000da:	50                   	push   %eax
  8000db:	68 72 1c 80 00       	push   $0x801c72
  8000e0:	e8 68 15 00 00       	call   80164d <sys_create_env>
  8000e5:	83 c4 10             	add    $0x10,%esp
  8000e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (ID == E_ENV_CREATION_ERROR)
  8000eb:	83 7d f0 ef          	cmpl   $0xffffffef,-0x10(%ebp)
  8000ef:	75 14                	jne    800105 <_main+0xcd>
		panic("RUNNING OUT OF ENV!! terminating...");
  8000f1:	83 ec 04             	sub    $0x4,%esp
  8000f4:	68 30 1c 80 00       	push   $0x801c30
  8000f9:	6a 10                	push   $0x10
  8000fb:	68 54 1c 80 00       	push   $0x801c54
  800100:	e8 46 01 00 00       	call   80024b <_panic>
	sys_run_env(ID);
  800105:	83 ec 0c             	sub    $0xc,%esp
  800108:	ff 75 f0             	pushl  -0x10(%ebp)
  80010b:	e8 5b 15 00 00       	call   80166b <sys_run_env>
  800110:	83 c4 10             	add    $0x10,%esp

	env_sleep(5000);
  800113:	83 ec 0c             	sub    $0xc,%esp
  800116:	68 88 13 00 00       	push   $0x1388
  80011b:	e8 e5 17 00 00       	call   801905 <env_sleep>
  800120:	83 c4 10             	add    $0x10,%esp

	return;
  800123:	90                   	nop
}
  800124:	c9                   	leave  
  800125:	c3                   	ret    

00800126 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800126:	55                   	push   %ebp
  800127:	89 e5                	mov    %esp,%ebp
  800129:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80012c:	e8 fc 11 00 00       	call   80132d <sys_getenvindex>
  800131:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800134:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800137:	89 d0                	mov    %edx,%eax
  800139:	c1 e0 03             	shl    $0x3,%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	c1 e0 02             	shl    $0x2,%eax
  800141:	01 d0                	add    %edx,%eax
  800143:	c1 e0 06             	shl    $0x6,%eax
  800146:	29 d0                	sub    %edx,%eax
  800148:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80014f:	01 c8                	add    %ecx,%eax
  800151:	01 d0                	add    %edx,%eax
  800153:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800158:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80015d:	a1 20 30 80 00       	mov    0x803020,%eax
  800162:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  800168:	84 c0                	test   %al,%al
  80016a:	74 0f                	je     80017b <libmain+0x55>
		binaryname = myEnv->prog_name;
  80016c:	a1 20 30 80 00       	mov    0x803020,%eax
  800171:	05 b0 52 00 00       	add    $0x52b0,%eax
  800176:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80017b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80017f:	7e 0a                	jle    80018b <libmain+0x65>
		binaryname = argv[0];
  800181:	8b 45 0c             	mov    0xc(%ebp),%eax
  800184:	8b 00                	mov    (%eax),%eax
  800186:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80018b:	83 ec 08             	sub    $0x8,%esp
  80018e:	ff 75 0c             	pushl  0xc(%ebp)
  800191:	ff 75 08             	pushl  0x8(%ebp)
  800194:	e8 9f fe ff ff       	call   800038 <_main>
  800199:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80019c:	e8 27 13 00 00       	call   8014c8 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001a1:	83 ec 0c             	sub    $0xc,%esp
  8001a4:	68 9c 1c 80 00       	push   $0x801c9c
  8001a9:	e8 54 03 00 00       	call   800502 <cprintf>
  8001ae:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b6:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  8001bc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c1:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  8001c7:	83 ec 04             	sub    $0x4,%esp
  8001ca:	52                   	push   %edx
  8001cb:	50                   	push   %eax
  8001cc:	68 c4 1c 80 00       	push   $0x801cc4
  8001d1:	e8 2c 03 00 00       	call   800502 <cprintf>
  8001d6:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8001d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001de:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  8001e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e9:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  8001ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f4:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  8001fa:	51                   	push   %ecx
  8001fb:	52                   	push   %edx
  8001fc:	50                   	push   %eax
  8001fd:	68 ec 1c 80 00       	push   $0x801cec
  800202:	e8 fb 02 00 00       	call   800502 <cprintf>
  800207:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80020a:	83 ec 0c             	sub    $0xc,%esp
  80020d:	68 9c 1c 80 00       	push   $0x801c9c
  800212:	e8 eb 02 00 00       	call   800502 <cprintf>
  800217:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80021a:	e8 c3 12 00 00       	call   8014e2 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80021f:	e8 19 00 00 00       	call   80023d <exit>
}
  800224:	90                   	nop
  800225:	c9                   	leave  
  800226:	c3                   	ret    

00800227 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800227:	55                   	push   %ebp
  800228:	89 e5                	mov    %esp,%ebp
  80022a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80022d:	83 ec 0c             	sub    $0xc,%esp
  800230:	6a 00                	push   $0x0
  800232:	e8 c2 10 00 00       	call   8012f9 <sys_env_destroy>
  800237:	83 c4 10             	add    $0x10,%esp
}
  80023a:	90                   	nop
  80023b:	c9                   	leave  
  80023c:	c3                   	ret    

0080023d <exit>:

void
exit(void)
{
  80023d:	55                   	push   %ebp
  80023e:	89 e5                	mov    %esp,%ebp
  800240:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800243:	e8 17 11 00 00       	call   80135f <sys_env_exit>
}
  800248:	90                   	nop
  800249:	c9                   	leave  
  80024a:	c3                   	ret    

0080024b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80024b:	55                   	push   %ebp
  80024c:	89 e5                	mov    %esp,%ebp
  80024e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800251:	8d 45 10             	lea    0x10(%ebp),%eax
  800254:	83 c0 04             	add    $0x4,%eax
  800257:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80025a:	a1 18 31 80 00       	mov    0x803118,%eax
  80025f:	85 c0                	test   %eax,%eax
  800261:	74 16                	je     800279 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800263:	a1 18 31 80 00       	mov    0x803118,%eax
  800268:	83 ec 08             	sub    $0x8,%esp
  80026b:	50                   	push   %eax
  80026c:	68 44 1d 80 00       	push   $0x801d44
  800271:	e8 8c 02 00 00       	call   800502 <cprintf>
  800276:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800279:	a1 00 30 80 00       	mov    0x803000,%eax
  80027e:	ff 75 0c             	pushl  0xc(%ebp)
  800281:	ff 75 08             	pushl  0x8(%ebp)
  800284:	50                   	push   %eax
  800285:	68 49 1d 80 00       	push   $0x801d49
  80028a:	e8 73 02 00 00       	call   800502 <cprintf>
  80028f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800292:	8b 45 10             	mov    0x10(%ebp),%eax
  800295:	83 ec 08             	sub    $0x8,%esp
  800298:	ff 75 f4             	pushl  -0xc(%ebp)
  80029b:	50                   	push   %eax
  80029c:	e8 f6 01 00 00       	call   800497 <vcprintf>
  8002a1:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002a4:	83 ec 08             	sub    $0x8,%esp
  8002a7:	6a 00                	push   $0x0
  8002a9:	68 65 1d 80 00       	push   $0x801d65
  8002ae:	e8 e4 01 00 00       	call   800497 <vcprintf>
  8002b3:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002b6:	e8 82 ff ff ff       	call   80023d <exit>

	// should not return here
	while (1) ;
  8002bb:	eb fe                	jmp    8002bb <_panic+0x70>

008002bd <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002bd:	55                   	push   %ebp
  8002be:	89 e5                	mov    %esp,%ebp
  8002c0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c8:	8b 50 74             	mov    0x74(%eax),%edx
  8002cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ce:	39 c2                	cmp    %eax,%edx
  8002d0:	74 14                	je     8002e6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002d2:	83 ec 04             	sub    $0x4,%esp
  8002d5:	68 68 1d 80 00       	push   $0x801d68
  8002da:	6a 26                	push   $0x26
  8002dc:	68 b4 1d 80 00       	push   $0x801db4
  8002e1:	e8 65 ff ff ff       	call   80024b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002f4:	e9 c4 00 00 00       	jmp    8003bd <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8002f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800303:	8b 45 08             	mov    0x8(%ebp),%eax
  800306:	01 d0                	add    %edx,%eax
  800308:	8b 00                	mov    (%eax),%eax
  80030a:	85 c0                	test   %eax,%eax
  80030c:	75 08                	jne    800316 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80030e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800311:	e9 a4 00 00 00       	jmp    8003ba <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800316:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80031d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800324:	eb 6b                	jmp    800391 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800326:	a1 20 30 80 00       	mov    0x803020,%eax
  80032b:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800331:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800334:	89 d0                	mov    %edx,%eax
  800336:	c1 e0 02             	shl    $0x2,%eax
  800339:	01 d0                	add    %edx,%eax
  80033b:	c1 e0 02             	shl    $0x2,%eax
  80033e:	01 c8                	add    %ecx,%eax
  800340:	8a 40 04             	mov    0x4(%eax),%al
  800343:	84 c0                	test   %al,%al
  800345:	75 47                	jne    80038e <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800347:	a1 20 30 80 00       	mov    0x803020,%eax
  80034c:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800352:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800355:	89 d0                	mov    %edx,%eax
  800357:	c1 e0 02             	shl    $0x2,%eax
  80035a:	01 d0                	add    %edx,%eax
  80035c:	c1 e0 02             	shl    $0x2,%eax
  80035f:	01 c8                	add    %ecx,%eax
  800361:	8b 00                	mov    (%eax),%eax
  800363:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800366:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800369:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80036e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800370:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800373:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80037a:	8b 45 08             	mov    0x8(%ebp),%eax
  80037d:	01 c8                	add    %ecx,%eax
  80037f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800381:	39 c2                	cmp    %eax,%edx
  800383:	75 09                	jne    80038e <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800385:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80038c:	eb 12                	jmp    8003a0 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80038e:	ff 45 e8             	incl   -0x18(%ebp)
  800391:	a1 20 30 80 00       	mov    0x803020,%eax
  800396:	8b 50 74             	mov    0x74(%eax),%edx
  800399:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80039c:	39 c2                	cmp    %eax,%edx
  80039e:	77 86                	ja     800326 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003a4:	75 14                	jne    8003ba <CheckWSWithoutLastIndex+0xfd>
			panic(
  8003a6:	83 ec 04             	sub    $0x4,%esp
  8003a9:	68 c0 1d 80 00       	push   $0x801dc0
  8003ae:	6a 3a                	push   $0x3a
  8003b0:	68 b4 1d 80 00       	push   $0x801db4
  8003b5:	e8 91 fe ff ff       	call   80024b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003ba:	ff 45 f0             	incl   -0x10(%ebp)
  8003bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003c3:	0f 8c 30 ff ff ff    	jl     8002f9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003c9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003d0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003d7:	eb 27                	jmp    800400 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003de:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8003e4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003e7:	89 d0                	mov    %edx,%eax
  8003e9:	c1 e0 02             	shl    $0x2,%eax
  8003ec:	01 d0                	add    %edx,%eax
  8003ee:	c1 e0 02             	shl    $0x2,%eax
  8003f1:	01 c8                	add    %ecx,%eax
  8003f3:	8a 40 04             	mov    0x4(%eax),%al
  8003f6:	3c 01                	cmp    $0x1,%al
  8003f8:	75 03                	jne    8003fd <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8003fa:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003fd:	ff 45 e0             	incl   -0x20(%ebp)
  800400:	a1 20 30 80 00       	mov    0x803020,%eax
  800405:	8b 50 74             	mov    0x74(%eax),%edx
  800408:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80040b:	39 c2                	cmp    %eax,%edx
  80040d:	77 ca                	ja     8003d9 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80040f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800412:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800415:	74 14                	je     80042b <CheckWSWithoutLastIndex+0x16e>
		panic(
  800417:	83 ec 04             	sub    $0x4,%esp
  80041a:	68 14 1e 80 00       	push   $0x801e14
  80041f:	6a 44                	push   $0x44
  800421:	68 b4 1d 80 00       	push   $0x801db4
  800426:	e8 20 fe ff ff       	call   80024b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80042b:	90                   	nop
  80042c:	c9                   	leave  
  80042d:	c3                   	ret    

0080042e <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80042e:	55                   	push   %ebp
  80042f:	89 e5                	mov    %esp,%ebp
  800431:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800434:	8b 45 0c             	mov    0xc(%ebp),%eax
  800437:	8b 00                	mov    (%eax),%eax
  800439:	8d 48 01             	lea    0x1(%eax),%ecx
  80043c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80043f:	89 0a                	mov    %ecx,(%edx)
  800441:	8b 55 08             	mov    0x8(%ebp),%edx
  800444:	88 d1                	mov    %dl,%cl
  800446:	8b 55 0c             	mov    0xc(%ebp),%edx
  800449:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80044d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800450:	8b 00                	mov    (%eax),%eax
  800452:	3d ff 00 00 00       	cmp    $0xff,%eax
  800457:	75 2c                	jne    800485 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800459:	a0 24 30 80 00       	mov    0x803024,%al
  80045e:	0f b6 c0             	movzbl %al,%eax
  800461:	8b 55 0c             	mov    0xc(%ebp),%edx
  800464:	8b 12                	mov    (%edx),%edx
  800466:	89 d1                	mov    %edx,%ecx
  800468:	8b 55 0c             	mov    0xc(%ebp),%edx
  80046b:	83 c2 08             	add    $0x8,%edx
  80046e:	83 ec 04             	sub    $0x4,%esp
  800471:	50                   	push   %eax
  800472:	51                   	push   %ecx
  800473:	52                   	push   %edx
  800474:	e8 3e 0e 00 00       	call   8012b7 <sys_cputs>
  800479:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80047c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800485:	8b 45 0c             	mov    0xc(%ebp),%eax
  800488:	8b 40 04             	mov    0x4(%eax),%eax
  80048b:	8d 50 01             	lea    0x1(%eax),%edx
  80048e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800491:	89 50 04             	mov    %edx,0x4(%eax)
}
  800494:	90                   	nop
  800495:	c9                   	leave  
  800496:	c3                   	ret    

00800497 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800497:	55                   	push   %ebp
  800498:	89 e5                	mov    %esp,%ebp
  80049a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004a0:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004a7:	00 00 00 
	b.cnt = 0;
  8004aa:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004b1:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004b4:	ff 75 0c             	pushl  0xc(%ebp)
  8004b7:	ff 75 08             	pushl  0x8(%ebp)
  8004ba:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004c0:	50                   	push   %eax
  8004c1:	68 2e 04 80 00       	push   $0x80042e
  8004c6:	e8 11 02 00 00       	call   8006dc <vprintfmt>
  8004cb:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004ce:	a0 24 30 80 00       	mov    0x803024,%al
  8004d3:	0f b6 c0             	movzbl %al,%eax
  8004d6:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004dc:	83 ec 04             	sub    $0x4,%esp
  8004df:	50                   	push   %eax
  8004e0:	52                   	push   %edx
  8004e1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004e7:	83 c0 08             	add    $0x8,%eax
  8004ea:	50                   	push   %eax
  8004eb:	e8 c7 0d 00 00       	call   8012b7 <sys_cputs>
  8004f0:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004f3:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8004fa:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800500:	c9                   	leave  
  800501:	c3                   	ret    

00800502 <cprintf>:

int cprintf(const char *fmt, ...) {
  800502:	55                   	push   %ebp
  800503:	89 e5                	mov    %esp,%ebp
  800505:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800508:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80050f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800512:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800515:	8b 45 08             	mov    0x8(%ebp),%eax
  800518:	83 ec 08             	sub    $0x8,%esp
  80051b:	ff 75 f4             	pushl  -0xc(%ebp)
  80051e:	50                   	push   %eax
  80051f:	e8 73 ff ff ff       	call   800497 <vcprintf>
  800524:	83 c4 10             	add    $0x10,%esp
  800527:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80052a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80052d:	c9                   	leave  
  80052e:	c3                   	ret    

0080052f <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80052f:	55                   	push   %ebp
  800530:	89 e5                	mov    %esp,%ebp
  800532:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800535:	e8 8e 0f 00 00       	call   8014c8 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80053a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80053d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800540:	8b 45 08             	mov    0x8(%ebp),%eax
  800543:	83 ec 08             	sub    $0x8,%esp
  800546:	ff 75 f4             	pushl  -0xc(%ebp)
  800549:	50                   	push   %eax
  80054a:	e8 48 ff ff ff       	call   800497 <vcprintf>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800555:	e8 88 0f 00 00       	call   8014e2 <sys_enable_interrupt>
	return cnt;
  80055a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80055d:	c9                   	leave  
  80055e:	c3                   	ret    

0080055f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80055f:	55                   	push   %ebp
  800560:	89 e5                	mov    %esp,%ebp
  800562:	53                   	push   %ebx
  800563:	83 ec 14             	sub    $0x14,%esp
  800566:	8b 45 10             	mov    0x10(%ebp),%eax
  800569:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80056c:	8b 45 14             	mov    0x14(%ebp),%eax
  80056f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800572:	8b 45 18             	mov    0x18(%ebp),%eax
  800575:	ba 00 00 00 00       	mov    $0x0,%edx
  80057a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80057d:	77 55                	ja     8005d4 <printnum+0x75>
  80057f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800582:	72 05                	jb     800589 <printnum+0x2a>
  800584:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800587:	77 4b                	ja     8005d4 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800589:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80058c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80058f:	8b 45 18             	mov    0x18(%ebp),%eax
  800592:	ba 00 00 00 00       	mov    $0x0,%edx
  800597:	52                   	push   %edx
  800598:	50                   	push   %eax
  800599:	ff 75 f4             	pushl  -0xc(%ebp)
  80059c:	ff 75 f0             	pushl  -0x10(%ebp)
  80059f:	e8 18 14 00 00       	call   8019bc <__udivdi3>
  8005a4:	83 c4 10             	add    $0x10,%esp
  8005a7:	83 ec 04             	sub    $0x4,%esp
  8005aa:	ff 75 20             	pushl  0x20(%ebp)
  8005ad:	53                   	push   %ebx
  8005ae:	ff 75 18             	pushl  0x18(%ebp)
  8005b1:	52                   	push   %edx
  8005b2:	50                   	push   %eax
  8005b3:	ff 75 0c             	pushl  0xc(%ebp)
  8005b6:	ff 75 08             	pushl  0x8(%ebp)
  8005b9:	e8 a1 ff ff ff       	call   80055f <printnum>
  8005be:	83 c4 20             	add    $0x20,%esp
  8005c1:	eb 1a                	jmp    8005dd <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005c3:	83 ec 08             	sub    $0x8,%esp
  8005c6:	ff 75 0c             	pushl  0xc(%ebp)
  8005c9:	ff 75 20             	pushl  0x20(%ebp)
  8005cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005cf:	ff d0                	call   *%eax
  8005d1:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005d4:	ff 4d 1c             	decl   0x1c(%ebp)
  8005d7:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005db:	7f e6                	jg     8005c3 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005dd:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005e0:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005eb:	53                   	push   %ebx
  8005ec:	51                   	push   %ecx
  8005ed:	52                   	push   %edx
  8005ee:	50                   	push   %eax
  8005ef:	e8 d8 14 00 00       	call   801acc <__umoddi3>
  8005f4:	83 c4 10             	add    $0x10,%esp
  8005f7:	05 74 20 80 00       	add    $0x802074,%eax
  8005fc:	8a 00                	mov    (%eax),%al
  8005fe:	0f be c0             	movsbl %al,%eax
  800601:	83 ec 08             	sub    $0x8,%esp
  800604:	ff 75 0c             	pushl  0xc(%ebp)
  800607:	50                   	push   %eax
  800608:	8b 45 08             	mov    0x8(%ebp),%eax
  80060b:	ff d0                	call   *%eax
  80060d:	83 c4 10             	add    $0x10,%esp
}
  800610:	90                   	nop
  800611:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800614:	c9                   	leave  
  800615:	c3                   	ret    

00800616 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800616:	55                   	push   %ebp
  800617:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800619:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80061d:	7e 1c                	jle    80063b <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80061f:	8b 45 08             	mov    0x8(%ebp),%eax
  800622:	8b 00                	mov    (%eax),%eax
  800624:	8d 50 08             	lea    0x8(%eax),%edx
  800627:	8b 45 08             	mov    0x8(%ebp),%eax
  80062a:	89 10                	mov    %edx,(%eax)
  80062c:	8b 45 08             	mov    0x8(%ebp),%eax
  80062f:	8b 00                	mov    (%eax),%eax
  800631:	83 e8 08             	sub    $0x8,%eax
  800634:	8b 50 04             	mov    0x4(%eax),%edx
  800637:	8b 00                	mov    (%eax),%eax
  800639:	eb 40                	jmp    80067b <getuint+0x65>
	else if (lflag)
  80063b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80063f:	74 1e                	je     80065f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800641:	8b 45 08             	mov    0x8(%ebp),%eax
  800644:	8b 00                	mov    (%eax),%eax
  800646:	8d 50 04             	lea    0x4(%eax),%edx
  800649:	8b 45 08             	mov    0x8(%ebp),%eax
  80064c:	89 10                	mov    %edx,(%eax)
  80064e:	8b 45 08             	mov    0x8(%ebp),%eax
  800651:	8b 00                	mov    (%eax),%eax
  800653:	83 e8 04             	sub    $0x4,%eax
  800656:	8b 00                	mov    (%eax),%eax
  800658:	ba 00 00 00 00       	mov    $0x0,%edx
  80065d:	eb 1c                	jmp    80067b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80065f:	8b 45 08             	mov    0x8(%ebp),%eax
  800662:	8b 00                	mov    (%eax),%eax
  800664:	8d 50 04             	lea    0x4(%eax),%edx
  800667:	8b 45 08             	mov    0x8(%ebp),%eax
  80066a:	89 10                	mov    %edx,(%eax)
  80066c:	8b 45 08             	mov    0x8(%ebp),%eax
  80066f:	8b 00                	mov    (%eax),%eax
  800671:	83 e8 04             	sub    $0x4,%eax
  800674:	8b 00                	mov    (%eax),%eax
  800676:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80067b:	5d                   	pop    %ebp
  80067c:	c3                   	ret    

0080067d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80067d:	55                   	push   %ebp
  80067e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800680:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800684:	7e 1c                	jle    8006a2 <getint+0x25>
		return va_arg(*ap, long long);
  800686:	8b 45 08             	mov    0x8(%ebp),%eax
  800689:	8b 00                	mov    (%eax),%eax
  80068b:	8d 50 08             	lea    0x8(%eax),%edx
  80068e:	8b 45 08             	mov    0x8(%ebp),%eax
  800691:	89 10                	mov    %edx,(%eax)
  800693:	8b 45 08             	mov    0x8(%ebp),%eax
  800696:	8b 00                	mov    (%eax),%eax
  800698:	83 e8 08             	sub    $0x8,%eax
  80069b:	8b 50 04             	mov    0x4(%eax),%edx
  80069e:	8b 00                	mov    (%eax),%eax
  8006a0:	eb 38                	jmp    8006da <getint+0x5d>
	else if (lflag)
  8006a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006a6:	74 1a                	je     8006c2 <getint+0x45>
		return va_arg(*ap, long);
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	8b 00                	mov    (%eax),%eax
  8006ad:	8d 50 04             	lea    0x4(%eax),%edx
  8006b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b3:	89 10                	mov    %edx,(%eax)
  8006b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b8:	8b 00                	mov    (%eax),%eax
  8006ba:	83 e8 04             	sub    $0x4,%eax
  8006bd:	8b 00                	mov    (%eax),%eax
  8006bf:	99                   	cltd   
  8006c0:	eb 18                	jmp    8006da <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c5:	8b 00                	mov    (%eax),%eax
  8006c7:	8d 50 04             	lea    0x4(%eax),%edx
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	89 10                	mov    %edx,(%eax)
  8006cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d2:	8b 00                	mov    (%eax),%eax
  8006d4:	83 e8 04             	sub    $0x4,%eax
  8006d7:	8b 00                	mov    (%eax),%eax
  8006d9:	99                   	cltd   
}
  8006da:	5d                   	pop    %ebp
  8006db:	c3                   	ret    

008006dc <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006dc:	55                   	push   %ebp
  8006dd:	89 e5                	mov    %esp,%ebp
  8006df:	56                   	push   %esi
  8006e0:	53                   	push   %ebx
  8006e1:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006e4:	eb 17                	jmp    8006fd <vprintfmt+0x21>
			if (ch == '\0')
  8006e6:	85 db                	test   %ebx,%ebx
  8006e8:	0f 84 af 03 00 00    	je     800a9d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006ee:	83 ec 08             	sub    $0x8,%esp
  8006f1:	ff 75 0c             	pushl  0xc(%ebp)
  8006f4:	53                   	push   %ebx
  8006f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f8:	ff d0                	call   *%eax
  8006fa:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800700:	8d 50 01             	lea    0x1(%eax),%edx
  800703:	89 55 10             	mov    %edx,0x10(%ebp)
  800706:	8a 00                	mov    (%eax),%al
  800708:	0f b6 d8             	movzbl %al,%ebx
  80070b:	83 fb 25             	cmp    $0x25,%ebx
  80070e:	75 d6                	jne    8006e6 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800710:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800714:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80071b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800722:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800729:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800730:	8b 45 10             	mov    0x10(%ebp),%eax
  800733:	8d 50 01             	lea    0x1(%eax),%edx
  800736:	89 55 10             	mov    %edx,0x10(%ebp)
  800739:	8a 00                	mov    (%eax),%al
  80073b:	0f b6 d8             	movzbl %al,%ebx
  80073e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800741:	83 f8 55             	cmp    $0x55,%eax
  800744:	0f 87 2b 03 00 00    	ja     800a75 <vprintfmt+0x399>
  80074a:	8b 04 85 98 20 80 00 	mov    0x802098(,%eax,4),%eax
  800751:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800753:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800757:	eb d7                	jmp    800730 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800759:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80075d:	eb d1                	jmp    800730 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80075f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800766:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800769:	89 d0                	mov    %edx,%eax
  80076b:	c1 e0 02             	shl    $0x2,%eax
  80076e:	01 d0                	add    %edx,%eax
  800770:	01 c0                	add    %eax,%eax
  800772:	01 d8                	add    %ebx,%eax
  800774:	83 e8 30             	sub    $0x30,%eax
  800777:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80077a:	8b 45 10             	mov    0x10(%ebp),%eax
  80077d:	8a 00                	mov    (%eax),%al
  80077f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800782:	83 fb 2f             	cmp    $0x2f,%ebx
  800785:	7e 3e                	jle    8007c5 <vprintfmt+0xe9>
  800787:	83 fb 39             	cmp    $0x39,%ebx
  80078a:	7f 39                	jg     8007c5 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80078c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80078f:	eb d5                	jmp    800766 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800791:	8b 45 14             	mov    0x14(%ebp),%eax
  800794:	83 c0 04             	add    $0x4,%eax
  800797:	89 45 14             	mov    %eax,0x14(%ebp)
  80079a:	8b 45 14             	mov    0x14(%ebp),%eax
  80079d:	83 e8 04             	sub    $0x4,%eax
  8007a0:	8b 00                	mov    (%eax),%eax
  8007a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007a5:	eb 1f                	jmp    8007c6 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007a7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ab:	79 83                	jns    800730 <vprintfmt+0x54>
				width = 0;
  8007ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007b4:	e9 77 ff ff ff       	jmp    800730 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007b9:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007c0:	e9 6b ff ff ff       	jmp    800730 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007c5:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007c6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ca:	0f 89 60 ff ff ff    	jns    800730 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007d3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007d6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007dd:	e9 4e ff ff ff       	jmp    800730 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007e2:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007e5:	e9 46 ff ff ff       	jmp    800730 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ed:	83 c0 04             	add    $0x4,%eax
  8007f0:	89 45 14             	mov    %eax,0x14(%ebp)
  8007f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f6:	83 e8 04             	sub    $0x4,%eax
  8007f9:	8b 00                	mov    (%eax),%eax
  8007fb:	83 ec 08             	sub    $0x8,%esp
  8007fe:	ff 75 0c             	pushl  0xc(%ebp)
  800801:	50                   	push   %eax
  800802:	8b 45 08             	mov    0x8(%ebp),%eax
  800805:	ff d0                	call   *%eax
  800807:	83 c4 10             	add    $0x10,%esp
			break;
  80080a:	e9 89 02 00 00       	jmp    800a98 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80080f:	8b 45 14             	mov    0x14(%ebp),%eax
  800812:	83 c0 04             	add    $0x4,%eax
  800815:	89 45 14             	mov    %eax,0x14(%ebp)
  800818:	8b 45 14             	mov    0x14(%ebp),%eax
  80081b:	83 e8 04             	sub    $0x4,%eax
  80081e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800820:	85 db                	test   %ebx,%ebx
  800822:	79 02                	jns    800826 <vprintfmt+0x14a>
				err = -err;
  800824:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800826:	83 fb 64             	cmp    $0x64,%ebx
  800829:	7f 0b                	jg     800836 <vprintfmt+0x15a>
  80082b:	8b 34 9d e0 1e 80 00 	mov    0x801ee0(,%ebx,4),%esi
  800832:	85 f6                	test   %esi,%esi
  800834:	75 19                	jne    80084f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800836:	53                   	push   %ebx
  800837:	68 85 20 80 00       	push   $0x802085
  80083c:	ff 75 0c             	pushl  0xc(%ebp)
  80083f:	ff 75 08             	pushl  0x8(%ebp)
  800842:	e8 5e 02 00 00       	call   800aa5 <printfmt>
  800847:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80084a:	e9 49 02 00 00       	jmp    800a98 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80084f:	56                   	push   %esi
  800850:	68 8e 20 80 00       	push   $0x80208e
  800855:	ff 75 0c             	pushl  0xc(%ebp)
  800858:	ff 75 08             	pushl  0x8(%ebp)
  80085b:	e8 45 02 00 00       	call   800aa5 <printfmt>
  800860:	83 c4 10             	add    $0x10,%esp
			break;
  800863:	e9 30 02 00 00       	jmp    800a98 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800868:	8b 45 14             	mov    0x14(%ebp),%eax
  80086b:	83 c0 04             	add    $0x4,%eax
  80086e:	89 45 14             	mov    %eax,0x14(%ebp)
  800871:	8b 45 14             	mov    0x14(%ebp),%eax
  800874:	83 e8 04             	sub    $0x4,%eax
  800877:	8b 30                	mov    (%eax),%esi
  800879:	85 f6                	test   %esi,%esi
  80087b:	75 05                	jne    800882 <vprintfmt+0x1a6>
				p = "(null)";
  80087d:	be 91 20 80 00       	mov    $0x802091,%esi
			if (width > 0 && padc != '-')
  800882:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800886:	7e 6d                	jle    8008f5 <vprintfmt+0x219>
  800888:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80088c:	74 67                	je     8008f5 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80088e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800891:	83 ec 08             	sub    $0x8,%esp
  800894:	50                   	push   %eax
  800895:	56                   	push   %esi
  800896:	e8 0c 03 00 00       	call   800ba7 <strnlen>
  80089b:	83 c4 10             	add    $0x10,%esp
  80089e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008a1:	eb 16                	jmp    8008b9 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008a3:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008a7:	83 ec 08             	sub    $0x8,%esp
  8008aa:	ff 75 0c             	pushl  0xc(%ebp)
  8008ad:	50                   	push   %eax
  8008ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b1:	ff d0                	call   *%eax
  8008b3:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b6:	ff 4d e4             	decl   -0x1c(%ebp)
  8008b9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008bd:	7f e4                	jg     8008a3 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008bf:	eb 34                	jmp    8008f5 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008c1:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008c5:	74 1c                	je     8008e3 <vprintfmt+0x207>
  8008c7:	83 fb 1f             	cmp    $0x1f,%ebx
  8008ca:	7e 05                	jle    8008d1 <vprintfmt+0x1f5>
  8008cc:	83 fb 7e             	cmp    $0x7e,%ebx
  8008cf:	7e 12                	jle    8008e3 <vprintfmt+0x207>
					putch('?', putdat);
  8008d1:	83 ec 08             	sub    $0x8,%esp
  8008d4:	ff 75 0c             	pushl  0xc(%ebp)
  8008d7:	6a 3f                	push   $0x3f
  8008d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dc:	ff d0                	call   *%eax
  8008de:	83 c4 10             	add    $0x10,%esp
  8008e1:	eb 0f                	jmp    8008f2 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008e3:	83 ec 08             	sub    $0x8,%esp
  8008e6:	ff 75 0c             	pushl  0xc(%ebp)
  8008e9:	53                   	push   %ebx
  8008ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ed:	ff d0                	call   *%eax
  8008ef:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008f2:	ff 4d e4             	decl   -0x1c(%ebp)
  8008f5:	89 f0                	mov    %esi,%eax
  8008f7:	8d 70 01             	lea    0x1(%eax),%esi
  8008fa:	8a 00                	mov    (%eax),%al
  8008fc:	0f be d8             	movsbl %al,%ebx
  8008ff:	85 db                	test   %ebx,%ebx
  800901:	74 24                	je     800927 <vprintfmt+0x24b>
  800903:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800907:	78 b8                	js     8008c1 <vprintfmt+0x1e5>
  800909:	ff 4d e0             	decl   -0x20(%ebp)
  80090c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800910:	79 af                	jns    8008c1 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800912:	eb 13                	jmp    800927 <vprintfmt+0x24b>
				putch(' ', putdat);
  800914:	83 ec 08             	sub    $0x8,%esp
  800917:	ff 75 0c             	pushl  0xc(%ebp)
  80091a:	6a 20                	push   $0x20
  80091c:	8b 45 08             	mov    0x8(%ebp),%eax
  80091f:	ff d0                	call   *%eax
  800921:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800924:	ff 4d e4             	decl   -0x1c(%ebp)
  800927:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80092b:	7f e7                	jg     800914 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80092d:	e9 66 01 00 00       	jmp    800a98 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800932:	83 ec 08             	sub    $0x8,%esp
  800935:	ff 75 e8             	pushl  -0x18(%ebp)
  800938:	8d 45 14             	lea    0x14(%ebp),%eax
  80093b:	50                   	push   %eax
  80093c:	e8 3c fd ff ff       	call   80067d <getint>
  800941:	83 c4 10             	add    $0x10,%esp
  800944:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800947:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80094a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80094d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800950:	85 d2                	test   %edx,%edx
  800952:	79 23                	jns    800977 <vprintfmt+0x29b>
				putch('-', putdat);
  800954:	83 ec 08             	sub    $0x8,%esp
  800957:	ff 75 0c             	pushl  0xc(%ebp)
  80095a:	6a 2d                	push   $0x2d
  80095c:	8b 45 08             	mov    0x8(%ebp),%eax
  80095f:	ff d0                	call   *%eax
  800961:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800964:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800967:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80096a:	f7 d8                	neg    %eax
  80096c:	83 d2 00             	adc    $0x0,%edx
  80096f:	f7 da                	neg    %edx
  800971:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800974:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800977:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80097e:	e9 bc 00 00 00       	jmp    800a3f <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800983:	83 ec 08             	sub    $0x8,%esp
  800986:	ff 75 e8             	pushl  -0x18(%ebp)
  800989:	8d 45 14             	lea    0x14(%ebp),%eax
  80098c:	50                   	push   %eax
  80098d:	e8 84 fc ff ff       	call   800616 <getuint>
  800992:	83 c4 10             	add    $0x10,%esp
  800995:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800998:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80099b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009a2:	e9 98 00 00 00       	jmp    800a3f <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009a7:	83 ec 08             	sub    $0x8,%esp
  8009aa:	ff 75 0c             	pushl  0xc(%ebp)
  8009ad:	6a 58                	push   $0x58
  8009af:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b2:	ff d0                	call   *%eax
  8009b4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009b7:	83 ec 08             	sub    $0x8,%esp
  8009ba:	ff 75 0c             	pushl  0xc(%ebp)
  8009bd:	6a 58                	push   $0x58
  8009bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c2:	ff d0                	call   *%eax
  8009c4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009c7:	83 ec 08             	sub    $0x8,%esp
  8009ca:	ff 75 0c             	pushl  0xc(%ebp)
  8009cd:	6a 58                	push   $0x58
  8009cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d2:	ff d0                	call   *%eax
  8009d4:	83 c4 10             	add    $0x10,%esp
			break;
  8009d7:	e9 bc 00 00 00       	jmp    800a98 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009dc:	83 ec 08             	sub    $0x8,%esp
  8009df:	ff 75 0c             	pushl  0xc(%ebp)
  8009e2:	6a 30                	push   $0x30
  8009e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e7:	ff d0                	call   *%eax
  8009e9:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009ec:	83 ec 08             	sub    $0x8,%esp
  8009ef:	ff 75 0c             	pushl  0xc(%ebp)
  8009f2:	6a 78                	push   $0x78
  8009f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f7:	ff d0                	call   *%eax
  8009f9:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ff:	83 c0 04             	add    $0x4,%eax
  800a02:	89 45 14             	mov    %eax,0x14(%ebp)
  800a05:	8b 45 14             	mov    0x14(%ebp),%eax
  800a08:	83 e8 04             	sub    $0x4,%eax
  800a0b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a17:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a1e:	eb 1f                	jmp    800a3f <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a20:	83 ec 08             	sub    $0x8,%esp
  800a23:	ff 75 e8             	pushl  -0x18(%ebp)
  800a26:	8d 45 14             	lea    0x14(%ebp),%eax
  800a29:	50                   	push   %eax
  800a2a:	e8 e7 fb ff ff       	call   800616 <getuint>
  800a2f:	83 c4 10             	add    $0x10,%esp
  800a32:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a35:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a38:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a3f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a43:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a46:	83 ec 04             	sub    $0x4,%esp
  800a49:	52                   	push   %edx
  800a4a:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a4d:	50                   	push   %eax
  800a4e:	ff 75 f4             	pushl  -0xc(%ebp)
  800a51:	ff 75 f0             	pushl  -0x10(%ebp)
  800a54:	ff 75 0c             	pushl  0xc(%ebp)
  800a57:	ff 75 08             	pushl  0x8(%ebp)
  800a5a:	e8 00 fb ff ff       	call   80055f <printnum>
  800a5f:	83 c4 20             	add    $0x20,%esp
			break;
  800a62:	eb 34                	jmp    800a98 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a64:	83 ec 08             	sub    $0x8,%esp
  800a67:	ff 75 0c             	pushl  0xc(%ebp)
  800a6a:	53                   	push   %ebx
  800a6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6e:	ff d0                	call   *%eax
  800a70:	83 c4 10             	add    $0x10,%esp
			break;
  800a73:	eb 23                	jmp    800a98 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a75:	83 ec 08             	sub    $0x8,%esp
  800a78:	ff 75 0c             	pushl  0xc(%ebp)
  800a7b:	6a 25                	push   $0x25
  800a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a80:	ff d0                	call   *%eax
  800a82:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a85:	ff 4d 10             	decl   0x10(%ebp)
  800a88:	eb 03                	jmp    800a8d <vprintfmt+0x3b1>
  800a8a:	ff 4d 10             	decl   0x10(%ebp)
  800a8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800a90:	48                   	dec    %eax
  800a91:	8a 00                	mov    (%eax),%al
  800a93:	3c 25                	cmp    $0x25,%al
  800a95:	75 f3                	jne    800a8a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a97:	90                   	nop
		}
	}
  800a98:	e9 47 fc ff ff       	jmp    8006e4 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a9d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800aa1:	5b                   	pop    %ebx
  800aa2:	5e                   	pop    %esi
  800aa3:	5d                   	pop    %ebp
  800aa4:	c3                   	ret    

00800aa5 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800aa5:	55                   	push   %ebp
  800aa6:	89 e5                	mov    %esp,%ebp
  800aa8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800aab:	8d 45 10             	lea    0x10(%ebp),%eax
  800aae:	83 c0 04             	add    $0x4,%eax
  800ab1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ab4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab7:	ff 75 f4             	pushl  -0xc(%ebp)
  800aba:	50                   	push   %eax
  800abb:	ff 75 0c             	pushl  0xc(%ebp)
  800abe:	ff 75 08             	pushl  0x8(%ebp)
  800ac1:	e8 16 fc ff ff       	call   8006dc <vprintfmt>
  800ac6:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ac9:	90                   	nop
  800aca:	c9                   	leave  
  800acb:	c3                   	ret    

00800acc <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800acc:	55                   	push   %ebp
  800acd:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800acf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad2:	8b 40 08             	mov    0x8(%eax),%eax
  800ad5:	8d 50 01             	lea    0x1(%eax),%edx
  800ad8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adb:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ade:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae1:	8b 10                	mov    (%eax),%edx
  800ae3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae6:	8b 40 04             	mov    0x4(%eax),%eax
  800ae9:	39 c2                	cmp    %eax,%edx
  800aeb:	73 12                	jae    800aff <sprintputch+0x33>
		*b->buf++ = ch;
  800aed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af0:	8b 00                	mov    (%eax),%eax
  800af2:	8d 48 01             	lea    0x1(%eax),%ecx
  800af5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af8:	89 0a                	mov    %ecx,(%edx)
  800afa:	8b 55 08             	mov    0x8(%ebp),%edx
  800afd:	88 10                	mov    %dl,(%eax)
}
  800aff:	90                   	nop
  800b00:	5d                   	pop    %ebp
  800b01:	c3                   	ret    

00800b02 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b02:	55                   	push   %ebp
  800b03:	89 e5                	mov    %esp,%ebp
  800b05:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b11:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
  800b17:	01 d0                	add    %edx,%eax
  800b19:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b1c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b23:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b27:	74 06                	je     800b2f <vsnprintf+0x2d>
  800b29:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b2d:	7f 07                	jg     800b36 <vsnprintf+0x34>
		return -E_INVAL;
  800b2f:	b8 03 00 00 00       	mov    $0x3,%eax
  800b34:	eb 20                	jmp    800b56 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b36:	ff 75 14             	pushl  0x14(%ebp)
  800b39:	ff 75 10             	pushl  0x10(%ebp)
  800b3c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b3f:	50                   	push   %eax
  800b40:	68 cc 0a 80 00       	push   $0x800acc
  800b45:	e8 92 fb ff ff       	call   8006dc <vprintfmt>
  800b4a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b4d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b50:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b56:	c9                   	leave  
  800b57:	c3                   	ret    

00800b58 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b58:	55                   	push   %ebp
  800b59:	89 e5                	mov    %esp,%ebp
  800b5b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b5e:	8d 45 10             	lea    0x10(%ebp),%eax
  800b61:	83 c0 04             	add    $0x4,%eax
  800b64:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b67:	8b 45 10             	mov    0x10(%ebp),%eax
  800b6a:	ff 75 f4             	pushl  -0xc(%ebp)
  800b6d:	50                   	push   %eax
  800b6e:	ff 75 0c             	pushl  0xc(%ebp)
  800b71:	ff 75 08             	pushl  0x8(%ebp)
  800b74:	e8 89 ff ff ff       	call   800b02 <vsnprintf>
  800b79:	83 c4 10             	add    $0x10,%esp
  800b7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b82:	c9                   	leave  
  800b83:	c3                   	ret    

00800b84 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b84:	55                   	push   %ebp
  800b85:	89 e5                	mov    %esp,%ebp
  800b87:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b91:	eb 06                	jmp    800b99 <strlen+0x15>
		n++;
  800b93:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b96:	ff 45 08             	incl   0x8(%ebp)
  800b99:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9c:	8a 00                	mov    (%eax),%al
  800b9e:	84 c0                	test   %al,%al
  800ba0:	75 f1                	jne    800b93 <strlen+0xf>
		n++;
	return n;
  800ba2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba5:	c9                   	leave  
  800ba6:	c3                   	ret    

00800ba7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ba7:	55                   	push   %ebp
  800ba8:	89 e5                	mov    %esp,%ebp
  800baa:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bb4:	eb 09                	jmp    800bbf <strnlen+0x18>
		n++;
  800bb6:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bb9:	ff 45 08             	incl   0x8(%ebp)
  800bbc:	ff 4d 0c             	decl   0xc(%ebp)
  800bbf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc3:	74 09                	je     800bce <strnlen+0x27>
  800bc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc8:	8a 00                	mov    (%eax),%al
  800bca:	84 c0                	test   %al,%al
  800bcc:	75 e8                	jne    800bb6 <strnlen+0xf>
		n++;
	return n;
  800bce:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bd1:	c9                   	leave  
  800bd2:	c3                   	ret    

00800bd3 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bd3:	55                   	push   %ebp
  800bd4:	89 e5                	mov    %esp,%ebp
  800bd6:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bdf:	90                   	nop
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	8d 50 01             	lea    0x1(%eax),%edx
  800be6:	89 55 08             	mov    %edx,0x8(%ebp)
  800be9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bec:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bef:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bf2:	8a 12                	mov    (%edx),%dl
  800bf4:	88 10                	mov    %dl,(%eax)
  800bf6:	8a 00                	mov    (%eax),%al
  800bf8:	84 c0                	test   %al,%al
  800bfa:	75 e4                	jne    800be0 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bff:	c9                   	leave  
  800c00:	c3                   	ret    

00800c01 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c01:	55                   	push   %ebp
  800c02:	89 e5                	mov    %esp,%ebp
  800c04:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c0d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c14:	eb 1f                	jmp    800c35 <strncpy+0x34>
		*dst++ = *src;
  800c16:	8b 45 08             	mov    0x8(%ebp),%eax
  800c19:	8d 50 01             	lea    0x1(%eax),%edx
  800c1c:	89 55 08             	mov    %edx,0x8(%ebp)
  800c1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c22:	8a 12                	mov    (%edx),%dl
  800c24:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c29:	8a 00                	mov    (%eax),%al
  800c2b:	84 c0                	test   %al,%al
  800c2d:	74 03                	je     800c32 <strncpy+0x31>
			src++;
  800c2f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c32:	ff 45 fc             	incl   -0x4(%ebp)
  800c35:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c38:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c3b:	72 d9                	jb     800c16 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c3d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c40:	c9                   	leave  
  800c41:	c3                   	ret    

00800c42 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c42:	55                   	push   %ebp
  800c43:	89 e5                	mov    %esp,%ebp
  800c45:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c48:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c4e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c52:	74 30                	je     800c84 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c54:	eb 16                	jmp    800c6c <strlcpy+0x2a>
			*dst++ = *src++;
  800c56:	8b 45 08             	mov    0x8(%ebp),%eax
  800c59:	8d 50 01             	lea    0x1(%eax),%edx
  800c5c:	89 55 08             	mov    %edx,0x8(%ebp)
  800c5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c62:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c65:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c68:	8a 12                	mov    (%edx),%dl
  800c6a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c6c:	ff 4d 10             	decl   0x10(%ebp)
  800c6f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c73:	74 09                	je     800c7e <strlcpy+0x3c>
  800c75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c78:	8a 00                	mov    (%eax),%al
  800c7a:	84 c0                	test   %al,%al
  800c7c:	75 d8                	jne    800c56 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c84:	8b 55 08             	mov    0x8(%ebp),%edx
  800c87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c8a:	29 c2                	sub    %eax,%edx
  800c8c:	89 d0                	mov    %edx,%eax
}
  800c8e:	c9                   	leave  
  800c8f:	c3                   	ret    

00800c90 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c90:	55                   	push   %ebp
  800c91:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c93:	eb 06                	jmp    800c9b <strcmp+0xb>
		p++, q++;
  800c95:	ff 45 08             	incl   0x8(%ebp)
  800c98:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	8a 00                	mov    (%eax),%al
  800ca0:	84 c0                	test   %al,%al
  800ca2:	74 0e                	je     800cb2 <strcmp+0x22>
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	8a 10                	mov    (%eax),%dl
  800ca9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cac:	8a 00                	mov    (%eax),%al
  800cae:	38 c2                	cmp    %al,%dl
  800cb0:	74 e3                	je     800c95 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	8a 00                	mov    (%eax),%al
  800cb7:	0f b6 d0             	movzbl %al,%edx
  800cba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbd:	8a 00                	mov    (%eax),%al
  800cbf:	0f b6 c0             	movzbl %al,%eax
  800cc2:	29 c2                	sub    %eax,%edx
  800cc4:	89 d0                	mov    %edx,%eax
}
  800cc6:	5d                   	pop    %ebp
  800cc7:	c3                   	ret    

00800cc8 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cc8:	55                   	push   %ebp
  800cc9:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ccb:	eb 09                	jmp    800cd6 <strncmp+0xe>
		n--, p++, q++;
  800ccd:	ff 4d 10             	decl   0x10(%ebp)
  800cd0:	ff 45 08             	incl   0x8(%ebp)
  800cd3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cd6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cda:	74 17                	je     800cf3 <strncmp+0x2b>
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	8a 00                	mov    (%eax),%al
  800ce1:	84 c0                	test   %al,%al
  800ce3:	74 0e                	je     800cf3 <strncmp+0x2b>
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8a 10                	mov    (%eax),%dl
  800cea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ced:	8a 00                	mov    (%eax),%al
  800cef:	38 c2                	cmp    %al,%dl
  800cf1:	74 da                	je     800ccd <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cf3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf7:	75 07                	jne    800d00 <strncmp+0x38>
		return 0;
  800cf9:	b8 00 00 00 00       	mov    $0x0,%eax
  800cfe:	eb 14                	jmp    800d14 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d00:	8b 45 08             	mov    0x8(%ebp),%eax
  800d03:	8a 00                	mov    (%eax),%al
  800d05:	0f b6 d0             	movzbl %al,%edx
  800d08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0b:	8a 00                	mov    (%eax),%al
  800d0d:	0f b6 c0             	movzbl %al,%eax
  800d10:	29 c2                	sub    %eax,%edx
  800d12:	89 d0                	mov    %edx,%eax
}
  800d14:	5d                   	pop    %ebp
  800d15:	c3                   	ret    

00800d16 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d16:	55                   	push   %ebp
  800d17:	89 e5                	mov    %esp,%ebp
  800d19:	83 ec 04             	sub    $0x4,%esp
  800d1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d22:	eb 12                	jmp    800d36 <strchr+0x20>
		if (*s == c)
  800d24:	8b 45 08             	mov    0x8(%ebp),%eax
  800d27:	8a 00                	mov    (%eax),%al
  800d29:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d2c:	75 05                	jne    800d33 <strchr+0x1d>
			return (char *) s;
  800d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d31:	eb 11                	jmp    800d44 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d33:	ff 45 08             	incl   0x8(%ebp)
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8a 00                	mov    (%eax),%al
  800d3b:	84 c0                	test   %al,%al
  800d3d:	75 e5                	jne    800d24 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d3f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d44:	c9                   	leave  
  800d45:	c3                   	ret    

00800d46 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d46:	55                   	push   %ebp
  800d47:	89 e5                	mov    %esp,%ebp
  800d49:	83 ec 04             	sub    $0x4,%esp
  800d4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d52:	eb 0d                	jmp    800d61 <strfind+0x1b>
		if (*s == c)
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	8a 00                	mov    (%eax),%al
  800d59:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d5c:	74 0e                	je     800d6c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d5e:	ff 45 08             	incl   0x8(%ebp)
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8a 00                	mov    (%eax),%al
  800d66:	84 c0                	test   %al,%al
  800d68:	75 ea                	jne    800d54 <strfind+0xe>
  800d6a:	eb 01                	jmp    800d6d <strfind+0x27>
		if (*s == c)
			break;
  800d6c:	90                   	nop
	return (char *) s;
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d70:	c9                   	leave  
  800d71:	c3                   	ret    

00800d72 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d72:	55                   	push   %ebp
  800d73:	89 e5                	mov    %esp,%ebp
  800d75:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800d81:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d84:	eb 0e                	jmp    800d94 <memset+0x22>
		*p++ = c;
  800d86:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d89:	8d 50 01             	lea    0x1(%eax),%edx
  800d8c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d92:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d94:	ff 4d f8             	decl   -0x8(%ebp)
  800d97:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d9b:	79 e9                	jns    800d86 <memset+0x14>
		*p++ = c;

	return v;
  800d9d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800da0:	c9                   	leave  
  800da1:	c3                   	ret    

00800da2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800da2:	55                   	push   %ebp
  800da3:	89 e5                	mov    %esp,%ebp
  800da5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800da8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800db4:	eb 16                	jmp    800dcc <memcpy+0x2a>
		*d++ = *s++;
  800db6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db9:	8d 50 01             	lea    0x1(%eax),%edx
  800dbc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dbf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dc2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dc5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dc8:	8a 12                	mov    (%edx),%dl
  800dca:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dd2:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd5:	85 c0                	test   %eax,%eax
  800dd7:	75 dd                	jne    800db6 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ddc:	c9                   	leave  
  800ddd:	c3                   	ret    

00800dde <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800dde:	55                   	push   %ebp
  800ddf:	89 e5                	mov    %esp,%ebp
  800de1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800de4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800df0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800df6:	73 50                	jae    800e48 <memmove+0x6a>
  800df8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dfb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfe:	01 d0                	add    %edx,%eax
  800e00:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e03:	76 43                	jbe    800e48 <memmove+0x6a>
		s += n;
  800e05:	8b 45 10             	mov    0x10(%ebp),%eax
  800e08:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e11:	eb 10                	jmp    800e23 <memmove+0x45>
			*--d = *--s;
  800e13:	ff 4d f8             	decl   -0x8(%ebp)
  800e16:	ff 4d fc             	decl   -0x4(%ebp)
  800e19:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1c:	8a 10                	mov    (%eax),%dl
  800e1e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e21:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e23:	8b 45 10             	mov    0x10(%ebp),%eax
  800e26:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e29:	89 55 10             	mov    %edx,0x10(%ebp)
  800e2c:	85 c0                	test   %eax,%eax
  800e2e:	75 e3                	jne    800e13 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e30:	eb 23                	jmp    800e55 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e35:	8d 50 01             	lea    0x1(%eax),%edx
  800e38:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e3b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e3e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e41:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e44:	8a 12                	mov    (%edx),%dl
  800e46:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e48:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e4e:	89 55 10             	mov    %edx,0x10(%ebp)
  800e51:	85 c0                	test   %eax,%eax
  800e53:	75 dd                	jne    800e32 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e55:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e58:	c9                   	leave  
  800e59:	c3                   	ret    

00800e5a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e5a:	55                   	push   %ebp
  800e5b:	89 e5                	mov    %esp,%ebp
  800e5d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
  800e63:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e69:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e6c:	eb 2a                	jmp    800e98 <memcmp+0x3e>
		if (*s1 != *s2)
  800e6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e71:	8a 10                	mov    (%eax),%dl
  800e73:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e76:	8a 00                	mov    (%eax),%al
  800e78:	38 c2                	cmp    %al,%dl
  800e7a:	74 16                	je     800e92 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7f:	8a 00                	mov    (%eax),%al
  800e81:	0f b6 d0             	movzbl %al,%edx
  800e84:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e87:	8a 00                	mov    (%eax),%al
  800e89:	0f b6 c0             	movzbl %al,%eax
  800e8c:	29 c2                	sub    %eax,%edx
  800e8e:	89 d0                	mov    %edx,%eax
  800e90:	eb 18                	jmp    800eaa <memcmp+0x50>
		s1++, s2++;
  800e92:	ff 45 fc             	incl   -0x4(%ebp)
  800e95:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e98:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e9e:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea1:	85 c0                	test   %eax,%eax
  800ea3:	75 c9                	jne    800e6e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ea5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800eaa:	c9                   	leave  
  800eab:	c3                   	ret    

00800eac <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800eac:	55                   	push   %ebp
  800ead:	89 e5                	mov    %esp,%ebp
  800eaf:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800eb2:	8b 55 08             	mov    0x8(%ebp),%edx
  800eb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb8:	01 d0                	add    %edx,%eax
  800eba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ebd:	eb 15                	jmp    800ed4 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec2:	8a 00                	mov    (%eax),%al
  800ec4:	0f b6 d0             	movzbl %al,%edx
  800ec7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eca:	0f b6 c0             	movzbl %al,%eax
  800ecd:	39 c2                	cmp    %eax,%edx
  800ecf:	74 0d                	je     800ede <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ed1:	ff 45 08             	incl   0x8(%ebp)
  800ed4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eda:	72 e3                	jb     800ebf <memfind+0x13>
  800edc:	eb 01                	jmp    800edf <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ede:	90                   	nop
	return (void *) s;
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee2:	c9                   	leave  
  800ee3:	c3                   	ret    

00800ee4 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ee4:	55                   	push   %ebp
  800ee5:	89 e5                	mov    %esp,%ebp
  800ee7:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800eea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ef1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ef8:	eb 03                	jmp    800efd <strtol+0x19>
		s++;
  800efa:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
  800f00:	8a 00                	mov    (%eax),%al
  800f02:	3c 20                	cmp    $0x20,%al
  800f04:	74 f4                	je     800efa <strtol+0x16>
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
  800f09:	8a 00                	mov    (%eax),%al
  800f0b:	3c 09                	cmp    $0x9,%al
  800f0d:	74 eb                	je     800efa <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	8a 00                	mov    (%eax),%al
  800f14:	3c 2b                	cmp    $0x2b,%al
  800f16:	75 05                	jne    800f1d <strtol+0x39>
		s++;
  800f18:	ff 45 08             	incl   0x8(%ebp)
  800f1b:	eb 13                	jmp    800f30 <strtol+0x4c>
	else if (*s == '-')
  800f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f20:	8a 00                	mov    (%eax),%al
  800f22:	3c 2d                	cmp    $0x2d,%al
  800f24:	75 0a                	jne    800f30 <strtol+0x4c>
		s++, neg = 1;
  800f26:	ff 45 08             	incl   0x8(%ebp)
  800f29:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f30:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f34:	74 06                	je     800f3c <strtol+0x58>
  800f36:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f3a:	75 20                	jne    800f5c <strtol+0x78>
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	8a 00                	mov    (%eax),%al
  800f41:	3c 30                	cmp    $0x30,%al
  800f43:	75 17                	jne    800f5c <strtol+0x78>
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	40                   	inc    %eax
  800f49:	8a 00                	mov    (%eax),%al
  800f4b:	3c 78                	cmp    $0x78,%al
  800f4d:	75 0d                	jne    800f5c <strtol+0x78>
		s += 2, base = 16;
  800f4f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f53:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f5a:	eb 28                	jmp    800f84 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f5c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f60:	75 15                	jne    800f77 <strtol+0x93>
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	3c 30                	cmp    $0x30,%al
  800f69:	75 0c                	jne    800f77 <strtol+0x93>
		s++, base = 8;
  800f6b:	ff 45 08             	incl   0x8(%ebp)
  800f6e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f75:	eb 0d                	jmp    800f84 <strtol+0xa0>
	else if (base == 0)
  800f77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f7b:	75 07                	jne    800f84 <strtol+0xa0>
		base = 10;
  800f7d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	8a 00                	mov    (%eax),%al
  800f89:	3c 2f                	cmp    $0x2f,%al
  800f8b:	7e 19                	jle    800fa6 <strtol+0xc2>
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	3c 39                	cmp    $0x39,%al
  800f94:	7f 10                	jg     800fa6 <strtol+0xc2>
			dig = *s - '0';
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	0f be c0             	movsbl %al,%eax
  800f9e:	83 e8 30             	sub    $0x30,%eax
  800fa1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fa4:	eb 42                	jmp    800fe8 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	8a 00                	mov    (%eax),%al
  800fab:	3c 60                	cmp    $0x60,%al
  800fad:	7e 19                	jle    800fc8 <strtol+0xe4>
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	8a 00                	mov    (%eax),%al
  800fb4:	3c 7a                	cmp    $0x7a,%al
  800fb6:	7f 10                	jg     800fc8 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	0f be c0             	movsbl %al,%eax
  800fc0:	83 e8 57             	sub    $0x57,%eax
  800fc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fc6:	eb 20                	jmp    800fe8 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcb:	8a 00                	mov    (%eax),%al
  800fcd:	3c 40                	cmp    $0x40,%al
  800fcf:	7e 39                	jle    80100a <strtol+0x126>
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	3c 5a                	cmp    $0x5a,%al
  800fd8:	7f 30                	jg     80100a <strtol+0x126>
			dig = *s - 'A' + 10;
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	0f be c0             	movsbl %al,%eax
  800fe2:	83 e8 37             	sub    $0x37,%eax
  800fe5:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fe8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800feb:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fee:	7d 19                	jge    801009 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800ff0:	ff 45 08             	incl   0x8(%ebp)
  800ff3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff6:	0f af 45 10          	imul   0x10(%ebp),%eax
  800ffa:	89 c2                	mov    %eax,%edx
  800ffc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fff:	01 d0                	add    %edx,%eax
  801001:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801004:	e9 7b ff ff ff       	jmp    800f84 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801009:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80100a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80100e:	74 08                	je     801018 <strtol+0x134>
		*endptr = (char *) s;
  801010:	8b 45 0c             	mov    0xc(%ebp),%eax
  801013:	8b 55 08             	mov    0x8(%ebp),%edx
  801016:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801018:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80101c:	74 07                	je     801025 <strtol+0x141>
  80101e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801021:	f7 d8                	neg    %eax
  801023:	eb 03                	jmp    801028 <strtol+0x144>
  801025:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801028:	c9                   	leave  
  801029:	c3                   	ret    

0080102a <ltostr>:

void
ltostr(long value, char *str)
{
  80102a:	55                   	push   %ebp
  80102b:	89 e5                	mov    %esp,%ebp
  80102d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801030:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801037:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80103e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801042:	79 13                	jns    801057 <ltostr+0x2d>
	{
		neg = 1;
  801044:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80104b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801051:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801054:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801057:	8b 45 08             	mov    0x8(%ebp),%eax
  80105a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80105f:	99                   	cltd   
  801060:	f7 f9                	idiv   %ecx
  801062:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801065:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801068:	8d 50 01             	lea    0x1(%eax),%edx
  80106b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80106e:	89 c2                	mov    %eax,%edx
  801070:	8b 45 0c             	mov    0xc(%ebp),%eax
  801073:	01 d0                	add    %edx,%eax
  801075:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801078:	83 c2 30             	add    $0x30,%edx
  80107b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80107d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801080:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801085:	f7 e9                	imul   %ecx
  801087:	c1 fa 02             	sar    $0x2,%edx
  80108a:	89 c8                	mov    %ecx,%eax
  80108c:	c1 f8 1f             	sar    $0x1f,%eax
  80108f:	29 c2                	sub    %eax,%edx
  801091:	89 d0                	mov    %edx,%eax
  801093:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801096:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801099:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80109e:	f7 e9                	imul   %ecx
  8010a0:	c1 fa 02             	sar    $0x2,%edx
  8010a3:	89 c8                	mov    %ecx,%eax
  8010a5:	c1 f8 1f             	sar    $0x1f,%eax
  8010a8:	29 c2                	sub    %eax,%edx
  8010aa:	89 d0                	mov    %edx,%eax
  8010ac:	c1 e0 02             	shl    $0x2,%eax
  8010af:	01 d0                	add    %edx,%eax
  8010b1:	01 c0                	add    %eax,%eax
  8010b3:	29 c1                	sub    %eax,%ecx
  8010b5:	89 ca                	mov    %ecx,%edx
  8010b7:	85 d2                	test   %edx,%edx
  8010b9:	75 9c                	jne    801057 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c5:	48                   	dec    %eax
  8010c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010c9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010cd:	74 3d                	je     80110c <ltostr+0xe2>
		start = 1 ;
  8010cf:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010d6:	eb 34                	jmp    80110c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010de:	01 d0                	add    %edx,%eax
  8010e0:	8a 00                	mov    (%eax),%al
  8010e2:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010eb:	01 c2                	add    %eax,%edx
  8010ed:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f3:	01 c8                	add    %ecx,%eax
  8010f5:	8a 00                	mov    (%eax),%al
  8010f7:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010f9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ff:	01 c2                	add    %eax,%edx
  801101:	8a 45 eb             	mov    -0x15(%ebp),%al
  801104:	88 02                	mov    %al,(%edx)
		start++ ;
  801106:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801109:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80110c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80110f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801112:	7c c4                	jl     8010d8 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801114:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801117:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111a:	01 d0                	add    %edx,%eax
  80111c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80111f:	90                   	nop
  801120:	c9                   	leave  
  801121:	c3                   	ret    

00801122 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801122:	55                   	push   %ebp
  801123:	89 e5                	mov    %esp,%ebp
  801125:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801128:	ff 75 08             	pushl  0x8(%ebp)
  80112b:	e8 54 fa ff ff       	call   800b84 <strlen>
  801130:	83 c4 04             	add    $0x4,%esp
  801133:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801136:	ff 75 0c             	pushl  0xc(%ebp)
  801139:	e8 46 fa ff ff       	call   800b84 <strlen>
  80113e:	83 c4 04             	add    $0x4,%esp
  801141:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801144:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80114b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801152:	eb 17                	jmp    80116b <strcconcat+0x49>
		final[s] = str1[s] ;
  801154:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801157:	8b 45 10             	mov    0x10(%ebp),%eax
  80115a:	01 c2                	add    %eax,%edx
  80115c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80115f:	8b 45 08             	mov    0x8(%ebp),%eax
  801162:	01 c8                	add    %ecx,%eax
  801164:	8a 00                	mov    (%eax),%al
  801166:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801168:	ff 45 fc             	incl   -0x4(%ebp)
  80116b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80116e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801171:	7c e1                	jl     801154 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801173:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80117a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801181:	eb 1f                	jmp    8011a2 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801183:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801186:	8d 50 01             	lea    0x1(%eax),%edx
  801189:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80118c:	89 c2                	mov    %eax,%edx
  80118e:	8b 45 10             	mov    0x10(%ebp),%eax
  801191:	01 c2                	add    %eax,%edx
  801193:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801196:	8b 45 0c             	mov    0xc(%ebp),%eax
  801199:	01 c8                	add    %ecx,%eax
  80119b:	8a 00                	mov    (%eax),%al
  80119d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80119f:	ff 45 f8             	incl   -0x8(%ebp)
  8011a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011a8:	7c d9                	jl     801183 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b0:	01 d0                	add    %edx,%eax
  8011b2:	c6 00 00             	movb   $0x0,(%eax)
}
  8011b5:	90                   	nop
  8011b6:	c9                   	leave  
  8011b7:	c3                   	ret    

008011b8 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011b8:	55                   	push   %ebp
  8011b9:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8011be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c7:	8b 00                	mov    (%eax),%eax
  8011c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d3:	01 d0                	add    %edx,%eax
  8011d5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011db:	eb 0c                	jmp    8011e9 <strsplit+0x31>
			*string++ = 0;
  8011dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e0:	8d 50 01             	lea    0x1(%eax),%edx
  8011e3:	89 55 08             	mov    %edx,0x8(%ebp)
  8011e6:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	8a 00                	mov    (%eax),%al
  8011ee:	84 c0                	test   %al,%al
  8011f0:	74 18                	je     80120a <strsplit+0x52>
  8011f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f5:	8a 00                	mov    (%eax),%al
  8011f7:	0f be c0             	movsbl %al,%eax
  8011fa:	50                   	push   %eax
  8011fb:	ff 75 0c             	pushl  0xc(%ebp)
  8011fe:	e8 13 fb ff ff       	call   800d16 <strchr>
  801203:	83 c4 08             	add    $0x8,%esp
  801206:	85 c0                	test   %eax,%eax
  801208:	75 d3                	jne    8011dd <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80120a:	8b 45 08             	mov    0x8(%ebp),%eax
  80120d:	8a 00                	mov    (%eax),%al
  80120f:	84 c0                	test   %al,%al
  801211:	74 5a                	je     80126d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801213:	8b 45 14             	mov    0x14(%ebp),%eax
  801216:	8b 00                	mov    (%eax),%eax
  801218:	83 f8 0f             	cmp    $0xf,%eax
  80121b:	75 07                	jne    801224 <strsplit+0x6c>
		{
			return 0;
  80121d:	b8 00 00 00 00       	mov    $0x0,%eax
  801222:	eb 66                	jmp    80128a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801224:	8b 45 14             	mov    0x14(%ebp),%eax
  801227:	8b 00                	mov    (%eax),%eax
  801229:	8d 48 01             	lea    0x1(%eax),%ecx
  80122c:	8b 55 14             	mov    0x14(%ebp),%edx
  80122f:	89 0a                	mov    %ecx,(%edx)
  801231:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801238:	8b 45 10             	mov    0x10(%ebp),%eax
  80123b:	01 c2                	add    %eax,%edx
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801242:	eb 03                	jmp    801247 <strsplit+0x8f>
			string++;
  801244:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801247:	8b 45 08             	mov    0x8(%ebp),%eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	84 c0                	test   %al,%al
  80124e:	74 8b                	je     8011db <strsplit+0x23>
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	8a 00                	mov    (%eax),%al
  801255:	0f be c0             	movsbl %al,%eax
  801258:	50                   	push   %eax
  801259:	ff 75 0c             	pushl  0xc(%ebp)
  80125c:	e8 b5 fa ff ff       	call   800d16 <strchr>
  801261:	83 c4 08             	add    $0x8,%esp
  801264:	85 c0                	test   %eax,%eax
  801266:	74 dc                	je     801244 <strsplit+0x8c>
			string++;
	}
  801268:	e9 6e ff ff ff       	jmp    8011db <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80126d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80126e:	8b 45 14             	mov    0x14(%ebp),%eax
  801271:	8b 00                	mov    (%eax),%eax
  801273:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80127a:	8b 45 10             	mov    0x10(%ebp),%eax
  80127d:	01 d0                	add    %edx,%eax
  80127f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801285:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80128a:	c9                   	leave  
  80128b:	c3                   	ret    

0080128c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80128c:	55                   	push   %ebp
  80128d:	89 e5                	mov    %esp,%ebp
  80128f:	57                   	push   %edi
  801290:	56                   	push   %esi
  801291:	53                   	push   %ebx
  801292:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801295:	8b 45 08             	mov    0x8(%ebp),%eax
  801298:	8b 55 0c             	mov    0xc(%ebp),%edx
  80129b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80129e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012a1:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012a4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012a7:	cd 30                	int    $0x30
  8012a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012af:	83 c4 10             	add    $0x10,%esp
  8012b2:	5b                   	pop    %ebx
  8012b3:	5e                   	pop    %esi
  8012b4:	5f                   	pop    %edi
  8012b5:	5d                   	pop    %ebp
  8012b6:	c3                   	ret    

008012b7 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012b7:	55                   	push   %ebp
  8012b8:	89 e5                	mov    %esp,%ebp
  8012ba:	83 ec 04             	sub    $0x4,%esp
  8012bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012c3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ca:	6a 00                	push   $0x0
  8012cc:	6a 00                	push   $0x0
  8012ce:	52                   	push   %edx
  8012cf:	ff 75 0c             	pushl  0xc(%ebp)
  8012d2:	50                   	push   %eax
  8012d3:	6a 00                	push   $0x0
  8012d5:	e8 b2 ff ff ff       	call   80128c <syscall>
  8012da:	83 c4 18             	add    $0x18,%esp
}
  8012dd:	90                   	nop
  8012de:	c9                   	leave  
  8012df:	c3                   	ret    

008012e0 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 01                	push   $0x1
  8012ef:	e8 98 ff ff ff       	call   80128c <syscall>
  8012f4:	83 c4 18             	add    $0x18,%esp
}
  8012f7:	c9                   	leave  
  8012f8:	c3                   	ret    

008012f9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012f9:	55                   	push   %ebp
  8012fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	50                   	push   %eax
  801308:	6a 05                	push   $0x5
  80130a:	e8 7d ff ff ff       	call   80128c <syscall>
  80130f:	83 c4 18             	add    $0x18,%esp
}
  801312:	c9                   	leave  
  801313:	c3                   	ret    

00801314 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801314:	55                   	push   %ebp
  801315:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 02                	push   $0x2
  801323:	e8 64 ff ff ff       	call   80128c <syscall>
  801328:	83 c4 18             	add    $0x18,%esp
}
  80132b:	c9                   	leave  
  80132c:	c3                   	ret    

0080132d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80132d:	55                   	push   %ebp
  80132e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	6a 00                	push   $0x0
  801338:	6a 00                	push   $0x0
  80133a:	6a 03                	push   $0x3
  80133c:	e8 4b ff ff ff       	call   80128c <syscall>
  801341:	83 c4 18             	add    $0x18,%esp
}
  801344:	c9                   	leave  
  801345:	c3                   	ret    

00801346 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801346:	55                   	push   %ebp
  801347:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801349:	6a 00                	push   $0x0
  80134b:	6a 00                	push   $0x0
  80134d:	6a 00                	push   $0x0
  80134f:	6a 00                	push   $0x0
  801351:	6a 00                	push   $0x0
  801353:	6a 04                	push   $0x4
  801355:	e8 32 ff ff ff       	call   80128c <syscall>
  80135a:	83 c4 18             	add    $0x18,%esp
}
  80135d:	c9                   	leave  
  80135e:	c3                   	ret    

0080135f <sys_env_exit>:


void sys_env_exit(void)
{
  80135f:	55                   	push   %ebp
  801360:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	6a 00                	push   $0x0
  80136c:	6a 06                	push   $0x6
  80136e:	e8 19 ff ff ff       	call   80128c <syscall>
  801373:	83 c4 18             	add    $0x18,%esp
}
  801376:	90                   	nop
  801377:	c9                   	leave  
  801378:	c3                   	ret    

00801379 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801379:	55                   	push   %ebp
  80137a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80137c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	6a 00                	push   $0x0
  801388:	52                   	push   %edx
  801389:	50                   	push   %eax
  80138a:	6a 07                	push   $0x7
  80138c:	e8 fb fe ff ff       	call   80128c <syscall>
  801391:	83 c4 18             	add    $0x18,%esp
}
  801394:	c9                   	leave  
  801395:	c3                   	ret    

00801396 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801396:	55                   	push   %ebp
  801397:	89 e5                	mov    %esp,%ebp
  801399:	56                   	push   %esi
  80139a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80139b:	8b 75 18             	mov    0x18(%ebp),%esi
  80139e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013a1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	56                   	push   %esi
  8013ab:	53                   	push   %ebx
  8013ac:	51                   	push   %ecx
  8013ad:	52                   	push   %edx
  8013ae:	50                   	push   %eax
  8013af:	6a 08                	push   $0x8
  8013b1:	e8 d6 fe ff ff       	call   80128c <syscall>
  8013b6:	83 c4 18             	add    $0x18,%esp
}
  8013b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013bc:	5b                   	pop    %ebx
  8013bd:	5e                   	pop    %esi
  8013be:	5d                   	pop    %ebp
  8013bf:	c3                   	ret    

008013c0 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013c0:	55                   	push   %ebp
  8013c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	52                   	push   %edx
  8013d0:	50                   	push   %eax
  8013d1:	6a 09                	push   $0x9
  8013d3:	e8 b4 fe ff ff       	call   80128c <syscall>
  8013d8:	83 c4 18             	add    $0x18,%esp
}
  8013db:	c9                   	leave  
  8013dc:	c3                   	ret    

008013dd <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013dd:	55                   	push   %ebp
  8013de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	ff 75 0c             	pushl  0xc(%ebp)
  8013e9:	ff 75 08             	pushl  0x8(%ebp)
  8013ec:	6a 0a                	push   $0xa
  8013ee:	e8 99 fe ff ff       	call   80128c <syscall>
  8013f3:	83 c4 18             	add    $0x18,%esp
}
  8013f6:	c9                   	leave  
  8013f7:	c3                   	ret    

008013f8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013f8:	55                   	push   %ebp
  8013f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 0b                	push   $0xb
  801407:	e8 80 fe ff ff       	call   80128c <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
}
  80140f:	c9                   	leave  
  801410:	c3                   	ret    

00801411 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801411:	55                   	push   %ebp
  801412:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	6a 00                	push   $0x0
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 0c                	push   $0xc
  801420:	e8 67 fe ff ff       	call   80128c <syscall>
  801425:	83 c4 18             	add    $0x18,%esp
}
  801428:	c9                   	leave  
  801429:	c3                   	ret    

0080142a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80142a:	55                   	push   %ebp
  80142b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80142d:	6a 00                	push   $0x0
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 0d                	push   $0xd
  801439:	e8 4e fe ff ff       	call   80128c <syscall>
  80143e:	83 c4 18             	add    $0x18,%esp
}
  801441:	c9                   	leave  
  801442:	c3                   	ret    

00801443 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801443:	55                   	push   %ebp
  801444:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	ff 75 0c             	pushl  0xc(%ebp)
  80144f:	ff 75 08             	pushl  0x8(%ebp)
  801452:	6a 11                	push   $0x11
  801454:	e8 33 fe ff ff       	call   80128c <syscall>
  801459:	83 c4 18             	add    $0x18,%esp
	return;
  80145c:	90                   	nop
}
  80145d:	c9                   	leave  
  80145e:	c3                   	ret    

0080145f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80145f:	55                   	push   %ebp
  801460:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	ff 75 0c             	pushl  0xc(%ebp)
  80146b:	ff 75 08             	pushl  0x8(%ebp)
  80146e:	6a 12                	push   $0x12
  801470:	e8 17 fe ff ff       	call   80128c <syscall>
  801475:	83 c4 18             	add    $0x18,%esp
	return ;
  801478:	90                   	nop
}
  801479:	c9                   	leave  
  80147a:	c3                   	ret    

0080147b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80147b:	55                   	push   %ebp
  80147c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 0e                	push   $0xe
  80148a:	e8 fd fd ff ff       	call   80128c <syscall>
  80148f:	83 c4 18             	add    $0x18,%esp
}
  801492:	c9                   	leave  
  801493:	c3                   	ret    

00801494 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	ff 75 08             	pushl  0x8(%ebp)
  8014a2:	6a 0f                	push   $0xf
  8014a4:	e8 e3 fd ff ff       	call   80128c <syscall>
  8014a9:	83 c4 18             	add    $0x18,%esp
}
  8014ac:	c9                   	leave  
  8014ad:	c3                   	ret    

008014ae <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014ae:	55                   	push   %ebp
  8014af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 10                	push   $0x10
  8014bd:	e8 ca fd ff ff       	call   80128c <syscall>
  8014c2:	83 c4 18             	add    $0x18,%esp
}
  8014c5:	90                   	nop
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 14                	push   $0x14
  8014d7:	e8 b0 fd ff ff       	call   80128c <syscall>
  8014dc:	83 c4 18             	add    $0x18,%esp
}
  8014df:	90                   	nop
  8014e0:	c9                   	leave  
  8014e1:	c3                   	ret    

008014e2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014e2:	55                   	push   %ebp
  8014e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 15                	push   $0x15
  8014f1:	e8 96 fd ff ff       	call   80128c <syscall>
  8014f6:	83 c4 18             	add    $0x18,%esp
}
  8014f9:	90                   	nop
  8014fa:	c9                   	leave  
  8014fb:	c3                   	ret    

008014fc <sys_cputc>:


void
sys_cputc(const char c)
{
  8014fc:	55                   	push   %ebp
  8014fd:	89 e5                	mov    %esp,%ebp
  8014ff:	83 ec 04             	sub    $0x4,%esp
  801502:	8b 45 08             	mov    0x8(%ebp),%eax
  801505:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801508:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	50                   	push   %eax
  801515:	6a 16                	push   $0x16
  801517:	e8 70 fd ff ff       	call   80128c <syscall>
  80151c:	83 c4 18             	add    $0x18,%esp
}
  80151f:	90                   	nop
  801520:	c9                   	leave  
  801521:	c3                   	ret    

00801522 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801522:	55                   	push   %ebp
  801523:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 17                	push   $0x17
  801531:	e8 56 fd ff ff       	call   80128c <syscall>
  801536:	83 c4 18             	add    $0x18,%esp
}
  801539:	90                   	nop
  80153a:	c9                   	leave  
  80153b:	c3                   	ret    

0080153c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80153c:	55                   	push   %ebp
  80153d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	ff 75 0c             	pushl  0xc(%ebp)
  80154b:	50                   	push   %eax
  80154c:	6a 18                	push   $0x18
  80154e:	e8 39 fd ff ff       	call   80128c <syscall>
  801553:	83 c4 18             	add    $0x18,%esp
}
  801556:	c9                   	leave  
  801557:	c3                   	ret    

00801558 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801558:	55                   	push   %ebp
  801559:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80155b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155e:	8b 45 08             	mov    0x8(%ebp),%eax
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	52                   	push   %edx
  801568:	50                   	push   %eax
  801569:	6a 1b                	push   $0x1b
  80156b:	e8 1c fd ff ff       	call   80128c <syscall>
  801570:	83 c4 18             	add    $0x18,%esp
}
  801573:	c9                   	leave  
  801574:	c3                   	ret    

00801575 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801575:	55                   	push   %ebp
  801576:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801578:	8b 55 0c             	mov    0xc(%ebp),%edx
  80157b:	8b 45 08             	mov    0x8(%ebp),%eax
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	52                   	push   %edx
  801585:	50                   	push   %eax
  801586:	6a 19                	push   $0x19
  801588:	e8 ff fc ff ff       	call   80128c <syscall>
  80158d:	83 c4 18             	add    $0x18,%esp
}
  801590:	90                   	nop
  801591:	c9                   	leave  
  801592:	c3                   	ret    

00801593 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801593:	55                   	push   %ebp
  801594:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801596:	8b 55 0c             	mov    0xc(%ebp),%edx
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	52                   	push   %edx
  8015a3:	50                   	push   %eax
  8015a4:	6a 1a                	push   $0x1a
  8015a6:	e8 e1 fc ff ff       	call   80128c <syscall>
  8015ab:	83 c4 18             	add    $0x18,%esp
}
  8015ae:	90                   	nop
  8015af:	c9                   	leave  
  8015b0:	c3                   	ret    

008015b1 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015b1:	55                   	push   %ebp
  8015b2:	89 e5                	mov    %esp,%ebp
  8015b4:	83 ec 04             	sub    $0x4,%esp
  8015b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015bd:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015c0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c7:	6a 00                	push   $0x0
  8015c9:	51                   	push   %ecx
  8015ca:	52                   	push   %edx
  8015cb:	ff 75 0c             	pushl  0xc(%ebp)
  8015ce:	50                   	push   %eax
  8015cf:	6a 1c                	push   $0x1c
  8015d1:	e8 b6 fc ff ff       	call   80128c <syscall>
  8015d6:	83 c4 18             	add    $0x18,%esp
}
  8015d9:	c9                   	leave  
  8015da:	c3                   	ret    

008015db <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015db:	55                   	push   %ebp
  8015dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	52                   	push   %edx
  8015eb:	50                   	push   %eax
  8015ec:	6a 1d                	push   $0x1d
  8015ee:	e8 99 fc ff ff       	call   80128c <syscall>
  8015f3:	83 c4 18             	add    $0x18,%esp
}
  8015f6:	c9                   	leave  
  8015f7:	c3                   	ret    

008015f8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015f8:	55                   	push   %ebp
  8015f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801601:	8b 45 08             	mov    0x8(%ebp),%eax
  801604:	6a 00                	push   $0x0
  801606:	6a 00                	push   $0x0
  801608:	51                   	push   %ecx
  801609:	52                   	push   %edx
  80160a:	50                   	push   %eax
  80160b:	6a 1e                	push   $0x1e
  80160d:	e8 7a fc ff ff       	call   80128c <syscall>
  801612:	83 c4 18             	add    $0x18,%esp
}
  801615:	c9                   	leave  
  801616:	c3                   	ret    

00801617 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801617:	55                   	push   %ebp
  801618:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80161a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80161d:	8b 45 08             	mov    0x8(%ebp),%eax
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	52                   	push   %edx
  801627:	50                   	push   %eax
  801628:	6a 1f                	push   $0x1f
  80162a:	e8 5d fc ff ff       	call   80128c <syscall>
  80162f:	83 c4 18             	add    $0x18,%esp
}
  801632:	c9                   	leave  
  801633:	c3                   	ret    

00801634 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 20                	push   $0x20
  801643:	e8 44 fc ff ff       	call   80128c <syscall>
  801648:	83 c4 18             	add    $0x18,%esp
}
  80164b:	c9                   	leave  
  80164c:	c3                   	ret    

0080164d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80164d:	55                   	push   %ebp
  80164e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	6a 00                	push   $0x0
  801655:	ff 75 14             	pushl  0x14(%ebp)
  801658:	ff 75 10             	pushl  0x10(%ebp)
  80165b:	ff 75 0c             	pushl  0xc(%ebp)
  80165e:	50                   	push   %eax
  80165f:	6a 21                	push   $0x21
  801661:	e8 26 fc ff ff       	call   80128c <syscall>
  801666:	83 c4 18             	add    $0x18,%esp
}
  801669:	c9                   	leave  
  80166a:	c3                   	ret    

0080166b <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80166b:	55                   	push   %ebp
  80166c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	50                   	push   %eax
  80167a:	6a 22                	push   $0x22
  80167c:	e8 0b fc ff ff       	call   80128c <syscall>
  801681:	83 c4 18             	add    $0x18,%esp
}
  801684:	90                   	nop
  801685:	c9                   	leave  
  801686:	c3                   	ret    

00801687 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801687:	55                   	push   %ebp
  801688:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80168a:	8b 45 08             	mov    0x8(%ebp),%eax
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	50                   	push   %eax
  801696:	6a 23                	push   $0x23
  801698:	e8 ef fb ff ff       	call   80128c <syscall>
  80169d:	83 c4 18             	add    $0x18,%esp
}
  8016a0:	90                   	nop
  8016a1:	c9                   	leave  
  8016a2:	c3                   	ret    

008016a3 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016a3:	55                   	push   %ebp
  8016a4:	89 e5                	mov    %esp,%ebp
  8016a6:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016a9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016ac:	8d 50 04             	lea    0x4(%eax),%edx
  8016af:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	52                   	push   %edx
  8016b9:	50                   	push   %eax
  8016ba:	6a 24                	push   $0x24
  8016bc:	e8 cb fb ff ff       	call   80128c <syscall>
  8016c1:	83 c4 18             	add    $0x18,%esp
	return result;
  8016c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016cd:	89 01                	mov    %eax,(%ecx)
  8016cf:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d5:	c9                   	leave  
  8016d6:	c2 04 00             	ret    $0x4

008016d9 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	ff 75 10             	pushl  0x10(%ebp)
  8016e3:	ff 75 0c             	pushl  0xc(%ebp)
  8016e6:	ff 75 08             	pushl  0x8(%ebp)
  8016e9:	6a 13                	push   $0x13
  8016eb:	e8 9c fb ff ff       	call   80128c <syscall>
  8016f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f3:	90                   	nop
}
  8016f4:	c9                   	leave  
  8016f5:	c3                   	ret    

008016f6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016f6:	55                   	push   %ebp
  8016f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 25                	push   $0x25
  801705:	e8 82 fb ff ff       	call   80128c <syscall>
  80170a:	83 c4 18             	add    $0x18,%esp
}
  80170d:	c9                   	leave  
  80170e:	c3                   	ret    

0080170f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80170f:	55                   	push   %ebp
  801710:	89 e5                	mov    %esp,%ebp
  801712:	83 ec 04             	sub    $0x4,%esp
  801715:	8b 45 08             	mov    0x8(%ebp),%eax
  801718:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80171b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	50                   	push   %eax
  801728:	6a 26                	push   $0x26
  80172a:	e8 5d fb ff ff       	call   80128c <syscall>
  80172f:	83 c4 18             	add    $0x18,%esp
	return ;
  801732:	90                   	nop
}
  801733:	c9                   	leave  
  801734:	c3                   	ret    

00801735 <rsttst>:
void rsttst()
{
  801735:	55                   	push   %ebp
  801736:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 28                	push   $0x28
  801744:	e8 43 fb ff ff       	call   80128c <syscall>
  801749:	83 c4 18             	add    $0x18,%esp
	return ;
  80174c:	90                   	nop
}
  80174d:	c9                   	leave  
  80174e:	c3                   	ret    

0080174f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80174f:	55                   	push   %ebp
  801750:	89 e5                	mov    %esp,%ebp
  801752:	83 ec 04             	sub    $0x4,%esp
  801755:	8b 45 14             	mov    0x14(%ebp),%eax
  801758:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80175b:	8b 55 18             	mov    0x18(%ebp),%edx
  80175e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801762:	52                   	push   %edx
  801763:	50                   	push   %eax
  801764:	ff 75 10             	pushl  0x10(%ebp)
  801767:	ff 75 0c             	pushl  0xc(%ebp)
  80176a:	ff 75 08             	pushl  0x8(%ebp)
  80176d:	6a 27                	push   $0x27
  80176f:	e8 18 fb ff ff       	call   80128c <syscall>
  801774:	83 c4 18             	add    $0x18,%esp
	return ;
  801777:	90                   	nop
}
  801778:	c9                   	leave  
  801779:	c3                   	ret    

0080177a <chktst>:
void chktst(uint32 n)
{
  80177a:	55                   	push   %ebp
  80177b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	ff 75 08             	pushl  0x8(%ebp)
  801788:	6a 29                	push   $0x29
  80178a:	e8 fd fa ff ff       	call   80128c <syscall>
  80178f:	83 c4 18             	add    $0x18,%esp
	return ;
  801792:	90                   	nop
}
  801793:	c9                   	leave  
  801794:	c3                   	ret    

00801795 <inctst>:

void inctst()
{
  801795:	55                   	push   %ebp
  801796:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 2a                	push   $0x2a
  8017a4:	e8 e3 fa ff ff       	call   80128c <syscall>
  8017a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ac:	90                   	nop
}
  8017ad:	c9                   	leave  
  8017ae:	c3                   	ret    

008017af <gettst>:
uint32 gettst()
{
  8017af:	55                   	push   %ebp
  8017b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 2b                	push   $0x2b
  8017be:	e8 c9 fa ff ff       	call   80128c <syscall>
  8017c3:	83 c4 18             	add    $0x18,%esp
}
  8017c6:	c9                   	leave  
  8017c7:	c3                   	ret    

008017c8 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017c8:	55                   	push   %ebp
  8017c9:	89 e5                	mov    %esp,%ebp
  8017cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 2c                	push   $0x2c
  8017da:	e8 ad fa ff ff       	call   80128c <syscall>
  8017df:	83 c4 18             	add    $0x18,%esp
  8017e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017e5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017e9:	75 07                	jne    8017f2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f0:	eb 05                	jmp    8017f7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f7:	c9                   	leave  
  8017f8:	c3                   	ret    

008017f9 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017f9:	55                   	push   %ebp
  8017fa:	89 e5                	mov    %esp,%ebp
  8017fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 2c                	push   $0x2c
  80180b:	e8 7c fa ff ff       	call   80128c <syscall>
  801810:	83 c4 18             	add    $0x18,%esp
  801813:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801816:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80181a:	75 07                	jne    801823 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80181c:	b8 01 00 00 00       	mov    $0x1,%eax
  801821:	eb 05                	jmp    801828 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801823:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801828:	c9                   	leave  
  801829:	c3                   	ret    

0080182a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80182a:	55                   	push   %ebp
  80182b:	89 e5                	mov    %esp,%ebp
  80182d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 2c                	push   $0x2c
  80183c:	e8 4b fa ff ff       	call   80128c <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
  801844:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801847:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80184b:	75 07                	jne    801854 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80184d:	b8 01 00 00 00       	mov    $0x1,%eax
  801852:	eb 05                	jmp    801859 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801854:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801859:	c9                   	leave  
  80185a:	c3                   	ret    

0080185b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80185b:	55                   	push   %ebp
  80185c:	89 e5                	mov    %esp,%ebp
  80185e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 2c                	push   $0x2c
  80186d:	e8 1a fa ff ff       	call   80128c <syscall>
  801872:	83 c4 18             	add    $0x18,%esp
  801875:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801878:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80187c:	75 07                	jne    801885 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80187e:	b8 01 00 00 00       	mov    $0x1,%eax
  801883:	eb 05                	jmp    80188a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801885:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80188a:	c9                   	leave  
  80188b:	c3                   	ret    

0080188c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80188c:	55                   	push   %ebp
  80188d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	ff 75 08             	pushl  0x8(%ebp)
  80189a:	6a 2d                	push   $0x2d
  80189c:	e8 eb f9 ff ff       	call   80128c <syscall>
  8018a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8018a4:	90                   	nop
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
  8018aa:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018ab:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018ae:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b7:	6a 00                	push   $0x0
  8018b9:	53                   	push   %ebx
  8018ba:	51                   	push   %ecx
  8018bb:	52                   	push   %edx
  8018bc:	50                   	push   %eax
  8018bd:	6a 2e                	push   $0x2e
  8018bf:	e8 c8 f9 ff ff       	call   80128c <syscall>
  8018c4:	83 c4 18             	add    $0x18,%esp
}
  8018c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018ca:	c9                   	leave  
  8018cb:	c3                   	ret    

008018cc <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018cc:	55                   	push   %ebp
  8018cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	52                   	push   %edx
  8018dc:	50                   	push   %eax
  8018dd:	6a 2f                	push   $0x2f
  8018df:	e8 a8 f9 ff ff       	call   80128c <syscall>
  8018e4:	83 c4 18             	add    $0x18,%esp
}
  8018e7:	c9                   	leave  
  8018e8:	c3                   	ret    

008018e9 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8018e9:	55                   	push   %ebp
  8018ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	ff 75 0c             	pushl  0xc(%ebp)
  8018f5:	ff 75 08             	pushl  0x8(%ebp)
  8018f8:	6a 30                	push   $0x30
  8018fa:	e8 8d f9 ff ff       	call   80128c <syscall>
  8018ff:	83 c4 18             	add    $0x18,%esp
	return ;
  801902:	90                   	nop
}
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
  801908:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80190b:	8b 55 08             	mov    0x8(%ebp),%edx
  80190e:	89 d0                	mov    %edx,%eax
  801910:	c1 e0 02             	shl    $0x2,%eax
  801913:	01 d0                	add    %edx,%eax
  801915:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80191c:	01 d0                	add    %edx,%eax
  80191e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801925:	01 d0                	add    %edx,%eax
  801927:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80192e:	01 d0                	add    %edx,%eax
  801930:	c1 e0 04             	shl    $0x4,%eax
  801933:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801936:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80193d:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801940:	83 ec 0c             	sub    $0xc,%esp
  801943:	50                   	push   %eax
  801944:	e8 5a fd ff ff       	call   8016a3 <sys_get_virtual_time>
  801949:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  80194c:	eb 41                	jmp    80198f <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80194e:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801951:	83 ec 0c             	sub    $0xc,%esp
  801954:	50                   	push   %eax
  801955:	e8 49 fd ff ff       	call   8016a3 <sys_get_virtual_time>
  80195a:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80195d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801960:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801963:	29 c2                	sub    %eax,%edx
  801965:	89 d0                	mov    %edx,%eax
  801967:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  80196a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80196d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801970:	89 d1                	mov    %edx,%ecx
  801972:	29 c1                	sub    %eax,%ecx
  801974:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801977:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80197a:	39 c2                	cmp    %eax,%edx
  80197c:	0f 97 c0             	seta   %al
  80197f:	0f b6 c0             	movzbl %al,%eax
  801982:	29 c1                	sub    %eax,%ecx
  801984:	89 c8                	mov    %ecx,%eax
  801986:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801989:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80198c:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80198f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801992:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801995:	72 b7                	jb     80194e <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801997:	90                   	nop
  801998:	c9                   	leave  
  801999:	c3                   	ret    

0080199a <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  80199a:	55                   	push   %ebp
  80199b:	89 e5                	mov    %esp,%ebp
  80199d:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  8019a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  8019a7:	eb 03                	jmp    8019ac <busy_wait+0x12>
  8019a9:	ff 45 fc             	incl   -0x4(%ebp)
  8019ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019af:	3b 45 08             	cmp    0x8(%ebp),%eax
  8019b2:	72 f5                	jb     8019a9 <busy_wait+0xf>
	return i;
  8019b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8019b7:	c9                   	leave  
  8019b8:	c3                   	ret    
  8019b9:	66 90                	xchg   %ax,%ax
  8019bb:	90                   	nop

008019bc <__udivdi3>:
  8019bc:	55                   	push   %ebp
  8019bd:	57                   	push   %edi
  8019be:	56                   	push   %esi
  8019bf:	53                   	push   %ebx
  8019c0:	83 ec 1c             	sub    $0x1c,%esp
  8019c3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019c7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019cb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019cf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019d3:	89 ca                	mov    %ecx,%edx
  8019d5:	89 f8                	mov    %edi,%eax
  8019d7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019db:	85 f6                	test   %esi,%esi
  8019dd:	75 2d                	jne    801a0c <__udivdi3+0x50>
  8019df:	39 cf                	cmp    %ecx,%edi
  8019e1:	77 65                	ja     801a48 <__udivdi3+0x8c>
  8019e3:	89 fd                	mov    %edi,%ebp
  8019e5:	85 ff                	test   %edi,%edi
  8019e7:	75 0b                	jne    8019f4 <__udivdi3+0x38>
  8019e9:	b8 01 00 00 00       	mov    $0x1,%eax
  8019ee:	31 d2                	xor    %edx,%edx
  8019f0:	f7 f7                	div    %edi
  8019f2:	89 c5                	mov    %eax,%ebp
  8019f4:	31 d2                	xor    %edx,%edx
  8019f6:	89 c8                	mov    %ecx,%eax
  8019f8:	f7 f5                	div    %ebp
  8019fa:	89 c1                	mov    %eax,%ecx
  8019fc:	89 d8                	mov    %ebx,%eax
  8019fe:	f7 f5                	div    %ebp
  801a00:	89 cf                	mov    %ecx,%edi
  801a02:	89 fa                	mov    %edi,%edx
  801a04:	83 c4 1c             	add    $0x1c,%esp
  801a07:	5b                   	pop    %ebx
  801a08:	5e                   	pop    %esi
  801a09:	5f                   	pop    %edi
  801a0a:	5d                   	pop    %ebp
  801a0b:	c3                   	ret    
  801a0c:	39 ce                	cmp    %ecx,%esi
  801a0e:	77 28                	ja     801a38 <__udivdi3+0x7c>
  801a10:	0f bd fe             	bsr    %esi,%edi
  801a13:	83 f7 1f             	xor    $0x1f,%edi
  801a16:	75 40                	jne    801a58 <__udivdi3+0x9c>
  801a18:	39 ce                	cmp    %ecx,%esi
  801a1a:	72 0a                	jb     801a26 <__udivdi3+0x6a>
  801a1c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a20:	0f 87 9e 00 00 00    	ja     801ac4 <__udivdi3+0x108>
  801a26:	b8 01 00 00 00       	mov    $0x1,%eax
  801a2b:	89 fa                	mov    %edi,%edx
  801a2d:	83 c4 1c             	add    $0x1c,%esp
  801a30:	5b                   	pop    %ebx
  801a31:	5e                   	pop    %esi
  801a32:	5f                   	pop    %edi
  801a33:	5d                   	pop    %ebp
  801a34:	c3                   	ret    
  801a35:	8d 76 00             	lea    0x0(%esi),%esi
  801a38:	31 ff                	xor    %edi,%edi
  801a3a:	31 c0                	xor    %eax,%eax
  801a3c:	89 fa                	mov    %edi,%edx
  801a3e:	83 c4 1c             	add    $0x1c,%esp
  801a41:	5b                   	pop    %ebx
  801a42:	5e                   	pop    %esi
  801a43:	5f                   	pop    %edi
  801a44:	5d                   	pop    %ebp
  801a45:	c3                   	ret    
  801a46:	66 90                	xchg   %ax,%ax
  801a48:	89 d8                	mov    %ebx,%eax
  801a4a:	f7 f7                	div    %edi
  801a4c:	31 ff                	xor    %edi,%edi
  801a4e:	89 fa                	mov    %edi,%edx
  801a50:	83 c4 1c             	add    $0x1c,%esp
  801a53:	5b                   	pop    %ebx
  801a54:	5e                   	pop    %esi
  801a55:	5f                   	pop    %edi
  801a56:	5d                   	pop    %ebp
  801a57:	c3                   	ret    
  801a58:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a5d:	89 eb                	mov    %ebp,%ebx
  801a5f:	29 fb                	sub    %edi,%ebx
  801a61:	89 f9                	mov    %edi,%ecx
  801a63:	d3 e6                	shl    %cl,%esi
  801a65:	89 c5                	mov    %eax,%ebp
  801a67:	88 d9                	mov    %bl,%cl
  801a69:	d3 ed                	shr    %cl,%ebp
  801a6b:	89 e9                	mov    %ebp,%ecx
  801a6d:	09 f1                	or     %esi,%ecx
  801a6f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a73:	89 f9                	mov    %edi,%ecx
  801a75:	d3 e0                	shl    %cl,%eax
  801a77:	89 c5                	mov    %eax,%ebp
  801a79:	89 d6                	mov    %edx,%esi
  801a7b:	88 d9                	mov    %bl,%cl
  801a7d:	d3 ee                	shr    %cl,%esi
  801a7f:	89 f9                	mov    %edi,%ecx
  801a81:	d3 e2                	shl    %cl,%edx
  801a83:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a87:	88 d9                	mov    %bl,%cl
  801a89:	d3 e8                	shr    %cl,%eax
  801a8b:	09 c2                	or     %eax,%edx
  801a8d:	89 d0                	mov    %edx,%eax
  801a8f:	89 f2                	mov    %esi,%edx
  801a91:	f7 74 24 0c          	divl   0xc(%esp)
  801a95:	89 d6                	mov    %edx,%esi
  801a97:	89 c3                	mov    %eax,%ebx
  801a99:	f7 e5                	mul    %ebp
  801a9b:	39 d6                	cmp    %edx,%esi
  801a9d:	72 19                	jb     801ab8 <__udivdi3+0xfc>
  801a9f:	74 0b                	je     801aac <__udivdi3+0xf0>
  801aa1:	89 d8                	mov    %ebx,%eax
  801aa3:	31 ff                	xor    %edi,%edi
  801aa5:	e9 58 ff ff ff       	jmp    801a02 <__udivdi3+0x46>
  801aaa:	66 90                	xchg   %ax,%ax
  801aac:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ab0:	89 f9                	mov    %edi,%ecx
  801ab2:	d3 e2                	shl    %cl,%edx
  801ab4:	39 c2                	cmp    %eax,%edx
  801ab6:	73 e9                	jae    801aa1 <__udivdi3+0xe5>
  801ab8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801abb:	31 ff                	xor    %edi,%edi
  801abd:	e9 40 ff ff ff       	jmp    801a02 <__udivdi3+0x46>
  801ac2:	66 90                	xchg   %ax,%ax
  801ac4:	31 c0                	xor    %eax,%eax
  801ac6:	e9 37 ff ff ff       	jmp    801a02 <__udivdi3+0x46>
  801acb:	90                   	nop

00801acc <__umoddi3>:
  801acc:	55                   	push   %ebp
  801acd:	57                   	push   %edi
  801ace:	56                   	push   %esi
  801acf:	53                   	push   %ebx
  801ad0:	83 ec 1c             	sub    $0x1c,%esp
  801ad3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ad7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801adb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801adf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ae3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ae7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801aeb:	89 f3                	mov    %esi,%ebx
  801aed:	89 fa                	mov    %edi,%edx
  801aef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801af3:	89 34 24             	mov    %esi,(%esp)
  801af6:	85 c0                	test   %eax,%eax
  801af8:	75 1a                	jne    801b14 <__umoddi3+0x48>
  801afa:	39 f7                	cmp    %esi,%edi
  801afc:	0f 86 a2 00 00 00    	jbe    801ba4 <__umoddi3+0xd8>
  801b02:	89 c8                	mov    %ecx,%eax
  801b04:	89 f2                	mov    %esi,%edx
  801b06:	f7 f7                	div    %edi
  801b08:	89 d0                	mov    %edx,%eax
  801b0a:	31 d2                	xor    %edx,%edx
  801b0c:	83 c4 1c             	add    $0x1c,%esp
  801b0f:	5b                   	pop    %ebx
  801b10:	5e                   	pop    %esi
  801b11:	5f                   	pop    %edi
  801b12:	5d                   	pop    %ebp
  801b13:	c3                   	ret    
  801b14:	39 f0                	cmp    %esi,%eax
  801b16:	0f 87 ac 00 00 00    	ja     801bc8 <__umoddi3+0xfc>
  801b1c:	0f bd e8             	bsr    %eax,%ebp
  801b1f:	83 f5 1f             	xor    $0x1f,%ebp
  801b22:	0f 84 ac 00 00 00    	je     801bd4 <__umoddi3+0x108>
  801b28:	bf 20 00 00 00       	mov    $0x20,%edi
  801b2d:	29 ef                	sub    %ebp,%edi
  801b2f:	89 fe                	mov    %edi,%esi
  801b31:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b35:	89 e9                	mov    %ebp,%ecx
  801b37:	d3 e0                	shl    %cl,%eax
  801b39:	89 d7                	mov    %edx,%edi
  801b3b:	89 f1                	mov    %esi,%ecx
  801b3d:	d3 ef                	shr    %cl,%edi
  801b3f:	09 c7                	or     %eax,%edi
  801b41:	89 e9                	mov    %ebp,%ecx
  801b43:	d3 e2                	shl    %cl,%edx
  801b45:	89 14 24             	mov    %edx,(%esp)
  801b48:	89 d8                	mov    %ebx,%eax
  801b4a:	d3 e0                	shl    %cl,%eax
  801b4c:	89 c2                	mov    %eax,%edx
  801b4e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b52:	d3 e0                	shl    %cl,%eax
  801b54:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b58:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b5c:	89 f1                	mov    %esi,%ecx
  801b5e:	d3 e8                	shr    %cl,%eax
  801b60:	09 d0                	or     %edx,%eax
  801b62:	d3 eb                	shr    %cl,%ebx
  801b64:	89 da                	mov    %ebx,%edx
  801b66:	f7 f7                	div    %edi
  801b68:	89 d3                	mov    %edx,%ebx
  801b6a:	f7 24 24             	mull   (%esp)
  801b6d:	89 c6                	mov    %eax,%esi
  801b6f:	89 d1                	mov    %edx,%ecx
  801b71:	39 d3                	cmp    %edx,%ebx
  801b73:	0f 82 87 00 00 00    	jb     801c00 <__umoddi3+0x134>
  801b79:	0f 84 91 00 00 00    	je     801c10 <__umoddi3+0x144>
  801b7f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b83:	29 f2                	sub    %esi,%edx
  801b85:	19 cb                	sbb    %ecx,%ebx
  801b87:	89 d8                	mov    %ebx,%eax
  801b89:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b8d:	d3 e0                	shl    %cl,%eax
  801b8f:	89 e9                	mov    %ebp,%ecx
  801b91:	d3 ea                	shr    %cl,%edx
  801b93:	09 d0                	or     %edx,%eax
  801b95:	89 e9                	mov    %ebp,%ecx
  801b97:	d3 eb                	shr    %cl,%ebx
  801b99:	89 da                	mov    %ebx,%edx
  801b9b:	83 c4 1c             	add    $0x1c,%esp
  801b9e:	5b                   	pop    %ebx
  801b9f:	5e                   	pop    %esi
  801ba0:	5f                   	pop    %edi
  801ba1:	5d                   	pop    %ebp
  801ba2:	c3                   	ret    
  801ba3:	90                   	nop
  801ba4:	89 fd                	mov    %edi,%ebp
  801ba6:	85 ff                	test   %edi,%edi
  801ba8:	75 0b                	jne    801bb5 <__umoddi3+0xe9>
  801baa:	b8 01 00 00 00       	mov    $0x1,%eax
  801baf:	31 d2                	xor    %edx,%edx
  801bb1:	f7 f7                	div    %edi
  801bb3:	89 c5                	mov    %eax,%ebp
  801bb5:	89 f0                	mov    %esi,%eax
  801bb7:	31 d2                	xor    %edx,%edx
  801bb9:	f7 f5                	div    %ebp
  801bbb:	89 c8                	mov    %ecx,%eax
  801bbd:	f7 f5                	div    %ebp
  801bbf:	89 d0                	mov    %edx,%eax
  801bc1:	e9 44 ff ff ff       	jmp    801b0a <__umoddi3+0x3e>
  801bc6:	66 90                	xchg   %ax,%ax
  801bc8:	89 c8                	mov    %ecx,%eax
  801bca:	89 f2                	mov    %esi,%edx
  801bcc:	83 c4 1c             	add    $0x1c,%esp
  801bcf:	5b                   	pop    %ebx
  801bd0:	5e                   	pop    %esi
  801bd1:	5f                   	pop    %edi
  801bd2:	5d                   	pop    %ebp
  801bd3:	c3                   	ret    
  801bd4:	3b 04 24             	cmp    (%esp),%eax
  801bd7:	72 06                	jb     801bdf <__umoddi3+0x113>
  801bd9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801bdd:	77 0f                	ja     801bee <__umoddi3+0x122>
  801bdf:	89 f2                	mov    %esi,%edx
  801be1:	29 f9                	sub    %edi,%ecx
  801be3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801be7:	89 14 24             	mov    %edx,(%esp)
  801bea:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bee:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bf2:	8b 14 24             	mov    (%esp),%edx
  801bf5:	83 c4 1c             	add    $0x1c,%esp
  801bf8:	5b                   	pop    %ebx
  801bf9:	5e                   	pop    %esi
  801bfa:	5f                   	pop    %edi
  801bfb:	5d                   	pop    %ebp
  801bfc:	c3                   	ret    
  801bfd:	8d 76 00             	lea    0x0(%esi),%esi
  801c00:	2b 04 24             	sub    (%esp),%eax
  801c03:	19 fa                	sbb    %edi,%edx
  801c05:	89 d1                	mov    %edx,%ecx
  801c07:	89 c6                	mov    %eax,%esi
  801c09:	e9 71 ff ff ff       	jmp    801b7f <__umoddi3+0xb3>
  801c0e:	66 90                	xchg   %ax,%ax
  801c10:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c14:	72 ea                	jb     801c00 <__umoddi3+0x134>
  801c16:	89 d9                	mov    %ebx,%ecx
  801c18:	e9 62 ff ff ff       	jmp    801b7f <__umoddi3+0xb3>
