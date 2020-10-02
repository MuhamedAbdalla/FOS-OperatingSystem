
obj/user/tst_page_replacement_mod_clock:     file format elf32-i386


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
  800031:	e8 69 05 00 00       	call   80059f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 68             	sub    $0x68,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 00 20 80 00       	push   $0x802000
  800065:	6a 15                	push   $0x15
  800067:	68 44 20 80 00       	push   $0x802044
  80006c:	e8 53 06 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80007c:	83 c0 14             	add    $0x14,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800084:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 00 20 80 00       	push   $0x802000
  80009b:	6a 16                	push   $0x16
  80009d:	68 44 20 80 00       	push   $0x802044
  8000a2:	e8 1d 06 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000b2:	83 c0 28             	add    $0x28,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 00 20 80 00       	push   $0x802000
  8000d1:	6a 17                	push   $0x17
  8000d3:	68 44 20 80 00       	push   $0x802044
  8000d8:	e8 e7 05 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000e8:	83 c0 3c             	add    $0x3c,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 00 20 80 00       	push   $0x802000
  800107:	6a 18                	push   $0x18
  800109:	68 44 20 80 00       	push   $0x802044
  80010e:	e8 b1 05 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80011e:	83 c0 50             	add    $0x50,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800126:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 00 20 80 00       	push   $0x802000
  80013d:	6a 19                	push   $0x19
  80013f:	68 44 20 80 00       	push   $0x802044
  800144:	e8 7b 05 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800154:	83 c0 64             	add    $0x64,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80015c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 00 20 80 00       	push   $0x802000
  800173:	6a 1a                	push   $0x1a
  800175:	68 44 20 80 00       	push   $0x802044
  80017a:	e8 45 05 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80018a:	83 c0 78             	add    $0x78,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800192:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 00 20 80 00       	push   $0x802000
  8001a9:	6a 1b                	push   $0x1b
  8001ab:	68 44 20 80 00       	push   $0x802044
  8001b0:	e8 0f 05 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001c0:	05 8c 00 00 00       	add    $0x8c,%eax
  8001c5:	8b 00                	mov    (%eax),%eax
  8001c7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001ca:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d2:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d7:	74 14                	je     8001ed <_main+0x1b5>
  8001d9:	83 ec 04             	sub    $0x4,%esp
  8001dc:	68 00 20 80 00       	push   $0x802000
  8001e1:	6a 1c                	push   $0x1c
  8001e3:	68 44 20 80 00       	push   $0x802044
  8001e8:	e8 d7 04 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f2:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001f8:	05 a0 00 00 00       	add    $0xa0,%eax
  8001fd:	8b 00                	mov    (%eax),%eax
  8001ff:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800202:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800205:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020a:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020f:	74 14                	je     800225 <_main+0x1ed>
  800211:	83 ec 04             	sub    $0x4,%esp
  800214:	68 00 20 80 00       	push   $0x802000
  800219:	6a 1d                	push   $0x1d
  80021b:	68 44 20 80 00       	push   $0x802044
  800220:	e8 9f 04 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800225:	a1 20 30 80 00       	mov    0x803020,%eax
  80022a:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800230:	05 b4 00 00 00       	add    $0xb4,%eax
  800235:	8b 00                	mov    (%eax),%eax
  800237:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80023a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80023d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800242:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800247:	74 14                	je     80025d <_main+0x225>
  800249:	83 ec 04             	sub    $0x4,%esp
  80024c:	68 00 20 80 00       	push   $0x802000
  800251:	6a 1e                	push   $0x1e
  800253:	68 44 20 80 00       	push   $0x802044
  800258:	e8 67 04 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025d:	a1 20 30 80 00       	mov    0x803020,%eax
  800262:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800268:	05 c8 00 00 00       	add    $0xc8,%eax
  80026d:	8b 00                	mov    (%eax),%eax
  80026f:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800272:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800275:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80027a:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027f:	74 14                	je     800295 <_main+0x25d>
  800281:	83 ec 04             	sub    $0x4,%esp
  800284:	68 00 20 80 00       	push   $0x802000
  800289:	6a 1f                	push   $0x1f
  80028b:	68 44 20 80 00       	push   $0x802044
  800290:	e8 2f 04 00 00       	call   8006c4 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800295:	a1 20 30 80 00       	mov    0x803020,%eax
  80029a:	8b 80 80 52 00 00    	mov    0x5280(%eax),%eax
  8002a0:	85 c0                	test   %eax,%eax
  8002a2:	74 14                	je     8002b8 <_main+0x280>
  8002a4:	83 ec 04             	sub    $0x4,%esp
  8002a7:	68 6c 20 80 00       	push   $0x80206c
  8002ac:	6a 20                	push   $0x20
  8002ae:	68 44 20 80 00       	push   $0x802044
  8002b3:	e8 0c 04 00 00       	call   8006c4 <_panic>
	}

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8002b8:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002bd:	88 45 c7             	mov    %al,-0x39(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002c0:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002c5:	88 45 c6             	mov    %al,-0x3a(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002cf:	eb 37                	jmp    800308 <_main+0x2d0>
	{
		arr[i] = -1 ;
  8002d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002d4:	05 40 30 80 00       	add    $0x803040,%eax
  8002d9:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002dc:	a1 04 30 80 00       	mov    0x803004,%eax
  8002e1:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002e7:	8a 12                	mov    (%edx),%dl
  8002e9:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002eb:	a1 00 30 80 00       	mov    0x803000,%eax
  8002f0:	40                   	inc    %eax
  8002f1:	a3 00 30 80 00       	mov    %eax,0x803000
  8002f6:	a1 04 30 80 00       	mov    0x803004,%eax
  8002fb:	40                   	inc    %eax
  8002fc:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800301:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800308:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  80030f:	7e c0                	jle    8002d1 <_main+0x299>
		ptr++ ; ptr2++ ;
	}

	//===================
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x809000)  panic("modified clock algo failed");
  800311:	a1 20 30 80 00       	mov    0x803020,%eax
  800316:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80031c:	8b 00                	mov    (%eax),%eax
  80031e:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800321:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800324:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800329:	3d 00 90 80 00       	cmp    $0x809000,%eax
  80032e:	74 14                	je     800344 <_main+0x30c>
  800330:	83 ec 04             	sub    $0x4,%esp
  800333:	68 b2 20 80 00       	push   $0x8020b2
  800338:	6a 36                	push   $0x36
  80033a:	68 44 20 80 00       	push   $0x802044
  80033f:	e8 80 03 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("modified clock algo failed");
  800344:	a1 20 30 80 00       	mov    0x803020,%eax
  800349:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80034f:	83 c0 14             	add    $0x14,%eax
  800352:	8b 00                	mov    (%eax),%eax
  800354:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800357:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80035a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80035f:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  800364:	74 14                	je     80037a <_main+0x342>
  800366:	83 ec 04             	sub    $0x4,%esp
  800369:	68 b2 20 80 00       	push   $0x8020b2
  80036e:	6a 37                	push   $0x37
  800370:	68 44 20 80 00       	push   $0x802044
  800375:	e8 4a 03 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x804000)  panic("modified clock algo failed");
  80037a:	a1 20 30 80 00       	mov    0x803020,%eax
  80037f:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800385:	83 c0 28             	add    $0x28,%eax
  800388:	8b 00                	mov    (%eax),%eax
  80038a:	89 45 b8             	mov    %eax,-0x48(%ebp)
  80038d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800390:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800395:	3d 00 40 80 00       	cmp    $0x804000,%eax
  80039a:	74 14                	je     8003b0 <_main+0x378>
  80039c:	83 ec 04             	sub    $0x4,%esp
  80039f:	68 b2 20 80 00       	push   $0x8020b2
  8003a4:	6a 38                	push   $0x38
  8003a6:	68 44 20 80 00       	push   $0x802044
  8003ab:	e8 14 03 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x80b000)  panic("modified clock algo failed");
  8003b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b5:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8003bb:	83 c0 3c             	add    $0x3c,%eax
  8003be:	8b 00                	mov    (%eax),%eax
  8003c0:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8003c3:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8003c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003cb:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  8003d0:	74 14                	je     8003e6 <_main+0x3ae>
  8003d2:	83 ec 04             	sub    $0x4,%esp
  8003d5:	68 b2 20 80 00       	push   $0x8020b2
  8003da:	6a 39                	push   $0x39
  8003dc:	68 44 20 80 00       	push   $0x802044
  8003e1:	e8 de 02 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x80c000)  panic("modified clock algo failed");
  8003e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003eb:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8003f1:	83 c0 50             	add    $0x50,%eax
  8003f4:	8b 00                	mov    (%eax),%eax
  8003f6:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8003f9:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8003fc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800401:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800406:	74 14                	je     80041c <_main+0x3e4>
  800408:	83 ec 04             	sub    $0x4,%esp
  80040b:	68 b2 20 80 00       	push   $0x8020b2
  800410:	6a 3a                	push   $0x3a
  800412:	68 44 20 80 00       	push   $0x802044
  800417:	e8 a8 02 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x807000)  panic("modified clock algo failed");
  80041c:	a1 20 30 80 00       	mov    0x803020,%eax
  800421:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800427:	83 c0 64             	add    $0x64,%eax
  80042a:	8b 00                	mov    (%eax),%eax
  80042c:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80042f:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800432:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800437:	3d 00 70 80 00       	cmp    $0x807000,%eax
  80043c:	74 14                	je     800452 <_main+0x41a>
  80043e:	83 ec 04             	sub    $0x4,%esp
  800441:	68 b2 20 80 00       	push   $0x8020b2
  800446:	6a 3b                	push   $0x3b
  800448:	68 44 20 80 00       	push   $0x802044
  80044d:	e8 72 02 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x800000)  panic("modified clock algo failed");
  800452:	a1 20 30 80 00       	mov    0x803020,%eax
  800457:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80045d:	83 c0 78             	add    $0x78,%eax
  800460:	8b 00                	mov    (%eax),%eax
  800462:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800465:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800468:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80046d:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800472:	74 14                	je     800488 <_main+0x450>
  800474:	83 ec 04             	sub    $0x4,%esp
  800477:	68 b2 20 80 00       	push   $0x8020b2
  80047c:	6a 3c                	push   $0x3c
  80047e:	68 44 20 80 00       	push   $0x802044
  800483:	e8 3c 02 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x801000)  panic("modified clock algo failed");
  800488:	a1 20 30 80 00       	mov    0x803020,%eax
  80048d:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800493:	05 8c 00 00 00       	add    $0x8c,%eax
  800498:	8b 00                	mov    (%eax),%eax
  80049a:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  80049d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8004a0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004a5:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8004aa:	74 14                	je     8004c0 <_main+0x488>
  8004ac:	83 ec 04             	sub    $0x4,%esp
  8004af:	68 b2 20 80 00       	push   $0x8020b2
  8004b4:	6a 3d                	push   $0x3d
  8004b6:	68 44 20 80 00       	push   $0x802044
  8004bb:	e8 04 02 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x808000)  panic("modified clock algo failed");
  8004c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c5:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8004cb:	05 a0 00 00 00       	add    $0xa0,%eax
  8004d0:	8b 00                	mov    (%eax),%eax
  8004d2:	89 45 a0             	mov    %eax,-0x60(%ebp)
  8004d5:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8004d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004dd:	3d 00 80 80 00       	cmp    $0x808000,%eax
  8004e2:	74 14                	je     8004f8 <_main+0x4c0>
  8004e4:	83 ec 04             	sub    $0x4,%esp
  8004e7:	68 b2 20 80 00       	push   $0x8020b2
  8004ec:	6a 3e                	push   $0x3e
  8004ee:	68 44 20 80 00       	push   $0x802044
  8004f3:	e8 cc 01 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x803000)  panic("modified clock algo failed");
  8004f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8004fd:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800503:	05 b4 00 00 00       	add    $0xb4,%eax
  800508:	8b 00                	mov    (%eax),%eax
  80050a:	89 45 9c             	mov    %eax,-0x64(%ebp)
  80050d:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800510:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800515:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80051a:	74 14                	je     800530 <_main+0x4f8>
  80051c:	83 ec 04             	sub    $0x4,%esp
  80051f:	68 b2 20 80 00       	push   $0x8020b2
  800524:	6a 3f                	push   $0x3f
  800526:	68 44 20 80 00       	push   $0x802044
  80052b:	e8 94 01 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("modified clock algo failed");
  800530:	a1 20 30 80 00       	mov    0x803020,%eax
  800535:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80053b:	05 c8 00 00 00       	add    $0xc8,%eax
  800540:	8b 00                	mov    (%eax),%eax
  800542:	89 45 98             	mov    %eax,-0x68(%ebp)
  800545:	8b 45 98             	mov    -0x68(%ebp),%eax
  800548:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80054d:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800552:	74 14                	je     800568 <_main+0x530>
  800554:	83 ec 04             	sub    $0x4,%esp
  800557:	68 b2 20 80 00       	push   $0x8020b2
  80055c:	6a 40                	push   $0x40
  80055e:	68 44 20 80 00       	push   $0x802044
  800563:	e8 5c 01 00 00       	call   8006c4 <_panic>

		if(myEnv->page_last_WS_index != 5) panic("wrong PAGE WS pointer location");
  800568:	a1 20 30 80 00       	mov    0x803020,%eax
  80056d:	8b 80 80 52 00 00    	mov    0x5280(%eax),%eax
  800573:	83 f8 05             	cmp    $0x5,%eax
  800576:	74 14                	je     80058c <_main+0x554>
  800578:	83 ec 04             	sub    $0x4,%esp
  80057b:	68 d0 20 80 00       	push   $0x8020d0
  800580:	6a 42                	push   $0x42
  800582:	68 44 20 80 00       	push   $0x802044
  800587:	e8 38 01 00 00       	call   8006c4 <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [Modified CLOCK Alg.] is completed successfully.\n");
  80058c:	83 ec 0c             	sub    $0xc,%esp
  80058f:	68 f0 20 80 00       	push   $0x8020f0
  800594:	e8 e2 03 00 00       	call   80097b <cprintf>
  800599:	83 c4 10             	add    $0x10,%esp
	return;
  80059c:	90                   	nop
}
  80059d:	c9                   	leave  
  80059e:	c3                   	ret    

0080059f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80059f:	55                   	push   %ebp
  8005a0:	89 e5                	mov    %esp,%ebp
  8005a2:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005a5:	e8 fc 11 00 00       	call   8017a6 <sys_getenvindex>
  8005aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005b0:	89 d0                	mov    %edx,%eax
  8005b2:	c1 e0 03             	shl    $0x3,%eax
  8005b5:	01 d0                	add    %edx,%eax
  8005b7:	c1 e0 02             	shl    $0x2,%eax
  8005ba:	01 d0                	add    %edx,%eax
  8005bc:	c1 e0 06             	shl    $0x6,%eax
  8005bf:	29 d0                	sub    %edx,%eax
  8005c1:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8005c8:	01 c8                	add    %ecx,%eax
  8005ca:	01 d0                	add    %edx,%eax
  8005cc:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005d1:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8005db:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8005e1:	84 c0                	test   %al,%al
  8005e3:	74 0f                	je     8005f4 <libmain+0x55>
		binaryname = myEnv->prog_name;
  8005e5:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ea:	05 b0 52 00 00       	add    $0x52b0,%eax
  8005ef:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005f4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005f8:	7e 0a                	jle    800604 <libmain+0x65>
		binaryname = argv[0];
  8005fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005fd:	8b 00                	mov    (%eax),%eax
  8005ff:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  800604:	83 ec 08             	sub    $0x8,%esp
  800607:	ff 75 0c             	pushl  0xc(%ebp)
  80060a:	ff 75 08             	pushl  0x8(%ebp)
  80060d:	e8 26 fa ff ff       	call   800038 <_main>
  800612:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800615:	e8 27 13 00 00       	call   801941 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80061a:	83 ec 0c             	sub    $0xc,%esp
  80061d:	68 64 21 80 00       	push   $0x802164
  800622:	e8 54 03 00 00       	call   80097b <cprintf>
  800627:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80062a:	a1 20 30 80 00       	mov    0x803020,%eax
  80062f:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800635:	a1 20 30 80 00       	mov    0x803020,%eax
  80063a:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800640:	83 ec 04             	sub    $0x4,%esp
  800643:	52                   	push   %edx
  800644:	50                   	push   %eax
  800645:	68 8c 21 80 00       	push   $0x80218c
  80064a:	e8 2c 03 00 00       	call   80097b <cprintf>
  80064f:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800652:	a1 20 30 80 00       	mov    0x803020,%eax
  800657:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  80065d:	a1 20 30 80 00       	mov    0x803020,%eax
  800662:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800668:	a1 20 30 80 00       	mov    0x803020,%eax
  80066d:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800673:	51                   	push   %ecx
  800674:	52                   	push   %edx
  800675:	50                   	push   %eax
  800676:	68 b4 21 80 00       	push   $0x8021b4
  80067b:	e8 fb 02 00 00       	call   80097b <cprintf>
  800680:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800683:	83 ec 0c             	sub    $0xc,%esp
  800686:	68 64 21 80 00       	push   $0x802164
  80068b:	e8 eb 02 00 00       	call   80097b <cprintf>
  800690:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800693:	e8 c3 12 00 00       	call   80195b <sys_enable_interrupt>

	// exit gracefully
	exit();
  800698:	e8 19 00 00 00       	call   8006b6 <exit>
}
  80069d:	90                   	nop
  80069e:	c9                   	leave  
  80069f:	c3                   	ret    

008006a0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006a0:	55                   	push   %ebp
  8006a1:	89 e5                	mov    %esp,%ebp
  8006a3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006a6:	83 ec 0c             	sub    $0xc,%esp
  8006a9:	6a 00                	push   $0x0
  8006ab:	e8 c2 10 00 00       	call   801772 <sys_env_destroy>
  8006b0:	83 c4 10             	add    $0x10,%esp
}
  8006b3:	90                   	nop
  8006b4:	c9                   	leave  
  8006b5:	c3                   	ret    

008006b6 <exit>:

void
exit(void)
{
  8006b6:	55                   	push   %ebp
  8006b7:	89 e5                	mov    %esp,%ebp
  8006b9:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006bc:	e8 17 11 00 00       	call   8017d8 <sys_env_exit>
}
  8006c1:	90                   	nop
  8006c2:	c9                   	leave  
  8006c3:	c3                   	ret    

008006c4 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006c4:	55                   	push   %ebp
  8006c5:	89 e5                	mov    %esp,%ebp
  8006c7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006ca:	8d 45 10             	lea    0x10(%ebp),%eax
  8006cd:	83 c0 04             	add    $0x4,%eax
  8006d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006d3:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8006d8:	85 c0                	test   %eax,%eax
  8006da:	74 16                	je     8006f2 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006dc:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8006e1:	83 ec 08             	sub    $0x8,%esp
  8006e4:	50                   	push   %eax
  8006e5:	68 0c 22 80 00       	push   $0x80220c
  8006ea:	e8 8c 02 00 00       	call   80097b <cprintf>
  8006ef:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006f2:	a1 08 30 80 00       	mov    0x803008,%eax
  8006f7:	ff 75 0c             	pushl  0xc(%ebp)
  8006fa:	ff 75 08             	pushl  0x8(%ebp)
  8006fd:	50                   	push   %eax
  8006fe:	68 11 22 80 00       	push   $0x802211
  800703:	e8 73 02 00 00       	call   80097b <cprintf>
  800708:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80070b:	8b 45 10             	mov    0x10(%ebp),%eax
  80070e:	83 ec 08             	sub    $0x8,%esp
  800711:	ff 75 f4             	pushl  -0xc(%ebp)
  800714:	50                   	push   %eax
  800715:	e8 f6 01 00 00       	call   800910 <vcprintf>
  80071a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80071d:	83 ec 08             	sub    $0x8,%esp
  800720:	6a 00                	push   $0x0
  800722:	68 2d 22 80 00       	push   $0x80222d
  800727:	e8 e4 01 00 00       	call   800910 <vcprintf>
  80072c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80072f:	e8 82 ff ff ff       	call   8006b6 <exit>

	// should not return here
	while (1) ;
  800734:	eb fe                	jmp    800734 <_panic+0x70>

00800736 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800736:	55                   	push   %ebp
  800737:	89 e5                	mov    %esp,%ebp
  800739:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80073c:	a1 20 30 80 00       	mov    0x803020,%eax
  800741:	8b 50 74             	mov    0x74(%eax),%edx
  800744:	8b 45 0c             	mov    0xc(%ebp),%eax
  800747:	39 c2                	cmp    %eax,%edx
  800749:	74 14                	je     80075f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80074b:	83 ec 04             	sub    $0x4,%esp
  80074e:	68 30 22 80 00       	push   $0x802230
  800753:	6a 26                	push   $0x26
  800755:	68 7c 22 80 00       	push   $0x80227c
  80075a:	e8 65 ff ff ff       	call   8006c4 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80075f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800766:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80076d:	e9 c4 00 00 00       	jmp    800836 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800772:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800775:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80077c:	8b 45 08             	mov    0x8(%ebp),%eax
  80077f:	01 d0                	add    %edx,%eax
  800781:	8b 00                	mov    (%eax),%eax
  800783:	85 c0                	test   %eax,%eax
  800785:	75 08                	jne    80078f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800787:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80078a:	e9 a4 00 00 00       	jmp    800833 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  80078f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800796:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80079d:	eb 6b                	jmp    80080a <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80079f:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a4:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8007aa:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ad:	89 d0                	mov    %edx,%eax
  8007af:	c1 e0 02             	shl    $0x2,%eax
  8007b2:	01 d0                	add    %edx,%eax
  8007b4:	c1 e0 02             	shl    $0x2,%eax
  8007b7:	01 c8                	add    %ecx,%eax
  8007b9:	8a 40 04             	mov    0x4(%eax),%al
  8007bc:	84 c0                	test   %al,%al
  8007be:	75 47                	jne    800807 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8007c5:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8007cb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ce:	89 d0                	mov    %edx,%eax
  8007d0:	c1 e0 02             	shl    $0x2,%eax
  8007d3:	01 d0                	add    %edx,%eax
  8007d5:	c1 e0 02             	shl    $0x2,%eax
  8007d8:	01 c8                	add    %ecx,%eax
  8007da:	8b 00                	mov    (%eax),%eax
  8007dc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007df:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007e7:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ec:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f6:	01 c8                	add    %ecx,%eax
  8007f8:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007fa:	39 c2                	cmp    %eax,%edx
  8007fc:	75 09                	jne    800807 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  8007fe:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800805:	eb 12                	jmp    800819 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800807:	ff 45 e8             	incl   -0x18(%ebp)
  80080a:	a1 20 30 80 00       	mov    0x803020,%eax
  80080f:	8b 50 74             	mov    0x74(%eax),%edx
  800812:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800815:	39 c2                	cmp    %eax,%edx
  800817:	77 86                	ja     80079f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800819:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80081d:	75 14                	jne    800833 <CheckWSWithoutLastIndex+0xfd>
			panic(
  80081f:	83 ec 04             	sub    $0x4,%esp
  800822:	68 88 22 80 00       	push   $0x802288
  800827:	6a 3a                	push   $0x3a
  800829:	68 7c 22 80 00       	push   $0x80227c
  80082e:	e8 91 fe ff ff       	call   8006c4 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800833:	ff 45 f0             	incl   -0x10(%ebp)
  800836:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800839:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80083c:	0f 8c 30 ff ff ff    	jl     800772 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800842:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800849:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800850:	eb 27                	jmp    800879 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800852:	a1 20 30 80 00       	mov    0x803020,%eax
  800857:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80085d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800860:	89 d0                	mov    %edx,%eax
  800862:	c1 e0 02             	shl    $0x2,%eax
  800865:	01 d0                	add    %edx,%eax
  800867:	c1 e0 02             	shl    $0x2,%eax
  80086a:	01 c8                	add    %ecx,%eax
  80086c:	8a 40 04             	mov    0x4(%eax),%al
  80086f:	3c 01                	cmp    $0x1,%al
  800871:	75 03                	jne    800876 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800873:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800876:	ff 45 e0             	incl   -0x20(%ebp)
  800879:	a1 20 30 80 00       	mov    0x803020,%eax
  80087e:	8b 50 74             	mov    0x74(%eax),%edx
  800881:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800884:	39 c2                	cmp    %eax,%edx
  800886:	77 ca                	ja     800852 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800888:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80088b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80088e:	74 14                	je     8008a4 <CheckWSWithoutLastIndex+0x16e>
		panic(
  800890:	83 ec 04             	sub    $0x4,%esp
  800893:	68 dc 22 80 00       	push   $0x8022dc
  800898:	6a 44                	push   $0x44
  80089a:	68 7c 22 80 00       	push   $0x80227c
  80089f:	e8 20 fe ff ff       	call   8006c4 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008a4:	90                   	nop
  8008a5:	c9                   	leave  
  8008a6:	c3                   	ret    

008008a7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008a7:	55                   	push   %ebp
  8008a8:	89 e5                	mov    %esp,%ebp
  8008aa:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b0:	8b 00                	mov    (%eax),%eax
  8008b2:	8d 48 01             	lea    0x1(%eax),%ecx
  8008b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b8:	89 0a                	mov    %ecx,(%edx)
  8008ba:	8b 55 08             	mov    0x8(%ebp),%edx
  8008bd:	88 d1                	mov    %dl,%cl
  8008bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c9:	8b 00                	mov    (%eax),%eax
  8008cb:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008d0:	75 2c                	jne    8008fe <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008d2:	a0 24 30 80 00       	mov    0x803024,%al
  8008d7:	0f b6 c0             	movzbl %al,%eax
  8008da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008dd:	8b 12                	mov    (%edx),%edx
  8008df:	89 d1                	mov    %edx,%ecx
  8008e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e4:	83 c2 08             	add    $0x8,%edx
  8008e7:	83 ec 04             	sub    $0x4,%esp
  8008ea:	50                   	push   %eax
  8008eb:	51                   	push   %ecx
  8008ec:	52                   	push   %edx
  8008ed:	e8 3e 0e 00 00       	call   801730 <sys_cputs>
  8008f2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800901:	8b 40 04             	mov    0x4(%eax),%eax
  800904:	8d 50 01             	lea    0x1(%eax),%edx
  800907:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80090d:	90                   	nop
  80090e:	c9                   	leave  
  80090f:	c3                   	ret    

00800910 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800910:	55                   	push   %ebp
  800911:	89 e5                	mov    %esp,%ebp
  800913:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800919:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800920:	00 00 00 
	b.cnt = 0;
  800923:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80092a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80092d:	ff 75 0c             	pushl  0xc(%ebp)
  800930:	ff 75 08             	pushl  0x8(%ebp)
  800933:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800939:	50                   	push   %eax
  80093a:	68 a7 08 80 00       	push   $0x8008a7
  80093f:	e8 11 02 00 00       	call   800b55 <vprintfmt>
  800944:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800947:	a0 24 30 80 00       	mov    0x803024,%al
  80094c:	0f b6 c0             	movzbl %al,%eax
  80094f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800955:	83 ec 04             	sub    $0x4,%esp
  800958:	50                   	push   %eax
  800959:	52                   	push   %edx
  80095a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800960:	83 c0 08             	add    $0x8,%eax
  800963:	50                   	push   %eax
  800964:	e8 c7 0d 00 00       	call   801730 <sys_cputs>
  800969:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80096c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800973:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800979:	c9                   	leave  
  80097a:	c3                   	ret    

0080097b <cprintf>:

int cprintf(const char *fmt, ...) {
  80097b:	55                   	push   %ebp
  80097c:	89 e5                	mov    %esp,%ebp
  80097e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800981:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800988:	8d 45 0c             	lea    0xc(%ebp),%eax
  80098b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80098e:	8b 45 08             	mov    0x8(%ebp),%eax
  800991:	83 ec 08             	sub    $0x8,%esp
  800994:	ff 75 f4             	pushl  -0xc(%ebp)
  800997:	50                   	push   %eax
  800998:	e8 73 ff ff ff       	call   800910 <vcprintf>
  80099d:	83 c4 10             	add    $0x10,%esp
  8009a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009a6:	c9                   	leave  
  8009a7:	c3                   	ret    

008009a8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009a8:	55                   	push   %ebp
  8009a9:	89 e5                	mov    %esp,%ebp
  8009ab:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009ae:	e8 8e 0f 00 00       	call   801941 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009b3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bc:	83 ec 08             	sub    $0x8,%esp
  8009bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c2:	50                   	push   %eax
  8009c3:	e8 48 ff ff ff       	call   800910 <vcprintf>
  8009c8:	83 c4 10             	add    $0x10,%esp
  8009cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009ce:	e8 88 0f 00 00       	call   80195b <sys_enable_interrupt>
	return cnt;
  8009d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009d6:	c9                   	leave  
  8009d7:	c3                   	ret    

008009d8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009d8:	55                   	push   %ebp
  8009d9:	89 e5                	mov    %esp,%ebp
  8009db:	53                   	push   %ebx
  8009dc:	83 ec 14             	sub    $0x14,%esp
  8009df:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009eb:	8b 45 18             	mov    0x18(%ebp),%eax
  8009ee:	ba 00 00 00 00       	mov    $0x0,%edx
  8009f3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009f6:	77 55                	ja     800a4d <printnum+0x75>
  8009f8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009fb:	72 05                	jb     800a02 <printnum+0x2a>
  8009fd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a00:	77 4b                	ja     800a4d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a02:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a05:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a08:	8b 45 18             	mov    0x18(%ebp),%eax
  800a0b:	ba 00 00 00 00       	mov    $0x0,%edx
  800a10:	52                   	push   %edx
  800a11:	50                   	push   %eax
  800a12:	ff 75 f4             	pushl  -0xc(%ebp)
  800a15:	ff 75 f0             	pushl  -0x10(%ebp)
  800a18:	e8 63 13 00 00       	call   801d80 <__udivdi3>
  800a1d:	83 c4 10             	add    $0x10,%esp
  800a20:	83 ec 04             	sub    $0x4,%esp
  800a23:	ff 75 20             	pushl  0x20(%ebp)
  800a26:	53                   	push   %ebx
  800a27:	ff 75 18             	pushl  0x18(%ebp)
  800a2a:	52                   	push   %edx
  800a2b:	50                   	push   %eax
  800a2c:	ff 75 0c             	pushl  0xc(%ebp)
  800a2f:	ff 75 08             	pushl  0x8(%ebp)
  800a32:	e8 a1 ff ff ff       	call   8009d8 <printnum>
  800a37:	83 c4 20             	add    $0x20,%esp
  800a3a:	eb 1a                	jmp    800a56 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a3c:	83 ec 08             	sub    $0x8,%esp
  800a3f:	ff 75 0c             	pushl  0xc(%ebp)
  800a42:	ff 75 20             	pushl  0x20(%ebp)
  800a45:	8b 45 08             	mov    0x8(%ebp),%eax
  800a48:	ff d0                	call   *%eax
  800a4a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a4d:	ff 4d 1c             	decl   0x1c(%ebp)
  800a50:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a54:	7f e6                	jg     800a3c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a56:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a59:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a61:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a64:	53                   	push   %ebx
  800a65:	51                   	push   %ecx
  800a66:	52                   	push   %edx
  800a67:	50                   	push   %eax
  800a68:	e8 23 14 00 00       	call   801e90 <__umoddi3>
  800a6d:	83 c4 10             	add    $0x10,%esp
  800a70:	05 54 25 80 00       	add    $0x802554,%eax
  800a75:	8a 00                	mov    (%eax),%al
  800a77:	0f be c0             	movsbl %al,%eax
  800a7a:	83 ec 08             	sub    $0x8,%esp
  800a7d:	ff 75 0c             	pushl  0xc(%ebp)
  800a80:	50                   	push   %eax
  800a81:	8b 45 08             	mov    0x8(%ebp),%eax
  800a84:	ff d0                	call   *%eax
  800a86:	83 c4 10             	add    $0x10,%esp
}
  800a89:	90                   	nop
  800a8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a8d:	c9                   	leave  
  800a8e:	c3                   	ret    

00800a8f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a8f:	55                   	push   %ebp
  800a90:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a92:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a96:	7e 1c                	jle    800ab4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a98:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9b:	8b 00                	mov    (%eax),%eax
  800a9d:	8d 50 08             	lea    0x8(%eax),%edx
  800aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa3:	89 10                	mov    %edx,(%eax)
  800aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa8:	8b 00                	mov    (%eax),%eax
  800aaa:	83 e8 08             	sub    $0x8,%eax
  800aad:	8b 50 04             	mov    0x4(%eax),%edx
  800ab0:	8b 00                	mov    (%eax),%eax
  800ab2:	eb 40                	jmp    800af4 <getuint+0x65>
	else if (lflag)
  800ab4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ab8:	74 1e                	je     800ad8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	8b 00                	mov    (%eax),%eax
  800abf:	8d 50 04             	lea    0x4(%eax),%edx
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac5:	89 10                	mov    %edx,(%eax)
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	8b 00                	mov    (%eax),%eax
  800acc:	83 e8 04             	sub    $0x4,%eax
  800acf:	8b 00                	mov    (%eax),%eax
  800ad1:	ba 00 00 00 00       	mov    $0x0,%edx
  800ad6:	eb 1c                	jmp    800af4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8b 00                	mov    (%eax),%eax
  800add:	8d 50 04             	lea    0x4(%eax),%edx
  800ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae3:	89 10                	mov    %edx,(%eax)
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	8b 00                	mov    (%eax),%eax
  800aea:	83 e8 04             	sub    $0x4,%eax
  800aed:	8b 00                	mov    (%eax),%eax
  800aef:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800af4:	5d                   	pop    %ebp
  800af5:	c3                   	ret    

00800af6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800af6:	55                   	push   %ebp
  800af7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800af9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800afd:	7e 1c                	jle    800b1b <getint+0x25>
		return va_arg(*ap, long long);
  800aff:	8b 45 08             	mov    0x8(%ebp),%eax
  800b02:	8b 00                	mov    (%eax),%eax
  800b04:	8d 50 08             	lea    0x8(%eax),%edx
  800b07:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0a:	89 10                	mov    %edx,(%eax)
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	8b 00                	mov    (%eax),%eax
  800b11:	83 e8 08             	sub    $0x8,%eax
  800b14:	8b 50 04             	mov    0x4(%eax),%edx
  800b17:	8b 00                	mov    (%eax),%eax
  800b19:	eb 38                	jmp    800b53 <getint+0x5d>
	else if (lflag)
  800b1b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b1f:	74 1a                	je     800b3b <getint+0x45>
		return va_arg(*ap, long);
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	8b 00                	mov    (%eax),%eax
  800b26:	8d 50 04             	lea    0x4(%eax),%edx
  800b29:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2c:	89 10                	mov    %edx,(%eax)
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	8b 00                	mov    (%eax),%eax
  800b33:	83 e8 04             	sub    $0x4,%eax
  800b36:	8b 00                	mov    (%eax),%eax
  800b38:	99                   	cltd   
  800b39:	eb 18                	jmp    800b53 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	8b 00                	mov    (%eax),%eax
  800b40:	8d 50 04             	lea    0x4(%eax),%edx
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	89 10                	mov    %edx,(%eax)
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	8b 00                	mov    (%eax),%eax
  800b4d:	83 e8 04             	sub    $0x4,%eax
  800b50:	8b 00                	mov    (%eax),%eax
  800b52:	99                   	cltd   
}
  800b53:	5d                   	pop    %ebp
  800b54:	c3                   	ret    

00800b55 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b55:	55                   	push   %ebp
  800b56:	89 e5                	mov    %esp,%ebp
  800b58:	56                   	push   %esi
  800b59:	53                   	push   %ebx
  800b5a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b5d:	eb 17                	jmp    800b76 <vprintfmt+0x21>
			if (ch == '\0')
  800b5f:	85 db                	test   %ebx,%ebx
  800b61:	0f 84 af 03 00 00    	je     800f16 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b67:	83 ec 08             	sub    $0x8,%esp
  800b6a:	ff 75 0c             	pushl  0xc(%ebp)
  800b6d:	53                   	push   %ebx
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	ff d0                	call   *%eax
  800b73:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b76:	8b 45 10             	mov    0x10(%ebp),%eax
  800b79:	8d 50 01             	lea    0x1(%eax),%edx
  800b7c:	89 55 10             	mov    %edx,0x10(%ebp)
  800b7f:	8a 00                	mov    (%eax),%al
  800b81:	0f b6 d8             	movzbl %al,%ebx
  800b84:	83 fb 25             	cmp    $0x25,%ebx
  800b87:	75 d6                	jne    800b5f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b89:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b8d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b94:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b9b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ba2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ba9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bac:	8d 50 01             	lea    0x1(%eax),%edx
  800baf:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb2:	8a 00                	mov    (%eax),%al
  800bb4:	0f b6 d8             	movzbl %al,%ebx
  800bb7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bba:	83 f8 55             	cmp    $0x55,%eax
  800bbd:	0f 87 2b 03 00 00    	ja     800eee <vprintfmt+0x399>
  800bc3:	8b 04 85 78 25 80 00 	mov    0x802578(,%eax,4),%eax
  800bca:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bcc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bd0:	eb d7                	jmp    800ba9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bd2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bd6:	eb d1                	jmp    800ba9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bd8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bdf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800be2:	89 d0                	mov    %edx,%eax
  800be4:	c1 e0 02             	shl    $0x2,%eax
  800be7:	01 d0                	add    %edx,%eax
  800be9:	01 c0                	add    %eax,%eax
  800beb:	01 d8                	add    %ebx,%eax
  800bed:	83 e8 30             	sub    $0x30,%eax
  800bf0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bf3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf6:	8a 00                	mov    (%eax),%al
  800bf8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bfb:	83 fb 2f             	cmp    $0x2f,%ebx
  800bfe:	7e 3e                	jle    800c3e <vprintfmt+0xe9>
  800c00:	83 fb 39             	cmp    $0x39,%ebx
  800c03:	7f 39                	jg     800c3e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c05:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c08:	eb d5                	jmp    800bdf <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0d:	83 c0 04             	add    $0x4,%eax
  800c10:	89 45 14             	mov    %eax,0x14(%ebp)
  800c13:	8b 45 14             	mov    0x14(%ebp),%eax
  800c16:	83 e8 04             	sub    $0x4,%eax
  800c19:	8b 00                	mov    (%eax),%eax
  800c1b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c1e:	eb 1f                	jmp    800c3f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c20:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c24:	79 83                	jns    800ba9 <vprintfmt+0x54>
				width = 0;
  800c26:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c2d:	e9 77 ff ff ff       	jmp    800ba9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c32:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c39:	e9 6b ff ff ff       	jmp    800ba9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c3e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c3f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c43:	0f 89 60 ff ff ff    	jns    800ba9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c49:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c4c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c4f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c56:	e9 4e ff ff ff       	jmp    800ba9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c5b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c5e:	e9 46 ff ff ff       	jmp    800ba9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c63:	8b 45 14             	mov    0x14(%ebp),%eax
  800c66:	83 c0 04             	add    $0x4,%eax
  800c69:	89 45 14             	mov    %eax,0x14(%ebp)
  800c6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6f:	83 e8 04             	sub    $0x4,%eax
  800c72:	8b 00                	mov    (%eax),%eax
  800c74:	83 ec 08             	sub    $0x8,%esp
  800c77:	ff 75 0c             	pushl  0xc(%ebp)
  800c7a:	50                   	push   %eax
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	ff d0                	call   *%eax
  800c80:	83 c4 10             	add    $0x10,%esp
			break;
  800c83:	e9 89 02 00 00       	jmp    800f11 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c88:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8b:	83 c0 04             	add    $0x4,%eax
  800c8e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c91:	8b 45 14             	mov    0x14(%ebp),%eax
  800c94:	83 e8 04             	sub    $0x4,%eax
  800c97:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c99:	85 db                	test   %ebx,%ebx
  800c9b:	79 02                	jns    800c9f <vprintfmt+0x14a>
				err = -err;
  800c9d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c9f:	83 fb 64             	cmp    $0x64,%ebx
  800ca2:	7f 0b                	jg     800caf <vprintfmt+0x15a>
  800ca4:	8b 34 9d c0 23 80 00 	mov    0x8023c0(,%ebx,4),%esi
  800cab:	85 f6                	test   %esi,%esi
  800cad:	75 19                	jne    800cc8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800caf:	53                   	push   %ebx
  800cb0:	68 65 25 80 00       	push   $0x802565
  800cb5:	ff 75 0c             	pushl  0xc(%ebp)
  800cb8:	ff 75 08             	pushl  0x8(%ebp)
  800cbb:	e8 5e 02 00 00       	call   800f1e <printfmt>
  800cc0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cc3:	e9 49 02 00 00       	jmp    800f11 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cc8:	56                   	push   %esi
  800cc9:	68 6e 25 80 00       	push   $0x80256e
  800cce:	ff 75 0c             	pushl  0xc(%ebp)
  800cd1:	ff 75 08             	pushl  0x8(%ebp)
  800cd4:	e8 45 02 00 00       	call   800f1e <printfmt>
  800cd9:	83 c4 10             	add    $0x10,%esp
			break;
  800cdc:	e9 30 02 00 00       	jmp    800f11 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ce1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce4:	83 c0 04             	add    $0x4,%eax
  800ce7:	89 45 14             	mov    %eax,0x14(%ebp)
  800cea:	8b 45 14             	mov    0x14(%ebp),%eax
  800ced:	83 e8 04             	sub    $0x4,%eax
  800cf0:	8b 30                	mov    (%eax),%esi
  800cf2:	85 f6                	test   %esi,%esi
  800cf4:	75 05                	jne    800cfb <vprintfmt+0x1a6>
				p = "(null)";
  800cf6:	be 71 25 80 00       	mov    $0x802571,%esi
			if (width > 0 && padc != '-')
  800cfb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cff:	7e 6d                	jle    800d6e <vprintfmt+0x219>
  800d01:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d05:	74 67                	je     800d6e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d07:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d0a:	83 ec 08             	sub    $0x8,%esp
  800d0d:	50                   	push   %eax
  800d0e:	56                   	push   %esi
  800d0f:	e8 0c 03 00 00       	call   801020 <strnlen>
  800d14:	83 c4 10             	add    $0x10,%esp
  800d17:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d1a:	eb 16                	jmp    800d32 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d1c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d20:	83 ec 08             	sub    $0x8,%esp
  800d23:	ff 75 0c             	pushl  0xc(%ebp)
  800d26:	50                   	push   %eax
  800d27:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2a:	ff d0                	call   *%eax
  800d2c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d2f:	ff 4d e4             	decl   -0x1c(%ebp)
  800d32:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d36:	7f e4                	jg     800d1c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d38:	eb 34                	jmp    800d6e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d3a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d3e:	74 1c                	je     800d5c <vprintfmt+0x207>
  800d40:	83 fb 1f             	cmp    $0x1f,%ebx
  800d43:	7e 05                	jle    800d4a <vprintfmt+0x1f5>
  800d45:	83 fb 7e             	cmp    $0x7e,%ebx
  800d48:	7e 12                	jle    800d5c <vprintfmt+0x207>
					putch('?', putdat);
  800d4a:	83 ec 08             	sub    $0x8,%esp
  800d4d:	ff 75 0c             	pushl  0xc(%ebp)
  800d50:	6a 3f                	push   $0x3f
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	ff d0                	call   *%eax
  800d57:	83 c4 10             	add    $0x10,%esp
  800d5a:	eb 0f                	jmp    800d6b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d5c:	83 ec 08             	sub    $0x8,%esp
  800d5f:	ff 75 0c             	pushl  0xc(%ebp)
  800d62:	53                   	push   %ebx
  800d63:	8b 45 08             	mov    0x8(%ebp),%eax
  800d66:	ff d0                	call   *%eax
  800d68:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d6b:	ff 4d e4             	decl   -0x1c(%ebp)
  800d6e:	89 f0                	mov    %esi,%eax
  800d70:	8d 70 01             	lea    0x1(%eax),%esi
  800d73:	8a 00                	mov    (%eax),%al
  800d75:	0f be d8             	movsbl %al,%ebx
  800d78:	85 db                	test   %ebx,%ebx
  800d7a:	74 24                	je     800da0 <vprintfmt+0x24b>
  800d7c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d80:	78 b8                	js     800d3a <vprintfmt+0x1e5>
  800d82:	ff 4d e0             	decl   -0x20(%ebp)
  800d85:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d89:	79 af                	jns    800d3a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d8b:	eb 13                	jmp    800da0 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d8d:	83 ec 08             	sub    $0x8,%esp
  800d90:	ff 75 0c             	pushl  0xc(%ebp)
  800d93:	6a 20                	push   $0x20
  800d95:	8b 45 08             	mov    0x8(%ebp),%eax
  800d98:	ff d0                	call   *%eax
  800d9a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d9d:	ff 4d e4             	decl   -0x1c(%ebp)
  800da0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da4:	7f e7                	jg     800d8d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800da6:	e9 66 01 00 00       	jmp    800f11 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dab:	83 ec 08             	sub    $0x8,%esp
  800dae:	ff 75 e8             	pushl  -0x18(%ebp)
  800db1:	8d 45 14             	lea    0x14(%ebp),%eax
  800db4:	50                   	push   %eax
  800db5:	e8 3c fd ff ff       	call   800af6 <getint>
  800dba:	83 c4 10             	add    $0x10,%esp
  800dbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dc0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dc9:	85 d2                	test   %edx,%edx
  800dcb:	79 23                	jns    800df0 <vprintfmt+0x29b>
				putch('-', putdat);
  800dcd:	83 ec 08             	sub    $0x8,%esp
  800dd0:	ff 75 0c             	pushl  0xc(%ebp)
  800dd3:	6a 2d                	push   $0x2d
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	ff d0                	call   *%eax
  800dda:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ddd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800de0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de3:	f7 d8                	neg    %eax
  800de5:	83 d2 00             	adc    $0x0,%edx
  800de8:	f7 da                	neg    %edx
  800dea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ded:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800df0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800df7:	e9 bc 00 00 00       	jmp    800eb8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800dfc:	83 ec 08             	sub    $0x8,%esp
  800dff:	ff 75 e8             	pushl  -0x18(%ebp)
  800e02:	8d 45 14             	lea    0x14(%ebp),%eax
  800e05:	50                   	push   %eax
  800e06:	e8 84 fc ff ff       	call   800a8f <getuint>
  800e0b:	83 c4 10             	add    $0x10,%esp
  800e0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e11:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e14:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e1b:	e9 98 00 00 00       	jmp    800eb8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e20:	83 ec 08             	sub    $0x8,%esp
  800e23:	ff 75 0c             	pushl  0xc(%ebp)
  800e26:	6a 58                	push   $0x58
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	ff d0                	call   *%eax
  800e2d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e30:	83 ec 08             	sub    $0x8,%esp
  800e33:	ff 75 0c             	pushl  0xc(%ebp)
  800e36:	6a 58                	push   $0x58
  800e38:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3b:	ff d0                	call   *%eax
  800e3d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e40:	83 ec 08             	sub    $0x8,%esp
  800e43:	ff 75 0c             	pushl  0xc(%ebp)
  800e46:	6a 58                	push   $0x58
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	ff d0                	call   *%eax
  800e4d:	83 c4 10             	add    $0x10,%esp
			break;
  800e50:	e9 bc 00 00 00       	jmp    800f11 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e55:	83 ec 08             	sub    $0x8,%esp
  800e58:	ff 75 0c             	pushl  0xc(%ebp)
  800e5b:	6a 30                	push   $0x30
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	ff d0                	call   *%eax
  800e62:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e65:	83 ec 08             	sub    $0x8,%esp
  800e68:	ff 75 0c             	pushl  0xc(%ebp)
  800e6b:	6a 78                	push   $0x78
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	ff d0                	call   *%eax
  800e72:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e75:	8b 45 14             	mov    0x14(%ebp),%eax
  800e78:	83 c0 04             	add    $0x4,%eax
  800e7b:	89 45 14             	mov    %eax,0x14(%ebp)
  800e7e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e81:	83 e8 04             	sub    $0x4,%eax
  800e84:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e89:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e90:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e97:	eb 1f                	jmp    800eb8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e99:	83 ec 08             	sub    $0x8,%esp
  800e9c:	ff 75 e8             	pushl  -0x18(%ebp)
  800e9f:	8d 45 14             	lea    0x14(%ebp),%eax
  800ea2:	50                   	push   %eax
  800ea3:	e8 e7 fb ff ff       	call   800a8f <getuint>
  800ea8:	83 c4 10             	add    $0x10,%esp
  800eab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eae:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eb1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eb8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ebc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ebf:	83 ec 04             	sub    $0x4,%esp
  800ec2:	52                   	push   %edx
  800ec3:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ec6:	50                   	push   %eax
  800ec7:	ff 75 f4             	pushl  -0xc(%ebp)
  800eca:	ff 75 f0             	pushl  -0x10(%ebp)
  800ecd:	ff 75 0c             	pushl  0xc(%ebp)
  800ed0:	ff 75 08             	pushl  0x8(%ebp)
  800ed3:	e8 00 fb ff ff       	call   8009d8 <printnum>
  800ed8:	83 c4 20             	add    $0x20,%esp
			break;
  800edb:	eb 34                	jmp    800f11 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800edd:	83 ec 08             	sub    $0x8,%esp
  800ee0:	ff 75 0c             	pushl  0xc(%ebp)
  800ee3:	53                   	push   %ebx
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	ff d0                	call   *%eax
  800ee9:	83 c4 10             	add    $0x10,%esp
			break;
  800eec:	eb 23                	jmp    800f11 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800eee:	83 ec 08             	sub    $0x8,%esp
  800ef1:	ff 75 0c             	pushl  0xc(%ebp)
  800ef4:	6a 25                	push   $0x25
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	ff d0                	call   *%eax
  800efb:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800efe:	ff 4d 10             	decl   0x10(%ebp)
  800f01:	eb 03                	jmp    800f06 <vprintfmt+0x3b1>
  800f03:	ff 4d 10             	decl   0x10(%ebp)
  800f06:	8b 45 10             	mov    0x10(%ebp),%eax
  800f09:	48                   	dec    %eax
  800f0a:	8a 00                	mov    (%eax),%al
  800f0c:	3c 25                	cmp    $0x25,%al
  800f0e:	75 f3                	jne    800f03 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f10:	90                   	nop
		}
	}
  800f11:	e9 47 fc ff ff       	jmp    800b5d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f16:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f17:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f1a:	5b                   	pop    %ebx
  800f1b:	5e                   	pop    %esi
  800f1c:	5d                   	pop    %ebp
  800f1d:	c3                   	ret    

00800f1e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f1e:	55                   	push   %ebp
  800f1f:	89 e5                	mov    %esp,%ebp
  800f21:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f24:	8d 45 10             	lea    0x10(%ebp),%eax
  800f27:	83 c0 04             	add    $0x4,%eax
  800f2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f30:	ff 75 f4             	pushl  -0xc(%ebp)
  800f33:	50                   	push   %eax
  800f34:	ff 75 0c             	pushl  0xc(%ebp)
  800f37:	ff 75 08             	pushl  0x8(%ebp)
  800f3a:	e8 16 fc ff ff       	call   800b55 <vprintfmt>
  800f3f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f42:	90                   	nop
  800f43:	c9                   	leave  
  800f44:	c3                   	ret    

00800f45 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f45:	55                   	push   %ebp
  800f46:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4b:	8b 40 08             	mov    0x8(%eax),%eax
  800f4e:	8d 50 01             	lea    0x1(%eax),%edx
  800f51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f54:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5a:	8b 10                	mov    (%eax),%edx
  800f5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5f:	8b 40 04             	mov    0x4(%eax),%eax
  800f62:	39 c2                	cmp    %eax,%edx
  800f64:	73 12                	jae    800f78 <sprintputch+0x33>
		*b->buf++ = ch;
  800f66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f69:	8b 00                	mov    (%eax),%eax
  800f6b:	8d 48 01             	lea    0x1(%eax),%ecx
  800f6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f71:	89 0a                	mov    %ecx,(%edx)
  800f73:	8b 55 08             	mov    0x8(%ebp),%edx
  800f76:	88 10                	mov    %dl,(%eax)
}
  800f78:	90                   	nop
  800f79:	5d                   	pop    %ebp
  800f7a:	c3                   	ret    

00800f7b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f7b:	55                   	push   %ebp
  800f7c:	89 e5                	mov    %esp,%ebp
  800f7e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	01 d0                	add    %edx,%eax
  800f92:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f9c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fa0:	74 06                	je     800fa8 <vsnprintf+0x2d>
  800fa2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fa6:	7f 07                	jg     800faf <vsnprintf+0x34>
		return -E_INVAL;
  800fa8:	b8 03 00 00 00       	mov    $0x3,%eax
  800fad:	eb 20                	jmp    800fcf <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800faf:	ff 75 14             	pushl  0x14(%ebp)
  800fb2:	ff 75 10             	pushl  0x10(%ebp)
  800fb5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fb8:	50                   	push   %eax
  800fb9:	68 45 0f 80 00       	push   $0x800f45
  800fbe:	e8 92 fb ff ff       	call   800b55 <vprintfmt>
  800fc3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fc9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fcf:	c9                   	leave  
  800fd0:	c3                   	ret    

00800fd1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fd1:	55                   	push   %ebp
  800fd2:	89 e5                	mov    %esp,%ebp
  800fd4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fd7:	8d 45 10             	lea    0x10(%ebp),%eax
  800fda:	83 c0 04             	add    $0x4,%eax
  800fdd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fe0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe3:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe6:	50                   	push   %eax
  800fe7:	ff 75 0c             	pushl  0xc(%ebp)
  800fea:	ff 75 08             	pushl  0x8(%ebp)
  800fed:	e8 89 ff ff ff       	call   800f7b <vsnprintf>
  800ff2:	83 c4 10             	add    $0x10,%esp
  800ff5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ff8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ffb:	c9                   	leave  
  800ffc:	c3                   	ret    

00800ffd <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ffd:	55                   	push   %ebp
  800ffe:	89 e5                	mov    %esp,%ebp
  801000:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801003:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80100a:	eb 06                	jmp    801012 <strlen+0x15>
		n++;
  80100c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80100f:	ff 45 08             	incl   0x8(%ebp)
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
  801015:	8a 00                	mov    (%eax),%al
  801017:	84 c0                	test   %al,%al
  801019:	75 f1                	jne    80100c <strlen+0xf>
		n++;
	return n;
  80101b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80101e:	c9                   	leave  
  80101f:	c3                   	ret    

00801020 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801020:	55                   	push   %ebp
  801021:	89 e5                	mov    %esp,%ebp
  801023:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801026:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80102d:	eb 09                	jmp    801038 <strnlen+0x18>
		n++;
  80102f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801032:	ff 45 08             	incl   0x8(%ebp)
  801035:	ff 4d 0c             	decl   0xc(%ebp)
  801038:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80103c:	74 09                	je     801047 <strnlen+0x27>
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8a 00                	mov    (%eax),%al
  801043:	84 c0                	test   %al,%al
  801045:	75 e8                	jne    80102f <strnlen+0xf>
		n++;
	return n;
  801047:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80104a:	c9                   	leave  
  80104b:	c3                   	ret    

0080104c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80104c:	55                   	push   %ebp
  80104d:	89 e5                	mov    %esp,%ebp
  80104f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801058:	90                   	nop
  801059:	8b 45 08             	mov    0x8(%ebp),%eax
  80105c:	8d 50 01             	lea    0x1(%eax),%edx
  80105f:	89 55 08             	mov    %edx,0x8(%ebp)
  801062:	8b 55 0c             	mov    0xc(%ebp),%edx
  801065:	8d 4a 01             	lea    0x1(%edx),%ecx
  801068:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80106b:	8a 12                	mov    (%edx),%dl
  80106d:	88 10                	mov    %dl,(%eax)
  80106f:	8a 00                	mov    (%eax),%al
  801071:	84 c0                	test   %al,%al
  801073:	75 e4                	jne    801059 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801075:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801078:	c9                   	leave  
  801079:	c3                   	ret    

0080107a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80107a:	55                   	push   %ebp
  80107b:	89 e5                	mov    %esp,%ebp
  80107d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801086:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80108d:	eb 1f                	jmp    8010ae <strncpy+0x34>
		*dst++ = *src;
  80108f:	8b 45 08             	mov    0x8(%ebp),%eax
  801092:	8d 50 01             	lea    0x1(%eax),%edx
  801095:	89 55 08             	mov    %edx,0x8(%ebp)
  801098:	8b 55 0c             	mov    0xc(%ebp),%edx
  80109b:	8a 12                	mov    (%edx),%dl
  80109d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80109f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a2:	8a 00                	mov    (%eax),%al
  8010a4:	84 c0                	test   %al,%al
  8010a6:	74 03                	je     8010ab <strncpy+0x31>
			src++;
  8010a8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010ab:	ff 45 fc             	incl   -0x4(%ebp)
  8010ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010b1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010b4:	72 d9                	jb     80108f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010b9:	c9                   	leave  
  8010ba:	c3                   	ret    

008010bb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010bb:	55                   	push   %ebp
  8010bc:	89 e5                	mov    %esp,%ebp
  8010be:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010cb:	74 30                	je     8010fd <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010cd:	eb 16                	jmp    8010e5 <strlcpy+0x2a>
			*dst++ = *src++;
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	8d 50 01             	lea    0x1(%eax),%edx
  8010d5:	89 55 08             	mov    %edx,0x8(%ebp)
  8010d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010db:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010de:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010e1:	8a 12                	mov    (%edx),%dl
  8010e3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010e5:	ff 4d 10             	decl   0x10(%ebp)
  8010e8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ec:	74 09                	je     8010f7 <strlcpy+0x3c>
  8010ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f1:	8a 00                	mov    (%eax),%al
  8010f3:	84 c0                	test   %al,%al
  8010f5:	75 d8                	jne    8010cf <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fa:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010fd:	8b 55 08             	mov    0x8(%ebp),%edx
  801100:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801103:	29 c2                	sub    %eax,%edx
  801105:	89 d0                	mov    %edx,%eax
}
  801107:	c9                   	leave  
  801108:	c3                   	ret    

00801109 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801109:	55                   	push   %ebp
  80110a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80110c:	eb 06                	jmp    801114 <strcmp+0xb>
		p++, q++;
  80110e:	ff 45 08             	incl   0x8(%ebp)
  801111:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	8a 00                	mov    (%eax),%al
  801119:	84 c0                	test   %al,%al
  80111b:	74 0e                	je     80112b <strcmp+0x22>
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	8a 10                	mov    (%eax),%dl
  801122:	8b 45 0c             	mov    0xc(%ebp),%eax
  801125:	8a 00                	mov    (%eax),%al
  801127:	38 c2                	cmp    %al,%dl
  801129:	74 e3                	je     80110e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
  80112e:	8a 00                	mov    (%eax),%al
  801130:	0f b6 d0             	movzbl %al,%edx
  801133:	8b 45 0c             	mov    0xc(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	0f b6 c0             	movzbl %al,%eax
  80113b:	29 c2                	sub    %eax,%edx
  80113d:	89 d0                	mov    %edx,%eax
}
  80113f:	5d                   	pop    %ebp
  801140:	c3                   	ret    

00801141 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801141:	55                   	push   %ebp
  801142:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801144:	eb 09                	jmp    80114f <strncmp+0xe>
		n--, p++, q++;
  801146:	ff 4d 10             	decl   0x10(%ebp)
  801149:	ff 45 08             	incl   0x8(%ebp)
  80114c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80114f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801153:	74 17                	je     80116c <strncmp+0x2b>
  801155:	8b 45 08             	mov    0x8(%ebp),%eax
  801158:	8a 00                	mov    (%eax),%al
  80115a:	84 c0                	test   %al,%al
  80115c:	74 0e                	je     80116c <strncmp+0x2b>
  80115e:	8b 45 08             	mov    0x8(%ebp),%eax
  801161:	8a 10                	mov    (%eax),%dl
  801163:	8b 45 0c             	mov    0xc(%ebp),%eax
  801166:	8a 00                	mov    (%eax),%al
  801168:	38 c2                	cmp    %al,%dl
  80116a:	74 da                	je     801146 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80116c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801170:	75 07                	jne    801179 <strncmp+0x38>
		return 0;
  801172:	b8 00 00 00 00       	mov    $0x0,%eax
  801177:	eb 14                	jmp    80118d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801179:	8b 45 08             	mov    0x8(%ebp),%eax
  80117c:	8a 00                	mov    (%eax),%al
  80117e:	0f b6 d0             	movzbl %al,%edx
  801181:	8b 45 0c             	mov    0xc(%ebp),%eax
  801184:	8a 00                	mov    (%eax),%al
  801186:	0f b6 c0             	movzbl %al,%eax
  801189:	29 c2                	sub    %eax,%edx
  80118b:	89 d0                	mov    %edx,%eax
}
  80118d:	5d                   	pop    %ebp
  80118e:	c3                   	ret    

0080118f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
  801192:	83 ec 04             	sub    $0x4,%esp
  801195:	8b 45 0c             	mov    0xc(%ebp),%eax
  801198:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80119b:	eb 12                	jmp    8011af <strchr+0x20>
		if (*s == c)
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	8a 00                	mov    (%eax),%al
  8011a2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011a5:	75 05                	jne    8011ac <strchr+0x1d>
			return (char *) s;
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	eb 11                	jmp    8011bd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011ac:	ff 45 08             	incl   0x8(%ebp)
  8011af:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b2:	8a 00                	mov    (%eax),%al
  8011b4:	84 c0                	test   %al,%al
  8011b6:	75 e5                	jne    80119d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011b8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011bd:	c9                   	leave  
  8011be:	c3                   	ret    

008011bf <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011bf:	55                   	push   %ebp
  8011c0:	89 e5                	mov    %esp,%ebp
  8011c2:	83 ec 04             	sub    $0x4,%esp
  8011c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011cb:	eb 0d                	jmp    8011da <strfind+0x1b>
		if (*s == c)
  8011cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d0:	8a 00                	mov    (%eax),%al
  8011d2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011d5:	74 0e                	je     8011e5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011d7:	ff 45 08             	incl   0x8(%ebp)
  8011da:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dd:	8a 00                	mov    (%eax),%al
  8011df:	84 c0                	test   %al,%al
  8011e1:	75 ea                	jne    8011cd <strfind+0xe>
  8011e3:	eb 01                	jmp    8011e6 <strfind+0x27>
		if (*s == c)
			break;
  8011e5:	90                   	nop
	return (char *) s;
  8011e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011e9:	c9                   	leave  
  8011ea:	c3                   	ret    

008011eb <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
  8011ee:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011fd:	eb 0e                	jmp    80120d <memset+0x22>
		*p++ = c;
  8011ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801202:	8d 50 01             	lea    0x1(%eax),%edx
  801205:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801208:	8b 55 0c             	mov    0xc(%ebp),%edx
  80120b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80120d:	ff 4d f8             	decl   -0x8(%ebp)
  801210:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801214:	79 e9                	jns    8011ff <memset+0x14>
		*p++ = c;

	return v;
  801216:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801219:	c9                   	leave  
  80121a:	c3                   	ret    

0080121b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80121b:	55                   	push   %ebp
  80121c:	89 e5                	mov    %esp,%ebp
  80121e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801221:	8b 45 0c             	mov    0xc(%ebp),%eax
  801224:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801227:	8b 45 08             	mov    0x8(%ebp),%eax
  80122a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80122d:	eb 16                	jmp    801245 <memcpy+0x2a>
		*d++ = *s++;
  80122f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801232:	8d 50 01             	lea    0x1(%eax),%edx
  801235:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801238:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80123b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80123e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801241:	8a 12                	mov    (%edx),%dl
  801243:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801245:	8b 45 10             	mov    0x10(%ebp),%eax
  801248:	8d 50 ff             	lea    -0x1(%eax),%edx
  80124b:	89 55 10             	mov    %edx,0x10(%ebp)
  80124e:	85 c0                	test   %eax,%eax
  801250:	75 dd                	jne    80122f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801252:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801255:	c9                   	leave  
  801256:	c3                   	ret    

00801257 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801257:	55                   	push   %ebp
  801258:	89 e5                	mov    %esp,%ebp
  80125a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80125d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801260:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801269:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80126c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80126f:	73 50                	jae    8012c1 <memmove+0x6a>
  801271:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801274:	8b 45 10             	mov    0x10(%ebp),%eax
  801277:	01 d0                	add    %edx,%eax
  801279:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80127c:	76 43                	jbe    8012c1 <memmove+0x6a>
		s += n;
  80127e:	8b 45 10             	mov    0x10(%ebp),%eax
  801281:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801284:	8b 45 10             	mov    0x10(%ebp),%eax
  801287:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80128a:	eb 10                	jmp    80129c <memmove+0x45>
			*--d = *--s;
  80128c:	ff 4d f8             	decl   -0x8(%ebp)
  80128f:	ff 4d fc             	decl   -0x4(%ebp)
  801292:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801295:	8a 10                	mov    (%eax),%dl
  801297:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80129a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80129c:	8b 45 10             	mov    0x10(%ebp),%eax
  80129f:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012a2:	89 55 10             	mov    %edx,0x10(%ebp)
  8012a5:	85 c0                	test   %eax,%eax
  8012a7:	75 e3                	jne    80128c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012a9:	eb 23                	jmp    8012ce <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ae:	8d 50 01             	lea    0x1(%eax),%edx
  8012b1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012b4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012ba:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012bd:	8a 12                	mov    (%edx),%dl
  8012bf:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012c7:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ca:	85 c0                	test   %eax,%eax
  8012cc:	75 dd                	jne    8012ab <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012d1:	c9                   	leave  
  8012d2:	c3                   	ret    

008012d3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012d3:	55                   	push   %ebp
  8012d4:	89 e5                	mov    %esp,%ebp
  8012d6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012e5:	eb 2a                	jmp    801311 <memcmp+0x3e>
		if (*s1 != *s2)
  8012e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ea:	8a 10                	mov    (%eax),%dl
  8012ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ef:	8a 00                	mov    (%eax),%al
  8012f1:	38 c2                	cmp    %al,%dl
  8012f3:	74 16                	je     80130b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f8:	8a 00                	mov    (%eax),%al
  8012fa:	0f b6 d0             	movzbl %al,%edx
  8012fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801300:	8a 00                	mov    (%eax),%al
  801302:	0f b6 c0             	movzbl %al,%eax
  801305:	29 c2                	sub    %eax,%edx
  801307:	89 d0                	mov    %edx,%eax
  801309:	eb 18                	jmp    801323 <memcmp+0x50>
		s1++, s2++;
  80130b:	ff 45 fc             	incl   -0x4(%ebp)
  80130e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801311:	8b 45 10             	mov    0x10(%ebp),%eax
  801314:	8d 50 ff             	lea    -0x1(%eax),%edx
  801317:	89 55 10             	mov    %edx,0x10(%ebp)
  80131a:	85 c0                	test   %eax,%eax
  80131c:	75 c9                	jne    8012e7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80131e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801323:	c9                   	leave  
  801324:	c3                   	ret    

00801325 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801325:	55                   	push   %ebp
  801326:	89 e5                	mov    %esp,%ebp
  801328:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80132b:	8b 55 08             	mov    0x8(%ebp),%edx
  80132e:	8b 45 10             	mov    0x10(%ebp),%eax
  801331:	01 d0                	add    %edx,%eax
  801333:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801336:	eb 15                	jmp    80134d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801338:	8b 45 08             	mov    0x8(%ebp),%eax
  80133b:	8a 00                	mov    (%eax),%al
  80133d:	0f b6 d0             	movzbl %al,%edx
  801340:	8b 45 0c             	mov    0xc(%ebp),%eax
  801343:	0f b6 c0             	movzbl %al,%eax
  801346:	39 c2                	cmp    %eax,%edx
  801348:	74 0d                	je     801357 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80134a:	ff 45 08             	incl   0x8(%ebp)
  80134d:	8b 45 08             	mov    0x8(%ebp),%eax
  801350:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801353:	72 e3                	jb     801338 <memfind+0x13>
  801355:	eb 01                	jmp    801358 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801357:	90                   	nop
	return (void *) s;
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80135b:	c9                   	leave  
  80135c:	c3                   	ret    

0080135d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80135d:	55                   	push   %ebp
  80135e:	89 e5                	mov    %esp,%ebp
  801360:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801363:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80136a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801371:	eb 03                	jmp    801376 <strtol+0x19>
		s++;
  801373:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	8a 00                	mov    (%eax),%al
  80137b:	3c 20                	cmp    $0x20,%al
  80137d:	74 f4                	je     801373 <strtol+0x16>
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8a 00                	mov    (%eax),%al
  801384:	3c 09                	cmp    $0x9,%al
  801386:	74 eb                	je     801373 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	8a 00                	mov    (%eax),%al
  80138d:	3c 2b                	cmp    $0x2b,%al
  80138f:	75 05                	jne    801396 <strtol+0x39>
		s++;
  801391:	ff 45 08             	incl   0x8(%ebp)
  801394:	eb 13                	jmp    8013a9 <strtol+0x4c>
	else if (*s == '-')
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	8a 00                	mov    (%eax),%al
  80139b:	3c 2d                	cmp    $0x2d,%al
  80139d:	75 0a                	jne    8013a9 <strtol+0x4c>
		s++, neg = 1;
  80139f:	ff 45 08             	incl   0x8(%ebp)
  8013a2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013a9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ad:	74 06                	je     8013b5 <strtol+0x58>
  8013af:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013b3:	75 20                	jne    8013d5 <strtol+0x78>
  8013b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b8:	8a 00                	mov    (%eax),%al
  8013ba:	3c 30                	cmp    $0x30,%al
  8013bc:	75 17                	jne    8013d5 <strtol+0x78>
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	40                   	inc    %eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	3c 78                	cmp    $0x78,%al
  8013c6:	75 0d                	jne    8013d5 <strtol+0x78>
		s += 2, base = 16;
  8013c8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013cc:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013d3:	eb 28                	jmp    8013fd <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d9:	75 15                	jne    8013f0 <strtol+0x93>
  8013db:	8b 45 08             	mov    0x8(%ebp),%eax
  8013de:	8a 00                	mov    (%eax),%al
  8013e0:	3c 30                	cmp    $0x30,%al
  8013e2:	75 0c                	jne    8013f0 <strtol+0x93>
		s++, base = 8;
  8013e4:	ff 45 08             	incl   0x8(%ebp)
  8013e7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013ee:	eb 0d                	jmp    8013fd <strtol+0xa0>
	else if (base == 0)
  8013f0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f4:	75 07                	jne    8013fd <strtol+0xa0>
		base = 10;
  8013f6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	8a 00                	mov    (%eax),%al
  801402:	3c 2f                	cmp    $0x2f,%al
  801404:	7e 19                	jle    80141f <strtol+0xc2>
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	8a 00                	mov    (%eax),%al
  80140b:	3c 39                	cmp    $0x39,%al
  80140d:	7f 10                	jg     80141f <strtol+0xc2>
			dig = *s - '0';
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	8a 00                	mov    (%eax),%al
  801414:	0f be c0             	movsbl %al,%eax
  801417:	83 e8 30             	sub    $0x30,%eax
  80141a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80141d:	eb 42                	jmp    801461 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	3c 60                	cmp    $0x60,%al
  801426:	7e 19                	jle    801441 <strtol+0xe4>
  801428:	8b 45 08             	mov    0x8(%ebp),%eax
  80142b:	8a 00                	mov    (%eax),%al
  80142d:	3c 7a                	cmp    $0x7a,%al
  80142f:	7f 10                	jg     801441 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801431:	8b 45 08             	mov    0x8(%ebp),%eax
  801434:	8a 00                	mov    (%eax),%al
  801436:	0f be c0             	movsbl %al,%eax
  801439:	83 e8 57             	sub    $0x57,%eax
  80143c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80143f:	eb 20                	jmp    801461 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	8a 00                	mov    (%eax),%al
  801446:	3c 40                	cmp    $0x40,%al
  801448:	7e 39                	jle    801483 <strtol+0x126>
  80144a:	8b 45 08             	mov    0x8(%ebp),%eax
  80144d:	8a 00                	mov    (%eax),%al
  80144f:	3c 5a                	cmp    $0x5a,%al
  801451:	7f 30                	jg     801483 <strtol+0x126>
			dig = *s - 'A' + 10;
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	8a 00                	mov    (%eax),%al
  801458:	0f be c0             	movsbl %al,%eax
  80145b:	83 e8 37             	sub    $0x37,%eax
  80145e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801464:	3b 45 10             	cmp    0x10(%ebp),%eax
  801467:	7d 19                	jge    801482 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801469:	ff 45 08             	incl   0x8(%ebp)
  80146c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80146f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801473:	89 c2                	mov    %eax,%edx
  801475:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801478:	01 d0                	add    %edx,%eax
  80147a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80147d:	e9 7b ff ff ff       	jmp    8013fd <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801482:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801483:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801487:	74 08                	je     801491 <strtol+0x134>
		*endptr = (char *) s;
  801489:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148c:	8b 55 08             	mov    0x8(%ebp),%edx
  80148f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801491:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801495:	74 07                	je     80149e <strtol+0x141>
  801497:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80149a:	f7 d8                	neg    %eax
  80149c:	eb 03                	jmp    8014a1 <strtol+0x144>
  80149e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014a1:	c9                   	leave  
  8014a2:	c3                   	ret    

008014a3 <ltostr>:

void
ltostr(long value, char *str)
{
  8014a3:	55                   	push   %ebp
  8014a4:	89 e5                	mov    %esp,%ebp
  8014a6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014b0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014bb:	79 13                	jns    8014d0 <ltostr+0x2d>
	{
		neg = 1;
  8014bd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014ca:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014cd:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014d8:	99                   	cltd   
  8014d9:	f7 f9                	idiv   %ecx
  8014db:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e1:	8d 50 01             	lea    0x1(%eax),%edx
  8014e4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014e7:	89 c2                	mov    %eax,%edx
  8014e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ec:	01 d0                	add    %edx,%eax
  8014ee:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014f1:	83 c2 30             	add    $0x30,%edx
  8014f4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014f9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014fe:	f7 e9                	imul   %ecx
  801500:	c1 fa 02             	sar    $0x2,%edx
  801503:	89 c8                	mov    %ecx,%eax
  801505:	c1 f8 1f             	sar    $0x1f,%eax
  801508:	29 c2                	sub    %eax,%edx
  80150a:	89 d0                	mov    %edx,%eax
  80150c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80150f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801512:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801517:	f7 e9                	imul   %ecx
  801519:	c1 fa 02             	sar    $0x2,%edx
  80151c:	89 c8                	mov    %ecx,%eax
  80151e:	c1 f8 1f             	sar    $0x1f,%eax
  801521:	29 c2                	sub    %eax,%edx
  801523:	89 d0                	mov    %edx,%eax
  801525:	c1 e0 02             	shl    $0x2,%eax
  801528:	01 d0                	add    %edx,%eax
  80152a:	01 c0                	add    %eax,%eax
  80152c:	29 c1                	sub    %eax,%ecx
  80152e:	89 ca                	mov    %ecx,%edx
  801530:	85 d2                	test   %edx,%edx
  801532:	75 9c                	jne    8014d0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801534:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80153b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153e:	48                   	dec    %eax
  80153f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801542:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801546:	74 3d                	je     801585 <ltostr+0xe2>
		start = 1 ;
  801548:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80154f:	eb 34                	jmp    801585 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801551:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801554:	8b 45 0c             	mov    0xc(%ebp),%eax
  801557:	01 d0                	add    %edx,%eax
  801559:	8a 00                	mov    (%eax),%al
  80155b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80155e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801561:	8b 45 0c             	mov    0xc(%ebp),%eax
  801564:	01 c2                	add    %eax,%edx
  801566:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801569:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156c:	01 c8                	add    %ecx,%eax
  80156e:	8a 00                	mov    (%eax),%al
  801570:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801572:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801575:	8b 45 0c             	mov    0xc(%ebp),%eax
  801578:	01 c2                	add    %eax,%edx
  80157a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80157d:	88 02                	mov    %al,(%edx)
		start++ ;
  80157f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801582:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801585:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801588:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80158b:	7c c4                	jl     801551 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80158d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801590:	8b 45 0c             	mov    0xc(%ebp),%eax
  801593:	01 d0                	add    %edx,%eax
  801595:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801598:	90                   	nop
  801599:	c9                   	leave  
  80159a:	c3                   	ret    

0080159b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80159b:	55                   	push   %ebp
  80159c:	89 e5                	mov    %esp,%ebp
  80159e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015a1:	ff 75 08             	pushl  0x8(%ebp)
  8015a4:	e8 54 fa ff ff       	call   800ffd <strlen>
  8015a9:	83 c4 04             	add    $0x4,%esp
  8015ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015af:	ff 75 0c             	pushl  0xc(%ebp)
  8015b2:	e8 46 fa ff ff       	call   800ffd <strlen>
  8015b7:	83 c4 04             	add    $0x4,%esp
  8015ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015cb:	eb 17                	jmp    8015e4 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d3:	01 c2                	add    %eax,%edx
  8015d5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015db:	01 c8                	add    %ecx,%eax
  8015dd:	8a 00                	mov    (%eax),%al
  8015df:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015e1:	ff 45 fc             	incl   -0x4(%ebp)
  8015e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015ea:	7c e1                	jl     8015cd <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015f3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015fa:	eb 1f                	jmp    80161b <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ff:	8d 50 01             	lea    0x1(%eax),%edx
  801602:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801605:	89 c2                	mov    %eax,%edx
  801607:	8b 45 10             	mov    0x10(%ebp),%eax
  80160a:	01 c2                	add    %eax,%edx
  80160c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80160f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801612:	01 c8                	add    %ecx,%eax
  801614:	8a 00                	mov    (%eax),%al
  801616:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801618:	ff 45 f8             	incl   -0x8(%ebp)
  80161b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80161e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801621:	7c d9                	jl     8015fc <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801623:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801626:	8b 45 10             	mov    0x10(%ebp),%eax
  801629:	01 d0                	add    %edx,%eax
  80162b:	c6 00 00             	movb   $0x0,(%eax)
}
  80162e:	90                   	nop
  80162f:	c9                   	leave  
  801630:	c3                   	ret    

00801631 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801631:	55                   	push   %ebp
  801632:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801634:	8b 45 14             	mov    0x14(%ebp),%eax
  801637:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80163d:	8b 45 14             	mov    0x14(%ebp),%eax
  801640:	8b 00                	mov    (%eax),%eax
  801642:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801649:	8b 45 10             	mov    0x10(%ebp),%eax
  80164c:	01 d0                	add    %edx,%eax
  80164e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801654:	eb 0c                	jmp    801662 <strsplit+0x31>
			*string++ = 0;
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	8d 50 01             	lea    0x1(%eax),%edx
  80165c:	89 55 08             	mov    %edx,0x8(%ebp)
  80165f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	8a 00                	mov    (%eax),%al
  801667:	84 c0                	test   %al,%al
  801669:	74 18                	je     801683 <strsplit+0x52>
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	8a 00                	mov    (%eax),%al
  801670:	0f be c0             	movsbl %al,%eax
  801673:	50                   	push   %eax
  801674:	ff 75 0c             	pushl  0xc(%ebp)
  801677:	e8 13 fb ff ff       	call   80118f <strchr>
  80167c:	83 c4 08             	add    $0x8,%esp
  80167f:	85 c0                	test   %eax,%eax
  801681:	75 d3                	jne    801656 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801683:	8b 45 08             	mov    0x8(%ebp),%eax
  801686:	8a 00                	mov    (%eax),%al
  801688:	84 c0                	test   %al,%al
  80168a:	74 5a                	je     8016e6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80168c:	8b 45 14             	mov    0x14(%ebp),%eax
  80168f:	8b 00                	mov    (%eax),%eax
  801691:	83 f8 0f             	cmp    $0xf,%eax
  801694:	75 07                	jne    80169d <strsplit+0x6c>
		{
			return 0;
  801696:	b8 00 00 00 00       	mov    $0x0,%eax
  80169b:	eb 66                	jmp    801703 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80169d:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a0:	8b 00                	mov    (%eax),%eax
  8016a2:	8d 48 01             	lea    0x1(%eax),%ecx
  8016a5:	8b 55 14             	mov    0x14(%ebp),%edx
  8016a8:	89 0a                	mov    %ecx,(%edx)
  8016aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b4:	01 c2                	add    %eax,%edx
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016bb:	eb 03                	jmp    8016c0 <strsplit+0x8f>
			string++;
  8016bd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c3:	8a 00                	mov    (%eax),%al
  8016c5:	84 c0                	test   %al,%al
  8016c7:	74 8b                	je     801654 <strsplit+0x23>
  8016c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cc:	8a 00                	mov    (%eax),%al
  8016ce:	0f be c0             	movsbl %al,%eax
  8016d1:	50                   	push   %eax
  8016d2:	ff 75 0c             	pushl  0xc(%ebp)
  8016d5:	e8 b5 fa ff ff       	call   80118f <strchr>
  8016da:	83 c4 08             	add    $0x8,%esp
  8016dd:	85 c0                	test   %eax,%eax
  8016df:	74 dc                	je     8016bd <strsplit+0x8c>
			string++;
	}
  8016e1:	e9 6e ff ff ff       	jmp    801654 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016e6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ea:	8b 00                	mov    (%eax),%eax
  8016ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f6:	01 d0                	add    %edx,%eax
  8016f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016fe:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801703:	c9                   	leave  
  801704:	c3                   	ret    

00801705 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801705:	55                   	push   %ebp
  801706:	89 e5                	mov    %esp,%ebp
  801708:	57                   	push   %edi
  801709:	56                   	push   %esi
  80170a:	53                   	push   %ebx
  80170b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80170e:	8b 45 08             	mov    0x8(%ebp),%eax
  801711:	8b 55 0c             	mov    0xc(%ebp),%edx
  801714:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801717:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80171a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80171d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801720:	cd 30                	int    $0x30
  801722:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801725:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801728:	83 c4 10             	add    $0x10,%esp
  80172b:	5b                   	pop    %ebx
  80172c:	5e                   	pop    %esi
  80172d:	5f                   	pop    %edi
  80172e:	5d                   	pop    %ebp
  80172f:	c3                   	ret    

00801730 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
  801733:	83 ec 04             	sub    $0x4,%esp
  801736:	8b 45 10             	mov    0x10(%ebp),%eax
  801739:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80173c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801740:	8b 45 08             	mov    0x8(%ebp),%eax
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	52                   	push   %edx
  801748:	ff 75 0c             	pushl  0xc(%ebp)
  80174b:	50                   	push   %eax
  80174c:	6a 00                	push   $0x0
  80174e:	e8 b2 ff ff ff       	call   801705 <syscall>
  801753:	83 c4 18             	add    $0x18,%esp
}
  801756:	90                   	nop
  801757:	c9                   	leave  
  801758:	c3                   	ret    

00801759 <sys_cgetc>:

int
sys_cgetc(void)
{
  801759:	55                   	push   %ebp
  80175a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 01                	push   $0x1
  801768:	e8 98 ff ff ff       	call   801705 <syscall>
  80176d:	83 c4 18             	add    $0x18,%esp
}
  801770:	c9                   	leave  
  801771:	c3                   	ret    

00801772 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801772:	55                   	push   %ebp
  801773:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801775:	8b 45 08             	mov    0x8(%ebp),%eax
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	50                   	push   %eax
  801781:	6a 05                	push   $0x5
  801783:	e8 7d ff ff ff       	call   801705 <syscall>
  801788:	83 c4 18             	add    $0x18,%esp
}
  80178b:	c9                   	leave  
  80178c:	c3                   	ret    

0080178d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80178d:	55                   	push   %ebp
  80178e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 02                	push   $0x2
  80179c:	e8 64 ff ff ff       	call   801705 <syscall>
  8017a1:	83 c4 18             	add    $0x18,%esp
}
  8017a4:	c9                   	leave  
  8017a5:	c3                   	ret    

008017a6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017a6:	55                   	push   %ebp
  8017a7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 03                	push   $0x3
  8017b5:	e8 4b ff ff ff       	call   801705 <syscall>
  8017ba:	83 c4 18             	add    $0x18,%esp
}
  8017bd:	c9                   	leave  
  8017be:	c3                   	ret    

008017bf <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017bf:	55                   	push   %ebp
  8017c0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 04                	push   $0x4
  8017ce:	e8 32 ff ff ff       	call   801705 <syscall>
  8017d3:	83 c4 18             	add    $0x18,%esp
}
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <sys_env_exit>:


void sys_env_exit(void)
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 06                	push   $0x6
  8017e7:	e8 19 ff ff ff       	call   801705 <syscall>
  8017ec:	83 c4 18             	add    $0x18,%esp
}
  8017ef:	90                   	nop
  8017f0:	c9                   	leave  
  8017f1:	c3                   	ret    

008017f2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017f2:	55                   	push   %ebp
  8017f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	52                   	push   %edx
  801802:	50                   	push   %eax
  801803:	6a 07                	push   $0x7
  801805:	e8 fb fe ff ff       	call   801705 <syscall>
  80180a:	83 c4 18             	add    $0x18,%esp
}
  80180d:	c9                   	leave  
  80180e:	c3                   	ret    

0080180f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80180f:	55                   	push   %ebp
  801810:	89 e5                	mov    %esp,%ebp
  801812:	56                   	push   %esi
  801813:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801814:	8b 75 18             	mov    0x18(%ebp),%esi
  801817:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80181a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80181d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801820:	8b 45 08             	mov    0x8(%ebp),%eax
  801823:	56                   	push   %esi
  801824:	53                   	push   %ebx
  801825:	51                   	push   %ecx
  801826:	52                   	push   %edx
  801827:	50                   	push   %eax
  801828:	6a 08                	push   $0x8
  80182a:	e8 d6 fe ff ff       	call   801705 <syscall>
  80182f:	83 c4 18             	add    $0x18,%esp
}
  801832:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801835:	5b                   	pop    %ebx
  801836:	5e                   	pop    %esi
  801837:	5d                   	pop    %ebp
  801838:	c3                   	ret    

00801839 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801839:	55                   	push   %ebp
  80183a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80183c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183f:	8b 45 08             	mov    0x8(%ebp),%eax
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	52                   	push   %edx
  801849:	50                   	push   %eax
  80184a:	6a 09                	push   $0x9
  80184c:	e8 b4 fe ff ff       	call   801705 <syscall>
  801851:	83 c4 18             	add    $0x18,%esp
}
  801854:	c9                   	leave  
  801855:	c3                   	ret    

00801856 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801856:	55                   	push   %ebp
  801857:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	ff 75 0c             	pushl  0xc(%ebp)
  801862:	ff 75 08             	pushl  0x8(%ebp)
  801865:	6a 0a                	push   $0xa
  801867:	e8 99 fe ff ff       	call   801705 <syscall>
  80186c:	83 c4 18             	add    $0x18,%esp
}
  80186f:	c9                   	leave  
  801870:	c3                   	ret    

00801871 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801871:	55                   	push   %ebp
  801872:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	6a 00                	push   $0x0
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 0b                	push   $0xb
  801880:	e8 80 fe ff ff       	call   801705 <syscall>
  801885:	83 c4 18             	add    $0x18,%esp
}
  801888:	c9                   	leave  
  801889:	c3                   	ret    

0080188a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80188a:	55                   	push   %ebp
  80188b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 0c                	push   $0xc
  801899:	e8 67 fe ff ff       	call   801705 <syscall>
  80189e:	83 c4 18             	add    $0x18,%esp
}
  8018a1:	c9                   	leave  
  8018a2:	c3                   	ret    

008018a3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018a3:	55                   	push   %ebp
  8018a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 0d                	push   $0xd
  8018b2:	e8 4e fe ff ff       	call   801705 <syscall>
  8018b7:	83 c4 18             	add    $0x18,%esp
}
  8018ba:	c9                   	leave  
  8018bb:	c3                   	ret    

008018bc <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018bc:	55                   	push   %ebp
  8018bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	ff 75 0c             	pushl  0xc(%ebp)
  8018c8:	ff 75 08             	pushl  0x8(%ebp)
  8018cb:	6a 11                	push   $0x11
  8018cd:	e8 33 fe ff ff       	call   801705 <syscall>
  8018d2:	83 c4 18             	add    $0x18,%esp
	return;
  8018d5:	90                   	nop
}
  8018d6:	c9                   	leave  
  8018d7:	c3                   	ret    

008018d8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018d8:	55                   	push   %ebp
  8018d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	ff 75 0c             	pushl  0xc(%ebp)
  8018e4:	ff 75 08             	pushl  0x8(%ebp)
  8018e7:	6a 12                	push   $0x12
  8018e9:	e8 17 fe ff ff       	call   801705 <syscall>
  8018ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8018f1:	90                   	nop
}
  8018f2:	c9                   	leave  
  8018f3:	c3                   	ret    

008018f4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018f4:	55                   	push   %ebp
  8018f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 0e                	push   $0xe
  801903:	e8 fd fd ff ff       	call   801705 <syscall>
  801908:	83 c4 18             	add    $0x18,%esp
}
  80190b:	c9                   	leave  
  80190c:	c3                   	ret    

0080190d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80190d:	55                   	push   %ebp
  80190e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	ff 75 08             	pushl  0x8(%ebp)
  80191b:	6a 0f                	push   $0xf
  80191d:	e8 e3 fd ff ff       	call   801705 <syscall>
  801922:	83 c4 18             	add    $0x18,%esp
}
  801925:	c9                   	leave  
  801926:	c3                   	ret    

00801927 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 10                	push   $0x10
  801936:	e8 ca fd ff ff       	call   801705 <syscall>
  80193b:	83 c4 18             	add    $0x18,%esp
}
  80193e:	90                   	nop
  80193f:	c9                   	leave  
  801940:	c3                   	ret    

00801941 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801941:	55                   	push   %ebp
  801942:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801944:	6a 00                	push   $0x0
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 14                	push   $0x14
  801950:	e8 b0 fd ff ff       	call   801705 <syscall>
  801955:	83 c4 18             	add    $0x18,%esp
}
  801958:	90                   	nop
  801959:	c9                   	leave  
  80195a:	c3                   	ret    

0080195b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80195b:	55                   	push   %ebp
  80195c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 15                	push   $0x15
  80196a:	e8 96 fd ff ff       	call   801705 <syscall>
  80196f:	83 c4 18             	add    $0x18,%esp
}
  801972:	90                   	nop
  801973:	c9                   	leave  
  801974:	c3                   	ret    

00801975 <sys_cputc>:


void
sys_cputc(const char c)
{
  801975:	55                   	push   %ebp
  801976:	89 e5                	mov    %esp,%ebp
  801978:	83 ec 04             	sub    $0x4,%esp
  80197b:	8b 45 08             	mov    0x8(%ebp),%eax
  80197e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801981:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	50                   	push   %eax
  80198e:	6a 16                	push   $0x16
  801990:	e8 70 fd ff ff       	call   801705 <syscall>
  801995:	83 c4 18             	add    $0x18,%esp
}
  801998:	90                   	nop
  801999:	c9                   	leave  
  80199a:	c3                   	ret    

0080199b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80199b:	55                   	push   %ebp
  80199c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 17                	push   $0x17
  8019aa:	e8 56 fd ff ff       	call   801705 <syscall>
  8019af:	83 c4 18             	add    $0x18,%esp
}
  8019b2:	90                   	nop
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	ff 75 0c             	pushl  0xc(%ebp)
  8019c4:	50                   	push   %eax
  8019c5:	6a 18                	push   $0x18
  8019c7:	e8 39 fd ff ff       	call   801705 <syscall>
  8019cc:	83 c4 18             	add    $0x18,%esp
}
  8019cf:	c9                   	leave  
  8019d0:	c3                   	ret    

008019d1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019d1:	55                   	push   %ebp
  8019d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	52                   	push   %edx
  8019e1:	50                   	push   %eax
  8019e2:	6a 1b                	push   $0x1b
  8019e4:	e8 1c fd ff ff       	call   801705 <syscall>
  8019e9:	83 c4 18             	add    $0x18,%esp
}
  8019ec:	c9                   	leave  
  8019ed:	c3                   	ret    

008019ee <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019ee:	55                   	push   %ebp
  8019ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	52                   	push   %edx
  8019fe:	50                   	push   %eax
  8019ff:	6a 19                	push   $0x19
  801a01:	e8 ff fc ff ff       	call   801705 <syscall>
  801a06:	83 c4 18             	add    $0x18,%esp
}
  801a09:	90                   	nop
  801a0a:	c9                   	leave  
  801a0b:	c3                   	ret    

00801a0c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a0c:	55                   	push   %ebp
  801a0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a12:	8b 45 08             	mov    0x8(%ebp),%eax
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 00                	push   $0x0
  801a1b:	52                   	push   %edx
  801a1c:	50                   	push   %eax
  801a1d:	6a 1a                	push   $0x1a
  801a1f:	e8 e1 fc ff ff       	call   801705 <syscall>
  801a24:	83 c4 18             	add    $0x18,%esp
}
  801a27:	90                   	nop
  801a28:	c9                   	leave  
  801a29:	c3                   	ret    

00801a2a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
  801a2d:	83 ec 04             	sub    $0x4,%esp
  801a30:	8b 45 10             	mov    0x10(%ebp),%eax
  801a33:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a36:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a39:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a40:	6a 00                	push   $0x0
  801a42:	51                   	push   %ecx
  801a43:	52                   	push   %edx
  801a44:	ff 75 0c             	pushl  0xc(%ebp)
  801a47:	50                   	push   %eax
  801a48:	6a 1c                	push   $0x1c
  801a4a:	e8 b6 fc ff ff       	call   801705 <syscall>
  801a4f:	83 c4 18             	add    $0x18,%esp
}
  801a52:	c9                   	leave  
  801a53:	c3                   	ret    

00801a54 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a54:	55                   	push   %ebp
  801a55:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a57:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	52                   	push   %edx
  801a64:	50                   	push   %eax
  801a65:	6a 1d                	push   $0x1d
  801a67:	e8 99 fc ff ff       	call   801705 <syscall>
  801a6c:	83 c4 18             	add    $0x18,%esp
}
  801a6f:	c9                   	leave  
  801a70:	c3                   	ret    

00801a71 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a71:	55                   	push   %ebp
  801a72:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a74:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a77:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	51                   	push   %ecx
  801a82:	52                   	push   %edx
  801a83:	50                   	push   %eax
  801a84:	6a 1e                	push   $0x1e
  801a86:	e8 7a fc ff ff       	call   801705 <syscall>
  801a8b:	83 c4 18             	add    $0x18,%esp
}
  801a8e:	c9                   	leave  
  801a8f:	c3                   	ret    

00801a90 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a90:	55                   	push   %ebp
  801a91:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a93:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a96:	8b 45 08             	mov    0x8(%ebp),%eax
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	52                   	push   %edx
  801aa0:	50                   	push   %eax
  801aa1:	6a 1f                	push   $0x1f
  801aa3:	e8 5d fc ff ff       	call   801705 <syscall>
  801aa8:	83 c4 18             	add    $0x18,%esp
}
  801aab:	c9                   	leave  
  801aac:	c3                   	ret    

00801aad <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801aad:	55                   	push   %ebp
  801aae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 20                	push   $0x20
  801abc:	e8 44 fc ff ff       	call   801705 <syscall>
  801ac1:	83 c4 18             	add    $0x18,%esp
}
  801ac4:	c9                   	leave  
  801ac5:	c3                   	ret    

00801ac6 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ac6:	55                   	push   %ebp
  801ac7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  801acc:	6a 00                	push   $0x0
  801ace:	ff 75 14             	pushl  0x14(%ebp)
  801ad1:	ff 75 10             	pushl  0x10(%ebp)
  801ad4:	ff 75 0c             	pushl  0xc(%ebp)
  801ad7:	50                   	push   %eax
  801ad8:	6a 21                	push   $0x21
  801ada:	e8 26 fc ff ff       	call   801705 <syscall>
  801adf:	83 c4 18             	add    $0x18,%esp
}
  801ae2:	c9                   	leave  
  801ae3:	c3                   	ret    

00801ae4 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801ae4:	55                   	push   %ebp
  801ae5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	50                   	push   %eax
  801af3:	6a 22                	push   $0x22
  801af5:	e8 0b fc ff ff       	call   801705 <syscall>
  801afa:	83 c4 18             	add    $0x18,%esp
}
  801afd:	90                   	nop
  801afe:	c9                   	leave  
  801aff:	c3                   	ret    

00801b00 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b00:	55                   	push   %ebp
  801b01:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b03:	8b 45 08             	mov    0x8(%ebp),%eax
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	50                   	push   %eax
  801b0f:	6a 23                	push   $0x23
  801b11:	e8 ef fb ff ff       	call   801705 <syscall>
  801b16:	83 c4 18             	add    $0x18,%esp
}
  801b19:	90                   	nop
  801b1a:	c9                   	leave  
  801b1b:	c3                   	ret    

00801b1c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b1c:	55                   	push   %ebp
  801b1d:	89 e5                	mov    %esp,%ebp
  801b1f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b22:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b25:	8d 50 04             	lea    0x4(%eax),%edx
  801b28:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	52                   	push   %edx
  801b32:	50                   	push   %eax
  801b33:	6a 24                	push   $0x24
  801b35:	e8 cb fb ff ff       	call   801705 <syscall>
  801b3a:	83 c4 18             	add    $0x18,%esp
	return result;
  801b3d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b40:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b43:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b46:	89 01                	mov    %eax,(%ecx)
  801b48:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4e:	c9                   	leave  
  801b4f:	c2 04 00             	ret    $0x4

00801b52 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b52:	55                   	push   %ebp
  801b53:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	ff 75 10             	pushl  0x10(%ebp)
  801b5c:	ff 75 0c             	pushl  0xc(%ebp)
  801b5f:	ff 75 08             	pushl  0x8(%ebp)
  801b62:	6a 13                	push   $0x13
  801b64:	e8 9c fb ff ff       	call   801705 <syscall>
  801b69:	83 c4 18             	add    $0x18,%esp
	return ;
  801b6c:	90                   	nop
}
  801b6d:	c9                   	leave  
  801b6e:	c3                   	ret    

00801b6f <sys_rcr2>:
uint32 sys_rcr2()
{
  801b6f:	55                   	push   %ebp
  801b70:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 25                	push   $0x25
  801b7e:	e8 82 fb ff ff       	call   801705 <syscall>
  801b83:	83 c4 18             	add    $0x18,%esp
}
  801b86:	c9                   	leave  
  801b87:	c3                   	ret    

00801b88 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b88:	55                   	push   %ebp
  801b89:	89 e5                	mov    %esp,%ebp
  801b8b:	83 ec 04             	sub    $0x4,%esp
  801b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b91:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b94:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	50                   	push   %eax
  801ba1:	6a 26                	push   $0x26
  801ba3:	e8 5d fb ff ff       	call   801705 <syscall>
  801ba8:	83 c4 18             	add    $0x18,%esp
	return ;
  801bab:	90                   	nop
}
  801bac:	c9                   	leave  
  801bad:	c3                   	ret    

00801bae <rsttst>:
void rsttst()
{
  801bae:	55                   	push   %ebp
  801baf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 28                	push   $0x28
  801bbd:	e8 43 fb ff ff       	call   801705 <syscall>
  801bc2:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc5:	90                   	nop
}
  801bc6:	c9                   	leave  
  801bc7:	c3                   	ret    

00801bc8 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bc8:	55                   	push   %ebp
  801bc9:	89 e5                	mov    %esp,%ebp
  801bcb:	83 ec 04             	sub    $0x4,%esp
  801bce:	8b 45 14             	mov    0x14(%ebp),%eax
  801bd1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bd4:	8b 55 18             	mov    0x18(%ebp),%edx
  801bd7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bdb:	52                   	push   %edx
  801bdc:	50                   	push   %eax
  801bdd:	ff 75 10             	pushl  0x10(%ebp)
  801be0:	ff 75 0c             	pushl  0xc(%ebp)
  801be3:	ff 75 08             	pushl  0x8(%ebp)
  801be6:	6a 27                	push   $0x27
  801be8:	e8 18 fb ff ff       	call   801705 <syscall>
  801bed:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf0:	90                   	nop
}
  801bf1:	c9                   	leave  
  801bf2:	c3                   	ret    

00801bf3 <chktst>:
void chktst(uint32 n)
{
  801bf3:	55                   	push   %ebp
  801bf4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	ff 75 08             	pushl  0x8(%ebp)
  801c01:	6a 29                	push   $0x29
  801c03:	e8 fd fa ff ff       	call   801705 <syscall>
  801c08:	83 c4 18             	add    $0x18,%esp
	return ;
  801c0b:	90                   	nop
}
  801c0c:	c9                   	leave  
  801c0d:	c3                   	ret    

00801c0e <inctst>:

void inctst()
{
  801c0e:	55                   	push   %ebp
  801c0f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 2a                	push   $0x2a
  801c1d:	e8 e3 fa ff ff       	call   801705 <syscall>
  801c22:	83 c4 18             	add    $0x18,%esp
	return ;
  801c25:	90                   	nop
}
  801c26:	c9                   	leave  
  801c27:	c3                   	ret    

00801c28 <gettst>:
uint32 gettst()
{
  801c28:	55                   	push   %ebp
  801c29:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 2b                	push   $0x2b
  801c37:	e8 c9 fa ff ff       	call   801705 <syscall>
  801c3c:	83 c4 18             	add    $0x18,%esp
}
  801c3f:	c9                   	leave  
  801c40:	c3                   	ret    

00801c41 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c41:	55                   	push   %ebp
  801c42:	89 e5                	mov    %esp,%ebp
  801c44:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 2c                	push   $0x2c
  801c53:	e8 ad fa ff ff       	call   801705 <syscall>
  801c58:	83 c4 18             	add    $0x18,%esp
  801c5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c5e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c62:	75 07                	jne    801c6b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c64:	b8 01 00 00 00       	mov    $0x1,%eax
  801c69:	eb 05                	jmp    801c70 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c6b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c70:	c9                   	leave  
  801c71:	c3                   	ret    

00801c72 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c72:	55                   	push   %ebp
  801c73:	89 e5                	mov    %esp,%ebp
  801c75:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 00                	push   $0x0
  801c82:	6a 2c                	push   $0x2c
  801c84:	e8 7c fa ff ff       	call   801705 <syscall>
  801c89:	83 c4 18             	add    $0x18,%esp
  801c8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c8f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c93:	75 07                	jne    801c9c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c95:	b8 01 00 00 00       	mov    $0x1,%eax
  801c9a:	eb 05                	jmp    801ca1 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c9c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ca1:	c9                   	leave  
  801ca2:	c3                   	ret    

00801ca3 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ca3:	55                   	push   %ebp
  801ca4:	89 e5                	mov    %esp,%ebp
  801ca6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 2c                	push   $0x2c
  801cb5:	e8 4b fa ff ff       	call   801705 <syscall>
  801cba:	83 c4 18             	add    $0x18,%esp
  801cbd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cc0:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cc4:	75 07                	jne    801ccd <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cc6:	b8 01 00 00 00       	mov    $0x1,%eax
  801ccb:	eb 05                	jmp    801cd2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ccd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cd2:	c9                   	leave  
  801cd3:	c3                   	ret    

00801cd4 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cd4:	55                   	push   %ebp
  801cd5:	89 e5                	mov    %esp,%ebp
  801cd7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 00                	push   $0x0
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 2c                	push   $0x2c
  801ce6:	e8 1a fa ff ff       	call   801705 <syscall>
  801ceb:	83 c4 18             	add    $0x18,%esp
  801cee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cf1:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cf5:	75 07                	jne    801cfe <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cf7:	b8 01 00 00 00       	mov    $0x1,%eax
  801cfc:	eb 05                	jmp    801d03 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801cfe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d03:	c9                   	leave  
  801d04:	c3                   	ret    

00801d05 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d05:	55                   	push   %ebp
  801d06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 00                	push   $0x0
  801d10:	ff 75 08             	pushl  0x8(%ebp)
  801d13:	6a 2d                	push   $0x2d
  801d15:	e8 eb f9 ff ff       	call   801705 <syscall>
  801d1a:	83 c4 18             	add    $0x18,%esp
	return ;
  801d1d:	90                   	nop
}
  801d1e:	c9                   	leave  
  801d1f:	c3                   	ret    

00801d20 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d20:	55                   	push   %ebp
  801d21:	89 e5                	mov    %esp,%ebp
  801d23:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d24:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d27:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d30:	6a 00                	push   $0x0
  801d32:	53                   	push   %ebx
  801d33:	51                   	push   %ecx
  801d34:	52                   	push   %edx
  801d35:	50                   	push   %eax
  801d36:	6a 2e                	push   $0x2e
  801d38:	e8 c8 f9 ff ff       	call   801705 <syscall>
  801d3d:	83 c4 18             	add    $0x18,%esp
}
  801d40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d43:	c9                   	leave  
  801d44:	c3                   	ret    

00801d45 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d45:	55                   	push   %ebp
  801d46:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d48:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	6a 00                	push   $0x0
  801d54:	52                   	push   %edx
  801d55:	50                   	push   %eax
  801d56:	6a 2f                	push   $0x2f
  801d58:	e8 a8 f9 ff ff       	call   801705 <syscall>
  801d5d:	83 c4 18             	add    $0x18,%esp
}
  801d60:	c9                   	leave  
  801d61:	c3                   	ret    

00801d62 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801d62:	55                   	push   %ebp
  801d63:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	ff 75 0c             	pushl  0xc(%ebp)
  801d6e:	ff 75 08             	pushl  0x8(%ebp)
  801d71:	6a 30                	push   $0x30
  801d73:	e8 8d f9 ff ff       	call   801705 <syscall>
  801d78:	83 c4 18             	add    $0x18,%esp
	return ;
  801d7b:	90                   	nop
}
  801d7c:	c9                   	leave  
  801d7d:	c3                   	ret    
  801d7e:	66 90                	xchg   %ax,%ax

00801d80 <__udivdi3>:
  801d80:	55                   	push   %ebp
  801d81:	57                   	push   %edi
  801d82:	56                   	push   %esi
  801d83:	53                   	push   %ebx
  801d84:	83 ec 1c             	sub    $0x1c,%esp
  801d87:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d8b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d8f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d93:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d97:	89 ca                	mov    %ecx,%edx
  801d99:	89 f8                	mov    %edi,%eax
  801d9b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d9f:	85 f6                	test   %esi,%esi
  801da1:	75 2d                	jne    801dd0 <__udivdi3+0x50>
  801da3:	39 cf                	cmp    %ecx,%edi
  801da5:	77 65                	ja     801e0c <__udivdi3+0x8c>
  801da7:	89 fd                	mov    %edi,%ebp
  801da9:	85 ff                	test   %edi,%edi
  801dab:	75 0b                	jne    801db8 <__udivdi3+0x38>
  801dad:	b8 01 00 00 00       	mov    $0x1,%eax
  801db2:	31 d2                	xor    %edx,%edx
  801db4:	f7 f7                	div    %edi
  801db6:	89 c5                	mov    %eax,%ebp
  801db8:	31 d2                	xor    %edx,%edx
  801dba:	89 c8                	mov    %ecx,%eax
  801dbc:	f7 f5                	div    %ebp
  801dbe:	89 c1                	mov    %eax,%ecx
  801dc0:	89 d8                	mov    %ebx,%eax
  801dc2:	f7 f5                	div    %ebp
  801dc4:	89 cf                	mov    %ecx,%edi
  801dc6:	89 fa                	mov    %edi,%edx
  801dc8:	83 c4 1c             	add    $0x1c,%esp
  801dcb:	5b                   	pop    %ebx
  801dcc:	5e                   	pop    %esi
  801dcd:	5f                   	pop    %edi
  801dce:	5d                   	pop    %ebp
  801dcf:	c3                   	ret    
  801dd0:	39 ce                	cmp    %ecx,%esi
  801dd2:	77 28                	ja     801dfc <__udivdi3+0x7c>
  801dd4:	0f bd fe             	bsr    %esi,%edi
  801dd7:	83 f7 1f             	xor    $0x1f,%edi
  801dda:	75 40                	jne    801e1c <__udivdi3+0x9c>
  801ddc:	39 ce                	cmp    %ecx,%esi
  801dde:	72 0a                	jb     801dea <__udivdi3+0x6a>
  801de0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801de4:	0f 87 9e 00 00 00    	ja     801e88 <__udivdi3+0x108>
  801dea:	b8 01 00 00 00       	mov    $0x1,%eax
  801def:	89 fa                	mov    %edi,%edx
  801df1:	83 c4 1c             	add    $0x1c,%esp
  801df4:	5b                   	pop    %ebx
  801df5:	5e                   	pop    %esi
  801df6:	5f                   	pop    %edi
  801df7:	5d                   	pop    %ebp
  801df8:	c3                   	ret    
  801df9:	8d 76 00             	lea    0x0(%esi),%esi
  801dfc:	31 ff                	xor    %edi,%edi
  801dfe:	31 c0                	xor    %eax,%eax
  801e00:	89 fa                	mov    %edi,%edx
  801e02:	83 c4 1c             	add    $0x1c,%esp
  801e05:	5b                   	pop    %ebx
  801e06:	5e                   	pop    %esi
  801e07:	5f                   	pop    %edi
  801e08:	5d                   	pop    %ebp
  801e09:	c3                   	ret    
  801e0a:	66 90                	xchg   %ax,%ax
  801e0c:	89 d8                	mov    %ebx,%eax
  801e0e:	f7 f7                	div    %edi
  801e10:	31 ff                	xor    %edi,%edi
  801e12:	89 fa                	mov    %edi,%edx
  801e14:	83 c4 1c             	add    $0x1c,%esp
  801e17:	5b                   	pop    %ebx
  801e18:	5e                   	pop    %esi
  801e19:	5f                   	pop    %edi
  801e1a:	5d                   	pop    %ebp
  801e1b:	c3                   	ret    
  801e1c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e21:	89 eb                	mov    %ebp,%ebx
  801e23:	29 fb                	sub    %edi,%ebx
  801e25:	89 f9                	mov    %edi,%ecx
  801e27:	d3 e6                	shl    %cl,%esi
  801e29:	89 c5                	mov    %eax,%ebp
  801e2b:	88 d9                	mov    %bl,%cl
  801e2d:	d3 ed                	shr    %cl,%ebp
  801e2f:	89 e9                	mov    %ebp,%ecx
  801e31:	09 f1                	or     %esi,%ecx
  801e33:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e37:	89 f9                	mov    %edi,%ecx
  801e39:	d3 e0                	shl    %cl,%eax
  801e3b:	89 c5                	mov    %eax,%ebp
  801e3d:	89 d6                	mov    %edx,%esi
  801e3f:	88 d9                	mov    %bl,%cl
  801e41:	d3 ee                	shr    %cl,%esi
  801e43:	89 f9                	mov    %edi,%ecx
  801e45:	d3 e2                	shl    %cl,%edx
  801e47:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e4b:	88 d9                	mov    %bl,%cl
  801e4d:	d3 e8                	shr    %cl,%eax
  801e4f:	09 c2                	or     %eax,%edx
  801e51:	89 d0                	mov    %edx,%eax
  801e53:	89 f2                	mov    %esi,%edx
  801e55:	f7 74 24 0c          	divl   0xc(%esp)
  801e59:	89 d6                	mov    %edx,%esi
  801e5b:	89 c3                	mov    %eax,%ebx
  801e5d:	f7 e5                	mul    %ebp
  801e5f:	39 d6                	cmp    %edx,%esi
  801e61:	72 19                	jb     801e7c <__udivdi3+0xfc>
  801e63:	74 0b                	je     801e70 <__udivdi3+0xf0>
  801e65:	89 d8                	mov    %ebx,%eax
  801e67:	31 ff                	xor    %edi,%edi
  801e69:	e9 58 ff ff ff       	jmp    801dc6 <__udivdi3+0x46>
  801e6e:	66 90                	xchg   %ax,%ax
  801e70:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e74:	89 f9                	mov    %edi,%ecx
  801e76:	d3 e2                	shl    %cl,%edx
  801e78:	39 c2                	cmp    %eax,%edx
  801e7a:	73 e9                	jae    801e65 <__udivdi3+0xe5>
  801e7c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e7f:	31 ff                	xor    %edi,%edi
  801e81:	e9 40 ff ff ff       	jmp    801dc6 <__udivdi3+0x46>
  801e86:	66 90                	xchg   %ax,%ax
  801e88:	31 c0                	xor    %eax,%eax
  801e8a:	e9 37 ff ff ff       	jmp    801dc6 <__udivdi3+0x46>
  801e8f:	90                   	nop

00801e90 <__umoddi3>:
  801e90:	55                   	push   %ebp
  801e91:	57                   	push   %edi
  801e92:	56                   	push   %esi
  801e93:	53                   	push   %ebx
  801e94:	83 ec 1c             	sub    $0x1c,%esp
  801e97:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e9b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e9f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ea3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ea7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801eab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801eaf:	89 f3                	mov    %esi,%ebx
  801eb1:	89 fa                	mov    %edi,%edx
  801eb3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801eb7:	89 34 24             	mov    %esi,(%esp)
  801eba:	85 c0                	test   %eax,%eax
  801ebc:	75 1a                	jne    801ed8 <__umoddi3+0x48>
  801ebe:	39 f7                	cmp    %esi,%edi
  801ec0:	0f 86 a2 00 00 00    	jbe    801f68 <__umoddi3+0xd8>
  801ec6:	89 c8                	mov    %ecx,%eax
  801ec8:	89 f2                	mov    %esi,%edx
  801eca:	f7 f7                	div    %edi
  801ecc:	89 d0                	mov    %edx,%eax
  801ece:	31 d2                	xor    %edx,%edx
  801ed0:	83 c4 1c             	add    $0x1c,%esp
  801ed3:	5b                   	pop    %ebx
  801ed4:	5e                   	pop    %esi
  801ed5:	5f                   	pop    %edi
  801ed6:	5d                   	pop    %ebp
  801ed7:	c3                   	ret    
  801ed8:	39 f0                	cmp    %esi,%eax
  801eda:	0f 87 ac 00 00 00    	ja     801f8c <__umoddi3+0xfc>
  801ee0:	0f bd e8             	bsr    %eax,%ebp
  801ee3:	83 f5 1f             	xor    $0x1f,%ebp
  801ee6:	0f 84 ac 00 00 00    	je     801f98 <__umoddi3+0x108>
  801eec:	bf 20 00 00 00       	mov    $0x20,%edi
  801ef1:	29 ef                	sub    %ebp,%edi
  801ef3:	89 fe                	mov    %edi,%esi
  801ef5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ef9:	89 e9                	mov    %ebp,%ecx
  801efb:	d3 e0                	shl    %cl,%eax
  801efd:	89 d7                	mov    %edx,%edi
  801eff:	89 f1                	mov    %esi,%ecx
  801f01:	d3 ef                	shr    %cl,%edi
  801f03:	09 c7                	or     %eax,%edi
  801f05:	89 e9                	mov    %ebp,%ecx
  801f07:	d3 e2                	shl    %cl,%edx
  801f09:	89 14 24             	mov    %edx,(%esp)
  801f0c:	89 d8                	mov    %ebx,%eax
  801f0e:	d3 e0                	shl    %cl,%eax
  801f10:	89 c2                	mov    %eax,%edx
  801f12:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f16:	d3 e0                	shl    %cl,%eax
  801f18:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f1c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f20:	89 f1                	mov    %esi,%ecx
  801f22:	d3 e8                	shr    %cl,%eax
  801f24:	09 d0                	or     %edx,%eax
  801f26:	d3 eb                	shr    %cl,%ebx
  801f28:	89 da                	mov    %ebx,%edx
  801f2a:	f7 f7                	div    %edi
  801f2c:	89 d3                	mov    %edx,%ebx
  801f2e:	f7 24 24             	mull   (%esp)
  801f31:	89 c6                	mov    %eax,%esi
  801f33:	89 d1                	mov    %edx,%ecx
  801f35:	39 d3                	cmp    %edx,%ebx
  801f37:	0f 82 87 00 00 00    	jb     801fc4 <__umoddi3+0x134>
  801f3d:	0f 84 91 00 00 00    	je     801fd4 <__umoddi3+0x144>
  801f43:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f47:	29 f2                	sub    %esi,%edx
  801f49:	19 cb                	sbb    %ecx,%ebx
  801f4b:	89 d8                	mov    %ebx,%eax
  801f4d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f51:	d3 e0                	shl    %cl,%eax
  801f53:	89 e9                	mov    %ebp,%ecx
  801f55:	d3 ea                	shr    %cl,%edx
  801f57:	09 d0                	or     %edx,%eax
  801f59:	89 e9                	mov    %ebp,%ecx
  801f5b:	d3 eb                	shr    %cl,%ebx
  801f5d:	89 da                	mov    %ebx,%edx
  801f5f:	83 c4 1c             	add    $0x1c,%esp
  801f62:	5b                   	pop    %ebx
  801f63:	5e                   	pop    %esi
  801f64:	5f                   	pop    %edi
  801f65:	5d                   	pop    %ebp
  801f66:	c3                   	ret    
  801f67:	90                   	nop
  801f68:	89 fd                	mov    %edi,%ebp
  801f6a:	85 ff                	test   %edi,%edi
  801f6c:	75 0b                	jne    801f79 <__umoddi3+0xe9>
  801f6e:	b8 01 00 00 00       	mov    $0x1,%eax
  801f73:	31 d2                	xor    %edx,%edx
  801f75:	f7 f7                	div    %edi
  801f77:	89 c5                	mov    %eax,%ebp
  801f79:	89 f0                	mov    %esi,%eax
  801f7b:	31 d2                	xor    %edx,%edx
  801f7d:	f7 f5                	div    %ebp
  801f7f:	89 c8                	mov    %ecx,%eax
  801f81:	f7 f5                	div    %ebp
  801f83:	89 d0                	mov    %edx,%eax
  801f85:	e9 44 ff ff ff       	jmp    801ece <__umoddi3+0x3e>
  801f8a:	66 90                	xchg   %ax,%ax
  801f8c:	89 c8                	mov    %ecx,%eax
  801f8e:	89 f2                	mov    %esi,%edx
  801f90:	83 c4 1c             	add    $0x1c,%esp
  801f93:	5b                   	pop    %ebx
  801f94:	5e                   	pop    %esi
  801f95:	5f                   	pop    %edi
  801f96:	5d                   	pop    %ebp
  801f97:	c3                   	ret    
  801f98:	3b 04 24             	cmp    (%esp),%eax
  801f9b:	72 06                	jb     801fa3 <__umoddi3+0x113>
  801f9d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fa1:	77 0f                	ja     801fb2 <__umoddi3+0x122>
  801fa3:	89 f2                	mov    %esi,%edx
  801fa5:	29 f9                	sub    %edi,%ecx
  801fa7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801fab:	89 14 24             	mov    %edx,(%esp)
  801fae:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fb2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801fb6:	8b 14 24             	mov    (%esp),%edx
  801fb9:	83 c4 1c             	add    $0x1c,%esp
  801fbc:	5b                   	pop    %ebx
  801fbd:	5e                   	pop    %esi
  801fbe:	5f                   	pop    %edi
  801fbf:	5d                   	pop    %ebp
  801fc0:	c3                   	ret    
  801fc1:	8d 76 00             	lea    0x0(%esi),%esi
  801fc4:	2b 04 24             	sub    (%esp),%eax
  801fc7:	19 fa                	sbb    %edi,%edx
  801fc9:	89 d1                	mov    %edx,%ecx
  801fcb:	89 c6                	mov    %eax,%esi
  801fcd:	e9 71 ff ff ff       	jmp    801f43 <__umoddi3+0xb3>
  801fd2:	66 90                	xchg   %ax,%ax
  801fd4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801fd8:	72 ea                	jb     801fc4 <__umoddi3+0x134>
  801fda:	89 d9                	mov    %ebx,%ecx
  801fdc:	e9 62 ff ff ff       	jmp    801f43 <__umoddi3+0xb3>
