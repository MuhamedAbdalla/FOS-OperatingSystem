
obj/user/tst_free_1:     file format elf32-i386


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
  800031:	e8 91 15 00 00       	call   8015c7 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	short b;
	int c;
};

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	81 ec 30 01 00 00    	sub    $0x130,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800043:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
//				fullWS = 0;
//				break;
//			}
//		}

		if (LIST_SIZE(&(myEnv->PageWorkingSetList)) > 0)
  800047:	a1 20 40 80 00       	mov    0x804020,%eax
  80004c:	8b 80 9c 3c 01 00    	mov    0x13c9c(%eax),%eax
  800052:	85 c0                	test   %eax,%eax
  800054:	74 04                	je     80005a <_main+0x22>
		{
			fullWS = 0;
  800056:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		}
		if (fullWS) panic("Please increase the WS size");
  80005a:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80005e:	74 14                	je     800074 <_main+0x3c>
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	68 e0 33 80 00       	push   $0x8033e0
  800068:	6a 1f                	push   $0x1f
  80006a:	68 fc 33 80 00       	push   $0x8033fc
  80006f:	e8 98 16 00 00       	call   80170c <_panic>





	int Mega = 1024*1024;
  800074:	c7 45 e8 00 00 10 00 	movl   $0x100000,-0x18(%ebp)
	int kilo = 1024;
  80007b:	c7 45 e4 00 04 00 00 	movl   $0x400,-0x1c(%ebp)
	char minByte = 1<<7;
  800082:	c6 45 e3 80          	movb   $0x80,-0x1d(%ebp)
	char maxByte = 0x7F;
  800086:	c6 45 e2 7f          	movb   $0x7f,-0x1e(%ebp)
	short minShort = 1<<15 ;
  80008a:	66 c7 45 e0 00 80    	movw   $0x8000,-0x20(%ebp)
	short maxShort = 0x7FFF;
  800090:	66 c7 45 de ff 7f    	movw   $0x7fff,-0x22(%ebp)
	int minInt = 1<<31 ;
  800096:	c7 45 d8 00 00 00 80 	movl   $0x80000000,-0x28(%ebp)
	int maxInt = 0x7FFFFFFF;
  80009d:	c7 45 d4 ff ff ff 7f 	movl   $0x7fffffff,-0x2c(%ebp)
	char *byteArr, *byteArr2 ;
	short *shortArr, *shortArr2 ;
	int *intArr;
	struct MyStruct *structArr ;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;
	int start_freeFrames = sys_calculate_free_frames() ;
  8000a4:	e8 da 2b 00 00       	call   802c83 <sys_calculate_free_frames>
  8000a9:	89 45 d0             	mov    %eax,-0x30(%ebp)

	void* ptr_allocations[20] = {0};
  8000ac:	8d 95 d4 fe ff ff    	lea    -0x12c(%ebp),%edx
  8000b2:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000b7:	b8 00 00 00 00       	mov    $0x0,%eax
  8000bc:	89 d7                	mov    %edx,%edi
  8000be:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 MB
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000c0:	e8 41 2c 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  8000c5:	89 45 cc             	mov    %eax,-0x34(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000cb:	01 c0                	add    %eax,%eax
  8000cd:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	50                   	push   %eax
  8000d4:	e8 5f 26 00 00       	call   802738 <malloc>
  8000d9:	83 c4 10             	add    $0x10,%esp
  8000dc:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8000e2:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8000e8:	85 c0                	test   %eax,%eax
  8000ea:	79 0d                	jns    8000f9 <_main+0xc1>
  8000ec:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8000f2:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  8000f7:	76 14                	jbe    80010d <_main+0xd5>
  8000f9:	83 ec 04             	sub    $0x4,%esp
  8000fc:	68 10 34 80 00       	push   $0x803410
  800101:	6a 3b                	push   $0x3b
  800103:	68 fc 33 80 00       	push   $0x8033fc
  800108:	e8 ff 15 00 00       	call   80170c <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80010d:	e8 f4 2b 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  800112:	2b 45 cc             	sub    -0x34(%ebp),%eax
  800115:	3d 00 02 00 00       	cmp    $0x200,%eax
  80011a:	74 14                	je     800130 <_main+0xf8>
  80011c:	83 ec 04             	sub    $0x4,%esp
  80011f:	68 78 34 80 00       	push   $0x803478
  800124:	6a 3c                	push   $0x3c
  800126:	68 fc 33 80 00       	push   $0x8033fc
  80012b:	e8 dc 15 00 00       	call   80170c <_panic>
		int freeFrames = sys_calculate_free_frames() ;
  800130:	e8 4e 2b 00 00       	call   802c83 <sys_calculate_free_frames>
  800135:	89 45 c8             	mov    %eax,-0x38(%ebp)
		lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  800138:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80013b:	01 c0                	add    %eax,%eax
  80013d:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800140:	48                   	dec    %eax
  800141:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		byteArr = (char *) ptr_allocations[0];
  800144:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  80014a:	89 45 c0             	mov    %eax,-0x40(%ebp)
		byteArr[0] = minByte ;
  80014d:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800150:	8a 55 e3             	mov    -0x1d(%ebp),%dl
  800153:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  800155:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  800158:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80015b:	01 c2                	add    %eax,%edx
  80015d:	8a 45 e2             	mov    -0x1e(%ebp),%al
  800160:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800162:	8b 5d c8             	mov    -0x38(%ebp),%ebx
  800165:	e8 19 2b 00 00       	call   802c83 <sys_calculate_free_frames>
  80016a:	29 c3                	sub    %eax,%ebx
  80016c:	89 d8                	mov    %ebx,%eax
  80016e:	83 f8 03             	cmp    $0x3,%eax
  800171:	74 14                	je     800187 <_main+0x14f>
  800173:	83 ec 04             	sub    $0x4,%esp
  800176:	68 a8 34 80 00       	push   $0x8034a8
  80017b:	6a 42                	push   $0x42
  80017d:	68 fc 33 80 00       	push   $0x8033fc
  800182:	e8 85 15 00 00       	call   80170c <_panic>
		int var;
		int found = 0;
  800187:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)

		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80018e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800195:	eb 76                	jmp    80020d <_main+0x1d5>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  800197:	a1 20 40 80 00       	mov    0x804020,%eax
  80019c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001a2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8001a5:	c1 e2 04             	shl    $0x4,%edx
  8001a8:	01 d0                	add    %edx,%eax
  8001aa:	8b 00                	mov    (%eax),%eax
  8001ac:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001af:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001b2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001b7:	89 c2                	mov    %eax,%edx
  8001b9:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001bc:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001bf:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001c7:	39 c2                	cmp    %eax,%edx
  8001c9:	75 03                	jne    8001ce <_main+0x196>
				found++;
  8001cb:	ff 45 ec             	incl   -0x14(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  8001ce:	a1 20 40 80 00       	mov    0x804020,%eax
  8001d3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001d9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8001dc:	c1 e2 04             	shl    $0x4,%edx
  8001df:	01 d0                	add    %edx,%eax
  8001e1:	8b 00                	mov    (%eax),%eax
  8001e3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8001e6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001e9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001ee:	89 c1                	mov    %eax,%ecx
  8001f0:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  8001f3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001f6:	01 d0                	add    %edx,%eax
  8001f8:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8001fb:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8001fe:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800203:	39 c1                	cmp    %eax,%ecx
  800205:	75 03                	jne    80020a <_main+0x1d2>
				found++;
  800207:	ff 45 ec             	incl   -0x14(%ebp)
		byteArr[lastIndexOfByte] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int var;
		int found = 0;

		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80020a:	ff 45 f0             	incl   -0x10(%ebp)
  80020d:	a1 20 40 80 00       	mov    0x804020,%eax
  800212:	8b 50 74             	mov    0x74(%eax),%edx
  800215:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800218:	39 c2                	cmp    %eax,%edx
  80021a:	0f 87 77 ff ff ff    	ja     800197 <_main+0x15f>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800220:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
  800224:	74 14                	je     80023a <_main+0x202>
  800226:	83 ec 04             	sub    $0x4,%esp
  800229:	68 ec 34 80 00       	push   $0x8034ec
  80022e:	6a 4d                	push   $0x4d
  800230:	68 fc 33 80 00       	push   $0x8033fc
  800235:	e8 d2 14 00 00       	call   80170c <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80023a:	e8 c7 2a 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  80023f:	89 45 cc             	mov    %eax,-0x34(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800242:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800245:	01 c0                	add    %eax,%eax
  800247:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	50                   	push   %eax
  80024e:	e8 e5 24 00 00       	call   802738 <malloc>
  800253:	83 c4 10             	add    $0x10,%esp
  800256:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80025c:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  800262:	89 c2                	mov    %eax,%edx
  800264:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800267:	01 c0                	add    %eax,%eax
  800269:	05 00 00 00 80       	add    $0x80000000,%eax
  80026e:	39 c2                	cmp    %eax,%edx
  800270:	72 16                	jb     800288 <_main+0x250>
  800272:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  800278:	89 c2                	mov    %eax,%edx
  80027a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80027d:	01 c0                	add    %eax,%eax
  80027f:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800284:	39 c2                	cmp    %eax,%edx
  800286:	76 14                	jbe    80029c <_main+0x264>
  800288:	83 ec 04             	sub    $0x4,%esp
  80028b:	68 10 34 80 00       	push   $0x803410
  800290:	6a 52                	push   $0x52
  800292:	68 fc 33 80 00       	push   $0x8033fc
  800297:	e8 70 14 00 00       	call   80170c <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80029c:	e8 65 2a 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  8002a1:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8002a4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002a9:	74 14                	je     8002bf <_main+0x287>
  8002ab:	83 ec 04             	sub    $0x4,%esp
  8002ae:	68 78 34 80 00       	push   $0x803478
  8002b3:	6a 53                	push   $0x53
  8002b5:	68 fc 33 80 00       	push   $0x8033fc
  8002ba:	e8 4d 14 00 00       	call   80170c <_panic>
		freeFrames = sys_calculate_free_frames() ;
  8002bf:	e8 bf 29 00 00       	call   802c83 <sys_calculate_free_frames>
  8002c4:	89 45 c8             	mov    %eax,-0x38(%ebp)
		shortArr = (short *) ptr_allocations[1];
  8002c7:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  8002cd:	89 45 ac             	mov    %eax,-0x54(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  8002d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002d3:	01 c0                	add    %eax,%eax
  8002d5:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8002d8:	d1 e8                	shr    %eax
  8002da:	48                   	dec    %eax
  8002db:	89 45 a8             	mov    %eax,-0x58(%ebp)
		shortArr[0] = minShort;
  8002de:	8b 55 ac             	mov    -0x54(%ebp),%edx
  8002e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002e4:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  8002e7:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8002ea:	01 c0                	add    %eax,%eax
  8002ec:	89 c2                	mov    %eax,%edx
  8002ee:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8002f1:	01 c2                	add    %eax,%edx
  8002f3:	66 8b 45 de          	mov    -0x22(%ebp),%ax
  8002f7:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8002fa:	8b 5d c8             	mov    -0x38(%ebp),%ebx
  8002fd:	e8 81 29 00 00       	call   802c83 <sys_calculate_free_frames>
  800302:	29 c3                	sub    %eax,%ebx
  800304:	89 d8                	mov    %ebx,%eax
  800306:	83 f8 02             	cmp    $0x2,%eax
  800309:	74 14                	je     80031f <_main+0x2e7>
  80030b:	83 ec 04             	sub    $0x4,%esp
  80030e:	68 a8 34 80 00       	push   $0x8034a8
  800313:	6a 59                	push   $0x59
  800315:	68 fc 33 80 00       	push   $0x8033fc
  80031a:	e8 ed 13 00 00       	call   80170c <_panic>
		found = 0;
  80031f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800326:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80032d:	eb 7a                	jmp    8003a9 <_main+0x371>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  80032f:	a1 20 40 80 00       	mov    0x804020,%eax
  800334:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80033a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80033d:	c1 e2 04             	shl    $0x4,%edx
  800340:	01 d0                	add    %edx,%eax
  800342:	8b 00                	mov    (%eax),%eax
  800344:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800347:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80034a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80034f:	89 c2                	mov    %eax,%edx
  800351:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800354:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800357:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80035a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80035f:	39 c2                	cmp    %eax,%edx
  800361:	75 03                	jne    800366 <_main+0x32e>
				found++;
  800363:	ff 45 ec             	incl   -0x14(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  800366:	a1 20 40 80 00       	mov    0x804020,%eax
  80036b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800371:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800374:	c1 e2 04             	shl    $0x4,%edx
  800377:	01 d0                	add    %edx,%eax
  800379:	8b 00                	mov    (%eax),%eax
  80037b:	89 45 9c             	mov    %eax,-0x64(%ebp)
  80037e:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800381:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800386:	89 c2                	mov    %eax,%edx
  800388:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80038b:	01 c0                	add    %eax,%eax
  80038d:	89 c1                	mov    %eax,%ecx
  80038f:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800392:	01 c8                	add    %ecx,%eax
  800394:	89 45 98             	mov    %eax,-0x68(%ebp)
  800397:	8b 45 98             	mov    -0x68(%ebp),%eax
  80039a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80039f:	39 c2                	cmp    %eax,%edx
  8003a1:	75 03                	jne    8003a6 <_main+0x36e>
				found++;
  8003a3:	ff 45 ec             	incl   -0x14(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
		shortArr[0] = minShort;
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8003a6:	ff 45 f0             	incl   -0x10(%ebp)
  8003a9:	a1 20 40 80 00       	mov    0x804020,%eax
  8003ae:	8b 50 74             	mov    0x74(%eax),%edx
  8003b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b4:	39 c2                	cmp    %eax,%edx
  8003b6:	0f 87 73 ff ff ff    	ja     80032f <_main+0x2f7>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8003bc:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
  8003c0:	74 14                	je     8003d6 <_main+0x39e>
  8003c2:	83 ec 04             	sub    $0x4,%esp
  8003c5:	68 ec 34 80 00       	push   $0x8034ec
  8003ca:	6a 62                	push   $0x62
  8003cc:	68 fc 33 80 00       	push   $0x8033fc
  8003d1:	e8 36 13 00 00       	call   80170c <_panic>

		//3 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003d6:	e8 2b 29 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  8003db:	89 45 cc             	mov    %eax,-0x34(%ebp)
		ptr_allocations[2] = malloc(3*kilo);
  8003de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003e1:	89 c2                	mov    %eax,%edx
  8003e3:	01 d2                	add    %edx,%edx
  8003e5:	01 d0                	add    %edx,%eax
  8003e7:	83 ec 0c             	sub    $0xc,%esp
  8003ea:	50                   	push   %eax
  8003eb:	e8 48 23 00 00       	call   802738 <malloc>
  8003f0:	83 c4 10             	add    $0x10,%esp
  8003f3:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8003f9:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  8003ff:	89 c2                	mov    %eax,%edx
  800401:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800404:	c1 e0 02             	shl    $0x2,%eax
  800407:	05 00 00 00 80       	add    $0x80000000,%eax
  80040c:	39 c2                	cmp    %eax,%edx
  80040e:	72 17                	jb     800427 <_main+0x3ef>
  800410:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800416:	89 c2                	mov    %eax,%edx
  800418:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80041b:	c1 e0 02             	shl    $0x2,%eax
  80041e:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800423:	39 c2                	cmp    %eax,%edx
  800425:	76 14                	jbe    80043b <_main+0x403>
  800427:	83 ec 04             	sub    $0x4,%esp
  80042a:	68 10 34 80 00       	push   $0x803410
  80042f:	6a 67                	push   $0x67
  800431:	68 fc 33 80 00       	push   $0x8033fc
  800436:	e8 d1 12 00 00       	call   80170c <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80043b:	e8 c6 28 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  800440:	2b 45 cc             	sub    -0x34(%ebp),%eax
  800443:	83 f8 01             	cmp    $0x1,%eax
  800446:	74 14                	je     80045c <_main+0x424>
  800448:	83 ec 04             	sub    $0x4,%esp
  80044b:	68 78 34 80 00       	push   $0x803478
  800450:	6a 68                	push   $0x68
  800452:	68 fc 33 80 00       	push   $0x8033fc
  800457:	e8 b0 12 00 00       	call   80170c <_panic>
		freeFrames = sys_calculate_free_frames() ;
  80045c:	e8 22 28 00 00       	call   802c83 <sys_calculate_free_frames>
  800461:	89 45 c8             	mov    %eax,-0x38(%ebp)
		intArr = (int *) ptr_allocations[2];
  800464:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  80046a:	89 45 94             	mov    %eax,-0x6c(%ebp)
		lastIndexOfInt = (3*kilo)/sizeof(int) - 1;
  80046d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800470:	89 c2                	mov    %eax,%edx
  800472:	01 d2                	add    %edx,%edx
  800474:	01 d0                	add    %edx,%eax
  800476:	c1 e8 02             	shr    $0x2,%eax
  800479:	48                   	dec    %eax
  80047a:	89 45 90             	mov    %eax,-0x70(%ebp)
		intArr[0] = minInt;
  80047d:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800480:	8b 55 d8             	mov    -0x28(%ebp),%edx
  800483:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  800485:	8b 45 90             	mov    -0x70(%ebp),%eax
  800488:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048f:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800492:	01 c2                	add    %eax,%edx
  800494:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800497:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800499:	8b 5d c8             	mov    -0x38(%ebp),%ebx
  80049c:	e8 e2 27 00 00       	call   802c83 <sys_calculate_free_frames>
  8004a1:	29 c3                	sub    %eax,%ebx
  8004a3:	89 d8                	mov    %ebx,%eax
  8004a5:	83 f8 02             	cmp    $0x2,%eax
  8004a8:	74 14                	je     8004be <_main+0x486>
  8004aa:	83 ec 04             	sub    $0x4,%esp
  8004ad:	68 a8 34 80 00       	push   $0x8034a8
  8004b2:	6a 6e                	push   $0x6e
  8004b4:	68 fc 33 80 00       	push   $0x8033fc
  8004b9:	e8 4e 12 00 00       	call   80170c <_panic>
		found = 0;
  8004be:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8004c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004cc:	eb 7d                	jmp    80054b <_main+0x513>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  8004ce:	a1 20 40 80 00       	mov    0x804020,%eax
  8004d3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004d9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8004dc:	c1 e2 04             	shl    $0x4,%edx
  8004df:	01 d0                	add    %edx,%eax
  8004e1:	8b 00                	mov    (%eax),%eax
  8004e3:	89 45 8c             	mov    %eax,-0x74(%ebp)
  8004e6:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8004e9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004ee:	89 c2                	mov    %eax,%edx
  8004f0:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8004f3:	89 45 88             	mov    %eax,-0x78(%ebp)
  8004f6:	8b 45 88             	mov    -0x78(%ebp),%eax
  8004f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004fe:	39 c2                	cmp    %eax,%edx
  800500:	75 03                	jne    800505 <_main+0x4cd>
				found++;
  800502:	ff 45 ec             	incl   -0x14(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  800505:	a1 20 40 80 00       	mov    0x804020,%eax
  80050a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800510:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800513:	c1 e2 04             	shl    $0x4,%edx
  800516:	01 d0                	add    %edx,%eax
  800518:	8b 00                	mov    (%eax),%eax
  80051a:	89 45 84             	mov    %eax,-0x7c(%ebp)
  80051d:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800520:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800525:	89 c2                	mov    %eax,%edx
  800527:	8b 45 90             	mov    -0x70(%ebp),%eax
  80052a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800531:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800534:	01 c8                	add    %ecx,%eax
  800536:	89 45 80             	mov    %eax,-0x80(%ebp)
  800539:	8b 45 80             	mov    -0x80(%ebp),%eax
  80053c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800541:	39 c2                	cmp    %eax,%edx
  800543:	75 03                	jne    800548 <_main+0x510>
				found++;
  800545:	ff 45 ec             	incl   -0x14(%ebp)
		lastIndexOfInt = (3*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800548:	ff 45 f0             	incl   -0x10(%ebp)
  80054b:	a1 20 40 80 00       	mov    0x804020,%eax
  800550:	8b 50 74             	mov    0x74(%eax),%edx
  800553:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800556:	39 c2                	cmp    %eax,%edx
  800558:	0f 87 70 ff ff ff    	ja     8004ce <_main+0x496>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  80055e:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
  800562:	74 14                	je     800578 <_main+0x540>
  800564:	83 ec 04             	sub    $0x4,%esp
  800567:	68 ec 34 80 00       	push   $0x8034ec
  80056c:	6a 77                	push   $0x77
  80056e:	68 fc 33 80 00       	push   $0x8033fc
  800573:	e8 94 11 00 00       	call   80170c <_panic>

		//3 KB
		freeFrames = sys_calculate_free_frames() ;
  800578:	e8 06 27 00 00       	call   802c83 <sys_calculate_free_frames>
  80057d:	89 45 c8             	mov    %eax,-0x38(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800580:	e8 81 27 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  800585:	89 45 cc             	mov    %eax,-0x34(%ebp)
		ptr_allocations[3] = malloc(3*kilo);
  800588:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80058b:	89 c2                	mov    %eax,%edx
  80058d:	01 d2                	add    %edx,%edx
  80058f:	01 d0                	add    %edx,%eax
  800591:	83 ec 0c             	sub    $0xc,%esp
  800594:	50                   	push   %eax
  800595:	e8 9e 21 00 00       	call   802738 <malloc>
  80059a:	83 c4 10             	add    $0x10,%esp
  80059d:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8005a3:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8005a9:	89 c2                	mov    %eax,%edx
  8005ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ae:	c1 e0 02             	shl    $0x2,%eax
  8005b1:	89 c1                	mov    %eax,%ecx
  8005b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005b6:	c1 e0 02             	shl    $0x2,%eax
  8005b9:	01 c8                	add    %ecx,%eax
  8005bb:	05 00 00 00 80       	add    $0x80000000,%eax
  8005c0:	39 c2                	cmp    %eax,%edx
  8005c2:	72 21                	jb     8005e5 <_main+0x5ad>
  8005c4:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8005ca:	89 c2                	mov    %eax,%edx
  8005cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005cf:	c1 e0 02             	shl    $0x2,%eax
  8005d2:	89 c1                	mov    %eax,%ecx
  8005d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005d7:	c1 e0 02             	shl    $0x2,%eax
  8005da:	01 c8                	add    %ecx,%eax
  8005dc:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8005e1:	39 c2                	cmp    %eax,%edx
  8005e3:	76 14                	jbe    8005f9 <_main+0x5c1>
  8005e5:	83 ec 04             	sub    $0x4,%esp
  8005e8:	68 10 34 80 00       	push   $0x803410
  8005ed:	6a 7d                	push   $0x7d
  8005ef:	68 fc 33 80 00       	push   $0x8033fc
  8005f4:	e8 13 11 00 00       	call   80170c <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  8005f9:	e8 08 27 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  8005fe:	2b 45 cc             	sub    -0x34(%ebp),%eax
  800601:	83 f8 01             	cmp    $0x1,%eax
  800604:	74 14                	je     80061a <_main+0x5e2>
  800606:	83 ec 04             	sub    $0x4,%esp
  800609:	68 78 34 80 00       	push   $0x803478
  80060e:	6a 7e                	push   $0x7e
  800610:	68 fc 33 80 00       	push   $0x8033fc
  800615:	e8 f2 10 00 00       	call   80170c <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80061a:	e8 e7 26 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  80061f:	89 45 cc             	mov    %eax,-0x34(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800622:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800625:	89 d0                	mov    %edx,%eax
  800627:	01 c0                	add    %eax,%eax
  800629:	01 d0                	add    %edx,%eax
  80062b:	01 c0                	add    %eax,%eax
  80062d:	01 d0                	add    %edx,%eax
  80062f:	83 ec 0c             	sub    $0xc,%esp
  800632:	50                   	push   %eax
  800633:	e8 00 21 00 00       	call   802738 <malloc>
  800638:	83 c4 10             	add    $0x10,%esp
  80063b:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800641:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800647:	89 c2                	mov    %eax,%edx
  800649:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80064c:	c1 e0 02             	shl    $0x2,%eax
  80064f:	89 c1                	mov    %eax,%ecx
  800651:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800654:	c1 e0 03             	shl    $0x3,%eax
  800657:	01 c8                	add    %ecx,%eax
  800659:	05 00 00 00 80       	add    $0x80000000,%eax
  80065e:	39 c2                	cmp    %eax,%edx
  800660:	72 21                	jb     800683 <_main+0x64b>
  800662:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800668:	89 c2                	mov    %eax,%edx
  80066a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80066d:	c1 e0 02             	shl    $0x2,%eax
  800670:	89 c1                	mov    %eax,%ecx
  800672:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800675:	c1 e0 03             	shl    $0x3,%eax
  800678:	01 c8                	add    %ecx,%eax
  80067a:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80067f:	39 c2                	cmp    %eax,%edx
  800681:	76 17                	jbe    80069a <_main+0x662>
  800683:	83 ec 04             	sub    $0x4,%esp
  800686:	68 10 34 80 00       	push   $0x803410
  80068b:	68 84 00 00 00       	push   $0x84
  800690:	68 fc 33 80 00       	push   $0x8033fc
  800695:	e8 72 10 00 00       	call   80170c <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  80069a:	e8 67 26 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  80069f:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8006a2:	83 f8 02             	cmp    $0x2,%eax
  8006a5:	74 17                	je     8006be <_main+0x686>
  8006a7:	83 ec 04             	sub    $0x4,%esp
  8006aa:	68 78 34 80 00       	push   $0x803478
  8006af:	68 85 00 00 00       	push   $0x85
  8006b4:	68 fc 33 80 00       	push   $0x8033fc
  8006b9:	e8 4e 10 00 00       	call   80170c <_panic>
		freeFrames = sys_calculate_free_frames() ;
  8006be:	e8 c0 25 00 00       	call   802c83 <sys_calculate_free_frames>
  8006c3:	89 45 c8             	mov    %eax,-0x38(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  8006c6:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  8006cc:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  8006d2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8006d5:	89 d0                	mov    %edx,%eax
  8006d7:	01 c0                	add    %eax,%eax
  8006d9:	01 d0                	add    %edx,%eax
  8006db:	01 c0                	add    %eax,%eax
  8006dd:	01 d0                	add    %edx,%eax
  8006df:	c1 e8 03             	shr    $0x3,%eax
  8006e2:	48                   	dec    %eax
  8006e3:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  8006e9:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8006ef:	8a 55 e3             	mov    -0x1d(%ebp),%dl
  8006f2:	88 10                	mov    %dl,(%eax)
  8006f4:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
  8006fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006fd:	66 89 42 02          	mov    %ax,0x2(%edx)
  800701:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800707:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80070a:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  80070d:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800713:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80071a:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800720:	01 c2                	add    %eax,%edx
  800722:	8a 45 e2             	mov    -0x1e(%ebp),%al
  800725:	88 02                	mov    %al,(%edx)
  800727:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80072d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800734:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80073a:	01 c2                	add    %eax,%edx
  80073c:	66 8b 45 de          	mov    -0x22(%ebp),%ax
  800740:	66 89 42 02          	mov    %ax,0x2(%edx)
  800744:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80074a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800751:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800757:	01 c2                	add    %eax,%edx
  800759:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80075c:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  80075f:	8b 5d c8             	mov    -0x38(%ebp),%ebx
  800762:	e8 1c 25 00 00       	call   802c83 <sys_calculate_free_frames>
  800767:	29 c3                	sub    %eax,%ebx
  800769:	89 d8                	mov    %ebx,%eax
  80076b:	83 f8 02             	cmp    $0x2,%eax
  80076e:	74 17                	je     800787 <_main+0x74f>
  800770:	83 ec 04             	sub    $0x4,%esp
  800773:	68 a8 34 80 00       	push   $0x8034a8
  800778:	68 8b 00 00 00       	push   $0x8b
  80077d:	68 fc 33 80 00       	push   $0x8033fc
  800782:	e8 85 0f 00 00       	call   80170c <_panic>
		found = 0;
  800787:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80078e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800795:	e9 9e 00 00 00       	jmp    800838 <_main+0x800>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  80079a:	a1 20 40 80 00       	mov    0x804020,%eax
  80079f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007a5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8007a8:	c1 e2 04             	shl    $0x4,%edx
  8007ab:	01 d0                	add    %edx,%eax
  8007ad:	8b 00                	mov    (%eax),%eax
  8007af:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  8007b5:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8007bb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007c0:	89 c2                	mov    %eax,%edx
  8007c2:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8007c8:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  8007ce:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8007d4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007d9:	39 c2                	cmp    %eax,%edx
  8007db:	75 03                	jne    8007e0 <_main+0x7a8>
				found++;
  8007dd:	ff 45 ec             	incl   -0x14(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  8007e0:	a1 20 40 80 00       	mov    0x804020,%eax
  8007e5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007eb:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8007ee:	c1 e2 04             	shl    $0x4,%edx
  8007f1:	01 d0                	add    %edx,%eax
  8007f3:	8b 00                	mov    (%eax),%eax
  8007f5:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  8007fb:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800801:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800806:	89 c2                	mov    %eax,%edx
  800808:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80080e:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800815:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80081b:	01 c8                	add    %ecx,%eax
  80081d:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800823:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800829:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80082e:	39 c2                	cmp    %eax,%edx
  800830:	75 03                	jne    800835 <_main+0x7fd>
				found++;
  800832:	ff 45 ec             	incl   -0x14(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800835:	ff 45 f0             	incl   -0x10(%ebp)
  800838:	a1 20 40 80 00       	mov    0x804020,%eax
  80083d:	8b 50 74             	mov    0x74(%eax),%edx
  800840:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800843:	39 c2                	cmp    %eax,%edx
  800845:	0f 87 4f ff ff ff    	ja     80079a <_main+0x762>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  80084b:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
  80084f:	74 17                	je     800868 <_main+0x830>
  800851:	83 ec 04             	sub    $0x4,%esp
  800854:	68 ec 34 80 00       	push   $0x8034ec
  800859:	68 94 00 00 00       	push   $0x94
  80085e:	68 fc 33 80 00       	push   $0x8033fc
  800863:	e8 a4 0e 00 00       	call   80170c <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  800868:	e8 16 24 00 00       	call   802c83 <sys_calculate_free_frames>
  80086d:	89 45 c8             	mov    %eax,-0x38(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800870:	e8 91 24 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  800875:	89 45 cc             	mov    %eax,-0x34(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800878:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80087b:	89 c2                	mov    %eax,%edx
  80087d:	01 d2                	add    %edx,%edx
  80087f:	01 d0                	add    %edx,%eax
  800881:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800884:	83 ec 0c             	sub    $0xc,%esp
  800887:	50                   	push   %eax
  800888:	e8 ab 1e 00 00       	call   802738 <malloc>
  80088d:	83 c4 10             	add    $0x10,%esp
  800890:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800896:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  80089c:	89 c2                	mov    %eax,%edx
  80089e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008a1:	c1 e0 02             	shl    $0x2,%eax
  8008a4:	89 c1                	mov    %eax,%ecx
  8008a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8008a9:	c1 e0 04             	shl    $0x4,%eax
  8008ac:	01 c8                	add    %ecx,%eax
  8008ae:	05 00 00 00 80       	add    $0x80000000,%eax
  8008b3:	39 c2                	cmp    %eax,%edx
  8008b5:	72 21                	jb     8008d8 <_main+0x8a0>
  8008b7:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  8008bd:	89 c2                	mov    %eax,%edx
  8008bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008c2:	c1 e0 02             	shl    $0x2,%eax
  8008c5:	89 c1                	mov    %eax,%ecx
  8008c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8008ca:	c1 e0 04             	shl    $0x4,%eax
  8008cd:	01 c8                	add    %ecx,%eax
  8008cf:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8008d4:	39 c2                	cmp    %eax,%edx
  8008d6:	76 17                	jbe    8008ef <_main+0x8b7>
  8008d8:	83 ec 04             	sub    $0x4,%esp
  8008db:	68 10 34 80 00       	push   $0x803410
  8008e0:	68 9a 00 00 00       	push   $0x9a
  8008e5:	68 fc 33 80 00       	push   $0x8033fc
  8008ea:	e8 1d 0e 00 00       	call   80170c <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  8008ef:	e8 12 24 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  8008f4:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8008f7:	89 c2                	mov    %eax,%edx
  8008f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008fc:	89 c1                	mov    %eax,%ecx
  8008fe:	01 c9                	add    %ecx,%ecx
  800900:	01 c8                	add    %ecx,%eax
  800902:	85 c0                	test   %eax,%eax
  800904:	79 05                	jns    80090b <_main+0x8d3>
  800906:	05 ff 0f 00 00       	add    $0xfff,%eax
  80090b:	c1 f8 0c             	sar    $0xc,%eax
  80090e:	39 c2                	cmp    %eax,%edx
  800910:	74 17                	je     800929 <_main+0x8f1>
  800912:	83 ec 04             	sub    $0x4,%esp
  800915:	68 78 34 80 00       	push   $0x803478
  80091a:	68 9b 00 00 00       	push   $0x9b
  80091f:	68 fc 33 80 00       	push   $0x8033fc
  800924:	e8 e3 0d 00 00       	call   80170c <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800929:	e8 d8 23 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  80092e:	89 45 cc             	mov    %eax,-0x34(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  800931:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800934:	89 d0                	mov    %edx,%eax
  800936:	01 c0                	add    %eax,%eax
  800938:	01 d0                	add    %edx,%eax
  80093a:	01 c0                	add    %eax,%eax
  80093c:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80093f:	83 ec 0c             	sub    $0xc,%esp
  800942:	50                   	push   %eax
  800943:	e8 f0 1d 00 00       	call   802738 <malloc>
  800948:	83 c4 10             	add    $0x10,%esp
  80094b:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800951:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  800957:	89 c1                	mov    %eax,%ecx
  800959:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80095c:	89 d0                	mov    %edx,%eax
  80095e:	01 c0                	add    %eax,%eax
  800960:	01 d0                	add    %edx,%eax
  800962:	01 c0                	add    %eax,%eax
  800964:	01 d0                	add    %edx,%eax
  800966:	89 c2                	mov    %eax,%edx
  800968:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80096b:	c1 e0 04             	shl    $0x4,%eax
  80096e:	01 d0                	add    %edx,%eax
  800970:	05 00 00 00 80       	add    $0x80000000,%eax
  800975:	39 c1                	cmp    %eax,%ecx
  800977:	72 28                	jb     8009a1 <_main+0x969>
  800979:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  80097f:	89 c1                	mov    %eax,%ecx
  800981:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800984:	89 d0                	mov    %edx,%eax
  800986:	01 c0                	add    %eax,%eax
  800988:	01 d0                	add    %edx,%eax
  80098a:	01 c0                	add    %eax,%eax
  80098c:	01 d0                	add    %edx,%eax
  80098e:	89 c2                	mov    %eax,%edx
  800990:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800993:	c1 e0 04             	shl    $0x4,%eax
  800996:	01 d0                	add    %edx,%eax
  800998:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80099d:	39 c1                	cmp    %eax,%ecx
  80099f:	76 17                	jbe    8009b8 <_main+0x980>
  8009a1:	83 ec 04             	sub    $0x4,%esp
  8009a4:	68 10 34 80 00       	push   $0x803410
  8009a9:	68 a1 00 00 00       	push   $0xa1
  8009ae:	68 fc 33 80 00       	push   $0x8033fc
  8009b3:	e8 54 0d 00 00       	call   80170c <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  8009b8:	e8 49 23 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  8009bd:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8009c0:	89 c1                	mov    %eax,%ecx
  8009c2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009c5:	89 d0                	mov    %edx,%eax
  8009c7:	01 c0                	add    %eax,%eax
  8009c9:	01 d0                	add    %edx,%eax
  8009cb:	01 c0                	add    %eax,%eax
  8009cd:	85 c0                	test   %eax,%eax
  8009cf:	79 05                	jns    8009d6 <_main+0x99e>
  8009d1:	05 ff 0f 00 00       	add    $0xfff,%eax
  8009d6:	c1 f8 0c             	sar    $0xc,%eax
  8009d9:	39 c1                	cmp    %eax,%ecx
  8009db:	74 17                	je     8009f4 <_main+0x9bc>
  8009dd:	83 ec 04             	sub    $0x4,%esp
  8009e0:	68 78 34 80 00       	push   $0x803478
  8009e5:	68 a2 00 00 00       	push   $0xa2
  8009ea:	68 fc 33 80 00       	push   $0x8033fc
  8009ef:	e8 18 0d 00 00       	call   80170c <_panic>
		freeFrames = sys_calculate_free_frames() ;
  8009f4:	e8 8a 22 00 00       	call   802c83 <sys_calculate_free_frames>
  8009f9:	89 45 c8             	mov    %eax,-0x38(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  8009fc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009ff:	89 d0                	mov    %edx,%eax
  800a01:	01 c0                	add    %eax,%eax
  800a03:	01 d0                	add    %edx,%eax
  800a05:	01 c0                	add    %eax,%eax
  800a07:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800a0a:	48                   	dec    %eax
  800a0b:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800a11:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  800a17:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
		byteArr2[0] = minByte ;
  800a1d:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800a23:	8a 55 e3             	mov    -0x1d(%ebp),%dl
  800a26:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800a28:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800a2e:	89 c2                	mov    %eax,%edx
  800a30:	c1 ea 1f             	shr    $0x1f,%edx
  800a33:	01 d0                	add    %edx,%eax
  800a35:	d1 f8                	sar    %eax
  800a37:	89 c2                	mov    %eax,%edx
  800a39:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800a3f:	01 c2                	add    %eax,%edx
  800a41:	8a 45 e2             	mov    -0x1e(%ebp),%al
  800a44:	88 c1                	mov    %al,%cl
  800a46:	c0 e9 07             	shr    $0x7,%cl
  800a49:	01 c8                	add    %ecx,%eax
  800a4b:	d0 f8                	sar    %al
  800a4d:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  800a4f:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
  800a55:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800a5b:	01 c2                	add    %eax,%edx
  800a5d:	8a 45 e2             	mov    -0x1e(%ebp),%al
  800a60:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800a62:	8b 5d c8             	mov    -0x38(%ebp),%ebx
  800a65:	e8 19 22 00 00       	call   802c83 <sys_calculate_free_frames>
  800a6a:	29 c3                	sub    %eax,%ebx
  800a6c:	89 d8                	mov    %ebx,%eax
  800a6e:	83 f8 05             	cmp    $0x5,%eax
  800a71:	74 17                	je     800a8a <_main+0xa52>
  800a73:	83 ec 04             	sub    $0x4,%esp
  800a76:	68 a8 34 80 00       	push   $0x8034a8
  800a7b:	68 a9 00 00 00       	push   $0xa9
  800a80:	68 fc 33 80 00       	push   $0x8033fc
  800a85:	e8 82 0c 00 00       	call   80170c <_panic>
		found = 0;
  800a8a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800a91:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a98:	e9 f0 00 00 00       	jmp    800b8d <_main+0xb55>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800a9d:	a1 20 40 80 00       	mov    0x804020,%eax
  800aa2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800aa8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800aab:	c1 e2 04             	shl    $0x4,%edx
  800aae:	01 d0                	add    %edx,%eax
  800ab0:	8b 00                	mov    (%eax),%eax
  800ab2:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  800ab8:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800abe:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ac3:	89 c2                	mov    %eax,%edx
  800ac5:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800acb:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  800ad1:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800ad7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800adc:	39 c2                	cmp    %eax,%edx
  800ade:	75 03                	jne    800ae3 <_main+0xaab>
				found++;
  800ae0:	ff 45 ec             	incl   -0x14(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800ae3:	a1 20 40 80 00       	mov    0x804020,%eax
  800ae8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800aee:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800af1:	c1 e2 04             	shl    $0x4,%edx
  800af4:	01 d0                	add    %edx,%eax
  800af6:	8b 00                	mov    (%eax),%eax
  800af8:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800afe:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b04:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b09:	89 c2                	mov    %eax,%edx
  800b0b:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800b11:	89 c1                	mov    %eax,%ecx
  800b13:	c1 e9 1f             	shr    $0x1f,%ecx
  800b16:	01 c8                	add    %ecx,%eax
  800b18:	d1 f8                	sar    %eax
  800b1a:	89 c1                	mov    %eax,%ecx
  800b1c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800b22:	01 c8                	add    %ecx,%eax
  800b24:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b2a:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b30:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b35:	39 c2                	cmp    %eax,%edx
  800b37:	75 03                	jne    800b3c <_main+0xb04>
				found++;
  800b39:	ff 45 ec             	incl   -0x14(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800b3c:	a1 20 40 80 00       	mov    0x804020,%eax
  800b41:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b47:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800b4a:	c1 e2 04             	shl    $0x4,%edx
  800b4d:	01 d0                	add    %edx,%eax
  800b4f:	8b 00                	mov    (%eax),%eax
  800b51:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b57:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b5d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b62:	89 c1                	mov    %eax,%ecx
  800b64:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
  800b6a:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800b70:	01 d0                	add    %edx,%eax
  800b72:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800b78:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800b7e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b83:	39 c1                	cmp    %eax,%ecx
  800b85:	75 03                	jne    800b8a <_main+0xb52>
				found++;
  800b87:	ff 45 ec             	incl   -0x14(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800b8a:	ff 45 f0             	incl   -0x10(%ebp)
  800b8d:	a1 20 40 80 00       	mov    0x804020,%eax
  800b92:	8b 50 74             	mov    0x74(%eax),%edx
  800b95:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b98:	39 c2                	cmp    %eax,%edx
  800b9a:	0f 87 fd fe ff ff    	ja     800a9d <_main+0xa65>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  800ba0:	83 7d ec 03          	cmpl   $0x3,-0x14(%ebp)
  800ba4:	74 17                	je     800bbd <_main+0xb85>
  800ba6:	83 ec 04             	sub    $0x4,%esp
  800ba9:	68 ec 34 80 00       	push   $0x8034ec
  800bae:	68 b4 00 00 00       	push   $0xb4
  800bb3:	68 fc 33 80 00       	push   $0x8033fc
  800bb8:	e8 4f 0b 00 00       	call   80170c <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800bbd:	e8 44 21 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  800bc2:	89 45 cc             	mov    %eax,-0x34(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  800bc5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800bc8:	89 d0                	mov    %edx,%eax
  800bca:	01 c0                	add    %eax,%eax
  800bcc:	01 d0                	add    %edx,%eax
  800bce:	01 c0                	add    %eax,%eax
  800bd0:	01 d0                	add    %edx,%eax
  800bd2:	01 c0                	add    %eax,%eax
  800bd4:	83 ec 0c             	sub    $0xc,%esp
  800bd7:	50                   	push   %eax
  800bd8:	e8 5b 1b 00 00       	call   802738 <malloc>
  800bdd:	83 c4 10             	add    $0x10,%esp
  800be0:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800be6:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  800bec:	89 c1                	mov    %eax,%ecx
  800bee:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800bf1:	89 d0                	mov    %edx,%eax
  800bf3:	01 c0                	add    %eax,%eax
  800bf5:	01 d0                	add    %edx,%eax
  800bf7:	c1 e0 02             	shl    $0x2,%eax
  800bfa:	01 d0                	add    %edx,%eax
  800bfc:	89 c2                	mov    %eax,%edx
  800bfe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800c01:	c1 e0 04             	shl    $0x4,%eax
  800c04:	01 d0                	add    %edx,%eax
  800c06:	05 00 00 00 80       	add    $0x80000000,%eax
  800c0b:	39 c1                	cmp    %eax,%ecx
  800c0d:	72 29                	jb     800c38 <_main+0xc00>
  800c0f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  800c15:	89 c1                	mov    %eax,%ecx
  800c17:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800c1a:	89 d0                	mov    %edx,%eax
  800c1c:	01 c0                	add    %eax,%eax
  800c1e:	01 d0                	add    %edx,%eax
  800c20:	c1 e0 02             	shl    $0x2,%eax
  800c23:	01 d0                	add    %edx,%eax
  800c25:	89 c2                	mov    %eax,%edx
  800c27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800c2a:	c1 e0 04             	shl    $0x4,%eax
  800c2d:	01 d0                	add    %edx,%eax
  800c2f:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800c34:	39 c1                	cmp    %eax,%ecx
  800c36:	76 17                	jbe    800c4f <_main+0xc17>
  800c38:	83 ec 04             	sub    $0x4,%esp
  800c3b:	68 10 34 80 00       	push   $0x803410
  800c40:	68 b9 00 00 00       	push   $0xb9
  800c45:	68 fc 33 80 00       	push   $0x8033fc
  800c4a:	e8 bd 0a 00 00       	call   80170c <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800c4f:	e8 b2 20 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  800c54:	2b 45 cc             	sub    -0x34(%ebp),%eax
  800c57:	83 f8 04             	cmp    $0x4,%eax
  800c5a:	74 17                	je     800c73 <_main+0xc3b>
  800c5c:	83 ec 04             	sub    $0x4,%esp
  800c5f:	68 78 34 80 00       	push   $0x803478
  800c64:	68 ba 00 00 00       	push   $0xba
  800c69:	68 fc 33 80 00       	push   $0x8033fc
  800c6e:	e8 99 0a 00 00       	call   80170c <_panic>
		freeFrames = sys_calculate_free_frames() ;
  800c73:	e8 0b 20 00 00       	call   802c83 <sys_calculate_free_frames>
  800c78:	89 45 c8             	mov    %eax,-0x38(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800c7b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  800c81:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  800c87:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800c8a:	89 d0                	mov    %edx,%eax
  800c8c:	01 c0                	add    %eax,%eax
  800c8e:	01 d0                	add    %edx,%eax
  800c90:	01 c0                	add    %eax,%eax
  800c92:	01 d0                	add    %edx,%eax
  800c94:	01 c0                	add    %eax,%eax
  800c96:	d1 e8                	shr    %eax
  800c98:	48                   	dec    %eax
  800c99:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
		shortArr2[0] = minShort;
  800c9f:	8b 95 44 ff ff ff    	mov    -0xbc(%ebp),%edx
  800ca5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ca8:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800cab:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800cb1:	01 c0                	add    %eax,%eax
  800cb3:	89 c2                	mov    %eax,%edx
  800cb5:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800cbb:	01 c2                	add    %eax,%edx
  800cbd:	66 8b 45 de          	mov    -0x22(%ebp),%ax
  800cc1:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800cc4:	8b 5d c8             	mov    -0x38(%ebp),%ebx
  800cc7:	e8 b7 1f 00 00       	call   802c83 <sys_calculate_free_frames>
  800ccc:	29 c3                	sub    %eax,%ebx
  800cce:	89 d8                	mov    %ebx,%eax
  800cd0:	83 f8 02             	cmp    $0x2,%eax
  800cd3:	74 17                	je     800cec <_main+0xcb4>
  800cd5:	83 ec 04             	sub    $0x4,%esp
  800cd8:	68 a8 34 80 00       	push   $0x8034a8
  800cdd:	68 c0 00 00 00       	push   $0xc0
  800ce2:	68 fc 33 80 00       	push   $0x8033fc
  800ce7:	e8 20 0a 00 00       	call   80170c <_panic>
		found = 0;
  800cec:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800cf3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800cfa:	e9 9b 00 00 00       	jmp    800d9a <_main+0xd62>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800cff:	a1 20 40 80 00       	mov    0x804020,%eax
  800d04:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d0a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800d0d:	c1 e2 04             	shl    $0x4,%edx
  800d10:	01 d0                	add    %edx,%eax
  800d12:	8b 00                	mov    (%eax),%eax
  800d14:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
  800d1a:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800d20:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d25:	89 c2                	mov    %eax,%edx
  800d27:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800d2d:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
  800d33:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d39:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d3e:	39 c2                	cmp    %eax,%edx
  800d40:	75 03                	jne    800d45 <_main+0xd0d>
				found++;
  800d42:	ff 45 ec             	incl   -0x14(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800d45:	a1 20 40 80 00       	mov    0x804020,%eax
  800d4a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d50:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800d53:	c1 e2 04             	shl    $0x4,%edx
  800d56:	01 d0                	add    %edx,%eax
  800d58:	8b 00                	mov    (%eax),%eax
  800d5a:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800d60:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800d66:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d6b:	89 c2                	mov    %eax,%edx
  800d6d:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800d73:	01 c0                	add    %eax,%eax
  800d75:	89 c1                	mov    %eax,%ecx
  800d77:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800d7d:	01 c8                	add    %ecx,%eax
  800d7f:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800d85:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800d8b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d90:	39 c2                	cmp    %eax,%edx
  800d92:	75 03                	jne    800d97 <_main+0xd5f>
				found++;
  800d94:	ff 45 ec             	incl   -0x14(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d97:	ff 45 f0             	incl   -0x10(%ebp)
  800d9a:	a1 20 40 80 00       	mov    0x804020,%eax
  800d9f:	8b 50 74             	mov    0x74(%eax),%edx
  800da2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800da5:	39 c2                	cmp    %eax,%edx
  800da7:	0f 87 52 ff ff ff    	ja     800cff <_main+0xcc7>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800dad:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
  800db1:	74 17                	je     800dca <_main+0xd92>
  800db3:	83 ec 04             	sub    $0x4,%esp
  800db6:	68 ec 34 80 00       	push   $0x8034ec
  800dbb:	68 c9 00 00 00       	push   $0xc9
  800dc0:	68 fc 33 80 00       	push   $0x8033fc
  800dc5:	e8 42 09 00 00       	call   80170c <_panic>
	}

	{
		uint32 tmp_addresses[3] = {0};
  800dca:	8d 95 c8 fe ff ff    	lea    -0x138(%ebp),%edx
  800dd0:	b9 03 00 00 00       	mov    $0x3,%ecx
  800dd5:	b8 00 00 00 00       	mov    $0x0,%eax
  800dda:	89 d7                	mov    %edx,%edi
  800ddc:	f3 ab                	rep stos %eax,%es:(%edi)

		//Free 6 MB
		int freeFrames = sys_calculate_free_frames() ;
  800dde:	e8 a0 1e 00 00       	call   802c83 <sys_calculate_free_frames>
  800de3:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800de9:	e8 18 1f 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  800dee:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
		free(ptr_allocations[6]);
  800df4:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  800dfa:	83 ec 0c             	sub    $0xc,%esp
  800dfd:	50                   	push   %eax
  800dfe:	e8 72 1a 00 00       	call   802875 <free>
  800e03:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  800e06:	e8 fb 1e 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  800e0b:	8b 95 28 ff ff ff    	mov    -0xd8(%ebp),%edx
  800e11:	89 d1                	mov    %edx,%ecx
  800e13:	29 c1                	sub    %eax,%ecx
  800e15:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800e18:	89 d0                	mov    %edx,%eax
  800e1a:	01 c0                	add    %eax,%eax
  800e1c:	01 d0                	add    %edx,%eax
  800e1e:	01 c0                	add    %eax,%eax
  800e20:	85 c0                	test   %eax,%eax
  800e22:	79 05                	jns    800e29 <_main+0xdf1>
  800e24:	05 ff 0f 00 00       	add    $0xfff,%eax
  800e29:	c1 f8 0c             	sar    $0xc,%eax
  800e2c:	39 c1                	cmp    %eax,%ecx
  800e2e:	74 17                	je     800e47 <_main+0xe0f>
  800e30:	83 ec 04             	sub    $0x4,%esp
  800e33:	68 0c 35 80 00       	push   $0x80350c
  800e38:	68 d3 00 00 00       	push   $0xd3
  800e3d:	68 fc 33 80 00       	push   $0x8033fc
  800e42:	e8 c5 08 00 00       	call   80170c <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800e47:	e8 37 1e 00 00       	call   802c83 <sys_calculate_free_frames>
  800e4c:	89 c2                	mov    %eax,%edx
  800e4e:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800e54:	29 c2                	sub    %eax,%edx
  800e56:	89 d0                	mov    %edx,%eax
  800e58:	83 f8 04             	cmp    $0x4,%eax
  800e5b:	74 17                	je     800e74 <_main+0xe3c>
  800e5d:	83 ec 04             	sub    $0x4,%esp
  800e60:	68 48 35 80 00       	push   $0x803548
  800e65:	68 d4 00 00 00       	push   $0xd4
  800e6a:	68 fc 33 80 00       	push   $0x8033fc
  800e6f:	e8 98 08 00 00       	call   80170c <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32)(&(byteArr2[0]));
  800e74:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800e7a:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
		tmp_addresses[1] = (uint32)(&(byteArr2[lastIndexOfByte2/2]));
  800e80:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800e86:	89 c2                	mov    %eax,%edx
  800e88:	c1 ea 1f             	shr    $0x1f,%edx
  800e8b:	01 d0                	add    %edx,%eax
  800e8d:	d1 f8                	sar    %eax
  800e8f:	89 c2                	mov    %eax,%edx
  800e91:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800e97:	01 d0                	add    %edx,%eax
  800e99:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
		tmp_addresses[2] = (uint32)(&(byteArr2[lastIndexOfByte2]));
  800e9f:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
  800ea5:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800eab:	01 d0                	add    %edx,%eax
  800ead:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
		int check = sys_check_LRU_lists_free(tmp_addresses, 3);
  800eb3:	83 ec 08             	sub    $0x8,%esp
  800eb6:	6a 03                	push   $0x3
  800eb8:	8d 85 c8 fe ff ff    	lea    -0x138(%ebp),%eax
  800ebe:	50                   	push   %eax
  800ebf:	e8 93 22 00 00       	call   803157 <sys_check_LRU_lists_free>
  800ec4:	83 c4 10             	add    $0x10,%esp
  800ec7:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		if(check != 0)
  800ecd:	83 bd 24 ff ff ff 00 	cmpl   $0x0,-0xdc(%ebp)
  800ed4:	74 17                	je     800eed <_main+0xeb5>
		{
				panic("free: page is not removed from LRU lists");
  800ed6:	83 ec 04             	sub    $0x4,%esp
  800ed9:	68 94 35 80 00       	push   $0x803594
  800ede:	68 e4 00 00 00       	push   $0xe4
  800ee3:	68 fc 33 80 00       	push   $0x8033fc
  800ee8:	e8 1f 08 00 00       	call   80170c <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 800 && LIST_SIZE(&myEnv->SecondList) != 1)
  800eed:	a1 20 40 80 00       	mov    0x804020,%eax
  800ef2:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  800ef8:	3d 20 03 00 00       	cmp    $0x320,%eax
  800efd:	74 27                	je     800f26 <_main+0xeee>
  800eff:	a1 20 40 80 00       	mov    0x804020,%eax
  800f04:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  800f0a:	83 f8 01             	cmp    $0x1,%eax
  800f0d:	74 17                	je     800f26 <_main+0xeee>
		{
			panic("LRU lists content is not correct");
  800f0f:	83 ec 04             	sub    $0x4,%esp
  800f12:	68 c0 35 80 00       	push   $0x8035c0
  800f17:	68 e9 00 00 00       	push   $0xe9
  800f1c:	68 fc 33 80 00       	push   $0x8033fc
  800f21:	e8 e6 07 00 00       	call   80170c <_panic>
		}

		//Free 1st 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800f26:	e8 58 1d 00 00       	call   802c83 <sys_calculate_free_frames>
  800f2b:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800f31:	e8 d0 1d 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  800f36:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
		free(ptr_allocations[0]);
  800f3c:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  800f42:	83 ec 0c             	sub    $0xc,%esp
  800f45:	50                   	push   %eax
  800f46:	e8 2a 19 00 00       	call   802875 <free>
  800f4b:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800f4e:	e8 b3 1d 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  800f53:	8b 95 28 ff ff ff    	mov    -0xd8(%ebp),%edx
  800f59:	29 c2                	sub    %eax,%edx
  800f5b:	89 d0                	mov    %edx,%eax
  800f5d:	3d 00 02 00 00       	cmp    $0x200,%eax
  800f62:	74 17                	je     800f7b <_main+0xf43>
  800f64:	83 ec 04             	sub    $0x4,%esp
  800f67:	68 0c 35 80 00       	push   $0x80350c
  800f6c:	68 f0 00 00 00       	push   $0xf0
  800f71:	68 fc 33 80 00       	push   $0x8033fc
  800f76:	e8 91 07 00 00       	call   80170c <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800f7b:	e8 03 1d 00 00       	call   802c83 <sys_calculate_free_frames>
  800f80:	89 c2                	mov    %eax,%edx
  800f82:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800f88:	29 c2                	sub    %eax,%edx
  800f8a:	89 d0                	mov    %edx,%eax
  800f8c:	83 f8 02             	cmp    $0x2,%eax
  800f8f:	74 17                	je     800fa8 <_main+0xf70>
  800f91:	83 ec 04             	sub    $0x4,%esp
  800f94:	68 48 35 80 00       	push   $0x803548
  800f99:	68 f1 00 00 00       	push   $0xf1
  800f9e:	68 fc 33 80 00       	push   $0x8033fc
  800fa3:	e8 64 07 00 00       	call   80170c <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(byteArr[0]));
  800fa8:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800fab:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
		tmp_addresses[1] = (uint32)(&(byteArr[lastIndexOfByte]));
  800fb1:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  800fb4:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800fb7:	01 d0                	add    %edx,%eax
  800fb9:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  800fbf:	83 ec 08             	sub    $0x8,%esp
  800fc2:	6a 02                	push   $0x2
  800fc4:	8d 85 c8 fe ff ff    	lea    -0x138(%ebp),%eax
  800fca:	50                   	push   %eax
  800fcb:	e8 87 21 00 00       	call   803157 <sys_check_LRU_lists_free>
  800fd0:	83 c4 10             	add    $0x10,%esp
  800fd3:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		if(check != 0)
  800fd9:	83 bd 24 ff ff ff 00 	cmpl   $0x0,-0xdc(%ebp)
  800fe0:	74 17                	je     800ff9 <_main+0xfc1>
		{
				panic("free: page is not removed from LRU lists");
  800fe2:	83 ec 04             	sub    $0x4,%esp
  800fe5:	68 94 35 80 00       	push   $0x803594
  800fea:	68 00 01 00 00       	push   $0x100
  800fef:	68 fc 33 80 00       	push   $0x8033fc
  800ff4:	e8 13 07 00 00       	call   80170c <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 799 && LIST_SIZE(&myEnv->SecondList) != 0)
  800ff9:	a1 20 40 80 00       	mov    0x804020,%eax
  800ffe:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801004:	3d 1f 03 00 00       	cmp    $0x31f,%eax
  801009:	74 26                	je     801031 <_main+0xff9>
  80100b:	a1 20 40 80 00       	mov    0x804020,%eax
  801010:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801016:	85 c0                	test   %eax,%eax
  801018:	74 17                	je     801031 <_main+0xff9>
		{
			panic("LRU lists content is not correct");
  80101a:	83 ec 04             	sub    $0x4,%esp
  80101d:	68 c0 35 80 00       	push   $0x8035c0
  801022:	68 05 01 00 00       	push   $0x105
  801027:	68 fc 33 80 00       	push   $0x8033fc
  80102c:	e8 db 06 00 00       	call   80170c <_panic>
		}

		//Free 2nd 2 MB
		freeFrames = sys_calculate_free_frames() ;
  801031:	e8 4d 1c 00 00       	call   802c83 <sys_calculate_free_frames>
  801036:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80103c:	e8 c5 1c 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  801041:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
		free(ptr_allocations[1]);
  801047:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  80104d:	83 ec 0c             	sub    $0xc,%esp
  801050:	50                   	push   %eax
  801051:	e8 1f 18 00 00       	call   802875 <free>
  801056:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  801059:	e8 a8 1c 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  80105e:	8b 95 28 ff ff ff    	mov    -0xd8(%ebp),%edx
  801064:	29 c2                	sub    %eax,%edx
  801066:	89 d0                	mov    %edx,%eax
  801068:	3d 00 02 00 00       	cmp    $0x200,%eax
  80106d:	74 17                	je     801086 <_main+0x104e>
  80106f:	83 ec 04             	sub    $0x4,%esp
  801072:	68 0c 35 80 00       	push   $0x80350c
  801077:	68 0c 01 00 00       	push   $0x10c
  80107c:	68 fc 33 80 00       	push   $0x8033fc
  801081:	e8 86 06 00 00       	call   80170c <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801086:	e8 f8 1b 00 00       	call   802c83 <sys_calculate_free_frames>
  80108b:	89 c2                	mov    %eax,%edx
  80108d:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801093:	29 c2                	sub    %eax,%edx
  801095:	89 d0                	mov    %edx,%eax
  801097:	83 f8 03             	cmp    $0x3,%eax
  80109a:	74 17                	je     8010b3 <_main+0x107b>
  80109c:	83 ec 04             	sub    $0x4,%esp
  80109f:	68 48 35 80 00       	push   $0x803548
  8010a4:	68 0d 01 00 00       	push   $0x10d
  8010a9:	68 fc 33 80 00       	push   $0x8033fc
  8010ae:	e8 59 06 00 00       	call   80170c <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32)(&(shortArr[0]));
  8010b3:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8010b6:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
		tmp_addresses[1] = (uint32)(&(shortArr[lastIndexOfShort]));
  8010bc:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8010bf:	01 c0                	add    %eax,%eax
  8010c1:	89 c2                	mov    %eax,%edx
  8010c3:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8010c6:	01 d0                	add    %edx,%eax
  8010c8:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8010ce:	83 ec 08             	sub    $0x8,%esp
  8010d1:	6a 02                	push   $0x2
  8010d3:	8d 85 c8 fe ff ff    	lea    -0x138(%ebp),%eax
  8010d9:	50                   	push   %eax
  8010da:	e8 78 20 00 00       	call   803157 <sys_check_LRU_lists_free>
  8010df:	83 c4 10             	add    $0x10,%esp
  8010e2:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		if(check != 0)
  8010e8:	83 bd 24 ff ff ff 00 	cmpl   $0x0,-0xdc(%ebp)
  8010ef:	74 17                	je     801108 <_main+0x10d0>
		{
				panic("free: page is not removed from LRU lists");
  8010f1:	83 ec 04             	sub    $0x4,%esp
  8010f4:	68 94 35 80 00       	push   $0x803594
  8010f9:	68 1a 01 00 00       	push   $0x11a
  8010fe:	68 fc 33 80 00       	push   $0x8033fc
  801103:	e8 04 06 00 00       	call   80170c <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 797 && LIST_SIZE(&myEnv->SecondList) != 0)
  801108:	a1 20 40 80 00       	mov    0x804020,%eax
  80110d:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801113:	3d 1d 03 00 00       	cmp    $0x31d,%eax
  801118:	74 26                	je     801140 <_main+0x1108>
  80111a:	a1 20 40 80 00       	mov    0x804020,%eax
  80111f:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801125:	85 c0                	test   %eax,%eax
  801127:	74 17                	je     801140 <_main+0x1108>
		{
			panic("LRU lists content is not correct");
  801129:	83 ec 04             	sub    $0x4,%esp
  80112c:	68 c0 35 80 00       	push   $0x8035c0
  801131:	68 1f 01 00 00       	push   $0x11f
  801136:	68 fc 33 80 00       	push   $0x8033fc
  80113b:	e8 cc 05 00 00       	call   80170c <_panic>
		}


		//Free 7 KB
		freeFrames = sys_calculate_free_frames() ;
  801140:	e8 3e 1b 00 00       	call   802c83 <sys_calculate_free_frames>
  801145:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80114b:	e8 b6 1b 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  801150:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
		free(ptr_allocations[4]);
  801156:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  80115c:	83 ec 0c             	sub    $0xc,%esp
  80115f:	50                   	push   %eax
  801160:	e8 10 17 00 00       	call   802875 <free>
  801165:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  801168:	e8 99 1b 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  80116d:	8b 95 28 ff ff ff    	mov    -0xd8(%ebp),%edx
  801173:	29 c2                	sub    %eax,%edx
  801175:	89 d0                	mov    %edx,%eax
  801177:	83 f8 02             	cmp    $0x2,%eax
  80117a:	74 17                	je     801193 <_main+0x115b>
  80117c:	83 ec 04             	sub    $0x4,%esp
  80117f:	68 0c 35 80 00       	push   $0x80350c
  801184:	68 27 01 00 00       	push   $0x127
  801189:	68 fc 33 80 00       	push   $0x8033fc
  80118e:	e8 79 05 00 00       	call   80170c <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801193:	e8 eb 1a 00 00       	call   802c83 <sys_calculate_free_frames>
  801198:	89 c2                	mov    %eax,%edx
  80119a:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  8011a0:	29 c2                	sub    %eax,%edx
  8011a2:	89 d0                	mov    %edx,%eax
  8011a4:	83 f8 02             	cmp    $0x2,%eax
  8011a7:	74 17                	je     8011c0 <_main+0x1188>
  8011a9:	83 ec 04             	sub    $0x4,%esp
  8011ac:	68 48 35 80 00       	push   $0x803548
  8011b1:	68 28 01 00 00       	push   $0x128
  8011b6:	68 fc 33 80 00       	push   $0x8033fc
  8011bb:	e8 4c 05 00 00       	call   80170c <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(structArr[0]));
  8011c0:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8011c6:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
		tmp_addresses[1] = (uint32)(&(structArr[lastIndexOfStruct]));
  8011cc:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8011d2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8011d9:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8011df:	01 d0                	add    %edx,%eax
  8011e1:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8011e7:	83 ec 08             	sub    $0x8,%esp
  8011ea:	6a 02                	push   $0x2
  8011ec:	8d 85 c8 fe ff ff    	lea    -0x138(%ebp),%eax
  8011f2:	50                   	push   %eax
  8011f3:	e8 5f 1f 00 00       	call   803157 <sys_check_LRU_lists_free>
  8011f8:	83 c4 10             	add    $0x10,%esp
  8011fb:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		if(check != 0)
  801201:	83 bd 24 ff ff ff 00 	cmpl   $0x0,-0xdc(%ebp)
  801208:	74 17                	je     801221 <_main+0x11e9>
		{
				panic("free: page is not removed from LRU lists");
  80120a:	83 ec 04             	sub    $0x4,%esp
  80120d:	68 94 35 80 00       	push   $0x803594
  801212:	68 36 01 00 00       	push   $0x136
  801217:	68 fc 33 80 00       	push   $0x8033fc
  80121c:	e8 eb 04 00 00       	call   80170c <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 795 && LIST_SIZE(&myEnv->SecondList) != 0)
  801221:	a1 20 40 80 00       	mov    0x804020,%eax
  801226:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  80122c:	3d 1b 03 00 00       	cmp    $0x31b,%eax
  801231:	74 26                	je     801259 <_main+0x1221>
  801233:	a1 20 40 80 00       	mov    0x804020,%eax
  801238:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  80123e:	85 c0                	test   %eax,%eax
  801240:	74 17                	je     801259 <_main+0x1221>
		{
			panic("LRU lists content is not correct");
  801242:	83 ec 04             	sub    $0x4,%esp
  801245:	68 c0 35 80 00       	push   $0x8035c0
  80124a:	68 3b 01 00 00       	push   $0x13b
  80124f:	68 fc 33 80 00       	push   $0x8033fc
  801254:	e8 b3 04 00 00       	call   80170c <_panic>
		}

		//Free 3 MB
		freeFrames = sys_calculate_free_frames() ;
  801259:	e8 25 1a 00 00       	call   802c83 <sys_calculate_free_frames>
  80125e:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801264:	e8 9d 1a 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  801269:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
		free(ptr_allocations[5]);
  80126f:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  801275:	83 ec 0c             	sub    $0xc,%esp
  801278:	50                   	push   %eax
  801279:	e8 f7 15 00 00       	call   802875 <free>
  80127e:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  801281:	e8 80 1a 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  801286:	8b 95 28 ff ff ff    	mov    -0xd8(%ebp),%edx
  80128c:	89 d1                	mov    %edx,%ecx
  80128e:	29 c1                	sub    %eax,%ecx
  801290:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801293:	89 c2                	mov    %eax,%edx
  801295:	01 d2                	add    %edx,%edx
  801297:	01 d0                	add    %edx,%eax
  801299:	85 c0                	test   %eax,%eax
  80129b:	79 05                	jns    8012a2 <_main+0x126a>
  80129d:	05 ff 0f 00 00       	add    $0xfff,%eax
  8012a2:	c1 f8 0c             	sar    $0xc,%eax
  8012a5:	39 c1                	cmp    %eax,%ecx
  8012a7:	74 17                	je     8012c0 <_main+0x1288>
  8012a9:	83 ec 04             	sub    $0x4,%esp
  8012ac:	68 0c 35 80 00       	push   $0x80350c
  8012b1:	68 42 01 00 00       	push   $0x142
  8012b6:	68 fc 33 80 00       	push   $0x8033fc
  8012bb:	e8 4c 04 00 00       	call   80170c <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8012c0:	e8 be 19 00 00       	call   802c83 <sys_calculate_free_frames>
  8012c5:	89 c2                	mov    %eax,%edx
  8012c7:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  8012cd:	39 c2                	cmp    %eax,%edx
  8012cf:	74 17                	je     8012e8 <_main+0x12b0>
  8012d1:	83 ec 04             	sub    $0x4,%esp
  8012d4:	68 48 35 80 00       	push   $0x803548
  8012d9:	68 43 01 00 00       	push   $0x143
  8012de:	68 fc 33 80 00       	push   $0x8033fc
  8012e3:	e8 24 04 00 00       	call   80170c <_panic>

		//Free 1st 3 KB
		freeFrames = sys_calculate_free_frames() ;
  8012e8:	e8 96 19 00 00       	call   802c83 <sys_calculate_free_frames>
  8012ed:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8012f3:	e8 0e 1a 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  8012f8:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
		free(ptr_allocations[2]);
  8012fe:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  801304:	83 ec 0c             	sub    $0xc,%esp
  801307:	50                   	push   %eax
  801308:	e8 68 15 00 00       	call   802875 <free>
  80130d:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  801310:	e8 f1 19 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  801315:	8b 95 28 ff ff ff    	mov    -0xd8(%ebp),%edx
  80131b:	29 c2                	sub    %eax,%edx
  80131d:	89 d0                	mov    %edx,%eax
  80131f:	83 f8 01             	cmp    $0x1,%eax
  801322:	74 17                	je     80133b <_main+0x1303>
  801324:	83 ec 04             	sub    $0x4,%esp
  801327:	68 0c 35 80 00       	push   $0x80350c
  80132c:	68 49 01 00 00       	push   $0x149
  801331:	68 fc 33 80 00       	push   $0x8033fc
  801336:	e8 d1 03 00 00       	call   80170c <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80133b:	e8 43 19 00 00       	call   802c83 <sys_calculate_free_frames>
  801340:	89 c2                	mov    %eax,%edx
  801342:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801348:	29 c2                	sub    %eax,%edx
  80134a:	89 d0                	mov    %edx,%eax
  80134c:	83 f8 02             	cmp    $0x2,%eax
  80134f:	74 17                	je     801368 <_main+0x1330>
  801351:	83 ec 04             	sub    $0x4,%esp
  801354:	68 48 35 80 00       	push   $0x803548
  801359:	68 4a 01 00 00       	push   $0x14a
  80135e:	68 fc 33 80 00       	push   $0x8033fc
  801363:	e8 a4 03 00 00       	call   80170c <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(intArr[0]));
  801368:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80136b:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
		tmp_addresses[1] = (uint32)(&(intArr[lastIndexOfInt]));
  801371:	8b 45 90             	mov    -0x70(%ebp),%eax
  801374:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80137b:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80137e:	01 d0                	add    %edx,%eax
  801380:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801386:	83 ec 08             	sub    $0x8,%esp
  801389:	6a 02                	push   $0x2
  80138b:	8d 85 c8 fe ff ff    	lea    -0x138(%ebp),%eax
  801391:	50                   	push   %eax
  801392:	e8 c0 1d 00 00       	call   803157 <sys_check_LRU_lists_free>
  801397:	83 c4 10             	add    $0x10,%esp
  80139a:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		if(check != 0)
  8013a0:	83 bd 24 ff ff ff 00 	cmpl   $0x0,-0xdc(%ebp)
  8013a7:	74 17                	je     8013c0 <_main+0x1388>
		{
				panic("free: page is not removed from LRU lists");
  8013a9:	83 ec 04             	sub    $0x4,%esp
  8013ac:	68 94 35 80 00       	push   $0x803594
  8013b1:	68 58 01 00 00       	push   $0x158
  8013b6:	68 fc 33 80 00       	push   $0x8033fc
  8013bb:	e8 4c 03 00 00       	call   80170c <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 794 && LIST_SIZE(&myEnv->SecondList) != 0)
  8013c0:	a1 20 40 80 00       	mov    0x804020,%eax
  8013c5:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8013cb:	3d 1a 03 00 00       	cmp    $0x31a,%eax
  8013d0:	74 26                	je     8013f8 <_main+0x13c0>
  8013d2:	a1 20 40 80 00       	mov    0x804020,%eax
  8013d7:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8013dd:	85 c0                	test   %eax,%eax
  8013df:	74 17                	je     8013f8 <_main+0x13c0>
		{
			panic("LRU lists content is not correct");
  8013e1:	83 ec 04             	sub    $0x4,%esp
  8013e4:	68 c0 35 80 00       	push   $0x8035c0
  8013e9:	68 5d 01 00 00       	push   $0x15d
  8013ee:	68 fc 33 80 00       	push   $0x8033fc
  8013f3:	e8 14 03 00 00       	call   80170c <_panic>
		}

		//Free 2nd 3 KB
		freeFrames = sys_calculate_free_frames() ;
  8013f8:	e8 86 18 00 00       	call   802c83 <sys_calculate_free_frames>
  8013fd:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801403:	e8 fe 18 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  801408:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
		free(ptr_allocations[3]);
  80140e:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  801414:	83 ec 0c             	sub    $0xc,%esp
  801417:	50                   	push   %eax
  801418:	e8 58 14 00 00       	call   802875 <free>
  80141d:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  801420:	e8 e1 18 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  801425:	8b 95 28 ff ff ff    	mov    -0xd8(%ebp),%edx
  80142b:	29 c2                	sub    %eax,%edx
  80142d:	89 d0                	mov    %edx,%eax
  80142f:	83 f8 01             	cmp    $0x1,%eax
  801432:	74 17                	je     80144b <_main+0x1413>
  801434:	83 ec 04             	sub    $0x4,%esp
  801437:	68 0c 35 80 00       	push   $0x80350c
  80143c:	68 64 01 00 00       	push   $0x164
  801441:	68 fc 33 80 00       	push   $0x8033fc
  801446:	e8 c1 02 00 00       	call   80170c <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80144b:	e8 33 18 00 00       	call   802c83 <sys_calculate_free_frames>
  801450:	89 c2                	mov    %eax,%edx
  801452:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801458:	39 c2                	cmp    %eax,%edx
  80145a:	74 17                	je     801473 <_main+0x143b>
  80145c:	83 ec 04             	sub    $0x4,%esp
  80145f:	68 48 35 80 00       	push   $0x803548
  801464:	68 65 01 00 00       	push   $0x165
  801469:	68 fc 33 80 00       	push   $0x8033fc
  80146e:	e8 99 02 00 00       	call   80170c <_panic>

		//Free last 14 KB
		freeFrames = sys_calculate_free_frames() ;
  801473:	e8 0b 18 00 00       	call   802c83 <sys_calculate_free_frames>
  801478:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80147e:	e8 83 18 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  801483:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
		free(ptr_allocations[7]);
  801489:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  80148f:	83 ec 0c             	sub    $0xc,%esp
  801492:	50                   	push   %eax
  801493:	e8 dd 13 00 00       	call   802875 <free>
  801498:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
  80149b:	e8 66 18 00 00       	call   802d06 <sys_pf_calculate_allocated_pages>
  8014a0:	8b 95 28 ff ff ff    	mov    -0xd8(%ebp),%edx
  8014a6:	29 c2                	sub    %eax,%edx
  8014a8:	89 d0                	mov    %edx,%eax
  8014aa:	83 f8 04             	cmp    $0x4,%eax
  8014ad:	74 17                	je     8014c6 <_main+0x148e>
  8014af:	83 ec 04             	sub    $0x4,%esp
  8014b2:	68 0c 35 80 00       	push   $0x80350c
  8014b7:	68 6b 01 00 00       	push   $0x16b
  8014bc:	68 fc 33 80 00       	push   $0x8033fc
  8014c1:	e8 46 02 00 00       	call   80170c <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8014c6:	e8 b8 17 00 00       	call   802c83 <sys_calculate_free_frames>
  8014cb:	89 c2                	mov    %eax,%edx
  8014cd:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  8014d3:	29 c2                	sub    %eax,%edx
  8014d5:	89 d0                	mov    %edx,%eax
  8014d7:	83 f8 03             	cmp    $0x3,%eax
  8014da:	74 17                	je     8014f3 <_main+0x14bb>
  8014dc:	83 ec 04             	sub    $0x4,%esp
  8014df:	68 48 35 80 00       	push   $0x803548
  8014e4:	68 6c 01 00 00       	push   $0x16c
  8014e9:	68 fc 33 80 00       	push   $0x8033fc
  8014ee:	e8 19 02 00 00       	call   80170c <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(shortArr2[0]));
  8014f3:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  8014f9:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
		tmp_addresses[1] = (uint32)(&(shortArr2[lastIndexOfShort2]));
  8014ff:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  801505:	01 c0                	add    %eax,%eax
  801507:	89 c2                	mov    %eax,%edx
  801509:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  80150f:	01 d0                	add    %edx,%eax
  801511:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801517:	83 ec 08             	sub    $0x8,%esp
  80151a:	6a 02                	push   $0x2
  80151c:	8d 85 c8 fe ff ff    	lea    -0x138(%ebp),%eax
  801522:	50                   	push   %eax
  801523:	e8 2f 1c 00 00       	call   803157 <sys_check_LRU_lists_free>
  801528:	83 c4 10             	add    $0x10,%esp
  80152b:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		if(check != 0)
  801531:	83 bd 24 ff ff ff 00 	cmpl   $0x0,-0xdc(%ebp)
  801538:	74 17                	je     801551 <_main+0x1519>
		{
				panic("free: page is not removed from LRU lists");
  80153a:	83 ec 04             	sub    $0x4,%esp
  80153d:	68 94 35 80 00       	push   $0x803594
  801542:	68 7a 01 00 00       	push   $0x17a
  801547:	68 fc 33 80 00       	push   $0x8033fc
  80154c:	e8 bb 01 00 00       	call   80170c <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 792 && LIST_SIZE(&myEnv->SecondList) != 0)
  801551:	a1 20 40 80 00       	mov    0x804020,%eax
  801556:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  80155c:	3d 18 03 00 00       	cmp    $0x318,%eax
  801561:	74 26                	je     801589 <_main+0x1551>
  801563:	a1 20 40 80 00       	mov    0x804020,%eax
  801568:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  80156e:	85 c0                	test   %eax,%eax
  801570:	74 17                	je     801589 <_main+0x1551>
		{
			panic("LRU lists content is not correct");
  801572:	83 ec 04             	sub    $0x4,%esp
  801575:	68 c0 35 80 00       	push   $0x8035c0
  80157a:	68 7f 01 00 00       	push   $0x17f
  80157f:	68 fc 33 80 00       	push   $0x8033fc
  801584:	e8 83 01 00 00       	call   80170c <_panic>
		}

			if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
  801589:	e8 f5 16 00 00       	call   802c83 <sys_calculate_free_frames>
  80158e:	8d 50 04             	lea    0x4(%eax),%edx
  801591:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801594:	39 c2                	cmp    %eax,%edx
  801596:	74 17                	je     8015af <_main+0x1577>
  801598:	83 ec 04             	sub    $0x4,%esp
  80159b:	68 e4 35 80 00       	push   $0x8035e4
  8015a0:	68 82 01 00 00       	push   $0x182
  8015a5:	68 fc 33 80 00       	push   $0x8033fc
  8015aa:	e8 5d 01 00 00       	call   80170c <_panic>
		}

		cprintf("Congratulations!! test free [1] completed successfully.\n");
  8015af:	83 ec 0c             	sub    $0xc,%esp
  8015b2:	68 18 36 80 00       	push   $0x803618
  8015b7:	e8 f2 03 00 00       	call   8019ae <cprintf>
  8015bc:	83 c4 10             	add    $0x10,%esp

	return;
  8015bf:	90                   	nop
}
  8015c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015c3:	5b                   	pop    %ebx
  8015c4:	5f                   	pop    %edi
  8015c5:	5d                   	pop    %ebp
  8015c6:	c3                   	ret    

008015c7 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
  8015ca:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8015cd:	e8 e6 15 00 00       	call   802bb8 <sys_getenvindex>
  8015d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8015d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015d8:	89 d0                	mov    %edx,%eax
  8015da:	c1 e0 03             	shl    $0x3,%eax
  8015dd:	01 d0                	add    %edx,%eax
  8015df:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8015e6:	01 c8                	add    %ecx,%eax
  8015e8:	01 c0                	add    %eax,%eax
  8015ea:	01 d0                	add    %edx,%eax
  8015ec:	01 c0                	add    %eax,%eax
  8015ee:	01 d0                	add    %edx,%eax
  8015f0:	89 c2                	mov    %eax,%edx
  8015f2:	c1 e2 05             	shl    $0x5,%edx
  8015f5:	29 c2                	sub    %eax,%edx
  8015f7:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8015fe:	89 c2                	mov    %eax,%edx
  801600:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  801606:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80160b:	a1 20 40 80 00       	mov    0x804020,%eax
  801610:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  801616:	84 c0                	test   %al,%al
  801618:	74 0f                	je     801629 <libmain+0x62>
		binaryname = myEnv->prog_name;
  80161a:	a1 20 40 80 00       	mov    0x804020,%eax
  80161f:	05 40 3c 01 00       	add    $0x13c40,%eax
  801624:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  801629:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80162d:	7e 0a                	jle    801639 <libmain+0x72>
		binaryname = argv[0];
  80162f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801632:	8b 00                	mov    (%eax),%eax
  801634:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  801639:	83 ec 08             	sub    $0x8,%esp
  80163c:	ff 75 0c             	pushl  0xc(%ebp)
  80163f:	ff 75 08             	pushl  0x8(%ebp)
  801642:	e8 f1 e9 ff ff       	call   800038 <_main>
  801647:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80164a:	e8 04 17 00 00       	call   802d53 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80164f:	83 ec 0c             	sub    $0xc,%esp
  801652:	68 6c 36 80 00       	push   $0x80366c
  801657:	e8 52 03 00 00       	call   8019ae <cprintf>
  80165c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80165f:	a1 20 40 80 00       	mov    0x804020,%eax
  801664:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80166a:	a1 20 40 80 00       	mov    0x804020,%eax
  80166f:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  801675:	83 ec 04             	sub    $0x4,%esp
  801678:	52                   	push   %edx
  801679:	50                   	push   %eax
  80167a:	68 94 36 80 00       	push   $0x803694
  80167f:	e8 2a 03 00 00       	call   8019ae <cprintf>
  801684:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  801687:	a1 20 40 80 00       	mov    0x804020,%eax
  80168c:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  801692:	a1 20 40 80 00       	mov    0x804020,%eax
  801697:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80169d:	83 ec 04             	sub    $0x4,%esp
  8016a0:	52                   	push   %edx
  8016a1:	50                   	push   %eax
  8016a2:	68 bc 36 80 00       	push   $0x8036bc
  8016a7:	e8 02 03 00 00       	call   8019ae <cprintf>
  8016ac:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8016af:	a1 20 40 80 00       	mov    0x804020,%eax
  8016b4:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8016ba:	83 ec 08             	sub    $0x8,%esp
  8016bd:	50                   	push   %eax
  8016be:	68 fd 36 80 00       	push   $0x8036fd
  8016c3:	e8 e6 02 00 00       	call   8019ae <cprintf>
  8016c8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8016cb:	83 ec 0c             	sub    $0xc,%esp
  8016ce:	68 6c 36 80 00       	push   $0x80366c
  8016d3:	e8 d6 02 00 00       	call   8019ae <cprintf>
  8016d8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8016db:	e8 8d 16 00 00       	call   802d6d <sys_enable_interrupt>

	// exit gracefully
	exit();
  8016e0:	e8 19 00 00 00       	call   8016fe <exit>
}
  8016e5:	90                   	nop
  8016e6:	c9                   	leave  
  8016e7:	c3                   	ret    

008016e8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8016e8:	55                   	push   %ebp
  8016e9:	89 e5                	mov    %esp,%ebp
  8016eb:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8016ee:	83 ec 0c             	sub    $0xc,%esp
  8016f1:	6a 00                	push   $0x0
  8016f3:	e8 8c 14 00 00       	call   802b84 <sys_env_destroy>
  8016f8:	83 c4 10             	add    $0x10,%esp
}
  8016fb:	90                   	nop
  8016fc:	c9                   	leave  
  8016fd:	c3                   	ret    

008016fe <exit>:

void
exit(void)
{
  8016fe:	55                   	push   %ebp
  8016ff:	89 e5                	mov    %esp,%ebp
  801701:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  801704:	e8 e1 14 00 00       	call   802bea <sys_env_exit>
}
  801709:	90                   	nop
  80170a:	c9                   	leave  
  80170b:	c3                   	ret    

0080170c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80170c:	55                   	push   %ebp
  80170d:	89 e5                	mov    %esp,%ebp
  80170f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801712:	8d 45 10             	lea    0x10(%ebp),%eax
  801715:	83 c0 04             	add    $0x4,%eax
  801718:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80171b:	a1 18 41 80 00       	mov    0x804118,%eax
  801720:	85 c0                	test   %eax,%eax
  801722:	74 16                	je     80173a <_panic+0x2e>
		cprintf("%s: ", argv0);
  801724:	a1 18 41 80 00       	mov    0x804118,%eax
  801729:	83 ec 08             	sub    $0x8,%esp
  80172c:	50                   	push   %eax
  80172d:	68 14 37 80 00       	push   $0x803714
  801732:	e8 77 02 00 00       	call   8019ae <cprintf>
  801737:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80173a:	a1 00 40 80 00       	mov    0x804000,%eax
  80173f:	ff 75 0c             	pushl  0xc(%ebp)
  801742:	ff 75 08             	pushl  0x8(%ebp)
  801745:	50                   	push   %eax
  801746:	68 19 37 80 00       	push   $0x803719
  80174b:	e8 5e 02 00 00       	call   8019ae <cprintf>
  801750:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801753:	8b 45 10             	mov    0x10(%ebp),%eax
  801756:	83 ec 08             	sub    $0x8,%esp
  801759:	ff 75 f4             	pushl  -0xc(%ebp)
  80175c:	50                   	push   %eax
  80175d:	e8 e1 01 00 00       	call   801943 <vcprintf>
  801762:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801765:	83 ec 08             	sub    $0x8,%esp
  801768:	6a 00                	push   $0x0
  80176a:	68 35 37 80 00       	push   $0x803735
  80176f:	e8 cf 01 00 00       	call   801943 <vcprintf>
  801774:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801777:	e8 82 ff ff ff       	call   8016fe <exit>

	// should not return here
	while (1) ;
  80177c:	eb fe                	jmp    80177c <_panic+0x70>

0080177e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
  801781:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801784:	a1 20 40 80 00       	mov    0x804020,%eax
  801789:	8b 50 74             	mov    0x74(%eax),%edx
  80178c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178f:	39 c2                	cmp    %eax,%edx
  801791:	74 14                	je     8017a7 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801793:	83 ec 04             	sub    $0x4,%esp
  801796:	68 38 37 80 00       	push   $0x803738
  80179b:	6a 26                	push   $0x26
  80179d:	68 84 37 80 00       	push   $0x803784
  8017a2:	e8 65 ff ff ff       	call   80170c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8017a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8017ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8017b5:	e9 b6 00 00 00       	jmp    801870 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8017ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c7:	01 d0                	add    %edx,%eax
  8017c9:	8b 00                	mov    (%eax),%eax
  8017cb:	85 c0                	test   %eax,%eax
  8017cd:	75 08                	jne    8017d7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8017cf:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8017d2:	e9 96 00 00 00       	jmp    80186d <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8017d7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8017de:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8017e5:	eb 5d                	jmp    801844 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8017e7:	a1 20 40 80 00       	mov    0x804020,%eax
  8017ec:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8017f2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8017f5:	c1 e2 04             	shl    $0x4,%edx
  8017f8:	01 d0                	add    %edx,%eax
  8017fa:	8a 40 04             	mov    0x4(%eax),%al
  8017fd:	84 c0                	test   %al,%al
  8017ff:	75 40                	jne    801841 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801801:	a1 20 40 80 00       	mov    0x804020,%eax
  801806:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80180c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80180f:	c1 e2 04             	shl    $0x4,%edx
  801812:	01 d0                	add    %edx,%eax
  801814:	8b 00                	mov    (%eax),%eax
  801816:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801819:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80181c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801821:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801823:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801826:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80182d:	8b 45 08             	mov    0x8(%ebp),%eax
  801830:	01 c8                	add    %ecx,%eax
  801832:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801834:	39 c2                	cmp    %eax,%edx
  801836:	75 09                	jne    801841 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801838:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80183f:	eb 12                	jmp    801853 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801841:	ff 45 e8             	incl   -0x18(%ebp)
  801844:	a1 20 40 80 00       	mov    0x804020,%eax
  801849:	8b 50 74             	mov    0x74(%eax),%edx
  80184c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80184f:	39 c2                	cmp    %eax,%edx
  801851:	77 94                	ja     8017e7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801853:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801857:	75 14                	jne    80186d <CheckWSWithoutLastIndex+0xef>
			panic(
  801859:	83 ec 04             	sub    $0x4,%esp
  80185c:	68 90 37 80 00       	push   $0x803790
  801861:	6a 3a                	push   $0x3a
  801863:	68 84 37 80 00       	push   $0x803784
  801868:	e8 9f fe ff ff       	call   80170c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80186d:	ff 45 f0             	incl   -0x10(%ebp)
  801870:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801873:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801876:	0f 8c 3e ff ff ff    	jl     8017ba <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80187c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801883:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80188a:	eb 20                	jmp    8018ac <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80188c:	a1 20 40 80 00       	mov    0x804020,%eax
  801891:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801897:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80189a:	c1 e2 04             	shl    $0x4,%edx
  80189d:	01 d0                	add    %edx,%eax
  80189f:	8a 40 04             	mov    0x4(%eax),%al
  8018a2:	3c 01                	cmp    $0x1,%al
  8018a4:	75 03                	jne    8018a9 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8018a6:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018a9:	ff 45 e0             	incl   -0x20(%ebp)
  8018ac:	a1 20 40 80 00       	mov    0x804020,%eax
  8018b1:	8b 50 74             	mov    0x74(%eax),%edx
  8018b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018b7:	39 c2                	cmp    %eax,%edx
  8018b9:	77 d1                	ja     80188c <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8018bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018be:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8018c1:	74 14                	je     8018d7 <CheckWSWithoutLastIndex+0x159>
		panic(
  8018c3:	83 ec 04             	sub    $0x4,%esp
  8018c6:	68 e4 37 80 00       	push   $0x8037e4
  8018cb:	6a 44                	push   $0x44
  8018cd:	68 84 37 80 00       	push   $0x803784
  8018d2:	e8 35 fe ff ff       	call   80170c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8018d7:	90                   	nop
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
  8018dd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8018e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e3:	8b 00                	mov    (%eax),%eax
  8018e5:	8d 48 01             	lea    0x1(%eax),%ecx
  8018e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018eb:	89 0a                	mov    %ecx,(%edx)
  8018ed:	8b 55 08             	mov    0x8(%ebp),%edx
  8018f0:	88 d1                	mov    %dl,%cl
  8018f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8018f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018fc:	8b 00                	mov    (%eax),%eax
  8018fe:	3d ff 00 00 00       	cmp    $0xff,%eax
  801903:	75 2c                	jne    801931 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801905:	a0 24 40 80 00       	mov    0x804024,%al
  80190a:	0f b6 c0             	movzbl %al,%eax
  80190d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801910:	8b 12                	mov    (%edx),%edx
  801912:	89 d1                	mov    %edx,%ecx
  801914:	8b 55 0c             	mov    0xc(%ebp),%edx
  801917:	83 c2 08             	add    $0x8,%edx
  80191a:	83 ec 04             	sub    $0x4,%esp
  80191d:	50                   	push   %eax
  80191e:	51                   	push   %ecx
  80191f:	52                   	push   %edx
  801920:	e8 1d 12 00 00       	call   802b42 <sys_cputs>
  801925:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801928:	8b 45 0c             	mov    0xc(%ebp),%eax
  80192b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801931:	8b 45 0c             	mov    0xc(%ebp),%eax
  801934:	8b 40 04             	mov    0x4(%eax),%eax
  801937:	8d 50 01             	lea    0x1(%eax),%edx
  80193a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80193d:	89 50 04             	mov    %edx,0x4(%eax)
}
  801940:	90                   	nop
  801941:	c9                   	leave  
  801942:	c3                   	ret    

00801943 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801943:	55                   	push   %ebp
  801944:	89 e5                	mov    %esp,%ebp
  801946:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80194c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801953:	00 00 00 
	b.cnt = 0;
  801956:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80195d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801960:	ff 75 0c             	pushl  0xc(%ebp)
  801963:	ff 75 08             	pushl  0x8(%ebp)
  801966:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80196c:	50                   	push   %eax
  80196d:	68 da 18 80 00       	push   $0x8018da
  801972:	e8 11 02 00 00       	call   801b88 <vprintfmt>
  801977:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80197a:	a0 24 40 80 00       	mov    0x804024,%al
  80197f:	0f b6 c0             	movzbl %al,%eax
  801982:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801988:	83 ec 04             	sub    $0x4,%esp
  80198b:	50                   	push   %eax
  80198c:	52                   	push   %edx
  80198d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801993:	83 c0 08             	add    $0x8,%eax
  801996:	50                   	push   %eax
  801997:	e8 a6 11 00 00       	call   802b42 <sys_cputs>
  80199c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80199f:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  8019a6:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8019ac:	c9                   	leave  
  8019ad:	c3                   	ret    

008019ae <cprintf>:

int cprintf(const char *fmt, ...) {
  8019ae:	55                   	push   %ebp
  8019af:	89 e5                	mov    %esp,%ebp
  8019b1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8019b4:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  8019bb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8019be:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8019c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c4:	83 ec 08             	sub    $0x8,%esp
  8019c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8019ca:	50                   	push   %eax
  8019cb:	e8 73 ff ff ff       	call   801943 <vcprintf>
  8019d0:	83 c4 10             	add    $0x10,%esp
  8019d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8019d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8019d9:	c9                   	leave  
  8019da:	c3                   	ret    

008019db <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8019db:	55                   	push   %ebp
  8019dc:	89 e5                	mov    %esp,%ebp
  8019de:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8019e1:	e8 6d 13 00 00       	call   802d53 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8019e6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8019e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8019ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ef:	83 ec 08             	sub    $0x8,%esp
  8019f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8019f5:	50                   	push   %eax
  8019f6:	e8 48 ff ff ff       	call   801943 <vcprintf>
  8019fb:	83 c4 10             	add    $0x10,%esp
  8019fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801a01:	e8 67 13 00 00       	call   802d6d <sys_enable_interrupt>
	return cnt;
  801a06:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a09:	c9                   	leave  
  801a0a:	c3                   	ret    

00801a0b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801a0b:	55                   	push   %ebp
  801a0c:	89 e5                	mov    %esp,%ebp
  801a0e:	53                   	push   %ebx
  801a0f:	83 ec 14             	sub    $0x14,%esp
  801a12:	8b 45 10             	mov    0x10(%ebp),%eax
  801a15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a18:	8b 45 14             	mov    0x14(%ebp),%eax
  801a1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801a1e:	8b 45 18             	mov    0x18(%ebp),%eax
  801a21:	ba 00 00 00 00       	mov    $0x0,%edx
  801a26:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801a29:	77 55                	ja     801a80 <printnum+0x75>
  801a2b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801a2e:	72 05                	jb     801a35 <printnum+0x2a>
  801a30:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a33:	77 4b                	ja     801a80 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801a35:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801a38:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801a3b:	8b 45 18             	mov    0x18(%ebp),%eax
  801a3e:	ba 00 00 00 00       	mov    $0x0,%edx
  801a43:	52                   	push   %edx
  801a44:	50                   	push   %eax
  801a45:	ff 75 f4             	pushl  -0xc(%ebp)
  801a48:	ff 75 f0             	pushl  -0x10(%ebp)
  801a4b:	e8 24 17 00 00       	call   803174 <__udivdi3>
  801a50:	83 c4 10             	add    $0x10,%esp
  801a53:	83 ec 04             	sub    $0x4,%esp
  801a56:	ff 75 20             	pushl  0x20(%ebp)
  801a59:	53                   	push   %ebx
  801a5a:	ff 75 18             	pushl  0x18(%ebp)
  801a5d:	52                   	push   %edx
  801a5e:	50                   	push   %eax
  801a5f:	ff 75 0c             	pushl  0xc(%ebp)
  801a62:	ff 75 08             	pushl  0x8(%ebp)
  801a65:	e8 a1 ff ff ff       	call   801a0b <printnum>
  801a6a:	83 c4 20             	add    $0x20,%esp
  801a6d:	eb 1a                	jmp    801a89 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801a6f:	83 ec 08             	sub    $0x8,%esp
  801a72:	ff 75 0c             	pushl  0xc(%ebp)
  801a75:	ff 75 20             	pushl  0x20(%ebp)
  801a78:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7b:	ff d0                	call   *%eax
  801a7d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801a80:	ff 4d 1c             	decl   0x1c(%ebp)
  801a83:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801a87:	7f e6                	jg     801a6f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801a89:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801a8c:	bb 00 00 00 00       	mov    $0x0,%ebx
  801a91:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a94:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a97:	53                   	push   %ebx
  801a98:	51                   	push   %ecx
  801a99:	52                   	push   %edx
  801a9a:	50                   	push   %eax
  801a9b:	e8 e4 17 00 00       	call   803284 <__umoddi3>
  801aa0:	83 c4 10             	add    $0x10,%esp
  801aa3:	05 54 3a 80 00       	add    $0x803a54,%eax
  801aa8:	8a 00                	mov    (%eax),%al
  801aaa:	0f be c0             	movsbl %al,%eax
  801aad:	83 ec 08             	sub    $0x8,%esp
  801ab0:	ff 75 0c             	pushl  0xc(%ebp)
  801ab3:	50                   	push   %eax
  801ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab7:	ff d0                	call   *%eax
  801ab9:	83 c4 10             	add    $0x10,%esp
}
  801abc:	90                   	nop
  801abd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801ac0:	c9                   	leave  
  801ac1:	c3                   	ret    

00801ac2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801ac2:	55                   	push   %ebp
  801ac3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801ac5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801ac9:	7e 1c                	jle    801ae7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801acb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ace:	8b 00                	mov    (%eax),%eax
  801ad0:	8d 50 08             	lea    0x8(%eax),%edx
  801ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad6:	89 10                	mov    %edx,(%eax)
  801ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  801adb:	8b 00                	mov    (%eax),%eax
  801add:	83 e8 08             	sub    $0x8,%eax
  801ae0:	8b 50 04             	mov    0x4(%eax),%edx
  801ae3:	8b 00                	mov    (%eax),%eax
  801ae5:	eb 40                	jmp    801b27 <getuint+0x65>
	else if (lflag)
  801ae7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801aeb:	74 1e                	je     801b0b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801aed:	8b 45 08             	mov    0x8(%ebp),%eax
  801af0:	8b 00                	mov    (%eax),%eax
  801af2:	8d 50 04             	lea    0x4(%eax),%edx
  801af5:	8b 45 08             	mov    0x8(%ebp),%eax
  801af8:	89 10                	mov    %edx,(%eax)
  801afa:	8b 45 08             	mov    0x8(%ebp),%eax
  801afd:	8b 00                	mov    (%eax),%eax
  801aff:	83 e8 04             	sub    $0x4,%eax
  801b02:	8b 00                	mov    (%eax),%eax
  801b04:	ba 00 00 00 00       	mov    $0x0,%edx
  801b09:	eb 1c                	jmp    801b27 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0e:	8b 00                	mov    (%eax),%eax
  801b10:	8d 50 04             	lea    0x4(%eax),%edx
  801b13:	8b 45 08             	mov    0x8(%ebp),%eax
  801b16:	89 10                	mov    %edx,(%eax)
  801b18:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1b:	8b 00                	mov    (%eax),%eax
  801b1d:	83 e8 04             	sub    $0x4,%eax
  801b20:	8b 00                	mov    (%eax),%eax
  801b22:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801b27:	5d                   	pop    %ebp
  801b28:	c3                   	ret    

00801b29 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801b29:	55                   	push   %ebp
  801b2a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801b2c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801b30:	7e 1c                	jle    801b4e <getint+0x25>
		return va_arg(*ap, long long);
  801b32:	8b 45 08             	mov    0x8(%ebp),%eax
  801b35:	8b 00                	mov    (%eax),%eax
  801b37:	8d 50 08             	lea    0x8(%eax),%edx
  801b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3d:	89 10                	mov    %edx,(%eax)
  801b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b42:	8b 00                	mov    (%eax),%eax
  801b44:	83 e8 08             	sub    $0x8,%eax
  801b47:	8b 50 04             	mov    0x4(%eax),%edx
  801b4a:	8b 00                	mov    (%eax),%eax
  801b4c:	eb 38                	jmp    801b86 <getint+0x5d>
	else if (lflag)
  801b4e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801b52:	74 1a                	je     801b6e <getint+0x45>
		return va_arg(*ap, long);
  801b54:	8b 45 08             	mov    0x8(%ebp),%eax
  801b57:	8b 00                	mov    (%eax),%eax
  801b59:	8d 50 04             	lea    0x4(%eax),%edx
  801b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5f:	89 10                	mov    %edx,(%eax)
  801b61:	8b 45 08             	mov    0x8(%ebp),%eax
  801b64:	8b 00                	mov    (%eax),%eax
  801b66:	83 e8 04             	sub    $0x4,%eax
  801b69:	8b 00                	mov    (%eax),%eax
  801b6b:	99                   	cltd   
  801b6c:	eb 18                	jmp    801b86 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b71:	8b 00                	mov    (%eax),%eax
  801b73:	8d 50 04             	lea    0x4(%eax),%edx
  801b76:	8b 45 08             	mov    0x8(%ebp),%eax
  801b79:	89 10                	mov    %edx,(%eax)
  801b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7e:	8b 00                	mov    (%eax),%eax
  801b80:	83 e8 04             	sub    $0x4,%eax
  801b83:	8b 00                	mov    (%eax),%eax
  801b85:	99                   	cltd   
}
  801b86:	5d                   	pop    %ebp
  801b87:	c3                   	ret    

00801b88 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801b88:	55                   	push   %ebp
  801b89:	89 e5                	mov    %esp,%ebp
  801b8b:	56                   	push   %esi
  801b8c:	53                   	push   %ebx
  801b8d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801b90:	eb 17                	jmp    801ba9 <vprintfmt+0x21>
			if (ch == '\0')
  801b92:	85 db                	test   %ebx,%ebx
  801b94:	0f 84 af 03 00 00    	je     801f49 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801b9a:	83 ec 08             	sub    $0x8,%esp
  801b9d:	ff 75 0c             	pushl  0xc(%ebp)
  801ba0:	53                   	push   %ebx
  801ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba4:	ff d0                	call   *%eax
  801ba6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801ba9:	8b 45 10             	mov    0x10(%ebp),%eax
  801bac:	8d 50 01             	lea    0x1(%eax),%edx
  801baf:	89 55 10             	mov    %edx,0x10(%ebp)
  801bb2:	8a 00                	mov    (%eax),%al
  801bb4:	0f b6 d8             	movzbl %al,%ebx
  801bb7:	83 fb 25             	cmp    $0x25,%ebx
  801bba:	75 d6                	jne    801b92 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801bbc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801bc0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801bc7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801bce:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801bd5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801bdc:	8b 45 10             	mov    0x10(%ebp),%eax
  801bdf:	8d 50 01             	lea    0x1(%eax),%edx
  801be2:	89 55 10             	mov    %edx,0x10(%ebp)
  801be5:	8a 00                	mov    (%eax),%al
  801be7:	0f b6 d8             	movzbl %al,%ebx
  801bea:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801bed:	83 f8 55             	cmp    $0x55,%eax
  801bf0:	0f 87 2b 03 00 00    	ja     801f21 <vprintfmt+0x399>
  801bf6:	8b 04 85 78 3a 80 00 	mov    0x803a78(,%eax,4),%eax
  801bfd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801bff:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801c03:	eb d7                	jmp    801bdc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801c05:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801c09:	eb d1                	jmp    801bdc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801c0b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801c12:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c15:	89 d0                	mov    %edx,%eax
  801c17:	c1 e0 02             	shl    $0x2,%eax
  801c1a:	01 d0                	add    %edx,%eax
  801c1c:	01 c0                	add    %eax,%eax
  801c1e:	01 d8                	add    %ebx,%eax
  801c20:	83 e8 30             	sub    $0x30,%eax
  801c23:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801c26:	8b 45 10             	mov    0x10(%ebp),%eax
  801c29:	8a 00                	mov    (%eax),%al
  801c2b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801c2e:	83 fb 2f             	cmp    $0x2f,%ebx
  801c31:	7e 3e                	jle    801c71 <vprintfmt+0xe9>
  801c33:	83 fb 39             	cmp    $0x39,%ebx
  801c36:	7f 39                	jg     801c71 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801c38:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801c3b:	eb d5                	jmp    801c12 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801c3d:	8b 45 14             	mov    0x14(%ebp),%eax
  801c40:	83 c0 04             	add    $0x4,%eax
  801c43:	89 45 14             	mov    %eax,0x14(%ebp)
  801c46:	8b 45 14             	mov    0x14(%ebp),%eax
  801c49:	83 e8 04             	sub    $0x4,%eax
  801c4c:	8b 00                	mov    (%eax),%eax
  801c4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801c51:	eb 1f                	jmp    801c72 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801c53:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801c57:	79 83                	jns    801bdc <vprintfmt+0x54>
				width = 0;
  801c59:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801c60:	e9 77 ff ff ff       	jmp    801bdc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801c65:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801c6c:	e9 6b ff ff ff       	jmp    801bdc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801c71:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801c72:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801c76:	0f 89 60 ff ff ff    	jns    801bdc <vprintfmt+0x54>
				width = precision, precision = -1;
  801c7c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c7f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801c82:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801c89:	e9 4e ff ff ff       	jmp    801bdc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801c8e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801c91:	e9 46 ff ff ff       	jmp    801bdc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801c96:	8b 45 14             	mov    0x14(%ebp),%eax
  801c99:	83 c0 04             	add    $0x4,%eax
  801c9c:	89 45 14             	mov    %eax,0x14(%ebp)
  801c9f:	8b 45 14             	mov    0x14(%ebp),%eax
  801ca2:	83 e8 04             	sub    $0x4,%eax
  801ca5:	8b 00                	mov    (%eax),%eax
  801ca7:	83 ec 08             	sub    $0x8,%esp
  801caa:	ff 75 0c             	pushl  0xc(%ebp)
  801cad:	50                   	push   %eax
  801cae:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb1:	ff d0                	call   *%eax
  801cb3:	83 c4 10             	add    $0x10,%esp
			break;
  801cb6:	e9 89 02 00 00       	jmp    801f44 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801cbb:	8b 45 14             	mov    0x14(%ebp),%eax
  801cbe:	83 c0 04             	add    $0x4,%eax
  801cc1:	89 45 14             	mov    %eax,0x14(%ebp)
  801cc4:	8b 45 14             	mov    0x14(%ebp),%eax
  801cc7:	83 e8 04             	sub    $0x4,%eax
  801cca:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801ccc:	85 db                	test   %ebx,%ebx
  801cce:	79 02                	jns    801cd2 <vprintfmt+0x14a>
				err = -err;
  801cd0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801cd2:	83 fb 64             	cmp    $0x64,%ebx
  801cd5:	7f 0b                	jg     801ce2 <vprintfmt+0x15a>
  801cd7:	8b 34 9d c0 38 80 00 	mov    0x8038c0(,%ebx,4),%esi
  801cde:	85 f6                	test   %esi,%esi
  801ce0:	75 19                	jne    801cfb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801ce2:	53                   	push   %ebx
  801ce3:	68 65 3a 80 00       	push   $0x803a65
  801ce8:	ff 75 0c             	pushl  0xc(%ebp)
  801ceb:	ff 75 08             	pushl  0x8(%ebp)
  801cee:	e8 5e 02 00 00       	call   801f51 <printfmt>
  801cf3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801cf6:	e9 49 02 00 00       	jmp    801f44 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801cfb:	56                   	push   %esi
  801cfc:	68 6e 3a 80 00       	push   $0x803a6e
  801d01:	ff 75 0c             	pushl  0xc(%ebp)
  801d04:	ff 75 08             	pushl  0x8(%ebp)
  801d07:	e8 45 02 00 00       	call   801f51 <printfmt>
  801d0c:	83 c4 10             	add    $0x10,%esp
			break;
  801d0f:	e9 30 02 00 00       	jmp    801f44 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801d14:	8b 45 14             	mov    0x14(%ebp),%eax
  801d17:	83 c0 04             	add    $0x4,%eax
  801d1a:	89 45 14             	mov    %eax,0x14(%ebp)
  801d1d:	8b 45 14             	mov    0x14(%ebp),%eax
  801d20:	83 e8 04             	sub    $0x4,%eax
  801d23:	8b 30                	mov    (%eax),%esi
  801d25:	85 f6                	test   %esi,%esi
  801d27:	75 05                	jne    801d2e <vprintfmt+0x1a6>
				p = "(null)";
  801d29:	be 71 3a 80 00       	mov    $0x803a71,%esi
			if (width > 0 && padc != '-')
  801d2e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801d32:	7e 6d                	jle    801da1 <vprintfmt+0x219>
  801d34:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801d38:	74 67                	je     801da1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801d3a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d3d:	83 ec 08             	sub    $0x8,%esp
  801d40:	50                   	push   %eax
  801d41:	56                   	push   %esi
  801d42:	e8 0c 03 00 00       	call   802053 <strnlen>
  801d47:	83 c4 10             	add    $0x10,%esp
  801d4a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801d4d:	eb 16                	jmp    801d65 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801d4f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801d53:	83 ec 08             	sub    $0x8,%esp
  801d56:	ff 75 0c             	pushl  0xc(%ebp)
  801d59:	50                   	push   %eax
  801d5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5d:	ff d0                	call   *%eax
  801d5f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801d62:	ff 4d e4             	decl   -0x1c(%ebp)
  801d65:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801d69:	7f e4                	jg     801d4f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801d6b:	eb 34                	jmp    801da1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801d6d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801d71:	74 1c                	je     801d8f <vprintfmt+0x207>
  801d73:	83 fb 1f             	cmp    $0x1f,%ebx
  801d76:	7e 05                	jle    801d7d <vprintfmt+0x1f5>
  801d78:	83 fb 7e             	cmp    $0x7e,%ebx
  801d7b:	7e 12                	jle    801d8f <vprintfmt+0x207>
					putch('?', putdat);
  801d7d:	83 ec 08             	sub    $0x8,%esp
  801d80:	ff 75 0c             	pushl  0xc(%ebp)
  801d83:	6a 3f                	push   $0x3f
  801d85:	8b 45 08             	mov    0x8(%ebp),%eax
  801d88:	ff d0                	call   *%eax
  801d8a:	83 c4 10             	add    $0x10,%esp
  801d8d:	eb 0f                	jmp    801d9e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801d8f:	83 ec 08             	sub    $0x8,%esp
  801d92:	ff 75 0c             	pushl  0xc(%ebp)
  801d95:	53                   	push   %ebx
  801d96:	8b 45 08             	mov    0x8(%ebp),%eax
  801d99:	ff d0                	call   *%eax
  801d9b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801d9e:	ff 4d e4             	decl   -0x1c(%ebp)
  801da1:	89 f0                	mov    %esi,%eax
  801da3:	8d 70 01             	lea    0x1(%eax),%esi
  801da6:	8a 00                	mov    (%eax),%al
  801da8:	0f be d8             	movsbl %al,%ebx
  801dab:	85 db                	test   %ebx,%ebx
  801dad:	74 24                	je     801dd3 <vprintfmt+0x24b>
  801daf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801db3:	78 b8                	js     801d6d <vprintfmt+0x1e5>
  801db5:	ff 4d e0             	decl   -0x20(%ebp)
  801db8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801dbc:	79 af                	jns    801d6d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801dbe:	eb 13                	jmp    801dd3 <vprintfmt+0x24b>
				putch(' ', putdat);
  801dc0:	83 ec 08             	sub    $0x8,%esp
  801dc3:	ff 75 0c             	pushl  0xc(%ebp)
  801dc6:	6a 20                	push   $0x20
  801dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801dcb:	ff d0                	call   *%eax
  801dcd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801dd0:	ff 4d e4             	decl   -0x1c(%ebp)
  801dd3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801dd7:	7f e7                	jg     801dc0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801dd9:	e9 66 01 00 00       	jmp    801f44 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801dde:	83 ec 08             	sub    $0x8,%esp
  801de1:	ff 75 e8             	pushl  -0x18(%ebp)
  801de4:	8d 45 14             	lea    0x14(%ebp),%eax
  801de7:	50                   	push   %eax
  801de8:	e8 3c fd ff ff       	call   801b29 <getint>
  801ded:	83 c4 10             	add    $0x10,%esp
  801df0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801df3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801df6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801df9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801dfc:	85 d2                	test   %edx,%edx
  801dfe:	79 23                	jns    801e23 <vprintfmt+0x29b>
				putch('-', putdat);
  801e00:	83 ec 08             	sub    $0x8,%esp
  801e03:	ff 75 0c             	pushl  0xc(%ebp)
  801e06:	6a 2d                	push   $0x2d
  801e08:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0b:	ff d0                	call   *%eax
  801e0d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801e10:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e13:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e16:	f7 d8                	neg    %eax
  801e18:	83 d2 00             	adc    $0x0,%edx
  801e1b:	f7 da                	neg    %edx
  801e1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e20:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801e23:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801e2a:	e9 bc 00 00 00       	jmp    801eeb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801e2f:	83 ec 08             	sub    $0x8,%esp
  801e32:	ff 75 e8             	pushl  -0x18(%ebp)
  801e35:	8d 45 14             	lea    0x14(%ebp),%eax
  801e38:	50                   	push   %eax
  801e39:	e8 84 fc ff ff       	call   801ac2 <getuint>
  801e3e:	83 c4 10             	add    $0x10,%esp
  801e41:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e44:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801e47:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801e4e:	e9 98 00 00 00       	jmp    801eeb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801e53:	83 ec 08             	sub    $0x8,%esp
  801e56:	ff 75 0c             	pushl  0xc(%ebp)
  801e59:	6a 58                	push   $0x58
  801e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5e:	ff d0                	call   *%eax
  801e60:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801e63:	83 ec 08             	sub    $0x8,%esp
  801e66:	ff 75 0c             	pushl  0xc(%ebp)
  801e69:	6a 58                	push   $0x58
  801e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e6e:	ff d0                	call   *%eax
  801e70:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801e73:	83 ec 08             	sub    $0x8,%esp
  801e76:	ff 75 0c             	pushl  0xc(%ebp)
  801e79:	6a 58                	push   $0x58
  801e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7e:	ff d0                	call   *%eax
  801e80:	83 c4 10             	add    $0x10,%esp
			break;
  801e83:	e9 bc 00 00 00       	jmp    801f44 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801e88:	83 ec 08             	sub    $0x8,%esp
  801e8b:	ff 75 0c             	pushl  0xc(%ebp)
  801e8e:	6a 30                	push   $0x30
  801e90:	8b 45 08             	mov    0x8(%ebp),%eax
  801e93:	ff d0                	call   *%eax
  801e95:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801e98:	83 ec 08             	sub    $0x8,%esp
  801e9b:	ff 75 0c             	pushl  0xc(%ebp)
  801e9e:	6a 78                	push   $0x78
  801ea0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea3:	ff d0                	call   *%eax
  801ea5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801ea8:	8b 45 14             	mov    0x14(%ebp),%eax
  801eab:	83 c0 04             	add    $0x4,%eax
  801eae:	89 45 14             	mov    %eax,0x14(%ebp)
  801eb1:	8b 45 14             	mov    0x14(%ebp),%eax
  801eb4:	83 e8 04             	sub    $0x4,%eax
  801eb7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801eb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ebc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801ec3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801eca:	eb 1f                	jmp    801eeb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801ecc:	83 ec 08             	sub    $0x8,%esp
  801ecf:	ff 75 e8             	pushl  -0x18(%ebp)
  801ed2:	8d 45 14             	lea    0x14(%ebp),%eax
  801ed5:	50                   	push   %eax
  801ed6:	e8 e7 fb ff ff       	call   801ac2 <getuint>
  801edb:	83 c4 10             	add    $0x10,%esp
  801ede:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ee1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801ee4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801eeb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801eef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ef2:	83 ec 04             	sub    $0x4,%esp
  801ef5:	52                   	push   %edx
  801ef6:	ff 75 e4             	pushl  -0x1c(%ebp)
  801ef9:	50                   	push   %eax
  801efa:	ff 75 f4             	pushl  -0xc(%ebp)
  801efd:	ff 75 f0             	pushl  -0x10(%ebp)
  801f00:	ff 75 0c             	pushl  0xc(%ebp)
  801f03:	ff 75 08             	pushl  0x8(%ebp)
  801f06:	e8 00 fb ff ff       	call   801a0b <printnum>
  801f0b:	83 c4 20             	add    $0x20,%esp
			break;
  801f0e:	eb 34                	jmp    801f44 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801f10:	83 ec 08             	sub    $0x8,%esp
  801f13:	ff 75 0c             	pushl  0xc(%ebp)
  801f16:	53                   	push   %ebx
  801f17:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1a:	ff d0                	call   *%eax
  801f1c:	83 c4 10             	add    $0x10,%esp
			break;
  801f1f:	eb 23                	jmp    801f44 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801f21:	83 ec 08             	sub    $0x8,%esp
  801f24:	ff 75 0c             	pushl  0xc(%ebp)
  801f27:	6a 25                	push   $0x25
  801f29:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2c:	ff d0                	call   *%eax
  801f2e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801f31:	ff 4d 10             	decl   0x10(%ebp)
  801f34:	eb 03                	jmp    801f39 <vprintfmt+0x3b1>
  801f36:	ff 4d 10             	decl   0x10(%ebp)
  801f39:	8b 45 10             	mov    0x10(%ebp),%eax
  801f3c:	48                   	dec    %eax
  801f3d:	8a 00                	mov    (%eax),%al
  801f3f:	3c 25                	cmp    $0x25,%al
  801f41:	75 f3                	jne    801f36 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801f43:	90                   	nop
		}
	}
  801f44:	e9 47 fc ff ff       	jmp    801b90 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801f49:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801f4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801f4d:	5b                   	pop    %ebx
  801f4e:	5e                   	pop    %esi
  801f4f:	5d                   	pop    %ebp
  801f50:	c3                   	ret    

00801f51 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801f51:	55                   	push   %ebp
  801f52:	89 e5                	mov    %esp,%ebp
  801f54:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801f57:	8d 45 10             	lea    0x10(%ebp),%eax
  801f5a:	83 c0 04             	add    $0x4,%eax
  801f5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801f60:	8b 45 10             	mov    0x10(%ebp),%eax
  801f63:	ff 75 f4             	pushl  -0xc(%ebp)
  801f66:	50                   	push   %eax
  801f67:	ff 75 0c             	pushl  0xc(%ebp)
  801f6a:	ff 75 08             	pushl  0x8(%ebp)
  801f6d:	e8 16 fc ff ff       	call   801b88 <vprintfmt>
  801f72:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801f75:	90                   	nop
  801f76:	c9                   	leave  
  801f77:	c3                   	ret    

00801f78 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801f78:	55                   	push   %ebp
  801f79:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801f7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f7e:	8b 40 08             	mov    0x8(%eax),%eax
  801f81:	8d 50 01             	lea    0x1(%eax),%edx
  801f84:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f87:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f8d:	8b 10                	mov    (%eax),%edx
  801f8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f92:	8b 40 04             	mov    0x4(%eax),%eax
  801f95:	39 c2                	cmp    %eax,%edx
  801f97:	73 12                	jae    801fab <sprintputch+0x33>
		*b->buf++ = ch;
  801f99:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f9c:	8b 00                	mov    (%eax),%eax
  801f9e:	8d 48 01             	lea    0x1(%eax),%ecx
  801fa1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa4:	89 0a                	mov    %ecx,(%edx)
  801fa6:	8b 55 08             	mov    0x8(%ebp),%edx
  801fa9:	88 10                	mov    %dl,(%eax)
}
  801fab:	90                   	nop
  801fac:	5d                   	pop    %ebp
  801fad:	c3                   	ret    

00801fae <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801fae:	55                   	push   %ebp
  801faf:	89 e5                	mov    %esp,%ebp
  801fb1:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801fba:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fbd:	8d 50 ff             	lea    -0x1(%eax),%edx
  801fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc3:	01 d0                	add    %edx,%eax
  801fc5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801fc8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801fcf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801fd3:	74 06                	je     801fdb <vsnprintf+0x2d>
  801fd5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801fd9:	7f 07                	jg     801fe2 <vsnprintf+0x34>
		return -E_INVAL;
  801fdb:	b8 03 00 00 00       	mov    $0x3,%eax
  801fe0:	eb 20                	jmp    802002 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801fe2:	ff 75 14             	pushl  0x14(%ebp)
  801fe5:	ff 75 10             	pushl  0x10(%ebp)
  801fe8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801feb:	50                   	push   %eax
  801fec:	68 78 1f 80 00       	push   $0x801f78
  801ff1:	e8 92 fb ff ff       	call   801b88 <vprintfmt>
  801ff6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801ff9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ffc:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801fff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  802002:	c9                   	leave  
  802003:	c3                   	ret    

00802004 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  802004:	55                   	push   %ebp
  802005:	89 e5                	mov    %esp,%ebp
  802007:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80200a:	8d 45 10             	lea    0x10(%ebp),%eax
  80200d:	83 c0 04             	add    $0x4,%eax
  802010:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  802013:	8b 45 10             	mov    0x10(%ebp),%eax
  802016:	ff 75 f4             	pushl  -0xc(%ebp)
  802019:	50                   	push   %eax
  80201a:	ff 75 0c             	pushl  0xc(%ebp)
  80201d:	ff 75 08             	pushl  0x8(%ebp)
  802020:	e8 89 ff ff ff       	call   801fae <vsnprintf>
  802025:	83 c4 10             	add    $0x10,%esp
  802028:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80202b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80202e:	c9                   	leave  
  80202f:	c3                   	ret    

00802030 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  802030:	55                   	push   %ebp
  802031:	89 e5                	mov    %esp,%ebp
  802033:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  802036:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80203d:	eb 06                	jmp    802045 <strlen+0x15>
		n++;
  80203f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  802042:	ff 45 08             	incl   0x8(%ebp)
  802045:	8b 45 08             	mov    0x8(%ebp),%eax
  802048:	8a 00                	mov    (%eax),%al
  80204a:	84 c0                	test   %al,%al
  80204c:	75 f1                	jne    80203f <strlen+0xf>
		n++;
	return n;
  80204e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802051:	c9                   	leave  
  802052:	c3                   	ret    

00802053 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  802053:	55                   	push   %ebp
  802054:	89 e5                	mov    %esp,%ebp
  802056:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  802059:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802060:	eb 09                	jmp    80206b <strnlen+0x18>
		n++;
  802062:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  802065:	ff 45 08             	incl   0x8(%ebp)
  802068:	ff 4d 0c             	decl   0xc(%ebp)
  80206b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80206f:	74 09                	je     80207a <strnlen+0x27>
  802071:	8b 45 08             	mov    0x8(%ebp),%eax
  802074:	8a 00                	mov    (%eax),%al
  802076:	84 c0                	test   %al,%al
  802078:	75 e8                	jne    802062 <strnlen+0xf>
		n++;
	return n;
  80207a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80207d:	c9                   	leave  
  80207e:	c3                   	ret    

0080207f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80207f:	55                   	push   %ebp
  802080:	89 e5                	mov    %esp,%ebp
  802082:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  802085:	8b 45 08             	mov    0x8(%ebp),%eax
  802088:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80208b:	90                   	nop
  80208c:	8b 45 08             	mov    0x8(%ebp),%eax
  80208f:	8d 50 01             	lea    0x1(%eax),%edx
  802092:	89 55 08             	mov    %edx,0x8(%ebp)
  802095:	8b 55 0c             	mov    0xc(%ebp),%edx
  802098:	8d 4a 01             	lea    0x1(%edx),%ecx
  80209b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80209e:	8a 12                	mov    (%edx),%dl
  8020a0:	88 10                	mov    %dl,(%eax)
  8020a2:	8a 00                	mov    (%eax),%al
  8020a4:	84 c0                	test   %al,%al
  8020a6:	75 e4                	jne    80208c <strcpy+0xd>
		/* do nothing */;
	return ret;
  8020a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8020ab:	c9                   	leave  
  8020ac:	c3                   	ret    

008020ad <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8020ad:	55                   	push   %ebp
  8020ae:	89 e5                	mov    %esp,%ebp
  8020b0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8020b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8020b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8020c0:	eb 1f                	jmp    8020e1 <strncpy+0x34>
		*dst++ = *src;
  8020c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c5:	8d 50 01             	lea    0x1(%eax),%edx
  8020c8:	89 55 08             	mov    %edx,0x8(%ebp)
  8020cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ce:	8a 12                	mov    (%edx),%dl
  8020d0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8020d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020d5:	8a 00                	mov    (%eax),%al
  8020d7:	84 c0                	test   %al,%al
  8020d9:	74 03                	je     8020de <strncpy+0x31>
			src++;
  8020db:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8020de:	ff 45 fc             	incl   -0x4(%ebp)
  8020e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020e4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8020e7:	72 d9                	jb     8020c2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8020e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8020ec:	c9                   	leave  
  8020ed:	c3                   	ret    

008020ee <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8020ee:	55                   	push   %ebp
  8020ef:	89 e5                	mov    %esp,%ebp
  8020f1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8020f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8020fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8020fe:	74 30                	je     802130 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  802100:	eb 16                	jmp    802118 <strlcpy+0x2a>
			*dst++ = *src++;
  802102:	8b 45 08             	mov    0x8(%ebp),%eax
  802105:	8d 50 01             	lea    0x1(%eax),%edx
  802108:	89 55 08             	mov    %edx,0x8(%ebp)
  80210b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80210e:	8d 4a 01             	lea    0x1(%edx),%ecx
  802111:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  802114:	8a 12                	mov    (%edx),%dl
  802116:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  802118:	ff 4d 10             	decl   0x10(%ebp)
  80211b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80211f:	74 09                	je     80212a <strlcpy+0x3c>
  802121:	8b 45 0c             	mov    0xc(%ebp),%eax
  802124:	8a 00                	mov    (%eax),%al
  802126:	84 c0                	test   %al,%al
  802128:	75 d8                	jne    802102 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80212a:	8b 45 08             	mov    0x8(%ebp),%eax
  80212d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  802130:	8b 55 08             	mov    0x8(%ebp),%edx
  802133:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802136:	29 c2                	sub    %eax,%edx
  802138:	89 d0                	mov    %edx,%eax
}
  80213a:	c9                   	leave  
  80213b:	c3                   	ret    

0080213c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80213c:	55                   	push   %ebp
  80213d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80213f:	eb 06                	jmp    802147 <strcmp+0xb>
		p++, q++;
  802141:	ff 45 08             	incl   0x8(%ebp)
  802144:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  802147:	8b 45 08             	mov    0x8(%ebp),%eax
  80214a:	8a 00                	mov    (%eax),%al
  80214c:	84 c0                	test   %al,%al
  80214e:	74 0e                	je     80215e <strcmp+0x22>
  802150:	8b 45 08             	mov    0x8(%ebp),%eax
  802153:	8a 10                	mov    (%eax),%dl
  802155:	8b 45 0c             	mov    0xc(%ebp),%eax
  802158:	8a 00                	mov    (%eax),%al
  80215a:	38 c2                	cmp    %al,%dl
  80215c:	74 e3                	je     802141 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80215e:	8b 45 08             	mov    0x8(%ebp),%eax
  802161:	8a 00                	mov    (%eax),%al
  802163:	0f b6 d0             	movzbl %al,%edx
  802166:	8b 45 0c             	mov    0xc(%ebp),%eax
  802169:	8a 00                	mov    (%eax),%al
  80216b:	0f b6 c0             	movzbl %al,%eax
  80216e:	29 c2                	sub    %eax,%edx
  802170:	89 d0                	mov    %edx,%eax
}
  802172:	5d                   	pop    %ebp
  802173:	c3                   	ret    

00802174 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  802174:	55                   	push   %ebp
  802175:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  802177:	eb 09                	jmp    802182 <strncmp+0xe>
		n--, p++, q++;
  802179:	ff 4d 10             	decl   0x10(%ebp)
  80217c:	ff 45 08             	incl   0x8(%ebp)
  80217f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  802182:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802186:	74 17                	je     80219f <strncmp+0x2b>
  802188:	8b 45 08             	mov    0x8(%ebp),%eax
  80218b:	8a 00                	mov    (%eax),%al
  80218d:	84 c0                	test   %al,%al
  80218f:	74 0e                	je     80219f <strncmp+0x2b>
  802191:	8b 45 08             	mov    0x8(%ebp),%eax
  802194:	8a 10                	mov    (%eax),%dl
  802196:	8b 45 0c             	mov    0xc(%ebp),%eax
  802199:	8a 00                	mov    (%eax),%al
  80219b:	38 c2                	cmp    %al,%dl
  80219d:	74 da                	je     802179 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80219f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8021a3:	75 07                	jne    8021ac <strncmp+0x38>
		return 0;
  8021a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8021aa:	eb 14                	jmp    8021c0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8021ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8021af:	8a 00                	mov    (%eax),%al
  8021b1:	0f b6 d0             	movzbl %al,%edx
  8021b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021b7:	8a 00                	mov    (%eax),%al
  8021b9:	0f b6 c0             	movzbl %al,%eax
  8021bc:	29 c2                	sub    %eax,%edx
  8021be:	89 d0                	mov    %edx,%eax
}
  8021c0:	5d                   	pop    %ebp
  8021c1:	c3                   	ret    

008021c2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8021c2:	55                   	push   %ebp
  8021c3:	89 e5                	mov    %esp,%ebp
  8021c5:	83 ec 04             	sub    $0x4,%esp
  8021c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021cb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8021ce:	eb 12                	jmp    8021e2 <strchr+0x20>
		if (*s == c)
  8021d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d3:	8a 00                	mov    (%eax),%al
  8021d5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8021d8:	75 05                	jne    8021df <strchr+0x1d>
			return (char *) s;
  8021da:	8b 45 08             	mov    0x8(%ebp),%eax
  8021dd:	eb 11                	jmp    8021f0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8021df:	ff 45 08             	incl   0x8(%ebp)
  8021e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e5:	8a 00                	mov    (%eax),%al
  8021e7:	84 c0                	test   %al,%al
  8021e9:	75 e5                	jne    8021d0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8021eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021f0:	c9                   	leave  
  8021f1:	c3                   	ret    

008021f2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8021f2:	55                   	push   %ebp
  8021f3:	89 e5                	mov    %esp,%ebp
  8021f5:	83 ec 04             	sub    $0x4,%esp
  8021f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021fb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8021fe:	eb 0d                	jmp    80220d <strfind+0x1b>
		if (*s == c)
  802200:	8b 45 08             	mov    0x8(%ebp),%eax
  802203:	8a 00                	mov    (%eax),%al
  802205:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802208:	74 0e                	je     802218 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80220a:	ff 45 08             	incl   0x8(%ebp)
  80220d:	8b 45 08             	mov    0x8(%ebp),%eax
  802210:	8a 00                	mov    (%eax),%al
  802212:	84 c0                	test   %al,%al
  802214:	75 ea                	jne    802200 <strfind+0xe>
  802216:	eb 01                	jmp    802219 <strfind+0x27>
		if (*s == c)
			break;
  802218:	90                   	nop
	return (char *) s;
  802219:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80221c:	c9                   	leave  
  80221d:	c3                   	ret    

0080221e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80221e:	55                   	push   %ebp
  80221f:	89 e5                	mov    %esp,%ebp
  802221:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  802224:	8b 45 08             	mov    0x8(%ebp),%eax
  802227:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80222a:	8b 45 10             	mov    0x10(%ebp),%eax
  80222d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  802230:	eb 0e                	jmp    802240 <memset+0x22>
		*p++ = c;
  802232:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802235:	8d 50 01             	lea    0x1(%eax),%edx
  802238:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80223b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80223e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  802240:	ff 4d f8             	decl   -0x8(%ebp)
  802243:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  802247:	79 e9                	jns    802232 <memset+0x14>
		*p++ = c;

	return v;
  802249:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80224c:	c9                   	leave  
  80224d:	c3                   	ret    

0080224e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80224e:	55                   	push   %ebp
  80224f:	89 e5                	mov    %esp,%ebp
  802251:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  802254:	8b 45 0c             	mov    0xc(%ebp),%eax
  802257:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80225a:	8b 45 08             	mov    0x8(%ebp),%eax
  80225d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  802260:	eb 16                	jmp    802278 <memcpy+0x2a>
		*d++ = *s++;
  802262:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802265:	8d 50 01             	lea    0x1(%eax),%edx
  802268:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80226b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80226e:	8d 4a 01             	lea    0x1(%edx),%ecx
  802271:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802274:	8a 12                	mov    (%edx),%dl
  802276:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  802278:	8b 45 10             	mov    0x10(%ebp),%eax
  80227b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80227e:	89 55 10             	mov    %edx,0x10(%ebp)
  802281:	85 c0                	test   %eax,%eax
  802283:	75 dd                	jne    802262 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  802285:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802288:	c9                   	leave  
  802289:	c3                   	ret    

0080228a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80228a:	55                   	push   %ebp
  80228b:	89 e5                	mov    %esp,%ebp
  80228d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  802290:	8b 45 0c             	mov    0xc(%ebp),%eax
  802293:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  802296:	8b 45 08             	mov    0x8(%ebp),%eax
  802299:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80229c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80229f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8022a2:	73 50                	jae    8022f4 <memmove+0x6a>
  8022a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8022a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8022aa:	01 d0                	add    %edx,%eax
  8022ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8022af:	76 43                	jbe    8022f4 <memmove+0x6a>
		s += n;
  8022b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8022b4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8022b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8022ba:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8022bd:	eb 10                	jmp    8022cf <memmove+0x45>
			*--d = *--s;
  8022bf:	ff 4d f8             	decl   -0x8(%ebp)
  8022c2:	ff 4d fc             	decl   -0x4(%ebp)
  8022c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8022c8:	8a 10                	mov    (%eax),%dl
  8022ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8022cd:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8022cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8022d2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8022d5:	89 55 10             	mov    %edx,0x10(%ebp)
  8022d8:	85 c0                	test   %eax,%eax
  8022da:	75 e3                	jne    8022bf <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8022dc:	eb 23                	jmp    802301 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8022de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8022e1:	8d 50 01             	lea    0x1(%eax),%edx
  8022e4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8022e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8022ea:	8d 4a 01             	lea    0x1(%edx),%ecx
  8022ed:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8022f0:	8a 12                	mov    (%edx),%dl
  8022f2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8022f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8022f7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8022fa:	89 55 10             	mov    %edx,0x10(%ebp)
  8022fd:	85 c0                	test   %eax,%eax
  8022ff:	75 dd                	jne    8022de <memmove+0x54>
			*d++ = *s++;

	return dst;
  802301:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802304:	c9                   	leave  
  802305:	c3                   	ret    

00802306 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  802306:	55                   	push   %ebp
  802307:	89 e5                	mov    %esp,%ebp
  802309:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80230c:	8b 45 08             	mov    0x8(%ebp),%eax
  80230f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  802312:	8b 45 0c             	mov    0xc(%ebp),%eax
  802315:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  802318:	eb 2a                	jmp    802344 <memcmp+0x3e>
		if (*s1 != *s2)
  80231a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80231d:	8a 10                	mov    (%eax),%dl
  80231f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802322:	8a 00                	mov    (%eax),%al
  802324:	38 c2                	cmp    %al,%dl
  802326:	74 16                	je     80233e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  802328:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80232b:	8a 00                	mov    (%eax),%al
  80232d:	0f b6 d0             	movzbl %al,%edx
  802330:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802333:	8a 00                	mov    (%eax),%al
  802335:	0f b6 c0             	movzbl %al,%eax
  802338:	29 c2                	sub    %eax,%edx
  80233a:	89 d0                	mov    %edx,%eax
  80233c:	eb 18                	jmp    802356 <memcmp+0x50>
		s1++, s2++;
  80233e:	ff 45 fc             	incl   -0x4(%ebp)
  802341:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  802344:	8b 45 10             	mov    0x10(%ebp),%eax
  802347:	8d 50 ff             	lea    -0x1(%eax),%edx
  80234a:	89 55 10             	mov    %edx,0x10(%ebp)
  80234d:	85 c0                	test   %eax,%eax
  80234f:	75 c9                	jne    80231a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  802351:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802356:	c9                   	leave  
  802357:	c3                   	ret    

00802358 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  802358:	55                   	push   %ebp
  802359:	89 e5                	mov    %esp,%ebp
  80235b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80235e:	8b 55 08             	mov    0x8(%ebp),%edx
  802361:	8b 45 10             	mov    0x10(%ebp),%eax
  802364:	01 d0                	add    %edx,%eax
  802366:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  802369:	eb 15                	jmp    802380 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80236b:	8b 45 08             	mov    0x8(%ebp),%eax
  80236e:	8a 00                	mov    (%eax),%al
  802370:	0f b6 d0             	movzbl %al,%edx
  802373:	8b 45 0c             	mov    0xc(%ebp),%eax
  802376:	0f b6 c0             	movzbl %al,%eax
  802379:	39 c2                	cmp    %eax,%edx
  80237b:	74 0d                	je     80238a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80237d:	ff 45 08             	incl   0x8(%ebp)
  802380:	8b 45 08             	mov    0x8(%ebp),%eax
  802383:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  802386:	72 e3                	jb     80236b <memfind+0x13>
  802388:	eb 01                	jmp    80238b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80238a:	90                   	nop
	return (void *) s;
  80238b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80238e:	c9                   	leave  
  80238f:	c3                   	ret    

00802390 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  802390:	55                   	push   %ebp
  802391:	89 e5                	mov    %esp,%ebp
  802393:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  802396:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80239d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8023a4:	eb 03                	jmp    8023a9 <strtol+0x19>
		s++;
  8023a6:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8023a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ac:	8a 00                	mov    (%eax),%al
  8023ae:	3c 20                	cmp    $0x20,%al
  8023b0:	74 f4                	je     8023a6 <strtol+0x16>
  8023b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8023b5:	8a 00                	mov    (%eax),%al
  8023b7:	3c 09                	cmp    $0x9,%al
  8023b9:	74 eb                	je     8023a6 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8023bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8023be:	8a 00                	mov    (%eax),%al
  8023c0:	3c 2b                	cmp    $0x2b,%al
  8023c2:	75 05                	jne    8023c9 <strtol+0x39>
		s++;
  8023c4:	ff 45 08             	incl   0x8(%ebp)
  8023c7:	eb 13                	jmp    8023dc <strtol+0x4c>
	else if (*s == '-')
  8023c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8023cc:	8a 00                	mov    (%eax),%al
  8023ce:	3c 2d                	cmp    $0x2d,%al
  8023d0:	75 0a                	jne    8023dc <strtol+0x4c>
		s++, neg = 1;
  8023d2:	ff 45 08             	incl   0x8(%ebp)
  8023d5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8023dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8023e0:	74 06                	je     8023e8 <strtol+0x58>
  8023e2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8023e6:	75 20                	jne    802408 <strtol+0x78>
  8023e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8023eb:	8a 00                	mov    (%eax),%al
  8023ed:	3c 30                	cmp    $0x30,%al
  8023ef:	75 17                	jne    802408 <strtol+0x78>
  8023f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8023f4:	40                   	inc    %eax
  8023f5:	8a 00                	mov    (%eax),%al
  8023f7:	3c 78                	cmp    $0x78,%al
  8023f9:	75 0d                	jne    802408 <strtol+0x78>
		s += 2, base = 16;
  8023fb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8023ff:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  802406:	eb 28                	jmp    802430 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  802408:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80240c:	75 15                	jne    802423 <strtol+0x93>
  80240e:	8b 45 08             	mov    0x8(%ebp),%eax
  802411:	8a 00                	mov    (%eax),%al
  802413:	3c 30                	cmp    $0x30,%al
  802415:	75 0c                	jne    802423 <strtol+0x93>
		s++, base = 8;
  802417:	ff 45 08             	incl   0x8(%ebp)
  80241a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  802421:	eb 0d                	jmp    802430 <strtol+0xa0>
	else if (base == 0)
  802423:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802427:	75 07                	jne    802430 <strtol+0xa0>
		base = 10;
  802429:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  802430:	8b 45 08             	mov    0x8(%ebp),%eax
  802433:	8a 00                	mov    (%eax),%al
  802435:	3c 2f                	cmp    $0x2f,%al
  802437:	7e 19                	jle    802452 <strtol+0xc2>
  802439:	8b 45 08             	mov    0x8(%ebp),%eax
  80243c:	8a 00                	mov    (%eax),%al
  80243e:	3c 39                	cmp    $0x39,%al
  802440:	7f 10                	jg     802452 <strtol+0xc2>
			dig = *s - '0';
  802442:	8b 45 08             	mov    0x8(%ebp),%eax
  802445:	8a 00                	mov    (%eax),%al
  802447:	0f be c0             	movsbl %al,%eax
  80244a:	83 e8 30             	sub    $0x30,%eax
  80244d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802450:	eb 42                	jmp    802494 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  802452:	8b 45 08             	mov    0x8(%ebp),%eax
  802455:	8a 00                	mov    (%eax),%al
  802457:	3c 60                	cmp    $0x60,%al
  802459:	7e 19                	jle    802474 <strtol+0xe4>
  80245b:	8b 45 08             	mov    0x8(%ebp),%eax
  80245e:	8a 00                	mov    (%eax),%al
  802460:	3c 7a                	cmp    $0x7a,%al
  802462:	7f 10                	jg     802474 <strtol+0xe4>
			dig = *s - 'a' + 10;
  802464:	8b 45 08             	mov    0x8(%ebp),%eax
  802467:	8a 00                	mov    (%eax),%al
  802469:	0f be c0             	movsbl %al,%eax
  80246c:	83 e8 57             	sub    $0x57,%eax
  80246f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802472:	eb 20                	jmp    802494 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  802474:	8b 45 08             	mov    0x8(%ebp),%eax
  802477:	8a 00                	mov    (%eax),%al
  802479:	3c 40                	cmp    $0x40,%al
  80247b:	7e 39                	jle    8024b6 <strtol+0x126>
  80247d:	8b 45 08             	mov    0x8(%ebp),%eax
  802480:	8a 00                	mov    (%eax),%al
  802482:	3c 5a                	cmp    $0x5a,%al
  802484:	7f 30                	jg     8024b6 <strtol+0x126>
			dig = *s - 'A' + 10;
  802486:	8b 45 08             	mov    0x8(%ebp),%eax
  802489:	8a 00                	mov    (%eax),%al
  80248b:	0f be c0             	movsbl %al,%eax
  80248e:	83 e8 37             	sub    $0x37,%eax
  802491:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  802494:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802497:	3b 45 10             	cmp    0x10(%ebp),%eax
  80249a:	7d 19                	jge    8024b5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80249c:	ff 45 08             	incl   0x8(%ebp)
  80249f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8024a2:	0f af 45 10          	imul   0x10(%ebp),%eax
  8024a6:	89 c2                	mov    %eax,%edx
  8024a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8024ab:	01 d0                	add    %edx,%eax
  8024ad:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8024b0:	e9 7b ff ff ff       	jmp    802430 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8024b5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8024b6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8024ba:	74 08                	je     8024c4 <strtol+0x134>
		*endptr = (char *) s;
  8024bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8024c2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8024c4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8024c8:	74 07                	je     8024d1 <strtol+0x141>
  8024ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8024cd:	f7 d8                	neg    %eax
  8024cf:	eb 03                	jmp    8024d4 <strtol+0x144>
  8024d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8024d4:	c9                   	leave  
  8024d5:	c3                   	ret    

008024d6 <ltostr>:

void
ltostr(long value, char *str)
{
  8024d6:	55                   	push   %ebp
  8024d7:	89 e5                	mov    %esp,%ebp
  8024d9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8024dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8024e3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8024ea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8024ee:	79 13                	jns    802503 <ltostr+0x2d>
	{
		neg = 1;
  8024f0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8024f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024fa:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8024fd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802500:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  802503:	8b 45 08             	mov    0x8(%ebp),%eax
  802506:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80250b:	99                   	cltd   
  80250c:	f7 f9                	idiv   %ecx
  80250e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802511:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802514:	8d 50 01             	lea    0x1(%eax),%edx
  802517:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80251a:	89 c2                	mov    %eax,%edx
  80251c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80251f:	01 d0                	add    %edx,%eax
  802521:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802524:	83 c2 30             	add    $0x30,%edx
  802527:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  802529:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80252c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802531:	f7 e9                	imul   %ecx
  802533:	c1 fa 02             	sar    $0x2,%edx
  802536:	89 c8                	mov    %ecx,%eax
  802538:	c1 f8 1f             	sar    $0x1f,%eax
  80253b:	29 c2                	sub    %eax,%edx
  80253d:	89 d0                	mov    %edx,%eax
  80253f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  802542:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802545:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80254a:	f7 e9                	imul   %ecx
  80254c:	c1 fa 02             	sar    $0x2,%edx
  80254f:	89 c8                	mov    %ecx,%eax
  802551:	c1 f8 1f             	sar    $0x1f,%eax
  802554:	29 c2                	sub    %eax,%edx
  802556:	89 d0                	mov    %edx,%eax
  802558:	c1 e0 02             	shl    $0x2,%eax
  80255b:	01 d0                	add    %edx,%eax
  80255d:	01 c0                	add    %eax,%eax
  80255f:	29 c1                	sub    %eax,%ecx
  802561:	89 ca                	mov    %ecx,%edx
  802563:	85 d2                	test   %edx,%edx
  802565:	75 9c                	jne    802503 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  802567:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80256e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802571:	48                   	dec    %eax
  802572:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  802575:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802579:	74 3d                	je     8025b8 <ltostr+0xe2>
		start = 1 ;
  80257b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  802582:	eb 34                	jmp    8025b8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  802584:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802587:	8b 45 0c             	mov    0xc(%ebp),%eax
  80258a:	01 d0                	add    %edx,%eax
  80258c:	8a 00                	mov    (%eax),%al
  80258e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802591:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802594:	8b 45 0c             	mov    0xc(%ebp),%eax
  802597:	01 c2                	add    %eax,%edx
  802599:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80259c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80259f:	01 c8                	add    %ecx,%eax
  8025a1:	8a 00                	mov    (%eax),%al
  8025a3:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8025a5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8025a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8025ab:	01 c2                	add    %eax,%edx
  8025ad:	8a 45 eb             	mov    -0x15(%ebp),%al
  8025b0:	88 02                	mov    %al,(%edx)
		start++ ;
  8025b2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8025b5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8025b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8025bb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8025be:	7c c4                	jl     802584 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8025c0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8025c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8025c6:	01 d0                	add    %edx,%eax
  8025c8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8025cb:	90                   	nop
  8025cc:	c9                   	leave  
  8025cd:	c3                   	ret    

008025ce <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8025ce:	55                   	push   %ebp
  8025cf:	89 e5                	mov    %esp,%ebp
  8025d1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8025d4:	ff 75 08             	pushl  0x8(%ebp)
  8025d7:	e8 54 fa ff ff       	call   802030 <strlen>
  8025dc:	83 c4 04             	add    $0x4,%esp
  8025df:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8025e2:	ff 75 0c             	pushl  0xc(%ebp)
  8025e5:	e8 46 fa ff ff       	call   802030 <strlen>
  8025ea:	83 c4 04             	add    $0x4,%esp
  8025ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8025f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8025f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8025fe:	eb 17                	jmp    802617 <strcconcat+0x49>
		final[s] = str1[s] ;
  802600:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802603:	8b 45 10             	mov    0x10(%ebp),%eax
  802606:	01 c2                	add    %eax,%edx
  802608:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80260b:	8b 45 08             	mov    0x8(%ebp),%eax
  80260e:	01 c8                	add    %ecx,%eax
  802610:	8a 00                	mov    (%eax),%al
  802612:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  802614:	ff 45 fc             	incl   -0x4(%ebp)
  802617:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80261a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80261d:	7c e1                	jl     802600 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80261f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  802626:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80262d:	eb 1f                	jmp    80264e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80262f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802632:	8d 50 01             	lea    0x1(%eax),%edx
  802635:	89 55 fc             	mov    %edx,-0x4(%ebp)
  802638:	89 c2                	mov    %eax,%edx
  80263a:	8b 45 10             	mov    0x10(%ebp),%eax
  80263d:	01 c2                	add    %eax,%edx
  80263f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  802642:	8b 45 0c             	mov    0xc(%ebp),%eax
  802645:	01 c8                	add    %ecx,%eax
  802647:	8a 00                	mov    (%eax),%al
  802649:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80264b:	ff 45 f8             	incl   -0x8(%ebp)
  80264e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802651:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802654:	7c d9                	jl     80262f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  802656:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802659:	8b 45 10             	mov    0x10(%ebp),%eax
  80265c:	01 d0                	add    %edx,%eax
  80265e:	c6 00 00             	movb   $0x0,(%eax)
}
  802661:	90                   	nop
  802662:	c9                   	leave  
  802663:	c3                   	ret    

00802664 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  802664:	55                   	push   %ebp
  802665:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  802667:	8b 45 14             	mov    0x14(%ebp),%eax
  80266a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  802670:	8b 45 14             	mov    0x14(%ebp),%eax
  802673:	8b 00                	mov    (%eax),%eax
  802675:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80267c:	8b 45 10             	mov    0x10(%ebp),%eax
  80267f:	01 d0                	add    %edx,%eax
  802681:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802687:	eb 0c                	jmp    802695 <strsplit+0x31>
			*string++ = 0;
  802689:	8b 45 08             	mov    0x8(%ebp),%eax
  80268c:	8d 50 01             	lea    0x1(%eax),%edx
  80268f:	89 55 08             	mov    %edx,0x8(%ebp)
  802692:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802695:	8b 45 08             	mov    0x8(%ebp),%eax
  802698:	8a 00                	mov    (%eax),%al
  80269a:	84 c0                	test   %al,%al
  80269c:	74 18                	je     8026b6 <strsplit+0x52>
  80269e:	8b 45 08             	mov    0x8(%ebp),%eax
  8026a1:	8a 00                	mov    (%eax),%al
  8026a3:	0f be c0             	movsbl %al,%eax
  8026a6:	50                   	push   %eax
  8026a7:	ff 75 0c             	pushl  0xc(%ebp)
  8026aa:	e8 13 fb ff ff       	call   8021c2 <strchr>
  8026af:	83 c4 08             	add    $0x8,%esp
  8026b2:	85 c0                	test   %eax,%eax
  8026b4:	75 d3                	jne    802689 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8026b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8026b9:	8a 00                	mov    (%eax),%al
  8026bb:	84 c0                	test   %al,%al
  8026bd:	74 5a                	je     802719 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8026bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8026c2:	8b 00                	mov    (%eax),%eax
  8026c4:	83 f8 0f             	cmp    $0xf,%eax
  8026c7:	75 07                	jne    8026d0 <strsplit+0x6c>
		{
			return 0;
  8026c9:	b8 00 00 00 00       	mov    $0x0,%eax
  8026ce:	eb 66                	jmp    802736 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8026d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8026d3:	8b 00                	mov    (%eax),%eax
  8026d5:	8d 48 01             	lea    0x1(%eax),%ecx
  8026d8:	8b 55 14             	mov    0x14(%ebp),%edx
  8026db:	89 0a                	mov    %ecx,(%edx)
  8026dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8026e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8026e7:	01 c2                	add    %eax,%edx
  8026e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8026ec:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8026ee:	eb 03                	jmp    8026f3 <strsplit+0x8f>
			string++;
  8026f0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8026f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8026f6:	8a 00                	mov    (%eax),%al
  8026f8:	84 c0                	test   %al,%al
  8026fa:	74 8b                	je     802687 <strsplit+0x23>
  8026fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8026ff:	8a 00                	mov    (%eax),%al
  802701:	0f be c0             	movsbl %al,%eax
  802704:	50                   	push   %eax
  802705:	ff 75 0c             	pushl  0xc(%ebp)
  802708:	e8 b5 fa ff ff       	call   8021c2 <strchr>
  80270d:	83 c4 08             	add    $0x8,%esp
  802710:	85 c0                	test   %eax,%eax
  802712:	74 dc                	je     8026f0 <strsplit+0x8c>
			string++;
	}
  802714:	e9 6e ff ff ff       	jmp    802687 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  802719:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80271a:	8b 45 14             	mov    0x14(%ebp),%eax
  80271d:	8b 00                	mov    (%eax),%eax
  80271f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802726:	8b 45 10             	mov    0x10(%ebp),%eax
  802729:	01 d0                	add    %edx,%eax
  80272b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  802731:	b8 01 00 00 00       	mov    $0x1,%eax
}
  802736:	c9                   	leave  
  802737:	c3                   	ret    

00802738 <malloc>:
//==================================================================================//
int FirstTimeFlag = 1;
int allocated[MAXN];

void* malloc(uint32 size)
{
  802738:	55                   	push   %ebp
  802739:	89 e5                	mov    %esp,%ebp
  80273b:	83 ec 28             	sub    $0x28,%esp
	//DON'T CHANGE THIS CODE
	if(FirstTimeFlag)
  80273e:	a1 04 40 80 00       	mov    0x804004,%eax
  802743:	85 c0                	test   %eax,%eax
  802745:	74 0f                	je     802756 <malloc+0x1e>
	{
		initialize_buddy();
  802747:	e8 a4 02 00 00       	call   8029f0 <initialize_buddy>
		FirstTimeFlag = 0;
  80274c:	c7 05 04 40 80 00 00 	movl   $0x0,0x804004
  802753:	00 00 00 
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
  802756:	81 7d 08 00 08 00 00 	cmpl   $0x800,0x8(%ebp)
  80275d:	0f 86 0b 01 00 00    	jbe    80286e <malloc+0x136>
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
  802763:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80276a:	8b 45 08             	mov    0x8(%ebp),%eax
  80276d:	c1 e8 0c             	shr    $0xc,%eax
  802770:	89 c2                	mov    %eax,%edx
  802772:	8b 45 08             	mov    0x8(%ebp),%eax
  802775:	25 ff 0f 00 00       	and    $0xfff,%eax
  80277a:	85 c0                	test   %eax,%eax
  80277c:	74 07                	je     802785 <malloc+0x4d>
  80277e:	b8 01 00 00 00       	mov    $0x1,%eax
  802783:	eb 05                	jmp    80278a <malloc+0x52>
  802785:	b8 00 00 00 00       	mov    $0x0,%eax
  80278a:	01 d0                	add    %edx,%eax
  80278c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  80278f:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  802796:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
		for(i = 0; i < MAXN; i++) {
  80279d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8027a4:	eb 5c                	jmp    802802 <malloc+0xca>
			if(allocated[i] != 0) continue;
  8027a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8027a9:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8027b0:	85 c0                	test   %eax,%eax
  8027b2:	75 4a                	jne    8027fe <malloc+0xc6>
			j = 1;
  8027b4:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
			i++;
  8027bb:	ff 45 f4             	incl   -0xc(%ebp)
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  8027be:	eb 06                	jmp    8027c6 <malloc+0x8e>
				i++;
  8027c0:	ff 45 f4             	incl   -0xc(%ebp)
				j++;
  8027c3:	ff 45 ec             	incl   -0x14(%ebp)
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
			j = 1;
			i++;
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  8027c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8027c9:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8027ce:	77 16                	ja     8027e6 <malloc+0xae>
  8027d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8027d3:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8027da:	85 c0                	test   %eax,%eax
  8027dc:	75 08                	jne    8027e6 <malloc+0xae>
  8027de:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8027e1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8027e4:	7c da                	jl     8027c0 <malloc+0x88>
				i++;
				j++;
			}
			if(j == sizeToPage) {
  8027e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8027e9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8027ec:	75 0b                	jne    8027f9 <malloc+0xc1>
				indx = i - j;
  8027ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8027f1:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8027f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
				break;
  8027f7:	eb 13                	jmp    80280c <malloc+0xd4>
			}
			i--;
  8027f9:	ff 4d f4             	decl   -0xc(%ebp)
  8027fc:	eb 01                	jmp    8027ff <malloc+0xc7>
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
  8027fe:	90                   	nop
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
  8027ff:	ff 45 f4             	incl   -0xc(%ebp)
  802802:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802805:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80280a:	76 9a                	jbe    8027a6 <malloc+0x6e>
				indx = i - j;
				break;
			}
			i--;
		}
		if(indx == -1) {
  80280c:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
  802810:	75 07                	jne    802819 <malloc+0xe1>
			return NULL;
  802812:	b8 00 00 00 00       	mov    $0x0,%eax
  802817:	eb 5a                	jmp    802873 <malloc+0x13b>
		}
		i = indx;
  802819:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80281c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		while(i < j + indx) {
  80281f:	eb 13                	jmp    802834 <malloc+0xfc>
			allocated[i++] = j;
  802821:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802824:	8d 50 01             	lea    0x1(%eax),%edx
  802827:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80282a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80282d:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
		}
		if(indx == -1) {
			return NULL;
		}
		i = indx;
		while(i < j + indx) {
  802834:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802837:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80283a:	01 d0                	add    %edx,%eax
  80283c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80283f:	7f e0                	jg     802821 <malloc+0xe9>
			allocated[i++] = j;
		}
		uint32 *address = (uint32 *)(USER_HEAP_START + (indx * PAGE_SIZE));
  802841:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802844:	c1 e0 0c             	shl    $0xc,%eax
  802847:	05 00 00 00 80       	add    $0x80000000,%eax
  80284c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		sys_allocateMem(USER_HEAP_START + (indx * PAGE_SIZE), size);
  80284f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802852:	c1 e0 0c             	shl    $0xc,%eax
  802855:	05 00 00 00 80       	add    $0x80000000,%eax
  80285a:	83 ec 08             	sub    $0x8,%esp
  80285d:	ff 75 08             	pushl  0x8(%ebp)
  802860:	50                   	push   %eax
  802861:	e8 84 04 00 00       	call   802cea <sys_allocateMem>
  802866:	83 c4 10             	add    $0x10,%esp
		return address;
  802869:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80286c:	eb 05                	jmp    802873 <malloc+0x13b>
	//1) FIRST FIT strategy (if size > 2 KB)
	//2) Buddy System (if size <= 2 KB)

	//refer to the project presentation and documentation for details

	return NULL;
  80286e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802873:	c9                   	leave  
  802874:	c3                   	ret    

00802875 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  802875:	55                   	push   %ebp
  802876:	89 e5                	mov    %esp,%ebp
  802878:	83 ec 18             	sub    $0x18,%esp
	//TODO: [PROJECT 2020 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
  80287b:	8b 45 08             	mov    0x8(%ebp),%eax
  80287e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  802881:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802884:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  802889:	89 45 08             	mov    %eax,0x8(%ebp)
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
  80288c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  802893:	8b 45 08             	mov    0x8(%ebp),%eax
  802896:	05 00 00 00 80       	add    $0x80000000,%eax
  80289b:	c1 e8 0c             	shr    $0xc,%eax
  80289e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int removable_size = allocated[indx];
  8028a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8028a4:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8028ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
	size = allocated[indx];
  8028ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8028b1:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8028b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while(size > 0) {
  8028bb:	eb 17                	jmp    8028d4 <free+0x5f>
		allocated[indx++] = 0;
  8028bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8028c0:	8d 50 01             	lea    0x1(%eax),%edx
  8028c3:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8028c6:	c7 04 85 20 41 80 00 	movl   $0x0,0x804120(,%eax,4)
  8028cd:	00 00 00 00 
		size--;
  8028d1:	ff 4d f4             	decl   -0xc(%ebp)
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
	int removable_size = allocated[indx];
	size = allocated[indx];
	while(size > 0) {
  8028d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8028d8:	7f e3                	jg     8028bd <free+0x48>
		allocated[indx++] = 0;
		size--;
	}
	sys_freeMem((uint32)virtual_address, removable_size);
  8028da:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8028dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8028e0:	83 ec 08             	sub    $0x8,%esp
  8028e3:	52                   	push   %edx
  8028e4:	50                   	push   %eax
  8028e5:	e8 e4 03 00 00       	call   802cce <sys_freeMem>
  8028ea:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details

}
  8028ed:	90                   	nop
  8028ee:	c9                   	leave  
  8028ef:	c3                   	ret    

008028f0 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8028f0:	55                   	push   %ebp
  8028f1:	89 e5                	mov    %esp,%ebp
  8028f3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - BONUS2] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8028f6:	83 ec 04             	sub    $0x4,%esp
  8028f9:	68 d0 3b 80 00       	push   $0x803bd0
  8028fe:	6a 7a                	push   $0x7a
  802900:	68 f6 3b 80 00       	push   $0x803bf6
  802905:	e8 02 ee ff ff       	call   80170c <_panic>

0080290a <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80290a:	55                   	push   %ebp
  80290b:	89 e5                	mov    %esp,%ebp
  80290d:	83 ec 18             	sub    $0x18,%esp
  802910:	8b 45 10             	mov    0x10(%ebp),%eax
  802913:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802916:	83 ec 04             	sub    $0x4,%esp
  802919:	68 04 3c 80 00       	push   $0x803c04
  80291e:	68 84 00 00 00       	push   $0x84
  802923:	68 f6 3b 80 00       	push   $0x803bf6
  802928:	e8 df ed ff ff       	call   80170c <_panic>

0080292d <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80292d:	55                   	push   %ebp
  80292e:	89 e5                	mov    %esp,%ebp
  802930:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802933:	83 ec 04             	sub    $0x4,%esp
  802936:	68 04 3c 80 00       	push   $0x803c04
  80293b:	68 8a 00 00 00       	push   $0x8a
  802940:	68 f6 3b 80 00       	push   $0x803bf6
  802945:	e8 c2 ed ff ff       	call   80170c <_panic>

0080294a <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80294a:	55                   	push   %ebp
  80294b:	89 e5                	mov    %esp,%ebp
  80294d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802950:	83 ec 04             	sub    $0x4,%esp
  802953:	68 04 3c 80 00       	push   $0x803c04
  802958:	68 90 00 00 00       	push   $0x90
  80295d:	68 f6 3b 80 00       	push   $0x803bf6
  802962:	e8 a5 ed ff ff       	call   80170c <_panic>

00802967 <expand>:
}

void expand(uint32 newSize)
{
  802967:	55                   	push   %ebp
  802968:	89 e5                	mov    %esp,%ebp
  80296a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80296d:	83 ec 04             	sub    $0x4,%esp
  802970:	68 04 3c 80 00       	push   $0x803c04
  802975:	68 95 00 00 00       	push   $0x95
  80297a:	68 f6 3b 80 00       	push   $0x803bf6
  80297f:	e8 88 ed ff ff       	call   80170c <_panic>

00802984 <shrink>:
}
void shrink(uint32 newSize)
{
  802984:	55                   	push   %ebp
  802985:	89 e5                	mov    %esp,%ebp
  802987:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80298a:	83 ec 04             	sub    $0x4,%esp
  80298d:	68 04 3c 80 00       	push   $0x803c04
  802992:	68 99 00 00 00       	push   $0x99
  802997:	68 f6 3b 80 00       	push   $0x803bf6
  80299c:	e8 6b ed ff ff       	call   80170c <_panic>

008029a1 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8029a1:	55                   	push   %ebp
  8029a2:	89 e5                	mov    %esp,%ebp
  8029a4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8029a7:	83 ec 04             	sub    $0x4,%esp
  8029aa:	68 04 3c 80 00       	push   $0x803c04
  8029af:	68 9e 00 00 00       	push   $0x9e
  8029b4:	68 f6 3b 80 00       	push   $0x803bf6
  8029b9:	e8 4e ed ff ff       	call   80170c <_panic>

008029be <ClearNodeData>:
 * inside the user heap
 */
 
struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  8029be:	55                   	push   %ebp
  8029bf:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  8029c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8029c4:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  8029c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8029cb:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  8029cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8029d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  8029d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8029dc:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  8029e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8029e6:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  8029ed:	90                   	nop
  8029ee:	5d                   	pop    %ebp
  8029ef:	c3                   	ret    

008029f0 <initialize_buddy>:

void initialize_buddy()
{
  8029f0:	55                   	push   %ebp
  8029f1:	89 e5                	mov    %esp,%ebp
  8029f3:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  8029f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8029fd:	e9 b7 00 00 00       	jmp    802ab9 <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  802a02:	8b 15 04 41 80 00    	mov    0x804104,%edx
  802a08:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  802a0b:	89 c8                	mov    %ecx,%eax
  802a0d:	01 c0                	add    %eax,%eax
  802a0f:	01 c8                	add    %ecx,%eax
  802a11:	c1 e0 03             	shl    $0x3,%eax
  802a14:	05 20 41 88 00       	add    $0x884120,%eax
  802a19:	89 10                	mov    %edx,(%eax)
  802a1b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802a1e:	89 d0                	mov    %edx,%eax
  802a20:	01 c0                	add    %eax,%eax
  802a22:	01 d0                	add    %edx,%eax
  802a24:	c1 e0 03             	shl    $0x3,%eax
  802a27:	05 20 41 88 00       	add    $0x884120,%eax
  802a2c:	8b 00                	mov    (%eax),%eax
  802a2e:	85 c0                	test   %eax,%eax
  802a30:	74 1c                	je     802a4e <initialize_buddy+0x5e>
  802a32:	8b 15 04 41 80 00    	mov    0x804104,%edx
  802a38:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  802a3b:	89 c8                	mov    %ecx,%eax
  802a3d:	01 c0                	add    %eax,%eax
  802a3f:	01 c8                	add    %ecx,%eax
  802a41:	c1 e0 03             	shl    $0x3,%eax
  802a44:	05 20 41 88 00       	add    $0x884120,%eax
  802a49:	89 42 04             	mov    %eax,0x4(%edx)
  802a4c:	eb 16                	jmp    802a64 <initialize_buddy+0x74>
  802a4e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802a51:	89 d0                	mov    %edx,%eax
  802a53:	01 c0                	add    %eax,%eax
  802a55:	01 d0                	add    %edx,%eax
  802a57:	c1 e0 03             	shl    $0x3,%eax
  802a5a:	05 20 41 88 00       	add    $0x884120,%eax
  802a5f:	a3 08 41 80 00       	mov    %eax,0x804108
  802a64:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802a67:	89 d0                	mov    %edx,%eax
  802a69:	01 c0                	add    %eax,%eax
  802a6b:	01 d0                	add    %edx,%eax
  802a6d:	c1 e0 03             	shl    $0x3,%eax
  802a70:	05 20 41 88 00       	add    $0x884120,%eax
  802a75:	a3 04 41 80 00       	mov    %eax,0x804104
  802a7a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802a7d:	89 d0                	mov    %edx,%eax
  802a7f:	01 c0                	add    %eax,%eax
  802a81:	01 d0                	add    %edx,%eax
  802a83:	c1 e0 03             	shl    $0x3,%eax
  802a86:	05 24 41 88 00       	add    $0x884124,%eax
  802a8b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802a91:	a1 10 41 80 00       	mov    0x804110,%eax
  802a96:	40                   	inc    %eax
  802a97:	a3 10 41 80 00       	mov    %eax,0x804110
		ClearNodeData(&(FreeNodes[i]));
  802a9c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802a9f:	89 d0                	mov    %edx,%eax
  802aa1:	01 c0                	add    %eax,%eax
  802aa3:	01 d0                	add    %edx,%eax
  802aa5:	c1 e0 03             	shl    $0x3,%eax
  802aa8:	05 20 41 88 00       	add    $0x884120,%eax
  802aad:	50                   	push   %eax
  802aae:	e8 0b ff ff ff       	call   8029be <ClearNodeData>
  802ab3:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  802ab6:	ff 45 fc             	incl   -0x4(%ebp)
  802ab9:	81 7d fc 3f 9c 00 00 	cmpl   $0x9c3f,-0x4(%ebp)
  802ac0:	0f 8e 3c ff ff ff    	jle    802a02 <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  802ac6:	90                   	nop
  802ac7:	c9                   	leave  
  802ac8:	c3                   	ret    

00802ac9 <CreateNewBuddySpace>:
/*===============================================================*/

//TODO: [PROJECT 2020 - BONUS4] Expand Buddy Free Node List

void CreateNewBuddySpace()
{
  802ac9:	55                   	push   %ebp
  802aca:	89 e5                	mov    %esp,%ebp
  802acc:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Create New Buddy Block]
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  802acf:	83 ec 04             	sub    $0x4,%esp
  802ad2:	68 28 3c 80 00       	push   $0x803c28
  802ad7:	6a 22                	push   $0x22
  802ad9:	68 5a 3c 80 00       	push   $0x803c5a
  802ade:	e8 29 ec ff ff       	call   80170c <_panic>

00802ae3 <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  802ae3:	55                   	push   %ebp
  802ae4:	89 e5                	mov    %esp,%ebp
  802ae6:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Get Allocation]
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  802ae9:	83 ec 04             	sub    $0x4,%esp
  802aec:	68 68 3c 80 00       	push   $0x803c68
  802af1:	6a 2a                	push   $0x2a
  802af3:	68 5a 3c 80 00       	push   $0x803c5a
  802af8:	e8 0f ec ff ff       	call   80170c <_panic>

00802afd <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  802afd:	55                   	push   %ebp
  802afe:	89 e5                	mov    %esp,%ebp
  802b00:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Free Allocation]
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  802b03:	83 ec 04             	sub    $0x4,%esp
  802b06:	68 a0 3c 80 00       	push   $0x803ca0
  802b0b:	6a 31                	push   $0x31
  802b0d:	68 5a 3c 80 00       	push   $0x803c5a
  802b12:	e8 f5 eb ff ff       	call   80170c <_panic>

00802b17 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802b17:	55                   	push   %ebp
  802b18:	89 e5                	mov    %esp,%ebp
  802b1a:	57                   	push   %edi
  802b1b:	56                   	push   %esi
  802b1c:	53                   	push   %ebx
  802b1d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802b20:	8b 45 08             	mov    0x8(%ebp),%eax
  802b23:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b26:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802b29:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802b2c:	8b 7d 18             	mov    0x18(%ebp),%edi
  802b2f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802b32:	cd 30                	int    $0x30
  802b34:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802b37:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802b3a:	83 c4 10             	add    $0x10,%esp
  802b3d:	5b                   	pop    %ebx
  802b3e:	5e                   	pop    %esi
  802b3f:	5f                   	pop    %edi
  802b40:	5d                   	pop    %ebp
  802b41:	c3                   	ret    

00802b42 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802b42:	55                   	push   %ebp
  802b43:	89 e5                	mov    %esp,%ebp
  802b45:	83 ec 04             	sub    $0x4,%esp
  802b48:	8b 45 10             	mov    0x10(%ebp),%eax
  802b4b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802b4e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802b52:	8b 45 08             	mov    0x8(%ebp),%eax
  802b55:	6a 00                	push   $0x0
  802b57:	6a 00                	push   $0x0
  802b59:	52                   	push   %edx
  802b5a:	ff 75 0c             	pushl  0xc(%ebp)
  802b5d:	50                   	push   %eax
  802b5e:	6a 00                	push   $0x0
  802b60:	e8 b2 ff ff ff       	call   802b17 <syscall>
  802b65:	83 c4 18             	add    $0x18,%esp
}
  802b68:	90                   	nop
  802b69:	c9                   	leave  
  802b6a:	c3                   	ret    

00802b6b <sys_cgetc>:

int
sys_cgetc(void)
{
  802b6b:	55                   	push   %ebp
  802b6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802b6e:	6a 00                	push   $0x0
  802b70:	6a 00                	push   $0x0
  802b72:	6a 00                	push   $0x0
  802b74:	6a 00                	push   $0x0
  802b76:	6a 00                	push   $0x0
  802b78:	6a 01                	push   $0x1
  802b7a:	e8 98 ff ff ff       	call   802b17 <syscall>
  802b7f:	83 c4 18             	add    $0x18,%esp
}
  802b82:	c9                   	leave  
  802b83:	c3                   	ret    

00802b84 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802b84:	55                   	push   %ebp
  802b85:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802b87:	8b 45 08             	mov    0x8(%ebp),%eax
  802b8a:	6a 00                	push   $0x0
  802b8c:	6a 00                	push   $0x0
  802b8e:	6a 00                	push   $0x0
  802b90:	6a 00                	push   $0x0
  802b92:	50                   	push   %eax
  802b93:	6a 05                	push   $0x5
  802b95:	e8 7d ff ff ff       	call   802b17 <syscall>
  802b9a:	83 c4 18             	add    $0x18,%esp
}
  802b9d:	c9                   	leave  
  802b9e:	c3                   	ret    

00802b9f <sys_getenvid>:

int32 sys_getenvid(void)
{
  802b9f:	55                   	push   %ebp
  802ba0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802ba2:	6a 00                	push   $0x0
  802ba4:	6a 00                	push   $0x0
  802ba6:	6a 00                	push   $0x0
  802ba8:	6a 00                	push   $0x0
  802baa:	6a 00                	push   $0x0
  802bac:	6a 02                	push   $0x2
  802bae:	e8 64 ff ff ff       	call   802b17 <syscall>
  802bb3:	83 c4 18             	add    $0x18,%esp
}
  802bb6:	c9                   	leave  
  802bb7:	c3                   	ret    

00802bb8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802bb8:	55                   	push   %ebp
  802bb9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802bbb:	6a 00                	push   $0x0
  802bbd:	6a 00                	push   $0x0
  802bbf:	6a 00                	push   $0x0
  802bc1:	6a 00                	push   $0x0
  802bc3:	6a 00                	push   $0x0
  802bc5:	6a 03                	push   $0x3
  802bc7:	e8 4b ff ff ff       	call   802b17 <syscall>
  802bcc:	83 c4 18             	add    $0x18,%esp
}
  802bcf:	c9                   	leave  
  802bd0:	c3                   	ret    

00802bd1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802bd1:	55                   	push   %ebp
  802bd2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802bd4:	6a 00                	push   $0x0
  802bd6:	6a 00                	push   $0x0
  802bd8:	6a 00                	push   $0x0
  802bda:	6a 00                	push   $0x0
  802bdc:	6a 00                	push   $0x0
  802bde:	6a 04                	push   $0x4
  802be0:	e8 32 ff ff ff       	call   802b17 <syscall>
  802be5:	83 c4 18             	add    $0x18,%esp
}
  802be8:	c9                   	leave  
  802be9:	c3                   	ret    

00802bea <sys_env_exit>:


void sys_env_exit(void)
{
  802bea:	55                   	push   %ebp
  802beb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802bed:	6a 00                	push   $0x0
  802bef:	6a 00                	push   $0x0
  802bf1:	6a 00                	push   $0x0
  802bf3:	6a 00                	push   $0x0
  802bf5:	6a 00                	push   $0x0
  802bf7:	6a 06                	push   $0x6
  802bf9:	e8 19 ff ff ff       	call   802b17 <syscall>
  802bfe:	83 c4 18             	add    $0x18,%esp
}
  802c01:	90                   	nop
  802c02:	c9                   	leave  
  802c03:	c3                   	ret    

00802c04 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802c04:	55                   	push   %ebp
  802c05:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802c07:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c0a:	8b 45 08             	mov    0x8(%ebp),%eax
  802c0d:	6a 00                	push   $0x0
  802c0f:	6a 00                	push   $0x0
  802c11:	6a 00                	push   $0x0
  802c13:	52                   	push   %edx
  802c14:	50                   	push   %eax
  802c15:	6a 07                	push   $0x7
  802c17:	e8 fb fe ff ff       	call   802b17 <syscall>
  802c1c:	83 c4 18             	add    $0x18,%esp
}
  802c1f:	c9                   	leave  
  802c20:	c3                   	ret    

00802c21 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802c21:	55                   	push   %ebp
  802c22:	89 e5                	mov    %esp,%ebp
  802c24:	56                   	push   %esi
  802c25:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802c26:	8b 75 18             	mov    0x18(%ebp),%esi
  802c29:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802c2c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802c2f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c32:	8b 45 08             	mov    0x8(%ebp),%eax
  802c35:	56                   	push   %esi
  802c36:	53                   	push   %ebx
  802c37:	51                   	push   %ecx
  802c38:	52                   	push   %edx
  802c39:	50                   	push   %eax
  802c3a:	6a 08                	push   $0x8
  802c3c:	e8 d6 fe ff ff       	call   802b17 <syscall>
  802c41:	83 c4 18             	add    $0x18,%esp
}
  802c44:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802c47:	5b                   	pop    %ebx
  802c48:	5e                   	pop    %esi
  802c49:	5d                   	pop    %ebp
  802c4a:	c3                   	ret    

00802c4b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802c4b:	55                   	push   %ebp
  802c4c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802c4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c51:	8b 45 08             	mov    0x8(%ebp),%eax
  802c54:	6a 00                	push   $0x0
  802c56:	6a 00                	push   $0x0
  802c58:	6a 00                	push   $0x0
  802c5a:	52                   	push   %edx
  802c5b:	50                   	push   %eax
  802c5c:	6a 09                	push   $0x9
  802c5e:	e8 b4 fe ff ff       	call   802b17 <syscall>
  802c63:	83 c4 18             	add    $0x18,%esp
}
  802c66:	c9                   	leave  
  802c67:	c3                   	ret    

00802c68 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802c68:	55                   	push   %ebp
  802c69:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802c6b:	6a 00                	push   $0x0
  802c6d:	6a 00                	push   $0x0
  802c6f:	6a 00                	push   $0x0
  802c71:	ff 75 0c             	pushl  0xc(%ebp)
  802c74:	ff 75 08             	pushl  0x8(%ebp)
  802c77:	6a 0a                	push   $0xa
  802c79:	e8 99 fe ff ff       	call   802b17 <syscall>
  802c7e:	83 c4 18             	add    $0x18,%esp
}
  802c81:	c9                   	leave  
  802c82:	c3                   	ret    

00802c83 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802c83:	55                   	push   %ebp
  802c84:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802c86:	6a 00                	push   $0x0
  802c88:	6a 00                	push   $0x0
  802c8a:	6a 00                	push   $0x0
  802c8c:	6a 00                	push   $0x0
  802c8e:	6a 00                	push   $0x0
  802c90:	6a 0b                	push   $0xb
  802c92:	e8 80 fe ff ff       	call   802b17 <syscall>
  802c97:	83 c4 18             	add    $0x18,%esp
}
  802c9a:	c9                   	leave  
  802c9b:	c3                   	ret    

00802c9c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802c9c:	55                   	push   %ebp
  802c9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802c9f:	6a 00                	push   $0x0
  802ca1:	6a 00                	push   $0x0
  802ca3:	6a 00                	push   $0x0
  802ca5:	6a 00                	push   $0x0
  802ca7:	6a 00                	push   $0x0
  802ca9:	6a 0c                	push   $0xc
  802cab:	e8 67 fe ff ff       	call   802b17 <syscall>
  802cb0:	83 c4 18             	add    $0x18,%esp
}
  802cb3:	c9                   	leave  
  802cb4:	c3                   	ret    

00802cb5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802cb5:	55                   	push   %ebp
  802cb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802cb8:	6a 00                	push   $0x0
  802cba:	6a 00                	push   $0x0
  802cbc:	6a 00                	push   $0x0
  802cbe:	6a 00                	push   $0x0
  802cc0:	6a 00                	push   $0x0
  802cc2:	6a 0d                	push   $0xd
  802cc4:	e8 4e fe ff ff       	call   802b17 <syscall>
  802cc9:	83 c4 18             	add    $0x18,%esp
}
  802ccc:	c9                   	leave  
  802ccd:	c3                   	ret    

00802cce <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802cce:	55                   	push   %ebp
  802ccf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802cd1:	6a 00                	push   $0x0
  802cd3:	6a 00                	push   $0x0
  802cd5:	6a 00                	push   $0x0
  802cd7:	ff 75 0c             	pushl  0xc(%ebp)
  802cda:	ff 75 08             	pushl  0x8(%ebp)
  802cdd:	6a 11                	push   $0x11
  802cdf:	e8 33 fe ff ff       	call   802b17 <syscall>
  802ce4:	83 c4 18             	add    $0x18,%esp
	return;
  802ce7:	90                   	nop
}
  802ce8:	c9                   	leave  
  802ce9:	c3                   	ret    

00802cea <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802cea:	55                   	push   %ebp
  802ceb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802ced:	6a 00                	push   $0x0
  802cef:	6a 00                	push   $0x0
  802cf1:	6a 00                	push   $0x0
  802cf3:	ff 75 0c             	pushl  0xc(%ebp)
  802cf6:	ff 75 08             	pushl  0x8(%ebp)
  802cf9:	6a 12                	push   $0x12
  802cfb:	e8 17 fe ff ff       	call   802b17 <syscall>
  802d00:	83 c4 18             	add    $0x18,%esp
	return ;
  802d03:	90                   	nop
}
  802d04:	c9                   	leave  
  802d05:	c3                   	ret    

00802d06 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802d06:	55                   	push   %ebp
  802d07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802d09:	6a 00                	push   $0x0
  802d0b:	6a 00                	push   $0x0
  802d0d:	6a 00                	push   $0x0
  802d0f:	6a 00                	push   $0x0
  802d11:	6a 00                	push   $0x0
  802d13:	6a 0e                	push   $0xe
  802d15:	e8 fd fd ff ff       	call   802b17 <syscall>
  802d1a:	83 c4 18             	add    $0x18,%esp
}
  802d1d:	c9                   	leave  
  802d1e:	c3                   	ret    

00802d1f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802d1f:	55                   	push   %ebp
  802d20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802d22:	6a 00                	push   $0x0
  802d24:	6a 00                	push   $0x0
  802d26:	6a 00                	push   $0x0
  802d28:	6a 00                	push   $0x0
  802d2a:	ff 75 08             	pushl  0x8(%ebp)
  802d2d:	6a 0f                	push   $0xf
  802d2f:	e8 e3 fd ff ff       	call   802b17 <syscall>
  802d34:	83 c4 18             	add    $0x18,%esp
}
  802d37:	c9                   	leave  
  802d38:	c3                   	ret    

00802d39 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802d39:	55                   	push   %ebp
  802d3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802d3c:	6a 00                	push   $0x0
  802d3e:	6a 00                	push   $0x0
  802d40:	6a 00                	push   $0x0
  802d42:	6a 00                	push   $0x0
  802d44:	6a 00                	push   $0x0
  802d46:	6a 10                	push   $0x10
  802d48:	e8 ca fd ff ff       	call   802b17 <syscall>
  802d4d:	83 c4 18             	add    $0x18,%esp
}
  802d50:	90                   	nop
  802d51:	c9                   	leave  
  802d52:	c3                   	ret    

00802d53 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802d53:	55                   	push   %ebp
  802d54:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802d56:	6a 00                	push   $0x0
  802d58:	6a 00                	push   $0x0
  802d5a:	6a 00                	push   $0x0
  802d5c:	6a 00                	push   $0x0
  802d5e:	6a 00                	push   $0x0
  802d60:	6a 14                	push   $0x14
  802d62:	e8 b0 fd ff ff       	call   802b17 <syscall>
  802d67:	83 c4 18             	add    $0x18,%esp
}
  802d6a:	90                   	nop
  802d6b:	c9                   	leave  
  802d6c:	c3                   	ret    

00802d6d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802d6d:	55                   	push   %ebp
  802d6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802d70:	6a 00                	push   $0x0
  802d72:	6a 00                	push   $0x0
  802d74:	6a 00                	push   $0x0
  802d76:	6a 00                	push   $0x0
  802d78:	6a 00                	push   $0x0
  802d7a:	6a 15                	push   $0x15
  802d7c:	e8 96 fd ff ff       	call   802b17 <syscall>
  802d81:	83 c4 18             	add    $0x18,%esp
}
  802d84:	90                   	nop
  802d85:	c9                   	leave  
  802d86:	c3                   	ret    

00802d87 <sys_cputc>:


void
sys_cputc(const char c)
{
  802d87:	55                   	push   %ebp
  802d88:	89 e5                	mov    %esp,%ebp
  802d8a:	83 ec 04             	sub    $0x4,%esp
  802d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  802d90:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802d93:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802d97:	6a 00                	push   $0x0
  802d99:	6a 00                	push   $0x0
  802d9b:	6a 00                	push   $0x0
  802d9d:	6a 00                	push   $0x0
  802d9f:	50                   	push   %eax
  802da0:	6a 16                	push   $0x16
  802da2:	e8 70 fd ff ff       	call   802b17 <syscall>
  802da7:	83 c4 18             	add    $0x18,%esp
}
  802daa:	90                   	nop
  802dab:	c9                   	leave  
  802dac:	c3                   	ret    

00802dad <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802dad:	55                   	push   %ebp
  802dae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802db0:	6a 00                	push   $0x0
  802db2:	6a 00                	push   $0x0
  802db4:	6a 00                	push   $0x0
  802db6:	6a 00                	push   $0x0
  802db8:	6a 00                	push   $0x0
  802dba:	6a 17                	push   $0x17
  802dbc:	e8 56 fd ff ff       	call   802b17 <syscall>
  802dc1:	83 c4 18             	add    $0x18,%esp
}
  802dc4:	90                   	nop
  802dc5:	c9                   	leave  
  802dc6:	c3                   	ret    

00802dc7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802dc7:	55                   	push   %ebp
  802dc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802dca:	8b 45 08             	mov    0x8(%ebp),%eax
  802dcd:	6a 00                	push   $0x0
  802dcf:	6a 00                	push   $0x0
  802dd1:	6a 00                	push   $0x0
  802dd3:	ff 75 0c             	pushl  0xc(%ebp)
  802dd6:	50                   	push   %eax
  802dd7:	6a 18                	push   $0x18
  802dd9:	e8 39 fd ff ff       	call   802b17 <syscall>
  802dde:	83 c4 18             	add    $0x18,%esp
}
  802de1:	c9                   	leave  
  802de2:	c3                   	ret    

00802de3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802de3:	55                   	push   %ebp
  802de4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802de6:	8b 55 0c             	mov    0xc(%ebp),%edx
  802de9:	8b 45 08             	mov    0x8(%ebp),%eax
  802dec:	6a 00                	push   $0x0
  802dee:	6a 00                	push   $0x0
  802df0:	6a 00                	push   $0x0
  802df2:	52                   	push   %edx
  802df3:	50                   	push   %eax
  802df4:	6a 1b                	push   $0x1b
  802df6:	e8 1c fd ff ff       	call   802b17 <syscall>
  802dfb:	83 c4 18             	add    $0x18,%esp
}
  802dfe:	c9                   	leave  
  802dff:	c3                   	ret    

00802e00 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802e00:	55                   	push   %ebp
  802e01:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e03:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e06:	8b 45 08             	mov    0x8(%ebp),%eax
  802e09:	6a 00                	push   $0x0
  802e0b:	6a 00                	push   $0x0
  802e0d:	6a 00                	push   $0x0
  802e0f:	52                   	push   %edx
  802e10:	50                   	push   %eax
  802e11:	6a 19                	push   $0x19
  802e13:	e8 ff fc ff ff       	call   802b17 <syscall>
  802e18:	83 c4 18             	add    $0x18,%esp
}
  802e1b:	90                   	nop
  802e1c:	c9                   	leave  
  802e1d:	c3                   	ret    

00802e1e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802e1e:	55                   	push   %ebp
  802e1f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e21:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e24:	8b 45 08             	mov    0x8(%ebp),%eax
  802e27:	6a 00                	push   $0x0
  802e29:	6a 00                	push   $0x0
  802e2b:	6a 00                	push   $0x0
  802e2d:	52                   	push   %edx
  802e2e:	50                   	push   %eax
  802e2f:	6a 1a                	push   $0x1a
  802e31:	e8 e1 fc ff ff       	call   802b17 <syscall>
  802e36:	83 c4 18             	add    $0x18,%esp
}
  802e39:	90                   	nop
  802e3a:	c9                   	leave  
  802e3b:	c3                   	ret    

00802e3c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802e3c:	55                   	push   %ebp
  802e3d:	89 e5                	mov    %esp,%ebp
  802e3f:	83 ec 04             	sub    $0x4,%esp
  802e42:	8b 45 10             	mov    0x10(%ebp),%eax
  802e45:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802e48:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802e4b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802e4f:	8b 45 08             	mov    0x8(%ebp),%eax
  802e52:	6a 00                	push   $0x0
  802e54:	51                   	push   %ecx
  802e55:	52                   	push   %edx
  802e56:	ff 75 0c             	pushl  0xc(%ebp)
  802e59:	50                   	push   %eax
  802e5a:	6a 1c                	push   $0x1c
  802e5c:	e8 b6 fc ff ff       	call   802b17 <syscall>
  802e61:	83 c4 18             	add    $0x18,%esp
}
  802e64:	c9                   	leave  
  802e65:	c3                   	ret    

00802e66 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802e66:	55                   	push   %ebp
  802e67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802e69:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  802e6f:	6a 00                	push   $0x0
  802e71:	6a 00                	push   $0x0
  802e73:	6a 00                	push   $0x0
  802e75:	52                   	push   %edx
  802e76:	50                   	push   %eax
  802e77:	6a 1d                	push   $0x1d
  802e79:	e8 99 fc ff ff       	call   802b17 <syscall>
  802e7e:	83 c4 18             	add    $0x18,%esp
}
  802e81:	c9                   	leave  
  802e82:	c3                   	ret    

00802e83 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802e83:	55                   	push   %ebp
  802e84:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802e86:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802e89:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  802e8f:	6a 00                	push   $0x0
  802e91:	6a 00                	push   $0x0
  802e93:	51                   	push   %ecx
  802e94:	52                   	push   %edx
  802e95:	50                   	push   %eax
  802e96:	6a 1e                	push   $0x1e
  802e98:	e8 7a fc ff ff       	call   802b17 <syscall>
  802e9d:	83 c4 18             	add    $0x18,%esp
}
  802ea0:	c9                   	leave  
  802ea1:	c3                   	ret    

00802ea2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802ea2:	55                   	push   %ebp
  802ea3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802ea5:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  802eab:	6a 00                	push   $0x0
  802ead:	6a 00                	push   $0x0
  802eaf:	6a 00                	push   $0x0
  802eb1:	52                   	push   %edx
  802eb2:	50                   	push   %eax
  802eb3:	6a 1f                	push   $0x1f
  802eb5:	e8 5d fc ff ff       	call   802b17 <syscall>
  802eba:	83 c4 18             	add    $0x18,%esp
}
  802ebd:	c9                   	leave  
  802ebe:	c3                   	ret    

00802ebf <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802ebf:	55                   	push   %ebp
  802ec0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802ec2:	6a 00                	push   $0x0
  802ec4:	6a 00                	push   $0x0
  802ec6:	6a 00                	push   $0x0
  802ec8:	6a 00                	push   $0x0
  802eca:	6a 00                	push   $0x0
  802ecc:	6a 20                	push   $0x20
  802ece:	e8 44 fc ff ff       	call   802b17 <syscall>
  802ed3:	83 c4 18             	add    $0x18,%esp
}
  802ed6:	c9                   	leave  
  802ed7:	c3                   	ret    

00802ed8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802ed8:	55                   	push   %ebp
  802ed9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802edb:	8b 45 08             	mov    0x8(%ebp),%eax
  802ede:	6a 00                	push   $0x0
  802ee0:	ff 75 14             	pushl  0x14(%ebp)
  802ee3:	ff 75 10             	pushl  0x10(%ebp)
  802ee6:	ff 75 0c             	pushl  0xc(%ebp)
  802ee9:	50                   	push   %eax
  802eea:	6a 21                	push   $0x21
  802eec:	e8 26 fc ff ff       	call   802b17 <syscall>
  802ef1:	83 c4 18             	add    $0x18,%esp
}
  802ef4:	c9                   	leave  
  802ef5:	c3                   	ret    

00802ef6 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802ef6:	55                   	push   %ebp
  802ef7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  802efc:	6a 00                	push   $0x0
  802efe:	6a 00                	push   $0x0
  802f00:	6a 00                	push   $0x0
  802f02:	6a 00                	push   $0x0
  802f04:	50                   	push   %eax
  802f05:	6a 22                	push   $0x22
  802f07:	e8 0b fc ff ff       	call   802b17 <syscall>
  802f0c:	83 c4 18             	add    $0x18,%esp
}
  802f0f:	90                   	nop
  802f10:	c9                   	leave  
  802f11:	c3                   	ret    

00802f12 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802f12:	55                   	push   %ebp
  802f13:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802f15:	8b 45 08             	mov    0x8(%ebp),%eax
  802f18:	6a 00                	push   $0x0
  802f1a:	6a 00                	push   $0x0
  802f1c:	6a 00                	push   $0x0
  802f1e:	6a 00                	push   $0x0
  802f20:	50                   	push   %eax
  802f21:	6a 23                	push   $0x23
  802f23:	e8 ef fb ff ff       	call   802b17 <syscall>
  802f28:	83 c4 18             	add    $0x18,%esp
}
  802f2b:	90                   	nop
  802f2c:	c9                   	leave  
  802f2d:	c3                   	ret    

00802f2e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802f2e:	55                   	push   %ebp
  802f2f:	89 e5                	mov    %esp,%ebp
  802f31:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802f34:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802f37:	8d 50 04             	lea    0x4(%eax),%edx
  802f3a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802f3d:	6a 00                	push   $0x0
  802f3f:	6a 00                	push   $0x0
  802f41:	6a 00                	push   $0x0
  802f43:	52                   	push   %edx
  802f44:	50                   	push   %eax
  802f45:	6a 24                	push   $0x24
  802f47:	e8 cb fb ff ff       	call   802b17 <syscall>
  802f4c:	83 c4 18             	add    $0x18,%esp
	return result;
  802f4f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802f52:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802f55:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802f58:	89 01                	mov    %eax,(%ecx)
  802f5a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  802f60:	c9                   	leave  
  802f61:	c2 04 00             	ret    $0x4

00802f64 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802f64:	55                   	push   %ebp
  802f65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802f67:	6a 00                	push   $0x0
  802f69:	6a 00                	push   $0x0
  802f6b:	ff 75 10             	pushl  0x10(%ebp)
  802f6e:	ff 75 0c             	pushl  0xc(%ebp)
  802f71:	ff 75 08             	pushl  0x8(%ebp)
  802f74:	6a 13                	push   $0x13
  802f76:	e8 9c fb ff ff       	call   802b17 <syscall>
  802f7b:	83 c4 18             	add    $0x18,%esp
	return ;
  802f7e:	90                   	nop
}
  802f7f:	c9                   	leave  
  802f80:	c3                   	ret    

00802f81 <sys_rcr2>:
uint32 sys_rcr2()
{
  802f81:	55                   	push   %ebp
  802f82:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802f84:	6a 00                	push   $0x0
  802f86:	6a 00                	push   $0x0
  802f88:	6a 00                	push   $0x0
  802f8a:	6a 00                	push   $0x0
  802f8c:	6a 00                	push   $0x0
  802f8e:	6a 25                	push   $0x25
  802f90:	e8 82 fb ff ff       	call   802b17 <syscall>
  802f95:	83 c4 18             	add    $0x18,%esp
}
  802f98:	c9                   	leave  
  802f99:	c3                   	ret    

00802f9a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802f9a:	55                   	push   %ebp
  802f9b:	89 e5                	mov    %esp,%ebp
  802f9d:	83 ec 04             	sub    $0x4,%esp
  802fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  802fa3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802fa6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802faa:	6a 00                	push   $0x0
  802fac:	6a 00                	push   $0x0
  802fae:	6a 00                	push   $0x0
  802fb0:	6a 00                	push   $0x0
  802fb2:	50                   	push   %eax
  802fb3:	6a 26                	push   $0x26
  802fb5:	e8 5d fb ff ff       	call   802b17 <syscall>
  802fba:	83 c4 18             	add    $0x18,%esp
	return ;
  802fbd:	90                   	nop
}
  802fbe:	c9                   	leave  
  802fbf:	c3                   	ret    

00802fc0 <rsttst>:
void rsttst()
{
  802fc0:	55                   	push   %ebp
  802fc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802fc3:	6a 00                	push   $0x0
  802fc5:	6a 00                	push   $0x0
  802fc7:	6a 00                	push   $0x0
  802fc9:	6a 00                	push   $0x0
  802fcb:	6a 00                	push   $0x0
  802fcd:	6a 28                	push   $0x28
  802fcf:	e8 43 fb ff ff       	call   802b17 <syscall>
  802fd4:	83 c4 18             	add    $0x18,%esp
	return ;
  802fd7:	90                   	nop
}
  802fd8:	c9                   	leave  
  802fd9:	c3                   	ret    

00802fda <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802fda:	55                   	push   %ebp
  802fdb:	89 e5                	mov    %esp,%ebp
  802fdd:	83 ec 04             	sub    $0x4,%esp
  802fe0:	8b 45 14             	mov    0x14(%ebp),%eax
  802fe3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802fe6:	8b 55 18             	mov    0x18(%ebp),%edx
  802fe9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802fed:	52                   	push   %edx
  802fee:	50                   	push   %eax
  802fef:	ff 75 10             	pushl  0x10(%ebp)
  802ff2:	ff 75 0c             	pushl  0xc(%ebp)
  802ff5:	ff 75 08             	pushl  0x8(%ebp)
  802ff8:	6a 27                	push   $0x27
  802ffa:	e8 18 fb ff ff       	call   802b17 <syscall>
  802fff:	83 c4 18             	add    $0x18,%esp
	return ;
  803002:	90                   	nop
}
  803003:	c9                   	leave  
  803004:	c3                   	ret    

00803005 <chktst>:
void chktst(uint32 n)
{
  803005:	55                   	push   %ebp
  803006:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  803008:	6a 00                	push   $0x0
  80300a:	6a 00                	push   $0x0
  80300c:	6a 00                	push   $0x0
  80300e:	6a 00                	push   $0x0
  803010:	ff 75 08             	pushl  0x8(%ebp)
  803013:	6a 29                	push   $0x29
  803015:	e8 fd fa ff ff       	call   802b17 <syscall>
  80301a:	83 c4 18             	add    $0x18,%esp
	return ;
  80301d:	90                   	nop
}
  80301e:	c9                   	leave  
  80301f:	c3                   	ret    

00803020 <inctst>:

void inctst()
{
  803020:	55                   	push   %ebp
  803021:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  803023:	6a 00                	push   $0x0
  803025:	6a 00                	push   $0x0
  803027:	6a 00                	push   $0x0
  803029:	6a 00                	push   $0x0
  80302b:	6a 00                	push   $0x0
  80302d:	6a 2a                	push   $0x2a
  80302f:	e8 e3 fa ff ff       	call   802b17 <syscall>
  803034:	83 c4 18             	add    $0x18,%esp
	return ;
  803037:	90                   	nop
}
  803038:	c9                   	leave  
  803039:	c3                   	ret    

0080303a <gettst>:
uint32 gettst()
{
  80303a:	55                   	push   %ebp
  80303b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80303d:	6a 00                	push   $0x0
  80303f:	6a 00                	push   $0x0
  803041:	6a 00                	push   $0x0
  803043:	6a 00                	push   $0x0
  803045:	6a 00                	push   $0x0
  803047:	6a 2b                	push   $0x2b
  803049:	e8 c9 fa ff ff       	call   802b17 <syscall>
  80304e:	83 c4 18             	add    $0x18,%esp
}
  803051:	c9                   	leave  
  803052:	c3                   	ret    

00803053 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  803053:	55                   	push   %ebp
  803054:	89 e5                	mov    %esp,%ebp
  803056:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803059:	6a 00                	push   $0x0
  80305b:	6a 00                	push   $0x0
  80305d:	6a 00                	push   $0x0
  80305f:	6a 00                	push   $0x0
  803061:	6a 00                	push   $0x0
  803063:	6a 2c                	push   $0x2c
  803065:	e8 ad fa ff ff       	call   802b17 <syscall>
  80306a:	83 c4 18             	add    $0x18,%esp
  80306d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  803070:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  803074:	75 07                	jne    80307d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  803076:	b8 01 00 00 00       	mov    $0x1,%eax
  80307b:	eb 05                	jmp    803082 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80307d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803082:	c9                   	leave  
  803083:	c3                   	ret    

00803084 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  803084:	55                   	push   %ebp
  803085:	89 e5                	mov    %esp,%ebp
  803087:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80308a:	6a 00                	push   $0x0
  80308c:	6a 00                	push   $0x0
  80308e:	6a 00                	push   $0x0
  803090:	6a 00                	push   $0x0
  803092:	6a 00                	push   $0x0
  803094:	6a 2c                	push   $0x2c
  803096:	e8 7c fa ff ff       	call   802b17 <syscall>
  80309b:	83 c4 18             	add    $0x18,%esp
  80309e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8030a1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8030a5:	75 07                	jne    8030ae <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8030a7:	b8 01 00 00 00       	mov    $0x1,%eax
  8030ac:	eb 05                	jmp    8030b3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8030ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8030b3:	c9                   	leave  
  8030b4:	c3                   	ret    

008030b5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8030b5:	55                   	push   %ebp
  8030b6:	89 e5                	mov    %esp,%ebp
  8030b8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8030bb:	6a 00                	push   $0x0
  8030bd:	6a 00                	push   $0x0
  8030bf:	6a 00                	push   $0x0
  8030c1:	6a 00                	push   $0x0
  8030c3:	6a 00                	push   $0x0
  8030c5:	6a 2c                	push   $0x2c
  8030c7:	e8 4b fa ff ff       	call   802b17 <syscall>
  8030cc:	83 c4 18             	add    $0x18,%esp
  8030cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8030d2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8030d6:	75 07                	jne    8030df <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8030d8:	b8 01 00 00 00       	mov    $0x1,%eax
  8030dd:	eb 05                	jmp    8030e4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8030df:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8030e4:	c9                   	leave  
  8030e5:	c3                   	ret    

008030e6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8030e6:	55                   	push   %ebp
  8030e7:	89 e5                	mov    %esp,%ebp
  8030e9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8030ec:	6a 00                	push   $0x0
  8030ee:	6a 00                	push   $0x0
  8030f0:	6a 00                	push   $0x0
  8030f2:	6a 00                	push   $0x0
  8030f4:	6a 00                	push   $0x0
  8030f6:	6a 2c                	push   $0x2c
  8030f8:	e8 1a fa ff ff       	call   802b17 <syscall>
  8030fd:	83 c4 18             	add    $0x18,%esp
  803100:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  803103:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  803107:	75 07                	jne    803110 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  803109:	b8 01 00 00 00       	mov    $0x1,%eax
  80310e:	eb 05                	jmp    803115 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  803110:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803115:	c9                   	leave  
  803116:	c3                   	ret    

00803117 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  803117:	55                   	push   %ebp
  803118:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80311a:	6a 00                	push   $0x0
  80311c:	6a 00                	push   $0x0
  80311e:	6a 00                	push   $0x0
  803120:	6a 00                	push   $0x0
  803122:	ff 75 08             	pushl  0x8(%ebp)
  803125:	6a 2d                	push   $0x2d
  803127:	e8 eb f9 ff ff       	call   802b17 <syscall>
  80312c:	83 c4 18             	add    $0x18,%esp
	return ;
  80312f:	90                   	nop
}
  803130:	c9                   	leave  
  803131:	c3                   	ret    

00803132 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  803132:	55                   	push   %ebp
  803133:	89 e5                	mov    %esp,%ebp
  803135:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  803136:	8b 5d 14             	mov    0x14(%ebp),%ebx
  803139:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80313c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80313f:	8b 45 08             	mov    0x8(%ebp),%eax
  803142:	6a 00                	push   $0x0
  803144:	53                   	push   %ebx
  803145:	51                   	push   %ecx
  803146:	52                   	push   %edx
  803147:	50                   	push   %eax
  803148:	6a 2e                	push   $0x2e
  80314a:	e8 c8 f9 ff ff       	call   802b17 <syscall>
  80314f:	83 c4 18             	add    $0x18,%esp
}
  803152:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  803155:	c9                   	leave  
  803156:	c3                   	ret    

00803157 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  803157:	55                   	push   %ebp
  803158:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80315a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80315d:	8b 45 08             	mov    0x8(%ebp),%eax
  803160:	6a 00                	push   $0x0
  803162:	6a 00                	push   $0x0
  803164:	6a 00                	push   $0x0
  803166:	52                   	push   %edx
  803167:	50                   	push   %eax
  803168:	6a 2f                	push   $0x2f
  80316a:	e8 a8 f9 ff ff       	call   802b17 <syscall>
  80316f:	83 c4 18             	add    $0x18,%esp
}
  803172:	c9                   	leave  
  803173:	c3                   	ret    

00803174 <__udivdi3>:
  803174:	55                   	push   %ebp
  803175:	57                   	push   %edi
  803176:	56                   	push   %esi
  803177:	53                   	push   %ebx
  803178:	83 ec 1c             	sub    $0x1c,%esp
  80317b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80317f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  803183:	8b 7c 24 38          	mov    0x38(%esp),%edi
  803187:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80318b:	89 ca                	mov    %ecx,%edx
  80318d:	89 f8                	mov    %edi,%eax
  80318f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  803193:	85 f6                	test   %esi,%esi
  803195:	75 2d                	jne    8031c4 <__udivdi3+0x50>
  803197:	39 cf                	cmp    %ecx,%edi
  803199:	77 65                	ja     803200 <__udivdi3+0x8c>
  80319b:	89 fd                	mov    %edi,%ebp
  80319d:	85 ff                	test   %edi,%edi
  80319f:	75 0b                	jne    8031ac <__udivdi3+0x38>
  8031a1:	b8 01 00 00 00       	mov    $0x1,%eax
  8031a6:	31 d2                	xor    %edx,%edx
  8031a8:	f7 f7                	div    %edi
  8031aa:	89 c5                	mov    %eax,%ebp
  8031ac:	31 d2                	xor    %edx,%edx
  8031ae:	89 c8                	mov    %ecx,%eax
  8031b0:	f7 f5                	div    %ebp
  8031b2:	89 c1                	mov    %eax,%ecx
  8031b4:	89 d8                	mov    %ebx,%eax
  8031b6:	f7 f5                	div    %ebp
  8031b8:	89 cf                	mov    %ecx,%edi
  8031ba:	89 fa                	mov    %edi,%edx
  8031bc:	83 c4 1c             	add    $0x1c,%esp
  8031bf:	5b                   	pop    %ebx
  8031c0:	5e                   	pop    %esi
  8031c1:	5f                   	pop    %edi
  8031c2:	5d                   	pop    %ebp
  8031c3:	c3                   	ret    
  8031c4:	39 ce                	cmp    %ecx,%esi
  8031c6:	77 28                	ja     8031f0 <__udivdi3+0x7c>
  8031c8:	0f bd fe             	bsr    %esi,%edi
  8031cb:	83 f7 1f             	xor    $0x1f,%edi
  8031ce:	75 40                	jne    803210 <__udivdi3+0x9c>
  8031d0:	39 ce                	cmp    %ecx,%esi
  8031d2:	72 0a                	jb     8031de <__udivdi3+0x6a>
  8031d4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8031d8:	0f 87 9e 00 00 00    	ja     80327c <__udivdi3+0x108>
  8031de:	b8 01 00 00 00       	mov    $0x1,%eax
  8031e3:	89 fa                	mov    %edi,%edx
  8031e5:	83 c4 1c             	add    $0x1c,%esp
  8031e8:	5b                   	pop    %ebx
  8031e9:	5e                   	pop    %esi
  8031ea:	5f                   	pop    %edi
  8031eb:	5d                   	pop    %ebp
  8031ec:	c3                   	ret    
  8031ed:	8d 76 00             	lea    0x0(%esi),%esi
  8031f0:	31 ff                	xor    %edi,%edi
  8031f2:	31 c0                	xor    %eax,%eax
  8031f4:	89 fa                	mov    %edi,%edx
  8031f6:	83 c4 1c             	add    $0x1c,%esp
  8031f9:	5b                   	pop    %ebx
  8031fa:	5e                   	pop    %esi
  8031fb:	5f                   	pop    %edi
  8031fc:	5d                   	pop    %ebp
  8031fd:	c3                   	ret    
  8031fe:	66 90                	xchg   %ax,%ax
  803200:	89 d8                	mov    %ebx,%eax
  803202:	f7 f7                	div    %edi
  803204:	31 ff                	xor    %edi,%edi
  803206:	89 fa                	mov    %edi,%edx
  803208:	83 c4 1c             	add    $0x1c,%esp
  80320b:	5b                   	pop    %ebx
  80320c:	5e                   	pop    %esi
  80320d:	5f                   	pop    %edi
  80320e:	5d                   	pop    %ebp
  80320f:	c3                   	ret    
  803210:	bd 20 00 00 00       	mov    $0x20,%ebp
  803215:	89 eb                	mov    %ebp,%ebx
  803217:	29 fb                	sub    %edi,%ebx
  803219:	89 f9                	mov    %edi,%ecx
  80321b:	d3 e6                	shl    %cl,%esi
  80321d:	89 c5                	mov    %eax,%ebp
  80321f:	88 d9                	mov    %bl,%cl
  803221:	d3 ed                	shr    %cl,%ebp
  803223:	89 e9                	mov    %ebp,%ecx
  803225:	09 f1                	or     %esi,%ecx
  803227:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80322b:	89 f9                	mov    %edi,%ecx
  80322d:	d3 e0                	shl    %cl,%eax
  80322f:	89 c5                	mov    %eax,%ebp
  803231:	89 d6                	mov    %edx,%esi
  803233:	88 d9                	mov    %bl,%cl
  803235:	d3 ee                	shr    %cl,%esi
  803237:	89 f9                	mov    %edi,%ecx
  803239:	d3 e2                	shl    %cl,%edx
  80323b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80323f:	88 d9                	mov    %bl,%cl
  803241:	d3 e8                	shr    %cl,%eax
  803243:	09 c2                	or     %eax,%edx
  803245:	89 d0                	mov    %edx,%eax
  803247:	89 f2                	mov    %esi,%edx
  803249:	f7 74 24 0c          	divl   0xc(%esp)
  80324d:	89 d6                	mov    %edx,%esi
  80324f:	89 c3                	mov    %eax,%ebx
  803251:	f7 e5                	mul    %ebp
  803253:	39 d6                	cmp    %edx,%esi
  803255:	72 19                	jb     803270 <__udivdi3+0xfc>
  803257:	74 0b                	je     803264 <__udivdi3+0xf0>
  803259:	89 d8                	mov    %ebx,%eax
  80325b:	31 ff                	xor    %edi,%edi
  80325d:	e9 58 ff ff ff       	jmp    8031ba <__udivdi3+0x46>
  803262:	66 90                	xchg   %ax,%ax
  803264:	8b 54 24 08          	mov    0x8(%esp),%edx
  803268:	89 f9                	mov    %edi,%ecx
  80326a:	d3 e2                	shl    %cl,%edx
  80326c:	39 c2                	cmp    %eax,%edx
  80326e:	73 e9                	jae    803259 <__udivdi3+0xe5>
  803270:	8d 43 ff             	lea    -0x1(%ebx),%eax
  803273:	31 ff                	xor    %edi,%edi
  803275:	e9 40 ff ff ff       	jmp    8031ba <__udivdi3+0x46>
  80327a:	66 90                	xchg   %ax,%ax
  80327c:	31 c0                	xor    %eax,%eax
  80327e:	e9 37 ff ff ff       	jmp    8031ba <__udivdi3+0x46>
  803283:	90                   	nop

00803284 <__umoddi3>:
  803284:	55                   	push   %ebp
  803285:	57                   	push   %edi
  803286:	56                   	push   %esi
  803287:	53                   	push   %ebx
  803288:	83 ec 1c             	sub    $0x1c,%esp
  80328b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80328f:	8b 74 24 34          	mov    0x34(%esp),%esi
  803293:	8b 7c 24 38          	mov    0x38(%esp),%edi
  803297:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80329b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80329f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8032a3:	89 f3                	mov    %esi,%ebx
  8032a5:	89 fa                	mov    %edi,%edx
  8032a7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8032ab:	89 34 24             	mov    %esi,(%esp)
  8032ae:	85 c0                	test   %eax,%eax
  8032b0:	75 1a                	jne    8032cc <__umoddi3+0x48>
  8032b2:	39 f7                	cmp    %esi,%edi
  8032b4:	0f 86 a2 00 00 00    	jbe    80335c <__umoddi3+0xd8>
  8032ba:	89 c8                	mov    %ecx,%eax
  8032bc:	89 f2                	mov    %esi,%edx
  8032be:	f7 f7                	div    %edi
  8032c0:	89 d0                	mov    %edx,%eax
  8032c2:	31 d2                	xor    %edx,%edx
  8032c4:	83 c4 1c             	add    $0x1c,%esp
  8032c7:	5b                   	pop    %ebx
  8032c8:	5e                   	pop    %esi
  8032c9:	5f                   	pop    %edi
  8032ca:	5d                   	pop    %ebp
  8032cb:	c3                   	ret    
  8032cc:	39 f0                	cmp    %esi,%eax
  8032ce:	0f 87 ac 00 00 00    	ja     803380 <__umoddi3+0xfc>
  8032d4:	0f bd e8             	bsr    %eax,%ebp
  8032d7:	83 f5 1f             	xor    $0x1f,%ebp
  8032da:	0f 84 ac 00 00 00    	je     80338c <__umoddi3+0x108>
  8032e0:	bf 20 00 00 00       	mov    $0x20,%edi
  8032e5:	29 ef                	sub    %ebp,%edi
  8032e7:	89 fe                	mov    %edi,%esi
  8032e9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8032ed:	89 e9                	mov    %ebp,%ecx
  8032ef:	d3 e0                	shl    %cl,%eax
  8032f1:	89 d7                	mov    %edx,%edi
  8032f3:	89 f1                	mov    %esi,%ecx
  8032f5:	d3 ef                	shr    %cl,%edi
  8032f7:	09 c7                	or     %eax,%edi
  8032f9:	89 e9                	mov    %ebp,%ecx
  8032fb:	d3 e2                	shl    %cl,%edx
  8032fd:	89 14 24             	mov    %edx,(%esp)
  803300:	89 d8                	mov    %ebx,%eax
  803302:	d3 e0                	shl    %cl,%eax
  803304:	89 c2                	mov    %eax,%edx
  803306:	8b 44 24 08          	mov    0x8(%esp),%eax
  80330a:	d3 e0                	shl    %cl,%eax
  80330c:	89 44 24 04          	mov    %eax,0x4(%esp)
  803310:	8b 44 24 08          	mov    0x8(%esp),%eax
  803314:	89 f1                	mov    %esi,%ecx
  803316:	d3 e8                	shr    %cl,%eax
  803318:	09 d0                	or     %edx,%eax
  80331a:	d3 eb                	shr    %cl,%ebx
  80331c:	89 da                	mov    %ebx,%edx
  80331e:	f7 f7                	div    %edi
  803320:	89 d3                	mov    %edx,%ebx
  803322:	f7 24 24             	mull   (%esp)
  803325:	89 c6                	mov    %eax,%esi
  803327:	89 d1                	mov    %edx,%ecx
  803329:	39 d3                	cmp    %edx,%ebx
  80332b:	0f 82 87 00 00 00    	jb     8033b8 <__umoddi3+0x134>
  803331:	0f 84 91 00 00 00    	je     8033c8 <__umoddi3+0x144>
  803337:	8b 54 24 04          	mov    0x4(%esp),%edx
  80333b:	29 f2                	sub    %esi,%edx
  80333d:	19 cb                	sbb    %ecx,%ebx
  80333f:	89 d8                	mov    %ebx,%eax
  803341:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  803345:	d3 e0                	shl    %cl,%eax
  803347:	89 e9                	mov    %ebp,%ecx
  803349:	d3 ea                	shr    %cl,%edx
  80334b:	09 d0                	or     %edx,%eax
  80334d:	89 e9                	mov    %ebp,%ecx
  80334f:	d3 eb                	shr    %cl,%ebx
  803351:	89 da                	mov    %ebx,%edx
  803353:	83 c4 1c             	add    $0x1c,%esp
  803356:	5b                   	pop    %ebx
  803357:	5e                   	pop    %esi
  803358:	5f                   	pop    %edi
  803359:	5d                   	pop    %ebp
  80335a:	c3                   	ret    
  80335b:	90                   	nop
  80335c:	89 fd                	mov    %edi,%ebp
  80335e:	85 ff                	test   %edi,%edi
  803360:	75 0b                	jne    80336d <__umoddi3+0xe9>
  803362:	b8 01 00 00 00       	mov    $0x1,%eax
  803367:	31 d2                	xor    %edx,%edx
  803369:	f7 f7                	div    %edi
  80336b:	89 c5                	mov    %eax,%ebp
  80336d:	89 f0                	mov    %esi,%eax
  80336f:	31 d2                	xor    %edx,%edx
  803371:	f7 f5                	div    %ebp
  803373:	89 c8                	mov    %ecx,%eax
  803375:	f7 f5                	div    %ebp
  803377:	89 d0                	mov    %edx,%eax
  803379:	e9 44 ff ff ff       	jmp    8032c2 <__umoddi3+0x3e>
  80337e:	66 90                	xchg   %ax,%ax
  803380:	89 c8                	mov    %ecx,%eax
  803382:	89 f2                	mov    %esi,%edx
  803384:	83 c4 1c             	add    $0x1c,%esp
  803387:	5b                   	pop    %ebx
  803388:	5e                   	pop    %esi
  803389:	5f                   	pop    %edi
  80338a:	5d                   	pop    %ebp
  80338b:	c3                   	ret    
  80338c:	3b 04 24             	cmp    (%esp),%eax
  80338f:	72 06                	jb     803397 <__umoddi3+0x113>
  803391:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  803395:	77 0f                	ja     8033a6 <__umoddi3+0x122>
  803397:	89 f2                	mov    %esi,%edx
  803399:	29 f9                	sub    %edi,%ecx
  80339b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80339f:	89 14 24             	mov    %edx,(%esp)
  8033a2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8033a6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8033aa:	8b 14 24             	mov    (%esp),%edx
  8033ad:	83 c4 1c             	add    $0x1c,%esp
  8033b0:	5b                   	pop    %ebx
  8033b1:	5e                   	pop    %esi
  8033b2:	5f                   	pop    %edi
  8033b3:	5d                   	pop    %ebp
  8033b4:	c3                   	ret    
  8033b5:	8d 76 00             	lea    0x0(%esi),%esi
  8033b8:	2b 04 24             	sub    (%esp),%eax
  8033bb:	19 fa                	sbb    %edi,%edx
  8033bd:	89 d1                	mov    %edx,%ecx
  8033bf:	89 c6                	mov    %eax,%esi
  8033c1:	e9 71 ff ff ff       	jmp    803337 <__umoddi3+0xb3>
  8033c6:	66 90                	xchg   %ax,%ax
  8033c8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8033cc:	72 ea                	jb     8033b8 <__umoddi3+0x134>
  8033ce:	89 d9                	mov    %ebx,%ecx
  8033d0:	e9 62 ff ff ff       	jmp    803337 <__umoddi3+0xb3>
