
obj/user/tst_malloc_3:     file format elf32-i386


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
  800031:	e8 39 0e 00 00       	call   800e6f <libmain>
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
  80003d:	81 ec 20 01 00 00    	sub    $0x120,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800043:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800047:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004e:	eb 2a                	jmp    80007a <_main+0x42>
		{
			if (myEnv->__uptr_pws[i].empty)
  800050:	a1 20 40 80 00       	mov    0x804020,%eax
  800055:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80005b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005e:	89 d0                	mov    %edx,%eax
  800060:	c1 e0 02             	shl    $0x2,%eax
  800063:	01 d0                	add    %edx,%eax
  800065:	c1 e0 02             	shl    $0x2,%eax
  800068:	01 c8                	add    %ecx,%eax
  80006a:	8a 40 04             	mov    0x4(%eax),%al
  80006d:	84 c0                	test   %al,%al
  80006f:	74 06                	je     800077 <_main+0x3f>
			{
				fullWS = 0;
  800071:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800075:	eb 12                	jmp    800089 <_main+0x51>
void _main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800077:	ff 45 f0             	incl   -0x10(%ebp)
  80007a:	a1 20 40 80 00       	mov    0x804020,%eax
  80007f:	8b 50 74             	mov    0x74(%eax),%edx
  800082:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800085:	39 c2                	cmp    %eax,%edx
  800087:	77 c7                	ja     800050 <_main+0x18>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800089:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80008d:	74 14                	je     8000a3 <_main+0x6b>
  80008f:	83 ec 04             	sub    $0x4,%esp
  800092:	68 c0 2c 80 00       	push   $0x802cc0
  800097:	6a 1a                	push   $0x1a
  800099:	68 dc 2c 80 00       	push   $0x802cdc
  80009e:	e8 f4 0e 00 00       	call   800f97 <_panic>


	
	

	int Mega = 1024*1024;
  8000a3:	c7 45 e4 00 00 10 00 	movl   $0x100000,-0x1c(%ebp)
	int kilo = 1024;
  8000aa:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%ebp)
	char minByte = 1<<7;
  8000b1:	c6 45 df 80          	movb   $0x80,-0x21(%ebp)
	char maxByte = 0x7F;
  8000b5:	c6 45 de 7f          	movb   $0x7f,-0x22(%ebp)
	short minShort = 1<<15 ;
  8000b9:	66 c7 45 dc 00 80    	movw   $0x8000,-0x24(%ebp)
	short maxShort = 0x7FFF;
  8000bf:	66 c7 45 da ff 7f    	movw   $0x7fff,-0x26(%ebp)
	int minInt = 1<<31 ;
  8000c5:	c7 45 d4 00 00 00 80 	movl   $0x80000000,-0x2c(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000cc:	c7 45 d0 ff ff ff 7f 	movl   $0x7fffffff,-0x30(%ebp)
	char *byteArr, *byteArr2 ;
	short *shortArr, *shortArr2 ;
	int *intArr;
	struct MyStruct *structArr ;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;
	int start_freeFrames = sys_calculate_free_frames() ;
  8000d3:	e8 76 24 00 00       	call   80254e <sys_calculate_free_frames>
  8000d8:	89 45 cc             	mov    %eax,-0x34(%ebp)

	void* ptr_allocations[20] = {0};
  8000db:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  8000e1:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000e6:	b8 00 00 00 00       	mov    $0x0,%eax
  8000eb:	89 d7                	mov    %edx,%edi
  8000ed:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 MB
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000ef:	e8 dd 24 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  8000f4:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000fa:	01 c0                	add    %eax,%eax
  8000fc:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8000ff:	83 ec 0c             	sub    $0xc,%esp
  800102:	50                   	push   %eax
  800103:	e8 d0 1e 00 00       	call   801fd8 <malloc>
  800108:	83 c4 10             	add    $0x10,%esp
  80010b:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800111:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800117:	85 c0                	test   %eax,%eax
  800119:	79 0d                	jns    800128 <_main+0xf0>
  80011b:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800121:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  800126:	76 14                	jbe    80013c <_main+0x104>
  800128:	83 ec 04             	sub    $0x4,%esp
  80012b:	68 f0 2c 80 00       	push   $0x802cf0
  800130:	6a 36                	push   $0x36
  800132:	68 dc 2c 80 00       	push   $0x802cdc
  800137:	e8 5b 0e 00 00       	call   800f97 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80013c:	e8 90 24 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  800141:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800144:	3d 00 02 00 00       	cmp    $0x200,%eax
  800149:	74 14                	je     80015f <_main+0x127>
  80014b:	83 ec 04             	sub    $0x4,%esp
  80014e:	68 58 2d 80 00       	push   $0x802d58
  800153:	6a 37                	push   $0x37
  800155:	68 dc 2c 80 00       	push   $0x802cdc
  80015a:	e8 38 0e 00 00       	call   800f97 <_panic>

		int freeFrames = sys_calculate_free_frames() ;
  80015f:	e8 ea 23 00 00       	call   80254e <sys_calculate_free_frames>
  800164:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  800167:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80016a:	01 c0                	add    %eax,%eax
  80016c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80016f:	48                   	dec    %eax
  800170:	89 45 c0             	mov    %eax,-0x40(%ebp)
		byteArr = (char *) ptr_allocations[0];
  800173:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800179:	89 45 bc             	mov    %eax,-0x44(%ebp)
		byteArr[0] = minByte ;
  80017c:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80017f:	8a 55 df             	mov    -0x21(%ebp),%dl
  800182:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  800184:	8b 55 c0             	mov    -0x40(%ebp),%edx
  800187:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80018a:	01 c2                	add    %eax,%edx
  80018c:	8a 45 de             	mov    -0x22(%ebp),%al
  80018f:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800191:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800194:	e8 b5 23 00 00       	call   80254e <sys_calculate_free_frames>
  800199:	29 c3                	sub    %eax,%ebx
  80019b:	89 d8                	mov    %ebx,%eax
  80019d:	83 f8 03             	cmp    $0x3,%eax
  8001a0:	74 14                	je     8001b6 <_main+0x17e>
  8001a2:	83 ec 04             	sub    $0x4,%esp
  8001a5:	68 88 2d 80 00       	push   $0x802d88
  8001aa:	6a 3e                	push   $0x3e
  8001ac:	68 dc 2c 80 00       	push   $0x802cdc
  8001b1:	e8 e1 0d 00 00       	call   800f97 <_panic>
		int var;
		int found = 0;
  8001b6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8001bd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8001c4:	e9 84 00 00 00       	jmp    80024d <_main+0x215>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  8001c9:	a1 20 40 80 00       	mov    0x804020,%eax
  8001ce:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8001d4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8001d7:	89 d0                	mov    %edx,%eax
  8001d9:	c1 e0 02             	shl    $0x2,%eax
  8001dc:	01 d0                	add    %edx,%eax
  8001de:	c1 e0 02             	shl    $0x2,%eax
  8001e1:	01 c8                	add    %ecx,%eax
  8001e3:	8b 00                	mov    (%eax),%eax
  8001e5:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001e8:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001f0:	89 c2                	mov    %eax,%edx
  8001f2:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001f5:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8001f8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800200:	39 c2                	cmp    %eax,%edx
  800202:	75 03                	jne    800207 <_main+0x1cf>
				found++;
  800204:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  800207:	a1 20 40 80 00       	mov    0x804020,%eax
  80020c:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800212:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800215:	89 d0                	mov    %edx,%eax
  800217:	c1 e0 02             	shl    $0x2,%eax
  80021a:	01 d0                	add    %edx,%eax
  80021c:	c1 e0 02             	shl    $0x2,%eax
  80021f:	01 c8                	add    %ecx,%eax
  800221:	8b 00                	mov    (%eax),%eax
  800223:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800226:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800229:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80022e:	89 c1                	mov    %eax,%ecx
  800230:	8b 55 c0             	mov    -0x40(%ebp),%edx
  800233:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800236:	01 d0                	add    %edx,%eax
  800238:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80023b:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80023e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800243:	39 c1                	cmp    %eax,%ecx
  800245:	75 03                	jne    80024a <_main+0x212>
				found++;
  800247:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr[0] = minByte ;
		byteArr[lastIndexOfByte] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int var;
		int found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80024a:	ff 45 ec             	incl   -0x14(%ebp)
  80024d:	a1 20 40 80 00       	mov    0x804020,%eax
  800252:	8b 50 74             	mov    0x74(%eax),%edx
  800255:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800258:	39 c2                	cmp    %eax,%edx
  80025a:	0f 87 69 ff ff ff    	ja     8001c9 <_main+0x191>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800260:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800264:	74 14                	je     80027a <_main+0x242>
  800266:	83 ec 04             	sub    $0x4,%esp
  800269:	68 cc 2d 80 00       	push   $0x802dcc
  80026e:	6a 48                	push   $0x48
  800270:	68 dc 2c 80 00       	push   $0x802cdc
  800275:	e8 1d 0d 00 00       	call   800f97 <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80027a:	e8 52 23 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  80027f:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800282:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800285:	01 c0                	add    %eax,%eax
  800287:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80028a:	83 ec 0c             	sub    $0xc,%esp
  80028d:	50                   	push   %eax
  80028e:	e8 45 1d 00 00       	call   801fd8 <malloc>
  800293:	83 c4 10             	add    $0x10,%esp
  800296:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80029c:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8002a2:	89 c2                	mov    %eax,%edx
  8002a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002a7:	01 c0                	add    %eax,%eax
  8002a9:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ae:	39 c2                	cmp    %eax,%edx
  8002b0:	72 16                	jb     8002c8 <_main+0x290>
  8002b2:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8002b8:	89 c2                	mov    %eax,%edx
  8002ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002bd:	01 c0                	add    %eax,%eax
  8002bf:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002c4:	39 c2                	cmp    %eax,%edx
  8002c6:	76 14                	jbe    8002dc <_main+0x2a4>
  8002c8:	83 ec 04             	sub    $0x4,%esp
  8002cb:	68 f0 2c 80 00       	push   $0x802cf0
  8002d0:	6a 4d                	push   $0x4d
  8002d2:	68 dc 2c 80 00       	push   $0x802cdc
  8002d7:	e8 bb 0c 00 00       	call   800f97 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8002dc:	e8 f0 22 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  8002e1:	2b 45 c8             	sub    -0x38(%ebp),%eax
  8002e4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002e9:	74 14                	je     8002ff <_main+0x2c7>
  8002eb:	83 ec 04             	sub    $0x4,%esp
  8002ee:	68 58 2d 80 00       	push   $0x802d58
  8002f3:	6a 4e                	push   $0x4e
  8002f5:	68 dc 2c 80 00       	push   $0x802cdc
  8002fa:	e8 98 0c 00 00       	call   800f97 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8002ff:	e8 4a 22 00 00       	call   80254e <sys_calculate_free_frames>
  800304:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		shortArr = (short *) ptr_allocations[1];
  800307:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  80030d:	89 45 a8             	mov    %eax,-0x58(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  800310:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800313:	01 c0                	add    %eax,%eax
  800315:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800318:	d1 e8                	shr    %eax
  80031a:	48                   	dec    %eax
  80031b:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		shortArr[0] = minShort;
  80031e:	8b 55 a8             	mov    -0x58(%ebp),%edx
  800321:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800324:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800327:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80032a:	01 c0                	add    %eax,%eax
  80032c:	89 c2                	mov    %eax,%edx
  80032e:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800331:	01 c2                	add    %eax,%edx
  800333:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  800337:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  80033a:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  80033d:	e8 0c 22 00 00       	call   80254e <sys_calculate_free_frames>
  800342:	29 c3                	sub    %eax,%ebx
  800344:	89 d8                	mov    %ebx,%eax
  800346:	83 f8 02             	cmp    $0x2,%eax
  800349:	74 14                	je     80035f <_main+0x327>
  80034b:	83 ec 04             	sub    $0x4,%esp
  80034e:	68 88 2d 80 00       	push   $0x802d88
  800353:	6a 55                	push   $0x55
  800355:	68 dc 2c 80 00       	push   $0x802cdc
  80035a:	e8 38 0c 00 00       	call   800f97 <_panic>
		found = 0;
  80035f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800366:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80036d:	e9 88 00 00 00       	jmp    8003fa <_main+0x3c2>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  800372:	a1 20 40 80 00       	mov    0x804020,%eax
  800377:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80037d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800380:	89 d0                	mov    %edx,%eax
  800382:	c1 e0 02             	shl    $0x2,%eax
  800385:	01 d0                	add    %edx,%eax
  800387:	c1 e0 02             	shl    $0x2,%eax
  80038a:	01 c8                	add    %ecx,%eax
  80038c:	8b 00                	mov    (%eax),%eax
  80038e:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800391:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800394:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800399:	89 c2                	mov    %eax,%edx
  80039b:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80039e:	89 45 9c             	mov    %eax,-0x64(%ebp)
  8003a1:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8003a4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003a9:	39 c2                	cmp    %eax,%edx
  8003ab:	75 03                	jne    8003b0 <_main+0x378>
				found++;
  8003ad:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  8003b0:	a1 20 40 80 00       	mov    0x804020,%eax
  8003b5:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8003bb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003be:	89 d0                	mov    %edx,%eax
  8003c0:	c1 e0 02             	shl    $0x2,%eax
  8003c3:	01 d0                	add    %edx,%eax
  8003c5:	c1 e0 02             	shl    $0x2,%eax
  8003c8:	01 c8                	add    %ecx,%eax
  8003ca:	8b 00                	mov    (%eax),%eax
  8003cc:	89 45 98             	mov    %eax,-0x68(%ebp)
  8003cf:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d7:	89 c2                	mov    %eax,%edx
  8003d9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003dc:	01 c0                	add    %eax,%eax
  8003de:	89 c1                	mov    %eax,%ecx
  8003e0:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003e3:	01 c8                	add    %ecx,%eax
  8003e5:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8003e8:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8003eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003f0:	39 c2                	cmp    %eax,%edx
  8003f2:	75 03                	jne    8003f7 <_main+0x3bf>
				found++;
  8003f4:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
		shortArr[0] = minShort;
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8003f7:	ff 45 ec             	incl   -0x14(%ebp)
  8003fa:	a1 20 40 80 00       	mov    0x804020,%eax
  8003ff:	8b 50 74             	mov    0x74(%eax),%edx
  800402:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800405:	39 c2                	cmp    %eax,%edx
  800407:	0f 87 65 ff ff ff    	ja     800372 <_main+0x33a>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  80040d:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800411:	74 14                	je     800427 <_main+0x3ef>
  800413:	83 ec 04             	sub    $0x4,%esp
  800416:	68 cc 2d 80 00       	push   $0x802dcc
  80041b:	6a 5e                	push   $0x5e
  80041d:	68 dc 2c 80 00       	push   $0x802cdc
  800422:	e8 70 0b 00 00       	call   800f97 <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800427:	e8 a5 21 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  80042c:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  80042f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800432:	01 c0                	add    %eax,%eax
  800434:	83 ec 0c             	sub    $0xc,%esp
  800437:	50                   	push   %eax
  800438:	e8 9b 1b 00 00       	call   801fd8 <malloc>
  80043d:	83 c4 10             	add    $0x10,%esp
  800440:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800446:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  80044c:	89 c2                	mov    %eax,%edx
  80044e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800451:	c1 e0 02             	shl    $0x2,%eax
  800454:	05 00 00 00 80       	add    $0x80000000,%eax
  800459:	39 c2                	cmp    %eax,%edx
  80045b:	72 17                	jb     800474 <_main+0x43c>
  80045d:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800463:	89 c2                	mov    %eax,%edx
  800465:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800468:	c1 e0 02             	shl    $0x2,%eax
  80046b:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800470:	39 c2                	cmp    %eax,%edx
  800472:	76 14                	jbe    800488 <_main+0x450>
  800474:	83 ec 04             	sub    $0x4,%esp
  800477:	68 f0 2c 80 00       	push   $0x802cf0
  80047c:	6a 63                	push   $0x63
  80047e:	68 dc 2c 80 00       	push   $0x802cdc
  800483:	e8 0f 0b 00 00       	call   800f97 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800488:	e8 44 21 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  80048d:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800490:	83 f8 01             	cmp    $0x1,%eax
  800493:	74 14                	je     8004a9 <_main+0x471>
  800495:	83 ec 04             	sub    $0x4,%esp
  800498:	68 58 2d 80 00       	push   $0x802d58
  80049d:	6a 64                	push   $0x64
  80049f:	68 dc 2c 80 00       	push   $0x802cdc
  8004a4:	e8 ee 0a 00 00       	call   800f97 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8004a9:	e8 a0 20 00 00       	call   80254e <sys_calculate_free_frames>
  8004ae:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		intArr = (int *) ptr_allocations[2];
  8004b1:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  8004b7:	89 45 90             	mov    %eax,-0x70(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  8004ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004bd:	01 c0                	add    %eax,%eax
  8004bf:	c1 e8 02             	shr    $0x2,%eax
  8004c2:	48                   	dec    %eax
  8004c3:	89 45 8c             	mov    %eax,-0x74(%ebp)
		intArr[0] = minInt;
  8004c6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8004c9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004cc:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  8004ce:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8004d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d8:	8b 45 90             	mov    -0x70(%ebp),%eax
  8004db:	01 c2                	add    %eax,%edx
  8004dd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004e0:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8004e2:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  8004e5:	e8 64 20 00 00       	call   80254e <sys_calculate_free_frames>
  8004ea:	29 c3                	sub    %eax,%ebx
  8004ec:	89 d8                	mov    %ebx,%eax
  8004ee:	83 f8 02             	cmp    $0x2,%eax
  8004f1:	74 14                	je     800507 <_main+0x4cf>
  8004f3:	83 ec 04             	sub    $0x4,%esp
  8004f6:	68 88 2d 80 00       	push   $0x802d88
  8004fb:	6a 6b                	push   $0x6b
  8004fd:	68 dc 2c 80 00       	push   $0x802cdc
  800502:	e8 90 0a 00 00       	call   800f97 <_panic>
		found = 0;
  800507:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80050e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800515:	e9 91 00 00 00       	jmp    8005ab <_main+0x573>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  80051a:	a1 20 40 80 00       	mov    0x804020,%eax
  80051f:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800525:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800528:	89 d0                	mov    %edx,%eax
  80052a:	c1 e0 02             	shl    $0x2,%eax
  80052d:	01 d0                	add    %edx,%eax
  80052f:	c1 e0 02             	shl    $0x2,%eax
  800532:	01 c8                	add    %ecx,%eax
  800534:	8b 00                	mov    (%eax),%eax
  800536:	89 45 88             	mov    %eax,-0x78(%ebp)
  800539:	8b 45 88             	mov    -0x78(%ebp),%eax
  80053c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800541:	89 c2                	mov    %eax,%edx
  800543:	8b 45 90             	mov    -0x70(%ebp),%eax
  800546:	89 45 84             	mov    %eax,-0x7c(%ebp)
  800549:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80054c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800551:	39 c2                	cmp    %eax,%edx
  800553:	75 03                	jne    800558 <_main+0x520>
				found++;
  800555:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  800558:	a1 20 40 80 00       	mov    0x804020,%eax
  80055d:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800563:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800566:	89 d0                	mov    %edx,%eax
  800568:	c1 e0 02             	shl    $0x2,%eax
  80056b:	01 d0                	add    %edx,%eax
  80056d:	c1 e0 02             	shl    $0x2,%eax
  800570:	01 c8                	add    %ecx,%eax
  800572:	8b 00                	mov    (%eax),%eax
  800574:	89 45 80             	mov    %eax,-0x80(%ebp)
  800577:	8b 45 80             	mov    -0x80(%ebp),%eax
  80057a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80057f:	89 c2                	mov    %eax,%edx
  800581:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800584:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80058b:	8b 45 90             	mov    -0x70(%ebp),%eax
  80058e:	01 c8                	add    %ecx,%eax
  800590:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  800596:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80059c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005a1:	39 c2                	cmp    %eax,%edx
  8005a3:	75 03                	jne    8005a8 <_main+0x570>
				found++;
  8005a5:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8005a8:	ff 45 ec             	incl   -0x14(%ebp)
  8005ab:	a1 20 40 80 00       	mov    0x804020,%eax
  8005b0:	8b 50 74             	mov    0x74(%eax),%edx
  8005b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005b6:	39 c2                	cmp    %eax,%edx
  8005b8:	0f 87 5c ff ff ff    	ja     80051a <_main+0x4e2>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8005be:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8005c2:	74 14                	je     8005d8 <_main+0x5a0>
  8005c4:	83 ec 04             	sub    $0x4,%esp
  8005c7:	68 cc 2d 80 00       	push   $0x802dcc
  8005cc:	6a 74                	push   $0x74
  8005ce:	68 dc 2c 80 00       	push   $0x802cdc
  8005d3:	e8 bf 09 00 00       	call   800f97 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8005d8:	e8 71 1f 00 00       	call   80254e <sys_calculate_free_frames>
  8005dd:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005e0:	e8 ec 1f 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  8005e5:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8005e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005eb:	01 c0                	add    %eax,%eax
  8005ed:	83 ec 0c             	sub    $0xc,%esp
  8005f0:	50                   	push   %eax
  8005f1:	e8 e2 19 00 00       	call   801fd8 <malloc>
  8005f6:	83 c4 10             	add    $0x10,%esp
  8005f9:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8005ff:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  800605:	89 c2                	mov    %eax,%edx
  800607:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80060a:	c1 e0 02             	shl    $0x2,%eax
  80060d:	89 c1                	mov    %eax,%ecx
  80060f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800612:	c1 e0 02             	shl    $0x2,%eax
  800615:	01 c8                	add    %ecx,%eax
  800617:	05 00 00 00 80       	add    $0x80000000,%eax
  80061c:	39 c2                	cmp    %eax,%edx
  80061e:	72 21                	jb     800641 <_main+0x609>
  800620:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  800626:	89 c2                	mov    %eax,%edx
  800628:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80062b:	c1 e0 02             	shl    $0x2,%eax
  80062e:	89 c1                	mov    %eax,%ecx
  800630:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800633:	c1 e0 02             	shl    $0x2,%eax
  800636:	01 c8                	add    %ecx,%eax
  800638:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80063d:	39 c2                	cmp    %eax,%edx
  80063f:	76 14                	jbe    800655 <_main+0x61d>
  800641:	83 ec 04             	sub    $0x4,%esp
  800644:	68 f0 2c 80 00       	push   $0x802cf0
  800649:	6a 7a                	push   $0x7a
  80064b:	68 dc 2c 80 00       	push   $0x802cdc
  800650:	e8 42 09 00 00       	call   800f97 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800655:	e8 77 1f 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  80065a:	2b 45 c8             	sub    -0x38(%ebp),%eax
  80065d:	83 f8 01             	cmp    $0x1,%eax
  800660:	74 14                	je     800676 <_main+0x63e>
  800662:	83 ec 04             	sub    $0x4,%esp
  800665:	68 58 2d 80 00       	push   $0x802d58
  80066a:	6a 7b                	push   $0x7b
  80066c:	68 dc 2c 80 00       	push   $0x802cdc
  800671:	e8 21 09 00 00       	call   800f97 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800676:	e8 56 1f 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  80067b:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  80067e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800681:	89 d0                	mov    %edx,%eax
  800683:	01 c0                	add    %eax,%eax
  800685:	01 d0                	add    %edx,%eax
  800687:	01 c0                	add    %eax,%eax
  800689:	01 d0                	add    %edx,%eax
  80068b:	83 ec 0c             	sub    $0xc,%esp
  80068e:	50                   	push   %eax
  80068f:	e8 44 19 00 00       	call   801fd8 <malloc>
  800694:	83 c4 10             	add    $0x10,%esp
  800697:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80069d:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  8006a3:	89 c2                	mov    %eax,%edx
  8006a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006a8:	c1 e0 02             	shl    $0x2,%eax
  8006ab:	89 c1                	mov    %eax,%ecx
  8006ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006b0:	c1 e0 03             	shl    $0x3,%eax
  8006b3:	01 c8                	add    %ecx,%eax
  8006b5:	05 00 00 00 80       	add    $0x80000000,%eax
  8006ba:	39 c2                	cmp    %eax,%edx
  8006bc:	72 21                	jb     8006df <_main+0x6a7>
  8006be:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  8006c4:	89 c2                	mov    %eax,%edx
  8006c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006c9:	c1 e0 02             	shl    $0x2,%eax
  8006cc:	89 c1                	mov    %eax,%ecx
  8006ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006d1:	c1 e0 03             	shl    $0x3,%eax
  8006d4:	01 c8                	add    %ecx,%eax
  8006d6:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8006db:	39 c2                	cmp    %eax,%edx
  8006dd:	76 17                	jbe    8006f6 <_main+0x6be>
  8006df:	83 ec 04             	sub    $0x4,%esp
  8006e2:	68 f0 2c 80 00       	push   $0x802cf0
  8006e7:	68 81 00 00 00       	push   $0x81
  8006ec:	68 dc 2c 80 00       	push   $0x802cdc
  8006f1:	e8 a1 08 00 00       	call   800f97 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8006f6:	e8 d6 1e 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  8006fb:	2b 45 c8             	sub    -0x38(%ebp),%eax
  8006fe:	83 f8 02             	cmp    $0x2,%eax
  800701:	74 17                	je     80071a <_main+0x6e2>
  800703:	83 ec 04             	sub    $0x4,%esp
  800706:	68 58 2d 80 00       	push   $0x802d58
  80070b:	68 82 00 00 00       	push   $0x82
  800710:	68 dc 2c 80 00       	push   $0x802cdc
  800715:	e8 7d 08 00 00       	call   800f97 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80071a:	e8 2f 1e 00 00       	call   80254e <sys_calculate_free_frames>
  80071f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  800722:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  800728:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  80072e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800731:	89 d0                	mov    %edx,%eax
  800733:	01 c0                	add    %eax,%eax
  800735:	01 d0                	add    %edx,%eax
  800737:	01 c0                	add    %eax,%eax
  800739:	01 d0                	add    %edx,%eax
  80073b:	c1 e8 03             	shr    $0x3,%eax
  80073e:	48                   	dec    %eax
  80073f:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  800745:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80074b:	8a 55 df             	mov    -0x21(%ebp),%dl
  80074e:	88 10                	mov    %dl,(%eax)
  800750:	8b 95 78 ff ff ff    	mov    -0x88(%ebp),%edx
  800756:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800759:	66 89 42 02          	mov    %ax,0x2(%edx)
  80075d:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800763:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800766:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  800769:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80076f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800776:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80077c:	01 c2                	add    %eax,%edx
  80077e:	8a 45 de             	mov    -0x22(%ebp),%al
  800781:	88 02                	mov    %al,(%edx)
  800783:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800789:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800790:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800796:	01 c2                	add    %eax,%edx
  800798:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  80079c:	66 89 42 02          	mov    %ax,0x2(%edx)
  8007a0:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8007a6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007ad:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8007b3:	01 c2                	add    %eax,%edx
  8007b5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007b8:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007bb:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  8007be:	e8 8b 1d 00 00       	call   80254e <sys_calculate_free_frames>
  8007c3:	29 c3                	sub    %eax,%ebx
  8007c5:	89 d8                	mov    %ebx,%eax
  8007c7:	83 f8 02             	cmp    $0x2,%eax
  8007ca:	74 17                	je     8007e3 <_main+0x7ab>
  8007cc:	83 ec 04             	sub    $0x4,%esp
  8007cf:	68 88 2d 80 00       	push   $0x802d88
  8007d4:	68 89 00 00 00       	push   $0x89
  8007d9:	68 dc 2c 80 00       	push   $0x802cdc
  8007de:	e8 b4 07 00 00       	call   800f97 <_panic>
		found = 0;
  8007e3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8007ea:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8007f1:	e9 ac 00 00 00       	jmp    8008a2 <_main+0x86a>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  8007f6:	a1 20 40 80 00       	mov    0x804020,%eax
  8007fb:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800801:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800804:	89 d0                	mov    %edx,%eax
  800806:	c1 e0 02             	shl    $0x2,%eax
  800809:	01 d0                	add    %edx,%eax
  80080b:	c1 e0 02             	shl    $0x2,%eax
  80080e:	01 c8                	add    %ecx,%eax
  800810:	8b 00                	mov    (%eax),%eax
  800812:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  800818:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80081e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800823:	89 c2                	mov    %eax,%edx
  800825:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80082b:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800831:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800837:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80083c:	39 c2                	cmp    %eax,%edx
  80083e:	75 03                	jne    800843 <_main+0x80b>
				found++;
  800840:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  800843:	a1 20 40 80 00       	mov    0x804020,%eax
  800848:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80084e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800851:	89 d0                	mov    %edx,%eax
  800853:	c1 e0 02             	shl    $0x2,%eax
  800856:	01 d0                	add    %edx,%eax
  800858:	c1 e0 02             	shl    $0x2,%eax
  80085b:	01 c8                	add    %ecx,%eax
  80085d:	8b 00                	mov    (%eax),%eax
  80085f:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800865:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  80086b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800870:	89 c2                	mov    %eax,%edx
  800872:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800878:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80087f:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800885:	01 c8                	add    %ecx,%eax
  800887:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  80088d:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800893:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800898:	39 c2                	cmp    %eax,%edx
  80089a:	75 03                	jne    80089f <_main+0x867>
				found++;
  80089c:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80089f:	ff 45 ec             	incl   -0x14(%ebp)
  8008a2:	a1 20 40 80 00       	mov    0x804020,%eax
  8008a7:	8b 50 74             	mov    0x74(%eax),%edx
  8008aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008ad:	39 c2                	cmp    %eax,%edx
  8008af:	0f 87 41 ff ff ff    	ja     8007f6 <_main+0x7be>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8008b5:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8008b9:	74 17                	je     8008d2 <_main+0x89a>
  8008bb:	83 ec 04             	sub    $0x4,%esp
  8008be:	68 cc 2d 80 00       	push   $0x802dcc
  8008c3:	68 92 00 00 00       	push   $0x92
  8008c8:	68 dc 2c 80 00       	push   $0x802cdc
  8008cd:	e8 c5 06 00 00       	call   800f97 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8008d2:	e8 77 1c 00 00       	call   80254e <sys_calculate_free_frames>
  8008d7:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008da:	e8 f2 1c 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  8008df:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8008e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8008e5:	89 c2                	mov    %eax,%edx
  8008e7:	01 d2                	add    %edx,%edx
  8008e9:	01 d0                	add    %edx,%eax
  8008eb:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8008ee:	83 ec 0c             	sub    $0xc,%esp
  8008f1:	50                   	push   %eax
  8008f2:	e8 e1 16 00 00       	call   801fd8 <malloc>
  8008f7:	83 c4 10             	add    $0x10,%esp
  8008fa:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800900:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  800906:	89 c2                	mov    %eax,%edx
  800908:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80090b:	c1 e0 02             	shl    $0x2,%eax
  80090e:	89 c1                	mov    %eax,%ecx
  800910:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800913:	c1 e0 04             	shl    $0x4,%eax
  800916:	01 c8                	add    %ecx,%eax
  800918:	05 00 00 00 80       	add    $0x80000000,%eax
  80091d:	39 c2                	cmp    %eax,%edx
  80091f:	72 21                	jb     800942 <_main+0x90a>
  800921:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  800927:	89 c2                	mov    %eax,%edx
  800929:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80092c:	c1 e0 02             	shl    $0x2,%eax
  80092f:	89 c1                	mov    %eax,%ecx
  800931:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800934:	c1 e0 04             	shl    $0x4,%eax
  800937:	01 c8                	add    %ecx,%eax
  800939:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80093e:	39 c2                	cmp    %eax,%edx
  800940:	76 17                	jbe    800959 <_main+0x921>
  800942:	83 ec 04             	sub    $0x4,%esp
  800945:	68 f0 2c 80 00       	push   $0x802cf0
  80094a:	68 98 00 00 00       	push   $0x98
  80094f:	68 dc 2c 80 00       	push   $0x802cdc
  800954:	e8 3e 06 00 00       	call   800f97 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800959:	e8 73 1c 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  80095e:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800961:	89 c2                	mov    %eax,%edx
  800963:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800966:	89 c1                	mov    %eax,%ecx
  800968:	01 c9                	add    %ecx,%ecx
  80096a:	01 c8                	add    %ecx,%eax
  80096c:	85 c0                	test   %eax,%eax
  80096e:	79 05                	jns    800975 <_main+0x93d>
  800970:	05 ff 0f 00 00       	add    $0xfff,%eax
  800975:	c1 f8 0c             	sar    $0xc,%eax
  800978:	39 c2                	cmp    %eax,%edx
  80097a:	74 17                	je     800993 <_main+0x95b>
  80097c:	83 ec 04             	sub    $0x4,%esp
  80097f:	68 58 2d 80 00       	push   $0x802d58
  800984:	68 99 00 00 00       	push   $0x99
  800989:	68 dc 2c 80 00       	push   $0x802cdc
  80098e:	e8 04 06 00 00       	call   800f97 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800993:	e8 39 1c 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  800998:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  80099b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80099e:	89 d0                	mov    %edx,%eax
  8009a0:	01 c0                	add    %eax,%eax
  8009a2:	01 d0                	add    %edx,%eax
  8009a4:	01 c0                	add    %eax,%eax
  8009a6:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8009a9:	83 ec 0c             	sub    $0xc,%esp
  8009ac:	50                   	push   %eax
  8009ad:	e8 26 16 00 00       	call   801fd8 <malloc>
  8009b2:	83 c4 10             	add    $0x10,%esp
  8009b5:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8009bb:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  8009c1:	89 c1                	mov    %eax,%ecx
  8009c3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8009c6:	89 d0                	mov    %edx,%eax
  8009c8:	01 c0                	add    %eax,%eax
  8009ca:	01 d0                	add    %edx,%eax
  8009cc:	01 c0                	add    %eax,%eax
  8009ce:	01 d0                	add    %edx,%eax
  8009d0:	89 c2                	mov    %eax,%edx
  8009d2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009d5:	c1 e0 04             	shl    $0x4,%eax
  8009d8:	01 d0                	add    %edx,%eax
  8009da:	05 00 00 00 80       	add    $0x80000000,%eax
  8009df:	39 c1                	cmp    %eax,%ecx
  8009e1:	72 28                	jb     800a0b <_main+0x9d3>
  8009e3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  8009e9:	89 c1                	mov    %eax,%ecx
  8009eb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8009ee:	89 d0                	mov    %edx,%eax
  8009f0:	01 c0                	add    %eax,%eax
  8009f2:	01 d0                	add    %edx,%eax
  8009f4:	01 c0                	add    %eax,%eax
  8009f6:	01 d0                	add    %edx,%eax
  8009f8:	89 c2                	mov    %eax,%edx
  8009fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009fd:	c1 e0 04             	shl    $0x4,%eax
  800a00:	01 d0                	add    %edx,%eax
  800a02:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800a07:	39 c1                	cmp    %eax,%ecx
  800a09:	76 17                	jbe    800a22 <_main+0x9ea>
  800a0b:	83 ec 04             	sub    $0x4,%esp
  800a0e:	68 f0 2c 80 00       	push   $0x802cf0
  800a13:	68 9f 00 00 00       	push   $0x9f
  800a18:	68 dc 2c 80 00       	push   $0x802cdc
  800a1d:	e8 75 05 00 00       	call   800f97 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800a22:	e8 aa 1b 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  800a27:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800a2a:	89 c1                	mov    %eax,%ecx
  800a2c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800a2f:	89 d0                	mov    %edx,%eax
  800a31:	01 c0                	add    %eax,%eax
  800a33:	01 d0                	add    %edx,%eax
  800a35:	01 c0                	add    %eax,%eax
  800a37:	85 c0                	test   %eax,%eax
  800a39:	79 05                	jns    800a40 <_main+0xa08>
  800a3b:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a40:	c1 f8 0c             	sar    $0xc,%eax
  800a43:	39 c1                	cmp    %eax,%ecx
  800a45:	74 17                	je     800a5e <_main+0xa26>
  800a47:	83 ec 04             	sub    $0x4,%esp
  800a4a:	68 58 2d 80 00       	push   $0x802d58
  800a4f:	68 a0 00 00 00       	push   $0xa0
  800a54:	68 dc 2c 80 00       	push   $0x802cdc
  800a59:	e8 39 05 00 00       	call   800f97 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800a5e:	e8 eb 1a 00 00       	call   80254e <sys_calculate_free_frames>
  800a63:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  800a66:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800a69:	89 d0                	mov    %edx,%eax
  800a6b:	01 c0                	add    %eax,%eax
  800a6d:	01 d0                	add    %edx,%eax
  800a6f:	01 c0                	add    %eax,%eax
  800a71:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800a74:	48                   	dec    %eax
  800a75:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800a7b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  800a81:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
		byteArr2[0] = minByte ;
  800a87:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800a8d:	8a 55 df             	mov    -0x21(%ebp),%dl
  800a90:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800a92:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800a98:	89 c2                	mov    %eax,%edx
  800a9a:	c1 ea 1f             	shr    $0x1f,%edx
  800a9d:	01 d0                	add    %edx,%eax
  800a9f:	d1 f8                	sar    %eax
  800aa1:	89 c2                	mov    %eax,%edx
  800aa3:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800aa9:	01 c2                	add    %eax,%edx
  800aab:	8a 45 de             	mov    -0x22(%ebp),%al
  800aae:	88 c1                	mov    %al,%cl
  800ab0:	c0 e9 07             	shr    $0x7,%cl
  800ab3:	01 c8                	add    %ecx,%eax
  800ab5:	d0 f8                	sar    %al
  800ab7:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  800ab9:	8b 95 60 ff ff ff    	mov    -0xa0(%ebp),%edx
  800abf:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800ac5:	01 c2                	add    %eax,%edx
  800ac7:	8a 45 de             	mov    -0x22(%ebp),%al
  800aca:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800acc:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800acf:	e8 7a 1a 00 00       	call   80254e <sys_calculate_free_frames>
  800ad4:	29 c3                	sub    %eax,%ebx
  800ad6:	89 d8                	mov    %ebx,%eax
  800ad8:	83 f8 05             	cmp    $0x5,%eax
  800adb:	74 17                	je     800af4 <_main+0xabc>
  800add:	83 ec 04             	sub    $0x4,%esp
  800ae0:	68 88 2d 80 00       	push   $0x802d88
  800ae5:	68 a8 00 00 00       	push   $0xa8
  800aea:	68 dc 2c 80 00       	push   $0x802cdc
  800aef:	e8 a3 04 00 00       	call   800f97 <_panic>
		found = 0;
  800af4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800afb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800b02:	e9 05 01 00 00       	jmp    800c0c <_main+0xbd4>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800b07:	a1 20 40 80 00       	mov    0x804020,%eax
  800b0c:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800b12:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b15:	89 d0                	mov    %edx,%eax
  800b17:	c1 e0 02             	shl    $0x2,%eax
  800b1a:	01 d0                	add    %edx,%eax
  800b1c:	c1 e0 02             	shl    $0x2,%eax
  800b1f:	01 c8                	add    %ecx,%eax
  800b21:	8b 00                	mov    (%eax),%eax
  800b23:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  800b29:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b2f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b34:	89 c2                	mov    %eax,%edx
  800b36:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800b3c:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800b42:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b48:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b4d:	39 c2                	cmp    %eax,%edx
  800b4f:	75 03                	jne    800b54 <_main+0xb1c>
				found++;
  800b51:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800b54:	a1 20 40 80 00       	mov    0x804020,%eax
  800b59:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800b5f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b62:	89 d0                	mov    %edx,%eax
  800b64:	c1 e0 02             	shl    $0x2,%eax
  800b67:	01 d0                	add    %edx,%eax
  800b69:	c1 e0 02             	shl    $0x2,%eax
  800b6c:	01 c8                	add    %ecx,%eax
  800b6e:	8b 00                	mov    (%eax),%eax
  800b70:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b76:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b7c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b81:	89 c2                	mov    %eax,%edx
  800b83:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800b89:	89 c1                	mov    %eax,%ecx
  800b8b:	c1 e9 1f             	shr    $0x1f,%ecx
  800b8e:	01 c8                	add    %ecx,%eax
  800b90:	d1 f8                	sar    %eax
  800b92:	89 c1                	mov    %eax,%ecx
  800b94:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800b9a:	01 c8                	add    %ecx,%eax
  800b9c:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800ba2:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800ba8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bad:	39 c2                	cmp    %eax,%edx
  800baf:	75 03                	jne    800bb4 <_main+0xb7c>
				found++;
  800bb1:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800bb4:	a1 20 40 80 00       	mov    0x804020,%eax
  800bb9:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800bbf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800bc2:	89 d0                	mov    %edx,%eax
  800bc4:	c1 e0 02             	shl    $0x2,%eax
  800bc7:	01 d0                	add    %edx,%eax
  800bc9:	c1 e0 02             	shl    $0x2,%eax
  800bcc:	01 c8                	add    %ecx,%eax
  800bce:	8b 00                	mov    (%eax),%eax
  800bd0:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800bd6:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800bdc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800be1:	89 c1                	mov    %eax,%ecx
  800be3:	8b 95 60 ff ff ff    	mov    -0xa0(%ebp),%edx
  800be9:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800bef:	01 d0                	add    %edx,%eax
  800bf1:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800bf7:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800bfd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c02:	39 c1                	cmp    %eax,%ecx
  800c04:	75 03                	jne    800c09 <_main+0xbd1>
				found++;
  800c06:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800c09:	ff 45 ec             	incl   -0x14(%ebp)
  800c0c:	a1 20 40 80 00       	mov    0x804020,%eax
  800c11:	8b 50 74             	mov    0x74(%eax),%edx
  800c14:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c17:	39 c2                	cmp    %eax,%edx
  800c19:	0f 87 e8 fe ff ff    	ja     800b07 <_main+0xacf>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  800c1f:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  800c23:	74 17                	je     800c3c <_main+0xc04>
  800c25:	83 ec 04             	sub    $0x4,%esp
  800c28:	68 cc 2d 80 00       	push   $0x802dcc
  800c2d:	68 b3 00 00 00       	push   $0xb3
  800c32:	68 dc 2c 80 00       	push   $0x802cdc
  800c37:	e8 5b 03 00 00       	call   800f97 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c3c:	e8 90 19 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  800c41:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  800c44:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c47:	89 d0                	mov    %edx,%eax
  800c49:	01 c0                	add    %eax,%eax
  800c4b:	01 d0                	add    %edx,%eax
  800c4d:	01 c0                	add    %eax,%eax
  800c4f:	01 d0                	add    %edx,%eax
  800c51:	01 c0                	add    %eax,%eax
  800c53:	83 ec 0c             	sub    $0xc,%esp
  800c56:	50                   	push   %eax
  800c57:	e8 7c 13 00 00       	call   801fd8 <malloc>
  800c5c:	83 c4 10             	add    $0x10,%esp
  800c5f:	89 85 f8 fe ff ff    	mov    %eax,-0x108(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800c65:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800c6b:	89 c1                	mov    %eax,%ecx
  800c6d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800c70:	89 d0                	mov    %edx,%eax
  800c72:	01 c0                	add    %eax,%eax
  800c74:	01 d0                	add    %edx,%eax
  800c76:	c1 e0 02             	shl    $0x2,%eax
  800c79:	01 d0                	add    %edx,%eax
  800c7b:	89 c2                	mov    %eax,%edx
  800c7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c80:	c1 e0 04             	shl    $0x4,%eax
  800c83:	01 d0                	add    %edx,%eax
  800c85:	05 00 00 00 80       	add    $0x80000000,%eax
  800c8a:	39 c1                	cmp    %eax,%ecx
  800c8c:	72 29                	jb     800cb7 <_main+0xc7f>
  800c8e:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800c94:	89 c1                	mov    %eax,%ecx
  800c96:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800c99:	89 d0                	mov    %edx,%eax
  800c9b:	01 c0                	add    %eax,%eax
  800c9d:	01 d0                	add    %edx,%eax
  800c9f:	c1 e0 02             	shl    $0x2,%eax
  800ca2:	01 d0                	add    %edx,%eax
  800ca4:	89 c2                	mov    %eax,%edx
  800ca6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ca9:	c1 e0 04             	shl    $0x4,%eax
  800cac:	01 d0                	add    %edx,%eax
  800cae:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800cb3:	39 c1                	cmp    %eax,%ecx
  800cb5:	76 17                	jbe    800cce <_main+0xc96>
  800cb7:	83 ec 04             	sub    $0x4,%esp
  800cba:	68 f0 2c 80 00       	push   $0x802cf0
  800cbf:	68 b8 00 00 00       	push   $0xb8
  800cc4:	68 dc 2c 80 00       	push   $0x802cdc
  800cc9:	e8 c9 02 00 00       	call   800f97 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800cce:	e8 fe 18 00 00       	call   8025d1 <sys_pf_calculate_allocated_pages>
  800cd3:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800cd6:	83 f8 04             	cmp    $0x4,%eax
  800cd9:	74 17                	je     800cf2 <_main+0xcba>
  800cdb:	83 ec 04             	sub    $0x4,%esp
  800cde:	68 58 2d 80 00       	push   $0x802d58
  800ce3:	68 b9 00 00 00       	push   $0xb9
  800ce8:	68 dc 2c 80 00       	push   $0x802cdc
  800ced:	e8 a5 02 00 00       	call   800f97 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800cf2:	e8 57 18 00 00       	call   80254e <sys_calculate_free_frames>
  800cf7:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800cfa:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800d00:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  800d06:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d09:	89 d0                	mov    %edx,%eax
  800d0b:	01 c0                	add    %eax,%eax
  800d0d:	01 d0                	add    %edx,%eax
  800d0f:	01 c0                	add    %eax,%eax
  800d11:	01 d0                	add    %edx,%eax
  800d13:	01 c0                	add    %eax,%eax
  800d15:	d1 e8                	shr    %eax
  800d17:	48                   	dec    %eax
  800d18:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
		shortArr2[0] = minShort;
  800d1e:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
  800d24:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d27:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800d2a:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800d30:	01 c0                	add    %eax,%eax
  800d32:	89 c2                	mov    %eax,%edx
  800d34:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800d3a:	01 c2                	add    %eax,%edx
  800d3c:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  800d40:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800d43:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800d46:	e8 03 18 00 00       	call   80254e <sys_calculate_free_frames>
  800d4b:	29 c3                	sub    %eax,%ebx
  800d4d:	89 d8                	mov    %ebx,%eax
  800d4f:	83 f8 02             	cmp    $0x2,%eax
  800d52:	74 17                	je     800d6b <_main+0xd33>
  800d54:	83 ec 04             	sub    $0x4,%esp
  800d57:	68 88 2d 80 00       	push   $0x802d88
  800d5c:	68 c0 00 00 00       	push   $0xc0
  800d61:	68 dc 2c 80 00       	push   $0x802cdc
  800d66:	e8 2c 02 00 00       	call   800f97 <_panic>
		found = 0;
  800d6b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d72:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800d79:	e9 a9 00 00 00       	jmp    800e27 <_main+0xdef>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800d7e:	a1 20 40 80 00       	mov    0x804020,%eax
  800d83:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800d89:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d8c:	89 d0                	mov    %edx,%eax
  800d8e:	c1 e0 02             	shl    $0x2,%eax
  800d91:	01 d0                	add    %edx,%eax
  800d93:	c1 e0 02             	shl    $0x2,%eax
  800d96:	01 c8                	add    %ecx,%eax
  800d98:	8b 00                	mov    (%eax),%eax
  800d9a:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
  800da0:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800da6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dab:	89 c2                	mov    %eax,%edx
  800dad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800db3:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800db9:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800dbf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dc4:	39 c2                	cmp    %eax,%edx
  800dc6:	75 03                	jne    800dcb <_main+0xd93>
				found++;
  800dc8:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800dcb:	a1 20 40 80 00       	mov    0x804020,%eax
  800dd0:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800dd6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dd9:	89 d0                	mov    %edx,%eax
  800ddb:	c1 e0 02             	shl    $0x2,%eax
  800dde:	01 d0                	add    %edx,%eax
  800de0:	c1 e0 02             	shl    $0x2,%eax
  800de3:	01 c8                	add    %ecx,%eax
  800de5:	8b 00                	mov    (%eax),%eax
  800de7:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800ded:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800df3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800df8:	89 c2                	mov    %eax,%edx
  800dfa:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800e00:	01 c0                	add    %eax,%eax
  800e02:	89 c1                	mov    %eax,%ecx
  800e04:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800e0a:	01 c8                	add    %ecx,%eax
  800e0c:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800e12:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800e18:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e1d:	39 c2                	cmp    %eax,%edx
  800e1f:	75 03                	jne    800e24 <_main+0xdec>
				found++;
  800e21:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800e24:	ff 45 ec             	incl   -0x14(%ebp)
  800e27:	a1 20 40 80 00       	mov    0x804020,%eax
  800e2c:	8b 50 74             	mov    0x74(%eax),%edx
  800e2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e32:	39 c2                	cmp    %eax,%edx
  800e34:	0f 87 44 ff ff ff    	ja     800d7e <_main+0xd46>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800e3a:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800e3e:	74 17                	je     800e57 <_main+0xe1f>
  800e40:	83 ec 04             	sub    $0x4,%esp
  800e43:	68 cc 2d 80 00       	push   $0x802dcc
  800e48:	68 c9 00 00 00       	push   $0xc9
  800e4d:	68 dc 2c 80 00       	push   $0x802cdc
  800e52:	e8 40 01 00 00       	call   800f97 <_panic>
	}

	cprintf("Congratulations!! test malloc [3] completed successfully.\n");
  800e57:	83 ec 0c             	sub    $0xc,%esp
  800e5a:	68 ec 2d 80 00       	push   $0x802dec
  800e5f:	e8 ea 03 00 00       	call   80124e <cprintf>
  800e64:	83 c4 10             	add    $0x10,%esp

	return;
  800e67:	90                   	nop
}
  800e68:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800e6b:	5b                   	pop    %ebx
  800e6c:	5f                   	pop    %edi
  800e6d:	5d                   	pop    %ebp
  800e6e:	c3                   	ret    

00800e6f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800e6f:	55                   	push   %ebp
  800e70:	89 e5                	mov    %esp,%ebp
  800e72:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800e75:	e8 09 16 00 00       	call   802483 <sys_getenvindex>
  800e7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800e7d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e80:	89 d0                	mov    %edx,%eax
  800e82:	01 c0                	add    %eax,%eax
  800e84:	01 d0                	add    %edx,%eax
  800e86:	c1 e0 07             	shl    $0x7,%eax
  800e89:	29 d0                	sub    %edx,%eax
  800e8b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800e92:	01 c8                	add    %ecx,%eax
  800e94:	01 c0                	add    %eax,%eax
  800e96:	01 d0                	add    %edx,%eax
  800e98:	01 c0                	add    %eax,%eax
  800e9a:	01 d0                	add    %edx,%eax
  800e9c:	c1 e0 03             	shl    $0x3,%eax
  800e9f:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800ea4:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800ea9:	a1 20 40 80 00       	mov    0x804020,%eax
  800eae:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800eb4:	84 c0                	test   %al,%al
  800eb6:	74 0f                	je     800ec7 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800eb8:	a1 20 40 80 00       	mov    0x804020,%eax
  800ebd:	05 f0 ee 00 00       	add    $0xeef0,%eax
  800ec2:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800ec7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ecb:	7e 0a                	jle    800ed7 <libmain+0x68>
		binaryname = argv[0];
  800ecd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed0:	8b 00                	mov    (%eax),%eax
  800ed2:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800ed7:	83 ec 08             	sub    $0x8,%esp
  800eda:	ff 75 0c             	pushl  0xc(%ebp)
  800edd:	ff 75 08             	pushl  0x8(%ebp)
  800ee0:	e8 53 f1 ff ff       	call   800038 <_main>
  800ee5:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800ee8:	e8 31 17 00 00       	call   80261e <sys_disable_interrupt>
	cprintf("**************************************\n");
  800eed:	83 ec 0c             	sub    $0xc,%esp
  800ef0:	68 40 2e 80 00       	push   $0x802e40
  800ef5:	e8 54 03 00 00       	call   80124e <cprintf>
  800efa:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800efd:	a1 20 40 80 00       	mov    0x804020,%eax
  800f02:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800f08:	a1 20 40 80 00       	mov    0x804020,%eax
  800f0d:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  800f13:	83 ec 04             	sub    $0x4,%esp
  800f16:	52                   	push   %edx
  800f17:	50                   	push   %eax
  800f18:	68 68 2e 80 00       	push   $0x802e68
  800f1d:	e8 2c 03 00 00       	call   80124e <cprintf>
  800f22:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800f25:	a1 20 40 80 00       	mov    0x804020,%eax
  800f2a:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800f30:	a1 20 40 80 00       	mov    0x804020,%eax
  800f35:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800f3b:	a1 20 40 80 00       	mov    0x804020,%eax
  800f40:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  800f46:	51                   	push   %ecx
  800f47:	52                   	push   %edx
  800f48:	50                   	push   %eax
  800f49:	68 90 2e 80 00       	push   $0x802e90
  800f4e:	e8 fb 02 00 00       	call   80124e <cprintf>
  800f53:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800f56:	83 ec 0c             	sub    $0xc,%esp
  800f59:	68 40 2e 80 00       	push   $0x802e40
  800f5e:	e8 eb 02 00 00       	call   80124e <cprintf>
  800f63:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800f66:	e8 cd 16 00 00       	call   802638 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800f6b:	e8 19 00 00 00       	call   800f89 <exit>
}
  800f70:	90                   	nop
  800f71:	c9                   	leave  
  800f72:	c3                   	ret    

00800f73 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800f73:	55                   	push   %ebp
  800f74:	89 e5                	mov    %esp,%ebp
  800f76:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800f79:	83 ec 0c             	sub    $0xc,%esp
  800f7c:	6a 00                	push   $0x0
  800f7e:	e8 cc 14 00 00       	call   80244f <sys_env_destroy>
  800f83:	83 c4 10             	add    $0x10,%esp
}
  800f86:	90                   	nop
  800f87:	c9                   	leave  
  800f88:	c3                   	ret    

00800f89 <exit>:

void
exit(void)
{
  800f89:	55                   	push   %ebp
  800f8a:	89 e5                	mov    %esp,%ebp
  800f8c:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800f8f:	e8 21 15 00 00       	call   8024b5 <sys_env_exit>
}
  800f94:	90                   	nop
  800f95:	c9                   	leave  
  800f96:	c3                   	ret    

00800f97 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800f97:	55                   	push   %ebp
  800f98:	89 e5                	mov    %esp,%ebp
  800f9a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800f9d:	8d 45 10             	lea    0x10(%ebp),%eax
  800fa0:	83 c0 04             	add    $0x4,%eax
  800fa3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800fa6:	a1 18 41 80 00       	mov    0x804118,%eax
  800fab:	85 c0                	test   %eax,%eax
  800fad:	74 16                	je     800fc5 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800faf:	a1 18 41 80 00       	mov    0x804118,%eax
  800fb4:	83 ec 08             	sub    $0x8,%esp
  800fb7:	50                   	push   %eax
  800fb8:	68 e8 2e 80 00       	push   $0x802ee8
  800fbd:	e8 8c 02 00 00       	call   80124e <cprintf>
  800fc2:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800fc5:	a1 00 40 80 00       	mov    0x804000,%eax
  800fca:	ff 75 0c             	pushl  0xc(%ebp)
  800fcd:	ff 75 08             	pushl  0x8(%ebp)
  800fd0:	50                   	push   %eax
  800fd1:	68 ed 2e 80 00       	push   $0x802eed
  800fd6:	e8 73 02 00 00       	call   80124e <cprintf>
  800fdb:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800fde:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe1:	83 ec 08             	sub    $0x8,%esp
  800fe4:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe7:	50                   	push   %eax
  800fe8:	e8 f6 01 00 00       	call   8011e3 <vcprintf>
  800fed:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800ff0:	83 ec 08             	sub    $0x8,%esp
  800ff3:	6a 00                	push   $0x0
  800ff5:	68 09 2f 80 00       	push   $0x802f09
  800ffa:	e8 e4 01 00 00       	call   8011e3 <vcprintf>
  800fff:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801002:	e8 82 ff ff ff       	call   800f89 <exit>

	// should not return here
	while (1) ;
  801007:	eb fe                	jmp    801007 <_panic+0x70>

00801009 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801009:	55                   	push   %ebp
  80100a:	89 e5                	mov    %esp,%ebp
  80100c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80100f:	a1 20 40 80 00       	mov    0x804020,%eax
  801014:	8b 50 74             	mov    0x74(%eax),%edx
  801017:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101a:	39 c2                	cmp    %eax,%edx
  80101c:	74 14                	je     801032 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80101e:	83 ec 04             	sub    $0x4,%esp
  801021:	68 0c 2f 80 00       	push   $0x802f0c
  801026:	6a 26                	push   $0x26
  801028:	68 58 2f 80 00       	push   $0x802f58
  80102d:	e8 65 ff ff ff       	call   800f97 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801032:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801039:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801040:	e9 c4 00 00 00       	jmp    801109 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  801045:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801048:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	01 d0                	add    %edx,%eax
  801054:	8b 00                	mov    (%eax),%eax
  801056:	85 c0                	test   %eax,%eax
  801058:	75 08                	jne    801062 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80105a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80105d:	e9 a4 00 00 00       	jmp    801106 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  801062:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801069:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801070:	eb 6b                	jmp    8010dd <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801072:	a1 20 40 80 00       	mov    0x804020,%eax
  801077:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80107d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801080:	89 d0                	mov    %edx,%eax
  801082:	c1 e0 02             	shl    $0x2,%eax
  801085:	01 d0                	add    %edx,%eax
  801087:	c1 e0 02             	shl    $0x2,%eax
  80108a:	01 c8                	add    %ecx,%eax
  80108c:	8a 40 04             	mov    0x4(%eax),%al
  80108f:	84 c0                	test   %al,%al
  801091:	75 47                	jne    8010da <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801093:	a1 20 40 80 00       	mov    0x804020,%eax
  801098:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80109e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8010a1:	89 d0                	mov    %edx,%eax
  8010a3:	c1 e0 02             	shl    $0x2,%eax
  8010a6:	01 d0                	add    %edx,%eax
  8010a8:	c1 e0 02             	shl    $0x2,%eax
  8010ab:	01 c8                	add    %ecx,%eax
  8010ad:	8b 00                	mov    (%eax),%eax
  8010af:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8010b2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8010b5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010ba:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8010bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010bf:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	01 c8                	add    %ecx,%eax
  8010cb:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8010cd:	39 c2                	cmp    %eax,%edx
  8010cf:	75 09                	jne    8010da <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  8010d1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8010d8:	eb 12                	jmp    8010ec <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8010da:	ff 45 e8             	incl   -0x18(%ebp)
  8010dd:	a1 20 40 80 00       	mov    0x804020,%eax
  8010e2:	8b 50 74             	mov    0x74(%eax),%edx
  8010e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010e8:	39 c2                	cmp    %eax,%edx
  8010ea:	77 86                	ja     801072 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8010ec:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010f0:	75 14                	jne    801106 <CheckWSWithoutLastIndex+0xfd>
			panic(
  8010f2:	83 ec 04             	sub    $0x4,%esp
  8010f5:	68 64 2f 80 00       	push   $0x802f64
  8010fa:	6a 3a                	push   $0x3a
  8010fc:	68 58 2f 80 00       	push   $0x802f58
  801101:	e8 91 fe ff ff       	call   800f97 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801106:	ff 45 f0             	incl   -0x10(%ebp)
  801109:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80110c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80110f:	0f 8c 30 ff ff ff    	jl     801045 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801115:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80111c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801123:	eb 27                	jmp    80114c <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801125:	a1 20 40 80 00       	mov    0x804020,%eax
  80112a:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801130:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801133:	89 d0                	mov    %edx,%eax
  801135:	c1 e0 02             	shl    $0x2,%eax
  801138:	01 d0                	add    %edx,%eax
  80113a:	c1 e0 02             	shl    $0x2,%eax
  80113d:	01 c8                	add    %ecx,%eax
  80113f:	8a 40 04             	mov    0x4(%eax),%al
  801142:	3c 01                	cmp    $0x1,%al
  801144:	75 03                	jne    801149 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  801146:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801149:	ff 45 e0             	incl   -0x20(%ebp)
  80114c:	a1 20 40 80 00       	mov    0x804020,%eax
  801151:	8b 50 74             	mov    0x74(%eax),%edx
  801154:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801157:	39 c2                	cmp    %eax,%edx
  801159:	77 ca                	ja     801125 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80115b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80115e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801161:	74 14                	je     801177 <CheckWSWithoutLastIndex+0x16e>
		panic(
  801163:	83 ec 04             	sub    $0x4,%esp
  801166:	68 b8 2f 80 00       	push   $0x802fb8
  80116b:	6a 44                	push   $0x44
  80116d:	68 58 2f 80 00       	push   $0x802f58
  801172:	e8 20 fe ff ff       	call   800f97 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801177:	90                   	nop
  801178:	c9                   	leave  
  801179:	c3                   	ret    

0080117a <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80117a:	55                   	push   %ebp
  80117b:	89 e5                	mov    %esp,%ebp
  80117d:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801180:	8b 45 0c             	mov    0xc(%ebp),%eax
  801183:	8b 00                	mov    (%eax),%eax
  801185:	8d 48 01             	lea    0x1(%eax),%ecx
  801188:	8b 55 0c             	mov    0xc(%ebp),%edx
  80118b:	89 0a                	mov    %ecx,(%edx)
  80118d:	8b 55 08             	mov    0x8(%ebp),%edx
  801190:	88 d1                	mov    %dl,%cl
  801192:	8b 55 0c             	mov    0xc(%ebp),%edx
  801195:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801199:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119c:	8b 00                	mov    (%eax),%eax
  80119e:	3d ff 00 00 00       	cmp    $0xff,%eax
  8011a3:	75 2c                	jne    8011d1 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8011a5:	a0 24 40 80 00       	mov    0x804024,%al
  8011aa:	0f b6 c0             	movzbl %al,%eax
  8011ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011b0:	8b 12                	mov    (%edx),%edx
  8011b2:	89 d1                	mov    %edx,%ecx
  8011b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011b7:	83 c2 08             	add    $0x8,%edx
  8011ba:	83 ec 04             	sub    $0x4,%esp
  8011bd:	50                   	push   %eax
  8011be:	51                   	push   %ecx
  8011bf:	52                   	push   %edx
  8011c0:	e8 48 12 00 00       	call   80240d <sys_cputs>
  8011c5:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8011c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8011d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d4:	8b 40 04             	mov    0x4(%eax),%eax
  8011d7:	8d 50 01             	lea    0x1(%eax),%edx
  8011da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dd:	89 50 04             	mov    %edx,0x4(%eax)
}
  8011e0:	90                   	nop
  8011e1:	c9                   	leave  
  8011e2:	c3                   	ret    

008011e3 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8011e3:	55                   	push   %ebp
  8011e4:	89 e5                	mov    %esp,%ebp
  8011e6:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8011ec:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8011f3:	00 00 00 
	b.cnt = 0;
  8011f6:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8011fd:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801200:	ff 75 0c             	pushl  0xc(%ebp)
  801203:	ff 75 08             	pushl  0x8(%ebp)
  801206:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80120c:	50                   	push   %eax
  80120d:	68 7a 11 80 00       	push   $0x80117a
  801212:	e8 11 02 00 00       	call   801428 <vprintfmt>
  801217:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80121a:	a0 24 40 80 00       	mov    0x804024,%al
  80121f:	0f b6 c0             	movzbl %al,%eax
  801222:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801228:	83 ec 04             	sub    $0x4,%esp
  80122b:	50                   	push   %eax
  80122c:	52                   	push   %edx
  80122d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801233:	83 c0 08             	add    $0x8,%eax
  801236:	50                   	push   %eax
  801237:	e8 d1 11 00 00       	call   80240d <sys_cputs>
  80123c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80123f:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801246:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80124c:	c9                   	leave  
  80124d:	c3                   	ret    

0080124e <cprintf>:

int cprintf(const char *fmt, ...) {
  80124e:	55                   	push   %ebp
  80124f:	89 e5                	mov    %esp,%ebp
  801251:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801254:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  80125b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80125e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801261:	8b 45 08             	mov    0x8(%ebp),%eax
  801264:	83 ec 08             	sub    $0x8,%esp
  801267:	ff 75 f4             	pushl  -0xc(%ebp)
  80126a:	50                   	push   %eax
  80126b:	e8 73 ff ff ff       	call   8011e3 <vcprintf>
  801270:	83 c4 10             	add    $0x10,%esp
  801273:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801276:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801279:	c9                   	leave  
  80127a:	c3                   	ret    

0080127b <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80127b:	55                   	push   %ebp
  80127c:	89 e5                	mov    %esp,%ebp
  80127e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801281:	e8 98 13 00 00       	call   80261e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801286:	8d 45 0c             	lea    0xc(%ebp),%eax
  801289:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80128c:	8b 45 08             	mov    0x8(%ebp),%eax
  80128f:	83 ec 08             	sub    $0x8,%esp
  801292:	ff 75 f4             	pushl  -0xc(%ebp)
  801295:	50                   	push   %eax
  801296:	e8 48 ff ff ff       	call   8011e3 <vcprintf>
  80129b:	83 c4 10             	add    $0x10,%esp
  80129e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8012a1:	e8 92 13 00 00       	call   802638 <sys_enable_interrupt>
	return cnt;
  8012a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012a9:	c9                   	leave  
  8012aa:	c3                   	ret    

008012ab <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8012ab:	55                   	push   %ebp
  8012ac:	89 e5                	mov    %esp,%ebp
  8012ae:	53                   	push   %ebx
  8012af:	83 ec 14             	sub    $0x14,%esp
  8012b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8012bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8012be:	8b 45 18             	mov    0x18(%ebp),%eax
  8012c1:	ba 00 00 00 00       	mov    $0x0,%edx
  8012c6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8012c9:	77 55                	ja     801320 <printnum+0x75>
  8012cb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8012ce:	72 05                	jb     8012d5 <printnum+0x2a>
  8012d0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012d3:	77 4b                	ja     801320 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8012d5:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8012d8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8012db:	8b 45 18             	mov    0x18(%ebp),%eax
  8012de:	ba 00 00 00 00       	mov    $0x0,%edx
  8012e3:	52                   	push   %edx
  8012e4:	50                   	push   %eax
  8012e5:	ff 75 f4             	pushl  -0xc(%ebp)
  8012e8:	ff 75 f0             	pushl  -0x10(%ebp)
  8012eb:	e8 6c 17 00 00       	call   802a5c <__udivdi3>
  8012f0:	83 c4 10             	add    $0x10,%esp
  8012f3:	83 ec 04             	sub    $0x4,%esp
  8012f6:	ff 75 20             	pushl  0x20(%ebp)
  8012f9:	53                   	push   %ebx
  8012fa:	ff 75 18             	pushl  0x18(%ebp)
  8012fd:	52                   	push   %edx
  8012fe:	50                   	push   %eax
  8012ff:	ff 75 0c             	pushl  0xc(%ebp)
  801302:	ff 75 08             	pushl  0x8(%ebp)
  801305:	e8 a1 ff ff ff       	call   8012ab <printnum>
  80130a:	83 c4 20             	add    $0x20,%esp
  80130d:	eb 1a                	jmp    801329 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80130f:	83 ec 08             	sub    $0x8,%esp
  801312:	ff 75 0c             	pushl  0xc(%ebp)
  801315:	ff 75 20             	pushl  0x20(%ebp)
  801318:	8b 45 08             	mov    0x8(%ebp),%eax
  80131b:	ff d0                	call   *%eax
  80131d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801320:	ff 4d 1c             	decl   0x1c(%ebp)
  801323:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801327:	7f e6                	jg     80130f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801329:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80132c:	bb 00 00 00 00       	mov    $0x0,%ebx
  801331:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801334:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801337:	53                   	push   %ebx
  801338:	51                   	push   %ecx
  801339:	52                   	push   %edx
  80133a:	50                   	push   %eax
  80133b:	e8 2c 18 00 00       	call   802b6c <__umoddi3>
  801340:	83 c4 10             	add    $0x10,%esp
  801343:	05 34 32 80 00       	add    $0x803234,%eax
  801348:	8a 00                	mov    (%eax),%al
  80134a:	0f be c0             	movsbl %al,%eax
  80134d:	83 ec 08             	sub    $0x8,%esp
  801350:	ff 75 0c             	pushl  0xc(%ebp)
  801353:	50                   	push   %eax
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	ff d0                	call   *%eax
  801359:	83 c4 10             	add    $0x10,%esp
}
  80135c:	90                   	nop
  80135d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801360:	c9                   	leave  
  801361:	c3                   	ret    

00801362 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801365:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801369:	7e 1c                	jle    801387 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	8b 00                	mov    (%eax),%eax
  801370:	8d 50 08             	lea    0x8(%eax),%edx
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	89 10                	mov    %edx,(%eax)
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	8b 00                	mov    (%eax),%eax
  80137d:	83 e8 08             	sub    $0x8,%eax
  801380:	8b 50 04             	mov    0x4(%eax),%edx
  801383:	8b 00                	mov    (%eax),%eax
  801385:	eb 40                	jmp    8013c7 <getuint+0x65>
	else if (lflag)
  801387:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80138b:	74 1e                	je     8013ab <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80138d:	8b 45 08             	mov    0x8(%ebp),%eax
  801390:	8b 00                	mov    (%eax),%eax
  801392:	8d 50 04             	lea    0x4(%eax),%edx
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	89 10                	mov    %edx,(%eax)
  80139a:	8b 45 08             	mov    0x8(%ebp),%eax
  80139d:	8b 00                	mov    (%eax),%eax
  80139f:	83 e8 04             	sub    $0x4,%eax
  8013a2:	8b 00                	mov    (%eax),%eax
  8013a4:	ba 00 00 00 00       	mov    $0x0,%edx
  8013a9:	eb 1c                	jmp    8013c7 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ae:	8b 00                	mov    (%eax),%eax
  8013b0:	8d 50 04             	lea    0x4(%eax),%edx
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	89 10                	mov    %edx,(%eax)
  8013b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bb:	8b 00                	mov    (%eax),%eax
  8013bd:	83 e8 04             	sub    $0x4,%eax
  8013c0:	8b 00                	mov    (%eax),%eax
  8013c2:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8013c7:	5d                   	pop    %ebp
  8013c8:	c3                   	ret    

008013c9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8013cc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8013d0:	7e 1c                	jle    8013ee <getint+0x25>
		return va_arg(*ap, long long);
  8013d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d5:	8b 00                	mov    (%eax),%eax
  8013d7:	8d 50 08             	lea    0x8(%eax),%edx
  8013da:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dd:	89 10                	mov    %edx,(%eax)
  8013df:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e2:	8b 00                	mov    (%eax),%eax
  8013e4:	83 e8 08             	sub    $0x8,%eax
  8013e7:	8b 50 04             	mov    0x4(%eax),%edx
  8013ea:	8b 00                	mov    (%eax),%eax
  8013ec:	eb 38                	jmp    801426 <getint+0x5d>
	else if (lflag)
  8013ee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013f2:	74 1a                	je     80140e <getint+0x45>
		return va_arg(*ap, long);
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	8b 00                	mov    (%eax),%eax
  8013f9:	8d 50 04             	lea    0x4(%eax),%edx
  8013fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ff:	89 10                	mov    %edx,(%eax)
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	8b 00                	mov    (%eax),%eax
  801406:	83 e8 04             	sub    $0x4,%eax
  801409:	8b 00                	mov    (%eax),%eax
  80140b:	99                   	cltd   
  80140c:	eb 18                	jmp    801426 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	8b 00                	mov    (%eax),%eax
  801413:	8d 50 04             	lea    0x4(%eax),%edx
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	89 10                	mov    %edx,(%eax)
  80141b:	8b 45 08             	mov    0x8(%ebp),%eax
  80141e:	8b 00                	mov    (%eax),%eax
  801420:	83 e8 04             	sub    $0x4,%eax
  801423:	8b 00                	mov    (%eax),%eax
  801425:	99                   	cltd   
}
  801426:	5d                   	pop    %ebp
  801427:	c3                   	ret    

00801428 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801428:	55                   	push   %ebp
  801429:	89 e5                	mov    %esp,%ebp
  80142b:	56                   	push   %esi
  80142c:	53                   	push   %ebx
  80142d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801430:	eb 17                	jmp    801449 <vprintfmt+0x21>
			if (ch == '\0')
  801432:	85 db                	test   %ebx,%ebx
  801434:	0f 84 af 03 00 00    	je     8017e9 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80143a:	83 ec 08             	sub    $0x8,%esp
  80143d:	ff 75 0c             	pushl  0xc(%ebp)
  801440:	53                   	push   %ebx
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	ff d0                	call   *%eax
  801446:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801449:	8b 45 10             	mov    0x10(%ebp),%eax
  80144c:	8d 50 01             	lea    0x1(%eax),%edx
  80144f:	89 55 10             	mov    %edx,0x10(%ebp)
  801452:	8a 00                	mov    (%eax),%al
  801454:	0f b6 d8             	movzbl %al,%ebx
  801457:	83 fb 25             	cmp    $0x25,%ebx
  80145a:	75 d6                	jne    801432 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80145c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801460:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801467:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80146e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801475:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80147c:	8b 45 10             	mov    0x10(%ebp),%eax
  80147f:	8d 50 01             	lea    0x1(%eax),%edx
  801482:	89 55 10             	mov    %edx,0x10(%ebp)
  801485:	8a 00                	mov    (%eax),%al
  801487:	0f b6 d8             	movzbl %al,%ebx
  80148a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80148d:	83 f8 55             	cmp    $0x55,%eax
  801490:	0f 87 2b 03 00 00    	ja     8017c1 <vprintfmt+0x399>
  801496:	8b 04 85 58 32 80 00 	mov    0x803258(,%eax,4),%eax
  80149d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80149f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8014a3:	eb d7                	jmp    80147c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8014a5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8014a9:	eb d1                	jmp    80147c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8014ab:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8014b2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8014b5:	89 d0                	mov    %edx,%eax
  8014b7:	c1 e0 02             	shl    $0x2,%eax
  8014ba:	01 d0                	add    %edx,%eax
  8014bc:	01 c0                	add    %eax,%eax
  8014be:	01 d8                	add    %ebx,%eax
  8014c0:	83 e8 30             	sub    $0x30,%eax
  8014c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8014c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c9:	8a 00                	mov    (%eax),%al
  8014cb:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8014ce:	83 fb 2f             	cmp    $0x2f,%ebx
  8014d1:	7e 3e                	jle    801511 <vprintfmt+0xe9>
  8014d3:	83 fb 39             	cmp    $0x39,%ebx
  8014d6:	7f 39                	jg     801511 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8014d8:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8014db:	eb d5                	jmp    8014b2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8014dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8014e0:	83 c0 04             	add    $0x4,%eax
  8014e3:	89 45 14             	mov    %eax,0x14(%ebp)
  8014e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8014e9:	83 e8 04             	sub    $0x4,%eax
  8014ec:	8b 00                	mov    (%eax),%eax
  8014ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8014f1:	eb 1f                	jmp    801512 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8014f3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8014f7:	79 83                	jns    80147c <vprintfmt+0x54>
				width = 0;
  8014f9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801500:	e9 77 ff ff ff       	jmp    80147c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801505:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80150c:	e9 6b ff ff ff       	jmp    80147c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801511:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801512:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801516:	0f 89 60 ff ff ff    	jns    80147c <vprintfmt+0x54>
				width = precision, precision = -1;
  80151c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80151f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801522:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801529:	e9 4e ff ff ff       	jmp    80147c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80152e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801531:	e9 46 ff ff ff       	jmp    80147c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801536:	8b 45 14             	mov    0x14(%ebp),%eax
  801539:	83 c0 04             	add    $0x4,%eax
  80153c:	89 45 14             	mov    %eax,0x14(%ebp)
  80153f:	8b 45 14             	mov    0x14(%ebp),%eax
  801542:	83 e8 04             	sub    $0x4,%eax
  801545:	8b 00                	mov    (%eax),%eax
  801547:	83 ec 08             	sub    $0x8,%esp
  80154a:	ff 75 0c             	pushl  0xc(%ebp)
  80154d:	50                   	push   %eax
  80154e:	8b 45 08             	mov    0x8(%ebp),%eax
  801551:	ff d0                	call   *%eax
  801553:	83 c4 10             	add    $0x10,%esp
			break;
  801556:	e9 89 02 00 00       	jmp    8017e4 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80155b:	8b 45 14             	mov    0x14(%ebp),%eax
  80155e:	83 c0 04             	add    $0x4,%eax
  801561:	89 45 14             	mov    %eax,0x14(%ebp)
  801564:	8b 45 14             	mov    0x14(%ebp),%eax
  801567:	83 e8 04             	sub    $0x4,%eax
  80156a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80156c:	85 db                	test   %ebx,%ebx
  80156e:	79 02                	jns    801572 <vprintfmt+0x14a>
				err = -err;
  801570:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801572:	83 fb 64             	cmp    $0x64,%ebx
  801575:	7f 0b                	jg     801582 <vprintfmt+0x15a>
  801577:	8b 34 9d a0 30 80 00 	mov    0x8030a0(,%ebx,4),%esi
  80157e:	85 f6                	test   %esi,%esi
  801580:	75 19                	jne    80159b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801582:	53                   	push   %ebx
  801583:	68 45 32 80 00       	push   $0x803245
  801588:	ff 75 0c             	pushl  0xc(%ebp)
  80158b:	ff 75 08             	pushl  0x8(%ebp)
  80158e:	e8 5e 02 00 00       	call   8017f1 <printfmt>
  801593:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801596:	e9 49 02 00 00       	jmp    8017e4 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80159b:	56                   	push   %esi
  80159c:	68 4e 32 80 00       	push   $0x80324e
  8015a1:	ff 75 0c             	pushl  0xc(%ebp)
  8015a4:	ff 75 08             	pushl  0x8(%ebp)
  8015a7:	e8 45 02 00 00       	call   8017f1 <printfmt>
  8015ac:	83 c4 10             	add    $0x10,%esp
			break;
  8015af:	e9 30 02 00 00       	jmp    8017e4 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8015b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8015b7:	83 c0 04             	add    $0x4,%eax
  8015ba:	89 45 14             	mov    %eax,0x14(%ebp)
  8015bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8015c0:	83 e8 04             	sub    $0x4,%eax
  8015c3:	8b 30                	mov    (%eax),%esi
  8015c5:	85 f6                	test   %esi,%esi
  8015c7:	75 05                	jne    8015ce <vprintfmt+0x1a6>
				p = "(null)";
  8015c9:	be 51 32 80 00       	mov    $0x803251,%esi
			if (width > 0 && padc != '-')
  8015ce:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8015d2:	7e 6d                	jle    801641 <vprintfmt+0x219>
  8015d4:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8015d8:	74 67                	je     801641 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8015da:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015dd:	83 ec 08             	sub    $0x8,%esp
  8015e0:	50                   	push   %eax
  8015e1:	56                   	push   %esi
  8015e2:	e8 0c 03 00 00       	call   8018f3 <strnlen>
  8015e7:	83 c4 10             	add    $0x10,%esp
  8015ea:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8015ed:	eb 16                	jmp    801605 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8015ef:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8015f3:	83 ec 08             	sub    $0x8,%esp
  8015f6:	ff 75 0c             	pushl  0xc(%ebp)
  8015f9:	50                   	push   %eax
  8015fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fd:	ff d0                	call   *%eax
  8015ff:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801602:	ff 4d e4             	decl   -0x1c(%ebp)
  801605:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801609:	7f e4                	jg     8015ef <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80160b:	eb 34                	jmp    801641 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80160d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801611:	74 1c                	je     80162f <vprintfmt+0x207>
  801613:	83 fb 1f             	cmp    $0x1f,%ebx
  801616:	7e 05                	jle    80161d <vprintfmt+0x1f5>
  801618:	83 fb 7e             	cmp    $0x7e,%ebx
  80161b:	7e 12                	jle    80162f <vprintfmt+0x207>
					putch('?', putdat);
  80161d:	83 ec 08             	sub    $0x8,%esp
  801620:	ff 75 0c             	pushl  0xc(%ebp)
  801623:	6a 3f                	push   $0x3f
  801625:	8b 45 08             	mov    0x8(%ebp),%eax
  801628:	ff d0                	call   *%eax
  80162a:	83 c4 10             	add    $0x10,%esp
  80162d:	eb 0f                	jmp    80163e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80162f:	83 ec 08             	sub    $0x8,%esp
  801632:	ff 75 0c             	pushl  0xc(%ebp)
  801635:	53                   	push   %ebx
  801636:	8b 45 08             	mov    0x8(%ebp),%eax
  801639:	ff d0                	call   *%eax
  80163b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80163e:	ff 4d e4             	decl   -0x1c(%ebp)
  801641:	89 f0                	mov    %esi,%eax
  801643:	8d 70 01             	lea    0x1(%eax),%esi
  801646:	8a 00                	mov    (%eax),%al
  801648:	0f be d8             	movsbl %al,%ebx
  80164b:	85 db                	test   %ebx,%ebx
  80164d:	74 24                	je     801673 <vprintfmt+0x24b>
  80164f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801653:	78 b8                	js     80160d <vprintfmt+0x1e5>
  801655:	ff 4d e0             	decl   -0x20(%ebp)
  801658:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80165c:	79 af                	jns    80160d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80165e:	eb 13                	jmp    801673 <vprintfmt+0x24b>
				putch(' ', putdat);
  801660:	83 ec 08             	sub    $0x8,%esp
  801663:	ff 75 0c             	pushl  0xc(%ebp)
  801666:	6a 20                	push   $0x20
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	ff d0                	call   *%eax
  80166d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801670:	ff 4d e4             	decl   -0x1c(%ebp)
  801673:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801677:	7f e7                	jg     801660 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801679:	e9 66 01 00 00       	jmp    8017e4 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80167e:	83 ec 08             	sub    $0x8,%esp
  801681:	ff 75 e8             	pushl  -0x18(%ebp)
  801684:	8d 45 14             	lea    0x14(%ebp),%eax
  801687:	50                   	push   %eax
  801688:	e8 3c fd ff ff       	call   8013c9 <getint>
  80168d:	83 c4 10             	add    $0x10,%esp
  801690:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801693:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801696:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801699:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80169c:	85 d2                	test   %edx,%edx
  80169e:	79 23                	jns    8016c3 <vprintfmt+0x29b>
				putch('-', putdat);
  8016a0:	83 ec 08             	sub    $0x8,%esp
  8016a3:	ff 75 0c             	pushl  0xc(%ebp)
  8016a6:	6a 2d                	push   $0x2d
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	ff d0                	call   *%eax
  8016ad:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8016b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016b6:	f7 d8                	neg    %eax
  8016b8:	83 d2 00             	adc    $0x0,%edx
  8016bb:	f7 da                	neg    %edx
  8016bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8016c3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8016ca:	e9 bc 00 00 00       	jmp    80178b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8016cf:	83 ec 08             	sub    $0x8,%esp
  8016d2:	ff 75 e8             	pushl  -0x18(%ebp)
  8016d5:	8d 45 14             	lea    0x14(%ebp),%eax
  8016d8:	50                   	push   %eax
  8016d9:	e8 84 fc ff ff       	call   801362 <getuint>
  8016de:	83 c4 10             	add    $0x10,%esp
  8016e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016e4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8016e7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8016ee:	e9 98 00 00 00       	jmp    80178b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8016f3:	83 ec 08             	sub    $0x8,%esp
  8016f6:	ff 75 0c             	pushl  0xc(%ebp)
  8016f9:	6a 58                	push   $0x58
  8016fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fe:	ff d0                	call   *%eax
  801700:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801703:	83 ec 08             	sub    $0x8,%esp
  801706:	ff 75 0c             	pushl  0xc(%ebp)
  801709:	6a 58                	push   $0x58
  80170b:	8b 45 08             	mov    0x8(%ebp),%eax
  80170e:	ff d0                	call   *%eax
  801710:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801713:	83 ec 08             	sub    $0x8,%esp
  801716:	ff 75 0c             	pushl  0xc(%ebp)
  801719:	6a 58                	push   $0x58
  80171b:	8b 45 08             	mov    0x8(%ebp),%eax
  80171e:	ff d0                	call   *%eax
  801720:	83 c4 10             	add    $0x10,%esp
			break;
  801723:	e9 bc 00 00 00       	jmp    8017e4 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801728:	83 ec 08             	sub    $0x8,%esp
  80172b:	ff 75 0c             	pushl  0xc(%ebp)
  80172e:	6a 30                	push   $0x30
  801730:	8b 45 08             	mov    0x8(%ebp),%eax
  801733:	ff d0                	call   *%eax
  801735:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801738:	83 ec 08             	sub    $0x8,%esp
  80173b:	ff 75 0c             	pushl  0xc(%ebp)
  80173e:	6a 78                	push   $0x78
  801740:	8b 45 08             	mov    0x8(%ebp),%eax
  801743:	ff d0                	call   *%eax
  801745:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801748:	8b 45 14             	mov    0x14(%ebp),%eax
  80174b:	83 c0 04             	add    $0x4,%eax
  80174e:	89 45 14             	mov    %eax,0x14(%ebp)
  801751:	8b 45 14             	mov    0x14(%ebp),%eax
  801754:	83 e8 04             	sub    $0x4,%eax
  801757:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801759:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80175c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801763:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80176a:	eb 1f                	jmp    80178b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80176c:	83 ec 08             	sub    $0x8,%esp
  80176f:	ff 75 e8             	pushl  -0x18(%ebp)
  801772:	8d 45 14             	lea    0x14(%ebp),%eax
  801775:	50                   	push   %eax
  801776:	e8 e7 fb ff ff       	call   801362 <getuint>
  80177b:	83 c4 10             	add    $0x10,%esp
  80177e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801781:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801784:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80178b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80178f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801792:	83 ec 04             	sub    $0x4,%esp
  801795:	52                   	push   %edx
  801796:	ff 75 e4             	pushl  -0x1c(%ebp)
  801799:	50                   	push   %eax
  80179a:	ff 75 f4             	pushl  -0xc(%ebp)
  80179d:	ff 75 f0             	pushl  -0x10(%ebp)
  8017a0:	ff 75 0c             	pushl  0xc(%ebp)
  8017a3:	ff 75 08             	pushl  0x8(%ebp)
  8017a6:	e8 00 fb ff ff       	call   8012ab <printnum>
  8017ab:	83 c4 20             	add    $0x20,%esp
			break;
  8017ae:	eb 34                	jmp    8017e4 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8017b0:	83 ec 08             	sub    $0x8,%esp
  8017b3:	ff 75 0c             	pushl  0xc(%ebp)
  8017b6:	53                   	push   %ebx
  8017b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ba:	ff d0                	call   *%eax
  8017bc:	83 c4 10             	add    $0x10,%esp
			break;
  8017bf:	eb 23                	jmp    8017e4 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8017c1:	83 ec 08             	sub    $0x8,%esp
  8017c4:	ff 75 0c             	pushl  0xc(%ebp)
  8017c7:	6a 25                	push   $0x25
  8017c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cc:	ff d0                	call   *%eax
  8017ce:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8017d1:	ff 4d 10             	decl   0x10(%ebp)
  8017d4:	eb 03                	jmp    8017d9 <vprintfmt+0x3b1>
  8017d6:	ff 4d 10             	decl   0x10(%ebp)
  8017d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8017dc:	48                   	dec    %eax
  8017dd:	8a 00                	mov    (%eax),%al
  8017df:	3c 25                	cmp    $0x25,%al
  8017e1:	75 f3                	jne    8017d6 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8017e3:	90                   	nop
		}
	}
  8017e4:	e9 47 fc ff ff       	jmp    801430 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8017e9:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8017ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017ed:	5b                   	pop    %ebx
  8017ee:	5e                   	pop    %esi
  8017ef:	5d                   	pop    %ebp
  8017f0:	c3                   	ret    

008017f1 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
  8017f4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8017f7:	8d 45 10             	lea    0x10(%ebp),%eax
  8017fa:	83 c0 04             	add    $0x4,%eax
  8017fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801800:	8b 45 10             	mov    0x10(%ebp),%eax
  801803:	ff 75 f4             	pushl  -0xc(%ebp)
  801806:	50                   	push   %eax
  801807:	ff 75 0c             	pushl  0xc(%ebp)
  80180a:	ff 75 08             	pushl  0x8(%ebp)
  80180d:	e8 16 fc ff ff       	call   801428 <vprintfmt>
  801812:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801815:	90                   	nop
  801816:	c9                   	leave  
  801817:	c3                   	ret    

00801818 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801818:	55                   	push   %ebp
  801819:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80181b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181e:	8b 40 08             	mov    0x8(%eax),%eax
  801821:	8d 50 01             	lea    0x1(%eax),%edx
  801824:	8b 45 0c             	mov    0xc(%ebp),%eax
  801827:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80182a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182d:	8b 10                	mov    (%eax),%edx
  80182f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801832:	8b 40 04             	mov    0x4(%eax),%eax
  801835:	39 c2                	cmp    %eax,%edx
  801837:	73 12                	jae    80184b <sprintputch+0x33>
		*b->buf++ = ch;
  801839:	8b 45 0c             	mov    0xc(%ebp),%eax
  80183c:	8b 00                	mov    (%eax),%eax
  80183e:	8d 48 01             	lea    0x1(%eax),%ecx
  801841:	8b 55 0c             	mov    0xc(%ebp),%edx
  801844:	89 0a                	mov    %ecx,(%edx)
  801846:	8b 55 08             	mov    0x8(%ebp),%edx
  801849:	88 10                	mov    %dl,(%eax)
}
  80184b:	90                   	nop
  80184c:	5d                   	pop    %ebp
  80184d:	c3                   	ret    

0080184e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80184e:	55                   	push   %ebp
  80184f:	89 e5                	mov    %esp,%ebp
  801851:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801854:	8b 45 08             	mov    0x8(%ebp),%eax
  801857:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80185a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80185d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801860:	8b 45 08             	mov    0x8(%ebp),%eax
  801863:	01 d0                	add    %edx,%eax
  801865:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801868:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80186f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801873:	74 06                	je     80187b <vsnprintf+0x2d>
  801875:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801879:	7f 07                	jg     801882 <vsnprintf+0x34>
		return -E_INVAL;
  80187b:	b8 03 00 00 00       	mov    $0x3,%eax
  801880:	eb 20                	jmp    8018a2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801882:	ff 75 14             	pushl  0x14(%ebp)
  801885:	ff 75 10             	pushl  0x10(%ebp)
  801888:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80188b:	50                   	push   %eax
  80188c:	68 18 18 80 00       	push   $0x801818
  801891:	e8 92 fb ff ff       	call   801428 <vprintfmt>
  801896:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801899:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80189c:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80189f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8018a2:	c9                   	leave  
  8018a3:	c3                   	ret    

008018a4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8018a4:	55                   	push   %ebp
  8018a5:	89 e5                	mov    %esp,%ebp
  8018a7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8018aa:	8d 45 10             	lea    0x10(%ebp),%eax
  8018ad:	83 c0 04             	add    $0x4,%eax
  8018b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8018b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8018b9:	50                   	push   %eax
  8018ba:	ff 75 0c             	pushl  0xc(%ebp)
  8018bd:	ff 75 08             	pushl  0x8(%ebp)
  8018c0:	e8 89 ff ff ff       	call   80184e <vsnprintf>
  8018c5:	83 c4 10             	add    $0x10,%esp
  8018c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8018cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8018ce:	c9                   	leave  
  8018cf:	c3                   	ret    

008018d0 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8018d0:	55                   	push   %ebp
  8018d1:	89 e5                	mov    %esp,%ebp
  8018d3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8018d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018dd:	eb 06                	jmp    8018e5 <strlen+0x15>
		n++;
  8018df:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8018e2:	ff 45 08             	incl   0x8(%ebp)
  8018e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e8:	8a 00                	mov    (%eax),%al
  8018ea:	84 c0                	test   %al,%al
  8018ec:	75 f1                	jne    8018df <strlen+0xf>
		n++;
	return n;
  8018ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8018f1:	c9                   	leave  
  8018f2:	c3                   	ret    

008018f3 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8018f3:	55                   	push   %ebp
  8018f4:	89 e5                	mov    %esp,%ebp
  8018f6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8018f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801900:	eb 09                	jmp    80190b <strnlen+0x18>
		n++;
  801902:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801905:	ff 45 08             	incl   0x8(%ebp)
  801908:	ff 4d 0c             	decl   0xc(%ebp)
  80190b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80190f:	74 09                	je     80191a <strnlen+0x27>
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	8a 00                	mov    (%eax),%al
  801916:	84 c0                	test   %al,%al
  801918:	75 e8                	jne    801902 <strnlen+0xf>
		n++;
	return n;
  80191a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80191d:	c9                   	leave  
  80191e:	c3                   	ret    

0080191f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80191f:	55                   	push   %ebp
  801920:	89 e5                	mov    %esp,%ebp
  801922:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801925:	8b 45 08             	mov    0x8(%ebp),%eax
  801928:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80192b:	90                   	nop
  80192c:	8b 45 08             	mov    0x8(%ebp),%eax
  80192f:	8d 50 01             	lea    0x1(%eax),%edx
  801932:	89 55 08             	mov    %edx,0x8(%ebp)
  801935:	8b 55 0c             	mov    0xc(%ebp),%edx
  801938:	8d 4a 01             	lea    0x1(%edx),%ecx
  80193b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80193e:	8a 12                	mov    (%edx),%dl
  801940:	88 10                	mov    %dl,(%eax)
  801942:	8a 00                	mov    (%eax),%al
  801944:	84 c0                	test   %al,%al
  801946:	75 e4                	jne    80192c <strcpy+0xd>
		/* do nothing */;
	return ret;
  801948:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80194b:	c9                   	leave  
  80194c:	c3                   	ret    

0080194d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80194d:	55                   	push   %ebp
  80194e:	89 e5                	mov    %esp,%ebp
  801950:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801953:	8b 45 08             	mov    0x8(%ebp),%eax
  801956:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801959:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801960:	eb 1f                	jmp    801981 <strncpy+0x34>
		*dst++ = *src;
  801962:	8b 45 08             	mov    0x8(%ebp),%eax
  801965:	8d 50 01             	lea    0x1(%eax),%edx
  801968:	89 55 08             	mov    %edx,0x8(%ebp)
  80196b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80196e:	8a 12                	mov    (%edx),%dl
  801970:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801972:	8b 45 0c             	mov    0xc(%ebp),%eax
  801975:	8a 00                	mov    (%eax),%al
  801977:	84 c0                	test   %al,%al
  801979:	74 03                	je     80197e <strncpy+0x31>
			src++;
  80197b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80197e:	ff 45 fc             	incl   -0x4(%ebp)
  801981:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801984:	3b 45 10             	cmp    0x10(%ebp),%eax
  801987:	72 d9                	jb     801962 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801989:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80198c:	c9                   	leave  
  80198d:	c3                   	ret    

0080198e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80198e:	55                   	push   %ebp
  80198f:	89 e5                	mov    %esp,%ebp
  801991:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801994:	8b 45 08             	mov    0x8(%ebp),%eax
  801997:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80199a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80199e:	74 30                	je     8019d0 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8019a0:	eb 16                	jmp    8019b8 <strlcpy+0x2a>
			*dst++ = *src++;
  8019a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a5:	8d 50 01             	lea    0x1(%eax),%edx
  8019a8:	89 55 08             	mov    %edx,0x8(%ebp)
  8019ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ae:	8d 4a 01             	lea    0x1(%edx),%ecx
  8019b1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8019b4:	8a 12                	mov    (%edx),%dl
  8019b6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8019b8:	ff 4d 10             	decl   0x10(%ebp)
  8019bb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019bf:	74 09                	je     8019ca <strlcpy+0x3c>
  8019c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019c4:	8a 00                	mov    (%eax),%al
  8019c6:	84 c0                	test   %al,%al
  8019c8:	75 d8                	jne    8019a2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8019ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cd:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8019d0:	8b 55 08             	mov    0x8(%ebp),%edx
  8019d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019d6:	29 c2                	sub    %eax,%edx
  8019d8:	89 d0                	mov    %edx,%eax
}
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8019df:	eb 06                	jmp    8019e7 <strcmp+0xb>
		p++, q++;
  8019e1:	ff 45 08             	incl   0x8(%ebp)
  8019e4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8019e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ea:	8a 00                	mov    (%eax),%al
  8019ec:	84 c0                	test   %al,%al
  8019ee:	74 0e                	je     8019fe <strcmp+0x22>
  8019f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f3:	8a 10                	mov    (%eax),%dl
  8019f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019f8:	8a 00                	mov    (%eax),%al
  8019fa:	38 c2                	cmp    %al,%dl
  8019fc:	74 e3                	je     8019e1 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8019fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801a01:	8a 00                	mov    (%eax),%al
  801a03:	0f b6 d0             	movzbl %al,%edx
  801a06:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a09:	8a 00                	mov    (%eax),%al
  801a0b:	0f b6 c0             	movzbl %al,%eax
  801a0e:	29 c2                	sub    %eax,%edx
  801a10:	89 d0                	mov    %edx,%eax
}
  801a12:	5d                   	pop    %ebp
  801a13:	c3                   	ret    

00801a14 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801a14:	55                   	push   %ebp
  801a15:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801a17:	eb 09                	jmp    801a22 <strncmp+0xe>
		n--, p++, q++;
  801a19:	ff 4d 10             	decl   0x10(%ebp)
  801a1c:	ff 45 08             	incl   0x8(%ebp)
  801a1f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801a22:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a26:	74 17                	je     801a3f <strncmp+0x2b>
  801a28:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2b:	8a 00                	mov    (%eax),%al
  801a2d:	84 c0                	test   %al,%al
  801a2f:	74 0e                	je     801a3f <strncmp+0x2b>
  801a31:	8b 45 08             	mov    0x8(%ebp),%eax
  801a34:	8a 10                	mov    (%eax),%dl
  801a36:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a39:	8a 00                	mov    (%eax),%al
  801a3b:	38 c2                	cmp    %al,%dl
  801a3d:	74 da                	je     801a19 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801a3f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a43:	75 07                	jne    801a4c <strncmp+0x38>
		return 0;
  801a45:	b8 00 00 00 00       	mov    $0x0,%eax
  801a4a:	eb 14                	jmp    801a60 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4f:	8a 00                	mov    (%eax),%al
  801a51:	0f b6 d0             	movzbl %al,%edx
  801a54:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a57:	8a 00                	mov    (%eax),%al
  801a59:	0f b6 c0             	movzbl %al,%eax
  801a5c:	29 c2                	sub    %eax,%edx
  801a5e:	89 d0                	mov    %edx,%eax
}
  801a60:	5d                   	pop    %ebp
  801a61:	c3                   	ret    

00801a62 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801a62:	55                   	push   %ebp
  801a63:	89 e5                	mov    %esp,%ebp
  801a65:	83 ec 04             	sub    $0x4,%esp
  801a68:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a6b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801a6e:	eb 12                	jmp    801a82 <strchr+0x20>
		if (*s == c)
  801a70:	8b 45 08             	mov    0x8(%ebp),%eax
  801a73:	8a 00                	mov    (%eax),%al
  801a75:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801a78:	75 05                	jne    801a7f <strchr+0x1d>
			return (char *) s;
  801a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7d:	eb 11                	jmp    801a90 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801a7f:	ff 45 08             	incl   0x8(%ebp)
  801a82:	8b 45 08             	mov    0x8(%ebp),%eax
  801a85:	8a 00                	mov    (%eax),%al
  801a87:	84 c0                	test   %al,%al
  801a89:	75 e5                	jne    801a70 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801a8b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a90:	c9                   	leave  
  801a91:	c3                   	ret    

00801a92 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801a92:	55                   	push   %ebp
  801a93:	89 e5                	mov    %esp,%ebp
  801a95:	83 ec 04             	sub    $0x4,%esp
  801a98:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a9b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801a9e:	eb 0d                	jmp    801aad <strfind+0x1b>
		if (*s == c)
  801aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa3:	8a 00                	mov    (%eax),%al
  801aa5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801aa8:	74 0e                	je     801ab8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801aaa:	ff 45 08             	incl   0x8(%ebp)
  801aad:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab0:	8a 00                	mov    (%eax),%al
  801ab2:	84 c0                	test   %al,%al
  801ab4:	75 ea                	jne    801aa0 <strfind+0xe>
  801ab6:	eb 01                	jmp    801ab9 <strfind+0x27>
		if (*s == c)
			break;
  801ab8:	90                   	nop
	return (char *) s;
  801ab9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801abc:	c9                   	leave  
  801abd:	c3                   	ret    

00801abe <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801abe:	55                   	push   %ebp
  801abf:	89 e5                	mov    %esp,%ebp
  801ac1:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801aca:	8b 45 10             	mov    0x10(%ebp),%eax
  801acd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801ad0:	eb 0e                	jmp    801ae0 <memset+0x22>
		*p++ = c;
  801ad2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ad5:	8d 50 01             	lea    0x1(%eax),%edx
  801ad8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801adb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ade:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801ae0:	ff 4d f8             	decl   -0x8(%ebp)
  801ae3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801ae7:	79 e9                	jns    801ad2 <memset+0x14>
		*p++ = c;

	return v;
  801ae9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801aec:	c9                   	leave  
  801aed:	c3                   	ret    

00801aee <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801aee:	55                   	push   %ebp
  801aef:	89 e5                	mov    %esp,%ebp
  801af1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801af4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801af7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801afa:	8b 45 08             	mov    0x8(%ebp),%eax
  801afd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801b00:	eb 16                	jmp    801b18 <memcpy+0x2a>
		*d++ = *s++;
  801b02:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b05:	8d 50 01             	lea    0x1(%eax),%edx
  801b08:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801b0b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b0e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801b11:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801b14:	8a 12                	mov    (%edx),%dl
  801b16:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801b18:	8b 45 10             	mov    0x10(%ebp),%eax
  801b1b:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b1e:	89 55 10             	mov    %edx,0x10(%ebp)
  801b21:	85 c0                	test   %eax,%eax
  801b23:	75 dd                	jne    801b02 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801b25:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801b28:	c9                   	leave  
  801b29:	c3                   	ret    

00801b2a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801b2a:	55                   	push   %ebp
  801b2b:	89 e5                	mov    %esp,%ebp
  801b2d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801b30:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b33:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801b36:	8b 45 08             	mov    0x8(%ebp),%eax
  801b39:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801b3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b3f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801b42:	73 50                	jae    801b94 <memmove+0x6a>
  801b44:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b47:	8b 45 10             	mov    0x10(%ebp),%eax
  801b4a:	01 d0                	add    %edx,%eax
  801b4c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801b4f:	76 43                	jbe    801b94 <memmove+0x6a>
		s += n;
  801b51:	8b 45 10             	mov    0x10(%ebp),%eax
  801b54:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801b57:	8b 45 10             	mov    0x10(%ebp),%eax
  801b5a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801b5d:	eb 10                	jmp    801b6f <memmove+0x45>
			*--d = *--s;
  801b5f:	ff 4d f8             	decl   -0x8(%ebp)
  801b62:	ff 4d fc             	decl   -0x4(%ebp)
  801b65:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b68:	8a 10                	mov    (%eax),%dl
  801b6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b6d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801b6f:	8b 45 10             	mov    0x10(%ebp),%eax
  801b72:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b75:	89 55 10             	mov    %edx,0x10(%ebp)
  801b78:	85 c0                	test   %eax,%eax
  801b7a:	75 e3                	jne    801b5f <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801b7c:	eb 23                	jmp    801ba1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801b7e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b81:	8d 50 01             	lea    0x1(%eax),%edx
  801b84:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801b87:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b8a:	8d 4a 01             	lea    0x1(%edx),%ecx
  801b8d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801b90:	8a 12                	mov    (%edx),%dl
  801b92:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801b94:	8b 45 10             	mov    0x10(%ebp),%eax
  801b97:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b9a:	89 55 10             	mov    %edx,0x10(%ebp)
  801b9d:	85 c0                	test   %eax,%eax
  801b9f:	75 dd                	jne    801b7e <memmove+0x54>
			*d++ = *s++;

	return dst;
  801ba1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801ba4:	c9                   	leave  
  801ba5:	c3                   	ret    

00801ba6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801ba6:	55                   	push   %ebp
  801ba7:	89 e5                	mov    %esp,%ebp
  801ba9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801bac:	8b 45 08             	mov    0x8(%ebp),%eax
  801baf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801bb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bb5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801bb8:	eb 2a                	jmp    801be4 <memcmp+0x3e>
		if (*s1 != *s2)
  801bba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bbd:	8a 10                	mov    (%eax),%dl
  801bbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bc2:	8a 00                	mov    (%eax),%al
  801bc4:	38 c2                	cmp    %al,%dl
  801bc6:	74 16                	je     801bde <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801bc8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bcb:	8a 00                	mov    (%eax),%al
  801bcd:	0f b6 d0             	movzbl %al,%edx
  801bd0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bd3:	8a 00                	mov    (%eax),%al
  801bd5:	0f b6 c0             	movzbl %al,%eax
  801bd8:	29 c2                	sub    %eax,%edx
  801bda:	89 d0                	mov    %edx,%eax
  801bdc:	eb 18                	jmp    801bf6 <memcmp+0x50>
		s1++, s2++;
  801bde:	ff 45 fc             	incl   -0x4(%ebp)
  801be1:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801be4:	8b 45 10             	mov    0x10(%ebp),%eax
  801be7:	8d 50 ff             	lea    -0x1(%eax),%edx
  801bea:	89 55 10             	mov    %edx,0x10(%ebp)
  801bed:	85 c0                	test   %eax,%eax
  801bef:	75 c9                	jne    801bba <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801bf1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bf6:	c9                   	leave  
  801bf7:	c3                   	ret    

00801bf8 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801bf8:	55                   	push   %ebp
  801bf9:	89 e5                	mov    %esp,%ebp
  801bfb:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801bfe:	8b 55 08             	mov    0x8(%ebp),%edx
  801c01:	8b 45 10             	mov    0x10(%ebp),%eax
  801c04:	01 d0                	add    %edx,%eax
  801c06:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801c09:	eb 15                	jmp    801c20 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0e:	8a 00                	mov    (%eax),%al
  801c10:	0f b6 d0             	movzbl %al,%edx
  801c13:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c16:	0f b6 c0             	movzbl %al,%eax
  801c19:	39 c2                	cmp    %eax,%edx
  801c1b:	74 0d                	je     801c2a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801c1d:	ff 45 08             	incl   0x8(%ebp)
  801c20:	8b 45 08             	mov    0x8(%ebp),%eax
  801c23:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801c26:	72 e3                	jb     801c0b <memfind+0x13>
  801c28:	eb 01                	jmp    801c2b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801c2a:	90                   	nop
	return (void *) s;
  801c2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801c2e:	c9                   	leave  
  801c2f:	c3                   	ret    

00801c30 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801c30:	55                   	push   %ebp
  801c31:	89 e5                	mov    %esp,%ebp
  801c33:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801c36:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801c3d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801c44:	eb 03                	jmp    801c49 <strtol+0x19>
		s++;
  801c46:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801c49:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4c:	8a 00                	mov    (%eax),%al
  801c4e:	3c 20                	cmp    $0x20,%al
  801c50:	74 f4                	je     801c46 <strtol+0x16>
  801c52:	8b 45 08             	mov    0x8(%ebp),%eax
  801c55:	8a 00                	mov    (%eax),%al
  801c57:	3c 09                	cmp    $0x9,%al
  801c59:	74 eb                	je     801c46 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5e:	8a 00                	mov    (%eax),%al
  801c60:	3c 2b                	cmp    $0x2b,%al
  801c62:	75 05                	jne    801c69 <strtol+0x39>
		s++;
  801c64:	ff 45 08             	incl   0x8(%ebp)
  801c67:	eb 13                	jmp    801c7c <strtol+0x4c>
	else if (*s == '-')
  801c69:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6c:	8a 00                	mov    (%eax),%al
  801c6e:	3c 2d                	cmp    $0x2d,%al
  801c70:	75 0a                	jne    801c7c <strtol+0x4c>
		s++, neg = 1;
  801c72:	ff 45 08             	incl   0x8(%ebp)
  801c75:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801c7c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c80:	74 06                	je     801c88 <strtol+0x58>
  801c82:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801c86:	75 20                	jne    801ca8 <strtol+0x78>
  801c88:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8b:	8a 00                	mov    (%eax),%al
  801c8d:	3c 30                	cmp    $0x30,%al
  801c8f:	75 17                	jne    801ca8 <strtol+0x78>
  801c91:	8b 45 08             	mov    0x8(%ebp),%eax
  801c94:	40                   	inc    %eax
  801c95:	8a 00                	mov    (%eax),%al
  801c97:	3c 78                	cmp    $0x78,%al
  801c99:	75 0d                	jne    801ca8 <strtol+0x78>
		s += 2, base = 16;
  801c9b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801c9f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801ca6:	eb 28                	jmp    801cd0 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801ca8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801cac:	75 15                	jne    801cc3 <strtol+0x93>
  801cae:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb1:	8a 00                	mov    (%eax),%al
  801cb3:	3c 30                	cmp    $0x30,%al
  801cb5:	75 0c                	jne    801cc3 <strtol+0x93>
		s++, base = 8;
  801cb7:	ff 45 08             	incl   0x8(%ebp)
  801cba:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801cc1:	eb 0d                	jmp    801cd0 <strtol+0xa0>
	else if (base == 0)
  801cc3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801cc7:	75 07                	jne    801cd0 <strtol+0xa0>
		base = 10;
  801cc9:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801cd0:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd3:	8a 00                	mov    (%eax),%al
  801cd5:	3c 2f                	cmp    $0x2f,%al
  801cd7:	7e 19                	jle    801cf2 <strtol+0xc2>
  801cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cdc:	8a 00                	mov    (%eax),%al
  801cde:	3c 39                	cmp    $0x39,%al
  801ce0:	7f 10                	jg     801cf2 <strtol+0xc2>
			dig = *s - '0';
  801ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce5:	8a 00                	mov    (%eax),%al
  801ce7:	0f be c0             	movsbl %al,%eax
  801cea:	83 e8 30             	sub    $0x30,%eax
  801ced:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801cf0:	eb 42                	jmp    801d34 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf5:	8a 00                	mov    (%eax),%al
  801cf7:	3c 60                	cmp    $0x60,%al
  801cf9:	7e 19                	jle    801d14 <strtol+0xe4>
  801cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfe:	8a 00                	mov    (%eax),%al
  801d00:	3c 7a                	cmp    $0x7a,%al
  801d02:	7f 10                	jg     801d14 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801d04:	8b 45 08             	mov    0x8(%ebp),%eax
  801d07:	8a 00                	mov    (%eax),%al
  801d09:	0f be c0             	movsbl %al,%eax
  801d0c:	83 e8 57             	sub    $0x57,%eax
  801d0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801d12:	eb 20                	jmp    801d34 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801d14:	8b 45 08             	mov    0x8(%ebp),%eax
  801d17:	8a 00                	mov    (%eax),%al
  801d19:	3c 40                	cmp    $0x40,%al
  801d1b:	7e 39                	jle    801d56 <strtol+0x126>
  801d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d20:	8a 00                	mov    (%eax),%al
  801d22:	3c 5a                	cmp    $0x5a,%al
  801d24:	7f 30                	jg     801d56 <strtol+0x126>
			dig = *s - 'A' + 10;
  801d26:	8b 45 08             	mov    0x8(%ebp),%eax
  801d29:	8a 00                	mov    (%eax),%al
  801d2b:	0f be c0             	movsbl %al,%eax
  801d2e:	83 e8 37             	sub    $0x37,%eax
  801d31:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801d34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d37:	3b 45 10             	cmp    0x10(%ebp),%eax
  801d3a:	7d 19                	jge    801d55 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801d3c:	ff 45 08             	incl   0x8(%ebp)
  801d3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d42:	0f af 45 10          	imul   0x10(%ebp),%eax
  801d46:	89 c2                	mov    %eax,%edx
  801d48:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d4b:	01 d0                	add    %edx,%eax
  801d4d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801d50:	e9 7b ff ff ff       	jmp    801cd0 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801d55:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801d56:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801d5a:	74 08                	je     801d64 <strtol+0x134>
		*endptr = (char *) s;
  801d5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d5f:	8b 55 08             	mov    0x8(%ebp),%edx
  801d62:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801d64:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801d68:	74 07                	je     801d71 <strtol+0x141>
  801d6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d6d:	f7 d8                	neg    %eax
  801d6f:	eb 03                	jmp    801d74 <strtol+0x144>
  801d71:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801d74:	c9                   	leave  
  801d75:	c3                   	ret    

00801d76 <ltostr>:

void
ltostr(long value, char *str)
{
  801d76:	55                   	push   %ebp
  801d77:	89 e5                	mov    %esp,%ebp
  801d79:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801d7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801d83:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801d8a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801d8e:	79 13                	jns    801da3 <ltostr+0x2d>
	{
		neg = 1;
  801d90:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801d97:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d9a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801d9d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801da0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801da3:	8b 45 08             	mov    0x8(%ebp),%eax
  801da6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801dab:	99                   	cltd   
  801dac:	f7 f9                	idiv   %ecx
  801dae:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801db1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801db4:	8d 50 01             	lea    0x1(%eax),%edx
  801db7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801dba:	89 c2                	mov    %eax,%edx
  801dbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dbf:	01 d0                	add    %edx,%eax
  801dc1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801dc4:	83 c2 30             	add    $0x30,%edx
  801dc7:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801dc9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801dcc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801dd1:	f7 e9                	imul   %ecx
  801dd3:	c1 fa 02             	sar    $0x2,%edx
  801dd6:	89 c8                	mov    %ecx,%eax
  801dd8:	c1 f8 1f             	sar    $0x1f,%eax
  801ddb:	29 c2                	sub    %eax,%edx
  801ddd:	89 d0                	mov    %edx,%eax
  801ddf:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801de2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801de5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801dea:	f7 e9                	imul   %ecx
  801dec:	c1 fa 02             	sar    $0x2,%edx
  801def:	89 c8                	mov    %ecx,%eax
  801df1:	c1 f8 1f             	sar    $0x1f,%eax
  801df4:	29 c2                	sub    %eax,%edx
  801df6:	89 d0                	mov    %edx,%eax
  801df8:	c1 e0 02             	shl    $0x2,%eax
  801dfb:	01 d0                	add    %edx,%eax
  801dfd:	01 c0                	add    %eax,%eax
  801dff:	29 c1                	sub    %eax,%ecx
  801e01:	89 ca                	mov    %ecx,%edx
  801e03:	85 d2                	test   %edx,%edx
  801e05:	75 9c                	jne    801da3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801e07:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801e0e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e11:	48                   	dec    %eax
  801e12:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801e15:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801e19:	74 3d                	je     801e58 <ltostr+0xe2>
		start = 1 ;
  801e1b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801e22:	eb 34                	jmp    801e58 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801e24:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e27:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e2a:	01 d0                	add    %edx,%eax
  801e2c:	8a 00                	mov    (%eax),%al
  801e2e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801e31:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e34:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e37:	01 c2                	add    %eax,%edx
  801e39:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801e3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e3f:	01 c8                	add    %ecx,%eax
  801e41:	8a 00                	mov    (%eax),%al
  801e43:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801e45:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801e48:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e4b:	01 c2                	add    %eax,%edx
  801e4d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801e50:	88 02                	mov    %al,(%edx)
		start++ ;
  801e52:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801e55:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801e58:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e5b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e5e:	7c c4                	jl     801e24 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801e60:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801e63:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e66:	01 d0                	add    %edx,%eax
  801e68:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801e6b:	90                   	nop
  801e6c:	c9                   	leave  
  801e6d:	c3                   	ret    

00801e6e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801e6e:	55                   	push   %ebp
  801e6f:	89 e5                	mov    %esp,%ebp
  801e71:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801e74:	ff 75 08             	pushl  0x8(%ebp)
  801e77:	e8 54 fa ff ff       	call   8018d0 <strlen>
  801e7c:	83 c4 04             	add    $0x4,%esp
  801e7f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801e82:	ff 75 0c             	pushl  0xc(%ebp)
  801e85:	e8 46 fa ff ff       	call   8018d0 <strlen>
  801e8a:	83 c4 04             	add    $0x4,%esp
  801e8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801e90:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801e97:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801e9e:	eb 17                	jmp    801eb7 <strcconcat+0x49>
		final[s] = str1[s] ;
  801ea0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ea3:	8b 45 10             	mov    0x10(%ebp),%eax
  801ea6:	01 c2                	add    %eax,%edx
  801ea8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801eab:	8b 45 08             	mov    0x8(%ebp),%eax
  801eae:	01 c8                	add    %ecx,%eax
  801eb0:	8a 00                	mov    (%eax),%al
  801eb2:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801eb4:	ff 45 fc             	incl   -0x4(%ebp)
  801eb7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801eba:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801ebd:	7c e1                	jl     801ea0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801ebf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801ec6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801ecd:	eb 1f                	jmp    801eee <strcconcat+0x80>
		final[s++] = str2[i] ;
  801ecf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ed2:	8d 50 01             	lea    0x1(%eax),%edx
  801ed5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801ed8:	89 c2                	mov    %eax,%edx
  801eda:	8b 45 10             	mov    0x10(%ebp),%eax
  801edd:	01 c2                	add    %eax,%edx
  801edf:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801ee2:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ee5:	01 c8                	add    %ecx,%eax
  801ee7:	8a 00                	mov    (%eax),%al
  801ee9:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801eeb:	ff 45 f8             	incl   -0x8(%ebp)
  801eee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ef1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ef4:	7c d9                	jl     801ecf <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801ef6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ef9:	8b 45 10             	mov    0x10(%ebp),%eax
  801efc:	01 d0                	add    %edx,%eax
  801efe:	c6 00 00             	movb   $0x0,(%eax)
}
  801f01:	90                   	nop
  801f02:	c9                   	leave  
  801f03:	c3                   	ret    

00801f04 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801f04:	55                   	push   %ebp
  801f05:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801f07:	8b 45 14             	mov    0x14(%ebp),%eax
  801f0a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801f10:	8b 45 14             	mov    0x14(%ebp),%eax
  801f13:	8b 00                	mov    (%eax),%eax
  801f15:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f1c:	8b 45 10             	mov    0x10(%ebp),%eax
  801f1f:	01 d0                	add    %edx,%eax
  801f21:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801f27:	eb 0c                	jmp    801f35 <strsplit+0x31>
			*string++ = 0;
  801f29:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2c:	8d 50 01             	lea    0x1(%eax),%edx
  801f2f:	89 55 08             	mov    %edx,0x8(%ebp)
  801f32:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801f35:	8b 45 08             	mov    0x8(%ebp),%eax
  801f38:	8a 00                	mov    (%eax),%al
  801f3a:	84 c0                	test   %al,%al
  801f3c:	74 18                	je     801f56 <strsplit+0x52>
  801f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f41:	8a 00                	mov    (%eax),%al
  801f43:	0f be c0             	movsbl %al,%eax
  801f46:	50                   	push   %eax
  801f47:	ff 75 0c             	pushl  0xc(%ebp)
  801f4a:	e8 13 fb ff ff       	call   801a62 <strchr>
  801f4f:	83 c4 08             	add    $0x8,%esp
  801f52:	85 c0                	test   %eax,%eax
  801f54:	75 d3                	jne    801f29 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801f56:	8b 45 08             	mov    0x8(%ebp),%eax
  801f59:	8a 00                	mov    (%eax),%al
  801f5b:	84 c0                	test   %al,%al
  801f5d:	74 5a                	je     801fb9 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801f5f:	8b 45 14             	mov    0x14(%ebp),%eax
  801f62:	8b 00                	mov    (%eax),%eax
  801f64:	83 f8 0f             	cmp    $0xf,%eax
  801f67:	75 07                	jne    801f70 <strsplit+0x6c>
		{
			return 0;
  801f69:	b8 00 00 00 00       	mov    $0x0,%eax
  801f6e:	eb 66                	jmp    801fd6 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801f70:	8b 45 14             	mov    0x14(%ebp),%eax
  801f73:	8b 00                	mov    (%eax),%eax
  801f75:	8d 48 01             	lea    0x1(%eax),%ecx
  801f78:	8b 55 14             	mov    0x14(%ebp),%edx
  801f7b:	89 0a                	mov    %ecx,(%edx)
  801f7d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f84:	8b 45 10             	mov    0x10(%ebp),%eax
  801f87:	01 c2                	add    %eax,%edx
  801f89:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801f8e:	eb 03                	jmp    801f93 <strsplit+0x8f>
			string++;
  801f90:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801f93:	8b 45 08             	mov    0x8(%ebp),%eax
  801f96:	8a 00                	mov    (%eax),%al
  801f98:	84 c0                	test   %al,%al
  801f9a:	74 8b                	je     801f27 <strsplit+0x23>
  801f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9f:	8a 00                	mov    (%eax),%al
  801fa1:	0f be c0             	movsbl %al,%eax
  801fa4:	50                   	push   %eax
  801fa5:	ff 75 0c             	pushl  0xc(%ebp)
  801fa8:	e8 b5 fa ff ff       	call   801a62 <strchr>
  801fad:	83 c4 08             	add    $0x8,%esp
  801fb0:	85 c0                	test   %eax,%eax
  801fb2:	74 dc                	je     801f90 <strsplit+0x8c>
			string++;
	}
  801fb4:	e9 6e ff ff ff       	jmp    801f27 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801fb9:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801fba:	8b 45 14             	mov    0x14(%ebp),%eax
  801fbd:	8b 00                	mov    (%eax),%eax
  801fbf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801fc6:	8b 45 10             	mov    0x10(%ebp),%eax
  801fc9:	01 d0                	add    %edx,%eax
  801fcb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801fd1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801fd6:	c9                   	leave  
  801fd7:	c3                   	ret    

00801fd8 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801fd8:	55                   	push   %ebp
  801fd9:	89 e5                	mov    %esp,%ebp
  801fdb:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  801fde:	e8 3b 09 00 00       	call   80291e <sys_isUHeapPlacementStrategyFIRSTFIT>
  801fe3:	85 c0                	test   %eax,%eax
  801fe5:	0f 84 3a 01 00 00    	je     802125 <malloc+0x14d>

		if(pl == 0){
  801feb:	a1 28 40 80 00       	mov    0x804028,%eax
  801ff0:	85 c0                	test   %eax,%eax
  801ff2:	75 24                	jne    802018 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801ff4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801ffb:	eb 11                	jmp    80200e <malloc+0x36>
				arr[k] = -10000;
  801ffd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802000:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  802007:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  80200b:	ff 45 f4             	incl   -0xc(%ebp)
  80200e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802011:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802016:	76 e5                	jbe    801ffd <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  802018:	c7 05 28 40 80 00 01 	movl   $0x1,0x804028
  80201f:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  802022:	8b 45 08             	mov    0x8(%ebp),%eax
  802025:	c1 e8 0c             	shr    $0xc,%eax
  802028:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  80202b:	8b 45 08             	mov    0x8(%ebp),%eax
  80202e:	25 ff 0f 00 00       	and    $0xfff,%eax
  802033:	85 c0                	test   %eax,%eax
  802035:	74 03                	je     80203a <malloc+0x62>
			x++;
  802037:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  80203a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  802041:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  802048:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80204f:	eb 66                	jmp    8020b7 <malloc+0xdf>
			if( arr[k] == -10000){
  802051:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802054:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  80205b:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  802060:	75 52                	jne    8020b4 <malloc+0xdc>
				uint32 w = 0 ;
  802062:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  802069:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80206c:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  80206f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802072:	89 45 dc             	mov    %eax,-0x24(%ebp)
  802075:	eb 09                	jmp    802080 <malloc+0xa8>
  802077:	ff 45 e0             	incl   -0x20(%ebp)
  80207a:	ff 45 dc             	incl   -0x24(%ebp)
  80207d:	ff 45 e4             	incl   -0x1c(%ebp)
  802080:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802083:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802088:	77 19                	ja     8020a3 <malloc+0xcb>
  80208a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80208d:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802094:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  802099:	75 08                	jne    8020a3 <malloc+0xcb>
  80209b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80209e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8020a1:	72 d4                	jb     802077 <malloc+0x9f>
				if(w >= x){
  8020a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8020a6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8020a9:	72 09                	jb     8020b4 <malloc+0xdc>
					p = 1 ;
  8020ab:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  8020b2:	eb 0d                	jmp    8020c1 <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  8020b4:	ff 45 e4             	incl   -0x1c(%ebp)
  8020b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8020ba:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8020bf:	76 90                	jbe    802051 <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  8020c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8020c5:	75 0a                	jne    8020d1 <malloc+0xf9>
  8020c7:	b8 00 00 00 00       	mov    $0x0,%eax
  8020cc:	e9 ca 01 00 00       	jmp    80229b <malloc+0x2c3>
		int q = idx;
  8020d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8020d4:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  8020d7:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8020de:	eb 16                	jmp    8020f6 <malloc+0x11e>
			arr[q++] = x;
  8020e0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8020e3:	8d 50 01             	lea    0x1(%eax),%edx
  8020e6:	89 55 d8             	mov    %edx,-0x28(%ebp)
  8020e9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8020ec:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  8020f3:	ff 45 d4             	incl   -0x2c(%ebp)
  8020f6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8020f9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8020fc:	72 e2                	jb     8020e0 <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  8020fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802101:	05 00 00 08 00       	add    $0x80000,%eax
  802106:	c1 e0 0c             	shl    $0xc,%eax
  802109:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  80210c:	83 ec 08             	sub    $0x8,%esp
  80210f:	ff 75 f0             	pushl  -0x10(%ebp)
  802112:	ff 75 ac             	pushl  -0x54(%ebp)
  802115:	e8 9b 04 00 00       	call   8025b5 <sys_allocateMem>
  80211a:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  80211d:	8b 45 ac             	mov    -0x54(%ebp),%eax
  802120:	e9 76 01 00 00       	jmp    80229b <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  802125:	e8 25 08 00 00       	call   80294f <sys_isUHeapPlacementStrategyBESTFIT>
  80212a:	85 c0                	test   %eax,%eax
  80212c:	0f 84 64 01 00 00    	je     802296 <malloc+0x2be>
		if(pl == 0){
  802132:	a1 28 40 80 00       	mov    0x804028,%eax
  802137:	85 c0                	test   %eax,%eax
  802139:	75 24                	jne    80215f <malloc+0x187>
			for(int k = 0; k < Size; k++){
  80213b:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  802142:	eb 11                	jmp    802155 <malloc+0x17d>
				arr[k] = -10000;
  802144:	8b 45 d0             	mov    -0x30(%ebp),%eax
  802147:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  80214e:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  802152:	ff 45 d0             	incl   -0x30(%ebp)
  802155:	8b 45 d0             	mov    -0x30(%ebp),%eax
  802158:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80215d:	76 e5                	jbe    802144 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  80215f:	c7 05 28 40 80 00 01 	movl   $0x1,0x804028
  802166:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  802169:	8b 45 08             	mov    0x8(%ebp),%eax
  80216c:	c1 e8 0c             	shr    $0xc,%eax
  80216f:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  802172:	8b 45 08             	mov    0x8(%ebp),%eax
  802175:	25 ff 0f 00 00       	and    $0xfff,%eax
  80217a:	85 c0                	test   %eax,%eax
  80217c:	74 03                	je     802181 <malloc+0x1a9>
			x++;
  80217e:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  802181:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  802188:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  80218f:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  802196:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  80219d:	e9 88 00 00 00       	jmp    80222a <malloc+0x252>
			if(arr[k] == -10000){
  8021a2:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8021a5:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8021ac:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  8021b1:	75 64                	jne    802217 <malloc+0x23f>
				uint32 w = 0 , i;
  8021b3:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  8021ba:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8021bd:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8021c0:	eb 06                	jmp    8021c8 <malloc+0x1f0>
  8021c2:	ff 45 b8             	incl   -0x48(%ebp)
  8021c5:	ff 45 b4             	incl   -0x4c(%ebp)
  8021c8:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  8021cf:	77 11                	ja     8021e2 <malloc+0x20a>
  8021d1:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8021d4:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8021db:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  8021e0:	74 e0                	je     8021c2 <malloc+0x1ea>
				if(w <q && w >= x){
  8021e2:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8021e5:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  8021e8:	73 24                	jae    80220e <malloc+0x236>
  8021ea:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8021ed:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  8021f0:	72 1c                	jb     80220e <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  8021f2:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8021f5:	89 45 c8             	mov    %eax,-0x38(%ebp)
  8021f8:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  8021ff:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802202:	89 45 c0             	mov    %eax,-0x40(%ebp)
  802205:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  802208:	48                   	dec    %eax
  802209:	89 45 bc             	mov    %eax,-0x44(%ebp)
  80220c:	eb 19                	jmp    802227 <malloc+0x24f>
				}
				else {
					k = i - 1;
  80220e:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  802211:	48                   	dec    %eax
  802212:	89 45 bc             	mov    %eax,-0x44(%ebp)
  802215:	eb 10                	jmp    802227 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  802217:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80221a:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802221:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  802224:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  802227:	ff 45 bc             	incl   -0x44(%ebp)
  80222a:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80222d:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802232:	0f 86 6a ff ff ff    	jbe    8021a2 <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  802238:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  80223c:	75 07                	jne    802245 <malloc+0x26d>
  80223e:	b8 00 00 00 00       	mov    $0x0,%eax
  802243:	eb 56                	jmp    80229b <malloc+0x2c3>
	    q = idx;
  802245:	8b 45 c0             	mov    -0x40(%ebp),%eax
  802248:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  80224b:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  802252:	eb 16                	jmp    80226a <malloc+0x292>
			arr[q++] = x;
  802254:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802257:	8d 50 01             	lea    0x1(%eax),%edx
  80225a:	89 55 c8             	mov    %edx,-0x38(%ebp)
  80225d:	8b 55 cc             	mov    -0x34(%ebp),%edx
  802260:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  802267:	ff 45 b0             	incl   -0x50(%ebp)
  80226a:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80226d:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  802270:	72 e2                	jb     802254 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  802272:	8b 45 c0             	mov    -0x40(%ebp),%eax
  802275:	05 00 00 08 00       	add    $0x80000,%eax
  80227a:	c1 e0 0c             	shl    $0xc,%eax
  80227d:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  802280:	83 ec 08             	sub    $0x8,%esp
  802283:	ff 75 cc             	pushl  -0x34(%ebp)
  802286:	ff 75 a8             	pushl  -0x58(%ebp)
  802289:	e8 27 03 00 00       	call   8025b5 <sys_allocateMem>
  80228e:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  802291:	8b 45 a8             	mov    -0x58(%ebp),%eax
  802294:	eb 05                	jmp    80229b <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  802296:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80229b:	c9                   	leave  
  80229c:	c3                   	ret    

0080229d <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80229d:	55                   	push   %ebp
  80229e:	89 e5                	mov    %esp,%ebp
  8022a0:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  8022a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8022a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8022ac:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8022b1:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  8022b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b7:	05 00 00 00 80       	add    $0x80000000,%eax
  8022bc:	c1 e8 0c             	shr    $0xc,%eax
  8022bf:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8022c6:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  8022c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8022d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d3:	05 00 00 00 80       	add    $0x80000000,%eax
  8022d8:	c1 e8 0c             	shr    $0xc,%eax
  8022db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8022de:	eb 14                	jmp    8022f4 <free+0x57>
		arr[j] = -10000;
  8022e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8022e3:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  8022ea:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  8022ee:	ff 45 f4             	incl   -0xc(%ebp)
  8022f1:	ff 45 f0             	incl   -0x10(%ebp)
  8022f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8022f7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8022fa:	72 e4                	jb     8022e0 <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  8022fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ff:	83 ec 08             	sub    $0x8,%esp
  802302:	ff 75 e8             	pushl  -0x18(%ebp)
  802305:	50                   	push   %eax
  802306:	e8 8e 02 00 00       	call   802599 <sys_freeMem>
  80230b:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  80230e:	90                   	nop
  80230f:	c9                   	leave  
  802310:	c3                   	ret    

00802311 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  802311:	55                   	push   %ebp
  802312:	89 e5                	mov    %esp,%ebp
  802314:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802317:	83 ec 04             	sub    $0x4,%esp
  80231a:	68 b0 33 80 00       	push   $0x8033b0
  80231f:	68 9e 00 00 00       	push   $0x9e
  802324:	68 d3 33 80 00       	push   $0x8033d3
  802329:	e8 69 ec ff ff       	call   800f97 <_panic>

0080232e <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80232e:	55                   	push   %ebp
  80232f:	89 e5                	mov    %esp,%ebp
  802331:	83 ec 18             	sub    $0x18,%esp
  802334:	8b 45 10             	mov    0x10(%ebp),%eax
  802337:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80233a:	83 ec 04             	sub    $0x4,%esp
  80233d:	68 b0 33 80 00       	push   $0x8033b0
  802342:	68 a9 00 00 00       	push   $0xa9
  802347:	68 d3 33 80 00       	push   $0x8033d3
  80234c:	e8 46 ec ff ff       	call   800f97 <_panic>

00802351 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802351:	55                   	push   %ebp
  802352:	89 e5                	mov    %esp,%ebp
  802354:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802357:	83 ec 04             	sub    $0x4,%esp
  80235a:	68 b0 33 80 00       	push   $0x8033b0
  80235f:	68 af 00 00 00       	push   $0xaf
  802364:	68 d3 33 80 00       	push   $0x8033d3
  802369:	e8 29 ec ff ff       	call   800f97 <_panic>

0080236e <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80236e:	55                   	push   %ebp
  80236f:	89 e5                	mov    %esp,%ebp
  802371:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802374:	83 ec 04             	sub    $0x4,%esp
  802377:	68 b0 33 80 00       	push   $0x8033b0
  80237c:	68 b5 00 00 00       	push   $0xb5
  802381:	68 d3 33 80 00       	push   $0x8033d3
  802386:	e8 0c ec ff ff       	call   800f97 <_panic>

0080238b <expand>:
}

void expand(uint32 newSize)
{
  80238b:	55                   	push   %ebp
  80238c:	89 e5                	mov    %esp,%ebp
  80238e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802391:	83 ec 04             	sub    $0x4,%esp
  802394:	68 b0 33 80 00       	push   $0x8033b0
  802399:	68 ba 00 00 00       	push   $0xba
  80239e:	68 d3 33 80 00       	push   $0x8033d3
  8023a3:	e8 ef eb ff ff       	call   800f97 <_panic>

008023a8 <shrink>:
}
void shrink(uint32 newSize)
{
  8023a8:	55                   	push   %ebp
  8023a9:	89 e5                	mov    %esp,%ebp
  8023ab:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8023ae:	83 ec 04             	sub    $0x4,%esp
  8023b1:	68 b0 33 80 00       	push   $0x8033b0
  8023b6:	68 be 00 00 00       	push   $0xbe
  8023bb:	68 d3 33 80 00       	push   $0x8033d3
  8023c0:	e8 d2 eb ff ff       	call   800f97 <_panic>

008023c5 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8023c5:	55                   	push   %ebp
  8023c6:	89 e5                	mov    %esp,%ebp
  8023c8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8023cb:	83 ec 04             	sub    $0x4,%esp
  8023ce:	68 b0 33 80 00       	push   $0x8033b0
  8023d3:	68 c3 00 00 00       	push   $0xc3
  8023d8:	68 d3 33 80 00       	push   $0x8033d3
  8023dd:	e8 b5 eb ff ff       	call   800f97 <_panic>

008023e2 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8023e2:	55                   	push   %ebp
  8023e3:	89 e5                	mov    %esp,%ebp
  8023e5:	57                   	push   %edi
  8023e6:	56                   	push   %esi
  8023e7:	53                   	push   %ebx
  8023e8:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8023eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023f1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023f4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8023f7:	8b 7d 18             	mov    0x18(%ebp),%edi
  8023fa:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8023fd:	cd 30                	int    $0x30
  8023ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802402:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802405:	83 c4 10             	add    $0x10,%esp
  802408:	5b                   	pop    %ebx
  802409:	5e                   	pop    %esi
  80240a:	5f                   	pop    %edi
  80240b:	5d                   	pop    %ebp
  80240c:	c3                   	ret    

0080240d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80240d:	55                   	push   %ebp
  80240e:	89 e5                	mov    %esp,%ebp
  802410:	83 ec 04             	sub    $0x4,%esp
  802413:	8b 45 10             	mov    0x10(%ebp),%eax
  802416:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802419:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80241d:	8b 45 08             	mov    0x8(%ebp),%eax
  802420:	6a 00                	push   $0x0
  802422:	6a 00                	push   $0x0
  802424:	52                   	push   %edx
  802425:	ff 75 0c             	pushl  0xc(%ebp)
  802428:	50                   	push   %eax
  802429:	6a 00                	push   $0x0
  80242b:	e8 b2 ff ff ff       	call   8023e2 <syscall>
  802430:	83 c4 18             	add    $0x18,%esp
}
  802433:	90                   	nop
  802434:	c9                   	leave  
  802435:	c3                   	ret    

00802436 <sys_cgetc>:

int
sys_cgetc(void)
{
  802436:	55                   	push   %ebp
  802437:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802439:	6a 00                	push   $0x0
  80243b:	6a 00                	push   $0x0
  80243d:	6a 00                	push   $0x0
  80243f:	6a 00                	push   $0x0
  802441:	6a 00                	push   $0x0
  802443:	6a 01                	push   $0x1
  802445:	e8 98 ff ff ff       	call   8023e2 <syscall>
  80244a:	83 c4 18             	add    $0x18,%esp
}
  80244d:	c9                   	leave  
  80244e:	c3                   	ret    

0080244f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80244f:	55                   	push   %ebp
  802450:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802452:	8b 45 08             	mov    0x8(%ebp),%eax
  802455:	6a 00                	push   $0x0
  802457:	6a 00                	push   $0x0
  802459:	6a 00                	push   $0x0
  80245b:	6a 00                	push   $0x0
  80245d:	50                   	push   %eax
  80245e:	6a 05                	push   $0x5
  802460:	e8 7d ff ff ff       	call   8023e2 <syscall>
  802465:	83 c4 18             	add    $0x18,%esp
}
  802468:	c9                   	leave  
  802469:	c3                   	ret    

0080246a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80246a:	55                   	push   %ebp
  80246b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80246d:	6a 00                	push   $0x0
  80246f:	6a 00                	push   $0x0
  802471:	6a 00                	push   $0x0
  802473:	6a 00                	push   $0x0
  802475:	6a 00                	push   $0x0
  802477:	6a 02                	push   $0x2
  802479:	e8 64 ff ff ff       	call   8023e2 <syscall>
  80247e:	83 c4 18             	add    $0x18,%esp
}
  802481:	c9                   	leave  
  802482:	c3                   	ret    

00802483 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802483:	55                   	push   %ebp
  802484:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802486:	6a 00                	push   $0x0
  802488:	6a 00                	push   $0x0
  80248a:	6a 00                	push   $0x0
  80248c:	6a 00                	push   $0x0
  80248e:	6a 00                	push   $0x0
  802490:	6a 03                	push   $0x3
  802492:	e8 4b ff ff ff       	call   8023e2 <syscall>
  802497:	83 c4 18             	add    $0x18,%esp
}
  80249a:	c9                   	leave  
  80249b:	c3                   	ret    

0080249c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80249c:	55                   	push   %ebp
  80249d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80249f:	6a 00                	push   $0x0
  8024a1:	6a 00                	push   $0x0
  8024a3:	6a 00                	push   $0x0
  8024a5:	6a 00                	push   $0x0
  8024a7:	6a 00                	push   $0x0
  8024a9:	6a 04                	push   $0x4
  8024ab:	e8 32 ff ff ff       	call   8023e2 <syscall>
  8024b0:	83 c4 18             	add    $0x18,%esp
}
  8024b3:	c9                   	leave  
  8024b4:	c3                   	ret    

008024b5 <sys_env_exit>:


void sys_env_exit(void)
{
  8024b5:	55                   	push   %ebp
  8024b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8024b8:	6a 00                	push   $0x0
  8024ba:	6a 00                	push   $0x0
  8024bc:	6a 00                	push   $0x0
  8024be:	6a 00                	push   $0x0
  8024c0:	6a 00                	push   $0x0
  8024c2:	6a 06                	push   $0x6
  8024c4:	e8 19 ff ff ff       	call   8023e2 <syscall>
  8024c9:	83 c4 18             	add    $0x18,%esp
}
  8024cc:	90                   	nop
  8024cd:	c9                   	leave  
  8024ce:	c3                   	ret    

008024cf <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8024cf:	55                   	push   %ebp
  8024d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8024d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8024d8:	6a 00                	push   $0x0
  8024da:	6a 00                	push   $0x0
  8024dc:	6a 00                	push   $0x0
  8024de:	52                   	push   %edx
  8024df:	50                   	push   %eax
  8024e0:	6a 07                	push   $0x7
  8024e2:	e8 fb fe ff ff       	call   8023e2 <syscall>
  8024e7:	83 c4 18             	add    $0x18,%esp
}
  8024ea:	c9                   	leave  
  8024eb:	c3                   	ret    

008024ec <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8024ec:	55                   	push   %ebp
  8024ed:	89 e5                	mov    %esp,%ebp
  8024ef:	56                   	push   %esi
  8024f0:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8024f1:	8b 75 18             	mov    0x18(%ebp),%esi
  8024f4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8024f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8024fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802500:	56                   	push   %esi
  802501:	53                   	push   %ebx
  802502:	51                   	push   %ecx
  802503:	52                   	push   %edx
  802504:	50                   	push   %eax
  802505:	6a 08                	push   $0x8
  802507:	e8 d6 fe ff ff       	call   8023e2 <syscall>
  80250c:	83 c4 18             	add    $0x18,%esp
}
  80250f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802512:	5b                   	pop    %ebx
  802513:	5e                   	pop    %esi
  802514:	5d                   	pop    %ebp
  802515:	c3                   	ret    

00802516 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802516:	55                   	push   %ebp
  802517:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802519:	8b 55 0c             	mov    0xc(%ebp),%edx
  80251c:	8b 45 08             	mov    0x8(%ebp),%eax
  80251f:	6a 00                	push   $0x0
  802521:	6a 00                	push   $0x0
  802523:	6a 00                	push   $0x0
  802525:	52                   	push   %edx
  802526:	50                   	push   %eax
  802527:	6a 09                	push   $0x9
  802529:	e8 b4 fe ff ff       	call   8023e2 <syscall>
  80252e:	83 c4 18             	add    $0x18,%esp
}
  802531:	c9                   	leave  
  802532:	c3                   	ret    

00802533 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802533:	55                   	push   %ebp
  802534:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802536:	6a 00                	push   $0x0
  802538:	6a 00                	push   $0x0
  80253a:	6a 00                	push   $0x0
  80253c:	ff 75 0c             	pushl  0xc(%ebp)
  80253f:	ff 75 08             	pushl  0x8(%ebp)
  802542:	6a 0a                	push   $0xa
  802544:	e8 99 fe ff ff       	call   8023e2 <syscall>
  802549:	83 c4 18             	add    $0x18,%esp
}
  80254c:	c9                   	leave  
  80254d:	c3                   	ret    

0080254e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80254e:	55                   	push   %ebp
  80254f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802551:	6a 00                	push   $0x0
  802553:	6a 00                	push   $0x0
  802555:	6a 00                	push   $0x0
  802557:	6a 00                	push   $0x0
  802559:	6a 00                	push   $0x0
  80255b:	6a 0b                	push   $0xb
  80255d:	e8 80 fe ff ff       	call   8023e2 <syscall>
  802562:	83 c4 18             	add    $0x18,%esp
}
  802565:	c9                   	leave  
  802566:	c3                   	ret    

00802567 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802567:	55                   	push   %ebp
  802568:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80256a:	6a 00                	push   $0x0
  80256c:	6a 00                	push   $0x0
  80256e:	6a 00                	push   $0x0
  802570:	6a 00                	push   $0x0
  802572:	6a 00                	push   $0x0
  802574:	6a 0c                	push   $0xc
  802576:	e8 67 fe ff ff       	call   8023e2 <syscall>
  80257b:	83 c4 18             	add    $0x18,%esp
}
  80257e:	c9                   	leave  
  80257f:	c3                   	ret    

00802580 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802580:	55                   	push   %ebp
  802581:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802583:	6a 00                	push   $0x0
  802585:	6a 00                	push   $0x0
  802587:	6a 00                	push   $0x0
  802589:	6a 00                	push   $0x0
  80258b:	6a 00                	push   $0x0
  80258d:	6a 0d                	push   $0xd
  80258f:	e8 4e fe ff ff       	call   8023e2 <syscall>
  802594:	83 c4 18             	add    $0x18,%esp
}
  802597:	c9                   	leave  
  802598:	c3                   	ret    

00802599 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802599:	55                   	push   %ebp
  80259a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80259c:	6a 00                	push   $0x0
  80259e:	6a 00                	push   $0x0
  8025a0:	6a 00                	push   $0x0
  8025a2:	ff 75 0c             	pushl  0xc(%ebp)
  8025a5:	ff 75 08             	pushl  0x8(%ebp)
  8025a8:	6a 11                	push   $0x11
  8025aa:	e8 33 fe ff ff       	call   8023e2 <syscall>
  8025af:	83 c4 18             	add    $0x18,%esp
	return;
  8025b2:	90                   	nop
}
  8025b3:	c9                   	leave  
  8025b4:	c3                   	ret    

008025b5 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8025b5:	55                   	push   %ebp
  8025b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8025b8:	6a 00                	push   $0x0
  8025ba:	6a 00                	push   $0x0
  8025bc:	6a 00                	push   $0x0
  8025be:	ff 75 0c             	pushl  0xc(%ebp)
  8025c1:	ff 75 08             	pushl  0x8(%ebp)
  8025c4:	6a 12                	push   $0x12
  8025c6:	e8 17 fe ff ff       	call   8023e2 <syscall>
  8025cb:	83 c4 18             	add    $0x18,%esp
	return ;
  8025ce:	90                   	nop
}
  8025cf:	c9                   	leave  
  8025d0:	c3                   	ret    

008025d1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8025d1:	55                   	push   %ebp
  8025d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8025d4:	6a 00                	push   $0x0
  8025d6:	6a 00                	push   $0x0
  8025d8:	6a 00                	push   $0x0
  8025da:	6a 00                	push   $0x0
  8025dc:	6a 00                	push   $0x0
  8025de:	6a 0e                	push   $0xe
  8025e0:	e8 fd fd ff ff       	call   8023e2 <syscall>
  8025e5:	83 c4 18             	add    $0x18,%esp
}
  8025e8:	c9                   	leave  
  8025e9:	c3                   	ret    

008025ea <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8025ea:	55                   	push   %ebp
  8025eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8025ed:	6a 00                	push   $0x0
  8025ef:	6a 00                	push   $0x0
  8025f1:	6a 00                	push   $0x0
  8025f3:	6a 00                	push   $0x0
  8025f5:	ff 75 08             	pushl  0x8(%ebp)
  8025f8:	6a 0f                	push   $0xf
  8025fa:	e8 e3 fd ff ff       	call   8023e2 <syscall>
  8025ff:	83 c4 18             	add    $0x18,%esp
}
  802602:	c9                   	leave  
  802603:	c3                   	ret    

00802604 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802604:	55                   	push   %ebp
  802605:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802607:	6a 00                	push   $0x0
  802609:	6a 00                	push   $0x0
  80260b:	6a 00                	push   $0x0
  80260d:	6a 00                	push   $0x0
  80260f:	6a 00                	push   $0x0
  802611:	6a 10                	push   $0x10
  802613:	e8 ca fd ff ff       	call   8023e2 <syscall>
  802618:	83 c4 18             	add    $0x18,%esp
}
  80261b:	90                   	nop
  80261c:	c9                   	leave  
  80261d:	c3                   	ret    

0080261e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80261e:	55                   	push   %ebp
  80261f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802621:	6a 00                	push   $0x0
  802623:	6a 00                	push   $0x0
  802625:	6a 00                	push   $0x0
  802627:	6a 00                	push   $0x0
  802629:	6a 00                	push   $0x0
  80262b:	6a 14                	push   $0x14
  80262d:	e8 b0 fd ff ff       	call   8023e2 <syscall>
  802632:	83 c4 18             	add    $0x18,%esp
}
  802635:	90                   	nop
  802636:	c9                   	leave  
  802637:	c3                   	ret    

00802638 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802638:	55                   	push   %ebp
  802639:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80263b:	6a 00                	push   $0x0
  80263d:	6a 00                	push   $0x0
  80263f:	6a 00                	push   $0x0
  802641:	6a 00                	push   $0x0
  802643:	6a 00                	push   $0x0
  802645:	6a 15                	push   $0x15
  802647:	e8 96 fd ff ff       	call   8023e2 <syscall>
  80264c:	83 c4 18             	add    $0x18,%esp
}
  80264f:	90                   	nop
  802650:	c9                   	leave  
  802651:	c3                   	ret    

00802652 <sys_cputc>:


void
sys_cputc(const char c)
{
  802652:	55                   	push   %ebp
  802653:	89 e5                	mov    %esp,%ebp
  802655:	83 ec 04             	sub    $0x4,%esp
  802658:	8b 45 08             	mov    0x8(%ebp),%eax
  80265b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80265e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802662:	6a 00                	push   $0x0
  802664:	6a 00                	push   $0x0
  802666:	6a 00                	push   $0x0
  802668:	6a 00                	push   $0x0
  80266a:	50                   	push   %eax
  80266b:	6a 16                	push   $0x16
  80266d:	e8 70 fd ff ff       	call   8023e2 <syscall>
  802672:	83 c4 18             	add    $0x18,%esp
}
  802675:	90                   	nop
  802676:	c9                   	leave  
  802677:	c3                   	ret    

00802678 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802678:	55                   	push   %ebp
  802679:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80267b:	6a 00                	push   $0x0
  80267d:	6a 00                	push   $0x0
  80267f:	6a 00                	push   $0x0
  802681:	6a 00                	push   $0x0
  802683:	6a 00                	push   $0x0
  802685:	6a 17                	push   $0x17
  802687:	e8 56 fd ff ff       	call   8023e2 <syscall>
  80268c:	83 c4 18             	add    $0x18,%esp
}
  80268f:	90                   	nop
  802690:	c9                   	leave  
  802691:	c3                   	ret    

00802692 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802692:	55                   	push   %ebp
  802693:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802695:	8b 45 08             	mov    0x8(%ebp),%eax
  802698:	6a 00                	push   $0x0
  80269a:	6a 00                	push   $0x0
  80269c:	6a 00                	push   $0x0
  80269e:	ff 75 0c             	pushl  0xc(%ebp)
  8026a1:	50                   	push   %eax
  8026a2:	6a 18                	push   $0x18
  8026a4:	e8 39 fd ff ff       	call   8023e2 <syscall>
  8026a9:	83 c4 18             	add    $0x18,%esp
}
  8026ac:	c9                   	leave  
  8026ad:	c3                   	ret    

008026ae <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8026ae:	55                   	push   %ebp
  8026af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8026b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8026b7:	6a 00                	push   $0x0
  8026b9:	6a 00                	push   $0x0
  8026bb:	6a 00                	push   $0x0
  8026bd:	52                   	push   %edx
  8026be:	50                   	push   %eax
  8026bf:	6a 1b                	push   $0x1b
  8026c1:	e8 1c fd ff ff       	call   8023e2 <syscall>
  8026c6:	83 c4 18             	add    $0x18,%esp
}
  8026c9:	c9                   	leave  
  8026ca:	c3                   	ret    

008026cb <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8026cb:	55                   	push   %ebp
  8026cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8026ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8026d4:	6a 00                	push   $0x0
  8026d6:	6a 00                	push   $0x0
  8026d8:	6a 00                	push   $0x0
  8026da:	52                   	push   %edx
  8026db:	50                   	push   %eax
  8026dc:	6a 19                	push   $0x19
  8026de:	e8 ff fc ff ff       	call   8023e2 <syscall>
  8026e3:	83 c4 18             	add    $0x18,%esp
}
  8026e6:	90                   	nop
  8026e7:	c9                   	leave  
  8026e8:	c3                   	ret    

008026e9 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8026e9:	55                   	push   %ebp
  8026ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8026ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8026f2:	6a 00                	push   $0x0
  8026f4:	6a 00                	push   $0x0
  8026f6:	6a 00                	push   $0x0
  8026f8:	52                   	push   %edx
  8026f9:	50                   	push   %eax
  8026fa:	6a 1a                	push   $0x1a
  8026fc:	e8 e1 fc ff ff       	call   8023e2 <syscall>
  802701:	83 c4 18             	add    $0x18,%esp
}
  802704:	90                   	nop
  802705:	c9                   	leave  
  802706:	c3                   	ret    

00802707 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802707:	55                   	push   %ebp
  802708:	89 e5                	mov    %esp,%ebp
  80270a:	83 ec 04             	sub    $0x4,%esp
  80270d:	8b 45 10             	mov    0x10(%ebp),%eax
  802710:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802713:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802716:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80271a:	8b 45 08             	mov    0x8(%ebp),%eax
  80271d:	6a 00                	push   $0x0
  80271f:	51                   	push   %ecx
  802720:	52                   	push   %edx
  802721:	ff 75 0c             	pushl  0xc(%ebp)
  802724:	50                   	push   %eax
  802725:	6a 1c                	push   $0x1c
  802727:	e8 b6 fc ff ff       	call   8023e2 <syscall>
  80272c:	83 c4 18             	add    $0x18,%esp
}
  80272f:	c9                   	leave  
  802730:	c3                   	ret    

00802731 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802731:	55                   	push   %ebp
  802732:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802734:	8b 55 0c             	mov    0xc(%ebp),%edx
  802737:	8b 45 08             	mov    0x8(%ebp),%eax
  80273a:	6a 00                	push   $0x0
  80273c:	6a 00                	push   $0x0
  80273e:	6a 00                	push   $0x0
  802740:	52                   	push   %edx
  802741:	50                   	push   %eax
  802742:	6a 1d                	push   $0x1d
  802744:	e8 99 fc ff ff       	call   8023e2 <syscall>
  802749:	83 c4 18             	add    $0x18,%esp
}
  80274c:	c9                   	leave  
  80274d:	c3                   	ret    

0080274e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80274e:	55                   	push   %ebp
  80274f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802751:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802754:	8b 55 0c             	mov    0xc(%ebp),%edx
  802757:	8b 45 08             	mov    0x8(%ebp),%eax
  80275a:	6a 00                	push   $0x0
  80275c:	6a 00                	push   $0x0
  80275e:	51                   	push   %ecx
  80275f:	52                   	push   %edx
  802760:	50                   	push   %eax
  802761:	6a 1e                	push   $0x1e
  802763:	e8 7a fc ff ff       	call   8023e2 <syscall>
  802768:	83 c4 18             	add    $0x18,%esp
}
  80276b:	c9                   	leave  
  80276c:	c3                   	ret    

0080276d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80276d:	55                   	push   %ebp
  80276e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802770:	8b 55 0c             	mov    0xc(%ebp),%edx
  802773:	8b 45 08             	mov    0x8(%ebp),%eax
  802776:	6a 00                	push   $0x0
  802778:	6a 00                	push   $0x0
  80277a:	6a 00                	push   $0x0
  80277c:	52                   	push   %edx
  80277d:	50                   	push   %eax
  80277e:	6a 1f                	push   $0x1f
  802780:	e8 5d fc ff ff       	call   8023e2 <syscall>
  802785:	83 c4 18             	add    $0x18,%esp
}
  802788:	c9                   	leave  
  802789:	c3                   	ret    

0080278a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80278a:	55                   	push   %ebp
  80278b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80278d:	6a 00                	push   $0x0
  80278f:	6a 00                	push   $0x0
  802791:	6a 00                	push   $0x0
  802793:	6a 00                	push   $0x0
  802795:	6a 00                	push   $0x0
  802797:	6a 20                	push   $0x20
  802799:	e8 44 fc ff ff       	call   8023e2 <syscall>
  80279e:	83 c4 18             	add    $0x18,%esp
}
  8027a1:	c9                   	leave  
  8027a2:	c3                   	ret    

008027a3 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8027a3:	55                   	push   %ebp
  8027a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8027a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8027a9:	6a 00                	push   $0x0
  8027ab:	ff 75 14             	pushl  0x14(%ebp)
  8027ae:	ff 75 10             	pushl  0x10(%ebp)
  8027b1:	ff 75 0c             	pushl  0xc(%ebp)
  8027b4:	50                   	push   %eax
  8027b5:	6a 21                	push   $0x21
  8027b7:	e8 26 fc ff ff       	call   8023e2 <syscall>
  8027bc:	83 c4 18             	add    $0x18,%esp
}
  8027bf:	c9                   	leave  
  8027c0:	c3                   	ret    

008027c1 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8027c1:	55                   	push   %ebp
  8027c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8027c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8027c7:	6a 00                	push   $0x0
  8027c9:	6a 00                	push   $0x0
  8027cb:	6a 00                	push   $0x0
  8027cd:	6a 00                	push   $0x0
  8027cf:	50                   	push   %eax
  8027d0:	6a 22                	push   $0x22
  8027d2:	e8 0b fc ff ff       	call   8023e2 <syscall>
  8027d7:	83 c4 18             	add    $0x18,%esp
}
  8027da:	90                   	nop
  8027db:	c9                   	leave  
  8027dc:	c3                   	ret    

008027dd <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8027dd:	55                   	push   %ebp
  8027de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8027e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8027e3:	6a 00                	push   $0x0
  8027e5:	6a 00                	push   $0x0
  8027e7:	6a 00                	push   $0x0
  8027e9:	6a 00                	push   $0x0
  8027eb:	50                   	push   %eax
  8027ec:	6a 23                	push   $0x23
  8027ee:	e8 ef fb ff ff       	call   8023e2 <syscall>
  8027f3:	83 c4 18             	add    $0x18,%esp
}
  8027f6:	90                   	nop
  8027f7:	c9                   	leave  
  8027f8:	c3                   	ret    

008027f9 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8027f9:	55                   	push   %ebp
  8027fa:	89 e5                	mov    %esp,%ebp
  8027fc:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8027ff:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802802:	8d 50 04             	lea    0x4(%eax),%edx
  802805:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802808:	6a 00                	push   $0x0
  80280a:	6a 00                	push   $0x0
  80280c:	6a 00                	push   $0x0
  80280e:	52                   	push   %edx
  80280f:	50                   	push   %eax
  802810:	6a 24                	push   $0x24
  802812:	e8 cb fb ff ff       	call   8023e2 <syscall>
  802817:	83 c4 18             	add    $0x18,%esp
	return result;
  80281a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80281d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802820:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802823:	89 01                	mov    %eax,(%ecx)
  802825:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802828:	8b 45 08             	mov    0x8(%ebp),%eax
  80282b:	c9                   	leave  
  80282c:	c2 04 00             	ret    $0x4

0080282f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80282f:	55                   	push   %ebp
  802830:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802832:	6a 00                	push   $0x0
  802834:	6a 00                	push   $0x0
  802836:	ff 75 10             	pushl  0x10(%ebp)
  802839:	ff 75 0c             	pushl  0xc(%ebp)
  80283c:	ff 75 08             	pushl  0x8(%ebp)
  80283f:	6a 13                	push   $0x13
  802841:	e8 9c fb ff ff       	call   8023e2 <syscall>
  802846:	83 c4 18             	add    $0x18,%esp
	return ;
  802849:	90                   	nop
}
  80284a:	c9                   	leave  
  80284b:	c3                   	ret    

0080284c <sys_rcr2>:
uint32 sys_rcr2()
{
  80284c:	55                   	push   %ebp
  80284d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80284f:	6a 00                	push   $0x0
  802851:	6a 00                	push   $0x0
  802853:	6a 00                	push   $0x0
  802855:	6a 00                	push   $0x0
  802857:	6a 00                	push   $0x0
  802859:	6a 25                	push   $0x25
  80285b:	e8 82 fb ff ff       	call   8023e2 <syscall>
  802860:	83 c4 18             	add    $0x18,%esp
}
  802863:	c9                   	leave  
  802864:	c3                   	ret    

00802865 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802865:	55                   	push   %ebp
  802866:	89 e5                	mov    %esp,%ebp
  802868:	83 ec 04             	sub    $0x4,%esp
  80286b:	8b 45 08             	mov    0x8(%ebp),%eax
  80286e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802871:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802875:	6a 00                	push   $0x0
  802877:	6a 00                	push   $0x0
  802879:	6a 00                	push   $0x0
  80287b:	6a 00                	push   $0x0
  80287d:	50                   	push   %eax
  80287e:	6a 26                	push   $0x26
  802880:	e8 5d fb ff ff       	call   8023e2 <syscall>
  802885:	83 c4 18             	add    $0x18,%esp
	return ;
  802888:	90                   	nop
}
  802889:	c9                   	leave  
  80288a:	c3                   	ret    

0080288b <rsttst>:
void rsttst()
{
  80288b:	55                   	push   %ebp
  80288c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80288e:	6a 00                	push   $0x0
  802890:	6a 00                	push   $0x0
  802892:	6a 00                	push   $0x0
  802894:	6a 00                	push   $0x0
  802896:	6a 00                	push   $0x0
  802898:	6a 28                	push   $0x28
  80289a:	e8 43 fb ff ff       	call   8023e2 <syscall>
  80289f:	83 c4 18             	add    $0x18,%esp
	return ;
  8028a2:	90                   	nop
}
  8028a3:	c9                   	leave  
  8028a4:	c3                   	ret    

008028a5 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8028a5:	55                   	push   %ebp
  8028a6:	89 e5                	mov    %esp,%ebp
  8028a8:	83 ec 04             	sub    $0x4,%esp
  8028ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8028ae:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8028b1:	8b 55 18             	mov    0x18(%ebp),%edx
  8028b4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8028b8:	52                   	push   %edx
  8028b9:	50                   	push   %eax
  8028ba:	ff 75 10             	pushl  0x10(%ebp)
  8028bd:	ff 75 0c             	pushl  0xc(%ebp)
  8028c0:	ff 75 08             	pushl  0x8(%ebp)
  8028c3:	6a 27                	push   $0x27
  8028c5:	e8 18 fb ff ff       	call   8023e2 <syscall>
  8028ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8028cd:	90                   	nop
}
  8028ce:	c9                   	leave  
  8028cf:	c3                   	ret    

008028d0 <chktst>:
void chktst(uint32 n)
{
  8028d0:	55                   	push   %ebp
  8028d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8028d3:	6a 00                	push   $0x0
  8028d5:	6a 00                	push   $0x0
  8028d7:	6a 00                	push   $0x0
  8028d9:	6a 00                	push   $0x0
  8028db:	ff 75 08             	pushl  0x8(%ebp)
  8028de:	6a 29                	push   $0x29
  8028e0:	e8 fd fa ff ff       	call   8023e2 <syscall>
  8028e5:	83 c4 18             	add    $0x18,%esp
	return ;
  8028e8:	90                   	nop
}
  8028e9:	c9                   	leave  
  8028ea:	c3                   	ret    

008028eb <inctst>:

void inctst()
{
  8028eb:	55                   	push   %ebp
  8028ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8028ee:	6a 00                	push   $0x0
  8028f0:	6a 00                	push   $0x0
  8028f2:	6a 00                	push   $0x0
  8028f4:	6a 00                	push   $0x0
  8028f6:	6a 00                	push   $0x0
  8028f8:	6a 2a                	push   $0x2a
  8028fa:	e8 e3 fa ff ff       	call   8023e2 <syscall>
  8028ff:	83 c4 18             	add    $0x18,%esp
	return ;
  802902:	90                   	nop
}
  802903:	c9                   	leave  
  802904:	c3                   	ret    

00802905 <gettst>:
uint32 gettst()
{
  802905:	55                   	push   %ebp
  802906:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802908:	6a 00                	push   $0x0
  80290a:	6a 00                	push   $0x0
  80290c:	6a 00                	push   $0x0
  80290e:	6a 00                	push   $0x0
  802910:	6a 00                	push   $0x0
  802912:	6a 2b                	push   $0x2b
  802914:	e8 c9 fa ff ff       	call   8023e2 <syscall>
  802919:	83 c4 18             	add    $0x18,%esp
}
  80291c:	c9                   	leave  
  80291d:	c3                   	ret    

0080291e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80291e:	55                   	push   %ebp
  80291f:	89 e5                	mov    %esp,%ebp
  802921:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802924:	6a 00                	push   $0x0
  802926:	6a 00                	push   $0x0
  802928:	6a 00                	push   $0x0
  80292a:	6a 00                	push   $0x0
  80292c:	6a 00                	push   $0x0
  80292e:	6a 2c                	push   $0x2c
  802930:	e8 ad fa ff ff       	call   8023e2 <syscall>
  802935:	83 c4 18             	add    $0x18,%esp
  802938:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80293b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80293f:	75 07                	jne    802948 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802941:	b8 01 00 00 00       	mov    $0x1,%eax
  802946:	eb 05                	jmp    80294d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802948:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80294d:	c9                   	leave  
  80294e:	c3                   	ret    

0080294f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80294f:	55                   	push   %ebp
  802950:	89 e5                	mov    %esp,%ebp
  802952:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802955:	6a 00                	push   $0x0
  802957:	6a 00                	push   $0x0
  802959:	6a 00                	push   $0x0
  80295b:	6a 00                	push   $0x0
  80295d:	6a 00                	push   $0x0
  80295f:	6a 2c                	push   $0x2c
  802961:	e8 7c fa ff ff       	call   8023e2 <syscall>
  802966:	83 c4 18             	add    $0x18,%esp
  802969:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80296c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802970:	75 07                	jne    802979 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802972:	b8 01 00 00 00       	mov    $0x1,%eax
  802977:	eb 05                	jmp    80297e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802979:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80297e:	c9                   	leave  
  80297f:	c3                   	ret    

00802980 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802980:	55                   	push   %ebp
  802981:	89 e5                	mov    %esp,%ebp
  802983:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802986:	6a 00                	push   $0x0
  802988:	6a 00                	push   $0x0
  80298a:	6a 00                	push   $0x0
  80298c:	6a 00                	push   $0x0
  80298e:	6a 00                	push   $0x0
  802990:	6a 2c                	push   $0x2c
  802992:	e8 4b fa ff ff       	call   8023e2 <syscall>
  802997:	83 c4 18             	add    $0x18,%esp
  80299a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80299d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8029a1:	75 07                	jne    8029aa <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8029a3:	b8 01 00 00 00       	mov    $0x1,%eax
  8029a8:	eb 05                	jmp    8029af <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8029aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8029af:	c9                   	leave  
  8029b0:	c3                   	ret    

008029b1 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8029b1:	55                   	push   %ebp
  8029b2:	89 e5                	mov    %esp,%ebp
  8029b4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8029b7:	6a 00                	push   $0x0
  8029b9:	6a 00                	push   $0x0
  8029bb:	6a 00                	push   $0x0
  8029bd:	6a 00                	push   $0x0
  8029bf:	6a 00                	push   $0x0
  8029c1:	6a 2c                	push   $0x2c
  8029c3:	e8 1a fa ff ff       	call   8023e2 <syscall>
  8029c8:	83 c4 18             	add    $0x18,%esp
  8029cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8029ce:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8029d2:	75 07                	jne    8029db <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8029d4:	b8 01 00 00 00       	mov    $0x1,%eax
  8029d9:	eb 05                	jmp    8029e0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8029db:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8029e0:	c9                   	leave  
  8029e1:	c3                   	ret    

008029e2 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8029e2:	55                   	push   %ebp
  8029e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8029e5:	6a 00                	push   $0x0
  8029e7:	6a 00                	push   $0x0
  8029e9:	6a 00                	push   $0x0
  8029eb:	6a 00                	push   $0x0
  8029ed:	ff 75 08             	pushl  0x8(%ebp)
  8029f0:	6a 2d                	push   $0x2d
  8029f2:	e8 eb f9 ff ff       	call   8023e2 <syscall>
  8029f7:	83 c4 18             	add    $0x18,%esp
	return ;
  8029fa:	90                   	nop
}
  8029fb:	c9                   	leave  
  8029fc:	c3                   	ret    

008029fd <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8029fd:	55                   	push   %ebp
  8029fe:	89 e5                	mov    %esp,%ebp
  802a00:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802a01:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802a04:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802a07:	8b 55 0c             	mov    0xc(%ebp),%edx
  802a0a:	8b 45 08             	mov    0x8(%ebp),%eax
  802a0d:	6a 00                	push   $0x0
  802a0f:	53                   	push   %ebx
  802a10:	51                   	push   %ecx
  802a11:	52                   	push   %edx
  802a12:	50                   	push   %eax
  802a13:	6a 2e                	push   $0x2e
  802a15:	e8 c8 f9 ff ff       	call   8023e2 <syscall>
  802a1a:	83 c4 18             	add    $0x18,%esp
}
  802a1d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802a20:	c9                   	leave  
  802a21:	c3                   	ret    

00802a22 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802a22:	55                   	push   %ebp
  802a23:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802a25:	8b 55 0c             	mov    0xc(%ebp),%edx
  802a28:	8b 45 08             	mov    0x8(%ebp),%eax
  802a2b:	6a 00                	push   $0x0
  802a2d:	6a 00                	push   $0x0
  802a2f:	6a 00                	push   $0x0
  802a31:	52                   	push   %edx
  802a32:	50                   	push   %eax
  802a33:	6a 2f                	push   $0x2f
  802a35:	e8 a8 f9 ff ff       	call   8023e2 <syscall>
  802a3a:	83 c4 18             	add    $0x18,%esp
}
  802a3d:	c9                   	leave  
  802a3e:	c3                   	ret    

00802a3f <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802a3f:	55                   	push   %ebp
  802a40:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802a42:	6a 00                	push   $0x0
  802a44:	6a 00                	push   $0x0
  802a46:	6a 00                	push   $0x0
  802a48:	ff 75 0c             	pushl  0xc(%ebp)
  802a4b:	ff 75 08             	pushl  0x8(%ebp)
  802a4e:	6a 30                	push   $0x30
  802a50:	e8 8d f9 ff ff       	call   8023e2 <syscall>
  802a55:	83 c4 18             	add    $0x18,%esp
	return ;
  802a58:	90                   	nop
}
  802a59:	c9                   	leave  
  802a5a:	c3                   	ret    
  802a5b:	90                   	nop

00802a5c <__udivdi3>:
  802a5c:	55                   	push   %ebp
  802a5d:	57                   	push   %edi
  802a5e:	56                   	push   %esi
  802a5f:	53                   	push   %ebx
  802a60:	83 ec 1c             	sub    $0x1c,%esp
  802a63:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802a67:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802a6b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802a6f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802a73:	89 ca                	mov    %ecx,%edx
  802a75:	89 f8                	mov    %edi,%eax
  802a77:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802a7b:	85 f6                	test   %esi,%esi
  802a7d:	75 2d                	jne    802aac <__udivdi3+0x50>
  802a7f:	39 cf                	cmp    %ecx,%edi
  802a81:	77 65                	ja     802ae8 <__udivdi3+0x8c>
  802a83:	89 fd                	mov    %edi,%ebp
  802a85:	85 ff                	test   %edi,%edi
  802a87:	75 0b                	jne    802a94 <__udivdi3+0x38>
  802a89:	b8 01 00 00 00       	mov    $0x1,%eax
  802a8e:	31 d2                	xor    %edx,%edx
  802a90:	f7 f7                	div    %edi
  802a92:	89 c5                	mov    %eax,%ebp
  802a94:	31 d2                	xor    %edx,%edx
  802a96:	89 c8                	mov    %ecx,%eax
  802a98:	f7 f5                	div    %ebp
  802a9a:	89 c1                	mov    %eax,%ecx
  802a9c:	89 d8                	mov    %ebx,%eax
  802a9e:	f7 f5                	div    %ebp
  802aa0:	89 cf                	mov    %ecx,%edi
  802aa2:	89 fa                	mov    %edi,%edx
  802aa4:	83 c4 1c             	add    $0x1c,%esp
  802aa7:	5b                   	pop    %ebx
  802aa8:	5e                   	pop    %esi
  802aa9:	5f                   	pop    %edi
  802aaa:	5d                   	pop    %ebp
  802aab:	c3                   	ret    
  802aac:	39 ce                	cmp    %ecx,%esi
  802aae:	77 28                	ja     802ad8 <__udivdi3+0x7c>
  802ab0:	0f bd fe             	bsr    %esi,%edi
  802ab3:	83 f7 1f             	xor    $0x1f,%edi
  802ab6:	75 40                	jne    802af8 <__udivdi3+0x9c>
  802ab8:	39 ce                	cmp    %ecx,%esi
  802aba:	72 0a                	jb     802ac6 <__udivdi3+0x6a>
  802abc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802ac0:	0f 87 9e 00 00 00    	ja     802b64 <__udivdi3+0x108>
  802ac6:	b8 01 00 00 00       	mov    $0x1,%eax
  802acb:	89 fa                	mov    %edi,%edx
  802acd:	83 c4 1c             	add    $0x1c,%esp
  802ad0:	5b                   	pop    %ebx
  802ad1:	5e                   	pop    %esi
  802ad2:	5f                   	pop    %edi
  802ad3:	5d                   	pop    %ebp
  802ad4:	c3                   	ret    
  802ad5:	8d 76 00             	lea    0x0(%esi),%esi
  802ad8:	31 ff                	xor    %edi,%edi
  802ada:	31 c0                	xor    %eax,%eax
  802adc:	89 fa                	mov    %edi,%edx
  802ade:	83 c4 1c             	add    $0x1c,%esp
  802ae1:	5b                   	pop    %ebx
  802ae2:	5e                   	pop    %esi
  802ae3:	5f                   	pop    %edi
  802ae4:	5d                   	pop    %ebp
  802ae5:	c3                   	ret    
  802ae6:	66 90                	xchg   %ax,%ax
  802ae8:	89 d8                	mov    %ebx,%eax
  802aea:	f7 f7                	div    %edi
  802aec:	31 ff                	xor    %edi,%edi
  802aee:	89 fa                	mov    %edi,%edx
  802af0:	83 c4 1c             	add    $0x1c,%esp
  802af3:	5b                   	pop    %ebx
  802af4:	5e                   	pop    %esi
  802af5:	5f                   	pop    %edi
  802af6:	5d                   	pop    %ebp
  802af7:	c3                   	ret    
  802af8:	bd 20 00 00 00       	mov    $0x20,%ebp
  802afd:	89 eb                	mov    %ebp,%ebx
  802aff:	29 fb                	sub    %edi,%ebx
  802b01:	89 f9                	mov    %edi,%ecx
  802b03:	d3 e6                	shl    %cl,%esi
  802b05:	89 c5                	mov    %eax,%ebp
  802b07:	88 d9                	mov    %bl,%cl
  802b09:	d3 ed                	shr    %cl,%ebp
  802b0b:	89 e9                	mov    %ebp,%ecx
  802b0d:	09 f1                	or     %esi,%ecx
  802b0f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802b13:	89 f9                	mov    %edi,%ecx
  802b15:	d3 e0                	shl    %cl,%eax
  802b17:	89 c5                	mov    %eax,%ebp
  802b19:	89 d6                	mov    %edx,%esi
  802b1b:	88 d9                	mov    %bl,%cl
  802b1d:	d3 ee                	shr    %cl,%esi
  802b1f:	89 f9                	mov    %edi,%ecx
  802b21:	d3 e2                	shl    %cl,%edx
  802b23:	8b 44 24 08          	mov    0x8(%esp),%eax
  802b27:	88 d9                	mov    %bl,%cl
  802b29:	d3 e8                	shr    %cl,%eax
  802b2b:	09 c2                	or     %eax,%edx
  802b2d:	89 d0                	mov    %edx,%eax
  802b2f:	89 f2                	mov    %esi,%edx
  802b31:	f7 74 24 0c          	divl   0xc(%esp)
  802b35:	89 d6                	mov    %edx,%esi
  802b37:	89 c3                	mov    %eax,%ebx
  802b39:	f7 e5                	mul    %ebp
  802b3b:	39 d6                	cmp    %edx,%esi
  802b3d:	72 19                	jb     802b58 <__udivdi3+0xfc>
  802b3f:	74 0b                	je     802b4c <__udivdi3+0xf0>
  802b41:	89 d8                	mov    %ebx,%eax
  802b43:	31 ff                	xor    %edi,%edi
  802b45:	e9 58 ff ff ff       	jmp    802aa2 <__udivdi3+0x46>
  802b4a:	66 90                	xchg   %ax,%ax
  802b4c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802b50:	89 f9                	mov    %edi,%ecx
  802b52:	d3 e2                	shl    %cl,%edx
  802b54:	39 c2                	cmp    %eax,%edx
  802b56:	73 e9                	jae    802b41 <__udivdi3+0xe5>
  802b58:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802b5b:	31 ff                	xor    %edi,%edi
  802b5d:	e9 40 ff ff ff       	jmp    802aa2 <__udivdi3+0x46>
  802b62:	66 90                	xchg   %ax,%ax
  802b64:	31 c0                	xor    %eax,%eax
  802b66:	e9 37 ff ff ff       	jmp    802aa2 <__udivdi3+0x46>
  802b6b:	90                   	nop

00802b6c <__umoddi3>:
  802b6c:	55                   	push   %ebp
  802b6d:	57                   	push   %edi
  802b6e:	56                   	push   %esi
  802b6f:	53                   	push   %ebx
  802b70:	83 ec 1c             	sub    $0x1c,%esp
  802b73:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802b77:	8b 74 24 34          	mov    0x34(%esp),%esi
  802b7b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802b7f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802b83:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802b87:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802b8b:	89 f3                	mov    %esi,%ebx
  802b8d:	89 fa                	mov    %edi,%edx
  802b8f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802b93:	89 34 24             	mov    %esi,(%esp)
  802b96:	85 c0                	test   %eax,%eax
  802b98:	75 1a                	jne    802bb4 <__umoddi3+0x48>
  802b9a:	39 f7                	cmp    %esi,%edi
  802b9c:	0f 86 a2 00 00 00    	jbe    802c44 <__umoddi3+0xd8>
  802ba2:	89 c8                	mov    %ecx,%eax
  802ba4:	89 f2                	mov    %esi,%edx
  802ba6:	f7 f7                	div    %edi
  802ba8:	89 d0                	mov    %edx,%eax
  802baa:	31 d2                	xor    %edx,%edx
  802bac:	83 c4 1c             	add    $0x1c,%esp
  802baf:	5b                   	pop    %ebx
  802bb0:	5e                   	pop    %esi
  802bb1:	5f                   	pop    %edi
  802bb2:	5d                   	pop    %ebp
  802bb3:	c3                   	ret    
  802bb4:	39 f0                	cmp    %esi,%eax
  802bb6:	0f 87 ac 00 00 00    	ja     802c68 <__umoddi3+0xfc>
  802bbc:	0f bd e8             	bsr    %eax,%ebp
  802bbf:	83 f5 1f             	xor    $0x1f,%ebp
  802bc2:	0f 84 ac 00 00 00    	je     802c74 <__umoddi3+0x108>
  802bc8:	bf 20 00 00 00       	mov    $0x20,%edi
  802bcd:	29 ef                	sub    %ebp,%edi
  802bcf:	89 fe                	mov    %edi,%esi
  802bd1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802bd5:	89 e9                	mov    %ebp,%ecx
  802bd7:	d3 e0                	shl    %cl,%eax
  802bd9:	89 d7                	mov    %edx,%edi
  802bdb:	89 f1                	mov    %esi,%ecx
  802bdd:	d3 ef                	shr    %cl,%edi
  802bdf:	09 c7                	or     %eax,%edi
  802be1:	89 e9                	mov    %ebp,%ecx
  802be3:	d3 e2                	shl    %cl,%edx
  802be5:	89 14 24             	mov    %edx,(%esp)
  802be8:	89 d8                	mov    %ebx,%eax
  802bea:	d3 e0                	shl    %cl,%eax
  802bec:	89 c2                	mov    %eax,%edx
  802bee:	8b 44 24 08          	mov    0x8(%esp),%eax
  802bf2:	d3 e0                	shl    %cl,%eax
  802bf4:	89 44 24 04          	mov    %eax,0x4(%esp)
  802bf8:	8b 44 24 08          	mov    0x8(%esp),%eax
  802bfc:	89 f1                	mov    %esi,%ecx
  802bfe:	d3 e8                	shr    %cl,%eax
  802c00:	09 d0                	or     %edx,%eax
  802c02:	d3 eb                	shr    %cl,%ebx
  802c04:	89 da                	mov    %ebx,%edx
  802c06:	f7 f7                	div    %edi
  802c08:	89 d3                	mov    %edx,%ebx
  802c0a:	f7 24 24             	mull   (%esp)
  802c0d:	89 c6                	mov    %eax,%esi
  802c0f:	89 d1                	mov    %edx,%ecx
  802c11:	39 d3                	cmp    %edx,%ebx
  802c13:	0f 82 87 00 00 00    	jb     802ca0 <__umoddi3+0x134>
  802c19:	0f 84 91 00 00 00    	je     802cb0 <__umoddi3+0x144>
  802c1f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802c23:	29 f2                	sub    %esi,%edx
  802c25:	19 cb                	sbb    %ecx,%ebx
  802c27:	89 d8                	mov    %ebx,%eax
  802c29:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802c2d:	d3 e0                	shl    %cl,%eax
  802c2f:	89 e9                	mov    %ebp,%ecx
  802c31:	d3 ea                	shr    %cl,%edx
  802c33:	09 d0                	or     %edx,%eax
  802c35:	89 e9                	mov    %ebp,%ecx
  802c37:	d3 eb                	shr    %cl,%ebx
  802c39:	89 da                	mov    %ebx,%edx
  802c3b:	83 c4 1c             	add    $0x1c,%esp
  802c3e:	5b                   	pop    %ebx
  802c3f:	5e                   	pop    %esi
  802c40:	5f                   	pop    %edi
  802c41:	5d                   	pop    %ebp
  802c42:	c3                   	ret    
  802c43:	90                   	nop
  802c44:	89 fd                	mov    %edi,%ebp
  802c46:	85 ff                	test   %edi,%edi
  802c48:	75 0b                	jne    802c55 <__umoddi3+0xe9>
  802c4a:	b8 01 00 00 00       	mov    $0x1,%eax
  802c4f:	31 d2                	xor    %edx,%edx
  802c51:	f7 f7                	div    %edi
  802c53:	89 c5                	mov    %eax,%ebp
  802c55:	89 f0                	mov    %esi,%eax
  802c57:	31 d2                	xor    %edx,%edx
  802c59:	f7 f5                	div    %ebp
  802c5b:	89 c8                	mov    %ecx,%eax
  802c5d:	f7 f5                	div    %ebp
  802c5f:	89 d0                	mov    %edx,%eax
  802c61:	e9 44 ff ff ff       	jmp    802baa <__umoddi3+0x3e>
  802c66:	66 90                	xchg   %ax,%ax
  802c68:	89 c8                	mov    %ecx,%eax
  802c6a:	89 f2                	mov    %esi,%edx
  802c6c:	83 c4 1c             	add    $0x1c,%esp
  802c6f:	5b                   	pop    %ebx
  802c70:	5e                   	pop    %esi
  802c71:	5f                   	pop    %edi
  802c72:	5d                   	pop    %ebp
  802c73:	c3                   	ret    
  802c74:	3b 04 24             	cmp    (%esp),%eax
  802c77:	72 06                	jb     802c7f <__umoddi3+0x113>
  802c79:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802c7d:	77 0f                	ja     802c8e <__umoddi3+0x122>
  802c7f:	89 f2                	mov    %esi,%edx
  802c81:	29 f9                	sub    %edi,%ecx
  802c83:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802c87:	89 14 24             	mov    %edx,(%esp)
  802c8a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802c8e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802c92:	8b 14 24             	mov    (%esp),%edx
  802c95:	83 c4 1c             	add    $0x1c,%esp
  802c98:	5b                   	pop    %ebx
  802c99:	5e                   	pop    %esi
  802c9a:	5f                   	pop    %edi
  802c9b:	5d                   	pop    %ebp
  802c9c:	c3                   	ret    
  802c9d:	8d 76 00             	lea    0x0(%esi),%esi
  802ca0:	2b 04 24             	sub    (%esp),%eax
  802ca3:	19 fa                	sbb    %edi,%edx
  802ca5:	89 d1                	mov    %edx,%ecx
  802ca7:	89 c6                	mov    %eax,%esi
  802ca9:	e9 71 ff ff ff       	jmp    802c1f <__umoddi3+0xb3>
  802cae:	66 90                	xchg   %ax,%ax
  802cb0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802cb4:	72 ea                	jb     802ca0 <__umoddi3+0x134>
  802cb6:	89 d9                	mov    %ebx,%ecx
  802cb8:	e9 62 ff ff ff       	jmp    802c1f <__umoddi3+0xb3>
