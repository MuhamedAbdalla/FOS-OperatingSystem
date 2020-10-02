
obj/user/fos_alloc:     file format elf32-i386


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
  800031:	e8 02 01 00 00       	call   800138 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>


void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	//uint32 size = 2*1024*1024 +120*4096+1;
	//uint32 size = 1*1024*1024 + 256*1024;
	//uint32 size = 1*1024*1024;
	uint32 size = 100;
  80003e:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%ebp)

	unsigned char *x = malloc(sizeof(unsigned char)*size) ;
  800045:	83 ec 0c             	sub    $0xc,%esp
  800048:	ff 75 f0             	pushl  -0x10(%ebp)
  80004b:	e8 6e 10 00 00       	call   8010be <malloc>
  800050:	83 c4 10             	add    $0x10,%esp
  800053:	89 45 ec             	mov    %eax,-0x14(%ebp)
	atomic_cprintf("x allocated at %x\n",x);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	ff 75 ec             	pushl  -0x14(%ebp)
  80005c:	68 a0 1f 80 00       	push   $0x801fa0
  800061:	e8 fb 02 00 00       	call   800361 <atomic_cprintf>
  800066:	83 c4 10             	add    $0x10,%esp

	//unsigned char *z = malloc(sizeof(unsigned char)*size) ;
	//cprintf("z allocated at %x\n",z);
	
	int i ;
	for (i = 0 ; i < size ; i++)
  800069:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800070:	eb 20                	jmp    800092 <_main+0x5a>
	{
		x[i] = i%256 ;
  800072:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800075:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800078:	01 c2                	add    %eax,%edx
  80007a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80007d:	25 ff 00 00 80       	and    $0x800000ff,%eax
  800082:	85 c0                	test   %eax,%eax
  800084:	79 07                	jns    80008d <_main+0x55>
  800086:	48                   	dec    %eax
  800087:	0d 00 ff ff ff       	or     $0xffffff00,%eax
  80008c:	40                   	inc    %eax
  80008d:	88 02                	mov    %al,(%edx)

	//unsigned char *z = malloc(sizeof(unsigned char)*size) ;
	//cprintf("z allocated at %x\n",z);
	
	int i ;
	for (i = 0 ; i < size ; i++)
  80008f:	ff 45 f4             	incl   -0xc(%ebp)
  800092:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800095:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800098:	72 d8                	jb     800072 <_main+0x3a>
		////z[i] = (int)(x[i]  * y[i]);
		////z[i] = i%256;
	}

	
	for (i = size-7 ; i < size ; i++)
  80009a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80009d:	83 e8 07             	sub    $0x7,%eax
  8000a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8000a3:	eb 24                	jmp    8000c9 <_main+0x91>
		atomic_cprintf("x[%d] = %d\n",i, x[i]);
  8000a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ab:	01 d0                	add    %edx,%eax
  8000ad:	8a 00                	mov    (%eax),%al
  8000af:	0f b6 c0             	movzbl %al,%eax
  8000b2:	83 ec 04             	sub    $0x4,%esp
  8000b5:	50                   	push   %eax
  8000b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8000b9:	68 b3 1f 80 00       	push   $0x801fb3
  8000be:	e8 9e 02 00 00       	call   800361 <atomic_cprintf>
  8000c3:	83 c4 10             	add    $0x10,%esp
		////z[i] = (int)(x[i]  * y[i]);
		////z[i] = i%256;
	}

	
	for (i = size-7 ; i < size ; i++)
  8000c6:	ff 45 f4             	incl   -0xc(%ebp)
  8000c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000cf:	72 d4                	jb     8000a5 <_main+0x6d>
		atomic_cprintf("x[%d] = %d\n",i, x[i]);
	
	free(x);
  8000d1:	83 ec 0c             	sub    $0xc,%esp
  8000d4:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d7:	e8 a7 12 00 00       	call   801383 <free>
  8000dc:	83 c4 10             	add    $0x10,%esp

	x = malloc(sizeof(unsigned char)*size) ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	ff 75 f0             	pushl  -0x10(%ebp)
  8000e5:	e8 d4 0f 00 00       	call   8010be <malloc>
  8000ea:	83 c4 10             	add    $0x10,%esp
  8000ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
	
	for (i = size-7 ; i < size ; i++)
  8000f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000f3:	83 e8 07             	sub    $0x7,%eax
  8000f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8000f9:	eb 24                	jmp    80011f <_main+0xe7>
	{
		atomic_cprintf("x[%d] = %d\n",i,x[i]);
  8000fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800101:	01 d0                	add    %edx,%eax
  800103:	8a 00                	mov    (%eax),%al
  800105:	0f b6 c0             	movzbl %al,%eax
  800108:	83 ec 04             	sub    $0x4,%esp
  80010b:	50                   	push   %eax
  80010c:	ff 75 f4             	pushl  -0xc(%ebp)
  80010f:	68 b3 1f 80 00       	push   $0x801fb3
  800114:	e8 48 02 00 00       	call   800361 <atomic_cprintf>
  800119:	83 c4 10             	add    $0x10,%esp
	
	free(x);

	x = malloc(sizeof(unsigned char)*size) ;
	
	for (i = size-7 ; i < size ; i++)
  80011c:	ff 45 f4             	incl   -0xc(%ebp)
  80011f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800122:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800125:	72 d4                	jb     8000fb <_main+0xc3>
	{
		atomic_cprintf("x[%d] = %d\n",i,x[i]);
	}

	free(x);
  800127:	83 ec 0c             	sub    $0xc,%esp
  80012a:	ff 75 ec             	pushl  -0x14(%ebp)
  80012d:	e8 51 12 00 00       	call   801383 <free>
  800132:	83 c4 10             	add    $0x10,%esp
	
	return;	
  800135:	90                   	nop
}
  800136:	c9                   	leave  
  800137:	c3                   	ret    

00800138 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800138:	55                   	push   %ebp
  800139:	89 e5                	mov    %esp,%ebp
  80013b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80013e:	e8 26 14 00 00       	call   801569 <sys_getenvindex>
  800143:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800146:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800149:	89 d0                	mov    %edx,%eax
  80014b:	01 c0                	add    %eax,%eax
  80014d:	01 d0                	add    %edx,%eax
  80014f:	c1 e0 07             	shl    $0x7,%eax
  800152:	29 d0                	sub    %edx,%eax
  800154:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80015b:	01 c8                	add    %ecx,%eax
  80015d:	01 c0                	add    %eax,%eax
  80015f:	01 d0                	add    %edx,%eax
  800161:	01 c0                	add    %eax,%eax
  800163:	01 d0                	add    %edx,%eax
  800165:	c1 e0 03             	shl    $0x3,%eax
  800168:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80016d:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800172:	a1 20 30 80 00       	mov    0x803020,%eax
  800177:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  80017d:	84 c0                	test   %al,%al
  80017f:	74 0f                	je     800190 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800181:	a1 20 30 80 00       	mov    0x803020,%eax
  800186:	05 f0 ee 00 00       	add    $0xeef0,%eax
  80018b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800190:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800194:	7e 0a                	jle    8001a0 <libmain+0x68>
		binaryname = argv[0];
  800196:	8b 45 0c             	mov    0xc(%ebp),%eax
  800199:	8b 00                	mov    (%eax),%eax
  80019b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 0c             	pushl  0xc(%ebp)
  8001a6:	ff 75 08             	pushl  0x8(%ebp)
  8001a9:	e8 8a fe ff ff       	call   800038 <_main>
  8001ae:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001b1:	e8 4e 15 00 00       	call   801704 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001b6:	83 ec 0c             	sub    $0xc,%esp
  8001b9:	68 d8 1f 80 00       	push   $0x801fd8
  8001be:	e8 71 01 00 00       	call   800334 <cprintf>
  8001c3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001cb:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  8001d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d6:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  8001dc:	83 ec 04             	sub    $0x4,%esp
  8001df:	52                   	push   %edx
  8001e0:	50                   	push   %eax
  8001e1:	68 00 20 80 00       	push   $0x802000
  8001e6:	e8 49 01 00 00       	call   800334 <cprintf>
  8001eb:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8001ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f3:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  8001f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fe:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800204:	a1 20 30 80 00       	mov    0x803020,%eax
  800209:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  80020f:	51                   	push   %ecx
  800210:	52                   	push   %edx
  800211:	50                   	push   %eax
  800212:	68 28 20 80 00       	push   $0x802028
  800217:	e8 18 01 00 00       	call   800334 <cprintf>
  80021c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80021f:	83 ec 0c             	sub    $0xc,%esp
  800222:	68 d8 1f 80 00       	push   $0x801fd8
  800227:	e8 08 01 00 00       	call   800334 <cprintf>
  80022c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80022f:	e8 ea 14 00 00       	call   80171e <sys_enable_interrupt>

	// exit gracefully
	exit();
  800234:	e8 19 00 00 00       	call   800252 <exit>
}
  800239:	90                   	nop
  80023a:	c9                   	leave  
  80023b:	c3                   	ret    

0080023c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80023c:	55                   	push   %ebp
  80023d:	89 e5                	mov    %esp,%ebp
  80023f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	6a 00                	push   $0x0
  800247:	e8 e9 12 00 00       	call   801535 <sys_env_destroy>
  80024c:	83 c4 10             	add    $0x10,%esp
}
  80024f:	90                   	nop
  800250:	c9                   	leave  
  800251:	c3                   	ret    

00800252 <exit>:

void
exit(void)
{
  800252:	55                   	push   %ebp
  800253:	89 e5                	mov    %esp,%ebp
  800255:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800258:	e8 3e 13 00 00       	call   80159b <sys_env_exit>
}
  80025d:	90                   	nop
  80025e:	c9                   	leave  
  80025f:	c3                   	ret    

00800260 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800260:	55                   	push   %ebp
  800261:	89 e5                	mov    %esp,%ebp
  800263:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800266:	8b 45 0c             	mov    0xc(%ebp),%eax
  800269:	8b 00                	mov    (%eax),%eax
  80026b:	8d 48 01             	lea    0x1(%eax),%ecx
  80026e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800271:	89 0a                	mov    %ecx,(%edx)
  800273:	8b 55 08             	mov    0x8(%ebp),%edx
  800276:	88 d1                	mov    %dl,%cl
  800278:	8b 55 0c             	mov    0xc(%ebp),%edx
  80027b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80027f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800282:	8b 00                	mov    (%eax),%eax
  800284:	3d ff 00 00 00       	cmp    $0xff,%eax
  800289:	75 2c                	jne    8002b7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80028b:	a0 24 30 80 00       	mov    0x803024,%al
  800290:	0f b6 c0             	movzbl %al,%eax
  800293:	8b 55 0c             	mov    0xc(%ebp),%edx
  800296:	8b 12                	mov    (%edx),%edx
  800298:	89 d1                	mov    %edx,%ecx
  80029a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80029d:	83 c2 08             	add    $0x8,%edx
  8002a0:	83 ec 04             	sub    $0x4,%esp
  8002a3:	50                   	push   %eax
  8002a4:	51                   	push   %ecx
  8002a5:	52                   	push   %edx
  8002a6:	e8 48 12 00 00       	call   8014f3 <sys_cputs>
  8002ab:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ba:	8b 40 04             	mov    0x4(%eax),%eax
  8002bd:	8d 50 01             	lea    0x1(%eax),%edx
  8002c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002c6:	90                   	nop
  8002c7:	c9                   	leave  
  8002c8:	c3                   	ret    

008002c9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002c9:	55                   	push   %ebp
  8002ca:	89 e5                	mov    %esp,%ebp
  8002cc:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002d2:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002d9:	00 00 00 
	b.cnt = 0;
  8002dc:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002e3:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002e6:	ff 75 0c             	pushl  0xc(%ebp)
  8002e9:	ff 75 08             	pushl  0x8(%ebp)
  8002ec:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002f2:	50                   	push   %eax
  8002f3:	68 60 02 80 00       	push   $0x800260
  8002f8:	e8 11 02 00 00       	call   80050e <vprintfmt>
  8002fd:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800300:	a0 24 30 80 00       	mov    0x803024,%al
  800305:	0f b6 c0             	movzbl %al,%eax
  800308:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80030e:	83 ec 04             	sub    $0x4,%esp
  800311:	50                   	push   %eax
  800312:	52                   	push   %edx
  800313:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800319:	83 c0 08             	add    $0x8,%eax
  80031c:	50                   	push   %eax
  80031d:	e8 d1 11 00 00       	call   8014f3 <sys_cputs>
  800322:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800325:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80032c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800332:	c9                   	leave  
  800333:	c3                   	ret    

00800334 <cprintf>:

int cprintf(const char *fmt, ...) {
  800334:	55                   	push   %ebp
  800335:	89 e5                	mov    %esp,%ebp
  800337:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80033a:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800341:	8d 45 0c             	lea    0xc(%ebp),%eax
  800344:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800347:	8b 45 08             	mov    0x8(%ebp),%eax
  80034a:	83 ec 08             	sub    $0x8,%esp
  80034d:	ff 75 f4             	pushl  -0xc(%ebp)
  800350:	50                   	push   %eax
  800351:	e8 73 ff ff ff       	call   8002c9 <vcprintf>
  800356:	83 c4 10             	add    $0x10,%esp
  800359:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80035c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80035f:	c9                   	leave  
  800360:	c3                   	ret    

00800361 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800361:	55                   	push   %ebp
  800362:	89 e5                	mov    %esp,%ebp
  800364:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800367:	e8 98 13 00 00       	call   801704 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80036c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80036f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800372:	8b 45 08             	mov    0x8(%ebp),%eax
  800375:	83 ec 08             	sub    $0x8,%esp
  800378:	ff 75 f4             	pushl  -0xc(%ebp)
  80037b:	50                   	push   %eax
  80037c:	e8 48 ff ff ff       	call   8002c9 <vcprintf>
  800381:	83 c4 10             	add    $0x10,%esp
  800384:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800387:	e8 92 13 00 00       	call   80171e <sys_enable_interrupt>
	return cnt;
  80038c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80038f:	c9                   	leave  
  800390:	c3                   	ret    

00800391 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800391:	55                   	push   %ebp
  800392:	89 e5                	mov    %esp,%ebp
  800394:	53                   	push   %ebx
  800395:	83 ec 14             	sub    $0x14,%esp
  800398:	8b 45 10             	mov    0x10(%ebp),%eax
  80039b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80039e:	8b 45 14             	mov    0x14(%ebp),%eax
  8003a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003a4:	8b 45 18             	mov    0x18(%ebp),%eax
  8003a7:	ba 00 00 00 00       	mov    $0x0,%edx
  8003ac:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003af:	77 55                	ja     800406 <printnum+0x75>
  8003b1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003b4:	72 05                	jb     8003bb <printnum+0x2a>
  8003b6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003b9:	77 4b                	ja     800406 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003bb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003be:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003c1:	8b 45 18             	mov    0x18(%ebp),%eax
  8003c4:	ba 00 00 00 00       	mov    $0x0,%edx
  8003c9:	52                   	push   %edx
  8003ca:	50                   	push   %eax
  8003cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8003ce:	ff 75 f0             	pushl  -0x10(%ebp)
  8003d1:	e8 4e 19 00 00       	call   801d24 <__udivdi3>
  8003d6:	83 c4 10             	add    $0x10,%esp
  8003d9:	83 ec 04             	sub    $0x4,%esp
  8003dc:	ff 75 20             	pushl  0x20(%ebp)
  8003df:	53                   	push   %ebx
  8003e0:	ff 75 18             	pushl  0x18(%ebp)
  8003e3:	52                   	push   %edx
  8003e4:	50                   	push   %eax
  8003e5:	ff 75 0c             	pushl  0xc(%ebp)
  8003e8:	ff 75 08             	pushl  0x8(%ebp)
  8003eb:	e8 a1 ff ff ff       	call   800391 <printnum>
  8003f0:	83 c4 20             	add    $0x20,%esp
  8003f3:	eb 1a                	jmp    80040f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003f5:	83 ec 08             	sub    $0x8,%esp
  8003f8:	ff 75 0c             	pushl  0xc(%ebp)
  8003fb:	ff 75 20             	pushl  0x20(%ebp)
  8003fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800401:	ff d0                	call   *%eax
  800403:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800406:	ff 4d 1c             	decl   0x1c(%ebp)
  800409:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80040d:	7f e6                	jg     8003f5 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80040f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800412:	bb 00 00 00 00       	mov    $0x0,%ebx
  800417:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80041a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80041d:	53                   	push   %ebx
  80041e:	51                   	push   %ecx
  80041f:	52                   	push   %edx
  800420:	50                   	push   %eax
  800421:	e8 0e 1a 00 00       	call   801e34 <__umoddi3>
  800426:	83 c4 10             	add    $0x10,%esp
  800429:	05 94 22 80 00       	add    $0x802294,%eax
  80042e:	8a 00                	mov    (%eax),%al
  800430:	0f be c0             	movsbl %al,%eax
  800433:	83 ec 08             	sub    $0x8,%esp
  800436:	ff 75 0c             	pushl  0xc(%ebp)
  800439:	50                   	push   %eax
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	ff d0                	call   *%eax
  80043f:	83 c4 10             	add    $0x10,%esp
}
  800442:	90                   	nop
  800443:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800446:	c9                   	leave  
  800447:	c3                   	ret    

00800448 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800448:	55                   	push   %ebp
  800449:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80044b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80044f:	7e 1c                	jle    80046d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800451:	8b 45 08             	mov    0x8(%ebp),%eax
  800454:	8b 00                	mov    (%eax),%eax
  800456:	8d 50 08             	lea    0x8(%eax),%edx
  800459:	8b 45 08             	mov    0x8(%ebp),%eax
  80045c:	89 10                	mov    %edx,(%eax)
  80045e:	8b 45 08             	mov    0x8(%ebp),%eax
  800461:	8b 00                	mov    (%eax),%eax
  800463:	83 e8 08             	sub    $0x8,%eax
  800466:	8b 50 04             	mov    0x4(%eax),%edx
  800469:	8b 00                	mov    (%eax),%eax
  80046b:	eb 40                	jmp    8004ad <getuint+0x65>
	else if (lflag)
  80046d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800471:	74 1e                	je     800491 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	8b 00                	mov    (%eax),%eax
  800478:	8d 50 04             	lea    0x4(%eax),%edx
  80047b:	8b 45 08             	mov    0x8(%ebp),%eax
  80047e:	89 10                	mov    %edx,(%eax)
  800480:	8b 45 08             	mov    0x8(%ebp),%eax
  800483:	8b 00                	mov    (%eax),%eax
  800485:	83 e8 04             	sub    $0x4,%eax
  800488:	8b 00                	mov    (%eax),%eax
  80048a:	ba 00 00 00 00       	mov    $0x0,%edx
  80048f:	eb 1c                	jmp    8004ad <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800491:	8b 45 08             	mov    0x8(%ebp),%eax
  800494:	8b 00                	mov    (%eax),%eax
  800496:	8d 50 04             	lea    0x4(%eax),%edx
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	89 10                	mov    %edx,(%eax)
  80049e:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a1:	8b 00                	mov    (%eax),%eax
  8004a3:	83 e8 04             	sub    $0x4,%eax
  8004a6:	8b 00                	mov    (%eax),%eax
  8004a8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004ad:	5d                   	pop    %ebp
  8004ae:	c3                   	ret    

008004af <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004af:	55                   	push   %ebp
  8004b0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004b2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004b6:	7e 1c                	jle    8004d4 <getint+0x25>
		return va_arg(*ap, long long);
  8004b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bb:	8b 00                	mov    (%eax),%eax
  8004bd:	8d 50 08             	lea    0x8(%eax),%edx
  8004c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c3:	89 10                	mov    %edx,(%eax)
  8004c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c8:	8b 00                	mov    (%eax),%eax
  8004ca:	83 e8 08             	sub    $0x8,%eax
  8004cd:	8b 50 04             	mov    0x4(%eax),%edx
  8004d0:	8b 00                	mov    (%eax),%eax
  8004d2:	eb 38                	jmp    80050c <getint+0x5d>
	else if (lflag)
  8004d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004d8:	74 1a                	je     8004f4 <getint+0x45>
		return va_arg(*ap, long);
  8004da:	8b 45 08             	mov    0x8(%ebp),%eax
  8004dd:	8b 00                	mov    (%eax),%eax
  8004df:	8d 50 04             	lea    0x4(%eax),%edx
  8004e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e5:	89 10                	mov    %edx,(%eax)
  8004e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ea:	8b 00                	mov    (%eax),%eax
  8004ec:	83 e8 04             	sub    $0x4,%eax
  8004ef:	8b 00                	mov    (%eax),%eax
  8004f1:	99                   	cltd   
  8004f2:	eb 18                	jmp    80050c <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f7:	8b 00                	mov    (%eax),%eax
  8004f9:	8d 50 04             	lea    0x4(%eax),%edx
  8004fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ff:	89 10                	mov    %edx,(%eax)
  800501:	8b 45 08             	mov    0x8(%ebp),%eax
  800504:	8b 00                	mov    (%eax),%eax
  800506:	83 e8 04             	sub    $0x4,%eax
  800509:	8b 00                	mov    (%eax),%eax
  80050b:	99                   	cltd   
}
  80050c:	5d                   	pop    %ebp
  80050d:	c3                   	ret    

0080050e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80050e:	55                   	push   %ebp
  80050f:	89 e5                	mov    %esp,%ebp
  800511:	56                   	push   %esi
  800512:	53                   	push   %ebx
  800513:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800516:	eb 17                	jmp    80052f <vprintfmt+0x21>
			if (ch == '\0')
  800518:	85 db                	test   %ebx,%ebx
  80051a:	0f 84 af 03 00 00    	je     8008cf <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800520:	83 ec 08             	sub    $0x8,%esp
  800523:	ff 75 0c             	pushl  0xc(%ebp)
  800526:	53                   	push   %ebx
  800527:	8b 45 08             	mov    0x8(%ebp),%eax
  80052a:	ff d0                	call   *%eax
  80052c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80052f:	8b 45 10             	mov    0x10(%ebp),%eax
  800532:	8d 50 01             	lea    0x1(%eax),%edx
  800535:	89 55 10             	mov    %edx,0x10(%ebp)
  800538:	8a 00                	mov    (%eax),%al
  80053a:	0f b6 d8             	movzbl %al,%ebx
  80053d:	83 fb 25             	cmp    $0x25,%ebx
  800540:	75 d6                	jne    800518 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800542:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800546:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80054d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800554:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80055b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800562:	8b 45 10             	mov    0x10(%ebp),%eax
  800565:	8d 50 01             	lea    0x1(%eax),%edx
  800568:	89 55 10             	mov    %edx,0x10(%ebp)
  80056b:	8a 00                	mov    (%eax),%al
  80056d:	0f b6 d8             	movzbl %al,%ebx
  800570:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800573:	83 f8 55             	cmp    $0x55,%eax
  800576:	0f 87 2b 03 00 00    	ja     8008a7 <vprintfmt+0x399>
  80057c:	8b 04 85 b8 22 80 00 	mov    0x8022b8(,%eax,4),%eax
  800583:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800585:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800589:	eb d7                	jmp    800562 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80058b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80058f:	eb d1                	jmp    800562 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800591:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800598:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80059b:	89 d0                	mov    %edx,%eax
  80059d:	c1 e0 02             	shl    $0x2,%eax
  8005a0:	01 d0                	add    %edx,%eax
  8005a2:	01 c0                	add    %eax,%eax
  8005a4:	01 d8                	add    %ebx,%eax
  8005a6:	83 e8 30             	sub    $0x30,%eax
  8005a9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8005af:	8a 00                	mov    (%eax),%al
  8005b1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005b4:	83 fb 2f             	cmp    $0x2f,%ebx
  8005b7:	7e 3e                	jle    8005f7 <vprintfmt+0xe9>
  8005b9:	83 fb 39             	cmp    $0x39,%ebx
  8005bc:	7f 39                	jg     8005f7 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005be:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005c1:	eb d5                	jmp    800598 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c6:	83 c0 04             	add    $0x4,%eax
  8005c9:	89 45 14             	mov    %eax,0x14(%ebp)
  8005cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cf:	83 e8 04             	sub    $0x4,%eax
  8005d2:	8b 00                	mov    (%eax),%eax
  8005d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005d7:	eb 1f                	jmp    8005f8 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005d9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005dd:	79 83                	jns    800562 <vprintfmt+0x54>
				width = 0;
  8005df:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005e6:	e9 77 ff ff ff       	jmp    800562 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005eb:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005f2:	e9 6b ff ff ff       	jmp    800562 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005f7:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005fc:	0f 89 60 ff ff ff    	jns    800562 <vprintfmt+0x54>
				width = precision, precision = -1;
  800602:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800605:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800608:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80060f:	e9 4e ff ff ff       	jmp    800562 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800614:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800617:	e9 46 ff ff ff       	jmp    800562 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80061c:	8b 45 14             	mov    0x14(%ebp),%eax
  80061f:	83 c0 04             	add    $0x4,%eax
  800622:	89 45 14             	mov    %eax,0x14(%ebp)
  800625:	8b 45 14             	mov    0x14(%ebp),%eax
  800628:	83 e8 04             	sub    $0x4,%eax
  80062b:	8b 00                	mov    (%eax),%eax
  80062d:	83 ec 08             	sub    $0x8,%esp
  800630:	ff 75 0c             	pushl  0xc(%ebp)
  800633:	50                   	push   %eax
  800634:	8b 45 08             	mov    0x8(%ebp),%eax
  800637:	ff d0                	call   *%eax
  800639:	83 c4 10             	add    $0x10,%esp
			break;
  80063c:	e9 89 02 00 00       	jmp    8008ca <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800641:	8b 45 14             	mov    0x14(%ebp),%eax
  800644:	83 c0 04             	add    $0x4,%eax
  800647:	89 45 14             	mov    %eax,0x14(%ebp)
  80064a:	8b 45 14             	mov    0x14(%ebp),%eax
  80064d:	83 e8 04             	sub    $0x4,%eax
  800650:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800652:	85 db                	test   %ebx,%ebx
  800654:	79 02                	jns    800658 <vprintfmt+0x14a>
				err = -err;
  800656:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800658:	83 fb 64             	cmp    $0x64,%ebx
  80065b:	7f 0b                	jg     800668 <vprintfmt+0x15a>
  80065d:	8b 34 9d 00 21 80 00 	mov    0x802100(,%ebx,4),%esi
  800664:	85 f6                	test   %esi,%esi
  800666:	75 19                	jne    800681 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800668:	53                   	push   %ebx
  800669:	68 a5 22 80 00       	push   $0x8022a5
  80066e:	ff 75 0c             	pushl  0xc(%ebp)
  800671:	ff 75 08             	pushl  0x8(%ebp)
  800674:	e8 5e 02 00 00       	call   8008d7 <printfmt>
  800679:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80067c:	e9 49 02 00 00       	jmp    8008ca <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800681:	56                   	push   %esi
  800682:	68 ae 22 80 00       	push   $0x8022ae
  800687:	ff 75 0c             	pushl  0xc(%ebp)
  80068a:	ff 75 08             	pushl  0x8(%ebp)
  80068d:	e8 45 02 00 00       	call   8008d7 <printfmt>
  800692:	83 c4 10             	add    $0x10,%esp
			break;
  800695:	e9 30 02 00 00       	jmp    8008ca <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80069a:	8b 45 14             	mov    0x14(%ebp),%eax
  80069d:	83 c0 04             	add    $0x4,%eax
  8006a0:	89 45 14             	mov    %eax,0x14(%ebp)
  8006a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8006a6:	83 e8 04             	sub    $0x4,%eax
  8006a9:	8b 30                	mov    (%eax),%esi
  8006ab:	85 f6                	test   %esi,%esi
  8006ad:	75 05                	jne    8006b4 <vprintfmt+0x1a6>
				p = "(null)";
  8006af:	be b1 22 80 00       	mov    $0x8022b1,%esi
			if (width > 0 && padc != '-')
  8006b4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006b8:	7e 6d                	jle    800727 <vprintfmt+0x219>
  8006ba:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006be:	74 67                	je     800727 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006c3:	83 ec 08             	sub    $0x8,%esp
  8006c6:	50                   	push   %eax
  8006c7:	56                   	push   %esi
  8006c8:	e8 0c 03 00 00       	call   8009d9 <strnlen>
  8006cd:	83 c4 10             	add    $0x10,%esp
  8006d0:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006d3:	eb 16                	jmp    8006eb <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006d5:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006d9:	83 ec 08             	sub    $0x8,%esp
  8006dc:	ff 75 0c             	pushl  0xc(%ebp)
  8006df:	50                   	push   %eax
  8006e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e3:	ff d0                	call   *%eax
  8006e5:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006e8:	ff 4d e4             	decl   -0x1c(%ebp)
  8006eb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ef:	7f e4                	jg     8006d5 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006f1:	eb 34                	jmp    800727 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006f3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006f7:	74 1c                	je     800715 <vprintfmt+0x207>
  8006f9:	83 fb 1f             	cmp    $0x1f,%ebx
  8006fc:	7e 05                	jle    800703 <vprintfmt+0x1f5>
  8006fe:	83 fb 7e             	cmp    $0x7e,%ebx
  800701:	7e 12                	jle    800715 <vprintfmt+0x207>
					putch('?', putdat);
  800703:	83 ec 08             	sub    $0x8,%esp
  800706:	ff 75 0c             	pushl  0xc(%ebp)
  800709:	6a 3f                	push   $0x3f
  80070b:	8b 45 08             	mov    0x8(%ebp),%eax
  80070e:	ff d0                	call   *%eax
  800710:	83 c4 10             	add    $0x10,%esp
  800713:	eb 0f                	jmp    800724 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800715:	83 ec 08             	sub    $0x8,%esp
  800718:	ff 75 0c             	pushl  0xc(%ebp)
  80071b:	53                   	push   %ebx
  80071c:	8b 45 08             	mov    0x8(%ebp),%eax
  80071f:	ff d0                	call   *%eax
  800721:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800724:	ff 4d e4             	decl   -0x1c(%ebp)
  800727:	89 f0                	mov    %esi,%eax
  800729:	8d 70 01             	lea    0x1(%eax),%esi
  80072c:	8a 00                	mov    (%eax),%al
  80072e:	0f be d8             	movsbl %al,%ebx
  800731:	85 db                	test   %ebx,%ebx
  800733:	74 24                	je     800759 <vprintfmt+0x24b>
  800735:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800739:	78 b8                	js     8006f3 <vprintfmt+0x1e5>
  80073b:	ff 4d e0             	decl   -0x20(%ebp)
  80073e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800742:	79 af                	jns    8006f3 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800744:	eb 13                	jmp    800759 <vprintfmt+0x24b>
				putch(' ', putdat);
  800746:	83 ec 08             	sub    $0x8,%esp
  800749:	ff 75 0c             	pushl  0xc(%ebp)
  80074c:	6a 20                	push   $0x20
  80074e:	8b 45 08             	mov    0x8(%ebp),%eax
  800751:	ff d0                	call   *%eax
  800753:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800756:	ff 4d e4             	decl   -0x1c(%ebp)
  800759:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80075d:	7f e7                	jg     800746 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80075f:	e9 66 01 00 00       	jmp    8008ca <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800764:	83 ec 08             	sub    $0x8,%esp
  800767:	ff 75 e8             	pushl  -0x18(%ebp)
  80076a:	8d 45 14             	lea    0x14(%ebp),%eax
  80076d:	50                   	push   %eax
  80076e:	e8 3c fd ff ff       	call   8004af <getint>
  800773:	83 c4 10             	add    $0x10,%esp
  800776:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800779:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80077c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80077f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800782:	85 d2                	test   %edx,%edx
  800784:	79 23                	jns    8007a9 <vprintfmt+0x29b>
				putch('-', putdat);
  800786:	83 ec 08             	sub    $0x8,%esp
  800789:	ff 75 0c             	pushl  0xc(%ebp)
  80078c:	6a 2d                	push   $0x2d
  80078e:	8b 45 08             	mov    0x8(%ebp),%eax
  800791:	ff d0                	call   *%eax
  800793:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800796:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800799:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80079c:	f7 d8                	neg    %eax
  80079e:	83 d2 00             	adc    $0x0,%edx
  8007a1:	f7 da                	neg    %edx
  8007a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007a9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007b0:	e9 bc 00 00 00       	jmp    800871 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007b5:	83 ec 08             	sub    $0x8,%esp
  8007b8:	ff 75 e8             	pushl  -0x18(%ebp)
  8007bb:	8d 45 14             	lea    0x14(%ebp),%eax
  8007be:	50                   	push   %eax
  8007bf:	e8 84 fc ff ff       	call   800448 <getuint>
  8007c4:	83 c4 10             	add    $0x10,%esp
  8007c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007cd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007d4:	e9 98 00 00 00       	jmp    800871 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007d9:	83 ec 08             	sub    $0x8,%esp
  8007dc:	ff 75 0c             	pushl  0xc(%ebp)
  8007df:	6a 58                	push   $0x58
  8007e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e4:	ff d0                	call   *%eax
  8007e6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007e9:	83 ec 08             	sub    $0x8,%esp
  8007ec:	ff 75 0c             	pushl  0xc(%ebp)
  8007ef:	6a 58                	push   $0x58
  8007f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f4:	ff d0                	call   *%eax
  8007f6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007f9:	83 ec 08             	sub    $0x8,%esp
  8007fc:	ff 75 0c             	pushl  0xc(%ebp)
  8007ff:	6a 58                	push   $0x58
  800801:	8b 45 08             	mov    0x8(%ebp),%eax
  800804:	ff d0                	call   *%eax
  800806:	83 c4 10             	add    $0x10,%esp
			break;
  800809:	e9 bc 00 00 00       	jmp    8008ca <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80080e:	83 ec 08             	sub    $0x8,%esp
  800811:	ff 75 0c             	pushl  0xc(%ebp)
  800814:	6a 30                	push   $0x30
  800816:	8b 45 08             	mov    0x8(%ebp),%eax
  800819:	ff d0                	call   *%eax
  80081b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80081e:	83 ec 08             	sub    $0x8,%esp
  800821:	ff 75 0c             	pushl  0xc(%ebp)
  800824:	6a 78                	push   $0x78
  800826:	8b 45 08             	mov    0x8(%ebp),%eax
  800829:	ff d0                	call   *%eax
  80082b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80082e:	8b 45 14             	mov    0x14(%ebp),%eax
  800831:	83 c0 04             	add    $0x4,%eax
  800834:	89 45 14             	mov    %eax,0x14(%ebp)
  800837:	8b 45 14             	mov    0x14(%ebp),%eax
  80083a:	83 e8 04             	sub    $0x4,%eax
  80083d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80083f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800842:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800849:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800850:	eb 1f                	jmp    800871 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800852:	83 ec 08             	sub    $0x8,%esp
  800855:	ff 75 e8             	pushl  -0x18(%ebp)
  800858:	8d 45 14             	lea    0x14(%ebp),%eax
  80085b:	50                   	push   %eax
  80085c:	e8 e7 fb ff ff       	call   800448 <getuint>
  800861:	83 c4 10             	add    $0x10,%esp
  800864:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800867:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80086a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800871:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800875:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800878:	83 ec 04             	sub    $0x4,%esp
  80087b:	52                   	push   %edx
  80087c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80087f:	50                   	push   %eax
  800880:	ff 75 f4             	pushl  -0xc(%ebp)
  800883:	ff 75 f0             	pushl  -0x10(%ebp)
  800886:	ff 75 0c             	pushl  0xc(%ebp)
  800889:	ff 75 08             	pushl  0x8(%ebp)
  80088c:	e8 00 fb ff ff       	call   800391 <printnum>
  800891:	83 c4 20             	add    $0x20,%esp
			break;
  800894:	eb 34                	jmp    8008ca <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800896:	83 ec 08             	sub    $0x8,%esp
  800899:	ff 75 0c             	pushl  0xc(%ebp)
  80089c:	53                   	push   %ebx
  80089d:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a0:	ff d0                	call   *%eax
  8008a2:	83 c4 10             	add    $0x10,%esp
			break;
  8008a5:	eb 23                	jmp    8008ca <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008a7:	83 ec 08             	sub    $0x8,%esp
  8008aa:	ff 75 0c             	pushl  0xc(%ebp)
  8008ad:	6a 25                	push   $0x25
  8008af:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b2:	ff d0                	call   *%eax
  8008b4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008b7:	ff 4d 10             	decl   0x10(%ebp)
  8008ba:	eb 03                	jmp    8008bf <vprintfmt+0x3b1>
  8008bc:	ff 4d 10             	decl   0x10(%ebp)
  8008bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c2:	48                   	dec    %eax
  8008c3:	8a 00                	mov    (%eax),%al
  8008c5:	3c 25                	cmp    $0x25,%al
  8008c7:	75 f3                	jne    8008bc <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008c9:	90                   	nop
		}
	}
  8008ca:	e9 47 fc ff ff       	jmp    800516 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008cf:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008d3:	5b                   	pop    %ebx
  8008d4:	5e                   	pop    %esi
  8008d5:	5d                   	pop    %ebp
  8008d6:	c3                   	ret    

008008d7 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008d7:	55                   	push   %ebp
  8008d8:	89 e5                	mov    %esp,%ebp
  8008da:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008dd:	8d 45 10             	lea    0x10(%ebp),%eax
  8008e0:	83 c0 04             	add    $0x4,%eax
  8008e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ec:	50                   	push   %eax
  8008ed:	ff 75 0c             	pushl  0xc(%ebp)
  8008f0:	ff 75 08             	pushl  0x8(%ebp)
  8008f3:	e8 16 fc ff ff       	call   80050e <vprintfmt>
  8008f8:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008fb:	90                   	nop
  8008fc:	c9                   	leave  
  8008fd:	c3                   	ret    

008008fe <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008fe:	55                   	push   %ebp
  8008ff:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800901:	8b 45 0c             	mov    0xc(%ebp),%eax
  800904:	8b 40 08             	mov    0x8(%eax),%eax
  800907:	8d 50 01             	lea    0x1(%eax),%edx
  80090a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800910:	8b 45 0c             	mov    0xc(%ebp),%eax
  800913:	8b 10                	mov    (%eax),%edx
  800915:	8b 45 0c             	mov    0xc(%ebp),%eax
  800918:	8b 40 04             	mov    0x4(%eax),%eax
  80091b:	39 c2                	cmp    %eax,%edx
  80091d:	73 12                	jae    800931 <sprintputch+0x33>
		*b->buf++ = ch;
  80091f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800922:	8b 00                	mov    (%eax),%eax
  800924:	8d 48 01             	lea    0x1(%eax),%ecx
  800927:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092a:	89 0a                	mov    %ecx,(%edx)
  80092c:	8b 55 08             	mov    0x8(%ebp),%edx
  80092f:	88 10                	mov    %dl,(%eax)
}
  800931:	90                   	nop
  800932:	5d                   	pop    %ebp
  800933:	c3                   	ret    

00800934 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800934:	55                   	push   %ebp
  800935:	89 e5                	mov    %esp,%ebp
  800937:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80093a:	8b 45 08             	mov    0x8(%ebp),%eax
  80093d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800940:	8b 45 0c             	mov    0xc(%ebp),%eax
  800943:	8d 50 ff             	lea    -0x1(%eax),%edx
  800946:	8b 45 08             	mov    0x8(%ebp),%eax
  800949:	01 d0                	add    %edx,%eax
  80094b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80094e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800955:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800959:	74 06                	je     800961 <vsnprintf+0x2d>
  80095b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80095f:	7f 07                	jg     800968 <vsnprintf+0x34>
		return -E_INVAL;
  800961:	b8 03 00 00 00       	mov    $0x3,%eax
  800966:	eb 20                	jmp    800988 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800968:	ff 75 14             	pushl  0x14(%ebp)
  80096b:	ff 75 10             	pushl  0x10(%ebp)
  80096e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800971:	50                   	push   %eax
  800972:	68 fe 08 80 00       	push   $0x8008fe
  800977:	e8 92 fb ff ff       	call   80050e <vprintfmt>
  80097c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80097f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800982:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800985:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800988:	c9                   	leave  
  800989:	c3                   	ret    

0080098a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80098a:	55                   	push   %ebp
  80098b:	89 e5                	mov    %esp,%ebp
  80098d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800990:	8d 45 10             	lea    0x10(%ebp),%eax
  800993:	83 c0 04             	add    $0x4,%eax
  800996:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800999:	8b 45 10             	mov    0x10(%ebp),%eax
  80099c:	ff 75 f4             	pushl  -0xc(%ebp)
  80099f:	50                   	push   %eax
  8009a0:	ff 75 0c             	pushl  0xc(%ebp)
  8009a3:	ff 75 08             	pushl  0x8(%ebp)
  8009a6:	e8 89 ff ff ff       	call   800934 <vsnprintf>
  8009ab:	83 c4 10             	add    $0x10,%esp
  8009ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009b4:	c9                   	leave  
  8009b5:	c3                   	ret    

008009b6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8009b6:	55                   	push   %ebp
  8009b7:	89 e5                	mov    %esp,%ebp
  8009b9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009c3:	eb 06                	jmp    8009cb <strlen+0x15>
		n++;
  8009c5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009c8:	ff 45 08             	incl   0x8(%ebp)
  8009cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ce:	8a 00                	mov    (%eax),%al
  8009d0:	84 c0                	test   %al,%al
  8009d2:	75 f1                	jne    8009c5 <strlen+0xf>
		n++;
	return n;
  8009d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009d7:	c9                   	leave  
  8009d8:	c3                   	ret    

008009d9 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009d9:	55                   	push   %ebp
  8009da:	89 e5                	mov    %esp,%ebp
  8009dc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009e6:	eb 09                	jmp    8009f1 <strnlen+0x18>
		n++;
  8009e8:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009eb:	ff 45 08             	incl   0x8(%ebp)
  8009ee:	ff 4d 0c             	decl   0xc(%ebp)
  8009f1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009f5:	74 09                	je     800a00 <strnlen+0x27>
  8009f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fa:	8a 00                	mov    (%eax),%al
  8009fc:	84 c0                	test   %al,%al
  8009fe:	75 e8                	jne    8009e8 <strnlen+0xf>
		n++;
	return n;
  800a00:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a03:	c9                   	leave  
  800a04:	c3                   	ret    

00800a05 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a05:	55                   	push   %ebp
  800a06:	89 e5                	mov    %esp,%ebp
  800a08:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a11:	90                   	nop
  800a12:	8b 45 08             	mov    0x8(%ebp),%eax
  800a15:	8d 50 01             	lea    0x1(%eax),%edx
  800a18:	89 55 08             	mov    %edx,0x8(%ebp)
  800a1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a1e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a21:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a24:	8a 12                	mov    (%edx),%dl
  800a26:	88 10                	mov    %dl,(%eax)
  800a28:	8a 00                	mov    (%eax),%al
  800a2a:	84 c0                	test   %al,%al
  800a2c:	75 e4                	jne    800a12 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a31:	c9                   	leave  
  800a32:	c3                   	ret    

00800a33 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a33:	55                   	push   %ebp
  800a34:	89 e5                	mov    %esp,%ebp
  800a36:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a39:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a3f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a46:	eb 1f                	jmp    800a67 <strncpy+0x34>
		*dst++ = *src;
  800a48:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4b:	8d 50 01             	lea    0x1(%eax),%edx
  800a4e:	89 55 08             	mov    %edx,0x8(%ebp)
  800a51:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a54:	8a 12                	mov    (%edx),%dl
  800a56:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5b:	8a 00                	mov    (%eax),%al
  800a5d:	84 c0                	test   %al,%al
  800a5f:	74 03                	je     800a64 <strncpy+0x31>
			src++;
  800a61:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a64:	ff 45 fc             	incl   -0x4(%ebp)
  800a67:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a6a:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a6d:	72 d9                	jb     800a48 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a6f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a72:	c9                   	leave  
  800a73:	c3                   	ret    

00800a74 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a74:	55                   	push   %ebp
  800a75:	89 e5                	mov    %esp,%ebp
  800a77:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a80:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a84:	74 30                	je     800ab6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a86:	eb 16                	jmp    800a9e <strlcpy+0x2a>
			*dst++ = *src++;
  800a88:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8b:	8d 50 01             	lea    0x1(%eax),%edx
  800a8e:	89 55 08             	mov    %edx,0x8(%ebp)
  800a91:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a94:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a97:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a9a:	8a 12                	mov    (%edx),%dl
  800a9c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a9e:	ff 4d 10             	decl   0x10(%ebp)
  800aa1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aa5:	74 09                	je     800ab0 <strlcpy+0x3c>
  800aa7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aaa:	8a 00                	mov    (%eax),%al
  800aac:	84 c0                	test   %al,%al
  800aae:	75 d8                	jne    800a88 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ab6:	8b 55 08             	mov    0x8(%ebp),%edx
  800ab9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800abc:	29 c2                	sub    %eax,%edx
  800abe:	89 d0                	mov    %edx,%eax
}
  800ac0:	c9                   	leave  
  800ac1:	c3                   	ret    

00800ac2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ac2:	55                   	push   %ebp
  800ac3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ac5:	eb 06                	jmp    800acd <strcmp+0xb>
		p++, q++;
  800ac7:	ff 45 08             	incl   0x8(%ebp)
  800aca:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800acd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad0:	8a 00                	mov    (%eax),%al
  800ad2:	84 c0                	test   %al,%al
  800ad4:	74 0e                	je     800ae4 <strcmp+0x22>
  800ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad9:	8a 10                	mov    (%eax),%dl
  800adb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ade:	8a 00                	mov    (%eax),%al
  800ae0:	38 c2                	cmp    %al,%dl
  800ae2:	74 e3                	je     800ac7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae7:	8a 00                	mov    (%eax),%al
  800ae9:	0f b6 d0             	movzbl %al,%edx
  800aec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aef:	8a 00                	mov    (%eax),%al
  800af1:	0f b6 c0             	movzbl %al,%eax
  800af4:	29 c2                	sub    %eax,%edx
  800af6:	89 d0                	mov    %edx,%eax
}
  800af8:	5d                   	pop    %ebp
  800af9:	c3                   	ret    

00800afa <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800afa:	55                   	push   %ebp
  800afb:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800afd:	eb 09                	jmp    800b08 <strncmp+0xe>
		n--, p++, q++;
  800aff:	ff 4d 10             	decl   0x10(%ebp)
  800b02:	ff 45 08             	incl   0x8(%ebp)
  800b05:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b08:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b0c:	74 17                	je     800b25 <strncmp+0x2b>
  800b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b11:	8a 00                	mov    (%eax),%al
  800b13:	84 c0                	test   %al,%al
  800b15:	74 0e                	je     800b25 <strncmp+0x2b>
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1a:	8a 10                	mov    (%eax),%dl
  800b1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1f:	8a 00                	mov    (%eax),%al
  800b21:	38 c2                	cmp    %al,%dl
  800b23:	74 da                	je     800aff <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b25:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b29:	75 07                	jne    800b32 <strncmp+0x38>
		return 0;
  800b2b:	b8 00 00 00 00       	mov    $0x0,%eax
  800b30:	eb 14                	jmp    800b46 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	8a 00                	mov    (%eax),%al
  800b37:	0f b6 d0             	movzbl %al,%edx
  800b3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3d:	8a 00                	mov    (%eax),%al
  800b3f:	0f b6 c0             	movzbl %al,%eax
  800b42:	29 c2                	sub    %eax,%edx
  800b44:	89 d0                	mov    %edx,%eax
}
  800b46:	5d                   	pop    %ebp
  800b47:	c3                   	ret    

00800b48 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b48:	55                   	push   %ebp
  800b49:	89 e5                	mov    %esp,%ebp
  800b4b:	83 ec 04             	sub    $0x4,%esp
  800b4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b51:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b54:	eb 12                	jmp    800b68 <strchr+0x20>
		if (*s == c)
  800b56:	8b 45 08             	mov    0x8(%ebp),%eax
  800b59:	8a 00                	mov    (%eax),%al
  800b5b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b5e:	75 05                	jne    800b65 <strchr+0x1d>
			return (char *) s;
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	eb 11                	jmp    800b76 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b65:	ff 45 08             	incl   0x8(%ebp)
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	8a 00                	mov    (%eax),%al
  800b6d:	84 c0                	test   %al,%al
  800b6f:	75 e5                	jne    800b56 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b71:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b76:	c9                   	leave  
  800b77:	c3                   	ret    

00800b78 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b78:	55                   	push   %ebp
  800b79:	89 e5                	mov    %esp,%ebp
  800b7b:	83 ec 04             	sub    $0x4,%esp
  800b7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b81:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b84:	eb 0d                	jmp    800b93 <strfind+0x1b>
		if (*s == c)
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
  800b89:	8a 00                	mov    (%eax),%al
  800b8b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b8e:	74 0e                	je     800b9e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b90:	ff 45 08             	incl   0x8(%ebp)
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	8a 00                	mov    (%eax),%al
  800b98:	84 c0                	test   %al,%al
  800b9a:	75 ea                	jne    800b86 <strfind+0xe>
  800b9c:	eb 01                	jmp    800b9f <strfind+0x27>
		if (*s == c)
			break;
  800b9e:	90                   	nop
	return (char *) s;
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ba2:	c9                   	leave  
  800ba3:	c3                   	ret    

00800ba4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ba4:	55                   	push   %ebp
  800ba5:	89 e5                	mov    %esp,%ebp
  800ba7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800baa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800bb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800bb6:	eb 0e                	jmp    800bc6 <memset+0x22>
		*p++ = c;
  800bb8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bbb:	8d 50 01             	lea    0x1(%eax),%edx
  800bbe:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800bc1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc4:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bc6:	ff 4d f8             	decl   -0x8(%ebp)
  800bc9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bcd:	79 e9                	jns    800bb8 <memset+0x14>
		*p++ = c;

	return v;
  800bcf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bd2:	c9                   	leave  
  800bd3:	c3                   	ret    

00800bd4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bd4:	55                   	push   %ebp
  800bd5:	89 e5                	mov    %esp,%ebp
  800bd7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800be6:	eb 16                	jmp    800bfe <memcpy+0x2a>
		*d++ = *s++;
  800be8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800beb:	8d 50 01             	lea    0x1(%eax),%edx
  800bee:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bf1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bf4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bf7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bfa:	8a 12                	mov    (%edx),%dl
  800bfc:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800bfe:	8b 45 10             	mov    0x10(%ebp),%eax
  800c01:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c04:	89 55 10             	mov    %edx,0x10(%ebp)
  800c07:	85 c0                	test   %eax,%eax
  800c09:	75 dd                	jne    800be8 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c0e:	c9                   	leave  
  800c0f:	c3                   	ret    

00800c10 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c10:	55                   	push   %ebp
  800c11:	89 e5                	mov    %esp,%ebp
  800c13:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c19:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c25:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c28:	73 50                	jae    800c7a <memmove+0x6a>
  800c2a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c30:	01 d0                	add    %edx,%eax
  800c32:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c35:	76 43                	jbe    800c7a <memmove+0x6a>
		s += n;
  800c37:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c40:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c43:	eb 10                	jmp    800c55 <memmove+0x45>
			*--d = *--s;
  800c45:	ff 4d f8             	decl   -0x8(%ebp)
  800c48:	ff 4d fc             	decl   -0x4(%ebp)
  800c4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c4e:	8a 10                	mov    (%eax),%dl
  800c50:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c53:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c55:	8b 45 10             	mov    0x10(%ebp),%eax
  800c58:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c5b:	89 55 10             	mov    %edx,0x10(%ebp)
  800c5e:	85 c0                	test   %eax,%eax
  800c60:	75 e3                	jne    800c45 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c62:	eb 23                	jmp    800c87 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c64:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c67:	8d 50 01             	lea    0x1(%eax),%edx
  800c6a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c6d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c70:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c73:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c76:	8a 12                	mov    (%edx),%dl
  800c78:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c80:	89 55 10             	mov    %edx,0x10(%ebp)
  800c83:	85 c0                	test   %eax,%eax
  800c85:	75 dd                	jne    800c64 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c8a:	c9                   	leave  
  800c8b:	c3                   	ret    

00800c8c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c8c:	55                   	push   %ebp
  800c8d:	89 e5                	mov    %esp,%ebp
  800c8f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c92:	8b 45 08             	mov    0x8(%ebp),%eax
  800c95:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c9e:	eb 2a                	jmp    800cca <memcmp+0x3e>
		if (*s1 != *s2)
  800ca0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ca3:	8a 10                	mov    (%eax),%dl
  800ca5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ca8:	8a 00                	mov    (%eax),%al
  800caa:	38 c2                	cmp    %al,%dl
  800cac:	74 16                	je     800cc4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb1:	8a 00                	mov    (%eax),%al
  800cb3:	0f b6 d0             	movzbl %al,%edx
  800cb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cb9:	8a 00                	mov    (%eax),%al
  800cbb:	0f b6 c0             	movzbl %al,%eax
  800cbe:	29 c2                	sub    %eax,%edx
  800cc0:	89 d0                	mov    %edx,%eax
  800cc2:	eb 18                	jmp    800cdc <memcmp+0x50>
		s1++, s2++;
  800cc4:	ff 45 fc             	incl   -0x4(%ebp)
  800cc7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cca:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cd0:	89 55 10             	mov    %edx,0x10(%ebp)
  800cd3:	85 c0                	test   %eax,%eax
  800cd5:	75 c9                	jne    800ca0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800cd7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cdc:	c9                   	leave  
  800cdd:	c3                   	ret    

00800cde <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800cde:	55                   	push   %ebp
  800cdf:	89 e5                	mov    %esp,%ebp
  800ce1:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ce4:	8b 55 08             	mov    0x8(%ebp),%edx
  800ce7:	8b 45 10             	mov    0x10(%ebp),%eax
  800cea:	01 d0                	add    %edx,%eax
  800cec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cef:	eb 15                	jmp    800d06 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	8a 00                	mov    (%eax),%al
  800cf6:	0f b6 d0             	movzbl %al,%edx
  800cf9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfc:	0f b6 c0             	movzbl %al,%eax
  800cff:	39 c2                	cmp    %eax,%edx
  800d01:	74 0d                	je     800d10 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d03:	ff 45 08             	incl   0x8(%ebp)
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d0c:	72 e3                	jb     800cf1 <memfind+0x13>
  800d0e:	eb 01                	jmp    800d11 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d10:	90                   	nop
	return (void *) s;
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d14:	c9                   	leave  
  800d15:	c3                   	ret    

00800d16 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d16:	55                   	push   %ebp
  800d17:	89 e5                	mov    %esp,%ebp
  800d19:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d1c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d23:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d2a:	eb 03                	jmp    800d2f <strtol+0x19>
		s++;
  800d2c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8a 00                	mov    (%eax),%al
  800d34:	3c 20                	cmp    $0x20,%al
  800d36:	74 f4                	je     800d2c <strtol+0x16>
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	8a 00                	mov    (%eax),%al
  800d3d:	3c 09                	cmp    $0x9,%al
  800d3f:	74 eb                	je     800d2c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d41:	8b 45 08             	mov    0x8(%ebp),%eax
  800d44:	8a 00                	mov    (%eax),%al
  800d46:	3c 2b                	cmp    $0x2b,%al
  800d48:	75 05                	jne    800d4f <strtol+0x39>
		s++;
  800d4a:	ff 45 08             	incl   0x8(%ebp)
  800d4d:	eb 13                	jmp    800d62 <strtol+0x4c>
	else if (*s == '-')
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	3c 2d                	cmp    $0x2d,%al
  800d56:	75 0a                	jne    800d62 <strtol+0x4c>
		s++, neg = 1;
  800d58:	ff 45 08             	incl   0x8(%ebp)
  800d5b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d62:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d66:	74 06                	je     800d6e <strtol+0x58>
  800d68:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d6c:	75 20                	jne    800d8e <strtol+0x78>
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	8a 00                	mov    (%eax),%al
  800d73:	3c 30                	cmp    $0x30,%al
  800d75:	75 17                	jne    800d8e <strtol+0x78>
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	40                   	inc    %eax
  800d7b:	8a 00                	mov    (%eax),%al
  800d7d:	3c 78                	cmp    $0x78,%al
  800d7f:	75 0d                	jne    800d8e <strtol+0x78>
		s += 2, base = 16;
  800d81:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d85:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d8c:	eb 28                	jmp    800db6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d92:	75 15                	jne    800da9 <strtol+0x93>
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	8a 00                	mov    (%eax),%al
  800d99:	3c 30                	cmp    $0x30,%al
  800d9b:	75 0c                	jne    800da9 <strtol+0x93>
		s++, base = 8;
  800d9d:	ff 45 08             	incl   0x8(%ebp)
  800da0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800da7:	eb 0d                	jmp    800db6 <strtol+0xa0>
	else if (base == 0)
  800da9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dad:	75 07                	jne    800db6 <strtol+0xa0>
		base = 10;
  800daf:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800db6:	8b 45 08             	mov    0x8(%ebp),%eax
  800db9:	8a 00                	mov    (%eax),%al
  800dbb:	3c 2f                	cmp    $0x2f,%al
  800dbd:	7e 19                	jle    800dd8 <strtol+0xc2>
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	8a 00                	mov    (%eax),%al
  800dc4:	3c 39                	cmp    $0x39,%al
  800dc6:	7f 10                	jg     800dd8 <strtol+0xc2>
			dig = *s - '0';
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	8a 00                	mov    (%eax),%al
  800dcd:	0f be c0             	movsbl %al,%eax
  800dd0:	83 e8 30             	sub    $0x30,%eax
  800dd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dd6:	eb 42                	jmp    800e1a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	8a 00                	mov    (%eax),%al
  800ddd:	3c 60                	cmp    $0x60,%al
  800ddf:	7e 19                	jle    800dfa <strtol+0xe4>
  800de1:	8b 45 08             	mov    0x8(%ebp),%eax
  800de4:	8a 00                	mov    (%eax),%al
  800de6:	3c 7a                	cmp    $0x7a,%al
  800de8:	7f 10                	jg     800dfa <strtol+0xe4>
			dig = *s - 'a' + 10;
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	8a 00                	mov    (%eax),%al
  800def:	0f be c0             	movsbl %al,%eax
  800df2:	83 e8 57             	sub    $0x57,%eax
  800df5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800df8:	eb 20                	jmp    800e1a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfd:	8a 00                	mov    (%eax),%al
  800dff:	3c 40                	cmp    $0x40,%al
  800e01:	7e 39                	jle    800e3c <strtol+0x126>
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	8a 00                	mov    (%eax),%al
  800e08:	3c 5a                	cmp    $0x5a,%al
  800e0a:	7f 30                	jg     800e3c <strtol+0x126>
			dig = *s - 'A' + 10;
  800e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0f:	8a 00                	mov    (%eax),%al
  800e11:	0f be c0             	movsbl %al,%eax
  800e14:	83 e8 37             	sub    $0x37,%eax
  800e17:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e1d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e20:	7d 19                	jge    800e3b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e22:	ff 45 08             	incl   0x8(%ebp)
  800e25:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e28:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e2c:	89 c2                	mov    %eax,%edx
  800e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e31:	01 d0                	add    %edx,%eax
  800e33:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e36:	e9 7b ff ff ff       	jmp    800db6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e3b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e3c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e40:	74 08                	je     800e4a <strtol+0x134>
		*endptr = (char *) s;
  800e42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e45:	8b 55 08             	mov    0x8(%ebp),%edx
  800e48:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e4a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e4e:	74 07                	je     800e57 <strtol+0x141>
  800e50:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e53:	f7 d8                	neg    %eax
  800e55:	eb 03                	jmp    800e5a <strtol+0x144>
  800e57:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e5a:	c9                   	leave  
  800e5b:	c3                   	ret    

00800e5c <ltostr>:

void
ltostr(long value, char *str)
{
  800e5c:	55                   	push   %ebp
  800e5d:	89 e5                	mov    %esp,%ebp
  800e5f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e62:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e69:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e70:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e74:	79 13                	jns    800e89 <ltostr+0x2d>
	{
		neg = 1;
  800e76:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e80:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e83:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e86:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e89:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e91:	99                   	cltd   
  800e92:	f7 f9                	idiv   %ecx
  800e94:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e97:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9a:	8d 50 01             	lea    0x1(%eax),%edx
  800e9d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ea0:	89 c2                	mov    %eax,%edx
  800ea2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea5:	01 d0                	add    %edx,%eax
  800ea7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800eaa:	83 c2 30             	add    $0x30,%edx
  800ead:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800eaf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800eb2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800eb7:	f7 e9                	imul   %ecx
  800eb9:	c1 fa 02             	sar    $0x2,%edx
  800ebc:	89 c8                	mov    %ecx,%eax
  800ebe:	c1 f8 1f             	sar    $0x1f,%eax
  800ec1:	29 c2                	sub    %eax,%edx
  800ec3:	89 d0                	mov    %edx,%eax
  800ec5:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ec8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ecb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ed0:	f7 e9                	imul   %ecx
  800ed2:	c1 fa 02             	sar    $0x2,%edx
  800ed5:	89 c8                	mov    %ecx,%eax
  800ed7:	c1 f8 1f             	sar    $0x1f,%eax
  800eda:	29 c2                	sub    %eax,%edx
  800edc:	89 d0                	mov    %edx,%eax
  800ede:	c1 e0 02             	shl    $0x2,%eax
  800ee1:	01 d0                	add    %edx,%eax
  800ee3:	01 c0                	add    %eax,%eax
  800ee5:	29 c1                	sub    %eax,%ecx
  800ee7:	89 ca                	mov    %ecx,%edx
  800ee9:	85 d2                	test   %edx,%edx
  800eeb:	75 9c                	jne    800e89 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800eed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800ef4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef7:	48                   	dec    %eax
  800ef8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800efb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800eff:	74 3d                	je     800f3e <ltostr+0xe2>
		start = 1 ;
  800f01:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f08:	eb 34                	jmp    800f3e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f0a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f10:	01 d0                	add    %edx,%eax
  800f12:	8a 00                	mov    (%eax),%al
  800f14:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f17:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1d:	01 c2                	add    %eax,%edx
  800f1f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f25:	01 c8                	add    %ecx,%eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f2b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f31:	01 c2                	add    %eax,%edx
  800f33:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f36:	88 02                	mov    %al,(%edx)
		start++ ;
  800f38:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f3b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f41:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f44:	7c c4                	jl     800f0a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f46:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4c:	01 d0                	add    %edx,%eax
  800f4e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f51:	90                   	nop
  800f52:	c9                   	leave  
  800f53:	c3                   	ret    

00800f54 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f54:	55                   	push   %ebp
  800f55:	89 e5                	mov    %esp,%ebp
  800f57:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f5a:	ff 75 08             	pushl  0x8(%ebp)
  800f5d:	e8 54 fa ff ff       	call   8009b6 <strlen>
  800f62:	83 c4 04             	add    $0x4,%esp
  800f65:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f68:	ff 75 0c             	pushl  0xc(%ebp)
  800f6b:	e8 46 fa ff ff       	call   8009b6 <strlen>
  800f70:	83 c4 04             	add    $0x4,%esp
  800f73:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f76:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f7d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f84:	eb 17                	jmp    800f9d <strcconcat+0x49>
		final[s] = str1[s] ;
  800f86:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f89:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8c:	01 c2                	add    %eax,%edx
  800f8e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f91:	8b 45 08             	mov    0x8(%ebp),%eax
  800f94:	01 c8                	add    %ecx,%eax
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f9a:	ff 45 fc             	incl   -0x4(%ebp)
  800f9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fa3:	7c e1                	jl     800f86 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800fa5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800fac:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800fb3:	eb 1f                	jmp    800fd4 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800fb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb8:	8d 50 01             	lea    0x1(%eax),%edx
  800fbb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fbe:	89 c2                	mov    %eax,%edx
  800fc0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc3:	01 c2                	add    %eax,%edx
  800fc5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcb:	01 c8                	add    %ecx,%eax
  800fcd:	8a 00                	mov    (%eax),%al
  800fcf:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fd1:	ff 45 f8             	incl   -0x8(%ebp)
  800fd4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fda:	7c d9                	jl     800fb5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fdc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fdf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe2:	01 d0                	add    %edx,%eax
  800fe4:	c6 00 00             	movb   $0x0,(%eax)
}
  800fe7:	90                   	nop
  800fe8:	c9                   	leave  
  800fe9:	c3                   	ret    

00800fea <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fea:	55                   	push   %ebp
  800feb:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fed:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800ff6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff9:	8b 00                	mov    (%eax),%eax
  800ffb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801002:	8b 45 10             	mov    0x10(%ebp),%eax
  801005:	01 d0                	add    %edx,%eax
  801007:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80100d:	eb 0c                	jmp    80101b <strsplit+0x31>
			*string++ = 0;
  80100f:	8b 45 08             	mov    0x8(%ebp),%eax
  801012:	8d 50 01             	lea    0x1(%eax),%edx
  801015:	89 55 08             	mov    %edx,0x8(%ebp)
  801018:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	8a 00                	mov    (%eax),%al
  801020:	84 c0                	test   %al,%al
  801022:	74 18                	je     80103c <strsplit+0x52>
  801024:	8b 45 08             	mov    0x8(%ebp),%eax
  801027:	8a 00                	mov    (%eax),%al
  801029:	0f be c0             	movsbl %al,%eax
  80102c:	50                   	push   %eax
  80102d:	ff 75 0c             	pushl  0xc(%ebp)
  801030:	e8 13 fb ff ff       	call   800b48 <strchr>
  801035:	83 c4 08             	add    $0x8,%esp
  801038:	85 c0                	test   %eax,%eax
  80103a:	75 d3                	jne    80100f <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80103c:	8b 45 08             	mov    0x8(%ebp),%eax
  80103f:	8a 00                	mov    (%eax),%al
  801041:	84 c0                	test   %al,%al
  801043:	74 5a                	je     80109f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801045:	8b 45 14             	mov    0x14(%ebp),%eax
  801048:	8b 00                	mov    (%eax),%eax
  80104a:	83 f8 0f             	cmp    $0xf,%eax
  80104d:	75 07                	jne    801056 <strsplit+0x6c>
		{
			return 0;
  80104f:	b8 00 00 00 00       	mov    $0x0,%eax
  801054:	eb 66                	jmp    8010bc <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801056:	8b 45 14             	mov    0x14(%ebp),%eax
  801059:	8b 00                	mov    (%eax),%eax
  80105b:	8d 48 01             	lea    0x1(%eax),%ecx
  80105e:	8b 55 14             	mov    0x14(%ebp),%edx
  801061:	89 0a                	mov    %ecx,(%edx)
  801063:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80106a:	8b 45 10             	mov    0x10(%ebp),%eax
  80106d:	01 c2                	add    %eax,%edx
  80106f:	8b 45 08             	mov    0x8(%ebp),%eax
  801072:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801074:	eb 03                	jmp    801079 <strsplit+0x8f>
			string++;
  801076:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
  80107c:	8a 00                	mov    (%eax),%al
  80107e:	84 c0                	test   %al,%al
  801080:	74 8b                	je     80100d <strsplit+0x23>
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
  801085:	8a 00                	mov    (%eax),%al
  801087:	0f be c0             	movsbl %al,%eax
  80108a:	50                   	push   %eax
  80108b:	ff 75 0c             	pushl  0xc(%ebp)
  80108e:	e8 b5 fa ff ff       	call   800b48 <strchr>
  801093:	83 c4 08             	add    $0x8,%esp
  801096:	85 c0                	test   %eax,%eax
  801098:	74 dc                	je     801076 <strsplit+0x8c>
			string++;
	}
  80109a:	e9 6e ff ff ff       	jmp    80100d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80109f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8010a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a3:	8b 00                	mov    (%eax),%eax
  8010a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8010af:	01 d0                	add    %edx,%eax
  8010b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010b7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010bc:	c9                   	leave  
  8010bd:	c3                   	ret    

008010be <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8010be:	55                   	push   %ebp
  8010bf:	89 e5                	mov    %esp,%ebp
  8010c1:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  8010c4:	e8 3b 09 00 00       	call   801a04 <sys_isUHeapPlacementStrategyFIRSTFIT>
  8010c9:	85 c0                	test   %eax,%eax
  8010cb:	0f 84 3a 01 00 00    	je     80120b <malloc+0x14d>

		if(pl == 0){
  8010d1:	a1 28 30 80 00       	mov    0x803028,%eax
  8010d6:	85 c0                	test   %eax,%eax
  8010d8:	75 24                	jne    8010fe <malloc+0x40>
			for(int k = 0; k < Size; k++){
  8010da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8010e1:	eb 11                	jmp    8010f4 <malloc+0x36>
				arr[k] = -10000;
  8010e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010e6:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  8010ed:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  8010f1:	ff 45 f4             	incl   -0xc(%ebp)
  8010f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010f7:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8010fc:	76 e5                	jbe    8010e3 <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  8010fe:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  801105:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801108:	8b 45 08             	mov    0x8(%ebp),%eax
  80110b:	c1 e8 0c             	shr    $0xc,%eax
  80110e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	25 ff 0f 00 00       	and    $0xfff,%eax
  801119:	85 c0                	test   %eax,%eax
  80111b:	74 03                	je     801120 <malloc+0x62>
			x++;
  80111d:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801120:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  801127:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  80112e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801135:	eb 66                	jmp    80119d <malloc+0xdf>
			if( arr[k] == -10000){
  801137:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80113a:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801141:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801146:	75 52                	jne    80119a <malloc+0xdc>
				uint32 w = 0 ;
  801148:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  80114f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801152:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  801155:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801158:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80115b:	eb 09                	jmp    801166 <malloc+0xa8>
  80115d:	ff 45 e0             	incl   -0x20(%ebp)
  801160:	ff 45 dc             	incl   -0x24(%ebp)
  801163:	ff 45 e4             	incl   -0x1c(%ebp)
  801166:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801169:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80116e:	77 19                	ja     801189 <malloc+0xcb>
  801170:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801173:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80117a:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  80117f:	75 08                	jne    801189 <malloc+0xcb>
  801181:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801184:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801187:	72 d4                	jb     80115d <malloc+0x9f>
				if(w >= x){
  801189:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80118c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80118f:	72 09                	jb     80119a <malloc+0xdc>
					p = 1 ;
  801191:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801198:	eb 0d                	jmp    8011a7 <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  80119a:	ff 45 e4             	incl   -0x1c(%ebp)
  80119d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8011a0:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8011a5:	76 90                	jbe    801137 <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  8011a7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011ab:	75 0a                	jne    8011b7 <malloc+0xf9>
  8011ad:	b8 00 00 00 00       	mov    $0x0,%eax
  8011b2:	e9 ca 01 00 00       	jmp    801381 <malloc+0x2c3>
		int q = idx;
  8011b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8011ba:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  8011bd:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8011c4:	eb 16                	jmp    8011dc <malloc+0x11e>
			arr[q++] = x;
  8011c6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8011c9:	8d 50 01             	lea    0x1(%eax),%edx
  8011cc:	89 55 d8             	mov    %edx,-0x28(%ebp)
  8011cf:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011d2:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  8011d9:	ff 45 d4             	incl   -0x2c(%ebp)
  8011dc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8011df:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011e2:	72 e2                	jb     8011c6 <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  8011e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8011e7:	05 00 00 08 00       	add    $0x80000,%eax
  8011ec:	c1 e0 0c             	shl    $0xc,%eax
  8011ef:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  8011f2:	83 ec 08             	sub    $0x8,%esp
  8011f5:	ff 75 f0             	pushl  -0x10(%ebp)
  8011f8:	ff 75 ac             	pushl  -0x54(%ebp)
  8011fb:	e8 9b 04 00 00       	call   80169b <sys_allocateMem>
  801200:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801203:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801206:	e9 76 01 00 00       	jmp    801381 <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  80120b:	e8 25 08 00 00       	call   801a35 <sys_isUHeapPlacementStrategyBESTFIT>
  801210:	85 c0                	test   %eax,%eax
  801212:	0f 84 64 01 00 00    	je     80137c <malloc+0x2be>
		if(pl == 0){
  801218:	a1 28 30 80 00       	mov    0x803028,%eax
  80121d:	85 c0                	test   %eax,%eax
  80121f:	75 24                	jne    801245 <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801221:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801228:	eb 11                	jmp    80123b <malloc+0x17d>
				arr[k] = -10000;
  80122a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80122d:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801234:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801238:	ff 45 d0             	incl   -0x30(%ebp)
  80123b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80123e:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801243:	76 e5                	jbe    80122a <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801245:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  80124c:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  80124f:	8b 45 08             	mov    0x8(%ebp),%eax
  801252:	c1 e8 0c             	shr    $0xc,%eax
  801255:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801258:	8b 45 08             	mov    0x8(%ebp),%eax
  80125b:	25 ff 0f 00 00       	and    $0xfff,%eax
  801260:	85 c0                	test   %eax,%eax
  801262:	74 03                	je     801267 <malloc+0x1a9>
			x++;
  801264:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801267:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  80126e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801275:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  80127c:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801283:	e9 88 00 00 00       	jmp    801310 <malloc+0x252>
			if(arr[k] == -10000){
  801288:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80128b:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801292:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801297:	75 64                	jne    8012fd <malloc+0x23f>
				uint32 w = 0 , i;
  801299:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  8012a0:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8012a3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8012a6:	eb 06                	jmp    8012ae <malloc+0x1f0>
  8012a8:	ff 45 b8             	incl   -0x48(%ebp)
  8012ab:	ff 45 b4             	incl   -0x4c(%ebp)
  8012ae:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  8012b5:	77 11                	ja     8012c8 <malloc+0x20a>
  8012b7:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8012ba:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8012c1:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  8012c6:	74 e0                	je     8012a8 <malloc+0x1ea>
				if(w <q && w >= x){
  8012c8:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8012cb:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  8012ce:	73 24                	jae    8012f4 <malloc+0x236>
  8012d0:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8012d3:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  8012d6:	72 1c                	jb     8012f4 <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  8012d8:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8012db:	89 45 c8             	mov    %eax,-0x38(%ebp)
  8012de:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  8012e5:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8012e8:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8012eb:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8012ee:	48                   	dec    %eax
  8012ef:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8012f2:	eb 19                	jmp    80130d <malloc+0x24f>
				}
				else {
					k = i - 1;
  8012f4:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8012f7:	48                   	dec    %eax
  8012f8:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8012fb:	eb 10                	jmp    80130d <malloc+0x24f>
				}
			} else {
				k += arr[k];
  8012fd:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801300:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801307:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  80130a:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  80130d:	ff 45 bc             	incl   -0x44(%ebp)
  801310:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801313:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801318:	0f 86 6a ff ff ff    	jbe    801288 <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  80131e:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801322:	75 07                	jne    80132b <malloc+0x26d>
  801324:	b8 00 00 00 00       	mov    $0x0,%eax
  801329:	eb 56                	jmp    801381 <malloc+0x2c3>
	    q = idx;
  80132b:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80132e:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801331:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801338:	eb 16                	jmp    801350 <malloc+0x292>
			arr[q++] = x;
  80133a:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80133d:	8d 50 01             	lea    0x1(%eax),%edx
  801340:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801343:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801346:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  80134d:	ff 45 b0             	incl   -0x50(%ebp)
  801350:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801353:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801356:	72 e2                	jb     80133a <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801358:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80135b:	05 00 00 08 00       	add    $0x80000,%eax
  801360:	c1 e0 0c             	shl    $0xc,%eax
  801363:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801366:	83 ec 08             	sub    $0x8,%esp
  801369:	ff 75 cc             	pushl  -0x34(%ebp)
  80136c:	ff 75 a8             	pushl  -0x58(%ebp)
  80136f:	e8 27 03 00 00       	call   80169b <sys_allocateMem>
  801374:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801377:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80137a:	eb 05                	jmp    801381 <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  80137c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801381:	c9                   	leave  
  801382:	c3                   	ret    

00801383 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801383:	55                   	push   %ebp
  801384:	89 e5                	mov    %esp,%ebp
  801386:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801389:	8b 45 08             	mov    0x8(%ebp),%eax
  80138c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80138f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801392:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801397:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  80139a:	8b 45 08             	mov    0x8(%ebp),%eax
  80139d:	05 00 00 00 80       	add    $0x80000000,%eax
  8013a2:	c1 e8 0c             	shr    $0xc,%eax
  8013a5:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8013ac:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  8013af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	05 00 00 00 80       	add    $0x80000000,%eax
  8013be:	c1 e8 0c             	shr    $0xc,%eax
  8013c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013c4:	eb 14                	jmp    8013da <free+0x57>
		arr[j] = -10000;
  8013c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013c9:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  8013d0:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  8013d4:	ff 45 f4             	incl   -0xc(%ebp)
  8013d7:	ff 45 f0             	incl   -0x10(%ebp)
  8013da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013dd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8013e0:	72 e4                	jb     8013c6 <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e5:	83 ec 08             	sub    $0x8,%esp
  8013e8:	ff 75 e8             	pushl  -0x18(%ebp)
  8013eb:	50                   	push   %eax
  8013ec:	e8 8e 02 00 00       	call   80167f <sys_freeMem>
  8013f1:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  8013f4:	90                   	nop
  8013f5:	c9                   	leave  
  8013f6:	c3                   	ret    

008013f7 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8013f7:	55                   	push   %ebp
  8013f8:	89 e5                	mov    %esp,%ebp
  8013fa:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013fd:	83 ec 04             	sub    $0x4,%esp
  801400:	68 10 24 80 00       	push   $0x802410
  801405:	68 9e 00 00 00       	push   $0x9e
  80140a:	68 33 24 80 00       	push   $0x802433
  80140f:	e8 2d 07 00 00       	call   801b41 <_panic>

00801414 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801414:	55                   	push   %ebp
  801415:	89 e5                	mov    %esp,%ebp
  801417:	83 ec 18             	sub    $0x18,%esp
  80141a:	8b 45 10             	mov    0x10(%ebp),%eax
  80141d:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801420:	83 ec 04             	sub    $0x4,%esp
  801423:	68 10 24 80 00       	push   $0x802410
  801428:	68 a9 00 00 00       	push   $0xa9
  80142d:	68 33 24 80 00       	push   $0x802433
  801432:	e8 0a 07 00 00       	call   801b41 <_panic>

00801437 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801437:	55                   	push   %ebp
  801438:	89 e5                	mov    %esp,%ebp
  80143a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80143d:	83 ec 04             	sub    $0x4,%esp
  801440:	68 10 24 80 00       	push   $0x802410
  801445:	68 af 00 00 00       	push   $0xaf
  80144a:	68 33 24 80 00       	push   $0x802433
  80144f:	e8 ed 06 00 00       	call   801b41 <_panic>

00801454 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801454:	55                   	push   %ebp
  801455:	89 e5                	mov    %esp,%ebp
  801457:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80145a:	83 ec 04             	sub    $0x4,%esp
  80145d:	68 10 24 80 00       	push   $0x802410
  801462:	68 b5 00 00 00       	push   $0xb5
  801467:	68 33 24 80 00       	push   $0x802433
  80146c:	e8 d0 06 00 00       	call   801b41 <_panic>

00801471 <expand>:
}

void expand(uint32 newSize)
{
  801471:	55                   	push   %ebp
  801472:	89 e5                	mov    %esp,%ebp
  801474:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801477:	83 ec 04             	sub    $0x4,%esp
  80147a:	68 10 24 80 00       	push   $0x802410
  80147f:	68 ba 00 00 00       	push   $0xba
  801484:	68 33 24 80 00       	push   $0x802433
  801489:	e8 b3 06 00 00       	call   801b41 <_panic>

0080148e <shrink>:
}
void shrink(uint32 newSize)
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
  801491:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801494:	83 ec 04             	sub    $0x4,%esp
  801497:	68 10 24 80 00       	push   $0x802410
  80149c:	68 be 00 00 00       	push   $0xbe
  8014a1:	68 33 24 80 00       	push   $0x802433
  8014a6:	e8 96 06 00 00       	call   801b41 <_panic>

008014ab <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8014ab:	55                   	push   %ebp
  8014ac:	89 e5                	mov    %esp,%ebp
  8014ae:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014b1:	83 ec 04             	sub    $0x4,%esp
  8014b4:	68 10 24 80 00       	push   $0x802410
  8014b9:	68 c3 00 00 00       	push   $0xc3
  8014be:	68 33 24 80 00       	push   $0x802433
  8014c3:	e8 79 06 00 00       	call   801b41 <_panic>

008014c8 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
  8014cb:	57                   	push   %edi
  8014cc:	56                   	push   %esi
  8014cd:	53                   	push   %ebx
  8014ce:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014da:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014dd:	8b 7d 18             	mov    0x18(%ebp),%edi
  8014e0:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014e3:	cd 30                	int    $0x30
  8014e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014eb:	83 c4 10             	add    $0x10,%esp
  8014ee:	5b                   	pop    %ebx
  8014ef:	5e                   	pop    %esi
  8014f0:	5f                   	pop    %edi
  8014f1:	5d                   	pop    %ebp
  8014f2:	c3                   	ret    

008014f3 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
  8014f6:	83 ec 04             	sub    $0x4,%esp
  8014f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8014ff:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801503:	8b 45 08             	mov    0x8(%ebp),%eax
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	52                   	push   %edx
  80150b:	ff 75 0c             	pushl  0xc(%ebp)
  80150e:	50                   	push   %eax
  80150f:	6a 00                	push   $0x0
  801511:	e8 b2 ff ff ff       	call   8014c8 <syscall>
  801516:	83 c4 18             	add    $0x18,%esp
}
  801519:	90                   	nop
  80151a:	c9                   	leave  
  80151b:	c3                   	ret    

0080151c <sys_cgetc>:

int
sys_cgetc(void)
{
  80151c:	55                   	push   %ebp
  80151d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80151f:	6a 00                	push   $0x0
  801521:	6a 00                	push   $0x0
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 01                	push   $0x1
  80152b:	e8 98 ff ff ff       	call   8014c8 <syscall>
  801530:	83 c4 18             	add    $0x18,%esp
}
  801533:	c9                   	leave  
  801534:	c3                   	ret    

00801535 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801535:	55                   	push   %ebp
  801536:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	50                   	push   %eax
  801544:	6a 05                	push   $0x5
  801546:	e8 7d ff ff ff       	call   8014c8 <syscall>
  80154b:	83 c4 18             	add    $0x18,%esp
}
  80154e:	c9                   	leave  
  80154f:	c3                   	ret    

00801550 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801550:	55                   	push   %ebp
  801551:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	6a 02                	push   $0x2
  80155f:	e8 64 ff ff ff       	call   8014c8 <syscall>
  801564:	83 c4 18             	add    $0x18,%esp
}
  801567:	c9                   	leave  
  801568:	c3                   	ret    

00801569 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801569:	55                   	push   %ebp
  80156a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 03                	push   $0x3
  801578:	e8 4b ff ff ff       	call   8014c8 <syscall>
  80157d:	83 c4 18             	add    $0x18,%esp
}
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 04                	push   $0x4
  801591:	e8 32 ff ff ff       	call   8014c8 <syscall>
  801596:	83 c4 18             	add    $0x18,%esp
}
  801599:	c9                   	leave  
  80159a:	c3                   	ret    

0080159b <sys_env_exit>:


void sys_env_exit(void)
{
  80159b:	55                   	push   %ebp
  80159c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 06                	push   $0x6
  8015aa:	e8 19 ff ff ff       	call   8014c8 <syscall>
  8015af:	83 c4 18             	add    $0x18,%esp
}
  8015b2:	90                   	nop
  8015b3:	c9                   	leave  
  8015b4:	c3                   	ret    

008015b5 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015b5:	55                   	push   %ebp
  8015b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	52                   	push   %edx
  8015c5:	50                   	push   %eax
  8015c6:	6a 07                	push   $0x7
  8015c8:	e8 fb fe ff ff       	call   8014c8 <syscall>
  8015cd:	83 c4 18             	add    $0x18,%esp
}
  8015d0:	c9                   	leave  
  8015d1:	c3                   	ret    

008015d2 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015d2:	55                   	push   %ebp
  8015d3:	89 e5                	mov    %esp,%ebp
  8015d5:	56                   	push   %esi
  8015d6:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015d7:	8b 75 18             	mov    0x18(%ebp),%esi
  8015da:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e6:	56                   	push   %esi
  8015e7:	53                   	push   %ebx
  8015e8:	51                   	push   %ecx
  8015e9:	52                   	push   %edx
  8015ea:	50                   	push   %eax
  8015eb:	6a 08                	push   $0x8
  8015ed:	e8 d6 fe ff ff       	call   8014c8 <syscall>
  8015f2:	83 c4 18             	add    $0x18,%esp
}
  8015f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015f8:	5b                   	pop    %ebx
  8015f9:	5e                   	pop    %esi
  8015fa:	5d                   	pop    %ebp
  8015fb:	c3                   	ret    

008015fc <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8015fc:	55                   	push   %ebp
  8015fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8015ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801602:	8b 45 08             	mov    0x8(%ebp),%eax
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	52                   	push   %edx
  80160c:	50                   	push   %eax
  80160d:	6a 09                	push   $0x9
  80160f:	e8 b4 fe ff ff       	call   8014c8 <syscall>
  801614:	83 c4 18             	add    $0x18,%esp
}
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	ff 75 0c             	pushl  0xc(%ebp)
  801625:	ff 75 08             	pushl  0x8(%ebp)
  801628:	6a 0a                	push   $0xa
  80162a:	e8 99 fe ff ff       	call   8014c8 <syscall>
  80162f:	83 c4 18             	add    $0x18,%esp
}
  801632:	c9                   	leave  
  801633:	c3                   	ret    

00801634 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 0b                	push   $0xb
  801643:	e8 80 fe ff ff       	call   8014c8 <syscall>
  801648:	83 c4 18             	add    $0x18,%esp
}
  80164b:	c9                   	leave  
  80164c:	c3                   	ret    

0080164d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80164d:	55                   	push   %ebp
  80164e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 0c                	push   $0xc
  80165c:	e8 67 fe ff ff       	call   8014c8 <syscall>
  801661:	83 c4 18             	add    $0x18,%esp
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 0d                	push   $0xd
  801675:	e8 4e fe ff ff       	call   8014c8 <syscall>
  80167a:	83 c4 18             	add    $0x18,%esp
}
  80167d:	c9                   	leave  
  80167e:	c3                   	ret    

0080167f <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80167f:	55                   	push   %ebp
  801680:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	ff 75 0c             	pushl  0xc(%ebp)
  80168b:	ff 75 08             	pushl  0x8(%ebp)
  80168e:	6a 11                	push   $0x11
  801690:	e8 33 fe ff ff       	call   8014c8 <syscall>
  801695:	83 c4 18             	add    $0x18,%esp
	return;
  801698:	90                   	nop
}
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	ff 75 0c             	pushl  0xc(%ebp)
  8016a7:	ff 75 08             	pushl  0x8(%ebp)
  8016aa:	6a 12                	push   $0x12
  8016ac:	e8 17 fe ff ff       	call   8014c8 <syscall>
  8016b1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016b4:	90                   	nop
}
  8016b5:	c9                   	leave  
  8016b6:	c3                   	ret    

008016b7 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 0e                	push   $0xe
  8016c6:	e8 fd fd ff ff       	call   8014c8 <syscall>
  8016cb:	83 c4 18             	add    $0x18,%esp
}
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	ff 75 08             	pushl  0x8(%ebp)
  8016de:	6a 0f                	push   $0xf
  8016e0:	e8 e3 fd ff ff       	call   8014c8 <syscall>
  8016e5:	83 c4 18             	add    $0x18,%esp
}
  8016e8:	c9                   	leave  
  8016e9:	c3                   	ret    

008016ea <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016ea:	55                   	push   %ebp
  8016eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 10                	push   $0x10
  8016f9:	e8 ca fd ff ff       	call   8014c8 <syscall>
  8016fe:	83 c4 18             	add    $0x18,%esp
}
  801701:	90                   	nop
  801702:	c9                   	leave  
  801703:	c3                   	ret    

00801704 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801704:	55                   	push   %ebp
  801705:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 14                	push   $0x14
  801713:	e8 b0 fd ff ff       	call   8014c8 <syscall>
  801718:	83 c4 18             	add    $0x18,%esp
}
  80171b:	90                   	nop
  80171c:	c9                   	leave  
  80171d:	c3                   	ret    

0080171e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80171e:	55                   	push   %ebp
  80171f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 15                	push   $0x15
  80172d:	e8 96 fd ff ff       	call   8014c8 <syscall>
  801732:	83 c4 18             	add    $0x18,%esp
}
  801735:	90                   	nop
  801736:	c9                   	leave  
  801737:	c3                   	ret    

00801738 <sys_cputc>:


void
sys_cputc(const char c)
{
  801738:	55                   	push   %ebp
  801739:	89 e5                	mov    %esp,%ebp
  80173b:	83 ec 04             	sub    $0x4,%esp
  80173e:	8b 45 08             	mov    0x8(%ebp),%eax
  801741:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801744:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	50                   	push   %eax
  801751:	6a 16                	push   $0x16
  801753:	e8 70 fd ff ff       	call   8014c8 <syscall>
  801758:	83 c4 18             	add    $0x18,%esp
}
  80175b:	90                   	nop
  80175c:	c9                   	leave  
  80175d:	c3                   	ret    

0080175e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80175e:	55                   	push   %ebp
  80175f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 17                	push   $0x17
  80176d:	e8 56 fd ff ff       	call   8014c8 <syscall>
  801772:	83 c4 18             	add    $0x18,%esp
}
  801775:	90                   	nop
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80177b:	8b 45 08             	mov    0x8(%ebp),%eax
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	ff 75 0c             	pushl  0xc(%ebp)
  801787:	50                   	push   %eax
  801788:	6a 18                	push   $0x18
  80178a:	e8 39 fd ff ff       	call   8014c8 <syscall>
  80178f:	83 c4 18             	add    $0x18,%esp
}
  801792:	c9                   	leave  
  801793:	c3                   	ret    

00801794 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801794:	55                   	push   %ebp
  801795:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801797:	8b 55 0c             	mov    0xc(%ebp),%edx
  80179a:	8b 45 08             	mov    0x8(%ebp),%eax
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	52                   	push   %edx
  8017a4:	50                   	push   %eax
  8017a5:	6a 1b                	push   $0x1b
  8017a7:	e8 1c fd ff ff       	call   8014c8 <syscall>
  8017ac:	83 c4 18             	add    $0x18,%esp
}
  8017af:	c9                   	leave  
  8017b0:	c3                   	ret    

008017b1 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017b1:	55                   	push   %ebp
  8017b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	52                   	push   %edx
  8017c1:	50                   	push   %eax
  8017c2:	6a 19                	push   $0x19
  8017c4:	e8 ff fc ff ff       	call   8014c8 <syscall>
  8017c9:	83 c4 18             	add    $0x18,%esp
}
  8017cc:	90                   	nop
  8017cd:	c9                   	leave  
  8017ce:	c3                   	ret    

008017cf <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017cf:	55                   	push   %ebp
  8017d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	52                   	push   %edx
  8017df:	50                   	push   %eax
  8017e0:	6a 1a                	push   $0x1a
  8017e2:	e8 e1 fc ff ff       	call   8014c8 <syscall>
  8017e7:	83 c4 18             	add    $0x18,%esp
}
  8017ea:	90                   	nop
  8017eb:	c9                   	leave  
  8017ec:	c3                   	ret    

008017ed <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8017ed:	55                   	push   %ebp
  8017ee:	89 e5                	mov    %esp,%ebp
  8017f0:	83 ec 04             	sub    $0x4,%esp
  8017f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f6:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8017f9:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017fc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801800:	8b 45 08             	mov    0x8(%ebp),%eax
  801803:	6a 00                	push   $0x0
  801805:	51                   	push   %ecx
  801806:	52                   	push   %edx
  801807:	ff 75 0c             	pushl  0xc(%ebp)
  80180a:	50                   	push   %eax
  80180b:	6a 1c                	push   $0x1c
  80180d:	e8 b6 fc ff ff       	call   8014c8 <syscall>
  801812:	83 c4 18             	add    $0x18,%esp
}
  801815:	c9                   	leave  
  801816:	c3                   	ret    

00801817 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801817:	55                   	push   %ebp
  801818:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80181a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	52                   	push   %edx
  801827:	50                   	push   %eax
  801828:	6a 1d                	push   $0x1d
  80182a:	e8 99 fc ff ff       	call   8014c8 <syscall>
  80182f:	83 c4 18             	add    $0x18,%esp
}
  801832:	c9                   	leave  
  801833:	c3                   	ret    

00801834 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801837:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80183a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183d:	8b 45 08             	mov    0x8(%ebp),%eax
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	51                   	push   %ecx
  801845:	52                   	push   %edx
  801846:	50                   	push   %eax
  801847:	6a 1e                	push   $0x1e
  801849:	e8 7a fc ff ff       	call   8014c8 <syscall>
  80184e:	83 c4 18             	add    $0x18,%esp
}
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801856:	8b 55 0c             	mov    0xc(%ebp),%edx
  801859:	8b 45 08             	mov    0x8(%ebp),%eax
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	52                   	push   %edx
  801863:	50                   	push   %eax
  801864:	6a 1f                	push   $0x1f
  801866:	e8 5d fc ff ff       	call   8014c8 <syscall>
  80186b:	83 c4 18             	add    $0x18,%esp
}
  80186e:	c9                   	leave  
  80186f:	c3                   	ret    

00801870 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801870:	55                   	push   %ebp
  801871:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 20                	push   $0x20
  80187f:	e8 44 fc ff ff       	call   8014c8 <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
}
  801887:	c9                   	leave  
  801888:	c3                   	ret    

00801889 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801889:	55                   	push   %ebp
  80188a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80188c:	8b 45 08             	mov    0x8(%ebp),%eax
  80188f:	6a 00                	push   $0x0
  801891:	ff 75 14             	pushl  0x14(%ebp)
  801894:	ff 75 10             	pushl  0x10(%ebp)
  801897:	ff 75 0c             	pushl  0xc(%ebp)
  80189a:	50                   	push   %eax
  80189b:	6a 21                	push   $0x21
  80189d:	e8 26 fc ff ff       	call   8014c8 <syscall>
  8018a2:	83 c4 18             	add    $0x18,%esp
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	50                   	push   %eax
  8018b6:	6a 22                	push   $0x22
  8018b8:	e8 0b fc ff ff       	call   8014c8 <syscall>
  8018bd:	83 c4 18             	add    $0x18,%esp
}
  8018c0:	90                   	nop
  8018c1:	c9                   	leave  
  8018c2:	c3                   	ret    

008018c3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8018c3:	55                   	push   %ebp
  8018c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8018c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	50                   	push   %eax
  8018d2:	6a 23                	push   $0x23
  8018d4:	e8 ef fb ff ff       	call   8014c8 <syscall>
  8018d9:	83 c4 18             	add    $0x18,%esp
}
  8018dc:	90                   	nop
  8018dd:	c9                   	leave  
  8018de:	c3                   	ret    

008018df <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
  8018e2:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8018e5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018e8:	8d 50 04             	lea    0x4(%eax),%edx
  8018eb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	52                   	push   %edx
  8018f5:	50                   	push   %eax
  8018f6:	6a 24                	push   $0x24
  8018f8:	e8 cb fb ff ff       	call   8014c8 <syscall>
  8018fd:	83 c4 18             	add    $0x18,%esp
	return result;
  801900:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801903:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801906:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801909:	89 01                	mov    %eax,(%ecx)
  80190b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80190e:	8b 45 08             	mov    0x8(%ebp),%eax
  801911:	c9                   	leave  
  801912:	c2 04 00             	ret    $0x4

00801915 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801915:	55                   	push   %ebp
  801916:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	ff 75 10             	pushl  0x10(%ebp)
  80191f:	ff 75 0c             	pushl  0xc(%ebp)
  801922:	ff 75 08             	pushl  0x8(%ebp)
  801925:	6a 13                	push   $0x13
  801927:	e8 9c fb ff ff       	call   8014c8 <syscall>
  80192c:	83 c4 18             	add    $0x18,%esp
	return ;
  80192f:	90                   	nop
}
  801930:	c9                   	leave  
  801931:	c3                   	ret    

00801932 <sys_rcr2>:
uint32 sys_rcr2()
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 25                	push   $0x25
  801941:	e8 82 fb ff ff       	call   8014c8 <syscall>
  801946:	83 c4 18             	add    $0x18,%esp
}
  801949:	c9                   	leave  
  80194a:	c3                   	ret    

0080194b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80194b:	55                   	push   %ebp
  80194c:	89 e5                	mov    %esp,%ebp
  80194e:	83 ec 04             	sub    $0x4,%esp
  801951:	8b 45 08             	mov    0x8(%ebp),%eax
  801954:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801957:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	50                   	push   %eax
  801964:	6a 26                	push   $0x26
  801966:	e8 5d fb ff ff       	call   8014c8 <syscall>
  80196b:	83 c4 18             	add    $0x18,%esp
	return ;
  80196e:	90                   	nop
}
  80196f:	c9                   	leave  
  801970:	c3                   	ret    

00801971 <rsttst>:
void rsttst()
{
  801971:	55                   	push   %ebp
  801972:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	6a 28                	push   $0x28
  801980:	e8 43 fb ff ff       	call   8014c8 <syscall>
  801985:	83 c4 18             	add    $0x18,%esp
	return ;
  801988:	90                   	nop
}
  801989:	c9                   	leave  
  80198a:	c3                   	ret    

0080198b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80198b:	55                   	push   %ebp
  80198c:	89 e5                	mov    %esp,%ebp
  80198e:	83 ec 04             	sub    $0x4,%esp
  801991:	8b 45 14             	mov    0x14(%ebp),%eax
  801994:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801997:	8b 55 18             	mov    0x18(%ebp),%edx
  80199a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80199e:	52                   	push   %edx
  80199f:	50                   	push   %eax
  8019a0:	ff 75 10             	pushl  0x10(%ebp)
  8019a3:	ff 75 0c             	pushl  0xc(%ebp)
  8019a6:	ff 75 08             	pushl  0x8(%ebp)
  8019a9:	6a 27                	push   $0x27
  8019ab:	e8 18 fb ff ff       	call   8014c8 <syscall>
  8019b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8019b3:	90                   	nop
}
  8019b4:	c9                   	leave  
  8019b5:	c3                   	ret    

008019b6 <chktst>:
void chktst(uint32 n)
{
  8019b6:	55                   	push   %ebp
  8019b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	ff 75 08             	pushl  0x8(%ebp)
  8019c4:	6a 29                	push   $0x29
  8019c6:	e8 fd fa ff ff       	call   8014c8 <syscall>
  8019cb:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ce:	90                   	nop
}
  8019cf:	c9                   	leave  
  8019d0:	c3                   	ret    

008019d1 <inctst>:

void inctst()
{
  8019d1:	55                   	push   %ebp
  8019d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 2a                	push   $0x2a
  8019e0:	e8 e3 fa ff ff       	call   8014c8 <syscall>
  8019e5:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e8:	90                   	nop
}
  8019e9:	c9                   	leave  
  8019ea:	c3                   	ret    

008019eb <gettst>:
uint32 gettst()
{
  8019eb:	55                   	push   %ebp
  8019ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 2b                	push   $0x2b
  8019fa:	e8 c9 fa ff ff       	call   8014c8 <syscall>
  8019ff:	83 c4 18             	add    $0x18,%esp
}
  801a02:	c9                   	leave  
  801a03:	c3                   	ret    

00801a04 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a04:	55                   	push   %ebp
  801a05:	89 e5                	mov    %esp,%ebp
  801a07:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	6a 00                	push   $0x0
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 2c                	push   $0x2c
  801a16:	e8 ad fa ff ff       	call   8014c8 <syscall>
  801a1b:	83 c4 18             	add    $0x18,%esp
  801a1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a21:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a25:	75 07                	jne    801a2e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a27:	b8 01 00 00 00       	mov    $0x1,%eax
  801a2c:	eb 05                	jmp    801a33 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a33:	c9                   	leave  
  801a34:	c3                   	ret    

00801a35 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a35:	55                   	push   %ebp
  801a36:	89 e5                	mov    %esp,%ebp
  801a38:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	6a 2c                	push   $0x2c
  801a47:	e8 7c fa ff ff       	call   8014c8 <syscall>
  801a4c:	83 c4 18             	add    $0x18,%esp
  801a4f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a52:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a56:	75 07                	jne    801a5f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a58:	b8 01 00 00 00       	mov    $0x1,%eax
  801a5d:	eb 05                	jmp    801a64 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a5f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a64:	c9                   	leave  
  801a65:	c3                   	ret    

00801a66 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a66:	55                   	push   %ebp
  801a67:	89 e5                	mov    %esp,%ebp
  801a69:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a6c:	6a 00                	push   $0x0
  801a6e:	6a 00                	push   $0x0
  801a70:	6a 00                	push   $0x0
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 2c                	push   $0x2c
  801a78:	e8 4b fa ff ff       	call   8014c8 <syscall>
  801a7d:	83 c4 18             	add    $0x18,%esp
  801a80:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a83:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a87:	75 07                	jne    801a90 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a89:	b8 01 00 00 00       	mov    $0x1,%eax
  801a8e:	eb 05                	jmp    801a95 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a90:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a95:	c9                   	leave  
  801a96:	c3                   	ret    

00801a97 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a97:	55                   	push   %ebp
  801a98:	89 e5                	mov    %esp,%ebp
  801a9a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 2c                	push   $0x2c
  801aa9:	e8 1a fa ff ff       	call   8014c8 <syscall>
  801aae:	83 c4 18             	add    $0x18,%esp
  801ab1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ab4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ab8:	75 07                	jne    801ac1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801aba:	b8 01 00 00 00       	mov    $0x1,%eax
  801abf:	eb 05                	jmp    801ac6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ac1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ac6:	c9                   	leave  
  801ac7:	c3                   	ret    

00801ac8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ac8:	55                   	push   %ebp
  801ac9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	ff 75 08             	pushl  0x8(%ebp)
  801ad6:	6a 2d                	push   $0x2d
  801ad8:	e8 eb f9 ff ff       	call   8014c8 <syscall>
  801add:	83 c4 18             	add    $0x18,%esp
	return ;
  801ae0:	90                   	nop
}
  801ae1:	c9                   	leave  
  801ae2:	c3                   	ret    

00801ae3 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801ae3:	55                   	push   %ebp
  801ae4:	89 e5                	mov    %esp,%ebp
  801ae6:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801ae7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801aea:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aed:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af0:	8b 45 08             	mov    0x8(%ebp),%eax
  801af3:	6a 00                	push   $0x0
  801af5:	53                   	push   %ebx
  801af6:	51                   	push   %ecx
  801af7:	52                   	push   %edx
  801af8:	50                   	push   %eax
  801af9:	6a 2e                	push   $0x2e
  801afb:	e8 c8 f9 ff ff       	call   8014c8 <syscall>
  801b00:	83 c4 18             	add    $0x18,%esp
}
  801b03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b06:	c9                   	leave  
  801b07:	c3                   	ret    

00801b08 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b08:	55                   	push   %ebp
  801b09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	52                   	push   %edx
  801b18:	50                   	push   %eax
  801b19:	6a 2f                	push   $0x2f
  801b1b:	e8 a8 f9 ff ff       	call   8014c8 <syscall>
  801b20:	83 c4 18             	add    $0x18,%esp
}
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	ff 75 0c             	pushl  0xc(%ebp)
  801b31:	ff 75 08             	pushl  0x8(%ebp)
  801b34:	6a 30                	push   $0x30
  801b36:	e8 8d f9 ff ff       	call   8014c8 <syscall>
  801b3b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b3e:	90                   	nop
}
  801b3f:	c9                   	leave  
  801b40:	c3                   	ret    

00801b41 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
  801b44:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801b47:	8d 45 10             	lea    0x10(%ebp),%eax
  801b4a:	83 c0 04             	add    $0x4,%eax
  801b4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801b50:	a1 20 31 88 00       	mov    0x883120,%eax
  801b55:	85 c0                	test   %eax,%eax
  801b57:	74 16                	je     801b6f <_panic+0x2e>
		cprintf("%s: ", argv0);
  801b59:	a1 20 31 88 00       	mov    0x883120,%eax
  801b5e:	83 ec 08             	sub    $0x8,%esp
  801b61:	50                   	push   %eax
  801b62:	68 40 24 80 00       	push   $0x802440
  801b67:	e8 c8 e7 ff ff       	call   800334 <cprintf>
  801b6c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801b6f:	a1 00 30 80 00       	mov    0x803000,%eax
  801b74:	ff 75 0c             	pushl  0xc(%ebp)
  801b77:	ff 75 08             	pushl  0x8(%ebp)
  801b7a:	50                   	push   %eax
  801b7b:	68 45 24 80 00       	push   $0x802445
  801b80:	e8 af e7 ff ff       	call   800334 <cprintf>
  801b85:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801b88:	8b 45 10             	mov    0x10(%ebp),%eax
  801b8b:	83 ec 08             	sub    $0x8,%esp
  801b8e:	ff 75 f4             	pushl  -0xc(%ebp)
  801b91:	50                   	push   %eax
  801b92:	e8 32 e7 ff ff       	call   8002c9 <vcprintf>
  801b97:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801b9a:	83 ec 08             	sub    $0x8,%esp
  801b9d:	6a 00                	push   $0x0
  801b9f:	68 61 24 80 00       	push   $0x802461
  801ba4:	e8 20 e7 ff ff       	call   8002c9 <vcprintf>
  801ba9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801bac:	e8 a1 e6 ff ff       	call   800252 <exit>

	// should not return here
	while (1) ;
  801bb1:	eb fe                	jmp    801bb1 <_panic+0x70>

00801bb3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801bb3:	55                   	push   %ebp
  801bb4:	89 e5                	mov    %esp,%ebp
  801bb6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801bb9:	a1 20 30 80 00       	mov    0x803020,%eax
  801bbe:	8b 50 74             	mov    0x74(%eax),%edx
  801bc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bc4:	39 c2                	cmp    %eax,%edx
  801bc6:	74 14                	je     801bdc <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801bc8:	83 ec 04             	sub    $0x4,%esp
  801bcb:	68 64 24 80 00       	push   $0x802464
  801bd0:	6a 26                	push   $0x26
  801bd2:	68 b0 24 80 00       	push   $0x8024b0
  801bd7:	e8 65 ff ff ff       	call   801b41 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801bdc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801be3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801bea:	e9 c4 00 00 00       	jmp    801cb3 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  801bef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bf2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfc:	01 d0                	add    %edx,%eax
  801bfe:	8b 00                	mov    (%eax),%eax
  801c00:	85 c0                	test   %eax,%eax
  801c02:	75 08                	jne    801c0c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801c04:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801c07:	e9 a4 00 00 00       	jmp    801cb0 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  801c0c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c13:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801c1a:	eb 6b                	jmp    801c87 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801c1c:	a1 20 30 80 00       	mov    0x803020,%eax
  801c21:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801c27:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c2a:	89 d0                	mov    %edx,%eax
  801c2c:	c1 e0 02             	shl    $0x2,%eax
  801c2f:	01 d0                	add    %edx,%eax
  801c31:	c1 e0 02             	shl    $0x2,%eax
  801c34:	01 c8                	add    %ecx,%eax
  801c36:	8a 40 04             	mov    0x4(%eax),%al
  801c39:	84 c0                	test   %al,%al
  801c3b:	75 47                	jne    801c84 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c3d:	a1 20 30 80 00       	mov    0x803020,%eax
  801c42:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801c48:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c4b:	89 d0                	mov    %edx,%eax
  801c4d:	c1 e0 02             	shl    $0x2,%eax
  801c50:	01 d0                	add    %edx,%eax
  801c52:	c1 e0 02             	shl    $0x2,%eax
  801c55:	01 c8                	add    %ecx,%eax
  801c57:	8b 00                	mov    (%eax),%eax
  801c59:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801c5c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c5f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801c64:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801c66:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c69:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801c70:	8b 45 08             	mov    0x8(%ebp),%eax
  801c73:	01 c8                	add    %ecx,%eax
  801c75:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c77:	39 c2                	cmp    %eax,%edx
  801c79:	75 09                	jne    801c84 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  801c7b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801c82:	eb 12                	jmp    801c96 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c84:	ff 45 e8             	incl   -0x18(%ebp)
  801c87:	a1 20 30 80 00       	mov    0x803020,%eax
  801c8c:	8b 50 74             	mov    0x74(%eax),%edx
  801c8f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c92:	39 c2                	cmp    %eax,%edx
  801c94:	77 86                	ja     801c1c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801c96:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801c9a:	75 14                	jne    801cb0 <CheckWSWithoutLastIndex+0xfd>
			panic(
  801c9c:	83 ec 04             	sub    $0x4,%esp
  801c9f:	68 bc 24 80 00       	push   $0x8024bc
  801ca4:	6a 3a                	push   $0x3a
  801ca6:	68 b0 24 80 00       	push   $0x8024b0
  801cab:	e8 91 fe ff ff       	call   801b41 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801cb0:	ff 45 f0             	incl   -0x10(%ebp)
  801cb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cb6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801cb9:	0f 8c 30 ff ff ff    	jl     801bef <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801cbf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801cc6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801ccd:	eb 27                	jmp    801cf6 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801ccf:	a1 20 30 80 00       	mov    0x803020,%eax
  801cd4:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801cda:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801cdd:	89 d0                	mov    %edx,%eax
  801cdf:	c1 e0 02             	shl    $0x2,%eax
  801ce2:	01 d0                	add    %edx,%eax
  801ce4:	c1 e0 02             	shl    $0x2,%eax
  801ce7:	01 c8                	add    %ecx,%eax
  801ce9:	8a 40 04             	mov    0x4(%eax),%al
  801cec:	3c 01                	cmp    $0x1,%al
  801cee:	75 03                	jne    801cf3 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  801cf0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801cf3:	ff 45 e0             	incl   -0x20(%ebp)
  801cf6:	a1 20 30 80 00       	mov    0x803020,%eax
  801cfb:	8b 50 74             	mov    0x74(%eax),%edx
  801cfe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d01:	39 c2                	cmp    %eax,%edx
  801d03:	77 ca                	ja     801ccf <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801d05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d08:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d0b:	74 14                	je     801d21 <CheckWSWithoutLastIndex+0x16e>
		panic(
  801d0d:	83 ec 04             	sub    $0x4,%esp
  801d10:	68 10 25 80 00       	push   $0x802510
  801d15:	6a 44                	push   $0x44
  801d17:	68 b0 24 80 00       	push   $0x8024b0
  801d1c:	e8 20 fe ff ff       	call   801b41 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801d21:	90                   	nop
  801d22:	c9                   	leave  
  801d23:	c3                   	ret    

00801d24 <__udivdi3>:
  801d24:	55                   	push   %ebp
  801d25:	57                   	push   %edi
  801d26:	56                   	push   %esi
  801d27:	53                   	push   %ebx
  801d28:	83 ec 1c             	sub    $0x1c,%esp
  801d2b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d2f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d37:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d3b:	89 ca                	mov    %ecx,%edx
  801d3d:	89 f8                	mov    %edi,%eax
  801d3f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d43:	85 f6                	test   %esi,%esi
  801d45:	75 2d                	jne    801d74 <__udivdi3+0x50>
  801d47:	39 cf                	cmp    %ecx,%edi
  801d49:	77 65                	ja     801db0 <__udivdi3+0x8c>
  801d4b:	89 fd                	mov    %edi,%ebp
  801d4d:	85 ff                	test   %edi,%edi
  801d4f:	75 0b                	jne    801d5c <__udivdi3+0x38>
  801d51:	b8 01 00 00 00       	mov    $0x1,%eax
  801d56:	31 d2                	xor    %edx,%edx
  801d58:	f7 f7                	div    %edi
  801d5a:	89 c5                	mov    %eax,%ebp
  801d5c:	31 d2                	xor    %edx,%edx
  801d5e:	89 c8                	mov    %ecx,%eax
  801d60:	f7 f5                	div    %ebp
  801d62:	89 c1                	mov    %eax,%ecx
  801d64:	89 d8                	mov    %ebx,%eax
  801d66:	f7 f5                	div    %ebp
  801d68:	89 cf                	mov    %ecx,%edi
  801d6a:	89 fa                	mov    %edi,%edx
  801d6c:	83 c4 1c             	add    $0x1c,%esp
  801d6f:	5b                   	pop    %ebx
  801d70:	5e                   	pop    %esi
  801d71:	5f                   	pop    %edi
  801d72:	5d                   	pop    %ebp
  801d73:	c3                   	ret    
  801d74:	39 ce                	cmp    %ecx,%esi
  801d76:	77 28                	ja     801da0 <__udivdi3+0x7c>
  801d78:	0f bd fe             	bsr    %esi,%edi
  801d7b:	83 f7 1f             	xor    $0x1f,%edi
  801d7e:	75 40                	jne    801dc0 <__udivdi3+0x9c>
  801d80:	39 ce                	cmp    %ecx,%esi
  801d82:	72 0a                	jb     801d8e <__udivdi3+0x6a>
  801d84:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d88:	0f 87 9e 00 00 00    	ja     801e2c <__udivdi3+0x108>
  801d8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d93:	89 fa                	mov    %edi,%edx
  801d95:	83 c4 1c             	add    $0x1c,%esp
  801d98:	5b                   	pop    %ebx
  801d99:	5e                   	pop    %esi
  801d9a:	5f                   	pop    %edi
  801d9b:	5d                   	pop    %ebp
  801d9c:	c3                   	ret    
  801d9d:	8d 76 00             	lea    0x0(%esi),%esi
  801da0:	31 ff                	xor    %edi,%edi
  801da2:	31 c0                	xor    %eax,%eax
  801da4:	89 fa                	mov    %edi,%edx
  801da6:	83 c4 1c             	add    $0x1c,%esp
  801da9:	5b                   	pop    %ebx
  801daa:	5e                   	pop    %esi
  801dab:	5f                   	pop    %edi
  801dac:	5d                   	pop    %ebp
  801dad:	c3                   	ret    
  801dae:	66 90                	xchg   %ax,%ax
  801db0:	89 d8                	mov    %ebx,%eax
  801db2:	f7 f7                	div    %edi
  801db4:	31 ff                	xor    %edi,%edi
  801db6:	89 fa                	mov    %edi,%edx
  801db8:	83 c4 1c             	add    $0x1c,%esp
  801dbb:	5b                   	pop    %ebx
  801dbc:	5e                   	pop    %esi
  801dbd:	5f                   	pop    %edi
  801dbe:	5d                   	pop    %ebp
  801dbf:	c3                   	ret    
  801dc0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801dc5:	89 eb                	mov    %ebp,%ebx
  801dc7:	29 fb                	sub    %edi,%ebx
  801dc9:	89 f9                	mov    %edi,%ecx
  801dcb:	d3 e6                	shl    %cl,%esi
  801dcd:	89 c5                	mov    %eax,%ebp
  801dcf:	88 d9                	mov    %bl,%cl
  801dd1:	d3 ed                	shr    %cl,%ebp
  801dd3:	89 e9                	mov    %ebp,%ecx
  801dd5:	09 f1                	or     %esi,%ecx
  801dd7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ddb:	89 f9                	mov    %edi,%ecx
  801ddd:	d3 e0                	shl    %cl,%eax
  801ddf:	89 c5                	mov    %eax,%ebp
  801de1:	89 d6                	mov    %edx,%esi
  801de3:	88 d9                	mov    %bl,%cl
  801de5:	d3 ee                	shr    %cl,%esi
  801de7:	89 f9                	mov    %edi,%ecx
  801de9:	d3 e2                	shl    %cl,%edx
  801deb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801def:	88 d9                	mov    %bl,%cl
  801df1:	d3 e8                	shr    %cl,%eax
  801df3:	09 c2                	or     %eax,%edx
  801df5:	89 d0                	mov    %edx,%eax
  801df7:	89 f2                	mov    %esi,%edx
  801df9:	f7 74 24 0c          	divl   0xc(%esp)
  801dfd:	89 d6                	mov    %edx,%esi
  801dff:	89 c3                	mov    %eax,%ebx
  801e01:	f7 e5                	mul    %ebp
  801e03:	39 d6                	cmp    %edx,%esi
  801e05:	72 19                	jb     801e20 <__udivdi3+0xfc>
  801e07:	74 0b                	je     801e14 <__udivdi3+0xf0>
  801e09:	89 d8                	mov    %ebx,%eax
  801e0b:	31 ff                	xor    %edi,%edi
  801e0d:	e9 58 ff ff ff       	jmp    801d6a <__udivdi3+0x46>
  801e12:	66 90                	xchg   %ax,%ax
  801e14:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e18:	89 f9                	mov    %edi,%ecx
  801e1a:	d3 e2                	shl    %cl,%edx
  801e1c:	39 c2                	cmp    %eax,%edx
  801e1e:	73 e9                	jae    801e09 <__udivdi3+0xe5>
  801e20:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e23:	31 ff                	xor    %edi,%edi
  801e25:	e9 40 ff ff ff       	jmp    801d6a <__udivdi3+0x46>
  801e2a:	66 90                	xchg   %ax,%ax
  801e2c:	31 c0                	xor    %eax,%eax
  801e2e:	e9 37 ff ff ff       	jmp    801d6a <__udivdi3+0x46>
  801e33:	90                   	nop

00801e34 <__umoddi3>:
  801e34:	55                   	push   %ebp
  801e35:	57                   	push   %edi
  801e36:	56                   	push   %esi
  801e37:	53                   	push   %ebx
  801e38:	83 ec 1c             	sub    $0x1c,%esp
  801e3b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e3f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e47:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e4f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e53:	89 f3                	mov    %esi,%ebx
  801e55:	89 fa                	mov    %edi,%edx
  801e57:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e5b:	89 34 24             	mov    %esi,(%esp)
  801e5e:	85 c0                	test   %eax,%eax
  801e60:	75 1a                	jne    801e7c <__umoddi3+0x48>
  801e62:	39 f7                	cmp    %esi,%edi
  801e64:	0f 86 a2 00 00 00    	jbe    801f0c <__umoddi3+0xd8>
  801e6a:	89 c8                	mov    %ecx,%eax
  801e6c:	89 f2                	mov    %esi,%edx
  801e6e:	f7 f7                	div    %edi
  801e70:	89 d0                	mov    %edx,%eax
  801e72:	31 d2                	xor    %edx,%edx
  801e74:	83 c4 1c             	add    $0x1c,%esp
  801e77:	5b                   	pop    %ebx
  801e78:	5e                   	pop    %esi
  801e79:	5f                   	pop    %edi
  801e7a:	5d                   	pop    %ebp
  801e7b:	c3                   	ret    
  801e7c:	39 f0                	cmp    %esi,%eax
  801e7e:	0f 87 ac 00 00 00    	ja     801f30 <__umoddi3+0xfc>
  801e84:	0f bd e8             	bsr    %eax,%ebp
  801e87:	83 f5 1f             	xor    $0x1f,%ebp
  801e8a:	0f 84 ac 00 00 00    	je     801f3c <__umoddi3+0x108>
  801e90:	bf 20 00 00 00       	mov    $0x20,%edi
  801e95:	29 ef                	sub    %ebp,%edi
  801e97:	89 fe                	mov    %edi,%esi
  801e99:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e9d:	89 e9                	mov    %ebp,%ecx
  801e9f:	d3 e0                	shl    %cl,%eax
  801ea1:	89 d7                	mov    %edx,%edi
  801ea3:	89 f1                	mov    %esi,%ecx
  801ea5:	d3 ef                	shr    %cl,%edi
  801ea7:	09 c7                	or     %eax,%edi
  801ea9:	89 e9                	mov    %ebp,%ecx
  801eab:	d3 e2                	shl    %cl,%edx
  801ead:	89 14 24             	mov    %edx,(%esp)
  801eb0:	89 d8                	mov    %ebx,%eax
  801eb2:	d3 e0                	shl    %cl,%eax
  801eb4:	89 c2                	mov    %eax,%edx
  801eb6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eba:	d3 e0                	shl    %cl,%eax
  801ebc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ec0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ec4:	89 f1                	mov    %esi,%ecx
  801ec6:	d3 e8                	shr    %cl,%eax
  801ec8:	09 d0                	or     %edx,%eax
  801eca:	d3 eb                	shr    %cl,%ebx
  801ecc:	89 da                	mov    %ebx,%edx
  801ece:	f7 f7                	div    %edi
  801ed0:	89 d3                	mov    %edx,%ebx
  801ed2:	f7 24 24             	mull   (%esp)
  801ed5:	89 c6                	mov    %eax,%esi
  801ed7:	89 d1                	mov    %edx,%ecx
  801ed9:	39 d3                	cmp    %edx,%ebx
  801edb:	0f 82 87 00 00 00    	jb     801f68 <__umoddi3+0x134>
  801ee1:	0f 84 91 00 00 00    	je     801f78 <__umoddi3+0x144>
  801ee7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801eeb:	29 f2                	sub    %esi,%edx
  801eed:	19 cb                	sbb    %ecx,%ebx
  801eef:	89 d8                	mov    %ebx,%eax
  801ef1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ef5:	d3 e0                	shl    %cl,%eax
  801ef7:	89 e9                	mov    %ebp,%ecx
  801ef9:	d3 ea                	shr    %cl,%edx
  801efb:	09 d0                	or     %edx,%eax
  801efd:	89 e9                	mov    %ebp,%ecx
  801eff:	d3 eb                	shr    %cl,%ebx
  801f01:	89 da                	mov    %ebx,%edx
  801f03:	83 c4 1c             	add    $0x1c,%esp
  801f06:	5b                   	pop    %ebx
  801f07:	5e                   	pop    %esi
  801f08:	5f                   	pop    %edi
  801f09:	5d                   	pop    %ebp
  801f0a:	c3                   	ret    
  801f0b:	90                   	nop
  801f0c:	89 fd                	mov    %edi,%ebp
  801f0e:	85 ff                	test   %edi,%edi
  801f10:	75 0b                	jne    801f1d <__umoddi3+0xe9>
  801f12:	b8 01 00 00 00       	mov    $0x1,%eax
  801f17:	31 d2                	xor    %edx,%edx
  801f19:	f7 f7                	div    %edi
  801f1b:	89 c5                	mov    %eax,%ebp
  801f1d:	89 f0                	mov    %esi,%eax
  801f1f:	31 d2                	xor    %edx,%edx
  801f21:	f7 f5                	div    %ebp
  801f23:	89 c8                	mov    %ecx,%eax
  801f25:	f7 f5                	div    %ebp
  801f27:	89 d0                	mov    %edx,%eax
  801f29:	e9 44 ff ff ff       	jmp    801e72 <__umoddi3+0x3e>
  801f2e:	66 90                	xchg   %ax,%ax
  801f30:	89 c8                	mov    %ecx,%eax
  801f32:	89 f2                	mov    %esi,%edx
  801f34:	83 c4 1c             	add    $0x1c,%esp
  801f37:	5b                   	pop    %ebx
  801f38:	5e                   	pop    %esi
  801f39:	5f                   	pop    %edi
  801f3a:	5d                   	pop    %ebp
  801f3b:	c3                   	ret    
  801f3c:	3b 04 24             	cmp    (%esp),%eax
  801f3f:	72 06                	jb     801f47 <__umoddi3+0x113>
  801f41:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f45:	77 0f                	ja     801f56 <__umoddi3+0x122>
  801f47:	89 f2                	mov    %esi,%edx
  801f49:	29 f9                	sub    %edi,%ecx
  801f4b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f4f:	89 14 24             	mov    %edx,(%esp)
  801f52:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f56:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f5a:	8b 14 24             	mov    (%esp),%edx
  801f5d:	83 c4 1c             	add    $0x1c,%esp
  801f60:	5b                   	pop    %ebx
  801f61:	5e                   	pop    %esi
  801f62:	5f                   	pop    %edi
  801f63:	5d                   	pop    %ebp
  801f64:	c3                   	ret    
  801f65:	8d 76 00             	lea    0x0(%esi),%esi
  801f68:	2b 04 24             	sub    (%esp),%eax
  801f6b:	19 fa                	sbb    %edi,%edx
  801f6d:	89 d1                	mov    %edx,%ecx
  801f6f:	89 c6                	mov    %eax,%esi
  801f71:	e9 71 ff ff ff       	jmp    801ee7 <__umoddi3+0xb3>
  801f76:	66 90                	xchg   %ax,%ax
  801f78:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f7c:	72 ea                	jb     801f68 <__umoddi3+0x134>
  801f7e:	89 d9                	mov    %ebx,%ecx
  801f80:	e9 62 ff ff ff       	jmp    801ee7 <__umoddi3+0xb3>
