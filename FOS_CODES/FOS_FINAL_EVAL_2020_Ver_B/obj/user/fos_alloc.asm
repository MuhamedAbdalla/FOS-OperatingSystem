
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
  80004b:	e8 6b 10 00 00       	call   8010bb <malloc>
  800050:	83 c4 10             	add    $0x10,%esp
  800053:	89 45 ec             	mov    %eax,-0x14(%ebp)
	atomic_cprintf("x allocated at %x\n",x);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	ff 75 ec             	pushl  -0x14(%ebp)
  80005c:	68 80 1c 80 00       	push   $0x801c80
  800061:	e8 f8 02 00 00       	call   80035e <atomic_cprintf>
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
  8000b9:	68 93 1c 80 00       	push   $0x801c93
  8000be:	e8 9b 02 00 00       	call   80035e <atomic_cprintf>
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
  8000d7:	e8 f9 0f 00 00       	call   8010d5 <free>
  8000dc:	83 c4 10             	add    $0x10,%esp

	x = malloc(sizeof(unsigned char)*size) ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	ff 75 f0             	pushl  -0x10(%ebp)
  8000e5:	e8 d1 0f 00 00       	call   8010bb <malloc>
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
  80010f:	68 93 1c 80 00       	push   $0x801c93
  800114:	e8 45 02 00 00       	call   80035e <atomic_cprintf>
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
  80012d:	e8 a3 0f 00 00       	call   8010d5 <free>
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
  80013e:	e8 09 11 00 00       	call   80124c <sys_getenvindex>
  800143:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800146:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800149:	89 d0                	mov    %edx,%eax
  80014b:	c1 e0 03             	shl    $0x3,%eax
  80014e:	01 d0                	add    %edx,%eax
  800150:	c1 e0 02             	shl    $0x2,%eax
  800153:	01 d0                	add    %edx,%eax
  800155:	c1 e0 06             	shl    $0x6,%eax
  800158:	29 d0                	sub    %edx,%eax
  80015a:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800161:	01 c8                	add    %ecx,%eax
  800163:	01 d0                	add    %edx,%eax
  800165:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80016a:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80016f:	a1 20 30 80 00       	mov    0x803020,%eax
  800174:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  80017a:	84 c0                	test   %al,%al
  80017c:	74 0f                	je     80018d <libmain+0x55>
		binaryname = myEnv->prog_name;
  80017e:	a1 20 30 80 00       	mov    0x803020,%eax
  800183:	05 b0 52 00 00       	add    $0x52b0,%eax
  800188:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80018d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800191:	7e 0a                	jle    80019d <libmain+0x65>
		binaryname = argv[0];
  800193:	8b 45 0c             	mov    0xc(%ebp),%eax
  800196:	8b 00                	mov    (%eax),%eax
  800198:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80019d:	83 ec 08             	sub    $0x8,%esp
  8001a0:	ff 75 0c             	pushl  0xc(%ebp)
  8001a3:	ff 75 08             	pushl  0x8(%ebp)
  8001a6:	e8 8d fe ff ff       	call   800038 <_main>
  8001ab:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001ae:	e8 34 12 00 00       	call   8013e7 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001b3:	83 ec 0c             	sub    $0xc,%esp
  8001b6:	68 b8 1c 80 00       	push   $0x801cb8
  8001bb:	e8 71 01 00 00       	call   800331 <cprintf>
  8001c0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c8:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  8001ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d3:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  8001d9:	83 ec 04             	sub    $0x4,%esp
  8001dc:	52                   	push   %edx
  8001dd:	50                   	push   %eax
  8001de:	68 e0 1c 80 00       	push   $0x801ce0
  8001e3:	e8 49 01 00 00       	call   800331 <cprintf>
  8001e8:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  8001f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fb:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800201:	a1 20 30 80 00       	mov    0x803020,%eax
  800206:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  80020c:	51                   	push   %ecx
  80020d:	52                   	push   %edx
  80020e:	50                   	push   %eax
  80020f:	68 08 1d 80 00       	push   $0x801d08
  800214:	e8 18 01 00 00       	call   800331 <cprintf>
  800219:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80021c:	83 ec 0c             	sub    $0xc,%esp
  80021f:	68 b8 1c 80 00       	push   $0x801cb8
  800224:	e8 08 01 00 00       	call   800331 <cprintf>
  800229:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80022c:	e8 d0 11 00 00       	call   801401 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800231:	e8 19 00 00 00       	call   80024f <exit>
}
  800236:	90                   	nop
  800237:	c9                   	leave  
  800238:	c3                   	ret    

00800239 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800239:	55                   	push   %ebp
  80023a:	89 e5                	mov    %esp,%ebp
  80023c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80023f:	83 ec 0c             	sub    $0xc,%esp
  800242:	6a 00                	push   $0x0
  800244:	e8 cf 0f 00 00       	call   801218 <sys_env_destroy>
  800249:	83 c4 10             	add    $0x10,%esp
}
  80024c:	90                   	nop
  80024d:	c9                   	leave  
  80024e:	c3                   	ret    

0080024f <exit>:

void
exit(void)
{
  80024f:	55                   	push   %ebp
  800250:	89 e5                	mov    %esp,%ebp
  800252:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800255:	e8 24 10 00 00       	call   80127e <sys_env_exit>
}
  80025a:	90                   	nop
  80025b:	c9                   	leave  
  80025c:	c3                   	ret    

0080025d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80025d:	55                   	push   %ebp
  80025e:	89 e5                	mov    %esp,%ebp
  800260:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800263:	8b 45 0c             	mov    0xc(%ebp),%eax
  800266:	8b 00                	mov    (%eax),%eax
  800268:	8d 48 01             	lea    0x1(%eax),%ecx
  80026b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80026e:	89 0a                	mov    %ecx,(%edx)
  800270:	8b 55 08             	mov    0x8(%ebp),%edx
  800273:	88 d1                	mov    %dl,%cl
  800275:	8b 55 0c             	mov    0xc(%ebp),%edx
  800278:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80027c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80027f:	8b 00                	mov    (%eax),%eax
  800281:	3d ff 00 00 00       	cmp    $0xff,%eax
  800286:	75 2c                	jne    8002b4 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800288:	a0 24 30 80 00       	mov    0x803024,%al
  80028d:	0f b6 c0             	movzbl %al,%eax
  800290:	8b 55 0c             	mov    0xc(%ebp),%edx
  800293:	8b 12                	mov    (%edx),%edx
  800295:	89 d1                	mov    %edx,%ecx
  800297:	8b 55 0c             	mov    0xc(%ebp),%edx
  80029a:	83 c2 08             	add    $0x8,%edx
  80029d:	83 ec 04             	sub    $0x4,%esp
  8002a0:	50                   	push   %eax
  8002a1:	51                   	push   %ecx
  8002a2:	52                   	push   %edx
  8002a3:	e8 2e 0f 00 00       	call   8011d6 <sys_cputs>
  8002a8:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002b7:	8b 40 04             	mov    0x4(%eax),%eax
  8002ba:	8d 50 01             	lea    0x1(%eax),%edx
  8002bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c0:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002c3:	90                   	nop
  8002c4:	c9                   	leave  
  8002c5:	c3                   	ret    

008002c6 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002c6:	55                   	push   %ebp
  8002c7:	89 e5                	mov    %esp,%ebp
  8002c9:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002cf:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002d6:	00 00 00 
	b.cnt = 0;
  8002d9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002e0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002e3:	ff 75 0c             	pushl  0xc(%ebp)
  8002e6:	ff 75 08             	pushl  0x8(%ebp)
  8002e9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002ef:	50                   	push   %eax
  8002f0:	68 5d 02 80 00       	push   $0x80025d
  8002f5:	e8 11 02 00 00       	call   80050b <vprintfmt>
  8002fa:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002fd:	a0 24 30 80 00       	mov    0x803024,%al
  800302:	0f b6 c0             	movzbl %al,%eax
  800305:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80030b:	83 ec 04             	sub    $0x4,%esp
  80030e:	50                   	push   %eax
  80030f:	52                   	push   %edx
  800310:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800316:	83 c0 08             	add    $0x8,%eax
  800319:	50                   	push   %eax
  80031a:	e8 b7 0e 00 00       	call   8011d6 <sys_cputs>
  80031f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800322:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800329:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80032f:	c9                   	leave  
  800330:	c3                   	ret    

00800331 <cprintf>:

int cprintf(const char *fmt, ...) {
  800331:	55                   	push   %ebp
  800332:	89 e5                	mov    %esp,%ebp
  800334:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800337:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80033e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800341:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800344:	8b 45 08             	mov    0x8(%ebp),%eax
  800347:	83 ec 08             	sub    $0x8,%esp
  80034a:	ff 75 f4             	pushl  -0xc(%ebp)
  80034d:	50                   	push   %eax
  80034e:	e8 73 ff ff ff       	call   8002c6 <vcprintf>
  800353:	83 c4 10             	add    $0x10,%esp
  800356:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800359:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80035c:	c9                   	leave  
  80035d:	c3                   	ret    

0080035e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80035e:	55                   	push   %ebp
  80035f:	89 e5                	mov    %esp,%ebp
  800361:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800364:	e8 7e 10 00 00       	call   8013e7 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800369:	8d 45 0c             	lea    0xc(%ebp),%eax
  80036c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80036f:	8b 45 08             	mov    0x8(%ebp),%eax
  800372:	83 ec 08             	sub    $0x8,%esp
  800375:	ff 75 f4             	pushl  -0xc(%ebp)
  800378:	50                   	push   %eax
  800379:	e8 48 ff ff ff       	call   8002c6 <vcprintf>
  80037e:	83 c4 10             	add    $0x10,%esp
  800381:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800384:	e8 78 10 00 00       	call   801401 <sys_enable_interrupt>
	return cnt;
  800389:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80038c:	c9                   	leave  
  80038d:	c3                   	ret    

0080038e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80038e:	55                   	push   %ebp
  80038f:	89 e5                	mov    %esp,%ebp
  800391:	53                   	push   %ebx
  800392:	83 ec 14             	sub    $0x14,%esp
  800395:	8b 45 10             	mov    0x10(%ebp),%eax
  800398:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80039b:	8b 45 14             	mov    0x14(%ebp),%eax
  80039e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003a1:	8b 45 18             	mov    0x18(%ebp),%eax
  8003a4:	ba 00 00 00 00       	mov    $0x0,%edx
  8003a9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003ac:	77 55                	ja     800403 <printnum+0x75>
  8003ae:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003b1:	72 05                	jb     8003b8 <printnum+0x2a>
  8003b3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003b6:	77 4b                	ja     800403 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003b8:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003bb:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003be:	8b 45 18             	mov    0x18(%ebp),%eax
  8003c1:	ba 00 00 00 00       	mov    $0x0,%edx
  8003c6:	52                   	push   %edx
  8003c7:	50                   	push   %eax
  8003c8:	ff 75 f4             	pushl  -0xc(%ebp)
  8003cb:	ff 75 f0             	pushl  -0x10(%ebp)
  8003ce:	e8 35 16 00 00       	call   801a08 <__udivdi3>
  8003d3:	83 c4 10             	add    $0x10,%esp
  8003d6:	83 ec 04             	sub    $0x4,%esp
  8003d9:	ff 75 20             	pushl  0x20(%ebp)
  8003dc:	53                   	push   %ebx
  8003dd:	ff 75 18             	pushl  0x18(%ebp)
  8003e0:	52                   	push   %edx
  8003e1:	50                   	push   %eax
  8003e2:	ff 75 0c             	pushl  0xc(%ebp)
  8003e5:	ff 75 08             	pushl  0x8(%ebp)
  8003e8:	e8 a1 ff ff ff       	call   80038e <printnum>
  8003ed:	83 c4 20             	add    $0x20,%esp
  8003f0:	eb 1a                	jmp    80040c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003f2:	83 ec 08             	sub    $0x8,%esp
  8003f5:	ff 75 0c             	pushl  0xc(%ebp)
  8003f8:	ff 75 20             	pushl  0x20(%ebp)
  8003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fe:	ff d0                	call   *%eax
  800400:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800403:	ff 4d 1c             	decl   0x1c(%ebp)
  800406:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80040a:	7f e6                	jg     8003f2 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80040c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80040f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800414:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800417:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80041a:	53                   	push   %ebx
  80041b:	51                   	push   %ecx
  80041c:	52                   	push   %edx
  80041d:	50                   	push   %eax
  80041e:	e8 f5 16 00 00       	call   801b18 <__umoddi3>
  800423:	83 c4 10             	add    $0x10,%esp
  800426:	05 74 1f 80 00       	add    $0x801f74,%eax
  80042b:	8a 00                	mov    (%eax),%al
  80042d:	0f be c0             	movsbl %al,%eax
  800430:	83 ec 08             	sub    $0x8,%esp
  800433:	ff 75 0c             	pushl  0xc(%ebp)
  800436:	50                   	push   %eax
  800437:	8b 45 08             	mov    0x8(%ebp),%eax
  80043a:	ff d0                	call   *%eax
  80043c:	83 c4 10             	add    $0x10,%esp
}
  80043f:	90                   	nop
  800440:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800443:	c9                   	leave  
  800444:	c3                   	ret    

00800445 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800445:	55                   	push   %ebp
  800446:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800448:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80044c:	7e 1c                	jle    80046a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80044e:	8b 45 08             	mov    0x8(%ebp),%eax
  800451:	8b 00                	mov    (%eax),%eax
  800453:	8d 50 08             	lea    0x8(%eax),%edx
  800456:	8b 45 08             	mov    0x8(%ebp),%eax
  800459:	89 10                	mov    %edx,(%eax)
  80045b:	8b 45 08             	mov    0x8(%ebp),%eax
  80045e:	8b 00                	mov    (%eax),%eax
  800460:	83 e8 08             	sub    $0x8,%eax
  800463:	8b 50 04             	mov    0x4(%eax),%edx
  800466:	8b 00                	mov    (%eax),%eax
  800468:	eb 40                	jmp    8004aa <getuint+0x65>
	else if (lflag)
  80046a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80046e:	74 1e                	je     80048e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800470:	8b 45 08             	mov    0x8(%ebp),%eax
  800473:	8b 00                	mov    (%eax),%eax
  800475:	8d 50 04             	lea    0x4(%eax),%edx
  800478:	8b 45 08             	mov    0x8(%ebp),%eax
  80047b:	89 10                	mov    %edx,(%eax)
  80047d:	8b 45 08             	mov    0x8(%ebp),%eax
  800480:	8b 00                	mov    (%eax),%eax
  800482:	83 e8 04             	sub    $0x4,%eax
  800485:	8b 00                	mov    (%eax),%eax
  800487:	ba 00 00 00 00       	mov    $0x0,%edx
  80048c:	eb 1c                	jmp    8004aa <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80048e:	8b 45 08             	mov    0x8(%ebp),%eax
  800491:	8b 00                	mov    (%eax),%eax
  800493:	8d 50 04             	lea    0x4(%eax),%edx
  800496:	8b 45 08             	mov    0x8(%ebp),%eax
  800499:	89 10                	mov    %edx,(%eax)
  80049b:	8b 45 08             	mov    0x8(%ebp),%eax
  80049e:	8b 00                	mov    (%eax),%eax
  8004a0:	83 e8 04             	sub    $0x4,%eax
  8004a3:	8b 00                	mov    (%eax),%eax
  8004a5:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004aa:	5d                   	pop    %ebp
  8004ab:	c3                   	ret    

008004ac <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004ac:	55                   	push   %ebp
  8004ad:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004af:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004b3:	7e 1c                	jle    8004d1 <getint+0x25>
		return va_arg(*ap, long long);
  8004b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b8:	8b 00                	mov    (%eax),%eax
  8004ba:	8d 50 08             	lea    0x8(%eax),%edx
  8004bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c0:	89 10                	mov    %edx,(%eax)
  8004c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c5:	8b 00                	mov    (%eax),%eax
  8004c7:	83 e8 08             	sub    $0x8,%eax
  8004ca:	8b 50 04             	mov    0x4(%eax),%edx
  8004cd:	8b 00                	mov    (%eax),%eax
  8004cf:	eb 38                	jmp    800509 <getint+0x5d>
	else if (lflag)
  8004d1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004d5:	74 1a                	je     8004f1 <getint+0x45>
		return va_arg(*ap, long);
  8004d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004da:	8b 00                	mov    (%eax),%eax
  8004dc:	8d 50 04             	lea    0x4(%eax),%edx
  8004df:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e2:	89 10                	mov    %edx,(%eax)
  8004e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e7:	8b 00                	mov    (%eax),%eax
  8004e9:	83 e8 04             	sub    $0x4,%eax
  8004ec:	8b 00                	mov    (%eax),%eax
  8004ee:	99                   	cltd   
  8004ef:	eb 18                	jmp    800509 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f4:	8b 00                	mov    (%eax),%eax
  8004f6:	8d 50 04             	lea    0x4(%eax),%edx
  8004f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fc:	89 10                	mov    %edx,(%eax)
  8004fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800501:	8b 00                	mov    (%eax),%eax
  800503:	83 e8 04             	sub    $0x4,%eax
  800506:	8b 00                	mov    (%eax),%eax
  800508:	99                   	cltd   
}
  800509:	5d                   	pop    %ebp
  80050a:	c3                   	ret    

0080050b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	56                   	push   %esi
  80050f:	53                   	push   %ebx
  800510:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800513:	eb 17                	jmp    80052c <vprintfmt+0x21>
			if (ch == '\0')
  800515:	85 db                	test   %ebx,%ebx
  800517:	0f 84 af 03 00 00    	je     8008cc <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80051d:	83 ec 08             	sub    $0x8,%esp
  800520:	ff 75 0c             	pushl  0xc(%ebp)
  800523:	53                   	push   %ebx
  800524:	8b 45 08             	mov    0x8(%ebp),%eax
  800527:	ff d0                	call   *%eax
  800529:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80052c:	8b 45 10             	mov    0x10(%ebp),%eax
  80052f:	8d 50 01             	lea    0x1(%eax),%edx
  800532:	89 55 10             	mov    %edx,0x10(%ebp)
  800535:	8a 00                	mov    (%eax),%al
  800537:	0f b6 d8             	movzbl %al,%ebx
  80053a:	83 fb 25             	cmp    $0x25,%ebx
  80053d:	75 d6                	jne    800515 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80053f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800543:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80054a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800551:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800558:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80055f:	8b 45 10             	mov    0x10(%ebp),%eax
  800562:	8d 50 01             	lea    0x1(%eax),%edx
  800565:	89 55 10             	mov    %edx,0x10(%ebp)
  800568:	8a 00                	mov    (%eax),%al
  80056a:	0f b6 d8             	movzbl %al,%ebx
  80056d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800570:	83 f8 55             	cmp    $0x55,%eax
  800573:	0f 87 2b 03 00 00    	ja     8008a4 <vprintfmt+0x399>
  800579:	8b 04 85 98 1f 80 00 	mov    0x801f98(,%eax,4),%eax
  800580:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800582:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800586:	eb d7                	jmp    80055f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800588:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80058c:	eb d1                	jmp    80055f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80058e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800595:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800598:	89 d0                	mov    %edx,%eax
  80059a:	c1 e0 02             	shl    $0x2,%eax
  80059d:	01 d0                	add    %edx,%eax
  80059f:	01 c0                	add    %eax,%eax
  8005a1:	01 d8                	add    %ebx,%eax
  8005a3:	83 e8 30             	sub    $0x30,%eax
  8005a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8005ac:	8a 00                	mov    (%eax),%al
  8005ae:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005b1:	83 fb 2f             	cmp    $0x2f,%ebx
  8005b4:	7e 3e                	jle    8005f4 <vprintfmt+0xe9>
  8005b6:	83 fb 39             	cmp    $0x39,%ebx
  8005b9:	7f 39                	jg     8005f4 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005bb:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005be:	eb d5                	jmp    800595 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c3:	83 c0 04             	add    $0x4,%eax
  8005c6:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cc:	83 e8 04             	sub    $0x4,%eax
  8005cf:	8b 00                	mov    (%eax),%eax
  8005d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005d4:	eb 1f                	jmp    8005f5 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005d6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005da:	79 83                	jns    80055f <vprintfmt+0x54>
				width = 0;
  8005dc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005e3:	e9 77 ff ff ff       	jmp    80055f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005e8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005ef:	e9 6b ff ff ff       	jmp    80055f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005f4:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005f5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005f9:	0f 89 60 ff ff ff    	jns    80055f <vprintfmt+0x54>
				width = precision, precision = -1;
  8005ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800602:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800605:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80060c:	e9 4e ff ff ff       	jmp    80055f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800611:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800614:	e9 46 ff ff ff       	jmp    80055f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800619:	8b 45 14             	mov    0x14(%ebp),%eax
  80061c:	83 c0 04             	add    $0x4,%eax
  80061f:	89 45 14             	mov    %eax,0x14(%ebp)
  800622:	8b 45 14             	mov    0x14(%ebp),%eax
  800625:	83 e8 04             	sub    $0x4,%eax
  800628:	8b 00                	mov    (%eax),%eax
  80062a:	83 ec 08             	sub    $0x8,%esp
  80062d:	ff 75 0c             	pushl  0xc(%ebp)
  800630:	50                   	push   %eax
  800631:	8b 45 08             	mov    0x8(%ebp),%eax
  800634:	ff d0                	call   *%eax
  800636:	83 c4 10             	add    $0x10,%esp
			break;
  800639:	e9 89 02 00 00       	jmp    8008c7 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80063e:	8b 45 14             	mov    0x14(%ebp),%eax
  800641:	83 c0 04             	add    $0x4,%eax
  800644:	89 45 14             	mov    %eax,0x14(%ebp)
  800647:	8b 45 14             	mov    0x14(%ebp),%eax
  80064a:	83 e8 04             	sub    $0x4,%eax
  80064d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80064f:	85 db                	test   %ebx,%ebx
  800651:	79 02                	jns    800655 <vprintfmt+0x14a>
				err = -err;
  800653:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800655:	83 fb 64             	cmp    $0x64,%ebx
  800658:	7f 0b                	jg     800665 <vprintfmt+0x15a>
  80065a:	8b 34 9d e0 1d 80 00 	mov    0x801de0(,%ebx,4),%esi
  800661:	85 f6                	test   %esi,%esi
  800663:	75 19                	jne    80067e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800665:	53                   	push   %ebx
  800666:	68 85 1f 80 00       	push   $0x801f85
  80066b:	ff 75 0c             	pushl  0xc(%ebp)
  80066e:	ff 75 08             	pushl  0x8(%ebp)
  800671:	e8 5e 02 00 00       	call   8008d4 <printfmt>
  800676:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800679:	e9 49 02 00 00       	jmp    8008c7 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80067e:	56                   	push   %esi
  80067f:	68 8e 1f 80 00       	push   $0x801f8e
  800684:	ff 75 0c             	pushl  0xc(%ebp)
  800687:	ff 75 08             	pushl  0x8(%ebp)
  80068a:	e8 45 02 00 00       	call   8008d4 <printfmt>
  80068f:	83 c4 10             	add    $0x10,%esp
			break;
  800692:	e9 30 02 00 00       	jmp    8008c7 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800697:	8b 45 14             	mov    0x14(%ebp),%eax
  80069a:	83 c0 04             	add    $0x4,%eax
  80069d:	89 45 14             	mov    %eax,0x14(%ebp)
  8006a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8006a3:	83 e8 04             	sub    $0x4,%eax
  8006a6:	8b 30                	mov    (%eax),%esi
  8006a8:	85 f6                	test   %esi,%esi
  8006aa:	75 05                	jne    8006b1 <vprintfmt+0x1a6>
				p = "(null)";
  8006ac:	be 91 1f 80 00       	mov    $0x801f91,%esi
			if (width > 0 && padc != '-')
  8006b1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006b5:	7e 6d                	jle    800724 <vprintfmt+0x219>
  8006b7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006bb:	74 67                	je     800724 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006c0:	83 ec 08             	sub    $0x8,%esp
  8006c3:	50                   	push   %eax
  8006c4:	56                   	push   %esi
  8006c5:	e8 0c 03 00 00       	call   8009d6 <strnlen>
  8006ca:	83 c4 10             	add    $0x10,%esp
  8006cd:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006d0:	eb 16                	jmp    8006e8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006d2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006d6:	83 ec 08             	sub    $0x8,%esp
  8006d9:	ff 75 0c             	pushl  0xc(%ebp)
  8006dc:	50                   	push   %eax
  8006dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e0:	ff d0                	call   *%eax
  8006e2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006e5:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ec:	7f e4                	jg     8006d2 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ee:	eb 34                	jmp    800724 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006f0:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006f4:	74 1c                	je     800712 <vprintfmt+0x207>
  8006f6:	83 fb 1f             	cmp    $0x1f,%ebx
  8006f9:	7e 05                	jle    800700 <vprintfmt+0x1f5>
  8006fb:	83 fb 7e             	cmp    $0x7e,%ebx
  8006fe:	7e 12                	jle    800712 <vprintfmt+0x207>
					putch('?', putdat);
  800700:	83 ec 08             	sub    $0x8,%esp
  800703:	ff 75 0c             	pushl  0xc(%ebp)
  800706:	6a 3f                	push   $0x3f
  800708:	8b 45 08             	mov    0x8(%ebp),%eax
  80070b:	ff d0                	call   *%eax
  80070d:	83 c4 10             	add    $0x10,%esp
  800710:	eb 0f                	jmp    800721 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800712:	83 ec 08             	sub    $0x8,%esp
  800715:	ff 75 0c             	pushl  0xc(%ebp)
  800718:	53                   	push   %ebx
  800719:	8b 45 08             	mov    0x8(%ebp),%eax
  80071c:	ff d0                	call   *%eax
  80071e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800721:	ff 4d e4             	decl   -0x1c(%ebp)
  800724:	89 f0                	mov    %esi,%eax
  800726:	8d 70 01             	lea    0x1(%eax),%esi
  800729:	8a 00                	mov    (%eax),%al
  80072b:	0f be d8             	movsbl %al,%ebx
  80072e:	85 db                	test   %ebx,%ebx
  800730:	74 24                	je     800756 <vprintfmt+0x24b>
  800732:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800736:	78 b8                	js     8006f0 <vprintfmt+0x1e5>
  800738:	ff 4d e0             	decl   -0x20(%ebp)
  80073b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80073f:	79 af                	jns    8006f0 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800741:	eb 13                	jmp    800756 <vprintfmt+0x24b>
				putch(' ', putdat);
  800743:	83 ec 08             	sub    $0x8,%esp
  800746:	ff 75 0c             	pushl  0xc(%ebp)
  800749:	6a 20                	push   $0x20
  80074b:	8b 45 08             	mov    0x8(%ebp),%eax
  80074e:	ff d0                	call   *%eax
  800750:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800753:	ff 4d e4             	decl   -0x1c(%ebp)
  800756:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80075a:	7f e7                	jg     800743 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80075c:	e9 66 01 00 00       	jmp    8008c7 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800761:	83 ec 08             	sub    $0x8,%esp
  800764:	ff 75 e8             	pushl  -0x18(%ebp)
  800767:	8d 45 14             	lea    0x14(%ebp),%eax
  80076a:	50                   	push   %eax
  80076b:	e8 3c fd ff ff       	call   8004ac <getint>
  800770:	83 c4 10             	add    $0x10,%esp
  800773:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800776:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800779:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80077c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80077f:	85 d2                	test   %edx,%edx
  800781:	79 23                	jns    8007a6 <vprintfmt+0x29b>
				putch('-', putdat);
  800783:	83 ec 08             	sub    $0x8,%esp
  800786:	ff 75 0c             	pushl  0xc(%ebp)
  800789:	6a 2d                	push   $0x2d
  80078b:	8b 45 08             	mov    0x8(%ebp),%eax
  80078e:	ff d0                	call   *%eax
  800790:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800793:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800796:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800799:	f7 d8                	neg    %eax
  80079b:	83 d2 00             	adc    $0x0,%edx
  80079e:	f7 da                	neg    %edx
  8007a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007a6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007ad:	e9 bc 00 00 00       	jmp    80086e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007b2:	83 ec 08             	sub    $0x8,%esp
  8007b5:	ff 75 e8             	pushl  -0x18(%ebp)
  8007b8:	8d 45 14             	lea    0x14(%ebp),%eax
  8007bb:	50                   	push   %eax
  8007bc:	e8 84 fc ff ff       	call   800445 <getuint>
  8007c1:	83 c4 10             	add    $0x10,%esp
  8007c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007ca:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007d1:	e9 98 00 00 00       	jmp    80086e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007d6:	83 ec 08             	sub    $0x8,%esp
  8007d9:	ff 75 0c             	pushl  0xc(%ebp)
  8007dc:	6a 58                	push   $0x58
  8007de:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e1:	ff d0                	call   *%eax
  8007e3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007e6:	83 ec 08             	sub    $0x8,%esp
  8007e9:	ff 75 0c             	pushl  0xc(%ebp)
  8007ec:	6a 58                	push   $0x58
  8007ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f1:	ff d0                	call   *%eax
  8007f3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007f6:	83 ec 08             	sub    $0x8,%esp
  8007f9:	ff 75 0c             	pushl  0xc(%ebp)
  8007fc:	6a 58                	push   $0x58
  8007fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800801:	ff d0                	call   *%eax
  800803:	83 c4 10             	add    $0x10,%esp
			break;
  800806:	e9 bc 00 00 00       	jmp    8008c7 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80080b:	83 ec 08             	sub    $0x8,%esp
  80080e:	ff 75 0c             	pushl  0xc(%ebp)
  800811:	6a 30                	push   $0x30
  800813:	8b 45 08             	mov    0x8(%ebp),%eax
  800816:	ff d0                	call   *%eax
  800818:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80081b:	83 ec 08             	sub    $0x8,%esp
  80081e:	ff 75 0c             	pushl  0xc(%ebp)
  800821:	6a 78                	push   $0x78
  800823:	8b 45 08             	mov    0x8(%ebp),%eax
  800826:	ff d0                	call   *%eax
  800828:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80082b:	8b 45 14             	mov    0x14(%ebp),%eax
  80082e:	83 c0 04             	add    $0x4,%eax
  800831:	89 45 14             	mov    %eax,0x14(%ebp)
  800834:	8b 45 14             	mov    0x14(%ebp),%eax
  800837:	83 e8 04             	sub    $0x4,%eax
  80083a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80083c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80083f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800846:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80084d:	eb 1f                	jmp    80086e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80084f:	83 ec 08             	sub    $0x8,%esp
  800852:	ff 75 e8             	pushl  -0x18(%ebp)
  800855:	8d 45 14             	lea    0x14(%ebp),%eax
  800858:	50                   	push   %eax
  800859:	e8 e7 fb ff ff       	call   800445 <getuint>
  80085e:	83 c4 10             	add    $0x10,%esp
  800861:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800864:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800867:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80086e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800872:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800875:	83 ec 04             	sub    $0x4,%esp
  800878:	52                   	push   %edx
  800879:	ff 75 e4             	pushl  -0x1c(%ebp)
  80087c:	50                   	push   %eax
  80087d:	ff 75 f4             	pushl  -0xc(%ebp)
  800880:	ff 75 f0             	pushl  -0x10(%ebp)
  800883:	ff 75 0c             	pushl  0xc(%ebp)
  800886:	ff 75 08             	pushl  0x8(%ebp)
  800889:	e8 00 fb ff ff       	call   80038e <printnum>
  80088e:	83 c4 20             	add    $0x20,%esp
			break;
  800891:	eb 34                	jmp    8008c7 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800893:	83 ec 08             	sub    $0x8,%esp
  800896:	ff 75 0c             	pushl  0xc(%ebp)
  800899:	53                   	push   %ebx
  80089a:	8b 45 08             	mov    0x8(%ebp),%eax
  80089d:	ff d0                	call   *%eax
  80089f:	83 c4 10             	add    $0x10,%esp
			break;
  8008a2:	eb 23                	jmp    8008c7 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008a4:	83 ec 08             	sub    $0x8,%esp
  8008a7:	ff 75 0c             	pushl  0xc(%ebp)
  8008aa:	6a 25                	push   $0x25
  8008ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8008af:	ff d0                	call   *%eax
  8008b1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008b4:	ff 4d 10             	decl   0x10(%ebp)
  8008b7:	eb 03                	jmp    8008bc <vprintfmt+0x3b1>
  8008b9:	ff 4d 10             	decl   0x10(%ebp)
  8008bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8008bf:	48                   	dec    %eax
  8008c0:	8a 00                	mov    (%eax),%al
  8008c2:	3c 25                	cmp    $0x25,%al
  8008c4:	75 f3                	jne    8008b9 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008c6:	90                   	nop
		}
	}
  8008c7:	e9 47 fc ff ff       	jmp    800513 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008cc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008d0:	5b                   	pop    %ebx
  8008d1:	5e                   	pop    %esi
  8008d2:	5d                   	pop    %ebp
  8008d3:	c3                   	ret    

008008d4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008d4:	55                   	push   %ebp
  8008d5:	89 e5                	mov    %esp,%ebp
  8008d7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008da:	8d 45 10             	lea    0x10(%ebp),%eax
  8008dd:	83 c0 04             	add    $0x4,%eax
  8008e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e6:	ff 75 f4             	pushl  -0xc(%ebp)
  8008e9:	50                   	push   %eax
  8008ea:	ff 75 0c             	pushl  0xc(%ebp)
  8008ed:	ff 75 08             	pushl  0x8(%ebp)
  8008f0:	e8 16 fc ff ff       	call   80050b <vprintfmt>
  8008f5:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008f8:	90                   	nop
  8008f9:	c9                   	leave  
  8008fa:	c3                   	ret    

008008fb <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008fb:	55                   	push   %ebp
  8008fc:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800901:	8b 40 08             	mov    0x8(%eax),%eax
  800904:	8d 50 01             	lea    0x1(%eax),%edx
  800907:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80090d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800910:	8b 10                	mov    (%eax),%edx
  800912:	8b 45 0c             	mov    0xc(%ebp),%eax
  800915:	8b 40 04             	mov    0x4(%eax),%eax
  800918:	39 c2                	cmp    %eax,%edx
  80091a:	73 12                	jae    80092e <sprintputch+0x33>
		*b->buf++ = ch;
  80091c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091f:	8b 00                	mov    (%eax),%eax
  800921:	8d 48 01             	lea    0x1(%eax),%ecx
  800924:	8b 55 0c             	mov    0xc(%ebp),%edx
  800927:	89 0a                	mov    %ecx,(%edx)
  800929:	8b 55 08             	mov    0x8(%ebp),%edx
  80092c:	88 10                	mov    %dl,(%eax)
}
  80092e:	90                   	nop
  80092f:	5d                   	pop    %ebp
  800930:	c3                   	ret    

00800931 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800931:	55                   	push   %ebp
  800932:	89 e5                	mov    %esp,%ebp
  800934:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800937:	8b 45 08             	mov    0x8(%ebp),%eax
  80093a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80093d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800940:	8d 50 ff             	lea    -0x1(%eax),%edx
  800943:	8b 45 08             	mov    0x8(%ebp),%eax
  800946:	01 d0                	add    %edx,%eax
  800948:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80094b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800952:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800956:	74 06                	je     80095e <vsnprintf+0x2d>
  800958:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80095c:	7f 07                	jg     800965 <vsnprintf+0x34>
		return -E_INVAL;
  80095e:	b8 03 00 00 00       	mov    $0x3,%eax
  800963:	eb 20                	jmp    800985 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800965:	ff 75 14             	pushl  0x14(%ebp)
  800968:	ff 75 10             	pushl  0x10(%ebp)
  80096b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80096e:	50                   	push   %eax
  80096f:	68 fb 08 80 00       	push   $0x8008fb
  800974:	e8 92 fb ff ff       	call   80050b <vprintfmt>
  800979:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80097c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80097f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800982:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800985:	c9                   	leave  
  800986:	c3                   	ret    

00800987 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800987:	55                   	push   %ebp
  800988:	89 e5                	mov    %esp,%ebp
  80098a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80098d:	8d 45 10             	lea    0x10(%ebp),%eax
  800990:	83 c0 04             	add    $0x4,%eax
  800993:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800996:	8b 45 10             	mov    0x10(%ebp),%eax
  800999:	ff 75 f4             	pushl  -0xc(%ebp)
  80099c:	50                   	push   %eax
  80099d:	ff 75 0c             	pushl  0xc(%ebp)
  8009a0:	ff 75 08             	pushl  0x8(%ebp)
  8009a3:	e8 89 ff ff ff       	call   800931 <vsnprintf>
  8009a8:	83 c4 10             	add    $0x10,%esp
  8009ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009b1:	c9                   	leave  
  8009b2:	c3                   	ret    

008009b3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8009b3:	55                   	push   %ebp
  8009b4:	89 e5                	mov    %esp,%ebp
  8009b6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009c0:	eb 06                	jmp    8009c8 <strlen+0x15>
		n++;
  8009c2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009c5:	ff 45 08             	incl   0x8(%ebp)
  8009c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cb:	8a 00                	mov    (%eax),%al
  8009cd:	84 c0                	test   %al,%al
  8009cf:	75 f1                	jne    8009c2 <strlen+0xf>
		n++;
	return n;
  8009d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009d4:	c9                   	leave  
  8009d5:	c3                   	ret    

008009d6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009d6:	55                   	push   %ebp
  8009d7:	89 e5                	mov    %esp,%ebp
  8009d9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009e3:	eb 09                	jmp    8009ee <strnlen+0x18>
		n++;
  8009e5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009e8:	ff 45 08             	incl   0x8(%ebp)
  8009eb:	ff 4d 0c             	decl   0xc(%ebp)
  8009ee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009f2:	74 09                	je     8009fd <strnlen+0x27>
  8009f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f7:	8a 00                	mov    (%eax),%al
  8009f9:	84 c0                	test   %al,%al
  8009fb:	75 e8                	jne    8009e5 <strnlen+0xf>
		n++;
	return n;
  8009fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a00:	c9                   	leave  
  800a01:	c3                   	ret    

00800a02 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a02:	55                   	push   %ebp
  800a03:	89 e5                	mov    %esp,%ebp
  800a05:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a08:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a0e:	90                   	nop
  800a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a12:	8d 50 01             	lea    0x1(%eax),%edx
  800a15:	89 55 08             	mov    %edx,0x8(%ebp)
  800a18:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a1b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a1e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a21:	8a 12                	mov    (%edx),%dl
  800a23:	88 10                	mov    %dl,(%eax)
  800a25:	8a 00                	mov    (%eax),%al
  800a27:	84 c0                	test   %al,%al
  800a29:	75 e4                	jne    800a0f <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a2e:	c9                   	leave  
  800a2f:	c3                   	ret    

00800a30 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a30:	55                   	push   %ebp
  800a31:	89 e5                	mov    %esp,%ebp
  800a33:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a36:	8b 45 08             	mov    0x8(%ebp),%eax
  800a39:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a3c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a43:	eb 1f                	jmp    800a64 <strncpy+0x34>
		*dst++ = *src;
  800a45:	8b 45 08             	mov    0x8(%ebp),%eax
  800a48:	8d 50 01             	lea    0x1(%eax),%edx
  800a4b:	89 55 08             	mov    %edx,0x8(%ebp)
  800a4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a51:	8a 12                	mov    (%edx),%dl
  800a53:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a58:	8a 00                	mov    (%eax),%al
  800a5a:	84 c0                	test   %al,%al
  800a5c:	74 03                	je     800a61 <strncpy+0x31>
			src++;
  800a5e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a61:	ff 45 fc             	incl   -0x4(%ebp)
  800a64:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a67:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a6a:	72 d9                	jb     800a45 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a6c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a6f:	c9                   	leave  
  800a70:	c3                   	ret    

00800a71 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a71:	55                   	push   %ebp
  800a72:	89 e5                	mov    %esp,%ebp
  800a74:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a77:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a81:	74 30                	je     800ab3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a83:	eb 16                	jmp    800a9b <strlcpy+0x2a>
			*dst++ = *src++;
  800a85:	8b 45 08             	mov    0x8(%ebp),%eax
  800a88:	8d 50 01             	lea    0x1(%eax),%edx
  800a8b:	89 55 08             	mov    %edx,0x8(%ebp)
  800a8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a91:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a94:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a97:	8a 12                	mov    (%edx),%dl
  800a99:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a9b:	ff 4d 10             	decl   0x10(%ebp)
  800a9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aa2:	74 09                	je     800aad <strlcpy+0x3c>
  800aa4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa7:	8a 00                	mov    (%eax),%al
  800aa9:	84 c0                	test   %al,%al
  800aab:	75 d8                	jne    800a85 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800aad:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ab3:	8b 55 08             	mov    0x8(%ebp),%edx
  800ab6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ab9:	29 c2                	sub    %eax,%edx
  800abb:	89 d0                	mov    %edx,%eax
}
  800abd:	c9                   	leave  
  800abe:	c3                   	ret    

00800abf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800abf:	55                   	push   %ebp
  800ac0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ac2:	eb 06                	jmp    800aca <strcmp+0xb>
		p++, q++;
  800ac4:	ff 45 08             	incl   0x8(%ebp)
  800ac7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	8a 00                	mov    (%eax),%al
  800acf:	84 c0                	test   %al,%al
  800ad1:	74 0e                	je     800ae1 <strcmp+0x22>
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	8a 10                	mov    (%eax),%dl
  800ad8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adb:	8a 00                	mov    (%eax),%al
  800add:	38 c2                	cmp    %al,%dl
  800adf:	74 e3                	je     800ac4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae4:	8a 00                	mov    (%eax),%al
  800ae6:	0f b6 d0             	movzbl %al,%edx
  800ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aec:	8a 00                	mov    (%eax),%al
  800aee:	0f b6 c0             	movzbl %al,%eax
  800af1:	29 c2                	sub    %eax,%edx
  800af3:	89 d0                	mov    %edx,%eax
}
  800af5:	5d                   	pop    %ebp
  800af6:	c3                   	ret    

00800af7 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800af7:	55                   	push   %ebp
  800af8:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800afa:	eb 09                	jmp    800b05 <strncmp+0xe>
		n--, p++, q++;
  800afc:	ff 4d 10             	decl   0x10(%ebp)
  800aff:	ff 45 08             	incl   0x8(%ebp)
  800b02:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b05:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b09:	74 17                	je     800b22 <strncmp+0x2b>
  800b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0e:	8a 00                	mov    (%eax),%al
  800b10:	84 c0                	test   %al,%al
  800b12:	74 0e                	je     800b22 <strncmp+0x2b>
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
  800b17:	8a 10                	mov    (%eax),%dl
  800b19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1c:	8a 00                	mov    (%eax),%al
  800b1e:	38 c2                	cmp    %al,%dl
  800b20:	74 da                	je     800afc <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b22:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b26:	75 07                	jne    800b2f <strncmp+0x38>
		return 0;
  800b28:	b8 00 00 00 00       	mov    $0x0,%eax
  800b2d:	eb 14                	jmp    800b43 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b32:	8a 00                	mov    (%eax),%al
  800b34:	0f b6 d0             	movzbl %al,%edx
  800b37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3a:	8a 00                	mov    (%eax),%al
  800b3c:	0f b6 c0             	movzbl %al,%eax
  800b3f:	29 c2                	sub    %eax,%edx
  800b41:	89 d0                	mov    %edx,%eax
}
  800b43:	5d                   	pop    %ebp
  800b44:	c3                   	ret    

00800b45 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b45:	55                   	push   %ebp
  800b46:	89 e5                	mov    %esp,%ebp
  800b48:	83 ec 04             	sub    $0x4,%esp
  800b4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b51:	eb 12                	jmp    800b65 <strchr+0x20>
		if (*s == c)
  800b53:	8b 45 08             	mov    0x8(%ebp),%eax
  800b56:	8a 00                	mov    (%eax),%al
  800b58:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b5b:	75 05                	jne    800b62 <strchr+0x1d>
			return (char *) s;
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	eb 11                	jmp    800b73 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b62:	ff 45 08             	incl   0x8(%ebp)
  800b65:	8b 45 08             	mov    0x8(%ebp),%eax
  800b68:	8a 00                	mov    (%eax),%al
  800b6a:	84 c0                	test   %al,%al
  800b6c:	75 e5                	jne    800b53 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b6e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b73:	c9                   	leave  
  800b74:	c3                   	ret    

00800b75 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b75:	55                   	push   %ebp
  800b76:	89 e5                	mov    %esp,%ebp
  800b78:	83 ec 04             	sub    $0x4,%esp
  800b7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b81:	eb 0d                	jmp    800b90 <strfind+0x1b>
		if (*s == c)
  800b83:	8b 45 08             	mov    0x8(%ebp),%eax
  800b86:	8a 00                	mov    (%eax),%al
  800b88:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b8b:	74 0e                	je     800b9b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b8d:	ff 45 08             	incl   0x8(%ebp)
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
  800b93:	8a 00                	mov    (%eax),%al
  800b95:	84 c0                	test   %al,%al
  800b97:	75 ea                	jne    800b83 <strfind+0xe>
  800b99:	eb 01                	jmp    800b9c <strfind+0x27>
		if (*s == c)
			break;
  800b9b:	90                   	nop
	return (char *) s;
  800b9c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b9f:	c9                   	leave  
  800ba0:	c3                   	ret    

00800ba1 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ba1:	55                   	push   %ebp
  800ba2:	89 e5                	mov    %esp,%ebp
  800ba4:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  800baa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800bad:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800bb3:	eb 0e                	jmp    800bc3 <memset+0x22>
		*p++ = c;
  800bb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb8:	8d 50 01             	lea    0x1(%eax),%edx
  800bbb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800bbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc1:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bc3:	ff 4d f8             	decl   -0x8(%ebp)
  800bc6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bca:	79 e9                	jns    800bb5 <memset+0x14>
		*p++ = c;

	return v;
  800bcc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bcf:	c9                   	leave  
  800bd0:	c3                   	ret    

00800bd1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bd1:	55                   	push   %ebp
  800bd2:	89 e5                	mov    %esp,%ebp
  800bd4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bda:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800be0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800be3:	eb 16                	jmp    800bfb <memcpy+0x2a>
		*d++ = *s++;
  800be5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800be8:	8d 50 01             	lea    0x1(%eax),%edx
  800beb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bf1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bf4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bf7:	8a 12                	mov    (%edx),%dl
  800bf9:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800bfb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfe:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c01:	89 55 10             	mov    %edx,0x10(%ebp)
  800c04:	85 c0                	test   %eax,%eax
  800c06:	75 dd                	jne    800be5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c0b:	c9                   	leave  
  800c0c:	c3                   	ret    

00800c0d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c0d:	55                   	push   %ebp
  800c0e:	89 e5                	mov    %esp,%ebp
  800c10:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c16:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c22:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c25:	73 50                	jae    800c77 <memmove+0x6a>
  800c27:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2d:	01 d0                	add    %edx,%eax
  800c2f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c32:	76 43                	jbe    800c77 <memmove+0x6a>
		s += n;
  800c34:	8b 45 10             	mov    0x10(%ebp),%eax
  800c37:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c40:	eb 10                	jmp    800c52 <memmove+0x45>
			*--d = *--s;
  800c42:	ff 4d f8             	decl   -0x8(%ebp)
  800c45:	ff 4d fc             	decl   -0x4(%ebp)
  800c48:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c4b:	8a 10                	mov    (%eax),%dl
  800c4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c50:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c52:	8b 45 10             	mov    0x10(%ebp),%eax
  800c55:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c58:	89 55 10             	mov    %edx,0x10(%ebp)
  800c5b:	85 c0                	test   %eax,%eax
  800c5d:	75 e3                	jne    800c42 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c5f:	eb 23                	jmp    800c84 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c61:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c64:	8d 50 01             	lea    0x1(%eax),%edx
  800c67:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c6a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c6d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c70:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c73:	8a 12                	mov    (%edx),%dl
  800c75:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c77:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c7d:	89 55 10             	mov    %edx,0x10(%ebp)
  800c80:	85 c0                	test   %eax,%eax
  800c82:	75 dd                	jne    800c61 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c87:	c9                   	leave  
  800c88:	c3                   	ret    

00800c89 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c89:	55                   	push   %ebp
  800c8a:	89 e5                	mov    %esp,%ebp
  800c8c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c92:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c98:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c9b:	eb 2a                	jmp    800cc7 <memcmp+0x3e>
		if (*s1 != *s2)
  800c9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ca0:	8a 10                	mov    (%eax),%dl
  800ca2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ca5:	8a 00                	mov    (%eax),%al
  800ca7:	38 c2                	cmp    %al,%dl
  800ca9:	74 16                	je     800cc1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cae:	8a 00                	mov    (%eax),%al
  800cb0:	0f b6 d0             	movzbl %al,%edx
  800cb3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cb6:	8a 00                	mov    (%eax),%al
  800cb8:	0f b6 c0             	movzbl %al,%eax
  800cbb:	29 c2                	sub    %eax,%edx
  800cbd:	89 d0                	mov    %edx,%eax
  800cbf:	eb 18                	jmp    800cd9 <memcmp+0x50>
		s1++, s2++;
  800cc1:	ff 45 fc             	incl   -0x4(%ebp)
  800cc4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cc7:	8b 45 10             	mov    0x10(%ebp),%eax
  800cca:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ccd:	89 55 10             	mov    %edx,0x10(%ebp)
  800cd0:	85 c0                	test   %eax,%eax
  800cd2:	75 c9                	jne    800c9d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800cd4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cd9:	c9                   	leave  
  800cda:	c3                   	ret    

00800cdb <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800cdb:	55                   	push   %ebp
  800cdc:	89 e5                	mov    %esp,%ebp
  800cde:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ce1:	8b 55 08             	mov    0x8(%ebp),%edx
  800ce4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce7:	01 d0                	add    %edx,%eax
  800ce9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cec:	eb 15                	jmp    800d03 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	8a 00                	mov    (%eax),%al
  800cf3:	0f b6 d0             	movzbl %al,%edx
  800cf6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf9:	0f b6 c0             	movzbl %al,%eax
  800cfc:	39 c2                	cmp    %eax,%edx
  800cfe:	74 0d                	je     800d0d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d00:	ff 45 08             	incl   0x8(%ebp)
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d09:	72 e3                	jb     800cee <memfind+0x13>
  800d0b:	eb 01                	jmp    800d0e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d0d:	90                   	nop
	return (void *) s;
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d11:	c9                   	leave  
  800d12:	c3                   	ret    

00800d13 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d13:	55                   	push   %ebp
  800d14:	89 e5                	mov    %esp,%ebp
  800d16:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d19:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d20:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d27:	eb 03                	jmp    800d2c <strtol+0x19>
		s++;
  800d29:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	8a 00                	mov    (%eax),%al
  800d31:	3c 20                	cmp    $0x20,%al
  800d33:	74 f4                	je     800d29 <strtol+0x16>
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8a 00                	mov    (%eax),%al
  800d3a:	3c 09                	cmp    $0x9,%al
  800d3c:	74 eb                	je     800d29 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	8a 00                	mov    (%eax),%al
  800d43:	3c 2b                	cmp    $0x2b,%al
  800d45:	75 05                	jne    800d4c <strtol+0x39>
		s++;
  800d47:	ff 45 08             	incl   0x8(%ebp)
  800d4a:	eb 13                	jmp    800d5f <strtol+0x4c>
	else if (*s == '-')
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	3c 2d                	cmp    $0x2d,%al
  800d53:	75 0a                	jne    800d5f <strtol+0x4c>
		s++, neg = 1;
  800d55:	ff 45 08             	incl   0x8(%ebp)
  800d58:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d5f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d63:	74 06                	je     800d6b <strtol+0x58>
  800d65:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d69:	75 20                	jne    800d8b <strtol+0x78>
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6e:	8a 00                	mov    (%eax),%al
  800d70:	3c 30                	cmp    $0x30,%al
  800d72:	75 17                	jne    800d8b <strtol+0x78>
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
  800d77:	40                   	inc    %eax
  800d78:	8a 00                	mov    (%eax),%al
  800d7a:	3c 78                	cmp    $0x78,%al
  800d7c:	75 0d                	jne    800d8b <strtol+0x78>
		s += 2, base = 16;
  800d7e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d82:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d89:	eb 28                	jmp    800db3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d8f:	75 15                	jne    800da6 <strtol+0x93>
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	8a 00                	mov    (%eax),%al
  800d96:	3c 30                	cmp    $0x30,%al
  800d98:	75 0c                	jne    800da6 <strtol+0x93>
		s++, base = 8;
  800d9a:	ff 45 08             	incl   0x8(%ebp)
  800d9d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800da4:	eb 0d                	jmp    800db3 <strtol+0xa0>
	else if (base == 0)
  800da6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800daa:	75 07                	jne    800db3 <strtol+0xa0>
		base = 10;
  800dac:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800db3:	8b 45 08             	mov    0x8(%ebp),%eax
  800db6:	8a 00                	mov    (%eax),%al
  800db8:	3c 2f                	cmp    $0x2f,%al
  800dba:	7e 19                	jle    800dd5 <strtol+0xc2>
  800dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbf:	8a 00                	mov    (%eax),%al
  800dc1:	3c 39                	cmp    $0x39,%al
  800dc3:	7f 10                	jg     800dd5 <strtol+0xc2>
			dig = *s - '0';
  800dc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc8:	8a 00                	mov    (%eax),%al
  800dca:	0f be c0             	movsbl %al,%eax
  800dcd:	83 e8 30             	sub    $0x30,%eax
  800dd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dd3:	eb 42                	jmp    800e17 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	8a 00                	mov    (%eax),%al
  800dda:	3c 60                	cmp    $0x60,%al
  800ddc:	7e 19                	jle    800df7 <strtol+0xe4>
  800dde:	8b 45 08             	mov    0x8(%ebp),%eax
  800de1:	8a 00                	mov    (%eax),%al
  800de3:	3c 7a                	cmp    $0x7a,%al
  800de5:	7f 10                	jg     800df7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dea:	8a 00                	mov    (%eax),%al
  800dec:	0f be c0             	movsbl %al,%eax
  800def:	83 e8 57             	sub    $0x57,%eax
  800df2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800df5:	eb 20                	jmp    800e17 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	8a 00                	mov    (%eax),%al
  800dfc:	3c 40                	cmp    $0x40,%al
  800dfe:	7e 39                	jle    800e39 <strtol+0x126>
  800e00:	8b 45 08             	mov    0x8(%ebp),%eax
  800e03:	8a 00                	mov    (%eax),%al
  800e05:	3c 5a                	cmp    $0x5a,%al
  800e07:	7f 30                	jg     800e39 <strtol+0x126>
			dig = *s - 'A' + 10;
  800e09:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0c:	8a 00                	mov    (%eax),%al
  800e0e:	0f be c0             	movsbl %al,%eax
  800e11:	83 e8 37             	sub    $0x37,%eax
  800e14:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e17:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e1a:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e1d:	7d 19                	jge    800e38 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e1f:	ff 45 08             	incl   0x8(%ebp)
  800e22:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e25:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e29:	89 c2                	mov    %eax,%edx
  800e2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e2e:	01 d0                	add    %edx,%eax
  800e30:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e33:	e9 7b ff ff ff       	jmp    800db3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e38:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e39:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e3d:	74 08                	je     800e47 <strtol+0x134>
		*endptr = (char *) s;
  800e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e42:	8b 55 08             	mov    0x8(%ebp),%edx
  800e45:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e47:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e4b:	74 07                	je     800e54 <strtol+0x141>
  800e4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e50:	f7 d8                	neg    %eax
  800e52:	eb 03                	jmp    800e57 <strtol+0x144>
  800e54:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e57:	c9                   	leave  
  800e58:	c3                   	ret    

00800e59 <ltostr>:

void
ltostr(long value, char *str)
{
  800e59:	55                   	push   %ebp
  800e5a:	89 e5                	mov    %esp,%ebp
  800e5c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e66:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e6d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e71:	79 13                	jns    800e86 <ltostr+0x2d>
	{
		neg = 1;
  800e73:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e80:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e83:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e86:	8b 45 08             	mov    0x8(%ebp),%eax
  800e89:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e8e:	99                   	cltd   
  800e8f:	f7 f9                	idiv   %ecx
  800e91:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e94:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e97:	8d 50 01             	lea    0x1(%eax),%edx
  800e9a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e9d:	89 c2                	mov    %eax,%edx
  800e9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea2:	01 d0                	add    %edx,%eax
  800ea4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ea7:	83 c2 30             	add    $0x30,%edx
  800eaa:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800eac:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800eaf:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800eb4:	f7 e9                	imul   %ecx
  800eb6:	c1 fa 02             	sar    $0x2,%edx
  800eb9:	89 c8                	mov    %ecx,%eax
  800ebb:	c1 f8 1f             	sar    $0x1f,%eax
  800ebe:	29 c2                	sub    %eax,%edx
  800ec0:	89 d0                	mov    %edx,%eax
  800ec2:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ec5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ec8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ecd:	f7 e9                	imul   %ecx
  800ecf:	c1 fa 02             	sar    $0x2,%edx
  800ed2:	89 c8                	mov    %ecx,%eax
  800ed4:	c1 f8 1f             	sar    $0x1f,%eax
  800ed7:	29 c2                	sub    %eax,%edx
  800ed9:	89 d0                	mov    %edx,%eax
  800edb:	c1 e0 02             	shl    $0x2,%eax
  800ede:	01 d0                	add    %edx,%eax
  800ee0:	01 c0                	add    %eax,%eax
  800ee2:	29 c1                	sub    %eax,%ecx
  800ee4:	89 ca                	mov    %ecx,%edx
  800ee6:	85 d2                	test   %edx,%edx
  800ee8:	75 9c                	jne    800e86 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800eea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800ef1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef4:	48                   	dec    %eax
  800ef5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800ef8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800efc:	74 3d                	je     800f3b <ltostr+0xe2>
		start = 1 ;
  800efe:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f05:	eb 34                	jmp    800f3b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f07:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0d:	01 d0                	add    %edx,%eax
  800f0f:	8a 00                	mov    (%eax),%al
  800f11:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f14:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1a:	01 c2                	add    %eax,%edx
  800f1c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f22:	01 c8                	add    %ecx,%eax
  800f24:	8a 00                	mov    (%eax),%al
  800f26:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f28:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2e:	01 c2                	add    %eax,%edx
  800f30:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f33:	88 02                	mov    %al,(%edx)
		start++ ;
  800f35:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f38:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f3e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f41:	7c c4                	jl     800f07 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f43:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f49:	01 d0                	add    %edx,%eax
  800f4b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f4e:	90                   	nop
  800f4f:	c9                   	leave  
  800f50:	c3                   	ret    

00800f51 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f51:	55                   	push   %ebp
  800f52:	89 e5                	mov    %esp,%ebp
  800f54:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f57:	ff 75 08             	pushl  0x8(%ebp)
  800f5a:	e8 54 fa ff ff       	call   8009b3 <strlen>
  800f5f:	83 c4 04             	add    $0x4,%esp
  800f62:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f65:	ff 75 0c             	pushl  0xc(%ebp)
  800f68:	e8 46 fa ff ff       	call   8009b3 <strlen>
  800f6d:	83 c4 04             	add    $0x4,%esp
  800f70:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f7a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f81:	eb 17                	jmp    800f9a <strcconcat+0x49>
		final[s] = str1[s] ;
  800f83:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f86:	8b 45 10             	mov    0x10(%ebp),%eax
  800f89:	01 c2                	add    %eax,%edx
  800f8b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	01 c8                	add    %ecx,%eax
  800f93:	8a 00                	mov    (%eax),%al
  800f95:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f97:	ff 45 fc             	incl   -0x4(%ebp)
  800f9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f9d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fa0:	7c e1                	jl     800f83 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800fa2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800fa9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800fb0:	eb 1f                	jmp    800fd1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800fb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb5:	8d 50 01             	lea    0x1(%eax),%edx
  800fb8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fbb:	89 c2                	mov    %eax,%edx
  800fbd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc0:	01 c2                	add    %eax,%edx
  800fc2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc8:	01 c8                	add    %ecx,%eax
  800fca:	8a 00                	mov    (%eax),%al
  800fcc:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fce:	ff 45 f8             	incl   -0x8(%ebp)
  800fd1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fd7:	7c d9                	jl     800fb2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fd9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdf:	01 d0                	add    %edx,%eax
  800fe1:	c6 00 00             	movb   $0x0,(%eax)
}
  800fe4:	90                   	nop
  800fe5:	c9                   	leave  
  800fe6:	c3                   	ret    

00800fe7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fe7:	55                   	push   %ebp
  800fe8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fea:	8b 45 14             	mov    0x14(%ebp),%eax
  800fed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800ff3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff6:	8b 00                	mov    (%eax),%eax
  800ff8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fff:	8b 45 10             	mov    0x10(%ebp),%eax
  801002:	01 d0                	add    %edx,%eax
  801004:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80100a:	eb 0c                	jmp    801018 <strsplit+0x31>
			*string++ = 0;
  80100c:	8b 45 08             	mov    0x8(%ebp),%eax
  80100f:	8d 50 01             	lea    0x1(%eax),%edx
  801012:	89 55 08             	mov    %edx,0x8(%ebp)
  801015:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801018:	8b 45 08             	mov    0x8(%ebp),%eax
  80101b:	8a 00                	mov    (%eax),%al
  80101d:	84 c0                	test   %al,%al
  80101f:	74 18                	je     801039 <strsplit+0x52>
  801021:	8b 45 08             	mov    0x8(%ebp),%eax
  801024:	8a 00                	mov    (%eax),%al
  801026:	0f be c0             	movsbl %al,%eax
  801029:	50                   	push   %eax
  80102a:	ff 75 0c             	pushl  0xc(%ebp)
  80102d:	e8 13 fb ff ff       	call   800b45 <strchr>
  801032:	83 c4 08             	add    $0x8,%esp
  801035:	85 c0                	test   %eax,%eax
  801037:	75 d3                	jne    80100c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
  80103c:	8a 00                	mov    (%eax),%al
  80103e:	84 c0                	test   %al,%al
  801040:	74 5a                	je     80109c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801042:	8b 45 14             	mov    0x14(%ebp),%eax
  801045:	8b 00                	mov    (%eax),%eax
  801047:	83 f8 0f             	cmp    $0xf,%eax
  80104a:	75 07                	jne    801053 <strsplit+0x6c>
		{
			return 0;
  80104c:	b8 00 00 00 00       	mov    $0x0,%eax
  801051:	eb 66                	jmp    8010b9 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801053:	8b 45 14             	mov    0x14(%ebp),%eax
  801056:	8b 00                	mov    (%eax),%eax
  801058:	8d 48 01             	lea    0x1(%eax),%ecx
  80105b:	8b 55 14             	mov    0x14(%ebp),%edx
  80105e:	89 0a                	mov    %ecx,(%edx)
  801060:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801067:	8b 45 10             	mov    0x10(%ebp),%eax
  80106a:	01 c2                	add    %eax,%edx
  80106c:	8b 45 08             	mov    0x8(%ebp),%eax
  80106f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801071:	eb 03                	jmp    801076 <strsplit+0x8f>
			string++;
  801073:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	8a 00                	mov    (%eax),%al
  80107b:	84 c0                	test   %al,%al
  80107d:	74 8b                	je     80100a <strsplit+0x23>
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8a 00                	mov    (%eax),%al
  801084:	0f be c0             	movsbl %al,%eax
  801087:	50                   	push   %eax
  801088:	ff 75 0c             	pushl  0xc(%ebp)
  80108b:	e8 b5 fa ff ff       	call   800b45 <strchr>
  801090:	83 c4 08             	add    $0x8,%esp
  801093:	85 c0                	test   %eax,%eax
  801095:	74 dc                	je     801073 <strsplit+0x8c>
			string++;
	}
  801097:	e9 6e ff ff ff       	jmp    80100a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80109c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80109d:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a0:	8b 00                	mov    (%eax),%eax
  8010a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ac:	01 d0                	add    %edx,%eax
  8010ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010b4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010b9:	c9                   	leave  
  8010ba:	c3                   	ret    

008010bb <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8010bb:	55                   	push   %ebp
  8010bc:	89 e5                	mov    %esp,%ebp
  8010be:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8010c1:	83 ec 04             	sub    $0x4,%esp
  8010c4:	68 f0 20 80 00       	push   $0x8020f0
  8010c9:	6a 15                	push   $0x15
  8010cb:	68 15 21 80 00       	push   $0x802115
  8010d0:	e8 4f 07 00 00       	call   801824 <_panic>

008010d5 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8010d5:	55                   	push   %ebp
  8010d6:	89 e5                	mov    %esp,%ebp
  8010d8:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8010db:	83 ec 04             	sub    $0x4,%esp
  8010de:	68 24 21 80 00       	push   $0x802124
  8010e3:	6a 2e                	push   $0x2e
  8010e5:	68 15 21 80 00       	push   $0x802115
  8010ea:	e8 35 07 00 00       	call   801824 <_panic>

008010ef <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8010ef:	55                   	push   %ebp
  8010f0:	89 e5                	mov    %esp,%ebp
  8010f2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8010f5:	83 ec 04             	sub    $0x4,%esp
  8010f8:	68 48 21 80 00       	push   $0x802148
  8010fd:	6a 4c                	push   $0x4c
  8010ff:	68 15 21 80 00       	push   $0x802115
  801104:	e8 1b 07 00 00       	call   801824 <_panic>

00801109 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801109:	55                   	push   %ebp
  80110a:	89 e5                	mov    %esp,%ebp
  80110c:	83 ec 18             	sub    $0x18,%esp
  80110f:	8b 45 10             	mov    0x10(%ebp),%eax
  801112:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801115:	83 ec 04             	sub    $0x4,%esp
  801118:	68 48 21 80 00       	push   $0x802148
  80111d:	6a 57                	push   $0x57
  80111f:	68 15 21 80 00       	push   $0x802115
  801124:	e8 fb 06 00 00       	call   801824 <_panic>

00801129 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801129:	55                   	push   %ebp
  80112a:	89 e5                	mov    %esp,%ebp
  80112c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80112f:	83 ec 04             	sub    $0x4,%esp
  801132:	68 48 21 80 00       	push   $0x802148
  801137:	6a 5d                	push   $0x5d
  801139:	68 15 21 80 00       	push   $0x802115
  80113e:	e8 e1 06 00 00       	call   801824 <_panic>

00801143 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801143:	55                   	push   %ebp
  801144:	89 e5                	mov    %esp,%ebp
  801146:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801149:	83 ec 04             	sub    $0x4,%esp
  80114c:	68 48 21 80 00       	push   $0x802148
  801151:	6a 63                	push   $0x63
  801153:	68 15 21 80 00       	push   $0x802115
  801158:	e8 c7 06 00 00       	call   801824 <_panic>

0080115d <expand>:
}

void expand(uint32 newSize)
{
  80115d:	55                   	push   %ebp
  80115e:	89 e5                	mov    %esp,%ebp
  801160:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801163:	83 ec 04             	sub    $0x4,%esp
  801166:	68 48 21 80 00       	push   $0x802148
  80116b:	6a 68                	push   $0x68
  80116d:	68 15 21 80 00       	push   $0x802115
  801172:	e8 ad 06 00 00       	call   801824 <_panic>

00801177 <shrink>:
}
void shrink(uint32 newSize)
{
  801177:	55                   	push   %ebp
  801178:	89 e5                	mov    %esp,%ebp
  80117a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80117d:	83 ec 04             	sub    $0x4,%esp
  801180:	68 48 21 80 00       	push   $0x802148
  801185:	6a 6c                	push   $0x6c
  801187:	68 15 21 80 00       	push   $0x802115
  80118c:	e8 93 06 00 00       	call   801824 <_panic>

00801191 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801191:	55                   	push   %ebp
  801192:	89 e5                	mov    %esp,%ebp
  801194:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801197:	83 ec 04             	sub    $0x4,%esp
  80119a:	68 48 21 80 00       	push   $0x802148
  80119f:	6a 71                	push   $0x71
  8011a1:	68 15 21 80 00       	push   $0x802115
  8011a6:	e8 79 06 00 00       	call   801824 <_panic>

008011ab <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8011ab:	55                   	push   %ebp
  8011ac:	89 e5                	mov    %esp,%ebp
  8011ae:	57                   	push   %edi
  8011af:	56                   	push   %esi
  8011b0:	53                   	push   %ebx
  8011b1:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011ba:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011bd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011c0:	8b 7d 18             	mov    0x18(%ebp),%edi
  8011c3:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8011c6:	cd 30                	int    $0x30
  8011c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8011cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011ce:	83 c4 10             	add    $0x10,%esp
  8011d1:	5b                   	pop    %ebx
  8011d2:	5e                   	pop    %esi
  8011d3:	5f                   	pop    %edi
  8011d4:	5d                   	pop    %ebp
  8011d5:	c3                   	ret    

008011d6 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8011d6:	55                   	push   %ebp
  8011d7:	89 e5                	mov    %esp,%ebp
  8011d9:	83 ec 04             	sub    $0x4,%esp
  8011dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8011df:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8011e2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8011e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e9:	6a 00                	push   $0x0
  8011eb:	6a 00                	push   $0x0
  8011ed:	52                   	push   %edx
  8011ee:	ff 75 0c             	pushl  0xc(%ebp)
  8011f1:	50                   	push   %eax
  8011f2:	6a 00                	push   $0x0
  8011f4:	e8 b2 ff ff ff       	call   8011ab <syscall>
  8011f9:	83 c4 18             	add    $0x18,%esp
}
  8011fc:	90                   	nop
  8011fd:	c9                   	leave  
  8011fe:	c3                   	ret    

008011ff <sys_cgetc>:

int
sys_cgetc(void)
{
  8011ff:	55                   	push   %ebp
  801200:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801202:	6a 00                	push   $0x0
  801204:	6a 00                	push   $0x0
  801206:	6a 00                	push   $0x0
  801208:	6a 00                	push   $0x0
  80120a:	6a 00                	push   $0x0
  80120c:	6a 01                	push   $0x1
  80120e:	e8 98 ff ff ff       	call   8011ab <syscall>
  801213:	83 c4 18             	add    $0x18,%esp
}
  801216:	c9                   	leave  
  801217:	c3                   	ret    

00801218 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801218:	55                   	push   %ebp
  801219:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80121b:	8b 45 08             	mov    0x8(%ebp),%eax
  80121e:	6a 00                	push   $0x0
  801220:	6a 00                	push   $0x0
  801222:	6a 00                	push   $0x0
  801224:	6a 00                	push   $0x0
  801226:	50                   	push   %eax
  801227:	6a 05                	push   $0x5
  801229:	e8 7d ff ff ff       	call   8011ab <syscall>
  80122e:	83 c4 18             	add    $0x18,%esp
}
  801231:	c9                   	leave  
  801232:	c3                   	ret    

00801233 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801233:	55                   	push   %ebp
  801234:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801236:	6a 00                	push   $0x0
  801238:	6a 00                	push   $0x0
  80123a:	6a 00                	push   $0x0
  80123c:	6a 00                	push   $0x0
  80123e:	6a 00                	push   $0x0
  801240:	6a 02                	push   $0x2
  801242:	e8 64 ff ff ff       	call   8011ab <syscall>
  801247:	83 c4 18             	add    $0x18,%esp
}
  80124a:	c9                   	leave  
  80124b:	c3                   	ret    

0080124c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80124c:	55                   	push   %ebp
  80124d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	6a 00                	push   $0x0
  801255:	6a 00                	push   $0x0
  801257:	6a 00                	push   $0x0
  801259:	6a 03                	push   $0x3
  80125b:	e8 4b ff ff ff       	call   8011ab <syscall>
  801260:	83 c4 18             	add    $0x18,%esp
}
  801263:	c9                   	leave  
  801264:	c3                   	ret    

00801265 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801265:	55                   	push   %ebp
  801266:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801268:	6a 00                	push   $0x0
  80126a:	6a 00                	push   $0x0
  80126c:	6a 00                	push   $0x0
  80126e:	6a 00                	push   $0x0
  801270:	6a 00                	push   $0x0
  801272:	6a 04                	push   $0x4
  801274:	e8 32 ff ff ff       	call   8011ab <syscall>
  801279:	83 c4 18             	add    $0x18,%esp
}
  80127c:	c9                   	leave  
  80127d:	c3                   	ret    

0080127e <sys_env_exit>:


void sys_env_exit(void)
{
  80127e:	55                   	push   %ebp
  80127f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801281:	6a 00                	push   $0x0
  801283:	6a 00                	push   $0x0
  801285:	6a 00                	push   $0x0
  801287:	6a 00                	push   $0x0
  801289:	6a 00                	push   $0x0
  80128b:	6a 06                	push   $0x6
  80128d:	e8 19 ff ff ff       	call   8011ab <syscall>
  801292:	83 c4 18             	add    $0x18,%esp
}
  801295:	90                   	nop
  801296:	c9                   	leave  
  801297:	c3                   	ret    

00801298 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801298:	55                   	push   %ebp
  801299:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80129b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80129e:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a1:	6a 00                	push   $0x0
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	52                   	push   %edx
  8012a8:	50                   	push   %eax
  8012a9:	6a 07                	push   $0x7
  8012ab:	e8 fb fe ff ff       	call   8011ab <syscall>
  8012b0:	83 c4 18             	add    $0x18,%esp
}
  8012b3:	c9                   	leave  
  8012b4:	c3                   	ret    

008012b5 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8012b5:	55                   	push   %ebp
  8012b6:	89 e5                	mov    %esp,%ebp
  8012b8:	56                   	push   %esi
  8012b9:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8012ba:	8b 75 18             	mov    0x18(%ebp),%esi
  8012bd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012c0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c9:	56                   	push   %esi
  8012ca:	53                   	push   %ebx
  8012cb:	51                   	push   %ecx
  8012cc:	52                   	push   %edx
  8012cd:	50                   	push   %eax
  8012ce:	6a 08                	push   $0x8
  8012d0:	e8 d6 fe ff ff       	call   8011ab <syscall>
  8012d5:	83 c4 18             	add    $0x18,%esp
}
  8012d8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8012db:	5b                   	pop    %ebx
  8012dc:	5e                   	pop    %esi
  8012dd:	5d                   	pop    %ebp
  8012de:	c3                   	ret    

008012df <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8012df:	55                   	push   %ebp
  8012e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8012e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	52                   	push   %edx
  8012ef:	50                   	push   %eax
  8012f0:	6a 09                	push   $0x9
  8012f2:	e8 b4 fe ff ff       	call   8011ab <syscall>
  8012f7:	83 c4 18             	add    $0x18,%esp
}
  8012fa:	c9                   	leave  
  8012fb:	c3                   	ret    

008012fc <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8012fc:	55                   	push   %ebp
  8012fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	ff 75 0c             	pushl  0xc(%ebp)
  801308:	ff 75 08             	pushl  0x8(%ebp)
  80130b:	6a 0a                	push   $0xa
  80130d:	e8 99 fe ff ff       	call   8011ab <syscall>
  801312:	83 c4 18             	add    $0x18,%esp
}
  801315:	c9                   	leave  
  801316:	c3                   	ret    

00801317 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801317:	55                   	push   %ebp
  801318:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	6a 00                	push   $0x0
  801320:	6a 00                	push   $0x0
  801322:	6a 00                	push   $0x0
  801324:	6a 0b                	push   $0xb
  801326:	e8 80 fe ff ff       	call   8011ab <syscall>
  80132b:	83 c4 18             	add    $0x18,%esp
}
  80132e:	c9                   	leave  
  80132f:	c3                   	ret    

00801330 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801330:	55                   	push   %ebp
  801331:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801333:	6a 00                	push   $0x0
  801335:	6a 00                	push   $0x0
  801337:	6a 00                	push   $0x0
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	6a 0c                	push   $0xc
  80133f:	e8 67 fe ff ff       	call   8011ab <syscall>
  801344:	83 c4 18             	add    $0x18,%esp
}
  801347:	c9                   	leave  
  801348:	c3                   	ret    

00801349 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801349:	55                   	push   %ebp
  80134a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	6a 00                	push   $0x0
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	6a 0d                	push   $0xd
  801358:	e8 4e fe ff ff       	call   8011ab <syscall>
  80135d:	83 c4 18             	add    $0x18,%esp
}
  801360:	c9                   	leave  
  801361:	c3                   	ret    

00801362 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	ff 75 0c             	pushl  0xc(%ebp)
  80136e:	ff 75 08             	pushl  0x8(%ebp)
  801371:	6a 11                	push   $0x11
  801373:	e8 33 fe ff ff       	call   8011ab <syscall>
  801378:	83 c4 18             	add    $0x18,%esp
	return;
  80137b:	90                   	nop
}
  80137c:	c9                   	leave  
  80137d:	c3                   	ret    

0080137e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80137e:	55                   	push   %ebp
  80137f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	6a 00                	push   $0x0
  801387:	ff 75 0c             	pushl  0xc(%ebp)
  80138a:	ff 75 08             	pushl  0x8(%ebp)
  80138d:	6a 12                	push   $0x12
  80138f:	e8 17 fe ff ff       	call   8011ab <syscall>
  801394:	83 c4 18             	add    $0x18,%esp
	return ;
  801397:	90                   	nop
}
  801398:	c9                   	leave  
  801399:	c3                   	ret    

0080139a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80139a:	55                   	push   %ebp
  80139b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 00                	push   $0x0
  8013a7:	6a 0e                	push   $0xe
  8013a9:	e8 fd fd ff ff       	call   8011ab <syscall>
  8013ae:	83 c4 18             	add    $0x18,%esp
}
  8013b1:	c9                   	leave  
  8013b2:	c3                   	ret    

008013b3 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8013b3:	55                   	push   %ebp
  8013b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	ff 75 08             	pushl  0x8(%ebp)
  8013c1:	6a 0f                	push   $0xf
  8013c3:	e8 e3 fd ff ff       	call   8011ab <syscall>
  8013c8:	83 c4 18             	add    $0x18,%esp
}
  8013cb:	c9                   	leave  
  8013cc:	c3                   	ret    

008013cd <sys_scarce_memory>:

void sys_scarce_memory()
{
  8013cd:	55                   	push   %ebp
  8013ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 10                	push   $0x10
  8013dc:	e8 ca fd ff ff       	call   8011ab <syscall>
  8013e1:	83 c4 18             	add    $0x18,%esp
}
  8013e4:	90                   	nop
  8013e5:	c9                   	leave  
  8013e6:	c3                   	ret    

008013e7 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8013e7:	55                   	push   %ebp
  8013e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 14                	push   $0x14
  8013f6:	e8 b0 fd ff ff       	call   8011ab <syscall>
  8013fb:	83 c4 18             	add    $0x18,%esp
}
  8013fe:	90                   	nop
  8013ff:	c9                   	leave  
  801400:	c3                   	ret    

00801401 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801401:	55                   	push   %ebp
  801402:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	6a 00                	push   $0x0
  80140e:	6a 15                	push   $0x15
  801410:	e8 96 fd ff ff       	call   8011ab <syscall>
  801415:	83 c4 18             	add    $0x18,%esp
}
  801418:	90                   	nop
  801419:	c9                   	leave  
  80141a:	c3                   	ret    

0080141b <sys_cputc>:


void
sys_cputc(const char c)
{
  80141b:	55                   	push   %ebp
  80141c:	89 e5                	mov    %esp,%ebp
  80141e:	83 ec 04             	sub    $0x4,%esp
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801427:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80142b:	6a 00                	push   $0x0
  80142d:	6a 00                	push   $0x0
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	50                   	push   %eax
  801434:	6a 16                	push   $0x16
  801436:	e8 70 fd ff ff       	call   8011ab <syscall>
  80143b:	83 c4 18             	add    $0x18,%esp
}
  80143e:	90                   	nop
  80143f:	c9                   	leave  
  801440:	c3                   	ret    

00801441 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801441:	55                   	push   %ebp
  801442:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	6a 17                	push   $0x17
  801450:	e8 56 fd ff ff       	call   8011ab <syscall>
  801455:	83 c4 18             	add    $0x18,%esp
}
  801458:	90                   	nop
  801459:	c9                   	leave  
  80145a:	c3                   	ret    

0080145b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80145b:	55                   	push   %ebp
  80145c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	6a 00                	push   $0x0
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	ff 75 0c             	pushl  0xc(%ebp)
  80146a:	50                   	push   %eax
  80146b:	6a 18                	push   $0x18
  80146d:	e8 39 fd ff ff       	call   8011ab <syscall>
  801472:	83 c4 18             	add    $0x18,%esp
}
  801475:	c9                   	leave  
  801476:	c3                   	ret    

00801477 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80147a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	52                   	push   %edx
  801487:	50                   	push   %eax
  801488:	6a 1b                	push   $0x1b
  80148a:	e8 1c fd ff ff       	call   8011ab <syscall>
  80148f:	83 c4 18             	add    $0x18,%esp
}
  801492:	c9                   	leave  
  801493:	c3                   	ret    

00801494 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801497:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	52                   	push   %edx
  8014a4:	50                   	push   %eax
  8014a5:	6a 19                	push   $0x19
  8014a7:	e8 ff fc ff ff       	call   8011ab <syscall>
  8014ac:	83 c4 18             	add    $0x18,%esp
}
  8014af:	90                   	nop
  8014b0:	c9                   	leave  
  8014b1:	c3                   	ret    

008014b2 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014b2:	55                   	push   %ebp
  8014b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	52                   	push   %edx
  8014c2:	50                   	push   %eax
  8014c3:	6a 1a                	push   $0x1a
  8014c5:	e8 e1 fc ff ff       	call   8011ab <syscall>
  8014ca:	83 c4 18             	add    $0x18,%esp
}
  8014cd:	90                   	nop
  8014ce:	c9                   	leave  
  8014cf:	c3                   	ret    

008014d0 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
  8014d3:	83 ec 04             	sub    $0x4,%esp
  8014d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d9:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8014dc:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8014df:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	6a 00                	push   $0x0
  8014e8:	51                   	push   %ecx
  8014e9:	52                   	push   %edx
  8014ea:	ff 75 0c             	pushl  0xc(%ebp)
  8014ed:	50                   	push   %eax
  8014ee:	6a 1c                	push   $0x1c
  8014f0:	e8 b6 fc ff ff       	call   8011ab <syscall>
  8014f5:	83 c4 18             	add    $0x18,%esp
}
  8014f8:	c9                   	leave  
  8014f9:	c3                   	ret    

008014fa <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8014fa:	55                   	push   %ebp
  8014fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8014fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801500:	8b 45 08             	mov    0x8(%ebp),%eax
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	6a 00                	push   $0x0
  801509:	52                   	push   %edx
  80150a:	50                   	push   %eax
  80150b:	6a 1d                	push   $0x1d
  80150d:	e8 99 fc ff ff       	call   8011ab <syscall>
  801512:	83 c4 18             	add    $0x18,%esp
}
  801515:	c9                   	leave  
  801516:	c3                   	ret    

00801517 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801517:	55                   	push   %ebp
  801518:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80151a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80151d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801520:	8b 45 08             	mov    0x8(%ebp),%eax
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	51                   	push   %ecx
  801528:	52                   	push   %edx
  801529:	50                   	push   %eax
  80152a:	6a 1e                	push   $0x1e
  80152c:	e8 7a fc ff ff       	call   8011ab <syscall>
  801531:	83 c4 18             	add    $0x18,%esp
}
  801534:	c9                   	leave  
  801535:	c3                   	ret    

00801536 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801536:	55                   	push   %ebp
  801537:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801539:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153c:	8b 45 08             	mov    0x8(%ebp),%eax
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	52                   	push   %edx
  801546:	50                   	push   %eax
  801547:	6a 1f                	push   $0x1f
  801549:	e8 5d fc ff ff       	call   8011ab <syscall>
  80154e:	83 c4 18             	add    $0x18,%esp
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 20                	push   $0x20
  801562:	e8 44 fc ff ff       	call   8011ab <syscall>
  801567:	83 c4 18             	add    $0x18,%esp
}
  80156a:	c9                   	leave  
  80156b:	c3                   	ret    

0080156c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80156c:	55                   	push   %ebp
  80156d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80156f:	8b 45 08             	mov    0x8(%ebp),%eax
  801572:	6a 00                	push   $0x0
  801574:	ff 75 14             	pushl  0x14(%ebp)
  801577:	ff 75 10             	pushl  0x10(%ebp)
  80157a:	ff 75 0c             	pushl  0xc(%ebp)
  80157d:	50                   	push   %eax
  80157e:	6a 21                	push   $0x21
  801580:	e8 26 fc ff ff       	call   8011ab <syscall>
  801585:	83 c4 18             	add    $0x18,%esp
}
  801588:	c9                   	leave  
  801589:	c3                   	ret    

0080158a <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80158d:	8b 45 08             	mov    0x8(%ebp),%eax
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	50                   	push   %eax
  801599:	6a 22                	push   $0x22
  80159b:	e8 0b fc ff ff       	call   8011ab <syscall>
  8015a0:	83 c4 18             	add    $0x18,%esp
}
  8015a3:	90                   	nop
  8015a4:	c9                   	leave  
  8015a5:	c3                   	ret    

008015a6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8015a6:	55                   	push   %ebp
  8015a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8015a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	50                   	push   %eax
  8015b5:	6a 23                	push   $0x23
  8015b7:	e8 ef fb ff ff       	call   8011ab <syscall>
  8015bc:	83 c4 18             	add    $0x18,%esp
}
  8015bf:	90                   	nop
  8015c0:	c9                   	leave  
  8015c1:	c3                   	ret    

008015c2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8015c2:	55                   	push   %ebp
  8015c3:	89 e5                	mov    %esp,%ebp
  8015c5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8015c8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8015cb:	8d 50 04             	lea    0x4(%eax),%edx
  8015ce:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	52                   	push   %edx
  8015d8:	50                   	push   %eax
  8015d9:	6a 24                	push   $0x24
  8015db:	e8 cb fb ff ff       	call   8011ab <syscall>
  8015e0:	83 c4 18             	add    $0x18,%esp
	return result;
  8015e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8015e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015ec:	89 01                	mov    %eax,(%ecx)
  8015ee:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8015f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f4:	c9                   	leave  
  8015f5:	c2 04 00             	ret    $0x4

008015f8 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8015f8:	55                   	push   %ebp
  8015f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	ff 75 10             	pushl  0x10(%ebp)
  801602:	ff 75 0c             	pushl  0xc(%ebp)
  801605:	ff 75 08             	pushl  0x8(%ebp)
  801608:	6a 13                	push   $0x13
  80160a:	e8 9c fb ff ff       	call   8011ab <syscall>
  80160f:	83 c4 18             	add    $0x18,%esp
	return ;
  801612:	90                   	nop
}
  801613:	c9                   	leave  
  801614:	c3                   	ret    

00801615 <sys_rcr2>:
uint32 sys_rcr2()
{
  801615:	55                   	push   %ebp
  801616:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	6a 25                	push   $0x25
  801624:	e8 82 fb ff ff       	call   8011ab <syscall>
  801629:	83 c4 18             	add    $0x18,%esp
}
  80162c:	c9                   	leave  
  80162d:	c3                   	ret    

0080162e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80162e:	55                   	push   %ebp
  80162f:	89 e5                	mov    %esp,%ebp
  801631:	83 ec 04             	sub    $0x4,%esp
  801634:	8b 45 08             	mov    0x8(%ebp),%eax
  801637:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80163a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	50                   	push   %eax
  801647:	6a 26                	push   $0x26
  801649:	e8 5d fb ff ff       	call   8011ab <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
	return ;
  801651:	90                   	nop
}
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <rsttst>:
void rsttst()
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 28                	push   $0x28
  801663:	e8 43 fb ff ff       	call   8011ab <syscall>
  801668:	83 c4 18             	add    $0x18,%esp
	return ;
  80166b:	90                   	nop
}
  80166c:	c9                   	leave  
  80166d:	c3                   	ret    

0080166e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80166e:	55                   	push   %ebp
  80166f:	89 e5                	mov    %esp,%ebp
  801671:	83 ec 04             	sub    $0x4,%esp
  801674:	8b 45 14             	mov    0x14(%ebp),%eax
  801677:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80167a:	8b 55 18             	mov    0x18(%ebp),%edx
  80167d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801681:	52                   	push   %edx
  801682:	50                   	push   %eax
  801683:	ff 75 10             	pushl  0x10(%ebp)
  801686:	ff 75 0c             	pushl  0xc(%ebp)
  801689:	ff 75 08             	pushl  0x8(%ebp)
  80168c:	6a 27                	push   $0x27
  80168e:	e8 18 fb ff ff       	call   8011ab <syscall>
  801693:	83 c4 18             	add    $0x18,%esp
	return ;
  801696:	90                   	nop
}
  801697:	c9                   	leave  
  801698:	c3                   	ret    

00801699 <chktst>:
void chktst(uint32 n)
{
  801699:	55                   	push   %ebp
  80169a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	ff 75 08             	pushl  0x8(%ebp)
  8016a7:	6a 29                	push   $0x29
  8016a9:	e8 fd fa ff ff       	call   8011ab <syscall>
  8016ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8016b1:	90                   	nop
}
  8016b2:	c9                   	leave  
  8016b3:	c3                   	ret    

008016b4 <inctst>:

void inctst()
{
  8016b4:	55                   	push   %ebp
  8016b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 2a                	push   $0x2a
  8016c3:	e8 e3 fa ff ff       	call   8011ab <syscall>
  8016c8:	83 c4 18             	add    $0x18,%esp
	return ;
  8016cb:	90                   	nop
}
  8016cc:	c9                   	leave  
  8016cd:	c3                   	ret    

008016ce <gettst>:
uint32 gettst()
{
  8016ce:	55                   	push   %ebp
  8016cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 2b                	push   $0x2b
  8016dd:	e8 c9 fa ff ff       	call   8011ab <syscall>
  8016e2:	83 c4 18             	add    $0x18,%esp
}
  8016e5:	c9                   	leave  
  8016e6:	c3                   	ret    

008016e7 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
  8016ea:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 2c                	push   $0x2c
  8016f9:	e8 ad fa ff ff       	call   8011ab <syscall>
  8016fe:	83 c4 18             	add    $0x18,%esp
  801701:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801704:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801708:	75 07                	jne    801711 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80170a:	b8 01 00 00 00       	mov    $0x1,%eax
  80170f:	eb 05                	jmp    801716 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801711:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801716:	c9                   	leave  
  801717:	c3                   	ret    

00801718 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
  80171b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 2c                	push   $0x2c
  80172a:	e8 7c fa ff ff       	call   8011ab <syscall>
  80172f:	83 c4 18             	add    $0x18,%esp
  801732:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801735:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801739:	75 07                	jne    801742 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80173b:	b8 01 00 00 00       	mov    $0x1,%eax
  801740:	eb 05                	jmp    801747 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801742:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
  80174c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	6a 2c                	push   $0x2c
  80175b:	e8 4b fa ff ff       	call   8011ab <syscall>
  801760:	83 c4 18             	add    $0x18,%esp
  801763:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801766:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80176a:	75 07                	jne    801773 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80176c:	b8 01 00 00 00       	mov    $0x1,%eax
  801771:	eb 05                	jmp    801778 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801773:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801778:	c9                   	leave  
  801779:	c3                   	ret    

0080177a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80177a:	55                   	push   %ebp
  80177b:	89 e5                	mov    %esp,%ebp
  80177d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 2c                	push   $0x2c
  80178c:	e8 1a fa ff ff       	call   8011ab <syscall>
  801791:	83 c4 18             	add    $0x18,%esp
  801794:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801797:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80179b:	75 07                	jne    8017a4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80179d:	b8 01 00 00 00       	mov    $0x1,%eax
  8017a2:	eb 05                	jmp    8017a9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8017a4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017a9:	c9                   	leave  
  8017aa:	c3                   	ret    

008017ab <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8017ab:	55                   	push   %ebp
  8017ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	ff 75 08             	pushl  0x8(%ebp)
  8017b9:	6a 2d                	push   $0x2d
  8017bb:	e8 eb f9 ff ff       	call   8011ab <syscall>
  8017c0:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c3:	90                   	nop
}
  8017c4:	c9                   	leave  
  8017c5:	c3                   	ret    

008017c6 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8017c6:	55                   	push   %ebp
  8017c7:	89 e5                	mov    %esp,%ebp
  8017c9:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8017ca:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017cd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d6:	6a 00                	push   $0x0
  8017d8:	53                   	push   %ebx
  8017d9:	51                   	push   %ecx
  8017da:	52                   	push   %edx
  8017db:	50                   	push   %eax
  8017dc:	6a 2e                	push   $0x2e
  8017de:	e8 c8 f9 ff ff       	call   8011ab <syscall>
  8017e3:	83 c4 18             	add    $0x18,%esp
}
  8017e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8017e9:	c9                   	leave  
  8017ea:	c3                   	ret    

008017eb <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8017eb:	55                   	push   %ebp
  8017ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8017ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	52                   	push   %edx
  8017fb:	50                   	push   %eax
  8017fc:	6a 2f                	push   $0x2f
  8017fe:	e8 a8 f9 ff ff       	call   8011ab <syscall>
  801803:	83 c4 18             	add    $0x18,%esp
}
  801806:	c9                   	leave  
  801807:	c3                   	ret    

00801808 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801808:	55                   	push   %ebp
  801809:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	ff 75 0c             	pushl  0xc(%ebp)
  801814:	ff 75 08             	pushl  0x8(%ebp)
  801817:	6a 30                	push   $0x30
  801819:	e8 8d f9 ff ff       	call   8011ab <syscall>
  80181e:	83 c4 18             	add    $0x18,%esp
	return ;
  801821:	90                   	nop
}
  801822:	c9                   	leave  
  801823:	c3                   	ret    

00801824 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801824:	55                   	push   %ebp
  801825:	89 e5                	mov    %esp,%ebp
  801827:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80182a:	8d 45 10             	lea    0x10(%ebp),%eax
  80182d:	83 c0 04             	add    $0x4,%eax
  801830:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801833:	a1 18 31 80 00       	mov    0x803118,%eax
  801838:	85 c0                	test   %eax,%eax
  80183a:	74 16                	je     801852 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80183c:	a1 18 31 80 00       	mov    0x803118,%eax
  801841:	83 ec 08             	sub    $0x8,%esp
  801844:	50                   	push   %eax
  801845:	68 6c 21 80 00       	push   $0x80216c
  80184a:	e8 e2 ea ff ff       	call   800331 <cprintf>
  80184f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801852:	a1 00 30 80 00       	mov    0x803000,%eax
  801857:	ff 75 0c             	pushl  0xc(%ebp)
  80185a:	ff 75 08             	pushl  0x8(%ebp)
  80185d:	50                   	push   %eax
  80185e:	68 71 21 80 00       	push   $0x802171
  801863:	e8 c9 ea ff ff       	call   800331 <cprintf>
  801868:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80186b:	8b 45 10             	mov    0x10(%ebp),%eax
  80186e:	83 ec 08             	sub    $0x8,%esp
  801871:	ff 75 f4             	pushl  -0xc(%ebp)
  801874:	50                   	push   %eax
  801875:	e8 4c ea ff ff       	call   8002c6 <vcprintf>
  80187a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80187d:	83 ec 08             	sub    $0x8,%esp
  801880:	6a 00                	push   $0x0
  801882:	68 8d 21 80 00       	push   $0x80218d
  801887:	e8 3a ea ff ff       	call   8002c6 <vcprintf>
  80188c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80188f:	e8 bb e9 ff ff       	call   80024f <exit>

	// should not return here
	while (1) ;
  801894:	eb fe                	jmp    801894 <_panic+0x70>

00801896 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801896:	55                   	push   %ebp
  801897:	89 e5                	mov    %esp,%ebp
  801899:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80189c:	a1 20 30 80 00       	mov    0x803020,%eax
  8018a1:	8b 50 74             	mov    0x74(%eax),%edx
  8018a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a7:	39 c2                	cmp    %eax,%edx
  8018a9:	74 14                	je     8018bf <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8018ab:	83 ec 04             	sub    $0x4,%esp
  8018ae:	68 90 21 80 00       	push   $0x802190
  8018b3:	6a 26                	push   $0x26
  8018b5:	68 dc 21 80 00       	push   $0x8021dc
  8018ba:	e8 65 ff ff ff       	call   801824 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8018bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8018c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8018cd:	e9 c4 00 00 00       	jmp    801996 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8018d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018df:	01 d0                	add    %edx,%eax
  8018e1:	8b 00                	mov    (%eax),%eax
  8018e3:	85 c0                	test   %eax,%eax
  8018e5:	75 08                	jne    8018ef <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8018e7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8018ea:	e9 a4 00 00 00       	jmp    801993 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8018ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018f6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8018fd:	eb 6b                	jmp    80196a <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8018ff:	a1 20 30 80 00       	mov    0x803020,%eax
  801904:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80190a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80190d:	89 d0                	mov    %edx,%eax
  80190f:	c1 e0 02             	shl    $0x2,%eax
  801912:	01 d0                	add    %edx,%eax
  801914:	c1 e0 02             	shl    $0x2,%eax
  801917:	01 c8                	add    %ecx,%eax
  801919:	8a 40 04             	mov    0x4(%eax),%al
  80191c:	84 c0                	test   %al,%al
  80191e:	75 47                	jne    801967 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801920:	a1 20 30 80 00       	mov    0x803020,%eax
  801925:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80192b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80192e:	89 d0                	mov    %edx,%eax
  801930:	c1 e0 02             	shl    $0x2,%eax
  801933:	01 d0                	add    %edx,%eax
  801935:	c1 e0 02             	shl    $0x2,%eax
  801938:	01 c8                	add    %ecx,%eax
  80193a:	8b 00                	mov    (%eax),%eax
  80193c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80193f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801942:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801947:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801949:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80194c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801953:	8b 45 08             	mov    0x8(%ebp),%eax
  801956:	01 c8                	add    %ecx,%eax
  801958:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80195a:	39 c2                	cmp    %eax,%edx
  80195c:	75 09                	jne    801967 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80195e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801965:	eb 12                	jmp    801979 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801967:	ff 45 e8             	incl   -0x18(%ebp)
  80196a:	a1 20 30 80 00       	mov    0x803020,%eax
  80196f:	8b 50 74             	mov    0x74(%eax),%edx
  801972:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801975:	39 c2                	cmp    %eax,%edx
  801977:	77 86                	ja     8018ff <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801979:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80197d:	75 14                	jne    801993 <CheckWSWithoutLastIndex+0xfd>
			panic(
  80197f:	83 ec 04             	sub    $0x4,%esp
  801982:	68 e8 21 80 00       	push   $0x8021e8
  801987:	6a 3a                	push   $0x3a
  801989:	68 dc 21 80 00       	push   $0x8021dc
  80198e:	e8 91 fe ff ff       	call   801824 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801993:	ff 45 f0             	incl   -0x10(%ebp)
  801996:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801999:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80199c:	0f 8c 30 ff ff ff    	jl     8018d2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8019a2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019a9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8019b0:	eb 27                	jmp    8019d9 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8019b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8019b7:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8019bd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019c0:	89 d0                	mov    %edx,%eax
  8019c2:	c1 e0 02             	shl    $0x2,%eax
  8019c5:	01 d0                	add    %edx,%eax
  8019c7:	c1 e0 02             	shl    $0x2,%eax
  8019ca:	01 c8                	add    %ecx,%eax
  8019cc:	8a 40 04             	mov    0x4(%eax),%al
  8019cf:	3c 01                	cmp    $0x1,%al
  8019d1:	75 03                	jne    8019d6 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8019d3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019d6:	ff 45 e0             	incl   -0x20(%ebp)
  8019d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8019de:	8b 50 74             	mov    0x74(%eax),%edx
  8019e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019e4:	39 c2                	cmp    %eax,%edx
  8019e6:	77 ca                	ja     8019b2 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8019e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019eb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019ee:	74 14                	je     801a04 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8019f0:	83 ec 04             	sub    $0x4,%esp
  8019f3:	68 3c 22 80 00       	push   $0x80223c
  8019f8:	6a 44                	push   $0x44
  8019fa:	68 dc 21 80 00       	push   $0x8021dc
  8019ff:	e8 20 fe ff ff       	call   801824 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801a04:	90                   	nop
  801a05:	c9                   	leave  
  801a06:	c3                   	ret    
  801a07:	90                   	nop

00801a08 <__udivdi3>:
  801a08:	55                   	push   %ebp
  801a09:	57                   	push   %edi
  801a0a:	56                   	push   %esi
  801a0b:	53                   	push   %ebx
  801a0c:	83 ec 1c             	sub    $0x1c,%esp
  801a0f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a13:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a17:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a1b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a1f:	89 ca                	mov    %ecx,%edx
  801a21:	89 f8                	mov    %edi,%eax
  801a23:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a27:	85 f6                	test   %esi,%esi
  801a29:	75 2d                	jne    801a58 <__udivdi3+0x50>
  801a2b:	39 cf                	cmp    %ecx,%edi
  801a2d:	77 65                	ja     801a94 <__udivdi3+0x8c>
  801a2f:	89 fd                	mov    %edi,%ebp
  801a31:	85 ff                	test   %edi,%edi
  801a33:	75 0b                	jne    801a40 <__udivdi3+0x38>
  801a35:	b8 01 00 00 00       	mov    $0x1,%eax
  801a3a:	31 d2                	xor    %edx,%edx
  801a3c:	f7 f7                	div    %edi
  801a3e:	89 c5                	mov    %eax,%ebp
  801a40:	31 d2                	xor    %edx,%edx
  801a42:	89 c8                	mov    %ecx,%eax
  801a44:	f7 f5                	div    %ebp
  801a46:	89 c1                	mov    %eax,%ecx
  801a48:	89 d8                	mov    %ebx,%eax
  801a4a:	f7 f5                	div    %ebp
  801a4c:	89 cf                	mov    %ecx,%edi
  801a4e:	89 fa                	mov    %edi,%edx
  801a50:	83 c4 1c             	add    $0x1c,%esp
  801a53:	5b                   	pop    %ebx
  801a54:	5e                   	pop    %esi
  801a55:	5f                   	pop    %edi
  801a56:	5d                   	pop    %ebp
  801a57:	c3                   	ret    
  801a58:	39 ce                	cmp    %ecx,%esi
  801a5a:	77 28                	ja     801a84 <__udivdi3+0x7c>
  801a5c:	0f bd fe             	bsr    %esi,%edi
  801a5f:	83 f7 1f             	xor    $0x1f,%edi
  801a62:	75 40                	jne    801aa4 <__udivdi3+0x9c>
  801a64:	39 ce                	cmp    %ecx,%esi
  801a66:	72 0a                	jb     801a72 <__udivdi3+0x6a>
  801a68:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a6c:	0f 87 9e 00 00 00    	ja     801b10 <__udivdi3+0x108>
  801a72:	b8 01 00 00 00       	mov    $0x1,%eax
  801a77:	89 fa                	mov    %edi,%edx
  801a79:	83 c4 1c             	add    $0x1c,%esp
  801a7c:	5b                   	pop    %ebx
  801a7d:	5e                   	pop    %esi
  801a7e:	5f                   	pop    %edi
  801a7f:	5d                   	pop    %ebp
  801a80:	c3                   	ret    
  801a81:	8d 76 00             	lea    0x0(%esi),%esi
  801a84:	31 ff                	xor    %edi,%edi
  801a86:	31 c0                	xor    %eax,%eax
  801a88:	89 fa                	mov    %edi,%edx
  801a8a:	83 c4 1c             	add    $0x1c,%esp
  801a8d:	5b                   	pop    %ebx
  801a8e:	5e                   	pop    %esi
  801a8f:	5f                   	pop    %edi
  801a90:	5d                   	pop    %ebp
  801a91:	c3                   	ret    
  801a92:	66 90                	xchg   %ax,%ax
  801a94:	89 d8                	mov    %ebx,%eax
  801a96:	f7 f7                	div    %edi
  801a98:	31 ff                	xor    %edi,%edi
  801a9a:	89 fa                	mov    %edi,%edx
  801a9c:	83 c4 1c             	add    $0x1c,%esp
  801a9f:	5b                   	pop    %ebx
  801aa0:	5e                   	pop    %esi
  801aa1:	5f                   	pop    %edi
  801aa2:	5d                   	pop    %ebp
  801aa3:	c3                   	ret    
  801aa4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801aa9:	89 eb                	mov    %ebp,%ebx
  801aab:	29 fb                	sub    %edi,%ebx
  801aad:	89 f9                	mov    %edi,%ecx
  801aaf:	d3 e6                	shl    %cl,%esi
  801ab1:	89 c5                	mov    %eax,%ebp
  801ab3:	88 d9                	mov    %bl,%cl
  801ab5:	d3 ed                	shr    %cl,%ebp
  801ab7:	89 e9                	mov    %ebp,%ecx
  801ab9:	09 f1                	or     %esi,%ecx
  801abb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801abf:	89 f9                	mov    %edi,%ecx
  801ac1:	d3 e0                	shl    %cl,%eax
  801ac3:	89 c5                	mov    %eax,%ebp
  801ac5:	89 d6                	mov    %edx,%esi
  801ac7:	88 d9                	mov    %bl,%cl
  801ac9:	d3 ee                	shr    %cl,%esi
  801acb:	89 f9                	mov    %edi,%ecx
  801acd:	d3 e2                	shl    %cl,%edx
  801acf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ad3:	88 d9                	mov    %bl,%cl
  801ad5:	d3 e8                	shr    %cl,%eax
  801ad7:	09 c2                	or     %eax,%edx
  801ad9:	89 d0                	mov    %edx,%eax
  801adb:	89 f2                	mov    %esi,%edx
  801add:	f7 74 24 0c          	divl   0xc(%esp)
  801ae1:	89 d6                	mov    %edx,%esi
  801ae3:	89 c3                	mov    %eax,%ebx
  801ae5:	f7 e5                	mul    %ebp
  801ae7:	39 d6                	cmp    %edx,%esi
  801ae9:	72 19                	jb     801b04 <__udivdi3+0xfc>
  801aeb:	74 0b                	je     801af8 <__udivdi3+0xf0>
  801aed:	89 d8                	mov    %ebx,%eax
  801aef:	31 ff                	xor    %edi,%edi
  801af1:	e9 58 ff ff ff       	jmp    801a4e <__udivdi3+0x46>
  801af6:	66 90                	xchg   %ax,%ax
  801af8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801afc:	89 f9                	mov    %edi,%ecx
  801afe:	d3 e2                	shl    %cl,%edx
  801b00:	39 c2                	cmp    %eax,%edx
  801b02:	73 e9                	jae    801aed <__udivdi3+0xe5>
  801b04:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b07:	31 ff                	xor    %edi,%edi
  801b09:	e9 40 ff ff ff       	jmp    801a4e <__udivdi3+0x46>
  801b0e:	66 90                	xchg   %ax,%ax
  801b10:	31 c0                	xor    %eax,%eax
  801b12:	e9 37 ff ff ff       	jmp    801a4e <__udivdi3+0x46>
  801b17:	90                   	nop

00801b18 <__umoddi3>:
  801b18:	55                   	push   %ebp
  801b19:	57                   	push   %edi
  801b1a:	56                   	push   %esi
  801b1b:	53                   	push   %ebx
  801b1c:	83 ec 1c             	sub    $0x1c,%esp
  801b1f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b23:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b27:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b2b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b2f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b33:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b37:	89 f3                	mov    %esi,%ebx
  801b39:	89 fa                	mov    %edi,%edx
  801b3b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b3f:	89 34 24             	mov    %esi,(%esp)
  801b42:	85 c0                	test   %eax,%eax
  801b44:	75 1a                	jne    801b60 <__umoddi3+0x48>
  801b46:	39 f7                	cmp    %esi,%edi
  801b48:	0f 86 a2 00 00 00    	jbe    801bf0 <__umoddi3+0xd8>
  801b4e:	89 c8                	mov    %ecx,%eax
  801b50:	89 f2                	mov    %esi,%edx
  801b52:	f7 f7                	div    %edi
  801b54:	89 d0                	mov    %edx,%eax
  801b56:	31 d2                	xor    %edx,%edx
  801b58:	83 c4 1c             	add    $0x1c,%esp
  801b5b:	5b                   	pop    %ebx
  801b5c:	5e                   	pop    %esi
  801b5d:	5f                   	pop    %edi
  801b5e:	5d                   	pop    %ebp
  801b5f:	c3                   	ret    
  801b60:	39 f0                	cmp    %esi,%eax
  801b62:	0f 87 ac 00 00 00    	ja     801c14 <__umoddi3+0xfc>
  801b68:	0f bd e8             	bsr    %eax,%ebp
  801b6b:	83 f5 1f             	xor    $0x1f,%ebp
  801b6e:	0f 84 ac 00 00 00    	je     801c20 <__umoddi3+0x108>
  801b74:	bf 20 00 00 00       	mov    $0x20,%edi
  801b79:	29 ef                	sub    %ebp,%edi
  801b7b:	89 fe                	mov    %edi,%esi
  801b7d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b81:	89 e9                	mov    %ebp,%ecx
  801b83:	d3 e0                	shl    %cl,%eax
  801b85:	89 d7                	mov    %edx,%edi
  801b87:	89 f1                	mov    %esi,%ecx
  801b89:	d3 ef                	shr    %cl,%edi
  801b8b:	09 c7                	or     %eax,%edi
  801b8d:	89 e9                	mov    %ebp,%ecx
  801b8f:	d3 e2                	shl    %cl,%edx
  801b91:	89 14 24             	mov    %edx,(%esp)
  801b94:	89 d8                	mov    %ebx,%eax
  801b96:	d3 e0                	shl    %cl,%eax
  801b98:	89 c2                	mov    %eax,%edx
  801b9a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b9e:	d3 e0                	shl    %cl,%eax
  801ba0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ba4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ba8:	89 f1                	mov    %esi,%ecx
  801baa:	d3 e8                	shr    %cl,%eax
  801bac:	09 d0                	or     %edx,%eax
  801bae:	d3 eb                	shr    %cl,%ebx
  801bb0:	89 da                	mov    %ebx,%edx
  801bb2:	f7 f7                	div    %edi
  801bb4:	89 d3                	mov    %edx,%ebx
  801bb6:	f7 24 24             	mull   (%esp)
  801bb9:	89 c6                	mov    %eax,%esi
  801bbb:	89 d1                	mov    %edx,%ecx
  801bbd:	39 d3                	cmp    %edx,%ebx
  801bbf:	0f 82 87 00 00 00    	jb     801c4c <__umoddi3+0x134>
  801bc5:	0f 84 91 00 00 00    	je     801c5c <__umoddi3+0x144>
  801bcb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bcf:	29 f2                	sub    %esi,%edx
  801bd1:	19 cb                	sbb    %ecx,%ebx
  801bd3:	89 d8                	mov    %ebx,%eax
  801bd5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bd9:	d3 e0                	shl    %cl,%eax
  801bdb:	89 e9                	mov    %ebp,%ecx
  801bdd:	d3 ea                	shr    %cl,%edx
  801bdf:	09 d0                	or     %edx,%eax
  801be1:	89 e9                	mov    %ebp,%ecx
  801be3:	d3 eb                	shr    %cl,%ebx
  801be5:	89 da                	mov    %ebx,%edx
  801be7:	83 c4 1c             	add    $0x1c,%esp
  801bea:	5b                   	pop    %ebx
  801beb:	5e                   	pop    %esi
  801bec:	5f                   	pop    %edi
  801bed:	5d                   	pop    %ebp
  801bee:	c3                   	ret    
  801bef:	90                   	nop
  801bf0:	89 fd                	mov    %edi,%ebp
  801bf2:	85 ff                	test   %edi,%edi
  801bf4:	75 0b                	jne    801c01 <__umoddi3+0xe9>
  801bf6:	b8 01 00 00 00       	mov    $0x1,%eax
  801bfb:	31 d2                	xor    %edx,%edx
  801bfd:	f7 f7                	div    %edi
  801bff:	89 c5                	mov    %eax,%ebp
  801c01:	89 f0                	mov    %esi,%eax
  801c03:	31 d2                	xor    %edx,%edx
  801c05:	f7 f5                	div    %ebp
  801c07:	89 c8                	mov    %ecx,%eax
  801c09:	f7 f5                	div    %ebp
  801c0b:	89 d0                	mov    %edx,%eax
  801c0d:	e9 44 ff ff ff       	jmp    801b56 <__umoddi3+0x3e>
  801c12:	66 90                	xchg   %ax,%ax
  801c14:	89 c8                	mov    %ecx,%eax
  801c16:	89 f2                	mov    %esi,%edx
  801c18:	83 c4 1c             	add    $0x1c,%esp
  801c1b:	5b                   	pop    %ebx
  801c1c:	5e                   	pop    %esi
  801c1d:	5f                   	pop    %edi
  801c1e:	5d                   	pop    %ebp
  801c1f:	c3                   	ret    
  801c20:	3b 04 24             	cmp    (%esp),%eax
  801c23:	72 06                	jb     801c2b <__umoddi3+0x113>
  801c25:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c29:	77 0f                	ja     801c3a <__umoddi3+0x122>
  801c2b:	89 f2                	mov    %esi,%edx
  801c2d:	29 f9                	sub    %edi,%ecx
  801c2f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c33:	89 14 24             	mov    %edx,(%esp)
  801c36:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c3a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c3e:	8b 14 24             	mov    (%esp),%edx
  801c41:	83 c4 1c             	add    $0x1c,%esp
  801c44:	5b                   	pop    %ebx
  801c45:	5e                   	pop    %esi
  801c46:	5f                   	pop    %edi
  801c47:	5d                   	pop    %ebp
  801c48:	c3                   	ret    
  801c49:	8d 76 00             	lea    0x0(%esi),%esi
  801c4c:	2b 04 24             	sub    (%esp),%eax
  801c4f:	19 fa                	sbb    %edi,%edx
  801c51:	89 d1                	mov    %edx,%ecx
  801c53:	89 c6                	mov    %eax,%esi
  801c55:	e9 71 ff ff ff       	jmp    801bcb <__umoddi3+0xb3>
  801c5a:	66 90                	xchg   %ax,%ax
  801c5c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c60:	72 ea                	jb     801c4c <__umoddi3+0x134>
  801c62:	89 d9                	mov    %ebx,%ecx
  801c64:	e9 62 ff ff ff       	jmp    801bcb <__umoddi3+0xb3>
