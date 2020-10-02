
obj/user/heap_program:     file format elf32-i386


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
  800031:	e8 f4 01 00 00       	call   80022a <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 5c             	sub    $0x5c,%esp
	int kilo = 1024;
  800041:	c7 45 d8 00 04 00 00 	movl   $0x400,-0x28(%ebp)
	int Mega = 1024*1024;
  800048:	c7 45 d4 00 00 10 00 	movl   $0x100000,-0x2c(%ebp)

	/// testing freeHeap()
	{
		uint32 size = 13*Mega;
  80004f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800052:	89 d0                	mov    %edx,%eax
  800054:	01 c0                	add    %eax,%eax
  800056:	01 d0                	add    %edx,%eax
  800058:	c1 e0 02             	shl    $0x2,%eax
  80005b:	01 d0                	add    %edx,%eax
  80005d:	89 45 d0             	mov    %eax,-0x30(%ebp)
		char *x = malloc(sizeof( char)*size) ;
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	ff 75 d0             	pushl  -0x30(%ebp)
  800066:	e8 25 13 00 00       	call   801390 <malloc>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	89 45 cc             	mov    %eax,-0x34(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  800071:	83 ec 0c             	sub    $0xc,%esp
  800074:	ff 75 d0             	pushl  -0x30(%ebp)
  800077:	e8 14 13 00 00       	call   801390 <malloc>
  80007c:	83 c4 10             	add    $0x10,%esp
  80007f:	89 45 c8             	mov    %eax,-0x38(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800082:	e8 e8 15 00 00       	call   80166f <sys_pf_calculate_allocated_pages>
  800087:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		x[1]=-1;
  80008a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80008d:	40                   	inc    %eax
  80008e:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega]=-1;
  800091:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800094:	89 d0                	mov    %edx,%eax
  800096:	c1 e0 02             	shl    $0x2,%eax
  800099:	01 d0                	add    %edx,%eax
  80009b:	89 c2                	mov    %eax,%edx
  80009d:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000a0:	01 d0                	add    %edx,%eax
  8000a2:	c6 00 ff             	movb   $0xff,(%eax)

		x[8*Mega] = -1;
  8000a5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000a8:	c1 e0 03             	shl    $0x3,%eax
  8000ab:	89 c2                	mov    %eax,%edx
  8000ad:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000b0:	01 d0                	add    %edx,%eax
  8000b2:	c6 00 ff             	movb   $0xff,(%eax)

		x[12*Mega]=-1;
  8000b5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8000b8:	89 d0                	mov    %edx,%eax
  8000ba:	01 c0                	add    %eax,%eax
  8000bc:	01 d0                	add    %edx,%eax
  8000be:	c1 e0 02             	shl    $0x2,%eax
  8000c1:	89 c2                	mov    %eax,%edx
  8000c3:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000c6:	01 d0                	add    %edx,%eax
  8000c8:	c6 00 ff             	movb   $0xff,(%eax)

		//int usedDiskPages = sys_pf_calculate_allocated_pages() ;

		free(x);
  8000cb:	83 ec 0c             	sub    $0xc,%esp
  8000ce:	ff 75 cc             	pushl  -0x34(%ebp)
  8000d1:	e8 d4 12 00 00       	call   8013aa <free>
  8000d6:	83 c4 10             	add    $0x10,%esp
		free(y);
  8000d9:	83 ec 0c             	sub    $0xc,%esp
  8000dc:	ff 75 c8             	pushl  -0x38(%ebp)
  8000df:	e8 c6 12 00 00       	call   8013aa <free>
  8000e4:	83 c4 10             	add    $0x10,%esp

		///		cprintf("%d\n",sys_pf_calculate_allocated_pages() - usedDiskPages);
		///assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 5 ); //4 pages + 1 table, that was not in WS

		int freePages = sys_calculate_free_frames();
  8000e7:	e8 00 15 00 00       	call   8015ec <sys_calculate_free_frames>
  8000ec:	89 45 c0             	mov    %eax,-0x40(%ebp)

		x = malloc(sizeof(char)*size) ;
  8000ef:	83 ec 0c             	sub    $0xc,%esp
  8000f2:	ff 75 d0             	pushl  -0x30(%ebp)
  8000f5:	e8 96 12 00 00       	call   801390 <malloc>
  8000fa:	83 c4 10             	add    $0x10,%esp
  8000fd:	89 45 cc             	mov    %eax,-0x34(%ebp)

		x[1]=-2;
  800100:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800103:	40                   	inc    %eax
  800104:	c6 00 fe             	movb   $0xfe,(%eax)

		x[5*Mega]=-2;
  800107:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80010a:	89 d0                	mov    %edx,%eax
  80010c:	c1 e0 02             	shl    $0x2,%eax
  80010f:	01 d0                	add    %edx,%eax
  800111:	89 c2                	mov    %eax,%edx
  800113:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800116:	01 d0                	add    %edx,%eax
  800118:	c6 00 fe             	movb   $0xfe,(%eax)

		x[8*Mega] = -2;
  80011b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80011e:	c1 e0 03             	shl    $0x3,%eax
  800121:	89 c2                	mov    %eax,%edx
  800123:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800126:	01 d0                	add    %edx,%eax
  800128:	c6 00 fe             	movb   $0xfe,(%eax)

		x[12*Mega]=-2;
  80012b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80012e:	89 d0                	mov    %edx,%eax
  800130:	01 c0                	add    %eax,%eax
  800132:	01 d0                	add    %edx,%eax
  800134:	c1 e0 02             	shl    $0x2,%eax
  800137:	89 c2                	mov    %eax,%edx
  800139:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	c6 00 fe             	movb   $0xfe,(%eax)

		uint32 pageWSEntries[8] = {0x802000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0x801000, 0x800000, 0xeebfd000};
  800141:	8d 45 9c             	lea    -0x64(%ebp),%eax
  800144:	bb 20 1e 80 00       	mov    $0x801e20,%ebx
  800149:	ba 08 00 00 00       	mov    $0x8,%edx
  80014e:	89 c7                	mov    %eax,%edi
  800150:	89 de                	mov    %ebx,%esi
  800152:	89 d1                	mov    %edx,%ecx
  800154:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

		int i = 0, j ;
  800156:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (; i < (myEnv->page_WS_max_size); i++)
  80015d:	eb 7a                	jmp    8001d9 <_main+0x1a1>
		{
			int found = 0 ;
  80015f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  800166:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80016d:	eb 3e                	jmp    8001ad <_main+0x175>
			{
				if (pageWSEntries[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE) )
  80016f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800172:	8b 4c 85 9c          	mov    -0x64(%ebp,%eax,4),%ecx
  800176:	a1 20 30 80 00       	mov    0x803020,%eax
  80017b:	8b 98 f0 52 00 00    	mov    0x52f0(%eax),%ebx
  800181:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800184:	89 d0                	mov    %edx,%eax
  800186:	c1 e0 02             	shl    $0x2,%eax
  800189:	01 d0                	add    %edx,%eax
  80018b:	c1 e0 02             	shl    $0x2,%eax
  80018e:	01 d8                	add    %ebx,%eax
  800190:	8b 00                	mov    (%eax),%eax
  800192:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800195:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800198:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019d:	39 c1                	cmp    %eax,%ecx
  80019f:	75 09                	jne    8001aa <_main+0x172>
				{
					found = 1 ;
  8001a1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
					break;
  8001a8:	eb 12                	jmp    8001bc <_main+0x184>

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
		{
			int found = 0 ;
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8001aa:	ff 45 e0             	incl   -0x20(%ebp)
  8001ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b2:	8b 50 74             	mov    0x74(%eax),%edx
  8001b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001b8:	39 c2                	cmp    %eax,%edx
  8001ba:	77 b3                	ja     80016f <_main+0x137>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  8001bc:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001c0:	75 14                	jne    8001d6 <_main+0x19e>
				panic("PAGE Placement algorithm failed after applying freeHeap");
  8001c2:	83 ec 04             	sub    $0x4,%esp
  8001c5:	68 60 1d 80 00       	push   $0x801d60
  8001ca:	6a 41                	push   $0x41
  8001cc:	68 98 1d 80 00       	push   $0x801d98
  8001d1:	e8 79 01 00 00       	call   80034f <_panic>
		x[12*Mega]=-2;

		uint32 pageWSEntries[8] = {0x802000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0x801000, 0x800000, 0xeebfd000};

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
  8001d6:	ff 45 e4             	incl   -0x1c(%ebp)
  8001d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001de:	8b 50 74             	mov    0x74(%eax),%edx
  8001e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001e4:	39 c2                	cmp    %eax,%edx
  8001e6:	0f 87 73 ff ff ff    	ja     80015f <_main+0x127>
			if (!found)
				panic("PAGE Placement algorithm failed after applying freeHeap");
		}


		if( (freePages - sys_calculate_free_frames() ) != 8 ) panic("Extra/Less memory are wrongly allocated");
  8001ec:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8001ef:	e8 f8 13 00 00       	call   8015ec <sys_calculate_free_frames>
  8001f4:	29 c3                	sub    %eax,%ebx
  8001f6:	89 d8                	mov    %ebx,%eax
  8001f8:	83 f8 08             	cmp    $0x8,%eax
  8001fb:	74 14                	je     800211 <_main+0x1d9>
  8001fd:	83 ec 04             	sub    $0x4,%esp
  800200:	68 ac 1d 80 00       	push   $0x801dac
  800205:	6a 45                	push   $0x45
  800207:	68 98 1d 80 00       	push   $0x801d98
  80020c:	e8 3e 01 00 00       	call   80034f <_panic>
	}

	cprintf("Congratulations!! test HEAP_PROGRAM completed successfully.\n");
  800211:	83 ec 0c             	sub    $0xc,%esp
  800214:	68 d4 1d 80 00       	push   $0x801dd4
  800219:	e8 e8 03 00 00       	call   800606 <cprintf>
  80021e:	83 c4 10             	add    $0x10,%esp


	return;
  800221:	90                   	nop
}
  800222:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800225:	5b                   	pop    %ebx
  800226:	5e                   	pop    %esi
  800227:	5f                   	pop    %edi
  800228:	5d                   	pop    %ebp
  800229:	c3                   	ret    

0080022a <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80022a:	55                   	push   %ebp
  80022b:	89 e5                	mov    %esp,%ebp
  80022d:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800230:	e8 ec 12 00 00       	call   801521 <sys_getenvindex>
  800235:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800238:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80023b:	89 d0                	mov    %edx,%eax
  80023d:	c1 e0 03             	shl    $0x3,%eax
  800240:	01 d0                	add    %edx,%eax
  800242:	c1 e0 02             	shl    $0x2,%eax
  800245:	01 d0                	add    %edx,%eax
  800247:	c1 e0 06             	shl    $0x6,%eax
  80024a:	29 d0                	sub    %edx,%eax
  80024c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800253:	01 c8                	add    %ecx,%eax
  800255:	01 d0                	add    %edx,%eax
  800257:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80025c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800261:	a1 20 30 80 00       	mov    0x803020,%eax
  800266:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  80026c:	84 c0                	test   %al,%al
  80026e:	74 0f                	je     80027f <libmain+0x55>
		binaryname = myEnv->prog_name;
  800270:	a1 20 30 80 00       	mov    0x803020,%eax
  800275:	05 b0 52 00 00       	add    $0x52b0,%eax
  80027a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80027f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800283:	7e 0a                	jle    80028f <libmain+0x65>
		binaryname = argv[0];
  800285:	8b 45 0c             	mov    0xc(%ebp),%eax
  800288:	8b 00                	mov    (%eax),%eax
  80028a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80028f:	83 ec 08             	sub    $0x8,%esp
  800292:	ff 75 0c             	pushl  0xc(%ebp)
  800295:	ff 75 08             	pushl  0x8(%ebp)
  800298:	e8 9b fd ff ff       	call   800038 <_main>
  80029d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8002a0:	e8 17 14 00 00       	call   8016bc <sys_disable_interrupt>
	cprintf("**************************************\n");
  8002a5:	83 ec 0c             	sub    $0xc,%esp
  8002a8:	68 58 1e 80 00       	push   $0x801e58
  8002ad:	e8 54 03 00 00       	call   800606 <cprintf>
  8002b2:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ba:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  8002c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c5:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  8002cb:	83 ec 04             	sub    $0x4,%esp
  8002ce:	52                   	push   %edx
  8002cf:	50                   	push   %eax
  8002d0:	68 80 1e 80 00       	push   $0x801e80
  8002d5:	e8 2c 03 00 00       	call   800606 <cprintf>
  8002da:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8002dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e2:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  8002e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ed:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  8002f3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f8:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  8002fe:	51                   	push   %ecx
  8002ff:	52                   	push   %edx
  800300:	50                   	push   %eax
  800301:	68 a8 1e 80 00       	push   $0x801ea8
  800306:	e8 fb 02 00 00       	call   800606 <cprintf>
  80030b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80030e:	83 ec 0c             	sub    $0xc,%esp
  800311:	68 58 1e 80 00       	push   $0x801e58
  800316:	e8 eb 02 00 00       	call   800606 <cprintf>
  80031b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80031e:	e8 b3 13 00 00       	call   8016d6 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800323:	e8 19 00 00 00       	call   800341 <exit>
}
  800328:	90                   	nop
  800329:	c9                   	leave  
  80032a:	c3                   	ret    

0080032b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80032b:	55                   	push   %ebp
  80032c:	89 e5                	mov    %esp,%ebp
  80032e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800331:	83 ec 0c             	sub    $0xc,%esp
  800334:	6a 00                	push   $0x0
  800336:	e8 b2 11 00 00       	call   8014ed <sys_env_destroy>
  80033b:	83 c4 10             	add    $0x10,%esp
}
  80033e:	90                   	nop
  80033f:	c9                   	leave  
  800340:	c3                   	ret    

00800341 <exit>:

void
exit(void)
{
  800341:	55                   	push   %ebp
  800342:	89 e5                	mov    %esp,%ebp
  800344:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800347:	e8 07 12 00 00       	call   801553 <sys_env_exit>
}
  80034c:	90                   	nop
  80034d:	c9                   	leave  
  80034e:	c3                   	ret    

0080034f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80034f:	55                   	push   %ebp
  800350:	89 e5                	mov    %esp,%ebp
  800352:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800355:	8d 45 10             	lea    0x10(%ebp),%eax
  800358:	83 c0 04             	add    $0x4,%eax
  80035b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80035e:	a1 18 31 80 00       	mov    0x803118,%eax
  800363:	85 c0                	test   %eax,%eax
  800365:	74 16                	je     80037d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800367:	a1 18 31 80 00       	mov    0x803118,%eax
  80036c:	83 ec 08             	sub    $0x8,%esp
  80036f:	50                   	push   %eax
  800370:	68 00 1f 80 00       	push   $0x801f00
  800375:	e8 8c 02 00 00       	call   800606 <cprintf>
  80037a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80037d:	a1 00 30 80 00       	mov    0x803000,%eax
  800382:	ff 75 0c             	pushl  0xc(%ebp)
  800385:	ff 75 08             	pushl  0x8(%ebp)
  800388:	50                   	push   %eax
  800389:	68 05 1f 80 00       	push   $0x801f05
  80038e:	e8 73 02 00 00       	call   800606 <cprintf>
  800393:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800396:	8b 45 10             	mov    0x10(%ebp),%eax
  800399:	83 ec 08             	sub    $0x8,%esp
  80039c:	ff 75 f4             	pushl  -0xc(%ebp)
  80039f:	50                   	push   %eax
  8003a0:	e8 f6 01 00 00       	call   80059b <vcprintf>
  8003a5:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8003a8:	83 ec 08             	sub    $0x8,%esp
  8003ab:	6a 00                	push   $0x0
  8003ad:	68 21 1f 80 00       	push   $0x801f21
  8003b2:	e8 e4 01 00 00       	call   80059b <vcprintf>
  8003b7:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8003ba:	e8 82 ff ff ff       	call   800341 <exit>

	// should not return here
	while (1) ;
  8003bf:	eb fe                	jmp    8003bf <_panic+0x70>

008003c1 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8003c1:	55                   	push   %ebp
  8003c2:	89 e5                	mov    %esp,%ebp
  8003c4:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8003c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003cc:	8b 50 74             	mov    0x74(%eax),%edx
  8003cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003d2:	39 c2                	cmp    %eax,%edx
  8003d4:	74 14                	je     8003ea <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8003d6:	83 ec 04             	sub    $0x4,%esp
  8003d9:	68 24 1f 80 00       	push   $0x801f24
  8003de:	6a 26                	push   $0x26
  8003e0:	68 70 1f 80 00       	push   $0x801f70
  8003e5:	e8 65 ff ff ff       	call   80034f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003f1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003f8:	e9 c4 00 00 00       	jmp    8004c1 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8003fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800400:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800407:	8b 45 08             	mov    0x8(%ebp),%eax
  80040a:	01 d0                	add    %edx,%eax
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	85 c0                	test   %eax,%eax
  800410:	75 08                	jne    80041a <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800412:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800415:	e9 a4 00 00 00       	jmp    8004be <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  80041a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800421:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800428:	eb 6b                	jmp    800495 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80042a:	a1 20 30 80 00       	mov    0x803020,%eax
  80042f:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800435:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800438:	89 d0                	mov    %edx,%eax
  80043a:	c1 e0 02             	shl    $0x2,%eax
  80043d:	01 d0                	add    %edx,%eax
  80043f:	c1 e0 02             	shl    $0x2,%eax
  800442:	01 c8                	add    %ecx,%eax
  800444:	8a 40 04             	mov    0x4(%eax),%al
  800447:	84 c0                	test   %al,%al
  800449:	75 47                	jne    800492 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80044b:	a1 20 30 80 00       	mov    0x803020,%eax
  800450:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800456:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800459:	89 d0                	mov    %edx,%eax
  80045b:	c1 e0 02             	shl    $0x2,%eax
  80045e:	01 d0                	add    %edx,%eax
  800460:	c1 e0 02             	shl    $0x2,%eax
  800463:	01 c8                	add    %ecx,%eax
  800465:	8b 00                	mov    (%eax),%eax
  800467:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80046a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80046d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800472:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800474:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800477:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80047e:	8b 45 08             	mov    0x8(%ebp),%eax
  800481:	01 c8                	add    %ecx,%eax
  800483:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800485:	39 c2                	cmp    %eax,%edx
  800487:	75 09                	jne    800492 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800489:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800490:	eb 12                	jmp    8004a4 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800492:	ff 45 e8             	incl   -0x18(%ebp)
  800495:	a1 20 30 80 00       	mov    0x803020,%eax
  80049a:	8b 50 74             	mov    0x74(%eax),%edx
  80049d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8004a0:	39 c2                	cmp    %eax,%edx
  8004a2:	77 86                	ja     80042a <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8004a4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8004a8:	75 14                	jne    8004be <CheckWSWithoutLastIndex+0xfd>
			panic(
  8004aa:	83 ec 04             	sub    $0x4,%esp
  8004ad:	68 7c 1f 80 00       	push   $0x801f7c
  8004b2:	6a 3a                	push   $0x3a
  8004b4:	68 70 1f 80 00       	push   $0x801f70
  8004b9:	e8 91 fe ff ff       	call   80034f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8004be:	ff 45 f0             	incl   -0x10(%ebp)
  8004c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004c4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004c7:	0f 8c 30 ff ff ff    	jl     8003fd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8004cd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004d4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004db:	eb 27                	jmp    800504 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8004dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8004e2:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8004e8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004eb:	89 d0                	mov    %edx,%eax
  8004ed:	c1 e0 02             	shl    $0x2,%eax
  8004f0:	01 d0                	add    %edx,%eax
  8004f2:	c1 e0 02             	shl    $0x2,%eax
  8004f5:	01 c8                	add    %ecx,%eax
  8004f7:	8a 40 04             	mov    0x4(%eax),%al
  8004fa:	3c 01                	cmp    $0x1,%al
  8004fc:	75 03                	jne    800501 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8004fe:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800501:	ff 45 e0             	incl   -0x20(%ebp)
  800504:	a1 20 30 80 00       	mov    0x803020,%eax
  800509:	8b 50 74             	mov    0x74(%eax),%edx
  80050c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80050f:	39 c2                	cmp    %eax,%edx
  800511:	77 ca                	ja     8004dd <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800513:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800516:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800519:	74 14                	je     80052f <CheckWSWithoutLastIndex+0x16e>
		panic(
  80051b:	83 ec 04             	sub    $0x4,%esp
  80051e:	68 d0 1f 80 00       	push   $0x801fd0
  800523:	6a 44                	push   $0x44
  800525:	68 70 1f 80 00       	push   $0x801f70
  80052a:	e8 20 fe ff ff       	call   80034f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80052f:	90                   	nop
  800530:	c9                   	leave  
  800531:	c3                   	ret    

00800532 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800532:	55                   	push   %ebp
  800533:	89 e5                	mov    %esp,%ebp
  800535:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800538:	8b 45 0c             	mov    0xc(%ebp),%eax
  80053b:	8b 00                	mov    (%eax),%eax
  80053d:	8d 48 01             	lea    0x1(%eax),%ecx
  800540:	8b 55 0c             	mov    0xc(%ebp),%edx
  800543:	89 0a                	mov    %ecx,(%edx)
  800545:	8b 55 08             	mov    0x8(%ebp),%edx
  800548:	88 d1                	mov    %dl,%cl
  80054a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80054d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800551:	8b 45 0c             	mov    0xc(%ebp),%eax
  800554:	8b 00                	mov    (%eax),%eax
  800556:	3d ff 00 00 00       	cmp    $0xff,%eax
  80055b:	75 2c                	jne    800589 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80055d:	a0 24 30 80 00       	mov    0x803024,%al
  800562:	0f b6 c0             	movzbl %al,%eax
  800565:	8b 55 0c             	mov    0xc(%ebp),%edx
  800568:	8b 12                	mov    (%edx),%edx
  80056a:	89 d1                	mov    %edx,%ecx
  80056c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80056f:	83 c2 08             	add    $0x8,%edx
  800572:	83 ec 04             	sub    $0x4,%esp
  800575:	50                   	push   %eax
  800576:	51                   	push   %ecx
  800577:	52                   	push   %edx
  800578:	e8 2e 0f 00 00       	call   8014ab <sys_cputs>
  80057d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800580:	8b 45 0c             	mov    0xc(%ebp),%eax
  800583:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800589:	8b 45 0c             	mov    0xc(%ebp),%eax
  80058c:	8b 40 04             	mov    0x4(%eax),%eax
  80058f:	8d 50 01             	lea    0x1(%eax),%edx
  800592:	8b 45 0c             	mov    0xc(%ebp),%eax
  800595:	89 50 04             	mov    %edx,0x4(%eax)
}
  800598:	90                   	nop
  800599:	c9                   	leave  
  80059a:	c3                   	ret    

0080059b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80059b:	55                   	push   %ebp
  80059c:	89 e5                	mov    %esp,%ebp
  80059e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8005a4:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8005ab:	00 00 00 
	b.cnt = 0;
  8005ae:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8005b5:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8005b8:	ff 75 0c             	pushl  0xc(%ebp)
  8005bb:	ff 75 08             	pushl  0x8(%ebp)
  8005be:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005c4:	50                   	push   %eax
  8005c5:	68 32 05 80 00       	push   $0x800532
  8005ca:	e8 11 02 00 00       	call   8007e0 <vprintfmt>
  8005cf:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005d2:	a0 24 30 80 00       	mov    0x803024,%al
  8005d7:	0f b6 c0             	movzbl %al,%eax
  8005da:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005e0:	83 ec 04             	sub    $0x4,%esp
  8005e3:	50                   	push   %eax
  8005e4:	52                   	push   %edx
  8005e5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005eb:	83 c0 08             	add    $0x8,%eax
  8005ee:	50                   	push   %eax
  8005ef:	e8 b7 0e 00 00       	call   8014ab <sys_cputs>
  8005f4:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005f7:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005fe:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800604:	c9                   	leave  
  800605:	c3                   	ret    

00800606 <cprintf>:

int cprintf(const char *fmt, ...) {
  800606:	55                   	push   %ebp
  800607:	89 e5                	mov    %esp,%ebp
  800609:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80060c:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800613:	8d 45 0c             	lea    0xc(%ebp),%eax
  800616:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800619:	8b 45 08             	mov    0x8(%ebp),%eax
  80061c:	83 ec 08             	sub    $0x8,%esp
  80061f:	ff 75 f4             	pushl  -0xc(%ebp)
  800622:	50                   	push   %eax
  800623:	e8 73 ff ff ff       	call   80059b <vcprintf>
  800628:	83 c4 10             	add    $0x10,%esp
  80062b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80062e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800631:	c9                   	leave  
  800632:	c3                   	ret    

00800633 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800633:	55                   	push   %ebp
  800634:	89 e5                	mov    %esp,%ebp
  800636:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800639:	e8 7e 10 00 00       	call   8016bc <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80063e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800641:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800644:	8b 45 08             	mov    0x8(%ebp),%eax
  800647:	83 ec 08             	sub    $0x8,%esp
  80064a:	ff 75 f4             	pushl  -0xc(%ebp)
  80064d:	50                   	push   %eax
  80064e:	e8 48 ff ff ff       	call   80059b <vcprintf>
  800653:	83 c4 10             	add    $0x10,%esp
  800656:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800659:	e8 78 10 00 00       	call   8016d6 <sys_enable_interrupt>
	return cnt;
  80065e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800661:	c9                   	leave  
  800662:	c3                   	ret    

00800663 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800663:	55                   	push   %ebp
  800664:	89 e5                	mov    %esp,%ebp
  800666:	53                   	push   %ebx
  800667:	83 ec 14             	sub    $0x14,%esp
  80066a:	8b 45 10             	mov    0x10(%ebp),%eax
  80066d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800670:	8b 45 14             	mov    0x14(%ebp),%eax
  800673:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800676:	8b 45 18             	mov    0x18(%ebp),%eax
  800679:	ba 00 00 00 00       	mov    $0x0,%edx
  80067e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800681:	77 55                	ja     8006d8 <printnum+0x75>
  800683:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800686:	72 05                	jb     80068d <printnum+0x2a>
  800688:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80068b:	77 4b                	ja     8006d8 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80068d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800690:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800693:	8b 45 18             	mov    0x18(%ebp),%eax
  800696:	ba 00 00 00 00       	mov    $0x0,%edx
  80069b:	52                   	push   %edx
  80069c:	50                   	push   %eax
  80069d:	ff 75 f4             	pushl  -0xc(%ebp)
  8006a0:	ff 75 f0             	pushl  -0x10(%ebp)
  8006a3:	e8 54 14 00 00       	call   801afc <__udivdi3>
  8006a8:	83 c4 10             	add    $0x10,%esp
  8006ab:	83 ec 04             	sub    $0x4,%esp
  8006ae:	ff 75 20             	pushl  0x20(%ebp)
  8006b1:	53                   	push   %ebx
  8006b2:	ff 75 18             	pushl  0x18(%ebp)
  8006b5:	52                   	push   %edx
  8006b6:	50                   	push   %eax
  8006b7:	ff 75 0c             	pushl  0xc(%ebp)
  8006ba:	ff 75 08             	pushl  0x8(%ebp)
  8006bd:	e8 a1 ff ff ff       	call   800663 <printnum>
  8006c2:	83 c4 20             	add    $0x20,%esp
  8006c5:	eb 1a                	jmp    8006e1 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006c7:	83 ec 08             	sub    $0x8,%esp
  8006ca:	ff 75 0c             	pushl  0xc(%ebp)
  8006cd:	ff 75 20             	pushl  0x20(%ebp)
  8006d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d3:	ff d0                	call   *%eax
  8006d5:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006d8:	ff 4d 1c             	decl   0x1c(%ebp)
  8006db:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006df:	7f e6                	jg     8006c7 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006e1:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006e4:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ef:	53                   	push   %ebx
  8006f0:	51                   	push   %ecx
  8006f1:	52                   	push   %edx
  8006f2:	50                   	push   %eax
  8006f3:	e8 14 15 00 00       	call   801c0c <__umoddi3>
  8006f8:	83 c4 10             	add    $0x10,%esp
  8006fb:	05 34 22 80 00       	add    $0x802234,%eax
  800700:	8a 00                	mov    (%eax),%al
  800702:	0f be c0             	movsbl %al,%eax
  800705:	83 ec 08             	sub    $0x8,%esp
  800708:	ff 75 0c             	pushl  0xc(%ebp)
  80070b:	50                   	push   %eax
  80070c:	8b 45 08             	mov    0x8(%ebp),%eax
  80070f:	ff d0                	call   *%eax
  800711:	83 c4 10             	add    $0x10,%esp
}
  800714:	90                   	nop
  800715:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800718:	c9                   	leave  
  800719:	c3                   	ret    

0080071a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80071a:	55                   	push   %ebp
  80071b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80071d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800721:	7e 1c                	jle    80073f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800723:	8b 45 08             	mov    0x8(%ebp),%eax
  800726:	8b 00                	mov    (%eax),%eax
  800728:	8d 50 08             	lea    0x8(%eax),%edx
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	89 10                	mov    %edx,(%eax)
  800730:	8b 45 08             	mov    0x8(%ebp),%eax
  800733:	8b 00                	mov    (%eax),%eax
  800735:	83 e8 08             	sub    $0x8,%eax
  800738:	8b 50 04             	mov    0x4(%eax),%edx
  80073b:	8b 00                	mov    (%eax),%eax
  80073d:	eb 40                	jmp    80077f <getuint+0x65>
	else if (lflag)
  80073f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800743:	74 1e                	je     800763 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800745:	8b 45 08             	mov    0x8(%ebp),%eax
  800748:	8b 00                	mov    (%eax),%eax
  80074a:	8d 50 04             	lea    0x4(%eax),%edx
  80074d:	8b 45 08             	mov    0x8(%ebp),%eax
  800750:	89 10                	mov    %edx,(%eax)
  800752:	8b 45 08             	mov    0x8(%ebp),%eax
  800755:	8b 00                	mov    (%eax),%eax
  800757:	83 e8 04             	sub    $0x4,%eax
  80075a:	8b 00                	mov    (%eax),%eax
  80075c:	ba 00 00 00 00       	mov    $0x0,%edx
  800761:	eb 1c                	jmp    80077f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800763:	8b 45 08             	mov    0x8(%ebp),%eax
  800766:	8b 00                	mov    (%eax),%eax
  800768:	8d 50 04             	lea    0x4(%eax),%edx
  80076b:	8b 45 08             	mov    0x8(%ebp),%eax
  80076e:	89 10                	mov    %edx,(%eax)
  800770:	8b 45 08             	mov    0x8(%ebp),%eax
  800773:	8b 00                	mov    (%eax),%eax
  800775:	83 e8 04             	sub    $0x4,%eax
  800778:	8b 00                	mov    (%eax),%eax
  80077a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80077f:	5d                   	pop    %ebp
  800780:	c3                   	ret    

00800781 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800781:	55                   	push   %ebp
  800782:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800784:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800788:	7e 1c                	jle    8007a6 <getint+0x25>
		return va_arg(*ap, long long);
  80078a:	8b 45 08             	mov    0x8(%ebp),%eax
  80078d:	8b 00                	mov    (%eax),%eax
  80078f:	8d 50 08             	lea    0x8(%eax),%edx
  800792:	8b 45 08             	mov    0x8(%ebp),%eax
  800795:	89 10                	mov    %edx,(%eax)
  800797:	8b 45 08             	mov    0x8(%ebp),%eax
  80079a:	8b 00                	mov    (%eax),%eax
  80079c:	83 e8 08             	sub    $0x8,%eax
  80079f:	8b 50 04             	mov    0x4(%eax),%edx
  8007a2:	8b 00                	mov    (%eax),%eax
  8007a4:	eb 38                	jmp    8007de <getint+0x5d>
	else if (lflag)
  8007a6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007aa:	74 1a                	je     8007c6 <getint+0x45>
		return va_arg(*ap, long);
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	8b 00                	mov    (%eax),%eax
  8007b1:	8d 50 04             	lea    0x4(%eax),%edx
  8007b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b7:	89 10                	mov    %edx,(%eax)
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	8b 00                	mov    (%eax),%eax
  8007be:	83 e8 04             	sub    $0x4,%eax
  8007c1:	8b 00                	mov    (%eax),%eax
  8007c3:	99                   	cltd   
  8007c4:	eb 18                	jmp    8007de <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c9:	8b 00                	mov    (%eax),%eax
  8007cb:	8d 50 04             	lea    0x4(%eax),%edx
  8007ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d1:	89 10                	mov    %edx,(%eax)
  8007d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d6:	8b 00                	mov    (%eax),%eax
  8007d8:	83 e8 04             	sub    $0x4,%eax
  8007db:	8b 00                	mov    (%eax),%eax
  8007dd:	99                   	cltd   
}
  8007de:	5d                   	pop    %ebp
  8007df:	c3                   	ret    

008007e0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007e0:	55                   	push   %ebp
  8007e1:	89 e5                	mov    %esp,%ebp
  8007e3:	56                   	push   %esi
  8007e4:	53                   	push   %ebx
  8007e5:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007e8:	eb 17                	jmp    800801 <vprintfmt+0x21>
			if (ch == '\0')
  8007ea:	85 db                	test   %ebx,%ebx
  8007ec:	0f 84 af 03 00 00    	je     800ba1 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007f2:	83 ec 08             	sub    $0x8,%esp
  8007f5:	ff 75 0c             	pushl  0xc(%ebp)
  8007f8:	53                   	push   %ebx
  8007f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fc:	ff d0                	call   *%eax
  8007fe:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800801:	8b 45 10             	mov    0x10(%ebp),%eax
  800804:	8d 50 01             	lea    0x1(%eax),%edx
  800807:	89 55 10             	mov    %edx,0x10(%ebp)
  80080a:	8a 00                	mov    (%eax),%al
  80080c:	0f b6 d8             	movzbl %al,%ebx
  80080f:	83 fb 25             	cmp    $0x25,%ebx
  800812:	75 d6                	jne    8007ea <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800814:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800818:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80081f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800826:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80082d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800834:	8b 45 10             	mov    0x10(%ebp),%eax
  800837:	8d 50 01             	lea    0x1(%eax),%edx
  80083a:	89 55 10             	mov    %edx,0x10(%ebp)
  80083d:	8a 00                	mov    (%eax),%al
  80083f:	0f b6 d8             	movzbl %al,%ebx
  800842:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800845:	83 f8 55             	cmp    $0x55,%eax
  800848:	0f 87 2b 03 00 00    	ja     800b79 <vprintfmt+0x399>
  80084e:	8b 04 85 58 22 80 00 	mov    0x802258(,%eax,4),%eax
  800855:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800857:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80085b:	eb d7                	jmp    800834 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80085d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800861:	eb d1                	jmp    800834 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800863:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80086a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80086d:	89 d0                	mov    %edx,%eax
  80086f:	c1 e0 02             	shl    $0x2,%eax
  800872:	01 d0                	add    %edx,%eax
  800874:	01 c0                	add    %eax,%eax
  800876:	01 d8                	add    %ebx,%eax
  800878:	83 e8 30             	sub    $0x30,%eax
  80087b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80087e:	8b 45 10             	mov    0x10(%ebp),%eax
  800881:	8a 00                	mov    (%eax),%al
  800883:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800886:	83 fb 2f             	cmp    $0x2f,%ebx
  800889:	7e 3e                	jle    8008c9 <vprintfmt+0xe9>
  80088b:	83 fb 39             	cmp    $0x39,%ebx
  80088e:	7f 39                	jg     8008c9 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800890:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800893:	eb d5                	jmp    80086a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800895:	8b 45 14             	mov    0x14(%ebp),%eax
  800898:	83 c0 04             	add    $0x4,%eax
  80089b:	89 45 14             	mov    %eax,0x14(%ebp)
  80089e:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a1:	83 e8 04             	sub    $0x4,%eax
  8008a4:	8b 00                	mov    (%eax),%eax
  8008a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008a9:	eb 1f                	jmp    8008ca <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008ab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008af:	79 83                	jns    800834 <vprintfmt+0x54>
				width = 0;
  8008b1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008b8:	e9 77 ff ff ff       	jmp    800834 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008bd:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008c4:	e9 6b ff ff ff       	jmp    800834 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008c9:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008ca:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ce:	0f 89 60 ff ff ff    	jns    800834 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008da:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008e1:	e9 4e ff ff ff       	jmp    800834 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008e6:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008e9:	e9 46 ff ff ff       	jmp    800834 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f1:	83 c0 04             	add    $0x4,%eax
  8008f4:	89 45 14             	mov    %eax,0x14(%ebp)
  8008f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8008fa:	83 e8 04             	sub    $0x4,%eax
  8008fd:	8b 00                	mov    (%eax),%eax
  8008ff:	83 ec 08             	sub    $0x8,%esp
  800902:	ff 75 0c             	pushl  0xc(%ebp)
  800905:	50                   	push   %eax
  800906:	8b 45 08             	mov    0x8(%ebp),%eax
  800909:	ff d0                	call   *%eax
  80090b:	83 c4 10             	add    $0x10,%esp
			break;
  80090e:	e9 89 02 00 00       	jmp    800b9c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800913:	8b 45 14             	mov    0x14(%ebp),%eax
  800916:	83 c0 04             	add    $0x4,%eax
  800919:	89 45 14             	mov    %eax,0x14(%ebp)
  80091c:	8b 45 14             	mov    0x14(%ebp),%eax
  80091f:	83 e8 04             	sub    $0x4,%eax
  800922:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800924:	85 db                	test   %ebx,%ebx
  800926:	79 02                	jns    80092a <vprintfmt+0x14a>
				err = -err;
  800928:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80092a:	83 fb 64             	cmp    $0x64,%ebx
  80092d:	7f 0b                	jg     80093a <vprintfmt+0x15a>
  80092f:	8b 34 9d a0 20 80 00 	mov    0x8020a0(,%ebx,4),%esi
  800936:	85 f6                	test   %esi,%esi
  800938:	75 19                	jne    800953 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80093a:	53                   	push   %ebx
  80093b:	68 45 22 80 00       	push   $0x802245
  800940:	ff 75 0c             	pushl  0xc(%ebp)
  800943:	ff 75 08             	pushl  0x8(%ebp)
  800946:	e8 5e 02 00 00       	call   800ba9 <printfmt>
  80094b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80094e:	e9 49 02 00 00       	jmp    800b9c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800953:	56                   	push   %esi
  800954:	68 4e 22 80 00       	push   $0x80224e
  800959:	ff 75 0c             	pushl  0xc(%ebp)
  80095c:	ff 75 08             	pushl  0x8(%ebp)
  80095f:	e8 45 02 00 00       	call   800ba9 <printfmt>
  800964:	83 c4 10             	add    $0x10,%esp
			break;
  800967:	e9 30 02 00 00       	jmp    800b9c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80096c:	8b 45 14             	mov    0x14(%ebp),%eax
  80096f:	83 c0 04             	add    $0x4,%eax
  800972:	89 45 14             	mov    %eax,0x14(%ebp)
  800975:	8b 45 14             	mov    0x14(%ebp),%eax
  800978:	83 e8 04             	sub    $0x4,%eax
  80097b:	8b 30                	mov    (%eax),%esi
  80097d:	85 f6                	test   %esi,%esi
  80097f:	75 05                	jne    800986 <vprintfmt+0x1a6>
				p = "(null)";
  800981:	be 51 22 80 00       	mov    $0x802251,%esi
			if (width > 0 && padc != '-')
  800986:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80098a:	7e 6d                	jle    8009f9 <vprintfmt+0x219>
  80098c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800990:	74 67                	je     8009f9 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800992:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800995:	83 ec 08             	sub    $0x8,%esp
  800998:	50                   	push   %eax
  800999:	56                   	push   %esi
  80099a:	e8 0c 03 00 00       	call   800cab <strnlen>
  80099f:	83 c4 10             	add    $0x10,%esp
  8009a2:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009a5:	eb 16                	jmp    8009bd <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009a7:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009ab:	83 ec 08             	sub    $0x8,%esp
  8009ae:	ff 75 0c             	pushl  0xc(%ebp)
  8009b1:	50                   	push   %eax
  8009b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b5:	ff d0                	call   *%eax
  8009b7:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009ba:	ff 4d e4             	decl   -0x1c(%ebp)
  8009bd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009c1:	7f e4                	jg     8009a7 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009c3:	eb 34                	jmp    8009f9 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009c5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009c9:	74 1c                	je     8009e7 <vprintfmt+0x207>
  8009cb:	83 fb 1f             	cmp    $0x1f,%ebx
  8009ce:	7e 05                	jle    8009d5 <vprintfmt+0x1f5>
  8009d0:	83 fb 7e             	cmp    $0x7e,%ebx
  8009d3:	7e 12                	jle    8009e7 <vprintfmt+0x207>
					putch('?', putdat);
  8009d5:	83 ec 08             	sub    $0x8,%esp
  8009d8:	ff 75 0c             	pushl  0xc(%ebp)
  8009db:	6a 3f                	push   $0x3f
  8009dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e0:	ff d0                	call   *%eax
  8009e2:	83 c4 10             	add    $0x10,%esp
  8009e5:	eb 0f                	jmp    8009f6 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009e7:	83 ec 08             	sub    $0x8,%esp
  8009ea:	ff 75 0c             	pushl  0xc(%ebp)
  8009ed:	53                   	push   %ebx
  8009ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f1:	ff d0                	call   *%eax
  8009f3:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009f6:	ff 4d e4             	decl   -0x1c(%ebp)
  8009f9:	89 f0                	mov    %esi,%eax
  8009fb:	8d 70 01             	lea    0x1(%eax),%esi
  8009fe:	8a 00                	mov    (%eax),%al
  800a00:	0f be d8             	movsbl %al,%ebx
  800a03:	85 db                	test   %ebx,%ebx
  800a05:	74 24                	je     800a2b <vprintfmt+0x24b>
  800a07:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a0b:	78 b8                	js     8009c5 <vprintfmt+0x1e5>
  800a0d:	ff 4d e0             	decl   -0x20(%ebp)
  800a10:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a14:	79 af                	jns    8009c5 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a16:	eb 13                	jmp    800a2b <vprintfmt+0x24b>
				putch(' ', putdat);
  800a18:	83 ec 08             	sub    $0x8,%esp
  800a1b:	ff 75 0c             	pushl  0xc(%ebp)
  800a1e:	6a 20                	push   $0x20
  800a20:	8b 45 08             	mov    0x8(%ebp),%eax
  800a23:	ff d0                	call   *%eax
  800a25:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a28:	ff 4d e4             	decl   -0x1c(%ebp)
  800a2b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a2f:	7f e7                	jg     800a18 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a31:	e9 66 01 00 00       	jmp    800b9c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a36:	83 ec 08             	sub    $0x8,%esp
  800a39:	ff 75 e8             	pushl  -0x18(%ebp)
  800a3c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a3f:	50                   	push   %eax
  800a40:	e8 3c fd ff ff       	call   800781 <getint>
  800a45:	83 c4 10             	add    $0x10,%esp
  800a48:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a4b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a51:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a54:	85 d2                	test   %edx,%edx
  800a56:	79 23                	jns    800a7b <vprintfmt+0x29b>
				putch('-', putdat);
  800a58:	83 ec 08             	sub    $0x8,%esp
  800a5b:	ff 75 0c             	pushl  0xc(%ebp)
  800a5e:	6a 2d                	push   $0x2d
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	ff d0                	call   *%eax
  800a65:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a6b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a6e:	f7 d8                	neg    %eax
  800a70:	83 d2 00             	adc    $0x0,%edx
  800a73:	f7 da                	neg    %edx
  800a75:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a78:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a7b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a82:	e9 bc 00 00 00       	jmp    800b43 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a87:	83 ec 08             	sub    $0x8,%esp
  800a8a:	ff 75 e8             	pushl  -0x18(%ebp)
  800a8d:	8d 45 14             	lea    0x14(%ebp),%eax
  800a90:	50                   	push   %eax
  800a91:	e8 84 fc ff ff       	call   80071a <getuint>
  800a96:	83 c4 10             	add    $0x10,%esp
  800a99:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a9c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a9f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800aa6:	e9 98 00 00 00       	jmp    800b43 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800aab:	83 ec 08             	sub    $0x8,%esp
  800aae:	ff 75 0c             	pushl  0xc(%ebp)
  800ab1:	6a 58                	push   $0x58
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	ff d0                	call   *%eax
  800ab8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800abb:	83 ec 08             	sub    $0x8,%esp
  800abe:	ff 75 0c             	pushl  0xc(%ebp)
  800ac1:	6a 58                	push   $0x58
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	ff d0                	call   *%eax
  800ac8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800acb:	83 ec 08             	sub    $0x8,%esp
  800ace:	ff 75 0c             	pushl  0xc(%ebp)
  800ad1:	6a 58                	push   $0x58
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	ff d0                	call   *%eax
  800ad8:	83 c4 10             	add    $0x10,%esp
			break;
  800adb:	e9 bc 00 00 00       	jmp    800b9c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ae0:	83 ec 08             	sub    $0x8,%esp
  800ae3:	ff 75 0c             	pushl  0xc(%ebp)
  800ae6:	6a 30                	push   $0x30
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	ff d0                	call   *%eax
  800aed:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800af0:	83 ec 08             	sub    $0x8,%esp
  800af3:	ff 75 0c             	pushl  0xc(%ebp)
  800af6:	6a 78                	push   $0x78
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	ff d0                	call   *%eax
  800afd:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b00:	8b 45 14             	mov    0x14(%ebp),%eax
  800b03:	83 c0 04             	add    $0x4,%eax
  800b06:	89 45 14             	mov    %eax,0x14(%ebp)
  800b09:	8b 45 14             	mov    0x14(%ebp),%eax
  800b0c:	83 e8 04             	sub    $0x4,%eax
  800b0f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b11:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b14:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b1b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b22:	eb 1f                	jmp    800b43 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b24:	83 ec 08             	sub    $0x8,%esp
  800b27:	ff 75 e8             	pushl  -0x18(%ebp)
  800b2a:	8d 45 14             	lea    0x14(%ebp),%eax
  800b2d:	50                   	push   %eax
  800b2e:	e8 e7 fb ff ff       	call   80071a <getuint>
  800b33:	83 c4 10             	add    $0x10,%esp
  800b36:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b39:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b3c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b43:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b47:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b4a:	83 ec 04             	sub    $0x4,%esp
  800b4d:	52                   	push   %edx
  800b4e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b51:	50                   	push   %eax
  800b52:	ff 75 f4             	pushl  -0xc(%ebp)
  800b55:	ff 75 f0             	pushl  -0x10(%ebp)
  800b58:	ff 75 0c             	pushl  0xc(%ebp)
  800b5b:	ff 75 08             	pushl  0x8(%ebp)
  800b5e:	e8 00 fb ff ff       	call   800663 <printnum>
  800b63:	83 c4 20             	add    $0x20,%esp
			break;
  800b66:	eb 34                	jmp    800b9c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b68:	83 ec 08             	sub    $0x8,%esp
  800b6b:	ff 75 0c             	pushl  0xc(%ebp)
  800b6e:	53                   	push   %ebx
  800b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b72:	ff d0                	call   *%eax
  800b74:	83 c4 10             	add    $0x10,%esp
			break;
  800b77:	eb 23                	jmp    800b9c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b79:	83 ec 08             	sub    $0x8,%esp
  800b7c:	ff 75 0c             	pushl  0xc(%ebp)
  800b7f:	6a 25                	push   $0x25
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	ff d0                	call   *%eax
  800b86:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b89:	ff 4d 10             	decl   0x10(%ebp)
  800b8c:	eb 03                	jmp    800b91 <vprintfmt+0x3b1>
  800b8e:	ff 4d 10             	decl   0x10(%ebp)
  800b91:	8b 45 10             	mov    0x10(%ebp),%eax
  800b94:	48                   	dec    %eax
  800b95:	8a 00                	mov    (%eax),%al
  800b97:	3c 25                	cmp    $0x25,%al
  800b99:	75 f3                	jne    800b8e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b9b:	90                   	nop
		}
	}
  800b9c:	e9 47 fc ff ff       	jmp    8007e8 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ba1:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ba2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ba5:	5b                   	pop    %ebx
  800ba6:	5e                   	pop    %esi
  800ba7:	5d                   	pop    %ebp
  800ba8:	c3                   	ret    

00800ba9 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ba9:	55                   	push   %ebp
  800baa:	89 e5                	mov    %esp,%ebp
  800bac:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800baf:	8d 45 10             	lea    0x10(%ebp),%eax
  800bb2:	83 c0 04             	add    $0x4,%eax
  800bb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800bb8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbb:	ff 75 f4             	pushl  -0xc(%ebp)
  800bbe:	50                   	push   %eax
  800bbf:	ff 75 0c             	pushl  0xc(%ebp)
  800bc2:	ff 75 08             	pushl  0x8(%ebp)
  800bc5:	e8 16 fc ff ff       	call   8007e0 <vprintfmt>
  800bca:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bcd:	90                   	nop
  800bce:	c9                   	leave  
  800bcf:	c3                   	ret    

00800bd0 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bd0:	55                   	push   %ebp
  800bd1:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd6:	8b 40 08             	mov    0x8(%eax),%eax
  800bd9:	8d 50 01             	lea    0x1(%eax),%edx
  800bdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdf:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800be2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be5:	8b 10                	mov    (%eax),%edx
  800be7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bea:	8b 40 04             	mov    0x4(%eax),%eax
  800bed:	39 c2                	cmp    %eax,%edx
  800bef:	73 12                	jae    800c03 <sprintputch+0x33>
		*b->buf++ = ch;
  800bf1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf4:	8b 00                	mov    (%eax),%eax
  800bf6:	8d 48 01             	lea    0x1(%eax),%ecx
  800bf9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bfc:	89 0a                	mov    %ecx,(%edx)
  800bfe:	8b 55 08             	mov    0x8(%ebp),%edx
  800c01:	88 10                	mov    %dl,(%eax)
}
  800c03:	90                   	nop
  800c04:	5d                   	pop    %ebp
  800c05:	c3                   	ret    

00800c06 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c06:	55                   	push   %ebp
  800c07:	89 e5                	mov    %esp,%ebp
  800c09:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c15:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1b:	01 d0                	add    %edx,%eax
  800c1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c20:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c27:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c2b:	74 06                	je     800c33 <vsnprintf+0x2d>
  800c2d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c31:	7f 07                	jg     800c3a <vsnprintf+0x34>
		return -E_INVAL;
  800c33:	b8 03 00 00 00       	mov    $0x3,%eax
  800c38:	eb 20                	jmp    800c5a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c3a:	ff 75 14             	pushl  0x14(%ebp)
  800c3d:	ff 75 10             	pushl  0x10(%ebp)
  800c40:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c43:	50                   	push   %eax
  800c44:	68 d0 0b 80 00       	push   $0x800bd0
  800c49:	e8 92 fb ff ff       	call   8007e0 <vprintfmt>
  800c4e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c51:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c54:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c5a:	c9                   	leave  
  800c5b:	c3                   	ret    

00800c5c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c5c:	55                   	push   %ebp
  800c5d:	89 e5                	mov    %esp,%ebp
  800c5f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c62:	8d 45 10             	lea    0x10(%ebp),%eax
  800c65:	83 c0 04             	add    $0x4,%eax
  800c68:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c6e:	ff 75 f4             	pushl  -0xc(%ebp)
  800c71:	50                   	push   %eax
  800c72:	ff 75 0c             	pushl  0xc(%ebp)
  800c75:	ff 75 08             	pushl  0x8(%ebp)
  800c78:	e8 89 ff ff ff       	call   800c06 <vsnprintf>
  800c7d:	83 c4 10             	add    $0x10,%esp
  800c80:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c83:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c86:	c9                   	leave  
  800c87:	c3                   	ret    

00800c88 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c88:	55                   	push   %ebp
  800c89:	89 e5                	mov    %esp,%ebp
  800c8b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c8e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c95:	eb 06                	jmp    800c9d <strlen+0x15>
		n++;
  800c97:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c9a:	ff 45 08             	incl   0x8(%ebp)
  800c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	84 c0                	test   %al,%al
  800ca4:	75 f1                	jne    800c97 <strlen+0xf>
		n++;
	return n;
  800ca6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ca9:	c9                   	leave  
  800caa:	c3                   	ret    

00800cab <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800cab:	55                   	push   %ebp
  800cac:	89 e5                	mov    %esp,%ebp
  800cae:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cb1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cb8:	eb 09                	jmp    800cc3 <strnlen+0x18>
		n++;
  800cba:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cbd:	ff 45 08             	incl   0x8(%ebp)
  800cc0:	ff 4d 0c             	decl   0xc(%ebp)
  800cc3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cc7:	74 09                	je     800cd2 <strnlen+0x27>
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	8a 00                	mov    (%eax),%al
  800cce:	84 c0                	test   %al,%al
  800cd0:	75 e8                	jne    800cba <strnlen+0xf>
		n++;
	return n;
  800cd2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cd5:	c9                   	leave  
  800cd6:	c3                   	ret    

00800cd7 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cd7:	55                   	push   %ebp
  800cd8:	89 e5                	mov    %esp,%ebp
  800cda:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ce3:	90                   	nop
  800ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce7:	8d 50 01             	lea    0x1(%eax),%edx
  800cea:	89 55 08             	mov    %edx,0x8(%ebp)
  800ced:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cf3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cf6:	8a 12                	mov    (%edx),%dl
  800cf8:	88 10                	mov    %dl,(%eax)
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	84 c0                	test   %al,%al
  800cfe:	75 e4                	jne    800ce4 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d00:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d03:	c9                   	leave  
  800d04:	c3                   	ret    

00800d05 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d05:	55                   	push   %ebp
  800d06:	89 e5                	mov    %esp,%ebp
  800d08:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d11:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d18:	eb 1f                	jmp    800d39 <strncpy+0x34>
		*dst++ = *src;
  800d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1d:	8d 50 01             	lea    0x1(%eax),%edx
  800d20:	89 55 08             	mov    %edx,0x8(%ebp)
  800d23:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d26:	8a 12                	mov    (%edx),%dl
  800d28:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2d:	8a 00                	mov    (%eax),%al
  800d2f:	84 c0                	test   %al,%al
  800d31:	74 03                	je     800d36 <strncpy+0x31>
			src++;
  800d33:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d36:	ff 45 fc             	incl   -0x4(%ebp)
  800d39:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d3c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d3f:	72 d9                	jb     800d1a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d41:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d44:	c9                   	leave  
  800d45:	c3                   	ret    

00800d46 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d46:	55                   	push   %ebp
  800d47:	89 e5                	mov    %esp,%ebp
  800d49:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d52:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d56:	74 30                	je     800d88 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d58:	eb 16                	jmp    800d70 <strlcpy+0x2a>
			*dst++ = *src++;
  800d5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5d:	8d 50 01             	lea    0x1(%eax),%edx
  800d60:	89 55 08             	mov    %edx,0x8(%ebp)
  800d63:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d66:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d69:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d6c:	8a 12                	mov    (%edx),%dl
  800d6e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d70:	ff 4d 10             	decl   0x10(%ebp)
  800d73:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d77:	74 09                	je     800d82 <strlcpy+0x3c>
  800d79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7c:	8a 00                	mov    (%eax),%al
  800d7e:	84 c0                	test   %al,%al
  800d80:	75 d8                	jne    800d5a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d82:	8b 45 08             	mov    0x8(%ebp),%eax
  800d85:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d88:	8b 55 08             	mov    0x8(%ebp),%edx
  800d8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d8e:	29 c2                	sub    %eax,%edx
  800d90:	89 d0                	mov    %edx,%eax
}
  800d92:	c9                   	leave  
  800d93:	c3                   	ret    

00800d94 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d94:	55                   	push   %ebp
  800d95:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d97:	eb 06                	jmp    800d9f <strcmp+0xb>
		p++, q++;
  800d99:	ff 45 08             	incl   0x8(%ebp)
  800d9c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800da2:	8a 00                	mov    (%eax),%al
  800da4:	84 c0                	test   %al,%al
  800da6:	74 0e                	je     800db6 <strcmp+0x22>
  800da8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dab:	8a 10                	mov    (%eax),%dl
  800dad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db0:	8a 00                	mov    (%eax),%al
  800db2:	38 c2                	cmp    %al,%dl
  800db4:	74 e3                	je     800d99 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800db6:	8b 45 08             	mov    0x8(%ebp),%eax
  800db9:	8a 00                	mov    (%eax),%al
  800dbb:	0f b6 d0             	movzbl %al,%edx
  800dbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc1:	8a 00                	mov    (%eax),%al
  800dc3:	0f b6 c0             	movzbl %al,%eax
  800dc6:	29 c2                	sub    %eax,%edx
  800dc8:	89 d0                	mov    %edx,%eax
}
  800dca:	5d                   	pop    %ebp
  800dcb:	c3                   	ret    

00800dcc <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800dcc:	55                   	push   %ebp
  800dcd:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800dcf:	eb 09                	jmp    800dda <strncmp+0xe>
		n--, p++, q++;
  800dd1:	ff 4d 10             	decl   0x10(%ebp)
  800dd4:	ff 45 08             	incl   0x8(%ebp)
  800dd7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800dda:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dde:	74 17                	je     800df7 <strncmp+0x2b>
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	8a 00                	mov    (%eax),%al
  800de5:	84 c0                	test   %al,%al
  800de7:	74 0e                	je     800df7 <strncmp+0x2b>
  800de9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dec:	8a 10                	mov    (%eax),%dl
  800dee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df1:	8a 00                	mov    (%eax),%al
  800df3:	38 c2                	cmp    %al,%dl
  800df5:	74 da                	je     800dd1 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800df7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dfb:	75 07                	jne    800e04 <strncmp+0x38>
		return 0;
  800dfd:	b8 00 00 00 00       	mov    $0x0,%eax
  800e02:	eb 14                	jmp    800e18 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e04:	8b 45 08             	mov    0x8(%ebp),%eax
  800e07:	8a 00                	mov    (%eax),%al
  800e09:	0f b6 d0             	movzbl %al,%edx
  800e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0f:	8a 00                	mov    (%eax),%al
  800e11:	0f b6 c0             	movzbl %al,%eax
  800e14:	29 c2                	sub    %eax,%edx
  800e16:	89 d0                	mov    %edx,%eax
}
  800e18:	5d                   	pop    %ebp
  800e19:	c3                   	ret    

00800e1a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e1a:	55                   	push   %ebp
  800e1b:	89 e5                	mov    %esp,%ebp
  800e1d:	83 ec 04             	sub    $0x4,%esp
  800e20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e23:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e26:	eb 12                	jmp    800e3a <strchr+0x20>
		if (*s == c)
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	8a 00                	mov    (%eax),%al
  800e2d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e30:	75 05                	jne    800e37 <strchr+0x1d>
			return (char *) s;
  800e32:	8b 45 08             	mov    0x8(%ebp),%eax
  800e35:	eb 11                	jmp    800e48 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e37:	ff 45 08             	incl   0x8(%ebp)
  800e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3d:	8a 00                	mov    (%eax),%al
  800e3f:	84 c0                	test   %al,%al
  800e41:	75 e5                	jne    800e28 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e43:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e48:	c9                   	leave  
  800e49:	c3                   	ret    

00800e4a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e4a:	55                   	push   %ebp
  800e4b:	89 e5                	mov    %esp,%ebp
  800e4d:	83 ec 04             	sub    $0x4,%esp
  800e50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e53:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e56:	eb 0d                	jmp    800e65 <strfind+0x1b>
		if (*s == c)
  800e58:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5b:	8a 00                	mov    (%eax),%al
  800e5d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e60:	74 0e                	je     800e70 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e62:	ff 45 08             	incl   0x8(%ebp)
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	8a 00                	mov    (%eax),%al
  800e6a:	84 c0                	test   %al,%al
  800e6c:	75 ea                	jne    800e58 <strfind+0xe>
  800e6e:	eb 01                	jmp    800e71 <strfind+0x27>
		if (*s == c)
			break;
  800e70:	90                   	nop
	return (char *) s;
  800e71:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e74:	c9                   	leave  
  800e75:	c3                   	ret    

00800e76 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e76:	55                   	push   %ebp
  800e77:	89 e5                	mov    %esp,%ebp
  800e79:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e82:	8b 45 10             	mov    0x10(%ebp),%eax
  800e85:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e88:	eb 0e                	jmp    800e98 <memset+0x22>
		*p++ = c;
  800e8a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e8d:	8d 50 01             	lea    0x1(%eax),%edx
  800e90:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e93:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e96:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e98:	ff 4d f8             	decl   -0x8(%ebp)
  800e9b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e9f:	79 e9                	jns    800e8a <memset+0x14>
		*p++ = c;

	return v;
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ea4:	c9                   	leave  
  800ea5:	c3                   	ret    

00800ea6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ea6:	55                   	push   %ebp
  800ea7:	89 e5                	mov    %esp,%ebp
  800ea9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800eac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eaf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800eb8:	eb 16                	jmp    800ed0 <memcpy+0x2a>
		*d++ = *s++;
  800eba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ebd:	8d 50 01             	lea    0x1(%eax),%edx
  800ec0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ec3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ec6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ec9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ecc:	8a 12                	mov    (%edx),%dl
  800ece:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ed0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ed6:	89 55 10             	mov    %edx,0x10(%ebp)
  800ed9:	85 c0                	test   %eax,%eax
  800edb:	75 dd                	jne    800eba <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee0:	c9                   	leave  
  800ee1:	c3                   	ret    

00800ee2 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ee2:	55                   	push   %ebp
  800ee3:	89 e5                	mov    %esp,%ebp
  800ee5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ee8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eeb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ef4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800efa:	73 50                	jae    800f4c <memmove+0x6a>
  800efc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eff:	8b 45 10             	mov    0x10(%ebp),%eax
  800f02:	01 d0                	add    %edx,%eax
  800f04:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f07:	76 43                	jbe    800f4c <memmove+0x6a>
		s += n;
  800f09:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f12:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f15:	eb 10                	jmp    800f27 <memmove+0x45>
			*--d = *--s;
  800f17:	ff 4d f8             	decl   -0x8(%ebp)
  800f1a:	ff 4d fc             	decl   -0x4(%ebp)
  800f1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f20:	8a 10                	mov    (%eax),%dl
  800f22:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f25:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f27:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f2d:	89 55 10             	mov    %edx,0x10(%ebp)
  800f30:	85 c0                	test   %eax,%eax
  800f32:	75 e3                	jne    800f17 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f34:	eb 23                	jmp    800f59 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f36:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f39:	8d 50 01             	lea    0x1(%eax),%edx
  800f3c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f3f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f42:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f45:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f48:	8a 12                	mov    (%edx),%dl
  800f4a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f52:	89 55 10             	mov    %edx,0x10(%ebp)
  800f55:	85 c0                	test   %eax,%eax
  800f57:	75 dd                	jne    800f36 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f5c:	c9                   	leave  
  800f5d:	c3                   	ret    

00800f5e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f5e:	55                   	push   %ebp
  800f5f:	89 e5                	mov    %esp,%ebp
  800f61:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f70:	eb 2a                	jmp    800f9c <memcmp+0x3e>
		if (*s1 != *s2)
  800f72:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f75:	8a 10                	mov    (%eax),%dl
  800f77:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	38 c2                	cmp    %al,%dl
  800f7e:	74 16                	je     800f96 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f80:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f83:	8a 00                	mov    (%eax),%al
  800f85:	0f b6 d0             	movzbl %al,%edx
  800f88:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f8b:	8a 00                	mov    (%eax),%al
  800f8d:	0f b6 c0             	movzbl %al,%eax
  800f90:	29 c2                	sub    %eax,%edx
  800f92:	89 d0                	mov    %edx,%eax
  800f94:	eb 18                	jmp    800fae <memcmp+0x50>
		s1++, s2++;
  800f96:	ff 45 fc             	incl   -0x4(%ebp)
  800f99:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f9c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fa2:	89 55 10             	mov    %edx,0x10(%ebp)
  800fa5:	85 c0                	test   %eax,%eax
  800fa7:	75 c9                	jne    800f72 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800fa9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fae:	c9                   	leave  
  800faf:	c3                   	ret    

00800fb0 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800fb0:	55                   	push   %ebp
  800fb1:	89 e5                	mov    %esp,%ebp
  800fb3:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800fb6:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbc:	01 d0                	add    %edx,%eax
  800fbe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800fc1:	eb 15                	jmp    800fd8 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc6:	8a 00                	mov    (%eax),%al
  800fc8:	0f b6 d0             	movzbl %al,%edx
  800fcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fce:	0f b6 c0             	movzbl %al,%eax
  800fd1:	39 c2                	cmp    %eax,%edx
  800fd3:	74 0d                	je     800fe2 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800fd5:	ff 45 08             	incl   0x8(%ebp)
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fde:	72 e3                	jb     800fc3 <memfind+0x13>
  800fe0:	eb 01                	jmp    800fe3 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fe2:	90                   	nop
	return (void *) s;
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fe6:	c9                   	leave  
  800fe7:	c3                   	ret    

00800fe8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800fe8:	55                   	push   %ebp
  800fe9:	89 e5                	mov    %esp,%ebp
  800feb:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ff5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ffc:	eb 03                	jmp    801001 <strtol+0x19>
		s++;
  800ffe:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
  801004:	8a 00                	mov    (%eax),%al
  801006:	3c 20                	cmp    $0x20,%al
  801008:	74 f4                	je     800ffe <strtol+0x16>
  80100a:	8b 45 08             	mov    0x8(%ebp),%eax
  80100d:	8a 00                	mov    (%eax),%al
  80100f:	3c 09                	cmp    $0x9,%al
  801011:	74 eb                	je     800ffe <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801013:	8b 45 08             	mov    0x8(%ebp),%eax
  801016:	8a 00                	mov    (%eax),%al
  801018:	3c 2b                	cmp    $0x2b,%al
  80101a:	75 05                	jne    801021 <strtol+0x39>
		s++;
  80101c:	ff 45 08             	incl   0x8(%ebp)
  80101f:	eb 13                	jmp    801034 <strtol+0x4c>
	else if (*s == '-')
  801021:	8b 45 08             	mov    0x8(%ebp),%eax
  801024:	8a 00                	mov    (%eax),%al
  801026:	3c 2d                	cmp    $0x2d,%al
  801028:	75 0a                	jne    801034 <strtol+0x4c>
		s++, neg = 1;
  80102a:	ff 45 08             	incl   0x8(%ebp)
  80102d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801034:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801038:	74 06                	je     801040 <strtol+0x58>
  80103a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80103e:	75 20                	jne    801060 <strtol+0x78>
  801040:	8b 45 08             	mov    0x8(%ebp),%eax
  801043:	8a 00                	mov    (%eax),%al
  801045:	3c 30                	cmp    $0x30,%al
  801047:	75 17                	jne    801060 <strtol+0x78>
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	40                   	inc    %eax
  80104d:	8a 00                	mov    (%eax),%al
  80104f:	3c 78                	cmp    $0x78,%al
  801051:	75 0d                	jne    801060 <strtol+0x78>
		s += 2, base = 16;
  801053:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801057:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80105e:	eb 28                	jmp    801088 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801060:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801064:	75 15                	jne    80107b <strtol+0x93>
  801066:	8b 45 08             	mov    0x8(%ebp),%eax
  801069:	8a 00                	mov    (%eax),%al
  80106b:	3c 30                	cmp    $0x30,%al
  80106d:	75 0c                	jne    80107b <strtol+0x93>
		s++, base = 8;
  80106f:	ff 45 08             	incl   0x8(%ebp)
  801072:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801079:	eb 0d                	jmp    801088 <strtol+0xa0>
	else if (base == 0)
  80107b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80107f:	75 07                	jne    801088 <strtol+0xa0>
		base = 10;
  801081:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
  80108b:	8a 00                	mov    (%eax),%al
  80108d:	3c 2f                	cmp    $0x2f,%al
  80108f:	7e 19                	jle    8010aa <strtol+0xc2>
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
  801094:	8a 00                	mov    (%eax),%al
  801096:	3c 39                	cmp    $0x39,%al
  801098:	7f 10                	jg     8010aa <strtol+0xc2>
			dig = *s - '0';
  80109a:	8b 45 08             	mov    0x8(%ebp),%eax
  80109d:	8a 00                	mov    (%eax),%al
  80109f:	0f be c0             	movsbl %al,%eax
  8010a2:	83 e8 30             	sub    $0x30,%eax
  8010a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010a8:	eb 42                	jmp    8010ec <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ad:	8a 00                	mov    (%eax),%al
  8010af:	3c 60                	cmp    $0x60,%al
  8010b1:	7e 19                	jle    8010cc <strtol+0xe4>
  8010b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b6:	8a 00                	mov    (%eax),%al
  8010b8:	3c 7a                	cmp    $0x7a,%al
  8010ba:	7f 10                	jg     8010cc <strtol+0xe4>
			dig = *s - 'a' + 10;
  8010bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bf:	8a 00                	mov    (%eax),%al
  8010c1:	0f be c0             	movsbl %al,%eax
  8010c4:	83 e8 57             	sub    $0x57,%eax
  8010c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010ca:	eb 20                	jmp    8010ec <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8010cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cf:	8a 00                	mov    (%eax),%al
  8010d1:	3c 40                	cmp    $0x40,%al
  8010d3:	7e 39                	jle    80110e <strtol+0x126>
  8010d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d8:	8a 00                	mov    (%eax),%al
  8010da:	3c 5a                	cmp    $0x5a,%al
  8010dc:	7f 30                	jg     80110e <strtol+0x126>
			dig = *s - 'A' + 10;
  8010de:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e1:	8a 00                	mov    (%eax),%al
  8010e3:	0f be c0             	movsbl %al,%eax
  8010e6:	83 e8 37             	sub    $0x37,%eax
  8010e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010ef:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010f2:	7d 19                	jge    80110d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010f4:	ff 45 08             	incl   0x8(%ebp)
  8010f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010fa:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010fe:	89 c2                	mov    %eax,%edx
  801100:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801103:	01 d0                	add    %edx,%eax
  801105:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801108:	e9 7b ff ff ff       	jmp    801088 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80110d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80110e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801112:	74 08                	je     80111c <strtol+0x134>
		*endptr = (char *) s;
  801114:	8b 45 0c             	mov    0xc(%ebp),%eax
  801117:	8b 55 08             	mov    0x8(%ebp),%edx
  80111a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80111c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801120:	74 07                	je     801129 <strtol+0x141>
  801122:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801125:	f7 d8                	neg    %eax
  801127:	eb 03                	jmp    80112c <strtol+0x144>
  801129:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80112c:	c9                   	leave  
  80112d:	c3                   	ret    

0080112e <ltostr>:

void
ltostr(long value, char *str)
{
  80112e:	55                   	push   %ebp
  80112f:	89 e5                	mov    %esp,%ebp
  801131:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801134:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80113b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801142:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801146:	79 13                	jns    80115b <ltostr+0x2d>
	{
		neg = 1;
  801148:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80114f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801152:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801155:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801158:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801163:	99                   	cltd   
  801164:	f7 f9                	idiv   %ecx
  801166:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801169:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80116c:	8d 50 01             	lea    0x1(%eax),%edx
  80116f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801172:	89 c2                	mov    %eax,%edx
  801174:	8b 45 0c             	mov    0xc(%ebp),%eax
  801177:	01 d0                	add    %edx,%eax
  801179:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80117c:	83 c2 30             	add    $0x30,%edx
  80117f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801181:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801184:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801189:	f7 e9                	imul   %ecx
  80118b:	c1 fa 02             	sar    $0x2,%edx
  80118e:	89 c8                	mov    %ecx,%eax
  801190:	c1 f8 1f             	sar    $0x1f,%eax
  801193:	29 c2                	sub    %eax,%edx
  801195:	89 d0                	mov    %edx,%eax
  801197:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80119a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80119d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011a2:	f7 e9                	imul   %ecx
  8011a4:	c1 fa 02             	sar    $0x2,%edx
  8011a7:	89 c8                	mov    %ecx,%eax
  8011a9:	c1 f8 1f             	sar    $0x1f,%eax
  8011ac:	29 c2                	sub    %eax,%edx
  8011ae:	89 d0                	mov    %edx,%eax
  8011b0:	c1 e0 02             	shl    $0x2,%eax
  8011b3:	01 d0                	add    %edx,%eax
  8011b5:	01 c0                	add    %eax,%eax
  8011b7:	29 c1                	sub    %eax,%ecx
  8011b9:	89 ca                	mov    %ecx,%edx
  8011bb:	85 d2                	test   %edx,%edx
  8011bd:	75 9c                	jne    80115b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8011bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8011c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011c9:	48                   	dec    %eax
  8011ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8011cd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011d1:	74 3d                	je     801210 <ltostr+0xe2>
		start = 1 ;
  8011d3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011da:	eb 34                	jmp    801210 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e2:	01 d0                	add    %edx,%eax
  8011e4:	8a 00                	mov    (%eax),%al
  8011e6:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ef:	01 c2                	add    %eax,%edx
  8011f1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f7:	01 c8                	add    %ecx,%eax
  8011f9:	8a 00                	mov    (%eax),%al
  8011fb:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011fd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801200:	8b 45 0c             	mov    0xc(%ebp),%eax
  801203:	01 c2                	add    %eax,%edx
  801205:	8a 45 eb             	mov    -0x15(%ebp),%al
  801208:	88 02                	mov    %al,(%edx)
		start++ ;
  80120a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80120d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801210:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801213:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801216:	7c c4                	jl     8011dc <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801218:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80121b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121e:	01 d0                	add    %edx,%eax
  801220:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801223:	90                   	nop
  801224:	c9                   	leave  
  801225:	c3                   	ret    

00801226 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801226:	55                   	push   %ebp
  801227:	89 e5                	mov    %esp,%ebp
  801229:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80122c:	ff 75 08             	pushl  0x8(%ebp)
  80122f:	e8 54 fa ff ff       	call   800c88 <strlen>
  801234:	83 c4 04             	add    $0x4,%esp
  801237:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80123a:	ff 75 0c             	pushl  0xc(%ebp)
  80123d:	e8 46 fa ff ff       	call   800c88 <strlen>
  801242:	83 c4 04             	add    $0x4,%esp
  801245:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801248:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80124f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801256:	eb 17                	jmp    80126f <strcconcat+0x49>
		final[s] = str1[s] ;
  801258:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80125b:	8b 45 10             	mov    0x10(%ebp),%eax
  80125e:	01 c2                	add    %eax,%edx
  801260:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	01 c8                	add    %ecx,%eax
  801268:	8a 00                	mov    (%eax),%al
  80126a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80126c:	ff 45 fc             	incl   -0x4(%ebp)
  80126f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801272:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801275:	7c e1                	jl     801258 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801277:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80127e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801285:	eb 1f                	jmp    8012a6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801287:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80128a:	8d 50 01             	lea    0x1(%eax),%edx
  80128d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801290:	89 c2                	mov    %eax,%edx
  801292:	8b 45 10             	mov    0x10(%ebp),%eax
  801295:	01 c2                	add    %eax,%edx
  801297:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80129a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129d:	01 c8                	add    %ecx,%eax
  80129f:	8a 00                	mov    (%eax),%al
  8012a1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8012a3:	ff 45 f8             	incl   -0x8(%ebp)
  8012a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012ac:	7c d9                	jl     801287 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8012ae:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b4:	01 d0                	add    %edx,%eax
  8012b6:	c6 00 00             	movb   $0x0,(%eax)
}
  8012b9:	90                   	nop
  8012ba:	c9                   	leave  
  8012bb:	c3                   	ret    

008012bc <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8012bc:	55                   	push   %ebp
  8012bd:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8012bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8012c2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8012c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8012cb:	8b 00                	mov    (%eax),%eax
  8012cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d7:	01 d0                	add    %edx,%eax
  8012d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012df:	eb 0c                	jmp    8012ed <strsplit+0x31>
			*string++ = 0;
  8012e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e4:	8d 50 01             	lea    0x1(%eax),%edx
  8012e7:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ea:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f0:	8a 00                	mov    (%eax),%al
  8012f2:	84 c0                	test   %al,%al
  8012f4:	74 18                	je     80130e <strsplit+0x52>
  8012f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f9:	8a 00                	mov    (%eax),%al
  8012fb:	0f be c0             	movsbl %al,%eax
  8012fe:	50                   	push   %eax
  8012ff:	ff 75 0c             	pushl  0xc(%ebp)
  801302:	e8 13 fb ff ff       	call   800e1a <strchr>
  801307:	83 c4 08             	add    $0x8,%esp
  80130a:	85 c0                	test   %eax,%eax
  80130c:	75 d3                	jne    8012e1 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	8a 00                	mov    (%eax),%al
  801313:	84 c0                	test   %al,%al
  801315:	74 5a                	je     801371 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801317:	8b 45 14             	mov    0x14(%ebp),%eax
  80131a:	8b 00                	mov    (%eax),%eax
  80131c:	83 f8 0f             	cmp    $0xf,%eax
  80131f:	75 07                	jne    801328 <strsplit+0x6c>
		{
			return 0;
  801321:	b8 00 00 00 00       	mov    $0x0,%eax
  801326:	eb 66                	jmp    80138e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801328:	8b 45 14             	mov    0x14(%ebp),%eax
  80132b:	8b 00                	mov    (%eax),%eax
  80132d:	8d 48 01             	lea    0x1(%eax),%ecx
  801330:	8b 55 14             	mov    0x14(%ebp),%edx
  801333:	89 0a                	mov    %ecx,(%edx)
  801335:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80133c:	8b 45 10             	mov    0x10(%ebp),%eax
  80133f:	01 c2                	add    %eax,%edx
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801346:	eb 03                	jmp    80134b <strsplit+0x8f>
			string++;
  801348:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80134b:	8b 45 08             	mov    0x8(%ebp),%eax
  80134e:	8a 00                	mov    (%eax),%al
  801350:	84 c0                	test   %al,%al
  801352:	74 8b                	je     8012df <strsplit+0x23>
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	8a 00                	mov    (%eax),%al
  801359:	0f be c0             	movsbl %al,%eax
  80135c:	50                   	push   %eax
  80135d:	ff 75 0c             	pushl  0xc(%ebp)
  801360:	e8 b5 fa ff ff       	call   800e1a <strchr>
  801365:	83 c4 08             	add    $0x8,%esp
  801368:	85 c0                	test   %eax,%eax
  80136a:	74 dc                	je     801348 <strsplit+0x8c>
			string++;
	}
  80136c:	e9 6e ff ff ff       	jmp    8012df <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801371:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801372:	8b 45 14             	mov    0x14(%ebp),%eax
  801375:	8b 00                	mov    (%eax),%eax
  801377:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80137e:	8b 45 10             	mov    0x10(%ebp),%eax
  801381:	01 d0                	add    %edx,%eax
  801383:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801389:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80138e:	c9                   	leave  
  80138f:	c3                   	ret    

00801390 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801390:	55                   	push   %ebp
  801391:	89 e5                	mov    %esp,%ebp
  801393:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801396:	83 ec 04             	sub    $0x4,%esp
  801399:	68 b0 23 80 00       	push   $0x8023b0
  80139e:	6a 15                	push   $0x15
  8013a0:	68 d5 23 80 00       	push   $0x8023d5
  8013a5:	e8 a5 ef ff ff       	call   80034f <_panic>

008013aa <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
  8013ad:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8013b0:	83 ec 04             	sub    $0x4,%esp
  8013b3:	68 e4 23 80 00       	push   $0x8023e4
  8013b8:	6a 2e                	push   $0x2e
  8013ba:	68 d5 23 80 00       	push   $0x8023d5
  8013bf:	e8 8b ef ff ff       	call   80034f <_panic>

008013c4 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8013c4:	55                   	push   %ebp
  8013c5:	89 e5                	mov    %esp,%ebp
  8013c7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013ca:	83 ec 04             	sub    $0x4,%esp
  8013cd:	68 08 24 80 00       	push   $0x802408
  8013d2:	6a 4c                	push   $0x4c
  8013d4:	68 d5 23 80 00       	push   $0x8023d5
  8013d9:	e8 71 ef ff ff       	call   80034f <_panic>

008013de <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8013de:	55                   	push   %ebp
  8013df:	89 e5                	mov    %esp,%ebp
  8013e1:	83 ec 18             	sub    $0x18,%esp
  8013e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e7:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8013ea:	83 ec 04             	sub    $0x4,%esp
  8013ed:	68 08 24 80 00       	push   $0x802408
  8013f2:	6a 57                	push   $0x57
  8013f4:	68 d5 23 80 00       	push   $0x8023d5
  8013f9:	e8 51 ef ff ff       	call   80034f <_panic>

008013fe <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
  801401:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801404:	83 ec 04             	sub    $0x4,%esp
  801407:	68 08 24 80 00       	push   $0x802408
  80140c:	6a 5d                	push   $0x5d
  80140e:	68 d5 23 80 00       	push   $0x8023d5
  801413:	e8 37 ef ff ff       	call   80034f <_panic>

00801418 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
  80141b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80141e:	83 ec 04             	sub    $0x4,%esp
  801421:	68 08 24 80 00       	push   $0x802408
  801426:	6a 63                	push   $0x63
  801428:	68 d5 23 80 00       	push   $0x8023d5
  80142d:	e8 1d ef ff ff       	call   80034f <_panic>

00801432 <expand>:
}

void expand(uint32 newSize)
{
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
  801435:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801438:	83 ec 04             	sub    $0x4,%esp
  80143b:	68 08 24 80 00       	push   $0x802408
  801440:	6a 68                	push   $0x68
  801442:	68 d5 23 80 00       	push   $0x8023d5
  801447:	e8 03 ef ff ff       	call   80034f <_panic>

0080144c <shrink>:
}
void shrink(uint32 newSize)
{
  80144c:	55                   	push   %ebp
  80144d:	89 e5                	mov    %esp,%ebp
  80144f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801452:	83 ec 04             	sub    $0x4,%esp
  801455:	68 08 24 80 00       	push   $0x802408
  80145a:	6a 6c                	push   $0x6c
  80145c:	68 d5 23 80 00       	push   $0x8023d5
  801461:	e8 e9 ee ff ff       	call   80034f <_panic>

00801466 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801466:	55                   	push   %ebp
  801467:	89 e5                	mov    %esp,%ebp
  801469:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80146c:	83 ec 04             	sub    $0x4,%esp
  80146f:	68 08 24 80 00       	push   $0x802408
  801474:	6a 71                	push   $0x71
  801476:	68 d5 23 80 00       	push   $0x8023d5
  80147b:	e8 cf ee ff ff       	call   80034f <_panic>

00801480 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801480:	55                   	push   %ebp
  801481:	89 e5                	mov    %esp,%ebp
  801483:	57                   	push   %edi
  801484:	56                   	push   %esi
  801485:	53                   	push   %ebx
  801486:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80148f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801492:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801495:	8b 7d 18             	mov    0x18(%ebp),%edi
  801498:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80149b:	cd 30                	int    $0x30
  80149d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014a3:	83 c4 10             	add    $0x10,%esp
  8014a6:	5b                   	pop    %ebx
  8014a7:	5e                   	pop    %esi
  8014a8:	5f                   	pop    %edi
  8014a9:	5d                   	pop    %ebp
  8014aa:	c3                   	ret    

008014ab <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8014ab:	55                   	push   %ebp
  8014ac:	89 e5                	mov    %esp,%ebp
  8014ae:	83 ec 04             	sub    $0x4,%esp
  8014b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8014b7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	52                   	push   %edx
  8014c3:	ff 75 0c             	pushl  0xc(%ebp)
  8014c6:	50                   	push   %eax
  8014c7:	6a 00                	push   $0x0
  8014c9:	e8 b2 ff ff ff       	call   801480 <syscall>
  8014ce:	83 c4 18             	add    $0x18,%esp
}
  8014d1:	90                   	nop
  8014d2:	c9                   	leave  
  8014d3:	c3                   	ret    

008014d4 <sys_cgetc>:

int
sys_cgetc(void)
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 01                	push   $0x1
  8014e3:	e8 98 ff ff ff       	call   801480 <syscall>
  8014e8:	83 c4 18             	add    $0x18,%esp
}
  8014eb:	c9                   	leave  
  8014ec:	c3                   	ret    

008014ed <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8014ed:	55                   	push   %ebp
  8014ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8014f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	50                   	push   %eax
  8014fc:	6a 05                	push   $0x5
  8014fe:	e8 7d ff ff ff       	call   801480 <syscall>
  801503:	83 c4 18             	add    $0x18,%esp
}
  801506:	c9                   	leave  
  801507:	c3                   	ret    

00801508 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801508:	55                   	push   %ebp
  801509:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 02                	push   $0x2
  801517:	e8 64 ff ff ff       	call   801480 <syscall>
  80151c:	83 c4 18             	add    $0x18,%esp
}
  80151f:	c9                   	leave  
  801520:	c3                   	ret    

00801521 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801521:	55                   	push   %ebp
  801522:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801524:	6a 00                	push   $0x0
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 03                	push   $0x3
  801530:	e8 4b ff ff ff       	call   801480 <syscall>
  801535:	83 c4 18             	add    $0x18,%esp
}
  801538:	c9                   	leave  
  801539:	c3                   	ret    

0080153a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80153a:	55                   	push   %ebp
  80153b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 04                	push   $0x4
  801549:	e8 32 ff ff ff       	call   801480 <syscall>
  80154e:	83 c4 18             	add    $0x18,%esp
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <sys_env_exit>:


void sys_env_exit(void)
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 06                	push   $0x6
  801562:	e8 19 ff ff ff       	call   801480 <syscall>
  801567:	83 c4 18             	add    $0x18,%esp
}
  80156a:	90                   	nop
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801570:	8b 55 0c             	mov    0xc(%ebp),%edx
  801573:	8b 45 08             	mov    0x8(%ebp),%eax
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	52                   	push   %edx
  80157d:	50                   	push   %eax
  80157e:	6a 07                	push   $0x7
  801580:	e8 fb fe ff ff       	call   801480 <syscall>
  801585:	83 c4 18             	add    $0x18,%esp
}
  801588:	c9                   	leave  
  801589:	c3                   	ret    

0080158a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
  80158d:	56                   	push   %esi
  80158e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80158f:	8b 75 18             	mov    0x18(%ebp),%esi
  801592:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801595:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801598:	8b 55 0c             	mov    0xc(%ebp),%edx
  80159b:	8b 45 08             	mov    0x8(%ebp),%eax
  80159e:	56                   	push   %esi
  80159f:	53                   	push   %ebx
  8015a0:	51                   	push   %ecx
  8015a1:	52                   	push   %edx
  8015a2:	50                   	push   %eax
  8015a3:	6a 08                	push   $0x8
  8015a5:	e8 d6 fe ff ff       	call   801480 <syscall>
  8015aa:	83 c4 18             	add    $0x18,%esp
}
  8015ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015b0:	5b                   	pop    %ebx
  8015b1:	5e                   	pop    %esi
  8015b2:	5d                   	pop    %ebp
  8015b3:	c3                   	ret    

008015b4 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8015b4:	55                   	push   %ebp
  8015b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8015b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	52                   	push   %edx
  8015c4:	50                   	push   %eax
  8015c5:	6a 09                	push   $0x9
  8015c7:	e8 b4 fe ff ff       	call   801480 <syscall>
  8015cc:	83 c4 18             	add    $0x18,%esp
}
  8015cf:	c9                   	leave  
  8015d0:	c3                   	ret    

008015d1 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8015d1:	55                   	push   %ebp
  8015d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	ff 75 0c             	pushl  0xc(%ebp)
  8015dd:	ff 75 08             	pushl  0x8(%ebp)
  8015e0:	6a 0a                	push   $0xa
  8015e2:	e8 99 fe ff ff       	call   801480 <syscall>
  8015e7:	83 c4 18             	add    $0x18,%esp
}
  8015ea:	c9                   	leave  
  8015eb:	c3                   	ret    

008015ec <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015ec:	55                   	push   %ebp
  8015ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 0b                	push   $0xb
  8015fb:	e8 80 fe ff ff       	call   801480 <syscall>
  801600:	83 c4 18             	add    $0x18,%esp
}
  801603:	c9                   	leave  
  801604:	c3                   	ret    

00801605 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801605:	55                   	push   %ebp
  801606:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 0c                	push   $0xc
  801614:	e8 67 fe ff ff       	call   801480 <syscall>
  801619:	83 c4 18             	add    $0x18,%esp
}
  80161c:	c9                   	leave  
  80161d:	c3                   	ret    

0080161e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80161e:	55                   	push   %ebp
  80161f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801621:	6a 00                	push   $0x0
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 0d                	push   $0xd
  80162d:	e8 4e fe ff ff       	call   801480 <syscall>
  801632:	83 c4 18             	add    $0x18,%esp
}
  801635:	c9                   	leave  
  801636:	c3                   	ret    

00801637 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801637:	55                   	push   %ebp
  801638:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	ff 75 0c             	pushl  0xc(%ebp)
  801643:	ff 75 08             	pushl  0x8(%ebp)
  801646:	6a 11                	push   $0x11
  801648:	e8 33 fe ff ff       	call   801480 <syscall>
  80164d:	83 c4 18             	add    $0x18,%esp
	return;
  801650:	90                   	nop
}
  801651:	c9                   	leave  
  801652:	c3                   	ret    

00801653 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801653:	55                   	push   %ebp
  801654:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	ff 75 0c             	pushl  0xc(%ebp)
  80165f:	ff 75 08             	pushl  0x8(%ebp)
  801662:	6a 12                	push   $0x12
  801664:	e8 17 fe ff ff       	call   801480 <syscall>
  801669:	83 c4 18             	add    $0x18,%esp
	return ;
  80166c:	90                   	nop
}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 0e                	push   $0xe
  80167e:	e8 fd fd ff ff       	call   801480 <syscall>
  801683:	83 c4 18             	add    $0x18,%esp
}
  801686:	c9                   	leave  
  801687:	c3                   	ret    

00801688 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801688:	55                   	push   %ebp
  801689:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	ff 75 08             	pushl  0x8(%ebp)
  801696:	6a 0f                	push   $0xf
  801698:	e8 e3 fd ff ff       	call   801480 <syscall>
  80169d:	83 c4 18             	add    $0x18,%esp
}
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    

008016a2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 10                	push   $0x10
  8016b1:	e8 ca fd ff ff       	call   801480 <syscall>
  8016b6:	83 c4 18             	add    $0x18,%esp
}
  8016b9:	90                   	nop
  8016ba:	c9                   	leave  
  8016bb:	c3                   	ret    

008016bc <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 14                	push   $0x14
  8016cb:	e8 b0 fd ff ff       	call   801480 <syscall>
  8016d0:	83 c4 18             	add    $0x18,%esp
}
  8016d3:	90                   	nop
  8016d4:	c9                   	leave  
  8016d5:	c3                   	ret    

008016d6 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8016d6:	55                   	push   %ebp
  8016d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 15                	push   $0x15
  8016e5:	e8 96 fd ff ff       	call   801480 <syscall>
  8016ea:	83 c4 18             	add    $0x18,%esp
}
  8016ed:	90                   	nop
  8016ee:	c9                   	leave  
  8016ef:	c3                   	ret    

008016f0 <sys_cputc>:


void
sys_cputc(const char c)
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
  8016f3:	83 ec 04             	sub    $0x4,%esp
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016fc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	50                   	push   %eax
  801709:	6a 16                	push   $0x16
  80170b:	e8 70 fd ff ff       	call   801480 <syscall>
  801710:	83 c4 18             	add    $0x18,%esp
}
  801713:	90                   	nop
  801714:	c9                   	leave  
  801715:	c3                   	ret    

00801716 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801716:	55                   	push   %ebp
  801717:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 17                	push   $0x17
  801725:	e8 56 fd ff ff       	call   801480 <syscall>
  80172a:	83 c4 18             	add    $0x18,%esp
}
  80172d:	90                   	nop
  80172e:	c9                   	leave  
  80172f:	c3                   	ret    

00801730 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	ff 75 0c             	pushl  0xc(%ebp)
  80173f:	50                   	push   %eax
  801740:	6a 18                	push   $0x18
  801742:	e8 39 fd ff ff       	call   801480 <syscall>
  801747:	83 c4 18             	add    $0x18,%esp
}
  80174a:	c9                   	leave  
  80174b:	c3                   	ret    

0080174c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80174c:	55                   	push   %ebp
  80174d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80174f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801752:	8b 45 08             	mov    0x8(%ebp),%eax
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	52                   	push   %edx
  80175c:	50                   	push   %eax
  80175d:	6a 1b                	push   $0x1b
  80175f:	e8 1c fd ff ff       	call   801480 <syscall>
  801764:	83 c4 18             	add    $0x18,%esp
}
  801767:	c9                   	leave  
  801768:	c3                   	ret    

00801769 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801769:	55                   	push   %ebp
  80176a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80176c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80176f:	8b 45 08             	mov    0x8(%ebp),%eax
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	52                   	push   %edx
  801779:	50                   	push   %eax
  80177a:	6a 19                	push   $0x19
  80177c:	e8 ff fc ff ff       	call   801480 <syscall>
  801781:	83 c4 18             	add    $0x18,%esp
}
  801784:	90                   	nop
  801785:	c9                   	leave  
  801786:	c3                   	ret    

00801787 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801787:	55                   	push   %ebp
  801788:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80178a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178d:	8b 45 08             	mov    0x8(%ebp),%eax
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	52                   	push   %edx
  801797:	50                   	push   %eax
  801798:	6a 1a                	push   $0x1a
  80179a:	e8 e1 fc ff ff       	call   801480 <syscall>
  80179f:	83 c4 18             	add    $0x18,%esp
}
  8017a2:	90                   	nop
  8017a3:	c9                   	leave  
  8017a4:	c3                   	ret    

008017a5 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8017a5:	55                   	push   %ebp
  8017a6:	89 e5                	mov    %esp,%ebp
  8017a8:	83 ec 04             	sub    $0x4,%esp
  8017ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ae:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8017b1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017b4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bb:	6a 00                	push   $0x0
  8017bd:	51                   	push   %ecx
  8017be:	52                   	push   %edx
  8017bf:	ff 75 0c             	pushl  0xc(%ebp)
  8017c2:	50                   	push   %eax
  8017c3:	6a 1c                	push   $0x1c
  8017c5:	e8 b6 fc ff ff       	call   801480 <syscall>
  8017ca:	83 c4 18             	add    $0x18,%esp
}
  8017cd:	c9                   	leave  
  8017ce:	c3                   	ret    

008017cf <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8017cf:	55                   	push   %ebp
  8017d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8017d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	52                   	push   %edx
  8017df:	50                   	push   %eax
  8017e0:	6a 1d                	push   $0x1d
  8017e2:	e8 99 fc ff ff       	call   801480 <syscall>
  8017e7:	83 c4 18             	add    $0x18,%esp
}
  8017ea:	c9                   	leave  
  8017eb:	c3                   	ret    

008017ec <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8017ec:	55                   	push   %ebp
  8017ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8017ef:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	51                   	push   %ecx
  8017fd:	52                   	push   %edx
  8017fe:	50                   	push   %eax
  8017ff:	6a 1e                	push   $0x1e
  801801:	e8 7a fc ff ff       	call   801480 <syscall>
  801806:	83 c4 18             	add    $0x18,%esp
}
  801809:	c9                   	leave  
  80180a:	c3                   	ret    

0080180b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80180b:	55                   	push   %ebp
  80180c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80180e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801811:	8b 45 08             	mov    0x8(%ebp),%eax
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	52                   	push   %edx
  80181b:	50                   	push   %eax
  80181c:	6a 1f                	push   $0x1f
  80181e:	e8 5d fc ff ff       	call   801480 <syscall>
  801823:	83 c4 18             	add    $0x18,%esp
}
  801826:	c9                   	leave  
  801827:	c3                   	ret    

00801828 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801828:	55                   	push   %ebp
  801829:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 20                	push   $0x20
  801837:	e8 44 fc ff ff       	call   801480 <syscall>
  80183c:	83 c4 18             	add    $0x18,%esp
}
  80183f:	c9                   	leave  
  801840:	c3                   	ret    

00801841 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801841:	55                   	push   %ebp
  801842:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801844:	8b 45 08             	mov    0x8(%ebp),%eax
  801847:	6a 00                	push   $0x0
  801849:	ff 75 14             	pushl  0x14(%ebp)
  80184c:	ff 75 10             	pushl  0x10(%ebp)
  80184f:	ff 75 0c             	pushl  0xc(%ebp)
  801852:	50                   	push   %eax
  801853:	6a 21                	push   $0x21
  801855:	e8 26 fc ff ff       	call   801480 <syscall>
  80185a:	83 c4 18             	add    $0x18,%esp
}
  80185d:	c9                   	leave  
  80185e:	c3                   	ret    

0080185f <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80185f:	55                   	push   %ebp
  801860:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801862:	8b 45 08             	mov    0x8(%ebp),%eax
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	50                   	push   %eax
  80186e:	6a 22                	push   $0x22
  801870:	e8 0b fc ff ff       	call   801480 <syscall>
  801875:	83 c4 18             	add    $0x18,%esp
}
  801878:	90                   	nop
  801879:	c9                   	leave  
  80187a:	c3                   	ret    

0080187b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80187b:	55                   	push   %ebp
  80187c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80187e:	8b 45 08             	mov    0x8(%ebp),%eax
  801881:	6a 00                	push   $0x0
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	50                   	push   %eax
  80188a:	6a 23                	push   $0x23
  80188c:	e8 ef fb ff ff       	call   801480 <syscall>
  801891:	83 c4 18             	add    $0x18,%esp
}
  801894:	90                   	nop
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
  80189a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80189d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018a0:	8d 50 04             	lea    0x4(%eax),%edx
  8018a3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	52                   	push   %edx
  8018ad:	50                   	push   %eax
  8018ae:	6a 24                	push   $0x24
  8018b0:	e8 cb fb ff ff       	call   801480 <syscall>
  8018b5:	83 c4 18             	add    $0x18,%esp
	return result;
  8018b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018be:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018c1:	89 01                	mov    %eax,(%ecx)
  8018c3:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8018c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c9:	c9                   	leave  
  8018ca:	c2 04 00             	ret    $0x4

008018cd <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8018cd:	55                   	push   %ebp
  8018ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	ff 75 10             	pushl  0x10(%ebp)
  8018d7:	ff 75 0c             	pushl  0xc(%ebp)
  8018da:	ff 75 08             	pushl  0x8(%ebp)
  8018dd:	6a 13                	push   $0x13
  8018df:	e8 9c fb ff ff       	call   801480 <syscall>
  8018e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018e7:	90                   	nop
}
  8018e8:	c9                   	leave  
  8018e9:	c3                   	ret    

008018ea <sys_rcr2>:
uint32 sys_rcr2()
{
  8018ea:	55                   	push   %ebp
  8018eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 25                	push   $0x25
  8018f9:	e8 82 fb ff ff       	call   801480 <syscall>
  8018fe:	83 c4 18             	add    $0x18,%esp
}
  801901:	c9                   	leave  
  801902:	c3                   	ret    

00801903 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801903:	55                   	push   %ebp
  801904:	89 e5                	mov    %esp,%ebp
  801906:	83 ec 04             	sub    $0x4,%esp
  801909:	8b 45 08             	mov    0x8(%ebp),%eax
  80190c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80190f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	50                   	push   %eax
  80191c:	6a 26                	push   $0x26
  80191e:	e8 5d fb ff ff       	call   801480 <syscall>
  801923:	83 c4 18             	add    $0x18,%esp
	return ;
  801926:	90                   	nop
}
  801927:	c9                   	leave  
  801928:	c3                   	ret    

00801929 <rsttst>:
void rsttst()
{
  801929:	55                   	push   %ebp
  80192a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 28                	push   $0x28
  801938:	e8 43 fb ff ff       	call   801480 <syscall>
  80193d:	83 c4 18             	add    $0x18,%esp
	return ;
  801940:	90                   	nop
}
  801941:	c9                   	leave  
  801942:	c3                   	ret    

00801943 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801943:	55                   	push   %ebp
  801944:	89 e5                	mov    %esp,%ebp
  801946:	83 ec 04             	sub    $0x4,%esp
  801949:	8b 45 14             	mov    0x14(%ebp),%eax
  80194c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80194f:	8b 55 18             	mov    0x18(%ebp),%edx
  801952:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801956:	52                   	push   %edx
  801957:	50                   	push   %eax
  801958:	ff 75 10             	pushl  0x10(%ebp)
  80195b:	ff 75 0c             	pushl  0xc(%ebp)
  80195e:	ff 75 08             	pushl  0x8(%ebp)
  801961:	6a 27                	push   $0x27
  801963:	e8 18 fb ff ff       	call   801480 <syscall>
  801968:	83 c4 18             	add    $0x18,%esp
	return ;
  80196b:	90                   	nop
}
  80196c:	c9                   	leave  
  80196d:	c3                   	ret    

0080196e <chktst>:
void chktst(uint32 n)
{
  80196e:	55                   	push   %ebp
  80196f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	ff 75 08             	pushl  0x8(%ebp)
  80197c:	6a 29                	push   $0x29
  80197e:	e8 fd fa ff ff       	call   801480 <syscall>
  801983:	83 c4 18             	add    $0x18,%esp
	return ;
  801986:	90                   	nop
}
  801987:	c9                   	leave  
  801988:	c3                   	ret    

00801989 <inctst>:

void inctst()
{
  801989:	55                   	push   %ebp
  80198a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	6a 2a                	push   $0x2a
  801998:	e8 e3 fa ff ff       	call   801480 <syscall>
  80199d:	83 c4 18             	add    $0x18,%esp
	return ;
  8019a0:	90                   	nop
}
  8019a1:	c9                   	leave  
  8019a2:	c3                   	ret    

008019a3 <gettst>:
uint32 gettst()
{
  8019a3:	55                   	push   %ebp
  8019a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 2b                	push   $0x2b
  8019b2:	e8 c9 fa ff ff       	call   801480 <syscall>
  8019b7:	83 c4 18             	add    $0x18,%esp
}
  8019ba:	c9                   	leave  
  8019bb:	c3                   	ret    

008019bc <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8019bc:	55                   	push   %ebp
  8019bd:	89 e5                	mov    %esp,%ebp
  8019bf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 2c                	push   $0x2c
  8019ce:	e8 ad fa ff ff       	call   801480 <syscall>
  8019d3:	83 c4 18             	add    $0x18,%esp
  8019d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8019d9:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8019dd:	75 07                	jne    8019e6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8019df:	b8 01 00 00 00       	mov    $0x1,%eax
  8019e4:	eb 05                	jmp    8019eb <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8019e6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019eb:	c9                   	leave  
  8019ec:	c3                   	ret    

008019ed <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8019ed:	55                   	push   %ebp
  8019ee:	89 e5                	mov    %esp,%ebp
  8019f0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 2c                	push   $0x2c
  8019ff:	e8 7c fa ff ff       	call   801480 <syscall>
  801a04:	83 c4 18             	add    $0x18,%esp
  801a07:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a0a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a0e:	75 07                	jne    801a17 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a10:	b8 01 00 00 00       	mov    $0x1,%eax
  801a15:	eb 05                	jmp    801a1c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a17:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a1c:	c9                   	leave  
  801a1d:	c3                   	ret    

00801a1e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a1e:	55                   	push   %ebp
  801a1f:	89 e5                	mov    %esp,%ebp
  801a21:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 2c                	push   $0x2c
  801a30:	e8 4b fa ff ff       	call   801480 <syscall>
  801a35:	83 c4 18             	add    $0x18,%esp
  801a38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a3b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a3f:	75 07                	jne    801a48 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a41:	b8 01 00 00 00       	mov    $0x1,%eax
  801a46:	eb 05                	jmp    801a4d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a48:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a4d:	c9                   	leave  
  801a4e:	c3                   	ret    

00801a4f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a4f:	55                   	push   %ebp
  801a50:	89 e5                	mov    %esp,%ebp
  801a52:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 2c                	push   $0x2c
  801a61:	e8 1a fa ff ff       	call   801480 <syscall>
  801a66:	83 c4 18             	add    $0x18,%esp
  801a69:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a6c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a70:	75 07                	jne    801a79 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a72:	b8 01 00 00 00       	mov    $0x1,%eax
  801a77:	eb 05                	jmp    801a7e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a79:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a7e:	c9                   	leave  
  801a7f:	c3                   	ret    

00801a80 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a80:	55                   	push   %ebp
  801a81:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	ff 75 08             	pushl  0x8(%ebp)
  801a8e:	6a 2d                	push   $0x2d
  801a90:	e8 eb f9 ff ff       	call   801480 <syscall>
  801a95:	83 c4 18             	add    $0x18,%esp
	return ;
  801a98:	90                   	nop
}
  801a99:	c9                   	leave  
  801a9a:	c3                   	ret    

00801a9b <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a9b:	55                   	push   %ebp
  801a9c:	89 e5                	mov    %esp,%ebp
  801a9e:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a9f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801aa2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aa5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  801aab:	6a 00                	push   $0x0
  801aad:	53                   	push   %ebx
  801aae:	51                   	push   %ecx
  801aaf:	52                   	push   %edx
  801ab0:	50                   	push   %eax
  801ab1:	6a 2e                	push   $0x2e
  801ab3:	e8 c8 f9 ff ff       	call   801480 <syscall>
  801ab8:	83 c4 18             	add    $0x18,%esp
}
  801abb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801abe:	c9                   	leave  
  801abf:	c3                   	ret    

00801ac0 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801ac0:	55                   	push   %ebp
  801ac1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801ac3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	52                   	push   %edx
  801ad0:	50                   	push   %eax
  801ad1:	6a 2f                	push   $0x2f
  801ad3:	e8 a8 f9 ff ff       	call   801480 <syscall>
  801ad8:	83 c4 18             	add    $0x18,%esp
}
  801adb:	c9                   	leave  
  801adc:	c3                   	ret    

00801add <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801add:	55                   	push   %ebp
  801ade:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	ff 75 0c             	pushl  0xc(%ebp)
  801ae9:	ff 75 08             	pushl  0x8(%ebp)
  801aec:	6a 30                	push   $0x30
  801aee:	e8 8d f9 ff ff       	call   801480 <syscall>
  801af3:	83 c4 18             	add    $0x18,%esp
	return ;
  801af6:	90                   	nop
}
  801af7:	c9                   	leave  
  801af8:	c3                   	ret    
  801af9:	66 90                	xchg   %ax,%ax
  801afb:	90                   	nop

00801afc <__udivdi3>:
  801afc:	55                   	push   %ebp
  801afd:	57                   	push   %edi
  801afe:	56                   	push   %esi
  801aff:	53                   	push   %ebx
  801b00:	83 ec 1c             	sub    $0x1c,%esp
  801b03:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b07:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b0b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b0f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b13:	89 ca                	mov    %ecx,%edx
  801b15:	89 f8                	mov    %edi,%eax
  801b17:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b1b:	85 f6                	test   %esi,%esi
  801b1d:	75 2d                	jne    801b4c <__udivdi3+0x50>
  801b1f:	39 cf                	cmp    %ecx,%edi
  801b21:	77 65                	ja     801b88 <__udivdi3+0x8c>
  801b23:	89 fd                	mov    %edi,%ebp
  801b25:	85 ff                	test   %edi,%edi
  801b27:	75 0b                	jne    801b34 <__udivdi3+0x38>
  801b29:	b8 01 00 00 00       	mov    $0x1,%eax
  801b2e:	31 d2                	xor    %edx,%edx
  801b30:	f7 f7                	div    %edi
  801b32:	89 c5                	mov    %eax,%ebp
  801b34:	31 d2                	xor    %edx,%edx
  801b36:	89 c8                	mov    %ecx,%eax
  801b38:	f7 f5                	div    %ebp
  801b3a:	89 c1                	mov    %eax,%ecx
  801b3c:	89 d8                	mov    %ebx,%eax
  801b3e:	f7 f5                	div    %ebp
  801b40:	89 cf                	mov    %ecx,%edi
  801b42:	89 fa                	mov    %edi,%edx
  801b44:	83 c4 1c             	add    $0x1c,%esp
  801b47:	5b                   	pop    %ebx
  801b48:	5e                   	pop    %esi
  801b49:	5f                   	pop    %edi
  801b4a:	5d                   	pop    %ebp
  801b4b:	c3                   	ret    
  801b4c:	39 ce                	cmp    %ecx,%esi
  801b4e:	77 28                	ja     801b78 <__udivdi3+0x7c>
  801b50:	0f bd fe             	bsr    %esi,%edi
  801b53:	83 f7 1f             	xor    $0x1f,%edi
  801b56:	75 40                	jne    801b98 <__udivdi3+0x9c>
  801b58:	39 ce                	cmp    %ecx,%esi
  801b5a:	72 0a                	jb     801b66 <__udivdi3+0x6a>
  801b5c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b60:	0f 87 9e 00 00 00    	ja     801c04 <__udivdi3+0x108>
  801b66:	b8 01 00 00 00       	mov    $0x1,%eax
  801b6b:	89 fa                	mov    %edi,%edx
  801b6d:	83 c4 1c             	add    $0x1c,%esp
  801b70:	5b                   	pop    %ebx
  801b71:	5e                   	pop    %esi
  801b72:	5f                   	pop    %edi
  801b73:	5d                   	pop    %ebp
  801b74:	c3                   	ret    
  801b75:	8d 76 00             	lea    0x0(%esi),%esi
  801b78:	31 ff                	xor    %edi,%edi
  801b7a:	31 c0                	xor    %eax,%eax
  801b7c:	89 fa                	mov    %edi,%edx
  801b7e:	83 c4 1c             	add    $0x1c,%esp
  801b81:	5b                   	pop    %ebx
  801b82:	5e                   	pop    %esi
  801b83:	5f                   	pop    %edi
  801b84:	5d                   	pop    %ebp
  801b85:	c3                   	ret    
  801b86:	66 90                	xchg   %ax,%ax
  801b88:	89 d8                	mov    %ebx,%eax
  801b8a:	f7 f7                	div    %edi
  801b8c:	31 ff                	xor    %edi,%edi
  801b8e:	89 fa                	mov    %edi,%edx
  801b90:	83 c4 1c             	add    $0x1c,%esp
  801b93:	5b                   	pop    %ebx
  801b94:	5e                   	pop    %esi
  801b95:	5f                   	pop    %edi
  801b96:	5d                   	pop    %ebp
  801b97:	c3                   	ret    
  801b98:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b9d:	89 eb                	mov    %ebp,%ebx
  801b9f:	29 fb                	sub    %edi,%ebx
  801ba1:	89 f9                	mov    %edi,%ecx
  801ba3:	d3 e6                	shl    %cl,%esi
  801ba5:	89 c5                	mov    %eax,%ebp
  801ba7:	88 d9                	mov    %bl,%cl
  801ba9:	d3 ed                	shr    %cl,%ebp
  801bab:	89 e9                	mov    %ebp,%ecx
  801bad:	09 f1                	or     %esi,%ecx
  801baf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bb3:	89 f9                	mov    %edi,%ecx
  801bb5:	d3 e0                	shl    %cl,%eax
  801bb7:	89 c5                	mov    %eax,%ebp
  801bb9:	89 d6                	mov    %edx,%esi
  801bbb:	88 d9                	mov    %bl,%cl
  801bbd:	d3 ee                	shr    %cl,%esi
  801bbf:	89 f9                	mov    %edi,%ecx
  801bc1:	d3 e2                	shl    %cl,%edx
  801bc3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bc7:	88 d9                	mov    %bl,%cl
  801bc9:	d3 e8                	shr    %cl,%eax
  801bcb:	09 c2                	or     %eax,%edx
  801bcd:	89 d0                	mov    %edx,%eax
  801bcf:	89 f2                	mov    %esi,%edx
  801bd1:	f7 74 24 0c          	divl   0xc(%esp)
  801bd5:	89 d6                	mov    %edx,%esi
  801bd7:	89 c3                	mov    %eax,%ebx
  801bd9:	f7 e5                	mul    %ebp
  801bdb:	39 d6                	cmp    %edx,%esi
  801bdd:	72 19                	jb     801bf8 <__udivdi3+0xfc>
  801bdf:	74 0b                	je     801bec <__udivdi3+0xf0>
  801be1:	89 d8                	mov    %ebx,%eax
  801be3:	31 ff                	xor    %edi,%edi
  801be5:	e9 58 ff ff ff       	jmp    801b42 <__udivdi3+0x46>
  801bea:	66 90                	xchg   %ax,%ax
  801bec:	8b 54 24 08          	mov    0x8(%esp),%edx
  801bf0:	89 f9                	mov    %edi,%ecx
  801bf2:	d3 e2                	shl    %cl,%edx
  801bf4:	39 c2                	cmp    %eax,%edx
  801bf6:	73 e9                	jae    801be1 <__udivdi3+0xe5>
  801bf8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801bfb:	31 ff                	xor    %edi,%edi
  801bfd:	e9 40 ff ff ff       	jmp    801b42 <__udivdi3+0x46>
  801c02:	66 90                	xchg   %ax,%ax
  801c04:	31 c0                	xor    %eax,%eax
  801c06:	e9 37 ff ff ff       	jmp    801b42 <__udivdi3+0x46>
  801c0b:	90                   	nop

00801c0c <__umoddi3>:
  801c0c:	55                   	push   %ebp
  801c0d:	57                   	push   %edi
  801c0e:	56                   	push   %esi
  801c0f:	53                   	push   %ebx
  801c10:	83 ec 1c             	sub    $0x1c,%esp
  801c13:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c17:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c1f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c23:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c27:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c2b:	89 f3                	mov    %esi,%ebx
  801c2d:	89 fa                	mov    %edi,%edx
  801c2f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c33:	89 34 24             	mov    %esi,(%esp)
  801c36:	85 c0                	test   %eax,%eax
  801c38:	75 1a                	jne    801c54 <__umoddi3+0x48>
  801c3a:	39 f7                	cmp    %esi,%edi
  801c3c:	0f 86 a2 00 00 00    	jbe    801ce4 <__umoddi3+0xd8>
  801c42:	89 c8                	mov    %ecx,%eax
  801c44:	89 f2                	mov    %esi,%edx
  801c46:	f7 f7                	div    %edi
  801c48:	89 d0                	mov    %edx,%eax
  801c4a:	31 d2                	xor    %edx,%edx
  801c4c:	83 c4 1c             	add    $0x1c,%esp
  801c4f:	5b                   	pop    %ebx
  801c50:	5e                   	pop    %esi
  801c51:	5f                   	pop    %edi
  801c52:	5d                   	pop    %ebp
  801c53:	c3                   	ret    
  801c54:	39 f0                	cmp    %esi,%eax
  801c56:	0f 87 ac 00 00 00    	ja     801d08 <__umoddi3+0xfc>
  801c5c:	0f bd e8             	bsr    %eax,%ebp
  801c5f:	83 f5 1f             	xor    $0x1f,%ebp
  801c62:	0f 84 ac 00 00 00    	je     801d14 <__umoddi3+0x108>
  801c68:	bf 20 00 00 00       	mov    $0x20,%edi
  801c6d:	29 ef                	sub    %ebp,%edi
  801c6f:	89 fe                	mov    %edi,%esi
  801c71:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c75:	89 e9                	mov    %ebp,%ecx
  801c77:	d3 e0                	shl    %cl,%eax
  801c79:	89 d7                	mov    %edx,%edi
  801c7b:	89 f1                	mov    %esi,%ecx
  801c7d:	d3 ef                	shr    %cl,%edi
  801c7f:	09 c7                	or     %eax,%edi
  801c81:	89 e9                	mov    %ebp,%ecx
  801c83:	d3 e2                	shl    %cl,%edx
  801c85:	89 14 24             	mov    %edx,(%esp)
  801c88:	89 d8                	mov    %ebx,%eax
  801c8a:	d3 e0                	shl    %cl,%eax
  801c8c:	89 c2                	mov    %eax,%edx
  801c8e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c92:	d3 e0                	shl    %cl,%eax
  801c94:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c98:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c9c:	89 f1                	mov    %esi,%ecx
  801c9e:	d3 e8                	shr    %cl,%eax
  801ca0:	09 d0                	or     %edx,%eax
  801ca2:	d3 eb                	shr    %cl,%ebx
  801ca4:	89 da                	mov    %ebx,%edx
  801ca6:	f7 f7                	div    %edi
  801ca8:	89 d3                	mov    %edx,%ebx
  801caa:	f7 24 24             	mull   (%esp)
  801cad:	89 c6                	mov    %eax,%esi
  801caf:	89 d1                	mov    %edx,%ecx
  801cb1:	39 d3                	cmp    %edx,%ebx
  801cb3:	0f 82 87 00 00 00    	jb     801d40 <__umoddi3+0x134>
  801cb9:	0f 84 91 00 00 00    	je     801d50 <__umoddi3+0x144>
  801cbf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801cc3:	29 f2                	sub    %esi,%edx
  801cc5:	19 cb                	sbb    %ecx,%ebx
  801cc7:	89 d8                	mov    %ebx,%eax
  801cc9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ccd:	d3 e0                	shl    %cl,%eax
  801ccf:	89 e9                	mov    %ebp,%ecx
  801cd1:	d3 ea                	shr    %cl,%edx
  801cd3:	09 d0                	or     %edx,%eax
  801cd5:	89 e9                	mov    %ebp,%ecx
  801cd7:	d3 eb                	shr    %cl,%ebx
  801cd9:	89 da                	mov    %ebx,%edx
  801cdb:	83 c4 1c             	add    $0x1c,%esp
  801cde:	5b                   	pop    %ebx
  801cdf:	5e                   	pop    %esi
  801ce0:	5f                   	pop    %edi
  801ce1:	5d                   	pop    %ebp
  801ce2:	c3                   	ret    
  801ce3:	90                   	nop
  801ce4:	89 fd                	mov    %edi,%ebp
  801ce6:	85 ff                	test   %edi,%edi
  801ce8:	75 0b                	jne    801cf5 <__umoddi3+0xe9>
  801cea:	b8 01 00 00 00       	mov    $0x1,%eax
  801cef:	31 d2                	xor    %edx,%edx
  801cf1:	f7 f7                	div    %edi
  801cf3:	89 c5                	mov    %eax,%ebp
  801cf5:	89 f0                	mov    %esi,%eax
  801cf7:	31 d2                	xor    %edx,%edx
  801cf9:	f7 f5                	div    %ebp
  801cfb:	89 c8                	mov    %ecx,%eax
  801cfd:	f7 f5                	div    %ebp
  801cff:	89 d0                	mov    %edx,%eax
  801d01:	e9 44 ff ff ff       	jmp    801c4a <__umoddi3+0x3e>
  801d06:	66 90                	xchg   %ax,%ax
  801d08:	89 c8                	mov    %ecx,%eax
  801d0a:	89 f2                	mov    %esi,%edx
  801d0c:	83 c4 1c             	add    $0x1c,%esp
  801d0f:	5b                   	pop    %ebx
  801d10:	5e                   	pop    %esi
  801d11:	5f                   	pop    %edi
  801d12:	5d                   	pop    %ebp
  801d13:	c3                   	ret    
  801d14:	3b 04 24             	cmp    (%esp),%eax
  801d17:	72 06                	jb     801d1f <__umoddi3+0x113>
  801d19:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d1d:	77 0f                	ja     801d2e <__umoddi3+0x122>
  801d1f:	89 f2                	mov    %esi,%edx
  801d21:	29 f9                	sub    %edi,%ecx
  801d23:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d27:	89 14 24             	mov    %edx,(%esp)
  801d2a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d2e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d32:	8b 14 24             	mov    (%esp),%edx
  801d35:	83 c4 1c             	add    $0x1c,%esp
  801d38:	5b                   	pop    %ebx
  801d39:	5e                   	pop    %esi
  801d3a:	5f                   	pop    %edi
  801d3b:	5d                   	pop    %ebp
  801d3c:	c3                   	ret    
  801d3d:	8d 76 00             	lea    0x0(%esi),%esi
  801d40:	2b 04 24             	sub    (%esp),%eax
  801d43:	19 fa                	sbb    %edi,%edx
  801d45:	89 d1                	mov    %edx,%ecx
  801d47:	89 c6                	mov    %eax,%esi
  801d49:	e9 71 ff ff ff       	jmp    801cbf <__umoddi3+0xb3>
  801d4e:	66 90                	xchg   %ax,%ax
  801d50:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d54:	72 ea                	jb     801d40 <__umoddi3+0x134>
  801d56:	89 d9                	mov    %ebx,%ecx
  801d58:	e9 62 ff ff ff       	jmp    801cbf <__umoddi3+0xb3>
