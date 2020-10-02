
obj/user/tst_best_fit_2:     file format elf32-i386


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
  800031:	e8 a6 08 00 00       	call   8008dc <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 02                	push   $0x2
  800045:	e8 05 24 00 00       	call   80244f <sys_set_uheap_strategy>
  80004a:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80004d:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800051:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800058:	eb 2a                	jmp    800084 <_main+0x4c>
		{
			if (myEnv->__uptr_pws[i].empty)
  80005a:	a1 20 30 80 00       	mov    0x803020,%eax
  80005f:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800065:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800068:	89 d0                	mov    %edx,%eax
  80006a:	c1 e0 02             	shl    $0x2,%eax
  80006d:	01 d0                	add    %edx,%eax
  80006f:	c1 e0 02             	shl    $0x2,%eax
  800072:	01 c8                	add    %ecx,%eax
  800074:	8a 40 04             	mov    0x4(%eax),%al
  800077:	84 c0                	test   %al,%al
  800079:	74 06                	je     800081 <_main+0x49>
			{
				fullWS = 0;
  80007b:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80007f:	eb 12                	jmp    800093 <_main+0x5b>
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800081:	ff 45 f0             	incl   -0x10(%ebp)
  800084:	a1 20 30 80 00       	mov    0x803020,%eax
  800089:	8b 50 74             	mov    0x74(%eax),%edx
  80008c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80008f:	39 c2                	cmp    %eax,%edx
  800091:	77 c7                	ja     80005a <_main+0x22>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800093:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800097:	74 14                	je     8000ad <_main+0x75>
  800099:	83 ec 04             	sub    $0x4,%esp
  80009c:	68 40 27 80 00       	push   $0x802740
  8000a1:	6a 1b                	push   $0x1b
  8000a3:	68 5c 27 80 00       	push   $0x80275c
  8000a8:	e8 57 09 00 00       	call   800a04 <_panic>
	}

	int Mega = 1024*1024;
  8000ad:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000b4:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	void* ptr_allocations[20] = {0};
  8000bb:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000be:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000c3:	b8 00 00 00 00       	mov    $0x0,%eax
  8000c8:	89 d7                	mov    %edx,%edi
  8000ca:	f3 ab                	rep stos %eax,%es:(%edi)

	//[1] Attempt to allocate more than heap size
	{
		ptr_allocations[0] = malloc(USER_HEAP_MAX - USER_HEAP_START + 1);
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	68 01 00 00 20       	push   $0x20000001
  8000d4:	e8 6c 19 00 00       	call   801a45 <malloc>
  8000d9:	83 c4 10             	add    $0x10,%esp
  8000dc:	89 45 90             	mov    %eax,-0x70(%ebp)
		if (ptr_allocations[0] != NULL) panic("Malloc: Attempt to allocate more than heap size, should return NULL");
  8000df:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e2:	85 c0                	test   %eax,%eax
  8000e4:	74 14                	je     8000fa <_main+0xc2>
  8000e6:	83 ec 04             	sub    $0x4,%esp
  8000e9:	68 74 27 80 00       	push   $0x802774
  8000ee:	6a 25                	push   $0x25
  8000f0:	68 5c 27 80 00       	push   $0x80275c
  8000f5:	e8 0a 09 00 00       	call   800a04 <_panic>
	}
	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
  8000fa:	e8 bc 1e 00 00       	call   801fbb <sys_calculate_free_frames>
  8000ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  800102:	e8 37 1f 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  800107:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  80010a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80010d:	01 c0                	add    %eax,%eax
  80010f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800112:	83 ec 0c             	sub    $0xc,%esp
  800115:	50                   	push   %eax
  800116:	e8 2a 19 00 00       	call   801a45 <malloc>
  80011b:	83 c4 10             	add    $0x10,%esp
  80011e:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START) ) panic("Wrong start address for the allocated space... ");
  800121:	8b 45 90             	mov    -0x70(%ebp),%eax
  800124:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800129:	74 14                	je     80013f <_main+0x107>
  80012b:	83 ec 04             	sub    $0x4,%esp
  80012e:	68 b8 27 80 00       	push   $0x8027b8
  800133:	6a 2e                	push   $0x2e
  800135:	68 5c 27 80 00       	push   $0x80275c
  80013a:	e8 c5 08 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  80013f:	e8 fa 1e 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  800144:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800147:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014c:	74 14                	je     800162 <_main+0x12a>
  80014e:	83 ec 04             	sub    $0x4,%esp
  800151:	68 e8 27 80 00       	push   $0x8027e8
  800156:	6a 30                	push   $0x30
  800158:	68 5c 27 80 00       	push   $0x80275c
  80015d:	e8 a2 08 00 00       	call   800a04 <_panic>

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  800162:	e8 54 1e 00 00       	call   801fbb <sys_calculate_free_frames>
  800167:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80016a:	e8 cf 1e 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  80016f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800172:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800175:	01 c0                	add    %eax,%eax
  800177:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80017a:	83 ec 0c             	sub    $0xc,%esp
  80017d:	50                   	push   %eax
  80017e:	e8 c2 18 00 00       	call   801a45 <malloc>
  800183:	83 c4 10             	add    $0x10,%esp
  800186:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  800189:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80018c:	89 c2                	mov    %eax,%edx
  80018e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800191:	01 c0                	add    %eax,%eax
  800193:	05 00 00 00 80       	add    $0x80000000,%eax
  800198:	39 c2                	cmp    %eax,%edx
  80019a:	74 14                	je     8001b0 <_main+0x178>
  80019c:	83 ec 04             	sub    $0x4,%esp
  80019f:	68 b8 27 80 00       	push   $0x8027b8
  8001a4:	6a 36                	push   $0x36
  8001a6:	68 5c 27 80 00       	push   $0x80275c
  8001ab:	e8 54 08 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8001b0:	e8 89 1e 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8001b5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001b8:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001bd:	74 14                	je     8001d3 <_main+0x19b>
  8001bf:	83 ec 04             	sub    $0x4,%esp
  8001c2:	68 e8 27 80 00       	push   $0x8027e8
  8001c7:	6a 38                	push   $0x38
  8001c9:	68 5c 27 80 00       	push   $0x80275c
  8001ce:	e8 31 08 00 00       	call   800a04 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8001d3:	e8 e3 1d 00 00       	call   801fbb <sys_calculate_free_frames>
  8001d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001db:	e8 5e 1e 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8001e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  8001e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001e6:	01 c0                	add    %eax,%eax
  8001e8:	83 ec 0c             	sub    $0xc,%esp
  8001eb:	50                   	push   %eax
  8001ec:	e8 54 18 00 00       	call   801a45 <malloc>
  8001f1:	83 c4 10             	add    $0x10,%esp
  8001f4:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  8001f7:	8b 45 98             	mov    -0x68(%ebp),%eax
  8001fa:	89 c2                	mov    %eax,%edx
  8001fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001ff:	c1 e0 02             	shl    $0x2,%eax
  800202:	05 00 00 00 80       	add    $0x80000000,%eax
  800207:	39 c2                	cmp    %eax,%edx
  800209:	74 14                	je     80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 b8 27 80 00       	push   $0x8027b8
  800213:	6a 3e                	push   $0x3e
  800215:	68 5c 27 80 00       	push   $0x80275c
  80021a:	e8 e5 07 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  80021f:	e8 1a 1e 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  800224:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800227:	83 f8 01             	cmp    $0x1,%eax
  80022a:	74 14                	je     800240 <_main+0x208>
  80022c:	83 ec 04             	sub    $0x4,%esp
  80022f:	68 e8 27 80 00       	push   $0x8027e8
  800234:	6a 40                	push   $0x40
  800236:	68 5c 27 80 00       	push   $0x80275c
  80023b:	e8 c4 07 00 00       	call   800a04 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  800240:	e8 76 1d 00 00       	call   801fbb <sys_calculate_free_frames>
  800245:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800248:	e8 f1 1d 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  80024d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  800250:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800253:	01 c0                	add    %eax,%eax
  800255:	83 ec 0c             	sub    $0xc,%esp
  800258:	50                   	push   %eax
  800259:	e8 e7 17 00 00       	call   801a45 <malloc>
  80025e:	83 c4 10             	add    $0x10,%esp
  800261:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 4*Mega + 4*kilo)) panic("Wrong start address for the allocated space... ");
  800264:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800267:	89 c2                	mov    %eax,%edx
  800269:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80026c:	c1 e0 02             	shl    $0x2,%eax
  80026f:	89 c1                	mov    %eax,%ecx
  800271:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800274:	c1 e0 02             	shl    $0x2,%eax
  800277:	01 c8                	add    %ecx,%eax
  800279:	05 00 00 00 80       	add    $0x80000000,%eax
  80027e:	39 c2                	cmp    %eax,%edx
  800280:	74 14                	je     800296 <_main+0x25e>
  800282:	83 ec 04             	sub    $0x4,%esp
  800285:	68 b8 27 80 00       	push   $0x8027b8
  80028a:	6a 46                	push   $0x46
  80028c:	68 5c 27 80 00       	push   $0x80275c
  800291:	e8 6e 07 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  800296:	e8 a3 1d 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  80029b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80029e:	83 f8 01             	cmp    $0x1,%eax
  8002a1:	74 14                	je     8002b7 <_main+0x27f>
  8002a3:	83 ec 04             	sub    $0x4,%esp
  8002a6:	68 e8 27 80 00       	push   $0x8027e8
  8002ab:	6a 48                	push   $0x48
  8002ad:	68 5c 27 80 00       	push   $0x80275c
  8002b2:	e8 4d 07 00 00       	call   800a04 <_panic>

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  8002b7:	e8 ff 1c 00 00       	call   801fbb <sys_calculate_free_frames>
  8002bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8002bf:	e8 7a 1d 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8002c4:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8002c7:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002ca:	83 ec 0c             	sub    $0xc,%esp
  8002cd:	50                   	push   %eax
  8002ce:	e8 37 1a 00 00       	call   801d0a <free>
  8002d3:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1) panic("Wrong free: ");
		if( (usedDiskPages-sys_pf_calculate_allocated_pages()) !=  1) panic("Wrong page file free: ");
  8002d6:	e8 63 1d 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8002db:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002de:	29 c2                	sub    %eax,%edx
  8002e0:	89 d0                	mov    %edx,%eax
  8002e2:	83 f8 01             	cmp    $0x1,%eax
  8002e5:	74 14                	je     8002fb <_main+0x2c3>
  8002e7:	83 ec 04             	sub    $0x4,%esp
  8002ea:	68 05 28 80 00       	push   $0x802805
  8002ef:	6a 4f                	push   $0x4f
  8002f1:	68 5c 27 80 00       	push   $0x80275c
  8002f6:	e8 09 07 00 00       	call   800a04 <_panic>

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  8002fb:	e8 bb 1c 00 00       	call   801fbb <sys_calculate_free_frames>
  800300:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800303:	e8 36 1d 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  800308:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  80030b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80030e:	89 d0                	mov    %edx,%eax
  800310:	01 c0                	add    %eax,%eax
  800312:	01 d0                	add    %edx,%eax
  800314:	01 c0                	add    %eax,%eax
  800316:	01 d0                	add    %edx,%eax
  800318:	83 ec 0c             	sub    $0xc,%esp
  80031b:	50                   	push   %eax
  80031c:	e8 24 17 00 00       	call   801a45 <malloc>
  800321:	83 c4 10             	add    $0x10,%esp
  800324:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega + 8*kilo)) panic("Wrong start address for the allocated space... ");
  800327:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80032a:	89 c2                	mov    %eax,%edx
  80032c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80032f:	c1 e0 02             	shl    $0x2,%eax
  800332:	89 c1                	mov    %eax,%ecx
  800334:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800337:	c1 e0 03             	shl    $0x3,%eax
  80033a:	01 c8                	add    %ecx,%eax
  80033c:	05 00 00 00 80       	add    $0x80000000,%eax
  800341:	39 c2                	cmp    %eax,%edx
  800343:	74 14                	je     800359 <_main+0x321>
  800345:	83 ec 04             	sub    $0x4,%esp
  800348:	68 b8 27 80 00       	push   $0x8027b8
  80034d:	6a 55                	push   $0x55
  80034f:	68 5c 27 80 00       	push   $0x80275c
  800354:	e8 ab 06 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  800359:	e8 e0 1c 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  80035e:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800361:	83 f8 02             	cmp    $0x2,%eax
  800364:	74 14                	je     80037a <_main+0x342>
  800366:	83 ec 04             	sub    $0x4,%esp
  800369:	68 e8 27 80 00       	push   $0x8027e8
  80036e:	6a 57                	push   $0x57
  800370:	68 5c 27 80 00       	push   $0x80275c
  800375:	e8 8a 06 00 00       	call   800a04 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80037a:	e8 3c 1c 00 00       	call   801fbb <sys_calculate_free_frames>
  80037f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800382:	e8 b7 1c 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  800387:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[0]);
  80038a:	8b 45 90             	mov    -0x70(%ebp),%eax
  80038d:	83 ec 0c             	sub    $0xc,%esp
  800390:	50                   	push   %eax
  800391:	e8 74 19 00 00       	call   801d0a <free>
  800396:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800399:	e8 a0 1c 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  80039e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003a1:	29 c2                	sub    %eax,%edx
  8003a3:	89 d0                	mov    %edx,%eax
  8003a5:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003aa:	74 14                	je     8003c0 <_main+0x388>
  8003ac:	83 ec 04             	sub    $0x4,%esp
  8003af:	68 05 28 80 00       	push   $0x802805
  8003b4:	6a 5e                	push   $0x5e
  8003b6:	68 5c 27 80 00       	push   $0x80275c
  8003bb:	e8 44 06 00 00       	call   800a04 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003c0:	e8 f6 1b 00 00       	call   801fbb <sys_calculate_free_frames>
  8003c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003c8:	e8 71 1c 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8003cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8003d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d3:	89 c2                	mov    %eax,%edx
  8003d5:	01 d2                	add    %edx,%edx
  8003d7:	01 d0                	add    %edx,%eax
  8003d9:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003dc:	83 ec 0c             	sub    $0xc,%esp
  8003df:	50                   	push   %eax
  8003e0:	e8 60 16 00 00       	call   801a45 <malloc>
  8003e5:	83 c4 10             	add    $0x10,%esp
  8003e8:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  8003eb:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003ee:	89 c2                	mov    %eax,%edx
  8003f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003f3:	c1 e0 02             	shl    $0x2,%eax
  8003f6:	89 c1                	mov    %eax,%ecx
  8003f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003fb:	c1 e0 04             	shl    $0x4,%eax
  8003fe:	01 c8                	add    %ecx,%eax
  800400:	05 00 00 00 80       	add    $0x80000000,%eax
  800405:	39 c2                	cmp    %eax,%edx
  800407:	74 14                	je     80041d <_main+0x3e5>
  800409:	83 ec 04             	sub    $0x4,%esp
  80040c:	68 b8 27 80 00       	push   $0x8027b8
  800411:	6a 64                	push   $0x64
  800413:	68 5c 27 80 00       	push   $0x80275c
  800418:	e8 e7 05 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80041d:	e8 1c 1c 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  800422:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800425:	89 c2                	mov    %eax,%edx
  800427:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80042a:	89 c1                	mov    %eax,%ecx
  80042c:	01 c9                	add    %ecx,%ecx
  80042e:	01 c8                	add    %ecx,%eax
  800430:	85 c0                	test   %eax,%eax
  800432:	79 05                	jns    800439 <_main+0x401>
  800434:	05 ff 0f 00 00       	add    $0xfff,%eax
  800439:	c1 f8 0c             	sar    $0xc,%eax
  80043c:	39 c2                	cmp    %eax,%edx
  80043e:	74 14                	je     800454 <_main+0x41c>
  800440:	83 ec 04             	sub    $0x4,%esp
  800443:	68 e8 27 80 00       	push   $0x8027e8
  800448:	6a 66                	push   $0x66
  80044a:	68 5c 27 80 00       	push   $0x80275c
  80044f:	e8 b0 05 00 00       	call   800a04 <_panic>

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
  800454:	e8 62 1b 00 00       	call   801fbb <sys_calculate_free_frames>
  800459:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80045c:	e8 dd 1b 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  800461:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(2*Mega + 6*kilo);
  800464:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800467:	89 c2                	mov    %eax,%edx
  800469:	01 d2                	add    %edx,%edx
  80046b:	01 c2                	add    %eax,%edx
  80046d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800470:	01 d0                	add    %edx,%eax
  800472:	01 c0                	add    %eax,%eax
  800474:	83 ec 0c             	sub    $0xc,%esp
  800477:	50                   	push   %eax
  800478:	e8 c8 15 00 00       	call   801a45 <malloc>
  80047d:	83 c4 10             	add    $0x10,%esp
  800480:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800483:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800486:	89 c1                	mov    %eax,%ecx
  800488:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80048b:	89 d0                	mov    %edx,%eax
  80048d:	01 c0                	add    %eax,%eax
  80048f:	01 d0                	add    %edx,%eax
  800491:	01 c0                	add    %eax,%eax
  800493:	01 d0                	add    %edx,%eax
  800495:	89 c2                	mov    %eax,%edx
  800497:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80049a:	c1 e0 04             	shl    $0x4,%eax
  80049d:	01 d0                	add    %edx,%eax
  80049f:	05 00 00 00 80       	add    $0x80000000,%eax
  8004a4:	39 c1                	cmp    %eax,%ecx
  8004a6:	74 14                	je     8004bc <_main+0x484>
  8004a8:	83 ec 04             	sub    $0x4,%esp
  8004ab:	68 b8 27 80 00       	push   $0x8027b8
  8004b0:	6a 6c                	push   $0x6c
  8004b2:	68 5c 27 80 00       	push   $0x80275c
  8004b7:	e8 48 05 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 514+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  514) panic("Wrong page file allocation: ");
  8004bc:	e8 7d 1b 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8004c1:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004c4:	3d 02 02 00 00       	cmp    $0x202,%eax
  8004c9:	74 14                	je     8004df <_main+0x4a7>
  8004cb:	83 ec 04             	sub    $0x4,%esp
  8004ce:	68 e8 27 80 00       	push   $0x8027e8
  8004d3:	6a 6e                	push   $0x6e
  8004d5:	68 5c 27 80 00       	push   $0x80275c
  8004da:	e8 25 05 00 00       	call   800a04 <_panic>

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
  8004df:	e8 d7 1a 00 00       	call   801fbb <sys_calculate_free_frames>
  8004e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004e7:	e8 52 1b 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8004ec:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(5*Mega-kilo);
  8004ef:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004f2:	89 d0                	mov    %edx,%eax
  8004f4:	c1 e0 02             	shl    $0x2,%eax
  8004f7:	01 d0                	add    %edx,%eax
  8004f9:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8004fc:	83 ec 0c             	sub    $0xc,%esp
  8004ff:	50                   	push   %eax
  800500:	e8 40 15 00 00       	call   801a45 <malloc>
  800505:	83 c4 10             	add    $0x10,%esp
  800508:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 9*Mega + 24*kilo)) panic("Wrong start address for the allocated space... ");
  80050b:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80050e:	89 c1                	mov    %eax,%ecx
  800510:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800513:	89 d0                	mov    %edx,%eax
  800515:	c1 e0 03             	shl    $0x3,%eax
  800518:	01 d0                	add    %edx,%eax
  80051a:	89 c3                	mov    %eax,%ebx
  80051c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80051f:	89 d0                	mov    %edx,%eax
  800521:	01 c0                	add    %eax,%eax
  800523:	01 d0                	add    %edx,%eax
  800525:	c1 e0 03             	shl    $0x3,%eax
  800528:	01 d8                	add    %ebx,%eax
  80052a:	05 00 00 00 80       	add    $0x80000000,%eax
  80052f:	39 c1                	cmp    %eax,%ecx
  800531:	74 14                	je     800547 <_main+0x50f>
  800533:	83 ec 04             	sub    $0x4,%esp
  800536:	68 b8 27 80 00       	push   $0x8027b8
  80053b:	6a 74                	push   $0x74
  80053d:	68 5c 27 80 00       	push   $0x80275c
  800542:	e8 bd 04 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 5*Mega/4096 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/4096) panic("Wrong page file allocation: ");
  800547:	e8 f2 1a 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  80054c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80054f:	89 c1                	mov    %eax,%ecx
  800551:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800554:	89 d0                	mov    %edx,%eax
  800556:	c1 e0 02             	shl    $0x2,%eax
  800559:	01 d0                	add    %edx,%eax
  80055b:	85 c0                	test   %eax,%eax
  80055d:	79 05                	jns    800564 <_main+0x52c>
  80055f:	05 ff 0f 00 00       	add    $0xfff,%eax
  800564:	c1 f8 0c             	sar    $0xc,%eax
  800567:	39 c1                	cmp    %eax,%ecx
  800569:	74 14                	je     80057f <_main+0x547>
  80056b:	83 ec 04             	sub    $0x4,%esp
  80056e:	68 e8 27 80 00       	push   $0x8027e8
  800573:	6a 76                	push   $0x76
  800575:	68 5c 27 80 00       	push   $0x80275c
  80057a:	e8 85 04 00 00       	call   800a04 <_panic>

		//2 MB + 8 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  80057f:	e8 37 1a 00 00       	call   801fbb <sys_calculate_free_frames>
  800584:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800587:	e8 b2 1a 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  80058c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[6]);
  80058f:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800592:	83 ec 0c             	sub    $0xc,%esp
  800595:	50                   	push   %eax
  800596:	e8 6f 17 00 00       	call   801d0a <free>
  80059b:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 514) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  514) panic("Wrong page file free: ");
  80059e:	e8 9b 1a 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8005a3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005a6:	29 c2                	sub    %eax,%edx
  8005a8:	89 d0                	mov    %edx,%eax
  8005aa:	3d 02 02 00 00       	cmp    $0x202,%eax
  8005af:	74 14                	je     8005c5 <_main+0x58d>
  8005b1:	83 ec 04             	sub    $0x4,%esp
  8005b4:	68 05 28 80 00       	push   $0x802805
  8005b9:	6a 7d                	push   $0x7d
  8005bb:	68 5c 27 80 00       	push   $0x80275c
  8005c0:	e8 3f 04 00 00       	call   800a04 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005c5:	e8 f1 19 00 00       	call   801fbb <sys_calculate_free_frames>
  8005ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005cd:	e8 6c 1a 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8005d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  8005d5:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8005d8:	83 ec 0c             	sub    $0xc,%esp
  8005db:	50                   	push   %eax
  8005dc:	e8 29 17 00 00       	call   801d0a <free>
  8005e1:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  8005e4:	e8 55 1a 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8005e9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005ec:	29 c2                	sub    %eax,%edx
  8005ee:	89 d0                	mov    %edx,%eax
  8005f0:	3d 00 02 00 00       	cmp    $0x200,%eax
  8005f5:	74 17                	je     80060e <_main+0x5d6>
  8005f7:	83 ec 04             	sub    $0x4,%esp
  8005fa:	68 05 28 80 00       	push   $0x802805
  8005ff:	68 84 00 00 00       	push   $0x84
  800604:	68 5c 27 80 00       	push   $0x80275c
  800609:	e8 f6 03 00 00       	call   800a04 <_panic>

		//2 MB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  80060e:	e8 a8 19 00 00       	call   801fbb <sys_calculate_free_frames>
  800613:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800616:	e8 23 1a 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  80061b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(2*Mega-kilo);
  80061e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800621:	01 c0                	add    %eax,%eax
  800623:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800626:	83 ec 0c             	sub    $0xc,%esp
  800629:	50                   	push   %eax
  80062a:	e8 16 14 00 00       	call   801a45 <malloc>
  80062f:	83 c4 10             	add    $0x10,%esp
  800632:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800635:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800638:	89 c1                	mov    %eax,%ecx
  80063a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80063d:	89 d0                	mov    %edx,%eax
  80063f:	01 c0                	add    %eax,%eax
  800641:	01 d0                	add    %edx,%eax
  800643:	01 c0                	add    %eax,%eax
  800645:	01 d0                	add    %edx,%eax
  800647:	89 c2                	mov    %eax,%edx
  800649:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80064c:	c1 e0 04             	shl    $0x4,%eax
  80064f:	01 d0                	add    %edx,%eax
  800651:	05 00 00 00 80       	add    $0x80000000,%eax
  800656:	39 c1                	cmp    %eax,%ecx
  800658:	74 17                	je     800671 <_main+0x639>
  80065a:	83 ec 04             	sub    $0x4,%esp
  80065d:	68 b8 27 80 00       	push   $0x8027b8
  800662:	68 8a 00 00 00       	push   $0x8a
  800667:	68 5c 27 80 00       	push   $0x80275c
  80066c:	e8 93 03 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  800671:	e8 c8 19 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  800676:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800679:	3d 00 02 00 00       	cmp    $0x200,%eax
  80067e:	74 17                	je     800697 <_main+0x65f>
  800680:	83 ec 04             	sub    $0x4,%esp
  800683:	68 e8 27 80 00       	push   $0x8027e8
  800688:	68 8c 00 00 00       	push   $0x8c
  80068d:	68 5c 27 80 00       	push   $0x80275c
  800692:	e8 6d 03 00 00       	call   800a04 <_panic>

		//6 KB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  800697:	e8 1f 19 00 00       	call   801fbb <sys_calculate_free_frames>
  80069c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80069f:	e8 9a 19 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8006a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(6*kilo);
  8006a7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006aa:	89 d0                	mov    %edx,%eax
  8006ac:	01 c0                	add    %eax,%eax
  8006ae:	01 d0                	add    %edx,%eax
  8006b0:	01 c0                	add    %eax,%eax
  8006b2:	83 ec 0c             	sub    $0xc,%esp
  8006b5:	50                   	push   %eax
  8006b6:	e8 8a 13 00 00       	call   801a45 <malloc>
  8006bb:	83 c4 10             	add    $0x10,%esp
  8006be:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 9*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  8006c1:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8006c4:	89 c1                	mov    %eax,%ecx
  8006c6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006c9:	89 d0                	mov    %edx,%eax
  8006cb:	c1 e0 03             	shl    $0x3,%eax
  8006ce:	01 d0                	add    %edx,%eax
  8006d0:	89 c2                	mov    %eax,%edx
  8006d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006d5:	c1 e0 04             	shl    $0x4,%eax
  8006d8:	01 d0                	add    %edx,%eax
  8006da:	05 00 00 00 80       	add    $0x80000000,%eax
  8006df:	39 c1                	cmp    %eax,%ecx
  8006e1:	74 17                	je     8006fa <_main+0x6c2>
  8006e3:	83 ec 04             	sub    $0x4,%esp
  8006e6:	68 b8 27 80 00       	push   $0x8027b8
  8006eb:	68 92 00 00 00       	push   $0x92
  8006f0:	68 5c 27 80 00       	push   $0x80275c
  8006f5:	e8 0a 03 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  8006fa:	e8 3f 19 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8006ff:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800702:	83 f8 02             	cmp    $0x2,%eax
  800705:	74 17                	je     80071e <_main+0x6e6>
  800707:	83 ec 04             	sub    $0x4,%esp
  80070a:	68 e8 27 80 00       	push   $0x8027e8
  80070f:	68 94 00 00 00       	push   $0x94
  800714:	68 5c 27 80 00       	push   $0x80275c
  800719:	e8 e6 02 00 00       	call   800a04 <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80071e:	e8 98 18 00 00       	call   801fbb <sys_calculate_free_frames>
  800723:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800726:	e8 13 19 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  80072b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  80072e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800731:	83 ec 0c             	sub    $0xc,%esp
  800734:	50                   	push   %eax
  800735:	e8 d0 15 00 00       	call   801d0a <free>
  80073a:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  80073d:	e8 fc 18 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  800742:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800745:	29 c2                	sub    %eax,%edx
  800747:	89 d0                	mov    %edx,%eax
  800749:	3d 00 03 00 00       	cmp    $0x300,%eax
  80074e:	74 17                	je     800767 <_main+0x72f>
  800750:	83 ec 04             	sub    $0x4,%esp
  800753:	68 05 28 80 00       	push   $0x802805
  800758:	68 9b 00 00 00       	push   $0x9b
  80075d:	68 5c 27 80 00       	push   $0x80275c
  800762:	e8 9d 02 00 00       	call   800a04 <_panic>

		//3 MB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  800767:	e8 4f 18 00 00       	call   801fbb <sys_calculate_free_frames>
  80076c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80076f:	e8 ca 18 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  800774:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(3*Mega-kilo);
  800777:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80077a:	89 c2                	mov    %eax,%edx
  80077c:	01 d2                	add    %edx,%edx
  80077e:	01 d0                	add    %edx,%eax
  800780:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800783:	83 ec 0c             	sub    $0xc,%esp
  800786:	50                   	push   %eax
  800787:	e8 b9 12 00 00       	call   801a45 <malloc>
  80078c:	83 c4 10             	add    $0x10,%esp
  80078f:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800792:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800795:	89 c2                	mov    %eax,%edx
  800797:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80079a:	c1 e0 02             	shl    $0x2,%eax
  80079d:	89 c1                	mov    %eax,%ecx
  80079f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007a2:	c1 e0 04             	shl    $0x4,%eax
  8007a5:	01 c8                	add    %ecx,%eax
  8007a7:	05 00 00 00 80       	add    $0x80000000,%eax
  8007ac:	39 c2                	cmp    %eax,%edx
  8007ae:	74 17                	je     8007c7 <_main+0x78f>
  8007b0:	83 ec 04             	sub    $0x4,%esp
  8007b3:	68 b8 27 80 00       	push   $0x8027b8
  8007b8:	68 a1 00 00 00       	push   $0xa1
  8007bd:	68 5c 27 80 00       	push   $0x80275c
  8007c2:	e8 3d 02 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  8007c7:	e8 72 18 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  8007cc:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007cf:	89 c2                	mov    %eax,%edx
  8007d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007d4:	89 c1                	mov    %eax,%ecx
  8007d6:	01 c9                	add    %ecx,%ecx
  8007d8:	01 c8                	add    %ecx,%eax
  8007da:	85 c0                	test   %eax,%eax
  8007dc:	79 05                	jns    8007e3 <_main+0x7ab>
  8007de:	05 ff 0f 00 00       	add    $0xfff,%eax
  8007e3:	c1 f8 0c             	sar    $0xc,%eax
  8007e6:	39 c2                	cmp    %eax,%edx
  8007e8:	74 17                	je     800801 <_main+0x7c9>
  8007ea:	83 ec 04             	sub    $0x4,%esp
  8007ed:	68 e8 27 80 00       	push   $0x8027e8
  8007f2:	68 a3 00 00 00       	push   $0xa3
  8007f7:	68 5c 27 80 00       	push   $0x80275c
  8007fc:	e8 03 02 00 00       	call   800a04 <_panic>

		//4 MB
		freeFrames = sys_calculate_free_frames() ;
  800801:	e8 b5 17 00 00       	call   801fbb <sys_calculate_free_frames>
  800806:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800809:	e8 30 18 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  80080e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(4*Mega-kilo);
  800811:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800814:	c1 e0 02             	shl    $0x2,%eax
  800817:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80081a:	83 ec 0c             	sub    $0xc,%esp
  80081d:	50                   	push   %eax
  80081e:	e8 22 12 00 00       	call   801a45 <malloc>
  800823:	83 c4 10             	add    $0x10,%esp
  800826:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800829:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80082c:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800831:	74 17                	je     80084a <_main+0x812>
  800833:	83 ec 04             	sub    $0x4,%esp
  800836:	68 b8 27 80 00       	push   $0x8027b8
  80083b:	68 a9 00 00 00       	push   $0xa9
  800840:	68 5c 27 80 00       	push   $0x80275c
  800845:	e8 ba 01 00 00       	call   800a04 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 4*Mega/4096) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*Mega/4096) panic("Wrong page file allocation: ");
  80084a:	e8 ef 17 00 00       	call   80203e <sys_pf_calculate_allocated_pages>
  80084f:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800852:	89 c2                	mov    %eax,%edx
  800854:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800857:	c1 e0 02             	shl    $0x2,%eax
  80085a:	85 c0                	test   %eax,%eax
  80085c:	79 05                	jns    800863 <_main+0x82b>
  80085e:	05 ff 0f 00 00       	add    $0xfff,%eax
  800863:	c1 f8 0c             	sar    $0xc,%eax
  800866:	39 c2                	cmp    %eax,%edx
  800868:	74 17                	je     800881 <_main+0x849>
  80086a:	83 ec 04             	sub    $0x4,%esp
  80086d:	68 e8 27 80 00       	push   $0x8027e8
  800872:	68 ab 00 00 00       	push   $0xab
  800877:	68 5c 27 80 00       	push   $0x80275c
  80087c:	e8 83 01 00 00       	call   800a04 <_panic>
	//	b) Attempt to allocate large segment with no suitable fragment to fit on
	{
		//Large Allocation
		//int freeFrames = sys_calculate_free_frames() ;
		//usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[12] = malloc((USER_HEAP_MAX - USER_HEAP_START - 14*Mega));
  800881:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800884:	89 d0                	mov    %edx,%eax
  800886:	01 c0                	add    %eax,%eax
  800888:	01 d0                	add    %edx,%eax
  80088a:	01 c0                	add    %eax,%eax
  80088c:	01 d0                	add    %edx,%eax
  80088e:	01 c0                	add    %eax,%eax
  800890:	f7 d8                	neg    %eax
  800892:	05 00 00 00 20       	add    $0x20000000,%eax
  800897:	83 ec 0c             	sub    $0xc,%esp
  80089a:	50                   	push   %eax
  80089b:	e8 a5 11 00 00       	call   801a45 <malloc>
  8008a0:	83 c4 10             	add    $0x10,%esp
  8008a3:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if (ptr_allocations[12] != NULL) panic("Malloc: Attempt to allocate large segment with no suitable fragment to fit on, should return NULL");
  8008a6:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8008a9:	85 c0                	test   %eax,%eax
  8008ab:	74 17                	je     8008c4 <_main+0x88c>
  8008ad:	83 ec 04             	sub    $0x4,%esp
  8008b0:	68 1c 28 80 00       	push   $0x80281c
  8008b5:	68 b4 00 00 00       	push   $0xb4
  8008ba:	68 5c 27 80 00       	push   $0x80275c
  8008bf:	e8 40 01 00 00       	call   800a04 <_panic>

		cprintf("Congratulations!! test BEST FIT allocation (2) completed successfully.\n");
  8008c4:	83 ec 0c             	sub    $0xc,%esp
  8008c7:	68 80 28 80 00       	push   $0x802880
  8008cc:	e8 ea 03 00 00       	call   800cbb <cprintf>
  8008d1:	83 c4 10             	add    $0x10,%esp

		return;
  8008d4:	90                   	nop
	}
}
  8008d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008d8:	5b                   	pop    %ebx
  8008d9:	5f                   	pop    %edi
  8008da:	5d                   	pop    %ebp
  8008db:	c3                   	ret    

008008dc <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8008dc:	55                   	push   %ebp
  8008dd:	89 e5                	mov    %esp,%ebp
  8008df:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8008e2:	e8 09 16 00 00       	call   801ef0 <sys_getenvindex>
  8008e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8008ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008ed:	89 d0                	mov    %edx,%eax
  8008ef:	01 c0                	add    %eax,%eax
  8008f1:	01 d0                	add    %edx,%eax
  8008f3:	c1 e0 07             	shl    $0x7,%eax
  8008f6:	29 d0                	sub    %edx,%eax
  8008f8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008ff:	01 c8                	add    %ecx,%eax
  800901:	01 c0                	add    %eax,%eax
  800903:	01 d0                	add    %edx,%eax
  800905:	01 c0                	add    %eax,%eax
  800907:	01 d0                	add    %edx,%eax
  800909:	c1 e0 03             	shl    $0x3,%eax
  80090c:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800911:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800916:	a1 20 30 80 00       	mov    0x803020,%eax
  80091b:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800921:	84 c0                	test   %al,%al
  800923:	74 0f                	je     800934 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800925:	a1 20 30 80 00       	mov    0x803020,%eax
  80092a:	05 f0 ee 00 00       	add    $0xeef0,%eax
  80092f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800934:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800938:	7e 0a                	jle    800944 <libmain+0x68>
		binaryname = argv[0];
  80093a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093d:	8b 00                	mov    (%eax),%eax
  80093f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800944:	83 ec 08             	sub    $0x8,%esp
  800947:	ff 75 0c             	pushl  0xc(%ebp)
  80094a:	ff 75 08             	pushl  0x8(%ebp)
  80094d:	e8 e6 f6 ff ff       	call   800038 <_main>
  800952:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800955:	e8 31 17 00 00       	call   80208b <sys_disable_interrupt>
	cprintf("**************************************\n");
  80095a:	83 ec 0c             	sub    $0xc,%esp
  80095d:	68 e0 28 80 00       	push   $0x8028e0
  800962:	e8 54 03 00 00       	call   800cbb <cprintf>
  800967:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80096a:	a1 20 30 80 00       	mov    0x803020,%eax
  80096f:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800975:	a1 20 30 80 00       	mov    0x803020,%eax
  80097a:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  800980:	83 ec 04             	sub    $0x4,%esp
  800983:	52                   	push   %edx
  800984:	50                   	push   %eax
  800985:	68 08 29 80 00       	push   $0x802908
  80098a:	e8 2c 03 00 00       	call   800cbb <cprintf>
  80098f:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800992:	a1 20 30 80 00       	mov    0x803020,%eax
  800997:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  80099d:	a1 20 30 80 00       	mov    0x803020,%eax
  8009a2:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  8009a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8009ad:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  8009b3:	51                   	push   %ecx
  8009b4:	52                   	push   %edx
  8009b5:	50                   	push   %eax
  8009b6:	68 30 29 80 00       	push   $0x802930
  8009bb:	e8 fb 02 00 00       	call   800cbb <cprintf>
  8009c0:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8009c3:	83 ec 0c             	sub    $0xc,%esp
  8009c6:	68 e0 28 80 00       	push   $0x8028e0
  8009cb:	e8 eb 02 00 00       	call   800cbb <cprintf>
  8009d0:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8009d3:	e8 cd 16 00 00       	call   8020a5 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8009d8:	e8 19 00 00 00       	call   8009f6 <exit>
}
  8009dd:	90                   	nop
  8009de:	c9                   	leave  
  8009df:	c3                   	ret    

008009e0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8009e0:	55                   	push   %ebp
  8009e1:	89 e5                	mov    %esp,%ebp
  8009e3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8009e6:	83 ec 0c             	sub    $0xc,%esp
  8009e9:	6a 00                	push   $0x0
  8009eb:	e8 cc 14 00 00       	call   801ebc <sys_env_destroy>
  8009f0:	83 c4 10             	add    $0x10,%esp
}
  8009f3:	90                   	nop
  8009f4:	c9                   	leave  
  8009f5:	c3                   	ret    

008009f6 <exit>:

void
exit(void)
{
  8009f6:	55                   	push   %ebp
  8009f7:	89 e5                	mov    %esp,%ebp
  8009f9:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8009fc:	e8 21 15 00 00       	call   801f22 <sys_env_exit>
}
  800a01:	90                   	nop
  800a02:	c9                   	leave  
  800a03:	c3                   	ret    

00800a04 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800a04:	55                   	push   %ebp
  800a05:	89 e5                	mov    %esp,%ebp
  800a07:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800a0a:	8d 45 10             	lea    0x10(%ebp),%eax
  800a0d:	83 c0 04             	add    $0x4,%eax
  800a10:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800a13:	a1 18 31 80 00       	mov    0x803118,%eax
  800a18:	85 c0                	test   %eax,%eax
  800a1a:	74 16                	je     800a32 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800a1c:	a1 18 31 80 00       	mov    0x803118,%eax
  800a21:	83 ec 08             	sub    $0x8,%esp
  800a24:	50                   	push   %eax
  800a25:	68 88 29 80 00       	push   $0x802988
  800a2a:	e8 8c 02 00 00       	call   800cbb <cprintf>
  800a2f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800a32:	a1 00 30 80 00       	mov    0x803000,%eax
  800a37:	ff 75 0c             	pushl  0xc(%ebp)
  800a3a:	ff 75 08             	pushl  0x8(%ebp)
  800a3d:	50                   	push   %eax
  800a3e:	68 8d 29 80 00       	push   $0x80298d
  800a43:	e8 73 02 00 00       	call   800cbb <cprintf>
  800a48:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800a4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800a4e:	83 ec 08             	sub    $0x8,%esp
  800a51:	ff 75 f4             	pushl  -0xc(%ebp)
  800a54:	50                   	push   %eax
  800a55:	e8 f6 01 00 00       	call   800c50 <vcprintf>
  800a5a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a5d:	83 ec 08             	sub    $0x8,%esp
  800a60:	6a 00                	push   $0x0
  800a62:	68 a9 29 80 00       	push   $0x8029a9
  800a67:	e8 e4 01 00 00       	call   800c50 <vcprintf>
  800a6c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a6f:	e8 82 ff ff ff       	call   8009f6 <exit>

	// should not return here
	while (1) ;
  800a74:	eb fe                	jmp    800a74 <_panic+0x70>

00800a76 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a76:	55                   	push   %ebp
  800a77:	89 e5                	mov    %esp,%ebp
  800a79:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a7c:	a1 20 30 80 00       	mov    0x803020,%eax
  800a81:	8b 50 74             	mov    0x74(%eax),%edx
  800a84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a87:	39 c2                	cmp    %eax,%edx
  800a89:	74 14                	je     800a9f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a8b:	83 ec 04             	sub    $0x4,%esp
  800a8e:	68 ac 29 80 00       	push   $0x8029ac
  800a93:	6a 26                	push   $0x26
  800a95:	68 f8 29 80 00       	push   $0x8029f8
  800a9a:	e8 65 ff ff ff       	call   800a04 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a9f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800aa6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800aad:	e9 c4 00 00 00       	jmp    800b76 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800ab2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ab5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800abc:	8b 45 08             	mov    0x8(%ebp),%eax
  800abf:	01 d0                	add    %edx,%eax
  800ac1:	8b 00                	mov    (%eax),%eax
  800ac3:	85 c0                	test   %eax,%eax
  800ac5:	75 08                	jne    800acf <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800ac7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800aca:	e9 a4 00 00 00       	jmp    800b73 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800acf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ad6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800add:	eb 6b                	jmp    800b4a <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800adf:	a1 20 30 80 00       	mov    0x803020,%eax
  800ae4:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800aea:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800aed:	89 d0                	mov    %edx,%eax
  800aef:	c1 e0 02             	shl    $0x2,%eax
  800af2:	01 d0                	add    %edx,%eax
  800af4:	c1 e0 02             	shl    $0x2,%eax
  800af7:	01 c8                	add    %ecx,%eax
  800af9:	8a 40 04             	mov    0x4(%eax),%al
  800afc:	84 c0                	test   %al,%al
  800afe:	75 47                	jne    800b47 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b00:	a1 20 30 80 00       	mov    0x803020,%eax
  800b05:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800b0b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b0e:	89 d0                	mov    %edx,%eax
  800b10:	c1 e0 02             	shl    $0x2,%eax
  800b13:	01 d0                	add    %edx,%eax
  800b15:	c1 e0 02             	shl    $0x2,%eax
  800b18:	01 c8                	add    %ecx,%eax
  800b1a:	8b 00                	mov    (%eax),%eax
  800b1c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800b1f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b22:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b27:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800b29:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b2c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	01 c8                	add    %ecx,%eax
  800b38:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b3a:	39 c2                	cmp    %eax,%edx
  800b3c:	75 09                	jne    800b47 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800b3e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b45:	eb 12                	jmp    800b59 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b47:	ff 45 e8             	incl   -0x18(%ebp)
  800b4a:	a1 20 30 80 00       	mov    0x803020,%eax
  800b4f:	8b 50 74             	mov    0x74(%eax),%edx
  800b52:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b55:	39 c2                	cmp    %eax,%edx
  800b57:	77 86                	ja     800adf <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b59:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b5d:	75 14                	jne    800b73 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800b5f:	83 ec 04             	sub    $0x4,%esp
  800b62:	68 04 2a 80 00       	push   $0x802a04
  800b67:	6a 3a                	push   $0x3a
  800b69:	68 f8 29 80 00       	push   $0x8029f8
  800b6e:	e8 91 fe ff ff       	call   800a04 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b73:	ff 45 f0             	incl   -0x10(%ebp)
  800b76:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b79:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b7c:	0f 8c 30 ff ff ff    	jl     800ab2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b82:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b89:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b90:	eb 27                	jmp    800bb9 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b92:	a1 20 30 80 00       	mov    0x803020,%eax
  800b97:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800b9d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ba0:	89 d0                	mov    %edx,%eax
  800ba2:	c1 e0 02             	shl    $0x2,%eax
  800ba5:	01 d0                	add    %edx,%eax
  800ba7:	c1 e0 02             	shl    $0x2,%eax
  800baa:	01 c8                	add    %ecx,%eax
  800bac:	8a 40 04             	mov    0x4(%eax),%al
  800baf:	3c 01                	cmp    $0x1,%al
  800bb1:	75 03                	jne    800bb6 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800bb3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800bb6:	ff 45 e0             	incl   -0x20(%ebp)
  800bb9:	a1 20 30 80 00       	mov    0x803020,%eax
  800bbe:	8b 50 74             	mov    0x74(%eax),%edx
  800bc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bc4:	39 c2                	cmp    %eax,%edx
  800bc6:	77 ca                	ja     800b92 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800bcb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800bce:	74 14                	je     800be4 <CheckWSWithoutLastIndex+0x16e>
		panic(
  800bd0:	83 ec 04             	sub    $0x4,%esp
  800bd3:	68 58 2a 80 00       	push   $0x802a58
  800bd8:	6a 44                	push   $0x44
  800bda:	68 f8 29 80 00       	push   $0x8029f8
  800bdf:	e8 20 fe ff ff       	call   800a04 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800be4:	90                   	nop
  800be5:	c9                   	leave  
  800be6:	c3                   	ret    

00800be7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800be7:	55                   	push   %ebp
  800be8:	89 e5                	mov    %esp,%ebp
  800bea:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800bed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf0:	8b 00                	mov    (%eax),%eax
  800bf2:	8d 48 01             	lea    0x1(%eax),%ecx
  800bf5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf8:	89 0a                	mov    %ecx,(%edx)
  800bfa:	8b 55 08             	mov    0x8(%ebp),%edx
  800bfd:	88 d1                	mov    %dl,%cl
  800bff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c02:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800c06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c09:	8b 00                	mov    (%eax),%eax
  800c0b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800c10:	75 2c                	jne    800c3e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800c12:	a0 24 30 80 00       	mov    0x803024,%al
  800c17:	0f b6 c0             	movzbl %al,%eax
  800c1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c1d:	8b 12                	mov    (%edx),%edx
  800c1f:	89 d1                	mov    %edx,%ecx
  800c21:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c24:	83 c2 08             	add    $0x8,%edx
  800c27:	83 ec 04             	sub    $0x4,%esp
  800c2a:	50                   	push   %eax
  800c2b:	51                   	push   %ecx
  800c2c:	52                   	push   %edx
  800c2d:	e8 48 12 00 00       	call   801e7a <sys_cputs>
  800c32:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800c35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c38:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c41:	8b 40 04             	mov    0x4(%eax),%eax
  800c44:	8d 50 01             	lea    0x1(%eax),%edx
  800c47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4a:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c4d:	90                   	nop
  800c4e:	c9                   	leave  
  800c4f:	c3                   	ret    

00800c50 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c50:	55                   	push   %ebp
  800c51:	89 e5                	mov    %esp,%ebp
  800c53:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c59:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c60:	00 00 00 
	b.cnt = 0;
  800c63:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c6a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c6d:	ff 75 0c             	pushl  0xc(%ebp)
  800c70:	ff 75 08             	pushl  0x8(%ebp)
  800c73:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c79:	50                   	push   %eax
  800c7a:	68 e7 0b 80 00       	push   $0x800be7
  800c7f:	e8 11 02 00 00       	call   800e95 <vprintfmt>
  800c84:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c87:	a0 24 30 80 00       	mov    0x803024,%al
  800c8c:	0f b6 c0             	movzbl %al,%eax
  800c8f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c95:	83 ec 04             	sub    $0x4,%esp
  800c98:	50                   	push   %eax
  800c99:	52                   	push   %edx
  800c9a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ca0:	83 c0 08             	add    $0x8,%eax
  800ca3:	50                   	push   %eax
  800ca4:	e8 d1 11 00 00       	call   801e7a <sys_cputs>
  800ca9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800cac:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800cb3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800cb9:	c9                   	leave  
  800cba:	c3                   	ret    

00800cbb <cprintf>:

int cprintf(const char *fmt, ...) {
  800cbb:	55                   	push   %ebp
  800cbc:	89 e5                	mov    %esp,%ebp
  800cbe:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800cc1:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800cc8:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ccb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	83 ec 08             	sub    $0x8,%esp
  800cd4:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd7:	50                   	push   %eax
  800cd8:	e8 73 ff ff ff       	call   800c50 <vcprintf>
  800cdd:	83 c4 10             	add    $0x10,%esp
  800ce0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ce3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ce6:	c9                   	leave  
  800ce7:	c3                   	ret    

00800ce8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ce8:	55                   	push   %ebp
  800ce9:	89 e5                	mov    %esp,%ebp
  800ceb:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800cee:	e8 98 13 00 00       	call   80208b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800cf3:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cf6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	83 ec 08             	sub    $0x8,%esp
  800cff:	ff 75 f4             	pushl  -0xc(%ebp)
  800d02:	50                   	push   %eax
  800d03:	e8 48 ff ff ff       	call   800c50 <vcprintf>
  800d08:	83 c4 10             	add    $0x10,%esp
  800d0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800d0e:	e8 92 13 00 00       	call   8020a5 <sys_enable_interrupt>
	return cnt;
  800d13:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d16:	c9                   	leave  
  800d17:	c3                   	ret    

00800d18 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d18:	55                   	push   %ebp
  800d19:	89 e5                	mov    %esp,%ebp
  800d1b:	53                   	push   %ebx
  800d1c:	83 ec 14             	sub    $0x14,%esp
  800d1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d25:	8b 45 14             	mov    0x14(%ebp),%eax
  800d28:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d2b:	8b 45 18             	mov    0x18(%ebp),%eax
  800d2e:	ba 00 00 00 00       	mov    $0x0,%edx
  800d33:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d36:	77 55                	ja     800d8d <printnum+0x75>
  800d38:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d3b:	72 05                	jb     800d42 <printnum+0x2a>
  800d3d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d40:	77 4b                	ja     800d8d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d42:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d45:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d48:	8b 45 18             	mov    0x18(%ebp),%eax
  800d4b:	ba 00 00 00 00       	mov    $0x0,%edx
  800d50:	52                   	push   %edx
  800d51:	50                   	push   %eax
  800d52:	ff 75 f4             	pushl  -0xc(%ebp)
  800d55:	ff 75 f0             	pushl  -0x10(%ebp)
  800d58:	e8 6b 17 00 00       	call   8024c8 <__udivdi3>
  800d5d:	83 c4 10             	add    $0x10,%esp
  800d60:	83 ec 04             	sub    $0x4,%esp
  800d63:	ff 75 20             	pushl  0x20(%ebp)
  800d66:	53                   	push   %ebx
  800d67:	ff 75 18             	pushl  0x18(%ebp)
  800d6a:	52                   	push   %edx
  800d6b:	50                   	push   %eax
  800d6c:	ff 75 0c             	pushl  0xc(%ebp)
  800d6f:	ff 75 08             	pushl  0x8(%ebp)
  800d72:	e8 a1 ff ff ff       	call   800d18 <printnum>
  800d77:	83 c4 20             	add    $0x20,%esp
  800d7a:	eb 1a                	jmp    800d96 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d7c:	83 ec 08             	sub    $0x8,%esp
  800d7f:	ff 75 0c             	pushl  0xc(%ebp)
  800d82:	ff 75 20             	pushl  0x20(%ebp)
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	ff d0                	call   *%eax
  800d8a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d8d:	ff 4d 1c             	decl   0x1c(%ebp)
  800d90:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d94:	7f e6                	jg     800d7c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d96:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d99:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800da1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800da4:	53                   	push   %ebx
  800da5:	51                   	push   %ecx
  800da6:	52                   	push   %edx
  800da7:	50                   	push   %eax
  800da8:	e8 2b 18 00 00       	call   8025d8 <__umoddi3>
  800dad:	83 c4 10             	add    $0x10,%esp
  800db0:	05 d4 2c 80 00       	add    $0x802cd4,%eax
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	0f be c0             	movsbl %al,%eax
  800dba:	83 ec 08             	sub    $0x8,%esp
  800dbd:	ff 75 0c             	pushl  0xc(%ebp)
  800dc0:	50                   	push   %eax
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	ff d0                	call   *%eax
  800dc6:	83 c4 10             	add    $0x10,%esp
}
  800dc9:	90                   	nop
  800dca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800dcd:	c9                   	leave  
  800dce:	c3                   	ret    

00800dcf <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800dcf:	55                   	push   %ebp
  800dd0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800dd2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800dd6:	7e 1c                	jle    800df4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	8b 00                	mov    (%eax),%eax
  800ddd:	8d 50 08             	lea    0x8(%eax),%edx
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	89 10                	mov    %edx,(%eax)
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	8b 00                	mov    (%eax),%eax
  800dea:	83 e8 08             	sub    $0x8,%eax
  800ded:	8b 50 04             	mov    0x4(%eax),%edx
  800df0:	8b 00                	mov    (%eax),%eax
  800df2:	eb 40                	jmp    800e34 <getuint+0x65>
	else if (lflag)
  800df4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800df8:	74 1e                	je     800e18 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfd:	8b 00                	mov    (%eax),%eax
  800dff:	8d 50 04             	lea    0x4(%eax),%edx
  800e02:	8b 45 08             	mov    0x8(%ebp),%eax
  800e05:	89 10                	mov    %edx,(%eax)
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	8b 00                	mov    (%eax),%eax
  800e0c:	83 e8 04             	sub    $0x4,%eax
  800e0f:	8b 00                	mov    (%eax),%eax
  800e11:	ba 00 00 00 00       	mov    $0x0,%edx
  800e16:	eb 1c                	jmp    800e34 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	8b 00                	mov    (%eax),%eax
  800e1d:	8d 50 04             	lea    0x4(%eax),%edx
  800e20:	8b 45 08             	mov    0x8(%ebp),%eax
  800e23:	89 10                	mov    %edx,(%eax)
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	8b 00                	mov    (%eax),%eax
  800e2a:	83 e8 04             	sub    $0x4,%eax
  800e2d:	8b 00                	mov    (%eax),%eax
  800e2f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e34:	5d                   	pop    %ebp
  800e35:	c3                   	ret    

00800e36 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e36:	55                   	push   %ebp
  800e37:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e39:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e3d:	7e 1c                	jle    800e5b <getint+0x25>
		return va_arg(*ap, long long);
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e42:	8b 00                	mov    (%eax),%eax
  800e44:	8d 50 08             	lea    0x8(%eax),%edx
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	89 10                	mov    %edx,(%eax)
  800e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4f:	8b 00                	mov    (%eax),%eax
  800e51:	83 e8 08             	sub    $0x8,%eax
  800e54:	8b 50 04             	mov    0x4(%eax),%edx
  800e57:	8b 00                	mov    (%eax),%eax
  800e59:	eb 38                	jmp    800e93 <getint+0x5d>
	else if (lflag)
  800e5b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e5f:	74 1a                	je     800e7b <getint+0x45>
		return va_arg(*ap, long);
  800e61:	8b 45 08             	mov    0x8(%ebp),%eax
  800e64:	8b 00                	mov    (%eax),%eax
  800e66:	8d 50 04             	lea    0x4(%eax),%edx
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	89 10                	mov    %edx,(%eax)
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	8b 00                	mov    (%eax),%eax
  800e73:	83 e8 04             	sub    $0x4,%eax
  800e76:	8b 00                	mov    (%eax),%eax
  800e78:	99                   	cltd   
  800e79:	eb 18                	jmp    800e93 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	8b 00                	mov    (%eax),%eax
  800e80:	8d 50 04             	lea    0x4(%eax),%edx
  800e83:	8b 45 08             	mov    0x8(%ebp),%eax
  800e86:	89 10                	mov    %edx,(%eax)
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	8b 00                	mov    (%eax),%eax
  800e8d:	83 e8 04             	sub    $0x4,%eax
  800e90:	8b 00                	mov    (%eax),%eax
  800e92:	99                   	cltd   
}
  800e93:	5d                   	pop    %ebp
  800e94:	c3                   	ret    

00800e95 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e95:	55                   	push   %ebp
  800e96:	89 e5                	mov    %esp,%ebp
  800e98:	56                   	push   %esi
  800e99:	53                   	push   %ebx
  800e9a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e9d:	eb 17                	jmp    800eb6 <vprintfmt+0x21>
			if (ch == '\0')
  800e9f:	85 db                	test   %ebx,%ebx
  800ea1:	0f 84 af 03 00 00    	je     801256 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ea7:	83 ec 08             	sub    $0x8,%esp
  800eaa:	ff 75 0c             	pushl  0xc(%ebp)
  800ead:	53                   	push   %ebx
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	ff d0                	call   *%eax
  800eb3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800eb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb9:	8d 50 01             	lea    0x1(%eax),%edx
  800ebc:	89 55 10             	mov    %edx,0x10(%ebp)
  800ebf:	8a 00                	mov    (%eax),%al
  800ec1:	0f b6 d8             	movzbl %al,%ebx
  800ec4:	83 fb 25             	cmp    $0x25,%ebx
  800ec7:	75 d6                	jne    800e9f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800ec9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ecd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ed4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800edb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ee2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ee9:	8b 45 10             	mov    0x10(%ebp),%eax
  800eec:	8d 50 01             	lea    0x1(%eax),%edx
  800eef:	89 55 10             	mov    %edx,0x10(%ebp)
  800ef2:	8a 00                	mov    (%eax),%al
  800ef4:	0f b6 d8             	movzbl %al,%ebx
  800ef7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800efa:	83 f8 55             	cmp    $0x55,%eax
  800efd:	0f 87 2b 03 00 00    	ja     80122e <vprintfmt+0x399>
  800f03:	8b 04 85 f8 2c 80 00 	mov    0x802cf8(,%eax,4),%eax
  800f0a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800f0c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f10:	eb d7                	jmp    800ee9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f12:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f16:	eb d1                	jmp    800ee9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f18:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f1f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f22:	89 d0                	mov    %edx,%eax
  800f24:	c1 e0 02             	shl    $0x2,%eax
  800f27:	01 d0                	add    %edx,%eax
  800f29:	01 c0                	add    %eax,%eax
  800f2b:	01 d8                	add    %ebx,%eax
  800f2d:	83 e8 30             	sub    $0x30,%eax
  800f30:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f33:	8b 45 10             	mov    0x10(%ebp),%eax
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f3b:	83 fb 2f             	cmp    $0x2f,%ebx
  800f3e:	7e 3e                	jle    800f7e <vprintfmt+0xe9>
  800f40:	83 fb 39             	cmp    $0x39,%ebx
  800f43:	7f 39                	jg     800f7e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f45:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f48:	eb d5                	jmp    800f1f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f4a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4d:	83 c0 04             	add    $0x4,%eax
  800f50:	89 45 14             	mov    %eax,0x14(%ebp)
  800f53:	8b 45 14             	mov    0x14(%ebp),%eax
  800f56:	83 e8 04             	sub    $0x4,%eax
  800f59:	8b 00                	mov    (%eax),%eax
  800f5b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f5e:	eb 1f                	jmp    800f7f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f60:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f64:	79 83                	jns    800ee9 <vprintfmt+0x54>
				width = 0;
  800f66:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f6d:	e9 77 ff ff ff       	jmp    800ee9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f72:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f79:	e9 6b ff ff ff       	jmp    800ee9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f7e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f7f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f83:	0f 89 60 ff ff ff    	jns    800ee9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800f89:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f8c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f8f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f96:	e9 4e ff ff ff       	jmp    800ee9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f9b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f9e:	e9 46 ff ff ff       	jmp    800ee9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800fa3:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa6:	83 c0 04             	add    $0x4,%eax
  800fa9:	89 45 14             	mov    %eax,0x14(%ebp)
  800fac:	8b 45 14             	mov    0x14(%ebp),%eax
  800faf:	83 e8 04             	sub    $0x4,%eax
  800fb2:	8b 00                	mov    (%eax),%eax
  800fb4:	83 ec 08             	sub    $0x8,%esp
  800fb7:	ff 75 0c             	pushl  0xc(%ebp)
  800fba:	50                   	push   %eax
  800fbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbe:	ff d0                	call   *%eax
  800fc0:	83 c4 10             	add    $0x10,%esp
			break;
  800fc3:	e9 89 02 00 00       	jmp    801251 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800fc8:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcb:	83 c0 04             	add    $0x4,%eax
  800fce:	89 45 14             	mov    %eax,0x14(%ebp)
  800fd1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd4:	83 e8 04             	sub    $0x4,%eax
  800fd7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fd9:	85 db                	test   %ebx,%ebx
  800fdb:	79 02                	jns    800fdf <vprintfmt+0x14a>
				err = -err;
  800fdd:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fdf:	83 fb 64             	cmp    $0x64,%ebx
  800fe2:	7f 0b                	jg     800fef <vprintfmt+0x15a>
  800fe4:	8b 34 9d 40 2b 80 00 	mov    0x802b40(,%ebx,4),%esi
  800feb:	85 f6                	test   %esi,%esi
  800fed:	75 19                	jne    801008 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800fef:	53                   	push   %ebx
  800ff0:	68 e5 2c 80 00       	push   $0x802ce5
  800ff5:	ff 75 0c             	pushl  0xc(%ebp)
  800ff8:	ff 75 08             	pushl  0x8(%ebp)
  800ffb:	e8 5e 02 00 00       	call   80125e <printfmt>
  801000:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801003:	e9 49 02 00 00       	jmp    801251 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801008:	56                   	push   %esi
  801009:	68 ee 2c 80 00       	push   $0x802cee
  80100e:	ff 75 0c             	pushl  0xc(%ebp)
  801011:	ff 75 08             	pushl  0x8(%ebp)
  801014:	e8 45 02 00 00       	call   80125e <printfmt>
  801019:	83 c4 10             	add    $0x10,%esp
			break;
  80101c:	e9 30 02 00 00       	jmp    801251 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801021:	8b 45 14             	mov    0x14(%ebp),%eax
  801024:	83 c0 04             	add    $0x4,%eax
  801027:	89 45 14             	mov    %eax,0x14(%ebp)
  80102a:	8b 45 14             	mov    0x14(%ebp),%eax
  80102d:	83 e8 04             	sub    $0x4,%eax
  801030:	8b 30                	mov    (%eax),%esi
  801032:	85 f6                	test   %esi,%esi
  801034:	75 05                	jne    80103b <vprintfmt+0x1a6>
				p = "(null)";
  801036:	be f1 2c 80 00       	mov    $0x802cf1,%esi
			if (width > 0 && padc != '-')
  80103b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80103f:	7e 6d                	jle    8010ae <vprintfmt+0x219>
  801041:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801045:	74 67                	je     8010ae <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801047:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80104a:	83 ec 08             	sub    $0x8,%esp
  80104d:	50                   	push   %eax
  80104e:	56                   	push   %esi
  80104f:	e8 0c 03 00 00       	call   801360 <strnlen>
  801054:	83 c4 10             	add    $0x10,%esp
  801057:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80105a:	eb 16                	jmp    801072 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80105c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801060:	83 ec 08             	sub    $0x8,%esp
  801063:	ff 75 0c             	pushl  0xc(%ebp)
  801066:	50                   	push   %eax
  801067:	8b 45 08             	mov    0x8(%ebp),%eax
  80106a:	ff d0                	call   *%eax
  80106c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80106f:	ff 4d e4             	decl   -0x1c(%ebp)
  801072:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801076:	7f e4                	jg     80105c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801078:	eb 34                	jmp    8010ae <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80107a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80107e:	74 1c                	je     80109c <vprintfmt+0x207>
  801080:	83 fb 1f             	cmp    $0x1f,%ebx
  801083:	7e 05                	jle    80108a <vprintfmt+0x1f5>
  801085:	83 fb 7e             	cmp    $0x7e,%ebx
  801088:	7e 12                	jle    80109c <vprintfmt+0x207>
					putch('?', putdat);
  80108a:	83 ec 08             	sub    $0x8,%esp
  80108d:	ff 75 0c             	pushl  0xc(%ebp)
  801090:	6a 3f                	push   $0x3f
  801092:	8b 45 08             	mov    0x8(%ebp),%eax
  801095:	ff d0                	call   *%eax
  801097:	83 c4 10             	add    $0x10,%esp
  80109a:	eb 0f                	jmp    8010ab <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80109c:	83 ec 08             	sub    $0x8,%esp
  80109f:	ff 75 0c             	pushl  0xc(%ebp)
  8010a2:	53                   	push   %ebx
  8010a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a6:	ff d0                	call   *%eax
  8010a8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010ab:	ff 4d e4             	decl   -0x1c(%ebp)
  8010ae:	89 f0                	mov    %esi,%eax
  8010b0:	8d 70 01             	lea    0x1(%eax),%esi
  8010b3:	8a 00                	mov    (%eax),%al
  8010b5:	0f be d8             	movsbl %al,%ebx
  8010b8:	85 db                	test   %ebx,%ebx
  8010ba:	74 24                	je     8010e0 <vprintfmt+0x24b>
  8010bc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010c0:	78 b8                	js     80107a <vprintfmt+0x1e5>
  8010c2:	ff 4d e0             	decl   -0x20(%ebp)
  8010c5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010c9:	79 af                	jns    80107a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010cb:	eb 13                	jmp    8010e0 <vprintfmt+0x24b>
				putch(' ', putdat);
  8010cd:	83 ec 08             	sub    $0x8,%esp
  8010d0:	ff 75 0c             	pushl  0xc(%ebp)
  8010d3:	6a 20                	push   $0x20
  8010d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d8:	ff d0                	call   *%eax
  8010da:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010dd:	ff 4d e4             	decl   -0x1c(%ebp)
  8010e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010e4:	7f e7                	jg     8010cd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010e6:	e9 66 01 00 00       	jmp    801251 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010eb:	83 ec 08             	sub    $0x8,%esp
  8010ee:	ff 75 e8             	pushl  -0x18(%ebp)
  8010f1:	8d 45 14             	lea    0x14(%ebp),%eax
  8010f4:	50                   	push   %eax
  8010f5:	e8 3c fd ff ff       	call   800e36 <getint>
  8010fa:	83 c4 10             	add    $0x10,%esp
  8010fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801100:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801103:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801106:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801109:	85 d2                	test   %edx,%edx
  80110b:	79 23                	jns    801130 <vprintfmt+0x29b>
				putch('-', putdat);
  80110d:	83 ec 08             	sub    $0x8,%esp
  801110:	ff 75 0c             	pushl  0xc(%ebp)
  801113:	6a 2d                	push   $0x2d
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	ff d0                	call   *%eax
  80111a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80111d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801120:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801123:	f7 d8                	neg    %eax
  801125:	83 d2 00             	adc    $0x0,%edx
  801128:	f7 da                	neg    %edx
  80112a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80112d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801130:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801137:	e9 bc 00 00 00       	jmp    8011f8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80113c:	83 ec 08             	sub    $0x8,%esp
  80113f:	ff 75 e8             	pushl  -0x18(%ebp)
  801142:	8d 45 14             	lea    0x14(%ebp),%eax
  801145:	50                   	push   %eax
  801146:	e8 84 fc ff ff       	call   800dcf <getuint>
  80114b:	83 c4 10             	add    $0x10,%esp
  80114e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801151:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801154:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80115b:	e9 98 00 00 00       	jmp    8011f8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801160:	83 ec 08             	sub    $0x8,%esp
  801163:	ff 75 0c             	pushl  0xc(%ebp)
  801166:	6a 58                	push   $0x58
  801168:	8b 45 08             	mov    0x8(%ebp),%eax
  80116b:	ff d0                	call   *%eax
  80116d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801170:	83 ec 08             	sub    $0x8,%esp
  801173:	ff 75 0c             	pushl  0xc(%ebp)
  801176:	6a 58                	push   $0x58
  801178:	8b 45 08             	mov    0x8(%ebp),%eax
  80117b:	ff d0                	call   *%eax
  80117d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801180:	83 ec 08             	sub    $0x8,%esp
  801183:	ff 75 0c             	pushl  0xc(%ebp)
  801186:	6a 58                	push   $0x58
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	ff d0                	call   *%eax
  80118d:	83 c4 10             	add    $0x10,%esp
			break;
  801190:	e9 bc 00 00 00       	jmp    801251 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801195:	83 ec 08             	sub    $0x8,%esp
  801198:	ff 75 0c             	pushl  0xc(%ebp)
  80119b:	6a 30                	push   $0x30
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	ff d0                	call   *%eax
  8011a2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8011a5:	83 ec 08             	sub    $0x8,%esp
  8011a8:	ff 75 0c             	pushl  0xc(%ebp)
  8011ab:	6a 78                	push   $0x78
  8011ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b0:	ff d0                	call   *%eax
  8011b2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8011b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b8:	83 c0 04             	add    $0x4,%eax
  8011bb:	89 45 14             	mov    %eax,0x14(%ebp)
  8011be:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c1:	83 e8 04             	sub    $0x4,%eax
  8011c4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8011c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011d0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011d7:	eb 1f                	jmp    8011f8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011d9:	83 ec 08             	sub    $0x8,%esp
  8011dc:	ff 75 e8             	pushl  -0x18(%ebp)
  8011df:	8d 45 14             	lea    0x14(%ebp),%eax
  8011e2:	50                   	push   %eax
  8011e3:	e8 e7 fb ff ff       	call   800dcf <getuint>
  8011e8:	83 c4 10             	add    $0x10,%esp
  8011eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011ee:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011f1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011f8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011ff:	83 ec 04             	sub    $0x4,%esp
  801202:	52                   	push   %edx
  801203:	ff 75 e4             	pushl  -0x1c(%ebp)
  801206:	50                   	push   %eax
  801207:	ff 75 f4             	pushl  -0xc(%ebp)
  80120a:	ff 75 f0             	pushl  -0x10(%ebp)
  80120d:	ff 75 0c             	pushl  0xc(%ebp)
  801210:	ff 75 08             	pushl  0x8(%ebp)
  801213:	e8 00 fb ff ff       	call   800d18 <printnum>
  801218:	83 c4 20             	add    $0x20,%esp
			break;
  80121b:	eb 34                	jmp    801251 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80121d:	83 ec 08             	sub    $0x8,%esp
  801220:	ff 75 0c             	pushl  0xc(%ebp)
  801223:	53                   	push   %ebx
  801224:	8b 45 08             	mov    0x8(%ebp),%eax
  801227:	ff d0                	call   *%eax
  801229:	83 c4 10             	add    $0x10,%esp
			break;
  80122c:	eb 23                	jmp    801251 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80122e:	83 ec 08             	sub    $0x8,%esp
  801231:	ff 75 0c             	pushl  0xc(%ebp)
  801234:	6a 25                	push   $0x25
  801236:	8b 45 08             	mov    0x8(%ebp),%eax
  801239:	ff d0                	call   *%eax
  80123b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80123e:	ff 4d 10             	decl   0x10(%ebp)
  801241:	eb 03                	jmp    801246 <vprintfmt+0x3b1>
  801243:	ff 4d 10             	decl   0x10(%ebp)
  801246:	8b 45 10             	mov    0x10(%ebp),%eax
  801249:	48                   	dec    %eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	3c 25                	cmp    $0x25,%al
  80124e:	75 f3                	jne    801243 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801250:	90                   	nop
		}
	}
  801251:	e9 47 fc ff ff       	jmp    800e9d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801256:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801257:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80125a:	5b                   	pop    %ebx
  80125b:	5e                   	pop    %esi
  80125c:	5d                   	pop    %ebp
  80125d:	c3                   	ret    

0080125e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80125e:	55                   	push   %ebp
  80125f:	89 e5                	mov    %esp,%ebp
  801261:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801264:	8d 45 10             	lea    0x10(%ebp),%eax
  801267:	83 c0 04             	add    $0x4,%eax
  80126a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80126d:	8b 45 10             	mov    0x10(%ebp),%eax
  801270:	ff 75 f4             	pushl  -0xc(%ebp)
  801273:	50                   	push   %eax
  801274:	ff 75 0c             	pushl  0xc(%ebp)
  801277:	ff 75 08             	pushl  0x8(%ebp)
  80127a:	e8 16 fc ff ff       	call   800e95 <vprintfmt>
  80127f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801282:	90                   	nop
  801283:	c9                   	leave  
  801284:	c3                   	ret    

00801285 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801285:	55                   	push   %ebp
  801286:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801288:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128b:	8b 40 08             	mov    0x8(%eax),%eax
  80128e:	8d 50 01             	lea    0x1(%eax),%edx
  801291:	8b 45 0c             	mov    0xc(%ebp),%eax
  801294:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129a:	8b 10                	mov    (%eax),%edx
  80129c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129f:	8b 40 04             	mov    0x4(%eax),%eax
  8012a2:	39 c2                	cmp    %eax,%edx
  8012a4:	73 12                	jae    8012b8 <sprintputch+0x33>
		*b->buf++ = ch;
  8012a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a9:	8b 00                	mov    (%eax),%eax
  8012ab:	8d 48 01             	lea    0x1(%eax),%ecx
  8012ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b1:	89 0a                	mov    %ecx,(%edx)
  8012b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8012b6:	88 10                	mov    %dl,(%eax)
}
  8012b8:	90                   	nop
  8012b9:	5d                   	pop    %ebp
  8012ba:	c3                   	ret    

008012bb <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8012bb:	55                   	push   %ebp
  8012bc:	89 e5                	mov    %esp,%ebp
  8012be:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ca:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	01 d0                	add    %edx,%eax
  8012d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012e0:	74 06                	je     8012e8 <vsnprintf+0x2d>
  8012e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012e6:	7f 07                	jg     8012ef <vsnprintf+0x34>
		return -E_INVAL;
  8012e8:	b8 03 00 00 00       	mov    $0x3,%eax
  8012ed:	eb 20                	jmp    80130f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012ef:	ff 75 14             	pushl  0x14(%ebp)
  8012f2:	ff 75 10             	pushl  0x10(%ebp)
  8012f5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012f8:	50                   	push   %eax
  8012f9:	68 85 12 80 00       	push   $0x801285
  8012fe:	e8 92 fb ff ff       	call   800e95 <vprintfmt>
  801303:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801306:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801309:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80130c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80130f:	c9                   	leave  
  801310:	c3                   	ret    

00801311 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801311:	55                   	push   %ebp
  801312:	89 e5                	mov    %esp,%ebp
  801314:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801317:	8d 45 10             	lea    0x10(%ebp),%eax
  80131a:	83 c0 04             	add    $0x4,%eax
  80131d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801320:	8b 45 10             	mov    0x10(%ebp),%eax
  801323:	ff 75 f4             	pushl  -0xc(%ebp)
  801326:	50                   	push   %eax
  801327:	ff 75 0c             	pushl  0xc(%ebp)
  80132a:	ff 75 08             	pushl  0x8(%ebp)
  80132d:	e8 89 ff ff ff       	call   8012bb <vsnprintf>
  801332:	83 c4 10             	add    $0x10,%esp
  801335:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801338:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80133b:	c9                   	leave  
  80133c:	c3                   	ret    

0080133d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80133d:	55                   	push   %ebp
  80133e:	89 e5                	mov    %esp,%ebp
  801340:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801343:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80134a:	eb 06                	jmp    801352 <strlen+0x15>
		n++;
  80134c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80134f:	ff 45 08             	incl   0x8(%ebp)
  801352:	8b 45 08             	mov    0x8(%ebp),%eax
  801355:	8a 00                	mov    (%eax),%al
  801357:	84 c0                	test   %al,%al
  801359:	75 f1                	jne    80134c <strlen+0xf>
		n++;
	return n;
  80135b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80135e:	c9                   	leave  
  80135f:	c3                   	ret    

00801360 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801360:	55                   	push   %ebp
  801361:	89 e5                	mov    %esp,%ebp
  801363:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801366:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80136d:	eb 09                	jmp    801378 <strnlen+0x18>
		n++;
  80136f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801372:	ff 45 08             	incl   0x8(%ebp)
  801375:	ff 4d 0c             	decl   0xc(%ebp)
  801378:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80137c:	74 09                	je     801387 <strnlen+0x27>
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	8a 00                	mov    (%eax),%al
  801383:	84 c0                	test   %al,%al
  801385:	75 e8                	jne    80136f <strnlen+0xf>
		n++;
	return n;
  801387:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80138a:	c9                   	leave  
  80138b:	c3                   	ret    

0080138c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80138c:	55                   	push   %ebp
  80138d:	89 e5                	mov    %esp,%ebp
  80138f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801398:	90                   	nop
  801399:	8b 45 08             	mov    0x8(%ebp),%eax
  80139c:	8d 50 01             	lea    0x1(%eax),%edx
  80139f:	89 55 08             	mov    %edx,0x8(%ebp)
  8013a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013a8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013ab:	8a 12                	mov    (%edx),%dl
  8013ad:	88 10                	mov    %dl,(%eax)
  8013af:	8a 00                	mov    (%eax),%al
  8013b1:	84 c0                	test   %al,%al
  8013b3:	75 e4                	jne    801399 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013b8:	c9                   	leave  
  8013b9:	c3                   	ret    

008013ba <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013ba:	55                   	push   %ebp
  8013bb:	89 e5                	mov    %esp,%ebp
  8013bd:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013cd:	eb 1f                	jmp    8013ee <strncpy+0x34>
		*dst++ = *src;
  8013cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d2:	8d 50 01             	lea    0x1(%eax),%edx
  8013d5:	89 55 08             	mov    %edx,0x8(%ebp)
  8013d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013db:	8a 12                	mov    (%edx),%dl
  8013dd:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e2:	8a 00                	mov    (%eax),%al
  8013e4:	84 c0                	test   %al,%al
  8013e6:	74 03                	je     8013eb <strncpy+0x31>
			src++;
  8013e8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013eb:	ff 45 fc             	incl   -0x4(%ebp)
  8013ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013f4:	72 d9                	jb     8013cf <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
  8013fe:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801407:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80140b:	74 30                	je     80143d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80140d:	eb 16                	jmp    801425 <strlcpy+0x2a>
			*dst++ = *src++;
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	8d 50 01             	lea    0x1(%eax),%edx
  801415:	89 55 08             	mov    %edx,0x8(%ebp)
  801418:	8b 55 0c             	mov    0xc(%ebp),%edx
  80141b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80141e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801421:	8a 12                	mov    (%edx),%dl
  801423:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801425:	ff 4d 10             	decl   0x10(%ebp)
  801428:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80142c:	74 09                	je     801437 <strlcpy+0x3c>
  80142e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801431:	8a 00                	mov    (%eax),%al
  801433:	84 c0                	test   %al,%al
  801435:	75 d8                	jne    80140f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801437:	8b 45 08             	mov    0x8(%ebp),%eax
  80143a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80143d:	8b 55 08             	mov    0x8(%ebp),%edx
  801440:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801443:	29 c2                	sub    %eax,%edx
  801445:	89 d0                	mov    %edx,%eax
}
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80144c:	eb 06                	jmp    801454 <strcmp+0xb>
		p++, q++;
  80144e:	ff 45 08             	incl   0x8(%ebp)
  801451:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801454:	8b 45 08             	mov    0x8(%ebp),%eax
  801457:	8a 00                	mov    (%eax),%al
  801459:	84 c0                	test   %al,%al
  80145b:	74 0e                	je     80146b <strcmp+0x22>
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	8a 10                	mov    (%eax),%dl
  801462:	8b 45 0c             	mov    0xc(%ebp),%eax
  801465:	8a 00                	mov    (%eax),%al
  801467:	38 c2                	cmp    %al,%dl
  801469:	74 e3                	je     80144e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	8a 00                	mov    (%eax),%al
  801470:	0f b6 d0             	movzbl %al,%edx
  801473:	8b 45 0c             	mov    0xc(%ebp),%eax
  801476:	8a 00                	mov    (%eax),%al
  801478:	0f b6 c0             	movzbl %al,%eax
  80147b:	29 c2                	sub    %eax,%edx
  80147d:	89 d0                	mov    %edx,%eax
}
  80147f:	5d                   	pop    %ebp
  801480:	c3                   	ret    

00801481 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801484:	eb 09                	jmp    80148f <strncmp+0xe>
		n--, p++, q++;
  801486:	ff 4d 10             	decl   0x10(%ebp)
  801489:	ff 45 08             	incl   0x8(%ebp)
  80148c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80148f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801493:	74 17                	je     8014ac <strncmp+0x2b>
  801495:	8b 45 08             	mov    0x8(%ebp),%eax
  801498:	8a 00                	mov    (%eax),%al
  80149a:	84 c0                	test   %al,%al
  80149c:	74 0e                	je     8014ac <strncmp+0x2b>
  80149e:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a1:	8a 10                	mov    (%eax),%dl
  8014a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a6:	8a 00                	mov    (%eax),%al
  8014a8:	38 c2                	cmp    %al,%dl
  8014aa:	74 da                	je     801486 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014b0:	75 07                	jne    8014b9 <strncmp+0x38>
		return 0;
  8014b2:	b8 00 00 00 00       	mov    $0x0,%eax
  8014b7:	eb 14                	jmp    8014cd <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	8a 00                	mov    (%eax),%al
  8014be:	0f b6 d0             	movzbl %al,%edx
  8014c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c4:	8a 00                	mov    (%eax),%al
  8014c6:	0f b6 c0             	movzbl %al,%eax
  8014c9:	29 c2                	sub    %eax,%edx
  8014cb:	89 d0                	mov    %edx,%eax
}
  8014cd:	5d                   	pop    %ebp
  8014ce:	c3                   	ret    

008014cf <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014cf:	55                   	push   %ebp
  8014d0:	89 e5                	mov    %esp,%ebp
  8014d2:	83 ec 04             	sub    $0x4,%esp
  8014d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014db:	eb 12                	jmp    8014ef <strchr+0x20>
		if (*s == c)
  8014dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e0:	8a 00                	mov    (%eax),%al
  8014e2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014e5:	75 05                	jne    8014ec <strchr+0x1d>
			return (char *) s;
  8014e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ea:	eb 11                	jmp    8014fd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014ec:	ff 45 08             	incl   0x8(%ebp)
  8014ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f2:	8a 00                	mov    (%eax),%al
  8014f4:	84 c0                	test   %al,%al
  8014f6:	75 e5                	jne    8014dd <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014fd:	c9                   	leave  
  8014fe:	c3                   	ret    

008014ff <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014ff:	55                   	push   %ebp
  801500:	89 e5                	mov    %esp,%ebp
  801502:	83 ec 04             	sub    $0x4,%esp
  801505:	8b 45 0c             	mov    0xc(%ebp),%eax
  801508:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80150b:	eb 0d                	jmp    80151a <strfind+0x1b>
		if (*s == c)
  80150d:	8b 45 08             	mov    0x8(%ebp),%eax
  801510:	8a 00                	mov    (%eax),%al
  801512:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801515:	74 0e                	je     801525 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801517:	ff 45 08             	incl   0x8(%ebp)
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	8a 00                	mov    (%eax),%al
  80151f:	84 c0                	test   %al,%al
  801521:	75 ea                	jne    80150d <strfind+0xe>
  801523:	eb 01                	jmp    801526 <strfind+0x27>
		if (*s == c)
			break;
  801525:	90                   	nop
	return (char *) s;
  801526:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801529:	c9                   	leave  
  80152a:	c3                   	ret    

0080152b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
  80152e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801531:	8b 45 08             	mov    0x8(%ebp),%eax
  801534:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801537:	8b 45 10             	mov    0x10(%ebp),%eax
  80153a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80153d:	eb 0e                	jmp    80154d <memset+0x22>
		*p++ = c;
  80153f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801542:	8d 50 01             	lea    0x1(%eax),%edx
  801545:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801548:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80154d:	ff 4d f8             	decl   -0x8(%ebp)
  801550:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801554:	79 e9                	jns    80153f <memset+0x14>
		*p++ = c;

	return v;
  801556:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801559:	c9                   	leave  
  80155a:	c3                   	ret    

0080155b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80155b:	55                   	push   %ebp
  80155c:	89 e5                	mov    %esp,%ebp
  80155e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801561:	8b 45 0c             	mov    0xc(%ebp),%eax
  801564:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801567:	8b 45 08             	mov    0x8(%ebp),%eax
  80156a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80156d:	eb 16                	jmp    801585 <memcpy+0x2a>
		*d++ = *s++;
  80156f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801572:	8d 50 01             	lea    0x1(%eax),%edx
  801575:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801578:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80157b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80157e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801581:	8a 12                	mov    (%edx),%dl
  801583:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801585:	8b 45 10             	mov    0x10(%ebp),%eax
  801588:	8d 50 ff             	lea    -0x1(%eax),%edx
  80158b:	89 55 10             	mov    %edx,0x10(%ebp)
  80158e:	85 c0                	test   %eax,%eax
  801590:	75 dd                	jne    80156f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801592:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801595:	c9                   	leave  
  801596:	c3                   	ret    

00801597 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801597:	55                   	push   %ebp
  801598:	89 e5                	mov    %esp,%ebp
  80159a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80159d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8015a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8015a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015af:	73 50                	jae    801601 <memmove+0x6a>
  8015b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b7:	01 d0                	add    %edx,%eax
  8015b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015bc:	76 43                	jbe    801601 <memmove+0x6a>
		s += n;
  8015be:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c1:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c7:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015ca:	eb 10                	jmp    8015dc <memmove+0x45>
			*--d = *--s;
  8015cc:	ff 4d f8             	decl   -0x8(%ebp)
  8015cf:	ff 4d fc             	decl   -0x4(%ebp)
  8015d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d5:	8a 10                	mov    (%eax),%dl
  8015d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015da:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015df:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8015e5:	85 c0                	test   %eax,%eax
  8015e7:	75 e3                	jne    8015cc <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015e9:	eb 23                	jmp    80160e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ee:	8d 50 01             	lea    0x1(%eax),%edx
  8015f1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015fa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015fd:	8a 12                	mov    (%edx),%dl
  8015ff:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801601:	8b 45 10             	mov    0x10(%ebp),%eax
  801604:	8d 50 ff             	lea    -0x1(%eax),%edx
  801607:	89 55 10             	mov    %edx,0x10(%ebp)
  80160a:	85 c0                	test   %eax,%eax
  80160c:	75 dd                	jne    8015eb <memmove+0x54>
			*d++ = *s++;

	return dst;
  80160e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801611:	c9                   	leave  
  801612:	c3                   	ret    

00801613 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801613:	55                   	push   %ebp
  801614:	89 e5                	mov    %esp,%ebp
  801616:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801619:	8b 45 08             	mov    0x8(%ebp),%eax
  80161c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80161f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801622:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801625:	eb 2a                	jmp    801651 <memcmp+0x3e>
		if (*s1 != *s2)
  801627:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80162a:	8a 10                	mov    (%eax),%dl
  80162c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80162f:	8a 00                	mov    (%eax),%al
  801631:	38 c2                	cmp    %al,%dl
  801633:	74 16                	je     80164b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801635:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801638:	8a 00                	mov    (%eax),%al
  80163a:	0f b6 d0             	movzbl %al,%edx
  80163d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801640:	8a 00                	mov    (%eax),%al
  801642:	0f b6 c0             	movzbl %al,%eax
  801645:	29 c2                	sub    %eax,%edx
  801647:	89 d0                	mov    %edx,%eax
  801649:	eb 18                	jmp    801663 <memcmp+0x50>
		s1++, s2++;
  80164b:	ff 45 fc             	incl   -0x4(%ebp)
  80164e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801651:	8b 45 10             	mov    0x10(%ebp),%eax
  801654:	8d 50 ff             	lea    -0x1(%eax),%edx
  801657:	89 55 10             	mov    %edx,0x10(%ebp)
  80165a:	85 c0                	test   %eax,%eax
  80165c:	75 c9                	jne    801627 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80165e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
  801668:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80166b:	8b 55 08             	mov    0x8(%ebp),%edx
  80166e:	8b 45 10             	mov    0x10(%ebp),%eax
  801671:	01 d0                	add    %edx,%eax
  801673:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801676:	eb 15                	jmp    80168d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801678:	8b 45 08             	mov    0x8(%ebp),%eax
  80167b:	8a 00                	mov    (%eax),%al
  80167d:	0f b6 d0             	movzbl %al,%edx
  801680:	8b 45 0c             	mov    0xc(%ebp),%eax
  801683:	0f b6 c0             	movzbl %al,%eax
  801686:	39 c2                	cmp    %eax,%edx
  801688:	74 0d                	je     801697 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80168a:	ff 45 08             	incl   0x8(%ebp)
  80168d:	8b 45 08             	mov    0x8(%ebp),%eax
  801690:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801693:	72 e3                	jb     801678 <memfind+0x13>
  801695:	eb 01                	jmp    801698 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801697:	90                   	nop
	return (void *) s;
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80169b:	c9                   	leave  
  80169c:	c3                   	ret    

0080169d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
  8016a0:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8016a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8016aa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016b1:	eb 03                	jmp    8016b6 <strtol+0x19>
		s++;
  8016b3:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	8a 00                	mov    (%eax),%al
  8016bb:	3c 20                	cmp    $0x20,%al
  8016bd:	74 f4                	je     8016b3 <strtol+0x16>
  8016bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c2:	8a 00                	mov    (%eax),%al
  8016c4:	3c 09                	cmp    $0x9,%al
  8016c6:	74 eb                	je     8016b3 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cb:	8a 00                	mov    (%eax),%al
  8016cd:	3c 2b                	cmp    $0x2b,%al
  8016cf:	75 05                	jne    8016d6 <strtol+0x39>
		s++;
  8016d1:	ff 45 08             	incl   0x8(%ebp)
  8016d4:	eb 13                	jmp    8016e9 <strtol+0x4c>
	else if (*s == '-')
  8016d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d9:	8a 00                	mov    (%eax),%al
  8016db:	3c 2d                	cmp    $0x2d,%al
  8016dd:	75 0a                	jne    8016e9 <strtol+0x4c>
		s++, neg = 1;
  8016df:	ff 45 08             	incl   0x8(%ebp)
  8016e2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016ed:	74 06                	je     8016f5 <strtol+0x58>
  8016ef:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016f3:	75 20                	jne    801715 <strtol+0x78>
  8016f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f8:	8a 00                	mov    (%eax),%al
  8016fa:	3c 30                	cmp    $0x30,%al
  8016fc:	75 17                	jne    801715 <strtol+0x78>
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	40                   	inc    %eax
  801702:	8a 00                	mov    (%eax),%al
  801704:	3c 78                	cmp    $0x78,%al
  801706:	75 0d                	jne    801715 <strtol+0x78>
		s += 2, base = 16;
  801708:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80170c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801713:	eb 28                	jmp    80173d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801715:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801719:	75 15                	jne    801730 <strtol+0x93>
  80171b:	8b 45 08             	mov    0x8(%ebp),%eax
  80171e:	8a 00                	mov    (%eax),%al
  801720:	3c 30                	cmp    $0x30,%al
  801722:	75 0c                	jne    801730 <strtol+0x93>
		s++, base = 8;
  801724:	ff 45 08             	incl   0x8(%ebp)
  801727:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80172e:	eb 0d                	jmp    80173d <strtol+0xa0>
	else if (base == 0)
  801730:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801734:	75 07                	jne    80173d <strtol+0xa0>
		base = 10;
  801736:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80173d:	8b 45 08             	mov    0x8(%ebp),%eax
  801740:	8a 00                	mov    (%eax),%al
  801742:	3c 2f                	cmp    $0x2f,%al
  801744:	7e 19                	jle    80175f <strtol+0xc2>
  801746:	8b 45 08             	mov    0x8(%ebp),%eax
  801749:	8a 00                	mov    (%eax),%al
  80174b:	3c 39                	cmp    $0x39,%al
  80174d:	7f 10                	jg     80175f <strtol+0xc2>
			dig = *s - '0';
  80174f:	8b 45 08             	mov    0x8(%ebp),%eax
  801752:	8a 00                	mov    (%eax),%al
  801754:	0f be c0             	movsbl %al,%eax
  801757:	83 e8 30             	sub    $0x30,%eax
  80175a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80175d:	eb 42                	jmp    8017a1 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80175f:	8b 45 08             	mov    0x8(%ebp),%eax
  801762:	8a 00                	mov    (%eax),%al
  801764:	3c 60                	cmp    $0x60,%al
  801766:	7e 19                	jle    801781 <strtol+0xe4>
  801768:	8b 45 08             	mov    0x8(%ebp),%eax
  80176b:	8a 00                	mov    (%eax),%al
  80176d:	3c 7a                	cmp    $0x7a,%al
  80176f:	7f 10                	jg     801781 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801771:	8b 45 08             	mov    0x8(%ebp),%eax
  801774:	8a 00                	mov    (%eax),%al
  801776:	0f be c0             	movsbl %al,%eax
  801779:	83 e8 57             	sub    $0x57,%eax
  80177c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80177f:	eb 20                	jmp    8017a1 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801781:	8b 45 08             	mov    0x8(%ebp),%eax
  801784:	8a 00                	mov    (%eax),%al
  801786:	3c 40                	cmp    $0x40,%al
  801788:	7e 39                	jle    8017c3 <strtol+0x126>
  80178a:	8b 45 08             	mov    0x8(%ebp),%eax
  80178d:	8a 00                	mov    (%eax),%al
  80178f:	3c 5a                	cmp    $0x5a,%al
  801791:	7f 30                	jg     8017c3 <strtol+0x126>
			dig = *s - 'A' + 10;
  801793:	8b 45 08             	mov    0x8(%ebp),%eax
  801796:	8a 00                	mov    (%eax),%al
  801798:	0f be c0             	movsbl %al,%eax
  80179b:	83 e8 37             	sub    $0x37,%eax
  80179e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8017a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017a4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8017a7:	7d 19                	jge    8017c2 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8017a9:	ff 45 08             	incl   0x8(%ebp)
  8017ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017af:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017b3:	89 c2                	mov    %eax,%edx
  8017b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017b8:	01 d0                	add    %edx,%eax
  8017ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017bd:	e9 7b ff ff ff       	jmp    80173d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017c2:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017c3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017c7:	74 08                	je     8017d1 <strtol+0x134>
		*endptr = (char *) s;
  8017c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017cc:	8b 55 08             	mov    0x8(%ebp),%edx
  8017cf:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017d5:	74 07                	je     8017de <strtol+0x141>
  8017d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017da:	f7 d8                	neg    %eax
  8017dc:	eb 03                	jmp    8017e1 <strtol+0x144>
  8017de:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017e1:	c9                   	leave  
  8017e2:	c3                   	ret    

008017e3 <ltostr>:

void
ltostr(long value, char *str)
{
  8017e3:	55                   	push   %ebp
  8017e4:	89 e5                	mov    %esp,%ebp
  8017e6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017fb:	79 13                	jns    801810 <ltostr+0x2d>
	{
		neg = 1;
  8017fd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801804:	8b 45 0c             	mov    0xc(%ebp),%eax
  801807:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80180a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80180d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801810:	8b 45 08             	mov    0x8(%ebp),%eax
  801813:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801818:	99                   	cltd   
  801819:	f7 f9                	idiv   %ecx
  80181b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80181e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801821:	8d 50 01             	lea    0x1(%eax),%edx
  801824:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801827:	89 c2                	mov    %eax,%edx
  801829:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182c:	01 d0                	add    %edx,%eax
  80182e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801831:	83 c2 30             	add    $0x30,%edx
  801834:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801836:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801839:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80183e:	f7 e9                	imul   %ecx
  801840:	c1 fa 02             	sar    $0x2,%edx
  801843:	89 c8                	mov    %ecx,%eax
  801845:	c1 f8 1f             	sar    $0x1f,%eax
  801848:	29 c2                	sub    %eax,%edx
  80184a:	89 d0                	mov    %edx,%eax
  80184c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80184f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801852:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801857:	f7 e9                	imul   %ecx
  801859:	c1 fa 02             	sar    $0x2,%edx
  80185c:	89 c8                	mov    %ecx,%eax
  80185e:	c1 f8 1f             	sar    $0x1f,%eax
  801861:	29 c2                	sub    %eax,%edx
  801863:	89 d0                	mov    %edx,%eax
  801865:	c1 e0 02             	shl    $0x2,%eax
  801868:	01 d0                	add    %edx,%eax
  80186a:	01 c0                	add    %eax,%eax
  80186c:	29 c1                	sub    %eax,%ecx
  80186e:	89 ca                	mov    %ecx,%edx
  801870:	85 d2                	test   %edx,%edx
  801872:	75 9c                	jne    801810 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801874:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80187b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187e:	48                   	dec    %eax
  80187f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801882:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801886:	74 3d                	je     8018c5 <ltostr+0xe2>
		start = 1 ;
  801888:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80188f:	eb 34                	jmp    8018c5 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801891:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801894:	8b 45 0c             	mov    0xc(%ebp),%eax
  801897:	01 d0                	add    %edx,%eax
  801899:	8a 00                	mov    (%eax),%al
  80189b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80189e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a4:	01 c2                	add    %eax,%edx
  8018a6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8018a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ac:	01 c8                	add    %ecx,%eax
  8018ae:	8a 00                	mov    (%eax),%al
  8018b0:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018b2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b8:	01 c2                	add    %eax,%edx
  8018ba:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018bd:	88 02                	mov    %al,(%edx)
		start++ ;
  8018bf:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018c2:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018cb:	7c c4                	jl     801891 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d3:	01 d0                	add    %edx,%eax
  8018d5:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018d8:	90                   	nop
  8018d9:	c9                   	leave  
  8018da:	c3                   	ret    

008018db <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018db:	55                   	push   %ebp
  8018dc:	89 e5                	mov    %esp,%ebp
  8018de:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018e1:	ff 75 08             	pushl  0x8(%ebp)
  8018e4:	e8 54 fa ff ff       	call   80133d <strlen>
  8018e9:	83 c4 04             	add    $0x4,%esp
  8018ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018ef:	ff 75 0c             	pushl  0xc(%ebp)
  8018f2:	e8 46 fa ff ff       	call   80133d <strlen>
  8018f7:	83 c4 04             	add    $0x4,%esp
  8018fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801904:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80190b:	eb 17                	jmp    801924 <strcconcat+0x49>
		final[s] = str1[s] ;
  80190d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801910:	8b 45 10             	mov    0x10(%ebp),%eax
  801913:	01 c2                	add    %eax,%edx
  801915:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801918:	8b 45 08             	mov    0x8(%ebp),%eax
  80191b:	01 c8                	add    %ecx,%eax
  80191d:	8a 00                	mov    (%eax),%al
  80191f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801921:	ff 45 fc             	incl   -0x4(%ebp)
  801924:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801927:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80192a:	7c e1                	jl     80190d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80192c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801933:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80193a:	eb 1f                	jmp    80195b <strcconcat+0x80>
		final[s++] = str2[i] ;
  80193c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80193f:	8d 50 01             	lea    0x1(%eax),%edx
  801942:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801945:	89 c2                	mov    %eax,%edx
  801947:	8b 45 10             	mov    0x10(%ebp),%eax
  80194a:	01 c2                	add    %eax,%edx
  80194c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80194f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801952:	01 c8                	add    %ecx,%eax
  801954:	8a 00                	mov    (%eax),%al
  801956:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801958:	ff 45 f8             	incl   -0x8(%ebp)
  80195b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80195e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801961:	7c d9                	jl     80193c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801963:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801966:	8b 45 10             	mov    0x10(%ebp),%eax
  801969:	01 d0                	add    %edx,%eax
  80196b:	c6 00 00             	movb   $0x0,(%eax)
}
  80196e:	90                   	nop
  80196f:	c9                   	leave  
  801970:	c3                   	ret    

00801971 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801971:	55                   	push   %ebp
  801972:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801974:	8b 45 14             	mov    0x14(%ebp),%eax
  801977:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80197d:	8b 45 14             	mov    0x14(%ebp),%eax
  801980:	8b 00                	mov    (%eax),%eax
  801982:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801989:	8b 45 10             	mov    0x10(%ebp),%eax
  80198c:	01 d0                	add    %edx,%eax
  80198e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801994:	eb 0c                	jmp    8019a2 <strsplit+0x31>
			*string++ = 0;
  801996:	8b 45 08             	mov    0x8(%ebp),%eax
  801999:	8d 50 01             	lea    0x1(%eax),%edx
  80199c:	89 55 08             	mov    %edx,0x8(%ebp)
  80199f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a5:	8a 00                	mov    (%eax),%al
  8019a7:	84 c0                	test   %al,%al
  8019a9:	74 18                	je     8019c3 <strsplit+0x52>
  8019ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ae:	8a 00                	mov    (%eax),%al
  8019b0:	0f be c0             	movsbl %al,%eax
  8019b3:	50                   	push   %eax
  8019b4:	ff 75 0c             	pushl  0xc(%ebp)
  8019b7:	e8 13 fb ff ff       	call   8014cf <strchr>
  8019bc:	83 c4 08             	add    $0x8,%esp
  8019bf:	85 c0                	test   %eax,%eax
  8019c1:	75 d3                	jne    801996 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8019c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c6:	8a 00                	mov    (%eax),%al
  8019c8:	84 c0                	test   %al,%al
  8019ca:	74 5a                	je     801a26 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8019cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8019cf:	8b 00                	mov    (%eax),%eax
  8019d1:	83 f8 0f             	cmp    $0xf,%eax
  8019d4:	75 07                	jne    8019dd <strsplit+0x6c>
		{
			return 0;
  8019d6:	b8 00 00 00 00       	mov    $0x0,%eax
  8019db:	eb 66                	jmp    801a43 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8019e0:	8b 00                	mov    (%eax),%eax
  8019e2:	8d 48 01             	lea    0x1(%eax),%ecx
  8019e5:	8b 55 14             	mov    0x14(%ebp),%edx
  8019e8:	89 0a                	mov    %ecx,(%edx)
  8019ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f4:	01 c2                	add    %eax,%edx
  8019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019fb:	eb 03                	jmp    801a00 <strsplit+0x8f>
			string++;
  8019fd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a00:	8b 45 08             	mov    0x8(%ebp),%eax
  801a03:	8a 00                	mov    (%eax),%al
  801a05:	84 c0                	test   %al,%al
  801a07:	74 8b                	je     801994 <strsplit+0x23>
  801a09:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0c:	8a 00                	mov    (%eax),%al
  801a0e:	0f be c0             	movsbl %al,%eax
  801a11:	50                   	push   %eax
  801a12:	ff 75 0c             	pushl  0xc(%ebp)
  801a15:	e8 b5 fa ff ff       	call   8014cf <strchr>
  801a1a:	83 c4 08             	add    $0x8,%esp
  801a1d:	85 c0                	test   %eax,%eax
  801a1f:	74 dc                	je     8019fd <strsplit+0x8c>
			string++;
	}
  801a21:	e9 6e ff ff ff       	jmp    801994 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a26:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a27:	8b 45 14             	mov    0x14(%ebp),%eax
  801a2a:	8b 00                	mov    (%eax),%eax
  801a2c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a33:	8b 45 10             	mov    0x10(%ebp),%eax
  801a36:	01 d0                	add    %edx,%eax
  801a38:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a3e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a43:	c9                   	leave  
  801a44:	c3                   	ret    

00801a45 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801a45:	55                   	push   %ebp
  801a46:	89 e5                	mov    %esp,%ebp
  801a48:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  801a4b:	e8 3b 09 00 00       	call   80238b <sys_isUHeapPlacementStrategyFIRSTFIT>
  801a50:	85 c0                	test   %eax,%eax
  801a52:	0f 84 3a 01 00 00    	je     801b92 <malloc+0x14d>

		if(pl == 0){
  801a58:	a1 28 30 80 00       	mov    0x803028,%eax
  801a5d:	85 c0                	test   %eax,%eax
  801a5f:	75 24                	jne    801a85 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801a61:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801a68:	eb 11                	jmp    801a7b <malloc+0x36>
				arr[k] = -10000;
  801a6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a6d:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801a74:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801a78:	ff 45 f4             	incl   -0xc(%ebp)
  801a7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a7e:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801a83:	76 e5                	jbe    801a6a <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801a85:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  801a8c:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a92:	c1 e8 0c             	shr    $0xc,%eax
  801a95:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  801a98:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9b:	25 ff 0f 00 00       	and    $0xfff,%eax
  801aa0:	85 c0                	test   %eax,%eax
  801aa2:	74 03                	je     801aa7 <malloc+0x62>
			x++;
  801aa4:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801aa7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  801aae:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801ab5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801abc:	eb 66                	jmp    801b24 <malloc+0xdf>
			if( arr[k] == -10000){
  801abe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ac1:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801ac8:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801acd:	75 52                	jne    801b21 <malloc+0xdc>
				uint32 w = 0 ;
  801acf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  801ad6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ad9:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  801adc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801adf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801ae2:	eb 09                	jmp    801aed <malloc+0xa8>
  801ae4:	ff 45 e0             	incl   -0x20(%ebp)
  801ae7:	ff 45 dc             	incl   -0x24(%ebp)
  801aea:	ff 45 e4             	incl   -0x1c(%ebp)
  801aed:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801af0:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801af5:	77 19                	ja     801b10 <malloc+0xcb>
  801af7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801afa:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801b01:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801b06:	75 08                	jne    801b10 <malloc+0xcb>
  801b08:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b0b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b0e:	72 d4                	jb     801ae4 <malloc+0x9f>
				if(w >= x){
  801b10:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b13:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b16:	72 09                	jb     801b21 <malloc+0xdc>
					p = 1 ;
  801b18:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801b1f:	eb 0d                	jmp    801b2e <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801b21:	ff 45 e4             	incl   -0x1c(%ebp)
  801b24:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b27:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801b2c:	76 90                	jbe    801abe <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801b2e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801b32:	75 0a                	jne    801b3e <malloc+0xf9>
  801b34:	b8 00 00 00 00       	mov    $0x0,%eax
  801b39:	e9 ca 01 00 00       	jmp    801d08 <malloc+0x2c3>
		int q = idx;
  801b3e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b41:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801b44:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801b4b:	eb 16                	jmp    801b63 <malloc+0x11e>
			arr[q++] = x;
  801b4d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801b50:	8d 50 01             	lea    0x1(%eax),%edx
  801b53:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801b56:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b59:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801b60:	ff 45 d4             	incl   -0x2c(%ebp)
  801b63:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801b66:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b69:	72 e2                	jb     801b4d <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801b6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b6e:	05 00 00 08 00       	add    $0x80000,%eax
  801b73:	c1 e0 0c             	shl    $0xc,%eax
  801b76:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801b79:	83 ec 08             	sub    $0x8,%esp
  801b7c:	ff 75 f0             	pushl  -0x10(%ebp)
  801b7f:	ff 75 ac             	pushl  -0x54(%ebp)
  801b82:	e8 9b 04 00 00       	call   802022 <sys_allocateMem>
  801b87:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801b8a:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801b8d:	e9 76 01 00 00       	jmp    801d08 <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801b92:	e8 25 08 00 00       	call   8023bc <sys_isUHeapPlacementStrategyBESTFIT>
  801b97:	85 c0                	test   %eax,%eax
  801b99:	0f 84 64 01 00 00    	je     801d03 <malloc+0x2be>
		if(pl == 0){
  801b9f:	a1 28 30 80 00       	mov    0x803028,%eax
  801ba4:	85 c0                	test   %eax,%eax
  801ba6:	75 24                	jne    801bcc <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801ba8:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801baf:	eb 11                	jmp    801bc2 <malloc+0x17d>
				arr[k] = -10000;
  801bb1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801bb4:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801bbb:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801bbf:	ff 45 d0             	incl   -0x30(%ebp)
  801bc2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801bc5:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801bca:	76 e5                	jbe    801bb1 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801bcc:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  801bd3:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd9:	c1 e8 0c             	shr    $0xc,%eax
  801bdc:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  801be2:	25 ff 0f 00 00       	and    $0xfff,%eax
  801be7:	85 c0                	test   %eax,%eax
  801be9:	74 03                	je     801bee <malloc+0x1a9>
			x++;
  801beb:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801bee:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801bf5:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801bfc:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801c03:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801c0a:	e9 88 00 00 00       	jmp    801c97 <malloc+0x252>
			if(arr[k] == -10000){
  801c0f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c12:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c19:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801c1e:	75 64                	jne    801c84 <malloc+0x23f>
				uint32 w = 0 , i;
  801c20:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801c27:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c2a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801c2d:	eb 06                	jmp    801c35 <malloc+0x1f0>
  801c2f:	ff 45 b8             	incl   -0x48(%ebp)
  801c32:	ff 45 b4             	incl   -0x4c(%ebp)
  801c35:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801c3c:	77 11                	ja     801c4f <malloc+0x20a>
  801c3e:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801c41:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c48:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801c4d:	74 e0                	je     801c2f <malloc+0x1ea>
				if(w <q && w >= x){
  801c4f:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801c52:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801c55:	73 24                	jae    801c7b <malloc+0x236>
  801c57:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801c5a:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801c5d:	72 1c                	jb     801c7b <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801c5f:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801c62:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801c65:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801c6c:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c6f:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801c72:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801c75:	48                   	dec    %eax
  801c76:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801c79:	eb 19                	jmp    801c94 <malloc+0x24f>
				}
				else {
					k = i - 1;
  801c7b:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801c7e:	48                   	dec    %eax
  801c7f:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801c82:	eb 10                	jmp    801c94 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801c84:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c87:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c8e:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801c91:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801c94:	ff 45 bc             	incl   -0x44(%ebp)
  801c97:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c9a:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c9f:	0f 86 6a ff ff ff    	jbe    801c0f <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801ca5:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801ca9:	75 07                	jne    801cb2 <malloc+0x26d>
  801cab:	b8 00 00 00 00       	mov    $0x0,%eax
  801cb0:	eb 56                	jmp    801d08 <malloc+0x2c3>
	    q = idx;
  801cb2:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801cb5:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801cb8:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801cbf:	eb 16                	jmp    801cd7 <malloc+0x292>
			arr[q++] = x;
  801cc1:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801cc4:	8d 50 01             	lea    0x1(%eax),%edx
  801cc7:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801cca:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801ccd:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801cd4:	ff 45 b0             	incl   -0x50(%ebp)
  801cd7:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801cda:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801cdd:	72 e2                	jb     801cc1 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801cdf:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801ce2:	05 00 00 08 00       	add    $0x80000,%eax
  801ce7:	c1 e0 0c             	shl    $0xc,%eax
  801cea:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801ced:	83 ec 08             	sub    $0x8,%esp
  801cf0:	ff 75 cc             	pushl  -0x34(%ebp)
  801cf3:	ff 75 a8             	pushl  -0x58(%ebp)
  801cf6:	e8 27 03 00 00       	call   802022 <sys_allocateMem>
  801cfb:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801cfe:	8b 45 a8             	mov    -0x58(%ebp),%eax
  801d01:	eb 05                	jmp    801d08 <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801d03:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d08:	c9                   	leave  
  801d09:	c3                   	ret    

00801d0a <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801d0a:	55                   	push   %ebp
  801d0b:	89 e5                	mov    %esp,%ebp
  801d0d:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801d10:	8b 45 08             	mov    0x8(%ebp),%eax
  801d13:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801d16:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d19:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801d1e:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801d21:	8b 45 08             	mov    0x8(%ebp),%eax
  801d24:	05 00 00 00 80       	add    $0x80000000,%eax
  801d29:	c1 e8 0c             	shr    $0xc,%eax
  801d2c:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801d33:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801d36:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d40:	05 00 00 00 80       	add    $0x80000000,%eax
  801d45:	c1 e8 0c             	shr    $0xc,%eax
  801d48:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d4b:	eb 14                	jmp    801d61 <free+0x57>
		arr[j] = -10000;
  801d4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d50:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801d57:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801d5b:	ff 45 f4             	incl   -0xc(%ebp)
  801d5e:	ff 45 f0             	incl   -0x10(%ebp)
  801d61:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d64:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801d67:	72 e4                	jb     801d4d <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801d69:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6c:	83 ec 08             	sub    $0x8,%esp
  801d6f:	ff 75 e8             	pushl  -0x18(%ebp)
  801d72:	50                   	push   %eax
  801d73:	e8 8e 02 00 00       	call   802006 <sys_freeMem>
  801d78:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801d7b:	90                   	nop
  801d7c:	c9                   	leave  
  801d7d:	c3                   	ret    

00801d7e <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801d7e:	55                   	push   %ebp
  801d7f:	89 e5                	mov    %esp,%ebp
  801d81:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d84:	83 ec 04             	sub    $0x4,%esp
  801d87:	68 50 2e 80 00       	push   $0x802e50
  801d8c:	68 9e 00 00 00       	push   $0x9e
  801d91:	68 73 2e 80 00       	push   $0x802e73
  801d96:	e8 69 ec ff ff       	call   800a04 <_panic>

00801d9b <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801d9b:	55                   	push   %ebp
  801d9c:	89 e5                	mov    %esp,%ebp
  801d9e:	83 ec 18             	sub    $0x18,%esp
  801da1:	8b 45 10             	mov    0x10(%ebp),%eax
  801da4:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801da7:	83 ec 04             	sub    $0x4,%esp
  801daa:	68 50 2e 80 00       	push   $0x802e50
  801daf:	68 a9 00 00 00       	push   $0xa9
  801db4:	68 73 2e 80 00       	push   $0x802e73
  801db9:	e8 46 ec ff ff       	call   800a04 <_panic>

00801dbe <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801dbe:	55                   	push   %ebp
  801dbf:	89 e5                	mov    %esp,%ebp
  801dc1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801dc4:	83 ec 04             	sub    $0x4,%esp
  801dc7:	68 50 2e 80 00       	push   $0x802e50
  801dcc:	68 af 00 00 00       	push   $0xaf
  801dd1:	68 73 2e 80 00       	push   $0x802e73
  801dd6:	e8 29 ec ff ff       	call   800a04 <_panic>

00801ddb <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801ddb:	55                   	push   %ebp
  801ddc:	89 e5                	mov    %esp,%ebp
  801dde:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801de1:	83 ec 04             	sub    $0x4,%esp
  801de4:	68 50 2e 80 00       	push   $0x802e50
  801de9:	68 b5 00 00 00       	push   $0xb5
  801dee:	68 73 2e 80 00       	push   $0x802e73
  801df3:	e8 0c ec ff ff       	call   800a04 <_panic>

00801df8 <expand>:
}

void expand(uint32 newSize)
{
  801df8:	55                   	push   %ebp
  801df9:	89 e5                	mov    %esp,%ebp
  801dfb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801dfe:	83 ec 04             	sub    $0x4,%esp
  801e01:	68 50 2e 80 00       	push   $0x802e50
  801e06:	68 ba 00 00 00       	push   $0xba
  801e0b:	68 73 2e 80 00       	push   $0x802e73
  801e10:	e8 ef eb ff ff       	call   800a04 <_panic>

00801e15 <shrink>:
}
void shrink(uint32 newSize)
{
  801e15:	55                   	push   %ebp
  801e16:	89 e5                	mov    %esp,%ebp
  801e18:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e1b:	83 ec 04             	sub    $0x4,%esp
  801e1e:	68 50 2e 80 00       	push   $0x802e50
  801e23:	68 be 00 00 00       	push   $0xbe
  801e28:	68 73 2e 80 00       	push   $0x802e73
  801e2d:	e8 d2 eb ff ff       	call   800a04 <_panic>

00801e32 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801e32:	55                   	push   %ebp
  801e33:	89 e5                	mov    %esp,%ebp
  801e35:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e38:	83 ec 04             	sub    $0x4,%esp
  801e3b:	68 50 2e 80 00       	push   $0x802e50
  801e40:	68 c3 00 00 00       	push   $0xc3
  801e45:	68 73 2e 80 00       	push   $0x802e73
  801e4a:	e8 b5 eb ff ff       	call   800a04 <_panic>

00801e4f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801e4f:	55                   	push   %ebp
  801e50:	89 e5                	mov    %esp,%ebp
  801e52:	57                   	push   %edi
  801e53:	56                   	push   %esi
  801e54:	53                   	push   %ebx
  801e55:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801e58:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e5e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e61:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e64:	8b 7d 18             	mov    0x18(%ebp),%edi
  801e67:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801e6a:	cd 30                	int    $0x30
  801e6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801e6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e72:	83 c4 10             	add    $0x10,%esp
  801e75:	5b                   	pop    %ebx
  801e76:	5e                   	pop    %esi
  801e77:	5f                   	pop    %edi
  801e78:	5d                   	pop    %ebp
  801e79:	c3                   	ret    

00801e7a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801e7a:	55                   	push   %ebp
  801e7b:	89 e5                	mov    %esp,%ebp
  801e7d:	83 ec 04             	sub    $0x4,%esp
  801e80:	8b 45 10             	mov    0x10(%ebp),%eax
  801e83:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801e86:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8d:	6a 00                	push   $0x0
  801e8f:	6a 00                	push   $0x0
  801e91:	52                   	push   %edx
  801e92:	ff 75 0c             	pushl  0xc(%ebp)
  801e95:	50                   	push   %eax
  801e96:	6a 00                	push   $0x0
  801e98:	e8 b2 ff ff ff       	call   801e4f <syscall>
  801e9d:	83 c4 18             	add    $0x18,%esp
}
  801ea0:	90                   	nop
  801ea1:	c9                   	leave  
  801ea2:	c3                   	ret    

00801ea3 <sys_cgetc>:

int
sys_cgetc(void)
{
  801ea3:	55                   	push   %ebp
  801ea4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801ea6:	6a 00                	push   $0x0
  801ea8:	6a 00                	push   $0x0
  801eaa:	6a 00                	push   $0x0
  801eac:	6a 00                	push   $0x0
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 01                	push   $0x1
  801eb2:	e8 98 ff ff ff       	call   801e4f <syscall>
  801eb7:	83 c4 18             	add    $0x18,%esp
}
  801eba:	c9                   	leave  
  801ebb:	c3                   	ret    

00801ebc <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ebc:	55                   	push   %ebp
  801ebd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	50                   	push   %eax
  801ecb:	6a 05                	push   $0x5
  801ecd:	e8 7d ff ff ff       	call   801e4f <syscall>
  801ed2:	83 c4 18             	add    $0x18,%esp
}
  801ed5:	c9                   	leave  
  801ed6:	c3                   	ret    

00801ed7 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ed7:	55                   	push   %ebp
  801ed8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801eda:	6a 00                	push   $0x0
  801edc:	6a 00                	push   $0x0
  801ede:	6a 00                	push   $0x0
  801ee0:	6a 00                	push   $0x0
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 02                	push   $0x2
  801ee6:	e8 64 ff ff ff       	call   801e4f <syscall>
  801eeb:	83 c4 18             	add    $0x18,%esp
}
  801eee:	c9                   	leave  
  801eef:	c3                   	ret    

00801ef0 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ef0:	55                   	push   %ebp
  801ef1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ef3:	6a 00                	push   $0x0
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	6a 03                	push   $0x3
  801eff:	e8 4b ff ff ff       	call   801e4f <syscall>
  801f04:	83 c4 18             	add    $0x18,%esp
}
  801f07:	c9                   	leave  
  801f08:	c3                   	ret    

00801f09 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f09:	55                   	push   %ebp
  801f0a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 00                	push   $0x0
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	6a 04                	push   $0x4
  801f18:	e8 32 ff ff ff       	call   801e4f <syscall>
  801f1d:	83 c4 18             	add    $0x18,%esp
}
  801f20:	c9                   	leave  
  801f21:	c3                   	ret    

00801f22 <sys_env_exit>:


void sys_env_exit(void)
{
  801f22:	55                   	push   %ebp
  801f23:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	6a 00                	push   $0x0
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 06                	push   $0x6
  801f31:	e8 19 ff ff ff       	call   801e4f <syscall>
  801f36:	83 c4 18             	add    $0x18,%esp
}
  801f39:	90                   	nop
  801f3a:	c9                   	leave  
  801f3b:	c3                   	ret    

00801f3c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801f3c:	55                   	push   %ebp
  801f3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801f3f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f42:	8b 45 08             	mov    0x8(%ebp),%eax
  801f45:	6a 00                	push   $0x0
  801f47:	6a 00                	push   $0x0
  801f49:	6a 00                	push   $0x0
  801f4b:	52                   	push   %edx
  801f4c:	50                   	push   %eax
  801f4d:	6a 07                	push   $0x7
  801f4f:	e8 fb fe ff ff       	call   801e4f <syscall>
  801f54:	83 c4 18             	add    $0x18,%esp
}
  801f57:	c9                   	leave  
  801f58:	c3                   	ret    

00801f59 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801f59:	55                   	push   %ebp
  801f5a:	89 e5                	mov    %esp,%ebp
  801f5c:	56                   	push   %esi
  801f5d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801f5e:	8b 75 18             	mov    0x18(%ebp),%esi
  801f61:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f64:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f67:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6d:	56                   	push   %esi
  801f6e:	53                   	push   %ebx
  801f6f:	51                   	push   %ecx
  801f70:	52                   	push   %edx
  801f71:	50                   	push   %eax
  801f72:	6a 08                	push   $0x8
  801f74:	e8 d6 fe ff ff       	call   801e4f <syscall>
  801f79:	83 c4 18             	add    $0x18,%esp
}
  801f7c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801f7f:	5b                   	pop    %ebx
  801f80:	5e                   	pop    %esi
  801f81:	5d                   	pop    %ebp
  801f82:	c3                   	ret    

00801f83 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801f83:	55                   	push   %ebp
  801f84:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801f86:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f89:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	52                   	push   %edx
  801f93:	50                   	push   %eax
  801f94:	6a 09                	push   $0x9
  801f96:	e8 b4 fe ff ff       	call   801e4f <syscall>
  801f9b:	83 c4 18             	add    $0x18,%esp
}
  801f9e:	c9                   	leave  
  801f9f:	c3                   	ret    

00801fa0 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801fa0:	55                   	push   %ebp
  801fa1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801fa3:	6a 00                	push   $0x0
  801fa5:	6a 00                	push   $0x0
  801fa7:	6a 00                	push   $0x0
  801fa9:	ff 75 0c             	pushl  0xc(%ebp)
  801fac:	ff 75 08             	pushl  0x8(%ebp)
  801faf:	6a 0a                	push   $0xa
  801fb1:	e8 99 fe ff ff       	call   801e4f <syscall>
  801fb6:	83 c4 18             	add    $0x18,%esp
}
  801fb9:	c9                   	leave  
  801fba:	c3                   	ret    

00801fbb <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801fbb:	55                   	push   %ebp
  801fbc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801fbe:	6a 00                	push   $0x0
  801fc0:	6a 00                	push   $0x0
  801fc2:	6a 00                	push   $0x0
  801fc4:	6a 00                	push   $0x0
  801fc6:	6a 00                	push   $0x0
  801fc8:	6a 0b                	push   $0xb
  801fca:	e8 80 fe ff ff       	call   801e4f <syscall>
  801fcf:	83 c4 18             	add    $0x18,%esp
}
  801fd2:	c9                   	leave  
  801fd3:	c3                   	ret    

00801fd4 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801fd4:	55                   	push   %ebp
  801fd5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 00                	push   $0x0
  801fe1:	6a 0c                	push   $0xc
  801fe3:	e8 67 fe ff ff       	call   801e4f <syscall>
  801fe8:	83 c4 18             	add    $0x18,%esp
}
  801feb:	c9                   	leave  
  801fec:	c3                   	ret    

00801fed <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801fed:	55                   	push   %ebp
  801fee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 00                	push   $0x0
  801ff8:	6a 00                	push   $0x0
  801ffa:	6a 0d                	push   $0xd
  801ffc:	e8 4e fe ff ff       	call   801e4f <syscall>
  802001:	83 c4 18             	add    $0x18,%esp
}
  802004:	c9                   	leave  
  802005:	c3                   	ret    

00802006 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802006:	55                   	push   %ebp
  802007:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802009:	6a 00                	push   $0x0
  80200b:	6a 00                	push   $0x0
  80200d:	6a 00                	push   $0x0
  80200f:	ff 75 0c             	pushl  0xc(%ebp)
  802012:	ff 75 08             	pushl  0x8(%ebp)
  802015:	6a 11                	push   $0x11
  802017:	e8 33 fe ff ff       	call   801e4f <syscall>
  80201c:	83 c4 18             	add    $0x18,%esp
	return;
  80201f:	90                   	nop
}
  802020:	c9                   	leave  
  802021:	c3                   	ret    

00802022 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802022:	55                   	push   %ebp
  802023:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802025:	6a 00                	push   $0x0
  802027:	6a 00                	push   $0x0
  802029:	6a 00                	push   $0x0
  80202b:	ff 75 0c             	pushl  0xc(%ebp)
  80202e:	ff 75 08             	pushl  0x8(%ebp)
  802031:	6a 12                	push   $0x12
  802033:	e8 17 fe ff ff       	call   801e4f <syscall>
  802038:	83 c4 18             	add    $0x18,%esp
	return ;
  80203b:	90                   	nop
}
  80203c:	c9                   	leave  
  80203d:	c3                   	ret    

0080203e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80203e:	55                   	push   %ebp
  80203f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	6a 0e                	push   $0xe
  80204d:	e8 fd fd ff ff       	call   801e4f <syscall>
  802052:	83 c4 18             	add    $0x18,%esp
}
  802055:	c9                   	leave  
  802056:	c3                   	ret    

00802057 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802057:	55                   	push   %ebp
  802058:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80205a:	6a 00                	push   $0x0
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	ff 75 08             	pushl  0x8(%ebp)
  802065:	6a 0f                	push   $0xf
  802067:	e8 e3 fd ff ff       	call   801e4f <syscall>
  80206c:	83 c4 18             	add    $0x18,%esp
}
  80206f:	c9                   	leave  
  802070:	c3                   	ret    

00802071 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802071:	55                   	push   %ebp
  802072:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802074:	6a 00                	push   $0x0
  802076:	6a 00                	push   $0x0
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	6a 00                	push   $0x0
  80207e:	6a 10                	push   $0x10
  802080:	e8 ca fd ff ff       	call   801e4f <syscall>
  802085:	83 c4 18             	add    $0x18,%esp
}
  802088:	90                   	nop
  802089:	c9                   	leave  
  80208a:	c3                   	ret    

0080208b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80208b:	55                   	push   %ebp
  80208c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	6a 00                	push   $0x0
  802098:	6a 14                	push   $0x14
  80209a:	e8 b0 fd ff ff       	call   801e4f <syscall>
  80209f:	83 c4 18             	add    $0x18,%esp
}
  8020a2:	90                   	nop
  8020a3:	c9                   	leave  
  8020a4:	c3                   	ret    

008020a5 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8020a5:	55                   	push   %ebp
  8020a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 15                	push   $0x15
  8020b4:	e8 96 fd ff ff       	call   801e4f <syscall>
  8020b9:	83 c4 18             	add    $0x18,%esp
}
  8020bc:	90                   	nop
  8020bd:	c9                   	leave  
  8020be:	c3                   	ret    

008020bf <sys_cputc>:


void
sys_cputc(const char c)
{
  8020bf:	55                   	push   %ebp
  8020c0:	89 e5                	mov    %esp,%ebp
  8020c2:	83 ec 04             	sub    $0x4,%esp
  8020c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8020cb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	50                   	push   %eax
  8020d8:	6a 16                	push   $0x16
  8020da:	e8 70 fd ff ff       	call   801e4f <syscall>
  8020df:	83 c4 18             	add    $0x18,%esp
}
  8020e2:	90                   	nop
  8020e3:	c9                   	leave  
  8020e4:	c3                   	ret    

008020e5 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8020e5:	55                   	push   %ebp
  8020e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8020e8:	6a 00                	push   $0x0
  8020ea:	6a 00                	push   $0x0
  8020ec:	6a 00                	push   $0x0
  8020ee:	6a 00                	push   $0x0
  8020f0:	6a 00                	push   $0x0
  8020f2:	6a 17                	push   $0x17
  8020f4:	e8 56 fd ff ff       	call   801e4f <syscall>
  8020f9:	83 c4 18             	add    $0x18,%esp
}
  8020fc:	90                   	nop
  8020fd:	c9                   	leave  
  8020fe:	c3                   	ret    

008020ff <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8020ff:	55                   	push   %ebp
  802100:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802102:	8b 45 08             	mov    0x8(%ebp),%eax
  802105:	6a 00                	push   $0x0
  802107:	6a 00                	push   $0x0
  802109:	6a 00                	push   $0x0
  80210b:	ff 75 0c             	pushl  0xc(%ebp)
  80210e:	50                   	push   %eax
  80210f:	6a 18                	push   $0x18
  802111:	e8 39 fd ff ff       	call   801e4f <syscall>
  802116:	83 c4 18             	add    $0x18,%esp
}
  802119:	c9                   	leave  
  80211a:	c3                   	ret    

0080211b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80211b:	55                   	push   %ebp
  80211c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80211e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802121:	8b 45 08             	mov    0x8(%ebp),%eax
  802124:	6a 00                	push   $0x0
  802126:	6a 00                	push   $0x0
  802128:	6a 00                	push   $0x0
  80212a:	52                   	push   %edx
  80212b:	50                   	push   %eax
  80212c:	6a 1b                	push   $0x1b
  80212e:	e8 1c fd ff ff       	call   801e4f <syscall>
  802133:	83 c4 18             	add    $0x18,%esp
}
  802136:	c9                   	leave  
  802137:	c3                   	ret    

00802138 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802138:	55                   	push   %ebp
  802139:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80213b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80213e:	8b 45 08             	mov    0x8(%ebp),%eax
  802141:	6a 00                	push   $0x0
  802143:	6a 00                	push   $0x0
  802145:	6a 00                	push   $0x0
  802147:	52                   	push   %edx
  802148:	50                   	push   %eax
  802149:	6a 19                	push   $0x19
  80214b:	e8 ff fc ff ff       	call   801e4f <syscall>
  802150:	83 c4 18             	add    $0x18,%esp
}
  802153:	90                   	nop
  802154:	c9                   	leave  
  802155:	c3                   	ret    

00802156 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802156:	55                   	push   %ebp
  802157:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802159:	8b 55 0c             	mov    0xc(%ebp),%edx
  80215c:	8b 45 08             	mov    0x8(%ebp),%eax
  80215f:	6a 00                	push   $0x0
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	52                   	push   %edx
  802166:	50                   	push   %eax
  802167:	6a 1a                	push   $0x1a
  802169:	e8 e1 fc ff ff       	call   801e4f <syscall>
  80216e:	83 c4 18             	add    $0x18,%esp
}
  802171:	90                   	nop
  802172:	c9                   	leave  
  802173:	c3                   	ret    

00802174 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802174:	55                   	push   %ebp
  802175:	89 e5                	mov    %esp,%ebp
  802177:	83 ec 04             	sub    $0x4,%esp
  80217a:	8b 45 10             	mov    0x10(%ebp),%eax
  80217d:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802180:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802183:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802187:	8b 45 08             	mov    0x8(%ebp),%eax
  80218a:	6a 00                	push   $0x0
  80218c:	51                   	push   %ecx
  80218d:	52                   	push   %edx
  80218e:	ff 75 0c             	pushl  0xc(%ebp)
  802191:	50                   	push   %eax
  802192:	6a 1c                	push   $0x1c
  802194:	e8 b6 fc ff ff       	call   801e4f <syscall>
  802199:	83 c4 18             	add    $0x18,%esp
}
  80219c:	c9                   	leave  
  80219d:	c3                   	ret    

0080219e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80219e:	55                   	push   %ebp
  80219f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8021a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	52                   	push   %edx
  8021ae:	50                   	push   %eax
  8021af:	6a 1d                	push   $0x1d
  8021b1:	e8 99 fc ff ff       	call   801e4f <syscall>
  8021b6:	83 c4 18             	add    $0x18,%esp
}
  8021b9:	c9                   	leave  
  8021ba:	c3                   	ret    

008021bb <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8021bb:	55                   	push   %ebp
  8021bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8021be:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	51                   	push   %ecx
  8021cc:	52                   	push   %edx
  8021cd:	50                   	push   %eax
  8021ce:	6a 1e                	push   $0x1e
  8021d0:	e8 7a fc ff ff       	call   801e4f <syscall>
  8021d5:	83 c4 18             	add    $0x18,%esp
}
  8021d8:	c9                   	leave  
  8021d9:	c3                   	ret    

008021da <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8021da:	55                   	push   %ebp
  8021db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8021dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 00                	push   $0x0
  8021e9:	52                   	push   %edx
  8021ea:	50                   	push   %eax
  8021eb:	6a 1f                	push   $0x1f
  8021ed:	e8 5d fc ff ff       	call   801e4f <syscall>
  8021f2:	83 c4 18             	add    $0x18,%esp
}
  8021f5:	c9                   	leave  
  8021f6:	c3                   	ret    

008021f7 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8021f7:	55                   	push   %ebp
  8021f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8021fa:	6a 00                	push   $0x0
  8021fc:	6a 00                	push   $0x0
  8021fe:	6a 00                	push   $0x0
  802200:	6a 00                	push   $0x0
  802202:	6a 00                	push   $0x0
  802204:	6a 20                	push   $0x20
  802206:	e8 44 fc ff ff       	call   801e4f <syscall>
  80220b:	83 c4 18             	add    $0x18,%esp
}
  80220e:	c9                   	leave  
  80220f:	c3                   	ret    

00802210 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802210:	55                   	push   %ebp
  802211:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802213:	8b 45 08             	mov    0x8(%ebp),%eax
  802216:	6a 00                	push   $0x0
  802218:	ff 75 14             	pushl  0x14(%ebp)
  80221b:	ff 75 10             	pushl  0x10(%ebp)
  80221e:	ff 75 0c             	pushl  0xc(%ebp)
  802221:	50                   	push   %eax
  802222:	6a 21                	push   $0x21
  802224:	e8 26 fc ff ff       	call   801e4f <syscall>
  802229:	83 c4 18             	add    $0x18,%esp
}
  80222c:	c9                   	leave  
  80222d:	c3                   	ret    

0080222e <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80222e:	55                   	push   %ebp
  80222f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802231:	8b 45 08             	mov    0x8(%ebp),%eax
  802234:	6a 00                	push   $0x0
  802236:	6a 00                	push   $0x0
  802238:	6a 00                	push   $0x0
  80223a:	6a 00                	push   $0x0
  80223c:	50                   	push   %eax
  80223d:	6a 22                	push   $0x22
  80223f:	e8 0b fc ff ff       	call   801e4f <syscall>
  802244:	83 c4 18             	add    $0x18,%esp
}
  802247:	90                   	nop
  802248:	c9                   	leave  
  802249:	c3                   	ret    

0080224a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80224a:	55                   	push   %ebp
  80224b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80224d:	8b 45 08             	mov    0x8(%ebp),%eax
  802250:	6a 00                	push   $0x0
  802252:	6a 00                	push   $0x0
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	50                   	push   %eax
  802259:	6a 23                	push   $0x23
  80225b:	e8 ef fb ff ff       	call   801e4f <syscall>
  802260:	83 c4 18             	add    $0x18,%esp
}
  802263:	90                   	nop
  802264:	c9                   	leave  
  802265:	c3                   	ret    

00802266 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802266:	55                   	push   %ebp
  802267:	89 e5                	mov    %esp,%ebp
  802269:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80226c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80226f:	8d 50 04             	lea    0x4(%eax),%edx
  802272:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802275:	6a 00                	push   $0x0
  802277:	6a 00                	push   $0x0
  802279:	6a 00                	push   $0x0
  80227b:	52                   	push   %edx
  80227c:	50                   	push   %eax
  80227d:	6a 24                	push   $0x24
  80227f:	e8 cb fb ff ff       	call   801e4f <syscall>
  802284:	83 c4 18             	add    $0x18,%esp
	return result;
  802287:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80228a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80228d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802290:	89 01                	mov    %eax,(%ecx)
  802292:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802295:	8b 45 08             	mov    0x8(%ebp),%eax
  802298:	c9                   	leave  
  802299:	c2 04 00             	ret    $0x4

0080229c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80229c:	55                   	push   %ebp
  80229d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80229f:	6a 00                	push   $0x0
  8022a1:	6a 00                	push   $0x0
  8022a3:	ff 75 10             	pushl  0x10(%ebp)
  8022a6:	ff 75 0c             	pushl  0xc(%ebp)
  8022a9:	ff 75 08             	pushl  0x8(%ebp)
  8022ac:	6a 13                	push   $0x13
  8022ae:	e8 9c fb ff ff       	call   801e4f <syscall>
  8022b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8022b6:	90                   	nop
}
  8022b7:	c9                   	leave  
  8022b8:	c3                   	ret    

008022b9 <sys_rcr2>:
uint32 sys_rcr2()
{
  8022b9:	55                   	push   %ebp
  8022ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8022bc:	6a 00                	push   $0x0
  8022be:	6a 00                	push   $0x0
  8022c0:	6a 00                	push   $0x0
  8022c2:	6a 00                	push   $0x0
  8022c4:	6a 00                	push   $0x0
  8022c6:	6a 25                	push   $0x25
  8022c8:	e8 82 fb ff ff       	call   801e4f <syscall>
  8022cd:	83 c4 18             	add    $0x18,%esp
}
  8022d0:	c9                   	leave  
  8022d1:	c3                   	ret    

008022d2 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8022d2:	55                   	push   %ebp
  8022d3:	89 e5                	mov    %esp,%ebp
  8022d5:	83 ec 04             	sub    $0x4,%esp
  8022d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8022db:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8022de:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8022e2:	6a 00                	push   $0x0
  8022e4:	6a 00                	push   $0x0
  8022e6:	6a 00                	push   $0x0
  8022e8:	6a 00                	push   $0x0
  8022ea:	50                   	push   %eax
  8022eb:	6a 26                	push   $0x26
  8022ed:	e8 5d fb ff ff       	call   801e4f <syscall>
  8022f2:	83 c4 18             	add    $0x18,%esp
	return ;
  8022f5:	90                   	nop
}
  8022f6:	c9                   	leave  
  8022f7:	c3                   	ret    

008022f8 <rsttst>:
void rsttst()
{
  8022f8:	55                   	push   %ebp
  8022f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8022fb:	6a 00                	push   $0x0
  8022fd:	6a 00                	push   $0x0
  8022ff:	6a 00                	push   $0x0
  802301:	6a 00                	push   $0x0
  802303:	6a 00                	push   $0x0
  802305:	6a 28                	push   $0x28
  802307:	e8 43 fb ff ff       	call   801e4f <syscall>
  80230c:	83 c4 18             	add    $0x18,%esp
	return ;
  80230f:	90                   	nop
}
  802310:	c9                   	leave  
  802311:	c3                   	ret    

00802312 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802312:	55                   	push   %ebp
  802313:	89 e5                	mov    %esp,%ebp
  802315:	83 ec 04             	sub    $0x4,%esp
  802318:	8b 45 14             	mov    0x14(%ebp),%eax
  80231b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80231e:	8b 55 18             	mov    0x18(%ebp),%edx
  802321:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802325:	52                   	push   %edx
  802326:	50                   	push   %eax
  802327:	ff 75 10             	pushl  0x10(%ebp)
  80232a:	ff 75 0c             	pushl  0xc(%ebp)
  80232d:	ff 75 08             	pushl  0x8(%ebp)
  802330:	6a 27                	push   $0x27
  802332:	e8 18 fb ff ff       	call   801e4f <syscall>
  802337:	83 c4 18             	add    $0x18,%esp
	return ;
  80233a:	90                   	nop
}
  80233b:	c9                   	leave  
  80233c:	c3                   	ret    

0080233d <chktst>:
void chktst(uint32 n)
{
  80233d:	55                   	push   %ebp
  80233e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802340:	6a 00                	push   $0x0
  802342:	6a 00                	push   $0x0
  802344:	6a 00                	push   $0x0
  802346:	6a 00                	push   $0x0
  802348:	ff 75 08             	pushl  0x8(%ebp)
  80234b:	6a 29                	push   $0x29
  80234d:	e8 fd fa ff ff       	call   801e4f <syscall>
  802352:	83 c4 18             	add    $0x18,%esp
	return ;
  802355:	90                   	nop
}
  802356:	c9                   	leave  
  802357:	c3                   	ret    

00802358 <inctst>:

void inctst()
{
  802358:	55                   	push   %ebp
  802359:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80235b:	6a 00                	push   $0x0
  80235d:	6a 00                	push   $0x0
  80235f:	6a 00                	push   $0x0
  802361:	6a 00                	push   $0x0
  802363:	6a 00                	push   $0x0
  802365:	6a 2a                	push   $0x2a
  802367:	e8 e3 fa ff ff       	call   801e4f <syscall>
  80236c:	83 c4 18             	add    $0x18,%esp
	return ;
  80236f:	90                   	nop
}
  802370:	c9                   	leave  
  802371:	c3                   	ret    

00802372 <gettst>:
uint32 gettst()
{
  802372:	55                   	push   %ebp
  802373:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802375:	6a 00                	push   $0x0
  802377:	6a 00                	push   $0x0
  802379:	6a 00                	push   $0x0
  80237b:	6a 00                	push   $0x0
  80237d:	6a 00                	push   $0x0
  80237f:	6a 2b                	push   $0x2b
  802381:	e8 c9 fa ff ff       	call   801e4f <syscall>
  802386:	83 c4 18             	add    $0x18,%esp
}
  802389:	c9                   	leave  
  80238a:	c3                   	ret    

0080238b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80238b:	55                   	push   %ebp
  80238c:	89 e5                	mov    %esp,%ebp
  80238e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802391:	6a 00                	push   $0x0
  802393:	6a 00                	push   $0x0
  802395:	6a 00                	push   $0x0
  802397:	6a 00                	push   $0x0
  802399:	6a 00                	push   $0x0
  80239b:	6a 2c                	push   $0x2c
  80239d:	e8 ad fa ff ff       	call   801e4f <syscall>
  8023a2:	83 c4 18             	add    $0x18,%esp
  8023a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8023a8:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8023ac:	75 07                	jne    8023b5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8023ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8023b3:	eb 05                	jmp    8023ba <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8023b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023ba:	c9                   	leave  
  8023bb:	c3                   	ret    

008023bc <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8023bc:	55                   	push   %ebp
  8023bd:	89 e5                	mov    %esp,%ebp
  8023bf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023c2:	6a 00                	push   $0x0
  8023c4:	6a 00                	push   $0x0
  8023c6:	6a 00                	push   $0x0
  8023c8:	6a 00                	push   $0x0
  8023ca:	6a 00                	push   $0x0
  8023cc:	6a 2c                	push   $0x2c
  8023ce:	e8 7c fa ff ff       	call   801e4f <syscall>
  8023d3:	83 c4 18             	add    $0x18,%esp
  8023d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8023d9:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8023dd:	75 07                	jne    8023e6 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8023df:	b8 01 00 00 00       	mov    $0x1,%eax
  8023e4:	eb 05                	jmp    8023eb <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8023e6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023eb:	c9                   	leave  
  8023ec:	c3                   	ret    

008023ed <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8023ed:	55                   	push   %ebp
  8023ee:	89 e5                	mov    %esp,%ebp
  8023f0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023f3:	6a 00                	push   $0x0
  8023f5:	6a 00                	push   $0x0
  8023f7:	6a 00                	push   $0x0
  8023f9:	6a 00                	push   $0x0
  8023fb:	6a 00                	push   $0x0
  8023fd:	6a 2c                	push   $0x2c
  8023ff:	e8 4b fa ff ff       	call   801e4f <syscall>
  802404:	83 c4 18             	add    $0x18,%esp
  802407:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80240a:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80240e:	75 07                	jne    802417 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802410:	b8 01 00 00 00       	mov    $0x1,%eax
  802415:	eb 05                	jmp    80241c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802417:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80241c:	c9                   	leave  
  80241d:	c3                   	ret    

0080241e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80241e:	55                   	push   %ebp
  80241f:	89 e5                	mov    %esp,%ebp
  802421:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802424:	6a 00                	push   $0x0
  802426:	6a 00                	push   $0x0
  802428:	6a 00                	push   $0x0
  80242a:	6a 00                	push   $0x0
  80242c:	6a 00                	push   $0x0
  80242e:	6a 2c                	push   $0x2c
  802430:	e8 1a fa ff ff       	call   801e4f <syscall>
  802435:	83 c4 18             	add    $0x18,%esp
  802438:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80243b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80243f:	75 07                	jne    802448 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802441:	b8 01 00 00 00       	mov    $0x1,%eax
  802446:	eb 05                	jmp    80244d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802448:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80244d:	c9                   	leave  
  80244e:	c3                   	ret    

0080244f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80244f:	55                   	push   %ebp
  802450:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802452:	6a 00                	push   $0x0
  802454:	6a 00                	push   $0x0
  802456:	6a 00                	push   $0x0
  802458:	6a 00                	push   $0x0
  80245a:	ff 75 08             	pushl  0x8(%ebp)
  80245d:	6a 2d                	push   $0x2d
  80245f:	e8 eb f9 ff ff       	call   801e4f <syscall>
  802464:	83 c4 18             	add    $0x18,%esp
	return ;
  802467:	90                   	nop
}
  802468:	c9                   	leave  
  802469:	c3                   	ret    

0080246a <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80246a:	55                   	push   %ebp
  80246b:	89 e5                	mov    %esp,%ebp
  80246d:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80246e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802471:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802474:	8b 55 0c             	mov    0xc(%ebp),%edx
  802477:	8b 45 08             	mov    0x8(%ebp),%eax
  80247a:	6a 00                	push   $0x0
  80247c:	53                   	push   %ebx
  80247d:	51                   	push   %ecx
  80247e:	52                   	push   %edx
  80247f:	50                   	push   %eax
  802480:	6a 2e                	push   $0x2e
  802482:	e8 c8 f9 ff ff       	call   801e4f <syscall>
  802487:	83 c4 18             	add    $0x18,%esp
}
  80248a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80248d:	c9                   	leave  
  80248e:	c3                   	ret    

0080248f <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80248f:	55                   	push   %ebp
  802490:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802492:	8b 55 0c             	mov    0xc(%ebp),%edx
  802495:	8b 45 08             	mov    0x8(%ebp),%eax
  802498:	6a 00                	push   $0x0
  80249a:	6a 00                	push   $0x0
  80249c:	6a 00                	push   $0x0
  80249e:	52                   	push   %edx
  80249f:	50                   	push   %eax
  8024a0:	6a 2f                	push   $0x2f
  8024a2:	e8 a8 f9 ff ff       	call   801e4f <syscall>
  8024a7:	83 c4 18             	add    $0x18,%esp
}
  8024aa:	c9                   	leave  
  8024ab:	c3                   	ret    

008024ac <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8024ac:	55                   	push   %ebp
  8024ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8024af:	6a 00                	push   $0x0
  8024b1:	6a 00                	push   $0x0
  8024b3:	6a 00                	push   $0x0
  8024b5:	ff 75 0c             	pushl  0xc(%ebp)
  8024b8:	ff 75 08             	pushl  0x8(%ebp)
  8024bb:	6a 30                	push   $0x30
  8024bd:	e8 8d f9 ff ff       	call   801e4f <syscall>
  8024c2:	83 c4 18             	add    $0x18,%esp
	return ;
  8024c5:	90                   	nop
}
  8024c6:	c9                   	leave  
  8024c7:	c3                   	ret    

008024c8 <__udivdi3>:
  8024c8:	55                   	push   %ebp
  8024c9:	57                   	push   %edi
  8024ca:	56                   	push   %esi
  8024cb:	53                   	push   %ebx
  8024cc:	83 ec 1c             	sub    $0x1c,%esp
  8024cf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8024d3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8024d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024db:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8024df:	89 ca                	mov    %ecx,%edx
  8024e1:	89 f8                	mov    %edi,%eax
  8024e3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8024e7:	85 f6                	test   %esi,%esi
  8024e9:	75 2d                	jne    802518 <__udivdi3+0x50>
  8024eb:	39 cf                	cmp    %ecx,%edi
  8024ed:	77 65                	ja     802554 <__udivdi3+0x8c>
  8024ef:	89 fd                	mov    %edi,%ebp
  8024f1:	85 ff                	test   %edi,%edi
  8024f3:	75 0b                	jne    802500 <__udivdi3+0x38>
  8024f5:	b8 01 00 00 00       	mov    $0x1,%eax
  8024fa:	31 d2                	xor    %edx,%edx
  8024fc:	f7 f7                	div    %edi
  8024fe:	89 c5                	mov    %eax,%ebp
  802500:	31 d2                	xor    %edx,%edx
  802502:	89 c8                	mov    %ecx,%eax
  802504:	f7 f5                	div    %ebp
  802506:	89 c1                	mov    %eax,%ecx
  802508:	89 d8                	mov    %ebx,%eax
  80250a:	f7 f5                	div    %ebp
  80250c:	89 cf                	mov    %ecx,%edi
  80250e:	89 fa                	mov    %edi,%edx
  802510:	83 c4 1c             	add    $0x1c,%esp
  802513:	5b                   	pop    %ebx
  802514:	5e                   	pop    %esi
  802515:	5f                   	pop    %edi
  802516:	5d                   	pop    %ebp
  802517:	c3                   	ret    
  802518:	39 ce                	cmp    %ecx,%esi
  80251a:	77 28                	ja     802544 <__udivdi3+0x7c>
  80251c:	0f bd fe             	bsr    %esi,%edi
  80251f:	83 f7 1f             	xor    $0x1f,%edi
  802522:	75 40                	jne    802564 <__udivdi3+0x9c>
  802524:	39 ce                	cmp    %ecx,%esi
  802526:	72 0a                	jb     802532 <__udivdi3+0x6a>
  802528:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80252c:	0f 87 9e 00 00 00    	ja     8025d0 <__udivdi3+0x108>
  802532:	b8 01 00 00 00       	mov    $0x1,%eax
  802537:	89 fa                	mov    %edi,%edx
  802539:	83 c4 1c             	add    $0x1c,%esp
  80253c:	5b                   	pop    %ebx
  80253d:	5e                   	pop    %esi
  80253e:	5f                   	pop    %edi
  80253f:	5d                   	pop    %ebp
  802540:	c3                   	ret    
  802541:	8d 76 00             	lea    0x0(%esi),%esi
  802544:	31 ff                	xor    %edi,%edi
  802546:	31 c0                	xor    %eax,%eax
  802548:	89 fa                	mov    %edi,%edx
  80254a:	83 c4 1c             	add    $0x1c,%esp
  80254d:	5b                   	pop    %ebx
  80254e:	5e                   	pop    %esi
  80254f:	5f                   	pop    %edi
  802550:	5d                   	pop    %ebp
  802551:	c3                   	ret    
  802552:	66 90                	xchg   %ax,%ax
  802554:	89 d8                	mov    %ebx,%eax
  802556:	f7 f7                	div    %edi
  802558:	31 ff                	xor    %edi,%edi
  80255a:	89 fa                	mov    %edi,%edx
  80255c:	83 c4 1c             	add    $0x1c,%esp
  80255f:	5b                   	pop    %ebx
  802560:	5e                   	pop    %esi
  802561:	5f                   	pop    %edi
  802562:	5d                   	pop    %ebp
  802563:	c3                   	ret    
  802564:	bd 20 00 00 00       	mov    $0x20,%ebp
  802569:	89 eb                	mov    %ebp,%ebx
  80256b:	29 fb                	sub    %edi,%ebx
  80256d:	89 f9                	mov    %edi,%ecx
  80256f:	d3 e6                	shl    %cl,%esi
  802571:	89 c5                	mov    %eax,%ebp
  802573:	88 d9                	mov    %bl,%cl
  802575:	d3 ed                	shr    %cl,%ebp
  802577:	89 e9                	mov    %ebp,%ecx
  802579:	09 f1                	or     %esi,%ecx
  80257b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80257f:	89 f9                	mov    %edi,%ecx
  802581:	d3 e0                	shl    %cl,%eax
  802583:	89 c5                	mov    %eax,%ebp
  802585:	89 d6                	mov    %edx,%esi
  802587:	88 d9                	mov    %bl,%cl
  802589:	d3 ee                	shr    %cl,%esi
  80258b:	89 f9                	mov    %edi,%ecx
  80258d:	d3 e2                	shl    %cl,%edx
  80258f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802593:	88 d9                	mov    %bl,%cl
  802595:	d3 e8                	shr    %cl,%eax
  802597:	09 c2                	or     %eax,%edx
  802599:	89 d0                	mov    %edx,%eax
  80259b:	89 f2                	mov    %esi,%edx
  80259d:	f7 74 24 0c          	divl   0xc(%esp)
  8025a1:	89 d6                	mov    %edx,%esi
  8025a3:	89 c3                	mov    %eax,%ebx
  8025a5:	f7 e5                	mul    %ebp
  8025a7:	39 d6                	cmp    %edx,%esi
  8025a9:	72 19                	jb     8025c4 <__udivdi3+0xfc>
  8025ab:	74 0b                	je     8025b8 <__udivdi3+0xf0>
  8025ad:	89 d8                	mov    %ebx,%eax
  8025af:	31 ff                	xor    %edi,%edi
  8025b1:	e9 58 ff ff ff       	jmp    80250e <__udivdi3+0x46>
  8025b6:	66 90                	xchg   %ax,%ax
  8025b8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8025bc:	89 f9                	mov    %edi,%ecx
  8025be:	d3 e2                	shl    %cl,%edx
  8025c0:	39 c2                	cmp    %eax,%edx
  8025c2:	73 e9                	jae    8025ad <__udivdi3+0xe5>
  8025c4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8025c7:	31 ff                	xor    %edi,%edi
  8025c9:	e9 40 ff ff ff       	jmp    80250e <__udivdi3+0x46>
  8025ce:	66 90                	xchg   %ax,%ax
  8025d0:	31 c0                	xor    %eax,%eax
  8025d2:	e9 37 ff ff ff       	jmp    80250e <__udivdi3+0x46>
  8025d7:	90                   	nop

008025d8 <__umoddi3>:
  8025d8:	55                   	push   %ebp
  8025d9:	57                   	push   %edi
  8025da:	56                   	push   %esi
  8025db:	53                   	push   %ebx
  8025dc:	83 ec 1c             	sub    $0x1c,%esp
  8025df:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8025e3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8025e7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025eb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8025ef:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8025f3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8025f7:	89 f3                	mov    %esi,%ebx
  8025f9:	89 fa                	mov    %edi,%edx
  8025fb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025ff:	89 34 24             	mov    %esi,(%esp)
  802602:	85 c0                	test   %eax,%eax
  802604:	75 1a                	jne    802620 <__umoddi3+0x48>
  802606:	39 f7                	cmp    %esi,%edi
  802608:	0f 86 a2 00 00 00    	jbe    8026b0 <__umoddi3+0xd8>
  80260e:	89 c8                	mov    %ecx,%eax
  802610:	89 f2                	mov    %esi,%edx
  802612:	f7 f7                	div    %edi
  802614:	89 d0                	mov    %edx,%eax
  802616:	31 d2                	xor    %edx,%edx
  802618:	83 c4 1c             	add    $0x1c,%esp
  80261b:	5b                   	pop    %ebx
  80261c:	5e                   	pop    %esi
  80261d:	5f                   	pop    %edi
  80261e:	5d                   	pop    %ebp
  80261f:	c3                   	ret    
  802620:	39 f0                	cmp    %esi,%eax
  802622:	0f 87 ac 00 00 00    	ja     8026d4 <__umoddi3+0xfc>
  802628:	0f bd e8             	bsr    %eax,%ebp
  80262b:	83 f5 1f             	xor    $0x1f,%ebp
  80262e:	0f 84 ac 00 00 00    	je     8026e0 <__umoddi3+0x108>
  802634:	bf 20 00 00 00       	mov    $0x20,%edi
  802639:	29 ef                	sub    %ebp,%edi
  80263b:	89 fe                	mov    %edi,%esi
  80263d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802641:	89 e9                	mov    %ebp,%ecx
  802643:	d3 e0                	shl    %cl,%eax
  802645:	89 d7                	mov    %edx,%edi
  802647:	89 f1                	mov    %esi,%ecx
  802649:	d3 ef                	shr    %cl,%edi
  80264b:	09 c7                	or     %eax,%edi
  80264d:	89 e9                	mov    %ebp,%ecx
  80264f:	d3 e2                	shl    %cl,%edx
  802651:	89 14 24             	mov    %edx,(%esp)
  802654:	89 d8                	mov    %ebx,%eax
  802656:	d3 e0                	shl    %cl,%eax
  802658:	89 c2                	mov    %eax,%edx
  80265a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80265e:	d3 e0                	shl    %cl,%eax
  802660:	89 44 24 04          	mov    %eax,0x4(%esp)
  802664:	8b 44 24 08          	mov    0x8(%esp),%eax
  802668:	89 f1                	mov    %esi,%ecx
  80266a:	d3 e8                	shr    %cl,%eax
  80266c:	09 d0                	or     %edx,%eax
  80266e:	d3 eb                	shr    %cl,%ebx
  802670:	89 da                	mov    %ebx,%edx
  802672:	f7 f7                	div    %edi
  802674:	89 d3                	mov    %edx,%ebx
  802676:	f7 24 24             	mull   (%esp)
  802679:	89 c6                	mov    %eax,%esi
  80267b:	89 d1                	mov    %edx,%ecx
  80267d:	39 d3                	cmp    %edx,%ebx
  80267f:	0f 82 87 00 00 00    	jb     80270c <__umoddi3+0x134>
  802685:	0f 84 91 00 00 00    	je     80271c <__umoddi3+0x144>
  80268b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80268f:	29 f2                	sub    %esi,%edx
  802691:	19 cb                	sbb    %ecx,%ebx
  802693:	89 d8                	mov    %ebx,%eax
  802695:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802699:	d3 e0                	shl    %cl,%eax
  80269b:	89 e9                	mov    %ebp,%ecx
  80269d:	d3 ea                	shr    %cl,%edx
  80269f:	09 d0                	or     %edx,%eax
  8026a1:	89 e9                	mov    %ebp,%ecx
  8026a3:	d3 eb                	shr    %cl,%ebx
  8026a5:	89 da                	mov    %ebx,%edx
  8026a7:	83 c4 1c             	add    $0x1c,%esp
  8026aa:	5b                   	pop    %ebx
  8026ab:	5e                   	pop    %esi
  8026ac:	5f                   	pop    %edi
  8026ad:	5d                   	pop    %ebp
  8026ae:	c3                   	ret    
  8026af:	90                   	nop
  8026b0:	89 fd                	mov    %edi,%ebp
  8026b2:	85 ff                	test   %edi,%edi
  8026b4:	75 0b                	jne    8026c1 <__umoddi3+0xe9>
  8026b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8026bb:	31 d2                	xor    %edx,%edx
  8026bd:	f7 f7                	div    %edi
  8026bf:	89 c5                	mov    %eax,%ebp
  8026c1:	89 f0                	mov    %esi,%eax
  8026c3:	31 d2                	xor    %edx,%edx
  8026c5:	f7 f5                	div    %ebp
  8026c7:	89 c8                	mov    %ecx,%eax
  8026c9:	f7 f5                	div    %ebp
  8026cb:	89 d0                	mov    %edx,%eax
  8026cd:	e9 44 ff ff ff       	jmp    802616 <__umoddi3+0x3e>
  8026d2:	66 90                	xchg   %ax,%ax
  8026d4:	89 c8                	mov    %ecx,%eax
  8026d6:	89 f2                	mov    %esi,%edx
  8026d8:	83 c4 1c             	add    $0x1c,%esp
  8026db:	5b                   	pop    %ebx
  8026dc:	5e                   	pop    %esi
  8026dd:	5f                   	pop    %edi
  8026de:	5d                   	pop    %ebp
  8026df:	c3                   	ret    
  8026e0:	3b 04 24             	cmp    (%esp),%eax
  8026e3:	72 06                	jb     8026eb <__umoddi3+0x113>
  8026e5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8026e9:	77 0f                	ja     8026fa <__umoddi3+0x122>
  8026eb:	89 f2                	mov    %esi,%edx
  8026ed:	29 f9                	sub    %edi,%ecx
  8026ef:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8026f3:	89 14 24             	mov    %edx,(%esp)
  8026f6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8026fa:	8b 44 24 04          	mov    0x4(%esp),%eax
  8026fe:	8b 14 24             	mov    (%esp),%edx
  802701:	83 c4 1c             	add    $0x1c,%esp
  802704:	5b                   	pop    %ebx
  802705:	5e                   	pop    %esi
  802706:	5f                   	pop    %edi
  802707:	5d                   	pop    %ebp
  802708:	c3                   	ret    
  802709:	8d 76 00             	lea    0x0(%esi),%esi
  80270c:	2b 04 24             	sub    (%esp),%eax
  80270f:	19 fa                	sbb    %edi,%edx
  802711:	89 d1                	mov    %edx,%ecx
  802713:	89 c6                	mov    %eax,%esi
  802715:	e9 71 ff ff ff       	jmp    80268b <__umoddi3+0xb3>
  80271a:	66 90                	xchg   %ax,%ax
  80271c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802720:	72 ea                	jb     80270c <__umoddi3+0x134>
  802722:	89 d9                	mov    %ebx,%ecx
  802724:	e9 62 ff ff ff       	jmp    80268b <__umoddi3+0xb3>
