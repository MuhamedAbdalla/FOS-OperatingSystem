
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
  800066:	e8 28 13 00 00       	call   801393 <malloc>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	89 45 cc             	mov    %eax,-0x34(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  800071:	83 ec 0c             	sub    $0xc,%esp
  800074:	ff 75 d0             	pushl  -0x30(%ebp)
  800077:	e8 17 13 00 00       	call   801393 <malloc>
  80007c:	83 c4 10             	add    $0x10,%esp
  80007f:	89 45 c8             	mov    %eax,-0x38(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800082:	e8 05 19 00 00       	call   80198c <sys_pf_calculate_allocated_pages>
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
  8000d1:	e8 82 15 00 00       	call   801658 <free>
  8000d6:	83 c4 10             	add    $0x10,%esp
		free(y);
  8000d9:	83 ec 0c             	sub    $0xc,%esp
  8000dc:	ff 75 c8             	pushl  -0x38(%ebp)
  8000df:	e8 74 15 00 00       	call   801658 <free>
  8000e4:	83 c4 10             	add    $0x10,%esp

		///		cprintf("%d\n",sys_pf_calculate_allocated_pages() - usedDiskPages);
		///assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 5 ); //4 pages + 1 table, that was not in WS

		int freePages = sys_calculate_free_frames();
  8000e7:	e8 1d 18 00 00       	call   801909 <sys_calculate_free_frames>
  8000ec:	89 45 c0             	mov    %eax,-0x40(%ebp)

		x = malloc(sizeof(char)*size) ;
  8000ef:	83 ec 0c             	sub    $0xc,%esp
  8000f2:	ff 75 d0             	pushl  -0x30(%ebp)
  8000f5:	e8 99 12 00 00       	call   801393 <malloc>
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
  800144:	bb 40 21 80 00       	mov    $0x802140,%ebx
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
  80017b:	8b 98 30 ef 00 00    	mov    0xef30(%eax),%ebx
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
  8001c5:	68 80 20 80 00       	push   $0x802080
  8001ca:	6a 41                	push   $0x41
  8001cc:	68 b8 20 80 00       	push   $0x8020b8
  8001d1:	e8 7c 01 00 00       	call   800352 <_panic>
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
  8001ef:	e8 15 17 00 00       	call   801909 <sys_calculate_free_frames>
  8001f4:	29 c3                	sub    %eax,%ebx
  8001f6:	89 d8                	mov    %ebx,%eax
  8001f8:	83 f8 08             	cmp    $0x8,%eax
  8001fb:	74 14                	je     800211 <_main+0x1d9>
  8001fd:	83 ec 04             	sub    $0x4,%esp
  800200:	68 cc 20 80 00       	push   $0x8020cc
  800205:	6a 45                	push   $0x45
  800207:	68 b8 20 80 00       	push   $0x8020b8
  80020c:	e8 41 01 00 00       	call   800352 <_panic>
	}

	cprintf("Congratulations!! test HEAP_PROGRAM completed successfully.\n");
  800211:	83 ec 0c             	sub    $0xc,%esp
  800214:	68 f4 20 80 00       	push   $0x8020f4
  800219:	e8 eb 03 00 00       	call   800609 <cprintf>
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
  800230:	e8 09 16 00 00       	call   80183e <sys_getenvindex>
  800235:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800238:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80023b:	89 d0                	mov    %edx,%eax
  80023d:	01 c0                	add    %eax,%eax
  80023f:	01 d0                	add    %edx,%eax
  800241:	c1 e0 07             	shl    $0x7,%eax
  800244:	29 d0                	sub    %edx,%eax
  800246:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80024d:	01 c8                	add    %ecx,%eax
  80024f:	01 c0                	add    %eax,%eax
  800251:	01 d0                	add    %edx,%eax
  800253:	01 c0                	add    %eax,%eax
  800255:	01 d0                	add    %edx,%eax
  800257:	c1 e0 03             	shl    $0x3,%eax
  80025a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80025f:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800264:	a1 20 30 80 00       	mov    0x803020,%eax
  800269:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  80026f:	84 c0                	test   %al,%al
  800271:	74 0f                	je     800282 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800273:	a1 20 30 80 00       	mov    0x803020,%eax
  800278:	05 f0 ee 00 00       	add    $0xeef0,%eax
  80027d:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800282:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800286:	7e 0a                	jle    800292 <libmain+0x68>
		binaryname = argv[0];
  800288:	8b 45 0c             	mov    0xc(%ebp),%eax
  80028b:	8b 00                	mov    (%eax),%eax
  80028d:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800292:	83 ec 08             	sub    $0x8,%esp
  800295:	ff 75 0c             	pushl  0xc(%ebp)
  800298:	ff 75 08             	pushl  0x8(%ebp)
  80029b:	e8 98 fd ff ff       	call   800038 <_main>
  8002a0:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8002a3:	e8 31 17 00 00       	call   8019d9 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8002a8:	83 ec 0c             	sub    $0xc,%esp
  8002ab:	68 78 21 80 00       	push   $0x802178
  8002b0:	e8 54 03 00 00       	call   800609 <cprintf>
  8002b5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002bd:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  8002c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c8:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  8002ce:	83 ec 04             	sub    $0x4,%esp
  8002d1:	52                   	push   %edx
  8002d2:	50                   	push   %eax
  8002d3:	68 a0 21 80 00       	push   $0x8021a0
  8002d8:	e8 2c 03 00 00       	call   800609 <cprintf>
  8002dd:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8002e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e5:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  8002eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f0:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  8002f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002fb:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  800301:	51                   	push   %ecx
  800302:	52                   	push   %edx
  800303:	50                   	push   %eax
  800304:	68 c8 21 80 00       	push   $0x8021c8
  800309:	e8 fb 02 00 00       	call   800609 <cprintf>
  80030e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800311:	83 ec 0c             	sub    $0xc,%esp
  800314:	68 78 21 80 00       	push   $0x802178
  800319:	e8 eb 02 00 00       	call   800609 <cprintf>
  80031e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800321:	e8 cd 16 00 00       	call   8019f3 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800326:	e8 19 00 00 00       	call   800344 <exit>
}
  80032b:	90                   	nop
  80032c:	c9                   	leave  
  80032d:	c3                   	ret    

0080032e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80032e:	55                   	push   %ebp
  80032f:	89 e5                	mov    %esp,%ebp
  800331:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800334:	83 ec 0c             	sub    $0xc,%esp
  800337:	6a 00                	push   $0x0
  800339:	e8 cc 14 00 00       	call   80180a <sys_env_destroy>
  80033e:	83 c4 10             	add    $0x10,%esp
}
  800341:	90                   	nop
  800342:	c9                   	leave  
  800343:	c3                   	ret    

00800344 <exit>:

void
exit(void)
{
  800344:	55                   	push   %ebp
  800345:	89 e5                	mov    %esp,%ebp
  800347:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80034a:	e8 21 15 00 00       	call   801870 <sys_env_exit>
}
  80034f:	90                   	nop
  800350:	c9                   	leave  
  800351:	c3                   	ret    

00800352 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800352:	55                   	push   %ebp
  800353:	89 e5                	mov    %esp,%ebp
  800355:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800358:	8d 45 10             	lea    0x10(%ebp),%eax
  80035b:	83 c0 04             	add    $0x4,%eax
  80035e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800361:	a1 18 31 80 00       	mov    0x803118,%eax
  800366:	85 c0                	test   %eax,%eax
  800368:	74 16                	je     800380 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80036a:	a1 18 31 80 00       	mov    0x803118,%eax
  80036f:	83 ec 08             	sub    $0x8,%esp
  800372:	50                   	push   %eax
  800373:	68 20 22 80 00       	push   $0x802220
  800378:	e8 8c 02 00 00       	call   800609 <cprintf>
  80037d:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800380:	a1 00 30 80 00       	mov    0x803000,%eax
  800385:	ff 75 0c             	pushl  0xc(%ebp)
  800388:	ff 75 08             	pushl  0x8(%ebp)
  80038b:	50                   	push   %eax
  80038c:	68 25 22 80 00       	push   $0x802225
  800391:	e8 73 02 00 00       	call   800609 <cprintf>
  800396:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800399:	8b 45 10             	mov    0x10(%ebp),%eax
  80039c:	83 ec 08             	sub    $0x8,%esp
  80039f:	ff 75 f4             	pushl  -0xc(%ebp)
  8003a2:	50                   	push   %eax
  8003a3:	e8 f6 01 00 00       	call   80059e <vcprintf>
  8003a8:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8003ab:	83 ec 08             	sub    $0x8,%esp
  8003ae:	6a 00                	push   $0x0
  8003b0:	68 41 22 80 00       	push   $0x802241
  8003b5:	e8 e4 01 00 00       	call   80059e <vcprintf>
  8003ba:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8003bd:	e8 82 ff ff ff       	call   800344 <exit>

	// should not return here
	while (1) ;
  8003c2:	eb fe                	jmp    8003c2 <_panic+0x70>

008003c4 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8003c4:	55                   	push   %ebp
  8003c5:	89 e5                	mov    %esp,%ebp
  8003c7:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8003ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8003cf:	8b 50 74             	mov    0x74(%eax),%edx
  8003d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003d5:	39 c2                	cmp    %eax,%edx
  8003d7:	74 14                	je     8003ed <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8003d9:	83 ec 04             	sub    $0x4,%esp
  8003dc:	68 44 22 80 00       	push   $0x802244
  8003e1:	6a 26                	push   $0x26
  8003e3:	68 90 22 80 00       	push   $0x802290
  8003e8:	e8 65 ff ff ff       	call   800352 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003fb:	e9 c4 00 00 00       	jmp    8004c4 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800400:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800403:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040a:	8b 45 08             	mov    0x8(%ebp),%eax
  80040d:	01 d0                	add    %edx,%eax
  80040f:	8b 00                	mov    (%eax),%eax
  800411:	85 c0                	test   %eax,%eax
  800413:	75 08                	jne    80041d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800415:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800418:	e9 a4 00 00 00       	jmp    8004c1 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  80041d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800424:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80042b:	eb 6b                	jmp    800498 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80042d:	a1 20 30 80 00       	mov    0x803020,%eax
  800432:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800438:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80043b:	89 d0                	mov    %edx,%eax
  80043d:	c1 e0 02             	shl    $0x2,%eax
  800440:	01 d0                	add    %edx,%eax
  800442:	c1 e0 02             	shl    $0x2,%eax
  800445:	01 c8                	add    %ecx,%eax
  800447:	8a 40 04             	mov    0x4(%eax),%al
  80044a:	84 c0                	test   %al,%al
  80044c:	75 47                	jne    800495 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80044e:	a1 20 30 80 00       	mov    0x803020,%eax
  800453:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800459:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80045c:	89 d0                	mov    %edx,%eax
  80045e:	c1 e0 02             	shl    $0x2,%eax
  800461:	01 d0                	add    %edx,%eax
  800463:	c1 e0 02             	shl    $0x2,%eax
  800466:	01 c8                	add    %ecx,%eax
  800468:	8b 00                	mov    (%eax),%eax
  80046a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80046d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800470:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800475:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800477:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80047a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800481:	8b 45 08             	mov    0x8(%ebp),%eax
  800484:	01 c8                	add    %ecx,%eax
  800486:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800488:	39 c2                	cmp    %eax,%edx
  80048a:	75 09                	jne    800495 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80048c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800493:	eb 12                	jmp    8004a7 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800495:	ff 45 e8             	incl   -0x18(%ebp)
  800498:	a1 20 30 80 00       	mov    0x803020,%eax
  80049d:	8b 50 74             	mov    0x74(%eax),%edx
  8004a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8004a3:	39 c2                	cmp    %eax,%edx
  8004a5:	77 86                	ja     80042d <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8004a7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8004ab:	75 14                	jne    8004c1 <CheckWSWithoutLastIndex+0xfd>
			panic(
  8004ad:	83 ec 04             	sub    $0x4,%esp
  8004b0:	68 9c 22 80 00       	push   $0x80229c
  8004b5:	6a 3a                	push   $0x3a
  8004b7:	68 90 22 80 00       	push   $0x802290
  8004bc:	e8 91 fe ff ff       	call   800352 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8004c1:	ff 45 f0             	incl   -0x10(%ebp)
  8004c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004c7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004ca:	0f 8c 30 ff ff ff    	jl     800400 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8004d0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004d7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004de:	eb 27                	jmp    800507 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8004e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004e5:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8004eb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004ee:	89 d0                	mov    %edx,%eax
  8004f0:	c1 e0 02             	shl    $0x2,%eax
  8004f3:	01 d0                	add    %edx,%eax
  8004f5:	c1 e0 02             	shl    $0x2,%eax
  8004f8:	01 c8                	add    %ecx,%eax
  8004fa:	8a 40 04             	mov    0x4(%eax),%al
  8004fd:	3c 01                	cmp    $0x1,%al
  8004ff:	75 03                	jne    800504 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800501:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800504:	ff 45 e0             	incl   -0x20(%ebp)
  800507:	a1 20 30 80 00       	mov    0x803020,%eax
  80050c:	8b 50 74             	mov    0x74(%eax),%edx
  80050f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800512:	39 c2                	cmp    %eax,%edx
  800514:	77 ca                	ja     8004e0 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800516:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800519:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80051c:	74 14                	je     800532 <CheckWSWithoutLastIndex+0x16e>
		panic(
  80051e:	83 ec 04             	sub    $0x4,%esp
  800521:	68 f0 22 80 00       	push   $0x8022f0
  800526:	6a 44                	push   $0x44
  800528:	68 90 22 80 00       	push   $0x802290
  80052d:	e8 20 fe ff ff       	call   800352 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800532:	90                   	nop
  800533:	c9                   	leave  
  800534:	c3                   	ret    

00800535 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800535:	55                   	push   %ebp
  800536:	89 e5                	mov    %esp,%ebp
  800538:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80053b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80053e:	8b 00                	mov    (%eax),%eax
  800540:	8d 48 01             	lea    0x1(%eax),%ecx
  800543:	8b 55 0c             	mov    0xc(%ebp),%edx
  800546:	89 0a                	mov    %ecx,(%edx)
  800548:	8b 55 08             	mov    0x8(%ebp),%edx
  80054b:	88 d1                	mov    %dl,%cl
  80054d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800550:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800554:	8b 45 0c             	mov    0xc(%ebp),%eax
  800557:	8b 00                	mov    (%eax),%eax
  800559:	3d ff 00 00 00       	cmp    $0xff,%eax
  80055e:	75 2c                	jne    80058c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800560:	a0 24 30 80 00       	mov    0x803024,%al
  800565:	0f b6 c0             	movzbl %al,%eax
  800568:	8b 55 0c             	mov    0xc(%ebp),%edx
  80056b:	8b 12                	mov    (%edx),%edx
  80056d:	89 d1                	mov    %edx,%ecx
  80056f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800572:	83 c2 08             	add    $0x8,%edx
  800575:	83 ec 04             	sub    $0x4,%esp
  800578:	50                   	push   %eax
  800579:	51                   	push   %ecx
  80057a:	52                   	push   %edx
  80057b:	e8 48 12 00 00       	call   8017c8 <sys_cputs>
  800580:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800583:	8b 45 0c             	mov    0xc(%ebp),%eax
  800586:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80058c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80058f:	8b 40 04             	mov    0x4(%eax),%eax
  800592:	8d 50 01             	lea    0x1(%eax),%edx
  800595:	8b 45 0c             	mov    0xc(%ebp),%eax
  800598:	89 50 04             	mov    %edx,0x4(%eax)
}
  80059b:	90                   	nop
  80059c:	c9                   	leave  
  80059d:	c3                   	ret    

0080059e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80059e:	55                   	push   %ebp
  80059f:	89 e5                	mov    %esp,%ebp
  8005a1:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8005a7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8005ae:	00 00 00 
	b.cnt = 0;
  8005b1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8005b8:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8005bb:	ff 75 0c             	pushl  0xc(%ebp)
  8005be:	ff 75 08             	pushl  0x8(%ebp)
  8005c1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005c7:	50                   	push   %eax
  8005c8:	68 35 05 80 00       	push   $0x800535
  8005cd:	e8 11 02 00 00       	call   8007e3 <vprintfmt>
  8005d2:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005d5:	a0 24 30 80 00       	mov    0x803024,%al
  8005da:	0f b6 c0             	movzbl %al,%eax
  8005dd:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005e3:	83 ec 04             	sub    $0x4,%esp
  8005e6:	50                   	push   %eax
  8005e7:	52                   	push   %edx
  8005e8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005ee:	83 c0 08             	add    $0x8,%eax
  8005f1:	50                   	push   %eax
  8005f2:	e8 d1 11 00 00       	call   8017c8 <sys_cputs>
  8005f7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005fa:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800601:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800607:	c9                   	leave  
  800608:	c3                   	ret    

00800609 <cprintf>:

int cprintf(const char *fmt, ...) {
  800609:	55                   	push   %ebp
  80060a:	89 e5                	mov    %esp,%ebp
  80060c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80060f:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800616:	8d 45 0c             	lea    0xc(%ebp),%eax
  800619:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80061c:	8b 45 08             	mov    0x8(%ebp),%eax
  80061f:	83 ec 08             	sub    $0x8,%esp
  800622:	ff 75 f4             	pushl  -0xc(%ebp)
  800625:	50                   	push   %eax
  800626:	e8 73 ff ff ff       	call   80059e <vcprintf>
  80062b:	83 c4 10             	add    $0x10,%esp
  80062e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800631:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800634:	c9                   	leave  
  800635:	c3                   	ret    

00800636 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800636:	55                   	push   %ebp
  800637:	89 e5                	mov    %esp,%ebp
  800639:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80063c:	e8 98 13 00 00       	call   8019d9 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800641:	8d 45 0c             	lea    0xc(%ebp),%eax
  800644:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800647:	8b 45 08             	mov    0x8(%ebp),%eax
  80064a:	83 ec 08             	sub    $0x8,%esp
  80064d:	ff 75 f4             	pushl  -0xc(%ebp)
  800650:	50                   	push   %eax
  800651:	e8 48 ff ff ff       	call   80059e <vcprintf>
  800656:	83 c4 10             	add    $0x10,%esp
  800659:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80065c:	e8 92 13 00 00       	call   8019f3 <sys_enable_interrupt>
	return cnt;
  800661:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800664:	c9                   	leave  
  800665:	c3                   	ret    

00800666 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800666:	55                   	push   %ebp
  800667:	89 e5                	mov    %esp,%ebp
  800669:	53                   	push   %ebx
  80066a:	83 ec 14             	sub    $0x14,%esp
  80066d:	8b 45 10             	mov    0x10(%ebp),%eax
  800670:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800673:	8b 45 14             	mov    0x14(%ebp),%eax
  800676:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800679:	8b 45 18             	mov    0x18(%ebp),%eax
  80067c:	ba 00 00 00 00       	mov    $0x0,%edx
  800681:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800684:	77 55                	ja     8006db <printnum+0x75>
  800686:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800689:	72 05                	jb     800690 <printnum+0x2a>
  80068b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80068e:	77 4b                	ja     8006db <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800690:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800693:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800696:	8b 45 18             	mov    0x18(%ebp),%eax
  800699:	ba 00 00 00 00       	mov    $0x0,%edx
  80069e:	52                   	push   %edx
  80069f:	50                   	push   %eax
  8006a0:	ff 75 f4             	pushl  -0xc(%ebp)
  8006a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8006a6:	e8 6d 17 00 00       	call   801e18 <__udivdi3>
  8006ab:	83 c4 10             	add    $0x10,%esp
  8006ae:	83 ec 04             	sub    $0x4,%esp
  8006b1:	ff 75 20             	pushl  0x20(%ebp)
  8006b4:	53                   	push   %ebx
  8006b5:	ff 75 18             	pushl  0x18(%ebp)
  8006b8:	52                   	push   %edx
  8006b9:	50                   	push   %eax
  8006ba:	ff 75 0c             	pushl  0xc(%ebp)
  8006bd:	ff 75 08             	pushl  0x8(%ebp)
  8006c0:	e8 a1 ff ff ff       	call   800666 <printnum>
  8006c5:	83 c4 20             	add    $0x20,%esp
  8006c8:	eb 1a                	jmp    8006e4 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006ca:	83 ec 08             	sub    $0x8,%esp
  8006cd:	ff 75 0c             	pushl  0xc(%ebp)
  8006d0:	ff 75 20             	pushl  0x20(%ebp)
  8006d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d6:	ff d0                	call   *%eax
  8006d8:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006db:	ff 4d 1c             	decl   0x1c(%ebp)
  8006de:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006e2:	7f e6                	jg     8006ca <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006e4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006e7:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006f2:	53                   	push   %ebx
  8006f3:	51                   	push   %ecx
  8006f4:	52                   	push   %edx
  8006f5:	50                   	push   %eax
  8006f6:	e8 2d 18 00 00       	call   801f28 <__umoddi3>
  8006fb:	83 c4 10             	add    $0x10,%esp
  8006fe:	05 54 25 80 00       	add    $0x802554,%eax
  800703:	8a 00                	mov    (%eax),%al
  800705:	0f be c0             	movsbl %al,%eax
  800708:	83 ec 08             	sub    $0x8,%esp
  80070b:	ff 75 0c             	pushl  0xc(%ebp)
  80070e:	50                   	push   %eax
  80070f:	8b 45 08             	mov    0x8(%ebp),%eax
  800712:	ff d0                	call   *%eax
  800714:	83 c4 10             	add    $0x10,%esp
}
  800717:	90                   	nop
  800718:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80071b:	c9                   	leave  
  80071c:	c3                   	ret    

0080071d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80071d:	55                   	push   %ebp
  80071e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800720:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800724:	7e 1c                	jle    800742 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800726:	8b 45 08             	mov    0x8(%ebp),%eax
  800729:	8b 00                	mov    (%eax),%eax
  80072b:	8d 50 08             	lea    0x8(%eax),%edx
  80072e:	8b 45 08             	mov    0x8(%ebp),%eax
  800731:	89 10                	mov    %edx,(%eax)
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	8b 00                	mov    (%eax),%eax
  800738:	83 e8 08             	sub    $0x8,%eax
  80073b:	8b 50 04             	mov    0x4(%eax),%edx
  80073e:	8b 00                	mov    (%eax),%eax
  800740:	eb 40                	jmp    800782 <getuint+0x65>
	else if (lflag)
  800742:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800746:	74 1e                	je     800766 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800748:	8b 45 08             	mov    0x8(%ebp),%eax
  80074b:	8b 00                	mov    (%eax),%eax
  80074d:	8d 50 04             	lea    0x4(%eax),%edx
  800750:	8b 45 08             	mov    0x8(%ebp),%eax
  800753:	89 10                	mov    %edx,(%eax)
  800755:	8b 45 08             	mov    0x8(%ebp),%eax
  800758:	8b 00                	mov    (%eax),%eax
  80075a:	83 e8 04             	sub    $0x4,%eax
  80075d:	8b 00                	mov    (%eax),%eax
  80075f:	ba 00 00 00 00       	mov    $0x0,%edx
  800764:	eb 1c                	jmp    800782 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800766:	8b 45 08             	mov    0x8(%ebp),%eax
  800769:	8b 00                	mov    (%eax),%eax
  80076b:	8d 50 04             	lea    0x4(%eax),%edx
  80076e:	8b 45 08             	mov    0x8(%ebp),%eax
  800771:	89 10                	mov    %edx,(%eax)
  800773:	8b 45 08             	mov    0x8(%ebp),%eax
  800776:	8b 00                	mov    (%eax),%eax
  800778:	83 e8 04             	sub    $0x4,%eax
  80077b:	8b 00                	mov    (%eax),%eax
  80077d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800782:	5d                   	pop    %ebp
  800783:	c3                   	ret    

00800784 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800784:	55                   	push   %ebp
  800785:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800787:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80078b:	7e 1c                	jle    8007a9 <getint+0x25>
		return va_arg(*ap, long long);
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	8b 00                	mov    (%eax),%eax
  800792:	8d 50 08             	lea    0x8(%eax),%edx
  800795:	8b 45 08             	mov    0x8(%ebp),%eax
  800798:	89 10                	mov    %edx,(%eax)
  80079a:	8b 45 08             	mov    0x8(%ebp),%eax
  80079d:	8b 00                	mov    (%eax),%eax
  80079f:	83 e8 08             	sub    $0x8,%eax
  8007a2:	8b 50 04             	mov    0x4(%eax),%edx
  8007a5:	8b 00                	mov    (%eax),%eax
  8007a7:	eb 38                	jmp    8007e1 <getint+0x5d>
	else if (lflag)
  8007a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007ad:	74 1a                	je     8007c9 <getint+0x45>
		return va_arg(*ap, long);
  8007af:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b2:	8b 00                	mov    (%eax),%eax
  8007b4:	8d 50 04             	lea    0x4(%eax),%edx
  8007b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ba:	89 10                	mov    %edx,(%eax)
  8007bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bf:	8b 00                	mov    (%eax),%eax
  8007c1:	83 e8 04             	sub    $0x4,%eax
  8007c4:	8b 00                	mov    (%eax),%eax
  8007c6:	99                   	cltd   
  8007c7:	eb 18                	jmp    8007e1 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cc:	8b 00                	mov    (%eax),%eax
  8007ce:	8d 50 04             	lea    0x4(%eax),%edx
  8007d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d4:	89 10                	mov    %edx,(%eax)
  8007d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d9:	8b 00                	mov    (%eax),%eax
  8007db:	83 e8 04             	sub    $0x4,%eax
  8007de:	8b 00                	mov    (%eax),%eax
  8007e0:	99                   	cltd   
}
  8007e1:	5d                   	pop    %ebp
  8007e2:	c3                   	ret    

008007e3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007e3:	55                   	push   %ebp
  8007e4:	89 e5                	mov    %esp,%ebp
  8007e6:	56                   	push   %esi
  8007e7:	53                   	push   %ebx
  8007e8:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007eb:	eb 17                	jmp    800804 <vprintfmt+0x21>
			if (ch == '\0')
  8007ed:	85 db                	test   %ebx,%ebx
  8007ef:	0f 84 af 03 00 00    	je     800ba4 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007f5:	83 ec 08             	sub    $0x8,%esp
  8007f8:	ff 75 0c             	pushl  0xc(%ebp)
  8007fb:	53                   	push   %ebx
  8007fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ff:	ff d0                	call   *%eax
  800801:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800804:	8b 45 10             	mov    0x10(%ebp),%eax
  800807:	8d 50 01             	lea    0x1(%eax),%edx
  80080a:	89 55 10             	mov    %edx,0x10(%ebp)
  80080d:	8a 00                	mov    (%eax),%al
  80080f:	0f b6 d8             	movzbl %al,%ebx
  800812:	83 fb 25             	cmp    $0x25,%ebx
  800815:	75 d6                	jne    8007ed <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800817:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80081b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800822:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800829:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800830:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800837:	8b 45 10             	mov    0x10(%ebp),%eax
  80083a:	8d 50 01             	lea    0x1(%eax),%edx
  80083d:	89 55 10             	mov    %edx,0x10(%ebp)
  800840:	8a 00                	mov    (%eax),%al
  800842:	0f b6 d8             	movzbl %al,%ebx
  800845:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800848:	83 f8 55             	cmp    $0x55,%eax
  80084b:	0f 87 2b 03 00 00    	ja     800b7c <vprintfmt+0x399>
  800851:	8b 04 85 78 25 80 00 	mov    0x802578(,%eax,4),%eax
  800858:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80085a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80085e:	eb d7                	jmp    800837 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800860:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800864:	eb d1                	jmp    800837 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800866:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80086d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800870:	89 d0                	mov    %edx,%eax
  800872:	c1 e0 02             	shl    $0x2,%eax
  800875:	01 d0                	add    %edx,%eax
  800877:	01 c0                	add    %eax,%eax
  800879:	01 d8                	add    %ebx,%eax
  80087b:	83 e8 30             	sub    $0x30,%eax
  80087e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800881:	8b 45 10             	mov    0x10(%ebp),%eax
  800884:	8a 00                	mov    (%eax),%al
  800886:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800889:	83 fb 2f             	cmp    $0x2f,%ebx
  80088c:	7e 3e                	jle    8008cc <vprintfmt+0xe9>
  80088e:	83 fb 39             	cmp    $0x39,%ebx
  800891:	7f 39                	jg     8008cc <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800893:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800896:	eb d5                	jmp    80086d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800898:	8b 45 14             	mov    0x14(%ebp),%eax
  80089b:	83 c0 04             	add    $0x4,%eax
  80089e:	89 45 14             	mov    %eax,0x14(%ebp)
  8008a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a4:	83 e8 04             	sub    $0x4,%eax
  8008a7:	8b 00                	mov    (%eax),%eax
  8008a9:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008ac:	eb 1f                	jmp    8008cd <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008ae:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008b2:	79 83                	jns    800837 <vprintfmt+0x54>
				width = 0;
  8008b4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008bb:	e9 77 ff ff ff       	jmp    800837 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008c0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008c7:	e9 6b ff ff ff       	jmp    800837 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008cc:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008cd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008d1:	0f 89 60 ff ff ff    	jns    800837 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008dd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008e4:	e9 4e ff ff ff       	jmp    800837 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008e9:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008ec:	e9 46 ff ff ff       	jmp    800837 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f4:	83 c0 04             	add    $0x4,%eax
  8008f7:	89 45 14             	mov    %eax,0x14(%ebp)
  8008fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8008fd:	83 e8 04             	sub    $0x4,%eax
  800900:	8b 00                	mov    (%eax),%eax
  800902:	83 ec 08             	sub    $0x8,%esp
  800905:	ff 75 0c             	pushl  0xc(%ebp)
  800908:	50                   	push   %eax
  800909:	8b 45 08             	mov    0x8(%ebp),%eax
  80090c:	ff d0                	call   *%eax
  80090e:	83 c4 10             	add    $0x10,%esp
			break;
  800911:	e9 89 02 00 00       	jmp    800b9f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800916:	8b 45 14             	mov    0x14(%ebp),%eax
  800919:	83 c0 04             	add    $0x4,%eax
  80091c:	89 45 14             	mov    %eax,0x14(%ebp)
  80091f:	8b 45 14             	mov    0x14(%ebp),%eax
  800922:	83 e8 04             	sub    $0x4,%eax
  800925:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800927:	85 db                	test   %ebx,%ebx
  800929:	79 02                	jns    80092d <vprintfmt+0x14a>
				err = -err;
  80092b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80092d:	83 fb 64             	cmp    $0x64,%ebx
  800930:	7f 0b                	jg     80093d <vprintfmt+0x15a>
  800932:	8b 34 9d c0 23 80 00 	mov    0x8023c0(,%ebx,4),%esi
  800939:	85 f6                	test   %esi,%esi
  80093b:	75 19                	jne    800956 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80093d:	53                   	push   %ebx
  80093e:	68 65 25 80 00       	push   $0x802565
  800943:	ff 75 0c             	pushl  0xc(%ebp)
  800946:	ff 75 08             	pushl  0x8(%ebp)
  800949:	e8 5e 02 00 00       	call   800bac <printfmt>
  80094e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800951:	e9 49 02 00 00       	jmp    800b9f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800956:	56                   	push   %esi
  800957:	68 6e 25 80 00       	push   $0x80256e
  80095c:	ff 75 0c             	pushl  0xc(%ebp)
  80095f:	ff 75 08             	pushl  0x8(%ebp)
  800962:	e8 45 02 00 00       	call   800bac <printfmt>
  800967:	83 c4 10             	add    $0x10,%esp
			break;
  80096a:	e9 30 02 00 00       	jmp    800b9f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80096f:	8b 45 14             	mov    0x14(%ebp),%eax
  800972:	83 c0 04             	add    $0x4,%eax
  800975:	89 45 14             	mov    %eax,0x14(%ebp)
  800978:	8b 45 14             	mov    0x14(%ebp),%eax
  80097b:	83 e8 04             	sub    $0x4,%eax
  80097e:	8b 30                	mov    (%eax),%esi
  800980:	85 f6                	test   %esi,%esi
  800982:	75 05                	jne    800989 <vprintfmt+0x1a6>
				p = "(null)";
  800984:	be 71 25 80 00       	mov    $0x802571,%esi
			if (width > 0 && padc != '-')
  800989:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80098d:	7e 6d                	jle    8009fc <vprintfmt+0x219>
  80098f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800993:	74 67                	je     8009fc <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800995:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800998:	83 ec 08             	sub    $0x8,%esp
  80099b:	50                   	push   %eax
  80099c:	56                   	push   %esi
  80099d:	e8 0c 03 00 00       	call   800cae <strnlen>
  8009a2:	83 c4 10             	add    $0x10,%esp
  8009a5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009a8:	eb 16                	jmp    8009c0 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009aa:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009ae:	83 ec 08             	sub    $0x8,%esp
  8009b1:	ff 75 0c             	pushl  0xc(%ebp)
  8009b4:	50                   	push   %eax
  8009b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b8:	ff d0                	call   *%eax
  8009ba:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009bd:	ff 4d e4             	decl   -0x1c(%ebp)
  8009c0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009c4:	7f e4                	jg     8009aa <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009c6:	eb 34                	jmp    8009fc <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009c8:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009cc:	74 1c                	je     8009ea <vprintfmt+0x207>
  8009ce:	83 fb 1f             	cmp    $0x1f,%ebx
  8009d1:	7e 05                	jle    8009d8 <vprintfmt+0x1f5>
  8009d3:	83 fb 7e             	cmp    $0x7e,%ebx
  8009d6:	7e 12                	jle    8009ea <vprintfmt+0x207>
					putch('?', putdat);
  8009d8:	83 ec 08             	sub    $0x8,%esp
  8009db:	ff 75 0c             	pushl  0xc(%ebp)
  8009de:	6a 3f                	push   $0x3f
  8009e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e3:	ff d0                	call   *%eax
  8009e5:	83 c4 10             	add    $0x10,%esp
  8009e8:	eb 0f                	jmp    8009f9 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009ea:	83 ec 08             	sub    $0x8,%esp
  8009ed:	ff 75 0c             	pushl  0xc(%ebp)
  8009f0:	53                   	push   %ebx
  8009f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f4:	ff d0                	call   *%eax
  8009f6:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009f9:	ff 4d e4             	decl   -0x1c(%ebp)
  8009fc:	89 f0                	mov    %esi,%eax
  8009fe:	8d 70 01             	lea    0x1(%eax),%esi
  800a01:	8a 00                	mov    (%eax),%al
  800a03:	0f be d8             	movsbl %al,%ebx
  800a06:	85 db                	test   %ebx,%ebx
  800a08:	74 24                	je     800a2e <vprintfmt+0x24b>
  800a0a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a0e:	78 b8                	js     8009c8 <vprintfmt+0x1e5>
  800a10:	ff 4d e0             	decl   -0x20(%ebp)
  800a13:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a17:	79 af                	jns    8009c8 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a19:	eb 13                	jmp    800a2e <vprintfmt+0x24b>
				putch(' ', putdat);
  800a1b:	83 ec 08             	sub    $0x8,%esp
  800a1e:	ff 75 0c             	pushl  0xc(%ebp)
  800a21:	6a 20                	push   $0x20
  800a23:	8b 45 08             	mov    0x8(%ebp),%eax
  800a26:	ff d0                	call   *%eax
  800a28:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a2b:	ff 4d e4             	decl   -0x1c(%ebp)
  800a2e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a32:	7f e7                	jg     800a1b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a34:	e9 66 01 00 00       	jmp    800b9f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a39:	83 ec 08             	sub    $0x8,%esp
  800a3c:	ff 75 e8             	pushl  -0x18(%ebp)
  800a3f:	8d 45 14             	lea    0x14(%ebp),%eax
  800a42:	50                   	push   %eax
  800a43:	e8 3c fd ff ff       	call   800784 <getint>
  800a48:	83 c4 10             	add    $0x10,%esp
  800a4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a4e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a51:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a54:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a57:	85 d2                	test   %edx,%edx
  800a59:	79 23                	jns    800a7e <vprintfmt+0x29b>
				putch('-', putdat);
  800a5b:	83 ec 08             	sub    $0x8,%esp
  800a5e:	ff 75 0c             	pushl  0xc(%ebp)
  800a61:	6a 2d                	push   $0x2d
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	ff d0                	call   *%eax
  800a68:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a6e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a71:	f7 d8                	neg    %eax
  800a73:	83 d2 00             	adc    $0x0,%edx
  800a76:	f7 da                	neg    %edx
  800a78:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a7b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a7e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a85:	e9 bc 00 00 00       	jmp    800b46 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a8a:	83 ec 08             	sub    $0x8,%esp
  800a8d:	ff 75 e8             	pushl  -0x18(%ebp)
  800a90:	8d 45 14             	lea    0x14(%ebp),%eax
  800a93:	50                   	push   %eax
  800a94:	e8 84 fc ff ff       	call   80071d <getuint>
  800a99:	83 c4 10             	add    $0x10,%esp
  800a9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a9f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800aa2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800aa9:	e9 98 00 00 00       	jmp    800b46 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800aae:	83 ec 08             	sub    $0x8,%esp
  800ab1:	ff 75 0c             	pushl  0xc(%ebp)
  800ab4:	6a 58                	push   $0x58
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	ff d0                	call   *%eax
  800abb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800abe:	83 ec 08             	sub    $0x8,%esp
  800ac1:	ff 75 0c             	pushl  0xc(%ebp)
  800ac4:	6a 58                	push   $0x58
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	ff d0                	call   *%eax
  800acb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ace:	83 ec 08             	sub    $0x8,%esp
  800ad1:	ff 75 0c             	pushl  0xc(%ebp)
  800ad4:	6a 58                	push   $0x58
  800ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad9:	ff d0                	call   *%eax
  800adb:	83 c4 10             	add    $0x10,%esp
			break;
  800ade:	e9 bc 00 00 00       	jmp    800b9f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ae3:	83 ec 08             	sub    $0x8,%esp
  800ae6:	ff 75 0c             	pushl  0xc(%ebp)
  800ae9:	6a 30                	push   $0x30
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	ff d0                	call   *%eax
  800af0:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800af3:	83 ec 08             	sub    $0x8,%esp
  800af6:	ff 75 0c             	pushl  0xc(%ebp)
  800af9:	6a 78                	push   $0x78
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	ff d0                	call   *%eax
  800b00:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b03:	8b 45 14             	mov    0x14(%ebp),%eax
  800b06:	83 c0 04             	add    $0x4,%eax
  800b09:	89 45 14             	mov    %eax,0x14(%ebp)
  800b0c:	8b 45 14             	mov    0x14(%ebp),%eax
  800b0f:	83 e8 04             	sub    $0x4,%eax
  800b12:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b14:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b1e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b25:	eb 1f                	jmp    800b46 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b27:	83 ec 08             	sub    $0x8,%esp
  800b2a:	ff 75 e8             	pushl  -0x18(%ebp)
  800b2d:	8d 45 14             	lea    0x14(%ebp),%eax
  800b30:	50                   	push   %eax
  800b31:	e8 e7 fb ff ff       	call   80071d <getuint>
  800b36:	83 c4 10             	add    $0x10,%esp
  800b39:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b3c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b3f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b46:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b4a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b4d:	83 ec 04             	sub    $0x4,%esp
  800b50:	52                   	push   %edx
  800b51:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b54:	50                   	push   %eax
  800b55:	ff 75 f4             	pushl  -0xc(%ebp)
  800b58:	ff 75 f0             	pushl  -0x10(%ebp)
  800b5b:	ff 75 0c             	pushl  0xc(%ebp)
  800b5e:	ff 75 08             	pushl  0x8(%ebp)
  800b61:	e8 00 fb ff ff       	call   800666 <printnum>
  800b66:	83 c4 20             	add    $0x20,%esp
			break;
  800b69:	eb 34                	jmp    800b9f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b6b:	83 ec 08             	sub    $0x8,%esp
  800b6e:	ff 75 0c             	pushl  0xc(%ebp)
  800b71:	53                   	push   %ebx
  800b72:	8b 45 08             	mov    0x8(%ebp),%eax
  800b75:	ff d0                	call   *%eax
  800b77:	83 c4 10             	add    $0x10,%esp
			break;
  800b7a:	eb 23                	jmp    800b9f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b7c:	83 ec 08             	sub    $0x8,%esp
  800b7f:	ff 75 0c             	pushl  0xc(%ebp)
  800b82:	6a 25                	push   $0x25
  800b84:	8b 45 08             	mov    0x8(%ebp),%eax
  800b87:	ff d0                	call   *%eax
  800b89:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b8c:	ff 4d 10             	decl   0x10(%ebp)
  800b8f:	eb 03                	jmp    800b94 <vprintfmt+0x3b1>
  800b91:	ff 4d 10             	decl   0x10(%ebp)
  800b94:	8b 45 10             	mov    0x10(%ebp),%eax
  800b97:	48                   	dec    %eax
  800b98:	8a 00                	mov    (%eax),%al
  800b9a:	3c 25                	cmp    $0x25,%al
  800b9c:	75 f3                	jne    800b91 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b9e:	90                   	nop
		}
	}
  800b9f:	e9 47 fc ff ff       	jmp    8007eb <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ba4:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ba5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ba8:	5b                   	pop    %ebx
  800ba9:	5e                   	pop    %esi
  800baa:	5d                   	pop    %ebp
  800bab:	c3                   	ret    

00800bac <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800bac:	55                   	push   %ebp
  800bad:	89 e5                	mov    %esp,%ebp
  800baf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800bb2:	8d 45 10             	lea    0x10(%ebp),%eax
  800bb5:	83 c0 04             	add    $0x4,%eax
  800bb8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800bbb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbe:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc1:	50                   	push   %eax
  800bc2:	ff 75 0c             	pushl  0xc(%ebp)
  800bc5:	ff 75 08             	pushl  0x8(%ebp)
  800bc8:	e8 16 fc ff ff       	call   8007e3 <vprintfmt>
  800bcd:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bd0:	90                   	nop
  800bd1:	c9                   	leave  
  800bd2:	c3                   	ret    

00800bd3 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bd3:	55                   	push   %ebp
  800bd4:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd9:	8b 40 08             	mov    0x8(%eax),%eax
  800bdc:	8d 50 01             	lea    0x1(%eax),%edx
  800bdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be2:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800be5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be8:	8b 10                	mov    (%eax),%edx
  800bea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bed:	8b 40 04             	mov    0x4(%eax),%eax
  800bf0:	39 c2                	cmp    %eax,%edx
  800bf2:	73 12                	jae    800c06 <sprintputch+0x33>
		*b->buf++ = ch;
  800bf4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf7:	8b 00                	mov    (%eax),%eax
  800bf9:	8d 48 01             	lea    0x1(%eax),%ecx
  800bfc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bff:	89 0a                	mov    %ecx,(%edx)
  800c01:	8b 55 08             	mov    0x8(%ebp),%edx
  800c04:	88 10                	mov    %dl,(%eax)
}
  800c06:	90                   	nop
  800c07:	5d                   	pop    %ebp
  800c08:	c3                   	ret    

00800c09 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c09:	55                   	push   %ebp
  800c0a:	89 e5                	mov    %esp,%ebp
  800c0c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c12:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c18:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	01 d0                	add    %edx,%eax
  800c20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c23:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c2a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c2e:	74 06                	je     800c36 <vsnprintf+0x2d>
  800c30:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c34:	7f 07                	jg     800c3d <vsnprintf+0x34>
		return -E_INVAL;
  800c36:	b8 03 00 00 00       	mov    $0x3,%eax
  800c3b:	eb 20                	jmp    800c5d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c3d:	ff 75 14             	pushl  0x14(%ebp)
  800c40:	ff 75 10             	pushl  0x10(%ebp)
  800c43:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c46:	50                   	push   %eax
  800c47:	68 d3 0b 80 00       	push   $0x800bd3
  800c4c:	e8 92 fb ff ff       	call   8007e3 <vprintfmt>
  800c51:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c54:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c57:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c5d:	c9                   	leave  
  800c5e:	c3                   	ret    

00800c5f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c5f:	55                   	push   %ebp
  800c60:	89 e5                	mov    %esp,%ebp
  800c62:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c65:	8d 45 10             	lea    0x10(%ebp),%eax
  800c68:	83 c0 04             	add    $0x4,%eax
  800c6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c6e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c71:	ff 75 f4             	pushl  -0xc(%ebp)
  800c74:	50                   	push   %eax
  800c75:	ff 75 0c             	pushl  0xc(%ebp)
  800c78:	ff 75 08             	pushl  0x8(%ebp)
  800c7b:	e8 89 ff ff ff       	call   800c09 <vsnprintf>
  800c80:	83 c4 10             	add    $0x10,%esp
  800c83:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c86:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c89:	c9                   	leave  
  800c8a:	c3                   	ret    

00800c8b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c8b:	55                   	push   %ebp
  800c8c:	89 e5                	mov    %esp,%ebp
  800c8e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c91:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c98:	eb 06                	jmp    800ca0 <strlen+0x15>
		n++;
  800c9a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c9d:	ff 45 08             	incl   0x8(%ebp)
  800ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca3:	8a 00                	mov    (%eax),%al
  800ca5:	84 c0                	test   %al,%al
  800ca7:	75 f1                	jne    800c9a <strlen+0xf>
		n++;
	return n;
  800ca9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cac:	c9                   	leave  
  800cad:	c3                   	ret    

00800cae <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800cae:	55                   	push   %ebp
  800caf:	89 e5                	mov    %esp,%ebp
  800cb1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cb4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cbb:	eb 09                	jmp    800cc6 <strnlen+0x18>
		n++;
  800cbd:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cc0:	ff 45 08             	incl   0x8(%ebp)
  800cc3:	ff 4d 0c             	decl   0xc(%ebp)
  800cc6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cca:	74 09                	je     800cd5 <strnlen+0x27>
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	8a 00                	mov    (%eax),%al
  800cd1:	84 c0                	test   %al,%al
  800cd3:	75 e8                	jne    800cbd <strnlen+0xf>
		n++;
	return n;
  800cd5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cd8:	c9                   	leave  
  800cd9:	c3                   	ret    

00800cda <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cda:	55                   	push   %ebp
  800cdb:	89 e5                	mov    %esp,%ebp
  800cdd:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ce6:	90                   	nop
  800ce7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cea:	8d 50 01             	lea    0x1(%eax),%edx
  800ced:	89 55 08             	mov    %edx,0x8(%ebp)
  800cf0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cf6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cf9:	8a 12                	mov    (%edx),%dl
  800cfb:	88 10                	mov    %dl,(%eax)
  800cfd:	8a 00                	mov    (%eax),%al
  800cff:	84 c0                	test   %al,%al
  800d01:	75 e4                	jne    800ce7 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d03:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d06:	c9                   	leave  
  800d07:	c3                   	ret    

00800d08 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d08:	55                   	push   %ebp
  800d09:	89 e5                	mov    %esp,%ebp
  800d0b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d11:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d1b:	eb 1f                	jmp    800d3c <strncpy+0x34>
		*dst++ = *src;
  800d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d20:	8d 50 01             	lea    0x1(%eax),%edx
  800d23:	89 55 08             	mov    %edx,0x8(%ebp)
  800d26:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d29:	8a 12                	mov    (%edx),%dl
  800d2b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d30:	8a 00                	mov    (%eax),%al
  800d32:	84 c0                	test   %al,%al
  800d34:	74 03                	je     800d39 <strncpy+0x31>
			src++;
  800d36:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d39:	ff 45 fc             	incl   -0x4(%ebp)
  800d3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d3f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d42:	72 d9                	jb     800d1d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d44:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d47:	c9                   	leave  
  800d48:	c3                   	ret    

00800d49 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d49:	55                   	push   %ebp
  800d4a:	89 e5                	mov    %esp,%ebp
  800d4c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d55:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d59:	74 30                	je     800d8b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d5b:	eb 16                	jmp    800d73 <strlcpy+0x2a>
			*dst++ = *src++;
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	8d 50 01             	lea    0x1(%eax),%edx
  800d63:	89 55 08             	mov    %edx,0x8(%ebp)
  800d66:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d69:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d6c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d6f:	8a 12                	mov    (%edx),%dl
  800d71:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d73:	ff 4d 10             	decl   0x10(%ebp)
  800d76:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d7a:	74 09                	je     800d85 <strlcpy+0x3c>
  800d7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7f:	8a 00                	mov    (%eax),%al
  800d81:	84 c0                	test   %al,%al
  800d83:	75 d8                	jne    800d5d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d8b:	8b 55 08             	mov    0x8(%ebp),%edx
  800d8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d91:	29 c2                	sub    %eax,%edx
  800d93:	89 d0                	mov    %edx,%eax
}
  800d95:	c9                   	leave  
  800d96:	c3                   	ret    

00800d97 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d97:	55                   	push   %ebp
  800d98:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d9a:	eb 06                	jmp    800da2 <strcmp+0xb>
		p++, q++;
  800d9c:	ff 45 08             	incl   0x8(%ebp)
  800d9f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	8a 00                	mov    (%eax),%al
  800da7:	84 c0                	test   %al,%al
  800da9:	74 0e                	je     800db9 <strcmp+0x22>
  800dab:	8b 45 08             	mov    0x8(%ebp),%eax
  800dae:	8a 10                	mov    (%eax),%dl
  800db0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db3:	8a 00                	mov    (%eax),%al
  800db5:	38 c2                	cmp    %al,%dl
  800db7:	74 e3                	je     800d9c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800db9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbc:	8a 00                	mov    (%eax),%al
  800dbe:	0f b6 d0             	movzbl %al,%edx
  800dc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc4:	8a 00                	mov    (%eax),%al
  800dc6:	0f b6 c0             	movzbl %al,%eax
  800dc9:	29 c2                	sub    %eax,%edx
  800dcb:	89 d0                	mov    %edx,%eax
}
  800dcd:	5d                   	pop    %ebp
  800dce:	c3                   	ret    

00800dcf <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800dcf:	55                   	push   %ebp
  800dd0:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800dd2:	eb 09                	jmp    800ddd <strncmp+0xe>
		n--, p++, q++;
  800dd4:	ff 4d 10             	decl   0x10(%ebp)
  800dd7:	ff 45 08             	incl   0x8(%ebp)
  800dda:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ddd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800de1:	74 17                	je     800dfa <strncmp+0x2b>
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	8a 00                	mov    (%eax),%al
  800de8:	84 c0                	test   %al,%al
  800dea:	74 0e                	je     800dfa <strncmp+0x2b>
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
  800def:	8a 10                	mov    (%eax),%dl
  800df1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df4:	8a 00                	mov    (%eax),%al
  800df6:	38 c2                	cmp    %al,%dl
  800df8:	74 da                	je     800dd4 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800dfa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dfe:	75 07                	jne    800e07 <strncmp+0x38>
		return 0;
  800e00:	b8 00 00 00 00       	mov    $0x0,%eax
  800e05:	eb 14                	jmp    800e1b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	8a 00                	mov    (%eax),%al
  800e0c:	0f b6 d0             	movzbl %al,%edx
  800e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e12:	8a 00                	mov    (%eax),%al
  800e14:	0f b6 c0             	movzbl %al,%eax
  800e17:	29 c2                	sub    %eax,%edx
  800e19:	89 d0                	mov    %edx,%eax
}
  800e1b:	5d                   	pop    %ebp
  800e1c:	c3                   	ret    

00800e1d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e1d:	55                   	push   %ebp
  800e1e:	89 e5                	mov    %esp,%ebp
  800e20:	83 ec 04             	sub    $0x4,%esp
  800e23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e26:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e29:	eb 12                	jmp    800e3d <strchr+0x20>
		if (*s == c)
  800e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2e:	8a 00                	mov    (%eax),%al
  800e30:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e33:	75 05                	jne    800e3a <strchr+0x1d>
			return (char *) s;
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	eb 11                	jmp    800e4b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e3a:	ff 45 08             	incl   0x8(%ebp)
  800e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e40:	8a 00                	mov    (%eax),%al
  800e42:	84 c0                	test   %al,%al
  800e44:	75 e5                	jne    800e2b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e46:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e4b:	c9                   	leave  
  800e4c:	c3                   	ret    

00800e4d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e4d:	55                   	push   %ebp
  800e4e:	89 e5                	mov    %esp,%ebp
  800e50:	83 ec 04             	sub    $0x4,%esp
  800e53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e56:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e59:	eb 0d                	jmp    800e68 <strfind+0x1b>
		if (*s == c)
  800e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5e:	8a 00                	mov    (%eax),%al
  800e60:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e63:	74 0e                	je     800e73 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e65:	ff 45 08             	incl   0x8(%ebp)
  800e68:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6b:	8a 00                	mov    (%eax),%al
  800e6d:	84 c0                	test   %al,%al
  800e6f:	75 ea                	jne    800e5b <strfind+0xe>
  800e71:	eb 01                	jmp    800e74 <strfind+0x27>
		if (*s == c)
			break;
  800e73:	90                   	nop
	return (char *) s;
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e77:	c9                   	leave  
  800e78:	c3                   	ret    

00800e79 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e79:	55                   	push   %ebp
  800e7a:	89 e5                	mov    %esp,%ebp
  800e7c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e82:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e85:	8b 45 10             	mov    0x10(%ebp),%eax
  800e88:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e8b:	eb 0e                	jmp    800e9b <memset+0x22>
		*p++ = c;
  800e8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e90:	8d 50 01             	lea    0x1(%eax),%edx
  800e93:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e96:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e99:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e9b:	ff 4d f8             	decl   -0x8(%ebp)
  800e9e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ea2:	79 e9                	jns    800e8d <memset+0x14>
		*p++ = c;

	return v;
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ea7:	c9                   	leave  
  800ea8:	c3                   	ret    

00800ea9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ea9:	55                   	push   %ebp
  800eaa:	89 e5                	mov    %esp,%ebp
  800eac:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800eaf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ebb:	eb 16                	jmp    800ed3 <memcpy+0x2a>
		*d++ = *s++;
  800ebd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ec0:	8d 50 01             	lea    0x1(%eax),%edx
  800ec3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ec6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ec9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ecc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ecf:	8a 12                	mov    (%edx),%dl
  800ed1:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ed3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ed9:	89 55 10             	mov    %edx,0x10(%ebp)
  800edc:	85 c0                	test   %eax,%eax
  800ede:	75 dd                	jne    800ebd <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ee0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee3:	c9                   	leave  
  800ee4:	c3                   	ret    

00800ee5 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ee5:	55                   	push   %ebp
  800ee6:	89 e5                	mov    %esp,%ebp
  800ee8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800eeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ef1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ef7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800efa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800efd:	73 50                	jae    800f4f <memmove+0x6a>
  800eff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f02:	8b 45 10             	mov    0x10(%ebp),%eax
  800f05:	01 d0                	add    %edx,%eax
  800f07:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f0a:	76 43                	jbe    800f4f <memmove+0x6a>
		s += n;
  800f0c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f12:	8b 45 10             	mov    0x10(%ebp),%eax
  800f15:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f18:	eb 10                	jmp    800f2a <memmove+0x45>
			*--d = *--s;
  800f1a:	ff 4d f8             	decl   -0x8(%ebp)
  800f1d:	ff 4d fc             	decl   -0x4(%ebp)
  800f20:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f23:	8a 10                	mov    (%eax),%dl
  800f25:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f28:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f30:	89 55 10             	mov    %edx,0x10(%ebp)
  800f33:	85 c0                	test   %eax,%eax
  800f35:	75 e3                	jne    800f1a <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f37:	eb 23                	jmp    800f5c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f39:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f3c:	8d 50 01             	lea    0x1(%eax),%edx
  800f3f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f42:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f45:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f48:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f4b:	8a 12                	mov    (%edx),%dl
  800f4d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f52:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f55:	89 55 10             	mov    %edx,0x10(%ebp)
  800f58:	85 c0                	test   %eax,%eax
  800f5a:	75 dd                	jne    800f39 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f5f:	c9                   	leave  
  800f60:	c3                   	ret    

00800f61 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f61:	55                   	push   %ebp
  800f62:	89 e5                	mov    %esp,%ebp
  800f64:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f67:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f70:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f73:	eb 2a                	jmp    800f9f <memcmp+0x3e>
		if (*s1 != *s2)
  800f75:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f78:	8a 10                	mov    (%eax),%dl
  800f7a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f7d:	8a 00                	mov    (%eax),%al
  800f7f:	38 c2                	cmp    %al,%dl
  800f81:	74 16                	je     800f99 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f83:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f86:	8a 00                	mov    (%eax),%al
  800f88:	0f b6 d0             	movzbl %al,%edx
  800f8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f8e:	8a 00                	mov    (%eax),%al
  800f90:	0f b6 c0             	movzbl %al,%eax
  800f93:	29 c2                	sub    %eax,%edx
  800f95:	89 d0                	mov    %edx,%eax
  800f97:	eb 18                	jmp    800fb1 <memcmp+0x50>
		s1++, s2++;
  800f99:	ff 45 fc             	incl   -0x4(%ebp)
  800f9c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fa5:	89 55 10             	mov    %edx,0x10(%ebp)
  800fa8:	85 c0                	test   %eax,%eax
  800faa:	75 c9                	jne    800f75 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800fac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fb1:	c9                   	leave  
  800fb2:	c3                   	ret    

00800fb3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800fb3:	55                   	push   %ebp
  800fb4:	89 e5                	mov    %esp,%ebp
  800fb6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800fb9:	8b 55 08             	mov    0x8(%ebp),%edx
  800fbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbf:	01 d0                	add    %edx,%eax
  800fc1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800fc4:	eb 15                	jmp    800fdb <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc9:	8a 00                	mov    (%eax),%al
  800fcb:	0f b6 d0             	movzbl %al,%edx
  800fce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd1:	0f b6 c0             	movzbl %al,%eax
  800fd4:	39 c2                	cmp    %eax,%edx
  800fd6:	74 0d                	je     800fe5 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800fd8:	ff 45 08             	incl   0x8(%ebp)
  800fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fde:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fe1:	72 e3                	jb     800fc6 <memfind+0x13>
  800fe3:	eb 01                	jmp    800fe6 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fe5:	90                   	nop
	return (void *) s;
  800fe6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fe9:	c9                   	leave  
  800fea:	c3                   	ret    

00800feb <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800feb:	55                   	push   %ebp
  800fec:	89 e5                	mov    %esp,%ebp
  800fee:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ff1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ff8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fff:	eb 03                	jmp    801004 <strtol+0x19>
		s++;
  801001:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801004:	8b 45 08             	mov    0x8(%ebp),%eax
  801007:	8a 00                	mov    (%eax),%al
  801009:	3c 20                	cmp    $0x20,%al
  80100b:	74 f4                	je     801001 <strtol+0x16>
  80100d:	8b 45 08             	mov    0x8(%ebp),%eax
  801010:	8a 00                	mov    (%eax),%al
  801012:	3c 09                	cmp    $0x9,%al
  801014:	74 eb                	je     801001 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801016:	8b 45 08             	mov    0x8(%ebp),%eax
  801019:	8a 00                	mov    (%eax),%al
  80101b:	3c 2b                	cmp    $0x2b,%al
  80101d:	75 05                	jne    801024 <strtol+0x39>
		s++;
  80101f:	ff 45 08             	incl   0x8(%ebp)
  801022:	eb 13                	jmp    801037 <strtol+0x4c>
	else if (*s == '-')
  801024:	8b 45 08             	mov    0x8(%ebp),%eax
  801027:	8a 00                	mov    (%eax),%al
  801029:	3c 2d                	cmp    $0x2d,%al
  80102b:	75 0a                	jne    801037 <strtol+0x4c>
		s++, neg = 1;
  80102d:	ff 45 08             	incl   0x8(%ebp)
  801030:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801037:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80103b:	74 06                	je     801043 <strtol+0x58>
  80103d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801041:	75 20                	jne    801063 <strtol+0x78>
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
  801046:	8a 00                	mov    (%eax),%al
  801048:	3c 30                	cmp    $0x30,%al
  80104a:	75 17                	jne    801063 <strtol+0x78>
  80104c:	8b 45 08             	mov    0x8(%ebp),%eax
  80104f:	40                   	inc    %eax
  801050:	8a 00                	mov    (%eax),%al
  801052:	3c 78                	cmp    $0x78,%al
  801054:	75 0d                	jne    801063 <strtol+0x78>
		s += 2, base = 16;
  801056:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80105a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801061:	eb 28                	jmp    80108b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801063:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801067:	75 15                	jne    80107e <strtol+0x93>
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	8a 00                	mov    (%eax),%al
  80106e:	3c 30                	cmp    $0x30,%al
  801070:	75 0c                	jne    80107e <strtol+0x93>
		s++, base = 8;
  801072:	ff 45 08             	incl   0x8(%ebp)
  801075:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80107c:	eb 0d                	jmp    80108b <strtol+0xa0>
	else if (base == 0)
  80107e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801082:	75 07                	jne    80108b <strtol+0xa0>
		base = 10;
  801084:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80108b:	8b 45 08             	mov    0x8(%ebp),%eax
  80108e:	8a 00                	mov    (%eax),%al
  801090:	3c 2f                	cmp    $0x2f,%al
  801092:	7e 19                	jle    8010ad <strtol+0xc2>
  801094:	8b 45 08             	mov    0x8(%ebp),%eax
  801097:	8a 00                	mov    (%eax),%al
  801099:	3c 39                	cmp    $0x39,%al
  80109b:	7f 10                	jg     8010ad <strtol+0xc2>
			dig = *s - '0';
  80109d:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a0:	8a 00                	mov    (%eax),%al
  8010a2:	0f be c0             	movsbl %al,%eax
  8010a5:	83 e8 30             	sub    $0x30,%eax
  8010a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010ab:	eb 42                	jmp    8010ef <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	8a 00                	mov    (%eax),%al
  8010b2:	3c 60                	cmp    $0x60,%al
  8010b4:	7e 19                	jle    8010cf <strtol+0xe4>
  8010b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b9:	8a 00                	mov    (%eax),%al
  8010bb:	3c 7a                	cmp    $0x7a,%al
  8010bd:	7f 10                	jg     8010cf <strtol+0xe4>
			dig = *s - 'a' + 10;
  8010bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c2:	8a 00                	mov    (%eax),%al
  8010c4:	0f be c0             	movsbl %al,%eax
  8010c7:	83 e8 57             	sub    $0x57,%eax
  8010ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010cd:	eb 20                	jmp    8010ef <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	8a 00                	mov    (%eax),%al
  8010d4:	3c 40                	cmp    $0x40,%al
  8010d6:	7e 39                	jle    801111 <strtol+0x126>
  8010d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010db:	8a 00                	mov    (%eax),%al
  8010dd:	3c 5a                	cmp    $0x5a,%al
  8010df:	7f 30                	jg     801111 <strtol+0x126>
			dig = *s - 'A' + 10;
  8010e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e4:	8a 00                	mov    (%eax),%al
  8010e6:	0f be c0             	movsbl %al,%eax
  8010e9:	83 e8 37             	sub    $0x37,%eax
  8010ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010f2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010f5:	7d 19                	jge    801110 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010f7:	ff 45 08             	incl   0x8(%ebp)
  8010fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010fd:	0f af 45 10          	imul   0x10(%ebp),%eax
  801101:	89 c2                	mov    %eax,%edx
  801103:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801106:	01 d0                	add    %edx,%eax
  801108:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80110b:	e9 7b ff ff ff       	jmp    80108b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801110:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801111:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801115:	74 08                	je     80111f <strtol+0x134>
		*endptr = (char *) s;
  801117:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111a:	8b 55 08             	mov    0x8(%ebp),%edx
  80111d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80111f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801123:	74 07                	je     80112c <strtol+0x141>
  801125:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801128:	f7 d8                	neg    %eax
  80112a:	eb 03                	jmp    80112f <strtol+0x144>
  80112c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80112f:	c9                   	leave  
  801130:	c3                   	ret    

00801131 <ltostr>:

void
ltostr(long value, char *str)
{
  801131:	55                   	push   %ebp
  801132:	89 e5                	mov    %esp,%ebp
  801134:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801137:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80113e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801145:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801149:	79 13                	jns    80115e <ltostr+0x2d>
	{
		neg = 1;
  80114b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801152:	8b 45 0c             	mov    0xc(%ebp),%eax
  801155:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801158:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80115b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80115e:	8b 45 08             	mov    0x8(%ebp),%eax
  801161:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801166:	99                   	cltd   
  801167:	f7 f9                	idiv   %ecx
  801169:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80116c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80116f:	8d 50 01             	lea    0x1(%eax),%edx
  801172:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801175:	89 c2                	mov    %eax,%edx
  801177:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117a:	01 d0                	add    %edx,%eax
  80117c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80117f:	83 c2 30             	add    $0x30,%edx
  801182:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801184:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801187:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80118c:	f7 e9                	imul   %ecx
  80118e:	c1 fa 02             	sar    $0x2,%edx
  801191:	89 c8                	mov    %ecx,%eax
  801193:	c1 f8 1f             	sar    $0x1f,%eax
  801196:	29 c2                	sub    %eax,%edx
  801198:	89 d0                	mov    %edx,%eax
  80119a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80119d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011a0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011a5:	f7 e9                	imul   %ecx
  8011a7:	c1 fa 02             	sar    $0x2,%edx
  8011aa:	89 c8                	mov    %ecx,%eax
  8011ac:	c1 f8 1f             	sar    $0x1f,%eax
  8011af:	29 c2                	sub    %eax,%edx
  8011b1:	89 d0                	mov    %edx,%eax
  8011b3:	c1 e0 02             	shl    $0x2,%eax
  8011b6:	01 d0                	add    %edx,%eax
  8011b8:	01 c0                	add    %eax,%eax
  8011ba:	29 c1                	sub    %eax,%ecx
  8011bc:	89 ca                	mov    %ecx,%edx
  8011be:	85 d2                	test   %edx,%edx
  8011c0:	75 9c                	jne    80115e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8011c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8011c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011cc:	48                   	dec    %eax
  8011cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8011d0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011d4:	74 3d                	je     801213 <ltostr+0xe2>
		start = 1 ;
  8011d6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011dd:	eb 34                	jmp    801213 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011df:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e5:	01 d0                	add    %edx,%eax
  8011e7:	8a 00                	mov    (%eax),%al
  8011e9:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f2:	01 c2                	add    %eax,%edx
  8011f4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fa:	01 c8                	add    %ecx,%eax
  8011fc:	8a 00                	mov    (%eax),%al
  8011fe:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801200:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801203:	8b 45 0c             	mov    0xc(%ebp),%eax
  801206:	01 c2                	add    %eax,%edx
  801208:	8a 45 eb             	mov    -0x15(%ebp),%al
  80120b:	88 02                	mov    %al,(%edx)
		start++ ;
  80120d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801210:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801213:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801216:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801219:	7c c4                	jl     8011df <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80121b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80121e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801221:	01 d0                	add    %edx,%eax
  801223:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801226:	90                   	nop
  801227:	c9                   	leave  
  801228:	c3                   	ret    

00801229 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801229:	55                   	push   %ebp
  80122a:	89 e5                	mov    %esp,%ebp
  80122c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80122f:	ff 75 08             	pushl  0x8(%ebp)
  801232:	e8 54 fa ff ff       	call   800c8b <strlen>
  801237:	83 c4 04             	add    $0x4,%esp
  80123a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80123d:	ff 75 0c             	pushl  0xc(%ebp)
  801240:	e8 46 fa ff ff       	call   800c8b <strlen>
  801245:	83 c4 04             	add    $0x4,%esp
  801248:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80124b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801252:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801259:	eb 17                	jmp    801272 <strcconcat+0x49>
		final[s] = str1[s] ;
  80125b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80125e:	8b 45 10             	mov    0x10(%ebp),%eax
  801261:	01 c2                	add    %eax,%edx
  801263:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801266:	8b 45 08             	mov    0x8(%ebp),%eax
  801269:	01 c8                	add    %ecx,%eax
  80126b:	8a 00                	mov    (%eax),%al
  80126d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80126f:	ff 45 fc             	incl   -0x4(%ebp)
  801272:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801275:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801278:	7c e1                	jl     80125b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80127a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801281:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801288:	eb 1f                	jmp    8012a9 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80128a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80128d:	8d 50 01             	lea    0x1(%eax),%edx
  801290:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801293:	89 c2                	mov    %eax,%edx
  801295:	8b 45 10             	mov    0x10(%ebp),%eax
  801298:	01 c2                	add    %eax,%edx
  80129a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80129d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a0:	01 c8                	add    %ecx,%eax
  8012a2:	8a 00                	mov    (%eax),%al
  8012a4:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8012a6:	ff 45 f8             	incl   -0x8(%ebp)
  8012a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012af:	7c d9                	jl     80128a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8012b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b7:	01 d0                	add    %edx,%eax
  8012b9:	c6 00 00             	movb   $0x0,(%eax)
}
  8012bc:	90                   	nop
  8012bd:	c9                   	leave  
  8012be:	c3                   	ret    

008012bf <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8012bf:	55                   	push   %ebp
  8012c0:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8012c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8012c5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8012cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8012ce:	8b 00                	mov    (%eax),%eax
  8012d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012da:	01 d0                	add    %edx,%eax
  8012dc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012e2:	eb 0c                	jmp    8012f0 <strsplit+0x31>
			*string++ = 0;
  8012e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e7:	8d 50 01             	lea    0x1(%eax),%edx
  8012ea:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ed:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f3:	8a 00                	mov    (%eax),%al
  8012f5:	84 c0                	test   %al,%al
  8012f7:	74 18                	je     801311 <strsplit+0x52>
  8012f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fc:	8a 00                	mov    (%eax),%al
  8012fe:	0f be c0             	movsbl %al,%eax
  801301:	50                   	push   %eax
  801302:	ff 75 0c             	pushl  0xc(%ebp)
  801305:	e8 13 fb ff ff       	call   800e1d <strchr>
  80130a:	83 c4 08             	add    $0x8,%esp
  80130d:	85 c0                	test   %eax,%eax
  80130f:	75 d3                	jne    8012e4 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801311:	8b 45 08             	mov    0x8(%ebp),%eax
  801314:	8a 00                	mov    (%eax),%al
  801316:	84 c0                	test   %al,%al
  801318:	74 5a                	je     801374 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80131a:	8b 45 14             	mov    0x14(%ebp),%eax
  80131d:	8b 00                	mov    (%eax),%eax
  80131f:	83 f8 0f             	cmp    $0xf,%eax
  801322:	75 07                	jne    80132b <strsplit+0x6c>
		{
			return 0;
  801324:	b8 00 00 00 00       	mov    $0x0,%eax
  801329:	eb 66                	jmp    801391 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80132b:	8b 45 14             	mov    0x14(%ebp),%eax
  80132e:	8b 00                	mov    (%eax),%eax
  801330:	8d 48 01             	lea    0x1(%eax),%ecx
  801333:	8b 55 14             	mov    0x14(%ebp),%edx
  801336:	89 0a                	mov    %ecx,(%edx)
  801338:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80133f:	8b 45 10             	mov    0x10(%ebp),%eax
  801342:	01 c2                	add    %eax,%edx
  801344:	8b 45 08             	mov    0x8(%ebp),%eax
  801347:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801349:	eb 03                	jmp    80134e <strsplit+0x8f>
			string++;
  80134b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80134e:	8b 45 08             	mov    0x8(%ebp),%eax
  801351:	8a 00                	mov    (%eax),%al
  801353:	84 c0                	test   %al,%al
  801355:	74 8b                	je     8012e2 <strsplit+0x23>
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	8a 00                	mov    (%eax),%al
  80135c:	0f be c0             	movsbl %al,%eax
  80135f:	50                   	push   %eax
  801360:	ff 75 0c             	pushl  0xc(%ebp)
  801363:	e8 b5 fa ff ff       	call   800e1d <strchr>
  801368:	83 c4 08             	add    $0x8,%esp
  80136b:	85 c0                	test   %eax,%eax
  80136d:	74 dc                	je     80134b <strsplit+0x8c>
			string++;
	}
  80136f:	e9 6e ff ff ff       	jmp    8012e2 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801374:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801375:	8b 45 14             	mov    0x14(%ebp),%eax
  801378:	8b 00                	mov    (%eax),%eax
  80137a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801381:	8b 45 10             	mov    0x10(%ebp),%eax
  801384:	01 d0                	add    %edx,%eax
  801386:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80138c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801391:	c9                   	leave  
  801392:	c3                   	ret    

00801393 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801393:	55                   	push   %ebp
  801394:	89 e5                	mov    %esp,%ebp
  801396:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  801399:	e8 3b 09 00 00       	call   801cd9 <sys_isUHeapPlacementStrategyFIRSTFIT>
  80139e:	85 c0                	test   %eax,%eax
  8013a0:	0f 84 3a 01 00 00    	je     8014e0 <malloc+0x14d>

		if(pl == 0){
  8013a6:	a1 28 30 80 00       	mov    0x803028,%eax
  8013ab:	85 c0                	test   %eax,%eax
  8013ad:	75 24                	jne    8013d3 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  8013af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8013b6:	eb 11                	jmp    8013c9 <malloc+0x36>
				arr[k] = -10000;
  8013b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013bb:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  8013c2:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  8013c6:	ff 45 f4             	incl   -0xc(%ebp)
  8013c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013cc:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8013d1:	76 e5                	jbe    8013b8 <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  8013d3:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  8013da:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  8013dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e0:	c1 e8 0c             	shr    $0xc,%eax
  8013e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  8013e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e9:	25 ff 0f 00 00       	and    $0xfff,%eax
  8013ee:	85 c0                	test   %eax,%eax
  8013f0:	74 03                	je     8013f5 <malloc+0x62>
			x++;
  8013f2:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  8013f5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  8013fc:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801403:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80140a:	eb 66                	jmp    801472 <malloc+0xdf>
			if( arr[k] == -10000){
  80140c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80140f:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801416:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  80141b:	75 52                	jne    80146f <malloc+0xdc>
				uint32 w = 0 ;
  80141d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  801424:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801427:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  80142a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80142d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801430:	eb 09                	jmp    80143b <malloc+0xa8>
  801432:	ff 45 e0             	incl   -0x20(%ebp)
  801435:	ff 45 dc             	incl   -0x24(%ebp)
  801438:	ff 45 e4             	incl   -0x1c(%ebp)
  80143b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80143e:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801443:	77 19                	ja     80145e <malloc+0xcb>
  801445:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801448:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80144f:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801454:	75 08                	jne    80145e <malloc+0xcb>
  801456:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801459:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80145c:	72 d4                	jb     801432 <malloc+0x9f>
				if(w >= x){
  80145e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801461:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801464:	72 09                	jb     80146f <malloc+0xdc>
					p = 1 ;
  801466:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  80146d:	eb 0d                	jmp    80147c <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  80146f:	ff 45 e4             	incl   -0x1c(%ebp)
  801472:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801475:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80147a:	76 90                	jbe    80140c <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  80147c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801480:	75 0a                	jne    80148c <malloc+0xf9>
  801482:	b8 00 00 00 00       	mov    $0x0,%eax
  801487:	e9 ca 01 00 00       	jmp    801656 <malloc+0x2c3>
		int q = idx;
  80148c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80148f:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801492:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801499:	eb 16                	jmp    8014b1 <malloc+0x11e>
			arr[q++] = x;
  80149b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80149e:	8d 50 01             	lea    0x1(%eax),%edx
  8014a1:	89 55 d8             	mov    %edx,-0x28(%ebp)
  8014a4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014a7:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  8014ae:	ff 45 d4             	incl   -0x2c(%ebp)
  8014b1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8014b4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014b7:	72 e2                	jb     80149b <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  8014b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014bc:	05 00 00 08 00       	add    $0x80000,%eax
  8014c1:	c1 e0 0c             	shl    $0xc,%eax
  8014c4:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  8014c7:	83 ec 08             	sub    $0x8,%esp
  8014ca:	ff 75 f0             	pushl  -0x10(%ebp)
  8014cd:	ff 75 ac             	pushl  -0x54(%ebp)
  8014d0:	e8 9b 04 00 00       	call   801970 <sys_allocateMem>
  8014d5:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  8014d8:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8014db:	e9 76 01 00 00       	jmp    801656 <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  8014e0:	e8 25 08 00 00       	call   801d0a <sys_isUHeapPlacementStrategyBESTFIT>
  8014e5:	85 c0                	test   %eax,%eax
  8014e7:	0f 84 64 01 00 00    	je     801651 <malloc+0x2be>
		if(pl == 0){
  8014ed:	a1 28 30 80 00       	mov    0x803028,%eax
  8014f2:	85 c0                	test   %eax,%eax
  8014f4:	75 24                	jne    80151a <malloc+0x187>
			for(int k = 0; k < Size; k++){
  8014f6:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  8014fd:	eb 11                	jmp    801510 <malloc+0x17d>
				arr[k] = -10000;
  8014ff:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801502:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801509:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  80150d:	ff 45 d0             	incl   -0x30(%ebp)
  801510:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801513:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801518:	76 e5                	jbe    8014ff <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  80151a:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  801521:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801524:	8b 45 08             	mov    0x8(%ebp),%eax
  801527:	c1 e8 0c             	shr    $0xc,%eax
  80152a:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
  801530:	25 ff 0f 00 00       	and    $0xfff,%eax
  801535:	85 c0                	test   %eax,%eax
  801537:	74 03                	je     80153c <malloc+0x1a9>
			x++;
  801539:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  80153c:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801543:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  80154a:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801551:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801558:	e9 88 00 00 00       	jmp    8015e5 <malloc+0x252>
			if(arr[k] == -10000){
  80155d:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801560:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801567:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  80156c:	75 64                	jne    8015d2 <malloc+0x23f>
				uint32 w = 0 , i;
  80156e:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801575:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801578:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80157b:	eb 06                	jmp    801583 <malloc+0x1f0>
  80157d:	ff 45 b8             	incl   -0x48(%ebp)
  801580:	ff 45 b4             	incl   -0x4c(%ebp)
  801583:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  80158a:	77 11                	ja     80159d <malloc+0x20a>
  80158c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80158f:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801596:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  80159b:	74 e0                	je     80157d <malloc+0x1ea>
				if(w <q && w >= x){
  80159d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8015a0:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  8015a3:	73 24                	jae    8015c9 <malloc+0x236>
  8015a5:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8015a8:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  8015ab:	72 1c                	jb     8015c9 <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  8015ad:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8015b0:	89 45 c8             	mov    %eax,-0x38(%ebp)
  8015b3:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  8015ba:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8015bd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8015c0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8015c3:	48                   	dec    %eax
  8015c4:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8015c7:	eb 19                	jmp    8015e2 <malloc+0x24f>
				}
				else {
					k = i - 1;
  8015c9:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8015cc:	48                   	dec    %eax
  8015cd:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8015d0:	eb 10                	jmp    8015e2 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  8015d2:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8015d5:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8015dc:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  8015df:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  8015e2:	ff 45 bc             	incl   -0x44(%ebp)
  8015e5:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8015e8:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8015ed:	0f 86 6a ff ff ff    	jbe    80155d <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  8015f3:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  8015f7:	75 07                	jne    801600 <malloc+0x26d>
  8015f9:	b8 00 00 00 00       	mov    $0x0,%eax
  8015fe:	eb 56                	jmp    801656 <malloc+0x2c3>
	    q = idx;
  801600:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801603:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801606:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  80160d:	eb 16                	jmp    801625 <malloc+0x292>
			arr[q++] = x;
  80160f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801612:	8d 50 01             	lea    0x1(%eax),%edx
  801615:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801618:	8b 55 cc             	mov    -0x34(%ebp),%edx
  80161b:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801622:	ff 45 b0             	incl   -0x50(%ebp)
  801625:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801628:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  80162b:	72 e2                	jb     80160f <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  80162d:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801630:	05 00 00 08 00       	add    $0x80000,%eax
  801635:	c1 e0 0c             	shl    $0xc,%eax
  801638:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  80163b:	83 ec 08             	sub    $0x8,%esp
  80163e:	ff 75 cc             	pushl  -0x34(%ebp)
  801641:	ff 75 a8             	pushl  -0x58(%ebp)
  801644:	e8 27 03 00 00       	call   801970 <sys_allocateMem>
  801649:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  80164c:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80164f:	eb 05                	jmp    801656 <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801651:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801656:	c9                   	leave  
  801657:	c3                   	ret    

00801658 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801658:	55                   	push   %ebp
  801659:	89 e5                	mov    %esp,%ebp
  80165b:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801664:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801667:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80166c:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  80166f:	8b 45 08             	mov    0x8(%ebp),%eax
  801672:	05 00 00 00 80       	add    $0x80000000,%eax
  801677:	c1 e8 0c             	shr    $0xc,%eax
  80167a:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801681:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801684:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	05 00 00 00 80       	add    $0x80000000,%eax
  801693:	c1 e8 0c             	shr    $0xc,%eax
  801696:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801699:	eb 14                	jmp    8016af <free+0x57>
		arr[j] = -10000;
  80169b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80169e:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  8016a5:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  8016a9:	ff 45 f4             	incl   -0xc(%ebp)
  8016ac:	ff 45 f0             	incl   -0x10(%ebp)
  8016af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8016b5:	72 e4                	jb     80169b <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  8016b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ba:	83 ec 08             	sub    $0x8,%esp
  8016bd:	ff 75 e8             	pushl  -0x18(%ebp)
  8016c0:	50                   	push   %eax
  8016c1:	e8 8e 02 00 00       	call   801954 <sys_freeMem>
  8016c6:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  8016c9:	90                   	nop
  8016ca:	c9                   	leave  
  8016cb:	c3                   	ret    

008016cc <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8016cc:	55                   	push   %ebp
  8016cd:	89 e5                	mov    %esp,%ebp
  8016cf:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016d2:	83 ec 04             	sub    $0x4,%esp
  8016d5:	68 d0 26 80 00       	push   $0x8026d0
  8016da:	68 9e 00 00 00       	push   $0x9e
  8016df:	68 f3 26 80 00       	push   $0x8026f3
  8016e4:	e8 69 ec ff ff       	call   800352 <_panic>

008016e9 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8016e9:	55                   	push   %ebp
  8016ea:	89 e5                	mov    %esp,%ebp
  8016ec:	83 ec 18             	sub    $0x18,%esp
  8016ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f2:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8016f5:	83 ec 04             	sub    $0x4,%esp
  8016f8:	68 d0 26 80 00       	push   $0x8026d0
  8016fd:	68 a9 00 00 00       	push   $0xa9
  801702:	68 f3 26 80 00       	push   $0x8026f3
  801707:	e8 46 ec ff ff       	call   800352 <_panic>

0080170c <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80170c:	55                   	push   %ebp
  80170d:	89 e5                	mov    %esp,%ebp
  80170f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801712:	83 ec 04             	sub    $0x4,%esp
  801715:	68 d0 26 80 00       	push   $0x8026d0
  80171a:	68 af 00 00 00       	push   $0xaf
  80171f:	68 f3 26 80 00       	push   $0x8026f3
  801724:	e8 29 ec ff ff       	call   800352 <_panic>

00801729 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801729:	55                   	push   %ebp
  80172a:	89 e5                	mov    %esp,%ebp
  80172c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80172f:	83 ec 04             	sub    $0x4,%esp
  801732:	68 d0 26 80 00       	push   $0x8026d0
  801737:	68 b5 00 00 00       	push   $0xb5
  80173c:	68 f3 26 80 00       	push   $0x8026f3
  801741:	e8 0c ec ff ff       	call   800352 <_panic>

00801746 <expand>:
}

void expand(uint32 newSize)
{
  801746:	55                   	push   %ebp
  801747:	89 e5                	mov    %esp,%ebp
  801749:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80174c:	83 ec 04             	sub    $0x4,%esp
  80174f:	68 d0 26 80 00       	push   $0x8026d0
  801754:	68 ba 00 00 00       	push   $0xba
  801759:	68 f3 26 80 00       	push   $0x8026f3
  80175e:	e8 ef eb ff ff       	call   800352 <_panic>

00801763 <shrink>:
}
void shrink(uint32 newSize)
{
  801763:	55                   	push   %ebp
  801764:	89 e5                	mov    %esp,%ebp
  801766:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801769:	83 ec 04             	sub    $0x4,%esp
  80176c:	68 d0 26 80 00       	push   $0x8026d0
  801771:	68 be 00 00 00       	push   $0xbe
  801776:	68 f3 26 80 00       	push   $0x8026f3
  80177b:	e8 d2 eb ff ff       	call   800352 <_panic>

00801780 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801780:	55                   	push   %ebp
  801781:	89 e5                	mov    %esp,%ebp
  801783:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801786:	83 ec 04             	sub    $0x4,%esp
  801789:	68 d0 26 80 00       	push   $0x8026d0
  80178e:	68 c3 00 00 00       	push   $0xc3
  801793:	68 f3 26 80 00       	push   $0x8026f3
  801798:	e8 b5 eb ff ff       	call   800352 <_panic>

0080179d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80179d:	55                   	push   %ebp
  80179e:	89 e5                	mov    %esp,%ebp
  8017a0:	57                   	push   %edi
  8017a1:	56                   	push   %esi
  8017a2:	53                   	push   %ebx
  8017a3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8017a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ac:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017af:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017b2:	8b 7d 18             	mov    0x18(%ebp),%edi
  8017b5:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8017b8:	cd 30                	int    $0x30
  8017ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8017bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8017c0:	83 c4 10             	add    $0x10,%esp
  8017c3:	5b                   	pop    %ebx
  8017c4:	5e                   	pop    %esi
  8017c5:	5f                   	pop    %edi
  8017c6:	5d                   	pop    %ebp
  8017c7:	c3                   	ret    

008017c8 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8017c8:	55                   	push   %ebp
  8017c9:	89 e5                	mov    %esp,%ebp
  8017cb:	83 ec 04             	sub    $0x4,%esp
  8017ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8017d4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	52                   	push   %edx
  8017e0:	ff 75 0c             	pushl  0xc(%ebp)
  8017e3:	50                   	push   %eax
  8017e4:	6a 00                	push   $0x0
  8017e6:	e8 b2 ff ff ff       	call   80179d <syscall>
  8017eb:	83 c4 18             	add    $0x18,%esp
}
  8017ee:	90                   	nop
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <sys_cgetc>:

int
sys_cgetc(void)
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 01                	push   $0x1
  801800:	e8 98 ff ff ff       	call   80179d <syscall>
  801805:	83 c4 18             	add    $0x18,%esp
}
  801808:	c9                   	leave  
  801809:	c3                   	ret    

0080180a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80180a:	55                   	push   %ebp
  80180b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80180d:	8b 45 08             	mov    0x8(%ebp),%eax
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	50                   	push   %eax
  801819:	6a 05                	push   $0x5
  80181b:	e8 7d ff ff ff       	call   80179d <syscall>
  801820:	83 c4 18             	add    $0x18,%esp
}
  801823:	c9                   	leave  
  801824:	c3                   	ret    

00801825 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801825:	55                   	push   %ebp
  801826:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 02                	push   $0x2
  801834:	e8 64 ff ff ff       	call   80179d <syscall>
  801839:	83 c4 18             	add    $0x18,%esp
}
  80183c:	c9                   	leave  
  80183d:	c3                   	ret    

0080183e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80183e:	55                   	push   %ebp
  80183f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 03                	push   $0x3
  80184d:	e8 4b ff ff ff       	call   80179d <syscall>
  801852:	83 c4 18             	add    $0x18,%esp
}
  801855:	c9                   	leave  
  801856:	c3                   	ret    

00801857 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 04                	push   $0x4
  801866:	e8 32 ff ff ff       	call   80179d <syscall>
  80186b:	83 c4 18             	add    $0x18,%esp
}
  80186e:	c9                   	leave  
  80186f:	c3                   	ret    

00801870 <sys_env_exit>:


void sys_env_exit(void)
{
  801870:	55                   	push   %ebp
  801871:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 06                	push   $0x6
  80187f:	e8 19 ff ff ff       	call   80179d <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
}
  801887:	90                   	nop
  801888:	c9                   	leave  
  801889:	c3                   	ret    

0080188a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80188a:	55                   	push   %ebp
  80188b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80188d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801890:	8b 45 08             	mov    0x8(%ebp),%eax
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	52                   	push   %edx
  80189a:	50                   	push   %eax
  80189b:	6a 07                	push   $0x7
  80189d:	e8 fb fe ff ff       	call   80179d <syscall>
  8018a2:	83 c4 18             	add    $0x18,%esp
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
  8018aa:	56                   	push   %esi
  8018ab:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8018ac:	8b 75 18             	mov    0x18(%ebp),%esi
  8018af:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018b2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bb:	56                   	push   %esi
  8018bc:	53                   	push   %ebx
  8018bd:	51                   	push   %ecx
  8018be:	52                   	push   %edx
  8018bf:	50                   	push   %eax
  8018c0:	6a 08                	push   $0x8
  8018c2:	e8 d6 fe ff ff       	call   80179d <syscall>
  8018c7:	83 c4 18             	add    $0x18,%esp
}
  8018ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8018cd:	5b                   	pop    %ebx
  8018ce:	5e                   	pop    %esi
  8018cf:	5d                   	pop    %ebp
  8018d0:	c3                   	ret    

008018d1 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8018d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	52                   	push   %edx
  8018e1:	50                   	push   %eax
  8018e2:	6a 09                	push   $0x9
  8018e4:	e8 b4 fe ff ff       	call   80179d <syscall>
  8018e9:	83 c4 18             	add    $0x18,%esp
}
  8018ec:	c9                   	leave  
  8018ed:	c3                   	ret    

008018ee <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8018ee:	55                   	push   %ebp
  8018ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	ff 75 0c             	pushl  0xc(%ebp)
  8018fa:	ff 75 08             	pushl  0x8(%ebp)
  8018fd:	6a 0a                	push   $0xa
  8018ff:	e8 99 fe ff ff       	call   80179d <syscall>
  801904:	83 c4 18             	add    $0x18,%esp
}
  801907:	c9                   	leave  
  801908:	c3                   	ret    

00801909 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801909:	55                   	push   %ebp
  80190a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 0b                	push   $0xb
  801918:	e8 80 fe ff ff       	call   80179d <syscall>
  80191d:	83 c4 18             	add    $0x18,%esp
}
  801920:	c9                   	leave  
  801921:	c3                   	ret    

00801922 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801922:	55                   	push   %ebp
  801923:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	6a 0c                	push   $0xc
  801931:	e8 67 fe ff ff       	call   80179d <syscall>
  801936:	83 c4 18             	add    $0x18,%esp
}
  801939:	c9                   	leave  
  80193a:	c3                   	ret    

0080193b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80193b:	55                   	push   %ebp
  80193c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	6a 00                	push   $0x0
  801946:	6a 00                	push   $0x0
  801948:	6a 0d                	push   $0xd
  80194a:	e8 4e fe ff ff       	call   80179d <syscall>
  80194f:	83 c4 18             	add    $0x18,%esp
}
  801952:	c9                   	leave  
  801953:	c3                   	ret    

00801954 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801954:	55                   	push   %ebp
  801955:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	ff 75 0c             	pushl  0xc(%ebp)
  801960:	ff 75 08             	pushl  0x8(%ebp)
  801963:	6a 11                	push   $0x11
  801965:	e8 33 fe ff ff       	call   80179d <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
	return;
  80196d:	90                   	nop
}
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	ff 75 0c             	pushl  0xc(%ebp)
  80197c:	ff 75 08             	pushl  0x8(%ebp)
  80197f:	6a 12                	push   $0x12
  801981:	e8 17 fe ff ff       	call   80179d <syscall>
  801986:	83 c4 18             	add    $0x18,%esp
	return ;
  801989:	90                   	nop
}
  80198a:	c9                   	leave  
  80198b:	c3                   	ret    

0080198c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 0e                	push   $0xe
  80199b:	e8 fd fd ff ff       	call   80179d <syscall>
  8019a0:	83 c4 18             	add    $0x18,%esp
}
  8019a3:	c9                   	leave  
  8019a4:	c3                   	ret    

008019a5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8019a5:	55                   	push   %ebp
  8019a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	ff 75 08             	pushl  0x8(%ebp)
  8019b3:	6a 0f                	push   $0xf
  8019b5:	e8 e3 fd ff ff       	call   80179d <syscall>
  8019ba:	83 c4 18             	add    $0x18,%esp
}
  8019bd:	c9                   	leave  
  8019be:	c3                   	ret    

008019bf <sys_scarce_memory>:

void sys_scarce_memory()
{
  8019bf:	55                   	push   %ebp
  8019c0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 10                	push   $0x10
  8019ce:	e8 ca fd ff ff       	call   80179d <syscall>
  8019d3:	83 c4 18             	add    $0x18,%esp
}
  8019d6:	90                   	nop
  8019d7:	c9                   	leave  
  8019d8:	c3                   	ret    

008019d9 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8019d9:	55                   	push   %ebp
  8019da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 14                	push   $0x14
  8019e8:	e8 b0 fd ff ff       	call   80179d <syscall>
  8019ed:	83 c4 18             	add    $0x18,%esp
}
  8019f0:	90                   	nop
  8019f1:	c9                   	leave  
  8019f2:	c3                   	ret    

008019f3 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8019f3:	55                   	push   %ebp
  8019f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 15                	push   $0x15
  801a02:	e8 96 fd ff ff       	call   80179d <syscall>
  801a07:	83 c4 18             	add    $0x18,%esp
}
  801a0a:	90                   	nop
  801a0b:	c9                   	leave  
  801a0c:	c3                   	ret    

00801a0d <sys_cputc>:


void
sys_cputc(const char c)
{
  801a0d:	55                   	push   %ebp
  801a0e:	89 e5                	mov    %esp,%ebp
  801a10:	83 ec 04             	sub    $0x4,%esp
  801a13:	8b 45 08             	mov    0x8(%ebp),%eax
  801a16:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a19:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	50                   	push   %eax
  801a26:	6a 16                	push   $0x16
  801a28:	e8 70 fd ff ff       	call   80179d <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
}
  801a30:	90                   	nop
  801a31:	c9                   	leave  
  801a32:	c3                   	ret    

00801a33 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a33:	55                   	push   %ebp
  801a34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 17                	push   $0x17
  801a42:	e8 56 fd ff ff       	call   80179d <syscall>
  801a47:	83 c4 18             	add    $0x18,%esp
}
  801a4a:	90                   	nop
  801a4b:	c9                   	leave  
  801a4c:	c3                   	ret    

00801a4d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801a4d:	55                   	push   %ebp
  801a4e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801a50:	8b 45 08             	mov    0x8(%ebp),%eax
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	ff 75 0c             	pushl  0xc(%ebp)
  801a5c:	50                   	push   %eax
  801a5d:	6a 18                	push   $0x18
  801a5f:	e8 39 fd ff ff       	call   80179d <syscall>
  801a64:	83 c4 18             	add    $0x18,%esp
}
  801a67:	c9                   	leave  
  801a68:	c3                   	ret    

00801a69 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a69:	55                   	push   %ebp
  801a6a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	52                   	push   %edx
  801a79:	50                   	push   %eax
  801a7a:	6a 1b                	push   $0x1b
  801a7c:	e8 1c fd ff ff       	call   80179d <syscall>
  801a81:	83 c4 18             	add    $0x18,%esp
}
  801a84:	c9                   	leave  
  801a85:	c3                   	ret    

00801a86 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a86:	55                   	push   %ebp
  801a87:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a89:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	52                   	push   %edx
  801a96:	50                   	push   %eax
  801a97:	6a 19                	push   $0x19
  801a99:	e8 ff fc ff ff       	call   80179d <syscall>
  801a9e:	83 c4 18             	add    $0x18,%esp
}
  801aa1:	90                   	nop
  801aa2:	c9                   	leave  
  801aa3:	c3                   	ret    

00801aa4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801aa4:	55                   	push   %ebp
  801aa5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801aa7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	52                   	push   %edx
  801ab4:	50                   	push   %eax
  801ab5:	6a 1a                	push   $0x1a
  801ab7:	e8 e1 fc ff ff       	call   80179d <syscall>
  801abc:	83 c4 18             	add    $0x18,%esp
}
  801abf:	90                   	nop
  801ac0:	c9                   	leave  
  801ac1:	c3                   	ret    

00801ac2 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ac2:	55                   	push   %ebp
  801ac3:	89 e5                	mov    %esp,%ebp
  801ac5:	83 ec 04             	sub    $0x4,%esp
  801ac8:	8b 45 10             	mov    0x10(%ebp),%eax
  801acb:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ace:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ad1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad8:	6a 00                	push   $0x0
  801ada:	51                   	push   %ecx
  801adb:	52                   	push   %edx
  801adc:	ff 75 0c             	pushl  0xc(%ebp)
  801adf:	50                   	push   %eax
  801ae0:	6a 1c                	push   $0x1c
  801ae2:	e8 b6 fc ff ff       	call   80179d <syscall>
  801ae7:	83 c4 18             	add    $0x18,%esp
}
  801aea:	c9                   	leave  
  801aeb:	c3                   	ret    

00801aec <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801aec:	55                   	push   %ebp
  801aed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801aef:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af2:	8b 45 08             	mov    0x8(%ebp),%eax
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	52                   	push   %edx
  801afc:	50                   	push   %eax
  801afd:	6a 1d                	push   $0x1d
  801aff:	e8 99 fc ff ff       	call   80179d <syscall>
  801b04:	83 c4 18             	add    $0x18,%esp
}
  801b07:	c9                   	leave  
  801b08:	c3                   	ret    

00801b09 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b09:	55                   	push   %ebp
  801b0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b0c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b12:	8b 45 08             	mov    0x8(%ebp),%eax
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	51                   	push   %ecx
  801b1a:	52                   	push   %edx
  801b1b:	50                   	push   %eax
  801b1c:	6a 1e                	push   $0x1e
  801b1e:	e8 7a fc ff ff       	call   80179d <syscall>
  801b23:	83 c4 18             	add    $0x18,%esp
}
  801b26:	c9                   	leave  
  801b27:	c3                   	ret    

00801b28 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	52                   	push   %edx
  801b38:	50                   	push   %eax
  801b39:	6a 1f                	push   $0x1f
  801b3b:	e8 5d fc ff ff       	call   80179d <syscall>
  801b40:	83 c4 18             	add    $0x18,%esp
}
  801b43:	c9                   	leave  
  801b44:	c3                   	ret    

00801b45 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b45:	55                   	push   %ebp
  801b46:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	6a 20                	push   $0x20
  801b54:	e8 44 fc ff ff       	call   80179d <syscall>
  801b59:	83 c4 18             	add    $0x18,%esp
}
  801b5c:	c9                   	leave  
  801b5d:	c3                   	ret    

00801b5e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801b5e:	55                   	push   %ebp
  801b5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b61:	8b 45 08             	mov    0x8(%ebp),%eax
  801b64:	6a 00                	push   $0x0
  801b66:	ff 75 14             	pushl  0x14(%ebp)
  801b69:	ff 75 10             	pushl  0x10(%ebp)
  801b6c:	ff 75 0c             	pushl  0xc(%ebp)
  801b6f:	50                   	push   %eax
  801b70:	6a 21                	push   $0x21
  801b72:	e8 26 fc ff ff       	call   80179d <syscall>
  801b77:	83 c4 18             	add    $0x18,%esp
}
  801b7a:	c9                   	leave  
  801b7b:	c3                   	ret    

00801b7c <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801b7c:	55                   	push   %ebp
  801b7d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	50                   	push   %eax
  801b8b:	6a 22                	push   $0x22
  801b8d:	e8 0b fc ff ff       	call   80179d <syscall>
  801b92:	83 c4 18             	add    $0x18,%esp
}
  801b95:	90                   	nop
  801b96:	c9                   	leave  
  801b97:	c3                   	ret    

00801b98 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b98:	55                   	push   %ebp
  801b99:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	50                   	push   %eax
  801ba7:	6a 23                	push   $0x23
  801ba9:	e8 ef fb ff ff       	call   80179d <syscall>
  801bae:	83 c4 18             	add    $0x18,%esp
}
  801bb1:	90                   	nop
  801bb2:	c9                   	leave  
  801bb3:	c3                   	ret    

00801bb4 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801bb4:	55                   	push   %ebp
  801bb5:	89 e5                	mov    %esp,%ebp
  801bb7:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801bba:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801bbd:	8d 50 04             	lea    0x4(%eax),%edx
  801bc0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	52                   	push   %edx
  801bca:	50                   	push   %eax
  801bcb:	6a 24                	push   $0x24
  801bcd:	e8 cb fb ff ff       	call   80179d <syscall>
  801bd2:	83 c4 18             	add    $0x18,%esp
	return result;
  801bd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801bd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bdb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bde:	89 01                	mov    %eax,(%ecx)
  801be0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801be3:	8b 45 08             	mov    0x8(%ebp),%eax
  801be6:	c9                   	leave  
  801be7:	c2 04 00             	ret    $0x4

00801bea <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801bea:	55                   	push   %ebp
  801beb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	ff 75 10             	pushl  0x10(%ebp)
  801bf4:	ff 75 0c             	pushl  0xc(%ebp)
  801bf7:	ff 75 08             	pushl  0x8(%ebp)
  801bfa:	6a 13                	push   $0x13
  801bfc:	e8 9c fb ff ff       	call   80179d <syscall>
  801c01:	83 c4 18             	add    $0x18,%esp
	return ;
  801c04:	90                   	nop
}
  801c05:	c9                   	leave  
  801c06:	c3                   	ret    

00801c07 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c07:	55                   	push   %ebp
  801c08:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	6a 25                	push   $0x25
  801c16:	e8 82 fb ff ff       	call   80179d <syscall>
  801c1b:	83 c4 18             	add    $0x18,%esp
}
  801c1e:	c9                   	leave  
  801c1f:	c3                   	ret    

00801c20 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c20:	55                   	push   %ebp
  801c21:	89 e5                	mov    %esp,%ebp
  801c23:	83 ec 04             	sub    $0x4,%esp
  801c26:	8b 45 08             	mov    0x8(%ebp),%eax
  801c29:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c2c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	50                   	push   %eax
  801c39:	6a 26                	push   $0x26
  801c3b:	e8 5d fb ff ff       	call   80179d <syscall>
  801c40:	83 c4 18             	add    $0x18,%esp
	return ;
  801c43:	90                   	nop
}
  801c44:	c9                   	leave  
  801c45:	c3                   	ret    

00801c46 <rsttst>:
void rsttst()
{
  801c46:	55                   	push   %ebp
  801c47:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 00                	push   $0x0
  801c53:	6a 28                	push   $0x28
  801c55:	e8 43 fb ff ff       	call   80179d <syscall>
  801c5a:	83 c4 18             	add    $0x18,%esp
	return ;
  801c5d:	90                   	nop
}
  801c5e:	c9                   	leave  
  801c5f:	c3                   	ret    

00801c60 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c60:	55                   	push   %ebp
  801c61:	89 e5                	mov    %esp,%ebp
  801c63:	83 ec 04             	sub    $0x4,%esp
  801c66:	8b 45 14             	mov    0x14(%ebp),%eax
  801c69:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c6c:	8b 55 18             	mov    0x18(%ebp),%edx
  801c6f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c73:	52                   	push   %edx
  801c74:	50                   	push   %eax
  801c75:	ff 75 10             	pushl  0x10(%ebp)
  801c78:	ff 75 0c             	pushl  0xc(%ebp)
  801c7b:	ff 75 08             	pushl  0x8(%ebp)
  801c7e:	6a 27                	push   $0x27
  801c80:	e8 18 fb ff ff       	call   80179d <syscall>
  801c85:	83 c4 18             	add    $0x18,%esp
	return ;
  801c88:	90                   	nop
}
  801c89:	c9                   	leave  
  801c8a:	c3                   	ret    

00801c8b <chktst>:
void chktst(uint32 n)
{
  801c8b:	55                   	push   %ebp
  801c8c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	ff 75 08             	pushl  0x8(%ebp)
  801c99:	6a 29                	push   $0x29
  801c9b:	e8 fd fa ff ff       	call   80179d <syscall>
  801ca0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ca3:	90                   	nop
}
  801ca4:	c9                   	leave  
  801ca5:	c3                   	ret    

00801ca6 <inctst>:

void inctst()
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 2a                	push   $0x2a
  801cb5:	e8 e3 fa ff ff       	call   80179d <syscall>
  801cba:	83 c4 18             	add    $0x18,%esp
	return ;
  801cbd:	90                   	nop
}
  801cbe:	c9                   	leave  
  801cbf:	c3                   	ret    

00801cc0 <gettst>:
uint32 gettst()
{
  801cc0:	55                   	push   %ebp
  801cc1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 2b                	push   $0x2b
  801ccf:	e8 c9 fa ff ff       	call   80179d <syscall>
  801cd4:	83 c4 18             	add    $0x18,%esp
}
  801cd7:	c9                   	leave  
  801cd8:	c3                   	ret    

00801cd9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801cd9:	55                   	push   %ebp
  801cda:	89 e5                	mov    %esp,%ebp
  801cdc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 2c                	push   $0x2c
  801ceb:	e8 ad fa ff ff       	call   80179d <syscall>
  801cf0:	83 c4 18             	add    $0x18,%esp
  801cf3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801cf6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801cfa:	75 07                	jne    801d03 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801cfc:	b8 01 00 00 00       	mov    $0x1,%eax
  801d01:	eb 05                	jmp    801d08 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d03:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d08:	c9                   	leave  
  801d09:	c3                   	ret    

00801d0a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d0a:	55                   	push   %ebp
  801d0b:	89 e5                	mov    %esp,%ebp
  801d0d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 2c                	push   $0x2c
  801d1c:	e8 7c fa ff ff       	call   80179d <syscall>
  801d21:	83 c4 18             	add    $0x18,%esp
  801d24:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d27:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d2b:	75 07                	jne    801d34 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d2d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d32:	eb 05                	jmp    801d39 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d34:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d39:	c9                   	leave  
  801d3a:	c3                   	ret    

00801d3b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d3b:	55                   	push   %ebp
  801d3c:	89 e5                	mov    %esp,%ebp
  801d3e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 00                	push   $0x0
  801d4b:	6a 2c                	push   $0x2c
  801d4d:	e8 4b fa ff ff       	call   80179d <syscall>
  801d52:	83 c4 18             	add    $0x18,%esp
  801d55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d58:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d5c:	75 07                	jne    801d65 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d5e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d63:	eb 05                	jmp    801d6a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d65:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d6a:	c9                   	leave  
  801d6b:	c3                   	ret    

00801d6c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d6c:	55                   	push   %ebp
  801d6d:	89 e5                	mov    %esp,%ebp
  801d6f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d72:	6a 00                	push   $0x0
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 00                	push   $0x0
  801d7c:	6a 2c                	push   $0x2c
  801d7e:	e8 1a fa ff ff       	call   80179d <syscall>
  801d83:	83 c4 18             	add    $0x18,%esp
  801d86:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d89:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d8d:	75 07                	jne    801d96 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d8f:	b8 01 00 00 00       	mov    $0x1,%eax
  801d94:	eb 05                	jmp    801d9b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d96:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d9b:	c9                   	leave  
  801d9c:	c3                   	ret    

00801d9d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d9d:	55                   	push   %ebp
  801d9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	ff 75 08             	pushl  0x8(%ebp)
  801dab:	6a 2d                	push   $0x2d
  801dad:	e8 eb f9 ff ff       	call   80179d <syscall>
  801db2:	83 c4 18             	add    $0x18,%esp
	return ;
  801db5:	90                   	nop
}
  801db6:	c9                   	leave  
  801db7:	c3                   	ret    

00801db8 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801db8:	55                   	push   %ebp
  801db9:	89 e5                	mov    %esp,%ebp
  801dbb:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801dbc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dbf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dc2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc5:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc8:	6a 00                	push   $0x0
  801dca:	53                   	push   %ebx
  801dcb:	51                   	push   %ecx
  801dcc:	52                   	push   %edx
  801dcd:	50                   	push   %eax
  801dce:	6a 2e                	push   $0x2e
  801dd0:	e8 c8 f9 ff ff       	call   80179d <syscall>
  801dd5:	83 c4 18             	add    $0x18,%esp
}
  801dd8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801ddb:	c9                   	leave  
  801ddc:	c3                   	ret    

00801ddd <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801ddd:	55                   	push   %ebp
  801dde:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801de0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801de3:	8b 45 08             	mov    0x8(%ebp),%eax
  801de6:	6a 00                	push   $0x0
  801de8:	6a 00                	push   $0x0
  801dea:	6a 00                	push   $0x0
  801dec:	52                   	push   %edx
  801ded:	50                   	push   %eax
  801dee:	6a 2f                	push   $0x2f
  801df0:	e8 a8 f9 ff ff       	call   80179d <syscall>
  801df5:	83 c4 18             	add    $0x18,%esp
}
  801df8:	c9                   	leave  
  801df9:	c3                   	ret    

00801dfa <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801dfa:	55                   	push   %ebp
  801dfb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	ff 75 0c             	pushl  0xc(%ebp)
  801e06:	ff 75 08             	pushl  0x8(%ebp)
  801e09:	6a 30                	push   $0x30
  801e0b:	e8 8d f9 ff ff       	call   80179d <syscall>
  801e10:	83 c4 18             	add    $0x18,%esp
	return ;
  801e13:	90                   	nop
}
  801e14:	c9                   	leave  
  801e15:	c3                   	ret    
  801e16:	66 90                	xchg   %ax,%ax

00801e18 <__udivdi3>:
  801e18:	55                   	push   %ebp
  801e19:	57                   	push   %edi
  801e1a:	56                   	push   %esi
  801e1b:	53                   	push   %ebx
  801e1c:	83 ec 1c             	sub    $0x1c,%esp
  801e1f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e23:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e27:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e2b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e2f:	89 ca                	mov    %ecx,%edx
  801e31:	89 f8                	mov    %edi,%eax
  801e33:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e37:	85 f6                	test   %esi,%esi
  801e39:	75 2d                	jne    801e68 <__udivdi3+0x50>
  801e3b:	39 cf                	cmp    %ecx,%edi
  801e3d:	77 65                	ja     801ea4 <__udivdi3+0x8c>
  801e3f:	89 fd                	mov    %edi,%ebp
  801e41:	85 ff                	test   %edi,%edi
  801e43:	75 0b                	jne    801e50 <__udivdi3+0x38>
  801e45:	b8 01 00 00 00       	mov    $0x1,%eax
  801e4a:	31 d2                	xor    %edx,%edx
  801e4c:	f7 f7                	div    %edi
  801e4e:	89 c5                	mov    %eax,%ebp
  801e50:	31 d2                	xor    %edx,%edx
  801e52:	89 c8                	mov    %ecx,%eax
  801e54:	f7 f5                	div    %ebp
  801e56:	89 c1                	mov    %eax,%ecx
  801e58:	89 d8                	mov    %ebx,%eax
  801e5a:	f7 f5                	div    %ebp
  801e5c:	89 cf                	mov    %ecx,%edi
  801e5e:	89 fa                	mov    %edi,%edx
  801e60:	83 c4 1c             	add    $0x1c,%esp
  801e63:	5b                   	pop    %ebx
  801e64:	5e                   	pop    %esi
  801e65:	5f                   	pop    %edi
  801e66:	5d                   	pop    %ebp
  801e67:	c3                   	ret    
  801e68:	39 ce                	cmp    %ecx,%esi
  801e6a:	77 28                	ja     801e94 <__udivdi3+0x7c>
  801e6c:	0f bd fe             	bsr    %esi,%edi
  801e6f:	83 f7 1f             	xor    $0x1f,%edi
  801e72:	75 40                	jne    801eb4 <__udivdi3+0x9c>
  801e74:	39 ce                	cmp    %ecx,%esi
  801e76:	72 0a                	jb     801e82 <__udivdi3+0x6a>
  801e78:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e7c:	0f 87 9e 00 00 00    	ja     801f20 <__udivdi3+0x108>
  801e82:	b8 01 00 00 00       	mov    $0x1,%eax
  801e87:	89 fa                	mov    %edi,%edx
  801e89:	83 c4 1c             	add    $0x1c,%esp
  801e8c:	5b                   	pop    %ebx
  801e8d:	5e                   	pop    %esi
  801e8e:	5f                   	pop    %edi
  801e8f:	5d                   	pop    %ebp
  801e90:	c3                   	ret    
  801e91:	8d 76 00             	lea    0x0(%esi),%esi
  801e94:	31 ff                	xor    %edi,%edi
  801e96:	31 c0                	xor    %eax,%eax
  801e98:	89 fa                	mov    %edi,%edx
  801e9a:	83 c4 1c             	add    $0x1c,%esp
  801e9d:	5b                   	pop    %ebx
  801e9e:	5e                   	pop    %esi
  801e9f:	5f                   	pop    %edi
  801ea0:	5d                   	pop    %ebp
  801ea1:	c3                   	ret    
  801ea2:	66 90                	xchg   %ax,%ax
  801ea4:	89 d8                	mov    %ebx,%eax
  801ea6:	f7 f7                	div    %edi
  801ea8:	31 ff                	xor    %edi,%edi
  801eaa:	89 fa                	mov    %edi,%edx
  801eac:	83 c4 1c             	add    $0x1c,%esp
  801eaf:	5b                   	pop    %ebx
  801eb0:	5e                   	pop    %esi
  801eb1:	5f                   	pop    %edi
  801eb2:	5d                   	pop    %ebp
  801eb3:	c3                   	ret    
  801eb4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801eb9:	89 eb                	mov    %ebp,%ebx
  801ebb:	29 fb                	sub    %edi,%ebx
  801ebd:	89 f9                	mov    %edi,%ecx
  801ebf:	d3 e6                	shl    %cl,%esi
  801ec1:	89 c5                	mov    %eax,%ebp
  801ec3:	88 d9                	mov    %bl,%cl
  801ec5:	d3 ed                	shr    %cl,%ebp
  801ec7:	89 e9                	mov    %ebp,%ecx
  801ec9:	09 f1                	or     %esi,%ecx
  801ecb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ecf:	89 f9                	mov    %edi,%ecx
  801ed1:	d3 e0                	shl    %cl,%eax
  801ed3:	89 c5                	mov    %eax,%ebp
  801ed5:	89 d6                	mov    %edx,%esi
  801ed7:	88 d9                	mov    %bl,%cl
  801ed9:	d3 ee                	shr    %cl,%esi
  801edb:	89 f9                	mov    %edi,%ecx
  801edd:	d3 e2                	shl    %cl,%edx
  801edf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ee3:	88 d9                	mov    %bl,%cl
  801ee5:	d3 e8                	shr    %cl,%eax
  801ee7:	09 c2                	or     %eax,%edx
  801ee9:	89 d0                	mov    %edx,%eax
  801eeb:	89 f2                	mov    %esi,%edx
  801eed:	f7 74 24 0c          	divl   0xc(%esp)
  801ef1:	89 d6                	mov    %edx,%esi
  801ef3:	89 c3                	mov    %eax,%ebx
  801ef5:	f7 e5                	mul    %ebp
  801ef7:	39 d6                	cmp    %edx,%esi
  801ef9:	72 19                	jb     801f14 <__udivdi3+0xfc>
  801efb:	74 0b                	je     801f08 <__udivdi3+0xf0>
  801efd:	89 d8                	mov    %ebx,%eax
  801eff:	31 ff                	xor    %edi,%edi
  801f01:	e9 58 ff ff ff       	jmp    801e5e <__udivdi3+0x46>
  801f06:	66 90                	xchg   %ax,%ax
  801f08:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f0c:	89 f9                	mov    %edi,%ecx
  801f0e:	d3 e2                	shl    %cl,%edx
  801f10:	39 c2                	cmp    %eax,%edx
  801f12:	73 e9                	jae    801efd <__udivdi3+0xe5>
  801f14:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f17:	31 ff                	xor    %edi,%edi
  801f19:	e9 40 ff ff ff       	jmp    801e5e <__udivdi3+0x46>
  801f1e:	66 90                	xchg   %ax,%ax
  801f20:	31 c0                	xor    %eax,%eax
  801f22:	e9 37 ff ff ff       	jmp    801e5e <__udivdi3+0x46>
  801f27:	90                   	nop

00801f28 <__umoddi3>:
  801f28:	55                   	push   %ebp
  801f29:	57                   	push   %edi
  801f2a:	56                   	push   %esi
  801f2b:	53                   	push   %ebx
  801f2c:	83 ec 1c             	sub    $0x1c,%esp
  801f2f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f33:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f37:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f3b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f3f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f43:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f47:	89 f3                	mov    %esi,%ebx
  801f49:	89 fa                	mov    %edi,%edx
  801f4b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f4f:	89 34 24             	mov    %esi,(%esp)
  801f52:	85 c0                	test   %eax,%eax
  801f54:	75 1a                	jne    801f70 <__umoddi3+0x48>
  801f56:	39 f7                	cmp    %esi,%edi
  801f58:	0f 86 a2 00 00 00    	jbe    802000 <__umoddi3+0xd8>
  801f5e:	89 c8                	mov    %ecx,%eax
  801f60:	89 f2                	mov    %esi,%edx
  801f62:	f7 f7                	div    %edi
  801f64:	89 d0                	mov    %edx,%eax
  801f66:	31 d2                	xor    %edx,%edx
  801f68:	83 c4 1c             	add    $0x1c,%esp
  801f6b:	5b                   	pop    %ebx
  801f6c:	5e                   	pop    %esi
  801f6d:	5f                   	pop    %edi
  801f6e:	5d                   	pop    %ebp
  801f6f:	c3                   	ret    
  801f70:	39 f0                	cmp    %esi,%eax
  801f72:	0f 87 ac 00 00 00    	ja     802024 <__umoddi3+0xfc>
  801f78:	0f bd e8             	bsr    %eax,%ebp
  801f7b:	83 f5 1f             	xor    $0x1f,%ebp
  801f7e:	0f 84 ac 00 00 00    	je     802030 <__umoddi3+0x108>
  801f84:	bf 20 00 00 00       	mov    $0x20,%edi
  801f89:	29 ef                	sub    %ebp,%edi
  801f8b:	89 fe                	mov    %edi,%esi
  801f8d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f91:	89 e9                	mov    %ebp,%ecx
  801f93:	d3 e0                	shl    %cl,%eax
  801f95:	89 d7                	mov    %edx,%edi
  801f97:	89 f1                	mov    %esi,%ecx
  801f99:	d3 ef                	shr    %cl,%edi
  801f9b:	09 c7                	or     %eax,%edi
  801f9d:	89 e9                	mov    %ebp,%ecx
  801f9f:	d3 e2                	shl    %cl,%edx
  801fa1:	89 14 24             	mov    %edx,(%esp)
  801fa4:	89 d8                	mov    %ebx,%eax
  801fa6:	d3 e0                	shl    %cl,%eax
  801fa8:	89 c2                	mov    %eax,%edx
  801faa:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fae:	d3 e0                	shl    %cl,%eax
  801fb0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801fb4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fb8:	89 f1                	mov    %esi,%ecx
  801fba:	d3 e8                	shr    %cl,%eax
  801fbc:	09 d0                	or     %edx,%eax
  801fbe:	d3 eb                	shr    %cl,%ebx
  801fc0:	89 da                	mov    %ebx,%edx
  801fc2:	f7 f7                	div    %edi
  801fc4:	89 d3                	mov    %edx,%ebx
  801fc6:	f7 24 24             	mull   (%esp)
  801fc9:	89 c6                	mov    %eax,%esi
  801fcb:	89 d1                	mov    %edx,%ecx
  801fcd:	39 d3                	cmp    %edx,%ebx
  801fcf:	0f 82 87 00 00 00    	jb     80205c <__umoddi3+0x134>
  801fd5:	0f 84 91 00 00 00    	je     80206c <__umoddi3+0x144>
  801fdb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801fdf:	29 f2                	sub    %esi,%edx
  801fe1:	19 cb                	sbb    %ecx,%ebx
  801fe3:	89 d8                	mov    %ebx,%eax
  801fe5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801fe9:	d3 e0                	shl    %cl,%eax
  801feb:	89 e9                	mov    %ebp,%ecx
  801fed:	d3 ea                	shr    %cl,%edx
  801fef:	09 d0                	or     %edx,%eax
  801ff1:	89 e9                	mov    %ebp,%ecx
  801ff3:	d3 eb                	shr    %cl,%ebx
  801ff5:	89 da                	mov    %ebx,%edx
  801ff7:	83 c4 1c             	add    $0x1c,%esp
  801ffa:	5b                   	pop    %ebx
  801ffb:	5e                   	pop    %esi
  801ffc:	5f                   	pop    %edi
  801ffd:	5d                   	pop    %ebp
  801ffe:	c3                   	ret    
  801fff:	90                   	nop
  802000:	89 fd                	mov    %edi,%ebp
  802002:	85 ff                	test   %edi,%edi
  802004:	75 0b                	jne    802011 <__umoddi3+0xe9>
  802006:	b8 01 00 00 00       	mov    $0x1,%eax
  80200b:	31 d2                	xor    %edx,%edx
  80200d:	f7 f7                	div    %edi
  80200f:	89 c5                	mov    %eax,%ebp
  802011:	89 f0                	mov    %esi,%eax
  802013:	31 d2                	xor    %edx,%edx
  802015:	f7 f5                	div    %ebp
  802017:	89 c8                	mov    %ecx,%eax
  802019:	f7 f5                	div    %ebp
  80201b:	89 d0                	mov    %edx,%eax
  80201d:	e9 44 ff ff ff       	jmp    801f66 <__umoddi3+0x3e>
  802022:	66 90                	xchg   %ax,%ax
  802024:	89 c8                	mov    %ecx,%eax
  802026:	89 f2                	mov    %esi,%edx
  802028:	83 c4 1c             	add    $0x1c,%esp
  80202b:	5b                   	pop    %ebx
  80202c:	5e                   	pop    %esi
  80202d:	5f                   	pop    %edi
  80202e:	5d                   	pop    %ebp
  80202f:	c3                   	ret    
  802030:	3b 04 24             	cmp    (%esp),%eax
  802033:	72 06                	jb     80203b <__umoddi3+0x113>
  802035:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802039:	77 0f                	ja     80204a <__umoddi3+0x122>
  80203b:	89 f2                	mov    %esi,%edx
  80203d:	29 f9                	sub    %edi,%ecx
  80203f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802043:	89 14 24             	mov    %edx,(%esp)
  802046:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80204a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80204e:	8b 14 24             	mov    (%esp),%edx
  802051:	83 c4 1c             	add    $0x1c,%esp
  802054:	5b                   	pop    %ebx
  802055:	5e                   	pop    %esi
  802056:	5f                   	pop    %edi
  802057:	5d                   	pop    %ebp
  802058:	c3                   	ret    
  802059:	8d 76 00             	lea    0x0(%esi),%esi
  80205c:	2b 04 24             	sub    (%esp),%eax
  80205f:	19 fa                	sbb    %edi,%edx
  802061:	89 d1                	mov    %edx,%ecx
  802063:	89 c6                	mov    %eax,%esi
  802065:	e9 71 ff ff ff       	jmp    801fdb <__umoddi3+0xb3>
  80206a:	66 90                	xchg   %ax,%ax
  80206c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802070:	72 ea                	jb     80205c <__umoddi3+0x134>
  802072:	89 d9                	mov    %ebx,%ecx
  802074:	e9 62 ff ff ff       	jmp    801fdb <__umoddi3+0xb3>
