
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
  800031:	e8 77 18 00 00       	call   8018ad <libmain>
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
  80003d:	81 ec 90 01 00 00    	sub    $0x190,%esp
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
  800092:	68 00 37 80 00       	push   $0x803700
  800097:	6a 1a                	push   $0x1a
  800099:	68 1c 37 80 00       	push   $0x80371c
  80009e:	e8 32 19 00 00       	call   8019d5 <_panic>





	int Mega = 1024*1024;
  8000a3:	c7 45 e0 00 00 10 00 	movl   $0x100000,-0x20(%ebp)
	int kilo = 1024;
  8000aa:	c7 45 dc 00 04 00 00 	movl   $0x400,-0x24(%ebp)
	char minByte = 1<<7;
  8000b1:	c6 45 db 80          	movb   $0x80,-0x25(%ebp)
	char maxByte = 0x7F;
  8000b5:	c6 45 da 7f          	movb   $0x7f,-0x26(%ebp)
	short minShort = 1<<15 ;
  8000b9:	66 c7 45 d8 00 80    	movw   $0x8000,-0x28(%ebp)
	short maxShort = 0x7FFF;
  8000bf:	66 c7 45 d6 ff 7f    	movw   $0x7fff,-0x2a(%ebp)
	int minInt = 1<<31 ;
  8000c5:	c7 45 d0 00 00 00 80 	movl   $0x80000000,-0x30(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000cc:	c7 45 cc ff ff ff 7f 	movl   $0x7fffffff,-0x34(%ebp)
	char *byteArr, *byteArr2 ;
	short *shortArr, *shortArr2 ;
	int *intArr;
	struct MyStruct *structArr ;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;
	int start_freeFrames = sys_calculate_free_frames() ;
  8000d3:	e8 b4 2e 00 00       	call   802f8c <sys_calculate_free_frames>
  8000d8:	89 45 c8             	mov    %eax,-0x38(%ebp)

	void* ptr_allocations[20] = {0};
  8000db:	8d 95 68 fe ff ff    	lea    -0x198(%ebp),%edx
  8000e1:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000e6:	b8 00 00 00 00       	mov    $0x0,%eax
  8000eb:	89 d7                	mov    %edx,%edi
  8000ed:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 MB
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000ef:	e8 1b 2f 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  8000f4:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000f7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000fa:	01 c0                	add    %eax,%eax
  8000fc:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8000ff:	83 ec 0c             	sub    $0xc,%esp
  800102:	50                   	push   %eax
  800103:	e8 0e 29 00 00       	call   802a16 <malloc>
  800108:	83 c4 10             	add    $0x10,%esp
  80010b:	89 85 68 fe ff ff    	mov    %eax,-0x198(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800111:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800117:	85 c0                	test   %eax,%eax
  800119:	79 0d                	jns    800128 <_main+0xf0>
  80011b:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800121:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  800126:	76 14                	jbe    80013c <_main+0x104>
  800128:	83 ec 04             	sub    $0x4,%esp
  80012b:	68 30 37 80 00       	push   $0x803730
  800130:	6a 36                	push   $0x36
  800132:	68 1c 37 80 00       	push   $0x80371c
  800137:	e8 99 18 00 00       	call   8019d5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80013c:	e8 ce 2e 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800141:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800144:	3d 00 02 00 00       	cmp    $0x200,%eax
  800149:	74 14                	je     80015f <_main+0x127>
  80014b:	83 ec 04             	sub    $0x4,%esp
  80014e:	68 98 37 80 00       	push   $0x803798
  800153:	6a 37                	push   $0x37
  800155:	68 1c 37 80 00       	push   $0x80371c
  80015a:	e8 76 18 00 00       	call   8019d5 <_panic>

		int freeFrames = sys_calculate_free_frames() ;
  80015f:	e8 28 2e 00 00       	call   802f8c <sys_calculate_free_frames>
  800164:	89 45 c0             	mov    %eax,-0x40(%ebp)
		lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  800167:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80016a:	01 c0                	add    %eax,%eax
  80016c:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80016f:	48                   	dec    %eax
  800170:	89 45 bc             	mov    %eax,-0x44(%ebp)
		byteArr = (char *) ptr_allocations[0];
  800173:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800179:	89 45 b8             	mov    %eax,-0x48(%ebp)
		byteArr[0] = minByte ;
  80017c:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80017f:	8a 55 db             	mov    -0x25(%ebp),%dl
  800182:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  800184:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800187:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80018a:	01 c2                	add    %eax,%edx
  80018c:	8a 45 da             	mov    -0x26(%ebp),%al
  80018f:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800191:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800194:	e8 f3 2d 00 00       	call   802f8c <sys_calculate_free_frames>
  800199:	29 c3                	sub    %eax,%ebx
  80019b:	89 d8                	mov    %ebx,%eax
  80019d:	83 f8 03             	cmp    $0x3,%eax
  8001a0:	74 14                	je     8001b6 <_main+0x17e>
  8001a2:	83 ec 04             	sub    $0x4,%esp
  8001a5:	68 c8 37 80 00       	push   $0x8037c8
  8001aa:	6a 3e                	push   $0x3e
  8001ac:	68 1c 37 80 00       	push   $0x80371c
  8001b1:	e8 1f 18 00 00       	call   8019d5 <_panic>
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
  8001e5:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8001e8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001f0:	89 c2                	mov    %eax,%edx
  8001f2:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001f5:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8001f8:	8b 45 b0             	mov    -0x50(%ebp),%eax
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
  800223:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800226:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800229:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80022e:	89 c1                	mov    %eax,%ecx
  800230:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800233:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800236:	01 d0                	add    %edx,%eax
  800238:	89 45 a8             	mov    %eax,-0x58(%ebp)
  80023b:	8b 45 a8             	mov    -0x58(%ebp),%eax
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
  800269:	68 0c 38 80 00       	push   $0x80380c
  80026e:	6a 48                	push   $0x48
  800270:	68 1c 37 80 00       	push   $0x80371c
  800275:	e8 5b 17 00 00       	call   8019d5 <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80027a:	e8 90 2d 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  80027f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800282:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800285:	01 c0                	add    %eax,%eax
  800287:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80028a:	83 ec 0c             	sub    $0xc,%esp
  80028d:	50                   	push   %eax
  80028e:	e8 83 27 00 00       	call   802a16 <malloc>
  800293:	83 c4 10             	add    $0x10,%esp
  800296:	89 85 6c fe ff ff    	mov    %eax,-0x194(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80029c:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  8002a2:	89 c2                	mov    %eax,%edx
  8002a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002a7:	01 c0                	add    %eax,%eax
  8002a9:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ae:	39 c2                	cmp    %eax,%edx
  8002b0:	72 16                	jb     8002c8 <_main+0x290>
  8002b2:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  8002b8:	89 c2                	mov    %eax,%edx
  8002ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002bd:	01 c0                	add    %eax,%eax
  8002bf:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002c4:	39 c2                	cmp    %eax,%edx
  8002c6:	76 14                	jbe    8002dc <_main+0x2a4>
  8002c8:	83 ec 04             	sub    $0x4,%esp
  8002cb:	68 30 37 80 00       	push   $0x803730
  8002d0:	6a 4d                	push   $0x4d
  8002d2:	68 1c 37 80 00       	push   $0x80371c
  8002d7:	e8 f9 16 00 00       	call   8019d5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8002dc:	e8 2e 2d 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  8002e1:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  8002e4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002e9:	74 14                	je     8002ff <_main+0x2c7>
  8002eb:	83 ec 04             	sub    $0x4,%esp
  8002ee:	68 98 37 80 00       	push   $0x803798
  8002f3:	6a 4e                	push   $0x4e
  8002f5:	68 1c 37 80 00       	push   $0x80371c
  8002fa:	e8 d6 16 00 00       	call   8019d5 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8002ff:	e8 88 2c 00 00       	call   802f8c <sys_calculate_free_frames>
  800304:	89 45 c0             	mov    %eax,-0x40(%ebp)
		shortArr = (short *) ptr_allocations[1];
  800307:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  80030d:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  800310:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800313:	01 c0                	add    %eax,%eax
  800315:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800318:	d1 e8                	shr    %eax
  80031a:	48                   	dec    %eax
  80031b:	89 45 a0             	mov    %eax,-0x60(%ebp)
		shortArr[0] = minShort;
  80031e:	8b 55 a4             	mov    -0x5c(%ebp),%edx
  800321:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800324:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800327:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80032a:	01 c0                	add    %eax,%eax
  80032c:	89 c2                	mov    %eax,%edx
  80032e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800331:	01 c2                	add    %eax,%edx
  800333:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800337:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  80033a:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  80033d:	e8 4a 2c 00 00       	call   802f8c <sys_calculate_free_frames>
  800342:	29 c3                	sub    %eax,%ebx
  800344:	89 d8                	mov    %ebx,%eax
  800346:	83 f8 02             	cmp    $0x2,%eax
  800349:	74 14                	je     80035f <_main+0x327>
  80034b:	83 ec 04             	sub    $0x4,%esp
  80034e:	68 c8 37 80 00       	push   $0x8037c8
  800353:	6a 55                	push   $0x55
  800355:	68 1c 37 80 00       	push   $0x80371c
  80035a:	e8 76 16 00 00       	call   8019d5 <_panic>
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
  80038e:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800391:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800394:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800399:	89 c2                	mov    %eax,%edx
  80039b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80039e:	89 45 98             	mov    %eax,-0x68(%ebp)
  8003a1:	8b 45 98             	mov    -0x68(%ebp),%eax
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
  8003cc:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8003cf:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8003d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d7:	89 c2                	mov    %eax,%edx
  8003d9:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003dc:	01 c0                	add    %eax,%eax
  8003de:	89 c1                	mov    %eax,%ecx
  8003e0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003e3:	01 c8                	add    %ecx,%eax
  8003e5:	89 45 90             	mov    %eax,-0x70(%ebp)
  8003e8:	8b 45 90             	mov    -0x70(%ebp),%eax
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
  800416:	68 0c 38 80 00       	push   $0x80380c
  80041b:	6a 5e                	push   $0x5e
  80041d:	68 1c 37 80 00       	push   $0x80371c
  800422:	e8 ae 15 00 00       	call   8019d5 <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800427:	e8 e3 2b 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  80042c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  80042f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800432:	01 c0                	add    %eax,%eax
  800434:	83 ec 0c             	sub    $0xc,%esp
  800437:	50                   	push   %eax
  800438:	e8 d9 25 00 00       	call   802a16 <malloc>
  80043d:	83 c4 10             	add    $0x10,%esp
  800440:	89 85 70 fe ff ff    	mov    %eax,-0x190(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800446:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  80044c:	89 c2                	mov    %eax,%edx
  80044e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800451:	c1 e0 02             	shl    $0x2,%eax
  800454:	05 00 00 00 80       	add    $0x80000000,%eax
  800459:	39 c2                	cmp    %eax,%edx
  80045b:	72 17                	jb     800474 <_main+0x43c>
  80045d:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  800463:	89 c2                	mov    %eax,%edx
  800465:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800468:	c1 e0 02             	shl    $0x2,%eax
  80046b:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800470:	39 c2                	cmp    %eax,%edx
  800472:	76 14                	jbe    800488 <_main+0x450>
  800474:	83 ec 04             	sub    $0x4,%esp
  800477:	68 30 37 80 00       	push   $0x803730
  80047c:	6a 63                	push   $0x63
  80047e:	68 1c 37 80 00       	push   $0x80371c
  800483:	e8 4d 15 00 00       	call   8019d5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800488:	e8 82 2b 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  80048d:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800490:	83 f8 01             	cmp    $0x1,%eax
  800493:	74 14                	je     8004a9 <_main+0x471>
  800495:	83 ec 04             	sub    $0x4,%esp
  800498:	68 98 37 80 00       	push   $0x803798
  80049d:	6a 64                	push   $0x64
  80049f:	68 1c 37 80 00       	push   $0x80371c
  8004a4:	e8 2c 15 00 00       	call   8019d5 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8004a9:	e8 de 2a 00 00       	call   802f8c <sys_calculate_free_frames>
  8004ae:	89 45 c0             	mov    %eax,-0x40(%ebp)
		intArr = (int *) ptr_allocations[2];
  8004b1:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  8004b7:	89 45 8c             	mov    %eax,-0x74(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  8004ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004bd:	01 c0                	add    %eax,%eax
  8004bf:	c1 e8 02             	shr    $0x2,%eax
  8004c2:	48                   	dec    %eax
  8004c3:	89 45 88             	mov    %eax,-0x78(%ebp)
		intArr[0] = minInt;
  8004c6:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8004c9:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8004cc:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  8004ce:	8b 45 88             	mov    -0x78(%ebp),%eax
  8004d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d8:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8004db:	01 c2                	add    %eax,%edx
  8004dd:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8004e0:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8004e2:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8004e5:	e8 a2 2a 00 00       	call   802f8c <sys_calculate_free_frames>
  8004ea:	29 c3                	sub    %eax,%ebx
  8004ec:	89 d8                	mov    %ebx,%eax
  8004ee:	83 f8 02             	cmp    $0x2,%eax
  8004f1:	74 14                	je     800507 <_main+0x4cf>
  8004f3:	83 ec 04             	sub    $0x4,%esp
  8004f6:	68 c8 37 80 00       	push   $0x8037c8
  8004fb:	6a 6b                	push   $0x6b
  8004fd:	68 1c 37 80 00       	push   $0x80371c
  800502:	e8 ce 14 00 00       	call   8019d5 <_panic>
		found = 0;
  800507:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80050e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800515:	e9 97 00 00 00       	jmp    8005b1 <_main+0x579>
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
  800536:	89 45 84             	mov    %eax,-0x7c(%ebp)
  800539:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80053c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800541:	89 c2                	mov    %eax,%edx
  800543:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800546:	89 45 80             	mov    %eax,-0x80(%ebp)
  800549:	8b 45 80             	mov    -0x80(%ebp),%eax
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
  800574:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80057a:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800580:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800585:	89 c2                	mov    %eax,%edx
  800587:	8b 45 88             	mov    -0x78(%ebp),%eax
  80058a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800591:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800594:	01 c8                	add    %ecx,%eax
  800596:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  80059c:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8005a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005a7:	39 c2                	cmp    %eax,%edx
  8005a9:	75 03                	jne    8005ae <_main+0x576>
				found++;
  8005ab:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8005ae:	ff 45 ec             	incl   -0x14(%ebp)
  8005b1:	a1 20 40 80 00       	mov    0x804020,%eax
  8005b6:	8b 50 74             	mov    0x74(%eax),%edx
  8005b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005bc:	39 c2                	cmp    %eax,%edx
  8005be:	0f 87 56 ff ff ff    	ja     80051a <_main+0x4e2>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8005c4:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8005c8:	74 14                	je     8005de <_main+0x5a6>
  8005ca:	83 ec 04             	sub    $0x4,%esp
  8005cd:	68 0c 38 80 00       	push   $0x80380c
  8005d2:	6a 74                	push   $0x74
  8005d4:	68 1c 37 80 00       	push   $0x80371c
  8005d9:	e8 f7 13 00 00       	call   8019d5 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8005de:	e8 a9 29 00 00       	call   802f8c <sys_calculate_free_frames>
  8005e3:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005e6:	e8 24 2a 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  8005eb:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8005ee:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005f1:	01 c0                	add    %eax,%eax
  8005f3:	83 ec 0c             	sub    $0xc,%esp
  8005f6:	50                   	push   %eax
  8005f7:	e8 1a 24 00 00       	call   802a16 <malloc>
  8005fc:	83 c4 10             	add    $0x10,%esp
  8005ff:	89 85 74 fe ff ff    	mov    %eax,-0x18c(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800605:	8b 85 74 fe ff ff    	mov    -0x18c(%ebp),%eax
  80060b:	89 c2                	mov    %eax,%edx
  80060d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800610:	c1 e0 02             	shl    $0x2,%eax
  800613:	89 c1                	mov    %eax,%ecx
  800615:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800618:	c1 e0 02             	shl    $0x2,%eax
  80061b:	01 c8                	add    %ecx,%eax
  80061d:	05 00 00 00 80       	add    $0x80000000,%eax
  800622:	39 c2                	cmp    %eax,%edx
  800624:	72 21                	jb     800647 <_main+0x60f>
  800626:	8b 85 74 fe ff ff    	mov    -0x18c(%ebp),%eax
  80062c:	89 c2                	mov    %eax,%edx
  80062e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800631:	c1 e0 02             	shl    $0x2,%eax
  800634:	89 c1                	mov    %eax,%ecx
  800636:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800639:	c1 e0 02             	shl    $0x2,%eax
  80063c:	01 c8                	add    %ecx,%eax
  80063e:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800643:	39 c2                	cmp    %eax,%edx
  800645:	76 14                	jbe    80065b <_main+0x623>
  800647:	83 ec 04             	sub    $0x4,%esp
  80064a:	68 30 37 80 00       	push   $0x803730
  80064f:	6a 7a                	push   $0x7a
  800651:	68 1c 37 80 00       	push   $0x80371c
  800656:	e8 7a 13 00 00       	call   8019d5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80065b:	e8 af 29 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800660:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800663:	83 f8 01             	cmp    $0x1,%eax
  800666:	74 14                	je     80067c <_main+0x644>
  800668:	83 ec 04             	sub    $0x4,%esp
  80066b:	68 98 37 80 00       	push   $0x803798
  800670:	6a 7b                	push   $0x7b
  800672:	68 1c 37 80 00       	push   $0x80371c
  800677:	e8 59 13 00 00       	call   8019d5 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80067c:	e8 8e 29 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800681:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800684:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800687:	89 d0                	mov    %edx,%eax
  800689:	01 c0                	add    %eax,%eax
  80068b:	01 d0                	add    %edx,%eax
  80068d:	01 c0                	add    %eax,%eax
  80068f:	01 d0                	add    %edx,%eax
  800691:	83 ec 0c             	sub    $0xc,%esp
  800694:	50                   	push   %eax
  800695:	e8 7c 23 00 00       	call   802a16 <malloc>
  80069a:	83 c4 10             	add    $0x10,%esp
  80069d:	89 85 78 fe ff ff    	mov    %eax,-0x188(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8006a3:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  8006a9:	89 c2                	mov    %eax,%edx
  8006ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006ae:	c1 e0 02             	shl    $0x2,%eax
  8006b1:	89 c1                	mov    %eax,%ecx
  8006b3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006b6:	c1 e0 03             	shl    $0x3,%eax
  8006b9:	01 c8                	add    %ecx,%eax
  8006bb:	05 00 00 00 80       	add    $0x80000000,%eax
  8006c0:	39 c2                	cmp    %eax,%edx
  8006c2:	72 21                	jb     8006e5 <_main+0x6ad>
  8006c4:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  8006ca:	89 c2                	mov    %eax,%edx
  8006cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006cf:	c1 e0 02             	shl    $0x2,%eax
  8006d2:	89 c1                	mov    %eax,%ecx
  8006d4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006d7:	c1 e0 03             	shl    $0x3,%eax
  8006da:	01 c8                	add    %ecx,%eax
  8006dc:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8006e1:	39 c2                	cmp    %eax,%edx
  8006e3:	76 17                	jbe    8006fc <_main+0x6c4>
  8006e5:	83 ec 04             	sub    $0x4,%esp
  8006e8:	68 30 37 80 00       	push   $0x803730
  8006ed:	68 81 00 00 00       	push   $0x81
  8006f2:	68 1c 37 80 00       	push   $0x80371c
  8006f7:	e8 d9 12 00 00       	call   8019d5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8006fc:	e8 0e 29 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800701:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800704:	83 f8 02             	cmp    $0x2,%eax
  800707:	74 17                	je     800720 <_main+0x6e8>
  800709:	83 ec 04             	sub    $0x4,%esp
  80070c:	68 98 37 80 00       	push   $0x803798
  800711:	68 82 00 00 00       	push   $0x82
  800716:	68 1c 37 80 00       	push   $0x80371c
  80071b:	e8 b5 12 00 00       	call   8019d5 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800720:	e8 67 28 00 00       	call   802f8c <sys_calculate_free_frames>
  800725:	89 45 c0             	mov    %eax,-0x40(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  800728:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  80072e:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  800734:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800737:	89 d0                	mov    %edx,%eax
  800739:	01 c0                	add    %eax,%eax
  80073b:	01 d0                	add    %edx,%eax
  80073d:	01 c0                	add    %eax,%eax
  80073f:	01 d0                	add    %edx,%eax
  800741:	c1 e8 03             	shr    $0x3,%eax
  800744:	48                   	dec    %eax
  800745:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  80074b:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800751:	8a 55 db             	mov    -0x25(%ebp),%dl
  800754:	88 10                	mov    %dl,(%eax)
  800756:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
  80075c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80075f:	66 89 42 02          	mov    %ax,0x2(%edx)
  800763:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800769:	8b 55 d0             	mov    -0x30(%ebp),%edx
  80076c:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  80076f:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800775:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80077c:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800782:	01 c2                	add    %eax,%edx
  800784:	8a 45 da             	mov    -0x26(%ebp),%al
  800787:	88 02                	mov    %al,(%edx)
  800789:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80078f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800796:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80079c:	01 c2                	add    %eax,%edx
  80079e:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  8007a2:	66 89 42 02          	mov    %ax,0x2(%edx)
  8007a6:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8007ac:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007b3:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8007b9:	01 c2                	add    %eax,%edx
  8007bb:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8007be:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007c1:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8007c4:	e8 c3 27 00 00       	call   802f8c <sys_calculate_free_frames>
  8007c9:	29 c3                	sub    %eax,%ebx
  8007cb:	89 d8                	mov    %ebx,%eax
  8007cd:	83 f8 02             	cmp    $0x2,%eax
  8007d0:	74 17                	je     8007e9 <_main+0x7b1>
  8007d2:	83 ec 04             	sub    $0x4,%esp
  8007d5:	68 c8 37 80 00       	push   $0x8037c8
  8007da:	68 89 00 00 00       	push   $0x89
  8007df:	68 1c 37 80 00       	push   $0x80371c
  8007e4:	e8 ec 11 00 00       	call   8019d5 <_panic>
		found = 0;
  8007e9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8007f0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8007f7:	e9 ac 00 00 00       	jmp    8008a8 <_main+0x870>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  8007fc:	a1 20 40 80 00       	mov    0x804020,%eax
  800801:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800807:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80080a:	89 d0                	mov    %edx,%eax
  80080c:	c1 e0 02             	shl    $0x2,%eax
  80080f:	01 d0                	add    %edx,%eax
  800811:	c1 e0 02             	shl    $0x2,%eax
  800814:	01 c8                	add    %ecx,%eax
  800816:	8b 00                	mov    (%eax),%eax
  800818:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  80081e:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800824:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800829:	89 c2                	mov    %eax,%edx
  80082b:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800831:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800837:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  80083d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800842:	39 c2                	cmp    %eax,%edx
  800844:	75 03                	jne    800849 <_main+0x811>
				found++;
  800846:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  800849:	a1 20 40 80 00       	mov    0x804020,%eax
  80084e:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800854:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800857:	89 d0                	mov    %edx,%eax
  800859:	c1 e0 02             	shl    $0x2,%eax
  80085c:	01 d0                	add    %edx,%eax
  80085e:	c1 e0 02             	shl    $0x2,%eax
  800861:	01 c8                	add    %ecx,%eax
  800863:	8b 00                	mov    (%eax),%eax
  800865:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  80086b:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800871:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800876:	89 c2                	mov    %eax,%edx
  800878:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80087e:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800885:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80088b:	01 c8                	add    %ecx,%eax
  80088d:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  800893:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800899:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80089e:	39 c2                	cmp    %eax,%edx
  8008a0:	75 03                	jne    8008a5 <_main+0x86d>
				found++;
  8008a2:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8008a5:	ff 45 ec             	incl   -0x14(%ebp)
  8008a8:	a1 20 40 80 00       	mov    0x804020,%eax
  8008ad:	8b 50 74             	mov    0x74(%eax),%edx
  8008b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008b3:	39 c2                	cmp    %eax,%edx
  8008b5:	0f 87 41 ff ff ff    	ja     8007fc <_main+0x7c4>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8008bb:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8008bf:	74 17                	je     8008d8 <_main+0x8a0>
  8008c1:	83 ec 04             	sub    $0x4,%esp
  8008c4:	68 0c 38 80 00       	push   $0x80380c
  8008c9:	68 92 00 00 00       	push   $0x92
  8008ce:	68 1c 37 80 00       	push   $0x80371c
  8008d3:	e8 fd 10 00 00       	call   8019d5 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8008d8:	e8 af 26 00 00       	call   802f8c <sys_calculate_free_frames>
  8008dd:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008e0:	e8 2a 27 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  8008e5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8008e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008eb:	89 c2                	mov    %eax,%edx
  8008ed:	01 d2                	add    %edx,%edx
  8008ef:	01 d0                	add    %edx,%eax
  8008f1:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008f4:	83 ec 0c             	sub    $0xc,%esp
  8008f7:	50                   	push   %eax
  8008f8:	e8 19 21 00 00       	call   802a16 <malloc>
  8008fd:	83 c4 10             	add    $0x10,%esp
  800900:	89 85 7c fe ff ff    	mov    %eax,-0x184(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800906:	8b 85 7c fe ff ff    	mov    -0x184(%ebp),%eax
  80090c:	89 c2                	mov    %eax,%edx
  80090e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800911:	c1 e0 02             	shl    $0x2,%eax
  800914:	89 c1                	mov    %eax,%ecx
  800916:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800919:	c1 e0 04             	shl    $0x4,%eax
  80091c:	01 c8                	add    %ecx,%eax
  80091e:	05 00 00 00 80       	add    $0x80000000,%eax
  800923:	39 c2                	cmp    %eax,%edx
  800925:	72 21                	jb     800948 <_main+0x910>
  800927:	8b 85 7c fe ff ff    	mov    -0x184(%ebp),%eax
  80092d:	89 c2                	mov    %eax,%edx
  80092f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800932:	c1 e0 02             	shl    $0x2,%eax
  800935:	89 c1                	mov    %eax,%ecx
  800937:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80093a:	c1 e0 04             	shl    $0x4,%eax
  80093d:	01 c8                	add    %ecx,%eax
  80093f:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800944:	39 c2                	cmp    %eax,%edx
  800946:	76 17                	jbe    80095f <_main+0x927>
  800948:	83 ec 04             	sub    $0x4,%esp
  80094b:	68 30 37 80 00       	push   $0x803730
  800950:	68 98 00 00 00       	push   $0x98
  800955:	68 1c 37 80 00       	push   $0x80371c
  80095a:	e8 76 10 00 00       	call   8019d5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  80095f:	e8 ab 26 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800964:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800967:	89 c2                	mov    %eax,%edx
  800969:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80096c:	89 c1                	mov    %eax,%ecx
  80096e:	01 c9                	add    %ecx,%ecx
  800970:	01 c8                	add    %ecx,%eax
  800972:	85 c0                	test   %eax,%eax
  800974:	79 05                	jns    80097b <_main+0x943>
  800976:	05 ff 0f 00 00       	add    $0xfff,%eax
  80097b:	c1 f8 0c             	sar    $0xc,%eax
  80097e:	39 c2                	cmp    %eax,%edx
  800980:	74 17                	je     800999 <_main+0x961>
  800982:	83 ec 04             	sub    $0x4,%esp
  800985:	68 98 37 80 00       	push   $0x803798
  80098a:	68 99 00 00 00       	push   $0x99
  80098f:	68 1c 37 80 00       	push   $0x80371c
  800994:	e8 3c 10 00 00       	call   8019d5 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800999:	e8 71 26 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  80099e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  8009a1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009a4:	89 d0                	mov    %edx,%eax
  8009a6:	01 c0                	add    %eax,%eax
  8009a8:	01 d0                	add    %edx,%eax
  8009aa:	01 c0                	add    %eax,%eax
  8009ac:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8009af:	83 ec 0c             	sub    $0xc,%esp
  8009b2:	50                   	push   %eax
  8009b3:	e8 5e 20 00 00       	call   802a16 <malloc>
  8009b8:	83 c4 10             	add    $0x10,%esp
  8009bb:	89 85 80 fe ff ff    	mov    %eax,-0x180(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8009c1:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8009c7:	89 c1                	mov    %eax,%ecx
  8009c9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009cc:	89 d0                	mov    %edx,%eax
  8009ce:	01 c0                	add    %eax,%eax
  8009d0:	01 d0                	add    %edx,%eax
  8009d2:	01 c0                	add    %eax,%eax
  8009d4:	01 d0                	add    %edx,%eax
  8009d6:	89 c2                	mov    %eax,%edx
  8009d8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009db:	c1 e0 04             	shl    $0x4,%eax
  8009de:	01 d0                	add    %edx,%eax
  8009e0:	05 00 00 00 80       	add    $0x80000000,%eax
  8009e5:	39 c1                	cmp    %eax,%ecx
  8009e7:	72 28                	jb     800a11 <_main+0x9d9>
  8009e9:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8009ef:	89 c1                	mov    %eax,%ecx
  8009f1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009f4:	89 d0                	mov    %edx,%eax
  8009f6:	01 c0                	add    %eax,%eax
  8009f8:	01 d0                	add    %edx,%eax
  8009fa:	01 c0                	add    %eax,%eax
  8009fc:	01 d0                	add    %edx,%eax
  8009fe:	89 c2                	mov    %eax,%edx
  800a00:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a03:	c1 e0 04             	shl    $0x4,%eax
  800a06:	01 d0                	add    %edx,%eax
  800a08:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800a0d:	39 c1                	cmp    %eax,%ecx
  800a0f:	76 17                	jbe    800a28 <_main+0x9f0>
  800a11:	83 ec 04             	sub    $0x4,%esp
  800a14:	68 30 37 80 00       	push   $0x803730
  800a19:	68 9f 00 00 00       	push   $0x9f
  800a1e:	68 1c 37 80 00       	push   $0x80371c
  800a23:	e8 ad 0f 00 00       	call   8019d5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800a28:	e8 e2 25 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800a2d:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800a30:	89 c1                	mov    %eax,%ecx
  800a32:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a35:	89 d0                	mov    %edx,%eax
  800a37:	01 c0                	add    %eax,%eax
  800a39:	01 d0                	add    %edx,%eax
  800a3b:	01 c0                	add    %eax,%eax
  800a3d:	85 c0                	test   %eax,%eax
  800a3f:	79 05                	jns    800a46 <_main+0xa0e>
  800a41:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a46:	c1 f8 0c             	sar    $0xc,%eax
  800a49:	39 c1                	cmp    %eax,%ecx
  800a4b:	74 17                	je     800a64 <_main+0xa2c>
  800a4d:	83 ec 04             	sub    $0x4,%esp
  800a50:	68 98 37 80 00       	push   $0x803798
  800a55:	68 a0 00 00 00       	push   $0xa0
  800a5a:	68 1c 37 80 00       	push   $0x80371c
  800a5f:	e8 71 0f 00 00       	call   8019d5 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800a64:	e8 23 25 00 00       	call   802f8c <sys_calculate_free_frames>
  800a69:	89 45 c0             	mov    %eax,-0x40(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  800a6c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a6f:	89 d0                	mov    %edx,%eax
  800a71:	01 c0                	add    %eax,%eax
  800a73:	01 d0                	add    %edx,%eax
  800a75:	01 c0                	add    %eax,%eax
  800a77:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800a7a:	48                   	dec    %eax
  800a7b:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800a81:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  800a87:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
		byteArr2[0] = minByte ;
  800a8d:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800a93:	8a 55 db             	mov    -0x25(%ebp),%dl
  800a96:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800a98:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800a9e:	89 c2                	mov    %eax,%edx
  800aa0:	c1 ea 1f             	shr    $0x1f,%edx
  800aa3:	01 d0                	add    %edx,%eax
  800aa5:	d1 f8                	sar    %eax
  800aa7:	89 c2                	mov    %eax,%edx
  800aa9:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800aaf:	01 c2                	add    %eax,%edx
  800ab1:	8a 45 da             	mov    -0x26(%ebp),%al
  800ab4:	88 c1                	mov    %al,%cl
  800ab6:	c0 e9 07             	shr    $0x7,%cl
  800ab9:	01 c8                	add    %ecx,%eax
  800abb:	d0 f8                	sar    %al
  800abd:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  800abf:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
  800ac5:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800acb:	01 c2                	add    %eax,%edx
  800acd:	8a 45 da             	mov    -0x26(%ebp),%al
  800ad0:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800ad2:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800ad5:	e8 b2 24 00 00       	call   802f8c <sys_calculate_free_frames>
  800ada:	29 c3                	sub    %eax,%ebx
  800adc:	89 d8                	mov    %ebx,%eax
  800ade:	83 f8 05             	cmp    $0x5,%eax
  800ae1:	74 17                	je     800afa <_main+0xac2>
  800ae3:	83 ec 04             	sub    $0x4,%esp
  800ae6:	68 c8 37 80 00       	push   $0x8037c8
  800aeb:	68 a8 00 00 00       	push   $0xa8
  800af0:	68 1c 37 80 00       	push   $0x80371c
  800af5:	e8 db 0e 00 00       	call   8019d5 <_panic>
		found = 0;
  800afa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800b01:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800b08:	e9 05 01 00 00       	jmp    800c12 <_main+0xbda>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800b0d:	a1 20 40 80 00       	mov    0x804020,%eax
  800b12:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800b18:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b1b:	89 d0                	mov    %edx,%eax
  800b1d:	c1 e0 02             	shl    $0x2,%eax
  800b20:	01 d0                	add    %edx,%eax
  800b22:	c1 e0 02             	shl    $0x2,%eax
  800b25:	01 c8                	add    %ecx,%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800b2f:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b35:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b3a:	89 c2                	mov    %eax,%edx
  800b3c:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b42:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b48:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b4e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b53:	39 c2                	cmp    %eax,%edx
  800b55:	75 03                	jne    800b5a <_main+0xb22>
				found++;
  800b57:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800b5a:	a1 20 40 80 00       	mov    0x804020,%eax
  800b5f:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800b65:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b68:	89 d0                	mov    %edx,%eax
  800b6a:	c1 e0 02             	shl    $0x2,%eax
  800b6d:	01 d0                	add    %edx,%eax
  800b6f:	c1 e0 02             	shl    $0x2,%eax
  800b72:	01 c8                	add    %ecx,%eax
  800b74:	8b 00                	mov    (%eax),%eax
  800b76:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b7c:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b87:	89 c2                	mov    %eax,%edx
  800b89:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800b8f:	89 c1                	mov    %eax,%ecx
  800b91:	c1 e9 1f             	shr    $0x1f,%ecx
  800b94:	01 c8                	add    %ecx,%eax
  800b96:	d1 f8                	sar    %eax
  800b98:	89 c1                	mov    %eax,%ecx
  800b9a:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800ba0:	01 c8                	add    %ecx,%eax
  800ba2:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800ba8:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800bae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bb3:	39 c2                	cmp    %eax,%edx
  800bb5:	75 03                	jne    800bba <_main+0xb82>
				found++;
  800bb7:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800bba:	a1 20 40 80 00       	mov    0x804020,%eax
  800bbf:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800bc5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800bc8:	89 d0                	mov    %edx,%eax
  800bca:	c1 e0 02             	shl    $0x2,%eax
  800bcd:	01 d0                	add    %edx,%eax
  800bcf:	c1 e0 02             	shl    $0x2,%eax
  800bd2:	01 c8                	add    %ecx,%eax
  800bd4:	8b 00                	mov    (%eax),%eax
  800bd6:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800bdc:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800be2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800be7:	89 c1                	mov    %eax,%ecx
  800be9:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
  800bef:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800bf5:	01 d0                	add    %edx,%eax
  800bf7:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800bfd:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800c03:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c08:	39 c1                	cmp    %eax,%ecx
  800c0a:	75 03                	jne    800c0f <_main+0xbd7>
				found++;
  800c0c:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800c0f:	ff 45 ec             	incl   -0x14(%ebp)
  800c12:	a1 20 40 80 00       	mov    0x804020,%eax
  800c17:	8b 50 74             	mov    0x74(%eax),%edx
  800c1a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c1d:	39 c2                	cmp    %eax,%edx
  800c1f:	0f 87 e8 fe ff ff    	ja     800b0d <_main+0xad5>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  800c25:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  800c29:	74 17                	je     800c42 <_main+0xc0a>
  800c2b:	83 ec 04             	sub    $0x4,%esp
  800c2e:	68 0c 38 80 00       	push   $0x80380c
  800c33:	68 b3 00 00 00       	push   $0xb3
  800c38:	68 1c 37 80 00       	push   $0x80371c
  800c3d:	e8 93 0d 00 00       	call   8019d5 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c42:	e8 c8 23 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800c47:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  800c4a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800c4d:	89 d0                	mov    %edx,%eax
  800c4f:	01 c0                	add    %eax,%eax
  800c51:	01 d0                	add    %edx,%eax
  800c53:	01 c0                	add    %eax,%eax
  800c55:	01 d0                	add    %edx,%eax
  800c57:	01 c0                	add    %eax,%eax
  800c59:	83 ec 0c             	sub    $0xc,%esp
  800c5c:	50                   	push   %eax
  800c5d:	e8 b4 1d 00 00       	call   802a16 <malloc>
  800c62:	83 c4 10             	add    $0x10,%esp
  800c65:	89 85 84 fe ff ff    	mov    %eax,-0x17c(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800c6b:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800c71:	89 c1                	mov    %eax,%ecx
  800c73:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c76:	89 d0                	mov    %edx,%eax
  800c78:	01 c0                	add    %eax,%eax
  800c7a:	01 d0                	add    %edx,%eax
  800c7c:	c1 e0 02             	shl    $0x2,%eax
  800c7f:	01 d0                	add    %edx,%eax
  800c81:	89 c2                	mov    %eax,%edx
  800c83:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800c86:	c1 e0 04             	shl    $0x4,%eax
  800c89:	01 d0                	add    %edx,%eax
  800c8b:	05 00 00 00 80       	add    $0x80000000,%eax
  800c90:	39 c1                	cmp    %eax,%ecx
  800c92:	72 29                	jb     800cbd <_main+0xc85>
  800c94:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800c9a:	89 c1                	mov    %eax,%ecx
  800c9c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c9f:	89 d0                	mov    %edx,%eax
  800ca1:	01 c0                	add    %eax,%eax
  800ca3:	01 d0                	add    %edx,%eax
  800ca5:	c1 e0 02             	shl    $0x2,%eax
  800ca8:	01 d0                	add    %edx,%eax
  800caa:	89 c2                	mov    %eax,%edx
  800cac:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800caf:	c1 e0 04             	shl    $0x4,%eax
  800cb2:	01 d0                	add    %edx,%eax
  800cb4:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800cb9:	39 c1                	cmp    %eax,%ecx
  800cbb:	76 17                	jbe    800cd4 <_main+0xc9c>
  800cbd:	83 ec 04             	sub    $0x4,%esp
  800cc0:	68 30 37 80 00       	push   $0x803730
  800cc5:	68 b8 00 00 00       	push   $0xb8
  800cca:	68 1c 37 80 00       	push   $0x80371c
  800ccf:	e8 01 0d 00 00       	call   8019d5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800cd4:	e8 36 23 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800cd9:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800cdc:	83 f8 04             	cmp    $0x4,%eax
  800cdf:	74 17                	je     800cf8 <_main+0xcc0>
  800ce1:	83 ec 04             	sub    $0x4,%esp
  800ce4:	68 98 37 80 00       	push   $0x803798
  800ce9:	68 b9 00 00 00       	push   $0xb9
  800cee:	68 1c 37 80 00       	push   $0x80371c
  800cf3:	e8 dd 0c 00 00       	call   8019d5 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800cf8:	e8 8f 22 00 00       	call   802f8c <sys_calculate_free_frames>
  800cfd:	89 45 c0             	mov    %eax,-0x40(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800d00:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800d06:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  800d0c:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800d0f:	89 d0                	mov    %edx,%eax
  800d11:	01 c0                	add    %eax,%eax
  800d13:	01 d0                	add    %edx,%eax
  800d15:	01 c0                	add    %eax,%eax
  800d17:	01 d0                	add    %edx,%eax
  800d19:	01 c0                	add    %eax,%eax
  800d1b:	d1 e8                	shr    %eax
  800d1d:	48                   	dec    %eax
  800d1e:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
		shortArr2[0] = minShort;
  800d24:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  800d2a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d2d:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800d30:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d36:	01 c0                	add    %eax,%eax
  800d38:	89 c2                	mov    %eax,%edx
  800d3a:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800d40:	01 c2                	add    %eax,%edx
  800d42:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800d46:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800d49:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800d4c:	e8 3b 22 00 00       	call   802f8c <sys_calculate_free_frames>
  800d51:	29 c3                	sub    %eax,%ebx
  800d53:	89 d8                	mov    %ebx,%eax
  800d55:	83 f8 02             	cmp    $0x2,%eax
  800d58:	74 17                	je     800d71 <_main+0xd39>
  800d5a:	83 ec 04             	sub    $0x4,%esp
  800d5d:	68 c8 37 80 00       	push   $0x8037c8
  800d62:	68 c0 00 00 00       	push   $0xc0
  800d67:	68 1c 37 80 00       	push   $0x80371c
  800d6c:	e8 64 0c 00 00       	call   8019d5 <_panic>
		found = 0;
  800d71:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d78:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800d7f:	e9 a9 00 00 00       	jmp    800e2d <_main+0xdf5>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800d84:	a1 20 40 80 00       	mov    0x804020,%eax
  800d89:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800d8f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d92:	89 d0                	mov    %edx,%eax
  800d94:	c1 e0 02             	shl    $0x2,%eax
  800d97:	01 d0                	add    %edx,%eax
  800d99:	c1 e0 02             	shl    $0x2,%eax
  800d9c:	01 c8                	add    %ecx,%eax
  800d9e:	8b 00                	mov    (%eax),%eax
  800da0:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800da6:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800dac:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800db1:	89 c2                	mov    %eax,%edx
  800db3:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800db9:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800dbf:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800dc5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dca:	39 c2                	cmp    %eax,%edx
  800dcc:	75 03                	jne    800dd1 <_main+0xd99>
				found++;
  800dce:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800dd1:	a1 20 40 80 00       	mov    0x804020,%eax
  800dd6:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800ddc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ddf:	89 d0                	mov    %edx,%eax
  800de1:	c1 e0 02             	shl    $0x2,%eax
  800de4:	01 d0                	add    %edx,%eax
  800de6:	c1 e0 02             	shl    $0x2,%eax
  800de9:	01 c8                	add    %ecx,%eax
  800deb:	8b 00                	mov    (%eax),%eax
  800ded:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800df3:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800df9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dfe:	89 c2                	mov    %eax,%edx
  800e00:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800e06:	01 c0                	add    %eax,%eax
  800e08:	89 c1                	mov    %eax,%ecx
  800e0a:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800e10:	01 c8                	add    %ecx,%eax
  800e12:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  800e18:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  800e1e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e23:	39 c2                	cmp    %eax,%edx
  800e25:	75 03                	jne    800e2a <_main+0xdf2>
				found++;
  800e27:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800e2a:	ff 45 ec             	incl   -0x14(%ebp)
  800e2d:	a1 20 40 80 00       	mov    0x804020,%eax
  800e32:	8b 50 74             	mov    0x74(%eax),%edx
  800e35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e38:	39 c2                	cmp    %eax,%edx
  800e3a:	0f 87 44 ff ff ff    	ja     800d84 <_main+0xd4c>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800e40:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800e44:	74 17                	je     800e5d <_main+0xe25>
  800e46:	83 ec 04             	sub    $0x4,%esp
  800e49:	68 0c 38 80 00       	push   $0x80380c
  800e4e:	68 c9 00 00 00       	push   $0xc9
  800e53:	68 1c 37 80 00       	push   $0x80371c
  800e58:	e8 78 0b 00 00       	call   8019d5 <_panic>
	}

	{
		//Free 1st 2 MB
		int freeFrames = sys_calculate_free_frames() ;
  800e5d:	e8 2a 21 00 00       	call   802f8c <sys_calculate_free_frames>
  800e62:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e68:	e8 a2 21 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800e6d:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[0]);
  800e73:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800e79:	83 ec 0c             	sub    $0xc,%esp
  800e7c:	50                   	push   %eax
  800e7d:	e8 59 1e 00 00       	call   802cdb <free>
  800e82:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800e85:	e8 85 21 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800e8a:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  800e90:	29 c2                	sub    %eax,%edx
  800e92:	89 d0                	mov    %edx,%eax
  800e94:	3d 00 02 00 00       	cmp    $0x200,%eax
  800e99:	74 17                	je     800eb2 <_main+0xe7a>
  800e9b:	83 ec 04             	sub    $0x4,%esp
  800e9e:	68 2c 38 80 00       	push   $0x80382c
  800ea3:	68 d1 00 00 00       	push   $0xd1
  800ea8:	68 1c 37 80 00       	push   $0x80371c
  800ead:	e8 23 0b 00 00       	call   8019d5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800eb2:	e8 d5 20 00 00       	call   802f8c <sys_calculate_free_frames>
  800eb7:	89 c2                	mov    %eax,%edx
  800eb9:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800ebf:	29 c2                	sub    %eax,%edx
  800ec1:	89 d0                	mov    %edx,%eax
  800ec3:	83 f8 02             	cmp    $0x2,%eax
  800ec6:	74 17                	je     800edf <_main+0xea7>
  800ec8:	83 ec 04             	sub    $0x4,%esp
  800ecb:	68 68 38 80 00       	push   $0x803868
  800ed0:	68 d2 00 00 00       	push   $0xd2
  800ed5:	68 1c 37 80 00       	push   $0x80371c
  800eda:	e8 f6 0a 00 00       	call   8019d5 <_panic>
		int var;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800edf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800ee6:	e9 c4 00 00 00       	jmp    800faf <_main+0xf77>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  800eeb:	a1 20 40 80 00       	mov    0x804020,%eax
  800ef0:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800ef6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ef9:	89 d0                	mov    %edx,%eax
  800efb:	c1 e0 02             	shl    $0x2,%eax
  800efe:	01 d0                	add    %edx,%eax
  800f00:	c1 e0 02             	shl    $0x2,%eax
  800f03:	01 c8                	add    %ecx,%eax
  800f05:	8b 00                	mov    (%eax),%eax
  800f07:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
  800f0d:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  800f13:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f18:	89 c2                	mov    %eax,%edx
  800f1a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800f1d:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  800f23:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  800f29:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f2e:	39 c2                	cmp    %eax,%edx
  800f30:	75 17                	jne    800f49 <_main+0xf11>
				panic("free: page is not removed from WS");
  800f32:	83 ec 04             	sub    $0x4,%esp
  800f35:	68 b4 38 80 00       	push   $0x8038b4
  800f3a:	68 d7 00 00 00       	push   $0xd7
  800f3f:	68 1c 37 80 00       	push   $0x80371c
  800f44:	e8 8c 0a 00 00       	call   8019d5 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  800f49:	a1 20 40 80 00       	mov    0x804020,%eax
  800f4e:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800f54:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800f57:	89 d0                	mov    %edx,%eax
  800f59:	c1 e0 02             	shl    $0x2,%eax
  800f5c:	01 d0                	add    %edx,%eax
  800f5e:	c1 e0 02             	shl    $0x2,%eax
  800f61:	01 c8                	add    %ecx,%eax
  800f63:	8b 00                	mov    (%eax),%eax
  800f65:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  800f6b:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  800f71:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f76:	89 c1                	mov    %eax,%ecx
  800f78:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800f7b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800f7e:	01 d0                	add    %edx,%eax
  800f80:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
  800f86:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  800f8c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f91:	39 c1                	cmp    %eax,%ecx
  800f93:	75 17                	jne    800fac <_main+0xf74>
				panic("free: page is not removed from WS");
  800f95:	83 ec 04             	sub    $0x4,%esp
  800f98:	68 b4 38 80 00       	push   $0x8038b4
  800f9d:	68 d9 00 00 00       	push   $0xd9
  800fa2:	68 1c 37 80 00       	push   $0x80371c
  800fa7:	e8 29 0a 00 00       	call   8019d5 <_panic>
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[0]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		int var;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800fac:	ff 45 e4             	incl   -0x1c(%ebp)
  800faf:	a1 20 40 80 00       	mov    0x804020,%eax
  800fb4:	8b 50 74             	mov    0x74(%eax),%edx
  800fb7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800fba:	39 c2                	cmp    %eax,%edx
  800fbc:	0f 87 29 ff ff ff    	ja     800eeb <_main+0xeb3>
				panic("free: page is not removed from WS");
		}


		//Free 2nd 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800fc2:	e8 c5 1f 00 00       	call   802f8c <sys_calculate_free_frames>
  800fc7:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800fcd:	e8 3d 20 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800fd2:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[1]);
  800fd8:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  800fde:	83 ec 0c             	sub    $0xc,%esp
  800fe1:	50                   	push   %eax
  800fe2:	e8 f4 1c 00 00       	call   802cdb <free>
  800fe7:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800fea:	e8 20 20 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  800fef:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  800ff5:	29 c2                	sub    %eax,%edx
  800ff7:	89 d0                	mov    %edx,%eax
  800ff9:	3d 00 02 00 00       	cmp    $0x200,%eax
  800ffe:	74 17                	je     801017 <_main+0xfdf>
  801000:	83 ec 04             	sub    $0x4,%esp
  801003:	68 2c 38 80 00       	push   $0x80382c
  801008:	68 e1 00 00 00       	push   $0xe1
  80100d:	68 1c 37 80 00       	push   $0x80371c
  801012:	e8 be 09 00 00       	call   8019d5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801017:	e8 70 1f 00 00       	call   802f8c <sys_calculate_free_frames>
  80101c:	89 c2                	mov    %eax,%edx
  80101e:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  801024:	29 c2                	sub    %eax,%edx
  801026:	89 d0                	mov    %edx,%eax
  801028:	83 f8 03             	cmp    $0x3,%eax
  80102b:	74 17                	je     801044 <_main+0x100c>
  80102d:	83 ec 04             	sub    $0x4,%esp
  801030:	68 68 38 80 00       	push   $0x803868
  801035:	68 e2 00 00 00       	push   $0xe2
  80103a:	68 1c 37 80 00       	push   $0x80371c
  80103f:	e8 91 09 00 00       	call   8019d5 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801044:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80104b:	e9 c8 00 00 00       	jmp    801118 <_main+0x10e0>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  801050:	a1 20 40 80 00       	mov    0x804020,%eax
  801055:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80105b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80105e:	89 d0                	mov    %edx,%eax
  801060:	c1 e0 02             	shl    $0x2,%eax
  801063:	01 d0                	add    %edx,%eax
  801065:	c1 e0 02             	shl    $0x2,%eax
  801068:	01 c8                	add    %ecx,%eax
  80106a:	8b 00                	mov    (%eax),%eax
  80106c:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
  801072:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  801078:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80107d:	89 c2                	mov    %eax,%edx
  80107f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  801082:	89 85 08 ff ff ff    	mov    %eax,-0xf8(%ebp)
  801088:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
  80108e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801093:	39 c2                	cmp    %eax,%edx
  801095:	75 17                	jne    8010ae <_main+0x1076>
				panic("free: page is not removed from WS");
  801097:	83 ec 04             	sub    $0x4,%esp
  80109a:	68 b4 38 80 00       	push   $0x8038b4
  80109f:	68 e6 00 00 00       	push   $0xe6
  8010a4:	68 1c 37 80 00       	push   $0x80371c
  8010a9:	e8 27 09 00 00       	call   8019d5 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  8010ae:	a1 20 40 80 00       	mov    0x804020,%eax
  8010b3:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8010b9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8010bc:	89 d0                	mov    %edx,%eax
  8010be:	c1 e0 02             	shl    $0x2,%eax
  8010c1:	01 d0                	add    %edx,%eax
  8010c3:	c1 e0 02             	shl    $0x2,%eax
  8010c6:	01 c8                	add    %ecx,%eax
  8010c8:	8b 00                	mov    (%eax),%eax
  8010ca:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  8010d0:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
  8010d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010db:	89 c2                	mov    %eax,%edx
  8010dd:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8010e0:	01 c0                	add    %eax,%eax
  8010e2:	89 c1                	mov    %eax,%ecx
  8010e4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8010e7:	01 c8                	add    %ecx,%eax
  8010e9:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  8010ef:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
  8010f5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010fa:	39 c2                	cmp    %eax,%edx
  8010fc:	75 17                	jne    801115 <_main+0x10dd>
				panic("free: page is not removed from WS");
  8010fe:	83 ec 04             	sub    $0x4,%esp
  801101:	68 b4 38 80 00       	push   $0x8038b4
  801106:	68 e8 00 00 00       	push   $0xe8
  80110b:	68 1c 37 80 00       	push   $0x80371c
  801110:	e8 c0 08 00 00       	call   8019d5 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[1]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801115:	ff 45 e4             	incl   -0x1c(%ebp)
  801118:	a1 20 40 80 00       	mov    0x804020,%eax
  80111d:	8b 50 74             	mov    0x74(%eax),%edx
  801120:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801123:	39 c2                	cmp    %eax,%edx
  801125:	0f 87 25 ff ff ff    	ja     801050 <_main+0x1018>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 6 MB
		freeFrames = sys_calculate_free_frames() ;
  80112b:	e8 5c 1e 00 00       	call   802f8c <sys_calculate_free_frames>
  801130:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801136:	e8 d4 1e 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  80113b:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[6]);
  801141:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  801147:	83 ec 0c             	sub    $0xc,%esp
  80114a:	50                   	push   %eax
  80114b:	e8 8b 1b 00 00       	call   802cdb <free>
  801150:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  801153:	e8 b7 1e 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  801158:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  80115e:	89 d1                	mov    %edx,%ecx
  801160:	29 c1                	sub    %eax,%ecx
  801162:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801165:	89 d0                	mov    %edx,%eax
  801167:	01 c0                	add    %eax,%eax
  801169:	01 d0                	add    %edx,%eax
  80116b:	01 c0                	add    %eax,%eax
  80116d:	85 c0                	test   %eax,%eax
  80116f:	79 05                	jns    801176 <_main+0x113e>
  801171:	05 ff 0f 00 00       	add    $0xfff,%eax
  801176:	c1 f8 0c             	sar    $0xc,%eax
  801179:	39 c1                	cmp    %eax,%ecx
  80117b:	74 17                	je     801194 <_main+0x115c>
  80117d:	83 ec 04             	sub    $0x4,%esp
  801180:	68 2c 38 80 00       	push   $0x80382c
  801185:	68 ef 00 00 00       	push   $0xef
  80118a:	68 1c 37 80 00       	push   $0x80371c
  80118f:	e8 41 08 00 00       	call   8019d5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801194:	e8 f3 1d 00 00       	call   802f8c <sys_calculate_free_frames>
  801199:	89 c2                	mov    %eax,%edx
  80119b:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  8011a1:	29 c2                	sub    %eax,%edx
  8011a3:	89 d0                	mov    %edx,%eax
  8011a5:	83 f8 04             	cmp    $0x4,%eax
  8011a8:	74 17                	je     8011c1 <_main+0x1189>
  8011aa:	83 ec 04             	sub    $0x4,%esp
  8011ad:	68 68 38 80 00       	push   $0x803868
  8011b2:	68 f0 00 00 00       	push   $0xf0
  8011b7:	68 1c 37 80 00       	push   $0x80371c
  8011bc:	e8 14 08 00 00       	call   8019d5 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8011c1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8011c8:	e9 41 01 00 00       	jmp    80130e <_main+0x12d6>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  8011cd:	a1 20 40 80 00       	mov    0x804020,%eax
  8011d2:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8011d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8011db:	89 d0                	mov    %edx,%eax
  8011dd:	c1 e0 02             	shl    $0x2,%eax
  8011e0:	01 d0                	add    %edx,%eax
  8011e2:	c1 e0 02             	shl    $0x2,%eax
  8011e5:	01 c8                	add    %ecx,%eax
  8011e7:	8b 00                	mov    (%eax),%eax
  8011e9:	89 85 fc fe ff ff    	mov    %eax,-0x104(%ebp)
  8011ef:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
  8011f5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8011fa:	89 c2                	mov    %eax,%edx
  8011fc:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  801202:	89 85 f8 fe ff ff    	mov    %eax,-0x108(%ebp)
  801208:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  80120e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801213:	39 c2                	cmp    %eax,%edx
  801215:	75 17                	jne    80122e <_main+0x11f6>
				panic("free: page is not removed from WS");
  801217:	83 ec 04             	sub    $0x4,%esp
  80121a:	68 b4 38 80 00       	push   $0x8038b4
  80121f:	68 f4 00 00 00       	push   $0xf4
  801224:	68 1c 37 80 00       	push   $0x80371c
  801229:	e8 a7 07 00 00       	call   8019d5 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  80122e:	a1 20 40 80 00       	mov    0x804020,%eax
  801233:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801239:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80123c:	89 d0                	mov    %edx,%eax
  80123e:	c1 e0 02             	shl    $0x2,%eax
  801241:	01 d0                	add    %edx,%eax
  801243:	c1 e0 02             	shl    $0x2,%eax
  801246:	01 c8                	add    %ecx,%eax
  801248:	8b 00                	mov    (%eax),%eax
  80124a:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
  801250:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  801256:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80125b:	89 c2                	mov    %eax,%edx
  80125d:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  801263:	89 c1                	mov    %eax,%ecx
  801265:	c1 e9 1f             	shr    $0x1f,%ecx
  801268:	01 c8                	add    %ecx,%eax
  80126a:	d1 f8                	sar    %eax
  80126c:	89 c1                	mov    %eax,%ecx
  80126e:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  801274:	01 c8                	add    %ecx,%eax
  801276:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
  80127c:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  801282:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801287:	39 c2                	cmp    %eax,%edx
  801289:	75 17                	jne    8012a2 <_main+0x126a>
				panic("free: page is not removed from WS");
  80128b:	83 ec 04             	sub    $0x4,%esp
  80128e:	68 b4 38 80 00       	push   $0x8038b4
  801293:	68 f6 00 00 00       	push   $0xf6
  801298:	68 1c 37 80 00       	push   $0x80371c
  80129d:	e8 33 07 00 00       	call   8019d5 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  8012a2:	a1 20 40 80 00       	mov    0x804020,%eax
  8012a7:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8012ad:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8012b0:	89 d0                	mov    %edx,%eax
  8012b2:	c1 e0 02             	shl    $0x2,%eax
  8012b5:	01 d0                	add    %edx,%eax
  8012b7:	c1 e0 02             	shl    $0x2,%eax
  8012ba:	01 c8                	add    %ecx,%eax
  8012bc:	8b 00                	mov    (%eax),%eax
  8012be:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  8012c4:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  8012ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8012cf:	89 c1                	mov    %eax,%ecx
  8012d1:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
  8012d7:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  8012dd:	01 d0                	add    %edx,%eax
  8012df:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
  8012e5:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  8012eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8012f0:	39 c1                	cmp    %eax,%ecx
  8012f2:	75 17                	jne    80130b <_main+0x12d3>
				panic("free: page is not removed from WS");
  8012f4:	83 ec 04             	sub    $0x4,%esp
  8012f7:	68 b4 38 80 00       	push   $0x8038b4
  8012fc:	68 f8 00 00 00       	push   $0xf8
  801301:	68 1c 37 80 00       	push   $0x80371c
  801306:	e8 ca 06 00 00       	call   8019d5 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[6]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80130b:	ff 45 e4             	incl   -0x1c(%ebp)
  80130e:	a1 20 40 80 00       	mov    0x804020,%eax
  801313:	8b 50 74             	mov    0x74(%eax),%edx
  801316:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801319:	39 c2                	cmp    %eax,%edx
  80131b:	0f 87 ac fe ff ff    	ja     8011cd <_main+0x1195>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 7 KB
		freeFrames = sys_calculate_free_frames() ;
  801321:	e8 66 1c 00 00       	call   802f8c <sys_calculate_free_frames>
  801326:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80132c:	e8 de 1c 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  801331:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[4]);
  801337:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  80133d:	83 ec 0c             	sub    $0xc,%esp
  801340:	50                   	push   %eax
  801341:	e8 95 19 00 00       	call   802cdb <free>
  801346:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  801349:	e8 c1 1c 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  80134e:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  801354:	29 c2                	sub    %eax,%edx
  801356:	89 d0                	mov    %edx,%eax
  801358:	83 f8 02             	cmp    $0x2,%eax
  80135b:	74 17                	je     801374 <_main+0x133c>
  80135d:	83 ec 04             	sub    $0x4,%esp
  801360:	68 2c 38 80 00       	push   $0x80382c
  801365:	68 ff 00 00 00       	push   $0xff
  80136a:	68 1c 37 80 00       	push   $0x80371c
  80136f:	e8 61 06 00 00       	call   8019d5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801374:	e8 13 1c 00 00       	call   802f8c <sys_calculate_free_frames>
  801379:	89 c2                	mov    %eax,%edx
  80137b:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  801381:	29 c2                	sub    %eax,%edx
  801383:	89 d0                	mov    %edx,%eax
  801385:	83 f8 02             	cmp    $0x2,%eax
  801388:	74 17                	je     8013a1 <_main+0x1369>
  80138a:	83 ec 04             	sub    $0x4,%esp
  80138d:	68 68 38 80 00       	push   $0x803868
  801392:	68 00 01 00 00       	push   $0x100
  801397:	68 1c 37 80 00       	push   $0x80371c
  80139c:	e8 34 06 00 00       	call   8019d5 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8013a1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8013a8:	e9 d4 00 00 00       	jmp    801481 <_main+0x1449>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  8013ad:	a1 20 40 80 00       	mov    0x804020,%eax
  8013b2:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8013b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8013bb:	89 d0                	mov    %edx,%eax
  8013bd:	c1 e0 02             	shl    $0x2,%eax
  8013c0:	01 d0                	add    %edx,%eax
  8013c2:	c1 e0 02             	shl    $0x2,%eax
  8013c5:	01 c8                	add    %ecx,%eax
  8013c7:	8b 00                	mov    (%eax),%eax
  8013c9:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
  8013cf:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  8013d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013da:	89 c2                	mov    %eax,%edx
  8013dc:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8013e2:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
  8013e8:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8013ee:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013f3:	39 c2                	cmp    %eax,%edx
  8013f5:	75 17                	jne    80140e <_main+0x13d6>
				panic("free: page is not removed from WS");
  8013f7:	83 ec 04             	sub    $0x4,%esp
  8013fa:	68 b4 38 80 00       	push   $0x8038b4
  8013ff:	68 04 01 00 00       	push   $0x104
  801404:	68 1c 37 80 00       	push   $0x80371c
  801409:	e8 c7 05 00 00       	call   8019d5 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  80140e:	a1 20 40 80 00       	mov    0x804020,%eax
  801413:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801419:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80141c:	89 d0                	mov    %edx,%eax
  80141e:	c1 e0 02             	shl    $0x2,%eax
  801421:	01 d0                	add    %edx,%eax
  801423:	c1 e0 02             	shl    $0x2,%eax
  801426:	01 c8                	add    %ecx,%eax
  801428:	8b 00                	mov    (%eax),%eax
  80142a:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
  801430:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  801436:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80143b:	89 c2                	mov    %eax,%edx
  80143d:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  801443:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80144a:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  801450:	01 c8                	add    %ecx,%eax
  801452:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
  801458:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  80145e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801463:	39 c2                	cmp    %eax,%edx
  801465:	75 17                	jne    80147e <_main+0x1446>
				panic("free: page is not removed from WS");
  801467:	83 ec 04             	sub    $0x4,%esp
  80146a:	68 b4 38 80 00       	push   $0x8038b4
  80146f:	68 06 01 00 00       	push   $0x106
  801474:	68 1c 37 80 00       	push   $0x80371c
  801479:	e8 57 05 00 00       	call   8019d5 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[4]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80147e:	ff 45 e4             	incl   -0x1c(%ebp)
  801481:	a1 20 40 80 00       	mov    0x804020,%eax
  801486:	8b 50 74             	mov    0x74(%eax),%edx
  801489:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80148c:	39 c2                	cmp    %eax,%edx
  80148e:	0f 87 19 ff ff ff    	ja     8013ad <_main+0x1375>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 3 MB
		freeFrames = sys_calculate_free_frames() ;
  801494:	e8 f3 1a 00 00       	call   802f8c <sys_calculate_free_frames>
  801499:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80149f:	e8 6b 1b 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  8014a4:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[5]);
  8014aa:	8b 85 7c fe ff ff    	mov    -0x184(%ebp),%eax
  8014b0:	83 ec 0c             	sub    $0xc,%esp
  8014b3:	50                   	push   %eax
  8014b4:	e8 22 18 00 00       	call   802cdb <free>
  8014b9:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  8014bc:	e8 4e 1b 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  8014c1:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  8014c7:	89 d1                	mov    %edx,%ecx
  8014c9:	29 c1                	sub    %eax,%ecx
  8014cb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8014ce:	89 c2                	mov    %eax,%edx
  8014d0:	01 d2                	add    %edx,%edx
  8014d2:	01 d0                	add    %edx,%eax
  8014d4:	85 c0                	test   %eax,%eax
  8014d6:	79 05                	jns    8014dd <_main+0x14a5>
  8014d8:	05 ff 0f 00 00       	add    $0xfff,%eax
  8014dd:	c1 f8 0c             	sar    $0xc,%eax
  8014e0:	39 c1                	cmp    %eax,%ecx
  8014e2:	74 17                	je     8014fb <_main+0x14c3>
  8014e4:	83 ec 04             	sub    $0x4,%esp
  8014e7:	68 2c 38 80 00       	push   $0x80382c
  8014ec:	68 0d 01 00 00       	push   $0x10d
  8014f1:	68 1c 37 80 00       	push   $0x80371c
  8014f6:	e8 da 04 00 00       	call   8019d5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8014fb:	e8 8c 1a 00 00       	call   802f8c <sys_calculate_free_frames>
  801500:	89 c2                	mov    %eax,%edx
  801502:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  801508:	39 c2                	cmp    %eax,%edx
  80150a:	74 17                	je     801523 <_main+0x14eb>
  80150c:	83 ec 04             	sub    $0x4,%esp
  80150f:	68 68 38 80 00       	push   $0x803868
  801514:	68 0e 01 00 00       	push   $0x10e
  801519:	68 1c 37 80 00       	push   $0x80371c
  80151e:	e8 b2 04 00 00       	call   8019d5 <_panic>

		//Free 1st 2 KB
		freeFrames = sys_calculate_free_frames() ;
  801523:	e8 64 1a 00 00       	call   802f8c <sys_calculate_free_frames>
  801528:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80152e:	e8 dc 1a 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  801533:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[2]);
  801539:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  80153f:	83 ec 0c             	sub    $0xc,%esp
  801542:	50                   	push   %eax
  801543:	e8 93 17 00 00       	call   802cdb <free>
  801548:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  80154b:	e8 bf 1a 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  801550:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  801556:	29 c2                	sub    %eax,%edx
  801558:	89 d0                	mov    %edx,%eax
  80155a:	83 f8 01             	cmp    $0x1,%eax
  80155d:	74 17                	je     801576 <_main+0x153e>
  80155f:	83 ec 04             	sub    $0x4,%esp
  801562:	68 2c 38 80 00       	push   $0x80382c
  801567:	68 14 01 00 00       	push   $0x114
  80156c:	68 1c 37 80 00       	push   $0x80371c
  801571:	e8 5f 04 00 00       	call   8019d5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801576:	e8 11 1a 00 00       	call   802f8c <sys_calculate_free_frames>
  80157b:	89 c2                	mov    %eax,%edx
  80157d:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  801583:	29 c2                	sub    %eax,%edx
  801585:	89 d0                	mov    %edx,%eax
  801587:	83 f8 02             	cmp    $0x2,%eax
  80158a:	74 17                	je     8015a3 <_main+0x156b>
  80158c:	83 ec 04             	sub    $0x4,%esp
  80158f:	68 68 38 80 00       	push   $0x803868
  801594:	68 15 01 00 00       	push   $0x115
  801599:	68 1c 37 80 00       	push   $0x80371c
  80159e:	e8 32 04 00 00       	call   8019d5 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8015a3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8015aa:	e9 cb 00 00 00       	jmp    80167a <_main+0x1642>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  8015af:	a1 20 40 80 00       	mov    0x804020,%eax
  8015b4:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8015ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8015bd:	89 d0                	mov    %edx,%eax
  8015bf:	c1 e0 02             	shl    $0x2,%eax
  8015c2:	01 d0                	add    %edx,%eax
  8015c4:	c1 e0 02             	shl    $0x2,%eax
  8015c7:	01 c8                	add    %ecx,%eax
  8015c9:	8b 00                	mov    (%eax),%eax
  8015cb:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
  8015d1:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8015d7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8015dc:	89 c2                	mov    %eax,%edx
  8015de:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8015e1:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
  8015e7:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  8015ed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8015f2:	39 c2                	cmp    %eax,%edx
  8015f4:	75 17                	jne    80160d <_main+0x15d5>
				panic("free: page is not removed from WS");
  8015f6:	83 ec 04             	sub    $0x4,%esp
  8015f9:	68 b4 38 80 00       	push   $0x8038b4
  8015fe:	68 19 01 00 00       	push   $0x119
  801603:	68 1c 37 80 00       	push   $0x80371c
  801608:	e8 c8 03 00 00       	call   8019d5 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  80160d:	a1 20 40 80 00       	mov    0x804020,%eax
  801612:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801618:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80161b:	89 d0                	mov    %edx,%eax
  80161d:	c1 e0 02             	shl    $0x2,%eax
  801620:	01 d0                	add    %edx,%eax
  801622:	c1 e0 02             	shl    $0x2,%eax
  801625:	01 c8                	add    %ecx,%eax
  801627:	8b 00                	mov    (%eax),%eax
  801629:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
  80162f:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  801635:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80163a:	89 c2                	mov    %eax,%edx
  80163c:	8b 45 88             	mov    -0x78(%ebp),%eax
  80163f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801646:	8b 45 8c             	mov    -0x74(%ebp),%eax
  801649:	01 c8                	add    %ecx,%eax
  80164b:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
  801651:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  801657:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80165c:	39 c2                	cmp    %eax,%edx
  80165e:	75 17                	jne    801677 <_main+0x163f>
				panic("free: page is not removed from WS");
  801660:	83 ec 04             	sub    $0x4,%esp
  801663:	68 b4 38 80 00       	push   $0x8038b4
  801668:	68 1b 01 00 00       	push   $0x11b
  80166d:	68 1c 37 80 00       	push   $0x80371c
  801672:	e8 5e 03 00 00       	call   8019d5 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[2]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801677:	ff 45 e4             	incl   -0x1c(%ebp)
  80167a:	a1 20 40 80 00       	mov    0x804020,%eax
  80167f:	8b 50 74             	mov    0x74(%eax),%edx
  801682:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801685:	39 c2                	cmp    %eax,%edx
  801687:	0f 87 22 ff ff ff    	ja     8015af <_main+0x1577>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 2nd 2 KB
		freeFrames = sys_calculate_free_frames() ;
  80168d:	e8 fa 18 00 00       	call   802f8c <sys_calculate_free_frames>
  801692:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801698:	e8 72 19 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  80169d:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[3]);
  8016a3:	8b 85 74 fe ff ff    	mov    -0x18c(%ebp),%eax
  8016a9:	83 ec 0c             	sub    $0xc,%esp
  8016ac:	50                   	push   %eax
  8016ad:	e8 29 16 00 00       	call   802cdb <free>
  8016b2:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  8016b5:	e8 55 19 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  8016ba:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  8016c0:	29 c2                	sub    %eax,%edx
  8016c2:	89 d0                	mov    %edx,%eax
  8016c4:	83 f8 01             	cmp    $0x1,%eax
  8016c7:	74 17                	je     8016e0 <_main+0x16a8>
  8016c9:	83 ec 04             	sub    $0x4,%esp
  8016cc:	68 2c 38 80 00       	push   $0x80382c
  8016d1:	68 22 01 00 00       	push   $0x122
  8016d6:	68 1c 37 80 00       	push   $0x80371c
  8016db:	e8 f5 02 00 00       	call   8019d5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8016e0:	e8 a7 18 00 00       	call   802f8c <sys_calculate_free_frames>
  8016e5:	89 c2                	mov    %eax,%edx
  8016e7:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  8016ed:	39 c2                	cmp    %eax,%edx
  8016ef:	74 17                	je     801708 <_main+0x16d0>
  8016f1:	83 ec 04             	sub    $0x4,%esp
  8016f4:	68 68 38 80 00       	push   $0x803868
  8016f9:	68 23 01 00 00       	push   $0x123
  8016fe:	68 1c 37 80 00       	push   $0x80371c
  801703:	e8 cd 02 00 00       	call   8019d5 <_panic>


		//Free last 14 KB
		freeFrames = sys_calculate_free_frames() ;
  801708:	e8 7f 18 00 00       	call   802f8c <sys_calculate_free_frames>
  80170d:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801713:	e8 f7 18 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  801718:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[7]);
  80171e:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  801724:	83 ec 0c             	sub    $0xc,%esp
  801727:	50                   	push   %eax
  801728:	e8 ae 15 00 00       	call   802cdb <free>
  80172d:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
  801730:	e8 da 18 00 00       	call   80300f <sys_pf_calculate_allocated_pages>
  801735:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  80173b:	29 c2                	sub    %eax,%edx
  80173d:	89 d0                	mov    %edx,%eax
  80173f:	83 f8 04             	cmp    $0x4,%eax
  801742:	74 17                	je     80175b <_main+0x1723>
  801744:	83 ec 04             	sub    $0x4,%esp
  801747:	68 2c 38 80 00       	push   $0x80382c
  80174c:	68 2a 01 00 00       	push   $0x12a
  801751:	68 1c 37 80 00       	push   $0x80371c
  801756:	e8 7a 02 00 00       	call   8019d5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80175b:	e8 2c 18 00 00       	call   802f8c <sys_calculate_free_frames>
  801760:	89 c2                	mov    %eax,%edx
  801762:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  801768:	29 c2                	sub    %eax,%edx
  80176a:	89 d0                	mov    %edx,%eax
  80176c:	83 f8 03             	cmp    $0x3,%eax
  80176f:	74 17                	je     801788 <_main+0x1750>
  801771:	83 ec 04             	sub    $0x4,%esp
  801774:	68 68 38 80 00       	push   $0x803868
  801779:	68 2b 01 00 00       	push   $0x12b
  80177e:	68 1c 37 80 00       	push   $0x80371c
  801783:	e8 4d 02 00 00       	call   8019d5 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801788:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80178f:	e9 c8 00 00 00       	jmp    80185c <_main+0x1824>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  801794:	a1 20 40 80 00       	mov    0x804020,%eax
  801799:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80179f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8017a2:	89 d0                	mov    %edx,%eax
  8017a4:	c1 e0 02             	shl    $0x2,%eax
  8017a7:	01 d0                	add    %edx,%eax
  8017a9:	c1 e0 02             	shl    $0x2,%eax
  8017ac:	01 c8                	add    %ecx,%eax
  8017ae:	8b 00                	mov    (%eax),%eax
  8017b0:	89 85 c4 fe ff ff    	mov    %eax,-0x13c(%ebp)
  8017b6:	8b 85 c4 fe ff ff    	mov    -0x13c(%ebp),%eax
  8017bc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8017c1:	89 c2                	mov    %eax,%edx
  8017c3:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8017c6:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
  8017cc:	8b 85 c0 fe ff ff    	mov    -0x140(%ebp),%eax
  8017d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8017d7:	39 c2                	cmp    %eax,%edx
  8017d9:	75 17                	jne    8017f2 <_main+0x17ba>
				panic("free: page is not removed from WS");
  8017db:	83 ec 04             	sub    $0x4,%esp
  8017de:	68 b4 38 80 00       	push   $0x8038b4
  8017e3:	68 2f 01 00 00       	push   $0x12f
  8017e8:	68 1c 37 80 00       	push   $0x80371c
  8017ed:	e8 e3 01 00 00       	call   8019d5 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  8017f2:	a1 20 40 80 00       	mov    0x804020,%eax
  8017f7:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8017fd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801800:	89 d0                	mov    %edx,%eax
  801802:	c1 e0 02             	shl    $0x2,%eax
  801805:	01 d0                	add    %edx,%eax
  801807:	c1 e0 02             	shl    $0x2,%eax
  80180a:	01 c8                	add    %ecx,%eax
  80180c:	8b 00                	mov    (%eax),%eax
  80180e:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
  801814:	8b 85 bc fe ff ff    	mov    -0x144(%ebp),%eax
  80181a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80181f:	89 c2                	mov    %eax,%edx
  801821:	8b 45 a0             	mov    -0x60(%ebp),%eax
  801824:	01 c0                	add    %eax,%eax
  801826:	89 c1                	mov    %eax,%ecx
  801828:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80182b:	01 c8                	add    %ecx,%eax
  80182d:	89 85 b8 fe ff ff    	mov    %eax,-0x148(%ebp)
  801833:	8b 85 b8 fe ff ff    	mov    -0x148(%ebp),%eax
  801839:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80183e:	39 c2                	cmp    %eax,%edx
  801840:	75 17                	jne    801859 <_main+0x1821>
				panic("free: page is not removed from WS");
  801842:	83 ec 04             	sub    $0x4,%esp
  801845:	68 b4 38 80 00       	push   $0x8038b4
  80184a:	68 31 01 00 00       	push   $0x131
  80184f:	68 1c 37 80 00       	push   $0x80371c
  801854:	e8 7c 01 00 00       	call   8019d5 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[7]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801859:	ff 45 e4             	incl   -0x1c(%ebp)
  80185c:	a1 20 40 80 00       	mov    0x804020,%eax
  801861:	8b 50 74             	mov    0x74(%eax),%edx
  801864:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801867:	39 c2                	cmp    %eax,%edx
  801869:	0f 87 25 ff ff ff    	ja     801794 <_main+0x175c>
				panic("free: page is not removed from WS");
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
  80186f:	e8 18 17 00 00       	call   802f8c <sys_calculate_free_frames>
  801874:	8d 50 04             	lea    0x4(%eax),%edx
  801877:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80187a:	39 c2                	cmp    %eax,%edx
  80187c:	74 17                	je     801895 <_main+0x185d>
  80187e:	83 ec 04             	sub    $0x4,%esp
  801881:	68 d8 38 80 00       	push   $0x8038d8
  801886:	68 34 01 00 00       	push   $0x134
  80188b:	68 1c 37 80 00       	push   $0x80371c
  801890:	e8 40 01 00 00       	call   8019d5 <_panic>
	}

	cprintf("Congratulations!! test free [1] completed successfully.\n");
  801895:	83 ec 0c             	sub    $0xc,%esp
  801898:	68 0c 39 80 00       	push   $0x80390c
  80189d:	e8 ea 03 00 00       	call   801c8c <cprintf>
  8018a2:	83 c4 10             	add    $0x10,%esp

	return;
  8018a5:	90                   	nop
}
  8018a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8018a9:	5b                   	pop    %ebx
  8018aa:	5f                   	pop    %edi
  8018ab:	5d                   	pop    %ebp
  8018ac:	c3                   	ret    

008018ad <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8018ad:	55                   	push   %ebp
  8018ae:	89 e5                	mov    %esp,%ebp
  8018b0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8018b3:	e8 09 16 00 00       	call   802ec1 <sys_getenvindex>
  8018b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8018bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018be:	89 d0                	mov    %edx,%eax
  8018c0:	01 c0                	add    %eax,%eax
  8018c2:	01 d0                	add    %edx,%eax
  8018c4:	c1 e0 07             	shl    $0x7,%eax
  8018c7:	29 d0                	sub    %edx,%eax
  8018c9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8018d0:	01 c8                	add    %ecx,%eax
  8018d2:	01 c0                	add    %eax,%eax
  8018d4:	01 d0                	add    %edx,%eax
  8018d6:	01 c0                	add    %eax,%eax
  8018d8:	01 d0                	add    %edx,%eax
  8018da:	c1 e0 03             	shl    $0x3,%eax
  8018dd:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8018e2:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8018e7:	a1 20 40 80 00       	mov    0x804020,%eax
  8018ec:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  8018f2:	84 c0                	test   %al,%al
  8018f4:	74 0f                	je     801905 <libmain+0x58>
		binaryname = myEnv->prog_name;
  8018f6:	a1 20 40 80 00       	mov    0x804020,%eax
  8018fb:	05 f0 ee 00 00       	add    $0xeef0,%eax
  801900:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  801905:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801909:	7e 0a                	jle    801915 <libmain+0x68>
		binaryname = argv[0];
  80190b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80190e:	8b 00                	mov    (%eax),%eax
  801910:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  801915:	83 ec 08             	sub    $0x8,%esp
  801918:	ff 75 0c             	pushl  0xc(%ebp)
  80191b:	ff 75 08             	pushl  0x8(%ebp)
  80191e:	e8 15 e7 ff ff       	call   800038 <_main>
  801923:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  801926:	e8 31 17 00 00       	call   80305c <sys_disable_interrupt>
	cprintf("**************************************\n");
  80192b:	83 ec 0c             	sub    $0xc,%esp
  80192e:	68 60 39 80 00       	push   $0x803960
  801933:	e8 54 03 00 00       	call   801c8c <cprintf>
  801938:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80193b:	a1 20 40 80 00       	mov    0x804020,%eax
  801940:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  801946:	a1 20 40 80 00       	mov    0x804020,%eax
  80194b:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  801951:	83 ec 04             	sub    $0x4,%esp
  801954:	52                   	push   %edx
  801955:	50                   	push   %eax
  801956:	68 88 39 80 00       	push   $0x803988
  80195b:	e8 2c 03 00 00       	call   801c8c <cprintf>
  801960:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  801963:	a1 20 40 80 00       	mov    0x804020,%eax
  801968:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  80196e:	a1 20 40 80 00       	mov    0x804020,%eax
  801973:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  801979:	a1 20 40 80 00       	mov    0x804020,%eax
  80197e:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  801984:	51                   	push   %ecx
  801985:	52                   	push   %edx
  801986:	50                   	push   %eax
  801987:	68 b0 39 80 00       	push   $0x8039b0
  80198c:	e8 fb 02 00 00       	call   801c8c <cprintf>
  801991:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  801994:	83 ec 0c             	sub    $0xc,%esp
  801997:	68 60 39 80 00       	push   $0x803960
  80199c:	e8 eb 02 00 00       	call   801c8c <cprintf>
  8019a1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8019a4:	e8 cd 16 00 00       	call   803076 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8019a9:	e8 19 00 00 00       	call   8019c7 <exit>
}
  8019ae:	90                   	nop
  8019af:	c9                   	leave  
  8019b0:	c3                   	ret    

008019b1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8019b1:	55                   	push   %ebp
  8019b2:	89 e5                	mov    %esp,%ebp
  8019b4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8019b7:	83 ec 0c             	sub    $0xc,%esp
  8019ba:	6a 00                	push   $0x0
  8019bc:	e8 cc 14 00 00       	call   802e8d <sys_env_destroy>
  8019c1:	83 c4 10             	add    $0x10,%esp
}
  8019c4:	90                   	nop
  8019c5:	c9                   	leave  
  8019c6:	c3                   	ret    

008019c7 <exit>:

void
exit(void)
{
  8019c7:	55                   	push   %ebp
  8019c8:	89 e5                	mov    %esp,%ebp
  8019ca:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8019cd:	e8 21 15 00 00       	call   802ef3 <sys_env_exit>
}
  8019d2:	90                   	nop
  8019d3:	c9                   	leave  
  8019d4:	c3                   	ret    

008019d5 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8019d5:	55                   	push   %ebp
  8019d6:	89 e5                	mov    %esp,%ebp
  8019d8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8019db:	8d 45 10             	lea    0x10(%ebp),%eax
  8019de:	83 c0 04             	add    $0x4,%eax
  8019e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8019e4:	a1 18 41 80 00       	mov    0x804118,%eax
  8019e9:	85 c0                	test   %eax,%eax
  8019eb:	74 16                	je     801a03 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8019ed:	a1 18 41 80 00       	mov    0x804118,%eax
  8019f2:	83 ec 08             	sub    $0x8,%esp
  8019f5:	50                   	push   %eax
  8019f6:	68 08 3a 80 00       	push   $0x803a08
  8019fb:	e8 8c 02 00 00       	call   801c8c <cprintf>
  801a00:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801a03:	a1 00 40 80 00       	mov    0x804000,%eax
  801a08:	ff 75 0c             	pushl  0xc(%ebp)
  801a0b:	ff 75 08             	pushl  0x8(%ebp)
  801a0e:	50                   	push   %eax
  801a0f:	68 0d 3a 80 00       	push   $0x803a0d
  801a14:	e8 73 02 00 00       	call   801c8c <cprintf>
  801a19:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801a1c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a1f:	83 ec 08             	sub    $0x8,%esp
  801a22:	ff 75 f4             	pushl  -0xc(%ebp)
  801a25:	50                   	push   %eax
  801a26:	e8 f6 01 00 00       	call   801c21 <vcprintf>
  801a2b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801a2e:	83 ec 08             	sub    $0x8,%esp
  801a31:	6a 00                	push   $0x0
  801a33:	68 29 3a 80 00       	push   $0x803a29
  801a38:	e8 e4 01 00 00       	call   801c21 <vcprintf>
  801a3d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801a40:	e8 82 ff ff ff       	call   8019c7 <exit>

	// should not return here
	while (1) ;
  801a45:	eb fe                	jmp    801a45 <_panic+0x70>

00801a47 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801a47:	55                   	push   %ebp
  801a48:	89 e5                	mov    %esp,%ebp
  801a4a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801a4d:	a1 20 40 80 00       	mov    0x804020,%eax
  801a52:	8b 50 74             	mov    0x74(%eax),%edx
  801a55:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a58:	39 c2                	cmp    %eax,%edx
  801a5a:	74 14                	je     801a70 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801a5c:	83 ec 04             	sub    $0x4,%esp
  801a5f:	68 2c 3a 80 00       	push   $0x803a2c
  801a64:	6a 26                	push   $0x26
  801a66:	68 78 3a 80 00       	push   $0x803a78
  801a6b:	e8 65 ff ff ff       	call   8019d5 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801a70:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801a77:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a7e:	e9 c4 00 00 00       	jmp    801b47 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  801a83:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a86:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a90:	01 d0                	add    %edx,%eax
  801a92:	8b 00                	mov    (%eax),%eax
  801a94:	85 c0                	test   %eax,%eax
  801a96:	75 08                	jne    801aa0 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801a98:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801a9b:	e9 a4 00 00 00       	jmp    801b44 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  801aa0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801aa7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801aae:	eb 6b                	jmp    801b1b <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801ab0:	a1 20 40 80 00       	mov    0x804020,%eax
  801ab5:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801abb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801abe:	89 d0                	mov    %edx,%eax
  801ac0:	c1 e0 02             	shl    $0x2,%eax
  801ac3:	01 d0                	add    %edx,%eax
  801ac5:	c1 e0 02             	shl    $0x2,%eax
  801ac8:	01 c8                	add    %ecx,%eax
  801aca:	8a 40 04             	mov    0x4(%eax),%al
  801acd:	84 c0                	test   %al,%al
  801acf:	75 47                	jne    801b18 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801ad1:	a1 20 40 80 00       	mov    0x804020,%eax
  801ad6:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801adc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801adf:	89 d0                	mov    %edx,%eax
  801ae1:	c1 e0 02             	shl    $0x2,%eax
  801ae4:	01 d0                	add    %edx,%eax
  801ae6:	c1 e0 02             	shl    $0x2,%eax
  801ae9:	01 c8                	add    %ecx,%eax
  801aeb:	8b 00                	mov    (%eax),%eax
  801aed:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801af0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801af3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801af8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801afa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801afd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801b04:	8b 45 08             	mov    0x8(%ebp),%eax
  801b07:	01 c8                	add    %ecx,%eax
  801b09:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801b0b:	39 c2                	cmp    %eax,%edx
  801b0d:	75 09                	jne    801b18 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  801b0f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801b16:	eb 12                	jmp    801b2a <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b18:	ff 45 e8             	incl   -0x18(%ebp)
  801b1b:	a1 20 40 80 00       	mov    0x804020,%eax
  801b20:	8b 50 74             	mov    0x74(%eax),%edx
  801b23:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b26:	39 c2                	cmp    %eax,%edx
  801b28:	77 86                	ja     801ab0 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801b2a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801b2e:	75 14                	jne    801b44 <CheckWSWithoutLastIndex+0xfd>
			panic(
  801b30:	83 ec 04             	sub    $0x4,%esp
  801b33:	68 84 3a 80 00       	push   $0x803a84
  801b38:	6a 3a                	push   $0x3a
  801b3a:	68 78 3a 80 00       	push   $0x803a78
  801b3f:	e8 91 fe ff ff       	call   8019d5 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801b44:	ff 45 f0             	incl   -0x10(%ebp)
  801b47:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b4a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801b4d:	0f 8c 30 ff ff ff    	jl     801a83 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801b53:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b5a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801b61:	eb 27                	jmp    801b8a <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801b63:	a1 20 40 80 00       	mov    0x804020,%eax
  801b68:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801b6e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801b71:	89 d0                	mov    %edx,%eax
  801b73:	c1 e0 02             	shl    $0x2,%eax
  801b76:	01 d0                	add    %edx,%eax
  801b78:	c1 e0 02             	shl    $0x2,%eax
  801b7b:	01 c8                	add    %ecx,%eax
  801b7d:	8a 40 04             	mov    0x4(%eax),%al
  801b80:	3c 01                	cmp    $0x1,%al
  801b82:	75 03                	jne    801b87 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  801b84:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b87:	ff 45 e0             	incl   -0x20(%ebp)
  801b8a:	a1 20 40 80 00       	mov    0x804020,%eax
  801b8f:	8b 50 74             	mov    0x74(%eax),%edx
  801b92:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b95:	39 c2                	cmp    %eax,%edx
  801b97:	77 ca                	ja     801b63 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801b99:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b9c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b9f:	74 14                	je     801bb5 <CheckWSWithoutLastIndex+0x16e>
		panic(
  801ba1:	83 ec 04             	sub    $0x4,%esp
  801ba4:	68 d8 3a 80 00       	push   $0x803ad8
  801ba9:	6a 44                	push   $0x44
  801bab:	68 78 3a 80 00       	push   $0x803a78
  801bb0:	e8 20 fe ff ff       	call   8019d5 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801bb5:	90                   	nop
  801bb6:	c9                   	leave  
  801bb7:	c3                   	ret    

00801bb8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801bb8:	55                   	push   %ebp
  801bb9:	89 e5                	mov    %esp,%ebp
  801bbb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801bbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bc1:	8b 00                	mov    (%eax),%eax
  801bc3:	8d 48 01             	lea    0x1(%eax),%ecx
  801bc6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc9:	89 0a                	mov    %ecx,(%edx)
  801bcb:	8b 55 08             	mov    0x8(%ebp),%edx
  801bce:	88 d1                	mov    %dl,%cl
  801bd0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bda:	8b 00                	mov    (%eax),%eax
  801bdc:	3d ff 00 00 00       	cmp    $0xff,%eax
  801be1:	75 2c                	jne    801c0f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801be3:	a0 24 40 80 00       	mov    0x804024,%al
  801be8:	0f b6 c0             	movzbl %al,%eax
  801beb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bee:	8b 12                	mov    (%edx),%edx
  801bf0:	89 d1                	mov    %edx,%ecx
  801bf2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf5:	83 c2 08             	add    $0x8,%edx
  801bf8:	83 ec 04             	sub    $0x4,%esp
  801bfb:	50                   	push   %eax
  801bfc:	51                   	push   %ecx
  801bfd:	52                   	push   %edx
  801bfe:	e8 48 12 00 00       	call   802e4b <sys_cputs>
  801c03:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801c06:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c09:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801c0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c12:	8b 40 04             	mov    0x4(%eax),%eax
  801c15:	8d 50 01             	lea    0x1(%eax),%edx
  801c18:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c1b:	89 50 04             	mov    %edx,0x4(%eax)
}
  801c1e:	90                   	nop
  801c1f:	c9                   	leave  
  801c20:	c3                   	ret    

00801c21 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801c21:	55                   	push   %ebp
  801c22:	89 e5                	mov    %esp,%ebp
  801c24:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801c2a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801c31:	00 00 00 
	b.cnt = 0;
  801c34:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801c3b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801c3e:	ff 75 0c             	pushl  0xc(%ebp)
  801c41:	ff 75 08             	pushl  0x8(%ebp)
  801c44:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801c4a:	50                   	push   %eax
  801c4b:	68 b8 1b 80 00       	push   $0x801bb8
  801c50:	e8 11 02 00 00       	call   801e66 <vprintfmt>
  801c55:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801c58:	a0 24 40 80 00       	mov    0x804024,%al
  801c5d:	0f b6 c0             	movzbl %al,%eax
  801c60:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801c66:	83 ec 04             	sub    $0x4,%esp
  801c69:	50                   	push   %eax
  801c6a:	52                   	push   %edx
  801c6b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801c71:	83 c0 08             	add    $0x8,%eax
  801c74:	50                   	push   %eax
  801c75:	e8 d1 11 00 00       	call   802e4b <sys_cputs>
  801c7a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801c7d:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801c84:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801c8a:	c9                   	leave  
  801c8b:	c3                   	ret    

00801c8c <cprintf>:

int cprintf(const char *fmt, ...) {
  801c8c:	55                   	push   %ebp
  801c8d:	89 e5                	mov    %esp,%ebp
  801c8f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801c92:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801c99:	8d 45 0c             	lea    0xc(%ebp),%eax
  801c9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca2:	83 ec 08             	sub    $0x8,%esp
  801ca5:	ff 75 f4             	pushl  -0xc(%ebp)
  801ca8:	50                   	push   %eax
  801ca9:	e8 73 ff ff ff       	call   801c21 <vcprintf>
  801cae:	83 c4 10             	add    $0x10,%esp
  801cb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801cb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801cb7:	c9                   	leave  
  801cb8:	c3                   	ret    

00801cb9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801cb9:	55                   	push   %ebp
  801cba:	89 e5                	mov    %esp,%ebp
  801cbc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801cbf:	e8 98 13 00 00       	call   80305c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801cc4:	8d 45 0c             	lea    0xc(%ebp),%eax
  801cc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801cca:	8b 45 08             	mov    0x8(%ebp),%eax
  801ccd:	83 ec 08             	sub    $0x8,%esp
  801cd0:	ff 75 f4             	pushl  -0xc(%ebp)
  801cd3:	50                   	push   %eax
  801cd4:	e8 48 ff ff ff       	call   801c21 <vcprintf>
  801cd9:	83 c4 10             	add    $0x10,%esp
  801cdc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801cdf:	e8 92 13 00 00       	call   803076 <sys_enable_interrupt>
	return cnt;
  801ce4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ce7:	c9                   	leave  
  801ce8:	c3                   	ret    

00801ce9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801ce9:	55                   	push   %ebp
  801cea:	89 e5                	mov    %esp,%ebp
  801cec:	53                   	push   %ebx
  801ced:	83 ec 14             	sub    $0x14,%esp
  801cf0:	8b 45 10             	mov    0x10(%ebp),%eax
  801cf3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801cf6:	8b 45 14             	mov    0x14(%ebp),%eax
  801cf9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801cfc:	8b 45 18             	mov    0x18(%ebp),%eax
  801cff:	ba 00 00 00 00       	mov    $0x0,%edx
  801d04:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801d07:	77 55                	ja     801d5e <printnum+0x75>
  801d09:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801d0c:	72 05                	jb     801d13 <printnum+0x2a>
  801d0e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801d11:	77 4b                	ja     801d5e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801d13:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801d16:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801d19:	8b 45 18             	mov    0x18(%ebp),%eax
  801d1c:	ba 00 00 00 00       	mov    $0x0,%edx
  801d21:	52                   	push   %edx
  801d22:	50                   	push   %eax
  801d23:	ff 75 f4             	pushl  -0xc(%ebp)
  801d26:	ff 75 f0             	pushl  -0x10(%ebp)
  801d29:	e8 6e 17 00 00       	call   80349c <__udivdi3>
  801d2e:	83 c4 10             	add    $0x10,%esp
  801d31:	83 ec 04             	sub    $0x4,%esp
  801d34:	ff 75 20             	pushl  0x20(%ebp)
  801d37:	53                   	push   %ebx
  801d38:	ff 75 18             	pushl  0x18(%ebp)
  801d3b:	52                   	push   %edx
  801d3c:	50                   	push   %eax
  801d3d:	ff 75 0c             	pushl  0xc(%ebp)
  801d40:	ff 75 08             	pushl  0x8(%ebp)
  801d43:	e8 a1 ff ff ff       	call   801ce9 <printnum>
  801d48:	83 c4 20             	add    $0x20,%esp
  801d4b:	eb 1a                	jmp    801d67 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801d4d:	83 ec 08             	sub    $0x8,%esp
  801d50:	ff 75 0c             	pushl  0xc(%ebp)
  801d53:	ff 75 20             	pushl  0x20(%ebp)
  801d56:	8b 45 08             	mov    0x8(%ebp),%eax
  801d59:	ff d0                	call   *%eax
  801d5b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801d5e:	ff 4d 1c             	decl   0x1c(%ebp)
  801d61:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801d65:	7f e6                	jg     801d4d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801d67:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801d6a:	bb 00 00 00 00       	mov    $0x0,%ebx
  801d6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d72:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d75:	53                   	push   %ebx
  801d76:	51                   	push   %ecx
  801d77:	52                   	push   %edx
  801d78:	50                   	push   %eax
  801d79:	e8 2e 18 00 00       	call   8035ac <__umoddi3>
  801d7e:	83 c4 10             	add    $0x10,%esp
  801d81:	05 54 3d 80 00       	add    $0x803d54,%eax
  801d86:	8a 00                	mov    (%eax),%al
  801d88:	0f be c0             	movsbl %al,%eax
  801d8b:	83 ec 08             	sub    $0x8,%esp
  801d8e:	ff 75 0c             	pushl  0xc(%ebp)
  801d91:	50                   	push   %eax
  801d92:	8b 45 08             	mov    0x8(%ebp),%eax
  801d95:	ff d0                	call   *%eax
  801d97:	83 c4 10             	add    $0x10,%esp
}
  801d9a:	90                   	nop
  801d9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d9e:	c9                   	leave  
  801d9f:	c3                   	ret    

00801da0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801da0:	55                   	push   %ebp
  801da1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801da3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801da7:	7e 1c                	jle    801dc5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801da9:	8b 45 08             	mov    0x8(%ebp),%eax
  801dac:	8b 00                	mov    (%eax),%eax
  801dae:	8d 50 08             	lea    0x8(%eax),%edx
  801db1:	8b 45 08             	mov    0x8(%ebp),%eax
  801db4:	89 10                	mov    %edx,(%eax)
  801db6:	8b 45 08             	mov    0x8(%ebp),%eax
  801db9:	8b 00                	mov    (%eax),%eax
  801dbb:	83 e8 08             	sub    $0x8,%eax
  801dbe:	8b 50 04             	mov    0x4(%eax),%edx
  801dc1:	8b 00                	mov    (%eax),%eax
  801dc3:	eb 40                	jmp    801e05 <getuint+0x65>
	else if (lflag)
  801dc5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801dc9:	74 1e                	je     801de9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dce:	8b 00                	mov    (%eax),%eax
  801dd0:	8d 50 04             	lea    0x4(%eax),%edx
  801dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd6:	89 10                	mov    %edx,(%eax)
  801dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddb:	8b 00                	mov    (%eax),%eax
  801ddd:	83 e8 04             	sub    $0x4,%eax
  801de0:	8b 00                	mov    (%eax),%eax
  801de2:	ba 00 00 00 00       	mov    $0x0,%edx
  801de7:	eb 1c                	jmp    801e05 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801de9:	8b 45 08             	mov    0x8(%ebp),%eax
  801dec:	8b 00                	mov    (%eax),%eax
  801dee:	8d 50 04             	lea    0x4(%eax),%edx
  801df1:	8b 45 08             	mov    0x8(%ebp),%eax
  801df4:	89 10                	mov    %edx,(%eax)
  801df6:	8b 45 08             	mov    0x8(%ebp),%eax
  801df9:	8b 00                	mov    (%eax),%eax
  801dfb:	83 e8 04             	sub    $0x4,%eax
  801dfe:	8b 00                	mov    (%eax),%eax
  801e00:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801e05:	5d                   	pop    %ebp
  801e06:	c3                   	ret    

00801e07 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801e07:	55                   	push   %ebp
  801e08:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801e0a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801e0e:	7e 1c                	jle    801e2c <getint+0x25>
		return va_arg(*ap, long long);
  801e10:	8b 45 08             	mov    0x8(%ebp),%eax
  801e13:	8b 00                	mov    (%eax),%eax
  801e15:	8d 50 08             	lea    0x8(%eax),%edx
  801e18:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1b:	89 10                	mov    %edx,(%eax)
  801e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e20:	8b 00                	mov    (%eax),%eax
  801e22:	83 e8 08             	sub    $0x8,%eax
  801e25:	8b 50 04             	mov    0x4(%eax),%edx
  801e28:	8b 00                	mov    (%eax),%eax
  801e2a:	eb 38                	jmp    801e64 <getint+0x5d>
	else if (lflag)
  801e2c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801e30:	74 1a                	je     801e4c <getint+0x45>
		return va_arg(*ap, long);
  801e32:	8b 45 08             	mov    0x8(%ebp),%eax
  801e35:	8b 00                	mov    (%eax),%eax
  801e37:	8d 50 04             	lea    0x4(%eax),%edx
  801e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3d:	89 10                	mov    %edx,(%eax)
  801e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e42:	8b 00                	mov    (%eax),%eax
  801e44:	83 e8 04             	sub    $0x4,%eax
  801e47:	8b 00                	mov    (%eax),%eax
  801e49:	99                   	cltd   
  801e4a:	eb 18                	jmp    801e64 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4f:	8b 00                	mov    (%eax),%eax
  801e51:	8d 50 04             	lea    0x4(%eax),%edx
  801e54:	8b 45 08             	mov    0x8(%ebp),%eax
  801e57:	89 10                	mov    %edx,(%eax)
  801e59:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5c:	8b 00                	mov    (%eax),%eax
  801e5e:	83 e8 04             	sub    $0x4,%eax
  801e61:	8b 00                	mov    (%eax),%eax
  801e63:	99                   	cltd   
}
  801e64:	5d                   	pop    %ebp
  801e65:	c3                   	ret    

00801e66 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801e66:	55                   	push   %ebp
  801e67:	89 e5                	mov    %esp,%ebp
  801e69:	56                   	push   %esi
  801e6a:	53                   	push   %ebx
  801e6b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801e6e:	eb 17                	jmp    801e87 <vprintfmt+0x21>
			if (ch == '\0')
  801e70:	85 db                	test   %ebx,%ebx
  801e72:	0f 84 af 03 00 00    	je     802227 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801e78:	83 ec 08             	sub    $0x8,%esp
  801e7b:	ff 75 0c             	pushl  0xc(%ebp)
  801e7e:	53                   	push   %ebx
  801e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e82:	ff d0                	call   *%eax
  801e84:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801e87:	8b 45 10             	mov    0x10(%ebp),%eax
  801e8a:	8d 50 01             	lea    0x1(%eax),%edx
  801e8d:	89 55 10             	mov    %edx,0x10(%ebp)
  801e90:	8a 00                	mov    (%eax),%al
  801e92:	0f b6 d8             	movzbl %al,%ebx
  801e95:	83 fb 25             	cmp    $0x25,%ebx
  801e98:	75 d6                	jne    801e70 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801e9a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801e9e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801ea5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801eac:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801eb3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801eba:	8b 45 10             	mov    0x10(%ebp),%eax
  801ebd:	8d 50 01             	lea    0x1(%eax),%edx
  801ec0:	89 55 10             	mov    %edx,0x10(%ebp)
  801ec3:	8a 00                	mov    (%eax),%al
  801ec5:	0f b6 d8             	movzbl %al,%ebx
  801ec8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801ecb:	83 f8 55             	cmp    $0x55,%eax
  801ece:	0f 87 2b 03 00 00    	ja     8021ff <vprintfmt+0x399>
  801ed4:	8b 04 85 78 3d 80 00 	mov    0x803d78(,%eax,4),%eax
  801edb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801edd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801ee1:	eb d7                	jmp    801eba <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801ee3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801ee7:	eb d1                	jmp    801eba <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801ee9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801ef0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ef3:	89 d0                	mov    %edx,%eax
  801ef5:	c1 e0 02             	shl    $0x2,%eax
  801ef8:	01 d0                	add    %edx,%eax
  801efa:	01 c0                	add    %eax,%eax
  801efc:	01 d8                	add    %ebx,%eax
  801efe:	83 e8 30             	sub    $0x30,%eax
  801f01:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801f04:	8b 45 10             	mov    0x10(%ebp),%eax
  801f07:	8a 00                	mov    (%eax),%al
  801f09:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801f0c:	83 fb 2f             	cmp    $0x2f,%ebx
  801f0f:	7e 3e                	jle    801f4f <vprintfmt+0xe9>
  801f11:	83 fb 39             	cmp    $0x39,%ebx
  801f14:	7f 39                	jg     801f4f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801f16:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801f19:	eb d5                	jmp    801ef0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801f1b:	8b 45 14             	mov    0x14(%ebp),%eax
  801f1e:	83 c0 04             	add    $0x4,%eax
  801f21:	89 45 14             	mov    %eax,0x14(%ebp)
  801f24:	8b 45 14             	mov    0x14(%ebp),%eax
  801f27:	83 e8 04             	sub    $0x4,%eax
  801f2a:	8b 00                	mov    (%eax),%eax
  801f2c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801f2f:	eb 1f                	jmp    801f50 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801f31:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801f35:	79 83                	jns    801eba <vprintfmt+0x54>
				width = 0;
  801f37:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801f3e:	e9 77 ff ff ff       	jmp    801eba <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801f43:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801f4a:	e9 6b ff ff ff       	jmp    801eba <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801f4f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801f50:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801f54:	0f 89 60 ff ff ff    	jns    801eba <vprintfmt+0x54>
				width = precision, precision = -1;
  801f5a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f5d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801f60:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801f67:	e9 4e ff ff ff       	jmp    801eba <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801f6c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801f6f:	e9 46 ff ff ff       	jmp    801eba <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801f74:	8b 45 14             	mov    0x14(%ebp),%eax
  801f77:	83 c0 04             	add    $0x4,%eax
  801f7a:	89 45 14             	mov    %eax,0x14(%ebp)
  801f7d:	8b 45 14             	mov    0x14(%ebp),%eax
  801f80:	83 e8 04             	sub    $0x4,%eax
  801f83:	8b 00                	mov    (%eax),%eax
  801f85:	83 ec 08             	sub    $0x8,%esp
  801f88:	ff 75 0c             	pushl  0xc(%ebp)
  801f8b:	50                   	push   %eax
  801f8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8f:	ff d0                	call   *%eax
  801f91:	83 c4 10             	add    $0x10,%esp
			break;
  801f94:	e9 89 02 00 00       	jmp    802222 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801f99:	8b 45 14             	mov    0x14(%ebp),%eax
  801f9c:	83 c0 04             	add    $0x4,%eax
  801f9f:	89 45 14             	mov    %eax,0x14(%ebp)
  801fa2:	8b 45 14             	mov    0x14(%ebp),%eax
  801fa5:	83 e8 04             	sub    $0x4,%eax
  801fa8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801faa:	85 db                	test   %ebx,%ebx
  801fac:	79 02                	jns    801fb0 <vprintfmt+0x14a>
				err = -err;
  801fae:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801fb0:	83 fb 64             	cmp    $0x64,%ebx
  801fb3:	7f 0b                	jg     801fc0 <vprintfmt+0x15a>
  801fb5:	8b 34 9d c0 3b 80 00 	mov    0x803bc0(,%ebx,4),%esi
  801fbc:	85 f6                	test   %esi,%esi
  801fbe:	75 19                	jne    801fd9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801fc0:	53                   	push   %ebx
  801fc1:	68 65 3d 80 00       	push   $0x803d65
  801fc6:	ff 75 0c             	pushl  0xc(%ebp)
  801fc9:	ff 75 08             	pushl  0x8(%ebp)
  801fcc:	e8 5e 02 00 00       	call   80222f <printfmt>
  801fd1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801fd4:	e9 49 02 00 00       	jmp    802222 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801fd9:	56                   	push   %esi
  801fda:	68 6e 3d 80 00       	push   $0x803d6e
  801fdf:	ff 75 0c             	pushl  0xc(%ebp)
  801fe2:	ff 75 08             	pushl  0x8(%ebp)
  801fe5:	e8 45 02 00 00       	call   80222f <printfmt>
  801fea:	83 c4 10             	add    $0x10,%esp
			break;
  801fed:	e9 30 02 00 00       	jmp    802222 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801ff2:	8b 45 14             	mov    0x14(%ebp),%eax
  801ff5:	83 c0 04             	add    $0x4,%eax
  801ff8:	89 45 14             	mov    %eax,0x14(%ebp)
  801ffb:	8b 45 14             	mov    0x14(%ebp),%eax
  801ffe:	83 e8 04             	sub    $0x4,%eax
  802001:	8b 30                	mov    (%eax),%esi
  802003:	85 f6                	test   %esi,%esi
  802005:	75 05                	jne    80200c <vprintfmt+0x1a6>
				p = "(null)";
  802007:	be 71 3d 80 00       	mov    $0x803d71,%esi
			if (width > 0 && padc != '-')
  80200c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  802010:	7e 6d                	jle    80207f <vprintfmt+0x219>
  802012:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  802016:	74 67                	je     80207f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  802018:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80201b:	83 ec 08             	sub    $0x8,%esp
  80201e:	50                   	push   %eax
  80201f:	56                   	push   %esi
  802020:	e8 0c 03 00 00       	call   802331 <strnlen>
  802025:	83 c4 10             	add    $0x10,%esp
  802028:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80202b:	eb 16                	jmp    802043 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80202d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  802031:	83 ec 08             	sub    $0x8,%esp
  802034:	ff 75 0c             	pushl  0xc(%ebp)
  802037:	50                   	push   %eax
  802038:	8b 45 08             	mov    0x8(%ebp),%eax
  80203b:	ff d0                	call   *%eax
  80203d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  802040:	ff 4d e4             	decl   -0x1c(%ebp)
  802043:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  802047:	7f e4                	jg     80202d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  802049:	eb 34                	jmp    80207f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80204b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80204f:	74 1c                	je     80206d <vprintfmt+0x207>
  802051:	83 fb 1f             	cmp    $0x1f,%ebx
  802054:	7e 05                	jle    80205b <vprintfmt+0x1f5>
  802056:	83 fb 7e             	cmp    $0x7e,%ebx
  802059:	7e 12                	jle    80206d <vprintfmt+0x207>
					putch('?', putdat);
  80205b:	83 ec 08             	sub    $0x8,%esp
  80205e:	ff 75 0c             	pushl  0xc(%ebp)
  802061:	6a 3f                	push   $0x3f
  802063:	8b 45 08             	mov    0x8(%ebp),%eax
  802066:	ff d0                	call   *%eax
  802068:	83 c4 10             	add    $0x10,%esp
  80206b:	eb 0f                	jmp    80207c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80206d:	83 ec 08             	sub    $0x8,%esp
  802070:	ff 75 0c             	pushl  0xc(%ebp)
  802073:	53                   	push   %ebx
  802074:	8b 45 08             	mov    0x8(%ebp),%eax
  802077:	ff d0                	call   *%eax
  802079:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80207c:	ff 4d e4             	decl   -0x1c(%ebp)
  80207f:	89 f0                	mov    %esi,%eax
  802081:	8d 70 01             	lea    0x1(%eax),%esi
  802084:	8a 00                	mov    (%eax),%al
  802086:	0f be d8             	movsbl %al,%ebx
  802089:	85 db                	test   %ebx,%ebx
  80208b:	74 24                	je     8020b1 <vprintfmt+0x24b>
  80208d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  802091:	78 b8                	js     80204b <vprintfmt+0x1e5>
  802093:	ff 4d e0             	decl   -0x20(%ebp)
  802096:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80209a:	79 af                	jns    80204b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80209c:	eb 13                	jmp    8020b1 <vprintfmt+0x24b>
				putch(' ', putdat);
  80209e:	83 ec 08             	sub    $0x8,%esp
  8020a1:	ff 75 0c             	pushl  0xc(%ebp)
  8020a4:	6a 20                	push   $0x20
  8020a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a9:	ff d0                	call   *%eax
  8020ab:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8020ae:	ff 4d e4             	decl   -0x1c(%ebp)
  8020b1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8020b5:	7f e7                	jg     80209e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8020b7:	e9 66 01 00 00       	jmp    802222 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8020bc:	83 ec 08             	sub    $0x8,%esp
  8020bf:	ff 75 e8             	pushl  -0x18(%ebp)
  8020c2:	8d 45 14             	lea    0x14(%ebp),%eax
  8020c5:	50                   	push   %eax
  8020c6:	e8 3c fd ff ff       	call   801e07 <getint>
  8020cb:	83 c4 10             	add    $0x10,%esp
  8020ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8020d1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8020d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8020da:	85 d2                	test   %edx,%edx
  8020dc:	79 23                	jns    802101 <vprintfmt+0x29b>
				putch('-', putdat);
  8020de:	83 ec 08             	sub    $0x8,%esp
  8020e1:	ff 75 0c             	pushl  0xc(%ebp)
  8020e4:	6a 2d                	push   $0x2d
  8020e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e9:	ff d0                	call   *%eax
  8020eb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8020ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8020f4:	f7 d8                	neg    %eax
  8020f6:	83 d2 00             	adc    $0x0,%edx
  8020f9:	f7 da                	neg    %edx
  8020fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8020fe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  802101:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  802108:	e9 bc 00 00 00       	jmp    8021c9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80210d:	83 ec 08             	sub    $0x8,%esp
  802110:	ff 75 e8             	pushl  -0x18(%ebp)
  802113:	8d 45 14             	lea    0x14(%ebp),%eax
  802116:	50                   	push   %eax
  802117:	e8 84 fc ff ff       	call   801da0 <getuint>
  80211c:	83 c4 10             	add    $0x10,%esp
  80211f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  802122:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  802125:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80212c:	e9 98 00 00 00       	jmp    8021c9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  802131:	83 ec 08             	sub    $0x8,%esp
  802134:	ff 75 0c             	pushl  0xc(%ebp)
  802137:	6a 58                	push   $0x58
  802139:	8b 45 08             	mov    0x8(%ebp),%eax
  80213c:	ff d0                	call   *%eax
  80213e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  802141:	83 ec 08             	sub    $0x8,%esp
  802144:	ff 75 0c             	pushl  0xc(%ebp)
  802147:	6a 58                	push   $0x58
  802149:	8b 45 08             	mov    0x8(%ebp),%eax
  80214c:	ff d0                	call   *%eax
  80214e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  802151:	83 ec 08             	sub    $0x8,%esp
  802154:	ff 75 0c             	pushl  0xc(%ebp)
  802157:	6a 58                	push   $0x58
  802159:	8b 45 08             	mov    0x8(%ebp),%eax
  80215c:	ff d0                	call   *%eax
  80215e:	83 c4 10             	add    $0x10,%esp
			break;
  802161:	e9 bc 00 00 00       	jmp    802222 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  802166:	83 ec 08             	sub    $0x8,%esp
  802169:	ff 75 0c             	pushl  0xc(%ebp)
  80216c:	6a 30                	push   $0x30
  80216e:	8b 45 08             	mov    0x8(%ebp),%eax
  802171:	ff d0                	call   *%eax
  802173:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  802176:	83 ec 08             	sub    $0x8,%esp
  802179:	ff 75 0c             	pushl  0xc(%ebp)
  80217c:	6a 78                	push   $0x78
  80217e:	8b 45 08             	mov    0x8(%ebp),%eax
  802181:	ff d0                	call   *%eax
  802183:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  802186:	8b 45 14             	mov    0x14(%ebp),%eax
  802189:	83 c0 04             	add    $0x4,%eax
  80218c:	89 45 14             	mov    %eax,0x14(%ebp)
  80218f:	8b 45 14             	mov    0x14(%ebp),%eax
  802192:	83 e8 04             	sub    $0x4,%eax
  802195:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  802197:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80219a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8021a1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8021a8:	eb 1f                	jmp    8021c9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8021aa:	83 ec 08             	sub    $0x8,%esp
  8021ad:	ff 75 e8             	pushl  -0x18(%ebp)
  8021b0:	8d 45 14             	lea    0x14(%ebp),%eax
  8021b3:	50                   	push   %eax
  8021b4:	e8 e7 fb ff ff       	call   801da0 <getuint>
  8021b9:	83 c4 10             	add    $0x10,%esp
  8021bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8021bf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8021c2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8021c9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8021cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8021d0:	83 ec 04             	sub    $0x4,%esp
  8021d3:	52                   	push   %edx
  8021d4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8021d7:	50                   	push   %eax
  8021d8:	ff 75 f4             	pushl  -0xc(%ebp)
  8021db:	ff 75 f0             	pushl  -0x10(%ebp)
  8021de:	ff 75 0c             	pushl  0xc(%ebp)
  8021e1:	ff 75 08             	pushl  0x8(%ebp)
  8021e4:	e8 00 fb ff ff       	call   801ce9 <printnum>
  8021e9:	83 c4 20             	add    $0x20,%esp
			break;
  8021ec:	eb 34                	jmp    802222 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8021ee:	83 ec 08             	sub    $0x8,%esp
  8021f1:	ff 75 0c             	pushl  0xc(%ebp)
  8021f4:	53                   	push   %ebx
  8021f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f8:	ff d0                	call   *%eax
  8021fa:	83 c4 10             	add    $0x10,%esp
			break;
  8021fd:	eb 23                	jmp    802222 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8021ff:	83 ec 08             	sub    $0x8,%esp
  802202:	ff 75 0c             	pushl  0xc(%ebp)
  802205:	6a 25                	push   $0x25
  802207:	8b 45 08             	mov    0x8(%ebp),%eax
  80220a:	ff d0                	call   *%eax
  80220c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80220f:	ff 4d 10             	decl   0x10(%ebp)
  802212:	eb 03                	jmp    802217 <vprintfmt+0x3b1>
  802214:	ff 4d 10             	decl   0x10(%ebp)
  802217:	8b 45 10             	mov    0x10(%ebp),%eax
  80221a:	48                   	dec    %eax
  80221b:	8a 00                	mov    (%eax),%al
  80221d:	3c 25                	cmp    $0x25,%al
  80221f:	75 f3                	jne    802214 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  802221:	90                   	nop
		}
	}
  802222:	e9 47 fc ff ff       	jmp    801e6e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  802227:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  802228:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80222b:	5b                   	pop    %ebx
  80222c:	5e                   	pop    %esi
  80222d:	5d                   	pop    %ebp
  80222e:	c3                   	ret    

0080222f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80222f:	55                   	push   %ebp
  802230:	89 e5                	mov    %esp,%ebp
  802232:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  802235:	8d 45 10             	lea    0x10(%ebp),%eax
  802238:	83 c0 04             	add    $0x4,%eax
  80223b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80223e:	8b 45 10             	mov    0x10(%ebp),%eax
  802241:	ff 75 f4             	pushl  -0xc(%ebp)
  802244:	50                   	push   %eax
  802245:	ff 75 0c             	pushl  0xc(%ebp)
  802248:	ff 75 08             	pushl  0x8(%ebp)
  80224b:	e8 16 fc ff ff       	call   801e66 <vprintfmt>
  802250:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  802253:	90                   	nop
  802254:	c9                   	leave  
  802255:	c3                   	ret    

00802256 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  802256:	55                   	push   %ebp
  802257:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  802259:	8b 45 0c             	mov    0xc(%ebp),%eax
  80225c:	8b 40 08             	mov    0x8(%eax),%eax
  80225f:	8d 50 01             	lea    0x1(%eax),%edx
  802262:	8b 45 0c             	mov    0xc(%ebp),%eax
  802265:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  802268:	8b 45 0c             	mov    0xc(%ebp),%eax
  80226b:	8b 10                	mov    (%eax),%edx
  80226d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802270:	8b 40 04             	mov    0x4(%eax),%eax
  802273:	39 c2                	cmp    %eax,%edx
  802275:	73 12                	jae    802289 <sprintputch+0x33>
		*b->buf++ = ch;
  802277:	8b 45 0c             	mov    0xc(%ebp),%eax
  80227a:	8b 00                	mov    (%eax),%eax
  80227c:	8d 48 01             	lea    0x1(%eax),%ecx
  80227f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802282:	89 0a                	mov    %ecx,(%edx)
  802284:	8b 55 08             	mov    0x8(%ebp),%edx
  802287:	88 10                	mov    %dl,(%eax)
}
  802289:	90                   	nop
  80228a:	5d                   	pop    %ebp
  80228b:	c3                   	ret    

0080228c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80228c:	55                   	push   %ebp
  80228d:	89 e5                	mov    %esp,%ebp
  80228f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  802292:	8b 45 08             	mov    0x8(%ebp),%eax
  802295:	89 45 ec             	mov    %eax,-0x14(%ebp)
  802298:	8b 45 0c             	mov    0xc(%ebp),%eax
  80229b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80229e:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a1:	01 d0                	add    %edx,%eax
  8022a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8022a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8022ad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8022b1:	74 06                	je     8022b9 <vsnprintf+0x2d>
  8022b3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8022b7:	7f 07                	jg     8022c0 <vsnprintf+0x34>
		return -E_INVAL;
  8022b9:	b8 03 00 00 00       	mov    $0x3,%eax
  8022be:	eb 20                	jmp    8022e0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8022c0:	ff 75 14             	pushl  0x14(%ebp)
  8022c3:	ff 75 10             	pushl  0x10(%ebp)
  8022c6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8022c9:	50                   	push   %eax
  8022ca:	68 56 22 80 00       	push   $0x802256
  8022cf:	e8 92 fb ff ff       	call   801e66 <vprintfmt>
  8022d4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8022d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8022da:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8022dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8022e0:	c9                   	leave  
  8022e1:	c3                   	ret    

008022e2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8022e2:	55                   	push   %ebp
  8022e3:	89 e5                	mov    %esp,%ebp
  8022e5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8022e8:	8d 45 10             	lea    0x10(%ebp),%eax
  8022eb:	83 c0 04             	add    $0x4,%eax
  8022ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8022f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8022f4:	ff 75 f4             	pushl  -0xc(%ebp)
  8022f7:	50                   	push   %eax
  8022f8:	ff 75 0c             	pushl  0xc(%ebp)
  8022fb:	ff 75 08             	pushl  0x8(%ebp)
  8022fe:	e8 89 ff ff ff       	call   80228c <vsnprintf>
  802303:	83 c4 10             	add    $0x10,%esp
  802306:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  802309:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80230c:	c9                   	leave  
  80230d:	c3                   	ret    

0080230e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80230e:	55                   	push   %ebp
  80230f:	89 e5                	mov    %esp,%ebp
  802311:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  802314:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80231b:	eb 06                	jmp    802323 <strlen+0x15>
		n++;
  80231d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  802320:	ff 45 08             	incl   0x8(%ebp)
  802323:	8b 45 08             	mov    0x8(%ebp),%eax
  802326:	8a 00                	mov    (%eax),%al
  802328:	84 c0                	test   %al,%al
  80232a:	75 f1                	jne    80231d <strlen+0xf>
		n++;
	return n;
  80232c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80232f:	c9                   	leave  
  802330:	c3                   	ret    

00802331 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  802331:	55                   	push   %ebp
  802332:	89 e5                	mov    %esp,%ebp
  802334:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  802337:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80233e:	eb 09                	jmp    802349 <strnlen+0x18>
		n++;
  802340:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  802343:	ff 45 08             	incl   0x8(%ebp)
  802346:	ff 4d 0c             	decl   0xc(%ebp)
  802349:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80234d:	74 09                	je     802358 <strnlen+0x27>
  80234f:	8b 45 08             	mov    0x8(%ebp),%eax
  802352:	8a 00                	mov    (%eax),%al
  802354:	84 c0                	test   %al,%al
  802356:	75 e8                	jne    802340 <strnlen+0xf>
		n++;
	return n;
  802358:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80235b:	c9                   	leave  
  80235c:	c3                   	ret    

0080235d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80235d:	55                   	push   %ebp
  80235e:	89 e5                	mov    %esp,%ebp
  802360:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  802363:	8b 45 08             	mov    0x8(%ebp),%eax
  802366:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  802369:	90                   	nop
  80236a:	8b 45 08             	mov    0x8(%ebp),%eax
  80236d:	8d 50 01             	lea    0x1(%eax),%edx
  802370:	89 55 08             	mov    %edx,0x8(%ebp)
  802373:	8b 55 0c             	mov    0xc(%ebp),%edx
  802376:	8d 4a 01             	lea    0x1(%edx),%ecx
  802379:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80237c:	8a 12                	mov    (%edx),%dl
  80237e:	88 10                	mov    %dl,(%eax)
  802380:	8a 00                	mov    (%eax),%al
  802382:	84 c0                	test   %al,%al
  802384:	75 e4                	jne    80236a <strcpy+0xd>
		/* do nothing */;
	return ret;
  802386:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802389:	c9                   	leave  
  80238a:	c3                   	ret    

0080238b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80238b:	55                   	push   %ebp
  80238c:	89 e5                	mov    %esp,%ebp
  80238e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  802391:	8b 45 08             	mov    0x8(%ebp),%eax
  802394:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  802397:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80239e:	eb 1f                	jmp    8023bf <strncpy+0x34>
		*dst++ = *src;
  8023a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8023a3:	8d 50 01             	lea    0x1(%eax),%edx
  8023a6:	89 55 08             	mov    %edx,0x8(%ebp)
  8023a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023ac:	8a 12                	mov    (%edx),%dl
  8023ae:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8023b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023b3:	8a 00                	mov    (%eax),%al
  8023b5:	84 c0                	test   %al,%al
  8023b7:	74 03                	je     8023bc <strncpy+0x31>
			src++;
  8023b9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8023bc:	ff 45 fc             	incl   -0x4(%ebp)
  8023bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023c2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8023c5:	72 d9                	jb     8023a0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8023c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8023ca:	c9                   	leave  
  8023cb:	c3                   	ret    

008023cc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8023cc:	55                   	push   %ebp
  8023cd:	89 e5                	mov    %esp,%ebp
  8023cf:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8023d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8023d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8023d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8023dc:	74 30                	je     80240e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8023de:	eb 16                	jmp    8023f6 <strlcpy+0x2a>
			*dst++ = *src++;
  8023e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e3:	8d 50 01             	lea    0x1(%eax),%edx
  8023e6:	89 55 08             	mov    %edx,0x8(%ebp)
  8023e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023ec:	8d 4a 01             	lea    0x1(%edx),%ecx
  8023ef:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8023f2:	8a 12                	mov    (%edx),%dl
  8023f4:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8023f6:	ff 4d 10             	decl   0x10(%ebp)
  8023f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8023fd:	74 09                	je     802408 <strlcpy+0x3c>
  8023ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  802402:	8a 00                	mov    (%eax),%al
  802404:	84 c0                	test   %al,%al
  802406:	75 d8                	jne    8023e0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  802408:	8b 45 08             	mov    0x8(%ebp),%eax
  80240b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80240e:	8b 55 08             	mov    0x8(%ebp),%edx
  802411:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802414:	29 c2                	sub    %eax,%edx
  802416:	89 d0                	mov    %edx,%eax
}
  802418:	c9                   	leave  
  802419:	c3                   	ret    

0080241a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80241a:	55                   	push   %ebp
  80241b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80241d:	eb 06                	jmp    802425 <strcmp+0xb>
		p++, q++;
  80241f:	ff 45 08             	incl   0x8(%ebp)
  802422:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  802425:	8b 45 08             	mov    0x8(%ebp),%eax
  802428:	8a 00                	mov    (%eax),%al
  80242a:	84 c0                	test   %al,%al
  80242c:	74 0e                	je     80243c <strcmp+0x22>
  80242e:	8b 45 08             	mov    0x8(%ebp),%eax
  802431:	8a 10                	mov    (%eax),%dl
  802433:	8b 45 0c             	mov    0xc(%ebp),%eax
  802436:	8a 00                	mov    (%eax),%al
  802438:	38 c2                	cmp    %al,%dl
  80243a:	74 e3                	je     80241f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80243c:	8b 45 08             	mov    0x8(%ebp),%eax
  80243f:	8a 00                	mov    (%eax),%al
  802441:	0f b6 d0             	movzbl %al,%edx
  802444:	8b 45 0c             	mov    0xc(%ebp),%eax
  802447:	8a 00                	mov    (%eax),%al
  802449:	0f b6 c0             	movzbl %al,%eax
  80244c:	29 c2                	sub    %eax,%edx
  80244e:	89 d0                	mov    %edx,%eax
}
  802450:	5d                   	pop    %ebp
  802451:	c3                   	ret    

00802452 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  802452:	55                   	push   %ebp
  802453:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  802455:	eb 09                	jmp    802460 <strncmp+0xe>
		n--, p++, q++;
  802457:	ff 4d 10             	decl   0x10(%ebp)
  80245a:	ff 45 08             	incl   0x8(%ebp)
  80245d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  802460:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802464:	74 17                	je     80247d <strncmp+0x2b>
  802466:	8b 45 08             	mov    0x8(%ebp),%eax
  802469:	8a 00                	mov    (%eax),%al
  80246b:	84 c0                	test   %al,%al
  80246d:	74 0e                	je     80247d <strncmp+0x2b>
  80246f:	8b 45 08             	mov    0x8(%ebp),%eax
  802472:	8a 10                	mov    (%eax),%dl
  802474:	8b 45 0c             	mov    0xc(%ebp),%eax
  802477:	8a 00                	mov    (%eax),%al
  802479:	38 c2                	cmp    %al,%dl
  80247b:	74 da                	je     802457 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80247d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802481:	75 07                	jne    80248a <strncmp+0x38>
		return 0;
  802483:	b8 00 00 00 00       	mov    $0x0,%eax
  802488:	eb 14                	jmp    80249e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80248a:	8b 45 08             	mov    0x8(%ebp),%eax
  80248d:	8a 00                	mov    (%eax),%al
  80248f:	0f b6 d0             	movzbl %al,%edx
  802492:	8b 45 0c             	mov    0xc(%ebp),%eax
  802495:	8a 00                	mov    (%eax),%al
  802497:	0f b6 c0             	movzbl %al,%eax
  80249a:	29 c2                	sub    %eax,%edx
  80249c:	89 d0                	mov    %edx,%eax
}
  80249e:	5d                   	pop    %ebp
  80249f:	c3                   	ret    

008024a0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8024a0:	55                   	push   %ebp
  8024a1:	89 e5                	mov    %esp,%ebp
  8024a3:	83 ec 04             	sub    $0x4,%esp
  8024a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024a9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8024ac:	eb 12                	jmp    8024c0 <strchr+0x20>
		if (*s == c)
  8024ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b1:	8a 00                	mov    (%eax),%al
  8024b3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8024b6:	75 05                	jne    8024bd <strchr+0x1d>
			return (char *) s;
  8024b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8024bb:	eb 11                	jmp    8024ce <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8024bd:	ff 45 08             	incl   0x8(%ebp)
  8024c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8024c3:	8a 00                	mov    (%eax),%al
  8024c5:	84 c0                	test   %al,%al
  8024c7:	75 e5                	jne    8024ae <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8024c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024ce:	c9                   	leave  
  8024cf:	c3                   	ret    

008024d0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8024d0:	55                   	push   %ebp
  8024d1:	89 e5                	mov    %esp,%ebp
  8024d3:	83 ec 04             	sub    $0x4,%esp
  8024d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024d9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8024dc:	eb 0d                	jmp    8024eb <strfind+0x1b>
		if (*s == c)
  8024de:	8b 45 08             	mov    0x8(%ebp),%eax
  8024e1:	8a 00                	mov    (%eax),%al
  8024e3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8024e6:	74 0e                	je     8024f6 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8024e8:	ff 45 08             	incl   0x8(%ebp)
  8024eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ee:	8a 00                	mov    (%eax),%al
  8024f0:	84 c0                	test   %al,%al
  8024f2:	75 ea                	jne    8024de <strfind+0xe>
  8024f4:	eb 01                	jmp    8024f7 <strfind+0x27>
		if (*s == c)
			break;
  8024f6:	90                   	nop
	return (char *) s;
  8024f7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8024fa:	c9                   	leave  
  8024fb:	c3                   	ret    

008024fc <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8024fc:	55                   	push   %ebp
  8024fd:	89 e5                	mov    %esp,%ebp
  8024ff:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  802502:	8b 45 08             	mov    0x8(%ebp),%eax
  802505:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  802508:	8b 45 10             	mov    0x10(%ebp),%eax
  80250b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80250e:	eb 0e                	jmp    80251e <memset+0x22>
		*p++ = c;
  802510:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802513:	8d 50 01             	lea    0x1(%eax),%edx
  802516:	89 55 fc             	mov    %edx,-0x4(%ebp)
  802519:	8b 55 0c             	mov    0xc(%ebp),%edx
  80251c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80251e:	ff 4d f8             	decl   -0x8(%ebp)
  802521:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  802525:	79 e9                	jns    802510 <memset+0x14>
		*p++ = c;

	return v;
  802527:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80252a:	c9                   	leave  
  80252b:	c3                   	ret    

0080252c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80252c:	55                   	push   %ebp
  80252d:	89 e5                	mov    %esp,%ebp
  80252f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  802532:	8b 45 0c             	mov    0xc(%ebp),%eax
  802535:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  802538:	8b 45 08             	mov    0x8(%ebp),%eax
  80253b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80253e:	eb 16                	jmp    802556 <memcpy+0x2a>
		*d++ = *s++;
  802540:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802543:	8d 50 01             	lea    0x1(%eax),%edx
  802546:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802549:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80254c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80254f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802552:	8a 12                	mov    (%edx),%dl
  802554:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  802556:	8b 45 10             	mov    0x10(%ebp),%eax
  802559:	8d 50 ff             	lea    -0x1(%eax),%edx
  80255c:	89 55 10             	mov    %edx,0x10(%ebp)
  80255f:	85 c0                	test   %eax,%eax
  802561:	75 dd                	jne    802540 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  802563:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802566:	c9                   	leave  
  802567:	c3                   	ret    

00802568 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  802568:	55                   	push   %ebp
  802569:	89 e5                	mov    %esp,%ebp
  80256b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80256e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802571:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  802574:	8b 45 08             	mov    0x8(%ebp),%eax
  802577:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80257a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80257d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802580:	73 50                	jae    8025d2 <memmove+0x6a>
  802582:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802585:	8b 45 10             	mov    0x10(%ebp),%eax
  802588:	01 d0                	add    %edx,%eax
  80258a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80258d:	76 43                	jbe    8025d2 <memmove+0x6a>
		s += n;
  80258f:	8b 45 10             	mov    0x10(%ebp),%eax
  802592:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  802595:	8b 45 10             	mov    0x10(%ebp),%eax
  802598:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80259b:	eb 10                	jmp    8025ad <memmove+0x45>
			*--d = *--s;
  80259d:	ff 4d f8             	decl   -0x8(%ebp)
  8025a0:	ff 4d fc             	decl   -0x4(%ebp)
  8025a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8025a6:	8a 10                	mov    (%eax),%dl
  8025a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025ab:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8025ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8025b0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8025b3:	89 55 10             	mov    %edx,0x10(%ebp)
  8025b6:	85 c0                	test   %eax,%eax
  8025b8:	75 e3                	jne    80259d <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8025ba:	eb 23                	jmp    8025df <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8025bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025bf:	8d 50 01             	lea    0x1(%eax),%edx
  8025c2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8025c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8025c8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8025cb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8025ce:	8a 12                	mov    (%edx),%dl
  8025d0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8025d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8025d5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8025d8:	89 55 10             	mov    %edx,0x10(%ebp)
  8025db:	85 c0                	test   %eax,%eax
  8025dd:	75 dd                	jne    8025bc <memmove+0x54>
			*d++ = *s++;

	return dst;
  8025df:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8025e2:	c9                   	leave  
  8025e3:	c3                   	ret    

008025e4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8025e4:	55                   	push   %ebp
  8025e5:	89 e5                	mov    %esp,%ebp
  8025e7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8025ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8025ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8025f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8025f3:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8025f6:	eb 2a                	jmp    802622 <memcmp+0x3e>
		if (*s1 != *s2)
  8025f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8025fb:	8a 10                	mov    (%eax),%dl
  8025fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802600:	8a 00                	mov    (%eax),%al
  802602:	38 c2                	cmp    %al,%dl
  802604:	74 16                	je     80261c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  802606:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802609:	8a 00                	mov    (%eax),%al
  80260b:	0f b6 d0             	movzbl %al,%edx
  80260e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802611:	8a 00                	mov    (%eax),%al
  802613:	0f b6 c0             	movzbl %al,%eax
  802616:	29 c2                	sub    %eax,%edx
  802618:	89 d0                	mov    %edx,%eax
  80261a:	eb 18                	jmp    802634 <memcmp+0x50>
		s1++, s2++;
  80261c:	ff 45 fc             	incl   -0x4(%ebp)
  80261f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  802622:	8b 45 10             	mov    0x10(%ebp),%eax
  802625:	8d 50 ff             	lea    -0x1(%eax),%edx
  802628:	89 55 10             	mov    %edx,0x10(%ebp)
  80262b:	85 c0                	test   %eax,%eax
  80262d:	75 c9                	jne    8025f8 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80262f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802634:	c9                   	leave  
  802635:	c3                   	ret    

00802636 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  802636:	55                   	push   %ebp
  802637:	89 e5                	mov    %esp,%ebp
  802639:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80263c:	8b 55 08             	mov    0x8(%ebp),%edx
  80263f:	8b 45 10             	mov    0x10(%ebp),%eax
  802642:	01 d0                	add    %edx,%eax
  802644:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  802647:	eb 15                	jmp    80265e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  802649:	8b 45 08             	mov    0x8(%ebp),%eax
  80264c:	8a 00                	mov    (%eax),%al
  80264e:	0f b6 d0             	movzbl %al,%edx
  802651:	8b 45 0c             	mov    0xc(%ebp),%eax
  802654:	0f b6 c0             	movzbl %al,%eax
  802657:	39 c2                	cmp    %eax,%edx
  802659:	74 0d                	je     802668 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80265b:	ff 45 08             	incl   0x8(%ebp)
  80265e:	8b 45 08             	mov    0x8(%ebp),%eax
  802661:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  802664:	72 e3                	jb     802649 <memfind+0x13>
  802666:	eb 01                	jmp    802669 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  802668:	90                   	nop
	return (void *) s;
  802669:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80266c:	c9                   	leave  
  80266d:	c3                   	ret    

0080266e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80266e:	55                   	push   %ebp
  80266f:	89 e5                	mov    %esp,%ebp
  802671:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  802674:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80267b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802682:	eb 03                	jmp    802687 <strtol+0x19>
		s++;
  802684:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802687:	8b 45 08             	mov    0x8(%ebp),%eax
  80268a:	8a 00                	mov    (%eax),%al
  80268c:	3c 20                	cmp    $0x20,%al
  80268e:	74 f4                	je     802684 <strtol+0x16>
  802690:	8b 45 08             	mov    0x8(%ebp),%eax
  802693:	8a 00                	mov    (%eax),%al
  802695:	3c 09                	cmp    $0x9,%al
  802697:	74 eb                	je     802684 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  802699:	8b 45 08             	mov    0x8(%ebp),%eax
  80269c:	8a 00                	mov    (%eax),%al
  80269e:	3c 2b                	cmp    $0x2b,%al
  8026a0:	75 05                	jne    8026a7 <strtol+0x39>
		s++;
  8026a2:	ff 45 08             	incl   0x8(%ebp)
  8026a5:	eb 13                	jmp    8026ba <strtol+0x4c>
	else if (*s == '-')
  8026a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8026aa:	8a 00                	mov    (%eax),%al
  8026ac:	3c 2d                	cmp    $0x2d,%al
  8026ae:	75 0a                	jne    8026ba <strtol+0x4c>
		s++, neg = 1;
  8026b0:	ff 45 08             	incl   0x8(%ebp)
  8026b3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8026ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8026be:	74 06                	je     8026c6 <strtol+0x58>
  8026c0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8026c4:	75 20                	jne    8026e6 <strtol+0x78>
  8026c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8026c9:	8a 00                	mov    (%eax),%al
  8026cb:	3c 30                	cmp    $0x30,%al
  8026cd:	75 17                	jne    8026e6 <strtol+0x78>
  8026cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8026d2:	40                   	inc    %eax
  8026d3:	8a 00                	mov    (%eax),%al
  8026d5:	3c 78                	cmp    $0x78,%al
  8026d7:	75 0d                	jne    8026e6 <strtol+0x78>
		s += 2, base = 16;
  8026d9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8026dd:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8026e4:	eb 28                	jmp    80270e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8026e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8026ea:	75 15                	jne    802701 <strtol+0x93>
  8026ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8026ef:	8a 00                	mov    (%eax),%al
  8026f1:	3c 30                	cmp    $0x30,%al
  8026f3:	75 0c                	jne    802701 <strtol+0x93>
		s++, base = 8;
  8026f5:	ff 45 08             	incl   0x8(%ebp)
  8026f8:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8026ff:	eb 0d                	jmp    80270e <strtol+0xa0>
	else if (base == 0)
  802701:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802705:	75 07                	jne    80270e <strtol+0xa0>
		base = 10;
  802707:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80270e:	8b 45 08             	mov    0x8(%ebp),%eax
  802711:	8a 00                	mov    (%eax),%al
  802713:	3c 2f                	cmp    $0x2f,%al
  802715:	7e 19                	jle    802730 <strtol+0xc2>
  802717:	8b 45 08             	mov    0x8(%ebp),%eax
  80271a:	8a 00                	mov    (%eax),%al
  80271c:	3c 39                	cmp    $0x39,%al
  80271e:	7f 10                	jg     802730 <strtol+0xc2>
			dig = *s - '0';
  802720:	8b 45 08             	mov    0x8(%ebp),%eax
  802723:	8a 00                	mov    (%eax),%al
  802725:	0f be c0             	movsbl %al,%eax
  802728:	83 e8 30             	sub    $0x30,%eax
  80272b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80272e:	eb 42                	jmp    802772 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  802730:	8b 45 08             	mov    0x8(%ebp),%eax
  802733:	8a 00                	mov    (%eax),%al
  802735:	3c 60                	cmp    $0x60,%al
  802737:	7e 19                	jle    802752 <strtol+0xe4>
  802739:	8b 45 08             	mov    0x8(%ebp),%eax
  80273c:	8a 00                	mov    (%eax),%al
  80273e:	3c 7a                	cmp    $0x7a,%al
  802740:	7f 10                	jg     802752 <strtol+0xe4>
			dig = *s - 'a' + 10;
  802742:	8b 45 08             	mov    0x8(%ebp),%eax
  802745:	8a 00                	mov    (%eax),%al
  802747:	0f be c0             	movsbl %al,%eax
  80274a:	83 e8 57             	sub    $0x57,%eax
  80274d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802750:	eb 20                	jmp    802772 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  802752:	8b 45 08             	mov    0x8(%ebp),%eax
  802755:	8a 00                	mov    (%eax),%al
  802757:	3c 40                	cmp    $0x40,%al
  802759:	7e 39                	jle    802794 <strtol+0x126>
  80275b:	8b 45 08             	mov    0x8(%ebp),%eax
  80275e:	8a 00                	mov    (%eax),%al
  802760:	3c 5a                	cmp    $0x5a,%al
  802762:	7f 30                	jg     802794 <strtol+0x126>
			dig = *s - 'A' + 10;
  802764:	8b 45 08             	mov    0x8(%ebp),%eax
  802767:	8a 00                	mov    (%eax),%al
  802769:	0f be c0             	movsbl %al,%eax
  80276c:	83 e8 37             	sub    $0x37,%eax
  80276f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  802772:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802775:	3b 45 10             	cmp    0x10(%ebp),%eax
  802778:	7d 19                	jge    802793 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80277a:	ff 45 08             	incl   0x8(%ebp)
  80277d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802780:	0f af 45 10          	imul   0x10(%ebp),%eax
  802784:	89 c2                	mov    %eax,%edx
  802786:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802789:	01 d0                	add    %edx,%eax
  80278b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80278e:	e9 7b ff ff ff       	jmp    80270e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  802793:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  802794:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802798:	74 08                	je     8027a2 <strtol+0x134>
		*endptr = (char *) s;
  80279a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80279d:	8b 55 08             	mov    0x8(%ebp),%edx
  8027a0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8027a2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8027a6:	74 07                	je     8027af <strtol+0x141>
  8027a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8027ab:	f7 d8                	neg    %eax
  8027ad:	eb 03                	jmp    8027b2 <strtol+0x144>
  8027af:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8027b2:	c9                   	leave  
  8027b3:	c3                   	ret    

008027b4 <ltostr>:

void
ltostr(long value, char *str)
{
  8027b4:	55                   	push   %ebp
  8027b5:	89 e5                	mov    %esp,%ebp
  8027b7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8027ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8027c1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8027c8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8027cc:	79 13                	jns    8027e1 <ltostr+0x2d>
	{
		neg = 1;
  8027ce:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8027d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8027d8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8027db:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8027de:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8027e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8027e4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8027e9:	99                   	cltd   
  8027ea:	f7 f9                	idiv   %ecx
  8027ec:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8027ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8027f2:	8d 50 01             	lea    0x1(%eax),%edx
  8027f5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8027f8:	89 c2                	mov    %eax,%edx
  8027fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8027fd:	01 d0                	add    %edx,%eax
  8027ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802802:	83 c2 30             	add    $0x30,%edx
  802805:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  802807:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80280a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80280f:	f7 e9                	imul   %ecx
  802811:	c1 fa 02             	sar    $0x2,%edx
  802814:	89 c8                	mov    %ecx,%eax
  802816:	c1 f8 1f             	sar    $0x1f,%eax
  802819:	29 c2                	sub    %eax,%edx
  80281b:	89 d0                	mov    %edx,%eax
  80281d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  802820:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802823:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802828:	f7 e9                	imul   %ecx
  80282a:	c1 fa 02             	sar    $0x2,%edx
  80282d:	89 c8                	mov    %ecx,%eax
  80282f:	c1 f8 1f             	sar    $0x1f,%eax
  802832:	29 c2                	sub    %eax,%edx
  802834:	89 d0                	mov    %edx,%eax
  802836:	c1 e0 02             	shl    $0x2,%eax
  802839:	01 d0                	add    %edx,%eax
  80283b:	01 c0                	add    %eax,%eax
  80283d:	29 c1                	sub    %eax,%ecx
  80283f:	89 ca                	mov    %ecx,%edx
  802841:	85 d2                	test   %edx,%edx
  802843:	75 9c                	jne    8027e1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  802845:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80284c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80284f:	48                   	dec    %eax
  802850:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  802853:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802857:	74 3d                	je     802896 <ltostr+0xe2>
		start = 1 ;
  802859:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  802860:	eb 34                	jmp    802896 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  802862:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802865:	8b 45 0c             	mov    0xc(%ebp),%eax
  802868:	01 d0                	add    %edx,%eax
  80286a:	8a 00                	mov    (%eax),%al
  80286c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80286f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802872:	8b 45 0c             	mov    0xc(%ebp),%eax
  802875:	01 c2                	add    %eax,%edx
  802877:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80287a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80287d:	01 c8                	add    %ecx,%eax
  80287f:	8a 00                	mov    (%eax),%al
  802881:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  802883:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802886:	8b 45 0c             	mov    0xc(%ebp),%eax
  802889:	01 c2                	add    %eax,%edx
  80288b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80288e:	88 02                	mov    %al,(%edx)
		start++ ;
  802890:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  802893:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  802896:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802899:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80289c:	7c c4                	jl     802862 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80289e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8028a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8028a4:	01 d0                	add    %edx,%eax
  8028a6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8028a9:	90                   	nop
  8028aa:	c9                   	leave  
  8028ab:	c3                   	ret    

008028ac <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8028ac:	55                   	push   %ebp
  8028ad:	89 e5                	mov    %esp,%ebp
  8028af:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8028b2:	ff 75 08             	pushl  0x8(%ebp)
  8028b5:	e8 54 fa ff ff       	call   80230e <strlen>
  8028ba:	83 c4 04             	add    $0x4,%esp
  8028bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8028c0:	ff 75 0c             	pushl  0xc(%ebp)
  8028c3:	e8 46 fa ff ff       	call   80230e <strlen>
  8028c8:	83 c4 04             	add    $0x4,%esp
  8028cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8028ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8028d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8028dc:	eb 17                	jmp    8028f5 <strcconcat+0x49>
		final[s] = str1[s] ;
  8028de:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8028e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8028e4:	01 c2                	add    %eax,%edx
  8028e6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8028e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8028ec:	01 c8                	add    %ecx,%eax
  8028ee:	8a 00                	mov    (%eax),%al
  8028f0:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8028f2:	ff 45 fc             	incl   -0x4(%ebp)
  8028f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8028f8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8028fb:	7c e1                	jl     8028de <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8028fd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  802904:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80290b:	eb 1f                	jmp    80292c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80290d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802910:	8d 50 01             	lea    0x1(%eax),%edx
  802913:	89 55 fc             	mov    %edx,-0x4(%ebp)
  802916:	89 c2                	mov    %eax,%edx
  802918:	8b 45 10             	mov    0x10(%ebp),%eax
  80291b:	01 c2                	add    %eax,%edx
  80291d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  802920:	8b 45 0c             	mov    0xc(%ebp),%eax
  802923:	01 c8                	add    %ecx,%eax
  802925:	8a 00                	mov    (%eax),%al
  802927:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  802929:	ff 45 f8             	incl   -0x8(%ebp)
  80292c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80292f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802932:	7c d9                	jl     80290d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  802934:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802937:	8b 45 10             	mov    0x10(%ebp),%eax
  80293a:	01 d0                	add    %edx,%eax
  80293c:	c6 00 00             	movb   $0x0,(%eax)
}
  80293f:	90                   	nop
  802940:	c9                   	leave  
  802941:	c3                   	ret    

00802942 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  802942:	55                   	push   %ebp
  802943:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  802945:	8b 45 14             	mov    0x14(%ebp),%eax
  802948:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80294e:	8b 45 14             	mov    0x14(%ebp),%eax
  802951:	8b 00                	mov    (%eax),%eax
  802953:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80295a:	8b 45 10             	mov    0x10(%ebp),%eax
  80295d:	01 d0                	add    %edx,%eax
  80295f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802965:	eb 0c                	jmp    802973 <strsplit+0x31>
			*string++ = 0;
  802967:	8b 45 08             	mov    0x8(%ebp),%eax
  80296a:	8d 50 01             	lea    0x1(%eax),%edx
  80296d:	89 55 08             	mov    %edx,0x8(%ebp)
  802970:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802973:	8b 45 08             	mov    0x8(%ebp),%eax
  802976:	8a 00                	mov    (%eax),%al
  802978:	84 c0                	test   %al,%al
  80297a:	74 18                	je     802994 <strsplit+0x52>
  80297c:	8b 45 08             	mov    0x8(%ebp),%eax
  80297f:	8a 00                	mov    (%eax),%al
  802981:	0f be c0             	movsbl %al,%eax
  802984:	50                   	push   %eax
  802985:	ff 75 0c             	pushl  0xc(%ebp)
  802988:	e8 13 fb ff ff       	call   8024a0 <strchr>
  80298d:	83 c4 08             	add    $0x8,%esp
  802990:	85 c0                	test   %eax,%eax
  802992:	75 d3                	jne    802967 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  802994:	8b 45 08             	mov    0x8(%ebp),%eax
  802997:	8a 00                	mov    (%eax),%al
  802999:	84 c0                	test   %al,%al
  80299b:	74 5a                	je     8029f7 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80299d:	8b 45 14             	mov    0x14(%ebp),%eax
  8029a0:	8b 00                	mov    (%eax),%eax
  8029a2:	83 f8 0f             	cmp    $0xf,%eax
  8029a5:	75 07                	jne    8029ae <strsplit+0x6c>
		{
			return 0;
  8029a7:	b8 00 00 00 00       	mov    $0x0,%eax
  8029ac:	eb 66                	jmp    802a14 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8029ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8029b1:	8b 00                	mov    (%eax),%eax
  8029b3:	8d 48 01             	lea    0x1(%eax),%ecx
  8029b6:	8b 55 14             	mov    0x14(%ebp),%edx
  8029b9:	89 0a                	mov    %ecx,(%edx)
  8029bb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8029c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8029c5:	01 c2                	add    %eax,%edx
  8029c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8029ca:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8029cc:	eb 03                	jmp    8029d1 <strsplit+0x8f>
			string++;
  8029ce:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8029d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8029d4:	8a 00                	mov    (%eax),%al
  8029d6:	84 c0                	test   %al,%al
  8029d8:	74 8b                	je     802965 <strsplit+0x23>
  8029da:	8b 45 08             	mov    0x8(%ebp),%eax
  8029dd:	8a 00                	mov    (%eax),%al
  8029df:	0f be c0             	movsbl %al,%eax
  8029e2:	50                   	push   %eax
  8029e3:	ff 75 0c             	pushl  0xc(%ebp)
  8029e6:	e8 b5 fa ff ff       	call   8024a0 <strchr>
  8029eb:	83 c4 08             	add    $0x8,%esp
  8029ee:	85 c0                	test   %eax,%eax
  8029f0:	74 dc                	je     8029ce <strsplit+0x8c>
			string++;
	}
  8029f2:	e9 6e ff ff ff       	jmp    802965 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8029f7:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8029f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8029fb:	8b 00                	mov    (%eax),%eax
  8029fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802a04:	8b 45 10             	mov    0x10(%ebp),%eax
  802a07:	01 d0                	add    %edx,%eax
  802a09:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  802a0f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  802a14:	c9                   	leave  
  802a15:	c3                   	ret    

00802a16 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  802a16:	55                   	push   %ebp
  802a17:	89 e5                	mov    %esp,%ebp
  802a19:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  802a1c:	e8 3b 09 00 00       	call   80335c <sys_isUHeapPlacementStrategyFIRSTFIT>
  802a21:	85 c0                	test   %eax,%eax
  802a23:	0f 84 3a 01 00 00    	je     802b63 <malloc+0x14d>

		if(pl == 0){
  802a29:	a1 28 40 80 00       	mov    0x804028,%eax
  802a2e:	85 c0                	test   %eax,%eax
  802a30:	75 24                	jne    802a56 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  802a32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  802a39:	eb 11                	jmp    802a4c <malloc+0x36>
				arr[k] = -10000;
  802a3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a3e:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  802a45:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  802a49:	ff 45 f4             	incl   -0xc(%ebp)
  802a4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a4f:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802a54:	76 e5                	jbe    802a3b <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  802a56:	c7 05 28 40 80 00 01 	movl   $0x1,0x804028
  802a5d:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  802a60:	8b 45 08             	mov    0x8(%ebp),%eax
  802a63:	c1 e8 0c             	shr    $0xc,%eax
  802a66:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  802a69:	8b 45 08             	mov    0x8(%ebp),%eax
  802a6c:	25 ff 0f 00 00       	and    $0xfff,%eax
  802a71:	85 c0                	test   %eax,%eax
  802a73:	74 03                	je     802a78 <malloc+0x62>
			x++;
  802a75:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  802a78:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  802a7f:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  802a86:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  802a8d:	eb 66                	jmp    802af5 <malloc+0xdf>
			if( arr[k] == -10000){
  802a8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802a92:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802a99:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  802a9e:	75 52                	jne    802af2 <malloc+0xdc>
				uint32 w = 0 ;
  802aa0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  802aa7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802aaa:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  802aad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802ab0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  802ab3:	eb 09                	jmp    802abe <malloc+0xa8>
  802ab5:	ff 45 e0             	incl   -0x20(%ebp)
  802ab8:	ff 45 dc             	incl   -0x24(%ebp)
  802abb:	ff 45 e4             	incl   -0x1c(%ebp)
  802abe:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802ac1:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802ac6:	77 19                	ja     802ae1 <malloc+0xcb>
  802ac8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802acb:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802ad2:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  802ad7:	75 08                	jne    802ae1 <malloc+0xcb>
  802ad9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802adc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802adf:	72 d4                	jb     802ab5 <malloc+0x9f>
				if(w >= x){
  802ae1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802ae4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802ae7:	72 09                	jb     802af2 <malloc+0xdc>
					p = 1 ;
  802ae9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  802af0:	eb 0d                	jmp    802aff <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  802af2:	ff 45 e4             	incl   -0x1c(%ebp)
  802af5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802af8:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802afd:	76 90                	jbe    802a8f <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  802aff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  802b03:	75 0a                	jne    802b0f <malloc+0xf9>
  802b05:	b8 00 00 00 00       	mov    $0x0,%eax
  802b0a:	e9 ca 01 00 00       	jmp    802cd9 <malloc+0x2c3>
		int q = idx;
  802b0f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802b12:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  802b15:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  802b1c:	eb 16                	jmp    802b34 <malloc+0x11e>
			arr[q++] = x;
  802b1e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802b21:	8d 50 01             	lea    0x1(%eax),%edx
  802b24:	89 55 d8             	mov    %edx,-0x28(%ebp)
  802b27:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802b2a:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  802b31:	ff 45 d4             	incl   -0x2c(%ebp)
  802b34:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  802b37:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802b3a:	72 e2                	jb     802b1e <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  802b3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802b3f:	05 00 00 08 00       	add    $0x80000,%eax
  802b44:	c1 e0 0c             	shl    $0xc,%eax
  802b47:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  802b4a:	83 ec 08             	sub    $0x8,%esp
  802b4d:	ff 75 f0             	pushl  -0x10(%ebp)
  802b50:	ff 75 ac             	pushl  -0x54(%ebp)
  802b53:	e8 9b 04 00 00       	call   802ff3 <sys_allocateMem>
  802b58:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  802b5b:	8b 45 ac             	mov    -0x54(%ebp),%eax
  802b5e:	e9 76 01 00 00       	jmp    802cd9 <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  802b63:	e8 25 08 00 00       	call   80338d <sys_isUHeapPlacementStrategyBESTFIT>
  802b68:	85 c0                	test   %eax,%eax
  802b6a:	0f 84 64 01 00 00    	je     802cd4 <malloc+0x2be>
		if(pl == 0){
  802b70:	a1 28 40 80 00       	mov    0x804028,%eax
  802b75:	85 c0                	test   %eax,%eax
  802b77:	75 24                	jne    802b9d <malloc+0x187>
			for(int k = 0; k < Size; k++){
  802b79:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  802b80:	eb 11                	jmp    802b93 <malloc+0x17d>
				arr[k] = -10000;
  802b82:	8b 45 d0             	mov    -0x30(%ebp),%eax
  802b85:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  802b8c:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  802b90:	ff 45 d0             	incl   -0x30(%ebp)
  802b93:	8b 45 d0             	mov    -0x30(%ebp),%eax
  802b96:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802b9b:	76 e5                	jbe    802b82 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  802b9d:	c7 05 28 40 80 00 01 	movl   $0x1,0x804028
  802ba4:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  802ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  802baa:	c1 e8 0c             	shr    $0xc,%eax
  802bad:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  802bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  802bb3:	25 ff 0f 00 00       	and    $0xfff,%eax
  802bb8:	85 c0                	test   %eax,%eax
  802bba:	74 03                	je     802bbf <malloc+0x1a9>
			x++;
  802bbc:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  802bbf:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  802bc6:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  802bcd:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  802bd4:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  802bdb:	e9 88 00 00 00       	jmp    802c68 <malloc+0x252>
			if(arr[k] == -10000){
  802be0:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802be3:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802bea:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  802bef:	75 64                	jne    802c55 <malloc+0x23f>
				uint32 w = 0 , i;
  802bf1:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  802bf8:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802bfb:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  802bfe:	eb 06                	jmp    802c06 <malloc+0x1f0>
  802c00:	ff 45 b8             	incl   -0x48(%ebp)
  802c03:	ff 45 b4             	incl   -0x4c(%ebp)
  802c06:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  802c0d:	77 11                	ja     802c20 <malloc+0x20a>
  802c0f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  802c12:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802c19:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  802c1e:	74 e0                	je     802c00 <malloc+0x1ea>
				if(w <q && w >= x){
  802c20:	8b 45 b8             	mov    -0x48(%ebp),%eax
  802c23:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  802c26:	73 24                	jae    802c4c <malloc+0x236>
  802c28:	8b 45 b8             	mov    -0x48(%ebp),%eax
  802c2b:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  802c2e:	72 1c                	jb     802c4c <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  802c30:	8b 45 b8             	mov    -0x48(%ebp),%eax
  802c33:	89 45 c8             	mov    %eax,-0x38(%ebp)
  802c36:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  802c3d:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802c40:	89 45 c0             	mov    %eax,-0x40(%ebp)
  802c43:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  802c46:	48                   	dec    %eax
  802c47:	89 45 bc             	mov    %eax,-0x44(%ebp)
  802c4a:	eb 19                	jmp    802c65 <malloc+0x24f>
				}
				else {
					k = i - 1;
  802c4c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  802c4f:	48                   	dec    %eax
  802c50:	89 45 bc             	mov    %eax,-0x44(%ebp)
  802c53:	eb 10                	jmp    802c65 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  802c55:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802c58:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802c5f:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  802c62:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  802c65:	ff 45 bc             	incl   -0x44(%ebp)
  802c68:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802c6b:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802c70:	0f 86 6a ff ff ff    	jbe    802be0 <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  802c76:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  802c7a:	75 07                	jne    802c83 <malloc+0x26d>
  802c7c:	b8 00 00 00 00       	mov    $0x0,%eax
  802c81:	eb 56                	jmp    802cd9 <malloc+0x2c3>
	    q = idx;
  802c83:	8b 45 c0             	mov    -0x40(%ebp),%eax
  802c86:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  802c89:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  802c90:	eb 16                	jmp    802ca8 <malloc+0x292>
			arr[q++] = x;
  802c92:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802c95:	8d 50 01             	lea    0x1(%eax),%edx
  802c98:	89 55 c8             	mov    %edx,-0x38(%ebp)
  802c9b:	8b 55 cc             	mov    -0x34(%ebp),%edx
  802c9e:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  802ca5:	ff 45 b0             	incl   -0x50(%ebp)
  802ca8:	8b 45 b0             	mov    -0x50(%ebp),%eax
  802cab:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  802cae:	72 e2                	jb     802c92 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  802cb0:	8b 45 c0             	mov    -0x40(%ebp),%eax
  802cb3:	05 00 00 08 00       	add    $0x80000,%eax
  802cb8:	c1 e0 0c             	shl    $0xc,%eax
  802cbb:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  802cbe:	83 ec 08             	sub    $0x8,%esp
  802cc1:	ff 75 cc             	pushl  -0x34(%ebp)
  802cc4:	ff 75 a8             	pushl  -0x58(%ebp)
  802cc7:	e8 27 03 00 00       	call   802ff3 <sys_allocateMem>
  802ccc:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  802ccf:	8b 45 a8             	mov    -0x58(%ebp),%eax
  802cd2:	eb 05                	jmp    802cd9 <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  802cd4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802cd9:	c9                   	leave  
  802cda:	c3                   	ret    

00802cdb <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  802cdb:	55                   	push   %ebp
  802cdc:	89 e5                	mov    %esp,%ebp
  802cde:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  802ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  802ce4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  802ce7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802cea:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  802cef:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  802cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  802cf5:	05 00 00 00 80       	add    $0x80000000,%eax
  802cfa:	c1 e8 0c             	shr    $0xc,%eax
  802cfd:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802d04:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  802d07:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  802d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  802d11:	05 00 00 00 80       	add    $0x80000000,%eax
  802d16:	c1 e8 0c             	shr    $0xc,%eax
  802d19:	89 45 f0             	mov    %eax,-0x10(%ebp)
  802d1c:	eb 14                	jmp    802d32 <free+0x57>
		arr[j] = -10000;
  802d1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802d21:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  802d28:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  802d2c:	ff 45 f4             	incl   -0xc(%ebp)
  802d2f:	ff 45 f0             	incl   -0x10(%ebp)
  802d32:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802d35:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  802d38:	72 e4                	jb     802d1e <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  802d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  802d3d:	83 ec 08             	sub    $0x8,%esp
  802d40:	ff 75 e8             	pushl  -0x18(%ebp)
  802d43:	50                   	push   %eax
  802d44:	e8 8e 02 00 00       	call   802fd7 <sys_freeMem>
  802d49:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  802d4c:	90                   	nop
  802d4d:	c9                   	leave  
  802d4e:	c3                   	ret    

00802d4f <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  802d4f:	55                   	push   %ebp
  802d50:	89 e5                	mov    %esp,%ebp
  802d52:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802d55:	83 ec 04             	sub    $0x4,%esp
  802d58:	68 d0 3e 80 00       	push   $0x803ed0
  802d5d:	68 9e 00 00 00       	push   $0x9e
  802d62:	68 f3 3e 80 00       	push   $0x803ef3
  802d67:	e8 69 ec ff ff       	call   8019d5 <_panic>

00802d6c <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  802d6c:	55                   	push   %ebp
  802d6d:	89 e5                	mov    %esp,%ebp
  802d6f:	83 ec 18             	sub    $0x18,%esp
  802d72:	8b 45 10             	mov    0x10(%ebp),%eax
  802d75:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802d78:	83 ec 04             	sub    $0x4,%esp
  802d7b:	68 d0 3e 80 00       	push   $0x803ed0
  802d80:	68 a9 00 00 00       	push   $0xa9
  802d85:	68 f3 3e 80 00       	push   $0x803ef3
  802d8a:	e8 46 ec ff ff       	call   8019d5 <_panic>

00802d8f <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802d8f:	55                   	push   %ebp
  802d90:	89 e5                	mov    %esp,%ebp
  802d92:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802d95:	83 ec 04             	sub    $0x4,%esp
  802d98:	68 d0 3e 80 00       	push   $0x803ed0
  802d9d:	68 af 00 00 00       	push   $0xaf
  802da2:	68 f3 3e 80 00       	push   $0x803ef3
  802da7:	e8 29 ec ff ff       	call   8019d5 <_panic>

00802dac <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  802dac:	55                   	push   %ebp
  802dad:	89 e5                	mov    %esp,%ebp
  802daf:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802db2:	83 ec 04             	sub    $0x4,%esp
  802db5:	68 d0 3e 80 00       	push   $0x803ed0
  802dba:	68 b5 00 00 00       	push   $0xb5
  802dbf:	68 f3 3e 80 00       	push   $0x803ef3
  802dc4:	e8 0c ec ff ff       	call   8019d5 <_panic>

00802dc9 <expand>:
}

void expand(uint32 newSize)
{
  802dc9:	55                   	push   %ebp
  802dca:	89 e5                	mov    %esp,%ebp
  802dcc:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802dcf:	83 ec 04             	sub    $0x4,%esp
  802dd2:	68 d0 3e 80 00       	push   $0x803ed0
  802dd7:	68 ba 00 00 00       	push   $0xba
  802ddc:	68 f3 3e 80 00       	push   $0x803ef3
  802de1:	e8 ef eb ff ff       	call   8019d5 <_panic>

00802de6 <shrink>:
}
void shrink(uint32 newSize)
{
  802de6:	55                   	push   %ebp
  802de7:	89 e5                	mov    %esp,%ebp
  802de9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802dec:	83 ec 04             	sub    $0x4,%esp
  802def:	68 d0 3e 80 00       	push   $0x803ed0
  802df4:	68 be 00 00 00       	push   $0xbe
  802df9:	68 f3 3e 80 00       	push   $0x803ef3
  802dfe:	e8 d2 eb ff ff       	call   8019d5 <_panic>

00802e03 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  802e03:	55                   	push   %ebp
  802e04:	89 e5                	mov    %esp,%ebp
  802e06:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802e09:	83 ec 04             	sub    $0x4,%esp
  802e0c:	68 d0 3e 80 00       	push   $0x803ed0
  802e11:	68 c3 00 00 00       	push   $0xc3
  802e16:	68 f3 3e 80 00       	push   $0x803ef3
  802e1b:	e8 b5 eb ff ff       	call   8019d5 <_panic>

00802e20 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802e20:	55                   	push   %ebp
  802e21:	89 e5                	mov    %esp,%ebp
  802e23:	57                   	push   %edi
  802e24:	56                   	push   %esi
  802e25:	53                   	push   %ebx
  802e26:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802e29:	8b 45 08             	mov    0x8(%ebp),%eax
  802e2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e2f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802e32:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802e35:	8b 7d 18             	mov    0x18(%ebp),%edi
  802e38:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802e3b:	cd 30                	int    $0x30
  802e3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802e40:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802e43:	83 c4 10             	add    $0x10,%esp
  802e46:	5b                   	pop    %ebx
  802e47:	5e                   	pop    %esi
  802e48:	5f                   	pop    %edi
  802e49:	5d                   	pop    %ebp
  802e4a:	c3                   	ret    

00802e4b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802e4b:	55                   	push   %ebp
  802e4c:	89 e5                	mov    %esp,%ebp
  802e4e:	83 ec 04             	sub    $0x4,%esp
  802e51:	8b 45 10             	mov    0x10(%ebp),%eax
  802e54:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802e57:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  802e5e:	6a 00                	push   $0x0
  802e60:	6a 00                	push   $0x0
  802e62:	52                   	push   %edx
  802e63:	ff 75 0c             	pushl  0xc(%ebp)
  802e66:	50                   	push   %eax
  802e67:	6a 00                	push   $0x0
  802e69:	e8 b2 ff ff ff       	call   802e20 <syscall>
  802e6e:	83 c4 18             	add    $0x18,%esp
}
  802e71:	90                   	nop
  802e72:	c9                   	leave  
  802e73:	c3                   	ret    

00802e74 <sys_cgetc>:

int
sys_cgetc(void)
{
  802e74:	55                   	push   %ebp
  802e75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802e77:	6a 00                	push   $0x0
  802e79:	6a 00                	push   $0x0
  802e7b:	6a 00                	push   $0x0
  802e7d:	6a 00                	push   $0x0
  802e7f:	6a 00                	push   $0x0
  802e81:	6a 01                	push   $0x1
  802e83:	e8 98 ff ff ff       	call   802e20 <syscall>
  802e88:	83 c4 18             	add    $0x18,%esp
}
  802e8b:	c9                   	leave  
  802e8c:	c3                   	ret    

00802e8d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802e8d:	55                   	push   %ebp
  802e8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802e90:	8b 45 08             	mov    0x8(%ebp),%eax
  802e93:	6a 00                	push   $0x0
  802e95:	6a 00                	push   $0x0
  802e97:	6a 00                	push   $0x0
  802e99:	6a 00                	push   $0x0
  802e9b:	50                   	push   %eax
  802e9c:	6a 05                	push   $0x5
  802e9e:	e8 7d ff ff ff       	call   802e20 <syscall>
  802ea3:	83 c4 18             	add    $0x18,%esp
}
  802ea6:	c9                   	leave  
  802ea7:	c3                   	ret    

00802ea8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802ea8:	55                   	push   %ebp
  802ea9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802eab:	6a 00                	push   $0x0
  802ead:	6a 00                	push   $0x0
  802eaf:	6a 00                	push   $0x0
  802eb1:	6a 00                	push   $0x0
  802eb3:	6a 00                	push   $0x0
  802eb5:	6a 02                	push   $0x2
  802eb7:	e8 64 ff ff ff       	call   802e20 <syscall>
  802ebc:	83 c4 18             	add    $0x18,%esp
}
  802ebf:	c9                   	leave  
  802ec0:	c3                   	ret    

00802ec1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802ec1:	55                   	push   %ebp
  802ec2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802ec4:	6a 00                	push   $0x0
  802ec6:	6a 00                	push   $0x0
  802ec8:	6a 00                	push   $0x0
  802eca:	6a 00                	push   $0x0
  802ecc:	6a 00                	push   $0x0
  802ece:	6a 03                	push   $0x3
  802ed0:	e8 4b ff ff ff       	call   802e20 <syscall>
  802ed5:	83 c4 18             	add    $0x18,%esp
}
  802ed8:	c9                   	leave  
  802ed9:	c3                   	ret    

00802eda <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802eda:	55                   	push   %ebp
  802edb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802edd:	6a 00                	push   $0x0
  802edf:	6a 00                	push   $0x0
  802ee1:	6a 00                	push   $0x0
  802ee3:	6a 00                	push   $0x0
  802ee5:	6a 00                	push   $0x0
  802ee7:	6a 04                	push   $0x4
  802ee9:	e8 32 ff ff ff       	call   802e20 <syscall>
  802eee:	83 c4 18             	add    $0x18,%esp
}
  802ef1:	c9                   	leave  
  802ef2:	c3                   	ret    

00802ef3 <sys_env_exit>:


void sys_env_exit(void)
{
  802ef3:	55                   	push   %ebp
  802ef4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802ef6:	6a 00                	push   $0x0
  802ef8:	6a 00                	push   $0x0
  802efa:	6a 00                	push   $0x0
  802efc:	6a 00                	push   $0x0
  802efe:	6a 00                	push   $0x0
  802f00:	6a 06                	push   $0x6
  802f02:	e8 19 ff ff ff       	call   802e20 <syscall>
  802f07:	83 c4 18             	add    $0x18,%esp
}
  802f0a:	90                   	nop
  802f0b:	c9                   	leave  
  802f0c:	c3                   	ret    

00802f0d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802f0d:	55                   	push   %ebp
  802f0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802f10:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f13:	8b 45 08             	mov    0x8(%ebp),%eax
  802f16:	6a 00                	push   $0x0
  802f18:	6a 00                	push   $0x0
  802f1a:	6a 00                	push   $0x0
  802f1c:	52                   	push   %edx
  802f1d:	50                   	push   %eax
  802f1e:	6a 07                	push   $0x7
  802f20:	e8 fb fe ff ff       	call   802e20 <syscall>
  802f25:	83 c4 18             	add    $0x18,%esp
}
  802f28:	c9                   	leave  
  802f29:	c3                   	ret    

00802f2a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802f2a:	55                   	push   %ebp
  802f2b:	89 e5                	mov    %esp,%ebp
  802f2d:	56                   	push   %esi
  802f2e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802f2f:	8b 75 18             	mov    0x18(%ebp),%esi
  802f32:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802f35:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802f38:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  802f3e:	56                   	push   %esi
  802f3f:	53                   	push   %ebx
  802f40:	51                   	push   %ecx
  802f41:	52                   	push   %edx
  802f42:	50                   	push   %eax
  802f43:	6a 08                	push   $0x8
  802f45:	e8 d6 fe ff ff       	call   802e20 <syscall>
  802f4a:	83 c4 18             	add    $0x18,%esp
}
  802f4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802f50:	5b                   	pop    %ebx
  802f51:	5e                   	pop    %esi
  802f52:	5d                   	pop    %ebp
  802f53:	c3                   	ret    

00802f54 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802f54:	55                   	push   %ebp
  802f55:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802f57:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  802f5d:	6a 00                	push   $0x0
  802f5f:	6a 00                	push   $0x0
  802f61:	6a 00                	push   $0x0
  802f63:	52                   	push   %edx
  802f64:	50                   	push   %eax
  802f65:	6a 09                	push   $0x9
  802f67:	e8 b4 fe ff ff       	call   802e20 <syscall>
  802f6c:	83 c4 18             	add    $0x18,%esp
}
  802f6f:	c9                   	leave  
  802f70:	c3                   	ret    

00802f71 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802f71:	55                   	push   %ebp
  802f72:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802f74:	6a 00                	push   $0x0
  802f76:	6a 00                	push   $0x0
  802f78:	6a 00                	push   $0x0
  802f7a:	ff 75 0c             	pushl  0xc(%ebp)
  802f7d:	ff 75 08             	pushl  0x8(%ebp)
  802f80:	6a 0a                	push   $0xa
  802f82:	e8 99 fe ff ff       	call   802e20 <syscall>
  802f87:	83 c4 18             	add    $0x18,%esp
}
  802f8a:	c9                   	leave  
  802f8b:	c3                   	ret    

00802f8c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802f8c:	55                   	push   %ebp
  802f8d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802f8f:	6a 00                	push   $0x0
  802f91:	6a 00                	push   $0x0
  802f93:	6a 00                	push   $0x0
  802f95:	6a 00                	push   $0x0
  802f97:	6a 00                	push   $0x0
  802f99:	6a 0b                	push   $0xb
  802f9b:	e8 80 fe ff ff       	call   802e20 <syscall>
  802fa0:	83 c4 18             	add    $0x18,%esp
}
  802fa3:	c9                   	leave  
  802fa4:	c3                   	ret    

00802fa5 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802fa5:	55                   	push   %ebp
  802fa6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802fa8:	6a 00                	push   $0x0
  802faa:	6a 00                	push   $0x0
  802fac:	6a 00                	push   $0x0
  802fae:	6a 00                	push   $0x0
  802fb0:	6a 00                	push   $0x0
  802fb2:	6a 0c                	push   $0xc
  802fb4:	e8 67 fe ff ff       	call   802e20 <syscall>
  802fb9:	83 c4 18             	add    $0x18,%esp
}
  802fbc:	c9                   	leave  
  802fbd:	c3                   	ret    

00802fbe <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802fbe:	55                   	push   %ebp
  802fbf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802fc1:	6a 00                	push   $0x0
  802fc3:	6a 00                	push   $0x0
  802fc5:	6a 00                	push   $0x0
  802fc7:	6a 00                	push   $0x0
  802fc9:	6a 00                	push   $0x0
  802fcb:	6a 0d                	push   $0xd
  802fcd:	e8 4e fe ff ff       	call   802e20 <syscall>
  802fd2:	83 c4 18             	add    $0x18,%esp
}
  802fd5:	c9                   	leave  
  802fd6:	c3                   	ret    

00802fd7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802fd7:	55                   	push   %ebp
  802fd8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802fda:	6a 00                	push   $0x0
  802fdc:	6a 00                	push   $0x0
  802fde:	6a 00                	push   $0x0
  802fe0:	ff 75 0c             	pushl  0xc(%ebp)
  802fe3:	ff 75 08             	pushl  0x8(%ebp)
  802fe6:	6a 11                	push   $0x11
  802fe8:	e8 33 fe ff ff       	call   802e20 <syscall>
  802fed:	83 c4 18             	add    $0x18,%esp
	return;
  802ff0:	90                   	nop
}
  802ff1:	c9                   	leave  
  802ff2:	c3                   	ret    

00802ff3 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802ff3:	55                   	push   %ebp
  802ff4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802ff6:	6a 00                	push   $0x0
  802ff8:	6a 00                	push   $0x0
  802ffa:	6a 00                	push   $0x0
  802ffc:	ff 75 0c             	pushl  0xc(%ebp)
  802fff:	ff 75 08             	pushl  0x8(%ebp)
  803002:	6a 12                	push   $0x12
  803004:	e8 17 fe ff ff       	call   802e20 <syscall>
  803009:	83 c4 18             	add    $0x18,%esp
	return ;
  80300c:	90                   	nop
}
  80300d:	c9                   	leave  
  80300e:	c3                   	ret    

0080300f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80300f:	55                   	push   %ebp
  803010:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  803012:	6a 00                	push   $0x0
  803014:	6a 00                	push   $0x0
  803016:	6a 00                	push   $0x0
  803018:	6a 00                	push   $0x0
  80301a:	6a 00                	push   $0x0
  80301c:	6a 0e                	push   $0xe
  80301e:	e8 fd fd ff ff       	call   802e20 <syscall>
  803023:	83 c4 18             	add    $0x18,%esp
}
  803026:	c9                   	leave  
  803027:	c3                   	ret    

00803028 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  803028:	55                   	push   %ebp
  803029:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80302b:	6a 00                	push   $0x0
  80302d:	6a 00                	push   $0x0
  80302f:	6a 00                	push   $0x0
  803031:	6a 00                	push   $0x0
  803033:	ff 75 08             	pushl  0x8(%ebp)
  803036:	6a 0f                	push   $0xf
  803038:	e8 e3 fd ff ff       	call   802e20 <syscall>
  80303d:	83 c4 18             	add    $0x18,%esp
}
  803040:	c9                   	leave  
  803041:	c3                   	ret    

00803042 <sys_scarce_memory>:

void sys_scarce_memory()
{
  803042:	55                   	push   %ebp
  803043:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  803045:	6a 00                	push   $0x0
  803047:	6a 00                	push   $0x0
  803049:	6a 00                	push   $0x0
  80304b:	6a 00                	push   $0x0
  80304d:	6a 00                	push   $0x0
  80304f:	6a 10                	push   $0x10
  803051:	e8 ca fd ff ff       	call   802e20 <syscall>
  803056:	83 c4 18             	add    $0x18,%esp
}
  803059:	90                   	nop
  80305a:	c9                   	leave  
  80305b:	c3                   	ret    

0080305c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80305c:	55                   	push   %ebp
  80305d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80305f:	6a 00                	push   $0x0
  803061:	6a 00                	push   $0x0
  803063:	6a 00                	push   $0x0
  803065:	6a 00                	push   $0x0
  803067:	6a 00                	push   $0x0
  803069:	6a 14                	push   $0x14
  80306b:	e8 b0 fd ff ff       	call   802e20 <syscall>
  803070:	83 c4 18             	add    $0x18,%esp
}
  803073:	90                   	nop
  803074:	c9                   	leave  
  803075:	c3                   	ret    

00803076 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  803076:	55                   	push   %ebp
  803077:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  803079:	6a 00                	push   $0x0
  80307b:	6a 00                	push   $0x0
  80307d:	6a 00                	push   $0x0
  80307f:	6a 00                	push   $0x0
  803081:	6a 00                	push   $0x0
  803083:	6a 15                	push   $0x15
  803085:	e8 96 fd ff ff       	call   802e20 <syscall>
  80308a:	83 c4 18             	add    $0x18,%esp
}
  80308d:	90                   	nop
  80308e:	c9                   	leave  
  80308f:	c3                   	ret    

00803090 <sys_cputc>:


void
sys_cputc(const char c)
{
  803090:	55                   	push   %ebp
  803091:	89 e5                	mov    %esp,%ebp
  803093:	83 ec 04             	sub    $0x4,%esp
  803096:	8b 45 08             	mov    0x8(%ebp),%eax
  803099:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80309c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8030a0:	6a 00                	push   $0x0
  8030a2:	6a 00                	push   $0x0
  8030a4:	6a 00                	push   $0x0
  8030a6:	6a 00                	push   $0x0
  8030a8:	50                   	push   %eax
  8030a9:	6a 16                	push   $0x16
  8030ab:	e8 70 fd ff ff       	call   802e20 <syscall>
  8030b0:	83 c4 18             	add    $0x18,%esp
}
  8030b3:	90                   	nop
  8030b4:	c9                   	leave  
  8030b5:	c3                   	ret    

008030b6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8030b6:	55                   	push   %ebp
  8030b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8030b9:	6a 00                	push   $0x0
  8030bb:	6a 00                	push   $0x0
  8030bd:	6a 00                	push   $0x0
  8030bf:	6a 00                	push   $0x0
  8030c1:	6a 00                	push   $0x0
  8030c3:	6a 17                	push   $0x17
  8030c5:	e8 56 fd ff ff       	call   802e20 <syscall>
  8030ca:	83 c4 18             	add    $0x18,%esp
}
  8030cd:	90                   	nop
  8030ce:	c9                   	leave  
  8030cf:	c3                   	ret    

008030d0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8030d0:	55                   	push   %ebp
  8030d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8030d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8030d6:	6a 00                	push   $0x0
  8030d8:	6a 00                	push   $0x0
  8030da:	6a 00                	push   $0x0
  8030dc:	ff 75 0c             	pushl  0xc(%ebp)
  8030df:	50                   	push   %eax
  8030e0:	6a 18                	push   $0x18
  8030e2:	e8 39 fd ff ff       	call   802e20 <syscall>
  8030e7:	83 c4 18             	add    $0x18,%esp
}
  8030ea:	c9                   	leave  
  8030eb:	c3                   	ret    

008030ec <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8030ec:	55                   	push   %ebp
  8030ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8030ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8030f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8030f5:	6a 00                	push   $0x0
  8030f7:	6a 00                	push   $0x0
  8030f9:	6a 00                	push   $0x0
  8030fb:	52                   	push   %edx
  8030fc:	50                   	push   %eax
  8030fd:	6a 1b                	push   $0x1b
  8030ff:	e8 1c fd ff ff       	call   802e20 <syscall>
  803104:	83 c4 18             	add    $0x18,%esp
}
  803107:	c9                   	leave  
  803108:	c3                   	ret    

00803109 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  803109:	55                   	push   %ebp
  80310a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80310c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80310f:	8b 45 08             	mov    0x8(%ebp),%eax
  803112:	6a 00                	push   $0x0
  803114:	6a 00                	push   $0x0
  803116:	6a 00                	push   $0x0
  803118:	52                   	push   %edx
  803119:	50                   	push   %eax
  80311a:	6a 19                	push   $0x19
  80311c:	e8 ff fc ff ff       	call   802e20 <syscall>
  803121:	83 c4 18             	add    $0x18,%esp
}
  803124:	90                   	nop
  803125:	c9                   	leave  
  803126:	c3                   	ret    

00803127 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  803127:	55                   	push   %ebp
  803128:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80312a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80312d:	8b 45 08             	mov    0x8(%ebp),%eax
  803130:	6a 00                	push   $0x0
  803132:	6a 00                	push   $0x0
  803134:	6a 00                	push   $0x0
  803136:	52                   	push   %edx
  803137:	50                   	push   %eax
  803138:	6a 1a                	push   $0x1a
  80313a:	e8 e1 fc ff ff       	call   802e20 <syscall>
  80313f:	83 c4 18             	add    $0x18,%esp
}
  803142:	90                   	nop
  803143:	c9                   	leave  
  803144:	c3                   	ret    

00803145 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  803145:	55                   	push   %ebp
  803146:	89 e5                	mov    %esp,%ebp
  803148:	83 ec 04             	sub    $0x4,%esp
  80314b:	8b 45 10             	mov    0x10(%ebp),%eax
  80314e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  803151:	8b 4d 14             	mov    0x14(%ebp),%ecx
  803154:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  803158:	8b 45 08             	mov    0x8(%ebp),%eax
  80315b:	6a 00                	push   $0x0
  80315d:	51                   	push   %ecx
  80315e:	52                   	push   %edx
  80315f:	ff 75 0c             	pushl  0xc(%ebp)
  803162:	50                   	push   %eax
  803163:	6a 1c                	push   $0x1c
  803165:	e8 b6 fc ff ff       	call   802e20 <syscall>
  80316a:	83 c4 18             	add    $0x18,%esp
}
  80316d:	c9                   	leave  
  80316e:	c3                   	ret    

0080316f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80316f:	55                   	push   %ebp
  803170:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  803172:	8b 55 0c             	mov    0xc(%ebp),%edx
  803175:	8b 45 08             	mov    0x8(%ebp),%eax
  803178:	6a 00                	push   $0x0
  80317a:	6a 00                	push   $0x0
  80317c:	6a 00                	push   $0x0
  80317e:	52                   	push   %edx
  80317f:	50                   	push   %eax
  803180:	6a 1d                	push   $0x1d
  803182:	e8 99 fc ff ff       	call   802e20 <syscall>
  803187:	83 c4 18             	add    $0x18,%esp
}
  80318a:	c9                   	leave  
  80318b:	c3                   	ret    

0080318c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80318c:	55                   	push   %ebp
  80318d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80318f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  803192:	8b 55 0c             	mov    0xc(%ebp),%edx
  803195:	8b 45 08             	mov    0x8(%ebp),%eax
  803198:	6a 00                	push   $0x0
  80319a:	6a 00                	push   $0x0
  80319c:	51                   	push   %ecx
  80319d:	52                   	push   %edx
  80319e:	50                   	push   %eax
  80319f:	6a 1e                	push   $0x1e
  8031a1:	e8 7a fc ff ff       	call   802e20 <syscall>
  8031a6:	83 c4 18             	add    $0x18,%esp
}
  8031a9:	c9                   	leave  
  8031aa:	c3                   	ret    

008031ab <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8031ab:	55                   	push   %ebp
  8031ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8031ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8031b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8031b4:	6a 00                	push   $0x0
  8031b6:	6a 00                	push   $0x0
  8031b8:	6a 00                	push   $0x0
  8031ba:	52                   	push   %edx
  8031bb:	50                   	push   %eax
  8031bc:	6a 1f                	push   $0x1f
  8031be:	e8 5d fc ff ff       	call   802e20 <syscall>
  8031c3:	83 c4 18             	add    $0x18,%esp
}
  8031c6:	c9                   	leave  
  8031c7:	c3                   	ret    

008031c8 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8031c8:	55                   	push   %ebp
  8031c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8031cb:	6a 00                	push   $0x0
  8031cd:	6a 00                	push   $0x0
  8031cf:	6a 00                	push   $0x0
  8031d1:	6a 00                	push   $0x0
  8031d3:	6a 00                	push   $0x0
  8031d5:	6a 20                	push   $0x20
  8031d7:	e8 44 fc ff ff       	call   802e20 <syscall>
  8031dc:	83 c4 18             	add    $0x18,%esp
}
  8031df:	c9                   	leave  
  8031e0:	c3                   	ret    

008031e1 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8031e1:	55                   	push   %ebp
  8031e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8031e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8031e7:	6a 00                	push   $0x0
  8031e9:	ff 75 14             	pushl  0x14(%ebp)
  8031ec:	ff 75 10             	pushl  0x10(%ebp)
  8031ef:	ff 75 0c             	pushl  0xc(%ebp)
  8031f2:	50                   	push   %eax
  8031f3:	6a 21                	push   $0x21
  8031f5:	e8 26 fc ff ff       	call   802e20 <syscall>
  8031fa:	83 c4 18             	add    $0x18,%esp
}
  8031fd:	c9                   	leave  
  8031fe:	c3                   	ret    

008031ff <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8031ff:	55                   	push   %ebp
  803200:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  803202:	8b 45 08             	mov    0x8(%ebp),%eax
  803205:	6a 00                	push   $0x0
  803207:	6a 00                	push   $0x0
  803209:	6a 00                	push   $0x0
  80320b:	6a 00                	push   $0x0
  80320d:	50                   	push   %eax
  80320e:	6a 22                	push   $0x22
  803210:	e8 0b fc ff ff       	call   802e20 <syscall>
  803215:	83 c4 18             	add    $0x18,%esp
}
  803218:	90                   	nop
  803219:	c9                   	leave  
  80321a:	c3                   	ret    

0080321b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80321b:	55                   	push   %ebp
  80321c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80321e:	8b 45 08             	mov    0x8(%ebp),%eax
  803221:	6a 00                	push   $0x0
  803223:	6a 00                	push   $0x0
  803225:	6a 00                	push   $0x0
  803227:	6a 00                	push   $0x0
  803229:	50                   	push   %eax
  80322a:	6a 23                	push   $0x23
  80322c:	e8 ef fb ff ff       	call   802e20 <syscall>
  803231:	83 c4 18             	add    $0x18,%esp
}
  803234:	90                   	nop
  803235:	c9                   	leave  
  803236:	c3                   	ret    

00803237 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  803237:	55                   	push   %ebp
  803238:	89 e5                	mov    %esp,%ebp
  80323a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80323d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  803240:	8d 50 04             	lea    0x4(%eax),%edx
  803243:	8d 45 f8             	lea    -0x8(%ebp),%eax
  803246:	6a 00                	push   $0x0
  803248:	6a 00                	push   $0x0
  80324a:	6a 00                	push   $0x0
  80324c:	52                   	push   %edx
  80324d:	50                   	push   %eax
  80324e:	6a 24                	push   $0x24
  803250:	e8 cb fb ff ff       	call   802e20 <syscall>
  803255:	83 c4 18             	add    $0x18,%esp
	return result;
  803258:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80325b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80325e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  803261:	89 01                	mov    %eax,(%ecx)
  803263:	89 51 04             	mov    %edx,0x4(%ecx)
}
  803266:	8b 45 08             	mov    0x8(%ebp),%eax
  803269:	c9                   	leave  
  80326a:	c2 04 00             	ret    $0x4

0080326d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80326d:	55                   	push   %ebp
  80326e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  803270:	6a 00                	push   $0x0
  803272:	6a 00                	push   $0x0
  803274:	ff 75 10             	pushl  0x10(%ebp)
  803277:	ff 75 0c             	pushl  0xc(%ebp)
  80327a:	ff 75 08             	pushl  0x8(%ebp)
  80327d:	6a 13                	push   $0x13
  80327f:	e8 9c fb ff ff       	call   802e20 <syscall>
  803284:	83 c4 18             	add    $0x18,%esp
	return ;
  803287:	90                   	nop
}
  803288:	c9                   	leave  
  803289:	c3                   	ret    

0080328a <sys_rcr2>:
uint32 sys_rcr2()
{
  80328a:	55                   	push   %ebp
  80328b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80328d:	6a 00                	push   $0x0
  80328f:	6a 00                	push   $0x0
  803291:	6a 00                	push   $0x0
  803293:	6a 00                	push   $0x0
  803295:	6a 00                	push   $0x0
  803297:	6a 25                	push   $0x25
  803299:	e8 82 fb ff ff       	call   802e20 <syscall>
  80329e:	83 c4 18             	add    $0x18,%esp
}
  8032a1:	c9                   	leave  
  8032a2:	c3                   	ret    

008032a3 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8032a3:	55                   	push   %ebp
  8032a4:	89 e5                	mov    %esp,%ebp
  8032a6:	83 ec 04             	sub    $0x4,%esp
  8032a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8032ac:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8032af:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8032b3:	6a 00                	push   $0x0
  8032b5:	6a 00                	push   $0x0
  8032b7:	6a 00                	push   $0x0
  8032b9:	6a 00                	push   $0x0
  8032bb:	50                   	push   %eax
  8032bc:	6a 26                	push   $0x26
  8032be:	e8 5d fb ff ff       	call   802e20 <syscall>
  8032c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8032c6:	90                   	nop
}
  8032c7:	c9                   	leave  
  8032c8:	c3                   	ret    

008032c9 <rsttst>:
void rsttst()
{
  8032c9:	55                   	push   %ebp
  8032ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8032cc:	6a 00                	push   $0x0
  8032ce:	6a 00                	push   $0x0
  8032d0:	6a 00                	push   $0x0
  8032d2:	6a 00                	push   $0x0
  8032d4:	6a 00                	push   $0x0
  8032d6:	6a 28                	push   $0x28
  8032d8:	e8 43 fb ff ff       	call   802e20 <syscall>
  8032dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8032e0:	90                   	nop
}
  8032e1:	c9                   	leave  
  8032e2:	c3                   	ret    

008032e3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8032e3:	55                   	push   %ebp
  8032e4:	89 e5                	mov    %esp,%ebp
  8032e6:	83 ec 04             	sub    $0x4,%esp
  8032e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8032ec:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8032ef:	8b 55 18             	mov    0x18(%ebp),%edx
  8032f2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8032f6:	52                   	push   %edx
  8032f7:	50                   	push   %eax
  8032f8:	ff 75 10             	pushl  0x10(%ebp)
  8032fb:	ff 75 0c             	pushl  0xc(%ebp)
  8032fe:	ff 75 08             	pushl  0x8(%ebp)
  803301:	6a 27                	push   $0x27
  803303:	e8 18 fb ff ff       	call   802e20 <syscall>
  803308:	83 c4 18             	add    $0x18,%esp
	return ;
  80330b:	90                   	nop
}
  80330c:	c9                   	leave  
  80330d:	c3                   	ret    

0080330e <chktst>:
void chktst(uint32 n)
{
  80330e:	55                   	push   %ebp
  80330f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  803311:	6a 00                	push   $0x0
  803313:	6a 00                	push   $0x0
  803315:	6a 00                	push   $0x0
  803317:	6a 00                	push   $0x0
  803319:	ff 75 08             	pushl  0x8(%ebp)
  80331c:	6a 29                	push   $0x29
  80331e:	e8 fd fa ff ff       	call   802e20 <syscall>
  803323:	83 c4 18             	add    $0x18,%esp
	return ;
  803326:	90                   	nop
}
  803327:	c9                   	leave  
  803328:	c3                   	ret    

00803329 <inctst>:

void inctst()
{
  803329:	55                   	push   %ebp
  80332a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80332c:	6a 00                	push   $0x0
  80332e:	6a 00                	push   $0x0
  803330:	6a 00                	push   $0x0
  803332:	6a 00                	push   $0x0
  803334:	6a 00                	push   $0x0
  803336:	6a 2a                	push   $0x2a
  803338:	e8 e3 fa ff ff       	call   802e20 <syscall>
  80333d:	83 c4 18             	add    $0x18,%esp
	return ;
  803340:	90                   	nop
}
  803341:	c9                   	leave  
  803342:	c3                   	ret    

00803343 <gettst>:
uint32 gettst()
{
  803343:	55                   	push   %ebp
  803344:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  803346:	6a 00                	push   $0x0
  803348:	6a 00                	push   $0x0
  80334a:	6a 00                	push   $0x0
  80334c:	6a 00                	push   $0x0
  80334e:	6a 00                	push   $0x0
  803350:	6a 2b                	push   $0x2b
  803352:	e8 c9 fa ff ff       	call   802e20 <syscall>
  803357:	83 c4 18             	add    $0x18,%esp
}
  80335a:	c9                   	leave  
  80335b:	c3                   	ret    

0080335c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80335c:	55                   	push   %ebp
  80335d:	89 e5                	mov    %esp,%ebp
  80335f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803362:	6a 00                	push   $0x0
  803364:	6a 00                	push   $0x0
  803366:	6a 00                	push   $0x0
  803368:	6a 00                	push   $0x0
  80336a:	6a 00                	push   $0x0
  80336c:	6a 2c                	push   $0x2c
  80336e:	e8 ad fa ff ff       	call   802e20 <syscall>
  803373:	83 c4 18             	add    $0x18,%esp
  803376:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  803379:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80337d:	75 07                	jne    803386 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80337f:	b8 01 00 00 00       	mov    $0x1,%eax
  803384:	eb 05                	jmp    80338b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  803386:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80338b:	c9                   	leave  
  80338c:	c3                   	ret    

0080338d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80338d:	55                   	push   %ebp
  80338e:	89 e5                	mov    %esp,%ebp
  803390:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803393:	6a 00                	push   $0x0
  803395:	6a 00                	push   $0x0
  803397:	6a 00                	push   $0x0
  803399:	6a 00                	push   $0x0
  80339b:	6a 00                	push   $0x0
  80339d:	6a 2c                	push   $0x2c
  80339f:	e8 7c fa ff ff       	call   802e20 <syscall>
  8033a4:	83 c4 18             	add    $0x18,%esp
  8033a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8033aa:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8033ae:	75 07                	jne    8033b7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8033b0:	b8 01 00 00 00       	mov    $0x1,%eax
  8033b5:	eb 05                	jmp    8033bc <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8033b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8033bc:	c9                   	leave  
  8033bd:	c3                   	ret    

008033be <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8033be:	55                   	push   %ebp
  8033bf:	89 e5                	mov    %esp,%ebp
  8033c1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8033c4:	6a 00                	push   $0x0
  8033c6:	6a 00                	push   $0x0
  8033c8:	6a 00                	push   $0x0
  8033ca:	6a 00                	push   $0x0
  8033cc:	6a 00                	push   $0x0
  8033ce:	6a 2c                	push   $0x2c
  8033d0:	e8 4b fa ff ff       	call   802e20 <syscall>
  8033d5:	83 c4 18             	add    $0x18,%esp
  8033d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8033db:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8033df:	75 07                	jne    8033e8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8033e1:	b8 01 00 00 00       	mov    $0x1,%eax
  8033e6:	eb 05                	jmp    8033ed <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8033e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8033ed:	c9                   	leave  
  8033ee:	c3                   	ret    

008033ef <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8033ef:	55                   	push   %ebp
  8033f0:	89 e5                	mov    %esp,%ebp
  8033f2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8033f5:	6a 00                	push   $0x0
  8033f7:	6a 00                	push   $0x0
  8033f9:	6a 00                	push   $0x0
  8033fb:	6a 00                	push   $0x0
  8033fd:	6a 00                	push   $0x0
  8033ff:	6a 2c                	push   $0x2c
  803401:	e8 1a fa ff ff       	call   802e20 <syscall>
  803406:	83 c4 18             	add    $0x18,%esp
  803409:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80340c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  803410:	75 07                	jne    803419 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  803412:	b8 01 00 00 00       	mov    $0x1,%eax
  803417:	eb 05                	jmp    80341e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  803419:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80341e:	c9                   	leave  
  80341f:	c3                   	ret    

00803420 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  803420:	55                   	push   %ebp
  803421:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  803423:	6a 00                	push   $0x0
  803425:	6a 00                	push   $0x0
  803427:	6a 00                	push   $0x0
  803429:	6a 00                	push   $0x0
  80342b:	ff 75 08             	pushl  0x8(%ebp)
  80342e:	6a 2d                	push   $0x2d
  803430:	e8 eb f9 ff ff       	call   802e20 <syscall>
  803435:	83 c4 18             	add    $0x18,%esp
	return ;
  803438:	90                   	nop
}
  803439:	c9                   	leave  
  80343a:	c3                   	ret    

0080343b <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80343b:	55                   	push   %ebp
  80343c:	89 e5                	mov    %esp,%ebp
  80343e:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80343f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  803442:	8b 4d 10             	mov    0x10(%ebp),%ecx
  803445:	8b 55 0c             	mov    0xc(%ebp),%edx
  803448:	8b 45 08             	mov    0x8(%ebp),%eax
  80344b:	6a 00                	push   $0x0
  80344d:	53                   	push   %ebx
  80344e:	51                   	push   %ecx
  80344f:	52                   	push   %edx
  803450:	50                   	push   %eax
  803451:	6a 2e                	push   $0x2e
  803453:	e8 c8 f9 ff ff       	call   802e20 <syscall>
  803458:	83 c4 18             	add    $0x18,%esp
}
  80345b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80345e:	c9                   	leave  
  80345f:	c3                   	ret    

00803460 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  803460:	55                   	push   %ebp
  803461:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  803463:	8b 55 0c             	mov    0xc(%ebp),%edx
  803466:	8b 45 08             	mov    0x8(%ebp),%eax
  803469:	6a 00                	push   $0x0
  80346b:	6a 00                	push   $0x0
  80346d:	6a 00                	push   $0x0
  80346f:	52                   	push   %edx
  803470:	50                   	push   %eax
  803471:	6a 2f                	push   $0x2f
  803473:	e8 a8 f9 ff ff       	call   802e20 <syscall>
  803478:	83 c4 18             	add    $0x18,%esp
}
  80347b:	c9                   	leave  
  80347c:	c3                   	ret    

0080347d <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80347d:	55                   	push   %ebp
  80347e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  803480:	6a 00                	push   $0x0
  803482:	6a 00                	push   $0x0
  803484:	6a 00                	push   $0x0
  803486:	ff 75 0c             	pushl  0xc(%ebp)
  803489:	ff 75 08             	pushl  0x8(%ebp)
  80348c:	6a 30                	push   $0x30
  80348e:	e8 8d f9 ff ff       	call   802e20 <syscall>
  803493:	83 c4 18             	add    $0x18,%esp
	return ;
  803496:	90                   	nop
}
  803497:	c9                   	leave  
  803498:	c3                   	ret    
  803499:	66 90                	xchg   %ax,%ax
  80349b:	90                   	nop

0080349c <__udivdi3>:
  80349c:	55                   	push   %ebp
  80349d:	57                   	push   %edi
  80349e:	56                   	push   %esi
  80349f:	53                   	push   %ebx
  8034a0:	83 ec 1c             	sub    $0x1c,%esp
  8034a3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8034a7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8034ab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8034af:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8034b3:	89 ca                	mov    %ecx,%edx
  8034b5:	89 f8                	mov    %edi,%eax
  8034b7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8034bb:	85 f6                	test   %esi,%esi
  8034bd:	75 2d                	jne    8034ec <__udivdi3+0x50>
  8034bf:	39 cf                	cmp    %ecx,%edi
  8034c1:	77 65                	ja     803528 <__udivdi3+0x8c>
  8034c3:	89 fd                	mov    %edi,%ebp
  8034c5:	85 ff                	test   %edi,%edi
  8034c7:	75 0b                	jne    8034d4 <__udivdi3+0x38>
  8034c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8034ce:	31 d2                	xor    %edx,%edx
  8034d0:	f7 f7                	div    %edi
  8034d2:	89 c5                	mov    %eax,%ebp
  8034d4:	31 d2                	xor    %edx,%edx
  8034d6:	89 c8                	mov    %ecx,%eax
  8034d8:	f7 f5                	div    %ebp
  8034da:	89 c1                	mov    %eax,%ecx
  8034dc:	89 d8                	mov    %ebx,%eax
  8034de:	f7 f5                	div    %ebp
  8034e0:	89 cf                	mov    %ecx,%edi
  8034e2:	89 fa                	mov    %edi,%edx
  8034e4:	83 c4 1c             	add    $0x1c,%esp
  8034e7:	5b                   	pop    %ebx
  8034e8:	5e                   	pop    %esi
  8034e9:	5f                   	pop    %edi
  8034ea:	5d                   	pop    %ebp
  8034eb:	c3                   	ret    
  8034ec:	39 ce                	cmp    %ecx,%esi
  8034ee:	77 28                	ja     803518 <__udivdi3+0x7c>
  8034f0:	0f bd fe             	bsr    %esi,%edi
  8034f3:	83 f7 1f             	xor    $0x1f,%edi
  8034f6:	75 40                	jne    803538 <__udivdi3+0x9c>
  8034f8:	39 ce                	cmp    %ecx,%esi
  8034fa:	72 0a                	jb     803506 <__udivdi3+0x6a>
  8034fc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  803500:	0f 87 9e 00 00 00    	ja     8035a4 <__udivdi3+0x108>
  803506:	b8 01 00 00 00       	mov    $0x1,%eax
  80350b:	89 fa                	mov    %edi,%edx
  80350d:	83 c4 1c             	add    $0x1c,%esp
  803510:	5b                   	pop    %ebx
  803511:	5e                   	pop    %esi
  803512:	5f                   	pop    %edi
  803513:	5d                   	pop    %ebp
  803514:	c3                   	ret    
  803515:	8d 76 00             	lea    0x0(%esi),%esi
  803518:	31 ff                	xor    %edi,%edi
  80351a:	31 c0                	xor    %eax,%eax
  80351c:	89 fa                	mov    %edi,%edx
  80351e:	83 c4 1c             	add    $0x1c,%esp
  803521:	5b                   	pop    %ebx
  803522:	5e                   	pop    %esi
  803523:	5f                   	pop    %edi
  803524:	5d                   	pop    %ebp
  803525:	c3                   	ret    
  803526:	66 90                	xchg   %ax,%ax
  803528:	89 d8                	mov    %ebx,%eax
  80352a:	f7 f7                	div    %edi
  80352c:	31 ff                	xor    %edi,%edi
  80352e:	89 fa                	mov    %edi,%edx
  803530:	83 c4 1c             	add    $0x1c,%esp
  803533:	5b                   	pop    %ebx
  803534:	5e                   	pop    %esi
  803535:	5f                   	pop    %edi
  803536:	5d                   	pop    %ebp
  803537:	c3                   	ret    
  803538:	bd 20 00 00 00       	mov    $0x20,%ebp
  80353d:	89 eb                	mov    %ebp,%ebx
  80353f:	29 fb                	sub    %edi,%ebx
  803541:	89 f9                	mov    %edi,%ecx
  803543:	d3 e6                	shl    %cl,%esi
  803545:	89 c5                	mov    %eax,%ebp
  803547:	88 d9                	mov    %bl,%cl
  803549:	d3 ed                	shr    %cl,%ebp
  80354b:	89 e9                	mov    %ebp,%ecx
  80354d:	09 f1                	or     %esi,%ecx
  80354f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  803553:	89 f9                	mov    %edi,%ecx
  803555:	d3 e0                	shl    %cl,%eax
  803557:	89 c5                	mov    %eax,%ebp
  803559:	89 d6                	mov    %edx,%esi
  80355b:	88 d9                	mov    %bl,%cl
  80355d:	d3 ee                	shr    %cl,%esi
  80355f:	89 f9                	mov    %edi,%ecx
  803561:	d3 e2                	shl    %cl,%edx
  803563:	8b 44 24 08          	mov    0x8(%esp),%eax
  803567:	88 d9                	mov    %bl,%cl
  803569:	d3 e8                	shr    %cl,%eax
  80356b:	09 c2                	or     %eax,%edx
  80356d:	89 d0                	mov    %edx,%eax
  80356f:	89 f2                	mov    %esi,%edx
  803571:	f7 74 24 0c          	divl   0xc(%esp)
  803575:	89 d6                	mov    %edx,%esi
  803577:	89 c3                	mov    %eax,%ebx
  803579:	f7 e5                	mul    %ebp
  80357b:	39 d6                	cmp    %edx,%esi
  80357d:	72 19                	jb     803598 <__udivdi3+0xfc>
  80357f:	74 0b                	je     80358c <__udivdi3+0xf0>
  803581:	89 d8                	mov    %ebx,%eax
  803583:	31 ff                	xor    %edi,%edi
  803585:	e9 58 ff ff ff       	jmp    8034e2 <__udivdi3+0x46>
  80358a:	66 90                	xchg   %ax,%ax
  80358c:	8b 54 24 08          	mov    0x8(%esp),%edx
  803590:	89 f9                	mov    %edi,%ecx
  803592:	d3 e2                	shl    %cl,%edx
  803594:	39 c2                	cmp    %eax,%edx
  803596:	73 e9                	jae    803581 <__udivdi3+0xe5>
  803598:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80359b:	31 ff                	xor    %edi,%edi
  80359d:	e9 40 ff ff ff       	jmp    8034e2 <__udivdi3+0x46>
  8035a2:	66 90                	xchg   %ax,%ax
  8035a4:	31 c0                	xor    %eax,%eax
  8035a6:	e9 37 ff ff ff       	jmp    8034e2 <__udivdi3+0x46>
  8035ab:	90                   	nop

008035ac <__umoddi3>:
  8035ac:	55                   	push   %ebp
  8035ad:	57                   	push   %edi
  8035ae:	56                   	push   %esi
  8035af:	53                   	push   %ebx
  8035b0:	83 ec 1c             	sub    $0x1c,%esp
  8035b3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8035b7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8035bb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8035bf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8035c3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8035c7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8035cb:	89 f3                	mov    %esi,%ebx
  8035cd:	89 fa                	mov    %edi,%edx
  8035cf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8035d3:	89 34 24             	mov    %esi,(%esp)
  8035d6:	85 c0                	test   %eax,%eax
  8035d8:	75 1a                	jne    8035f4 <__umoddi3+0x48>
  8035da:	39 f7                	cmp    %esi,%edi
  8035dc:	0f 86 a2 00 00 00    	jbe    803684 <__umoddi3+0xd8>
  8035e2:	89 c8                	mov    %ecx,%eax
  8035e4:	89 f2                	mov    %esi,%edx
  8035e6:	f7 f7                	div    %edi
  8035e8:	89 d0                	mov    %edx,%eax
  8035ea:	31 d2                	xor    %edx,%edx
  8035ec:	83 c4 1c             	add    $0x1c,%esp
  8035ef:	5b                   	pop    %ebx
  8035f0:	5e                   	pop    %esi
  8035f1:	5f                   	pop    %edi
  8035f2:	5d                   	pop    %ebp
  8035f3:	c3                   	ret    
  8035f4:	39 f0                	cmp    %esi,%eax
  8035f6:	0f 87 ac 00 00 00    	ja     8036a8 <__umoddi3+0xfc>
  8035fc:	0f bd e8             	bsr    %eax,%ebp
  8035ff:	83 f5 1f             	xor    $0x1f,%ebp
  803602:	0f 84 ac 00 00 00    	je     8036b4 <__umoddi3+0x108>
  803608:	bf 20 00 00 00       	mov    $0x20,%edi
  80360d:	29 ef                	sub    %ebp,%edi
  80360f:	89 fe                	mov    %edi,%esi
  803611:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  803615:	89 e9                	mov    %ebp,%ecx
  803617:	d3 e0                	shl    %cl,%eax
  803619:	89 d7                	mov    %edx,%edi
  80361b:	89 f1                	mov    %esi,%ecx
  80361d:	d3 ef                	shr    %cl,%edi
  80361f:	09 c7                	or     %eax,%edi
  803621:	89 e9                	mov    %ebp,%ecx
  803623:	d3 e2                	shl    %cl,%edx
  803625:	89 14 24             	mov    %edx,(%esp)
  803628:	89 d8                	mov    %ebx,%eax
  80362a:	d3 e0                	shl    %cl,%eax
  80362c:	89 c2                	mov    %eax,%edx
  80362e:	8b 44 24 08          	mov    0x8(%esp),%eax
  803632:	d3 e0                	shl    %cl,%eax
  803634:	89 44 24 04          	mov    %eax,0x4(%esp)
  803638:	8b 44 24 08          	mov    0x8(%esp),%eax
  80363c:	89 f1                	mov    %esi,%ecx
  80363e:	d3 e8                	shr    %cl,%eax
  803640:	09 d0                	or     %edx,%eax
  803642:	d3 eb                	shr    %cl,%ebx
  803644:	89 da                	mov    %ebx,%edx
  803646:	f7 f7                	div    %edi
  803648:	89 d3                	mov    %edx,%ebx
  80364a:	f7 24 24             	mull   (%esp)
  80364d:	89 c6                	mov    %eax,%esi
  80364f:	89 d1                	mov    %edx,%ecx
  803651:	39 d3                	cmp    %edx,%ebx
  803653:	0f 82 87 00 00 00    	jb     8036e0 <__umoddi3+0x134>
  803659:	0f 84 91 00 00 00    	je     8036f0 <__umoddi3+0x144>
  80365f:	8b 54 24 04          	mov    0x4(%esp),%edx
  803663:	29 f2                	sub    %esi,%edx
  803665:	19 cb                	sbb    %ecx,%ebx
  803667:	89 d8                	mov    %ebx,%eax
  803669:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80366d:	d3 e0                	shl    %cl,%eax
  80366f:	89 e9                	mov    %ebp,%ecx
  803671:	d3 ea                	shr    %cl,%edx
  803673:	09 d0                	or     %edx,%eax
  803675:	89 e9                	mov    %ebp,%ecx
  803677:	d3 eb                	shr    %cl,%ebx
  803679:	89 da                	mov    %ebx,%edx
  80367b:	83 c4 1c             	add    $0x1c,%esp
  80367e:	5b                   	pop    %ebx
  80367f:	5e                   	pop    %esi
  803680:	5f                   	pop    %edi
  803681:	5d                   	pop    %ebp
  803682:	c3                   	ret    
  803683:	90                   	nop
  803684:	89 fd                	mov    %edi,%ebp
  803686:	85 ff                	test   %edi,%edi
  803688:	75 0b                	jne    803695 <__umoddi3+0xe9>
  80368a:	b8 01 00 00 00       	mov    $0x1,%eax
  80368f:	31 d2                	xor    %edx,%edx
  803691:	f7 f7                	div    %edi
  803693:	89 c5                	mov    %eax,%ebp
  803695:	89 f0                	mov    %esi,%eax
  803697:	31 d2                	xor    %edx,%edx
  803699:	f7 f5                	div    %ebp
  80369b:	89 c8                	mov    %ecx,%eax
  80369d:	f7 f5                	div    %ebp
  80369f:	89 d0                	mov    %edx,%eax
  8036a1:	e9 44 ff ff ff       	jmp    8035ea <__umoddi3+0x3e>
  8036a6:	66 90                	xchg   %ax,%ax
  8036a8:	89 c8                	mov    %ecx,%eax
  8036aa:	89 f2                	mov    %esi,%edx
  8036ac:	83 c4 1c             	add    $0x1c,%esp
  8036af:	5b                   	pop    %ebx
  8036b0:	5e                   	pop    %esi
  8036b1:	5f                   	pop    %edi
  8036b2:	5d                   	pop    %ebp
  8036b3:	c3                   	ret    
  8036b4:	3b 04 24             	cmp    (%esp),%eax
  8036b7:	72 06                	jb     8036bf <__umoddi3+0x113>
  8036b9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8036bd:	77 0f                	ja     8036ce <__umoddi3+0x122>
  8036bf:	89 f2                	mov    %esi,%edx
  8036c1:	29 f9                	sub    %edi,%ecx
  8036c3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8036c7:	89 14 24             	mov    %edx,(%esp)
  8036ca:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8036ce:	8b 44 24 04          	mov    0x4(%esp),%eax
  8036d2:	8b 14 24             	mov    (%esp),%edx
  8036d5:	83 c4 1c             	add    $0x1c,%esp
  8036d8:	5b                   	pop    %ebx
  8036d9:	5e                   	pop    %esi
  8036da:	5f                   	pop    %edi
  8036db:	5d                   	pop    %ebp
  8036dc:	c3                   	ret    
  8036dd:	8d 76 00             	lea    0x0(%esi),%esi
  8036e0:	2b 04 24             	sub    (%esp),%eax
  8036e3:	19 fa                	sbb    %edi,%edx
  8036e5:	89 d1                	mov    %edx,%ecx
  8036e7:	89 c6                	mov    %eax,%esi
  8036e9:	e9 71 ff ff ff       	jmp    80365f <__umoddi3+0xb3>
  8036ee:	66 90                	xchg   %ax,%ax
  8036f0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8036f4:	72 ea                	jb     8036e0 <__umoddi3+0x134>
  8036f6:	89 d9                	mov    %ebx,%ecx
  8036f8:	e9 62 ff ff ff       	jmp    80365f <__umoddi3+0xb3>
