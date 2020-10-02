
obj/user/tst_invalid_access:     file format elf32-i386


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
  800031:	e8 57 00 00 00       	call   80008d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp

	uint32 kilo = 1024;
  80003e:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	
	

	/// testing illegal memory access
	{
		uint32 size = 4*kilo;
  800045:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800048:	c1 e0 02             	shl    $0x2,%eax
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)


		unsigned char *x = (unsigned char *)0x80000000;
  80004e:	c7 45 e8 00 00 00 80 	movl   $0x80000000,-0x18(%ebp)

		int i=0;
  800055:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for(;i< size+20;i++)
  80005c:	eb 0e                	jmp    80006c <_main+0x34>
		{
			x[i]=-1;
  80005e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800061:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800064:	01 d0                	add    %edx,%eax
  800066:	c6 00 ff             	movb   $0xff,(%eax)


		unsigned char *x = (unsigned char *)0x80000000;

		int i=0;
		for(;i< size+20;i++)
  800069:	ff 45 f4             	incl   -0xc(%ebp)
  80006c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80006f:	8d 50 14             	lea    0x14(%eax),%edx
  800072:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800075:	39 c2                	cmp    %eax,%edx
  800077:	77 e5                	ja     80005e <_main+0x26>
		{
			x[i]=-1;
		}

		panic("ERROR: FOS SHOULD NOT panic here, it should panic earlier in page_fault_handler(), since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK. REMEMBER: creating new page in page file shouldn't be allowed except ONLY for new stack pages\n");
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	68 e0 1a 80 00       	push   $0x801ae0
  800081:	6a 1f                	push   $0x1f
  800083:	68 e9 1b 80 00       	push   $0x801be9
  800088:	e8 28 01 00 00       	call   8001b5 <_panic>

0080008d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80008d:	55                   	push   %ebp
  80008e:	89 e5                	mov    %esp,%ebp
  800090:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800093:	e8 ff 11 00 00       	call   801297 <sys_getenvindex>
  800098:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80009b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80009e:	89 d0                	mov    %edx,%eax
  8000a0:	01 c0                	add    %eax,%eax
  8000a2:	01 d0                	add    %edx,%eax
  8000a4:	c1 e0 07             	shl    $0x7,%eax
  8000a7:	29 d0                	sub    %edx,%eax
  8000a9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000b0:	01 c8                	add    %ecx,%eax
  8000b2:	01 c0                	add    %eax,%eax
  8000b4:	01 d0                	add    %edx,%eax
  8000b6:	01 c0                	add    %eax,%eax
  8000b8:	01 d0                	add    %edx,%eax
  8000ba:	c1 e0 03             	shl    $0x3,%eax
  8000bd:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000c2:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000cc:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  8000d2:	84 c0                	test   %al,%al
  8000d4:	74 0f                	je     8000e5 <libmain+0x58>
		binaryname = myEnv->prog_name;
  8000d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8000db:	05 f0 ee 00 00       	add    $0xeef0,%eax
  8000e0:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000e5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000e9:	7e 0a                	jle    8000f5 <libmain+0x68>
		binaryname = argv[0];
  8000eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000ee:	8b 00                	mov    (%eax),%eax
  8000f0:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8000f5:	83 ec 08             	sub    $0x8,%esp
  8000f8:	ff 75 0c             	pushl  0xc(%ebp)
  8000fb:	ff 75 08             	pushl  0x8(%ebp)
  8000fe:	e8 35 ff ff ff       	call   800038 <_main>
  800103:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800106:	e8 27 13 00 00       	call   801432 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 1c 1c 80 00       	push   $0x801c1c
  800113:	e8 54 03 00 00       	call   80046c <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80011b:	a1 20 30 80 00       	mov    0x803020,%eax
  800120:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800126:	a1 20 30 80 00       	mov    0x803020,%eax
  80012b:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  800131:	83 ec 04             	sub    $0x4,%esp
  800134:	52                   	push   %edx
  800135:	50                   	push   %eax
  800136:	68 44 1c 80 00       	push   $0x801c44
  80013b:	e8 2c 03 00 00       	call   80046c <cprintf>
  800140:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800143:	a1 20 30 80 00       	mov    0x803020,%eax
  800148:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  80014e:	a1 20 30 80 00       	mov    0x803020,%eax
  800153:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800159:	a1 20 30 80 00       	mov    0x803020,%eax
  80015e:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  800164:	51                   	push   %ecx
  800165:	52                   	push   %edx
  800166:	50                   	push   %eax
  800167:	68 6c 1c 80 00       	push   $0x801c6c
  80016c:	e8 fb 02 00 00       	call   80046c <cprintf>
  800171:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800174:	83 ec 0c             	sub    $0xc,%esp
  800177:	68 1c 1c 80 00       	push   $0x801c1c
  80017c:	e8 eb 02 00 00       	call   80046c <cprintf>
  800181:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800184:	e8 c3 12 00 00       	call   80144c <sys_enable_interrupt>

	// exit gracefully
	exit();
  800189:	e8 19 00 00 00       	call   8001a7 <exit>
}
  80018e:	90                   	nop
  80018f:	c9                   	leave  
  800190:	c3                   	ret    

00800191 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800191:	55                   	push   %ebp
  800192:	89 e5                	mov    %esp,%ebp
  800194:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800197:	83 ec 0c             	sub    $0xc,%esp
  80019a:	6a 00                	push   $0x0
  80019c:	e8 c2 10 00 00       	call   801263 <sys_env_destroy>
  8001a1:	83 c4 10             	add    $0x10,%esp
}
  8001a4:	90                   	nop
  8001a5:	c9                   	leave  
  8001a6:	c3                   	ret    

008001a7 <exit>:

void
exit(void)
{
  8001a7:	55                   	push   %ebp
  8001a8:	89 e5                	mov    %esp,%ebp
  8001aa:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001ad:	e8 17 11 00 00       	call   8012c9 <sys_env_exit>
}
  8001b2:	90                   	nop
  8001b3:	c9                   	leave  
  8001b4:	c3                   	ret    

008001b5 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8001b5:	55                   	push   %ebp
  8001b6:	89 e5                	mov    %esp,%ebp
  8001b8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8001bb:	8d 45 10             	lea    0x10(%ebp),%eax
  8001be:	83 c0 04             	add    $0x4,%eax
  8001c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8001c4:	a1 18 31 80 00       	mov    0x803118,%eax
  8001c9:	85 c0                	test   %eax,%eax
  8001cb:	74 16                	je     8001e3 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8001cd:	a1 18 31 80 00       	mov    0x803118,%eax
  8001d2:	83 ec 08             	sub    $0x8,%esp
  8001d5:	50                   	push   %eax
  8001d6:	68 c4 1c 80 00       	push   $0x801cc4
  8001db:	e8 8c 02 00 00       	call   80046c <cprintf>
  8001e0:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8001e3:	a1 00 30 80 00       	mov    0x803000,%eax
  8001e8:	ff 75 0c             	pushl  0xc(%ebp)
  8001eb:	ff 75 08             	pushl  0x8(%ebp)
  8001ee:	50                   	push   %eax
  8001ef:	68 c9 1c 80 00       	push   $0x801cc9
  8001f4:	e8 73 02 00 00       	call   80046c <cprintf>
  8001f9:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8001fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8001ff:	83 ec 08             	sub    $0x8,%esp
  800202:	ff 75 f4             	pushl  -0xc(%ebp)
  800205:	50                   	push   %eax
  800206:	e8 f6 01 00 00       	call   800401 <vcprintf>
  80020b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80020e:	83 ec 08             	sub    $0x8,%esp
  800211:	6a 00                	push   $0x0
  800213:	68 e5 1c 80 00       	push   $0x801ce5
  800218:	e8 e4 01 00 00       	call   800401 <vcprintf>
  80021d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800220:	e8 82 ff ff ff       	call   8001a7 <exit>

	// should not return here
	while (1) ;
  800225:	eb fe                	jmp    800225 <_panic+0x70>

00800227 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800227:	55                   	push   %ebp
  800228:	89 e5                	mov    %esp,%ebp
  80022a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80022d:	a1 20 30 80 00       	mov    0x803020,%eax
  800232:	8b 50 74             	mov    0x74(%eax),%edx
  800235:	8b 45 0c             	mov    0xc(%ebp),%eax
  800238:	39 c2                	cmp    %eax,%edx
  80023a:	74 14                	je     800250 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80023c:	83 ec 04             	sub    $0x4,%esp
  80023f:	68 e8 1c 80 00       	push   $0x801ce8
  800244:	6a 26                	push   $0x26
  800246:	68 34 1d 80 00       	push   $0x801d34
  80024b:	e8 65 ff ff ff       	call   8001b5 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800250:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800257:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80025e:	e9 c4 00 00 00       	jmp    800327 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800263:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800266:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80026d:	8b 45 08             	mov    0x8(%ebp),%eax
  800270:	01 d0                	add    %edx,%eax
  800272:	8b 00                	mov    (%eax),%eax
  800274:	85 c0                	test   %eax,%eax
  800276:	75 08                	jne    800280 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800278:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80027b:	e9 a4 00 00 00       	jmp    800324 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800280:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800287:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80028e:	eb 6b                	jmp    8002fb <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800290:	a1 20 30 80 00       	mov    0x803020,%eax
  800295:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80029b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80029e:	89 d0                	mov    %edx,%eax
  8002a0:	c1 e0 02             	shl    $0x2,%eax
  8002a3:	01 d0                	add    %edx,%eax
  8002a5:	c1 e0 02             	shl    $0x2,%eax
  8002a8:	01 c8                	add    %ecx,%eax
  8002aa:	8a 40 04             	mov    0x4(%eax),%al
  8002ad:	84 c0                	test   %al,%al
  8002af:	75 47                	jne    8002f8 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b6:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8002bc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002bf:	89 d0                	mov    %edx,%eax
  8002c1:	c1 e0 02             	shl    $0x2,%eax
  8002c4:	01 d0                	add    %edx,%eax
  8002c6:	c1 e0 02             	shl    $0x2,%eax
  8002c9:	01 c8                	add    %ecx,%eax
  8002cb:	8b 00                	mov    (%eax),%eax
  8002cd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8002d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002d3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002d8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8002da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002dd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 c8                	add    %ecx,%eax
  8002e9:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002eb:	39 c2                	cmp    %eax,%edx
  8002ed:	75 09                	jne    8002f8 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  8002ef:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8002f6:	eb 12                	jmp    80030a <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002f8:	ff 45 e8             	incl   -0x18(%ebp)
  8002fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800300:	8b 50 74             	mov    0x74(%eax),%edx
  800303:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800306:	39 c2                	cmp    %eax,%edx
  800308:	77 86                	ja     800290 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80030a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80030e:	75 14                	jne    800324 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800310:	83 ec 04             	sub    $0x4,%esp
  800313:	68 40 1d 80 00       	push   $0x801d40
  800318:	6a 3a                	push   $0x3a
  80031a:	68 34 1d 80 00       	push   $0x801d34
  80031f:	e8 91 fe ff ff       	call   8001b5 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800324:	ff 45 f0             	incl   -0x10(%ebp)
  800327:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80032a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80032d:	0f 8c 30 ff ff ff    	jl     800263 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800333:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80033a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800341:	eb 27                	jmp    80036a <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800343:	a1 20 30 80 00       	mov    0x803020,%eax
  800348:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80034e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800351:	89 d0                	mov    %edx,%eax
  800353:	c1 e0 02             	shl    $0x2,%eax
  800356:	01 d0                	add    %edx,%eax
  800358:	c1 e0 02             	shl    $0x2,%eax
  80035b:	01 c8                	add    %ecx,%eax
  80035d:	8a 40 04             	mov    0x4(%eax),%al
  800360:	3c 01                	cmp    $0x1,%al
  800362:	75 03                	jne    800367 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800364:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800367:	ff 45 e0             	incl   -0x20(%ebp)
  80036a:	a1 20 30 80 00       	mov    0x803020,%eax
  80036f:	8b 50 74             	mov    0x74(%eax),%edx
  800372:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800375:	39 c2                	cmp    %eax,%edx
  800377:	77 ca                	ja     800343 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800379:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80037c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80037f:	74 14                	je     800395 <CheckWSWithoutLastIndex+0x16e>
		panic(
  800381:	83 ec 04             	sub    $0x4,%esp
  800384:	68 94 1d 80 00       	push   $0x801d94
  800389:	6a 44                	push   $0x44
  80038b:	68 34 1d 80 00       	push   $0x801d34
  800390:	e8 20 fe ff ff       	call   8001b5 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800395:	90                   	nop
  800396:	c9                   	leave  
  800397:	c3                   	ret    

00800398 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800398:	55                   	push   %ebp
  800399:	89 e5                	mov    %esp,%ebp
  80039b:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80039e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a1:	8b 00                	mov    (%eax),%eax
  8003a3:	8d 48 01             	lea    0x1(%eax),%ecx
  8003a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003a9:	89 0a                	mov    %ecx,(%edx)
  8003ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8003ae:	88 d1                	mov    %dl,%cl
  8003b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003b3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8003b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ba:	8b 00                	mov    (%eax),%eax
  8003bc:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003c1:	75 2c                	jne    8003ef <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8003c3:	a0 24 30 80 00       	mov    0x803024,%al
  8003c8:	0f b6 c0             	movzbl %al,%eax
  8003cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003ce:	8b 12                	mov    (%edx),%edx
  8003d0:	89 d1                	mov    %edx,%ecx
  8003d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003d5:	83 c2 08             	add    $0x8,%edx
  8003d8:	83 ec 04             	sub    $0x4,%esp
  8003db:	50                   	push   %eax
  8003dc:	51                   	push   %ecx
  8003dd:	52                   	push   %edx
  8003de:	e8 3e 0e 00 00       	call   801221 <sys_cputs>
  8003e3:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8003e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f2:	8b 40 04             	mov    0x4(%eax),%eax
  8003f5:	8d 50 01             	lea    0x1(%eax),%edx
  8003f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003fb:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003fe:	90                   	nop
  8003ff:	c9                   	leave  
  800400:	c3                   	ret    

00800401 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800401:	55                   	push   %ebp
  800402:	89 e5                	mov    %esp,%ebp
  800404:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80040a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800411:	00 00 00 
	b.cnt = 0;
  800414:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80041b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80041e:	ff 75 0c             	pushl  0xc(%ebp)
  800421:	ff 75 08             	pushl  0x8(%ebp)
  800424:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80042a:	50                   	push   %eax
  80042b:	68 98 03 80 00       	push   $0x800398
  800430:	e8 11 02 00 00       	call   800646 <vprintfmt>
  800435:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800438:	a0 24 30 80 00       	mov    0x803024,%al
  80043d:	0f b6 c0             	movzbl %al,%eax
  800440:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800446:	83 ec 04             	sub    $0x4,%esp
  800449:	50                   	push   %eax
  80044a:	52                   	push   %edx
  80044b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800451:	83 c0 08             	add    $0x8,%eax
  800454:	50                   	push   %eax
  800455:	e8 c7 0d 00 00       	call   801221 <sys_cputs>
  80045a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80045d:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800464:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80046a:	c9                   	leave  
  80046b:	c3                   	ret    

0080046c <cprintf>:

int cprintf(const char *fmt, ...) {
  80046c:	55                   	push   %ebp
  80046d:	89 e5                	mov    %esp,%ebp
  80046f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800472:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800479:	8d 45 0c             	lea    0xc(%ebp),%eax
  80047c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80047f:	8b 45 08             	mov    0x8(%ebp),%eax
  800482:	83 ec 08             	sub    $0x8,%esp
  800485:	ff 75 f4             	pushl  -0xc(%ebp)
  800488:	50                   	push   %eax
  800489:	e8 73 ff ff ff       	call   800401 <vcprintf>
  80048e:	83 c4 10             	add    $0x10,%esp
  800491:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800494:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800497:	c9                   	leave  
  800498:	c3                   	ret    

00800499 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800499:	55                   	push   %ebp
  80049a:	89 e5                	mov    %esp,%ebp
  80049c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80049f:	e8 8e 0f 00 00       	call   801432 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8004a4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ad:	83 ec 08             	sub    $0x8,%esp
  8004b0:	ff 75 f4             	pushl  -0xc(%ebp)
  8004b3:	50                   	push   %eax
  8004b4:	e8 48 ff ff ff       	call   800401 <vcprintf>
  8004b9:	83 c4 10             	add    $0x10,%esp
  8004bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8004bf:	e8 88 0f 00 00       	call   80144c <sys_enable_interrupt>
	return cnt;
  8004c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004c7:	c9                   	leave  
  8004c8:	c3                   	ret    

008004c9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004c9:	55                   	push   %ebp
  8004ca:	89 e5                	mov    %esp,%ebp
  8004cc:	53                   	push   %ebx
  8004cd:	83 ec 14             	sub    $0x14,%esp
  8004d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8004d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004dc:	8b 45 18             	mov    0x18(%ebp),%eax
  8004df:	ba 00 00 00 00       	mov    $0x0,%edx
  8004e4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004e7:	77 55                	ja     80053e <printnum+0x75>
  8004e9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004ec:	72 05                	jb     8004f3 <printnum+0x2a>
  8004ee:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004f1:	77 4b                	ja     80053e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004f3:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004f6:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004f9:	8b 45 18             	mov    0x18(%ebp),%eax
  8004fc:	ba 00 00 00 00       	mov    $0x0,%edx
  800501:	52                   	push   %edx
  800502:	50                   	push   %eax
  800503:	ff 75 f4             	pushl  -0xc(%ebp)
  800506:	ff 75 f0             	pushl  -0x10(%ebp)
  800509:	e8 62 13 00 00       	call   801870 <__udivdi3>
  80050e:	83 c4 10             	add    $0x10,%esp
  800511:	83 ec 04             	sub    $0x4,%esp
  800514:	ff 75 20             	pushl  0x20(%ebp)
  800517:	53                   	push   %ebx
  800518:	ff 75 18             	pushl  0x18(%ebp)
  80051b:	52                   	push   %edx
  80051c:	50                   	push   %eax
  80051d:	ff 75 0c             	pushl  0xc(%ebp)
  800520:	ff 75 08             	pushl  0x8(%ebp)
  800523:	e8 a1 ff ff ff       	call   8004c9 <printnum>
  800528:	83 c4 20             	add    $0x20,%esp
  80052b:	eb 1a                	jmp    800547 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80052d:	83 ec 08             	sub    $0x8,%esp
  800530:	ff 75 0c             	pushl  0xc(%ebp)
  800533:	ff 75 20             	pushl  0x20(%ebp)
  800536:	8b 45 08             	mov    0x8(%ebp),%eax
  800539:	ff d0                	call   *%eax
  80053b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80053e:	ff 4d 1c             	decl   0x1c(%ebp)
  800541:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800545:	7f e6                	jg     80052d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800547:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80054a:	bb 00 00 00 00       	mov    $0x0,%ebx
  80054f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800552:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800555:	53                   	push   %ebx
  800556:	51                   	push   %ecx
  800557:	52                   	push   %edx
  800558:	50                   	push   %eax
  800559:	e8 22 14 00 00       	call   801980 <__umoddi3>
  80055e:	83 c4 10             	add    $0x10,%esp
  800561:	05 f4 1f 80 00       	add    $0x801ff4,%eax
  800566:	8a 00                	mov    (%eax),%al
  800568:	0f be c0             	movsbl %al,%eax
  80056b:	83 ec 08             	sub    $0x8,%esp
  80056e:	ff 75 0c             	pushl  0xc(%ebp)
  800571:	50                   	push   %eax
  800572:	8b 45 08             	mov    0x8(%ebp),%eax
  800575:	ff d0                	call   *%eax
  800577:	83 c4 10             	add    $0x10,%esp
}
  80057a:	90                   	nop
  80057b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80057e:	c9                   	leave  
  80057f:	c3                   	ret    

00800580 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800580:	55                   	push   %ebp
  800581:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800583:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800587:	7e 1c                	jle    8005a5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800589:	8b 45 08             	mov    0x8(%ebp),%eax
  80058c:	8b 00                	mov    (%eax),%eax
  80058e:	8d 50 08             	lea    0x8(%eax),%edx
  800591:	8b 45 08             	mov    0x8(%ebp),%eax
  800594:	89 10                	mov    %edx,(%eax)
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	8b 00                	mov    (%eax),%eax
  80059b:	83 e8 08             	sub    $0x8,%eax
  80059e:	8b 50 04             	mov    0x4(%eax),%edx
  8005a1:	8b 00                	mov    (%eax),%eax
  8005a3:	eb 40                	jmp    8005e5 <getuint+0x65>
	else if (lflag)
  8005a5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005a9:	74 1e                	je     8005c9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ae:	8b 00                	mov    (%eax),%eax
  8005b0:	8d 50 04             	lea    0x4(%eax),%edx
  8005b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b6:	89 10                	mov    %edx,(%eax)
  8005b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bb:	8b 00                	mov    (%eax),%eax
  8005bd:	83 e8 04             	sub    $0x4,%eax
  8005c0:	8b 00                	mov    (%eax),%eax
  8005c2:	ba 00 00 00 00       	mov    $0x0,%edx
  8005c7:	eb 1c                	jmp    8005e5 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005cc:	8b 00                	mov    (%eax),%eax
  8005ce:	8d 50 04             	lea    0x4(%eax),%edx
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	89 10                	mov    %edx,(%eax)
  8005d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d9:	8b 00                	mov    (%eax),%eax
  8005db:	83 e8 04             	sub    $0x4,%eax
  8005de:	8b 00                	mov    (%eax),%eax
  8005e0:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005e5:	5d                   	pop    %ebp
  8005e6:	c3                   	ret    

008005e7 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005e7:	55                   	push   %ebp
  8005e8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005ea:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005ee:	7e 1c                	jle    80060c <getint+0x25>
		return va_arg(*ap, long long);
  8005f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f3:	8b 00                	mov    (%eax),%eax
  8005f5:	8d 50 08             	lea    0x8(%eax),%edx
  8005f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fb:	89 10                	mov    %edx,(%eax)
  8005fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800600:	8b 00                	mov    (%eax),%eax
  800602:	83 e8 08             	sub    $0x8,%eax
  800605:	8b 50 04             	mov    0x4(%eax),%edx
  800608:	8b 00                	mov    (%eax),%eax
  80060a:	eb 38                	jmp    800644 <getint+0x5d>
	else if (lflag)
  80060c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800610:	74 1a                	je     80062c <getint+0x45>
		return va_arg(*ap, long);
  800612:	8b 45 08             	mov    0x8(%ebp),%eax
  800615:	8b 00                	mov    (%eax),%eax
  800617:	8d 50 04             	lea    0x4(%eax),%edx
  80061a:	8b 45 08             	mov    0x8(%ebp),%eax
  80061d:	89 10                	mov    %edx,(%eax)
  80061f:	8b 45 08             	mov    0x8(%ebp),%eax
  800622:	8b 00                	mov    (%eax),%eax
  800624:	83 e8 04             	sub    $0x4,%eax
  800627:	8b 00                	mov    (%eax),%eax
  800629:	99                   	cltd   
  80062a:	eb 18                	jmp    800644 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80062c:	8b 45 08             	mov    0x8(%ebp),%eax
  80062f:	8b 00                	mov    (%eax),%eax
  800631:	8d 50 04             	lea    0x4(%eax),%edx
  800634:	8b 45 08             	mov    0x8(%ebp),%eax
  800637:	89 10                	mov    %edx,(%eax)
  800639:	8b 45 08             	mov    0x8(%ebp),%eax
  80063c:	8b 00                	mov    (%eax),%eax
  80063e:	83 e8 04             	sub    $0x4,%eax
  800641:	8b 00                	mov    (%eax),%eax
  800643:	99                   	cltd   
}
  800644:	5d                   	pop    %ebp
  800645:	c3                   	ret    

00800646 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800646:	55                   	push   %ebp
  800647:	89 e5                	mov    %esp,%ebp
  800649:	56                   	push   %esi
  80064a:	53                   	push   %ebx
  80064b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80064e:	eb 17                	jmp    800667 <vprintfmt+0x21>
			if (ch == '\0')
  800650:	85 db                	test   %ebx,%ebx
  800652:	0f 84 af 03 00 00    	je     800a07 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800658:	83 ec 08             	sub    $0x8,%esp
  80065b:	ff 75 0c             	pushl  0xc(%ebp)
  80065e:	53                   	push   %ebx
  80065f:	8b 45 08             	mov    0x8(%ebp),%eax
  800662:	ff d0                	call   *%eax
  800664:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800667:	8b 45 10             	mov    0x10(%ebp),%eax
  80066a:	8d 50 01             	lea    0x1(%eax),%edx
  80066d:	89 55 10             	mov    %edx,0x10(%ebp)
  800670:	8a 00                	mov    (%eax),%al
  800672:	0f b6 d8             	movzbl %al,%ebx
  800675:	83 fb 25             	cmp    $0x25,%ebx
  800678:	75 d6                	jne    800650 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80067a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80067e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800685:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80068c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800693:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80069a:	8b 45 10             	mov    0x10(%ebp),%eax
  80069d:	8d 50 01             	lea    0x1(%eax),%edx
  8006a0:	89 55 10             	mov    %edx,0x10(%ebp)
  8006a3:	8a 00                	mov    (%eax),%al
  8006a5:	0f b6 d8             	movzbl %al,%ebx
  8006a8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006ab:	83 f8 55             	cmp    $0x55,%eax
  8006ae:	0f 87 2b 03 00 00    	ja     8009df <vprintfmt+0x399>
  8006b4:	8b 04 85 18 20 80 00 	mov    0x802018(,%eax,4),%eax
  8006bb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006bd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006c1:	eb d7                	jmp    80069a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006c3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006c7:	eb d1                	jmp    80069a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006c9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006d0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006d3:	89 d0                	mov    %edx,%eax
  8006d5:	c1 e0 02             	shl    $0x2,%eax
  8006d8:	01 d0                	add    %edx,%eax
  8006da:	01 c0                	add    %eax,%eax
  8006dc:	01 d8                	add    %ebx,%eax
  8006de:	83 e8 30             	sub    $0x30,%eax
  8006e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8006e7:	8a 00                	mov    (%eax),%al
  8006e9:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006ec:	83 fb 2f             	cmp    $0x2f,%ebx
  8006ef:	7e 3e                	jle    80072f <vprintfmt+0xe9>
  8006f1:	83 fb 39             	cmp    $0x39,%ebx
  8006f4:	7f 39                	jg     80072f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006f6:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006f9:	eb d5                	jmp    8006d0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8006fe:	83 c0 04             	add    $0x4,%eax
  800701:	89 45 14             	mov    %eax,0x14(%ebp)
  800704:	8b 45 14             	mov    0x14(%ebp),%eax
  800707:	83 e8 04             	sub    $0x4,%eax
  80070a:	8b 00                	mov    (%eax),%eax
  80070c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80070f:	eb 1f                	jmp    800730 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800711:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800715:	79 83                	jns    80069a <vprintfmt+0x54>
				width = 0;
  800717:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80071e:	e9 77 ff ff ff       	jmp    80069a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800723:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80072a:	e9 6b ff ff ff       	jmp    80069a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80072f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800730:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800734:	0f 89 60 ff ff ff    	jns    80069a <vprintfmt+0x54>
				width = precision, precision = -1;
  80073a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80073d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800740:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800747:	e9 4e ff ff ff       	jmp    80069a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80074c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80074f:	e9 46 ff ff ff       	jmp    80069a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800754:	8b 45 14             	mov    0x14(%ebp),%eax
  800757:	83 c0 04             	add    $0x4,%eax
  80075a:	89 45 14             	mov    %eax,0x14(%ebp)
  80075d:	8b 45 14             	mov    0x14(%ebp),%eax
  800760:	83 e8 04             	sub    $0x4,%eax
  800763:	8b 00                	mov    (%eax),%eax
  800765:	83 ec 08             	sub    $0x8,%esp
  800768:	ff 75 0c             	pushl  0xc(%ebp)
  80076b:	50                   	push   %eax
  80076c:	8b 45 08             	mov    0x8(%ebp),%eax
  80076f:	ff d0                	call   *%eax
  800771:	83 c4 10             	add    $0x10,%esp
			break;
  800774:	e9 89 02 00 00       	jmp    800a02 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800779:	8b 45 14             	mov    0x14(%ebp),%eax
  80077c:	83 c0 04             	add    $0x4,%eax
  80077f:	89 45 14             	mov    %eax,0x14(%ebp)
  800782:	8b 45 14             	mov    0x14(%ebp),%eax
  800785:	83 e8 04             	sub    $0x4,%eax
  800788:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80078a:	85 db                	test   %ebx,%ebx
  80078c:	79 02                	jns    800790 <vprintfmt+0x14a>
				err = -err;
  80078e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800790:	83 fb 64             	cmp    $0x64,%ebx
  800793:	7f 0b                	jg     8007a0 <vprintfmt+0x15a>
  800795:	8b 34 9d 60 1e 80 00 	mov    0x801e60(,%ebx,4),%esi
  80079c:	85 f6                	test   %esi,%esi
  80079e:	75 19                	jne    8007b9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8007a0:	53                   	push   %ebx
  8007a1:	68 05 20 80 00       	push   $0x802005
  8007a6:	ff 75 0c             	pushl  0xc(%ebp)
  8007a9:	ff 75 08             	pushl  0x8(%ebp)
  8007ac:	e8 5e 02 00 00       	call   800a0f <printfmt>
  8007b1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007b4:	e9 49 02 00 00       	jmp    800a02 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007b9:	56                   	push   %esi
  8007ba:	68 0e 20 80 00       	push   $0x80200e
  8007bf:	ff 75 0c             	pushl  0xc(%ebp)
  8007c2:	ff 75 08             	pushl  0x8(%ebp)
  8007c5:	e8 45 02 00 00       	call   800a0f <printfmt>
  8007ca:	83 c4 10             	add    $0x10,%esp
			break;
  8007cd:	e9 30 02 00 00       	jmp    800a02 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d5:	83 c0 04             	add    $0x4,%eax
  8007d8:	89 45 14             	mov    %eax,0x14(%ebp)
  8007db:	8b 45 14             	mov    0x14(%ebp),%eax
  8007de:	83 e8 04             	sub    $0x4,%eax
  8007e1:	8b 30                	mov    (%eax),%esi
  8007e3:	85 f6                	test   %esi,%esi
  8007e5:	75 05                	jne    8007ec <vprintfmt+0x1a6>
				p = "(null)";
  8007e7:	be 11 20 80 00       	mov    $0x802011,%esi
			if (width > 0 && padc != '-')
  8007ec:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007f0:	7e 6d                	jle    80085f <vprintfmt+0x219>
  8007f2:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007f6:	74 67                	je     80085f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007fb:	83 ec 08             	sub    $0x8,%esp
  8007fe:	50                   	push   %eax
  8007ff:	56                   	push   %esi
  800800:	e8 0c 03 00 00       	call   800b11 <strnlen>
  800805:	83 c4 10             	add    $0x10,%esp
  800808:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80080b:	eb 16                	jmp    800823 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80080d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800811:	83 ec 08             	sub    $0x8,%esp
  800814:	ff 75 0c             	pushl  0xc(%ebp)
  800817:	50                   	push   %eax
  800818:	8b 45 08             	mov    0x8(%ebp),%eax
  80081b:	ff d0                	call   *%eax
  80081d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800820:	ff 4d e4             	decl   -0x1c(%ebp)
  800823:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800827:	7f e4                	jg     80080d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800829:	eb 34                	jmp    80085f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80082b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80082f:	74 1c                	je     80084d <vprintfmt+0x207>
  800831:	83 fb 1f             	cmp    $0x1f,%ebx
  800834:	7e 05                	jle    80083b <vprintfmt+0x1f5>
  800836:	83 fb 7e             	cmp    $0x7e,%ebx
  800839:	7e 12                	jle    80084d <vprintfmt+0x207>
					putch('?', putdat);
  80083b:	83 ec 08             	sub    $0x8,%esp
  80083e:	ff 75 0c             	pushl  0xc(%ebp)
  800841:	6a 3f                	push   $0x3f
  800843:	8b 45 08             	mov    0x8(%ebp),%eax
  800846:	ff d0                	call   *%eax
  800848:	83 c4 10             	add    $0x10,%esp
  80084b:	eb 0f                	jmp    80085c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80084d:	83 ec 08             	sub    $0x8,%esp
  800850:	ff 75 0c             	pushl  0xc(%ebp)
  800853:	53                   	push   %ebx
  800854:	8b 45 08             	mov    0x8(%ebp),%eax
  800857:	ff d0                	call   *%eax
  800859:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80085c:	ff 4d e4             	decl   -0x1c(%ebp)
  80085f:	89 f0                	mov    %esi,%eax
  800861:	8d 70 01             	lea    0x1(%eax),%esi
  800864:	8a 00                	mov    (%eax),%al
  800866:	0f be d8             	movsbl %al,%ebx
  800869:	85 db                	test   %ebx,%ebx
  80086b:	74 24                	je     800891 <vprintfmt+0x24b>
  80086d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800871:	78 b8                	js     80082b <vprintfmt+0x1e5>
  800873:	ff 4d e0             	decl   -0x20(%ebp)
  800876:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80087a:	79 af                	jns    80082b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80087c:	eb 13                	jmp    800891 <vprintfmt+0x24b>
				putch(' ', putdat);
  80087e:	83 ec 08             	sub    $0x8,%esp
  800881:	ff 75 0c             	pushl  0xc(%ebp)
  800884:	6a 20                	push   $0x20
  800886:	8b 45 08             	mov    0x8(%ebp),%eax
  800889:	ff d0                	call   *%eax
  80088b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80088e:	ff 4d e4             	decl   -0x1c(%ebp)
  800891:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800895:	7f e7                	jg     80087e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800897:	e9 66 01 00 00       	jmp    800a02 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80089c:	83 ec 08             	sub    $0x8,%esp
  80089f:	ff 75 e8             	pushl  -0x18(%ebp)
  8008a2:	8d 45 14             	lea    0x14(%ebp),%eax
  8008a5:	50                   	push   %eax
  8008a6:	e8 3c fd ff ff       	call   8005e7 <getint>
  8008ab:	83 c4 10             	add    $0x10,%esp
  8008ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008ba:	85 d2                	test   %edx,%edx
  8008bc:	79 23                	jns    8008e1 <vprintfmt+0x29b>
				putch('-', putdat);
  8008be:	83 ec 08             	sub    $0x8,%esp
  8008c1:	ff 75 0c             	pushl  0xc(%ebp)
  8008c4:	6a 2d                	push   $0x2d
  8008c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c9:	ff d0                	call   *%eax
  8008cb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008d4:	f7 d8                	neg    %eax
  8008d6:	83 d2 00             	adc    $0x0,%edx
  8008d9:	f7 da                	neg    %edx
  8008db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008de:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008e1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008e8:	e9 bc 00 00 00       	jmp    8009a9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008ed:	83 ec 08             	sub    $0x8,%esp
  8008f0:	ff 75 e8             	pushl  -0x18(%ebp)
  8008f3:	8d 45 14             	lea    0x14(%ebp),%eax
  8008f6:	50                   	push   %eax
  8008f7:	e8 84 fc ff ff       	call   800580 <getuint>
  8008fc:	83 c4 10             	add    $0x10,%esp
  8008ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800902:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800905:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80090c:	e9 98 00 00 00       	jmp    8009a9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800911:	83 ec 08             	sub    $0x8,%esp
  800914:	ff 75 0c             	pushl  0xc(%ebp)
  800917:	6a 58                	push   $0x58
  800919:	8b 45 08             	mov    0x8(%ebp),%eax
  80091c:	ff d0                	call   *%eax
  80091e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800921:	83 ec 08             	sub    $0x8,%esp
  800924:	ff 75 0c             	pushl  0xc(%ebp)
  800927:	6a 58                	push   $0x58
  800929:	8b 45 08             	mov    0x8(%ebp),%eax
  80092c:	ff d0                	call   *%eax
  80092e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800931:	83 ec 08             	sub    $0x8,%esp
  800934:	ff 75 0c             	pushl  0xc(%ebp)
  800937:	6a 58                	push   $0x58
  800939:	8b 45 08             	mov    0x8(%ebp),%eax
  80093c:	ff d0                	call   *%eax
  80093e:	83 c4 10             	add    $0x10,%esp
			break;
  800941:	e9 bc 00 00 00       	jmp    800a02 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800946:	83 ec 08             	sub    $0x8,%esp
  800949:	ff 75 0c             	pushl  0xc(%ebp)
  80094c:	6a 30                	push   $0x30
  80094e:	8b 45 08             	mov    0x8(%ebp),%eax
  800951:	ff d0                	call   *%eax
  800953:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800956:	83 ec 08             	sub    $0x8,%esp
  800959:	ff 75 0c             	pushl  0xc(%ebp)
  80095c:	6a 78                	push   $0x78
  80095e:	8b 45 08             	mov    0x8(%ebp),%eax
  800961:	ff d0                	call   *%eax
  800963:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800966:	8b 45 14             	mov    0x14(%ebp),%eax
  800969:	83 c0 04             	add    $0x4,%eax
  80096c:	89 45 14             	mov    %eax,0x14(%ebp)
  80096f:	8b 45 14             	mov    0x14(%ebp),%eax
  800972:	83 e8 04             	sub    $0x4,%eax
  800975:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800977:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80097a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800981:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800988:	eb 1f                	jmp    8009a9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80098a:	83 ec 08             	sub    $0x8,%esp
  80098d:	ff 75 e8             	pushl  -0x18(%ebp)
  800990:	8d 45 14             	lea    0x14(%ebp),%eax
  800993:	50                   	push   %eax
  800994:	e8 e7 fb ff ff       	call   800580 <getuint>
  800999:	83 c4 10             	add    $0x10,%esp
  80099c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8009a2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009a9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009b0:	83 ec 04             	sub    $0x4,%esp
  8009b3:	52                   	push   %edx
  8009b4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009b7:	50                   	push   %eax
  8009b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8009bb:	ff 75 f0             	pushl  -0x10(%ebp)
  8009be:	ff 75 0c             	pushl  0xc(%ebp)
  8009c1:	ff 75 08             	pushl  0x8(%ebp)
  8009c4:	e8 00 fb ff ff       	call   8004c9 <printnum>
  8009c9:	83 c4 20             	add    $0x20,%esp
			break;
  8009cc:	eb 34                	jmp    800a02 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009ce:	83 ec 08             	sub    $0x8,%esp
  8009d1:	ff 75 0c             	pushl  0xc(%ebp)
  8009d4:	53                   	push   %ebx
  8009d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d8:	ff d0                	call   *%eax
  8009da:	83 c4 10             	add    $0x10,%esp
			break;
  8009dd:	eb 23                	jmp    800a02 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009df:	83 ec 08             	sub    $0x8,%esp
  8009e2:	ff 75 0c             	pushl  0xc(%ebp)
  8009e5:	6a 25                	push   $0x25
  8009e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ea:	ff d0                	call   *%eax
  8009ec:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009ef:	ff 4d 10             	decl   0x10(%ebp)
  8009f2:	eb 03                	jmp    8009f7 <vprintfmt+0x3b1>
  8009f4:	ff 4d 10             	decl   0x10(%ebp)
  8009f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8009fa:	48                   	dec    %eax
  8009fb:	8a 00                	mov    (%eax),%al
  8009fd:	3c 25                	cmp    $0x25,%al
  8009ff:	75 f3                	jne    8009f4 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a01:	90                   	nop
		}
	}
  800a02:	e9 47 fc ff ff       	jmp    80064e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a07:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a08:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a0b:	5b                   	pop    %ebx
  800a0c:	5e                   	pop    %esi
  800a0d:	5d                   	pop    %ebp
  800a0e:	c3                   	ret    

00800a0f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a0f:	55                   	push   %ebp
  800a10:	89 e5                	mov    %esp,%ebp
  800a12:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a15:	8d 45 10             	lea    0x10(%ebp),%eax
  800a18:	83 c0 04             	add    $0x4,%eax
  800a1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a1e:	8b 45 10             	mov    0x10(%ebp),%eax
  800a21:	ff 75 f4             	pushl  -0xc(%ebp)
  800a24:	50                   	push   %eax
  800a25:	ff 75 0c             	pushl  0xc(%ebp)
  800a28:	ff 75 08             	pushl  0x8(%ebp)
  800a2b:	e8 16 fc ff ff       	call   800646 <vprintfmt>
  800a30:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a33:	90                   	nop
  800a34:	c9                   	leave  
  800a35:	c3                   	ret    

00800a36 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a36:	55                   	push   %ebp
  800a37:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3c:	8b 40 08             	mov    0x8(%eax),%eax
  800a3f:	8d 50 01             	lea    0x1(%eax),%edx
  800a42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a45:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4b:	8b 10                	mov    (%eax),%edx
  800a4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a50:	8b 40 04             	mov    0x4(%eax),%eax
  800a53:	39 c2                	cmp    %eax,%edx
  800a55:	73 12                	jae    800a69 <sprintputch+0x33>
		*b->buf++ = ch;
  800a57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5a:	8b 00                	mov    (%eax),%eax
  800a5c:	8d 48 01             	lea    0x1(%eax),%ecx
  800a5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a62:	89 0a                	mov    %ecx,(%edx)
  800a64:	8b 55 08             	mov    0x8(%ebp),%edx
  800a67:	88 10                	mov    %dl,(%eax)
}
  800a69:	90                   	nop
  800a6a:	5d                   	pop    %ebp
  800a6b:	c3                   	ret    

00800a6c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a6c:	55                   	push   %ebp
  800a6d:	89 e5                	mov    %esp,%ebp
  800a6f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a72:	8b 45 08             	mov    0x8(%ebp),%eax
  800a75:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a81:	01 d0                	add    %edx,%eax
  800a83:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a86:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a8d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a91:	74 06                	je     800a99 <vsnprintf+0x2d>
  800a93:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a97:	7f 07                	jg     800aa0 <vsnprintf+0x34>
		return -E_INVAL;
  800a99:	b8 03 00 00 00       	mov    $0x3,%eax
  800a9e:	eb 20                	jmp    800ac0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800aa0:	ff 75 14             	pushl  0x14(%ebp)
  800aa3:	ff 75 10             	pushl  0x10(%ebp)
  800aa6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800aa9:	50                   	push   %eax
  800aaa:	68 36 0a 80 00       	push   $0x800a36
  800aaf:	e8 92 fb ff ff       	call   800646 <vprintfmt>
  800ab4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ab7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800aba:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ac0:	c9                   	leave  
  800ac1:	c3                   	ret    

00800ac2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ac2:	55                   	push   %ebp
  800ac3:	89 e5                	mov    %esp,%ebp
  800ac5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ac8:	8d 45 10             	lea    0x10(%ebp),%eax
  800acb:	83 c0 04             	add    $0x4,%eax
  800ace:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ad1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ad4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ad7:	50                   	push   %eax
  800ad8:	ff 75 0c             	pushl  0xc(%ebp)
  800adb:	ff 75 08             	pushl  0x8(%ebp)
  800ade:	e8 89 ff ff ff       	call   800a6c <vsnprintf>
  800ae3:	83 c4 10             	add    $0x10,%esp
  800ae6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ae9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800aec:	c9                   	leave  
  800aed:	c3                   	ret    

00800aee <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800aee:	55                   	push   %ebp
  800aef:	89 e5                	mov    %esp,%ebp
  800af1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800af4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800afb:	eb 06                	jmp    800b03 <strlen+0x15>
		n++;
  800afd:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b00:	ff 45 08             	incl   0x8(%ebp)
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	8a 00                	mov    (%eax),%al
  800b08:	84 c0                	test   %al,%al
  800b0a:	75 f1                	jne    800afd <strlen+0xf>
		n++;
	return n;
  800b0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b0f:	c9                   	leave  
  800b10:	c3                   	ret    

00800b11 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b11:	55                   	push   %ebp
  800b12:	89 e5                	mov    %esp,%ebp
  800b14:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b17:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b1e:	eb 09                	jmp    800b29 <strnlen+0x18>
		n++;
  800b20:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b23:	ff 45 08             	incl   0x8(%ebp)
  800b26:	ff 4d 0c             	decl   0xc(%ebp)
  800b29:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b2d:	74 09                	je     800b38 <strnlen+0x27>
  800b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b32:	8a 00                	mov    (%eax),%al
  800b34:	84 c0                	test   %al,%al
  800b36:	75 e8                	jne    800b20 <strnlen+0xf>
		n++;
	return n;
  800b38:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b3b:	c9                   	leave  
  800b3c:	c3                   	ret    

00800b3d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b3d:	55                   	push   %ebp
  800b3e:	89 e5                	mov    %esp,%ebp
  800b40:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b49:	90                   	nop
  800b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4d:	8d 50 01             	lea    0x1(%eax),%edx
  800b50:	89 55 08             	mov    %edx,0x8(%ebp)
  800b53:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b56:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b59:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b5c:	8a 12                	mov    (%edx),%dl
  800b5e:	88 10                	mov    %dl,(%eax)
  800b60:	8a 00                	mov    (%eax),%al
  800b62:	84 c0                	test   %al,%al
  800b64:	75 e4                	jne    800b4a <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b66:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b69:	c9                   	leave  
  800b6a:	c3                   	ret    

00800b6b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b6b:	55                   	push   %ebp
  800b6c:	89 e5                	mov    %esp,%ebp
  800b6e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b7e:	eb 1f                	jmp    800b9f <strncpy+0x34>
		*dst++ = *src;
  800b80:	8b 45 08             	mov    0x8(%ebp),%eax
  800b83:	8d 50 01             	lea    0x1(%eax),%edx
  800b86:	89 55 08             	mov    %edx,0x8(%ebp)
  800b89:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b8c:	8a 12                	mov    (%edx),%dl
  800b8e:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b93:	8a 00                	mov    (%eax),%al
  800b95:	84 c0                	test   %al,%al
  800b97:	74 03                	je     800b9c <strncpy+0x31>
			src++;
  800b99:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b9c:	ff 45 fc             	incl   -0x4(%ebp)
  800b9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba2:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ba5:	72 d9                	jb     800b80 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ba7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800baa:	c9                   	leave  
  800bab:	c3                   	ret    

00800bac <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800bac:	55                   	push   %ebp
  800bad:	89 e5                	mov    %esp,%ebp
  800baf:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800bb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800bb8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bbc:	74 30                	je     800bee <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bbe:	eb 16                	jmp    800bd6 <strlcpy+0x2a>
			*dst++ = *src++;
  800bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc3:	8d 50 01             	lea    0x1(%eax),%edx
  800bc6:	89 55 08             	mov    %edx,0x8(%ebp)
  800bc9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bcc:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bcf:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bd2:	8a 12                	mov    (%edx),%dl
  800bd4:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800bd6:	ff 4d 10             	decl   0x10(%ebp)
  800bd9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bdd:	74 09                	je     800be8 <strlcpy+0x3c>
  800bdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be2:	8a 00                	mov    (%eax),%al
  800be4:	84 c0                	test   %al,%al
  800be6:	75 d8                	jne    800bc0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800be8:	8b 45 08             	mov    0x8(%ebp),%eax
  800beb:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800bee:	8b 55 08             	mov    0x8(%ebp),%edx
  800bf1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf4:	29 c2                	sub    %eax,%edx
  800bf6:	89 d0                	mov    %edx,%eax
}
  800bf8:	c9                   	leave  
  800bf9:	c3                   	ret    

00800bfa <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800bfa:	55                   	push   %ebp
  800bfb:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800bfd:	eb 06                	jmp    800c05 <strcmp+0xb>
		p++, q++;
  800bff:	ff 45 08             	incl   0x8(%ebp)
  800c02:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c05:	8b 45 08             	mov    0x8(%ebp),%eax
  800c08:	8a 00                	mov    (%eax),%al
  800c0a:	84 c0                	test   %al,%al
  800c0c:	74 0e                	je     800c1c <strcmp+0x22>
  800c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c11:	8a 10                	mov    (%eax),%dl
  800c13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c16:	8a 00                	mov    (%eax),%al
  800c18:	38 c2                	cmp    %al,%dl
  800c1a:	74 e3                	je     800bff <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	8a 00                	mov    (%eax),%al
  800c21:	0f b6 d0             	movzbl %al,%edx
  800c24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c27:	8a 00                	mov    (%eax),%al
  800c29:	0f b6 c0             	movzbl %al,%eax
  800c2c:	29 c2                	sub    %eax,%edx
  800c2e:	89 d0                	mov    %edx,%eax
}
  800c30:	5d                   	pop    %ebp
  800c31:	c3                   	ret    

00800c32 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c32:	55                   	push   %ebp
  800c33:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c35:	eb 09                	jmp    800c40 <strncmp+0xe>
		n--, p++, q++;
  800c37:	ff 4d 10             	decl   0x10(%ebp)
  800c3a:	ff 45 08             	incl   0x8(%ebp)
  800c3d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c40:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c44:	74 17                	je     800c5d <strncmp+0x2b>
  800c46:	8b 45 08             	mov    0x8(%ebp),%eax
  800c49:	8a 00                	mov    (%eax),%al
  800c4b:	84 c0                	test   %al,%al
  800c4d:	74 0e                	je     800c5d <strncmp+0x2b>
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c52:	8a 10                	mov    (%eax),%dl
  800c54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c57:	8a 00                	mov    (%eax),%al
  800c59:	38 c2                	cmp    %al,%dl
  800c5b:	74 da                	je     800c37 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c5d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c61:	75 07                	jne    800c6a <strncmp+0x38>
		return 0;
  800c63:	b8 00 00 00 00       	mov    $0x0,%eax
  800c68:	eb 14                	jmp    800c7e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6d:	8a 00                	mov    (%eax),%al
  800c6f:	0f b6 d0             	movzbl %al,%edx
  800c72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c75:	8a 00                	mov    (%eax),%al
  800c77:	0f b6 c0             	movzbl %al,%eax
  800c7a:	29 c2                	sub    %eax,%edx
  800c7c:	89 d0                	mov    %edx,%eax
}
  800c7e:	5d                   	pop    %ebp
  800c7f:	c3                   	ret    

00800c80 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c80:	55                   	push   %ebp
  800c81:	89 e5                	mov    %esp,%ebp
  800c83:	83 ec 04             	sub    $0x4,%esp
  800c86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c89:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c8c:	eb 12                	jmp    800ca0 <strchr+0x20>
		if (*s == c)
  800c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c91:	8a 00                	mov    (%eax),%al
  800c93:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c96:	75 05                	jne    800c9d <strchr+0x1d>
			return (char *) s;
  800c98:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9b:	eb 11                	jmp    800cae <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c9d:	ff 45 08             	incl   0x8(%ebp)
  800ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca3:	8a 00                	mov    (%eax),%al
  800ca5:	84 c0                	test   %al,%al
  800ca7:	75 e5                	jne    800c8e <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ca9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cae:	c9                   	leave  
  800caf:	c3                   	ret    

00800cb0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800cb0:	55                   	push   %ebp
  800cb1:	89 e5                	mov    %esp,%ebp
  800cb3:	83 ec 04             	sub    $0x4,%esp
  800cb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cbc:	eb 0d                	jmp    800ccb <strfind+0x1b>
		if (*s == c)
  800cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc1:	8a 00                	mov    (%eax),%al
  800cc3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cc6:	74 0e                	je     800cd6 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cc8:	ff 45 08             	incl   0x8(%ebp)
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	8a 00                	mov    (%eax),%al
  800cd0:	84 c0                	test   %al,%al
  800cd2:	75 ea                	jne    800cbe <strfind+0xe>
  800cd4:	eb 01                	jmp    800cd7 <strfind+0x27>
		if (*s == c)
			break;
  800cd6:	90                   	nop
	return (char *) s;
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cda:	c9                   	leave  
  800cdb:	c3                   	ret    

00800cdc <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800cdc:	55                   	push   %ebp
  800cdd:	89 e5                	mov    %esp,%ebp
  800cdf:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ce8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ceb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800cee:	eb 0e                	jmp    800cfe <memset+0x22>
		*p++ = c;
  800cf0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cf3:	8d 50 01             	lea    0x1(%eax),%edx
  800cf6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800cf9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cfc:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800cfe:	ff 4d f8             	decl   -0x8(%ebp)
  800d01:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d05:	79 e9                	jns    800cf0 <memset+0x14>
		*p++ = c;

	return v;
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d0a:	c9                   	leave  
  800d0b:	c3                   	ret    

00800d0c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d0c:	55                   	push   %ebp
  800d0d:	89 e5                	mov    %esp,%ebp
  800d0f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d15:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d1e:	eb 16                	jmp    800d36 <memcpy+0x2a>
		*d++ = *s++;
  800d20:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d23:	8d 50 01             	lea    0x1(%eax),%edx
  800d26:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d29:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d2c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d2f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d32:	8a 12                	mov    (%edx),%dl
  800d34:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d36:	8b 45 10             	mov    0x10(%ebp),%eax
  800d39:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d3c:	89 55 10             	mov    %edx,0x10(%ebp)
  800d3f:	85 c0                	test   %eax,%eax
  800d41:	75 dd                	jne    800d20 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d46:	c9                   	leave  
  800d47:	c3                   	ret    

00800d48 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d48:	55                   	push   %ebp
  800d49:	89 e5                	mov    %esp,%ebp
  800d4b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d51:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d5d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d60:	73 50                	jae    800db2 <memmove+0x6a>
  800d62:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d65:	8b 45 10             	mov    0x10(%ebp),%eax
  800d68:	01 d0                	add    %edx,%eax
  800d6a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d6d:	76 43                	jbe    800db2 <memmove+0x6a>
		s += n;
  800d6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d72:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800d75:	8b 45 10             	mov    0x10(%ebp),%eax
  800d78:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d7b:	eb 10                	jmp    800d8d <memmove+0x45>
			*--d = *--s;
  800d7d:	ff 4d f8             	decl   -0x8(%ebp)
  800d80:	ff 4d fc             	decl   -0x4(%ebp)
  800d83:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d86:	8a 10                	mov    (%eax),%dl
  800d88:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d8b:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800d8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d90:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d93:	89 55 10             	mov    %edx,0x10(%ebp)
  800d96:	85 c0                	test   %eax,%eax
  800d98:	75 e3                	jne    800d7d <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800d9a:	eb 23                	jmp    800dbf <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800d9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9f:	8d 50 01             	lea    0x1(%eax),%edx
  800da2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800da5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800da8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dab:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dae:	8a 12                	mov    (%edx),%dl
  800db0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800db2:	8b 45 10             	mov    0x10(%ebp),%eax
  800db5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800db8:	89 55 10             	mov    %edx,0x10(%ebp)
  800dbb:	85 c0                	test   %eax,%eax
  800dbd:	75 dd                	jne    800d9c <memmove+0x54>
			*d++ = *s++;

	return dst;
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dc2:	c9                   	leave  
  800dc3:	c3                   	ret    

00800dc4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800dc4:	55                   	push   %ebp
  800dc5:	89 e5                	mov    %esp,%ebp
  800dc7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800dca:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800dd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd3:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800dd6:	eb 2a                	jmp    800e02 <memcmp+0x3e>
		if (*s1 != *s2)
  800dd8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ddb:	8a 10                	mov    (%eax),%dl
  800ddd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de0:	8a 00                	mov    (%eax),%al
  800de2:	38 c2                	cmp    %al,%dl
  800de4:	74 16                	je     800dfc <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800de6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de9:	8a 00                	mov    (%eax),%al
  800deb:	0f b6 d0             	movzbl %al,%edx
  800dee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df1:	8a 00                	mov    (%eax),%al
  800df3:	0f b6 c0             	movzbl %al,%eax
  800df6:	29 c2                	sub    %eax,%edx
  800df8:	89 d0                	mov    %edx,%eax
  800dfa:	eb 18                	jmp    800e14 <memcmp+0x50>
		s1++, s2++;
  800dfc:	ff 45 fc             	incl   -0x4(%ebp)
  800dff:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e02:	8b 45 10             	mov    0x10(%ebp),%eax
  800e05:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e08:	89 55 10             	mov    %edx,0x10(%ebp)
  800e0b:	85 c0                	test   %eax,%eax
  800e0d:	75 c9                	jne    800dd8 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e14:	c9                   	leave  
  800e15:	c3                   	ret    

00800e16 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e16:	55                   	push   %ebp
  800e17:	89 e5                	mov    %esp,%ebp
  800e19:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e1c:	8b 55 08             	mov    0x8(%ebp),%edx
  800e1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e22:	01 d0                	add    %edx,%eax
  800e24:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e27:	eb 15                	jmp    800e3e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e29:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2c:	8a 00                	mov    (%eax),%al
  800e2e:	0f b6 d0             	movzbl %al,%edx
  800e31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e34:	0f b6 c0             	movzbl %al,%eax
  800e37:	39 c2                	cmp    %eax,%edx
  800e39:	74 0d                	je     800e48 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e3b:	ff 45 08             	incl   0x8(%ebp)
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e44:	72 e3                	jb     800e29 <memfind+0x13>
  800e46:	eb 01                	jmp    800e49 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e48:	90                   	nop
	return (void *) s;
  800e49:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e4c:	c9                   	leave  
  800e4d:	c3                   	ret    

00800e4e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e4e:	55                   	push   %ebp
  800e4f:	89 e5                	mov    %esp,%ebp
  800e51:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e54:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e5b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e62:	eb 03                	jmp    800e67 <strtol+0x19>
		s++;
  800e64:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e67:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6a:	8a 00                	mov    (%eax),%al
  800e6c:	3c 20                	cmp    $0x20,%al
  800e6e:	74 f4                	je     800e64 <strtol+0x16>
  800e70:	8b 45 08             	mov    0x8(%ebp),%eax
  800e73:	8a 00                	mov    (%eax),%al
  800e75:	3c 09                	cmp    $0x9,%al
  800e77:	74 eb                	je     800e64 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800e79:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7c:	8a 00                	mov    (%eax),%al
  800e7e:	3c 2b                	cmp    $0x2b,%al
  800e80:	75 05                	jne    800e87 <strtol+0x39>
		s++;
  800e82:	ff 45 08             	incl   0x8(%ebp)
  800e85:	eb 13                	jmp    800e9a <strtol+0x4c>
	else if (*s == '-')
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8a:	8a 00                	mov    (%eax),%al
  800e8c:	3c 2d                	cmp    $0x2d,%al
  800e8e:	75 0a                	jne    800e9a <strtol+0x4c>
		s++, neg = 1;
  800e90:	ff 45 08             	incl   0x8(%ebp)
  800e93:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800e9a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e9e:	74 06                	je     800ea6 <strtol+0x58>
  800ea0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ea4:	75 20                	jne    800ec6 <strtol+0x78>
  800ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea9:	8a 00                	mov    (%eax),%al
  800eab:	3c 30                	cmp    $0x30,%al
  800ead:	75 17                	jne    800ec6 <strtol+0x78>
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	40                   	inc    %eax
  800eb3:	8a 00                	mov    (%eax),%al
  800eb5:	3c 78                	cmp    $0x78,%al
  800eb7:	75 0d                	jne    800ec6 <strtol+0x78>
		s += 2, base = 16;
  800eb9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ebd:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ec4:	eb 28                	jmp    800eee <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ec6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eca:	75 15                	jne    800ee1 <strtol+0x93>
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecf:	8a 00                	mov    (%eax),%al
  800ed1:	3c 30                	cmp    $0x30,%al
  800ed3:	75 0c                	jne    800ee1 <strtol+0x93>
		s++, base = 8;
  800ed5:	ff 45 08             	incl   0x8(%ebp)
  800ed8:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800edf:	eb 0d                	jmp    800eee <strtol+0xa0>
	else if (base == 0)
  800ee1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee5:	75 07                	jne    800eee <strtol+0xa0>
		base = 10;
  800ee7:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	3c 2f                	cmp    $0x2f,%al
  800ef5:	7e 19                	jle    800f10 <strtol+0xc2>
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  800efa:	8a 00                	mov    (%eax),%al
  800efc:	3c 39                	cmp    $0x39,%al
  800efe:	7f 10                	jg     800f10 <strtol+0xc2>
			dig = *s - '0';
  800f00:	8b 45 08             	mov    0x8(%ebp),%eax
  800f03:	8a 00                	mov    (%eax),%al
  800f05:	0f be c0             	movsbl %al,%eax
  800f08:	83 e8 30             	sub    $0x30,%eax
  800f0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f0e:	eb 42                	jmp    800f52 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f10:	8b 45 08             	mov    0x8(%ebp),%eax
  800f13:	8a 00                	mov    (%eax),%al
  800f15:	3c 60                	cmp    $0x60,%al
  800f17:	7e 19                	jle    800f32 <strtol+0xe4>
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	8a 00                	mov    (%eax),%al
  800f1e:	3c 7a                	cmp    $0x7a,%al
  800f20:	7f 10                	jg     800f32 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f22:	8b 45 08             	mov    0x8(%ebp),%eax
  800f25:	8a 00                	mov    (%eax),%al
  800f27:	0f be c0             	movsbl %al,%eax
  800f2a:	83 e8 57             	sub    $0x57,%eax
  800f2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f30:	eb 20                	jmp    800f52 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	8a 00                	mov    (%eax),%al
  800f37:	3c 40                	cmp    $0x40,%al
  800f39:	7e 39                	jle    800f74 <strtol+0x126>
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3e:	8a 00                	mov    (%eax),%al
  800f40:	3c 5a                	cmp    $0x5a,%al
  800f42:	7f 30                	jg     800f74 <strtol+0x126>
			dig = *s - 'A' + 10;
  800f44:	8b 45 08             	mov    0x8(%ebp),%eax
  800f47:	8a 00                	mov    (%eax),%al
  800f49:	0f be c0             	movsbl %al,%eax
  800f4c:	83 e8 37             	sub    $0x37,%eax
  800f4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f52:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f55:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f58:	7d 19                	jge    800f73 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f5a:	ff 45 08             	incl   0x8(%ebp)
  800f5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f60:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f64:	89 c2                	mov    %eax,%edx
  800f66:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f69:	01 d0                	add    %edx,%eax
  800f6b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f6e:	e9 7b ff ff ff       	jmp    800eee <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800f73:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800f74:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f78:	74 08                	je     800f82 <strtol+0x134>
		*endptr = (char *) s;
  800f7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7d:	8b 55 08             	mov    0x8(%ebp),%edx
  800f80:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800f82:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f86:	74 07                	je     800f8f <strtol+0x141>
  800f88:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f8b:	f7 d8                	neg    %eax
  800f8d:	eb 03                	jmp    800f92 <strtol+0x144>
  800f8f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f92:	c9                   	leave  
  800f93:	c3                   	ret    

00800f94 <ltostr>:

void
ltostr(long value, char *str)
{
  800f94:	55                   	push   %ebp
  800f95:	89 e5                	mov    %esp,%ebp
  800f97:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800f9a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fa1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800fa8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fac:	79 13                	jns    800fc1 <ltostr+0x2d>
	{
		neg = 1;
  800fae:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800fbb:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800fbe:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800fc9:	99                   	cltd   
  800fca:	f7 f9                	idiv   %ecx
  800fcc:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800fcf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd2:	8d 50 01             	lea    0x1(%eax),%edx
  800fd5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fd8:	89 c2                	mov    %eax,%edx
  800fda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fdd:	01 d0                	add    %edx,%eax
  800fdf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800fe2:	83 c2 30             	add    $0x30,%edx
  800fe5:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800fe7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800fea:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fef:	f7 e9                	imul   %ecx
  800ff1:	c1 fa 02             	sar    $0x2,%edx
  800ff4:	89 c8                	mov    %ecx,%eax
  800ff6:	c1 f8 1f             	sar    $0x1f,%eax
  800ff9:	29 c2                	sub    %eax,%edx
  800ffb:	89 d0                	mov    %edx,%eax
  800ffd:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801000:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801003:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801008:	f7 e9                	imul   %ecx
  80100a:	c1 fa 02             	sar    $0x2,%edx
  80100d:	89 c8                	mov    %ecx,%eax
  80100f:	c1 f8 1f             	sar    $0x1f,%eax
  801012:	29 c2                	sub    %eax,%edx
  801014:	89 d0                	mov    %edx,%eax
  801016:	c1 e0 02             	shl    $0x2,%eax
  801019:	01 d0                	add    %edx,%eax
  80101b:	01 c0                	add    %eax,%eax
  80101d:	29 c1                	sub    %eax,%ecx
  80101f:	89 ca                	mov    %ecx,%edx
  801021:	85 d2                	test   %edx,%edx
  801023:	75 9c                	jne    800fc1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801025:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80102c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80102f:	48                   	dec    %eax
  801030:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801033:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801037:	74 3d                	je     801076 <ltostr+0xe2>
		start = 1 ;
  801039:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801040:	eb 34                	jmp    801076 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801042:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801045:	8b 45 0c             	mov    0xc(%ebp),%eax
  801048:	01 d0                	add    %edx,%eax
  80104a:	8a 00                	mov    (%eax),%al
  80104c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80104f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801052:	8b 45 0c             	mov    0xc(%ebp),%eax
  801055:	01 c2                	add    %eax,%edx
  801057:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80105a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105d:	01 c8                	add    %ecx,%eax
  80105f:	8a 00                	mov    (%eax),%al
  801061:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801063:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801066:	8b 45 0c             	mov    0xc(%ebp),%eax
  801069:	01 c2                	add    %eax,%edx
  80106b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80106e:	88 02                	mov    %al,(%edx)
		start++ ;
  801070:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801073:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801076:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801079:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80107c:	7c c4                	jl     801042 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80107e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801081:	8b 45 0c             	mov    0xc(%ebp),%eax
  801084:	01 d0                	add    %edx,%eax
  801086:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801089:	90                   	nop
  80108a:	c9                   	leave  
  80108b:	c3                   	ret    

0080108c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80108c:	55                   	push   %ebp
  80108d:	89 e5                	mov    %esp,%ebp
  80108f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801092:	ff 75 08             	pushl  0x8(%ebp)
  801095:	e8 54 fa ff ff       	call   800aee <strlen>
  80109a:	83 c4 04             	add    $0x4,%esp
  80109d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010a0:	ff 75 0c             	pushl  0xc(%ebp)
  8010a3:	e8 46 fa ff ff       	call   800aee <strlen>
  8010a8:	83 c4 04             	add    $0x4,%esp
  8010ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010bc:	eb 17                	jmp    8010d5 <strcconcat+0x49>
		final[s] = str1[s] ;
  8010be:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c4:	01 c2                	add    %eax,%edx
  8010c6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cc:	01 c8                	add    %ecx,%eax
  8010ce:	8a 00                	mov    (%eax),%al
  8010d0:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8010d2:	ff 45 fc             	incl   -0x4(%ebp)
  8010d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010db:	7c e1                	jl     8010be <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8010dd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8010e4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8010eb:	eb 1f                	jmp    80110c <strcconcat+0x80>
		final[s++] = str2[i] ;
  8010ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f0:	8d 50 01             	lea    0x1(%eax),%edx
  8010f3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010f6:	89 c2                	mov    %eax,%edx
  8010f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fb:	01 c2                	add    %eax,%edx
  8010fd:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801100:	8b 45 0c             	mov    0xc(%ebp),%eax
  801103:	01 c8                	add    %ecx,%eax
  801105:	8a 00                	mov    (%eax),%al
  801107:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801109:	ff 45 f8             	incl   -0x8(%ebp)
  80110c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80110f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801112:	7c d9                	jl     8010ed <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801114:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801117:	8b 45 10             	mov    0x10(%ebp),%eax
  80111a:	01 d0                	add    %edx,%eax
  80111c:	c6 00 00             	movb   $0x0,(%eax)
}
  80111f:	90                   	nop
  801120:	c9                   	leave  
  801121:	c3                   	ret    

00801122 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801122:	55                   	push   %ebp
  801123:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801125:	8b 45 14             	mov    0x14(%ebp),%eax
  801128:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80112e:	8b 45 14             	mov    0x14(%ebp),%eax
  801131:	8b 00                	mov    (%eax),%eax
  801133:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80113a:	8b 45 10             	mov    0x10(%ebp),%eax
  80113d:	01 d0                	add    %edx,%eax
  80113f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801145:	eb 0c                	jmp    801153 <strsplit+0x31>
			*string++ = 0;
  801147:	8b 45 08             	mov    0x8(%ebp),%eax
  80114a:	8d 50 01             	lea    0x1(%eax),%edx
  80114d:	89 55 08             	mov    %edx,0x8(%ebp)
  801150:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801153:	8b 45 08             	mov    0x8(%ebp),%eax
  801156:	8a 00                	mov    (%eax),%al
  801158:	84 c0                	test   %al,%al
  80115a:	74 18                	je     801174 <strsplit+0x52>
  80115c:	8b 45 08             	mov    0x8(%ebp),%eax
  80115f:	8a 00                	mov    (%eax),%al
  801161:	0f be c0             	movsbl %al,%eax
  801164:	50                   	push   %eax
  801165:	ff 75 0c             	pushl  0xc(%ebp)
  801168:	e8 13 fb ff ff       	call   800c80 <strchr>
  80116d:	83 c4 08             	add    $0x8,%esp
  801170:	85 c0                	test   %eax,%eax
  801172:	75 d3                	jne    801147 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801174:	8b 45 08             	mov    0x8(%ebp),%eax
  801177:	8a 00                	mov    (%eax),%al
  801179:	84 c0                	test   %al,%al
  80117b:	74 5a                	je     8011d7 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80117d:	8b 45 14             	mov    0x14(%ebp),%eax
  801180:	8b 00                	mov    (%eax),%eax
  801182:	83 f8 0f             	cmp    $0xf,%eax
  801185:	75 07                	jne    80118e <strsplit+0x6c>
		{
			return 0;
  801187:	b8 00 00 00 00       	mov    $0x0,%eax
  80118c:	eb 66                	jmp    8011f4 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80118e:	8b 45 14             	mov    0x14(%ebp),%eax
  801191:	8b 00                	mov    (%eax),%eax
  801193:	8d 48 01             	lea    0x1(%eax),%ecx
  801196:	8b 55 14             	mov    0x14(%ebp),%edx
  801199:	89 0a                	mov    %ecx,(%edx)
  80119b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a5:	01 c2                	add    %eax,%edx
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011ac:	eb 03                	jmp    8011b1 <strsplit+0x8f>
			string++;
  8011ae:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	84 c0                	test   %al,%al
  8011b8:	74 8b                	je     801145 <strsplit+0x23>
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	8a 00                	mov    (%eax),%al
  8011bf:	0f be c0             	movsbl %al,%eax
  8011c2:	50                   	push   %eax
  8011c3:	ff 75 0c             	pushl  0xc(%ebp)
  8011c6:	e8 b5 fa ff ff       	call   800c80 <strchr>
  8011cb:	83 c4 08             	add    $0x8,%esp
  8011ce:	85 c0                	test   %eax,%eax
  8011d0:	74 dc                	je     8011ae <strsplit+0x8c>
			string++;
	}
  8011d2:	e9 6e ff ff ff       	jmp    801145 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8011d7:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8011d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011db:	8b 00                	mov    (%eax),%eax
  8011dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e7:	01 d0                	add    %edx,%eax
  8011e9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8011ef:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8011f4:	c9                   	leave  
  8011f5:	c3                   	ret    

008011f6 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8011f6:	55                   	push   %ebp
  8011f7:	89 e5                	mov    %esp,%ebp
  8011f9:	57                   	push   %edi
  8011fa:	56                   	push   %esi
  8011fb:	53                   	push   %ebx
  8011fc:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801202:	8b 55 0c             	mov    0xc(%ebp),%edx
  801205:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801208:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80120b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80120e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801211:	cd 30                	int    $0x30
  801213:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801216:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801219:	83 c4 10             	add    $0x10,%esp
  80121c:	5b                   	pop    %ebx
  80121d:	5e                   	pop    %esi
  80121e:	5f                   	pop    %edi
  80121f:	5d                   	pop    %ebp
  801220:	c3                   	ret    

00801221 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801221:	55                   	push   %ebp
  801222:	89 e5                	mov    %esp,%ebp
  801224:	83 ec 04             	sub    $0x4,%esp
  801227:	8b 45 10             	mov    0x10(%ebp),%eax
  80122a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80122d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801231:	8b 45 08             	mov    0x8(%ebp),%eax
  801234:	6a 00                	push   $0x0
  801236:	6a 00                	push   $0x0
  801238:	52                   	push   %edx
  801239:	ff 75 0c             	pushl  0xc(%ebp)
  80123c:	50                   	push   %eax
  80123d:	6a 00                	push   $0x0
  80123f:	e8 b2 ff ff ff       	call   8011f6 <syscall>
  801244:	83 c4 18             	add    $0x18,%esp
}
  801247:	90                   	nop
  801248:	c9                   	leave  
  801249:	c3                   	ret    

0080124a <sys_cgetc>:

int
sys_cgetc(void)
{
  80124a:	55                   	push   %ebp
  80124b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80124d:	6a 00                	push   $0x0
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	6a 00                	push   $0x0
  801255:	6a 00                	push   $0x0
  801257:	6a 01                	push   $0x1
  801259:	e8 98 ff ff ff       	call   8011f6 <syscall>
  80125e:	83 c4 18             	add    $0x18,%esp
}
  801261:	c9                   	leave  
  801262:	c3                   	ret    

00801263 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801263:	55                   	push   %ebp
  801264:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801266:	8b 45 08             	mov    0x8(%ebp),%eax
  801269:	6a 00                	push   $0x0
  80126b:	6a 00                	push   $0x0
  80126d:	6a 00                	push   $0x0
  80126f:	6a 00                	push   $0x0
  801271:	50                   	push   %eax
  801272:	6a 05                	push   $0x5
  801274:	e8 7d ff ff ff       	call   8011f6 <syscall>
  801279:	83 c4 18             	add    $0x18,%esp
}
  80127c:	c9                   	leave  
  80127d:	c3                   	ret    

0080127e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80127e:	55                   	push   %ebp
  80127f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801281:	6a 00                	push   $0x0
  801283:	6a 00                	push   $0x0
  801285:	6a 00                	push   $0x0
  801287:	6a 00                	push   $0x0
  801289:	6a 00                	push   $0x0
  80128b:	6a 02                	push   $0x2
  80128d:	e8 64 ff ff ff       	call   8011f6 <syscall>
  801292:	83 c4 18             	add    $0x18,%esp
}
  801295:	c9                   	leave  
  801296:	c3                   	ret    

00801297 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801297:	55                   	push   %ebp
  801298:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 03                	push   $0x3
  8012a6:	e8 4b ff ff ff       	call   8011f6 <syscall>
  8012ab:	83 c4 18             	add    $0x18,%esp
}
  8012ae:	c9                   	leave  
  8012af:	c3                   	ret    

008012b0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8012b0:	55                   	push   %ebp
  8012b1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8012b3:	6a 00                	push   $0x0
  8012b5:	6a 00                	push   $0x0
  8012b7:	6a 00                	push   $0x0
  8012b9:	6a 00                	push   $0x0
  8012bb:	6a 00                	push   $0x0
  8012bd:	6a 04                	push   $0x4
  8012bf:	e8 32 ff ff ff       	call   8011f6 <syscall>
  8012c4:	83 c4 18             	add    $0x18,%esp
}
  8012c7:	c9                   	leave  
  8012c8:	c3                   	ret    

008012c9 <sys_env_exit>:


void sys_env_exit(void)
{
  8012c9:	55                   	push   %ebp
  8012ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8012cc:	6a 00                	push   $0x0
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 06                	push   $0x6
  8012d8:	e8 19 ff ff ff       	call   8011f6 <syscall>
  8012dd:	83 c4 18             	add    $0x18,%esp
}
  8012e0:	90                   	nop
  8012e1:	c9                   	leave  
  8012e2:	c3                   	ret    

008012e3 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8012e3:	55                   	push   %ebp
  8012e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8012e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	52                   	push   %edx
  8012f3:	50                   	push   %eax
  8012f4:	6a 07                	push   $0x7
  8012f6:	e8 fb fe ff ff       	call   8011f6 <syscall>
  8012fb:	83 c4 18             	add    $0x18,%esp
}
  8012fe:	c9                   	leave  
  8012ff:	c3                   	ret    

00801300 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801300:	55                   	push   %ebp
  801301:	89 e5                	mov    %esp,%ebp
  801303:	56                   	push   %esi
  801304:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801305:	8b 75 18             	mov    0x18(%ebp),%esi
  801308:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80130b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80130e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801311:	8b 45 08             	mov    0x8(%ebp),%eax
  801314:	56                   	push   %esi
  801315:	53                   	push   %ebx
  801316:	51                   	push   %ecx
  801317:	52                   	push   %edx
  801318:	50                   	push   %eax
  801319:	6a 08                	push   $0x8
  80131b:	e8 d6 fe ff ff       	call   8011f6 <syscall>
  801320:	83 c4 18             	add    $0x18,%esp
}
  801323:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801326:	5b                   	pop    %ebx
  801327:	5e                   	pop    %esi
  801328:	5d                   	pop    %ebp
  801329:	c3                   	ret    

0080132a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80132a:	55                   	push   %ebp
  80132b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80132d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	6a 00                	push   $0x0
  801335:	6a 00                	push   $0x0
  801337:	6a 00                	push   $0x0
  801339:	52                   	push   %edx
  80133a:	50                   	push   %eax
  80133b:	6a 09                	push   $0x9
  80133d:	e8 b4 fe ff ff       	call   8011f6 <syscall>
  801342:	83 c4 18             	add    $0x18,%esp
}
  801345:	c9                   	leave  
  801346:	c3                   	ret    

00801347 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801347:	55                   	push   %ebp
  801348:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80134a:	6a 00                	push   $0x0
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	ff 75 0c             	pushl  0xc(%ebp)
  801353:	ff 75 08             	pushl  0x8(%ebp)
  801356:	6a 0a                	push   $0xa
  801358:	e8 99 fe ff ff       	call   8011f6 <syscall>
  80135d:	83 c4 18             	add    $0x18,%esp
}
  801360:	c9                   	leave  
  801361:	c3                   	ret    

00801362 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	6a 00                	push   $0x0
  80136d:	6a 00                	push   $0x0
  80136f:	6a 0b                	push   $0xb
  801371:	e8 80 fe ff ff       	call   8011f6 <syscall>
  801376:	83 c4 18             	add    $0x18,%esp
}
  801379:	c9                   	leave  
  80137a:	c3                   	ret    

0080137b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	6a 00                	push   $0x0
  801388:	6a 0c                	push   $0xc
  80138a:	e8 67 fe ff ff       	call   8011f6 <syscall>
  80138f:	83 c4 18             	add    $0x18,%esp
}
  801392:	c9                   	leave  
  801393:	c3                   	ret    

00801394 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801394:	55                   	push   %ebp
  801395:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801397:	6a 00                	push   $0x0
  801399:	6a 00                	push   $0x0
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 0d                	push   $0xd
  8013a3:	e8 4e fe ff ff       	call   8011f6 <syscall>
  8013a8:	83 c4 18             	add    $0x18,%esp
}
  8013ab:	c9                   	leave  
  8013ac:	c3                   	ret    

008013ad <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8013ad:	55                   	push   %ebp
  8013ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8013b0:	6a 00                	push   $0x0
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	ff 75 0c             	pushl  0xc(%ebp)
  8013b9:	ff 75 08             	pushl  0x8(%ebp)
  8013bc:	6a 11                	push   $0x11
  8013be:	e8 33 fe ff ff       	call   8011f6 <syscall>
  8013c3:	83 c4 18             	add    $0x18,%esp
	return;
  8013c6:	90                   	nop
}
  8013c7:	c9                   	leave  
  8013c8:	c3                   	ret    

008013c9 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	ff 75 0c             	pushl  0xc(%ebp)
  8013d5:	ff 75 08             	pushl  0x8(%ebp)
  8013d8:	6a 12                	push   $0x12
  8013da:	e8 17 fe ff ff       	call   8011f6 <syscall>
  8013df:	83 c4 18             	add    $0x18,%esp
	return ;
  8013e2:	90                   	nop
}
  8013e3:	c9                   	leave  
  8013e4:	c3                   	ret    

008013e5 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8013e5:	55                   	push   %ebp
  8013e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 0e                	push   $0xe
  8013f4:	e8 fd fd ff ff       	call   8011f6 <syscall>
  8013f9:	83 c4 18             	add    $0x18,%esp
}
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	ff 75 08             	pushl  0x8(%ebp)
  80140c:	6a 0f                	push   $0xf
  80140e:	e8 e3 fd ff ff       	call   8011f6 <syscall>
  801413:	83 c4 18             	add    $0x18,%esp
}
  801416:	c9                   	leave  
  801417:	c3                   	ret    

00801418 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 10                	push   $0x10
  801427:	e8 ca fd ff ff       	call   8011f6 <syscall>
  80142c:	83 c4 18             	add    $0x18,%esp
}
  80142f:	90                   	nop
  801430:	c9                   	leave  
  801431:	c3                   	ret    

00801432 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	6a 00                	push   $0x0
  80143f:	6a 14                	push   $0x14
  801441:	e8 b0 fd ff ff       	call   8011f6 <syscall>
  801446:	83 c4 18             	add    $0x18,%esp
}
  801449:	90                   	nop
  80144a:	c9                   	leave  
  80144b:	c3                   	ret    

0080144c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80144c:	55                   	push   %ebp
  80144d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	6a 00                	push   $0x0
  801459:	6a 15                	push   $0x15
  80145b:	e8 96 fd ff ff       	call   8011f6 <syscall>
  801460:	83 c4 18             	add    $0x18,%esp
}
  801463:	90                   	nop
  801464:	c9                   	leave  
  801465:	c3                   	ret    

00801466 <sys_cputc>:


void
sys_cputc(const char c)
{
  801466:	55                   	push   %ebp
  801467:	89 e5                	mov    %esp,%ebp
  801469:	83 ec 04             	sub    $0x4,%esp
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801472:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	50                   	push   %eax
  80147f:	6a 16                	push   $0x16
  801481:	e8 70 fd ff ff       	call   8011f6 <syscall>
  801486:	83 c4 18             	add    $0x18,%esp
}
  801489:	90                   	nop
  80148a:	c9                   	leave  
  80148b:	c3                   	ret    

0080148c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80148c:	55                   	push   %ebp
  80148d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 17                	push   $0x17
  80149b:	e8 56 fd ff ff       	call   8011f6 <syscall>
  8014a0:	83 c4 18             	add    $0x18,%esp
}
  8014a3:	90                   	nop
  8014a4:	c9                   	leave  
  8014a5:	c3                   	ret    

008014a6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014a6:	55                   	push   %ebp
  8014a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	ff 75 0c             	pushl  0xc(%ebp)
  8014b5:	50                   	push   %eax
  8014b6:	6a 18                	push   $0x18
  8014b8:	e8 39 fd ff ff       	call   8011f6 <syscall>
  8014bd:	83 c4 18             	add    $0x18,%esp
}
  8014c0:	c9                   	leave  
  8014c1:	c3                   	ret    

008014c2 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8014c2:	55                   	push   %ebp
  8014c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	52                   	push   %edx
  8014d2:	50                   	push   %eax
  8014d3:	6a 1b                	push   $0x1b
  8014d5:	e8 1c fd ff ff       	call   8011f6 <syscall>
  8014da:	83 c4 18             	add    $0x18,%esp
}
  8014dd:	c9                   	leave  
  8014de:	c3                   	ret    

008014df <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014df:	55                   	push   %ebp
  8014e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	52                   	push   %edx
  8014ef:	50                   	push   %eax
  8014f0:	6a 19                	push   $0x19
  8014f2:	e8 ff fc ff ff       	call   8011f6 <syscall>
  8014f7:	83 c4 18             	add    $0x18,%esp
}
  8014fa:	90                   	nop
  8014fb:	c9                   	leave  
  8014fc:	c3                   	ret    

008014fd <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014fd:	55                   	push   %ebp
  8014fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801500:	8b 55 0c             	mov    0xc(%ebp),%edx
  801503:	8b 45 08             	mov    0x8(%ebp),%eax
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	52                   	push   %edx
  80150d:	50                   	push   %eax
  80150e:	6a 1a                	push   $0x1a
  801510:	e8 e1 fc ff ff       	call   8011f6 <syscall>
  801515:	83 c4 18             	add    $0x18,%esp
}
  801518:	90                   	nop
  801519:	c9                   	leave  
  80151a:	c3                   	ret    

0080151b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80151b:	55                   	push   %ebp
  80151c:	89 e5                	mov    %esp,%ebp
  80151e:	83 ec 04             	sub    $0x4,%esp
  801521:	8b 45 10             	mov    0x10(%ebp),%eax
  801524:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801527:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80152a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80152e:	8b 45 08             	mov    0x8(%ebp),%eax
  801531:	6a 00                	push   $0x0
  801533:	51                   	push   %ecx
  801534:	52                   	push   %edx
  801535:	ff 75 0c             	pushl  0xc(%ebp)
  801538:	50                   	push   %eax
  801539:	6a 1c                	push   $0x1c
  80153b:	e8 b6 fc ff ff       	call   8011f6 <syscall>
  801540:	83 c4 18             	add    $0x18,%esp
}
  801543:	c9                   	leave  
  801544:	c3                   	ret    

00801545 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801548:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	52                   	push   %edx
  801555:	50                   	push   %eax
  801556:	6a 1d                	push   $0x1d
  801558:	e8 99 fc ff ff       	call   8011f6 <syscall>
  80155d:	83 c4 18             	add    $0x18,%esp
}
  801560:	c9                   	leave  
  801561:	c3                   	ret    

00801562 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801562:	55                   	push   %ebp
  801563:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801565:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801568:	8b 55 0c             	mov    0xc(%ebp),%edx
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	51                   	push   %ecx
  801573:	52                   	push   %edx
  801574:	50                   	push   %eax
  801575:	6a 1e                	push   $0x1e
  801577:	e8 7a fc ff ff       	call   8011f6 <syscall>
  80157c:	83 c4 18             	add    $0x18,%esp
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801584:	8b 55 0c             	mov    0xc(%ebp),%edx
  801587:	8b 45 08             	mov    0x8(%ebp),%eax
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	52                   	push   %edx
  801591:	50                   	push   %eax
  801592:	6a 1f                	push   $0x1f
  801594:	e8 5d fc ff ff       	call   8011f6 <syscall>
  801599:	83 c4 18             	add    $0x18,%esp
}
  80159c:	c9                   	leave  
  80159d:	c3                   	ret    

0080159e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80159e:	55                   	push   %ebp
  80159f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 20                	push   $0x20
  8015ad:	e8 44 fc ff ff       	call   8011f6 <syscall>
  8015b2:	83 c4 18             	add    $0x18,%esp
}
  8015b5:	c9                   	leave  
  8015b6:	c3                   	ret    

008015b7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8015b7:	55                   	push   %ebp
  8015b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8015ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bd:	6a 00                	push   $0x0
  8015bf:	ff 75 14             	pushl  0x14(%ebp)
  8015c2:	ff 75 10             	pushl  0x10(%ebp)
  8015c5:	ff 75 0c             	pushl  0xc(%ebp)
  8015c8:	50                   	push   %eax
  8015c9:	6a 21                	push   $0x21
  8015cb:	e8 26 fc ff ff       	call   8011f6 <syscall>
  8015d0:	83 c4 18             	add    $0x18,%esp
}
  8015d3:	c9                   	leave  
  8015d4:	c3                   	ret    

008015d5 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8015d5:	55                   	push   %ebp
  8015d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	50                   	push   %eax
  8015e4:	6a 22                	push   $0x22
  8015e6:	e8 0b fc ff ff       	call   8011f6 <syscall>
  8015eb:	83 c4 18             	add    $0x18,%esp
}
  8015ee:	90                   	nop
  8015ef:	c9                   	leave  
  8015f0:	c3                   	ret    

008015f1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8015f1:	55                   	push   %ebp
  8015f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8015f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	50                   	push   %eax
  801600:	6a 23                	push   $0x23
  801602:	e8 ef fb ff ff       	call   8011f6 <syscall>
  801607:	83 c4 18             	add    $0x18,%esp
}
  80160a:	90                   	nop
  80160b:	c9                   	leave  
  80160c:	c3                   	ret    

0080160d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80160d:	55                   	push   %ebp
  80160e:	89 e5                	mov    %esp,%ebp
  801610:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801613:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801616:	8d 50 04             	lea    0x4(%eax),%edx
  801619:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	52                   	push   %edx
  801623:	50                   	push   %eax
  801624:	6a 24                	push   $0x24
  801626:	e8 cb fb ff ff       	call   8011f6 <syscall>
  80162b:	83 c4 18             	add    $0x18,%esp
	return result;
  80162e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801631:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801634:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801637:	89 01                	mov    %eax,(%ecx)
  801639:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80163c:	8b 45 08             	mov    0x8(%ebp),%eax
  80163f:	c9                   	leave  
  801640:	c2 04 00             	ret    $0x4

00801643 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801643:	55                   	push   %ebp
  801644:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	ff 75 10             	pushl  0x10(%ebp)
  80164d:	ff 75 0c             	pushl  0xc(%ebp)
  801650:	ff 75 08             	pushl  0x8(%ebp)
  801653:	6a 13                	push   $0x13
  801655:	e8 9c fb ff ff       	call   8011f6 <syscall>
  80165a:	83 c4 18             	add    $0x18,%esp
	return ;
  80165d:	90                   	nop
}
  80165e:	c9                   	leave  
  80165f:	c3                   	ret    

00801660 <sys_rcr2>:
uint32 sys_rcr2()
{
  801660:	55                   	push   %ebp
  801661:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 25                	push   $0x25
  80166f:	e8 82 fb ff ff       	call   8011f6 <syscall>
  801674:	83 c4 18             	add    $0x18,%esp
}
  801677:	c9                   	leave  
  801678:	c3                   	ret    

00801679 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801679:	55                   	push   %ebp
  80167a:	89 e5                	mov    %esp,%ebp
  80167c:	83 ec 04             	sub    $0x4,%esp
  80167f:	8b 45 08             	mov    0x8(%ebp),%eax
  801682:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801685:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	50                   	push   %eax
  801692:	6a 26                	push   $0x26
  801694:	e8 5d fb ff ff       	call   8011f6 <syscall>
  801699:	83 c4 18             	add    $0x18,%esp
	return ;
  80169c:	90                   	nop
}
  80169d:	c9                   	leave  
  80169e:	c3                   	ret    

0080169f <rsttst>:
void rsttst()
{
  80169f:	55                   	push   %ebp
  8016a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 28                	push   $0x28
  8016ae:	e8 43 fb ff ff       	call   8011f6 <syscall>
  8016b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8016b6:	90                   	nop
}
  8016b7:	c9                   	leave  
  8016b8:	c3                   	ret    

008016b9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8016b9:	55                   	push   %ebp
  8016ba:	89 e5                	mov    %esp,%ebp
  8016bc:	83 ec 04             	sub    $0x4,%esp
  8016bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8016c2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016c5:	8b 55 18             	mov    0x18(%ebp),%edx
  8016c8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016cc:	52                   	push   %edx
  8016cd:	50                   	push   %eax
  8016ce:	ff 75 10             	pushl  0x10(%ebp)
  8016d1:	ff 75 0c             	pushl  0xc(%ebp)
  8016d4:	ff 75 08             	pushl  0x8(%ebp)
  8016d7:	6a 27                	push   $0x27
  8016d9:	e8 18 fb ff ff       	call   8011f6 <syscall>
  8016de:	83 c4 18             	add    $0x18,%esp
	return ;
  8016e1:	90                   	nop
}
  8016e2:	c9                   	leave  
  8016e3:	c3                   	ret    

008016e4 <chktst>:
void chktst(uint32 n)
{
  8016e4:	55                   	push   %ebp
  8016e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	ff 75 08             	pushl  0x8(%ebp)
  8016f2:	6a 29                	push   $0x29
  8016f4:	e8 fd fa ff ff       	call   8011f6 <syscall>
  8016f9:	83 c4 18             	add    $0x18,%esp
	return ;
  8016fc:	90                   	nop
}
  8016fd:	c9                   	leave  
  8016fe:	c3                   	ret    

008016ff <inctst>:

void inctst()
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 2a                	push   $0x2a
  80170e:	e8 e3 fa ff ff       	call   8011f6 <syscall>
  801713:	83 c4 18             	add    $0x18,%esp
	return ;
  801716:	90                   	nop
}
  801717:	c9                   	leave  
  801718:	c3                   	ret    

00801719 <gettst>:
uint32 gettst()
{
  801719:	55                   	push   %ebp
  80171a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	6a 2b                	push   $0x2b
  801728:	e8 c9 fa ff ff       	call   8011f6 <syscall>
  80172d:	83 c4 18             	add    $0x18,%esp
}
  801730:	c9                   	leave  
  801731:	c3                   	ret    

00801732 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801732:	55                   	push   %ebp
  801733:	89 e5                	mov    %esp,%ebp
  801735:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 2c                	push   $0x2c
  801744:	e8 ad fa ff ff       	call   8011f6 <syscall>
  801749:	83 c4 18             	add    $0x18,%esp
  80174c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80174f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801753:	75 07                	jne    80175c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801755:	b8 01 00 00 00       	mov    $0x1,%eax
  80175a:	eb 05                	jmp    801761 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80175c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801761:	c9                   	leave  
  801762:	c3                   	ret    

00801763 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
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
  801775:	e8 7c fa ff ff       	call   8011f6 <syscall>
  80177a:	83 c4 18             	add    $0x18,%esp
  80177d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801780:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801784:	75 07                	jne    80178d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801786:	b8 01 00 00 00       	mov    $0x1,%eax
  80178b:	eb 05                	jmp    801792 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80178d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801792:	c9                   	leave  
  801793:	c3                   	ret    

00801794 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
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
  8017a6:	e8 4b fa ff ff       	call   8011f6 <syscall>
  8017ab:	83 c4 18             	add    $0x18,%esp
  8017ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8017b1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8017b5:	75 07                	jne    8017be <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8017b7:	b8 01 00 00 00       	mov    $0x1,%eax
  8017bc:	eb 05                	jmp    8017c3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8017be:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017c3:	c9                   	leave  
  8017c4:	c3                   	ret    

008017c5 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
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
  8017d7:	e8 1a fa ff ff       	call   8011f6 <syscall>
  8017dc:	83 c4 18             	add    $0x18,%esp
  8017df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8017e2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8017e6:	75 07                	jne    8017ef <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8017e8:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ed:	eb 05                	jmp    8017f4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8017ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	ff 75 08             	pushl  0x8(%ebp)
  801804:	6a 2d                	push   $0x2d
  801806:	e8 eb f9 ff ff       	call   8011f6 <syscall>
  80180b:	83 c4 18             	add    $0x18,%esp
	return ;
  80180e:	90                   	nop
}
  80180f:	c9                   	leave  
  801810:	c3                   	ret    

00801811 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801811:	55                   	push   %ebp
  801812:	89 e5                	mov    %esp,%ebp
  801814:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801815:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801818:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80181b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181e:	8b 45 08             	mov    0x8(%ebp),%eax
  801821:	6a 00                	push   $0x0
  801823:	53                   	push   %ebx
  801824:	51                   	push   %ecx
  801825:	52                   	push   %edx
  801826:	50                   	push   %eax
  801827:	6a 2e                	push   $0x2e
  801829:	e8 c8 f9 ff ff       	call   8011f6 <syscall>
  80182e:	83 c4 18             	add    $0x18,%esp
}
  801831:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801834:	c9                   	leave  
  801835:	c3                   	ret    

00801836 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801839:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183c:	8b 45 08             	mov    0x8(%ebp),%eax
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	52                   	push   %edx
  801846:	50                   	push   %eax
  801847:	6a 2f                	push   $0x2f
  801849:	e8 a8 f9 ff ff       	call   8011f6 <syscall>
  80184e:	83 c4 18             	add    $0x18,%esp
}
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	ff 75 0c             	pushl  0xc(%ebp)
  80185f:	ff 75 08             	pushl  0x8(%ebp)
  801862:	6a 30                	push   $0x30
  801864:	e8 8d f9 ff ff       	call   8011f6 <syscall>
  801869:	83 c4 18             	add    $0x18,%esp
	return ;
  80186c:	90                   	nop
}
  80186d:	c9                   	leave  
  80186e:	c3                   	ret    
  80186f:	90                   	nop

00801870 <__udivdi3>:
  801870:	55                   	push   %ebp
  801871:	57                   	push   %edi
  801872:	56                   	push   %esi
  801873:	53                   	push   %ebx
  801874:	83 ec 1c             	sub    $0x1c,%esp
  801877:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80187b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80187f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801883:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801887:	89 ca                	mov    %ecx,%edx
  801889:	89 f8                	mov    %edi,%eax
  80188b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80188f:	85 f6                	test   %esi,%esi
  801891:	75 2d                	jne    8018c0 <__udivdi3+0x50>
  801893:	39 cf                	cmp    %ecx,%edi
  801895:	77 65                	ja     8018fc <__udivdi3+0x8c>
  801897:	89 fd                	mov    %edi,%ebp
  801899:	85 ff                	test   %edi,%edi
  80189b:	75 0b                	jne    8018a8 <__udivdi3+0x38>
  80189d:	b8 01 00 00 00       	mov    $0x1,%eax
  8018a2:	31 d2                	xor    %edx,%edx
  8018a4:	f7 f7                	div    %edi
  8018a6:	89 c5                	mov    %eax,%ebp
  8018a8:	31 d2                	xor    %edx,%edx
  8018aa:	89 c8                	mov    %ecx,%eax
  8018ac:	f7 f5                	div    %ebp
  8018ae:	89 c1                	mov    %eax,%ecx
  8018b0:	89 d8                	mov    %ebx,%eax
  8018b2:	f7 f5                	div    %ebp
  8018b4:	89 cf                	mov    %ecx,%edi
  8018b6:	89 fa                	mov    %edi,%edx
  8018b8:	83 c4 1c             	add    $0x1c,%esp
  8018bb:	5b                   	pop    %ebx
  8018bc:	5e                   	pop    %esi
  8018bd:	5f                   	pop    %edi
  8018be:	5d                   	pop    %ebp
  8018bf:	c3                   	ret    
  8018c0:	39 ce                	cmp    %ecx,%esi
  8018c2:	77 28                	ja     8018ec <__udivdi3+0x7c>
  8018c4:	0f bd fe             	bsr    %esi,%edi
  8018c7:	83 f7 1f             	xor    $0x1f,%edi
  8018ca:	75 40                	jne    80190c <__udivdi3+0x9c>
  8018cc:	39 ce                	cmp    %ecx,%esi
  8018ce:	72 0a                	jb     8018da <__udivdi3+0x6a>
  8018d0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8018d4:	0f 87 9e 00 00 00    	ja     801978 <__udivdi3+0x108>
  8018da:	b8 01 00 00 00       	mov    $0x1,%eax
  8018df:	89 fa                	mov    %edi,%edx
  8018e1:	83 c4 1c             	add    $0x1c,%esp
  8018e4:	5b                   	pop    %ebx
  8018e5:	5e                   	pop    %esi
  8018e6:	5f                   	pop    %edi
  8018e7:	5d                   	pop    %ebp
  8018e8:	c3                   	ret    
  8018e9:	8d 76 00             	lea    0x0(%esi),%esi
  8018ec:	31 ff                	xor    %edi,%edi
  8018ee:	31 c0                	xor    %eax,%eax
  8018f0:	89 fa                	mov    %edi,%edx
  8018f2:	83 c4 1c             	add    $0x1c,%esp
  8018f5:	5b                   	pop    %ebx
  8018f6:	5e                   	pop    %esi
  8018f7:	5f                   	pop    %edi
  8018f8:	5d                   	pop    %ebp
  8018f9:	c3                   	ret    
  8018fa:	66 90                	xchg   %ax,%ax
  8018fc:	89 d8                	mov    %ebx,%eax
  8018fe:	f7 f7                	div    %edi
  801900:	31 ff                	xor    %edi,%edi
  801902:	89 fa                	mov    %edi,%edx
  801904:	83 c4 1c             	add    $0x1c,%esp
  801907:	5b                   	pop    %ebx
  801908:	5e                   	pop    %esi
  801909:	5f                   	pop    %edi
  80190a:	5d                   	pop    %ebp
  80190b:	c3                   	ret    
  80190c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801911:	89 eb                	mov    %ebp,%ebx
  801913:	29 fb                	sub    %edi,%ebx
  801915:	89 f9                	mov    %edi,%ecx
  801917:	d3 e6                	shl    %cl,%esi
  801919:	89 c5                	mov    %eax,%ebp
  80191b:	88 d9                	mov    %bl,%cl
  80191d:	d3 ed                	shr    %cl,%ebp
  80191f:	89 e9                	mov    %ebp,%ecx
  801921:	09 f1                	or     %esi,%ecx
  801923:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801927:	89 f9                	mov    %edi,%ecx
  801929:	d3 e0                	shl    %cl,%eax
  80192b:	89 c5                	mov    %eax,%ebp
  80192d:	89 d6                	mov    %edx,%esi
  80192f:	88 d9                	mov    %bl,%cl
  801931:	d3 ee                	shr    %cl,%esi
  801933:	89 f9                	mov    %edi,%ecx
  801935:	d3 e2                	shl    %cl,%edx
  801937:	8b 44 24 08          	mov    0x8(%esp),%eax
  80193b:	88 d9                	mov    %bl,%cl
  80193d:	d3 e8                	shr    %cl,%eax
  80193f:	09 c2                	or     %eax,%edx
  801941:	89 d0                	mov    %edx,%eax
  801943:	89 f2                	mov    %esi,%edx
  801945:	f7 74 24 0c          	divl   0xc(%esp)
  801949:	89 d6                	mov    %edx,%esi
  80194b:	89 c3                	mov    %eax,%ebx
  80194d:	f7 e5                	mul    %ebp
  80194f:	39 d6                	cmp    %edx,%esi
  801951:	72 19                	jb     80196c <__udivdi3+0xfc>
  801953:	74 0b                	je     801960 <__udivdi3+0xf0>
  801955:	89 d8                	mov    %ebx,%eax
  801957:	31 ff                	xor    %edi,%edi
  801959:	e9 58 ff ff ff       	jmp    8018b6 <__udivdi3+0x46>
  80195e:	66 90                	xchg   %ax,%ax
  801960:	8b 54 24 08          	mov    0x8(%esp),%edx
  801964:	89 f9                	mov    %edi,%ecx
  801966:	d3 e2                	shl    %cl,%edx
  801968:	39 c2                	cmp    %eax,%edx
  80196a:	73 e9                	jae    801955 <__udivdi3+0xe5>
  80196c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80196f:	31 ff                	xor    %edi,%edi
  801971:	e9 40 ff ff ff       	jmp    8018b6 <__udivdi3+0x46>
  801976:	66 90                	xchg   %ax,%ax
  801978:	31 c0                	xor    %eax,%eax
  80197a:	e9 37 ff ff ff       	jmp    8018b6 <__udivdi3+0x46>
  80197f:	90                   	nop

00801980 <__umoddi3>:
  801980:	55                   	push   %ebp
  801981:	57                   	push   %edi
  801982:	56                   	push   %esi
  801983:	53                   	push   %ebx
  801984:	83 ec 1c             	sub    $0x1c,%esp
  801987:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80198b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80198f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801993:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801997:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80199b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80199f:	89 f3                	mov    %esi,%ebx
  8019a1:	89 fa                	mov    %edi,%edx
  8019a3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8019a7:	89 34 24             	mov    %esi,(%esp)
  8019aa:	85 c0                	test   %eax,%eax
  8019ac:	75 1a                	jne    8019c8 <__umoddi3+0x48>
  8019ae:	39 f7                	cmp    %esi,%edi
  8019b0:	0f 86 a2 00 00 00    	jbe    801a58 <__umoddi3+0xd8>
  8019b6:	89 c8                	mov    %ecx,%eax
  8019b8:	89 f2                	mov    %esi,%edx
  8019ba:	f7 f7                	div    %edi
  8019bc:	89 d0                	mov    %edx,%eax
  8019be:	31 d2                	xor    %edx,%edx
  8019c0:	83 c4 1c             	add    $0x1c,%esp
  8019c3:	5b                   	pop    %ebx
  8019c4:	5e                   	pop    %esi
  8019c5:	5f                   	pop    %edi
  8019c6:	5d                   	pop    %ebp
  8019c7:	c3                   	ret    
  8019c8:	39 f0                	cmp    %esi,%eax
  8019ca:	0f 87 ac 00 00 00    	ja     801a7c <__umoddi3+0xfc>
  8019d0:	0f bd e8             	bsr    %eax,%ebp
  8019d3:	83 f5 1f             	xor    $0x1f,%ebp
  8019d6:	0f 84 ac 00 00 00    	je     801a88 <__umoddi3+0x108>
  8019dc:	bf 20 00 00 00       	mov    $0x20,%edi
  8019e1:	29 ef                	sub    %ebp,%edi
  8019e3:	89 fe                	mov    %edi,%esi
  8019e5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8019e9:	89 e9                	mov    %ebp,%ecx
  8019eb:	d3 e0                	shl    %cl,%eax
  8019ed:	89 d7                	mov    %edx,%edi
  8019ef:	89 f1                	mov    %esi,%ecx
  8019f1:	d3 ef                	shr    %cl,%edi
  8019f3:	09 c7                	or     %eax,%edi
  8019f5:	89 e9                	mov    %ebp,%ecx
  8019f7:	d3 e2                	shl    %cl,%edx
  8019f9:	89 14 24             	mov    %edx,(%esp)
  8019fc:	89 d8                	mov    %ebx,%eax
  8019fe:	d3 e0                	shl    %cl,%eax
  801a00:	89 c2                	mov    %eax,%edx
  801a02:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a06:	d3 e0                	shl    %cl,%eax
  801a08:	89 44 24 04          	mov    %eax,0x4(%esp)
  801a0c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a10:	89 f1                	mov    %esi,%ecx
  801a12:	d3 e8                	shr    %cl,%eax
  801a14:	09 d0                	or     %edx,%eax
  801a16:	d3 eb                	shr    %cl,%ebx
  801a18:	89 da                	mov    %ebx,%edx
  801a1a:	f7 f7                	div    %edi
  801a1c:	89 d3                	mov    %edx,%ebx
  801a1e:	f7 24 24             	mull   (%esp)
  801a21:	89 c6                	mov    %eax,%esi
  801a23:	89 d1                	mov    %edx,%ecx
  801a25:	39 d3                	cmp    %edx,%ebx
  801a27:	0f 82 87 00 00 00    	jb     801ab4 <__umoddi3+0x134>
  801a2d:	0f 84 91 00 00 00    	je     801ac4 <__umoddi3+0x144>
  801a33:	8b 54 24 04          	mov    0x4(%esp),%edx
  801a37:	29 f2                	sub    %esi,%edx
  801a39:	19 cb                	sbb    %ecx,%ebx
  801a3b:	89 d8                	mov    %ebx,%eax
  801a3d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801a41:	d3 e0                	shl    %cl,%eax
  801a43:	89 e9                	mov    %ebp,%ecx
  801a45:	d3 ea                	shr    %cl,%edx
  801a47:	09 d0                	or     %edx,%eax
  801a49:	89 e9                	mov    %ebp,%ecx
  801a4b:	d3 eb                	shr    %cl,%ebx
  801a4d:	89 da                	mov    %ebx,%edx
  801a4f:	83 c4 1c             	add    $0x1c,%esp
  801a52:	5b                   	pop    %ebx
  801a53:	5e                   	pop    %esi
  801a54:	5f                   	pop    %edi
  801a55:	5d                   	pop    %ebp
  801a56:	c3                   	ret    
  801a57:	90                   	nop
  801a58:	89 fd                	mov    %edi,%ebp
  801a5a:	85 ff                	test   %edi,%edi
  801a5c:	75 0b                	jne    801a69 <__umoddi3+0xe9>
  801a5e:	b8 01 00 00 00       	mov    $0x1,%eax
  801a63:	31 d2                	xor    %edx,%edx
  801a65:	f7 f7                	div    %edi
  801a67:	89 c5                	mov    %eax,%ebp
  801a69:	89 f0                	mov    %esi,%eax
  801a6b:	31 d2                	xor    %edx,%edx
  801a6d:	f7 f5                	div    %ebp
  801a6f:	89 c8                	mov    %ecx,%eax
  801a71:	f7 f5                	div    %ebp
  801a73:	89 d0                	mov    %edx,%eax
  801a75:	e9 44 ff ff ff       	jmp    8019be <__umoddi3+0x3e>
  801a7a:	66 90                	xchg   %ax,%ax
  801a7c:	89 c8                	mov    %ecx,%eax
  801a7e:	89 f2                	mov    %esi,%edx
  801a80:	83 c4 1c             	add    $0x1c,%esp
  801a83:	5b                   	pop    %ebx
  801a84:	5e                   	pop    %esi
  801a85:	5f                   	pop    %edi
  801a86:	5d                   	pop    %ebp
  801a87:	c3                   	ret    
  801a88:	3b 04 24             	cmp    (%esp),%eax
  801a8b:	72 06                	jb     801a93 <__umoddi3+0x113>
  801a8d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801a91:	77 0f                	ja     801aa2 <__umoddi3+0x122>
  801a93:	89 f2                	mov    %esi,%edx
  801a95:	29 f9                	sub    %edi,%ecx
  801a97:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801a9b:	89 14 24             	mov    %edx,(%esp)
  801a9e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801aa2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801aa6:	8b 14 24             	mov    (%esp),%edx
  801aa9:	83 c4 1c             	add    $0x1c,%esp
  801aac:	5b                   	pop    %ebx
  801aad:	5e                   	pop    %esi
  801aae:	5f                   	pop    %edi
  801aaf:	5d                   	pop    %ebp
  801ab0:	c3                   	ret    
  801ab1:	8d 76 00             	lea    0x0(%esi),%esi
  801ab4:	2b 04 24             	sub    (%esp),%eax
  801ab7:	19 fa                	sbb    %edi,%edx
  801ab9:	89 d1                	mov    %edx,%ecx
  801abb:	89 c6                	mov    %eax,%esi
  801abd:	e9 71 ff ff ff       	jmp    801a33 <__umoddi3+0xb3>
  801ac2:	66 90                	xchg   %ax,%ax
  801ac4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ac8:	72 ea                	jb     801ab4 <__umoddi3+0x134>
  801aca:	89 d9                	mov    %ebx,%ecx
  801acc:	e9 62 ff ff ff       	jmp    801a33 <__umoddi3+0xb3>
