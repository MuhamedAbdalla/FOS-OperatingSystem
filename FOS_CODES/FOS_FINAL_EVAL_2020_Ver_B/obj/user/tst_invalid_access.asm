
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
  800088:	e8 25 01 00 00       	call   8001b2 <_panic>

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
  800093:	e8 fc 11 00 00       	call   801294 <sys_getenvindex>
  800098:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80009b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80009e:	89 d0                	mov    %edx,%eax
  8000a0:	c1 e0 03             	shl    $0x3,%eax
  8000a3:	01 d0                	add    %edx,%eax
  8000a5:	c1 e0 02             	shl    $0x2,%eax
  8000a8:	01 d0                	add    %edx,%eax
  8000aa:	c1 e0 06             	shl    $0x6,%eax
  8000ad:	29 d0                	sub    %edx,%eax
  8000af:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000b6:	01 c8                	add    %ecx,%eax
  8000b8:	01 d0                	add    %edx,%eax
  8000ba:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000bf:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000c4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c9:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8000cf:	84 c0                	test   %al,%al
  8000d1:	74 0f                	je     8000e2 <libmain+0x55>
		binaryname = myEnv->prog_name;
  8000d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d8:	05 b0 52 00 00       	add    $0x52b0,%eax
  8000dd:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000e2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000e6:	7e 0a                	jle    8000f2 <libmain+0x65>
		binaryname = argv[0];
  8000e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8000f2:	83 ec 08             	sub    $0x8,%esp
  8000f5:	ff 75 0c             	pushl  0xc(%ebp)
  8000f8:	ff 75 08             	pushl  0x8(%ebp)
  8000fb:	e8 38 ff ff ff       	call   800038 <_main>
  800100:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800103:	e8 27 13 00 00       	call   80142f <sys_disable_interrupt>
	cprintf("**************************************\n");
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	68 1c 1c 80 00       	push   $0x801c1c
  800110:	e8 54 03 00 00       	call   800469 <cprintf>
  800115:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800118:	a1 20 30 80 00       	mov    0x803020,%eax
  80011d:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800123:	a1 20 30 80 00       	mov    0x803020,%eax
  800128:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  80012e:	83 ec 04             	sub    $0x4,%esp
  800131:	52                   	push   %edx
  800132:	50                   	push   %eax
  800133:	68 44 1c 80 00       	push   $0x801c44
  800138:	e8 2c 03 00 00       	call   800469 <cprintf>
  80013d:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800140:	a1 20 30 80 00       	mov    0x803020,%eax
  800145:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  80014b:	a1 20 30 80 00       	mov    0x803020,%eax
  800150:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800156:	a1 20 30 80 00       	mov    0x803020,%eax
  80015b:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800161:	51                   	push   %ecx
  800162:	52                   	push   %edx
  800163:	50                   	push   %eax
  800164:	68 6c 1c 80 00       	push   $0x801c6c
  800169:	e8 fb 02 00 00       	call   800469 <cprintf>
  80016e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800171:	83 ec 0c             	sub    $0xc,%esp
  800174:	68 1c 1c 80 00       	push   $0x801c1c
  800179:	e8 eb 02 00 00       	call   800469 <cprintf>
  80017e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800181:	e8 c3 12 00 00       	call   801449 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800186:	e8 19 00 00 00       	call   8001a4 <exit>
}
  80018b:	90                   	nop
  80018c:	c9                   	leave  
  80018d:	c3                   	ret    

0080018e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80018e:	55                   	push   %ebp
  80018f:	89 e5                	mov    %esp,%ebp
  800191:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800194:	83 ec 0c             	sub    $0xc,%esp
  800197:	6a 00                	push   $0x0
  800199:	e8 c2 10 00 00       	call   801260 <sys_env_destroy>
  80019e:	83 c4 10             	add    $0x10,%esp
}
  8001a1:	90                   	nop
  8001a2:	c9                   	leave  
  8001a3:	c3                   	ret    

008001a4 <exit>:

void
exit(void)
{
  8001a4:	55                   	push   %ebp
  8001a5:	89 e5                	mov    %esp,%ebp
  8001a7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001aa:	e8 17 11 00 00       	call   8012c6 <sys_env_exit>
}
  8001af:	90                   	nop
  8001b0:	c9                   	leave  
  8001b1:	c3                   	ret    

008001b2 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8001b2:	55                   	push   %ebp
  8001b3:	89 e5                	mov    %esp,%ebp
  8001b5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8001b8:	8d 45 10             	lea    0x10(%ebp),%eax
  8001bb:	83 c0 04             	add    $0x4,%eax
  8001be:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8001c1:	a1 18 31 80 00       	mov    0x803118,%eax
  8001c6:	85 c0                	test   %eax,%eax
  8001c8:	74 16                	je     8001e0 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8001ca:	a1 18 31 80 00       	mov    0x803118,%eax
  8001cf:	83 ec 08             	sub    $0x8,%esp
  8001d2:	50                   	push   %eax
  8001d3:	68 c4 1c 80 00       	push   $0x801cc4
  8001d8:	e8 8c 02 00 00       	call   800469 <cprintf>
  8001dd:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8001e0:	a1 00 30 80 00       	mov    0x803000,%eax
  8001e5:	ff 75 0c             	pushl  0xc(%ebp)
  8001e8:	ff 75 08             	pushl  0x8(%ebp)
  8001eb:	50                   	push   %eax
  8001ec:	68 c9 1c 80 00       	push   $0x801cc9
  8001f1:	e8 73 02 00 00       	call   800469 <cprintf>
  8001f6:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8001f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8001fc:	83 ec 08             	sub    $0x8,%esp
  8001ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800202:	50                   	push   %eax
  800203:	e8 f6 01 00 00       	call   8003fe <vcprintf>
  800208:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80020b:	83 ec 08             	sub    $0x8,%esp
  80020e:	6a 00                	push   $0x0
  800210:	68 e5 1c 80 00       	push   $0x801ce5
  800215:	e8 e4 01 00 00       	call   8003fe <vcprintf>
  80021a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80021d:	e8 82 ff ff ff       	call   8001a4 <exit>

	// should not return here
	while (1) ;
  800222:	eb fe                	jmp    800222 <_panic+0x70>

00800224 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800224:	55                   	push   %ebp
  800225:	89 e5                	mov    %esp,%ebp
  800227:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80022a:	a1 20 30 80 00       	mov    0x803020,%eax
  80022f:	8b 50 74             	mov    0x74(%eax),%edx
  800232:	8b 45 0c             	mov    0xc(%ebp),%eax
  800235:	39 c2                	cmp    %eax,%edx
  800237:	74 14                	je     80024d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800239:	83 ec 04             	sub    $0x4,%esp
  80023c:	68 e8 1c 80 00       	push   $0x801ce8
  800241:	6a 26                	push   $0x26
  800243:	68 34 1d 80 00       	push   $0x801d34
  800248:	e8 65 ff ff ff       	call   8001b2 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80024d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800254:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80025b:	e9 c4 00 00 00       	jmp    800324 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800260:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800263:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80026a:	8b 45 08             	mov    0x8(%ebp),%eax
  80026d:	01 d0                	add    %edx,%eax
  80026f:	8b 00                	mov    (%eax),%eax
  800271:	85 c0                	test   %eax,%eax
  800273:	75 08                	jne    80027d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800275:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800278:	e9 a4 00 00 00       	jmp    800321 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  80027d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800284:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80028b:	eb 6b                	jmp    8002f8 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80028d:	a1 20 30 80 00       	mov    0x803020,%eax
  800292:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800298:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80029b:	89 d0                	mov    %edx,%eax
  80029d:	c1 e0 02             	shl    $0x2,%eax
  8002a0:	01 d0                	add    %edx,%eax
  8002a2:	c1 e0 02             	shl    $0x2,%eax
  8002a5:	01 c8                	add    %ecx,%eax
  8002a7:	8a 40 04             	mov    0x4(%eax),%al
  8002aa:	84 c0                	test   %al,%al
  8002ac:	75 47                	jne    8002f5 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002ae:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b3:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8002b9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002bc:	89 d0                	mov    %edx,%eax
  8002be:	c1 e0 02             	shl    $0x2,%eax
  8002c1:	01 d0                	add    %edx,%eax
  8002c3:	c1 e0 02             	shl    $0x2,%eax
  8002c6:	01 c8                	add    %ecx,%eax
  8002c8:	8b 00                	mov    (%eax),%eax
  8002ca:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8002cd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002d5:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8002d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002da:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e4:	01 c8                	add    %ecx,%eax
  8002e6:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002e8:	39 c2                	cmp    %eax,%edx
  8002ea:	75 09                	jne    8002f5 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  8002ec:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8002f3:	eb 12                	jmp    800307 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002f5:	ff 45 e8             	incl   -0x18(%ebp)
  8002f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002fd:	8b 50 74             	mov    0x74(%eax),%edx
  800300:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800303:	39 c2                	cmp    %eax,%edx
  800305:	77 86                	ja     80028d <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800307:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80030b:	75 14                	jne    800321 <CheckWSWithoutLastIndex+0xfd>
			panic(
  80030d:	83 ec 04             	sub    $0x4,%esp
  800310:	68 40 1d 80 00       	push   $0x801d40
  800315:	6a 3a                	push   $0x3a
  800317:	68 34 1d 80 00       	push   $0x801d34
  80031c:	e8 91 fe ff ff       	call   8001b2 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800321:	ff 45 f0             	incl   -0x10(%ebp)
  800324:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800327:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80032a:	0f 8c 30 ff ff ff    	jl     800260 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800330:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800337:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80033e:	eb 27                	jmp    800367 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800340:	a1 20 30 80 00       	mov    0x803020,%eax
  800345:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80034b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80034e:	89 d0                	mov    %edx,%eax
  800350:	c1 e0 02             	shl    $0x2,%eax
  800353:	01 d0                	add    %edx,%eax
  800355:	c1 e0 02             	shl    $0x2,%eax
  800358:	01 c8                	add    %ecx,%eax
  80035a:	8a 40 04             	mov    0x4(%eax),%al
  80035d:	3c 01                	cmp    $0x1,%al
  80035f:	75 03                	jne    800364 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800361:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800364:	ff 45 e0             	incl   -0x20(%ebp)
  800367:	a1 20 30 80 00       	mov    0x803020,%eax
  80036c:	8b 50 74             	mov    0x74(%eax),%edx
  80036f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800372:	39 c2                	cmp    %eax,%edx
  800374:	77 ca                	ja     800340 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800376:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800379:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80037c:	74 14                	je     800392 <CheckWSWithoutLastIndex+0x16e>
		panic(
  80037e:	83 ec 04             	sub    $0x4,%esp
  800381:	68 94 1d 80 00       	push   $0x801d94
  800386:	6a 44                	push   $0x44
  800388:	68 34 1d 80 00       	push   $0x801d34
  80038d:	e8 20 fe ff ff       	call   8001b2 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800392:	90                   	nop
  800393:	c9                   	leave  
  800394:	c3                   	ret    

00800395 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800395:	55                   	push   %ebp
  800396:	89 e5                	mov    %esp,%ebp
  800398:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80039b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80039e:	8b 00                	mov    (%eax),%eax
  8003a0:	8d 48 01             	lea    0x1(%eax),%ecx
  8003a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003a6:	89 0a                	mov    %ecx,(%edx)
  8003a8:	8b 55 08             	mov    0x8(%ebp),%edx
  8003ab:	88 d1                	mov    %dl,%cl
  8003ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003b0:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8003b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b7:	8b 00                	mov    (%eax),%eax
  8003b9:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003be:	75 2c                	jne    8003ec <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8003c0:	a0 24 30 80 00       	mov    0x803024,%al
  8003c5:	0f b6 c0             	movzbl %al,%eax
  8003c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003cb:	8b 12                	mov    (%edx),%edx
  8003cd:	89 d1                	mov    %edx,%ecx
  8003cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003d2:	83 c2 08             	add    $0x8,%edx
  8003d5:	83 ec 04             	sub    $0x4,%esp
  8003d8:	50                   	push   %eax
  8003d9:	51                   	push   %ecx
  8003da:	52                   	push   %edx
  8003db:	e8 3e 0e 00 00       	call   80121e <sys_cputs>
  8003e0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8003e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ef:	8b 40 04             	mov    0x4(%eax),%eax
  8003f2:	8d 50 01             	lea    0x1(%eax),%edx
  8003f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f8:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003fb:	90                   	nop
  8003fc:	c9                   	leave  
  8003fd:	c3                   	ret    

008003fe <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8003fe:	55                   	push   %ebp
  8003ff:	89 e5                	mov    %esp,%ebp
  800401:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800407:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80040e:	00 00 00 
	b.cnt = 0;
  800411:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800418:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80041b:	ff 75 0c             	pushl  0xc(%ebp)
  80041e:	ff 75 08             	pushl  0x8(%ebp)
  800421:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800427:	50                   	push   %eax
  800428:	68 95 03 80 00       	push   $0x800395
  80042d:	e8 11 02 00 00       	call   800643 <vprintfmt>
  800432:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800435:	a0 24 30 80 00       	mov    0x803024,%al
  80043a:	0f b6 c0             	movzbl %al,%eax
  80043d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800443:	83 ec 04             	sub    $0x4,%esp
  800446:	50                   	push   %eax
  800447:	52                   	push   %edx
  800448:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80044e:	83 c0 08             	add    $0x8,%eax
  800451:	50                   	push   %eax
  800452:	e8 c7 0d 00 00       	call   80121e <sys_cputs>
  800457:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80045a:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800461:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800467:	c9                   	leave  
  800468:	c3                   	ret    

00800469 <cprintf>:

int cprintf(const char *fmt, ...) {
  800469:	55                   	push   %ebp
  80046a:	89 e5                	mov    %esp,%ebp
  80046c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80046f:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800476:	8d 45 0c             	lea    0xc(%ebp),%eax
  800479:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80047c:	8b 45 08             	mov    0x8(%ebp),%eax
  80047f:	83 ec 08             	sub    $0x8,%esp
  800482:	ff 75 f4             	pushl  -0xc(%ebp)
  800485:	50                   	push   %eax
  800486:	e8 73 ff ff ff       	call   8003fe <vcprintf>
  80048b:	83 c4 10             	add    $0x10,%esp
  80048e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800491:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800494:	c9                   	leave  
  800495:	c3                   	ret    

00800496 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800496:	55                   	push   %ebp
  800497:	89 e5                	mov    %esp,%ebp
  800499:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80049c:	e8 8e 0f 00 00       	call   80142f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8004a1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004aa:	83 ec 08             	sub    $0x8,%esp
  8004ad:	ff 75 f4             	pushl  -0xc(%ebp)
  8004b0:	50                   	push   %eax
  8004b1:	e8 48 ff ff ff       	call   8003fe <vcprintf>
  8004b6:	83 c4 10             	add    $0x10,%esp
  8004b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8004bc:	e8 88 0f 00 00       	call   801449 <sys_enable_interrupt>
	return cnt;
  8004c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004c4:	c9                   	leave  
  8004c5:	c3                   	ret    

008004c6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004c6:	55                   	push   %ebp
  8004c7:	89 e5                	mov    %esp,%ebp
  8004c9:	53                   	push   %ebx
  8004ca:	83 ec 14             	sub    $0x14,%esp
  8004cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8004d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004d9:	8b 45 18             	mov    0x18(%ebp),%eax
  8004dc:	ba 00 00 00 00       	mov    $0x0,%edx
  8004e1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004e4:	77 55                	ja     80053b <printnum+0x75>
  8004e6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004e9:	72 05                	jb     8004f0 <printnum+0x2a>
  8004eb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004ee:	77 4b                	ja     80053b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004f0:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004f3:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004f6:	8b 45 18             	mov    0x18(%ebp),%eax
  8004f9:	ba 00 00 00 00       	mov    $0x0,%edx
  8004fe:	52                   	push   %edx
  8004ff:	50                   	push   %eax
  800500:	ff 75 f4             	pushl  -0xc(%ebp)
  800503:	ff 75 f0             	pushl  -0x10(%ebp)
  800506:	e8 61 13 00 00       	call   80186c <__udivdi3>
  80050b:	83 c4 10             	add    $0x10,%esp
  80050e:	83 ec 04             	sub    $0x4,%esp
  800511:	ff 75 20             	pushl  0x20(%ebp)
  800514:	53                   	push   %ebx
  800515:	ff 75 18             	pushl  0x18(%ebp)
  800518:	52                   	push   %edx
  800519:	50                   	push   %eax
  80051a:	ff 75 0c             	pushl  0xc(%ebp)
  80051d:	ff 75 08             	pushl  0x8(%ebp)
  800520:	e8 a1 ff ff ff       	call   8004c6 <printnum>
  800525:	83 c4 20             	add    $0x20,%esp
  800528:	eb 1a                	jmp    800544 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80052a:	83 ec 08             	sub    $0x8,%esp
  80052d:	ff 75 0c             	pushl  0xc(%ebp)
  800530:	ff 75 20             	pushl  0x20(%ebp)
  800533:	8b 45 08             	mov    0x8(%ebp),%eax
  800536:	ff d0                	call   *%eax
  800538:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80053b:	ff 4d 1c             	decl   0x1c(%ebp)
  80053e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800542:	7f e6                	jg     80052a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800544:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800547:	bb 00 00 00 00       	mov    $0x0,%ebx
  80054c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80054f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800552:	53                   	push   %ebx
  800553:	51                   	push   %ecx
  800554:	52                   	push   %edx
  800555:	50                   	push   %eax
  800556:	e8 21 14 00 00       	call   80197c <__umoddi3>
  80055b:	83 c4 10             	add    $0x10,%esp
  80055e:	05 f4 1f 80 00       	add    $0x801ff4,%eax
  800563:	8a 00                	mov    (%eax),%al
  800565:	0f be c0             	movsbl %al,%eax
  800568:	83 ec 08             	sub    $0x8,%esp
  80056b:	ff 75 0c             	pushl  0xc(%ebp)
  80056e:	50                   	push   %eax
  80056f:	8b 45 08             	mov    0x8(%ebp),%eax
  800572:	ff d0                	call   *%eax
  800574:	83 c4 10             	add    $0x10,%esp
}
  800577:	90                   	nop
  800578:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80057b:	c9                   	leave  
  80057c:	c3                   	ret    

0080057d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80057d:	55                   	push   %ebp
  80057e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800580:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800584:	7e 1c                	jle    8005a2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800586:	8b 45 08             	mov    0x8(%ebp),%eax
  800589:	8b 00                	mov    (%eax),%eax
  80058b:	8d 50 08             	lea    0x8(%eax),%edx
  80058e:	8b 45 08             	mov    0x8(%ebp),%eax
  800591:	89 10                	mov    %edx,(%eax)
  800593:	8b 45 08             	mov    0x8(%ebp),%eax
  800596:	8b 00                	mov    (%eax),%eax
  800598:	83 e8 08             	sub    $0x8,%eax
  80059b:	8b 50 04             	mov    0x4(%eax),%edx
  80059e:	8b 00                	mov    (%eax),%eax
  8005a0:	eb 40                	jmp    8005e2 <getuint+0x65>
	else if (lflag)
  8005a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005a6:	74 1e                	je     8005c6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8005a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ab:	8b 00                	mov    (%eax),%eax
  8005ad:	8d 50 04             	lea    0x4(%eax),%edx
  8005b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b3:	89 10                	mov    %edx,(%eax)
  8005b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b8:	8b 00                	mov    (%eax),%eax
  8005ba:	83 e8 04             	sub    $0x4,%eax
  8005bd:	8b 00                	mov    (%eax),%eax
  8005bf:	ba 00 00 00 00       	mov    $0x0,%edx
  8005c4:	eb 1c                	jmp    8005e2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c9:	8b 00                	mov    (%eax),%eax
  8005cb:	8d 50 04             	lea    0x4(%eax),%edx
  8005ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d1:	89 10                	mov    %edx,(%eax)
  8005d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d6:	8b 00                	mov    (%eax),%eax
  8005d8:	83 e8 04             	sub    $0x4,%eax
  8005db:	8b 00                	mov    (%eax),%eax
  8005dd:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005e2:	5d                   	pop    %ebp
  8005e3:	c3                   	ret    

008005e4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005e4:	55                   	push   %ebp
  8005e5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005e7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005eb:	7e 1c                	jle    800609 <getint+0x25>
		return va_arg(*ap, long long);
  8005ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f0:	8b 00                	mov    (%eax),%eax
  8005f2:	8d 50 08             	lea    0x8(%eax),%edx
  8005f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f8:	89 10                	mov    %edx,(%eax)
  8005fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fd:	8b 00                	mov    (%eax),%eax
  8005ff:	83 e8 08             	sub    $0x8,%eax
  800602:	8b 50 04             	mov    0x4(%eax),%edx
  800605:	8b 00                	mov    (%eax),%eax
  800607:	eb 38                	jmp    800641 <getint+0x5d>
	else if (lflag)
  800609:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80060d:	74 1a                	je     800629 <getint+0x45>
		return va_arg(*ap, long);
  80060f:	8b 45 08             	mov    0x8(%ebp),%eax
  800612:	8b 00                	mov    (%eax),%eax
  800614:	8d 50 04             	lea    0x4(%eax),%edx
  800617:	8b 45 08             	mov    0x8(%ebp),%eax
  80061a:	89 10                	mov    %edx,(%eax)
  80061c:	8b 45 08             	mov    0x8(%ebp),%eax
  80061f:	8b 00                	mov    (%eax),%eax
  800621:	83 e8 04             	sub    $0x4,%eax
  800624:	8b 00                	mov    (%eax),%eax
  800626:	99                   	cltd   
  800627:	eb 18                	jmp    800641 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800629:	8b 45 08             	mov    0x8(%ebp),%eax
  80062c:	8b 00                	mov    (%eax),%eax
  80062e:	8d 50 04             	lea    0x4(%eax),%edx
  800631:	8b 45 08             	mov    0x8(%ebp),%eax
  800634:	89 10                	mov    %edx,(%eax)
  800636:	8b 45 08             	mov    0x8(%ebp),%eax
  800639:	8b 00                	mov    (%eax),%eax
  80063b:	83 e8 04             	sub    $0x4,%eax
  80063e:	8b 00                	mov    (%eax),%eax
  800640:	99                   	cltd   
}
  800641:	5d                   	pop    %ebp
  800642:	c3                   	ret    

00800643 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800643:	55                   	push   %ebp
  800644:	89 e5                	mov    %esp,%ebp
  800646:	56                   	push   %esi
  800647:	53                   	push   %ebx
  800648:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80064b:	eb 17                	jmp    800664 <vprintfmt+0x21>
			if (ch == '\0')
  80064d:	85 db                	test   %ebx,%ebx
  80064f:	0f 84 af 03 00 00    	je     800a04 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800655:	83 ec 08             	sub    $0x8,%esp
  800658:	ff 75 0c             	pushl  0xc(%ebp)
  80065b:	53                   	push   %ebx
  80065c:	8b 45 08             	mov    0x8(%ebp),%eax
  80065f:	ff d0                	call   *%eax
  800661:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800664:	8b 45 10             	mov    0x10(%ebp),%eax
  800667:	8d 50 01             	lea    0x1(%eax),%edx
  80066a:	89 55 10             	mov    %edx,0x10(%ebp)
  80066d:	8a 00                	mov    (%eax),%al
  80066f:	0f b6 d8             	movzbl %al,%ebx
  800672:	83 fb 25             	cmp    $0x25,%ebx
  800675:	75 d6                	jne    80064d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800677:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80067b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800682:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800689:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800690:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800697:	8b 45 10             	mov    0x10(%ebp),%eax
  80069a:	8d 50 01             	lea    0x1(%eax),%edx
  80069d:	89 55 10             	mov    %edx,0x10(%ebp)
  8006a0:	8a 00                	mov    (%eax),%al
  8006a2:	0f b6 d8             	movzbl %al,%ebx
  8006a5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8006a8:	83 f8 55             	cmp    $0x55,%eax
  8006ab:	0f 87 2b 03 00 00    	ja     8009dc <vprintfmt+0x399>
  8006b1:	8b 04 85 18 20 80 00 	mov    0x802018(,%eax,4),%eax
  8006b8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006ba:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006be:	eb d7                	jmp    800697 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006c0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006c4:	eb d1                	jmp    800697 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006c6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006cd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006d0:	89 d0                	mov    %edx,%eax
  8006d2:	c1 e0 02             	shl    $0x2,%eax
  8006d5:	01 d0                	add    %edx,%eax
  8006d7:	01 c0                	add    %eax,%eax
  8006d9:	01 d8                	add    %ebx,%eax
  8006db:	83 e8 30             	sub    $0x30,%eax
  8006de:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8006e4:	8a 00                	mov    (%eax),%al
  8006e6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006e9:	83 fb 2f             	cmp    $0x2f,%ebx
  8006ec:	7e 3e                	jle    80072c <vprintfmt+0xe9>
  8006ee:	83 fb 39             	cmp    $0x39,%ebx
  8006f1:	7f 39                	jg     80072c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006f3:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006f6:	eb d5                	jmp    8006cd <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8006fb:	83 c0 04             	add    $0x4,%eax
  8006fe:	89 45 14             	mov    %eax,0x14(%ebp)
  800701:	8b 45 14             	mov    0x14(%ebp),%eax
  800704:	83 e8 04             	sub    $0x4,%eax
  800707:	8b 00                	mov    (%eax),%eax
  800709:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80070c:	eb 1f                	jmp    80072d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80070e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800712:	79 83                	jns    800697 <vprintfmt+0x54>
				width = 0;
  800714:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80071b:	e9 77 ff ff ff       	jmp    800697 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800720:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800727:	e9 6b ff ff ff       	jmp    800697 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80072c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80072d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800731:	0f 89 60 ff ff ff    	jns    800697 <vprintfmt+0x54>
				width = precision, precision = -1;
  800737:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80073a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80073d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800744:	e9 4e ff ff ff       	jmp    800697 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800749:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80074c:	e9 46 ff ff ff       	jmp    800697 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800751:	8b 45 14             	mov    0x14(%ebp),%eax
  800754:	83 c0 04             	add    $0x4,%eax
  800757:	89 45 14             	mov    %eax,0x14(%ebp)
  80075a:	8b 45 14             	mov    0x14(%ebp),%eax
  80075d:	83 e8 04             	sub    $0x4,%eax
  800760:	8b 00                	mov    (%eax),%eax
  800762:	83 ec 08             	sub    $0x8,%esp
  800765:	ff 75 0c             	pushl  0xc(%ebp)
  800768:	50                   	push   %eax
  800769:	8b 45 08             	mov    0x8(%ebp),%eax
  80076c:	ff d0                	call   *%eax
  80076e:	83 c4 10             	add    $0x10,%esp
			break;
  800771:	e9 89 02 00 00       	jmp    8009ff <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800776:	8b 45 14             	mov    0x14(%ebp),%eax
  800779:	83 c0 04             	add    $0x4,%eax
  80077c:	89 45 14             	mov    %eax,0x14(%ebp)
  80077f:	8b 45 14             	mov    0x14(%ebp),%eax
  800782:	83 e8 04             	sub    $0x4,%eax
  800785:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800787:	85 db                	test   %ebx,%ebx
  800789:	79 02                	jns    80078d <vprintfmt+0x14a>
				err = -err;
  80078b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80078d:	83 fb 64             	cmp    $0x64,%ebx
  800790:	7f 0b                	jg     80079d <vprintfmt+0x15a>
  800792:	8b 34 9d 60 1e 80 00 	mov    0x801e60(,%ebx,4),%esi
  800799:	85 f6                	test   %esi,%esi
  80079b:	75 19                	jne    8007b6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80079d:	53                   	push   %ebx
  80079e:	68 05 20 80 00       	push   $0x802005
  8007a3:	ff 75 0c             	pushl  0xc(%ebp)
  8007a6:	ff 75 08             	pushl  0x8(%ebp)
  8007a9:	e8 5e 02 00 00       	call   800a0c <printfmt>
  8007ae:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007b1:	e9 49 02 00 00       	jmp    8009ff <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007b6:	56                   	push   %esi
  8007b7:	68 0e 20 80 00       	push   $0x80200e
  8007bc:	ff 75 0c             	pushl  0xc(%ebp)
  8007bf:	ff 75 08             	pushl  0x8(%ebp)
  8007c2:	e8 45 02 00 00       	call   800a0c <printfmt>
  8007c7:	83 c4 10             	add    $0x10,%esp
			break;
  8007ca:	e9 30 02 00 00       	jmp    8009ff <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d2:	83 c0 04             	add    $0x4,%eax
  8007d5:	89 45 14             	mov    %eax,0x14(%ebp)
  8007d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8007db:	83 e8 04             	sub    $0x4,%eax
  8007de:	8b 30                	mov    (%eax),%esi
  8007e0:	85 f6                	test   %esi,%esi
  8007e2:	75 05                	jne    8007e9 <vprintfmt+0x1a6>
				p = "(null)";
  8007e4:	be 11 20 80 00       	mov    $0x802011,%esi
			if (width > 0 && padc != '-')
  8007e9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ed:	7e 6d                	jle    80085c <vprintfmt+0x219>
  8007ef:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007f3:	74 67                	je     80085c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007f8:	83 ec 08             	sub    $0x8,%esp
  8007fb:	50                   	push   %eax
  8007fc:	56                   	push   %esi
  8007fd:	e8 0c 03 00 00       	call   800b0e <strnlen>
  800802:	83 c4 10             	add    $0x10,%esp
  800805:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800808:	eb 16                	jmp    800820 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80080a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80080e:	83 ec 08             	sub    $0x8,%esp
  800811:	ff 75 0c             	pushl  0xc(%ebp)
  800814:	50                   	push   %eax
  800815:	8b 45 08             	mov    0x8(%ebp),%eax
  800818:	ff d0                	call   *%eax
  80081a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80081d:	ff 4d e4             	decl   -0x1c(%ebp)
  800820:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800824:	7f e4                	jg     80080a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800826:	eb 34                	jmp    80085c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800828:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80082c:	74 1c                	je     80084a <vprintfmt+0x207>
  80082e:	83 fb 1f             	cmp    $0x1f,%ebx
  800831:	7e 05                	jle    800838 <vprintfmt+0x1f5>
  800833:	83 fb 7e             	cmp    $0x7e,%ebx
  800836:	7e 12                	jle    80084a <vprintfmt+0x207>
					putch('?', putdat);
  800838:	83 ec 08             	sub    $0x8,%esp
  80083b:	ff 75 0c             	pushl  0xc(%ebp)
  80083e:	6a 3f                	push   $0x3f
  800840:	8b 45 08             	mov    0x8(%ebp),%eax
  800843:	ff d0                	call   *%eax
  800845:	83 c4 10             	add    $0x10,%esp
  800848:	eb 0f                	jmp    800859 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80084a:	83 ec 08             	sub    $0x8,%esp
  80084d:	ff 75 0c             	pushl  0xc(%ebp)
  800850:	53                   	push   %ebx
  800851:	8b 45 08             	mov    0x8(%ebp),%eax
  800854:	ff d0                	call   *%eax
  800856:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800859:	ff 4d e4             	decl   -0x1c(%ebp)
  80085c:	89 f0                	mov    %esi,%eax
  80085e:	8d 70 01             	lea    0x1(%eax),%esi
  800861:	8a 00                	mov    (%eax),%al
  800863:	0f be d8             	movsbl %al,%ebx
  800866:	85 db                	test   %ebx,%ebx
  800868:	74 24                	je     80088e <vprintfmt+0x24b>
  80086a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80086e:	78 b8                	js     800828 <vprintfmt+0x1e5>
  800870:	ff 4d e0             	decl   -0x20(%ebp)
  800873:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800877:	79 af                	jns    800828 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800879:	eb 13                	jmp    80088e <vprintfmt+0x24b>
				putch(' ', putdat);
  80087b:	83 ec 08             	sub    $0x8,%esp
  80087e:	ff 75 0c             	pushl  0xc(%ebp)
  800881:	6a 20                	push   $0x20
  800883:	8b 45 08             	mov    0x8(%ebp),%eax
  800886:	ff d0                	call   *%eax
  800888:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80088b:	ff 4d e4             	decl   -0x1c(%ebp)
  80088e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800892:	7f e7                	jg     80087b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800894:	e9 66 01 00 00       	jmp    8009ff <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800899:	83 ec 08             	sub    $0x8,%esp
  80089c:	ff 75 e8             	pushl  -0x18(%ebp)
  80089f:	8d 45 14             	lea    0x14(%ebp),%eax
  8008a2:	50                   	push   %eax
  8008a3:	e8 3c fd ff ff       	call   8005e4 <getint>
  8008a8:	83 c4 10             	add    $0x10,%esp
  8008ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008b7:	85 d2                	test   %edx,%edx
  8008b9:	79 23                	jns    8008de <vprintfmt+0x29b>
				putch('-', putdat);
  8008bb:	83 ec 08             	sub    $0x8,%esp
  8008be:	ff 75 0c             	pushl  0xc(%ebp)
  8008c1:	6a 2d                	push   $0x2d
  8008c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c6:	ff d0                	call   *%eax
  8008c8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008d1:	f7 d8                	neg    %eax
  8008d3:	83 d2 00             	adc    $0x0,%edx
  8008d6:	f7 da                	neg    %edx
  8008d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008db:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008de:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008e5:	e9 bc 00 00 00       	jmp    8009a6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008ea:	83 ec 08             	sub    $0x8,%esp
  8008ed:	ff 75 e8             	pushl  -0x18(%ebp)
  8008f0:	8d 45 14             	lea    0x14(%ebp),%eax
  8008f3:	50                   	push   %eax
  8008f4:	e8 84 fc ff ff       	call   80057d <getuint>
  8008f9:	83 c4 10             	add    $0x10,%esp
  8008fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ff:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800902:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800909:	e9 98 00 00 00       	jmp    8009a6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80090e:	83 ec 08             	sub    $0x8,%esp
  800911:	ff 75 0c             	pushl  0xc(%ebp)
  800914:	6a 58                	push   $0x58
  800916:	8b 45 08             	mov    0x8(%ebp),%eax
  800919:	ff d0                	call   *%eax
  80091b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80091e:	83 ec 08             	sub    $0x8,%esp
  800921:	ff 75 0c             	pushl  0xc(%ebp)
  800924:	6a 58                	push   $0x58
  800926:	8b 45 08             	mov    0x8(%ebp),%eax
  800929:	ff d0                	call   *%eax
  80092b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80092e:	83 ec 08             	sub    $0x8,%esp
  800931:	ff 75 0c             	pushl  0xc(%ebp)
  800934:	6a 58                	push   $0x58
  800936:	8b 45 08             	mov    0x8(%ebp),%eax
  800939:	ff d0                	call   *%eax
  80093b:	83 c4 10             	add    $0x10,%esp
			break;
  80093e:	e9 bc 00 00 00       	jmp    8009ff <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800943:	83 ec 08             	sub    $0x8,%esp
  800946:	ff 75 0c             	pushl  0xc(%ebp)
  800949:	6a 30                	push   $0x30
  80094b:	8b 45 08             	mov    0x8(%ebp),%eax
  80094e:	ff d0                	call   *%eax
  800950:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800953:	83 ec 08             	sub    $0x8,%esp
  800956:	ff 75 0c             	pushl  0xc(%ebp)
  800959:	6a 78                	push   $0x78
  80095b:	8b 45 08             	mov    0x8(%ebp),%eax
  80095e:	ff d0                	call   *%eax
  800960:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800963:	8b 45 14             	mov    0x14(%ebp),%eax
  800966:	83 c0 04             	add    $0x4,%eax
  800969:	89 45 14             	mov    %eax,0x14(%ebp)
  80096c:	8b 45 14             	mov    0x14(%ebp),%eax
  80096f:	83 e8 04             	sub    $0x4,%eax
  800972:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800974:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800977:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80097e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800985:	eb 1f                	jmp    8009a6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800987:	83 ec 08             	sub    $0x8,%esp
  80098a:	ff 75 e8             	pushl  -0x18(%ebp)
  80098d:	8d 45 14             	lea    0x14(%ebp),%eax
  800990:	50                   	push   %eax
  800991:	e8 e7 fb ff ff       	call   80057d <getuint>
  800996:	83 c4 10             	add    $0x10,%esp
  800999:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80099f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8009a6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8009aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009ad:	83 ec 04             	sub    $0x4,%esp
  8009b0:	52                   	push   %edx
  8009b1:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009b4:	50                   	push   %eax
  8009b5:	ff 75 f4             	pushl  -0xc(%ebp)
  8009b8:	ff 75 f0             	pushl  -0x10(%ebp)
  8009bb:	ff 75 0c             	pushl  0xc(%ebp)
  8009be:	ff 75 08             	pushl  0x8(%ebp)
  8009c1:	e8 00 fb ff ff       	call   8004c6 <printnum>
  8009c6:	83 c4 20             	add    $0x20,%esp
			break;
  8009c9:	eb 34                	jmp    8009ff <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009cb:	83 ec 08             	sub    $0x8,%esp
  8009ce:	ff 75 0c             	pushl  0xc(%ebp)
  8009d1:	53                   	push   %ebx
  8009d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d5:	ff d0                	call   *%eax
  8009d7:	83 c4 10             	add    $0x10,%esp
			break;
  8009da:	eb 23                	jmp    8009ff <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009dc:	83 ec 08             	sub    $0x8,%esp
  8009df:	ff 75 0c             	pushl  0xc(%ebp)
  8009e2:	6a 25                	push   $0x25
  8009e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e7:	ff d0                	call   *%eax
  8009e9:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009ec:	ff 4d 10             	decl   0x10(%ebp)
  8009ef:	eb 03                	jmp    8009f4 <vprintfmt+0x3b1>
  8009f1:	ff 4d 10             	decl   0x10(%ebp)
  8009f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f7:	48                   	dec    %eax
  8009f8:	8a 00                	mov    (%eax),%al
  8009fa:	3c 25                	cmp    $0x25,%al
  8009fc:	75 f3                	jne    8009f1 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8009fe:	90                   	nop
		}
	}
  8009ff:	e9 47 fc ff ff       	jmp    80064b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a04:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a05:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a08:	5b                   	pop    %ebx
  800a09:	5e                   	pop    %esi
  800a0a:	5d                   	pop    %ebp
  800a0b:	c3                   	ret    

00800a0c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a0c:	55                   	push   %ebp
  800a0d:	89 e5                	mov    %esp,%ebp
  800a0f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a12:	8d 45 10             	lea    0x10(%ebp),%eax
  800a15:	83 c0 04             	add    $0x4,%eax
  800a18:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800a1e:	ff 75 f4             	pushl  -0xc(%ebp)
  800a21:	50                   	push   %eax
  800a22:	ff 75 0c             	pushl  0xc(%ebp)
  800a25:	ff 75 08             	pushl  0x8(%ebp)
  800a28:	e8 16 fc ff ff       	call   800643 <vprintfmt>
  800a2d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a30:	90                   	nop
  800a31:	c9                   	leave  
  800a32:	c3                   	ret    

00800a33 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a33:	55                   	push   %ebp
  800a34:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a39:	8b 40 08             	mov    0x8(%eax),%eax
  800a3c:	8d 50 01             	lea    0x1(%eax),%edx
  800a3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a42:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a48:	8b 10                	mov    (%eax),%edx
  800a4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4d:	8b 40 04             	mov    0x4(%eax),%eax
  800a50:	39 c2                	cmp    %eax,%edx
  800a52:	73 12                	jae    800a66 <sprintputch+0x33>
		*b->buf++ = ch;
  800a54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a57:	8b 00                	mov    (%eax),%eax
  800a59:	8d 48 01             	lea    0x1(%eax),%ecx
  800a5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a5f:	89 0a                	mov    %ecx,(%edx)
  800a61:	8b 55 08             	mov    0x8(%ebp),%edx
  800a64:	88 10                	mov    %dl,(%eax)
}
  800a66:	90                   	nop
  800a67:	5d                   	pop    %ebp
  800a68:	c3                   	ret    

00800a69 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a69:	55                   	push   %ebp
  800a6a:	89 e5                	mov    %esp,%ebp
  800a6c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a78:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7e:	01 d0                	add    %edx,%eax
  800a80:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a83:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a8a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a8e:	74 06                	je     800a96 <vsnprintf+0x2d>
  800a90:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a94:	7f 07                	jg     800a9d <vsnprintf+0x34>
		return -E_INVAL;
  800a96:	b8 03 00 00 00       	mov    $0x3,%eax
  800a9b:	eb 20                	jmp    800abd <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a9d:	ff 75 14             	pushl  0x14(%ebp)
  800aa0:	ff 75 10             	pushl  0x10(%ebp)
  800aa3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800aa6:	50                   	push   %eax
  800aa7:	68 33 0a 80 00       	push   $0x800a33
  800aac:	e8 92 fb ff ff       	call   800643 <vprintfmt>
  800ab1:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ab4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ab7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800aba:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800abd:	c9                   	leave  
  800abe:	c3                   	ret    

00800abf <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800abf:	55                   	push   %ebp
  800ac0:	89 e5                	mov    %esp,%ebp
  800ac2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ac5:	8d 45 10             	lea    0x10(%ebp),%eax
  800ac8:	83 c0 04             	add    $0x4,%eax
  800acb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ace:	8b 45 10             	mov    0x10(%ebp),%eax
  800ad1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ad4:	50                   	push   %eax
  800ad5:	ff 75 0c             	pushl  0xc(%ebp)
  800ad8:	ff 75 08             	pushl  0x8(%ebp)
  800adb:	e8 89 ff ff ff       	call   800a69 <vsnprintf>
  800ae0:	83 c4 10             	add    $0x10,%esp
  800ae3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ae6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ae9:	c9                   	leave  
  800aea:	c3                   	ret    

00800aeb <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800aeb:	55                   	push   %ebp
  800aec:	89 e5                	mov    %esp,%ebp
  800aee:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800af1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800af8:	eb 06                	jmp    800b00 <strlen+0x15>
		n++;
  800afa:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800afd:	ff 45 08             	incl   0x8(%ebp)
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	8a 00                	mov    (%eax),%al
  800b05:	84 c0                	test   %al,%al
  800b07:	75 f1                	jne    800afa <strlen+0xf>
		n++;
	return n;
  800b09:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b0c:	c9                   	leave  
  800b0d:	c3                   	ret    

00800b0e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b0e:	55                   	push   %ebp
  800b0f:	89 e5                	mov    %esp,%ebp
  800b11:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b1b:	eb 09                	jmp    800b26 <strnlen+0x18>
		n++;
  800b1d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b20:	ff 45 08             	incl   0x8(%ebp)
  800b23:	ff 4d 0c             	decl   0xc(%ebp)
  800b26:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b2a:	74 09                	je     800b35 <strnlen+0x27>
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	8a 00                	mov    (%eax),%al
  800b31:	84 c0                	test   %al,%al
  800b33:	75 e8                	jne    800b1d <strnlen+0xf>
		n++;
	return n;
  800b35:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b38:	c9                   	leave  
  800b39:	c3                   	ret    

00800b3a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b3a:	55                   	push   %ebp
  800b3b:	89 e5                	mov    %esp,%ebp
  800b3d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b40:	8b 45 08             	mov    0x8(%ebp),%eax
  800b43:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b46:	90                   	nop
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	8d 50 01             	lea    0x1(%eax),%edx
  800b4d:	89 55 08             	mov    %edx,0x8(%ebp)
  800b50:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b53:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b56:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b59:	8a 12                	mov    (%edx),%dl
  800b5b:	88 10                	mov    %dl,(%eax)
  800b5d:	8a 00                	mov    (%eax),%al
  800b5f:	84 c0                	test   %al,%al
  800b61:	75 e4                	jne    800b47 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b63:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b66:	c9                   	leave  
  800b67:	c3                   	ret    

00800b68 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b68:	55                   	push   %ebp
  800b69:	89 e5                	mov    %esp,%ebp
  800b6b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b7b:	eb 1f                	jmp    800b9c <strncpy+0x34>
		*dst++ = *src;
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	8d 50 01             	lea    0x1(%eax),%edx
  800b83:	89 55 08             	mov    %edx,0x8(%ebp)
  800b86:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b89:	8a 12                	mov    (%edx),%dl
  800b8b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b90:	8a 00                	mov    (%eax),%al
  800b92:	84 c0                	test   %al,%al
  800b94:	74 03                	je     800b99 <strncpy+0x31>
			src++;
  800b96:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b99:	ff 45 fc             	incl   -0x4(%ebp)
  800b9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b9f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ba2:	72 d9                	jb     800b7d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ba4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ba7:	c9                   	leave  
  800ba8:	c3                   	ret    

00800ba9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ba9:	55                   	push   %ebp
  800baa:	89 e5                	mov    %esp,%ebp
  800bac:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800baf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800bb5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bb9:	74 30                	je     800beb <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800bbb:	eb 16                	jmp    800bd3 <strlcpy+0x2a>
			*dst++ = *src++;
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	8d 50 01             	lea    0x1(%eax),%edx
  800bc3:	89 55 08             	mov    %edx,0x8(%ebp)
  800bc6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bcc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bcf:	8a 12                	mov    (%edx),%dl
  800bd1:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800bd3:	ff 4d 10             	decl   0x10(%ebp)
  800bd6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bda:	74 09                	je     800be5 <strlcpy+0x3c>
  800bdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdf:	8a 00                	mov    (%eax),%al
  800be1:	84 c0                	test   %al,%al
  800be3:	75 d8                	jne    800bbd <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800be5:	8b 45 08             	mov    0x8(%ebp),%eax
  800be8:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800beb:	8b 55 08             	mov    0x8(%ebp),%edx
  800bee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf1:	29 c2                	sub    %eax,%edx
  800bf3:	89 d0                	mov    %edx,%eax
}
  800bf5:	c9                   	leave  
  800bf6:	c3                   	ret    

00800bf7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800bf7:	55                   	push   %ebp
  800bf8:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800bfa:	eb 06                	jmp    800c02 <strcmp+0xb>
		p++, q++;
  800bfc:	ff 45 08             	incl   0x8(%ebp)
  800bff:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c02:	8b 45 08             	mov    0x8(%ebp),%eax
  800c05:	8a 00                	mov    (%eax),%al
  800c07:	84 c0                	test   %al,%al
  800c09:	74 0e                	je     800c19 <strcmp+0x22>
  800c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0e:	8a 10                	mov    (%eax),%dl
  800c10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c13:	8a 00                	mov    (%eax),%al
  800c15:	38 c2                	cmp    %al,%dl
  800c17:	74 e3                	je     800bfc <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	8a 00                	mov    (%eax),%al
  800c1e:	0f b6 d0             	movzbl %al,%edx
  800c21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c24:	8a 00                	mov    (%eax),%al
  800c26:	0f b6 c0             	movzbl %al,%eax
  800c29:	29 c2                	sub    %eax,%edx
  800c2b:	89 d0                	mov    %edx,%eax
}
  800c2d:	5d                   	pop    %ebp
  800c2e:	c3                   	ret    

00800c2f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c2f:	55                   	push   %ebp
  800c30:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c32:	eb 09                	jmp    800c3d <strncmp+0xe>
		n--, p++, q++;
  800c34:	ff 4d 10             	decl   0x10(%ebp)
  800c37:	ff 45 08             	incl   0x8(%ebp)
  800c3a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c3d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c41:	74 17                	je     800c5a <strncmp+0x2b>
  800c43:	8b 45 08             	mov    0x8(%ebp),%eax
  800c46:	8a 00                	mov    (%eax),%al
  800c48:	84 c0                	test   %al,%al
  800c4a:	74 0e                	je     800c5a <strncmp+0x2b>
  800c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4f:	8a 10                	mov    (%eax),%dl
  800c51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c54:	8a 00                	mov    (%eax),%al
  800c56:	38 c2                	cmp    %al,%dl
  800c58:	74 da                	je     800c34 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c5a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c5e:	75 07                	jne    800c67 <strncmp+0x38>
		return 0;
  800c60:	b8 00 00 00 00       	mov    $0x0,%eax
  800c65:	eb 14                	jmp    800c7b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c67:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6a:	8a 00                	mov    (%eax),%al
  800c6c:	0f b6 d0             	movzbl %al,%edx
  800c6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c72:	8a 00                	mov    (%eax),%al
  800c74:	0f b6 c0             	movzbl %al,%eax
  800c77:	29 c2                	sub    %eax,%edx
  800c79:	89 d0                	mov    %edx,%eax
}
  800c7b:	5d                   	pop    %ebp
  800c7c:	c3                   	ret    

00800c7d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c7d:	55                   	push   %ebp
  800c7e:	89 e5                	mov    %esp,%ebp
  800c80:	83 ec 04             	sub    $0x4,%esp
  800c83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c86:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c89:	eb 12                	jmp    800c9d <strchr+0x20>
		if (*s == c)
  800c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8e:	8a 00                	mov    (%eax),%al
  800c90:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c93:	75 05                	jne    800c9a <strchr+0x1d>
			return (char *) s;
  800c95:	8b 45 08             	mov    0x8(%ebp),%eax
  800c98:	eb 11                	jmp    800cab <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c9a:	ff 45 08             	incl   0x8(%ebp)
  800c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	84 c0                	test   %al,%al
  800ca4:	75 e5                	jne    800c8b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ca6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cab:	c9                   	leave  
  800cac:	c3                   	ret    

00800cad <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800cad:	55                   	push   %ebp
  800cae:	89 e5                	mov    %esp,%ebp
  800cb0:	83 ec 04             	sub    $0x4,%esp
  800cb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cb9:	eb 0d                	jmp    800cc8 <strfind+0x1b>
		if (*s == c)
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	8a 00                	mov    (%eax),%al
  800cc0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cc3:	74 0e                	je     800cd3 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cc5:	ff 45 08             	incl   0x8(%ebp)
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8a 00                	mov    (%eax),%al
  800ccd:	84 c0                	test   %al,%al
  800ccf:	75 ea                	jne    800cbb <strfind+0xe>
  800cd1:	eb 01                	jmp    800cd4 <strfind+0x27>
		if (*s == c)
			break;
  800cd3:	90                   	nop
	return (char *) s;
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cd7:	c9                   	leave  
  800cd8:	c3                   	ret    

00800cd9 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800cd9:	55                   	push   %ebp
  800cda:	89 e5                	mov    %esp,%ebp
  800cdc:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ce5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ceb:	eb 0e                	jmp    800cfb <memset+0x22>
		*p++ = c;
  800ced:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cf0:	8d 50 01             	lea    0x1(%eax),%edx
  800cf3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800cf6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf9:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800cfb:	ff 4d f8             	decl   -0x8(%ebp)
  800cfe:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d02:	79 e9                	jns    800ced <memset+0x14>
		*p++ = c;

	return v;
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d07:	c9                   	leave  
  800d08:	c3                   	ret    

00800d09 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d09:	55                   	push   %ebp
  800d0a:	89 e5                	mov    %esp,%ebp
  800d0c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d15:	8b 45 08             	mov    0x8(%ebp),%eax
  800d18:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d1b:	eb 16                	jmp    800d33 <memcpy+0x2a>
		*d++ = *s++;
  800d1d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d20:	8d 50 01             	lea    0x1(%eax),%edx
  800d23:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d26:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d29:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d2c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d2f:	8a 12                	mov    (%edx),%dl
  800d31:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d33:	8b 45 10             	mov    0x10(%ebp),%eax
  800d36:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d39:	89 55 10             	mov    %edx,0x10(%ebp)
  800d3c:	85 c0                	test   %eax,%eax
  800d3e:	75 dd                	jne    800d1d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d40:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d43:	c9                   	leave  
  800d44:	c3                   	ret    

00800d45 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d45:	55                   	push   %ebp
  800d46:	89 e5                	mov    %esp,%ebp
  800d48:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d57:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d5a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d5d:	73 50                	jae    800daf <memmove+0x6a>
  800d5f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d62:	8b 45 10             	mov    0x10(%ebp),%eax
  800d65:	01 d0                	add    %edx,%eax
  800d67:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d6a:	76 43                	jbe    800daf <memmove+0x6a>
		s += n;
  800d6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800d72:	8b 45 10             	mov    0x10(%ebp),%eax
  800d75:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d78:	eb 10                	jmp    800d8a <memmove+0x45>
			*--d = *--s;
  800d7a:	ff 4d f8             	decl   -0x8(%ebp)
  800d7d:	ff 4d fc             	decl   -0x4(%ebp)
  800d80:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d83:	8a 10                	mov    (%eax),%dl
  800d85:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d88:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800d8a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d8d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d90:	89 55 10             	mov    %edx,0x10(%ebp)
  800d93:	85 c0                	test   %eax,%eax
  800d95:	75 e3                	jne    800d7a <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800d97:	eb 23                	jmp    800dbc <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800d99:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9c:	8d 50 01             	lea    0x1(%eax),%edx
  800d9f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800da2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800da5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800da8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dab:	8a 12                	mov    (%edx),%dl
  800dad:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800daf:	8b 45 10             	mov    0x10(%ebp),%eax
  800db2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800db5:	89 55 10             	mov    %edx,0x10(%ebp)
  800db8:	85 c0                	test   %eax,%eax
  800dba:	75 dd                	jne    800d99 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800dbc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dbf:	c9                   	leave  
  800dc0:	c3                   	ret    

00800dc1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800dc1:	55                   	push   %ebp
  800dc2:	89 e5                	mov    %esp,%ebp
  800dc4:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800dcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd0:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800dd3:	eb 2a                	jmp    800dff <memcmp+0x3e>
		if (*s1 != *s2)
  800dd5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dd8:	8a 10                	mov    (%eax),%dl
  800dda:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ddd:	8a 00                	mov    (%eax),%al
  800ddf:	38 c2                	cmp    %al,%dl
  800de1:	74 16                	je     800df9 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800de3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de6:	8a 00                	mov    (%eax),%al
  800de8:	0f b6 d0             	movzbl %al,%edx
  800deb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dee:	8a 00                	mov    (%eax),%al
  800df0:	0f b6 c0             	movzbl %al,%eax
  800df3:	29 c2                	sub    %eax,%edx
  800df5:	89 d0                	mov    %edx,%eax
  800df7:	eb 18                	jmp    800e11 <memcmp+0x50>
		s1++, s2++;
  800df9:	ff 45 fc             	incl   -0x4(%ebp)
  800dfc:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800dff:	8b 45 10             	mov    0x10(%ebp),%eax
  800e02:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e05:	89 55 10             	mov    %edx,0x10(%ebp)
  800e08:	85 c0                	test   %eax,%eax
  800e0a:	75 c9                	jne    800dd5 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e0c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e11:	c9                   	leave  
  800e12:	c3                   	ret    

00800e13 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e13:	55                   	push   %ebp
  800e14:	89 e5                	mov    %esp,%ebp
  800e16:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e19:	8b 55 08             	mov    0x8(%ebp),%edx
  800e1c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1f:	01 d0                	add    %edx,%eax
  800e21:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e24:	eb 15                	jmp    800e3b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e26:	8b 45 08             	mov    0x8(%ebp),%eax
  800e29:	8a 00                	mov    (%eax),%al
  800e2b:	0f b6 d0             	movzbl %al,%edx
  800e2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e31:	0f b6 c0             	movzbl %al,%eax
  800e34:	39 c2                	cmp    %eax,%edx
  800e36:	74 0d                	je     800e45 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e38:	ff 45 08             	incl   0x8(%ebp)
  800e3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e41:	72 e3                	jb     800e26 <memfind+0x13>
  800e43:	eb 01                	jmp    800e46 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e45:	90                   	nop
	return (void *) s;
  800e46:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e49:	c9                   	leave  
  800e4a:	c3                   	ret    

00800e4b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e4b:	55                   	push   %ebp
  800e4c:	89 e5                	mov    %esp,%ebp
  800e4e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e51:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e58:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e5f:	eb 03                	jmp    800e64 <strtol+0x19>
		s++;
  800e61:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	8a 00                	mov    (%eax),%al
  800e69:	3c 20                	cmp    $0x20,%al
  800e6b:	74 f4                	je     800e61 <strtol+0x16>
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	8a 00                	mov    (%eax),%al
  800e72:	3c 09                	cmp    $0x9,%al
  800e74:	74 eb                	je     800e61 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800e76:	8b 45 08             	mov    0x8(%ebp),%eax
  800e79:	8a 00                	mov    (%eax),%al
  800e7b:	3c 2b                	cmp    $0x2b,%al
  800e7d:	75 05                	jne    800e84 <strtol+0x39>
		s++;
  800e7f:	ff 45 08             	incl   0x8(%ebp)
  800e82:	eb 13                	jmp    800e97 <strtol+0x4c>
	else if (*s == '-')
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	8a 00                	mov    (%eax),%al
  800e89:	3c 2d                	cmp    $0x2d,%al
  800e8b:	75 0a                	jne    800e97 <strtol+0x4c>
		s++, neg = 1;
  800e8d:	ff 45 08             	incl   0x8(%ebp)
  800e90:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800e97:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e9b:	74 06                	je     800ea3 <strtol+0x58>
  800e9d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ea1:	75 20                	jne    800ec3 <strtol+0x78>
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	8a 00                	mov    (%eax),%al
  800ea8:	3c 30                	cmp    $0x30,%al
  800eaa:	75 17                	jne    800ec3 <strtol+0x78>
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	40                   	inc    %eax
  800eb0:	8a 00                	mov    (%eax),%al
  800eb2:	3c 78                	cmp    $0x78,%al
  800eb4:	75 0d                	jne    800ec3 <strtol+0x78>
		s += 2, base = 16;
  800eb6:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800eba:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ec1:	eb 28                	jmp    800eeb <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ec3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec7:	75 15                	jne    800ede <strtol+0x93>
  800ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecc:	8a 00                	mov    (%eax),%al
  800ece:	3c 30                	cmp    $0x30,%al
  800ed0:	75 0c                	jne    800ede <strtol+0x93>
		s++, base = 8;
  800ed2:	ff 45 08             	incl   0x8(%ebp)
  800ed5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800edc:	eb 0d                	jmp    800eeb <strtol+0xa0>
	else if (base == 0)
  800ede:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee2:	75 07                	jne    800eeb <strtol+0xa0>
		base = 10;
  800ee4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	8a 00                	mov    (%eax),%al
  800ef0:	3c 2f                	cmp    $0x2f,%al
  800ef2:	7e 19                	jle    800f0d <strtol+0xc2>
  800ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef7:	8a 00                	mov    (%eax),%al
  800ef9:	3c 39                	cmp    $0x39,%al
  800efb:	7f 10                	jg     800f0d <strtol+0xc2>
			dig = *s - '0';
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
  800f00:	8a 00                	mov    (%eax),%al
  800f02:	0f be c0             	movsbl %al,%eax
  800f05:	83 e8 30             	sub    $0x30,%eax
  800f08:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f0b:	eb 42                	jmp    800f4f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	3c 60                	cmp    $0x60,%al
  800f14:	7e 19                	jle    800f2f <strtol+0xe4>
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
  800f19:	8a 00                	mov    (%eax),%al
  800f1b:	3c 7a                	cmp    $0x7a,%al
  800f1d:	7f 10                	jg     800f2f <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f22:	8a 00                	mov    (%eax),%al
  800f24:	0f be c0             	movsbl %al,%eax
  800f27:	83 e8 57             	sub    $0x57,%eax
  800f2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f2d:	eb 20                	jmp    800f4f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f32:	8a 00                	mov    (%eax),%al
  800f34:	3c 40                	cmp    $0x40,%al
  800f36:	7e 39                	jle    800f71 <strtol+0x126>
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	8a 00                	mov    (%eax),%al
  800f3d:	3c 5a                	cmp    $0x5a,%al
  800f3f:	7f 30                	jg     800f71 <strtol+0x126>
			dig = *s - 'A' + 10;
  800f41:	8b 45 08             	mov    0x8(%ebp),%eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	0f be c0             	movsbl %al,%eax
  800f49:	83 e8 37             	sub    $0x37,%eax
  800f4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f52:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f55:	7d 19                	jge    800f70 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f57:	ff 45 08             	incl   0x8(%ebp)
  800f5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f5d:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f61:	89 c2                	mov    %eax,%edx
  800f63:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f66:	01 d0                	add    %edx,%eax
  800f68:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f6b:	e9 7b ff ff ff       	jmp    800eeb <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800f70:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800f71:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f75:	74 08                	je     800f7f <strtol+0x134>
		*endptr = (char *) s;
  800f77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7a:	8b 55 08             	mov    0x8(%ebp),%edx
  800f7d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800f7f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f83:	74 07                	je     800f8c <strtol+0x141>
  800f85:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f88:	f7 d8                	neg    %eax
  800f8a:	eb 03                	jmp    800f8f <strtol+0x144>
  800f8c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f8f:	c9                   	leave  
  800f90:	c3                   	ret    

00800f91 <ltostr>:

void
ltostr(long value, char *str)
{
  800f91:	55                   	push   %ebp
  800f92:	89 e5                	mov    %esp,%ebp
  800f94:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800f97:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800f9e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800fa5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fa9:	79 13                	jns    800fbe <ltostr+0x2d>
	{
		neg = 1;
  800fab:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800fb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb5:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800fb8:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800fbb:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800fc6:	99                   	cltd   
  800fc7:	f7 f9                	idiv   %ecx
  800fc9:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800fcc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fcf:	8d 50 01             	lea    0x1(%eax),%edx
  800fd2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fd5:	89 c2                	mov    %eax,%edx
  800fd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fda:	01 d0                	add    %edx,%eax
  800fdc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800fdf:	83 c2 30             	add    $0x30,%edx
  800fe2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800fe4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800fe7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fec:	f7 e9                	imul   %ecx
  800fee:	c1 fa 02             	sar    $0x2,%edx
  800ff1:	89 c8                	mov    %ecx,%eax
  800ff3:	c1 f8 1f             	sar    $0x1f,%eax
  800ff6:	29 c2                	sub    %eax,%edx
  800ff8:	89 d0                	mov    %edx,%eax
  800ffa:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ffd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801000:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801005:	f7 e9                	imul   %ecx
  801007:	c1 fa 02             	sar    $0x2,%edx
  80100a:	89 c8                	mov    %ecx,%eax
  80100c:	c1 f8 1f             	sar    $0x1f,%eax
  80100f:	29 c2                	sub    %eax,%edx
  801011:	89 d0                	mov    %edx,%eax
  801013:	c1 e0 02             	shl    $0x2,%eax
  801016:	01 d0                	add    %edx,%eax
  801018:	01 c0                	add    %eax,%eax
  80101a:	29 c1                	sub    %eax,%ecx
  80101c:	89 ca                	mov    %ecx,%edx
  80101e:	85 d2                	test   %edx,%edx
  801020:	75 9c                	jne    800fbe <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801022:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801029:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80102c:	48                   	dec    %eax
  80102d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801030:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801034:	74 3d                	je     801073 <ltostr+0xe2>
		start = 1 ;
  801036:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80103d:	eb 34                	jmp    801073 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80103f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801042:	8b 45 0c             	mov    0xc(%ebp),%eax
  801045:	01 d0                	add    %edx,%eax
  801047:	8a 00                	mov    (%eax),%al
  801049:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80104c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80104f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801052:	01 c2                	add    %eax,%edx
  801054:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801057:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105a:	01 c8                	add    %ecx,%eax
  80105c:	8a 00                	mov    (%eax),%al
  80105e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801060:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801063:	8b 45 0c             	mov    0xc(%ebp),%eax
  801066:	01 c2                	add    %eax,%edx
  801068:	8a 45 eb             	mov    -0x15(%ebp),%al
  80106b:	88 02                	mov    %al,(%edx)
		start++ ;
  80106d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801070:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801073:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801076:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801079:	7c c4                	jl     80103f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80107b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80107e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801081:	01 d0                	add    %edx,%eax
  801083:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801086:	90                   	nop
  801087:	c9                   	leave  
  801088:	c3                   	ret    

00801089 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801089:	55                   	push   %ebp
  80108a:	89 e5                	mov    %esp,%ebp
  80108c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80108f:	ff 75 08             	pushl  0x8(%ebp)
  801092:	e8 54 fa ff ff       	call   800aeb <strlen>
  801097:	83 c4 04             	add    $0x4,%esp
  80109a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80109d:	ff 75 0c             	pushl  0xc(%ebp)
  8010a0:	e8 46 fa ff ff       	call   800aeb <strlen>
  8010a5:	83 c4 04             	add    $0x4,%esp
  8010a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010b9:	eb 17                	jmp    8010d2 <strcconcat+0x49>
		final[s] = str1[s] ;
  8010bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010be:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c1:	01 c2                	add    %eax,%edx
  8010c3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	01 c8                	add    %ecx,%eax
  8010cb:	8a 00                	mov    (%eax),%al
  8010cd:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8010cf:	ff 45 fc             	incl   -0x4(%ebp)
  8010d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010d8:	7c e1                	jl     8010bb <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8010da:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8010e1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8010e8:	eb 1f                	jmp    801109 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8010ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ed:	8d 50 01             	lea    0x1(%eax),%edx
  8010f0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010f3:	89 c2                	mov    %eax,%edx
  8010f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f8:	01 c2                	add    %eax,%edx
  8010fa:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8010fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801100:	01 c8                	add    %ecx,%eax
  801102:	8a 00                	mov    (%eax),%al
  801104:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801106:	ff 45 f8             	incl   -0x8(%ebp)
  801109:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80110c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80110f:	7c d9                	jl     8010ea <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801111:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801114:	8b 45 10             	mov    0x10(%ebp),%eax
  801117:	01 d0                	add    %edx,%eax
  801119:	c6 00 00             	movb   $0x0,(%eax)
}
  80111c:	90                   	nop
  80111d:	c9                   	leave  
  80111e:	c3                   	ret    

0080111f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80111f:	55                   	push   %ebp
  801120:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801122:	8b 45 14             	mov    0x14(%ebp),%eax
  801125:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80112b:	8b 45 14             	mov    0x14(%ebp),%eax
  80112e:	8b 00                	mov    (%eax),%eax
  801130:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801137:	8b 45 10             	mov    0x10(%ebp),%eax
  80113a:	01 d0                	add    %edx,%eax
  80113c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801142:	eb 0c                	jmp    801150 <strsplit+0x31>
			*string++ = 0;
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	8d 50 01             	lea    0x1(%eax),%edx
  80114a:	89 55 08             	mov    %edx,0x8(%ebp)
  80114d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	8a 00                	mov    (%eax),%al
  801155:	84 c0                	test   %al,%al
  801157:	74 18                	je     801171 <strsplit+0x52>
  801159:	8b 45 08             	mov    0x8(%ebp),%eax
  80115c:	8a 00                	mov    (%eax),%al
  80115e:	0f be c0             	movsbl %al,%eax
  801161:	50                   	push   %eax
  801162:	ff 75 0c             	pushl  0xc(%ebp)
  801165:	e8 13 fb ff ff       	call   800c7d <strchr>
  80116a:	83 c4 08             	add    $0x8,%esp
  80116d:	85 c0                	test   %eax,%eax
  80116f:	75 d3                	jne    801144 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	8a 00                	mov    (%eax),%al
  801176:	84 c0                	test   %al,%al
  801178:	74 5a                	je     8011d4 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80117a:	8b 45 14             	mov    0x14(%ebp),%eax
  80117d:	8b 00                	mov    (%eax),%eax
  80117f:	83 f8 0f             	cmp    $0xf,%eax
  801182:	75 07                	jne    80118b <strsplit+0x6c>
		{
			return 0;
  801184:	b8 00 00 00 00       	mov    $0x0,%eax
  801189:	eb 66                	jmp    8011f1 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80118b:	8b 45 14             	mov    0x14(%ebp),%eax
  80118e:	8b 00                	mov    (%eax),%eax
  801190:	8d 48 01             	lea    0x1(%eax),%ecx
  801193:	8b 55 14             	mov    0x14(%ebp),%edx
  801196:	89 0a                	mov    %ecx,(%edx)
  801198:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80119f:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a2:	01 c2                	add    %eax,%edx
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011a9:	eb 03                	jmp    8011ae <strsplit+0x8f>
			string++;
  8011ab:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	8a 00                	mov    (%eax),%al
  8011b3:	84 c0                	test   %al,%al
  8011b5:	74 8b                	je     801142 <strsplit+0x23>
  8011b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ba:	8a 00                	mov    (%eax),%al
  8011bc:	0f be c0             	movsbl %al,%eax
  8011bf:	50                   	push   %eax
  8011c0:	ff 75 0c             	pushl  0xc(%ebp)
  8011c3:	e8 b5 fa ff ff       	call   800c7d <strchr>
  8011c8:	83 c4 08             	add    $0x8,%esp
  8011cb:	85 c0                	test   %eax,%eax
  8011cd:	74 dc                	je     8011ab <strsplit+0x8c>
			string++;
	}
  8011cf:	e9 6e ff ff ff       	jmp    801142 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8011d4:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8011d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d8:	8b 00                	mov    (%eax),%eax
  8011da:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e4:	01 d0                	add    %edx,%eax
  8011e6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8011ec:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8011f1:	c9                   	leave  
  8011f2:	c3                   	ret    

008011f3 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8011f3:	55                   	push   %ebp
  8011f4:	89 e5                	mov    %esp,%ebp
  8011f6:	57                   	push   %edi
  8011f7:	56                   	push   %esi
  8011f8:	53                   	push   %ebx
  8011f9:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8011fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801202:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801205:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801208:	8b 7d 18             	mov    0x18(%ebp),%edi
  80120b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80120e:	cd 30                	int    $0x30
  801210:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801213:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801216:	83 c4 10             	add    $0x10,%esp
  801219:	5b                   	pop    %ebx
  80121a:	5e                   	pop    %esi
  80121b:	5f                   	pop    %edi
  80121c:	5d                   	pop    %ebp
  80121d:	c3                   	ret    

0080121e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80121e:	55                   	push   %ebp
  80121f:	89 e5                	mov    %esp,%ebp
  801221:	83 ec 04             	sub    $0x4,%esp
  801224:	8b 45 10             	mov    0x10(%ebp),%eax
  801227:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80122a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	52                   	push   %edx
  801236:	ff 75 0c             	pushl  0xc(%ebp)
  801239:	50                   	push   %eax
  80123a:	6a 00                	push   $0x0
  80123c:	e8 b2 ff ff ff       	call   8011f3 <syscall>
  801241:	83 c4 18             	add    $0x18,%esp
}
  801244:	90                   	nop
  801245:	c9                   	leave  
  801246:	c3                   	ret    

00801247 <sys_cgetc>:

int
sys_cgetc(void)
{
  801247:	55                   	push   %ebp
  801248:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80124a:	6a 00                	push   $0x0
  80124c:	6a 00                	push   $0x0
  80124e:	6a 00                	push   $0x0
  801250:	6a 00                	push   $0x0
  801252:	6a 00                	push   $0x0
  801254:	6a 01                	push   $0x1
  801256:	e8 98 ff ff ff       	call   8011f3 <syscall>
  80125b:	83 c4 18             	add    $0x18,%esp
}
  80125e:	c9                   	leave  
  80125f:	c3                   	ret    

00801260 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801260:	55                   	push   %ebp
  801261:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	6a 00                	push   $0x0
  801268:	6a 00                	push   $0x0
  80126a:	6a 00                	push   $0x0
  80126c:	6a 00                	push   $0x0
  80126e:	50                   	push   %eax
  80126f:	6a 05                	push   $0x5
  801271:	e8 7d ff ff ff       	call   8011f3 <syscall>
  801276:	83 c4 18             	add    $0x18,%esp
}
  801279:	c9                   	leave  
  80127a:	c3                   	ret    

0080127b <sys_getenvid>:

int32 sys_getenvid(void)
{
  80127b:	55                   	push   %ebp
  80127c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	6a 00                	push   $0x0
  801286:	6a 00                	push   $0x0
  801288:	6a 02                	push   $0x2
  80128a:	e8 64 ff ff ff       	call   8011f3 <syscall>
  80128f:	83 c4 18             	add    $0x18,%esp
}
  801292:	c9                   	leave  
  801293:	c3                   	ret    

00801294 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801294:	55                   	push   %ebp
  801295:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801297:	6a 00                	push   $0x0
  801299:	6a 00                	push   $0x0
  80129b:	6a 00                	push   $0x0
  80129d:	6a 00                	push   $0x0
  80129f:	6a 00                	push   $0x0
  8012a1:	6a 03                	push   $0x3
  8012a3:	e8 4b ff ff ff       	call   8011f3 <syscall>
  8012a8:	83 c4 18             	add    $0x18,%esp
}
  8012ab:	c9                   	leave  
  8012ac:	c3                   	ret    

008012ad <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8012ad:	55                   	push   %ebp
  8012ae:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8012b0:	6a 00                	push   $0x0
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 04                	push   $0x4
  8012bc:	e8 32 ff ff ff       	call   8011f3 <syscall>
  8012c1:	83 c4 18             	add    $0x18,%esp
}
  8012c4:	c9                   	leave  
  8012c5:	c3                   	ret    

008012c6 <sys_env_exit>:


void sys_env_exit(void)
{
  8012c6:	55                   	push   %ebp
  8012c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8012c9:	6a 00                	push   $0x0
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 06                	push   $0x6
  8012d5:	e8 19 ff ff ff       	call   8011f3 <syscall>
  8012da:	83 c4 18             	add    $0x18,%esp
}
  8012dd:	90                   	nop
  8012de:	c9                   	leave  
  8012df:	c3                   	ret    

008012e0 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8012e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 00                	push   $0x0
  8012ef:	52                   	push   %edx
  8012f0:	50                   	push   %eax
  8012f1:	6a 07                	push   $0x7
  8012f3:	e8 fb fe ff ff       	call   8011f3 <syscall>
  8012f8:	83 c4 18             	add    $0x18,%esp
}
  8012fb:	c9                   	leave  
  8012fc:	c3                   	ret    

008012fd <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8012fd:	55                   	push   %ebp
  8012fe:	89 e5                	mov    %esp,%ebp
  801300:	56                   	push   %esi
  801301:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801302:	8b 75 18             	mov    0x18(%ebp),%esi
  801305:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801308:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80130b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	56                   	push   %esi
  801312:	53                   	push   %ebx
  801313:	51                   	push   %ecx
  801314:	52                   	push   %edx
  801315:	50                   	push   %eax
  801316:	6a 08                	push   $0x8
  801318:	e8 d6 fe ff ff       	call   8011f3 <syscall>
  80131d:	83 c4 18             	add    $0x18,%esp
}
  801320:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801323:	5b                   	pop    %ebx
  801324:	5e                   	pop    %esi
  801325:	5d                   	pop    %ebp
  801326:	c3                   	ret    

00801327 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80132a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132d:	8b 45 08             	mov    0x8(%ebp),%eax
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	52                   	push   %edx
  801337:	50                   	push   %eax
  801338:	6a 09                	push   $0x9
  80133a:	e8 b4 fe ff ff       	call   8011f3 <syscall>
  80133f:	83 c4 18             	add    $0x18,%esp
}
  801342:	c9                   	leave  
  801343:	c3                   	ret    

00801344 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	6a 00                	push   $0x0
  80134d:	ff 75 0c             	pushl  0xc(%ebp)
  801350:	ff 75 08             	pushl  0x8(%ebp)
  801353:	6a 0a                	push   $0xa
  801355:	e8 99 fe ff ff       	call   8011f3 <syscall>
  80135a:	83 c4 18             	add    $0x18,%esp
}
  80135d:	c9                   	leave  
  80135e:	c3                   	ret    

0080135f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80135f:	55                   	push   %ebp
  801360:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	6a 00                	push   $0x0
  80136c:	6a 0b                	push   $0xb
  80136e:	e8 80 fe ff ff       	call   8011f3 <syscall>
  801373:	83 c4 18             	add    $0x18,%esp
}
  801376:	c9                   	leave  
  801377:	c3                   	ret    

00801378 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801378:	55                   	push   %ebp
  801379:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	6a 00                	push   $0x0
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	6a 0c                	push   $0xc
  801387:	e8 67 fe ff ff       	call   8011f3 <syscall>
  80138c:	83 c4 18             	add    $0x18,%esp
}
  80138f:	c9                   	leave  
  801390:	c3                   	ret    

00801391 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801391:	55                   	push   %ebp
  801392:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 0d                	push   $0xd
  8013a0:	e8 4e fe ff ff       	call   8011f3 <syscall>
  8013a5:	83 c4 18             	add    $0x18,%esp
}
  8013a8:	c9                   	leave  
  8013a9:	c3                   	ret    

008013aa <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	ff 75 0c             	pushl  0xc(%ebp)
  8013b6:	ff 75 08             	pushl  0x8(%ebp)
  8013b9:	6a 11                	push   $0x11
  8013bb:	e8 33 fe ff ff       	call   8011f3 <syscall>
  8013c0:	83 c4 18             	add    $0x18,%esp
	return;
  8013c3:	90                   	nop
}
  8013c4:	c9                   	leave  
  8013c5:	c3                   	ret    

008013c6 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8013c6:	55                   	push   %ebp
  8013c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	ff 75 0c             	pushl  0xc(%ebp)
  8013d2:	ff 75 08             	pushl  0x8(%ebp)
  8013d5:	6a 12                	push   $0x12
  8013d7:	e8 17 fe ff ff       	call   8011f3 <syscall>
  8013dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8013df:	90                   	nop
}
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 0e                	push   $0xe
  8013f1:	e8 fd fd ff ff       	call   8011f3 <syscall>
  8013f6:	83 c4 18             	add    $0x18,%esp
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	ff 75 08             	pushl  0x8(%ebp)
  801409:	6a 0f                	push   $0xf
  80140b:	e8 e3 fd ff ff       	call   8011f3 <syscall>
  801410:	83 c4 18             	add    $0x18,%esp
}
  801413:	c9                   	leave  
  801414:	c3                   	ret    

00801415 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801415:	55                   	push   %ebp
  801416:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801418:	6a 00                	push   $0x0
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 10                	push   $0x10
  801424:	e8 ca fd ff ff       	call   8011f3 <syscall>
  801429:	83 c4 18             	add    $0x18,%esp
}
  80142c:	90                   	nop
  80142d:	c9                   	leave  
  80142e:	c3                   	ret    

0080142f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80142f:	55                   	push   %ebp
  801430:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801432:	6a 00                	push   $0x0
  801434:	6a 00                	push   $0x0
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	6a 14                	push   $0x14
  80143e:	e8 b0 fd ff ff       	call   8011f3 <syscall>
  801443:	83 c4 18             	add    $0x18,%esp
}
  801446:	90                   	nop
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80144c:	6a 00                	push   $0x0
  80144e:	6a 00                	push   $0x0
  801450:	6a 00                	push   $0x0
  801452:	6a 00                	push   $0x0
  801454:	6a 00                	push   $0x0
  801456:	6a 15                	push   $0x15
  801458:	e8 96 fd ff ff       	call   8011f3 <syscall>
  80145d:	83 c4 18             	add    $0x18,%esp
}
  801460:	90                   	nop
  801461:	c9                   	leave  
  801462:	c3                   	ret    

00801463 <sys_cputc>:


void
sys_cputc(const char c)
{
  801463:	55                   	push   %ebp
  801464:	89 e5                	mov    %esp,%ebp
  801466:	83 ec 04             	sub    $0x4,%esp
  801469:	8b 45 08             	mov    0x8(%ebp),%eax
  80146c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80146f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	50                   	push   %eax
  80147c:	6a 16                	push   $0x16
  80147e:	e8 70 fd ff ff       	call   8011f3 <syscall>
  801483:	83 c4 18             	add    $0x18,%esp
}
  801486:	90                   	nop
  801487:	c9                   	leave  
  801488:	c3                   	ret    

00801489 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801489:	55                   	push   %ebp
  80148a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	6a 17                	push   $0x17
  801498:	e8 56 fd ff ff       	call   8011f3 <syscall>
  80149d:	83 c4 18             	add    $0x18,%esp
}
  8014a0:	90                   	nop
  8014a1:	c9                   	leave  
  8014a2:	c3                   	ret    

008014a3 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014a3:	55                   	push   %ebp
  8014a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	ff 75 0c             	pushl  0xc(%ebp)
  8014b2:	50                   	push   %eax
  8014b3:	6a 18                	push   $0x18
  8014b5:	e8 39 fd ff ff       	call   8011f3 <syscall>
  8014ba:	83 c4 18             	add    $0x18,%esp
}
  8014bd:	c9                   	leave  
  8014be:	c3                   	ret    

008014bf <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8014bf:	55                   	push   %ebp
  8014c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	52                   	push   %edx
  8014cf:	50                   	push   %eax
  8014d0:	6a 1b                	push   $0x1b
  8014d2:	e8 1c fd ff ff       	call   8011f3 <syscall>
  8014d7:	83 c4 18             	add    $0x18,%esp
}
  8014da:	c9                   	leave  
  8014db:	c3                   	ret    

008014dc <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014dc:	55                   	push   %ebp
  8014dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	52                   	push   %edx
  8014ec:	50                   	push   %eax
  8014ed:	6a 19                	push   $0x19
  8014ef:	e8 ff fc ff ff       	call   8011f3 <syscall>
  8014f4:	83 c4 18             	add    $0x18,%esp
}
  8014f7:	90                   	nop
  8014f8:	c9                   	leave  
  8014f9:	c3                   	ret    

008014fa <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014fa:	55                   	push   %ebp
  8014fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801500:	8b 45 08             	mov    0x8(%ebp),%eax
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	6a 00                	push   $0x0
  801509:	52                   	push   %edx
  80150a:	50                   	push   %eax
  80150b:	6a 1a                	push   $0x1a
  80150d:	e8 e1 fc ff ff       	call   8011f3 <syscall>
  801512:	83 c4 18             	add    $0x18,%esp
}
  801515:	90                   	nop
  801516:	c9                   	leave  
  801517:	c3                   	ret    

00801518 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801518:	55                   	push   %ebp
  801519:	89 e5                	mov    %esp,%ebp
  80151b:	83 ec 04             	sub    $0x4,%esp
  80151e:	8b 45 10             	mov    0x10(%ebp),%eax
  801521:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801524:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801527:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80152b:	8b 45 08             	mov    0x8(%ebp),%eax
  80152e:	6a 00                	push   $0x0
  801530:	51                   	push   %ecx
  801531:	52                   	push   %edx
  801532:	ff 75 0c             	pushl  0xc(%ebp)
  801535:	50                   	push   %eax
  801536:	6a 1c                	push   $0x1c
  801538:	e8 b6 fc ff ff       	call   8011f3 <syscall>
  80153d:	83 c4 18             	add    $0x18,%esp
}
  801540:	c9                   	leave  
  801541:	c3                   	ret    

00801542 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801542:	55                   	push   %ebp
  801543:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801545:	8b 55 0c             	mov    0xc(%ebp),%edx
  801548:	8b 45 08             	mov    0x8(%ebp),%eax
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	52                   	push   %edx
  801552:	50                   	push   %eax
  801553:	6a 1d                	push   $0x1d
  801555:	e8 99 fc ff ff       	call   8011f3 <syscall>
  80155a:	83 c4 18             	add    $0x18,%esp
}
  80155d:	c9                   	leave  
  80155e:	c3                   	ret    

0080155f <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80155f:	55                   	push   %ebp
  801560:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801562:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801565:	8b 55 0c             	mov    0xc(%ebp),%edx
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	51                   	push   %ecx
  801570:	52                   	push   %edx
  801571:	50                   	push   %eax
  801572:	6a 1e                	push   $0x1e
  801574:	e8 7a fc ff ff       	call   8011f3 <syscall>
  801579:	83 c4 18             	add    $0x18,%esp
}
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801581:	8b 55 0c             	mov    0xc(%ebp),%edx
  801584:	8b 45 08             	mov    0x8(%ebp),%eax
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	52                   	push   %edx
  80158e:	50                   	push   %eax
  80158f:	6a 1f                	push   $0x1f
  801591:	e8 5d fc ff ff       	call   8011f3 <syscall>
  801596:	83 c4 18             	add    $0x18,%esp
}
  801599:	c9                   	leave  
  80159a:	c3                   	ret    

0080159b <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80159b:	55                   	push   %ebp
  80159c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 20                	push   $0x20
  8015aa:	e8 44 fc ff ff       	call   8011f3 <syscall>
  8015af:	83 c4 18             	add    $0x18,%esp
}
  8015b2:	c9                   	leave  
  8015b3:	c3                   	ret    

008015b4 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8015b4:	55                   	push   %ebp
  8015b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8015b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ba:	6a 00                	push   $0x0
  8015bc:	ff 75 14             	pushl  0x14(%ebp)
  8015bf:	ff 75 10             	pushl  0x10(%ebp)
  8015c2:	ff 75 0c             	pushl  0xc(%ebp)
  8015c5:	50                   	push   %eax
  8015c6:	6a 21                	push   $0x21
  8015c8:	e8 26 fc ff ff       	call   8011f3 <syscall>
  8015cd:	83 c4 18             	add    $0x18,%esp
}
  8015d0:	c9                   	leave  
  8015d1:	c3                   	ret    

008015d2 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8015d2:	55                   	push   %ebp
  8015d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8015d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	50                   	push   %eax
  8015e1:	6a 22                	push   $0x22
  8015e3:	e8 0b fc ff ff       	call   8011f3 <syscall>
  8015e8:	83 c4 18             	add    $0x18,%esp
}
  8015eb:	90                   	nop
  8015ec:	c9                   	leave  
  8015ed:	c3                   	ret    

008015ee <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8015ee:	55                   	push   %ebp
  8015ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8015f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	50                   	push   %eax
  8015fd:	6a 23                	push   $0x23
  8015ff:	e8 ef fb ff ff       	call   8011f3 <syscall>
  801604:	83 c4 18             	add    $0x18,%esp
}
  801607:	90                   	nop
  801608:	c9                   	leave  
  801609:	c3                   	ret    

0080160a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80160a:	55                   	push   %ebp
  80160b:	89 e5                	mov    %esp,%ebp
  80160d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801610:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801613:	8d 50 04             	lea    0x4(%eax),%edx
  801616:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	52                   	push   %edx
  801620:	50                   	push   %eax
  801621:	6a 24                	push   $0x24
  801623:	e8 cb fb ff ff       	call   8011f3 <syscall>
  801628:	83 c4 18             	add    $0x18,%esp
	return result;
  80162b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80162e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801631:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801634:	89 01                	mov    %eax,(%ecx)
  801636:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801639:	8b 45 08             	mov    0x8(%ebp),%eax
  80163c:	c9                   	leave  
  80163d:	c2 04 00             	ret    $0x4

00801640 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	ff 75 10             	pushl  0x10(%ebp)
  80164a:	ff 75 0c             	pushl  0xc(%ebp)
  80164d:	ff 75 08             	pushl  0x8(%ebp)
  801650:	6a 13                	push   $0x13
  801652:	e8 9c fb ff ff       	call   8011f3 <syscall>
  801657:	83 c4 18             	add    $0x18,%esp
	return ;
  80165a:	90                   	nop
}
  80165b:	c9                   	leave  
  80165c:	c3                   	ret    

0080165d <sys_rcr2>:
uint32 sys_rcr2()
{
  80165d:	55                   	push   %ebp
  80165e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	6a 25                	push   $0x25
  80166c:	e8 82 fb ff ff       	call   8011f3 <syscall>
  801671:	83 c4 18             	add    $0x18,%esp
}
  801674:	c9                   	leave  
  801675:	c3                   	ret    

00801676 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801676:	55                   	push   %ebp
  801677:	89 e5                	mov    %esp,%ebp
  801679:	83 ec 04             	sub    $0x4,%esp
  80167c:	8b 45 08             	mov    0x8(%ebp),%eax
  80167f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801682:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	50                   	push   %eax
  80168f:	6a 26                	push   $0x26
  801691:	e8 5d fb ff ff       	call   8011f3 <syscall>
  801696:	83 c4 18             	add    $0x18,%esp
	return ;
  801699:	90                   	nop
}
  80169a:	c9                   	leave  
  80169b:	c3                   	ret    

0080169c <rsttst>:
void rsttst()
{
  80169c:	55                   	push   %ebp
  80169d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 28                	push   $0x28
  8016ab:	e8 43 fb ff ff       	call   8011f3 <syscall>
  8016b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8016b3:	90                   	nop
}
  8016b4:	c9                   	leave  
  8016b5:	c3                   	ret    

008016b6 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8016b6:	55                   	push   %ebp
  8016b7:	89 e5                	mov    %esp,%ebp
  8016b9:	83 ec 04             	sub    $0x4,%esp
  8016bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8016bf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016c2:	8b 55 18             	mov    0x18(%ebp),%edx
  8016c5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016c9:	52                   	push   %edx
  8016ca:	50                   	push   %eax
  8016cb:	ff 75 10             	pushl  0x10(%ebp)
  8016ce:	ff 75 0c             	pushl  0xc(%ebp)
  8016d1:	ff 75 08             	pushl  0x8(%ebp)
  8016d4:	6a 27                	push   $0x27
  8016d6:	e8 18 fb ff ff       	call   8011f3 <syscall>
  8016db:	83 c4 18             	add    $0x18,%esp
	return ;
  8016de:	90                   	nop
}
  8016df:	c9                   	leave  
  8016e0:	c3                   	ret    

008016e1 <chktst>:
void chktst(uint32 n)
{
  8016e1:	55                   	push   %ebp
  8016e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	ff 75 08             	pushl  0x8(%ebp)
  8016ef:	6a 29                	push   $0x29
  8016f1:	e8 fd fa ff ff       	call   8011f3 <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f9:	90                   	nop
}
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <inctst>:

void inctst()
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 2a                	push   $0x2a
  80170b:	e8 e3 fa ff ff       	call   8011f3 <syscall>
  801710:	83 c4 18             	add    $0x18,%esp
	return ;
  801713:	90                   	nop
}
  801714:	c9                   	leave  
  801715:	c3                   	ret    

00801716 <gettst>:
uint32 gettst()
{
  801716:	55                   	push   %ebp
  801717:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 2b                	push   $0x2b
  801725:	e8 c9 fa ff ff       	call   8011f3 <syscall>
  80172a:	83 c4 18             	add    $0x18,%esp
}
  80172d:	c9                   	leave  
  80172e:	c3                   	ret    

0080172f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80172f:	55                   	push   %ebp
  801730:	89 e5                	mov    %esp,%ebp
  801732:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	6a 2c                	push   $0x2c
  801741:	e8 ad fa ff ff       	call   8011f3 <syscall>
  801746:	83 c4 18             	add    $0x18,%esp
  801749:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80174c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801750:	75 07                	jne    801759 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801752:	b8 01 00 00 00       	mov    $0x1,%eax
  801757:	eb 05                	jmp    80175e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801759:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80175e:	c9                   	leave  
  80175f:	c3                   	ret    

00801760 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801760:	55                   	push   %ebp
  801761:	89 e5                	mov    %esp,%ebp
  801763:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	6a 2c                	push   $0x2c
  801772:	e8 7c fa ff ff       	call   8011f3 <syscall>
  801777:	83 c4 18             	add    $0x18,%esp
  80177a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80177d:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801781:	75 07                	jne    80178a <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801783:	b8 01 00 00 00       	mov    $0x1,%eax
  801788:	eb 05                	jmp    80178f <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80178a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80178f:	c9                   	leave  
  801790:	c3                   	ret    

00801791 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
  801794:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 2c                	push   $0x2c
  8017a3:	e8 4b fa ff ff       	call   8011f3 <syscall>
  8017a8:	83 c4 18             	add    $0x18,%esp
  8017ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8017ae:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8017b2:	75 07                	jne    8017bb <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8017b4:	b8 01 00 00 00       	mov    $0x1,%eax
  8017b9:	eb 05                	jmp    8017c0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8017bb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017c0:	c9                   	leave  
  8017c1:	c3                   	ret    

008017c2 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8017c2:	55                   	push   %ebp
  8017c3:	89 e5                	mov    %esp,%ebp
  8017c5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 2c                	push   $0x2c
  8017d4:	e8 1a fa ff ff       	call   8011f3 <syscall>
  8017d9:	83 c4 18             	add    $0x18,%esp
  8017dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8017df:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8017e3:	75 07                	jne    8017ec <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8017e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ea:	eb 05                	jmp    8017f1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8017ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f1:	c9                   	leave  
  8017f2:	c3                   	ret    

008017f3 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8017f3:	55                   	push   %ebp
  8017f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	ff 75 08             	pushl  0x8(%ebp)
  801801:	6a 2d                	push   $0x2d
  801803:	e8 eb f9 ff ff       	call   8011f3 <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
	return ;
  80180b:	90                   	nop
}
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
  801811:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801812:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801815:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801818:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181b:	8b 45 08             	mov    0x8(%ebp),%eax
  80181e:	6a 00                	push   $0x0
  801820:	53                   	push   %ebx
  801821:	51                   	push   %ecx
  801822:	52                   	push   %edx
  801823:	50                   	push   %eax
  801824:	6a 2e                	push   $0x2e
  801826:	e8 c8 f9 ff ff       	call   8011f3 <syscall>
  80182b:	83 c4 18             	add    $0x18,%esp
}
  80182e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801836:	8b 55 0c             	mov    0xc(%ebp),%edx
  801839:	8b 45 08             	mov    0x8(%ebp),%eax
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	52                   	push   %edx
  801843:	50                   	push   %eax
  801844:	6a 2f                	push   $0x2f
  801846:	e8 a8 f9 ff ff       	call   8011f3 <syscall>
  80184b:	83 c4 18             	add    $0x18,%esp
}
  80184e:	c9                   	leave  
  80184f:	c3                   	ret    

00801850 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801850:	55                   	push   %ebp
  801851:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	ff 75 0c             	pushl  0xc(%ebp)
  80185c:	ff 75 08             	pushl  0x8(%ebp)
  80185f:	6a 30                	push   $0x30
  801861:	e8 8d f9 ff ff       	call   8011f3 <syscall>
  801866:	83 c4 18             	add    $0x18,%esp
	return ;
  801869:	90                   	nop
}
  80186a:	c9                   	leave  
  80186b:	c3                   	ret    

0080186c <__udivdi3>:
  80186c:	55                   	push   %ebp
  80186d:	57                   	push   %edi
  80186e:	56                   	push   %esi
  80186f:	53                   	push   %ebx
  801870:	83 ec 1c             	sub    $0x1c,%esp
  801873:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801877:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80187b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80187f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801883:	89 ca                	mov    %ecx,%edx
  801885:	89 f8                	mov    %edi,%eax
  801887:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80188b:	85 f6                	test   %esi,%esi
  80188d:	75 2d                	jne    8018bc <__udivdi3+0x50>
  80188f:	39 cf                	cmp    %ecx,%edi
  801891:	77 65                	ja     8018f8 <__udivdi3+0x8c>
  801893:	89 fd                	mov    %edi,%ebp
  801895:	85 ff                	test   %edi,%edi
  801897:	75 0b                	jne    8018a4 <__udivdi3+0x38>
  801899:	b8 01 00 00 00       	mov    $0x1,%eax
  80189e:	31 d2                	xor    %edx,%edx
  8018a0:	f7 f7                	div    %edi
  8018a2:	89 c5                	mov    %eax,%ebp
  8018a4:	31 d2                	xor    %edx,%edx
  8018a6:	89 c8                	mov    %ecx,%eax
  8018a8:	f7 f5                	div    %ebp
  8018aa:	89 c1                	mov    %eax,%ecx
  8018ac:	89 d8                	mov    %ebx,%eax
  8018ae:	f7 f5                	div    %ebp
  8018b0:	89 cf                	mov    %ecx,%edi
  8018b2:	89 fa                	mov    %edi,%edx
  8018b4:	83 c4 1c             	add    $0x1c,%esp
  8018b7:	5b                   	pop    %ebx
  8018b8:	5e                   	pop    %esi
  8018b9:	5f                   	pop    %edi
  8018ba:	5d                   	pop    %ebp
  8018bb:	c3                   	ret    
  8018bc:	39 ce                	cmp    %ecx,%esi
  8018be:	77 28                	ja     8018e8 <__udivdi3+0x7c>
  8018c0:	0f bd fe             	bsr    %esi,%edi
  8018c3:	83 f7 1f             	xor    $0x1f,%edi
  8018c6:	75 40                	jne    801908 <__udivdi3+0x9c>
  8018c8:	39 ce                	cmp    %ecx,%esi
  8018ca:	72 0a                	jb     8018d6 <__udivdi3+0x6a>
  8018cc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8018d0:	0f 87 9e 00 00 00    	ja     801974 <__udivdi3+0x108>
  8018d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8018db:	89 fa                	mov    %edi,%edx
  8018dd:	83 c4 1c             	add    $0x1c,%esp
  8018e0:	5b                   	pop    %ebx
  8018e1:	5e                   	pop    %esi
  8018e2:	5f                   	pop    %edi
  8018e3:	5d                   	pop    %ebp
  8018e4:	c3                   	ret    
  8018e5:	8d 76 00             	lea    0x0(%esi),%esi
  8018e8:	31 ff                	xor    %edi,%edi
  8018ea:	31 c0                	xor    %eax,%eax
  8018ec:	89 fa                	mov    %edi,%edx
  8018ee:	83 c4 1c             	add    $0x1c,%esp
  8018f1:	5b                   	pop    %ebx
  8018f2:	5e                   	pop    %esi
  8018f3:	5f                   	pop    %edi
  8018f4:	5d                   	pop    %ebp
  8018f5:	c3                   	ret    
  8018f6:	66 90                	xchg   %ax,%ax
  8018f8:	89 d8                	mov    %ebx,%eax
  8018fa:	f7 f7                	div    %edi
  8018fc:	31 ff                	xor    %edi,%edi
  8018fe:	89 fa                	mov    %edi,%edx
  801900:	83 c4 1c             	add    $0x1c,%esp
  801903:	5b                   	pop    %ebx
  801904:	5e                   	pop    %esi
  801905:	5f                   	pop    %edi
  801906:	5d                   	pop    %ebp
  801907:	c3                   	ret    
  801908:	bd 20 00 00 00       	mov    $0x20,%ebp
  80190d:	89 eb                	mov    %ebp,%ebx
  80190f:	29 fb                	sub    %edi,%ebx
  801911:	89 f9                	mov    %edi,%ecx
  801913:	d3 e6                	shl    %cl,%esi
  801915:	89 c5                	mov    %eax,%ebp
  801917:	88 d9                	mov    %bl,%cl
  801919:	d3 ed                	shr    %cl,%ebp
  80191b:	89 e9                	mov    %ebp,%ecx
  80191d:	09 f1                	or     %esi,%ecx
  80191f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801923:	89 f9                	mov    %edi,%ecx
  801925:	d3 e0                	shl    %cl,%eax
  801927:	89 c5                	mov    %eax,%ebp
  801929:	89 d6                	mov    %edx,%esi
  80192b:	88 d9                	mov    %bl,%cl
  80192d:	d3 ee                	shr    %cl,%esi
  80192f:	89 f9                	mov    %edi,%ecx
  801931:	d3 e2                	shl    %cl,%edx
  801933:	8b 44 24 08          	mov    0x8(%esp),%eax
  801937:	88 d9                	mov    %bl,%cl
  801939:	d3 e8                	shr    %cl,%eax
  80193b:	09 c2                	or     %eax,%edx
  80193d:	89 d0                	mov    %edx,%eax
  80193f:	89 f2                	mov    %esi,%edx
  801941:	f7 74 24 0c          	divl   0xc(%esp)
  801945:	89 d6                	mov    %edx,%esi
  801947:	89 c3                	mov    %eax,%ebx
  801949:	f7 e5                	mul    %ebp
  80194b:	39 d6                	cmp    %edx,%esi
  80194d:	72 19                	jb     801968 <__udivdi3+0xfc>
  80194f:	74 0b                	je     80195c <__udivdi3+0xf0>
  801951:	89 d8                	mov    %ebx,%eax
  801953:	31 ff                	xor    %edi,%edi
  801955:	e9 58 ff ff ff       	jmp    8018b2 <__udivdi3+0x46>
  80195a:	66 90                	xchg   %ax,%ax
  80195c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801960:	89 f9                	mov    %edi,%ecx
  801962:	d3 e2                	shl    %cl,%edx
  801964:	39 c2                	cmp    %eax,%edx
  801966:	73 e9                	jae    801951 <__udivdi3+0xe5>
  801968:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80196b:	31 ff                	xor    %edi,%edi
  80196d:	e9 40 ff ff ff       	jmp    8018b2 <__udivdi3+0x46>
  801972:	66 90                	xchg   %ax,%ax
  801974:	31 c0                	xor    %eax,%eax
  801976:	e9 37 ff ff ff       	jmp    8018b2 <__udivdi3+0x46>
  80197b:	90                   	nop

0080197c <__umoddi3>:
  80197c:	55                   	push   %ebp
  80197d:	57                   	push   %edi
  80197e:	56                   	push   %esi
  80197f:	53                   	push   %ebx
  801980:	83 ec 1c             	sub    $0x1c,%esp
  801983:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801987:	8b 74 24 34          	mov    0x34(%esp),%esi
  80198b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80198f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801993:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801997:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80199b:	89 f3                	mov    %esi,%ebx
  80199d:	89 fa                	mov    %edi,%edx
  80199f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8019a3:	89 34 24             	mov    %esi,(%esp)
  8019a6:	85 c0                	test   %eax,%eax
  8019a8:	75 1a                	jne    8019c4 <__umoddi3+0x48>
  8019aa:	39 f7                	cmp    %esi,%edi
  8019ac:	0f 86 a2 00 00 00    	jbe    801a54 <__umoddi3+0xd8>
  8019b2:	89 c8                	mov    %ecx,%eax
  8019b4:	89 f2                	mov    %esi,%edx
  8019b6:	f7 f7                	div    %edi
  8019b8:	89 d0                	mov    %edx,%eax
  8019ba:	31 d2                	xor    %edx,%edx
  8019bc:	83 c4 1c             	add    $0x1c,%esp
  8019bf:	5b                   	pop    %ebx
  8019c0:	5e                   	pop    %esi
  8019c1:	5f                   	pop    %edi
  8019c2:	5d                   	pop    %ebp
  8019c3:	c3                   	ret    
  8019c4:	39 f0                	cmp    %esi,%eax
  8019c6:	0f 87 ac 00 00 00    	ja     801a78 <__umoddi3+0xfc>
  8019cc:	0f bd e8             	bsr    %eax,%ebp
  8019cf:	83 f5 1f             	xor    $0x1f,%ebp
  8019d2:	0f 84 ac 00 00 00    	je     801a84 <__umoddi3+0x108>
  8019d8:	bf 20 00 00 00       	mov    $0x20,%edi
  8019dd:	29 ef                	sub    %ebp,%edi
  8019df:	89 fe                	mov    %edi,%esi
  8019e1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8019e5:	89 e9                	mov    %ebp,%ecx
  8019e7:	d3 e0                	shl    %cl,%eax
  8019e9:	89 d7                	mov    %edx,%edi
  8019eb:	89 f1                	mov    %esi,%ecx
  8019ed:	d3 ef                	shr    %cl,%edi
  8019ef:	09 c7                	or     %eax,%edi
  8019f1:	89 e9                	mov    %ebp,%ecx
  8019f3:	d3 e2                	shl    %cl,%edx
  8019f5:	89 14 24             	mov    %edx,(%esp)
  8019f8:	89 d8                	mov    %ebx,%eax
  8019fa:	d3 e0                	shl    %cl,%eax
  8019fc:	89 c2                	mov    %eax,%edx
  8019fe:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a02:	d3 e0                	shl    %cl,%eax
  801a04:	89 44 24 04          	mov    %eax,0x4(%esp)
  801a08:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a0c:	89 f1                	mov    %esi,%ecx
  801a0e:	d3 e8                	shr    %cl,%eax
  801a10:	09 d0                	or     %edx,%eax
  801a12:	d3 eb                	shr    %cl,%ebx
  801a14:	89 da                	mov    %ebx,%edx
  801a16:	f7 f7                	div    %edi
  801a18:	89 d3                	mov    %edx,%ebx
  801a1a:	f7 24 24             	mull   (%esp)
  801a1d:	89 c6                	mov    %eax,%esi
  801a1f:	89 d1                	mov    %edx,%ecx
  801a21:	39 d3                	cmp    %edx,%ebx
  801a23:	0f 82 87 00 00 00    	jb     801ab0 <__umoddi3+0x134>
  801a29:	0f 84 91 00 00 00    	je     801ac0 <__umoddi3+0x144>
  801a2f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801a33:	29 f2                	sub    %esi,%edx
  801a35:	19 cb                	sbb    %ecx,%ebx
  801a37:	89 d8                	mov    %ebx,%eax
  801a39:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801a3d:	d3 e0                	shl    %cl,%eax
  801a3f:	89 e9                	mov    %ebp,%ecx
  801a41:	d3 ea                	shr    %cl,%edx
  801a43:	09 d0                	or     %edx,%eax
  801a45:	89 e9                	mov    %ebp,%ecx
  801a47:	d3 eb                	shr    %cl,%ebx
  801a49:	89 da                	mov    %ebx,%edx
  801a4b:	83 c4 1c             	add    $0x1c,%esp
  801a4e:	5b                   	pop    %ebx
  801a4f:	5e                   	pop    %esi
  801a50:	5f                   	pop    %edi
  801a51:	5d                   	pop    %ebp
  801a52:	c3                   	ret    
  801a53:	90                   	nop
  801a54:	89 fd                	mov    %edi,%ebp
  801a56:	85 ff                	test   %edi,%edi
  801a58:	75 0b                	jne    801a65 <__umoddi3+0xe9>
  801a5a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a5f:	31 d2                	xor    %edx,%edx
  801a61:	f7 f7                	div    %edi
  801a63:	89 c5                	mov    %eax,%ebp
  801a65:	89 f0                	mov    %esi,%eax
  801a67:	31 d2                	xor    %edx,%edx
  801a69:	f7 f5                	div    %ebp
  801a6b:	89 c8                	mov    %ecx,%eax
  801a6d:	f7 f5                	div    %ebp
  801a6f:	89 d0                	mov    %edx,%eax
  801a71:	e9 44 ff ff ff       	jmp    8019ba <__umoddi3+0x3e>
  801a76:	66 90                	xchg   %ax,%ax
  801a78:	89 c8                	mov    %ecx,%eax
  801a7a:	89 f2                	mov    %esi,%edx
  801a7c:	83 c4 1c             	add    $0x1c,%esp
  801a7f:	5b                   	pop    %ebx
  801a80:	5e                   	pop    %esi
  801a81:	5f                   	pop    %edi
  801a82:	5d                   	pop    %ebp
  801a83:	c3                   	ret    
  801a84:	3b 04 24             	cmp    (%esp),%eax
  801a87:	72 06                	jb     801a8f <__umoddi3+0x113>
  801a89:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801a8d:	77 0f                	ja     801a9e <__umoddi3+0x122>
  801a8f:	89 f2                	mov    %esi,%edx
  801a91:	29 f9                	sub    %edi,%ecx
  801a93:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801a97:	89 14 24             	mov    %edx,(%esp)
  801a9a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a9e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801aa2:	8b 14 24             	mov    (%esp),%edx
  801aa5:	83 c4 1c             	add    $0x1c,%esp
  801aa8:	5b                   	pop    %ebx
  801aa9:	5e                   	pop    %esi
  801aaa:	5f                   	pop    %edi
  801aab:	5d                   	pop    %ebp
  801aac:	c3                   	ret    
  801aad:	8d 76 00             	lea    0x0(%esi),%esi
  801ab0:	2b 04 24             	sub    (%esp),%eax
  801ab3:	19 fa                	sbb    %edi,%edx
  801ab5:	89 d1                	mov    %edx,%ecx
  801ab7:	89 c6                	mov    %eax,%esi
  801ab9:	e9 71 ff ff ff       	jmp    801a2f <__umoddi3+0xb3>
  801abe:	66 90                	xchg   %ax,%ax
  801ac0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ac4:	72 ea                	jb     801ab0 <__umoddi3+0x134>
  801ac6:	89 d9                	mov    %ebx,%ecx
  801ac8:	e9 62 ff ff ff       	jmp    801a2f <__umoddi3+0xb3>
