
obj/user/tst_page_replacement_alloc:     file format elf32-i386


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
  800031:	e8 4d 03 00 00       	call   800383 <libmain>
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
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp

//	cprintf("envID = %d\n",envID);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003f:	a1 20 30 80 00       	mov    0x803020,%eax
  800044:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80004a:	8b 00                	mov    (%eax),%eax
  80004c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800052:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800057:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005c:	74 14                	je     800072 <_main+0x3a>
  80005e:	83 ec 04             	sub    $0x4,%esp
  800061:	68 e0 1d 80 00       	push   $0x801de0
  800066:	6a 12                	push   $0x12
  800068:	68 24 1e 80 00       	push   $0x801e24
  80006d:	e8 36 04 00 00       	call   8004a8 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800072:	a1 20 30 80 00       	mov    0x803020,%eax
  800077:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80007d:	83 c0 14             	add    $0x14,%eax
  800080:	8b 00                	mov    (%eax),%eax
  800082:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800085:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800088:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008d:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800092:	74 14                	je     8000a8 <_main+0x70>
  800094:	83 ec 04             	sub    $0x4,%esp
  800097:	68 e0 1d 80 00       	push   $0x801de0
  80009c:	6a 13                	push   $0x13
  80009e:	68 24 1e 80 00       	push   $0x801e24
  8000a3:	e8 00 04 00 00       	call   8004a8 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ad:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000b3:	83 c0 28             	add    $0x28,%eax
  8000b6:	8b 00                	mov    (%eax),%eax
  8000b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000be:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c3:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c8:	74 14                	je     8000de <_main+0xa6>
  8000ca:	83 ec 04             	sub    $0x4,%esp
  8000cd:	68 e0 1d 80 00       	push   $0x801de0
  8000d2:	6a 14                	push   $0x14
  8000d4:	68 24 1e 80 00       	push   $0x801e24
  8000d9:	e8 ca 03 00 00       	call   8004a8 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000de:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e3:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000e9:	83 c0 3c             	add    $0x3c,%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f9:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fe:	74 14                	je     800114 <_main+0xdc>
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	68 e0 1d 80 00       	push   $0x801de0
  800108:	6a 15                	push   $0x15
  80010a:	68 24 1e 80 00       	push   $0x801e24
  80010f:	e8 94 03 00 00       	call   8004a8 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800114:	a1 20 30 80 00       	mov    0x803020,%eax
  800119:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80011f:	83 c0 50             	add    $0x50,%eax
  800122:	8b 00                	mov    (%eax),%eax
  800124:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800127:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012f:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800134:	74 14                	je     80014a <_main+0x112>
  800136:	83 ec 04             	sub    $0x4,%esp
  800139:	68 e0 1d 80 00       	push   $0x801de0
  80013e:	6a 16                	push   $0x16
  800140:	68 24 1e 80 00       	push   $0x801e24
  800145:	e8 5e 03 00 00       	call   8004a8 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014a:	a1 20 30 80 00       	mov    0x803020,%eax
  80014f:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800155:	83 c0 64             	add    $0x64,%eax
  800158:	8b 00                	mov    (%eax),%eax
  80015a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80015d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800160:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800165:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016a:	74 14                	je     800180 <_main+0x148>
  80016c:	83 ec 04             	sub    $0x4,%esp
  80016f:	68 e0 1d 80 00       	push   $0x801de0
  800174:	6a 17                	push   $0x17
  800176:	68 24 1e 80 00       	push   $0x801e24
  80017b:	e8 28 03 00 00       	call   8004a8 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800180:	a1 20 30 80 00       	mov    0x803020,%eax
  800185:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80018b:	83 c0 78             	add    $0x78,%eax
  80018e:	8b 00                	mov    (%eax),%eax
  800190:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800193:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800196:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019b:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a0:	74 14                	je     8001b6 <_main+0x17e>
  8001a2:	83 ec 04             	sub    $0x4,%esp
  8001a5:	68 e0 1d 80 00       	push   $0x801de0
  8001aa:	6a 18                	push   $0x18
  8001ac:	68 24 1e 80 00       	push   $0x801e24
  8001b1:	e8 f2 02 00 00       	call   8004a8 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bb:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001c1:	05 8c 00 00 00       	add    $0x8c,%eax
  8001c6:	8b 00                	mov    (%eax),%eax
  8001c8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001cb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d3:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d8:	74 14                	je     8001ee <_main+0x1b6>
  8001da:	83 ec 04             	sub    $0x4,%esp
  8001dd:	68 e0 1d 80 00       	push   $0x801de0
  8001e2:	6a 19                	push   $0x19
  8001e4:	68 24 1e 80 00       	push   $0x801e24
  8001e9:	e8 ba 02 00 00       	call   8004a8 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f3:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001f9:	05 a0 00 00 00       	add    $0xa0,%eax
  8001fe:	8b 00                	mov    (%eax),%eax
  800200:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800203:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800206:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020b:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800210:	74 14                	je     800226 <_main+0x1ee>
  800212:	83 ec 04             	sub    $0x4,%esp
  800215:	68 e0 1d 80 00       	push   $0x801de0
  80021a:	6a 1a                	push   $0x1a
  80021c:	68 24 1e 80 00       	push   $0x801e24
  800221:	e8 82 02 00 00       	call   8004a8 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800226:	a1 20 30 80 00       	mov    0x803020,%eax
  80022b:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800231:	05 b4 00 00 00       	add    $0xb4,%eax
  800236:	8b 00                	mov    (%eax),%eax
  800238:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80023b:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80023e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800243:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800248:	74 14                	je     80025e <_main+0x226>
  80024a:	83 ec 04             	sub    $0x4,%esp
  80024d:	68 e0 1d 80 00       	push   $0x801de0
  800252:	6a 1b                	push   $0x1b
  800254:	68 24 1e 80 00       	push   $0x801e24
  800259:	e8 4a 02 00 00       	call   8004a8 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025e:	a1 20 30 80 00       	mov    0x803020,%eax
  800263:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800269:	05 c8 00 00 00       	add    $0xc8,%eax
  80026e:	8b 00                	mov    (%eax),%eax
  800270:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800273:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800276:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80027b:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800280:	74 14                	je     800296 <_main+0x25e>
  800282:	83 ec 04             	sub    $0x4,%esp
  800285:	68 e0 1d 80 00       	push   $0x801de0
  80028a:	6a 1c                	push   $0x1c
  80028c:	68 24 1e 80 00       	push   $0x801e24
  800291:	e8 12 02 00 00       	call   8004a8 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800296:	a1 20 30 80 00       	mov    0x803020,%eax
  80029b:	8b 80 80 52 00 00    	mov    0x5280(%eax),%eax
  8002a1:	85 c0                	test   %eax,%eax
  8002a3:	74 14                	je     8002b9 <_main+0x281>
  8002a5:	83 ec 04             	sub    $0x4,%esp
  8002a8:	68 48 1e 80 00       	push   $0x801e48
  8002ad:	6a 1d                	push   $0x1d
  8002af:	68 24 1e 80 00       	push   $0x801e24
  8002b4:	e8 ef 01 00 00       	call   8004a8 <_panic>
	}

	int freePages = sys_calculate_free_frames();
  8002b9:	e8 97 13 00 00       	call   801655 <sys_calculate_free_frames>
  8002be:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c1:	e8 12 14 00 00       	call   8016d8 <sys_pf_calculate_allocated_pages>
  8002c6:	89 45 c0             	mov    %eax,-0x40(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8002c9:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002ce:	88 45 bf             	mov    %al,-0x41(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002d1:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002d6:	88 45 be             	mov    %al,-0x42(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002e0:	eb 37                	jmp    800319 <_main+0x2e1>
	{
		arr[i] = -1 ;
  8002e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e5:	05 40 30 80 00       	add    $0x803040,%eax
  8002ea:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002ed:	a1 04 30 80 00       	mov    0x803004,%eax
  8002f2:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002f8:	8a 12                	mov    (%edx),%dl
  8002fa:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002fc:	a1 00 30 80 00       	mov    0x803000,%eax
  800301:	40                   	inc    %eax
  800302:	a3 00 30 80 00       	mov    %eax,0x803000
  800307:	a1 04 30 80 00       	mov    0x803004,%eax
  80030c:	40                   	inc    %eax
  80030d:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800312:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800319:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  800320:	7e c0                	jle    8002e2 <_main+0x2aa>

	//===================

	//cprintf("Checking Allocation in Mem & Page File... \n");
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  800322:	e8 b1 13 00 00       	call   8016d8 <sys_pf_calculate_allocated_pages>
  800327:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  80032a:	74 14                	je     800340 <_main+0x308>
  80032c:	83 ec 04             	sub    $0x4,%esp
  80032f:	68 90 1e 80 00       	push   $0x801e90
  800334:	6a 38                	push   $0x38
  800336:	68 24 1e 80 00       	push   $0x801e24
  80033b:	e8 68 01 00 00       	call   8004a8 <_panic>

		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800340:	e8 10 13 00 00       	call   801655 <sys_calculate_free_frames>
  800345:	89 c3                	mov    %eax,%ebx
  800347:	e8 22 13 00 00       	call   80166e <sys_calculate_modified_frames>
  80034c:	01 d8                	add    %ebx,%eax
  80034e:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if( (freePages - freePagesAfter) != 0 )
  800351:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800354:	3b 45 b8             	cmp    -0x48(%ebp),%eax
  800357:	74 14                	je     80036d <_main+0x335>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  800359:	83 ec 04             	sub    $0x4,%esp
  80035c:	68 fc 1e 80 00       	push   $0x801efc
  800361:	6a 3c                	push   $0x3c
  800363:	68 24 1e 80 00       	push   $0x801e24
  800368:	e8 3b 01 00 00       	call   8004a8 <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [ALLOCATION] by REMOVING ONLY ONE PAGE is completed successfully.\n");
  80036d:	83 ec 0c             	sub    $0xc,%esp
  800370:	68 60 1f 80 00       	push   $0x801f60
  800375:	e8 e5 03 00 00       	call   80075f <cprintf>
  80037a:	83 c4 10             	add    $0x10,%esp
	return;
  80037d:	90                   	nop
}
  80037e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800381:	c9                   	leave  
  800382:	c3                   	ret    

00800383 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800383:	55                   	push   %ebp
  800384:	89 e5                	mov    %esp,%ebp
  800386:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800389:	e8 fc 11 00 00       	call   80158a <sys_getenvindex>
  80038e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800391:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800394:	89 d0                	mov    %edx,%eax
  800396:	c1 e0 03             	shl    $0x3,%eax
  800399:	01 d0                	add    %edx,%eax
  80039b:	c1 e0 02             	shl    $0x2,%eax
  80039e:	01 d0                	add    %edx,%eax
  8003a0:	c1 e0 06             	shl    $0x6,%eax
  8003a3:	29 d0                	sub    %edx,%eax
  8003a5:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8003ac:	01 c8                	add    %ecx,%eax
  8003ae:	01 d0                	add    %edx,%eax
  8003b0:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8003b5:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bf:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8003c5:	84 c0                	test   %al,%al
  8003c7:	74 0f                	je     8003d8 <libmain+0x55>
		binaryname = myEnv->prog_name;
  8003c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ce:	05 b0 52 00 00       	add    $0x52b0,%eax
  8003d3:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003d8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003dc:	7e 0a                	jle    8003e8 <libmain+0x65>
		binaryname = argv[0];
  8003de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e1:	8b 00                	mov    (%eax),%eax
  8003e3:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  8003e8:	83 ec 08             	sub    $0x8,%esp
  8003eb:	ff 75 0c             	pushl  0xc(%ebp)
  8003ee:	ff 75 08             	pushl  0x8(%ebp)
  8003f1:	e8 42 fc ff ff       	call   800038 <_main>
  8003f6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003f9:	e8 27 13 00 00       	call   801725 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003fe:	83 ec 0c             	sub    $0xc,%esp
  800401:	68 e4 1f 80 00       	push   $0x801fe4
  800406:	e8 54 03 00 00       	call   80075f <cprintf>
  80040b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80040e:	a1 20 30 80 00       	mov    0x803020,%eax
  800413:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800419:	a1 20 30 80 00       	mov    0x803020,%eax
  80041e:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800424:	83 ec 04             	sub    $0x4,%esp
  800427:	52                   	push   %edx
  800428:	50                   	push   %eax
  800429:	68 0c 20 80 00       	push   $0x80200c
  80042e:	e8 2c 03 00 00       	call   80075f <cprintf>
  800433:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800436:	a1 20 30 80 00       	mov    0x803020,%eax
  80043b:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800441:	a1 20 30 80 00       	mov    0x803020,%eax
  800446:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  80044c:	a1 20 30 80 00       	mov    0x803020,%eax
  800451:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800457:	51                   	push   %ecx
  800458:	52                   	push   %edx
  800459:	50                   	push   %eax
  80045a:	68 34 20 80 00       	push   $0x802034
  80045f:	e8 fb 02 00 00       	call   80075f <cprintf>
  800464:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800467:	83 ec 0c             	sub    $0xc,%esp
  80046a:	68 e4 1f 80 00       	push   $0x801fe4
  80046f:	e8 eb 02 00 00       	call   80075f <cprintf>
  800474:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800477:	e8 c3 12 00 00       	call   80173f <sys_enable_interrupt>

	// exit gracefully
	exit();
  80047c:	e8 19 00 00 00       	call   80049a <exit>
}
  800481:	90                   	nop
  800482:	c9                   	leave  
  800483:	c3                   	ret    

00800484 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800484:	55                   	push   %ebp
  800485:	89 e5                	mov    %esp,%ebp
  800487:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80048a:	83 ec 0c             	sub    $0xc,%esp
  80048d:	6a 00                	push   $0x0
  80048f:	e8 c2 10 00 00       	call   801556 <sys_env_destroy>
  800494:	83 c4 10             	add    $0x10,%esp
}
  800497:	90                   	nop
  800498:	c9                   	leave  
  800499:	c3                   	ret    

0080049a <exit>:

void
exit(void)
{
  80049a:	55                   	push   %ebp
  80049b:	89 e5                	mov    %esp,%ebp
  80049d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8004a0:	e8 17 11 00 00       	call   8015bc <sys_env_exit>
}
  8004a5:	90                   	nop
  8004a6:	c9                   	leave  
  8004a7:	c3                   	ret    

008004a8 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004a8:	55                   	push   %ebp
  8004a9:	89 e5                	mov    %esp,%ebp
  8004ab:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004ae:	8d 45 10             	lea    0x10(%ebp),%eax
  8004b1:	83 c0 04             	add    $0x4,%eax
  8004b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004b7:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8004bc:	85 c0                	test   %eax,%eax
  8004be:	74 16                	je     8004d6 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004c0:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8004c5:	83 ec 08             	sub    $0x8,%esp
  8004c8:	50                   	push   %eax
  8004c9:	68 8c 20 80 00       	push   $0x80208c
  8004ce:	e8 8c 02 00 00       	call   80075f <cprintf>
  8004d3:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004d6:	a1 08 30 80 00       	mov    0x803008,%eax
  8004db:	ff 75 0c             	pushl  0xc(%ebp)
  8004de:	ff 75 08             	pushl  0x8(%ebp)
  8004e1:	50                   	push   %eax
  8004e2:	68 91 20 80 00       	push   $0x802091
  8004e7:	e8 73 02 00 00       	call   80075f <cprintf>
  8004ec:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8004ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f2:	83 ec 08             	sub    $0x8,%esp
  8004f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f8:	50                   	push   %eax
  8004f9:	e8 f6 01 00 00       	call   8006f4 <vcprintf>
  8004fe:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800501:	83 ec 08             	sub    $0x8,%esp
  800504:	6a 00                	push   $0x0
  800506:	68 ad 20 80 00       	push   $0x8020ad
  80050b:	e8 e4 01 00 00       	call   8006f4 <vcprintf>
  800510:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800513:	e8 82 ff ff ff       	call   80049a <exit>

	// should not return here
	while (1) ;
  800518:	eb fe                	jmp    800518 <_panic+0x70>

0080051a <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80051a:	55                   	push   %ebp
  80051b:	89 e5                	mov    %esp,%ebp
  80051d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800520:	a1 20 30 80 00       	mov    0x803020,%eax
  800525:	8b 50 74             	mov    0x74(%eax),%edx
  800528:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052b:	39 c2                	cmp    %eax,%edx
  80052d:	74 14                	je     800543 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80052f:	83 ec 04             	sub    $0x4,%esp
  800532:	68 b0 20 80 00       	push   $0x8020b0
  800537:	6a 26                	push   $0x26
  800539:	68 fc 20 80 00       	push   $0x8020fc
  80053e:	e8 65 ff ff ff       	call   8004a8 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800543:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80054a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800551:	e9 c4 00 00 00       	jmp    80061a <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800556:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800559:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800560:	8b 45 08             	mov    0x8(%ebp),%eax
  800563:	01 d0                	add    %edx,%eax
  800565:	8b 00                	mov    (%eax),%eax
  800567:	85 c0                	test   %eax,%eax
  800569:	75 08                	jne    800573 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80056b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80056e:	e9 a4 00 00 00       	jmp    800617 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800573:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80057a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800581:	eb 6b                	jmp    8005ee <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800583:	a1 20 30 80 00       	mov    0x803020,%eax
  800588:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80058e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800591:	89 d0                	mov    %edx,%eax
  800593:	c1 e0 02             	shl    $0x2,%eax
  800596:	01 d0                	add    %edx,%eax
  800598:	c1 e0 02             	shl    $0x2,%eax
  80059b:	01 c8                	add    %ecx,%eax
  80059d:	8a 40 04             	mov    0x4(%eax),%al
  8005a0:	84 c0                	test   %al,%al
  8005a2:	75 47                	jne    8005eb <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a9:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8005af:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005b2:	89 d0                	mov    %edx,%eax
  8005b4:	c1 e0 02             	shl    $0x2,%eax
  8005b7:	01 d0                	add    %edx,%eax
  8005b9:	c1 e0 02             	shl    $0x2,%eax
  8005bc:	01 c8                	add    %ecx,%eax
  8005be:	8b 00                	mov    (%eax),%eax
  8005c0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005c3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005cb:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005da:	01 c8                	add    %ecx,%eax
  8005dc:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005de:	39 c2                	cmp    %eax,%edx
  8005e0:	75 09                	jne    8005eb <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  8005e2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005e9:	eb 12                	jmp    8005fd <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005eb:	ff 45 e8             	incl   -0x18(%ebp)
  8005ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f3:	8b 50 74             	mov    0x74(%eax),%edx
  8005f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005f9:	39 c2                	cmp    %eax,%edx
  8005fb:	77 86                	ja     800583 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8005fd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800601:	75 14                	jne    800617 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800603:	83 ec 04             	sub    $0x4,%esp
  800606:	68 08 21 80 00       	push   $0x802108
  80060b:	6a 3a                	push   $0x3a
  80060d:	68 fc 20 80 00       	push   $0x8020fc
  800612:	e8 91 fe ff ff       	call   8004a8 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800617:	ff 45 f0             	incl   -0x10(%ebp)
  80061a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80061d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800620:	0f 8c 30 ff ff ff    	jl     800556 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800626:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80062d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800634:	eb 27                	jmp    80065d <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800636:	a1 20 30 80 00       	mov    0x803020,%eax
  80063b:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800641:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800644:	89 d0                	mov    %edx,%eax
  800646:	c1 e0 02             	shl    $0x2,%eax
  800649:	01 d0                	add    %edx,%eax
  80064b:	c1 e0 02             	shl    $0x2,%eax
  80064e:	01 c8                	add    %ecx,%eax
  800650:	8a 40 04             	mov    0x4(%eax),%al
  800653:	3c 01                	cmp    $0x1,%al
  800655:	75 03                	jne    80065a <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800657:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80065a:	ff 45 e0             	incl   -0x20(%ebp)
  80065d:	a1 20 30 80 00       	mov    0x803020,%eax
  800662:	8b 50 74             	mov    0x74(%eax),%edx
  800665:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800668:	39 c2                	cmp    %eax,%edx
  80066a:	77 ca                	ja     800636 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80066c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80066f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800672:	74 14                	je     800688 <CheckWSWithoutLastIndex+0x16e>
		panic(
  800674:	83 ec 04             	sub    $0x4,%esp
  800677:	68 5c 21 80 00       	push   $0x80215c
  80067c:	6a 44                	push   $0x44
  80067e:	68 fc 20 80 00       	push   $0x8020fc
  800683:	e8 20 fe ff ff       	call   8004a8 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800688:	90                   	nop
  800689:	c9                   	leave  
  80068a:	c3                   	ret    

0080068b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80068b:	55                   	push   %ebp
  80068c:	89 e5                	mov    %esp,%ebp
  80068e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800691:	8b 45 0c             	mov    0xc(%ebp),%eax
  800694:	8b 00                	mov    (%eax),%eax
  800696:	8d 48 01             	lea    0x1(%eax),%ecx
  800699:	8b 55 0c             	mov    0xc(%ebp),%edx
  80069c:	89 0a                	mov    %ecx,(%edx)
  80069e:	8b 55 08             	mov    0x8(%ebp),%edx
  8006a1:	88 d1                	mov    %dl,%cl
  8006a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006a6:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ad:	8b 00                	mov    (%eax),%eax
  8006af:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006b4:	75 2c                	jne    8006e2 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8006b6:	a0 24 30 80 00       	mov    0x803024,%al
  8006bb:	0f b6 c0             	movzbl %al,%eax
  8006be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006c1:	8b 12                	mov    (%edx),%edx
  8006c3:	89 d1                	mov    %edx,%ecx
  8006c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006c8:	83 c2 08             	add    $0x8,%edx
  8006cb:	83 ec 04             	sub    $0x4,%esp
  8006ce:	50                   	push   %eax
  8006cf:	51                   	push   %ecx
  8006d0:	52                   	push   %edx
  8006d1:	e8 3e 0e 00 00       	call   801514 <sys_cputs>
  8006d6:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006dc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e5:	8b 40 04             	mov    0x4(%eax),%eax
  8006e8:	8d 50 01             	lea    0x1(%eax),%edx
  8006eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ee:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006f1:	90                   	nop
  8006f2:	c9                   	leave  
  8006f3:	c3                   	ret    

008006f4 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006f4:	55                   	push   %ebp
  8006f5:	89 e5                	mov    %esp,%ebp
  8006f7:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006fd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800704:	00 00 00 
	b.cnt = 0;
  800707:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80070e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800711:	ff 75 0c             	pushl  0xc(%ebp)
  800714:	ff 75 08             	pushl  0x8(%ebp)
  800717:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80071d:	50                   	push   %eax
  80071e:	68 8b 06 80 00       	push   $0x80068b
  800723:	e8 11 02 00 00       	call   800939 <vprintfmt>
  800728:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80072b:	a0 24 30 80 00       	mov    0x803024,%al
  800730:	0f b6 c0             	movzbl %al,%eax
  800733:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800739:	83 ec 04             	sub    $0x4,%esp
  80073c:	50                   	push   %eax
  80073d:	52                   	push   %edx
  80073e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800744:	83 c0 08             	add    $0x8,%eax
  800747:	50                   	push   %eax
  800748:	e8 c7 0d 00 00       	call   801514 <sys_cputs>
  80074d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800750:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800757:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80075d:	c9                   	leave  
  80075e:	c3                   	ret    

0080075f <cprintf>:

int cprintf(const char *fmt, ...) {
  80075f:	55                   	push   %ebp
  800760:	89 e5                	mov    %esp,%ebp
  800762:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800765:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80076c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80076f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800772:	8b 45 08             	mov    0x8(%ebp),%eax
  800775:	83 ec 08             	sub    $0x8,%esp
  800778:	ff 75 f4             	pushl  -0xc(%ebp)
  80077b:	50                   	push   %eax
  80077c:	e8 73 ff ff ff       	call   8006f4 <vcprintf>
  800781:	83 c4 10             	add    $0x10,%esp
  800784:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800787:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80078a:	c9                   	leave  
  80078b:	c3                   	ret    

0080078c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80078c:	55                   	push   %ebp
  80078d:	89 e5                	mov    %esp,%ebp
  80078f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800792:	e8 8e 0f 00 00       	call   801725 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800797:	8d 45 0c             	lea    0xc(%ebp),%eax
  80079a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80079d:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a0:	83 ec 08             	sub    $0x8,%esp
  8007a3:	ff 75 f4             	pushl  -0xc(%ebp)
  8007a6:	50                   	push   %eax
  8007a7:	e8 48 ff ff ff       	call   8006f4 <vcprintf>
  8007ac:	83 c4 10             	add    $0x10,%esp
  8007af:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8007b2:	e8 88 0f 00 00       	call   80173f <sys_enable_interrupt>
	return cnt;
  8007b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007ba:	c9                   	leave  
  8007bb:	c3                   	ret    

008007bc <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007bc:	55                   	push   %ebp
  8007bd:	89 e5                	mov    %esp,%ebp
  8007bf:	53                   	push   %ebx
  8007c0:	83 ec 14             	sub    $0x14,%esp
  8007c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007cf:	8b 45 18             	mov    0x18(%ebp),%eax
  8007d2:	ba 00 00 00 00       	mov    $0x0,%edx
  8007d7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007da:	77 55                	ja     800831 <printnum+0x75>
  8007dc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007df:	72 05                	jb     8007e6 <printnum+0x2a>
  8007e1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007e4:	77 4b                	ja     800831 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007e6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007e9:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007ec:	8b 45 18             	mov    0x18(%ebp),%eax
  8007ef:	ba 00 00 00 00       	mov    $0x0,%edx
  8007f4:	52                   	push   %edx
  8007f5:	50                   	push   %eax
  8007f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8007f9:	ff 75 f0             	pushl  -0x10(%ebp)
  8007fc:	e8 63 13 00 00       	call   801b64 <__udivdi3>
  800801:	83 c4 10             	add    $0x10,%esp
  800804:	83 ec 04             	sub    $0x4,%esp
  800807:	ff 75 20             	pushl  0x20(%ebp)
  80080a:	53                   	push   %ebx
  80080b:	ff 75 18             	pushl  0x18(%ebp)
  80080e:	52                   	push   %edx
  80080f:	50                   	push   %eax
  800810:	ff 75 0c             	pushl  0xc(%ebp)
  800813:	ff 75 08             	pushl  0x8(%ebp)
  800816:	e8 a1 ff ff ff       	call   8007bc <printnum>
  80081b:	83 c4 20             	add    $0x20,%esp
  80081e:	eb 1a                	jmp    80083a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800820:	83 ec 08             	sub    $0x8,%esp
  800823:	ff 75 0c             	pushl  0xc(%ebp)
  800826:	ff 75 20             	pushl  0x20(%ebp)
  800829:	8b 45 08             	mov    0x8(%ebp),%eax
  80082c:	ff d0                	call   *%eax
  80082e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800831:	ff 4d 1c             	decl   0x1c(%ebp)
  800834:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800838:	7f e6                	jg     800820 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80083a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80083d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800842:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800845:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800848:	53                   	push   %ebx
  800849:	51                   	push   %ecx
  80084a:	52                   	push   %edx
  80084b:	50                   	push   %eax
  80084c:	e8 23 14 00 00       	call   801c74 <__umoddi3>
  800851:	83 c4 10             	add    $0x10,%esp
  800854:	05 d4 23 80 00       	add    $0x8023d4,%eax
  800859:	8a 00                	mov    (%eax),%al
  80085b:	0f be c0             	movsbl %al,%eax
  80085e:	83 ec 08             	sub    $0x8,%esp
  800861:	ff 75 0c             	pushl  0xc(%ebp)
  800864:	50                   	push   %eax
  800865:	8b 45 08             	mov    0x8(%ebp),%eax
  800868:	ff d0                	call   *%eax
  80086a:	83 c4 10             	add    $0x10,%esp
}
  80086d:	90                   	nop
  80086e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800871:	c9                   	leave  
  800872:	c3                   	ret    

00800873 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800873:	55                   	push   %ebp
  800874:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800876:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80087a:	7e 1c                	jle    800898 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80087c:	8b 45 08             	mov    0x8(%ebp),%eax
  80087f:	8b 00                	mov    (%eax),%eax
  800881:	8d 50 08             	lea    0x8(%eax),%edx
  800884:	8b 45 08             	mov    0x8(%ebp),%eax
  800887:	89 10                	mov    %edx,(%eax)
  800889:	8b 45 08             	mov    0x8(%ebp),%eax
  80088c:	8b 00                	mov    (%eax),%eax
  80088e:	83 e8 08             	sub    $0x8,%eax
  800891:	8b 50 04             	mov    0x4(%eax),%edx
  800894:	8b 00                	mov    (%eax),%eax
  800896:	eb 40                	jmp    8008d8 <getuint+0x65>
	else if (lflag)
  800898:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80089c:	74 1e                	je     8008bc <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80089e:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a1:	8b 00                	mov    (%eax),%eax
  8008a3:	8d 50 04             	lea    0x4(%eax),%edx
  8008a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a9:	89 10                	mov    %edx,(%eax)
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	8b 00                	mov    (%eax),%eax
  8008b0:	83 e8 04             	sub    $0x4,%eax
  8008b3:	8b 00                	mov    (%eax),%eax
  8008b5:	ba 00 00 00 00       	mov    $0x0,%edx
  8008ba:	eb 1c                	jmp    8008d8 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bf:	8b 00                	mov    (%eax),%eax
  8008c1:	8d 50 04             	lea    0x4(%eax),%edx
  8008c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c7:	89 10                	mov    %edx,(%eax)
  8008c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cc:	8b 00                	mov    (%eax),%eax
  8008ce:	83 e8 04             	sub    $0x4,%eax
  8008d1:	8b 00                	mov    (%eax),%eax
  8008d3:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008d8:	5d                   	pop    %ebp
  8008d9:	c3                   	ret    

008008da <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008da:	55                   	push   %ebp
  8008db:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008dd:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008e1:	7e 1c                	jle    8008ff <getint+0x25>
		return va_arg(*ap, long long);
  8008e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e6:	8b 00                	mov    (%eax),%eax
  8008e8:	8d 50 08             	lea    0x8(%eax),%edx
  8008eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ee:	89 10                	mov    %edx,(%eax)
  8008f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f3:	8b 00                	mov    (%eax),%eax
  8008f5:	83 e8 08             	sub    $0x8,%eax
  8008f8:	8b 50 04             	mov    0x4(%eax),%edx
  8008fb:	8b 00                	mov    (%eax),%eax
  8008fd:	eb 38                	jmp    800937 <getint+0x5d>
	else if (lflag)
  8008ff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800903:	74 1a                	je     80091f <getint+0x45>
		return va_arg(*ap, long);
  800905:	8b 45 08             	mov    0x8(%ebp),%eax
  800908:	8b 00                	mov    (%eax),%eax
  80090a:	8d 50 04             	lea    0x4(%eax),%edx
  80090d:	8b 45 08             	mov    0x8(%ebp),%eax
  800910:	89 10                	mov    %edx,(%eax)
  800912:	8b 45 08             	mov    0x8(%ebp),%eax
  800915:	8b 00                	mov    (%eax),%eax
  800917:	83 e8 04             	sub    $0x4,%eax
  80091a:	8b 00                	mov    (%eax),%eax
  80091c:	99                   	cltd   
  80091d:	eb 18                	jmp    800937 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80091f:	8b 45 08             	mov    0x8(%ebp),%eax
  800922:	8b 00                	mov    (%eax),%eax
  800924:	8d 50 04             	lea    0x4(%eax),%edx
  800927:	8b 45 08             	mov    0x8(%ebp),%eax
  80092a:	89 10                	mov    %edx,(%eax)
  80092c:	8b 45 08             	mov    0x8(%ebp),%eax
  80092f:	8b 00                	mov    (%eax),%eax
  800931:	83 e8 04             	sub    $0x4,%eax
  800934:	8b 00                	mov    (%eax),%eax
  800936:	99                   	cltd   
}
  800937:	5d                   	pop    %ebp
  800938:	c3                   	ret    

00800939 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800939:	55                   	push   %ebp
  80093a:	89 e5                	mov    %esp,%ebp
  80093c:	56                   	push   %esi
  80093d:	53                   	push   %ebx
  80093e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800941:	eb 17                	jmp    80095a <vprintfmt+0x21>
			if (ch == '\0')
  800943:	85 db                	test   %ebx,%ebx
  800945:	0f 84 af 03 00 00    	je     800cfa <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80094b:	83 ec 08             	sub    $0x8,%esp
  80094e:	ff 75 0c             	pushl  0xc(%ebp)
  800951:	53                   	push   %ebx
  800952:	8b 45 08             	mov    0x8(%ebp),%eax
  800955:	ff d0                	call   *%eax
  800957:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80095a:	8b 45 10             	mov    0x10(%ebp),%eax
  80095d:	8d 50 01             	lea    0x1(%eax),%edx
  800960:	89 55 10             	mov    %edx,0x10(%ebp)
  800963:	8a 00                	mov    (%eax),%al
  800965:	0f b6 d8             	movzbl %al,%ebx
  800968:	83 fb 25             	cmp    $0x25,%ebx
  80096b:	75 d6                	jne    800943 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80096d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800971:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800978:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80097f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800986:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80098d:	8b 45 10             	mov    0x10(%ebp),%eax
  800990:	8d 50 01             	lea    0x1(%eax),%edx
  800993:	89 55 10             	mov    %edx,0x10(%ebp)
  800996:	8a 00                	mov    (%eax),%al
  800998:	0f b6 d8             	movzbl %al,%ebx
  80099b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80099e:	83 f8 55             	cmp    $0x55,%eax
  8009a1:	0f 87 2b 03 00 00    	ja     800cd2 <vprintfmt+0x399>
  8009a7:	8b 04 85 f8 23 80 00 	mov    0x8023f8(,%eax,4),%eax
  8009ae:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009b0:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009b4:	eb d7                	jmp    80098d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009b6:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009ba:	eb d1                	jmp    80098d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009bc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009c3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009c6:	89 d0                	mov    %edx,%eax
  8009c8:	c1 e0 02             	shl    $0x2,%eax
  8009cb:	01 d0                	add    %edx,%eax
  8009cd:	01 c0                	add    %eax,%eax
  8009cf:	01 d8                	add    %ebx,%eax
  8009d1:	83 e8 30             	sub    $0x30,%eax
  8009d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8009da:	8a 00                	mov    (%eax),%al
  8009dc:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009df:	83 fb 2f             	cmp    $0x2f,%ebx
  8009e2:	7e 3e                	jle    800a22 <vprintfmt+0xe9>
  8009e4:	83 fb 39             	cmp    $0x39,%ebx
  8009e7:	7f 39                	jg     800a22 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009e9:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009ec:	eb d5                	jmp    8009c3 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f1:	83 c0 04             	add    $0x4,%eax
  8009f4:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fa:	83 e8 04             	sub    $0x4,%eax
  8009fd:	8b 00                	mov    (%eax),%eax
  8009ff:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a02:	eb 1f                	jmp    800a23 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a04:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a08:	79 83                	jns    80098d <vprintfmt+0x54>
				width = 0;
  800a0a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a11:	e9 77 ff ff ff       	jmp    80098d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a16:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a1d:	e9 6b ff ff ff       	jmp    80098d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a22:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a23:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a27:	0f 89 60 ff ff ff    	jns    80098d <vprintfmt+0x54>
				width = precision, precision = -1;
  800a2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a30:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a33:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a3a:	e9 4e ff ff ff       	jmp    80098d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a3f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a42:	e9 46 ff ff ff       	jmp    80098d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a47:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4a:	83 c0 04             	add    $0x4,%eax
  800a4d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a50:	8b 45 14             	mov    0x14(%ebp),%eax
  800a53:	83 e8 04             	sub    $0x4,%eax
  800a56:	8b 00                	mov    (%eax),%eax
  800a58:	83 ec 08             	sub    $0x8,%esp
  800a5b:	ff 75 0c             	pushl  0xc(%ebp)
  800a5e:	50                   	push   %eax
  800a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a62:	ff d0                	call   *%eax
  800a64:	83 c4 10             	add    $0x10,%esp
			break;
  800a67:	e9 89 02 00 00       	jmp    800cf5 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6f:	83 c0 04             	add    $0x4,%eax
  800a72:	89 45 14             	mov    %eax,0x14(%ebp)
  800a75:	8b 45 14             	mov    0x14(%ebp),%eax
  800a78:	83 e8 04             	sub    $0x4,%eax
  800a7b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a7d:	85 db                	test   %ebx,%ebx
  800a7f:	79 02                	jns    800a83 <vprintfmt+0x14a>
				err = -err;
  800a81:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a83:	83 fb 64             	cmp    $0x64,%ebx
  800a86:	7f 0b                	jg     800a93 <vprintfmt+0x15a>
  800a88:	8b 34 9d 40 22 80 00 	mov    0x802240(,%ebx,4),%esi
  800a8f:	85 f6                	test   %esi,%esi
  800a91:	75 19                	jne    800aac <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a93:	53                   	push   %ebx
  800a94:	68 e5 23 80 00       	push   $0x8023e5
  800a99:	ff 75 0c             	pushl  0xc(%ebp)
  800a9c:	ff 75 08             	pushl  0x8(%ebp)
  800a9f:	e8 5e 02 00 00       	call   800d02 <printfmt>
  800aa4:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800aa7:	e9 49 02 00 00       	jmp    800cf5 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800aac:	56                   	push   %esi
  800aad:	68 ee 23 80 00       	push   $0x8023ee
  800ab2:	ff 75 0c             	pushl  0xc(%ebp)
  800ab5:	ff 75 08             	pushl  0x8(%ebp)
  800ab8:	e8 45 02 00 00       	call   800d02 <printfmt>
  800abd:	83 c4 10             	add    $0x10,%esp
			break;
  800ac0:	e9 30 02 00 00       	jmp    800cf5 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ac5:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac8:	83 c0 04             	add    $0x4,%eax
  800acb:	89 45 14             	mov    %eax,0x14(%ebp)
  800ace:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad1:	83 e8 04             	sub    $0x4,%eax
  800ad4:	8b 30                	mov    (%eax),%esi
  800ad6:	85 f6                	test   %esi,%esi
  800ad8:	75 05                	jne    800adf <vprintfmt+0x1a6>
				p = "(null)";
  800ada:	be f1 23 80 00       	mov    $0x8023f1,%esi
			if (width > 0 && padc != '-')
  800adf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ae3:	7e 6d                	jle    800b52 <vprintfmt+0x219>
  800ae5:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ae9:	74 67                	je     800b52 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800aeb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aee:	83 ec 08             	sub    $0x8,%esp
  800af1:	50                   	push   %eax
  800af2:	56                   	push   %esi
  800af3:	e8 0c 03 00 00       	call   800e04 <strnlen>
  800af8:	83 c4 10             	add    $0x10,%esp
  800afb:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800afe:	eb 16                	jmp    800b16 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b00:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b04:	83 ec 08             	sub    $0x8,%esp
  800b07:	ff 75 0c             	pushl  0xc(%ebp)
  800b0a:	50                   	push   %eax
  800b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0e:	ff d0                	call   *%eax
  800b10:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b13:	ff 4d e4             	decl   -0x1c(%ebp)
  800b16:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b1a:	7f e4                	jg     800b00 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b1c:	eb 34                	jmp    800b52 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b1e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b22:	74 1c                	je     800b40 <vprintfmt+0x207>
  800b24:	83 fb 1f             	cmp    $0x1f,%ebx
  800b27:	7e 05                	jle    800b2e <vprintfmt+0x1f5>
  800b29:	83 fb 7e             	cmp    $0x7e,%ebx
  800b2c:	7e 12                	jle    800b40 <vprintfmt+0x207>
					putch('?', putdat);
  800b2e:	83 ec 08             	sub    $0x8,%esp
  800b31:	ff 75 0c             	pushl  0xc(%ebp)
  800b34:	6a 3f                	push   $0x3f
  800b36:	8b 45 08             	mov    0x8(%ebp),%eax
  800b39:	ff d0                	call   *%eax
  800b3b:	83 c4 10             	add    $0x10,%esp
  800b3e:	eb 0f                	jmp    800b4f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b40:	83 ec 08             	sub    $0x8,%esp
  800b43:	ff 75 0c             	pushl  0xc(%ebp)
  800b46:	53                   	push   %ebx
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	ff d0                	call   *%eax
  800b4c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b4f:	ff 4d e4             	decl   -0x1c(%ebp)
  800b52:	89 f0                	mov    %esi,%eax
  800b54:	8d 70 01             	lea    0x1(%eax),%esi
  800b57:	8a 00                	mov    (%eax),%al
  800b59:	0f be d8             	movsbl %al,%ebx
  800b5c:	85 db                	test   %ebx,%ebx
  800b5e:	74 24                	je     800b84 <vprintfmt+0x24b>
  800b60:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b64:	78 b8                	js     800b1e <vprintfmt+0x1e5>
  800b66:	ff 4d e0             	decl   -0x20(%ebp)
  800b69:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b6d:	79 af                	jns    800b1e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b6f:	eb 13                	jmp    800b84 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b71:	83 ec 08             	sub    $0x8,%esp
  800b74:	ff 75 0c             	pushl  0xc(%ebp)
  800b77:	6a 20                	push   $0x20
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	ff d0                	call   *%eax
  800b7e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b81:	ff 4d e4             	decl   -0x1c(%ebp)
  800b84:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b88:	7f e7                	jg     800b71 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b8a:	e9 66 01 00 00       	jmp    800cf5 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b8f:	83 ec 08             	sub    $0x8,%esp
  800b92:	ff 75 e8             	pushl  -0x18(%ebp)
  800b95:	8d 45 14             	lea    0x14(%ebp),%eax
  800b98:	50                   	push   %eax
  800b99:	e8 3c fd ff ff       	call   8008da <getint>
  800b9e:	83 c4 10             	add    $0x10,%esp
  800ba1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ba7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800baa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bad:	85 d2                	test   %edx,%edx
  800baf:	79 23                	jns    800bd4 <vprintfmt+0x29b>
				putch('-', putdat);
  800bb1:	83 ec 08             	sub    $0x8,%esp
  800bb4:	ff 75 0c             	pushl  0xc(%ebp)
  800bb7:	6a 2d                	push   $0x2d
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	ff d0                	call   *%eax
  800bbe:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800bc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bc4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bc7:	f7 d8                	neg    %eax
  800bc9:	83 d2 00             	adc    $0x0,%edx
  800bcc:	f7 da                	neg    %edx
  800bce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bd4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bdb:	e9 bc 00 00 00       	jmp    800c9c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800be0:	83 ec 08             	sub    $0x8,%esp
  800be3:	ff 75 e8             	pushl  -0x18(%ebp)
  800be6:	8d 45 14             	lea    0x14(%ebp),%eax
  800be9:	50                   	push   %eax
  800bea:	e8 84 fc ff ff       	call   800873 <getuint>
  800bef:	83 c4 10             	add    $0x10,%esp
  800bf2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bf8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bff:	e9 98 00 00 00       	jmp    800c9c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c04:	83 ec 08             	sub    $0x8,%esp
  800c07:	ff 75 0c             	pushl  0xc(%ebp)
  800c0a:	6a 58                	push   $0x58
  800c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0f:	ff d0                	call   *%eax
  800c11:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c14:	83 ec 08             	sub    $0x8,%esp
  800c17:	ff 75 0c             	pushl  0xc(%ebp)
  800c1a:	6a 58                	push   $0x58
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	ff d0                	call   *%eax
  800c21:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c24:	83 ec 08             	sub    $0x8,%esp
  800c27:	ff 75 0c             	pushl  0xc(%ebp)
  800c2a:	6a 58                	push   $0x58
  800c2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2f:	ff d0                	call   *%eax
  800c31:	83 c4 10             	add    $0x10,%esp
			break;
  800c34:	e9 bc 00 00 00       	jmp    800cf5 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c39:	83 ec 08             	sub    $0x8,%esp
  800c3c:	ff 75 0c             	pushl  0xc(%ebp)
  800c3f:	6a 30                	push   $0x30
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	ff d0                	call   *%eax
  800c46:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c49:	83 ec 08             	sub    $0x8,%esp
  800c4c:	ff 75 0c             	pushl  0xc(%ebp)
  800c4f:	6a 78                	push   $0x78
  800c51:	8b 45 08             	mov    0x8(%ebp),%eax
  800c54:	ff d0                	call   *%eax
  800c56:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c59:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5c:	83 c0 04             	add    $0x4,%eax
  800c5f:	89 45 14             	mov    %eax,0x14(%ebp)
  800c62:	8b 45 14             	mov    0x14(%ebp),%eax
  800c65:	83 e8 04             	sub    $0x4,%eax
  800c68:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c6d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c74:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c7b:	eb 1f                	jmp    800c9c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c7d:	83 ec 08             	sub    $0x8,%esp
  800c80:	ff 75 e8             	pushl  -0x18(%ebp)
  800c83:	8d 45 14             	lea    0x14(%ebp),%eax
  800c86:	50                   	push   %eax
  800c87:	e8 e7 fb ff ff       	call   800873 <getuint>
  800c8c:	83 c4 10             	add    $0x10,%esp
  800c8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c92:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c95:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c9c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ca0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ca3:	83 ec 04             	sub    $0x4,%esp
  800ca6:	52                   	push   %edx
  800ca7:	ff 75 e4             	pushl  -0x1c(%ebp)
  800caa:	50                   	push   %eax
  800cab:	ff 75 f4             	pushl  -0xc(%ebp)
  800cae:	ff 75 f0             	pushl  -0x10(%ebp)
  800cb1:	ff 75 0c             	pushl  0xc(%ebp)
  800cb4:	ff 75 08             	pushl  0x8(%ebp)
  800cb7:	e8 00 fb ff ff       	call   8007bc <printnum>
  800cbc:	83 c4 20             	add    $0x20,%esp
			break;
  800cbf:	eb 34                	jmp    800cf5 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800cc1:	83 ec 08             	sub    $0x8,%esp
  800cc4:	ff 75 0c             	pushl  0xc(%ebp)
  800cc7:	53                   	push   %ebx
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	ff d0                	call   *%eax
  800ccd:	83 c4 10             	add    $0x10,%esp
			break;
  800cd0:	eb 23                	jmp    800cf5 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cd2:	83 ec 08             	sub    $0x8,%esp
  800cd5:	ff 75 0c             	pushl  0xc(%ebp)
  800cd8:	6a 25                	push   $0x25
  800cda:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdd:	ff d0                	call   *%eax
  800cdf:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ce2:	ff 4d 10             	decl   0x10(%ebp)
  800ce5:	eb 03                	jmp    800cea <vprintfmt+0x3b1>
  800ce7:	ff 4d 10             	decl   0x10(%ebp)
  800cea:	8b 45 10             	mov    0x10(%ebp),%eax
  800ced:	48                   	dec    %eax
  800cee:	8a 00                	mov    (%eax),%al
  800cf0:	3c 25                	cmp    $0x25,%al
  800cf2:	75 f3                	jne    800ce7 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800cf4:	90                   	nop
		}
	}
  800cf5:	e9 47 fc ff ff       	jmp    800941 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800cfa:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800cfb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cfe:	5b                   	pop    %ebx
  800cff:	5e                   	pop    %esi
  800d00:	5d                   	pop    %ebp
  800d01:	c3                   	ret    

00800d02 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d02:	55                   	push   %ebp
  800d03:	89 e5                	mov    %esp,%ebp
  800d05:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d08:	8d 45 10             	lea    0x10(%ebp),%eax
  800d0b:	83 c0 04             	add    $0x4,%eax
  800d0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d11:	8b 45 10             	mov    0x10(%ebp),%eax
  800d14:	ff 75 f4             	pushl  -0xc(%ebp)
  800d17:	50                   	push   %eax
  800d18:	ff 75 0c             	pushl  0xc(%ebp)
  800d1b:	ff 75 08             	pushl  0x8(%ebp)
  800d1e:	e8 16 fc ff ff       	call   800939 <vprintfmt>
  800d23:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d26:	90                   	nop
  800d27:	c9                   	leave  
  800d28:	c3                   	ret    

00800d29 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d29:	55                   	push   %ebp
  800d2a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2f:	8b 40 08             	mov    0x8(%eax),%eax
  800d32:	8d 50 01             	lea    0x1(%eax),%edx
  800d35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d38:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3e:	8b 10                	mov    (%eax),%edx
  800d40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d43:	8b 40 04             	mov    0x4(%eax),%eax
  800d46:	39 c2                	cmp    %eax,%edx
  800d48:	73 12                	jae    800d5c <sprintputch+0x33>
		*b->buf++ = ch;
  800d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4d:	8b 00                	mov    (%eax),%eax
  800d4f:	8d 48 01             	lea    0x1(%eax),%ecx
  800d52:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d55:	89 0a                	mov    %ecx,(%edx)
  800d57:	8b 55 08             	mov    0x8(%ebp),%edx
  800d5a:	88 10                	mov    %dl,(%eax)
}
  800d5c:	90                   	nop
  800d5d:	5d                   	pop    %ebp
  800d5e:	c3                   	ret    

00800d5f <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d5f:	55                   	push   %ebp
  800d60:	89 e5                	mov    %esp,%ebp
  800d62:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	01 d0                	add    %edx,%eax
  800d76:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d80:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d84:	74 06                	je     800d8c <vsnprintf+0x2d>
  800d86:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d8a:	7f 07                	jg     800d93 <vsnprintf+0x34>
		return -E_INVAL;
  800d8c:	b8 03 00 00 00       	mov    $0x3,%eax
  800d91:	eb 20                	jmp    800db3 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d93:	ff 75 14             	pushl  0x14(%ebp)
  800d96:	ff 75 10             	pushl  0x10(%ebp)
  800d99:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d9c:	50                   	push   %eax
  800d9d:	68 29 0d 80 00       	push   $0x800d29
  800da2:	e8 92 fb ff ff       	call   800939 <vprintfmt>
  800da7:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800daa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800dad:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800db0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800db3:	c9                   	leave  
  800db4:	c3                   	ret    

00800db5 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800db5:	55                   	push   %ebp
  800db6:	89 e5                	mov    %esp,%ebp
  800db8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800dbb:	8d 45 10             	lea    0x10(%ebp),%eax
  800dbe:	83 c0 04             	add    $0x4,%eax
  800dc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800dc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc7:	ff 75 f4             	pushl  -0xc(%ebp)
  800dca:	50                   	push   %eax
  800dcb:	ff 75 0c             	pushl  0xc(%ebp)
  800dce:	ff 75 08             	pushl  0x8(%ebp)
  800dd1:	e8 89 ff ff ff       	call   800d5f <vsnprintf>
  800dd6:	83 c4 10             	add    $0x10,%esp
  800dd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ddc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ddf:	c9                   	leave  
  800de0:	c3                   	ret    

00800de1 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800de1:	55                   	push   %ebp
  800de2:	89 e5                	mov    %esp,%ebp
  800de4:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800de7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dee:	eb 06                	jmp    800df6 <strlen+0x15>
		n++;
  800df0:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800df3:	ff 45 08             	incl   0x8(%ebp)
  800df6:	8b 45 08             	mov    0x8(%ebp),%eax
  800df9:	8a 00                	mov    (%eax),%al
  800dfb:	84 c0                	test   %al,%al
  800dfd:	75 f1                	jne    800df0 <strlen+0xf>
		n++;
	return n;
  800dff:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e02:	c9                   	leave  
  800e03:	c3                   	ret    

00800e04 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e04:	55                   	push   %ebp
  800e05:	89 e5                	mov    %esp,%ebp
  800e07:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e0a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e11:	eb 09                	jmp    800e1c <strnlen+0x18>
		n++;
  800e13:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e16:	ff 45 08             	incl   0x8(%ebp)
  800e19:	ff 4d 0c             	decl   0xc(%ebp)
  800e1c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e20:	74 09                	je     800e2b <strnlen+0x27>
  800e22:	8b 45 08             	mov    0x8(%ebp),%eax
  800e25:	8a 00                	mov    (%eax),%al
  800e27:	84 c0                	test   %al,%al
  800e29:	75 e8                	jne    800e13 <strnlen+0xf>
		n++;
	return n;
  800e2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e2e:	c9                   	leave  
  800e2f:	c3                   	ret    

00800e30 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e30:	55                   	push   %ebp
  800e31:	89 e5                	mov    %esp,%ebp
  800e33:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e36:	8b 45 08             	mov    0x8(%ebp),%eax
  800e39:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e3c:	90                   	nop
  800e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e40:	8d 50 01             	lea    0x1(%eax),%edx
  800e43:	89 55 08             	mov    %edx,0x8(%ebp)
  800e46:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e49:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e4c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e4f:	8a 12                	mov    (%edx),%dl
  800e51:	88 10                	mov    %dl,(%eax)
  800e53:	8a 00                	mov    (%eax),%al
  800e55:	84 c0                	test   %al,%al
  800e57:	75 e4                	jne    800e3d <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e59:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e5c:	c9                   	leave  
  800e5d:	c3                   	ret    

00800e5e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e5e:	55                   	push   %ebp
  800e5f:	89 e5                	mov    %esp,%ebp
  800e61:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e6a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e71:	eb 1f                	jmp    800e92 <strncpy+0x34>
		*dst++ = *src;
  800e73:	8b 45 08             	mov    0x8(%ebp),%eax
  800e76:	8d 50 01             	lea    0x1(%eax),%edx
  800e79:	89 55 08             	mov    %edx,0x8(%ebp)
  800e7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e7f:	8a 12                	mov    (%edx),%dl
  800e81:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e86:	8a 00                	mov    (%eax),%al
  800e88:	84 c0                	test   %al,%al
  800e8a:	74 03                	je     800e8f <strncpy+0x31>
			src++;
  800e8c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e8f:	ff 45 fc             	incl   -0x4(%ebp)
  800e92:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e95:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e98:	72 d9                	jb     800e73 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e9a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e9d:	c9                   	leave  
  800e9e:	c3                   	ret    

00800e9f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e9f:	55                   	push   %ebp
  800ea0:	89 e5                	mov    %esp,%ebp
  800ea2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800eab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eaf:	74 30                	je     800ee1 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800eb1:	eb 16                	jmp    800ec9 <strlcpy+0x2a>
			*dst++ = *src++;
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb6:	8d 50 01             	lea    0x1(%eax),%edx
  800eb9:	89 55 08             	mov    %edx,0x8(%ebp)
  800ebc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ebf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ec2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ec5:	8a 12                	mov    (%edx),%dl
  800ec7:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ec9:	ff 4d 10             	decl   0x10(%ebp)
  800ecc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed0:	74 09                	je     800edb <strlcpy+0x3c>
  800ed2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed5:	8a 00                	mov    (%eax),%al
  800ed7:	84 c0                	test   %al,%al
  800ed9:	75 d8                	jne    800eb3 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800edb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ede:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ee1:	8b 55 08             	mov    0x8(%ebp),%edx
  800ee4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee7:	29 c2                	sub    %eax,%edx
  800ee9:	89 d0                	mov    %edx,%eax
}
  800eeb:	c9                   	leave  
  800eec:	c3                   	ret    

00800eed <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800eed:	55                   	push   %ebp
  800eee:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ef0:	eb 06                	jmp    800ef8 <strcmp+0xb>
		p++, q++;
  800ef2:	ff 45 08             	incl   0x8(%ebp)
  800ef5:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  800efb:	8a 00                	mov    (%eax),%al
  800efd:	84 c0                	test   %al,%al
  800eff:	74 0e                	je     800f0f <strcmp+0x22>
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	8a 10                	mov    (%eax),%dl
  800f06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f09:	8a 00                	mov    (%eax),%al
  800f0b:	38 c2                	cmp    %al,%dl
  800f0d:	74 e3                	je     800ef2 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	8a 00                	mov    (%eax),%al
  800f14:	0f b6 d0             	movzbl %al,%edx
  800f17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	0f b6 c0             	movzbl %al,%eax
  800f1f:	29 c2                	sub    %eax,%edx
  800f21:	89 d0                	mov    %edx,%eax
}
  800f23:	5d                   	pop    %ebp
  800f24:	c3                   	ret    

00800f25 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f25:	55                   	push   %ebp
  800f26:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f28:	eb 09                	jmp    800f33 <strncmp+0xe>
		n--, p++, q++;
  800f2a:	ff 4d 10             	decl   0x10(%ebp)
  800f2d:	ff 45 08             	incl   0x8(%ebp)
  800f30:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f33:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f37:	74 17                	je     800f50 <strncmp+0x2b>
  800f39:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3c:	8a 00                	mov    (%eax),%al
  800f3e:	84 c0                	test   %al,%al
  800f40:	74 0e                	je     800f50 <strncmp+0x2b>
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	8a 10                	mov    (%eax),%dl
  800f47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4a:	8a 00                	mov    (%eax),%al
  800f4c:	38 c2                	cmp    %al,%dl
  800f4e:	74 da                	je     800f2a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f50:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f54:	75 07                	jne    800f5d <strncmp+0x38>
		return 0;
  800f56:	b8 00 00 00 00       	mov    $0x0,%eax
  800f5b:	eb 14                	jmp    800f71 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	8a 00                	mov    (%eax),%al
  800f62:	0f b6 d0             	movzbl %al,%edx
  800f65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f68:	8a 00                	mov    (%eax),%al
  800f6a:	0f b6 c0             	movzbl %al,%eax
  800f6d:	29 c2                	sub    %eax,%edx
  800f6f:	89 d0                	mov    %edx,%eax
}
  800f71:	5d                   	pop    %ebp
  800f72:	c3                   	ret    

00800f73 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f73:	55                   	push   %ebp
  800f74:	89 e5                	mov    %esp,%ebp
  800f76:	83 ec 04             	sub    $0x4,%esp
  800f79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f7f:	eb 12                	jmp    800f93 <strchr+0x20>
		if (*s == c)
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	8a 00                	mov    (%eax),%al
  800f86:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f89:	75 05                	jne    800f90 <strchr+0x1d>
			return (char *) s;
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	eb 11                	jmp    800fa1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f90:	ff 45 08             	incl   0x8(%ebp)
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	84 c0                	test   %al,%al
  800f9a:	75 e5                	jne    800f81 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f9c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fa1:	c9                   	leave  
  800fa2:	c3                   	ret    

00800fa3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800fa3:	55                   	push   %ebp
  800fa4:	89 e5                	mov    %esp,%ebp
  800fa6:	83 ec 04             	sub    $0x4,%esp
  800fa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fac:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800faf:	eb 0d                	jmp    800fbe <strfind+0x1b>
		if (*s == c)
  800fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb4:	8a 00                	mov    (%eax),%al
  800fb6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fb9:	74 0e                	je     800fc9 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fbb:	ff 45 08             	incl   0x8(%ebp)
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	8a 00                	mov    (%eax),%al
  800fc3:	84 c0                	test   %al,%al
  800fc5:	75 ea                	jne    800fb1 <strfind+0xe>
  800fc7:	eb 01                	jmp    800fca <strfind+0x27>
		if (*s == c)
			break;
  800fc9:	90                   	nop
	return (char *) s;
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fcd:	c9                   	leave  
  800fce:	c3                   	ret    

00800fcf <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800fcf:	55                   	push   %ebp
  800fd0:	89 e5                	mov    %esp,%ebp
  800fd2:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800fdb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fde:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800fe1:	eb 0e                	jmp    800ff1 <memset+0x22>
		*p++ = c;
  800fe3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe6:	8d 50 01             	lea    0x1(%eax),%edx
  800fe9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fec:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fef:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ff1:	ff 4d f8             	decl   -0x8(%ebp)
  800ff4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ff8:	79 e9                	jns    800fe3 <memset+0x14>
		*p++ = c;

	return v;
  800ffa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ffd:	c9                   	leave  
  800ffe:	c3                   	ret    

00800fff <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fff:	55                   	push   %ebp
  801000:	89 e5                	mov    %esp,%ebp
  801002:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801005:	8b 45 0c             	mov    0xc(%ebp),%eax
  801008:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80100b:	8b 45 08             	mov    0x8(%ebp),%eax
  80100e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801011:	eb 16                	jmp    801029 <memcpy+0x2a>
		*d++ = *s++;
  801013:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801016:	8d 50 01             	lea    0x1(%eax),%edx
  801019:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80101c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80101f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801022:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801025:	8a 12                	mov    (%edx),%dl
  801027:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801029:	8b 45 10             	mov    0x10(%ebp),%eax
  80102c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80102f:	89 55 10             	mov    %edx,0x10(%ebp)
  801032:	85 c0                	test   %eax,%eax
  801034:	75 dd                	jne    801013 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801039:	c9                   	leave  
  80103a:	c3                   	ret    

0080103b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80103b:	55                   	push   %ebp
  80103c:	89 e5                	mov    %esp,%ebp
  80103e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801041:	8b 45 0c             	mov    0xc(%ebp),%eax
  801044:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80104d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801050:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801053:	73 50                	jae    8010a5 <memmove+0x6a>
  801055:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801058:	8b 45 10             	mov    0x10(%ebp),%eax
  80105b:	01 d0                	add    %edx,%eax
  80105d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801060:	76 43                	jbe    8010a5 <memmove+0x6a>
		s += n;
  801062:	8b 45 10             	mov    0x10(%ebp),%eax
  801065:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801068:	8b 45 10             	mov    0x10(%ebp),%eax
  80106b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80106e:	eb 10                	jmp    801080 <memmove+0x45>
			*--d = *--s;
  801070:	ff 4d f8             	decl   -0x8(%ebp)
  801073:	ff 4d fc             	decl   -0x4(%ebp)
  801076:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801079:	8a 10                	mov    (%eax),%dl
  80107b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80107e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801080:	8b 45 10             	mov    0x10(%ebp),%eax
  801083:	8d 50 ff             	lea    -0x1(%eax),%edx
  801086:	89 55 10             	mov    %edx,0x10(%ebp)
  801089:	85 c0                	test   %eax,%eax
  80108b:	75 e3                	jne    801070 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80108d:	eb 23                	jmp    8010b2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80108f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801092:	8d 50 01             	lea    0x1(%eax),%edx
  801095:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801098:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80109b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80109e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010a1:	8a 12                	mov    (%edx),%dl
  8010a3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ab:	89 55 10             	mov    %edx,0x10(%ebp)
  8010ae:	85 c0                	test   %eax,%eax
  8010b0:	75 dd                	jne    80108f <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010b2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010b5:	c9                   	leave  
  8010b6:	c3                   	ret    

008010b7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010b7:	55                   	push   %ebp
  8010b8:	89 e5                	mov    %esp,%ebp
  8010ba:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010c9:	eb 2a                	jmp    8010f5 <memcmp+0x3e>
		if (*s1 != *s2)
  8010cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ce:	8a 10                	mov    (%eax),%dl
  8010d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d3:	8a 00                	mov    (%eax),%al
  8010d5:	38 c2                	cmp    %al,%dl
  8010d7:	74 16                	je     8010ef <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010dc:	8a 00                	mov    (%eax),%al
  8010de:	0f b6 d0             	movzbl %al,%edx
  8010e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e4:	8a 00                	mov    (%eax),%al
  8010e6:	0f b6 c0             	movzbl %al,%eax
  8010e9:	29 c2                	sub    %eax,%edx
  8010eb:	89 d0                	mov    %edx,%eax
  8010ed:	eb 18                	jmp    801107 <memcmp+0x50>
		s1++, s2++;
  8010ef:	ff 45 fc             	incl   -0x4(%ebp)
  8010f2:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010fb:	89 55 10             	mov    %edx,0x10(%ebp)
  8010fe:	85 c0                	test   %eax,%eax
  801100:	75 c9                	jne    8010cb <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801102:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801107:	c9                   	leave  
  801108:	c3                   	ret    

00801109 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801109:	55                   	push   %ebp
  80110a:	89 e5                	mov    %esp,%ebp
  80110c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80110f:	8b 55 08             	mov    0x8(%ebp),%edx
  801112:	8b 45 10             	mov    0x10(%ebp),%eax
  801115:	01 d0                	add    %edx,%eax
  801117:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80111a:	eb 15                	jmp    801131 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80111c:	8b 45 08             	mov    0x8(%ebp),%eax
  80111f:	8a 00                	mov    (%eax),%al
  801121:	0f b6 d0             	movzbl %al,%edx
  801124:	8b 45 0c             	mov    0xc(%ebp),%eax
  801127:	0f b6 c0             	movzbl %al,%eax
  80112a:	39 c2                	cmp    %eax,%edx
  80112c:	74 0d                	je     80113b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80112e:	ff 45 08             	incl   0x8(%ebp)
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801137:	72 e3                	jb     80111c <memfind+0x13>
  801139:	eb 01                	jmp    80113c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80113b:	90                   	nop
	return (void *) s;
  80113c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80113f:	c9                   	leave  
  801140:	c3                   	ret    

00801141 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801141:	55                   	push   %ebp
  801142:	89 e5                	mov    %esp,%ebp
  801144:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801147:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80114e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801155:	eb 03                	jmp    80115a <strtol+0x19>
		s++;
  801157:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80115a:	8b 45 08             	mov    0x8(%ebp),%eax
  80115d:	8a 00                	mov    (%eax),%al
  80115f:	3c 20                	cmp    $0x20,%al
  801161:	74 f4                	je     801157 <strtol+0x16>
  801163:	8b 45 08             	mov    0x8(%ebp),%eax
  801166:	8a 00                	mov    (%eax),%al
  801168:	3c 09                	cmp    $0x9,%al
  80116a:	74 eb                	je     801157 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80116c:	8b 45 08             	mov    0x8(%ebp),%eax
  80116f:	8a 00                	mov    (%eax),%al
  801171:	3c 2b                	cmp    $0x2b,%al
  801173:	75 05                	jne    80117a <strtol+0x39>
		s++;
  801175:	ff 45 08             	incl   0x8(%ebp)
  801178:	eb 13                	jmp    80118d <strtol+0x4c>
	else if (*s == '-')
  80117a:	8b 45 08             	mov    0x8(%ebp),%eax
  80117d:	8a 00                	mov    (%eax),%al
  80117f:	3c 2d                	cmp    $0x2d,%al
  801181:	75 0a                	jne    80118d <strtol+0x4c>
		s++, neg = 1;
  801183:	ff 45 08             	incl   0x8(%ebp)
  801186:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80118d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801191:	74 06                	je     801199 <strtol+0x58>
  801193:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801197:	75 20                	jne    8011b9 <strtol+0x78>
  801199:	8b 45 08             	mov    0x8(%ebp),%eax
  80119c:	8a 00                	mov    (%eax),%al
  80119e:	3c 30                	cmp    $0x30,%al
  8011a0:	75 17                	jne    8011b9 <strtol+0x78>
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	40                   	inc    %eax
  8011a6:	8a 00                	mov    (%eax),%al
  8011a8:	3c 78                	cmp    $0x78,%al
  8011aa:	75 0d                	jne    8011b9 <strtol+0x78>
		s += 2, base = 16;
  8011ac:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011b0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011b7:	eb 28                	jmp    8011e1 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011bd:	75 15                	jne    8011d4 <strtol+0x93>
  8011bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c2:	8a 00                	mov    (%eax),%al
  8011c4:	3c 30                	cmp    $0x30,%al
  8011c6:	75 0c                	jne    8011d4 <strtol+0x93>
		s++, base = 8;
  8011c8:	ff 45 08             	incl   0x8(%ebp)
  8011cb:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011d2:	eb 0d                	jmp    8011e1 <strtol+0xa0>
	else if (base == 0)
  8011d4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d8:	75 07                	jne    8011e1 <strtol+0xa0>
		base = 10;
  8011da:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	8a 00                	mov    (%eax),%al
  8011e6:	3c 2f                	cmp    $0x2f,%al
  8011e8:	7e 19                	jle    801203 <strtol+0xc2>
  8011ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ed:	8a 00                	mov    (%eax),%al
  8011ef:	3c 39                	cmp    $0x39,%al
  8011f1:	7f 10                	jg     801203 <strtol+0xc2>
			dig = *s - '0';
  8011f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f6:	8a 00                	mov    (%eax),%al
  8011f8:	0f be c0             	movsbl %al,%eax
  8011fb:	83 e8 30             	sub    $0x30,%eax
  8011fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801201:	eb 42                	jmp    801245 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801203:	8b 45 08             	mov    0x8(%ebp),%eax
  801206:	8a 00                	mov    (%eax),%al
  801208:	3c 60                	cmp    $0x60,%al
  80120a:	7e 19                	jle    801225 <strtol+0xe4>
  80120c:	8b 45 08             	mov    0x8(%ebp),%eax
  80120f:	8a 00                	mov    (%eax),%al
  801211:	3c 7a                	cmp    $0x7a,%al
  801213:	7f 10                	jg     801225 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801215:	8b 45 08             	mov    0x8(%ebp),%eax
  801218:	8a 00                	mov    (%eax),%al
  80121a:	0f be c0             	movsbl %al,%eax
  80121d:	83 e8 57             	sub    $0x57,%eax
  801220:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801223:	eb 20                	jmp    801245 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	8a 00                	mov    (%eax),%al
  80122a:	3c 40                	cmp    $0x40,%al
  80122c:	7e 39                	jle    801267 <strtol+0x126>
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	8a 00                	mov    (%eax),%al
  801233:	3c 5a                	cmp    $0x5a,%al
  801235:	7f 30                	jg     801267 <strtol+0x126>
			dig = *s - 'A' + 10;
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	8a 00                	mov    (%eax),%al
  80123c:	0f be c0             	movsbl %al,%eax
  80123f:	83 e8 37             	sub    $0x37,%eax
  801242:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801245:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801248:	3b 45 10             	cmp    0x10(%ebp),%eax
  80124b:	7d 19                	jge    801266 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80124d:	ff 45 08             	incl   0x8(%ebp)
  801250:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801253:	0f af 45 10          	imul   0x10(%ebp),%eax
  801257:	89 c2                	mov    %eax,%edx
  801259:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80125c:	01 d0                	add    %edx,%eax
  80125e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801261:	e9 7b ff ff ff       	jmp    8011e1 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801266:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801267:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80126b:	74 08                	je     801275 <strtol+0x134>
		*endptr = (char *) s;
  80126d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801270:	8b 55 08             	mov    0x8(%ebp),%edx
  801273:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801275:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801279:	74 07                	je     801282 <strtol+0x141>
  80127b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80127e:	f7 d8                	neg    %eax
  801280:	eb 03                	jmp    801285 <strtol+0x144>
  801282:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801285:	c9                   	leave  
  801286:	c3                   	ret    

00801287 <ltostr>:

void
ltostr(long value, char *str)
{
  801287:	55                   	push   %ebp
  801288:	89 e5                	mov    %esp,%ebp
  80128a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80128d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801294:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80129b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80129f:	79 13                	jns    8012b4 <ltostr+0x2d>
	{
		neg = 1;
  8012a1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ab:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012ae:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012b1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012bc:	99                   	cltd   
  8012bd:	f7 f9                	idiv   %ecx
  8012bf:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c5:	8d 50 01             	lea    0x1(%eax),%edx
  8012c8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012cb:	89 c2                	mov    %eax,%edx
  8012cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d0:	01 d0                	add    %edx,%eax
  8012d2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012d5:	83 c2 30             	add    $0x30,%edx
  8012d8:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012da:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012dd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012e2:	f7 e9                	imul   %ecx
  8012e4:	c1 fa 02             	sar    $0x2,%edx
  8012e7:	89 c8                	mov    %ecx,%eax
  8012e9:	c1 f8 1f             	sar    $0x1f,%eax
  8012ec:	29 c2                	sub    %eax,%edx
  8012ee:	89 d0                	mov    %edx,%eax
  8012f0:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012f6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012fb:	f7 e9                	imul   %ecx
  8012fd:	c1 fa 02             	sar    $0x2,%edx
  801300:	89 c8                	mov    %ecx,%eax
  801302:	c1 f8 1f             	sar    $0x1f,%eax
  801305:	29 c2                	sub    %eax,%edx
  801307:	89 d0                	mov    %edx,%eax
  801309:	c1 e0 02             	shl    $0x2,%eax
  80130c:	01 d0                	add    %edx,%eax
  80130e:	01 c0                	add    %eax,%eax
  801310:	29 c1                	sub    %eax,%ecx
  801312:	89 ca                	mov    %ecx,%edx
  801314:	85 d2                	test   %edx,%edx
  801316:	75 9c                	jne    8012b4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801318:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80131f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801322:	48                   	dec    %eax
  801323:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801326:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80132a:	74 3d                	je     801369 <ltostr+0xe2>
		start = 1 ;
  80132c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801333:	eb 34                	jmp    801369 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801335:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801338:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133b:	01 d0                	add    %edx,%eax
  80133d:	8a 00                	mov    (%eax),%al
  80133f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801342:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801345:	8b 45 0c             	mov    0xc(%ebp),%eax
  801348:	01 c2                	add    %eax,%edx
  80134a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80134d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801350:	01 c8                	add    %ecx,%eax
  801352:	8a 00                	mov    (%eax),%al
  801354:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801356:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801359:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135c:	01 c2                	add    %eax,%edx
  80135e:	8a 45 eb             	mov    -0x15(%ebp),%al
  801361:	88 02                	mov    %al,(%edx)
		start++ ;
  801363:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801366:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801369:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80136c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80136f:	7c c4                	jl     801335 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801371:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801374:	8b 45 0c             	mov    0xc(%ebp),%eax
  801377:	01 d0                	add    %edx,%eax
  801379:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80137c:	90                   	nop
  80137d:	c9                   	leave  
  80137e:	c3                   	ret    

0080137f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
  801382:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801385:	ff 75 08             	pushl  0x8(%ebp)
  801388:	e8 54 fa ff ff       	call   800de1 <strlen>
  80138d:	83 c4 04             	add    $0x4,%esp
  801390:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801393:	ff 75 0c             	pushl  0xc(%ebp)
  801396:	e8 46 fa ff ff       	call   800de1 <strlen>
  80139b:	83 c4 04             	add    $0x4,%esp
  80139e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013af:	eb 17                	jmp    8013c8 <strcconcat+0x49>
		final[s] = str1[s] ;
  8013b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b7:	01 c2                	add    %eax,%edx
  8013b9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bf:	01 c8                	add    %ecx,%eax
  8013c1:	8a 00                	mov    (%eax),%al
  8013c3:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013c5:	ff 45 fc             	incl   -0x4(%ebp)
  8013c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013cb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013ce:	7c e1                	jl     8013b1 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013d0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013d7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013de:	eb 1f                	jmp    8013ff <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013e3:	8d 50 01             	lea    0x1(%eax),%edx
  8013e6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013e9:	89 c2                	mov    %eax,%edx
  8013eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ee:	01 c2                	add    %eax,%edx
  8013f0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f6:	01 c8                	add    %ecx,%eax
  8013f8:	8a 00                	mov    (%eax),%al
  8013fa:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013fc:	ff 45 f8             	incl   -0x8(%ebp)
  8013ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801402:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801405:	7c d9                	jl     8013e0 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801407:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80140a:	8b 45 10             	mov    0x10(%ebp),%eax
  80140d:	01 d0                	add    %edx,%eax
  80140f:	c6 00 00             	movb   $0x0,(%eax)
}
  801412:	90                   	nop
  801413:	c9                   	leave  
  801414:	c3                   	ret    

00801415 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801415:	55                   	push   %ebp
  801416:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801418:	8b 45 14             	mov    0x14(%ebp),%eax
  80141b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801421:	8b 45 14             	mov    0x14(%ebp),%eax
  801424:	8b 00                	mov    (%eax),%eax
  801426:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80142d:	8b 45 10             	mov    0x10(%ebp),%eax
  801430:	01 d0                	add    %edx,%eax
  801432:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801438:	eb 0c                	jmp    801446 <strsplit+0x31>
			*string++ = 0;
  80143a:	8b 45 08             	mov    0x8(%ebp),%eax
  80143d:	8d 50 01             	lea    0x1(%eax),%edx
  801440:	89 55 08             	mov    %edx,0x8(%ebp)
  801443:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	8a 00                	mov    (%eax),%al
  80144b:	84 c0                	test   %al,%al
  80144d:	74 18                	je     801467 <strsplit+0x52>
  80144f:	8b 45 08             	mov    0x8(%ebp),%eax
  801452:	8a 00                	mov    (%eax),%al
  801454:	0f be c0             	movsbl %al,%eax
  801457:	50                   	push   %eax
  801458:	ff 75 0c             	pushl  0xc(%ebp)
  80145b:	e8 13 fb ff ff       	call   800f73 <strchr>
  801460:	83 c4 08             	add    $0x8,%esp
  801463:	85 c0                	test   %eax,%eax
  801465:	75 d3                	jne    80143a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801467:	8b 45 08             	mov    0x8(%ebp),%eax
  80146a:	8a 00                	mov    (%eax),%al
  80146c:	84 c0                	test   %al,%al
  80146e:	74 5a                	je     8014ca <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801470:	8b 45 14             	mov    0x14(%ebp),%eax
  801473:	8b 00                	mov    (%eax),%eax
  801475:	83 f8 0f             	cmp    $0xf,%eax
  801478:	75 07                	jne    801481 <strsplit+0x6c>
		{
			return 0;
  80147a:	b8 00 00 00 00       	mov    $0x0,%eax
  80147f:	eb 66                	jmp    8014e7 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801481:	8b 45 14             	mov    0x14(%ebp),%eax
  801484:	8b 00                	mov    (%eax),%eax
  801486:	8d 48 01             	lea    0x1(%eax),%ecx
  801489:	8b 55 14             	mov    0x14(%ebp),%edx
  80148c:	89 0a                	mov    %ecx,(%edx)
  80148e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801495:	8b 45 10             	mov    0x10(%ebp),%eax
  801498:	01 c2                	add    %eax,%edx
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80149f:	eb 03                	jmp    8014a4 <strsplit+0x8f>
			string++;
  8014a1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a7:	8a 00                	mov    (%eax),%al
  8014a9:	84 c0                	test   %al,%al
  8014ab:	74 8b                	je     801438 <strsplit+0x23>
  8014ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b0:	8a 00                	mov    (%eax),%al
  8014b2:	0f be c0             	movsbl %al,%eax
  8014b5:	50                   	push   %eax
  8014b6:	ff 75 0c             	pushl  0xc(%ebp)
  8014b9:	e8 b5 fa ff ff       	call   800f73 <strchr>
  8014be:	83 c4 08             	add    $0x8,%esp
  8014c1:	85 c0                	test   %eax,%eax
  8014c3:	74 dc                	je     8014a1 <strsplit+0x8c>
			string++;
	}
  8014c5:	e9 6e ff ff ff       	jmp    801438 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014ca:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ce:	8b 00                	mov    (%eax),%eax
  8014d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014da:	01 d0                	add    %edx,%eax
  8014dc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014e2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	57                   	push   %edi
  8014ed:	56                   	push   %esi
  8014ee:	53                   	push   %ebx
  8014ef:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014fb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014fe:	8b 7d 18             	mov    0x18(%ebp),%edi
  801501:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801504:	cd 30                	int    $0x30
  801506:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801509:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80150c:	83 c4 10             	add    $0x10,%esp
  80150f:	5b                   	pop    %ebx
  801510:	5e                   	pop    %esi
  801511:	5f                   	pop    %edi
  801512:	5d                   	pop    %ebp
  801513:	c3                   	ret    

00801514 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801514:	55                   	push   %ebp
  801515:	89 e5                	mov    %esp,%ebp
  801517:	83 ec 04             	sub    $0x4,%esp
  80151a:	8b 45 10             	mov    0x10(%ebp),%eax
  80151d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801520:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801524:	8b 45 08             	mov    0x8(%ebp),%eax
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	52                   	push   %edx
  80152c:	ff 75 0c             	pushl  0xc(%ebp)
  80152f:	50                   	push   %eax
  801530:	6a 00                	push   $0x0
  801532:	e8 b2 ff ff ff       	call   8014e9 <syscall>
  801537:	83 c4 18             	add    $0x18,%esp
}
  80153a:	90                   	nop
  80153b:	c9                   	leave  
  80153c:	c3                   	ret    

0080153d <sys_cgetc>:

int
sys_cgetc(void)
{
  80153d:	55                   	push   %ebp
  80153e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 01                	push   $0x1
  80154c:	e8 98 ff ff ff       	call   8014e9 <syscall>
  801551:	83 c4 18             	add    $0x18,%esp
}
  801554:	c9                   	leave  
  801555:	c3                   	ret    

00801556 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801556:	55                   	push   %ebp
  801557:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801559:	8b 45 08             	mov    0x8(%ebp),%eax
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	50                   	push   %eax
  801565:	6a 05                	push   $0x5
  801567:	e8 7d ff ff ff       	call   8014e9 <syscall>
  80156c:	83 c4 18             	add    $0x18,%esp
}
  80156f:	c9                   	leave  
  801570:	c3                   	ret    

00801571 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801571:	55                   	push   %ebp
  801572:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 02                	push   $0x2
  801580:	e8 64 ff ff ff       	call   8014e9 <syscall>
  801585:	83 c4 18             	add    $0x18,%esp
}
  801588:	c9                   	leave  
  801589:	c3                   	ret    

0080158a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 03                	push   $0x3
  801599:	e8 4b ff ff ff       	call   8014e9 <syscall>
  80159e:	83 c4 18             	add    $0x18,%esp
}
  8015a1:	c9                   	leave  
  8015a2:	c3                   	ret    

008015a3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015a3:	55                   	push   %ebp
  8015a4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 04                	push   $0x4
  8015b2:	e8 32 ff ff ff       	call   8014e9 <syscall>
  8015b7:	83 c4 18             	add    $0x18,%esp
}
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <sys_env_exit>:


void sys_env_exit(void)
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 06                	push   $0x6
  8015cb:	e8 19 ff ff ff       	call   8014e9 <syscall>
  8015d0:	83 c4 18             	add    $0x18,%esp
}
  8015d3:	90                   	nop
  8015d4:	c9                   	leave  
  8015d5:	c3                   	ret    

008015d6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	52                   	push   %edx
  8015e6:	50                   	push   %eax
  8015e7:	6a 07                	push   $0x7
  8015e9:	e8 fb fe ff ff       	call   8014e9 <syscall>
  8015ee:	83 c4 18             	add    $0x18,%esp
}
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
  8015f6:	56                   	push   %esi
  8015f7:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015f8:	8b 75 18             	mov    0x18(%ebp),%esi
  8015fb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015fe:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801601:	8b 55 0c             	mov    0xc(%ebp),%edx
  801604:	8b 45 08             	mov    0x8(%ebp),%eax
  801607:	56                   	push   %esi
  801608:	53                   	push   %ebx
  801609:	51                   	push   %ecx
  80160a:	52                   	push   %edx
  80160b:	50                   	push   %eax
  80160c:	6a 08                	push   $0x8
  80160e:	e8 d6 fe ff ff       	call   8014e9 <syscall>
  801613:	83 c4 18             	add    $0x18,%esp
}
  801616:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801619:	5b                   	pop    %ebx
  80161a:	5e                   	pop    %esi
  80161b:	5d                   	pop    %ebp
  80161c:	c3                   	ret    

0080161d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80161d:	55                   	push   %ebp
  80161e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801620:	8b 55 0c             	mov    0xc(%ebp),%edx
  801623:	8b 45 08             	mov    0x8(%ebp),%eax
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	52                   	push   %edx
  80162d:	50                   	push   %eax
  80162e:	6a 09                	push   $0x9
  801630:	e8 b4 fe ff ff       	call   8014e9 <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	ff 75 0c             	pushl  0xc(%ebp)
  801646:	ff 75 08             	pushl  0x8(%ebp)
  801649:	6a 0a                	push   $0xa
  80164b:	e8 99 fe ff ff       	call   8014e9 <syscall>
  801650:	83 c4 18             	add    $0x18,%esp
}
  801653:	c9                   	leave  
  801654:	c3                   	ret    

00801655 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801655:	55                   	push   %ebp
  801656:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 0b                	push   $0xb
  801664:	e8 80 fe ff ff       	call   8014e9 <syscall>
  801669:	83 c4 18             	add    $0x18,%esp
}
  80166c:	c9                   	leave  
  80166d:	c3                   	ret    

0080166e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80166e:	55                   	push   %ebp
  80166f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 0c                	push   $0xc
  80167d:	e8 67 fe ff ff       	call   8014e9 <syscall>
  801682:	83 c4 18             	add    $0x18,%esp
}
  801685:	c9                   	leave  
  801686:	c3                   	ret    

00801687 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801687:	55                   	push   %ebp
  801688:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 0d                	push   $0xd
  801696:	e8 4e fe ff ff       	call   8014e9 <syscall>
  80169b:	83 c4 18             	add    $0x18,%esp
}
  80169e:	c9                   	leave  
  80169f:	c3                   	ret    

008016a0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016a0:	55                   	push   %ebp
  8016a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	ff 75 0c             	pushl  0xc(%ebp)
  8016ac:	ff 75 08             	pushl  0x8(%ebp)
  8016af:	6a 11                	push   $0x11
  8016b1:	e8 33 fe ff ff       	call   8014e9 <syscall>
  8016b6:	83 c4 18             	add    $0x18,%esp
	return;
  8016b9:	90                   	nop
}
  8016ba:	c9                   	leave  
  8016bb:	c3                   	ret    

008016bc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	ff 75 0c             	pushl  0xc(%ebp)
  8016c8:	ff 75 08             	pushl  0x8(%ebp)
  8016cb:	6a 12                	push   $0x12
  8016cd:	e8 17 fe ff ff       	call   8014e9 <syscall>
  8016d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d5:	90                   	nop
}
  8016d6:	c9                   	leave  
  8016d7:	c3                   	ret    

008016d8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016d8:	55                   	push   %ebp
  8016d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 0e                	push   $0xe
  8016e7:	e8 fd fd ff ff       	call   8014e9 <syscall>
  8016ec:	83 c4 18             	add    $0x18,%esp
}
  8016ef:	c9                   	leave  
  8016f0:	c3                   	ret    

008016f1 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016f1:	55                   	push   %ebp
  8016f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	ff 75 08             	pushl  0x8(%ebp)
  8016ff:	6a 0f                	push   $0xf
  801701:	e8 e3 fd ff ff       	call   8014e9 <syscall>
  801706:	83 c4 18             	add    $0x18,%esp
}
  801709:	c9                   	leave  
  80170a:	c3                   	ret    

0080170b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80170b:	55                   	push   %ebp
  80170c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 10                	push   $0x10
  80171a:	e8 ca fd ff ff       	call   8014e9 <syscall>
  80171f:	83 c4 18             	add    $0x18,%esp
}
  801722:	90                   	nop
  801723:	c9                   	leave  
  801724:	c3                   	ret    

00801725 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801725:	55                   	push   %ebp
  801726:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 14                	push   $0x14
  801734:	e8 b0 fd ff ff       	call   8014e9 <syscall>
  801739:	83 c4 18             	add    $0x18,%esp
}
  80173c:	90                   	nop
  80173d:	c9                   	leave  
  80173e:	c3                   	ret    

0080173f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80173f:	55                   	push   %ebp
  801740:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 15                	push   $0x15
  80174e:	e8 96 fd ff ff       	call   8014e9 <syscall>
  801753:	83 c4 18             	add    $0x18,%esp
}
  801756:	90                   	nop
  801757:	c9                   	leave  
  801758:	c3                   	ret    

00801759 <sys_cputc>:


void
sys_cputc(const char c)
{
  801759:	55                   	push   %ebp
  80175a:	89 e5                	mov    %esp,%ebp
  80175c:	83 ec 04             	sub    $0x4,%esp
  80175f:	8b 45 08             	mov    0x8(%ebp),%eax
  801762:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801765:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	50                   	push   %eax
  801772:	6a 16                	push   $0x16
  801774:	e8 70 fd ff ff       	call   8014e9 <syscall>
  801779:	83 c4 18             	add    $0x18,%esp
}
  80177c:	90                   	nop
  80177d:	c9                   	leave  
  80177e:	c3                   	ret    

0080177f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80177f:	55                   	push   %ebp
  801780:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 17                	push   $0x17
  80178e:	e8 56 fd ff ff       	call   8014e9 <syscall>
  801793:	83 c4 18             	add    $0x18,%esp
}
  801796:	90                   	nop
  801797:	c9                   	leave  
  801798:	c3                   	ret    

00801799 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801799:	55                   	push   %ebp
  80179a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80179c:	8b 45 08             	mov    0x8(%ebp),%eax
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	ff 75 0c             	pushl  0xc(%ebp)
  8017a8:	50                   	push   %eax
  8017a9:	6a 18                	push   $0x18
  8017ab:	e8 39 fd ff ff       	call   8014e9 <syscall>
  8017b0:	83 c4 18             	add    $0x18,%esp
}
  8017b3:	c9                   	leave  
  8017b4:	c3                   	ret    

008017b5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8017b5:	55                   	push   %ebp
  8017b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	52                   	push   %edx
  8017c5:	50                   	push   %eax
  8017c6:	6a 1b                	push   $0x1b
  8017c8:	e8 1c fd ff ff       	call   8014e9 <syscall>
  8017cd:	83 c4 18             	add    $0x18,%esp
}
  8017d0:	c9                   	leave  
  8017d1:	c3                   	ret    

008017d2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017d2:	55                   	push   %ebp
  8017d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	52                   	push   %edx
  8017e2:	50                   	push   %eax
  8017e3:	6a 19                	push   $0x19
  8017e5:	e8 ff fc ff ff       	call   8014e9 <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	90                   	nop
  8017ee:	c9                   	leave  
  8017ef:	c3                   	ret    

008017f0 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017f0:	55                   	push   %ebp
  8017f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	52                   	push   %edx
  801800:	50                   	push   %eax
  801801:	6a 1a                	push   $0x1a
  801803:	e8 e1 fc ff ff       	call   8014e9 <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
}
  80180b:	90                   	nop
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
  801811:	83 ec 04             	sub    $0x4,%esp
  801814:	8b 45 10             	mov    0x10(%ebp),%eax
  801817:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80181a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80181d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801821:	8b 45 08             	mov    0x8(%ebp),%eax
  801824:	6a 00                	push   $0x0
  801826:	51                   	push   %ecx
  801827:	52                   	push   %edx
  801828:	ff 75 0c             	pushl  0xc(%ebp)
  80182b:	50                   	push   %eax
  80182c:	6a 1c                	push   $0x1c
  80182e:	e8 b6 fc ff ff       	call   8014e9 <syscall>
  801833:	83 c4 18             	add    $0x18,%esp
}
  801836:	c9                   	leave  
  801837:	c3                   	ret    

00801838 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801838:	55                   	push   %ebp
  801839:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80183b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	52                   	push   %edx
  801848:	50                   	push   %eax
  801849:	6a 1d                	push   $0x1d
  80184b:	e8 99 fc ff ff       	call   8014e9 <syscall>
  801850:	83 c4 18             	add    $0x18,%esp
}
  801853:	c9                   	leave  
  801854:	c3                   	ret    

00801855 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801855:	55                   	push   %ebp
  801856:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801858:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80185b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185e:	8b 45 08             	mov    0x8(%ebp),%eax
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	51                   	push   %ecx
  801866:	52                   	push   %edx
  801867:	50                   	push   %eax
  801868:	6a 1e                	push   $0x1e
  80186a:	e8 7a fc ff ff       	call   8014e9 <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
}
  801872:	c9                   	leave  
  801873:	c3                   	ret    

00801874 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801874:	55                   	push   %ebp
  801875:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801877:	8b 55 0c             	mov    0xc(%ebp),%edx
  80187a:	8b 45 08             	mov    0x8(%ebp),%eax
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	52                   	push   %edx
  801884:	50                   	push   %eax
  801885:	6a 1f                	push   $0x1f
  801887:	e8 5d fc ff ff       	call   8014e9 <syscall>
  80188c:	83 c4 18             	add    $0x18,%esp
}
  80188f:	c9                   	leave  
  801890:	c3                   	ret    

00801891 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801891:	55                   	push   %ebp
  801892:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 20                	push   $0x20
  8018a0:	e8 44 fc ff ff       	call   8014e9 <syscall>
  8018a5:	83 c4 18             	add    $0x18,%esp
}
  8018a8:	c9                   	leave  
  8018a9:	c3                   	ret    

008018aa <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8018aa:	55                   	push   %ebp
  8018ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8018ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b0:	6a 00                	push   $0x0
  8018b2:	ff 75 14             	pushl  0x14(%ebp)
  8018b5:	ff 75 10             	pushl  0x10(%ebp)
  8018b8:	ff 75 0c             	pushl  0xc(%ebp)
  8018bb:	50                   	push   %eax
  8018bc:	6a 21                	push   $0x21
  8018be:	e8 26 fc ff ff       	call   8014e9 <syscall>
  8018c3:	83 c4 18             	add    $0x18,%esp
}
  8018c6:	c9                   	leave  
  8018c7:	c3                   	ret    

008018c8 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8018c8:	55                   	push   %ebp
  8018c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	50                   	push   %eax
  8018d7:	6a 22                	push   $0x22
  8018d9:	e8 0b fc ff ff       	call   8014e9 <syscall>
  8018de:	83 c4 18             	add    $0x18,%esp
}
  8018e1:	90                   	nop
  8018e2:	c9                   	leave  
  8018e3:	c3                   	ret    

008018e4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8018e4:	55                   	push   %ebp
  8018e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8018e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	50                   	push   %eax
  8018f3:	6a 23                	push   $0x23
  8018f5:	e8 ef fb ff ff       	call   8014e9 <syscall>
  8018fa:	83 c4 18             	add    $0x18,%esp
}
  8018fd:	90                   	nop
  8018fe:	c9                   	leave  
  8018ff:	c3                   	ret    

00801900 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801900:	55                   	push   %ebp
  801901:	89 e5                	mov    %esp,%ebp
  801903:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801906:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801909:	8d 50 04             	lea    0x4(%eax),%edx
  80190c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	52                   	push   %edx
  801916:	50                   	push   %eax
  801917:	6a 24                	push   $0x24
  801919:	e8 cb fb ff ff       	call   8014e9 <syscall>
  80191e:	83 c4 18             	add    $0x18,%esp
	return result;
  801921:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801924:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801927:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80192a:	89 01                	mov    %eax,(%ecx)
  80192c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80192f:	8b 45 08             	mov    0x8(%ebp),%eax
  801932:	c9                   	leave  
  801933:	c2 04 00             	ret    $0x4

00801936 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801936:	55                   	push   %ebp
  801937:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	ff 75 10             	pushl  0x10(%ebp)
  801940:	ff 75 0c             	pushl  0xc(%ebp)
  801943:	ff 75 08             	pushl  0x8(%ebp)
  801946:	6a 13                	push   $0x13
  801948:	e8 9c fb ff ff       	call   8014e9 <syscall>
  80194d:	83 c4 18             	add    $0x18,%esp
	return ;
  801950:	90                   	nop
}
  801951:	c9                   	leave  
  801952:	c3                   	ret    

00801953 <sys_rcr2>:
uint32 sys_rcr2()
{
  801953:	55                   	push   %ebp
  801954:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	6a 25                	push   $0x25
  801962:	e8 82 fb ff ff       	call   8014e9 <syscall>
  801967:	83 c4 18             	add    $0x18,%esp
}
  80196a:	c9                   	leave  
  80196b:	c3                   	ret    

0080196c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80196c:	55                   	push   %ebp
  80196d:	89 e5                	mov    %esp,%ebp
  80196f:	83 ec 04             	sub    $0x4,%esp
  801972:	8b 45 08             	mov    0x8(%ebp),%eax
  801975:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801978:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	50                   	push   %eax
  801985:	6a 26                	push   $0x26
  801987:	e8 5d fb ff ff       	call   8014e9 <syscall>
  80198c:	83 c4 18             	add    $0x18,%esp
	return ;
  80198f:	90                   	nop
}
  801990:	c9                   	leave  
  801991:	c3                   	ret    

00801992 <rsttst>:
void rsttst()
{
  801992:	55                   	push   %ebp
  801993:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 28                	push   $0x28
  8019a1:	e8 43 fb ff ff       	call   8014e9 <syscall>
  8019a6:	83 c4 18             	add    $0x18,%esp
	return ;
  8019a9:	90                   	nop
}
  8019aa:	c9                   	leave  
  8019ab:	c3                   	ret    

008019ac <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019ac:	55                   	push   %ebp
  8019ad:	89 e5                	mov    %esp,%ebp
  8019af:	83 ec 04             	sub    $0x4,%esp
  8019b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8019b5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019b8:	8b 55 18             	mov    0x18(%ebp),%edx
  8019bb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019bf:	52                   	push   %edx
  8019c0:	50                   	push   %eax
  8019c1:	ff 75 10             	pushl  0x10(%ebp)
  8019c4:	ff 75 0c             	pushl  0xc(%ebp)
  8019c7:	ff 75 08             	pushl  0x8(%ebp)
  8019ca:	6a 27                	push   $0x27
  8019cc:	e8 18 fb ff ff       	call   8014e9 <syscall>
  8019d1:	83 c4 18             	add    $0x18,%esp
	return ;
  8019d4:	90                   	nop
}
  8019d5:	c9                   	leave  
  8019d6:	c3                   	ret    

008019d7 <chktst>:
void chktst(uint32 n)
{
  8019d7:	55                   	push   %ebp
  8019d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	ff 75 08             	pushl  0x8(%ebp)
  8019e5:	6a 29                	push   $0x29
  8019e7:	e8 fd fa ff ff       	call   8014e9 <syscall>
  8019ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ef:	90                   	nop
}
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    

008019f2 <inctst>:

void inctst()
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 2a                	push   $0x2a
  801a01:	e8 e3 fa ff ff       	call   8014e9 <syscall>
  801a06:	83 c4 18             	add    $0x18,%esp
	return ;
  801a09:	90                   	nop
}
  801a0a:	c9                   	leave  
  801a0b:	c3                   	ret    

00801a0c <gettst>:
uint32 gettst()
{
  801a0c:	55                   	push   %ebp
  801a0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 2b                	push   $0x2b
  801a1b:	e8 c9 fa ff ff       	call   8014e9 <syscall>
  801a20:	83 c4 18             	add    $0x18,%esp
}
  801a23:	c9                   	leave  
  801a24:	c3                   	ret    

00801a25 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a25:	55                   	push   %ebp
  801a26:	89 e5                	mov    %esp,%ebp
  801a28:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 00                	push   $0x0
  801a35:	6a 2c                	push   $0x2c
  801a37:	e8 ad fa ff ff       	call   8014e9 <syscall>
  801a3c:	83 c4 18             	add    $0x18,%esp
  801a3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a42:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a46:	75 07                	jne    801a4f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a48:	b8 01 00 00 00       	mov    $0x1,%eax
  801a4d:	eb 05                	jmp    801a54 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a4f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a54:	c9                   	leave  
  801a55:	c3                   	ret    

00801a56 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a56:	55                   	push   %ebp
  801a57:	89 e5                	mov    %esp,%ebp
  801a59:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a5c:	6a 00                	push   $0x0
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 00                	push   $0x0
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	6a 2c                	push   $0x2c
  801a68:	e8 7c fa ff ff       	call   8014e9 <syscall>
  801a6d:	83 c4 18             	add    $0x18,%esp
  801a70:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a73:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a77:	75 07                	jne    801a80 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a79:	b8 01 00 00 00       	mov    $0x1,%eax
  801a7e:	eb 05                	jmp    801a85 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a80:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a85:	c9                   	leave  
  801a86:	c3                   	ret    

00801a87 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a87:	55                   	push   %ebp
  801a88:	89 e5                	mov    %esp,%ebp
  801a8a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 2c                	push   $0x2c
  801a99:	e8 4b fa ff ff       	call   8014e9 <syscall>
  801a9e:	83 c4 18             	add    $0x18,%esp
  801aa1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801aa4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801aa8:	75 07                	jne    801ab1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801aaa:	b8 01 00 00 00       	mov    $0x1,%eax
  801aaf:	eb 05                	jmp    801ab6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ab1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ab6:	c9                   	leave  
  801ab7:	c3                   	ret    

00801ab8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ab8:	55                   	push   %ebp
  801ab9:	89 e5                	mov    %esp,%ebp
  801abb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 2c                	push   $0x2c
  801aca:	e8 1a fa ff ff       	call   8014e9 <syscall>
  801acf:	83 c4 18             	add    $0x18,%esp
  801ad2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ad5:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ad9:	75 07                	jne    801ae2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801adb:	b8 01 00 00 00       	mov    $0x1,%eax
  801ae0:	eb 05                	jmp    801ae7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ae2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ae7:	c9                   	leave  
  801ae8:	c3                   	ret    

00801ae9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ae9:	55                   	push   %ebp
  801aea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	ff 75 08             	pushl  0x8(%ebp)
  801af7:	6a 2d                	push   $0x2d
  801af9:	e8 eb f9 ff ff       	call   8014e9 <syscall>
  801afe:	83 c4 18             	add    $0x18,%esp
	return ;
  801b01:	90                   	nop
}
  801b02:	c9                   	leave  
  801b03:	c3                   	ret    

00801b04 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b04:	55                   	push   %ebp
  801b05:	89 e5                	mov    %esp,%ebp
  801b07:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b08:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b0b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b0e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b11:	8b 45 08             	mov    0x8(%ebp),%eax
  801b14:	6a 00                	push   $0x0
  801b16:	53                   	push   %ebx
  801b17:	51                   	push   %ecx
  801b18:	52                   	push   %edx
  801b19:	50                   	push   %eax
  801b1a:	6a 2e                	push   $0x2e
  801b1c:	e8 c8 f9 ff ff       	call   8014e9 <syscall>
  801b21:	83 c4 18             	add    $0x18,%esp
}
  801b24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b27:	c9                   	leave  
  801b28:	c3                   	ret    

00801b29 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b29:	55                   	push   %ebp
  801b2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	52                   	push   %edx
  801b39:	50                   	push   %eax
  801b3a:	6a 2f                	push   $0x2f
  801b3c:	e8 a8 f9 ff ff       	call   8014e9 <syscall>
  801b41:	83 c4 18             	add    $0x18,%esp
}
  801b44:	c9                   	leave  
  801b45:	c3                   	ret    

00801b46 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801b46:	55                   	push   %ebp
  801b47:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	ff 75 0c             	pushl  0xc(%ebp)
  801b52:	ff 75 08             	pushl  0x8(%ebp)
  801b55:	6a 30                	push   $0x30
  801b57:	e8 8d f9 ff ff       	call   8014e9 <syscall>
  801b5c:	83 c4 18             	add    $0x18,%esp
	return ;
  801b5f:	90                   	nop
}
  801b60:	c9                   	leave  
  801b61:	c3                   	ret    
  801b62:	66 90                	xchg   %ax,%ax

00801b64 <__udivdi3>:
  801b64:	55                   	push   %ebp
  801b65:	57                   	push   %edi
  801b66:	56                   	push   %esi
  801b67:	53                   	push   %ebx
  801b68:	83 ec 1c             	sub    $0x1c,%esp
  801b6b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b6f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b73:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b77:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b7b:	89 ca                	mov    %ecx,%edx
  801b7d:	89 f8                	mov    %edi,%eax
  801b7f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b83:	85 f6                	test   %esi,%esi
  801b85:	75 2d                	jne    801bb4 <__udivdi3+0x50>
  801b87:	39 cf                	cmp    %ecx,%edi
  801b89:	77 65                	ja     801bf0 <__udivdi3+0x8c>
  801b8b:	89 fd                	mov    %edi,%ebp
  801b8d:	85 ff                	test   %edi,%edi
  801b8f:	75 0b                	jne    801b9c <__udivdi3+0x38>
  801b91:	b8 01 00 00 00       	mov    $0x1,%eax
  801b96:	31 d2                	xor    %edx,%edx
  801b98:	f7 f7                	div    %edi
  801b9a:	89 c5                	mov    %eax,%ebp
  801b9c:	31 d2                	xor    %edx,%edx
  801b9e:	89 c8                	mov    %ecx,%eax
  801ba0:	f7 f5                	div    %ebp
  801ba2:	89 c1                	mov    %eax,%ecx
  801ba4:	89 d8                	mov    %ebx,%eax
  801ba6:	f7 f5                	div    %ebp
  801ba8:	89 cf                	mov    %ecx,%edi
  801baa:	89 fa                	mov    %edi,%edx
  801bac:	83 c4 1c             	add    $0x1c,%esp
  801baf:	5b                   	pop    %ebx
  801bb0:	5e                   	pop    %esi
  801bb1:	5f                   	pop    %edi
  801bb2:	5d                   	pop    %ebp
  801bb3:	c3                   	ret    
  801bb4:	39 ce                	cmp    %ecx,%esi
  801bb6:	77 28                	ja     801be0 <__udivdi3+0x7c>
  801bb8:	0f bd fe             	bsr    %esi,%edi
  801bbb:	83 f7 1f             	xor    $0x1f,%edi
  801bbe:	75 40                	jne    801c00 <__udivdi3+0x9c>
  801bc0:	39 ce                	cmp    %ecx,%esi
  801bc2:	72 0a                	jb     801bce <__udivdi3+0x6a>
  801bc4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801bc8:	0f 87 9e 00 00 00    	ja     801c6c <__udivdi3+0x108>
  801bce:	b8 01 00 00 00       	mov    $0x1,%eax
  801bd3:	89 fa                	mov    %edi,%edx
  801bd5:	83 c4 1c             	add    $0x1c,%esp
  801bd8:	5b                   	pop    %ebx
  801bd9:	5e                   	pop    %esi
  801bda:	5f                   	pop    %edi
  801bdb:	5d                   	pop    %ebp
  801bdc:	c3                   	ret    
  801bdd:	8d 76 00             	lea    0x0(%esi),%esi
  801be0:	31 ff                	xor    %edi,%edi
  801be2:	31 c0                	xor    %eax,%eax
  801be4:	89 fa                	mov    %edi,%edx
  801be6:	83 c4 1c             	add    $0x1c,%esp
  801be9:	5b                   	pop    %ebx
  801bea:	5e                   	pop    %esi
  801beb:	5f                   	pop    %edi
  801bec:	5d                   	pop    %ebp
  801bed:	c3                   	ret    
  801bee:	66 90                	xchg   %ax,%ax
  801bf0:	89 d8                	mov    %ebx,%eax
  801bf2:	f7 f7                	div    %edi
  801bf4:	31 ff                	xor    %edi,%edi
  801bf6:	89 fa                	mov    %edi,%edx
  801bf8:	83 c4 1c             	add    $0x1c,%esp
  801bfb:	5b                   	pop    %ebx
  801bfc:	5e                   	pop    %esi
  801bfd:	5f                   	pop    %edi
  801bfe:	5d                   	pop    %ebp
  801bff:	c3                   	ret    
  801c00:	bd 20 00 00 00       	mov    $0x20,%ebp
  801c05:	89 eb                	mov    %ebp,%ebx
  801c07:	29 fb                	sub    %edi,%ebx
  801c09:	89 f9                	mov    %edi,%ecx
  801c0b:	d3 e6                	shl    %cl,%esi
  801c0d:	89 c5                	mov    %eax,%ebp
  801c0f:	88 d9                	mov    %bl,%cl
  801c11:	d3 ed                	shr    %cl,%ebp
  801c13:	89 e9                	mov    %ebp,%ecx
  801c15:	09 f1                	or     %esi,%ecx
  801c17:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801c1b:	89 f9                	mov    %edi,%ecx
  801c1d:	d3 e0                	shl    %cl,%eax
  801c1f:	89 c5                	mov    %eax,%ebp
  801c21:	89 d6                	mov    %edx,%esi
  801c23:	88 d9                	mov    %bl,%cl
  801c25:	d3 ee                	shr    %cl,%esi
  801c27:	89 f9                	mov    %edi,%ecx
  801c29:	d3 e2                	shl    %cl,%edx
  801c2b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c2f:	88 d9                	mov    %bl,%cl
  801c31:	d3 e8                	shr    %cl,%eax
  801c33:	09 c2                	or     %eax,%edx
  801c35:	89 d0                	mov    %edx,%eax
  801c37:	89 f2                	mov    %esi,%edx
  801c39:	f7 74 24 0c          	divl   0xc(%esp)
  801c3d:	89 d6                	mov    %edx,%esi
  801c3f:	89 c3                	mov    %eax,%ebx
  801c41:	f7 e5                	mul    %ebp
  801c43:	39 d6                	cmp    %edx,%esi
  801c45:	72 19                	jb     801c60 <__udivdi3+0xfc>
  801c47:	74 0b                	je     801c54 <__udivdi3+0xf0>
  801c49:	89 d8                	mov    %ebx,%eax
  801c4b:	31 ff                	xor    %edi,%edi
  801c4d:	e9 58 ff ff ff       	jmp    801baa <__udivdi3+0x46>
  801c52:	66 90                	xchg   %ax,%ax
  801c54:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c58:	89 f9                	mov    %edi,%ecx
  801c5a:	d3 e2                	shl    %cl,%edx
  801c5c:	39 c2                	cmp    %eax,%edx
  801c5e:	73 e9                	jae    801c49 <__udivdi3+0xe5>
  801c60:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c63:	31 ff                	xor    %edi,%edi
  801c65:	e9 40 ff ff ff       	jmp    801baa <__udivdi3+0x46>
  801c6a:	66 90                	xchg   %ax,%ax
  801c6c:	31 c0                	xor    %eax,%eax
  801c6e:	e9 37 ff ff ff       	jmp    801baa <__udivdi3+0x46>
  801c73:	90                   	nop

00801c74 <__umoddi3>:
  801c74:	55                   	push   %ebp
  801c75:	57                   	push   %edi
  801c76:	56                   	push   %esi
  801c77:	53                   	push   %ebx
  801c78:	83 ec 1c             	sub    $0x1c,%esp
  801c7b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c7f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c83:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c87:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c8b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c8f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c93:	89 f3                	mov    %esi,%ebx
  801c95:	89 fa                	mov    %edi,%edx
  801c97:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c9b:	89 34 24             	mov    %esi,(%esp)
  801c9e:	85 c0                	test   %eax,%eax
  801ca0:	75 1a                	jne    801cbc <__umoddi3+0x48>
  801ca2:	39 f7                	cmp    %esi,%edi
  801ca4:	0f 86 a2 00 00 00    	jbe    801d4c <__umoddi3+0xd8>
  801caa:	89 c8                	mov    %ecx,%eax
  801cac:	89 f2                	mov    %esi,%edx
  801cae:	f7 f7                	div    %edi
  801cb0:	89 d0                	mov    %edx,%eax
  801cb2:	31 d2                	xor    %edx,%edx
  801cb4:	83 c4 1c             	add    $0x1c,%esp
  801cb7:	5b                   	pop    %ebx
  801cb8:	5e                   	pop    %esi
  801cb9:	5f                   	pop    %edi
  801cba:	5d                   	pop    %ebp
  801cbb:	c3                   	ret    
  801cbc:	39 f0                	cmp    %esi,%eax
  801cbe:	0f 87 ac 00 00 00    	ja     801d70 <__umoddi3+0xfc>
  801cc4:	0f bd e8             	bsr    %eax,%ebp
  801cc7:	83 f5 1f             	xor    $0x1f,%ebp
  801cca:	0f 84 ac 00 00 00    	je     801d7c <__umoddi3+0x108>
  801cd0:	bf 20 00 00 00       	mov    $0x20,%edi
  801cd5:	29 ef                	sub    %ebp,%edi
  801cd7:	89 fe                	mov    %edi,%esi
  801cd9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801cdd:	89 e9                	mov    %ebp,%ecx
  801cdf:	d3 e0                	shl    %cl,%eax
  801ce1:	89 d7                	mov    %edx,%edi
  801ce3:	89 f1                	mov    %esi,%ecx
  801ce5:	d3 ef                	shr    %cl,%edi
  801ce7:	09 c7                	or     %eax,%edi
  801ce9:	89 e9                	mov    %ebp,%ecx
  801ceb:	d3 e2                	shl    %cl,%edx
  801ced:	89 14 24             	mov    %edx,(%esp)
  801cf0:	89 d8                	mov    %ebx,%eax
  801cf2:	d3 e0                	shl    %cl,%eax
  801cf4:	89 c2                	mov    %eax,%edx
  801cf6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cfa:	d3 e0                	shl    %cl,%eax
  801cfc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801d00:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d04:	89 f1                	mov    %esi,%ecx
  801d06:	d3 e8                	shr    %cl,%eax
  801d08:	09 d0                	or     %edx,%eax
  801d0a:	d3 eb                	shr    %cl,%ebx
  801d0c:	89 da                	mov    %ebx,%edx
  801d0e:	f7 f7                	div    %edi
  801d10:	89 d3                	mov    %edx,%ebx
  801d12:	f7 24 24             	mull   (%esp)
  801d15:	89 c6                	mov    %eax,%esi
  801d17:	89 d1                	mov    %edx,%ecx
  801d19:	39 d3                	cmp    %edx,%ebx
  801d1b:	0f 82 87 00 00 00    	jb     801da8 <__umoddi3+0x134>
  801d21:	0f 84 91 00 00 00    	je     801db8 <__umoddi3+0x144>
  801d27:	8b 54 24 04          	mov    0x4(%esp),%edx
  801d2b:	29 f2                	sub    %esi,%edx
  801d2d:	19 cb                	sbb    %ecx,%ebx
  801d2f:	89 d8                	mov    %ebx,%eax
  801d31:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801d35:	d3 e0                	shl    %cl,%eax
  801d37:	89 e9                	mov    %ebp,%ecx
  801d39:	d3 ea                	shr    %cl,%edx
  801d3b:	09 d0                	or     %edx,%eax
  801d3d:	89 e9                	mov    %ebp,%ecx
  801d3f:	d3 eb                	shr    %cl,%ebx
  801d41:	89 da                	mov    %ebx,%edx
  801d43:	83 c4 1c             	add    $0x1c,%esp
  801d46:	5b                   	pop    %ebx
  801d47:	5e                   	pop    %esi
  801d48:	5f                   	pop    %edi
  801d49:	5d                   	pop    %ebp
  801d4a:	c3                   	ret    
  801d4b:	90                   	nop
  801d4c:	89 fd                	mov    %edi,%ebp
  801d4e:	85 ff                	test   %edi,%edi
  801d50:	75 0b                	jne    801d5d <__umoddi3+0xe9>
  801d52:	b8 01 00 00 00       	mov    $0x1,%eax
  801d57:	31 d2                	xor    %edx,%edx
  801d59:	f7 f7                	div    %edi
  801d5b:	89 c5                	mov    %eax,%ebp
  801d5d:	89 f0                	mov    %esi,%eax
  801d5f:	31 d2                	xor    %edx,%edx
  801d61:	f7 f5                	div    %ebp
  801d63:	89 c8                	mov    %ecx,%eax
  801d65:	f7 f5                	div    %ebp
  801d67:	89 d0                	mov    %edx,%eax
  801d69:	e9 44 ff ff ff       	jmp    801cb2 <__umoddi3+0x3e>
  801d6e:	66 90                	xchg   %ax,%ax
  801d70:	89 c8                	mov    %ecx,%eax
  801d72:	89 f2                	mov    %esi,%edx
  801d74:	83 c4 1c             	add    $0x1c,%esp
  801d77:	5b                   	pop    %ebx
  801d78:	5e                   	pop    %esi
  801d79:	5f                   	pop    %edi
  801d7a:	5d                   	pop    %ebp
  801d7b:	c3                   	ret    
  801d7c:	3b 04 24             	cmp    (%esp),%eax
  801d7f:	72 06                	jb     801d87 <__umoddi3+0x113>
  801d81:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d85:	77 0f                	ja     801d96 <__umoddi3+0x122>
  801d87:	89 f2                	mov    %esi,%edx
  801d89:	29 f9                	sub    %edi,%ecx
  801d8b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d8f:	89 14 24             	mov    %edx,(%esp)
  801d92:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d96:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d9a:	8b 14 24             	mov    (%esp),%edx
  801d9d:	83 c4 1c             	add    $0x1c,%esp
  801da0:	5b                   	pop    %ebx
  801da1:	5e                   	pop    %esi
  801da2:	5f                   	pop    %edi
  801da3:	5d                   	pop    %ebp
  801da4:	c3                   	ret    
  801da5:	8d 76 00             	lea    0x0(%esi),%esi
  801da8:	2b 04 24             	sub    (%esp),%eax
  801dab:	19 fa                	sbb    %edi,%edx
  801dad:	89 d1                	mov    %edx,%ecx
  801daf:	89 c6                	mov    %eax,%esi
  801db1:	e9 71 ff ff ff       	jmp    801d27 <__umoddi3+0xb3>
  801db6:	66 90                	xchg   %ax,%ax
  801db8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801dbc:	72 ea                	jb     801da8 <__umoddi3+0x134>
  801dbe:	89 d9                	mov    %ebx,%ecx
  801dc0:	e9 62 ff ff ff       	jmp    801d27 <__umoddi3+0xb3>
