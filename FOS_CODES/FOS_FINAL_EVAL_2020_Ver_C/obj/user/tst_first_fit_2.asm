
obj/user/tst_first_fit_2:     file format elf32-i386


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
  800031:	e8 bc 06 00 00       	call   8006f2 <libmain>
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
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 01                	push   $0x1
  800045:	e8 1b 22 00 00       	call   802265 <sys_set_uheap_strategy>
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
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);

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
  80009c:	68 60 25 80 00       	push   $0x802560
  8000a1:	6a 1b                	push   $0x1b
  8000a3:	68 7c 25 80 00       	push   $0x80257c
  8000a8:	e8 6d 07 00 00       	call   80081a <_panic>
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
  8000d4:	e8 82 17 00 00       	call   80185b <malloc>
  8000d9:	83 c4 10             	add    $0x10,%esp
  8000dc:	89 45 90             	mov    %eax,-0x70(%ebp)
		if (ptr_allocations[0] != NULL) panic("Malloc: Attempt to allocate more than heap size, should return NULL");
  8000df:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e2:	85 c0                	test   %eax,%eax
  8000e4:	74 14                	je     8000fa <_main+0xc2>
  8000e6:	83 ec 04             	sub    $0x4,%esp
  8000e9:	68 94 25 80 00       	push   $0x802594
  8000ee:	6a 26                	push   $0x26
  8000f0:	68 7c 25 80 00       	push   $0x80257c
  8000f5:	e8 20 07 00 00       	call   80081a <_panic>
	}
	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
  8000fa:	e8 d2 1c 00 00       	call   801dd1 <sys_calculate_free_frames>
  8000ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  800102:	e8 4d 1d 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  800107:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  80010a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80010d:	01 c0                	add    %eax,%eax
  80010f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800112:	83 ec 0c             	sub    $0xc,%esp
  800115:	50                   	push   %eax
  800116:	e8 40 17 00 00       	call   80185b <malloc>
  80011b:	83 c4 10             	add    $0x10,%esp
  80011e:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800121:	8b 45 90             	mov    -0x70(%ebp),%eax
  800124:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800129:	74 14                	je     80013f <_main+0x107>
  80012b:	83 ec 04             	sub    $0x4,%esp
  80012e:	68 d8 25 80 00       	push   $0x8025d8
  800133:	6a 2f                	push   $0x2f
  800135:	68 7c 25 80 00       	push   $0x80257c
  80013a:	e8 db 06 00 00       	call   80081a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  80013f:	e8 10 1d 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  800144:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800147:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014c:	74 14                	je     800162 <_main+0x12a>
  80014e:	83 ec 04             	sub    $0x4,%esp
  800151:	68 08 26 80 00       	push   $0x802608
  800156:	6a 31                	push   $0x31
  800158:	68 7c 25 80 00       	push   $0x80257c
  80015d:	e8 b8 06 00 00       	call   80081a <_panic>

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  800162:	e8 6a 1c 00 00       	call   801dd1 <sys_calculate_free_frames>
  800167:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80016a:	e8 e5 1c 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  80016f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800172:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800175:	01 c0                	add    %eax,%eax
  800177:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80017a:	83 ec 0c             	sub    $0xc,%esp
  80017d:	50                   	push   %eax
  80017e:	e8 d8 16 00 00       	call   80185b <malloc>
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
  80019f:	68 d8 25 80 00       	push   $0x8025d8
  8001a4:	6a 37                	push   $0x37
  8001a6:	68 7c 25 80 00       	push   $0x80257c
  8001ab:	e8 6a 06 00 00       	call   80081a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8001b0:	e8 9f 1c 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  8001b5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001b8:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001bd:	74 14                	je     8001d3 <_main+0x19b>
  8001bf:	83 ec 04             	sub    $0x4,%esp
  8001c2:	68 08 26 80 00       	push   $0x802608
  8001c7:	6a 39                	push   $0x39
  8001c9:	68 7c 25 80 00       	push   $0x80257c
  8001ce:	e8 47 06 00 00       	call   80081a <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8001d3:	e8 f9 1b 00 00       	call   801dd1 <sys_calculate_free_frames>
  8001d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001db:	e8 74 1c 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  8001e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  8001e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001e6:	01 c0                	add    %eax,%eax
  8001e8:	83 ec 0c             	sub    $0xc,%esp
  8001eb:	50                   	push   %eax
  8001ec:	e8 6a 16 00 00       	call   80185b <malloc>
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
  80020e:	68 d8 25 80 00       	push   $0x8025d8
  800213:	6a 3f                	push   $0x3f
  800215:	68 7c 25 80 00       	push   $0x80257c
  80021a:	e8 fb 05 00 00       	call   80081a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  80021f:	e8 30 1c 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  800224:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800227:	83 f8 01             	cmp    $0x1,%eax
  80022a:	74 14                	je     800240 <_main+0x208>
  80022c:	83 ec 04             	sub    $0x4,%esp
  80022f:	68 08 26 80 00       	push   $0x802608
  800234:	6a 41                	push   $0x41
  800236:	68 7c 25 80 00       	push   $0x80257c
  80023b:	e8 da 05 00 00       	call   80081a <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  800240:	e8 8c 1b 00 00       	call   801dd1 <sys_calculate_free_frames>
  800245:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800248:	e8 07 1c 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  80024d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  800250:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800253:	01 c0                	add    %eax,%eax
  800255:	83 ec 0c             	sub    $0xc,%esp
  800258:	50                   	push   %eax
  800259:	e8 fd 15 00 00       	call   80185b <malloc>
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
  800285:	68 d8 25 80 00       	push   $0x8025d8
  80028a:	6a 47                	push   $0x47
  80028c:	68 7c 25 80 00       	push   $0x80257c
  800291:	e8 84 05 00 00       	call   80081a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  800296:	e8 b9 1b 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  80029b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80029e:	83 f8 01             	cmp    $0x1,%eax
  8002a1:	74 14                	je     8002b7 <_main+0x27f>
  8002a3:	83 ec 04             	sub    $0x4,%esp
  8002a6:	68 08 26 80 00       	push   $0x802608
  8002ab:	6a 49                	push   $0x49
  8002ad:	68 7c 25 80 00       	push   $0x80257c
  8002b2:	e8 63 05 00 00       	call   80081a <_panic>

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  8002b7:	e8 15 1b 00 00       	call   801dd1 <sys_calculate_free_frames>
  8002bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8002bf:	e8 90 1b 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  8002c4:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8002c7:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002ca:	83 ec 0c             	sub    $0xc,%esp
  8002cd:	50                   	push   %eax
  8002ce:	e8 4d 18 00 00       	call   801b20 <free>
  8002d3:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1) panic("Wrong free: ");
		if( (usedDiskPages-sys_pf_calculate_allocated_pages()) !=  1) panic("Wrong page file free: ");
  8002d6:	e8 79 1b 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  8002db:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002de:	29 c2                	sub    %eax,%edx
  8002e0:	89 d0                	mov    %edx,%eax
  8002e2:	83 f8 01             	cmp    $0x1,%eax
  8002e5:	74 14                	je     8002fb <_main+0x2c3>
  8002e7:	83 ec 04             	sub    $0x4,%esp
  8002ea:	68 25 26 80 00       	push   $0x802625
  8002ef:	6a 50                	push   $0x50
  8002f1:	68 7c 25 80 00       	push   $0x80257c
  8002f6:	e8 1f 05 00 00       	call   80081a <_panic>

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  8002fb:	e8 d1 1a 00 00       	call   801dd1 <sys_calculate_free_frames>
  800300:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800303:	e8 4c 1b 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
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
  80031c:	e8 3a 15 00 00       	call   80185b <malloc>
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
  800348:	68 d8 25 80 00       	push   $0x8025d8
  80034d:	6a 56                	push   $0x56
  80034f:	68 7c 25 80 00       	push   $0x80257c
  800354:	e8 c1 04 00 00       	call   80081a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  800359:	e8 f6 1a 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  80035e:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800361:	83 f8 02             	cmp    $0x2,%eax
  800364:	74 14                	je     80037a <_main+0x342>
  800366:	83 ec 04             	sub    $0x4,%esp
  800369:	68 08 26 80 00       	push   $0x802608
  80036e:	6a 58                	push   $0x58
  800370:	68 7c 25 80 00       	push   $0x80257c
  800375:	e8 a0 04 00 00       	call   80081a <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80037a:	e8 52 1a 00 00       	call   801dd1 <sys_calculate_free_frames>
  80037f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800382:	e8 cd 1a 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  800387:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[0]);
  80038a:	8b 45 90             	mov    -0x70(%ebp),%eax
  80038d:	83 ec 0c             	sub    $0xc,%esp
  800390:	50                   	push   %eax
  800391:	e8 8a 17 00 00       	call   801b20 <free>
  800396:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800399:	e8 b6 1a 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  80039e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003a1:	29 c2                	sub    %eax,%edx
  8003a3:	89 d0                	mov    %edx,%eax
  8003a5:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003aa:	74 14                	je     8003c0 <_main+0x388>
  8003ac:	83 ec 04             	sub    $0x4,%esp
  8003af:	68 25 26 80 00       	push   $0x802625
  8003b4:	6a 5f                	push   $0x5f
  8003b6:	68 7c 25 80 00       	push   $0x80257c
  8003bb:	e8 5a 04 00 00       	call   80081a <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003c0:	e8 0c 1a 00 00       	call   801dd1 <sys_calculate_free_frames>
  8003c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003c8:	e8 87 1a 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  8003cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8003d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d3:	89 c2                	mov    %eax,%edx
  8003d5:	01 d2                	add    %edx,%edx
  8003d7:	01 d0                	add    %edx,%eax
  8003d9:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003dc:	83 ec 0c             	sub    $0xc,%esp
  8003df:	50                   	push   %eax
  8003e0:	e8 76 14 00 00       	call   80185b <malloc>
  8003e5:	83 c4 10             	add    $0x10,%esp
  8003e8:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] !=  (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
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
  80040c:	68 d8 25 80 00       	push   $0x8025d8
  800411:	6a 65                	push   $0x65
  800413:	68 7c 25 80 00       	push   $0x80257c
  800418:	e8 fd 03 00 00       	call   80081a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80041d:	e8 32 1a 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
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
  800443:	68 08 26 80 00       	push   $0x802608
  800448:	6a 67                	push   $0x67
  80044a:	68 7c 25 80 00       	push   $0x80257c
  80044f:	e8 c6 03 00 00       	call   80081a <_panic>

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
  800454:	e8 78 19 00 00       	call   801dd1 <sys_calculate_free_frames>
  800459:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80045c:	e8 f3 19 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
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
  800478:	e8 de 13 00 00       	call   80185b <malloc>
  80047d:	83 c4 10             	add    $0x10,%esp
  800480:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] !=  (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
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
  8004ab:	68 d8 25 80 00       	push   $0x8025d8
  8004b0:	6a 6d                	push   $0x6d
  8004b2:	68 7c 25 80 00       	push   $0x80257c
  8004b7:	e8 5e 03 00 00       	call   80081a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 514+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  514) panic("Wrong page file allocation: ");
  8004bc:	e8 93 19 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  8004c1:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004c4:	3d 02 02 00 00       	cmp    $0x202,%eax
  8004c9:	74 14                	je     8004df <_main+0x4a7>
  8004cb:	83 ec 04             	sub    $0x4,%esp
  8004ce:	68 08 26 80 00       	push   $0x802608
  8004d3:	6a 6f                	push   $0x6f
  8004d5:	68 7c 25 80 00       	push   $0x80257c
  8004da:	e8 3b 03 00 00       	call   80081a <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8004df:	e8 ed 18 00 00       	call   801dd1 <sys_calculate_free_frames>
  8004e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004e7:	e8 68 19 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  8004ec:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  8004ef:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8004f2:	83 ec 0c             	sub    $0xc,%esp
  8004f5:	50                   	push   %eax
  8004f6:	e8 25 16 00 00       	call   801b20 <free>
  8004fb:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  8004fe:	e8 51 19 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  800503:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800506:	29 c2                	sub    %eax,%edx
  800508:	89 d0                	mov    %edx,%eax
  80050a:	3d 00 03 00 00       	cmp    $0x300,%eax
  80050f:	74 14                	je     800525 <_main+0x4ed>
  800511:	83 ec 04             	sub    $0x4,%esp
  800514:	68 25 26 80 00       	push   $0x802625
  800519:	6a 76                	push   $0x76
  80051b:	68 7c 25 80 00       	push   $0x80257c
  800520:	e8 f5 02 00 00       	call   80081a <_panic>

		//2 MB Hole [Resulting Hole = 2 MB + 2 MB + 4 KB = 4 MB + 4 KB]
		freeFrames = sys_calculate_free_frames() ;
  800525:	e8 a7 18 00 00       	call   801dd1 <sys_calculate_free_frames>
  80052a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80052d:	e8 22 19 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  800532:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  800535:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800538:	83 ec 0c             	sub    $0xc,%esp
  80053b:	50                   	push   %eax
  80053c:	e8 df 15 00 00       	call   801b20 <free>
  800541:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800544:	e8 0b 19 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  800549:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80054c:	29 c2                	sub    %eax,%edx
  80054e:	89 d0                	mov    %edx,%eax
  800550:	3d 00 02 00 00       	cmp    $0x200,%eax
  800555:	74 14                	je     80056b <_main+0x533>
  800557:	83 ec 04             	sub    $0x4,%esp
  80055a:	68 25 26 80 00       	push   $0x802625
  80055f:	6a 7d                	push   $0x7d
  800561:	68 7c 25 80 00       	push   $0x80257c
  800566:	e8 af 02 00 00       	call   80081a <_panic>

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
  80056b:	e8 61 18 00 00       	call   801dd1 <sys_calculate_free_frames>
  800570:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800573:	e8 dc 18 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  800578:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(5*Mega-kilo);
  80057b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80057e:	89 d0                	mov    %edx,%eax
  800580:	c1 e0 02             	shl    $0x2,%eax
  800583:	01 d0                	add    %edx,%eax
  800585:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800588:	83 ec 0c             	sub    $0xc,%esp
  80058b:	50                   	push   %eax
  80058c:	e8 ca 12 00 00       	call   80185b <malloc>
  800591:	83 c4 10             	add    $0x10,%esp
  800594:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 9*Mega + 24*kilo)) panic("Wrong start address for the allocated space... ");
  800597:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80059a:	89 c1                	mov    %eax,%ecx
  80059c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80059f:	89 d0                	mov    %edx,%eax
  8005a1:	c1 e0 03             	shl    $0x3,%eax
  8005a4:	01 d0                	add    %edx,%eax
  8005a6:	89 c3                	mov    %eax,%ebx
  8005a8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005ab:	89 d0                	mov    %edx,%eax
  8005ad:	01 c0                	add    %eax,%eax
  8005af:	01 d0                	add    %edx,%eax
  8005b1:	c1 e0 03             	shl    $0x3,%eax
  8005b4:	01 d8                	add    %ebx,%eax
  8005b6:	05 00 00 00 80       	add    $0x80000000,%eax
  8005bb:	39 c1                	cmp    %eax,%ecx
  8005bd:	74 17                	je     8005d6 <_main+0x59e>
  8005bf:	83 ec 04             	sub    $0x4,%esp
  8005c2:	68 d8 25 80 00       	push   $0x8025d8
  8005c7:	68 83 00 00 00       	push   $0x83
  8005cc:	68 7c 25 80 00       	push   $0x80257c
  8005d1:	e8 44 02 00 00       	call   80081a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 5*Mega/4096 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/4096) panic("Wrong page file allocation: ");
  8005d6:	e8 79 18 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  8005db:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8005de:	89 c1                	mov    %eax,%ecx
  8005e0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8005e3:	89 d0                	mov    %edx,%eax
  8005e5:	c1 e0 02             	shl    $0x2,%eax
  8005e8:	01 d0                	add    %edx,%eax
  8005ea:	85 c0                	test   %eax,%eax
  8005ec:	79 05                	jns    8005f3 <_main+0x5bb>
  8005ee:	05 ff 0f 00 00       	add    $0xfff,%eax
  8005f3:	c1 f8 0c             	sar    $0xc,%eax
  8005f6:	39 c1                	cmp    %eax,%ecx
  8005f8:	74 17                	je     800611 <_main+0x5d9>
  8005fa:	83 ec 04             	sub    $0x4,%esp
  8005fd:	68 08 26 80 00       	push   $0x802608
  800602:	68 85 00 00 00       	push   $0x85
  800607:	68 7c 25 80 00       	push   $0x80257c
  80060c:	e8 09 02 00 00       	call   80081a <_panic>
//		//if ((sys_calculate_free_frames() - freeFrames) != 514) panic("Wrong free: ");
//		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  514) panic("Wrong page file free: ");

		//[FIRST FIT Case]
		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  800611:	e8 bb 17 00 00       	call   801dd1 <sys_calculate_free_frames>
  800616:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800619:	e8 36 18 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  80061e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(3*Mega-kilo);
  800621:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800624:	89 c2                	mov    %eax,%edx
  800626:	01 d2                	add    %edx,%edx
  800628:	01 d0                	add    %edx,%eax
  80062a:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80062d:	83 ec 0c             	sub    $0xc,%esp
  800630:	50                   	push   %eax
  800631:	e8 25 12 00 00       	call   80185b <malloc>
  800636:	83 c4 10             	add    $0x10,%esp
  800639:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  80063c:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80063f:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800644:	74 17                	je     80065d <_main+0x625>
  800646:	83 ec 04             	sub    $0x4,%esp
  800649:	68 d8 25 80 00       	push   $0x8025d8
  80064e:	68 93 00 00 00       	push   $0x93
  800653:	68 7c 25 80 00       	push   $0x80257c
  800658:	e8 bd 01 00 00       	call   80081a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80065d:	e8 f2 17 00 00       	call   801e54 <sys_pf_calculate_allocated_pages>
  800662:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800665:	89 c2                	mov    %eax,%edx
  800667:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80066a:	89 c1                	mov    %eax,%ecx
  80066c:	01 c9                	add    %ecx,%ecx
  80066e:	01 c8                	add    %ecx,%eax
  800670:	85 c0                	test   %eax,%eax
  800672:	79 05                	jns    800679 <_main+0x641>
  800674:	05 ff 0f 00 00       	add    $0xfff,%eax
  800679:	c1 f8 0c             	sar    $0xc,%eax
  80067c:	39 c2                	cmp    %eax,%edx
  80067e:	74 17                	je     800697 <_main+0x65f>
  800680:	83 ec 04             	sub    $0x4,%esp
  800683:	68 08 26 80 00       	push   $0x802608
  800688:	68 95 00 00 00       	push   $0x95
  80068d:	68 7c 25 80 00       	push   $0x80257c
  800692:	e8 83 01 00 00       	call   80081a <_panic>
	//	b) Attempt to allocate large segment with no suitable fragment to fit on
	{
		//Large Allocation
		//int freeFrames = sys_calculate_free_frames() ;
		//usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[9] = malloc((USER_HEAP_MAX - USER_HEAP_START - 14*Mega));
  800697:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80069a:	89 d0                	mov    %edx,%eax
  80069c:	01 c0                	add    %eax,%eax
  80069e:	01 d0                	add    %edx,%eax
  8006a0:	01 c0                	add    %eax,%eax
  8006a2:	01 d0                	add    %edx,%eax
  8006a4:	01 c0                	add    %eax,%eax
  8006a6:	f7 d8                	neg    %eax
  8006a8:	05 00 00 00 20       	add    $0x20000000,%eax
  8006ad:	83 ec 0c             	sub    $0xc,%esp
  8006b0:	50                   	push   %eax
  8006b1:	e8 a5 11 00 00       	call   80185b <malloc>
  8006b6:	83 c4 10             	add    $0x10,%esp
  8006b9:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if (ptr_allocations[9] != NULL) panic("Malloc: Attempt to allocate large segment with no suitable fragment to fit on, should return NULL");
  8006bc:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8006bf:	85 c0                	test   %eax,%eax
  8006c1:	74 17                	je     8006da <_main+0x6a2>
  8006c3:	83 ec 04             	sub    $0x4,%esp
  8006c6:	68 3c 26 80 00       	push   $0x80263c
  8006cb:	68 9e 00 00 00       	push   $0x9e
  8006d0:	68 7c 25 80 00       	push   $0x80257c
  8006d5:	e8 40 01 00 00       	call   80081a <_panic>

		cprintf("Congratulations!! test FIRST FIT allocation (2) completed successfully.\n");
  8006da:	83 ec 0c             	sub    $0xc,%esp
  8006dd:	68 a0 26 80 00       	push   $0x8026a0
  8006e2:	e8 ea 03 00 00       	call   800ad1 <cprintf>
  8006e7:	83 c4 10             	add    $0x10,%esp

		return;
  8006ea:	90                   	nop
	}
}
  8006eb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8006ee:	5b                   	pop    %ebx
  8006ef:	5f                   	pop    %edi
  8006f0:	5d                   	pop    %ebp
  8006f1:	c3                   	ret    

008006f2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006f2:	55                   	push   %ebp
  8006f3:	89 e5                	mov    %esp,%ebp
  8006f5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006f8:	e8 09 16 00 00       	call   801d06 <sys_getenvindex>
  8006fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800700:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800703:	89 d0                	mov    %edx,%eax
  800705:	01 c0                	add    %eax,%eax
  800707:	01 d0                	add    %edx,%eax
  800709:	c1 e0 07             	shl    $0x7,%eax
  80070c:	29 d0                	sub    %edx,%eax
  80070e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800715:	01 c8                	add    %ecx,%eax
  800717:	01 c0                	add    %eax,%eax
  800719:	01 d0                	add    %edx,%eax
  80071b:	01 c0                	add    %eax,%eax
  80071d:	01 d0                	add    %edx,%eax
  80071f:	c1 e0 03             	shl    $0x3,%eax
  800722:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800727:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80072c:	a1 20 30 80 00       	mov    0x803020,%eax
  800731:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800737:	84 c0                	test   %al,%al
  800739:	74 0f                	je     80074a <libmain+0x58>
		binaryname = myEnv->prog_name;
  80073b:	a1 20 30 80 00       	mov    0x803020,%eax
  800740:	05 f0 ee 00 00       	add    $0xeef0,%eax
  800745:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80074a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80074e:	7e 0a                	jle    80075a <libmain+0x68>
		binaryname = argv[0];
  800750:	8b 45 0c             	mov    0xc(%ebp),%eax
  800753:	8b 00                	mov    (%eax),%eax
  800755:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80075a:	83 ec 08             	sub    $0x8,%esp
  80075d:	ff 75 0c             	pushl  0xc(%ebp)
  800760:	ff 75 08             	pushl  0x8(%ebp)
  800763:	e8 d0 f8 ff ff       	call   800038 <_main>
  800768:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80076b:	e8 31 17 00 00       	call   801ea1 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800770:	83 ec 0c             	sub    $0xc,%esp
  800773:	68 04 27 80 00       	push   $0x802704
  800778:	e8 54 03 00 00       	call   800ad1 <cprintf>
  80077d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800780:	a1 20 30 80 00       	mov    0x803020,%eax
  800785:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  80078b:	a1 20 30 80 00       	mov    0x803020,%eax
  800790:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  800796:	83 ec 04             	sub    $0x4,%esp
  800799:	52                   	push   %edx
  80079a:	50                   	push   %eax
  80079b:	68 2c 27 80 00       	push   $0x80272c
  8007a0:	e8 2c 03 00 00       	call   800ad1 <cprintf>
  8007a5:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8007a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ad:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  8007b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8007b8:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  8007be:	a1 20 30 80 00       	mov    0x803020,%eax
  8007c3:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  8007c9:	51                   	push   %ecx
  8007ca:	52                   	push   %edx
  8007cb:	50                   	push   %eax
  8007cc:	68 54 27 80 00       	push   $0x802754
  8007d1:	e8 fb 02 00 00       	call   800ad1 <cprintf>
  8007d6:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8007d9:	83 ec 0c             	sub    $0xc,%esp
  8007dc:	68 04 27 80 00       	push   $0x802704
  8007e1:	e8 eb 02 00 00       	call   800ad1 <cprintf>
  8007e6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007e9:	e8 cd 16 00 00       	call   801ebb <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007ee:	e8 19 00 00 00       	call   80080c <exit>
}
  8007f3:	90                   	nop
  8007f4:	c9                   	leave  
  8007f5:	c3                   	ret    

008007f6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007f6:	55                   	push   %ebp
  8007f7:	89 e5                	mov    %esp,%ebp
  8007f9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007fc:	83 ec 0c             	sub    $0xc,%esp
  8007ff:	6a 00                	push   $0x0
  800801:	e8 cc 14 00 00       	call   801cd2 <sys_env_destroy>
  800806:	83 c4 10             	add    $0x10,%esp
}
  800809:	90                   	nop
  80080a:	c9                   	leave  
  80080b:	c3                   	ret    

0080080c <exit>:

void
exit(void)
{
  80080c:	55                   	push   %ebp
  80080d:	89 e5                	mov    %esp,%ebp
  80080f:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800812:	e8 21 15 00 00       	call   801d38 <sys_env_exit>
}
  800817:	90                   	nop
  800818:	c9                   	leave  
  800819:	c3                   	ret    

0080081a <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80081a:	55                   	push   %ebp
  80081b:	89 e5                	mov    %esp,%ebp
  80081d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800820:	8d 45 10             	lea    0x10(%ebp),%eax
  800823:	83 c0 04             	add    $0x4,%eax
  800826:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800829:	a1 18 31 80 00       	mov    0x803118,%eax
  80082e:	85 c0                	test   %eax,%eax
  800830:	74 16                	je     800848 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800832:	a1 18 31 80 00       	mov    0x803118,%eax
  800837:	83 ec 08             	sub    $0x8,%esp
  80083a:	50                   	push   %eax
  80083b:	68 ac 27 80 00       	push   $0x8027ac
  800840:	e8 8c 02 00 00       	call   800ad1 <cprintf>
  800845:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800848:	a1 00 30 80 00       	mov    0x803000,%eax
  80084d:	ff 75 0c             	pushl  0xc(%ebp)
  800850:	ff 75 08             	pushl  0x8(%ebp)
  800853:	50                   	push   %eax
  800854:	68 b1 27 80 00       	push   $0x8027b1
  800859:	e8 73 02 00 00       	call   800ad1 <cprintf>
  80085e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800861:	8b 45 10             	mov    0x10(%ebp),%eax
  800864:	83 ec 08             	sub    $0x8,%esp
  800867:	ff 75 f4             	pushl  -0xc(%ebp)
  80086a:	50                   	push   %eax
  80086b:	e8 f6 01 00 00       	call   800a66 <vcprintf>
  800870:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800873:	83 ec 08             	sub    $0x8,%esp
  800876:	6a 00                	push   $0x0
  800878:	68 cd 27 80 00       	push   $0x8027cd
  80087d:	e8 e4 01 00 00       	call   800a66 <vcprintf>
  800882:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800885:	e8 82 ff ff ff       	call   80080c <exit>

	// should not return here
	while (1) ;
  80088a:	eb fe                	jmp    80088a <_panic+0x70>

0080088c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80088c:	55                   	push   %ebp
  80088d:	89 e5                	mov    %esp,%ebp
  80088f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800892:	a1 20 30 80 00       	mov    0x803020,%eax
  800897:	8b 50 74             	mov    0x74(%eax),%edx
  80089a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089d:	39 c2                	cmp    %eax,%edx
  80089f:	74 14                	je     8008b5 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8008a1:	83 ec 04             	sub    $0x4,%esp
  8008a4:	68 d0 27 80 00       	push   $0x8027d0
  8008a9:	6a 26                	push   $0x26
  8008ab:	68 1c 28 80 00       	push   $0x80281c
  8008b0:	e8 65 ff ff ff       	call   80081a <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8008b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008bc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8008c3:	e9 c4 00 00 00       	jmp    80098c <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8008c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008cb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d5:	01 d0                	add    %edx,%eax
  8008d7:	8b 00                	mov    (%eax),%eax
  8008d9:	85 c0                	test   %eax,%eax
  8008db:	75 08                	jne    8008e5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008dd:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008e0:	e9 a4 00 00 00       	jmp    800989 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8008e5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ec:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008f3:	eb 6b                	jmp    800960 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008f5:	a1 20 30 80 00       	mov    0x803020,%eax
  8008fa:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800900:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800903:	89 d0                	mov    %edx,%eax
  800905:	c1 e0 02             	shl    $0x2,%eax
  800908:	01 d0                	add    %edx,%eax
  80090a:	c1 e0 02             	shl    $0x2,%eax
  80090d:	01 c8                	add    %ecx,%eax
  80090f:	8a 40 04             	mov    0x4(%eax),%al
  800912:	84 c0                	test   %al,%al
  800914:	75 47                	jne    80095d <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800916:	a1 20 30 80 00       	mov    0x803020,%eax
  80091b:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800921:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800924:	89 d0                	mov    %edx,%eax
  800926:	c1 e0 02             	shl    $0x2,%eax
  800929:	01 d0                	add    %edx,%eax
  80092b:	c1 e0 02             	shl    $0x2,%eax
  80092e:	01 c8                	add    %ecx,%eax
  800930:	8b 00                	mov    (%eax),%eax
  800932:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800935:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800938:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80093d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80093f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800942:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800949:	8b 45 08             	mov    0x8(%ebp),%eax
  80094c:	01 c8                	add    %ecx,%eax
  80094e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800950:	39 c2                	cmp    %eax,%edx
  800952:	75 09                	jne    80095d <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800954:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80095b:	eb 12                	jmp    80096f <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80095d:	ff 45 e8             	incl   -0x18(%ebp)
  800960:	a1 20 30 80 00       	mov    0x803020,%eax
  800965:	8b 50 74             	mov    0x74(%eax),%edx
  800968:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80096b:	39 c2                	cmp    %eax,%edx
  80096d:	77 86                	ja     8008f5 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80096f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800973:	75 14                	jne    800989 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800975:	83 ec 04             	sub    $0x4,%esp
  800978:	68 28 28 80 00       	push   $0x802828
  80097d:	6a 3a                	push   $0x3a
  80097f:	68 1c 28 80 00       	push   $0x80281c
  800984:	e8 91 fe ff ff       	call   80081a <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800989:	ff 45 f0             	incl   -0x10(%ebp)
  80098c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80098f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800992:	0f 8c 30 ff ff ff    	jl     8008c8 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800998:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80099f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8009a6:	eb 27                	jmp    8009cf <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8009a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8009ad:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8009b3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009b6:	89 d0                	mov    %edx,%eax
  8009b8:	c1 e0 02             	shl    $0x2,%eax
  8009bb:	01 d0                	add    %edx,%eax
  8009bd:	c1 e0 02             	shl    $0x2,%eax
  8009c0:	01 c8                	add    %ecx,%eax
  8009c2:	8a 40 04             	mov    0x4(%eax),%al
  8009c5:	3c 01                	cmp    $0x1,%al
  8009c7:	75 03                	jne    8009cc <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8009c9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009cc:	ff 45 e0             	incl   -0x20(%ebp)
  8009cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8009d4:	8b 50 74             	mov    0x74(%eax),%edx
  8009d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009da:	39 c2                	cmp    %eax,%edx
  8009dc:	77 ca                	ja     8009a8 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009e1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009e4:	74 14                	je     8009fa <CheckWSWithoutLastIndex+0x16e>
		panic(
  8009e6:	83 ec 04             	sub    $0x4,%esp
  8009e9:	68 7c 28 80 00       	push   $0x80287c
  8009ee:	6a 44                	push   $0x44
  8009f0:	68 1c 28 80 00       	push   $0x80281c
  8009f5:	e8 20 fe ff ff       	call   80081a <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009fa:	90                   	nop
  8009fb:	c9                   	leave  
  8009fc:	c3                   	ret    

008009fd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009fd:	55                   	push   %ebp
  8009fe:	89 e5                	mov    %esp,%ebp
  800a00:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800a03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a06:	8b 00                	mov    (%eax),%eax
  800a08:	8d 48 01             	lea    0x1(%eax),%ecx
  800a0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a0e:	89 0a                	mov    %ecx,(%edx)
  800a10:	8b 55 08             	mov    0x8(%ebp),%edx
  800a13:	88 d1                	mov    %dl,%cl
  800a15:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a18:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1f:	8b 00                	mov    (%eax),%eax
  800a21:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a26:	75 2c                	jne    800a54 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a28:	a0 24 30 80 00       	mov    0x803024,%al
  800a2d:	0f b6 c0             	movzbl %al,%eax
  800a30:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a33:	8b 12                	mov    (%edx),%edx
  800a35:	89 d1                	mov    %edx,%ecx
  800a37:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a3a:	83 c2 08             	add    $0x8,%edx
  800a3d:	83 ec 04             	sub    $0x4,%esp
  800a40:	50                   	push   %eax
  800a41:	51                   	push   %ecx
  800a42:	52                   	push   %edx
  800a43:	e8 48 12 00 00       	call   801c90 <sys_cputs>
  800a48:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a57:	8b 40 04             	mov    0x4(%eax),%eax
  800a5a:	8d 50 01             	lea    0x1(%eax),%edx
  800a5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a60:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a63:	90                   	nop
  800a64:	c9                   	leave  
  800a65:	c3                   	ret    

00800a66 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a66:	55                   	push   %ebp
  800a67:	89 e5                	mov    %esp,%ebp
  800a69:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a6f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a76:	00 00 00 
	b.cnt = 0;
  800a79:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a80:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a83:	ff 75 0c             	pushl  0xc(%ebp)
  800a86:	ff 75 08             	pushl  0x8(%ebp)
  800a89:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a8f:	50                   	push   %eax
  800a90:	68 fd 09 80 00       	push   $0x8009fd
  800a95:	e8 11 02 00 00       	call   800cab <vprintfmt>
  800a9a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a9d:	a0 24 30 80 00       	mov    0x803024,%al
  800aa2:	0f b6 c0             	movzbl %al,%eax
  800aa5:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800aab:	83 ec 04             	sub    $0x4,%esp
  800aae:	50                   	push   %eax
  800aaf:	52                   	push   %edx
  800ab0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ab6:	83 c0 08             	add    $0x8,%eax
  800ab9:	50                   	push   %eax
  800aba:	e8 d1 11 00 00       	call   801c90 <sys_cputs>
  800abf:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800ac2:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800ac9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800acf:	c9                   	leave  
  800ad0:	c3                   	ret    

00800ad1 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ad1:	55                   	push   %ebp
  800ad2:	89 e5                	mov    %esp,%ebp
  800ad4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ad7:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800ade:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ae1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae7:	83 ec 08             	sub    $0x8,%esp
  800aea:	ff 75 f4             	pushl  -0xc(%ebp)
  800aed:	50                   	push   %eax
  800aee:	e8 73 ff ff ff       	call   800a66 <vcprintf>
  800af3:	83 c4 10             	add    $0x10,%esp
  800af6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800af9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800afc:	c9                   	leave  
  800afd:	c3                   	ret    

00800afe <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800afe:	55                   	push   %ebp
  800aff:	89 e5                	mov    %esp,%ebp
  800b01:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800b04:	e8 98 13 00 00       	call   801ea1 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800b09:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	83 ec 08             	sub    $0x8,%esp
  800b15:	ff 75 f4             	pushl  -0xc(%ebp)
  800b18:	50                   	push   %eax
  800b19:	e8 48 ff ff ff       	call   800a66 <vcprintf>
  800b1e:	83 c4 10             	add    $0x10,%esp
  800b21:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b24:	e8 92 13 00 00       	call   801ebb <sys_enable_interrupt>
	return cnt;
  800b29:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b2c:	c9                   	leave  
  800b2d:	c3                   	ret    

00800b2e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b2e:	55                   	push   %ebp
  800b2f:	89 e5                	mov    %esp,%ebp
  800b31:	53                   	push   %ebx
  800b32:	83 ec 14             	sub    $0x14,%esp
  800b35:	8b 45 10             	mov    0x10(%ebp),%eax
  800b38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b3b:	8b 45 14             	mov    0x14(%ebp),%eax
  800b3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b41:	8b 45 18             	mov    0x18(%ebp),%eax
  800b44:	ba 00 00 00 00       	mov    $0x0,%edx
  800b49:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b4c:	77 55                	ja     800ba3 <printnum+0x75>
  800b4e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b51:	72 05                	jb     800b58 <printnum+0x2a>
  800b53:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b56:	77 4b                	ja     800ba3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b58:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b5b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b5e:	8b 45 18             	mov    0x18(%ebp),%eax
  800b61:	ba 00 00 00 00       	mov    $0x0,%edx
  800b66:	52                   	push   %edx
  800b67:	50                   	push   %eax
  800b68:	ff 75 f4             	pushl  -0xc(%ebp)
  800b6b:	ff 75 f0             	pushl  -0x10(%ebp)
  800b6e:	e8 6d 17 00 00       	call   8022e0 <__udivdi3>
  800b73:	83 c4 10             	add    $0x10,%esp
  800b76:	83 ec 04             	sub    $0x4,%esp
  800b79:	ff 75 20             	pushl  0x20(%ebp)
  800b7c:	53                   	push   %ebx
  800b7d:	ff 75 18             	pushl  0x18(%ebp)
  800b80:	52                   	push   %edx
  800b81:	50                   	push   %eax
  800b82:	ff 75 0c             	pushl  0xc(%ebp)
  800b85:	ff 75 08             	pushl  0x8(%ebp)
  800b88:	e8 a1 ff ff ff       	call   800b2e <printnum>
  800b8d:	83 c4 20             	add    $0x20,%esp
  800b90:	eb 1a                	jmp    800bac <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b92:	83 ec 08             	sub    $0x8,%esp
  800b95:	ff 75 0c             	pushl  0xc(%ebp)
  800b98:	ff 75 20             	pushl  0x20(%ebp)
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	ff d0                	call   *%eax
  800ba0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ba3:	ff 4d 1c             	decl   0x1c(%ebp)
  800ba6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800baa:	7f e6                	jg     800b92 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800bac:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800baf:	bb 00 00 00 00       	mov    $0x0,%ebx
  800bb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bb7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bba:	53                   	push   %ebx
  800bbb:	51                   	push   %ecx
  800bbc:	52                   	push   %edx
  800bbd:	50                   	push   %eax
  800bbe:	e8 2d 18 00 00       	call   8023f0 <__umoddi3>
  800bc3:	83 c4 10             	add    $0x10,%esp
  800bc6:	05 f4 2a 80 00       	add    $0x802af4,%eax
  800bcb:	8a 00                	mov    (%eax),%al
  800bcd:	0f be c0             	movsbl %al,%eax
  800bd0:	83 ec 08             	sub    $0x8,%esp
  800bd3:	ff 75 0c             	pushl  0xc(%ebp)
  800bd6:	50                   	push   %eax
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	ff d0                	call   *%eax
  800bdc:	83 c4 10             	add    $0x10,%esp
}
  800bdf:	90                   	nop
  800be0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800be3:	c9                   	leave  
  800be4:	c3                   	ret    

00800be5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800be5:	55                   	push   %ebp
  800be6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800be8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bec:	7e 1c                	jle    800c0a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bee:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf1:	8b 00                	mov    (%eax),%eax
  800bf3:	8d 50 08             	lea    0x8(%eax),%edx
  800bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf9:	89 10                	mov    %edx,(%eax)
  800bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfe:	8b 00                	mov    (%eax),%eax
  800c00:	83 e8 08             	sub    $0x8,%eax
  800c03:	8b 50 04             	mov    0x4(%eax),%edx
  800c06:	8b 00                	mov    (%eax),%eax
  800c08:	eb 40                	jmp    800c4a <getuint+0x65>
	else if (lflag)
  800c0a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c0e:	74 1e                	je     800c2e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	8b 00                	mov    (%eax),%eax
  800c15:	8d 50 04             	lea    0x4(%eax),%edx
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1b:	89 10                	mov    %edx,(%eax)
  800c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c20:	8b 00                	mov    (%eax),%eax
  800c22:	83 e8 04             	sub    $0x4,%eax
  800c25:	8b 00                	mov    (%eax),%eax
  800c27:	ba 00 00 00 00       	mov    $0x0,%edx
  800c2c:	eb 1c                	jmp    800c4a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c31:	8b 00                	mov    (%eax),%eax
  800c33:	8d 50 04             	lea    0x4(%eax),%edx
  800c36:	8b 45 08             	mov    0x8(%ebp),%eax
  800c39:	89 10                	mov    %edx,(%eax)
  800c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3e:	8b 00                	mov    (%eax),%eax
  800c40:	83 e8 04             	sub    $0x4,%eax
  800c43:	8b 00                	mov    (%eax),%eax
  800c45:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c4a:	5d                   	pop    %ebp
  800c4b:	c3                   	ret    

00800c4c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c4c:	55                   	push   %ebp
  800c4d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c4f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c53:	7e 1c                	jle    800c71 <getint+0x25>
		return va_arg(*ap, long long);
  800c55:	8b 45 08             	mov    0x8(%ebp),%eax
  800c58:	8b 00                	mov    (%eax),%eax
  800c5a:	8d 50 08             	lea    0x8(%eax),%edx
  800c5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c60:	89 10                	mov    %edx,(%eax)
  800c62:	8b 45 08             	mov    0x8(%ebp),%eax
  800c65:	8b 00                	mov    (%eax),%eax
  800c67:	83 e8 08             	sub    $0x8,%eax
  800c6a:	8b 50 04             	mov    0x4(%eax),%edx
  800c6d:	8b 00                	mov    (%eax),%eax
  800c6f:	eb 38                	jmp    800ca9 <getint+0x5d>
	else if (lflag)
  800c71:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c75:	74 1a                	je     800c91 <getint+0x45>
		return va_arg(*ap, long);
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7a:	8b 00                	mov    (%eax),%eax
  800c7c:	8d 50 04             	lea    0x4(%eax),%edx
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	89 10                	mov    %edx,(%eax)
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	8b 00                	mov    (%eax),%eax
  800c89:	83 e8 04             	sub    $0x4,%eax
  800c8c:	8b 00                	mov    (%eax),%eax
  800c8e:	99                   	cltd   
  800c8f:	eb 18                	jmp    800ca9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	8b 00                	mov    (%eax),%eax
  800c96:	8d 50 04             	lea    0x4(%eax),%edx
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	89 10                	mov    %edx,(%eax)
  800c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca1:	8b 00                	mov    (%eax),%eax
  800ca3:	83 e8 04             	sub    $0x4,%eax
  800ca6:	8b 00                	mov    (%eax),%eax
  800ca8:	99                   	cltd   
}
  800ca9:	5d                   	pop    %ebp
  800caa:	c3                   	ret    

00800cab <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800cab:	55                   	push   %ebp
  800cac:	89 e5                	mov    %esp,%ebp
  800cae:	56                   	push   %esi
  800caf:	53                   	push   %ebx
  800cb0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800cb3:	eb 17                	jmp    800ccc <vprintfmt+0x21>
			if (ch == '\0')
  800cb5:	85 db                	test   %ebx,%ebx
  800cb7:	0f 84 af 03 00 00    	je     80106c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800cbd:	83 ec 08             	sub    $0x8,%esp
  800cc0:	ff 75 0c             	pushl  0xc(%ebp)
  800cc3:	53                   	push   %ebx
  800cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc7:	ff d0                	call   *%eax
  800cc9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ccc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccf:	8d 50 01             	lea    0x1(%eax),%edx
  800cd2:	89 55 10             	mov    %edx,0x10(%ebp)
  800cd5:	8a 00                	mov    (%eax),%al
  800cd7:	0f b6 d8             	movzbl %al,%ebx
  800cda:	83 fb 25             	cmp    $0x25,%ebx
  800cdd:	75 d6                	jne    800cb5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800cdf:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ce3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800cea:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cf1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cf8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800cff:	8b 45 10             	mov    0x10(%ebp),%eax
  800d02:	8d 50 01             	lea    0x1(%eax),%edx
  800d05:	89 55 10             	mov    %edx,0x10(%ebp)
  800d08:	8a 00                	mov    (%eax),%al
  800d0a:	0f b6 d8             	movzbl %al,%ebx
  800d0d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d10:	83 f8 55             	cmp    $0x55,%eax
  800d13:	0f 87 2b 03 00 00    	ja     801044 <vprintfmt+0x399>
  800d19:	8b 04 85 18 2b 80 00 	mov    0x802b18(,%eax,4),%eax
  800d20:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d22:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d26:	eb d7                	jmp    800cff <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d28:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d2c:	eb d1                	jmp    800cff <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d2e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d35:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d38:	89 d0                	mov    %edx,%eax
  800d3a:	c1 e0 02             	shl    $0x2,%eax
  800d3d:	01 d0                	add    %edx,%eax
  800d3f:	01 c0                	add    %eax,%eax
  800d41:	01 d8                	add    %ebx,%eax
  800d43:	83 e8 30             	sub    $0x30,%eax
  800d46:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d49:	8b 45 10             	mov    0x10(%ebp),%eax
  800d4c:	8a 00                	mov    (%eax),%al
  800d4e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d51:	83 fb 2f             	cmp    $0x2f,%ebx
  800d54:	7e 3e                	jle    800d94 <vprintfmt+0xe9>
  800d56:	83 fb 39             	cmp    $0x39,%ebx
  800d59:	7f 39                	jg     800d94 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d5b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d5e:	eb d5                	jmp    800d35 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d60:	8b 45 14             	mov    0x14(%ebp),%eax
  800d63:	83 c0 04             	add    $0x4,%eax
  800d66:	89 45 14             	mov    %eax,0x14(%ebp)
  800d69:	8b 45 14             	mov    0x14(%ebp),%eax
  800d6c:	83 e8 04             	sub    $0x4,%eax
  800d6f:	8b 00                	mov    (%eax),%eax
  800d71:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d74:	eb 1f                	jmp    800d95 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d76:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d7a:	79 83                	jns    800cff <vprintfmt+0x54>
				width = 0;
  800d7c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d83:	e9 77 ff ff ff       	jmp    800cff <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d88:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d8f:	e9 6b ff ff ff       	jmp    800cff <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d94:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d95:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d99:	0f 89 60 ff ff ff    	jns    800cff <vprintfmt+0x54>
				width = precision, precision = -1;
  800d9f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800da2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800da5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800dac:	e9 4e ff ff ff       	jmp    800cff <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800db1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800db4:	e9 46 ff ff ff       	jmp    800cff <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800db9:	8b 45 14             	mov    0x14(%ebp),%eax
  800dbc:	83 c0 04             	add    $0x4,%eax
  800dbf:	89 45 14             	mov    %eax,0x14(%ebp)
  800dc2:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc5:	83 e8 04             	sub    $0x4,%eax
  800dc8:	8b 00                	mov    (%eax),%eax
  800dca:	83 ec 08             	sub    $0x8,%esp
  800dcd:	ff 75 0c             	pushl  0xc(%ebp)
  800dd0:	50                   	push   %eax
  800dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd4:	ff d0                	call   *%eax
  800dd6:	83 c4 10             	add    $0x10,%esp
			break;
  800dd9:	e9 89 02 00 00       	jmp    801067 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800dde:	8b 45 14             	mov    0x14(%ebp),%eax
  800de1:	83 c0 04             	add    $0x4,%eax
  800de4:	89 45 14             	mov    %eax,0x14(%ebp)
  800de7:	8b 45 14             	mov    0x14(%ebp),%eax
  800dea:	83 e8 04             	sub    $0x4,%eax
  800ded:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800def:	85 db                	test   %ebx,%ebx
  800df1:	79 02                	jns    800df5 <vprintfmt+0x14a>
				err = -err;
  800df3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800df5:	83 fb 64             	cmp    $0x64,%ebx
  800df8:	7f 0b                	jg     800e05 <vprintfmt+0x15a>
  800dfa:	8b 34 9d 60 29 80 00 	mov    0x802960(,%ebx,4),%esi
  800e01:	85 f6                	test   %esi,%esi
  800e03:	75 19                	jne    800e1e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e05:	53                   	push   %ebx
  800e06:	68 05 2b 80 00       	push   $0x802b05
  800e0b:	ff 75 0c             	pushl  0xc(%ebp)
  800e0e:	ff 75 08             	pushl  0x8(%ebp)
  800e11:	e8 5e 02 00 00       	call   801074 <printfmt>
  800e16:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800e19:	e9 49 02 00 00       	jmp    801067 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e1e:	56                   	push   %esi
  800e1f:	68 0e 2b 80 00       	push   $0x802b0e
  800e24:	ff 75 0c             	pushl  0xc(%ebp)
  800e27:	ff 75 08             	pushl  0x8(%ebp)
  800e2a:	e8 45 02 00 00       	call   801074 <printfmt>
  800e2f:	83 c4 10             	add    $0x10,%esp
			break;
  800e32:	e9 30 02 00 00       	jmp    801067 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e37:	8b 45 14             	mov    0x14(%ebp),%eax
  800e3a:	83 c0 04             	add    $0x4,%eax
  800e3d:	89 45 14             	mov    %eax,0x14(%ebp)
  800e40:	8b 45 14             	mov    0x14(%ebp),%eax
  800e43:	83 e8 04             	sub    $0x4,%eax
  800e46:	8b 30                	mov    (%eax),%esi
  800e48:	85 f6                	test   %esi,%esi
  800e4a:	75 05                	jne    800e51 <vprintfmt+0x1a6>
				p = "(null)";
  800e4c:	be 11 2b 80 00       	mov    $0x802b11,%esi
			if (width > 0 && padc != '-')
  800e51:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e55:	7e 6d                	jle    800ec4 <vprintfmt+0x219>
  800e57:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e5b:	74 67                	je     800ec4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e5d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e60:	83 ec 08             	sub    $0x8,%esp
  800e63:	50                   	push   %eax
  800e64:	56                   	push   %esi
  800e65:	e8 0c 03 00 00       	call   801176 <strnlen>
  800e6a:	83 c4 10             	add    $0x10,%esp
  800e6d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e70:	eb 16                	jmp    800e88 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e72:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e76:	83 ec 08             	sub    $0x8,%esp
  800e79:	ff 75 0c             	pushl  0xc(%ebp)
  800e7c:	50                   	push   %eax
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	ff d0                	call   *%eax
  800e82:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e85:	ff 4d e4             	decl   -0x1c(%ebp)
  800e88:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e8c:	7f e4                	jg     800e72 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e8e:	eb 34                	jmp    800ec4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e90:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e94:	74 1c                	je     800eb2 <vprintfmt+0x207>
  800e96:	83 fb 1f             	cmp    $0x1f,%ebx
  800e99:	7e 05                	jle    800ea0 <vprintfmt+0x1f5>
  800e9b:	83 fb 7e             	cmp    $0x7e,%ebx
  800e9e:	7e 12                	jle    800eb2 <vprintfmt+0x207>
					putch('?', putdat);
  800ea0:	83 ec 08             	sub    $0x8,%esp
  800ea3:	ff 75 0c             	pushl  0xc(%ebp)
  800ea6:	6a 3f                	push   $0x3f
  800ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eab:	ff d0                	call   *%eax
  800ead:	83 c4 10             	add    $0x10,%esp
  800eb0:	eb 0f                	jmp    800ec1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800eb2:	83 ec 08             	sub    $0x8,%esp
  800eb5:	ff 75 0c             	pushl  0xc(%ebp)
  800eb8:	53                   	push   %ebx
  800eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebc:	ff d0                	call   *%eax
  800ebe:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ec1:	ff 4d e4             	decl   -0x1c(%ebp)
  800ec4:	89 f0                	mov    %esi,%eax
  800ec6:	8d 70 01             	lea    0x1(%eax),%esi
  800ec9:	8a 00                	mov    (%eax),%al
  800ecb:	0f be d8             	movsbl %al,%ebx
  800ece:	85 db                	test   %ebx,%ebx
  800ed0:	74 24                	je     800ef6 <vprintfmt+0x24b>
  800ed2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ed6:	78 b8                	js     800e90 <vprintfmt+0x1e5>
  800ed8:	ff 4d e0             	decl   -0x20(%ebp)
  800edb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800edf:	79 af                	jns    800e90 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ee1:	eb 13                	jmp    800ef6 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ee3:	83 ec 08             	sub    $0x8,%esp
  800ee6:	ff 75 0c             	pushl  0xc(%ebp)
  800ee9:	6a 20                	push   $0x20
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	ff d0                	call   *%eax
  800ef0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ef3:	ff 4d e4             	decl   -0x1c(%ebp)
  800ef6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800efa:	7f e7                	jg     800ee3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800efc:	e9 66 01 00 00       	jmp    801067 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f01:	83 ec 08             	sub    $0x8,%esp
  800f04:	ff 75 e8             	pushl  -0x18(%ebp)
  800f07:	8d 45 14             	lea    0x14(%ebp),%eax
  800f0a:	50                   	push   %eax
  800f0b:	e8 3c fd ff ff       	call   800c4c <getint>
  800f10:	83 c4 10             	add    $0x10,%esp
  800f13:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f16:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800f19:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1f:	85 d2                	test   %edx,%edx
  800f21:	79 23                	jns    800f46 <vprintfmt+0x29b>
				putch('-', putdat);
  800f23:	83 ec 08             	sub    $0x8,%esp
  800f26:	ff 75 0c             	pushl  0xc(%ebp)
  800f29:	6a 2d                	push   $0x2d
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	ff d0                	call   *%eax
  800f30:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f33:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f36:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f39:	f7 d8                	neg    %eax
  800f3b:	83 d2 00             	adc    $0x0,%edx
  800f3e:	f7 da                	neg    %edx
  800f40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f43:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f46:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f4d:	e9 bc 00 00 00       	jmp    80100e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f52:	83 ec 08             	sub    $0x8,%esp
  800f55:	ff 75 e8             	pushl  -0x18(%ebp)
  800f58:	8d 45 14             	lea    0x14(%ebp),%eax
  800f5b:	50                   	push   %eax
  800f5c:	e8 84 fc ff ff       	call   800be5 <getuint>
  800f61:	83 c4 10             	add    $0x10,%esp
  800f64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f67:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f6a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f71:	e9 98 00 00 00       	jmp    80100e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f76:	83 ec 08             	sub    $0x8,%esp
  800f79:	ff 75 0c             	pushl  0xc(%ebp)
  800f7c:	6a 58                	push   $0x58
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f81:	ff d0                	call   *%eax
  800f83:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f86:	83 ec 08             	sub    $0x8,%esp
  800f89:	ff 75 0c             	pushl  0xc(%ebp)
  800f8c:	6a 58                	push   $0x58
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	ff d0                	call   *%eax
  800f93:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f96:	83 ec 08             	sub    $0x8,%esp
  800f99:	ff 75 0c             	pushl  0xc(%ebp)
  800f9c:	6a 58                	push   $0x58
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	ff d0                	call   *%eax
  800fa3:	83 c4 10             	add    $0x10,%esp
			break;
  800fa6:	e9 bc 00 00 00       	jmp    801067 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800fab:	83 ec 08             	sub    $0x8,%esp
  800fae:	ff 75 0c             	pushl  0xc(%ebp)
  800fb1:	6a 30                	push   $0x30
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	ff d0                	call   *%eax
  800fb8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800fbb:	83 ec 08             	sub    $0x8,%esp
  800fbe:	ff 75 0c             	pushl  0xc(%ebp)
  800fc1:	6a 78                	push   $0x78
  800fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc6:	ff d0                	call   *%eax
  800fc8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800fcb:	8b 45 14             	mov    0x14(%ebp),%eax
  800fce:	83 c0 04             	add    $0x4,%eax
  800fd1:	89 45 14             	mov    %eax,0x14(%ebp)
  800fd4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd7:	83 e8 04             	sub    $0x4,%eax
  800fda:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fdc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fdf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fe6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fed:	eb 1f                	jmp    80100e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fef:	83 ec 08             	sub    $0x8,%esp
  800ff2:	ff 75 e8             	pushl  -0x18(%ebp)
  800ff5:	8d 45 14             	lea    0x14(%ebp),%eax
  800ff8:	50                   	push   %eax
  800ff9:	e8 e7 fb ff ff       	call   800be5 <getuint>
  800ffe:	83 c4 10             	add    $0x10,%esp
  801001:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801004:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801007:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80100e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801012:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801015:	83 ec 04             	sub    $0x4,%esp
  801018:	52                   	push   %edx
  801019:	ff 75 e4             	pushl  -0x1c(%ebp)
  80101c:	50                   	push   %eax
  80101d:	ff 75 f4             	pushl  -0xc(%ebp)
  801020:	ff 75 f0             	pushl  -0x10(%ebp)
  801023:	ff 75 0c             	pushl  0xc(%ebp)
  801026:	ff 75 08             	pushl  0x8(%ebp)
  801029:	e8 00 fb ff ff       	call   800b2e <printnum>
  80102e:	83 c4 20             	add    $0x20,%esp
			break;
  801031:	eb 34                	jmp    801067 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801033:	83 ec 08             	sub    $0x8,%esp
  801036:	ff 75 0c             	pushl  0xc(%ebp)
  801039:	53                   	push   %ebx
  80103a:	8b 45 08             	mov    0x8(%ebp),%eax
  80103d:	ff d0                	call   *%eax
  80103f:	83 c4 10             	add    $0x10,%esp
			break;
  801042:	eb 23                	jmp    801067 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801044:	83 ec 08             	sub    $0x8,%esp
  801047:	ff 75 0c             	pushl  0xc(%ebp)
  80104a:	6a 25                	push   $0x25
  80104c:	8b 45 08             	mov    0x8(%ebp),%eax
  80104f:	ff d0                	call   *%eax
  801051:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801054:	ff 4d 10             	decl   0x10(%ebp)
  801057:	eb 03                	jmp    80105c <vprintfmt+0x3b1>
  801059:	ff 4d 10             	decl   0x10(%ebp)
  80105c:	8b 45 10             	mov    0x10(%ebp),%eax
  80105f:	48                   	dec    %eax
  801060:	8a 00                	mov    (%eax),%al
  801062:	3c 25                	cmp    $0x25,%al
  801064:	75 f3                	jne    801059 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801066:	90                   	nop
		}
	}
  801067:	e9 47 fc ff ff       	jmp    800cb3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80106c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80106d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801070:	5b                   	pop    %ebx
  801071:	5e                   	pop    %esi
  801072:	5d                   	pop    %ebp
  801073:	c3                   	ret    

00801074 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801074:	55                   	push   %ebp
  801075:	89 e5                	mov    %esp,%ebp
  801077:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80107a:	8d 45 10             	lea    0x10(%ebp),%eax
  80107d:	83 c0 04             	add    $0x4,%eax
  801080:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801083:	8b 45 10             	mov    0x10(%ebp),%eax
  801086:	ff 75 f4             	pushl  -0xc(%ebp)
  801089:	50                   	push   %eax
  80108a:	ff 75 0c             	pushl  0xc(%ebp)
  80108d:	ff 75 08             	pushl  0x8(%ebp)
  801090:	e8 16 fc ff ff       	call   800cab <vprintfmt>
  801095:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801098:	90                   	nop
  801099:	c9                   	leave  
  80109a:	c3                   	ret    

0080109b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80109b:	55                   	push   %ebp
  80109c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80109e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a1:	8b 40 08             	mov    0x8(%eax),%eax
  8010a4:	8d 50 01             	lea    0x1(%eax),%edx
  8010a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010aa:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8010ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b0:	8b 10                	mov    (%eax),%edx
  8010b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b5:	8b 40 04             	mov    0x4(%eax),%eax
  8010b8:	39 c2                	cmp    %eax,%edx
  8010ba:	73 12                	jae    8010ce <sprintputch+0x33>
		*b->buf++ = ch;
  8010bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bf:	8b 00                	mov    (%eax),%eax
  8010c1:	8d 48 01             	lea    0x1(%eax),%ecx
  8010c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c7:	89 0a                	mov    %ecx,(%edx)
  8010c9:	8b 55 08             	mov    0x8(%ebp),%edx
  8010cc:	88 10                	mov    %dl,(%eax)
}
  8010ce:	90                   	nop
  8010cf:	5d                   	pop    %ebp
  8010d0:	c3                   	ret    

008010d1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010d1:	55                   	push   %ebp
  8010d2:	89 e5                	mov    %esp,%ebp
  8010d4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010da:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	01 d0                	add    %edx,%eax
  8010e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010f2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010f6:	74 06                	je     8010fe <vsnprintf+0x2d>
  8010f8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010fc:	7f 07                	jg     801105 <vsnprintf+0x34>
		return -E_INVAL;
  8010fe:	b8 03 00 00 00       	mov    $0x3,%eax
  801103:	eb 20                	jmp    801125 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801105:	ff 75 14             	pushl  0x14(%ebp)
  801108:	ff 75 10             	pushl  0x10(%ebp)
  80110b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80110e:	50                   	push   %eax
  80110f:	68 9b 10 80 00       	push   $0x80109b
  801114:	e8 92 fb ff ff       	call   800cab <vprintfmt>
  801119:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80111c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80111f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801122:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801125:	c9                   	leave  
  801126:	c3                   	ret    

00801127 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801127:	55                   	push   %ebp
  801128:	89 e5                	mov    %esp,%ebp
  80112a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80112d:	8d 45 10             	lea    0x10(%ebp),%eax
  801130:	83 c0 04             	add    $0x4,%eax
  801133:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801136:	8b 45 10             	mov    0x10(%ebp),%eax
  801139:	ff 75 f4             	pushl  -0xc(%ebp)
  80113c:	50                   	push   %eax
  80113d:	ff 75 0c             	pushl  0xc(%ebp)
  801140:	ff 75 08             	pushl  0x8(%ebp)
  801143:	e8 89 ff ff ff       	call   8010d1 <vsnprintf>
  801148:	83 c4 10             	add    $0x10,%esp
  80114b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80114e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801151:	c9                   	leave  
  801152:	c3                   	ret    

00801153 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801153:	55                   	push   %ebp
  801154:	89 e5                	mov    %esp,%ebp
  801156:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801159:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801160:	eb 06                	jmp    801168 <strlen+0x15>
		n++;
  801162:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801165:	ff 45 08             	incl   0x8(%ebp)
  801168:	8b 45 08             	mov    0x8(%ebp),%eax
  80116b:	8a 00                	mov    (%eax),%al
  80116d:	84 c0                	test   %al,%al
  80116f:	75 f1                	jne    801162 <strlen+0xf>
		n++;
	return n;
  801171:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801174:	c9                   	leave  
  801175:	c3                   	ret    

00801176 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801176:	55                   	push   %ebp
  801177:	89 e5                	mov    %esp,%ebp
  801179:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80117c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801183:	eb 09                	jmp    80118e <strnlen+0x18>
		n++;
  801185:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801188:	ff 45 08             	incl   0x8(%ebp)
  80118b:	ff 4d 0c             	decl   0xc(%ebp)
  80118e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801192:	74 09                	je     80119d <strnlen+0x27>
  801194:	8b 45 08             	mov    0x8(%ebp),%eax
  801197:	8a 00                	mov    (%eax),%al
  801199:	84 c0                	test   %al,%al
  80119b:	75 e8                	jne    801185 <strnlen+0xf>
		n++;
	return n;
  80119d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011a0:	c9                   	leave  
  8011a1:	c3                   	ret    

008011a2 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8011a2:	55                   	push   %ebp
  8011a3:	89 e5                	mov    %esp,%ebp
  8011a5:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8011a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8011ae:	90                   	nop
  8011af:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b2:	8d 50 01             	lea    0x1(%eax),%edx
  8011b5:	89 55 08             	mov    %edx,0x8(%ebp)
  8011b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011bb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011be:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8011c1:	8a 12                	mov    (%edx),%dl
  8011c3:	88 10                	mov    %dl,(%eax)
  8011c5:	8a 00                	mov    (%eax),%al
  8011c7:	84 c0                	test   %al,%al
  8011c9:	75 e4                	jne    8011af <strcpy+0xd>
		/* do nothing */;
	return ret;
  8011cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011ce:	c9                   	leave  
  8011cf:	c3                   	ret    

008011d0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8011d0:	55                   	push   %ebp
  8011d1:	89 e5                	mov    %esp,%ebp
  8011d3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8011dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011e3:	eb 1f                	jmp    801204 <strncpy+0x34>
		*dst++ = *src;
  8011e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e8:	8d 50 01             	lea    0x1(%eax),%edx
  8011eb:	89 55 08             	mov    %edx,0x8(%ebp)
  8011ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011f1:	8a 12                	mov    (%edx),%dl
  8011f3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8011f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	84 c0                	test   %al,%al
  8011fc:	74 03                	je     801201 <strncpy+0x31>
			src++;
  8011fe:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801201:	ff 45 fc             	incl   -0x4(%ebp)
  801204:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801207:	3b 45 10             	cmp    0x10(%ebp),%eax
  80120a:	72 d9                	jb     8011e5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80120c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80120f:	c9                   	leave  
  801210:	c3                   	ret    

00801211 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801211:	55                   	push   %ebp
  801212:	89 e5                	mov    %esp,%ebp
  801214:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801217:	8b 45 08             	mov    0x8(%ebp),%eax
  80121a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80121d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801221:	74 30                	je     801253 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801223:	eb 16                	jmp    80123b <strlcpy+0x2a>
			*dst++ = *src++;
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	8d 50 01             	lea    0x1(%eax),%edx
  80122b:	89 55 08             	mov    %edx,0x8(%ebp)
  80122e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801231:	8d 4a 01             	lea    0x1(%edx),%ecx
  801234:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801237:	8a 12                	mov    (%edx),%dl
  801239:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80123b:	ff 4d 10             	decl   0x10(%ebp)
  80123e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801242:	74 09                	je     80124d <strlcpy+0x3c>
  801244:	8b 45 0c             	mov    0xc(%ebp),%eax
  801247:	8a 00                	mov    (%eax),%al
  801249:	84 c0                	test   %al,%al
  80124b:	75 d8                	jne    801225 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80124d:	8b 45 08             	mov    0x8(%ebp),%eax
  801250:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801253:	8b 55 08             	mov    0x8(%ebp),%edx
  801256:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801259:	29 c2                	sub    %eax,%edx
  80125b:	89 d0                	mov    %edx,%eax
}
  80125d:	c9                   	leave  
  80125e:	c3                   	ret    

0080125f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80125f:	55                   	push   %ebp
  801260:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801262:	eb 06                	jmp    80126a <strcmp+0xb>
		p++, q++;
  801264:	ff 45 08             	incl   0x8(%ebp)
  801267:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80126a:	8b 45 08             	mov    0x8(%ebp),%eax
  80126d:	8a 00                	mov    (%eax),%al
  80126f:	84 c0                	test   %al,%al
  801271:	74 0e                	je     801281 <strcmp+0x22>
  801273:	8b 45 08             	mov    0x8(%ebp),%eax
  801276:	8a 10                	mov    (%eax),%dl
  801278:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127b:	8a 00                	mov    (%eax),%al
  80127d:	38 c2                	cmp    %al,%dl
  80127f:	74 e3                	je     801264 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	8a 00                	mov    (%eax),%al
  801286:	0f b6 d0             	movzbl %al,%edx
  801289:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128c:	8a 00                	mov    (%eax),%al
  80128e:	0f b6 c0             	movzbl %al,%eax
  801291:	29 c2                	sub    %eax,%edx
  801293:	89 d0                	mov    %edx,%eax
}
  801295:	5d                   	pop    %ebp
  801296:	c3                   	ret    

00801297 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801297:	55                   	push   %ebp
  801298:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80129a:	eb 09                	jmp    8012a5 <strncmp+0xe>
		n--, p++, q++;
  80129c:	ff 4d 10             	decl   0x10(%ebp)
  80129f:	ff 45 08             	incl   0x8(%ebp)
  8012a2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8012a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012a9:	74 17                	je     8012c2 <strncmp+0x2b>
  8012ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ae:	8a 00                	mov    (%eax),%al
  8012b0:	84 c0                	test   %al,%al
  8012b2:	74 0e                	je     8012c2 <strncmp+0x2b>
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	8a 10                	mov    (%eax),%dl
  8012b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bc:	8a 00                	mov    (%eax),%al
  8012be:	38 c2                	cmp    %al,%dl
  8012c0:	74 da                	je     80129c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8012c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012c6:	75 07                	jne    8012cf <strncmp+0x38>
		return 0;
  8012c8:	b8 00 00 00 00       	mov    $0x0,%eax
  8012cd:	eb 14                	jmp    8012e3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8012cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d2:	8a 00                	mov    (%eax),%al
  8012d4:	0f b6 d0             	movzbl %al,%edx
  8012d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012da:	8a 00                	mov    (%eax),%al
  8012dc:	0f b6 c0             	movzbl %al,%eax
  8012df:	29 c2                	sub    %eax,%edx
  8012e1:	89 d0                	mov    %edx,%eax
}
  8012e3:	5d                   	pop    %ebp
  8012e4:	c3                   	ret    

008012e5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8012e5:	55                   	push   %ebp
  8012e6:	89 e5                	mov    %esp,%ebp
  8012e8:	83 ec 04             	sub    $0x4,%esp
  8012eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ee:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012f1:	eb 12                	jmp    801305 <strchr+0x20>
		if (*s == c)
  8012f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f6:	8a 00                	mov    (%eax),%al
  8012f8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8012fb:	75 05                	jne    801302 <strchr+0x1d>
			return (char *) s;
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	eb 11                	jmp    801313 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801302:	ff 45 08             	incl   0x8(%ebp)
  801305:	8b 45 08             	mov    0x8(%ebp),%eax
  801308:	8a 00                	mov    (%eax),%al
  80130a:	84 c0                	test   %al,%al
  80130c:	75 e5                	jne    8012f3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80130e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801313:	c9                   	leave  
  801314:	c3                   	ret    

00801315 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801315:	55                   	push   %ebp
  801316:	89 e5                	mov    %esp,%ebp
  801318:	83 ec 04             	sub    $0x4,%esp
  80131b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801321:	eb 0d                	jmp    801330 <strfind+0x1b>
		if (*s == c)
  801323:	8b 45 08             	mov    0x8(%ebp),%eax
  801326:	8a 00                	mov    (%eax),%al
  801328:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80132b:	74 0e                	je     80133b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80132d:	ff 45 08             	incl   0x8(%ebp)
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	8a 00                	mov    (%eax),%al
  801335:	84 c0                	test   %al,%al
  801337:	75 ea                	jne    801323 <strfind+0xe>
  801339:	eb 01                	jmp    80133c <strfind+0x27>
		if (*s == c)
			break;
  80133b:	90                   	nop
	return (char *) s;
  80133c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80133f:	c9                   	leave  
  801340:	c3                   	ret    

00801341 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801341:	55                   	push   %ebp
  801342:	89 e5                	mov    %esp,%ebp
  801344:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801347:	8b 45 08             	mov    0x8(%ebp),%eax
  80134a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80134d:	8b 45 10             	mov    0x10(%ebp),%eax
  801350:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801353:	eb 0e                	jmp    801363 <memset+0x22>
		*p++ = c;
  801355:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801358:	8d 50 01             	lea    0x1(%eax),%edx
  80135b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80135e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801361:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801363:	ff 4d f8             	decl   -0x8(%ebp)
  801366:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80136a:	79 e9                	jns    801355 <memset+0x14>
		*p++ = c;

	return v;
  80136c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80136f:	c9                   	leave  
  801370:	c3                   	ret    

00801371 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801371:	55                   	push   %ebp
  801372:	89 e5                	mov    %esp,%ebp
  801374:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801377:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80137d:	8b 45 08             	mov    0x8(%ebp),%eax
  801380:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801383:	eb 16                	jmp    80139b <memcpy+0x2a>
		*d++ = *s++;
  801385:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801388:	8d 50 01             	lea    0x1(%eax),%edx
  80138b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80138e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801391:	8d 4a 01             	lea    0x1(%edx),%ecx
  801394:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801397:	8a 12                	mov    (%edx),%dl
  801399:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80139b:	8b 45 10             	mov    0x10(%ebp),%eax
  80139e:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013a1:	89 55 10             	mov    %edx,0x10(%ebp)
  8013a4:	85 c0                	test   %eax,%eax
  8013a6:	75 dd                	jne    801385 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8013a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013ab:	c9                   	leave  
  8013ac:	c3                   	ret    

008013ad <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8013ad:	55                   	push   %ebp
  8013ae:	89 e5                	mov    %esp,%ebp
  8013b0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8013b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8013b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8013bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013c2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013c5:	73 50                	jae    801417 <memmove+0x6a>
  8013c7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8013cd:	01 d0                	add    %edx,%eax
  8013cf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013d2:	76 43                	jbe    801417 <memmove+0x6a>
		s += n;
  8013d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8013da:	8b 45 10             	mov    0x10(%ebp),%eax
  8013dd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8013e0:	eb 10                	jmp    8013f2 <memmove+0x45>
			*--d = *--s;
  8013e2:	ff 4d f8             	decl   -0x8(%ebp)
  8013e5:	ff 4d fc             	decl   -0x4(%ebp)
  8013e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013eb:	8a 10                	mov    (%eax),%dl
  8013ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013f0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8013f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013f8:	89 55 10             	mov    %edx,0x10(%ebp)
  8013fb:	85 c0                	test   %eax,%eax
  8013fd:	75 e3                	jne    8013e2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8013ff:	eb 23                	jmp    801424 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801401:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801404:	8d 50 01             	lea    0x1(%eax),%edx
  801407:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80140a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80140d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801410:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801413:	8a 12                	mov    (%edx),%dl
  801415:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801417:	8b 45 10             	mov    0x10(%ebp),%eax
  80141a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80141d:	89 55 10             	mov    %edx,0x10(%ebp)
  801420:	85 c0                	test   %eax,%eax
  801422:	75 dd                	jne    801401 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801427:	c9                   	leave  
  801428:	c3                   	ret    

00801429 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801429:	55                   	push   %ebp
  80142a:	89 e5                	mov    %esp,%ebp
  80142c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80142f:	8b 45 08             	mov    0x8(%ebp),%eax
  801432:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801435:	8b 45 0c             	mov    0xc(%ebp),%eax
  801438:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80143b:	eb 2a                	jmp    801467 <memcmp+0x3e>
		if (*s1 != *s2)
  80143d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801440:	8a 10                	mov    (%eax),%dl
  801442:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801445:	8a 00                	mov    (%eax),%al
  801447:	38 c2                	cmp    %al,%dl
  801449:	74 16                	je     801461 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80144b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	0f b6 d0             	movzbl %al,%edx
  801453:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801456:	8a 00                	mov    (%eax),%al
  801458:	0f b6 c0             	movzbl %al,%eax
  80145b:	29 c2                	sub    %eax,%edx
  80145d:	89 d0                	mov    %edx,%eax
  80145f:	eb 18                	jmp    801479 <memcmp+0x50>
		s1++, s2++;
  801461:	ff 45 fc             	incl   -0x4(%ebp)
  801464:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801467:	8b 45 10             	mov    0x10(%ebp),%eax
  80146a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80146d:	89 55 10             	mov    %edx,0x10(%ebp)
  801470:	85 c0                	test   %eax,%eax
  801472:	75 c9                	jne    80143d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801474:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801479:	c9                   	leave  
  80147a:	c3                   	ret    

0080147b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80147b:	55                   	push   %ebp
  80147c:	89 e5                	mov    %esp,%ebp
  80147e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801481:	8b 55 08             	mov    0x8(%ebp),%edx
  801484:	8b 45 10             	mov    0x10(%ebp),%eax
  801487:	01 d0                	add    %edx,%eax
  801489:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80148c:	eb 15                	jmp    8014a3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80148e:	8b 45 08             	mov    0x8(%ebp),%eax
  801491:	8a 00                	mov    (%eax),%al
  801493:	0f b6 d0             	movzbl %al,%edx
  801496:	8b 45 0c             	mov    0xc(%ebp),%eax
  801499:	0f b6 c0             	movzbl %al,%eax
  80149c:	39 c2                	cmp    %eax,%edx
  80149e:	74 0d                	je     8014ad <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8014a0:	ff 45 08             	incl   0x8(%ebp)
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8014a9:	72 e3                	jb     80148e <memfind+0x13>
  8014ab:	eb 01                	jmp    8014ae <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8014ad:	90                   	nop
	return (void *) s;
  8014ae:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014b1:	c9                   	leave  
  8014b2:	c3                   	ret    

008014b3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8014b3:	55                   	push   %ebp
  8014b4:	89 e5                	mov    %esp,%ebp
  8014b6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8014b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8014c0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8014c7:	eb 03                	jmp    8014cc <strtol+0x19>
		s++;
  8014c9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8014cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cf:	8a 00                	mov    (%eax),%al
  8014d1:	3c 20                	cmp    $0x20,%al
  8014d3:	74 f4                	je     8014c9 <strtol+0x16>
  8014d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d8:	8a 00                	mov    (%eax),%al
  8014da:	3c 09                	cmp    $0x9,%al
  8014dc:	74 eb                	je     8014c9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8014de:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e1:	8a 00                	mov    (%eax),%al
  8014e3:	3c 2b                	cmp    $0x2b,%al
  8014e5:	75 05                	jne    8014ec <strtol+0x39>
		s++;
  8014e7:	ff 45 08             	incl   0x8(%ebp)
  8014ea:	eb 13                	jmp    8014ff <strtol+0x4c>
	else if (*s == '-')
  8014ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ef:	8a 00                	mov    (%eax),%al
  8014f1:	3c 2d                	cmp    $0x2d,%al
  8014f3:	75 0a                	jne    8014ff <strtol+0x4c>
		s++, neg = 1;
  8014f5:	ff 45 08             	incl   0x8(%ebp)
  8014f8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8014ff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801503:	74 06                	je     80150b <strtol+0x58>
  801505:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801509:	75 20                	jne    80152b <strtol+0x78>
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	8a 00                	mov    (%eax),%al
  801510:	3c 30                	cmp    $0x30,%al
  801512:	75 17                	jne    80152b <strtol+0x78>
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	40                   	inc    %eax
  801518:	8a 00                	mov    (%eax),%al
  80151a:	3c 78                	cmp    $0x78,%al
  80151c:	75 0d                	jne    80152b <strtol+0x78>
		s += 2, base = 16;
  80151e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801522:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801529:	eb 28                	jmp    801553 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80152b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80152f:	75 15                	jne    801546 <strtol+0x93>
  801531:	8b 45 08             	mov    0x8(%ebp),%eax
  801534:	8a 00                	mov    (%eax),%al
  801536:	3c 30                	cmp    $0x30,%al
  801538:	75 0c                	jne    801546 <strtol+0x93>
		s++, base = 8;
  80153a:	ff 45 08             	incl   0x8(%ebp)
  80153d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801544:	eb 0d                	jmp    801553 <strtol+0xa0>
	else if (base == 0)
  801546:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80154a:	75 07                	jne    801553 <strtol+0xa0>
		base = 10;
  80154c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801553:	8b 45 08             	mov    0x8(%ebp),%eax
  801556:	8a 00                	mov    (%eax),%al
  801558:	3c 2f                	cmp    $0x2f,%al
  80155a:	7e 19                	jle    801575 <strtol+0xc2>
  80155c:	8b 45 08             	mov    0x8(%ebp),%eax
  80155f:	8a 00                	mov    (%eax),%al
  801561:	3c 39                	cmp    $0x39,%al
  801563:	7f 10                	jg     801575 <strtol+0xc2>
			dig = *s - '0';
  801565:	8b 45 08             	mov    0x8(%ebp),%eax
  801568:	8a 00                	mov    (%eax),%al
  80156a:	0f be c0             	movsbl %al,%eax
  80156d:	83 e8 30             	sub    $0x30,%eax
  801570:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801573:	eb 42                	jmp    8015b7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801575:	8b 45 08             	mov    0x8(%ebp),%eax
  801578:	8a 00                	mov    (%eax),%al
  80157a:	3c 60                	cmp    $0x60,%al
  80157c:	7e 19                	jle    801597 <strtol+0xe4>
  80157e:	8b 45 08             	mov    0x8(%ebp),%eax
  801581:	8a 00                	mov    (%eax),%al
  801583:	3c 7a                	cmp    $0x7a,%al
  801585:	7f 10                	jg     801597 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801587:	8b 45 08             	mov    0x8(%ebp),%eax
  80158a:	8a 00                	mov    (%eax),%al
  80158c:	0f be c0             	movsbl %al,%eax
  80158f:	83 e8 57             	sub    $0x57,%eax
  801592:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801595:	eb 20                	jmp    8015b7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801597:	8b 45 08             	mov    0x8(%ebp),%eax
  80159a:	8a 00                	mov    (%eax),%al
  80159c:	3c 40                	cmp    $0x40,%al
  80159e:	7e 39                	jle    8015d9 <strtol+0x126>
  8015a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a3:	8a 00                	mov    (%eax),%al
  8015a5:	3c 5a                	cmp    $0x5a,%al
  8015a7:	7f 30                	jg     8015d9 <strtol+0x126>
			dig = *s - 'A' + 10;
  8015a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ac:	8a 00                	mov    (%eax),%al
  8015ae:	0f be c0             	movsbl %al,%eax
  8015b1:	83 e8 37             	sub    $0x37,%eax
  8015b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8015b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ba:	3b 45 10             	cmp    0x10(%ebp),%eax
  8015bd:	7d 19                	jge    8015d8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8015bf:	ff 45 08             	incl   0x8(%ebp)
  8015c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015c5:	0f af 45 10          	imul   0x10(%ebp),%eax
  8015c9:	89 c2                	mov    %eax,%edx
  8015cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ce:	01 d0                	add    %edx,%eax
  8015d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8015d3:	e9 7b ff ff ff       	jmp    801553 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8015d8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8015d9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015dd:	74 08                	je     8015e7 <strtol+0x134>
		*endptr = (char *) s;
  8015df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e2:	8b 55 08             	mov    0x8(%ebp),%edx
  8015e5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8015e7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015eb:	74 07                	je     8015f4 <strtol+0x141>
  8015ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015f0:	f7 d8                	neg    %eax
  8015f2:	eb 03                	jmp    8015f7 <strtol+0x144>
  8015f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015f7:	c9                   	leave  
  8015f8:	c3                   	ret    

008015f9 <ltostr>:

void
ltostr(long value, char *str)
{
  8015f9:	55                   	push   %ebp
  8015fa:	89 e5                	mov    %esp,%ebp
  8015fc:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8015ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801606:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80160d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801611:	79 13                	jns    801626 <ltostr+0x2d>
	{
		neg = 1;
  801613:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80161a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80161d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801620:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801623:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80162e:	99                   	cltd   
  80162f:	f7 f9                	idiv   %ecx
  801631:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801634:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801637:	8d 50 01             	lea    0x1(%eax),%edx
  80163a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80163d:	89 c2                	mov    %eax,%edx
  80163f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801642:	01 d0                	add    %edx,%eax
  801644:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801647:	83 c2 30             	add    $0x30,%edx
  80164a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80164c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80164f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801654:	f7 e9                	imul   %ecx
  801656:	c1 fa 02             	sar    $0x2,%edx
  801659:	89 c8                	mov    %ecx,%eax
  80165b:	c1 f8 1f             	sar    $0x1f,%eax
  80165e:	29 c2                	sub    %eax,%edx
  801660:	89 d0                	mov    %edx,%eax
  801662:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801665:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801668:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80166d:	f7 e9                	imul   %ecx
  80166f:	c1 fa 02             	sar    $0x2,%edx
  801672:	89 c8                	mov    %ecx,%eax
  801674:	c1 f8 1f             	sar    $0x1f,%eax
  801677:	29 c2                	sub    %eax,%edx
  801679:	89 d0                	mov    %edx,%eax
  80167b:	c1 e0 02             	shl    $0x2,%eax
  80167e:	01 d0                	add    %edx,%eax
  801680:	01 c0                	add    %eax,%eax
  801682:	29 c1                	sub    %eax,%ecx
  801684:	89 ca                	mov    %ecx,%edx
  801686:	85 d2                	test   %edx,%edx
  801688:	75 9c                	jne    801626 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80168a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801691:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801694:	48                   	dec    %eax
  801695:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801698:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80169c:	74 3d                	je     8016db <ltostr+0xe2>
		start = 1 ;
  80169e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8016a5:	eb 34                	jmp    8016db <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8016a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ad:	01 d0                	add    %edx,%eax
  8016af:	8a 00                	mov    (%eax),%al
  8016b1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8016b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ba:	01 c2                	add    %eax,%edx
  8016bc:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8016bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c2:	01 c8                	add    %ecx,%eax
  8016c4:	8a 00                	mov    (%eax),%al
  8016c6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8016c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8016cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ce:	01 c2                	add    %eax,%edx
  8016d0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8016d3:	88 02                	mov    %al,(%edx)
		start++ ;
  8016d5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8016d8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8016db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016e1:	7c c4                	jl     8016a7 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8016e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8016e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e9:	01 d0                	add    %edx,%eax
  8016eb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8016ee:	90                   	nop
  8016ef:	c9                   	leave  
  8016f0:	c3                   	ret    

008016f1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8016f1:	55                   	push   %ebp
  8016f2:	89 e5                	mov    %esp,%ebp
  8016f4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8016f7:	ff 75 08             	pushl  0x8(%ebp)
  8016fa:	e8 54 fa ff ff       	call   801153 <strlen>
  8016ff:	83 c4 04             	add    $0x4,%esp
  801702:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801705:	ff 75 0c             	pushl  0xc(%ebp)
  801708:	e8 46 fa ff ff       	call   801153 <strlen>
  80170d:	83 c4 04             	add    $0x4,%esp
  801710:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801713:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80171a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801721:	eb 17                	jmp    80173a <strcconcat+0x49>
		final[s] = str1[s] ;
  801723:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801726:	8b 45 10             	mov    0x10(%ebp),%eax
  801729:	01 c2                	add    %eax,%edx
  80172b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80172e:	8b 45 08             	mov    0x8(%ebp),%eax
  801731:	01 c8                	add    %ecx,%eax
  801733:	8a 00                	mov    (%eax),%al
  801735:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801737:	ff 45 fc             	incl   -0x4(%ebp)
  80173a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80173d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801740:	7c e1                	jl     801723 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801742:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801749:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801750:	eb 1f                	jmp    801771 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801752:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801755:	8d 50 01             	lea    0x1(%eax),%edx
  801758:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80175b:	89 c2                	mov    %eax,%edx
  80175d:	8b 45 10             	mov    0x10(%ebp),%eax
  801760:	01 c2                	add    %eax,%edx
  801762:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801765:	8b 45 0c             	mov    0xc(%ebp),%eax
  801768:	01 c8                	add    %ecx,%eax
  80176a:	8a 00                	mov    (%eax),%al
  80176c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80176e:	ff 45 f8             	incl   -0x8(%ebp)
  801771:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801774:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801777:	7c d9                	jl     801752 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801779:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80177c:	8b 45 10             	mov    0x10(%ebp),%eax
  80177f:	01 d0                	add    %edx,%eax
  801781:	c6 00 00             	movb   $0x0,(%eax)
}
  801784:	90                   	nop
  801785:	c9                   	leave  
  801786:	c3                   	ret    

00801787 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801787:	55                   	push   %ebp
  801788:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80178a:	8b 45 14             	mov    0x14(%ebp),%eax
  80178d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801793:	8b 45 14             	mov    0x14(%ebp),%eax
  801796:	8b 00                	mov    (%eax),%eax
  801798:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80179f:	8b 45 10             	mov    0x10(%ebp),%eax
  8017a2:	01 d0                	add    %edx,%eax
  8017a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8017aa:	eb 0c                	jmp    8017b8 <strsplit+0x31>
			*string++ = 0;
  8017ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8017af:	8d 50 01             	lea    0x1(%eax),%edx
  8017b2:	89 55 08             	mov    %edx,0x8(%ebp)
  8017b5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8017b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bb:	8a 00                	mov    (%eax),%al
  8017bd:	84 c0                	test   %al,%al
  8017bf:	74 18                	je     8017d9 <strsplit+0x52>
  8017c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c4:	8a 00                	mov    (%eax),%al
  8017c6:	0f be c0             	movsbl %al,%eax
  8017c9:	50                   	push   %eax
  8017ca:	ff 75 0c             	pushl  0xc(%ebp)
  8017cd:	e8 13 fb ff ff       	call   8012e5 <strchr>
  8017d2:	83 c4 08             	add    $0x8,%esp
  8017d5:	85 c0                	test   %eax,%eax
  8017d7:	75 d3                	jne    8017ac <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8017d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017dc:	8a 00                	mov    (%eax),%al
  8017de:	84 c0                	test   %al,%al
  8017e0:	74 5a                	je     80183c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8017e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8017e5:	8b 00                	mov    (%eax),%eax
  8017e7:	83 f8 0f             	cmp    $0xf,%eax
  8017ea:	75 07                	jne    8017f3 <strsplit+0x6c>
		{
			return 0;
  8017ec:	b8 00 00 00 00       	mov    $0x0,%eax
  8017f1:	eb 66                	jmp    801859 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8017f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8017f6:	8b 00                	mov    (%eax),%eax
  8017f8:	8d 48 01             	lea    0x1(%eax),%ecx
  8017fb:	8b 55 14             	mov    0x14(%ebp),%edx
  8017fe:	89 0a                	mov    %ecx,(%edx)
  801800:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801807:	8b 45 10             	mov    0x10(%ebp),%eax
  80180a:	01 c2                	add    %eax,%edx
  80180c:	8b 45 08             	mov    0x8(%ebp),%eax
  80180f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801811:	eb 03                	jmp    801816 <strsplit+0x8f>
			string++;
  801813:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801816:	8b 45 08             	mov    0x8(%ebp),%eax
  801819:	8a 00                	mov    (%eax),%al
  80181b:	84 c0                	test   %al,%al
  80181d:	74 8b                	je     8017aa <strsplit+0x23>
  80181f:	8b 45 08             	mov    0x8(%ebp),%eax
  801822:	8a 00                	mov    (%eax),%al
  801824:	0f be c0             	movsbl %al,%eax
  801827:	50                   	push   %eax
  801828:	ff 75 0c             	pushl  0xc(%ebp)
  80182b:	e8 b5 fa ff ff       	call   8012e5 <strchr>
  801830:	83 c4 08             	add    $0x8,%esp
  801833:	85 c0                	test   %eax,%eax
  801835:	74 dc                	je     801813 <strsplit+0x8c>
			string++;
	}
  801837:	e9 6e ff ff ff       	jmp    8017aa <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80183c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80183d:	8b 45 14             	mov    0x14(%ebp),%eax
  801840:	8b 00                	mov    (%eax),%eax
  801842:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801849:	8b 45 10             	mov    0x10(%ebp),%eax
  80184c:	01 d0                	add    %edx,%eax
  80184e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801854:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801859:	c9                   	leave  
  80185a:	c3                   	ret    

0080185b <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  80185b:	55                   	push   %ebp
  80185c:	89 e5                	mov    %esp,%ebp
  80185e:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  801861:	e8 3b 09 00 00       	call   8021a1 <sys_isUHeapPlacementStrategyFIRSTFIT>
  801866:	85 c0                	test   %eax,%eax
  801868:	0f 84 3a 01 00 00    	je     8019a8 <malloc+0x14d>

		if(pl == 0){
  80186e:	a1 28 30 80 00       	mov    0x803028,%eax
  801873:	85 c0                	test   %eax,%eax
  801875:	75 24                	jne    80189b <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801877:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80187e:	eb 11                	jmp    801891 <malloc+0x36>
				arr[k] = -10000;
  801880:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801883:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  80188a:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  80188e:	ff 45 f4             	incl   -0xc(%ebp)
  801891:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801894:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801899:	76 e5                	jbe    801880 <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  80189b:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  8018a2:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  8018a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a8:	c1 e8 0c             	shr    $0xc,%eax
  8018ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  8018ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b1:	25 ff 0f 00 00       	and    $0xfff,%eax
  8018b6:	85 c0                	test   %eax,%eax
  8018b8:	74 03                	je     8018bd <malloc+0x62>
			x++;
  8018ba:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  8018bd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  8018c4:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  8018cb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8018d2:	eb 66                	jmp    80193a <malloc+0xdf>
			if( arr[k] == -10000){
  8018d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018d7:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8018de:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  8018e3:	75 52                	jne    801937 <malloc+0xdc>
				uint32 w = 0 ;
  8018e5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  8018ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  8018f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018f5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8018f8:	eb 09                	jmp    801903 <malloc+0xa8>
  8018fa:	ff 45 e0             	incl   -0x20(%ebp)
  8018fd:	ff 45 dc             	incl   -0x24(%ebp)
  801900:	ff 45 e4             	incl   -0x1c(%ebp)
  801903:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801906:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80190b:	77 19                	ja     801926 <malloc+0xcb>
  80190d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801910:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801917:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  80191c:	75 08                	jne    801926 <malloc+0xcb>
  80191e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801921:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801924:	72 d4                	jb     8018fa <malloc+0x9f>
				if(w >= x){
  801926:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801929:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80192c:	72 09                	jb     801937 <malloc+0xdc>
					p = 1 ;
  80192e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801935:	eb 0d                	jmp    801944 <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801937:	ff 45 e4             	incl   -0x1c(%ebp)
  80193a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80193d:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801942:	76 90                	jbe    8018d4 <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801944:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801948:	75 0a                	jne    801954 <malloc+0xf9>
  80194a:	b8 00 00 00 00       	mov    $0x0,%eax
  80194f:	e9 ca 01 00 00       	jmp    801b1e <malloc+0x2c3>
		int q = idx;
  801954:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801957:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  80195a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801961:	eb 16                	jmp    801979 <malloc+0x11e>
			arr[q++] = x;
  801963:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801966:	8d 50 01             	lea    0x1(%eax),%edx
  801969:	89 55 d8             	mov    %edx,-0x28(%ebp)
  80196c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80196f:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801976:	ff 45 d4             	incl   -0x2c(%ebp)
  801979:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80197c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80197f:	72 e2                	jb     801963 <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801981:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801984:	05 00 00 08 00       	add    $0x80000,%eax
  801989:	c1 e0 0c             	shl    $0xc,%eax
  80198c:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  80198f:	83 ec 08             	sub    $0x8,%esp
  801992:	ff 75 f0             	pushl  -0x10(%ebp)
  801995:	ff 75 ac             	pushl  -0x54(%ebp)
  801998:	e8 9b 04 00 00       	call   801e38 <sys_allocateMem>
  80199d:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  8019a0:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8019a3:	e9 76 01 00 00       	jmp    801b1e <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  8019a8:	e8 25 08 00 00       	call   8021d2 <sys_isUHeapPlacementStrategyBESTFIT>
  8019ad:	85 c0                	test   %eax,%eax
  8019af:	0f 84 64 01 00 00    	je     801b19 <malloc+0x2be>
		if(pl == 0){
  8019b5:	a1 28 30 80 00       	mov    0x803028,%eax
  8019ba:	85 c0                	test   %eax,%eax
  8019bc:	75 24                	jne    8019e2 <malloc+0x187>
			for(int k = 0; k < Size; k++){
  8019be:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  8019c5:	eb 11                	jmp    8019d8 <malloc+0x17d>
				arr[k] = -10000;
  8019c7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8019ca:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  8019d1:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  8019d5:	ff 45 d0             	incl   -0x30(%ebp)
  8019d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8019db:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8019e0:	76 e5                	jbe    8019c7 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  8019e2:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  8019e9:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  8019ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ef:	c1 e8 0c             	shr    $0xc,%eax
  8019f2:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  8019f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f8:	25 ff 0f 00 00       	and    $0xfff,%eax
  8019fd:	85 c0                	test   %eax,%eax
  8019ff:	74 03                	je     801a04 <malloc+0x1a9>
			x++;
  801a01:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801a04:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801a0b:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801a12:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801a19:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801a20:	e9 88 00 00 00       	jmp    801aad <malloc+0x252>
			if(arr[k] == -10000){
  801a25:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801a28:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801a2f:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801a34:	75 64                	jne    801a9a <malloc+0x23f>
				uint32 w = 0 , i;
  801a36:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801a3d:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801a40:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801a43:	eb 06                	jmp    801a4b <malloc+0x1f0>
  801a45:	ff 45 b8             	incl   -0x48(%ebp)
  801a48:	ff 45 b4             	incl   -0x4c(%ebp)
  801a4b:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801a52:	77 11                	ja     801a65 <malloc+0x20a>
  801a54:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801a57:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801a5e:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801a63:	74 e0                	je     801a45 <malloc+0x1ea>
				if(w <q && w >= x){
  801a65:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801a68:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801a6b:	73 24                	jae    801a91 <malloc+0x236>
  801a6d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801a70:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801a73:	72 1c                	jb     801a91 <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801a75:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801a78:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801a7b:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801a82:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801a85:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801a88:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801a8b:	48                   	dec    %eax
  801a8c:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801a8f:	eb 19                	jmp    801aaa <malloc+0x24f>
				}
				else {
					k = i - 1;
  801a91:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801a94:	48                   	dec    %eax
  801a95:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801a98:	eb 10                	jmp    801aaa <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801a9a:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801a9d:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801aa4:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801aa7:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801aaa:	ff 45 bc             	incl   -0x44(%ebp)
  801aad:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801ab0:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801ab5:	0f 86 6a ff ff ff    	jbe    801a25 <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801abb:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801abf:	75 07                	jne    801ac8 <malloc+0x26d>
  801ac1:	b8 00 00 00 00       	mov    $0x0,%eax
  801ac6:	eb 56                	jmp    801b1e <malloc+0x2c3>
	    q = idx;
  801ac8:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801acb:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801ace:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801ad5:	eb 16                	jmp    801aed <malloc+0x292>
			arr[q++] = x;
  801ad7:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801ada:	8d 50 01             	lea    0x1(%eax),%edx
  801add:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801ae0:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801ae3:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801aea:	ff 45 b0             	incl   -0x50(%ebp)
  801aed:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801af0:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801af3:	72 e2                	jb     801ad7 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801af5:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801af8:	05 00 00 08 00       	add    $0x80000,%eax
  801afd:	c1 e0 0c             	shl    $0xc,%eax
  801b00:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801b03:	83 ec 08             	sub    $0x8,%esp
  801b06:	ff 75 cc             	pushl  -0x34(%ebp)
  801b09:	ff 75 a8             	pushl  -0x58(%ebp)
  801b0c:	e8 27 03 00 00       	call   801e38 <sys_allocateMem>
  801b11:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801b14:	8b 45 a8             	mov    -0x58(%ebp),%eax
  801b17:	eb 05                	jmp    801b1e <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801b19:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b1e:	c9                   	leave  
  801b1f:	c3                   	ret    

00801b20 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801b20:	55                   	push   %ebp
  801b21:	89 e5                	mov    %esp,%ebp
  801b23:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801b26:	8b 45 08             	mov    0x8(%ebp),%eax
  801b29:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801b2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b2f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801b34:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801b37:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3a:	05 00 00 00 80       	add    $0x80000000,%eax
  801b3f:	c1 e8 0c             	shr    $0xc,%eax
  801b42:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801b49:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801b4c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b53:	8b 45 08             	mov    0x8(%ebp),%eax
  801b56:	05 00 00 00 80       	add    $0x80000000,%eax
  801b5b:	c1 e8 0c             	shr    $0xc,%eax
  801b5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b61:	eb 14                	jmp    801b77 <free+0x57>
		arr[j] = -10000;
  801b63:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b66:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801b6d:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801b71:	ff 45 f4             	incl   -0xc(%ebp)
  801b74:	ff 45 f0             	incl   -0x10(%ebp)
  801b77:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b7a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b7d:	72 e4                	jb     801b63 <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b82:	83 ec 08             	sub    $0x8,%esp
  801b85:	ff 75 e8             	pushl  -0x18(%ebp)
  801b88:	50                   	push   %eax
  801b89:	e8 8e 02 00 00       	call   801e1c <sys_freeMem>
  801b8e:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801b91:	90                   	nop
  801b92:	c9                   	leave  
  801b93:	c3                   	ret    

00801b94 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801b94:	55                   	push   %ebp
  801b95:	89 e5                	mov    %esp,%ebp
  801b97:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b9a:	83 ec 04             	sub    $0x4,%esp
  801b9d:	68 70 2c 80 00       	push   $0x802c70
  801ba2:	68 9e 00 00 00       	push   $0x9e
  801ba7:	68 93 2c 80 00       	push   $0x802c93
  801bac:	e8 69 ec ff ff       	call   80081a <_panic>

00801bb1 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801bb1:	55                   	push   %ebp
  801bb2:	89 e5                	mov    %esp,%ebp
  801bb4:	83 ec 18             	sub    $0x18,%esp
  801bb7:	8b 45 10             	mov    0x10(%ebp),%eax
  801bba:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801bbd:	83 ec 04             	sub    $0x4,%esp
  801bc0:	68 70 2c 80 00       	push   $0x802c70
  801bc5:	68 a9 00 00 00       	push   $0xa9
  801bca:	68 93 2c 80 00       	push   $0x802c93
  801bcf:	e8 46 ec ff ff       	call   80081a <_panic>

00801bd4 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
  801bd7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bda:	83 ec 04             	sub    $0x4,%esp
  801bdd:	68 70 2c 80 00       	push   $0x802c70
  801be2:	68 af 00 00 00       	push   $0xaf
  801be7:	68 93 2c 80 00       	push   $0x802c93
  801bec:	e8 29 ec ff ff       	call   80081a <_panic>

00801bf1 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801bf1:	55                   	push   %ebp
  801bf2:	89 e5                	mov    %esp,%ebp
  801bf4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bf7:	83 ec 04             	sub    $0x4,%esp
  801bfa:	68 70 2c 80 00       	push   $0x802c70
  801bff:	68 b5 00 00 00       	push   $0xb5
  801c04:	68 93 2c 80 00       	push   $0x802c93
  801c09:	e8 0c ec ff ff       	call   80081a <_panic>

00801c0e <expand>:
}

void expand(uint32 newSize)
{
  801c0e:	55                   	push   %ebp
  801c0f:	89 e5                	mov    %esp,%ebp
  801c11:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c14:	83 ec 04             	sub    $0x4,%esp
  801c17:	68 70 2c 80 00       	push   $0x802c70
  801c1c:	68 ba 00 00 00       	push   $0xba
  801c21:	68 93 2c 80 00       	push   $0x802c93
  801c26:	e8 ef eb ff ff       	call   80081a <_panic>

00801c2b <shrink>:
}
void shrink(uint32 newSize)
{
  801c2b:	55                   	push   %ebp
  801c2c:	89 e5                	mov    %esp,%ebp
  801c2e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c31:	83 ec 04             	sub    $0x4,%esp
  801c34:	68 70 2c 80 00       	push   $0x802c70
  801c39:	68 be 00 00 00       	push   $0xbe
  801c3e:	68 93 2c 80 00       	push   $0x802c93
  801c43:	e8 d2 eb ff ff       	call   80081a <_panic>

00801c48 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801c48:	55                   	push   %ebp
  801c49:	89 e5                	mov    %esp,%ebp
  801c4b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c4e:	83 ec 04             	sub    $0x4,%esp
  801c51:	68 70 2c 80 00       	push   $0x802c70
  801c56:	68 c3 00 00 00       	push   $0xc3
  801c5b:	68 93 2c 80 00       	push   $0x802c93
  801c60:	e8 b5 eb ff ff       	call   80081a <_panic>

00801c65 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c65:	55                   	push   %ebp
  801c66:	89 e5                	mov    %esp,%ebp
  801c68:	57                   	push   %edi
  801c69:	56                   	push   %esi
  801c6a:	53                   	push   %ebx
  801c6b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c71:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c74:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c77:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c7a:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c7d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c80:	cd 30                	int    $0x30
  801c82:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c85:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c88:	83 c4 10             	add    $0x10,%esp
  801c8b:	5b                   	pop    %ebx
  801c8c:	5e                   	pop    %esi
  801c8d:	5f                   	pop    %edi
  801c8e:	5d                   	pop    %ebp
  801c8f:	c3                   	ret    

00801c90 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c90:	55                   	push   %ebp
  801c91:	89 e5                	mov    %esp,%ebp
  801c93:	83 ec 04             	sub    $0x4,%esp
  801c96:	8b 45 10             	mov    0x10(%ebp),%eax
  801c99:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c9c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	52                   	push   %edx
  801ca8:	ff 75 0c             	pushl  0xc(%ebp)
  801cab:	50                   	push   %eax
  801cac:	6a 00                	push   $0x0
  801cae:	e8 b2 ff ff ff       	call   801c65 <syscall>
  801cb3:	83 c4 18             	add    $0x18,%esp
}
  801cb6:	90                   	nop
  801cb7:	c9                   	leave  
  801cb8:	c3                   	ret    

00801cb9 <sys_cgetc>:

int
sys_cgetc(void)
{
  801cb9:	55                   	push   %ebp
  801cba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 01                	push   $0x1
  801cc8:	e8 98 ff ff ff       	call   801c65 <syscall>
  801ccd:	83 c4 18             	add    $0x18,%esp
}
  801cd0:	c9                   	leave  
  801cd1:	c3                   	ret    

00801cd2 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 00                	push   $0x0
  801cde:	6a 00                	push   $0x0
  801ce0:	50                   	push   %eax
  801ce1:	6a 05                	push   $0x5
  801ce3:	e8 7d ff ff ff       	call   801c65 <syscall>
  801ce8:	83 c4 18             	add    $0x18,%esp
}
  801ceb:	c9                   	leave  
  801cec:	c3                   	ret    

00801ced <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ced:	55                   	push   %ebp
  801cee:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 02                	push   $0x2
  801cfc:	e8 64 ff ff ff       	call   801c65 <syscall>
  801d01:	83 c4 18             	add    $0x18,%esp
}
  801d04:	c9                   	leave  
  801d05:	c3                   	ret    

00801d06 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 03                	push   $0x3
  801d15:	e8 4b ff ff ff       	call   801c65 <syscall>
  801d1a:	83 c4 18             	add    $0x18,%esp
}
  801d1d:	c9                   	leave  
  801d1e:	c3                   	ret    

00801d1f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d1f:	55                   	push   %ebp
  801d20:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 04                	push   $0x4
  801d2e:	e8 32 ff ff ff       	call   801c65 <syscall>
  801d33:	83 c4 18             	add    $0x18,%esp
}
  801d36:	c9                   	leave  
  801d37:	c3                   	ret    

00801d38 <sys_env_exit>:


void sys_env_exit(void)
{
  801d38:	55                   	push   %ebp
  801d39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 06                	push   $0x6
  801d47:	e8 19 ff ff ff       	call   801c65 <syscall>
  801d4c:	83 c4 18             	add    $0x18,%esp
}
  801d4f:	90                   	nop
  801d50:	c9                   	leave  
  801d51:	c3                   	ret    

00801d52 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d52:	55                   	push   %ebp
  801d53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d55:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d58:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	52                   	push   %edx
  801d62:	50                   	push   %eax
  801d63:	6a 07                	push   $0x7
  801d65:	e8 fb fe ff ff       	call   801c65 <syscall>
  801d6a:	83 c4 18             	add    $0x18,%esp
}
  801d6d:	c9                   	leave  
  801d6e:	c3                   	ret    

00801d6f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d6f:	55                   	push   %ebp
  801d70:	89 e5                	mov    %esp,%ebp
  801d72:	56                   	push   %esi
  801d73:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d74:	8b 75 18             	mov    0x18(%ebp),%esi
  801d77:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d7a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d80:	8b 45 08             	mov    0x8(%ebp),%eax
  801d83:	56                   	push   %esi
  801d84:	53                   	push   %ebx
  801d85:	51                   	push   %ecx
  801d86:	52                   	push   %edx
  801d87:	50                   	push   %eax
  801d88:	6a 08                	push   $0x8
  801d8a:	e8 d6 fe ff ff       	call   801c65 <syscall>
  801d8f:	83 c4 18             	add    $0x18,%esp
}
  801d92:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d95:	5b                   	pop    %ebx
  801d96:	5e                   	pop    %esi
  801d97:	5d                   	pop    %ebp
  801d98:	c3                   	ret    

00801d99 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d99:	55                   	push   %ebp
  801d9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	52                   	push   %edx
  801da9:	50                   	push   %eax
  801daa:	6a 09                	push   $0x9
  801dac:	e8 b4 fe ff ff       	call   801c65 <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
}
  801db4:	c9                   	leave  
  801db5:	c3                   	ret    

00801db6 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801db6:	55                   	push   %ebp
  801db7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	ff 75 0c             	pushl  0xc(%ebp)
  801dc2:	ff 75 08             	pushl  0x8(%ebp)
  801dc5:	6a 0a                	push   $0xa
  801dc7:	e8 99 fe ff ff       	call   801c65 <syscall>
  801dcc:	83 c4 18             	add    $0x18,%esp
}
  801dcf:	c9                   	leave  
  801dd0:	c3                   	ret    

00801dd1 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 0b                	push   $0xb
  801de0:	e8 80 fe ff ff       	call   801c65 <syscall>
  801de5:	83 c4 18             	add    $0x18,%esp
}
  801de8:	c9                   	leave  
  801de9:	c3                   	ret    

00801dea <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801dea:	55                   	push   %ebp
  801deb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 0c                	push   $0xc
  801df9:	e8 67 fe ff ff       	call   801c65 <syscall>
  801dfe:	83 c4 18             	add    $0x18,%esp
}
  801e01:	c9                   	leave  
  801e02:	c3                   	ret    

00801e03 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e03:	55                   	push   %ebp
  801e04:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e06:	6a 00                	push   $0x0
  801e08:	6a 00                	push   $0x0
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 0d                	push   $0xd
  801e12:	e8 4e fe ff ff       	call   801c65 <syscall>
  801e17:	83 c4 18             	add    $0x18,%esp
}
  801e1a:	c9                   	leave  
  801e1b:	c3                   	ret    

00801e1c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e1c:	55                   	push   %ebp
  801e1d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	ff 75 0c             	pushl  0xc(%ebp)
  801e28:	ff 75 08             	pushl  0x8(%ebp)
  801e2b:	6a 11                	push   $0x11
  801e2d:	e8 33 fe ff ff       	call   801c65 <syscall>
  801e32:	83 c4 18             	add    $0x18,%esp
	return;
  801e35:	90                   	nop
}
  801e36:	c9                   	leave  
  801e37:	c3                   	ret    

00801e38 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e38:	55                   	push   %ebp
  801e39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	ff 75 0c             	pushl  0xc(%ebp)
  801e44:	ff 75 08             	pushl  0x8(%ebp)
  801e47:	6a 12                	push   $0x12
  801e49:	e8 17 fe ff ff       	call   801c65 <syscall>
  801e4e:	83 c4 18             	add    $0x18,%esp
	return ;
  801e51:	90                   	nop
}
  801e52:	c9                   	leave  
  801e53:	c3                   	ret    

00801e54 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e54:	55                   	push   %ebp
  801e55:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 0e                	push   $0xe
  801e63:	e8 fd fd ff ff       	call   801c65 <syscall>
  801e68:	83 c4 18             	add    $0x18,%esp
}
  801e6b:	c9                   	leave  
  801e6c:	c3                   	ret    

00801e6d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e6d:	55                   	push   %ebp
  801e6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	ff 75 08             	pushl  0x8(%ebp)
  801e7b:	6a 0f                	push   $0xf
  801e7d:	e8 e3 fd ff ff       	call   801c65 <syscall>
  801e82:	83 c4 18             	add    $0x18,%esp
}
  801e85:	c9                   	leave  
  801e86:	c3                   	ret    

00801e87 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e87:	55                   	push   %ebp
  801e88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 10                	push   $0x10
  801e96:	e8 ca fd ff ff       	call   801c65 <syscall>
  801e9b:	83 c4 18             	add    $0x18,%esp
}
  801e9e:	90                   	nop
  801e9f:	c9                   	leave  
  801ea0:	c3                   	ret    

00801ea1 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ea1:	55                   	push   %ebp
  801ea2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ea4:	6a 00                	push   $0x0
  801ea6:	6a 00                	push   $0x0
  801ea8:	6a 00                	push   $0x0
  801eaa:	6a 00                	push   $0x0
  801eac:	6a 00                	push   $0x0
  801eae:	6a 14                	push   $0x14
  801eb0:	e8 b0 fd ff ff       	call   801c65 <syscall>
  801eb5:	83 c4 18             	add    $0x18,%esp
}
  801eb8:	90                   	nop
  801eb9:	c9                   	leave  
  801eba:	c3                   	ret    

00801ebb <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ebb:	55                   	push   %ebp
  801ebc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 15                	push   $0x15
  801eca:	e8 96 fd ff ff       	call   801c65 <syscall>
  801ecf:	83 c4 18             	add    $0x18,%esp
}
  801ed2:	90                   	nop
  801ed3:	c9                   	leave  
  801ed4:	c3                   	ret    

00801ed5 <sys_cputc>:


void
sys_cputc(const char c)
{
  801ed5:	55                   	push   %ebp
  801ed6:	89 e5                	mov    %esp,%ebp
  801ed8:	83 ec 04             	sub    $0x4,%esp
  801edb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ede:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ee1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	50                   	push   %eax
  801eee:	6a 16                	push   $0x16
  801ef0:	e8 70 fd ff ff       	call   801c65 <syscall>
  801ef5:	83 c4 18             	add    $0x18,%esp
}
  801ef8:	90                   	nop
  801ef9:	c9                   	leave  
  801efa:	c3                   	ret    

00801efb <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801efb:	55                   	push   %ebp
  801efc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 17                	push   $0x17
  801f0a:	e8 56 fd ff ff       	call   801c65 <syscall>
  801f0f:	83 c4 18             	add    $0x18,%esp
}
  801f12:	90                   	nop
  801f13:	c9                   	leave  
  801f14:	c3                   	ret    

00801f15 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f15:	55                   	push   %ebp
  801f16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f18:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	ff 75 0c             	pushl  0xc(%ebp)
  801f24:	50                   	push   %eax
  801f25:	6a 18                	push   $0x18
  801f27:	e8 39 fd ff ff       	call   801c65 <syscall>
  801f2c:	83 c4 18             	add    $0x18,%esp
}
  801f2f:	c9                   	leave  
  801f30:	c3                   	ret    

00801f31 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f31:	55                   	push   %ebp
  801f32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f37:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 00                	push   $0x0
  801f40:	52                   	push   %edx
  801f41:	50                   	push   %eax
  801f42:	6a 1b                	push   $0x1b
  801f44:	e8 1c fd ff ff       	call   801c65 <syscall>
  801f49:	83 c4 18             	add    $0x18,%esp
}
  801f4c:	c9                   	leave  
  801f4d:	c3                   	ret    

00801f4e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f4e:	55                   	push   %ebp
  801f4f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f51:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f54:	8b 45 08             	mov    0x8(%ebp),%eax
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	52                   	push   %edx
  801f5e:	50                   	push   %eax
  801f5f:	6a 19                	push   $0x19
  801f61:	e8 ff fc ff ff       	call   801c65 <syscall>
  801f66:	83 c4 18             	add    $0x18,%esp
}
  801f69:	90                   	nop
  801f6a:	c9                   	leave  
  801f6b:	c3                   	ret    

00801f6c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f6c:	55                   	push   %ebp
  801f6d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f72:	8b 45 08             	mov    0x8(%ebp),%eax
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	52                   	push   %edx
  801f7c:	50                   	push   %eax
  801f7d:	6a 1a                	push   $0x1a
  801f7f:	e8 e1 fc ff ff       	call   801c65 <syscall>
  801f84:	83 c4 18             	add    $0x18,%esp
}
  801f87:	90                   	nop
  801f88:	c9                   	leave  
  801f89:	c3                   	ret    

00801f8a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f8a:	55                   	push   %ebp
  801f8b:	89 e5                	mov    %esp,%ebp
  801f8d:	83 ec 04             	sub    $0x4,%esp
  801f90:	8b 45 10             	mov    0x10(%ebp),%eax
  801f93:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f96:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f99:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa0:	6a 00                	push   $0x0
  801fa2:	51                   	push   %ecx
  801fa3:	52                   	push   %edx
  801fa4:	ff 75 0c             	pushl  0xc(%ebp)
  801fa7:	50                   	push   %eax
  801fa8:	6a 1c                	push   $0x1c
  801faa:	e8 b6 fc ff ff       	call   801c65 <syscall>
  801faf:	83 c4 18             	add    $0x18,%esp
}
  801fb2:	c9                   	leave  
  801fb3:	c3                   	ret    

00801fb4 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801fb4:	55                   	push   %ebp
  801fb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801fb7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fba:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	52                   	push   %edx
  801fc4:	50                   	push   %eax
  801fc5:	6a 1d                	push   $0x1d
  801fc7:	e8 99 fc ff ff       	call   801c65 <syscall>
  801fcc:	83 c4 18             	add    $0x18,%esp
}
  801fcf:	c9                   	leave  
  801fd0:	c3                   	ret    

00801fd1 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801fd1:	55                   	push   %ebp
  801fd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801fd4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fd7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fda:	8b 45 08             	mov    0x8(%ebp),%eax
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 00                	push   $0x0
  801fe1:	51                   	push   %ecx
  801fe2:	52                   	push   %edx
  801fe3:	50                   	push   %eax
  801fe4:	6a 1e                	push   $0x1e
  801fe6:	e8 7a fc ff ff       	call   801c65 <syscall>
  801feb:	83 c4 18             	add    $0x18,%esp
}
  801fee:	c9                   	leave  
  801fef:	c3                   	ret    

00801ff0 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ff0:	55                   	push   %ebp
  801ff1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ff3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ff6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	52                   	push   %edx
  802000:	50                   	push   %eax
  802001:	6a 1f                	push   $0x1f
  802003:	e8 5d fc ff ff       	call   801c65 <syscall>
  802008:	83 c4 18             	add    $0x18,%esp
}
  80200b:	c9                   	leave  
  80200c:	c3                   	ret    

0080200d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80200d:	55                   	push   %ebp
  80200e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	6a 20                	push   $0x20
  80201c:	e8 44 fc ff ff       	call   801c65 <syscall>
  802021:	83 c4 18             	add    $0x18,%esp
}
  802024:	c9                   	leave  
  802025:	c3                   	ret    

00802026 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802026:	55                   	push   %ebp
  802027:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802029:	8b 45 08             	mov    0x8(%ebp),%eax
  80202c:	6a 00                	push   $0x0
  80202e:	ff 75 14             	pushl  0x14(%ebp)
  802031:	ff 75 10             	pushl  0x10(%ebp)
  802034:	ff 75 0c             	pushl  0xc(%ebp)
  802037:	50                   	push   %eax
  802038:	6a 21                	push   $0x21
  80203a:	e8 26 fc ff ff       	call   801c65 <syscall>
  80203f:	83 c4 18             	add    $0x18,%esp
}
  802042:	c9                   	leave  
  802043:	c3                   	ret    

00802044 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802044:	55                   	push   %ebp
  802045:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802047:	8b 45 08             	mov    0x8(%ebp),%eax
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	6a 00                	push   $0x0
  802050:	6a 00                	push   $0x0
  802052:	50                   	push   %eax
  802053:	6a 22                	push   $0x22
  802055:	e8 0b fc ff ff       	call   801c65 <syscall>
  80205a:	83 c4 18             	add    $0x18,%esp
}
  80205d:	90                   	nop
  80205e:	c9                   	leave  
  80205f:	c3                   	ret    

00802060 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802060:	55                   	push   %ebp
  802061:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802063:	8b 45 08             	mov    0x8(%ebp),%eax
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	6a 00                	push   $0x0
  80206c:	6a 00                	push   $0x0
  80206e:	50                   	push   %eax
  80206f:	6a 23                	push   $0x23
  802071:	e8 ef fb ff ff       	call   801c65 <syscall>
  802076:	83 c4 18             	add    $0x18,%esp
}
  802079:	90                   	nop
  80207a:	c9                   	leave  
  80207b:	c3                   	ret    

0080207c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80207c:	55                   	push   %ebp
  80207d:	89 e5                	mov    %esp,%ebp
  80207f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802082:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802085:	8d 50 04             	lea    0x4(%eax),%edx
  802088:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80208b:	6a 00                	push   $0x0
  80208d:	6a 00                	push   $0x0
  80208f:	6a 00                	push   $0x0
  802091:	52                   	push   %edx
  802092:	50                   	push   %eax
  802093:	6a 24                	push   $0x24
  802095:	e8 cb fb ff ff       	call   801c65 <syscall>
  80209a:	83 c4 18             	add    $0x18,%esp
	return result;
  80209d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020a6:	89 01                	mov    %eax,(%ecx)
  8020a8:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8020ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ae:	c9                   	leave  
  8020af:	c2 04 00             	ret    $0x4

008020b2 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8020b2:	55                   	push   %ebp
  8020b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 00                	push   $0x0
  8020b9:	ff 75 10             	pushl  0x10(%ebp)
  8020bc:	ff 75 0c             	pushl  0xc(%ebp)
  8020bf:	ff 75 08             	pushl  0x8(%ebp)
  8020c2:	6a 13                	push   $0x13
  8020c4:	e8 9c fb ff ff       	call   801c65 <syscall>
  8020c9:	83 c4 18             	add    $0x18,%esp
	return ;
  8020cc:	90                   	nop
}
  8020cd:	c9                   	leave  
  8020ce:	c3                   	ret    

008020cf <sys_rcr2>:
uint32 sys_rcr2()
{
  8020cf:	55                   	push   %ebp
  8020d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	6a 00                	push   $0x0
  8020d8:	6a 00                	push   $0x0
  8020da:	6a 00                	push   $0x0
  8020dc:	6a 25                	push   $0x25
  8020de:	e8 82 fb ff ff       	call   801c65 <syscall>
  8020e3:	83 c4 18             	add    $0x18,%esp
}
  8020e6:	c9                   	leave  
  8020e7:	c3                   	ret    

008020e8 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8020e8:	55                   	push   %ebp
  8020e9:	89 e5                	mov    %esp,%ebp
  8020eb:	83 ec 04             	sub    $0x4,%esp
  8020ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020f4:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020f8:	6a 00                	push   $0x0
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	6a 00                	push   $0x0
  802100:	50                   	push   %eax
  802101:	6a 26                	push   $0x26
  802103:	e8 5d fb ff ff       	call   801c65 <syscall>
  802108:	83 c4 18             	add    $0x18,%esp
	return ;
  80210b:	90                   	nop
}
  80210c:	c9                   	leave  
  80210d:	c3                   	ret    

0080210e <rsttst>:
void rsttst()
{
  80210e:	55                   	push   %ebp
  80210f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	6a 00                	push   $0x0
  80211b:	6a 28                	push   $0x28
  80211d:	e8 43 fb ff ff       	call   801c65 <syscall>
  802122:	83 c4 18             	add    $0x18,%esp
	return ;
  802125:	90                   	nop
}
  802126:	c9                   	leave  
  802127:	c3                   	ret    

00802128 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802128:	55                   	push   %ebp
  802129:	89 e5                	mov    %esp,%ebp
  80212b:	83 ec 04             	sub    $0x4,%esp
  80212e:	8b 45 14             	mov    0x14(%ebp),%eax
  802131:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802134:	8b 55 18             	mov    0x18(%ebp),%edx
  802137:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80213b:	52                   	push   %edx
  80213c:	50                   	push   %eax
  80213d:	ff 75 10             	pushl  0x10(%ebp)
  802140:	ff 75 0c             	pushl  0xc(%ebp)
  802143:	ff 75 08             	pushl  0x8(%ebp)
  802146:	6a 27                	push   $0x27
  802148:	e8 18 fb ff ff       	call   801c65 <syscall>
  80214d:	83 c4 18             	add    $0x18,%esp
	return ;
  802150:	90                   	nop
}
  802151:	c9                   	leave  
  802152:	c3                   	ret    

00802153 <chktst>:
void chktst(uint32 n)
{
  802153:	55                   	push   %ebp
  802154:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802156:	6a 00                	push   $0x0
  802158:	6a 00                	push   $0x0
  80215a:	6a 00                	push   $0x0
  80215c:	6a 00                	push   $0x0
  80215e:	ff 75 08             	pushl  0x8(%ebp)
  802161:	6a 29                	push   $0x29
  802163:	e8 fd fa ff ff       	call   801c65 <syscall>
  802168:	83 c4 18             	add    $0x18,%esp
	return ;
  80216b:	90                   	nop
}
  80216c:	c9                   	leave  
  80216d:	c3                   	ret    

0080216e <inctst>:

void inctst()
{
  80216e:	55                   	push   %ebp
  80216f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802171:	6a 00                	push   $0x0
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	6a 00                	push   $0x0
  802179:	6a 00                	push   $0x0
  80217b:	6a 2a                	push   $0x2a
  80217d:	e8 e3 fa ff ff       	call   801c65 <syscall>
  802182:	83 c4 18             	add    $0x18,%esp
	return ;
  802185:	90                   	nop
}
  802186:	c9                   	leave  
  802187:	c3                   	ret    

00802188 <gettst>:
uint32 gettst()
{
  802188:	55                   	push   %ebp
  802189:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 00                	push   $0x0
  802193:	6a 00                	push   $0x0
  802195:	6a 2b                	push   $0x2b
  802197:	e8 c9 fa ff ff       	call   801c65 <syscall>
  80219c:	83 c4 18             	add    $0x18,%esp
}
  80219f:	c9                   	leave  
  8021a0:	c3                   	ret    

008021a1 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8021a1:	55                   	push   %ebp
  8021a2:	89 e5                	mov    %esp,%ebp
  8021a4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 00                	push   $0x0
  8021b1:	6a 2c                	push   $0x2c
  8021b3:	e8 ad fa ff ff       	call   801c65 <syscall>
  8021b8:	83 c4 18             	add    $0x18,%esp
  8021bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8021be:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8021c2:	75 07                	jne    8021cb <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8021c4:	b8 01 00 00 00       	mov    $0x1,%eax
  8021c9:	eb 05                	jmp    8021d0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8021cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021d0:	c9                   	leave  
  8021d1:	c3                   	ret    

008021d2 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8021d2:	55                   	push   %ebp
  8021d3:	89 e5                	mov    %esp,%ebp
  8021d5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021d8:	6a 00                	push   $0x0
  8021da:	6a 00                	push   $0x0
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 00                	push   $0x0
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 2c                	push   $0x2c
  8021e4:	e8 7c fa ff ff       	call   801c65 <syscall>
  8021e9:	83 c4 18             	add    $0x18,%esp
  8021ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8021ef:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8021f3:	75 07                	jne    8021fc <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8021f5:	b8 01 00 00 00       	mov    $0x1,%eax
  8021fa:	eb 05                	jmp    802201 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8021fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802201:	c9                   	leave  
  802202:	c3                   	ret    

00802203 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802203:	55                   	push   %ebp
  802204:	89 e5                	mov    %esp,%ebp
  802206:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802209:	6a 00                	push   $0x0
  80220b:	6a 00                	push   $0x0
  80220d:	6a 00                	push   $0x0
  80220f:	6a 00                	push   $0x0
  802211:	6a 00                	push   $0x0
  802213:	6a 2c                	push   $0x2c
  802215:	e8 4b fa ff ff       	call   801c65 <syscall>
  80221a:	83 c4 18             	add    $0x18,%esp
  80221d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802220:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802224:	75 07                	jne    80222d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802226:	b8 01 00 00 00       	mov    $0x1,%eax
  80222b:	eb 05                	jmp    802232 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80222d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802232:	c9                   	leave  
  802233:	c3                   	ret    

00802234 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802234:	55                   	push   %ebp
  802235:	89 e5                	mov    %esp,%ebp
  802237:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80223a:	6a 00                	push   $0x0
  80223c:	6a 00                	push   $0x0
  80223e:	6a 00                	push   $0x0
  802240:	6a 00                	push   $0x0
  802242:	6a 00                	push   $0x0
  802244:	6a 2c                	push   $0x2c
  802246:	e8 1a fa ff ff       	call   801c65 <syscall>
  80224b:	83 c4 18             	add    $0x18,%esp
  80224e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802251:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802255:	75 07                	jne    80225e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802257:	b8 01 00 00 00       	mov    $0x1,%eax
  80225c:	eb 05                	jmp    802263 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80225e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802263:	c9                   	leave  
  802264:	c3                   	ret    

00802265 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802265:	55                   	push   %ebp
  802266:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802268:	6a 00                	push   $0x0
  80226a:	6a 00                	push   $0x0
  80226c:	6a 00                	push   $0x0
  80226e:	6a 00                	push   $0x0
  802270:	ff 75 08             	pushl  0x8(%ebp)
  802273:	6a 2d                	push   $0x2d
  802275:	e8 eb f9 ff ff       	call   801c65 <syscall>
  80227a:	83 c4 18             	add    $0x18,%esp
	return ;
  80227d:	90                   	nop
}
  80227e:	c9                   	leave  
  80227f:	c3                   	ret    

00802280 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802280:	55                   	push   %ebp
  802281:	89 e5                	mov    %esp,%ebp
  802283:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802284:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802287:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80228a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80228d:	8b 45 08             	mov    0x8(%ebp),%eax
  802290:	6a 00                	push   $0x0
  802292:	53                   	push   %ebx
  802293:	51                   	push   %ecx
  802294:	52                   	push   %edx
  802295:	50                   	push   %eax
  802296:	6a 2e                	push   $0x2e
  802298:	e8 c8 f9 ff ff       	call   801c65 <syscall>
  80229d:	83 c4 18             	add    $0x18,%esp
}
  8022a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8022a3:	c9                   	leave  
  8022a4:	c3                   	ret    

008022a5 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8022a5:	55                   	push   %ebp
  8022a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8022a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ae:	6a 00                	push   $0x0
  8022b0:	6a 00                	push   $0x0
  8022b2:	6a 00                	push   $0x0
  8022b4:	52                   	push   %edx
  8022b5:	50                   	push   %eax
  8022b6:	6a 2f                	push   $0x2f
  8022b8:	e8 a8 f9 ff ff       	call   801c65 <syscall>
  8022bd:	83 c4 18             	add    $0x18,%esp
}
  8022c0:	c9                   	leave  
  8022c1:	c3                   	ret    

008022c2 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8022c2:	55                   	push   %ebp
  8022c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8022c5:	6a 00                	push   $0x0
  8022c7:	6a 00                	push   $0x0
  8022c9:	6a 00                	push   $0x0
  8022cb:	ff 75 0c             	pushl  0xc(%ebp)
  8022ce:	ff 75 08             	pushl  0x8(%ebp)
  8022d1:	6a 30                	push   $0x30
  8022d3:	e8 8d f9 ff ff       	call   801c65 <syscall>
  8022d8:	83 c4 18             	add    $0x18,%esp
	return ;
  8022db:	90                   	nop
}
  8022dc:	c9                   	leave  
  8022dd:	c3                   	ret    
  8022de:	66 90                	xchg   %ax,%ax

008022e0 <__udivdi3>:
  8022e0:	55                   	push   %ebp
  8022e1:	57                   	push   %edi
  8022e2:	56                   	push   %esi
  8022e3:	53                   	push   %ebx
  8022e4:	83 ec 1c             	sub    $0x1c,%esp
  8022e7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022eb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022ef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022f3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022f7:	89 ca                	mov    %ecx,%edx
  8022f9:	89 f8                	mov    %edi,%eax
  8022fb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022ff:	85 f6                	test   %esi,%esi
  802301:	75 2d                	jne    802330 <__udivdi3+0x50>
  802303:	39 cf                	cmp    %ecx,%edi
  802305:	77 65                	ja     80236c <__udivdi3+0x8c>
  802307:	89 fd                	mov    %edi,%ebp
  802309:	85 ff                	test   %edi,%edi
  80230b:	75 0b                	jne    802318 <__udivdi3+0x38>
  80230d:	b8 01 00 00 00       	mov    $0x1,%eax
  802312:	31 d2                	xor    %edx,%edx
  802314:	f7 f7                	div    %edi
  802316:	89 c5                	mov    %eax,%ebp
  802318:	31 d2                	xor    %edx,%edx
  80231a:	89 c8                	mov    %ecx,%eax
  80231c:	f7 f5                	div    %ebp
  80231e:	89 c1                	mov    %eax,%ecx
  802320:	89 d8                	mov    %ebx,%eax
  802322:	f7 f5                	div    %ebp
  802324:	89 cf                	mov    %ecx,%edi
  802326:	89 fa                	mov    %edi,%edx
  802328:	83 c4 1c             	add    $0x1c,%esp
  80232b:	5b                   	pop    %ebx
  80232c:	5e                   	pop    %esi
  80232d:	5f                   	pop    %edi
  80232e:	5d                   	pop    %ebp
  80232f:	c3                   	ret    
  802330:	39 ce                	cmp    %ecx,%esi
  802332:	77 28                	ja     80235c <__udivdi3+0x7c>
  802334:	0f bd fe             	bsr    %esi,%edi
  802337:	83 f7 1f             	xor    $0x1f,%edi
  80233a:	75 40                	jne    80237c <__udivdi3+0x9c>
  80233c:	39 ce                	cmp    %ecx,%esi
  80233e:	72 0a                	jb     80234a <__udivdi3+0x6a>
  802340:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802344:	0f 87 9e 00 00 00    	ja     8023e8 <__udivdi3+0x108>
  80234a:	b8 01 00 00 00       	mov    $0x1,%eax
  80234f:	89 fa                	mov    %edi,%edx
  802351:	83 c4 1c             	add    $0x1c,%esp
  802354:	5b                   	pop    %ebx
  802355:	5e                   	pop    %esi
  802356:	5f                   	pop    %edi
  802357:	5d                   	pop    %ebp
  802358:	c3                   	ret    
  802359:	8d 76 00             	lea    0x0(%esi),%esi
  80235c:	31 ff                	xor    %edi,%edi
  80235e:	31 c0                	xor    %eax,%eax
  802360:	89 fa                	mov    %edi,%edx
  802362:	83 c4 1c             	add    $0x1c,%esp
  802365:	5b                   	pop    %ebx
  802366:	5e                   	pop    %esi
  802367:	5f                   	pop    %edi
  802368:	5d                   	pop    %ebp
  802369:	c3                   	ret    
  80236a:	66 90                	xchg   %ax,%ax
  80236c:	89 d8                	mov    %ebx,%eax
  80236e:	f7 f7                	div    %edi
  802370:	31 ff                	xor    %edi,%edi
  802372:	89 fa                	mov    %edi,%edx
  802374:	83 c4 1c             	add    $0x1c,%esp
  802377:	5b                   	pop    %ebx
  802378:	5e                   	pop    %esi
  802379:	5f                   	pop    %edi
  80237a:	5d                   	pop    %ebp
  80237b:	c3                   	ret    
  80237c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802381:	89 eb                	mov    %ebp,%ebx
  802383:	29 fb                	sub    %edi,%ebx
  802385:	89 f9                	mov    %edi,%ecx
  802387:	d3 e6                	shl    %cl,%esi
  802389:	89 c5                	mov    %eax,%ebp
  80238b:	88 d9                	mov    %bl,%cl
  80238d:	d3 ed                	shr    %cl,%ebp
  80238f:	89 e9                	mov    %ebp,%ecx
  802391:	09 f1                	or     %esi,%ecx
  802393:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802397:	89 f9                	mov    %edi,%ecx
  802399:	d3 e0                	shl    %cl,%eax
  80239b:	89 c5                	mov    %eax,%ebp
  80239d:	89 d6                	mov    %edx,%esi
  80239f:	88 d9                	mov    %bl,%cl
  8023a1:	d3 ee                	shr    %cl,%esi
  8023a3:	89 f9                	mov    %edi,%ecx
  8023a5:	d3 e2                	shl    %cl,%edx
  8023a7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023ab:	88 d9                	mov    %bl,%cl
  8023ad:	d3 e8                	shr    %cl,%eax
  8023af:	09 c2                	or     %eax,%edx
  8023b1:	89 d0                	mov    %edx,%eax
  8023b3:	89 f2                	mov    %esi,%edx
  8023b5:	f7 74 24 0c          	divl   0xc(%esp)
  8023b9:	89 d6                	mov    %edx,%esi
  8023bb:	89 c3                	mov    %eax,%ebx
  8023bd:	f7 e5                	mul    %ebp
  8023bf:	39 d6                	cmp    %edx,%esi
  8023c1:	72 19                	jb     8023dc <__udivdi3+0xfc>
  8023c3:	74 0b                	je     8023d0 <__udivdi3+0xf0>
  8023c5:	89 d8                	mov    %ebx,%eax
  8023c7:	31 ff                	xor    %edi,%edi
  8023c9:	e9 58 ff ff ff       	jmp    802326 <__udivdi3+0x46>
  8023ce:	66 90                	xchg   %ax,%ax
  8023d0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8023d4:	89 f9                	mov    %edi,%ecx
  8023d6:	d3 e2                	shl    %cl,%edx
  8023d8:	39 c2                	cmp    %eax,%edx
  8023da:	73 e9                	jae    8023c5 <__udivdi3+0xe5>
  8023dc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8023df:	31 ff                	xor    %edi,%edi
  8023e1:	e9 40 ff ff ff       	jmp    802326 <__udivdi3+0x46>
  8023e6:	66 90                	xchg   %ax,%ax
  8023e8:	31 c0                	xor    %eax,%eax
  8023ea:	e9 37 ff ff ff       	jmp    802326 <__udivdi3+0x46>
  8023ef:	90                   	nop

008023f0 <__umoddi3>:
  8023f0:	55                   	push   %ebp
  8023f1:	57                   	push   %edi
  8023f2:	56                   	push   %esi
  8023f3:	53                   	push   %ebx
  8023f4:	83 ec 1c             	sub    $0x1c,%esp
  8023f7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023fb:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023ff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802403:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802407:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80240b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80240f:	89 f3                	mov    %esi,%ebx
  802411:	89 fa                	mov    %edi,%edx
  802413:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802417:	89 34 24             	mov    %esi,(%esp)
  80241a:	85 c0                	test   %eax,%eax
  80241c:	75 1a                	jne    802438 <__umoddi3+0x48>
  80241e:	39 f7                	cmp    %esi,%edi
  802420:	0f 86 a2 00 00 00    	jbe    8024c8 <__umoddi3+0xd8>
  802426:	89 c8                	mov    %ecx,%eax
  802428:	89 f2                	mov    %esi,%edx
  80242a:	f7 f7                	div    %edi
  80242c:	89 d0                	mov    %edx,%eax
  80242e:	31 d2                	xor    %edx,%edx
  802430:	83 c4 1c             	add    $0x1c,%esp
  802433:	5b                   	pop    %ebx
  802434:	5e                   	pop    %esi
  802435:	5f                   	pop    %edi
  802436:	5d                   	pop    %ebp
  802437:	c3                   	ret    
  802438:	39 f0                	cmp    %esi,%eax
  80243a:	0f 87 ac 00 00 00    	ja     8024ec <__umoddi3+0xfc>
  802440:	0f bd e8             	bsr    %eax,%ebp
  802443:	83 f5 1f             	xor    $0x1f,%ebp
  802446:	0f 84 ac 00 00 00    	je     8024f8 <__umoddi3+0x108>
  80244c:	bf 20 00 00 00       	mov    $0x20,%edi
  802451:	29 ef                	sub    %ebp,%edi
  802453:	89 fe                	mov    %edi,%esi
  802455:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802459:	89 e9                	mov    %ebp,%ecx
  80245b:	d3 e0                	shl    %cl,%eax
  80245d:	89 d7                	mov    %edx,%edi
  80245f:	89 f1                	mov    %esi,%ecx
  802461:	d3 ef                	shr    %cl,%edi
  802463:	09 c7                	or     %eax,%edi
  802465:	89 e9                	mov    %ebp,%ecx
  802467:	d3 e2                	shl    %cl,%edx
  802469:	89 14 24             	mov    %edx,(%esp)
  80246c:	89 d8                	mov    %ebx,%eax
  80246e:	d3 e0                	shl    %cl,%eax
  802470:	89 c2                	mov    %eax,%edx
  802472:	8b 44 24 08          	mov    0x8(%esp),%eax
  802476:	d3 e0                	shl    %cl,%eax
  802478:	89 44 24 04          	mov    %eax,0x4(%esp)
  80247c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802480:	89 f1                	mov    %esi,%ecx
  802482:	d3 e8                	shr    %cl,%eax
  802484:	09 d0                	or     %edx,%eax
  802486:	d3 eb                	shr    %cl,%ebx
  802488:	89 da                	mov    %ebx,%edx
  80248a:	f7 f7                	div    %edi
  80248c:	89 d3                	mov    %edx,%ebx
  80248e:	f7 24 24             	mull   (%esp)
  802491:	89 c6                	mov    %eax,%esi
  802493:	89 d1                	mov    %edx,%ecx
  802495:	39 d3                	cmp    %edx,%ebx
  802497:	0f 82 87 00 00 00    	jb     802524 <__umoddi3+0x134>
  80249d:	0f 84 91 00 00 00    	je     802534 <__umoddi3+0x144>
  8024a3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024a7:	29 f2                	sub    %esi,%edx
  8024a9:	19 cb                	sbb    %ecx,%ebx
  8024ab:	89 d8                	mov    %ebx,%eax
  8024ad:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024b1:	d3 e0                	shl    %cl,%eax
  8024b3:	89 e9                	mov    %ebp,%ecx
  8024b5:	d3 ea                	shr    %cl,%edx
  8024b7:	09 d0                	or     %edx,%eax
  8024b9:	89 e9                	mov    %ebp,%ecx
  8024bb:	d3 eb                	shr    %cl,%ebx
  8024bd:	89 da                	mov    %ebx,%edx
  8024bf:	83 c4 1c             	add    $0x1c,%esp
  8024c2:	5b                   	pop    %ebx
  8024c3:	5e                   	pop    %esi
  8024c4:	5f                   	pop    %edi
  8024c5:	5d                   	pop    %ebp
  8024c6:	c3                   	ret    
  8024c7:	90                   	nop
  8024c8:	89 fd                	mov    %edi,%ebp
  8024ca:	85 ff                	test   %edi,%edi
  8024cc:	75 0b                	jne    8024d9 <__umoddi3+0xe9>
  8024ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8024d3:	31 d2                	xor    %edx,%edx
  8024d5:	f7 f7                	div    %edi
  8024d7:	89 c5                	mov    %eax,%ebp
  8024d9:	89 f0                	mov    %esi,%eax
  8024db:	31 d2                	xor    %edx,%edx
  8024dd:	f7 f5                	div    %ebp
  8024df:	89 c8                	mov    %ecx,%eax
  8024e1:	f7 f5                	div    %ebp
  8024e3:	89 d0                	mov    %edx,%eax
  8024e5:	e9 44 ff ff ff       	jmp    80242e <__umoddi3+0x3e>
  8024ea:	66 90                	xchg   %ax,%ax
  8024ec:	89 c8                	mov    %ecx,%eax
  8024ee:	89 f2                	mov    %esi,%edx
  8024f0:	83 c4 1c             	add    $0x1c,%esp
  8024f3:	5b                   	pop    %ebx
  8024f4:	5e                   	pop    %esi
  8024f5:	5f                   	pop    %edi
  8024f6:	5d                   	pop    %ebp
  8024f7:	c3                   	ret    
  8024f8:	3b 04 24             	cmp    (%esp),%eax
  8024fb:	72 06                	jb     802503 <__umoddi3+0x113>
  8024fd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802501:	77 0f                	ja     802512 <__umoddi3+0x122>
  802503:	89 f2                	mov    %esi,%edx
  802505:	29 f9                	sub    %edi,%ecx
  802507:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80250b:	89 14 24             	mov    %edx,(%esp)
  80250e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802512:	8b 44 24 04          	mov    0x4(%esp),%eax
  802516:	8b 14 24             	mov    (%esp),%edx
  802519:	83 c4 1c             	add    $0x1c,%esp
  80251c:	5b                   	pop    %ebx
  80251d:	5e                   	pop    %esi
  80251e:	5f                   	pop    %edi
  80251f:	5d                   	pop    %ebp
  802520:	c3                   	ret    
  802521:	8d 76 00             	lea    0x0(%esi),%esi
  802524:	2b 04 24             	sub    (%esp),%eax
  802527:	19 fa                	sbb    %edi,%edx
  802529:	89 d1                	mov    %edx,%ecx
  80252b:	89 c6                	mov    %eax,%esi
  80252d:	e9 71 ff ff ff       	jmp    8024a3 <__umoddi3+0xb3>
  802532:	66 90                	xchg   %ax,%ax
  802534:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802538:	72 ea                	jb     802524 <__umoddi3+0x134>
  80253a:	89 d9                	mov    %ebx,%ecx
  80253c:	e9 62 ff ff ff       	jmp    8024a3 <__umoddi3+0xb3>
