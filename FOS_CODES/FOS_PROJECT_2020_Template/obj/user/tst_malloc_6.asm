
obj/user/tst_malloc_6:     file format elf32-i386


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
  800031:	e8 24 0e 00 00       	call   800e5a <libmain>
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
  80004e:	eb 23                	jmp    800073 <_main+0x3b>
		{
			if (myEnv->__uptr_pws[i].empty)
  800050:	a1 20 40 80 00       	mov    0x804020,%eax
  800055:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80005b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005e:	c1 e2 04             	shl    $0x4,%edx
  800061:	01 d0                	add    %edx,%eax
  800063:	8a 40 04             	mov    0x4(%eax),%al
  800066:	84 c0                	test   %al,%al
  800068:	74 06                	je     800070 <_main+0x38>
			{
				fullWS = 0;
  80006a:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006e:	eb 12                	jmp    800082 <_main+0x4a>
void _main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800070:	ff 45 f0             	incl   -0x10(%ebp)
  800073:	a1 20 40 80 00       	mov    0x804020,%eax
  800078:	8b 50 74             	mov    0x74(%eax),%edx
  80007b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007e:	39 c2                	cmp    %eax,%edx
  800080:	77 ce                	ja     800050 <_main+0x18>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800082:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800086:	74 14                	je     80009c <_main+0x64>
  800088:	83 ec 04             	sub    $0x4,%esp
  80008b:	68 80 2c 80 00       	push   $0x802c80
  800090:	6a 1a                	push   $0x1a
  800092:	68 9c 2c 80 00       	push   $0x802c9c
  800097:	e8 03 0f 00 00       	call   800f9f <_panic>





	int Mega = 1024*1024;
  80009c:	c7 45 e4 00 00 10 00 	movl   $0x100000,-0x1c(%ebp)
	int kilo = 1024;
  8000a3:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%ebp)
	char minByte = 1<<7;
  8000aa:	c6 45 df 80          	movb   $0x80,-0x21(%ebp)
	char maxByte = 0x7F;
  8000ae:	c6 45 de 7f          	movb   $0x7f,-0x22(%ebp)
	short minShort = 1<<15 ;
  8000b2:	66 c7 45 dc 00 80    	movw   $0x8000,-0x24(%ebp)
	short maxShort = 0x7FFF;
  8000b8:	66 c7 45 da ff 7f    	movw   $0x7fff,-0x26(%ebp)
	int minInt = 1<<31 ;
  8000be:	c7 45 d4 00 00 00 80 	movl   $0x80000000,-0x2c(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000c5:	c7 45 d0 ff ff ff 7f 	movl   $0x7fffffff,-0x30(%ebp)
	char *byteArr, *byteArr2 ;
	short *shortArr, *shortArr2 ;
	int *intArr;
	struct MyStruct *structArr ;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;
	int start_freeFrames = sys_calculate_free_frames() ;
  8000cc:	e8 45 24 00 00       	call   802516 <sys_calculate_free_frames>
  8000d1:	89 45 cc             	mov    %eax,-0x34(%ebp)

	void* ptr_allocations[20] = {0};
  8000d4:	8d 95 d8 fe ff ff    	lea    -0x128(%ebp),%edx
  8000da:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000df:	b8 00 00 00 00       	mov    $0x0,%eax
  8000e4:	89 d7                	mov    %edx,%edi
  8000e6:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 MB
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000e8:	e8 ac 24 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  8000ed:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f3:	01 c0                	add    %eax,%eax
  8000f5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8000f8:	83 ec 0c             	sub    $0xc,%esp
  8000fb:	50                   	push   %eax
  8000fc:	e8 ca 1e 00 00       	call   801fcb <malloc>
  800101:	83 c4 10             	add    $0x10,%esp
  800104:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80010a:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  800110:	85 c0                	test   %eax,%eax
  800112:	79 0d                	jns    800121 <_main+0xe9>
  800114:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  80011a:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  80011f:	76 14                	jbe    800135 <_main+0xfd>
  800121:	83 ec 04             	sub    $0x4,%esp
  800124:	68 b0 2c 80 00       	push   $0x802cb0
  800129:	6a 36                	push   $0x36
  80012b:	68 9c 2c 80 00       	push   $0x802c9c
  800130:	e8 6a 0e 00 00       	call   800f9f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800135:	e8 5f 24 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  80013a:	2b 45 c8             	sub    -0x38(%ebp),%eax
  80013d:	3d 00 02 00 00       	cmp    $0x200,%eax
  800142:	74 14                	je     800158 <_main+0x120>
  800144:	83 ec 04             	sub    $0x4,%esp
  800147:	68 18 2d 80 00       	push   $0x802d18
  80014c:	6a 37                	push   $0x37
  80014e:	68 9c 2c 80 00       	push   $0x802c9c
  800153:	e8 47 0e 00 00       	call   800f9f <_panic>

		int freeFrames = sys_calculate_free_frames() ;
  800158:	e8 b9 23 00 00       	call   802516 <sys_calculate_free_frames>
  80015d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  800160:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800163:	01 c0                	add    %eax,%eax
  800165:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800168:	48                   	dec    %eax
  800169:	89 45 c0             	mov    %eax,-0x40(%ebp)
		byteArr = (char *) ptr_allocations[0];
  80016c:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  800172:	89 45 bc             	mov    %eax,-0x44(%ebp)
		byteArr[0] = minByte ;
  800175:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800178:	8a 55 df             	mov    -0x21(%ebp),%dl
  80017b:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  80017d:	8b 55 c0             	mov    -0x40(%ebp),%edx
  800180:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800183:	01 c2                	add    %eax,%edx
  800185:	8a 45 de             	mov    -0x22(%ebp),%al
  800188:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  80018a:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  80018d:	e8 84 23 00 00       	call   802516 <sys_calculate_free_frames>
  800192:	29 c3                	sub    %eax,%ebx
  800194:	89 d8                	mov    %ebx,%eax
  800196:	83 f8 03             	cmp    $0x3,%eax
  800199:	74 14                	je     8001af <_main+0x177>
  80019b:	83 ec 04             	sub    $0x4,%esp
  80019e:	68 48 2d 80 00       	push   $0x802d48
  8001a3:	6a 3e                	push   $0x3e
  8001a5:	68 9c 2c 80 00       	push   $0x802c9c
  8001aa:	e8 f0 0d 00 00       	call   800f9f <_panic>
		int var;
		int found = 0;
  8001af:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8001b6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8001bd:	eb 76                	jmp    800235 <_main+0x1fd>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  8001bf:	a1 20 40 80 00       	mov    0x804020,%eax
  8001c4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001ca:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8001cd:	c1 e2 04             	shl    $0x4,%edx
  8001d0:	01 d0                	add    %edx,%eax
  8001d2:	8b 00                	mov    (%eax),%eax
  8001d4:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001d7:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001df:	89 c2                	mov    %eax,%edx
  8001e1:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001e4:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8001e7:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001ea:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001ef:	39 c2                	cmp    %eax,%edx
  8001f1:	75 03                	jne    8001f6 <_main+0x1be>
				found++;
  8001f3:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  8001f6:	a1 20 40 80 00       	mov    0x804020,%eax
  8001fb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800201:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800204:	c1 e2 04             	shl    $0x4,%edx
  800207:	01 d0                	add    %edx,%eax
  800209:	8b 00                	mov    (%eax),%eax
  80020b:	89 45 b0             	mov    %eax,-0x50(%ebp)
  80020e:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800211:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800216:	89 c1                	mov    %eax,%ecx
  800218:	8b 55 c0             	mov    -0x40(%ebp),%edx
  80021b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80021e:	01 d0                	add    %edx,%eax
  800220:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800223:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800226:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80022b:	39 c1                	cmp    %eax,%ecx
  80022d:	75 03                	jne    800232 <_main+0x1fa>
				found++;
  80022f:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr[0] = minByte ;
		byteArr[lastIndexOfByte] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int var;
		int found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800232:	ff 45 ec             	incl   -0x14(%ebp)
  800235:	a1 20 40 80 00       	mov    0x804020,%eax
  80023a:	8b 50 74             	mov    0x74(%eax),%edx
  80023d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800240:	39 c2                	cmp    %eax,%edx
  800242:	0f 87 77 ff ff ff    	ja     8001bf <_main+0x187>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800248:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  80024c:	74 14                	je     800262 <_main+0x22a>
  80024e:	83 ec 04             	sub    $0x4,%esp
  800251:	68 8c 2d 80 00       	push   $0x802d8c
  800256:	6a 48                	push   $0x48
  800258:	68 9c 2c 80 00       	push   $0x802c9c
  80025d:	e8 3d 0d 00 00       	call   800f9f <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800262:	e8 32 23 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  800267:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80026a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80026d:	01 c0                	add    %eax,%eax
  80026f:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	50                   	push   %eax
  800276:	e8 50 1d 00 00       	call   801fcb <malloc>
  80027b:	83 c4 10             	add    $0x10,%esp
  80027e:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800284:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  80028a:	89 c2                	mov    %eax,%edx
  80028c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80028f:	01 c0                	add    %eax,%eax
  800291:	05 00 00 00 80       	add    $0x80000000,%eax
  800296:	39 c2                	cmp    %eax,%edx
  800298:	72 16                	jb     8002b0 <_main+0x278>
  80029a:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  8002a0:	89 c2                	mov    %eax,%edx
  8002a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002a5:	01 c0                	add    %eax,%eax
  8002a7:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002ac:	39 c2                	cmp    %eax,%edx
  8002ae:	76 14                	jbe    8002c4 <_main+0x28c>
  8002b0:	83 ec 04             	sub    $0x4,%esp
  8002b3:	68 b0 2c 80 00       	push   $0x802cb0
  8002b8:	6a 4d                	push   $0x4d
  8002ba:	68 9c 2c 80 00       	push   $0x802c9c
  8002bf:	e8 db 0c 00 00       	call   800f9f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8002c4:	e8 d0 22 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  8002c9:	2b 45 c8             	sub    -0x38(%ebp),%eax
  8002cc:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002d1:	74 14                	je     8002e7 <_main+0x2af>
  8002d3:	83 ec 04             	sub    $0x4,%esp
  8002d6:	68 18 2d 80 00       	push   $0x802d18
  8002db:	6a 4e                	push   $0x4e
  8002dd:	68 9c 2c 80 00       	push   $0x802c9c
  8002e2:	e8 b8 0c 00 00       	call   800f9f <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8002e7:	e8 2a 22 00 00       	call   802516 <sys_calculate_free_frames>
  8002ec:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		shortArr = (short *) ptr_allocations[1];
  8002ef:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  8002f5:	89 45 a8             	mov    %eax,-0x58(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  8002f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002fb:	01 c0                	add    %eax,%eax
  8002fd:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800300:	d1 e8                	shr    %eax
  800302:	48                   	dec    %eax
  800303:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		shortArr[0] = minShort;
  800306:	8b 55 a8             	mov    -0x58(%ebp),%edx
  800309:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80030c:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  80030f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800312:	01 c0                	add    %eax,%eax
  800314:	89 c2                	mov    %eax,%edx
  800316:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800319:	01 c2                	add    %eax,%edx
  80031b:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  80031f:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800322:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800325:	e8 ec 21 00 00       	call   802516 <sys_calculate_free_frames>
  80032a:	29 c3                	sub    %eax,%ebx
  80032c:	89 d8                	mov    %ebx,%eax
  80032e:	83 f8 02             	cmp    $0x2,%eax
  800331:	74 14                	je     800347 <_main+0x30f>
  800333:	83 ec 04             	sub    $0x4,%esp
  800336:	68 48 2d 80 00       	push   $0x802d48
  80033b:	6a 55                	push   $0x55
  80033d:	68 9c 2c 80 00       	push   $0x802c9c
  800342:	e8 58 0c 00 00       	call   800f9f <_panic>
		found = 0;
  800347:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80034e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800355:	eb 7a                	jmp    8003d1 <_main+0x399>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  800357:	a1 20 40 80 00       	mov    0x804020,%eax
  80035c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800362:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800365:	c1 e2 04             	shl    $0x4,%edx
  800368:	01 d0                	add    %edx,%eax
  80036a:	8b 00                	mov    (%eax),%eax
  80036c:	89 45 a0             	mov    %eax,-0x60(%ebp)
  80036f:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800372:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800377:	89 c2                	mov    %eax,%edx
  800379:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80037c:	89 45 9c             	mov    %eax,-0x64(%ebp)
  80037f:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800382:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800387:	39 c2                	cmp    %eax,%edx
  800389:	75 03                	jne    80038e <_main+0x356>
				found++;
  80038b:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  80038e:	a1 20 40 80 00       	mov    0x804020,%eax
  800393:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800399:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80039c:	c1 e2 04             	shl    $0x4,%edx
  80039f:	01 d0                	add    %edx,%eax
  8003a1:	8b 00                	mov    (%eax),%eax
  8003a3:	89 45 98             	mov    %eax,-0x68(%ebp)
  8003a6:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003a9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003ae:	89 c2                	mov    %eax,%edx
  8003b0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003b3:	01 c0                	add    %eax,%eax
  8003b5:	89 c1                	mov    %eax,%ecx
  8003b7:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003ba:	01 c8                	add    %ecx,%eax
  8003bc:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8003bf:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8003c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003c7:	39 c2                	cmp    %eax,%edx
  8003c9:	75 03                	jne    8003ce <_main+0x396>
				found++;
  8003cb:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
		shortArr[0] = minShort;
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8003ce:	ff 45 ec             	incl   -0x14(%ebp)
  8003d1:	a1 20 40 80 00       	mov    0x804020,%eax
  8003d6:	8b 50 74             	mov    0x74(%eax),%edx
  8003d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003dc:	39 c2                	cmp    %eax,%edx
  8003de:	0f 87 73 ff ff ff    	ja     800357 <_main+0x31f>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8003e4:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8003e8:	74 14                	je     8003fe <_main+0x3c6>
  8003ea:	83 ec 04             	sub    $0x4,%esp
  8003ed:	68 8c 2d 80 00       	push   $0x802d8c
  8003f2:	6a 5e                	push   $0x5e
  8003f4:	68 9c 2c 80 00       	push   $0x802c9c
  8003f9:	e8 a1 0b 00 00       	call   800f9f <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003fe:	e8 96 21 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  800403:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800406:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800409:	01 c0                	add    %eax,%eax
  80040b:	83 ec 0c             	sub    $0xc,%esp
  80040e:	50                   	push   %eax
  80040f:	e8 b7 1b 00 00       	call   801fcb <malloc>
  800414:	83 c4 10             	add    $0x10,%esp
  800417:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80041d:	e8 77 21 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  800422:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800425:	83 f8 01             	cmp    $0x1,%eax
  800428:	74 14                	je     80043e <_main+0x406>
  80042a:	83 ec 04             	sub    $0x4,%esp
  80042d:	68 18 2d 80 00       	push   $0x802d18
  800432:	6a 63                	push   $0x63
  800434:	68 9c 2c 80 00       	push   $0x802c9c
  800439:	e8 61 0b 00 00       	call   800f9f <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80043e:	e8 d3 20 00 00       	call   802516 <sys_calculate_free_frames>
  800443:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		intArr = (int *) ptr_allocations[2];
  800446:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  80044c:	89 45 90             	mov    %eax,-0x70(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  80044f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800452:	01 c0                	add    %eax,%eax
  800454:	c1 e8 02             	shr    $0x2,%eax
  800457:	48                   	dec    %eax
  800458:	89 45 8c             	mov    %eax,-0x74(%ebp)
		intArr[0] = minInt;
  80045b:	8b 45 90             	mov    -0x70(%ebp),%eax
  80045e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800461:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  800463:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800466:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046d:	8b 45 90             	mov    -0x70(%ebp),%eax
  800470:	01 c2                	add    %eax,%edx
  800472:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800475:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800477:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  80047a:	e8 97 20 00 00       	call   802516 <sys_calculate_free_frames>
  80047f:	29 c3                	sub    %eax,%ebx
  800481:	89 d8                	mov    %ebx,%eax
  800483:	83 f8 02             	cmp    $0x2,%eax
  800486:	74 14                	je     80049c <_main+0x464>
  800488:	83 ec 04             	sub    $0x4,%esp
  80048b:	68 48 2d 80 00       	push   $0x802d48
  800490:	6a 6a                	push   $0x6a
  800492:	68 9c 2c 80 00       	push   $0x802c9c
  800497:	e8 03 0b 00 00       	call   800f9f <_panic>
		found = 0;
  80049c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8004a3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8004aa:	e9 83 00 00 00       	jmp    800532 <_main+0x4fa>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  8004af:	a1 20 40 80 00       	mov    0x804020,%eax
  8004b4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004ba:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004bd:	c1 e2 04             	shl    $0x4,%edx
  8004c0:	01 d0                	add    %edx,%eax
  8004c2:	8b 00                	mov    (%eax),%eax
  8004c4:	89 45 88             	mov    %eax,-0x78(%ebp)
  8004c7:	8b 45 88             	mov    -0x78(%ebp),%eax
  8004ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004cf:	89 c2                	mov    %eax,%edx
  8004d1:	8b 45 90             	mov    -0x70(%ebp),%eax
  8004d4:	89 45 84             	mov    %eax,-0x7c(%ebp)
  8004d7:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8004da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004df:	39 c2                	cmp    %eax,%edx
  8004e1:	75 03                	jne    8004e6 <_main+0x4ae>
				found++;
  8004e3:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  8004e6:	a1 20 40 80 00       	mov    0x804020,%eax
  8004eb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004f1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004f4:	c1 e2 04             	shl    $0x4,%edx
  8004f7:	01 d0                	add    %edx,%eax
  8004f9:	8b 00                	mov    (%eax),%eax
  8004fb:	89 45 80             	mov    %eax,-0x80(%ebp)
  8004fe:	8b 45 80             	mov    -0x80(%ebp),%eax
  800501:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800506:	89 c2                	mov    %eax,%edx
  800508:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80050b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800512:	8b 45 90             	mov    -0x70(%ebp),%eax
  800515:	01 c8                	add    %ecx,%eax
  800517:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80051d:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800523:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800528:	39 c2                	cmp    %eax,%edx
  80052a:	75 03                	jne    80052f <_main+0x4f7>
				found++;
  80052c:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80052f:	ff 45 ec             	incl   -0x14(%ebp)
  800532:	a1 20 40 80 00       	mov    0x804020,%eax
  800537:	8b 50 74             	mov    0x74(%eax),%edx
  80053a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80053d:	39 c2                	cmp    %eax,%edx
  80053f:	0f 87 6a ff ff ff    	ja     8004af <_main+0x477>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800545:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800549:	74 14                	je     80055f <_main+0x527>
  80054b:	83 ec 04             	sub    $0x4,%esp
  80054e:	68 8c 2d 80 00       	push   $0x802d8c
  800553:	6a 73                	push   $0x73
  800555:	68 9c 2c 80 00       	push   $0x802c9c
  80055a:	e8 40 0a 00 00       	call   800f9f <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  80055f:	e8 b2 1f 00 00       	call   802516 <sys_calculate_free_frames>
  800564:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800567:	e8 2d 20 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  80056c:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  80056f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800572:	01 c0                	add    %eax,%eax
  800574:	83 ec 0c             	sub    $0xc,%esp
  800577:	50                   	push   %eax
  800578:	e8 4e 1a 00 00       	call   801fcb <malloc>
  80057d:	83 c4 10             	add    $0x10,%esp
  800580:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)

		//swap the two addresses if the left node address is not in allocation 2
		if(ptr_allocations[2]>ptr_allocations[3])
  800586:	8b 95 e0 fe ff ff    	mov    -0x120(%ebp),%edx
  80058c:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800592:	39 c2                	cmp    %eax,%edx
  800594:	76 24                	jbe    8005ba <_main+0x582>
		{
			uint32* temp =ptr_allocations[3];
  800596:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  80059c:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
			ptr_allocations[3]=ptr_allocations[2];
  8005a2:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8005a8:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
			ptr_allocations[2]=temp;
  8005ae:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8005b4:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
		}
		//check the first 2 kilo
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8005ba:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8005c0:	89 c2                	mov    %eax,%edx
  8005c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005c5:	c1 e0 02             	shl    $0x2,%eax
  8005c8:	05 00 00 00 80       	add    $0x80000000,%eax
  8005cd:	39 c2                	cmp    %eax,%edx
  8005cf:	72 17                	jb     8005e8 <_main+0x5b0>
  8005d1:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8005d7:	89 c2                	mov    %eax,%edx
  8005d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005dc:	c1 e0 02             	shl    $0x2,%eax
  8005df:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8005e4:	39 c2                	cmp    %eax,%edx
  8005e6:	76 17                	jbe    8005ff <_main+0x5c7>
  8005e8:	83 ec 04             	sub    $0x4,%esp
  8005eb:	68 b0 2c 80 00       	push   $0x802cb0
  8005f0:	68 82 00 00 00       	push   $0x82
  8005f5:	68 9c 2c 80 00       	push   $0x802c9c
  8005fa:	e8 a0 09 00 00       	call   800f9f <_panic>

		//check the second 2 kilo
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega+ 2*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8005ff:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800605:	89 c2                	mov    %eax,%edx
  800607:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80060a:	c1 e0 02             	shl    $0x2,%eax
  80060d:	89 c1                	mov    %eax,%ecx
  80060f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800612:	01 c0                	add    %eax,%eax
  800614:	01 c8                	add    %ecx,%eax
  800616:	05 00 00 00 80       	add    $0x80000000,%eax
  80061b:	39 c2                	cmp    %eax,%edx
  80061d:	72 17                	jb     800636 <_main+0x5fe>
  80061f:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800625:	89 c2                	mov    %eax,%edx
  800627:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80062a:	c1 e0 02             	shl    $0x2,%eax
  80062d:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800632:	39 c2                	cmp    %eax,%edx
  800634:	76 17                	jbe    80064d <_main+0x615>
  800636:	83 ec 04             	sub    $0x4,%esp
  800639:	68 b0 2c 80 00       	push   $0x802cb0
  80063e:	68 85 00 00 00       	push   $0x85
  800643:	68 9c 2c 80 00       	push   $0x802c9c
  800648:	e8 52 09 00 00       	call   800f9f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are allocated in PageFile");
  80064d:	e8 47 1f 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  800652:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  800655:	74 17                	je     80066e <_main+0x636>
  800657:	83 ec 04             	sub    $0x4,%esp
  80065a:	68 18 2d 80 00       	push   $0x802d18
  80065f:	68 86 00 00 00       	push   $0x86
  800664:	68 9c 2c 80 00       	push   $0x802c9c
  800669:	e8 31 09 00 00       	call   800f9f <_panic>

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80066e:	e8 26 1f 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  800673:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800676:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800679:	89 d0                	mov    %edx,%eax
  80067b:	01 c0                	add    %eax,%eax
  80067d:	01 d0                	add    %edx,%eax
  80067f:	01 c0                	add    %eax,%eax
  800681:	01 d0                	add    %edx,%eax
  800683:	83 ec 0c             	sub    $0xc,%esp
  800686:	50                   	push   %eax
  800687:	e8 3f 19 00 00       	call   801fcb <malloc>
  80068c:	83 c4 10             	add    $0x10,%esp
  80068f:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 4*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800695:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  80069b:	89 c2                	mov    %eax,%edx
  80069d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006a0:	c1 e0 02             	shl    $0x2,%eax
  8006a3:	89 c1                	mov    %eax,%ecx
  8006a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a8:	c1 e0 02             	shl    $0x2,%eax
  8006ab:	01 c8                	add    %ecx,%eax
  8006ad:	05 00 00 00 80       	add    $0x80000000,%eax
  8006b2:	39 c2                	cmp    %eax,%edx
  8006b4:	72 21                	jb     8006d7 <_main+0x69f>
  8006b6:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  8006bc:	89 c2                	mov    %eax,%edx
  8006be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006c1:	c1 e0 02             	shl    $0x2,%eax
  8006c4:	89 c1                	mov    %eax,%ecx
  8006c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006c9:	c1 e0 02             	shl    $0x2,%eax
  8006cc:	01 c8                	add    %ecx,%eax
  8006ce:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8006d3:	39 c2                	cmp    %eax,%edx
  8006d5:	76 17                	jbe    8006ee <_main+0x6b6>
  8006d7:	83 ec 04             	sub    $0x4,%esp
  8006da:	68 b0 2c 80 00       	push   $0x802cb0
  8006df:	68 8b 00 00 00       	push   $0x8b
  8006e4:	68 9c 2c 80 00       	push   $0x802c9c
  8006e9:	e8 b1 08 00 00       	call   800f9f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8006ee:	e8 a6 1e 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  8006f3:	2b 45 c8             	sub    -0x38(%ebp),%eax
  8006f6:	83 f8 02             	cmp    $0x2,%eax
  8006f9:	74 17                	je     800712 <_main+0x6da>
  8006fb:	83 ec 04             	sub    $0x4,%esp
  8006fe:	68 18 2d 80 00       	push   $0x802d18
  800703:	68 8c 00 00 00       	push   $0x8c
  800708:	68 9c 2c 80 00       	push   $0x802c9c
  80070d:	e8 8d 08 00 00       	call   800f9f <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800712:	e8 ff 1d 00 00       	call   802516 <sys_calculate_free_frames>
  800717:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  80071a:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  800720:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  800726:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800729:	89 d0                	mov    %edx,%eax
  80072b:	01 c0                	add    %eax,%eax
  80072d:	01 d0                	add    %edx,%eax
  80072f:	01 c0                	add    %eax,%eax
  800731:	01 d0                	add    %edx,%eax
  800733:	c1 e8 03             	shr    $0x3,%eax
  800736:	48                   	dec    %eax
  800737:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  80073d:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800743:	8a 55 df             	mov    -0x21(%ebp),%dl
  800746:	88 10                	mov    %dl,(%eax)
  800748:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
  80074e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800751:	66 89 42 02          	mov    %ax,0x2(%edx)
  800755:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80075b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80075e:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  800761:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800767:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80076e:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800774:	01 c2                	add    %eax,%edx
  800776:	8a 45 de             	mov    -0x22(%ebp),%al
  800779:	88 02                	mov    %al,(%edx)
  80077b:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800781:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800788:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80078e:	01 c2                	add    %eax,%edx
  800790:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  800794:	66 89 42 02          	mov    %ax,0x2(%edx)
  800798:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80079e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007a5:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8007ab:	01 c2                	add    %eax,%edx
  8007ad:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007b0:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007b3:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  8007b6:	e8 5b 1d 00 00       	call   802516 <sys_calculate_free_frames>
  8007bb:	29 c3                	sub    %eax,%ebx
  8007bd:	89 d8                	mov    %ebx,%eax
  8007bf:	83 f8 02             	cmp    $0x2,%eax
  8007c2:	74 17                	je     8007db <_main+0x7a3>
  8007c4:	83 ec 04             	sub    $0x4,%esp
  8007c7:	68 48 2d 80 00       	push   $0x802d48
  8007cc:	68 93 00 00 00       	push   $0x93
  8007d1:	68 9c 2c 80 00       	push   $0x802c9c
  8007d6:	e8 c4 07 00 00       	call   800f9f <_panic>
		found = 0;
  8007db:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8007e2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8007e9:	e9 9e 00 00 00       	jmp    80088c <_main+0x854>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  8007ee:	a1 20 40 80 00       	mov    0x804020,%eax
  8007f3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007f9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8007fc:	c1 e2 04             	shl    $0x4,%edx
  8007ff:	01 d0                	add    %edx,%eax
  800801:	8b 00                	mov    (%eax),%eax
  800803:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800809:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80080f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800814:	89 c2                	mov    %eax,%edx
  800816:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80081c:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800822:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800828:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80082d:	39 c2                	cmp    %eax,%edx
  80082f:	75 03                	jne    800834 <_main+0x7fc>
				found++;
  800831:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  800834:	a1 20 40 80 00       	mov    0x804020,%eax
  800839:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80083f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800842:	c1 e2 04             	shl    $0x4,%edx
  800845:	01 d0                	add    %edx,%eax
  800847:	8b 00                	mov    (%eax),%eax
  800849:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  80084f:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800855:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80085a:	89 c2                	mov    %eax,%edx
  80085c:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800862:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800869:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80086f:	01 c8                	add    %ecx,%eax
  800871:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  800877:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  80087d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800882:	39 c2                	cmp    %eax,%edx
  800884:	75 03                	jne    800889 <_main+0x851>
				found++;
  800886:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800889:	ff 45 ec             	incl   -0x14(%ebp)
  80088c:	a1 20 40 80 00       	mov    0x804020,%eax
  800891:	8b 50 74             	mov    0x74(%eax),%edx
  800894:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800897:	39 c2                	cmp    %eax,%edx
  800899:	0f 87 4f ff ff ff    	ja     8007ee <_main+0x7b6>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  80089f:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8008a3:	74 17                	je     8008bc <_main+0x884>
  8008a5:	83 ec 04             	sub    $0x4,%esp
  8008a8:	68 8c 2d 80 00       	push   $0x802d8c
  8008ad:	68 9c 00 00 00       	push   $0x9c
  8008b2:	68 9c 2c 80 00       	push   $0x802c9c
  8008b7:	e8 e3 06 00 00       	call   800f9f <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8008bc:	e8 55 1c 00 00       	call   802516 <sys_calculate_free_frames>
  8008c1:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008c4:	e8 d0 1c 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  8008c9:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8008cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8008cf:	89 c2                	mov    %eax,%edx
  8008d1:	01 d2                	add    %edx,%edx
  8008d3:	01 d0                	add    %edx,%eax
  8008d5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8008d8:	83 ec 0c             	sub    $0xc,%esp
  8008db:	50                   	push   %eax
  8008dc:	e8 ea 16 00 00       	call   801fcb <malloc>
  8008e1:	83 c4 10             	add    $0x10,%esp
  8008e4:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 12*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 12*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8008ea:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  8008f0:	89 c1                	mov    %eax,%ecx
  8008f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8008f5:	c1 e0 02             	shl    $0x2,%eax
  8008f8:	89 c3                	mov    %eax,%ebx
  8008fa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008fd:	89 d0                	mov    %edx,%eax
  8008ff:	01 c0                	add    %eax,%eax
  800901:	01 d0                	add    %edx,%eax
  800903:	c1 e0 02             	shl    $0x2,%eax
  800906:	01 d8                	add    %ebx,%eax
  800908:	05 00 00 00 80       	add    $0x80000000,%eax
  80090d:	39 c1                	cmp    %eax,%ecx
  80090f:	72 27                	jb     800938 <_main+0x900>
  800911:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  800917:	89 c1                	mov    %eax,%ecx
  800919:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80091c:	c1 e0 02             	shl    $0x2,%eax
  80091f:	89 c3                	mov    %eax,%ebx
  800921:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800924:	89 d0                	mov    %edx,%eax
  800926:	01 c0                	add    %eax,%eax
  800928:	01 d0                	add    %edx,%eax
  80092a:	c1 e0 02             	shl    $0x2,%eax
  80092d:	01 d8                	add    %ebx,%eax
  80092f:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800934:	39 c1                	cmp    %eax,%ecx
  800936:	76 17                	jbe    80094f <_main+0x917>
  800938:	83 ec 04             	sub    $0x4,%esp
  80093b:	68 b0 2c 80 00       	push   $0x802cb0
  800940:	68 a2 00 00 00       	push   $0xa2
  800945:	68 9c 2c 80 00       	push   $0x802c9c
  80094a:	e8 50 06 00 00       	call   800f9f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  80094f:	e8 45 1c 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  800954:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800957:	89 c2                	mov    %eax,%edx
  800959:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80095c:	89 c1                	mov    %eax,%ecx
  80095e:	01 c9                	add    %ecx,%ecx
  800960:	01 c8                	add    %ecx,%eax
  800962:	85 c0                	test   %eax,%eax
  800964:	79 05                	jns    80096b <_main+0x933>
  800966:	05 ff 0f 00 00       	add    $0xfff,%eax
  80096b:	c1 f8 0c             	sar    $0xc,%eax
  80096e:	39 c2                	cmp    %eax,%edx
  800970:	74 17                	je     800989 <_main+0x951>
  800972:	83 ec 04             	sub    $0x4,%esp
  800975:	68 18 2d 80 00       	push   $0x802d18
  80097a:	68 a3 00 00 00       	push   $0xa3
  80097f:	68 9c 2c 80 00       	push   $0x802c9c
  800984:	e8 16 06 00 00       	call   800f9f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800989:	e8 0b 1c 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  80098e:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  800991:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800994:	89 d0                	mov    %edx,%eax
  800996:	01 c0                	add    %eax,%eax
  800998:	01 d0                	add    %edx,%eax
  80099a:	01 c0                	add    %eax,%eax
  80099c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80099f:	83 ec 0c             	sub    $0xc,%esp
  8009a2:	50                   	push   %eax
  8009a3:	e8 23 16 00 00       	call   801fcb <malloc>
  8009a8:	83 c4 10             	add    $0x10,%esp
  8009ab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 12*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 12*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8009b1:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  8009b7:	89 c1                	mov    %eax,%ecx
  8009b9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8009bc:	89 d0                	mov    %edx,%eax
  8009be:	01 c0                	add    %eax,%eax
  8009c0:	01 d0                	add    %edx,%eax
  8009c2:	01 c0                	add    %eax,%eax
  8009c4:	01 d0                	add    %edx,%eax
  8009c6:	89 c3                	mov    %eax,%ebx
  8009c8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009cb:	89 d0                	mov    %edx,%eax
  8009cd:	01 c0                	add    %eax,%eax
  8009cf:	01 d0                	add    %edx,%eax
  8009d1:	c1 e0 02             	shl    $0x2,%eax
  8009d4:	01 d8                	add    %ebx,%eax
  8009d6:	05 00 00 00 80       	add    $0x80000000,%eax
  8009db:	39 c1                	cmp    %eax,%ecx
  8009dd:	72 2e                	jb     800a0d <_main+0x9d5>
  8009df:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  8009e5:	89 c1                	mov    %eax,%ecx
  8009e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8009ea:	89 d0                	mov    %edx,%eax
  8009ec:	01 c0                	add    %eax,%eax
  8009ee:	01 d0                	add    %edx,%eax
  8009f0:	01 c0                	add    %eax,%eax
  8009f2:	01 d0                	add    %edx,%eax
  8009f4:	89 c3                	mov    %eax,%ebx
  8009f6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009f9:	89 d0                	mov    %edx,%eax
  8009fb:	01 c0                	add    %eax,%eax
  8009fd:	01 d0                	add    %edx,%eax
  8009ff:	c1 e0 02             	shl    $0x2,%eax
  800a02:	01 d8                	add    %ebx,%eax
  800a04:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800a09:	39 c1                	cmp    %eax,%ecx
  800a0b:	76 17                	jbe    800a24 <_main+0x9ec>
  800a0d:	83 ec 04             	sub    $0x4,%esp
  800a10:	68 b0 2c 80 00       	push   $0x802cb0
  800a15:	68 a9 00 00 00       	push   $0xa9
  800a1a:	68 9c 2c 80 00       	push   $0x802c9c
  800a1f:	e8 7b 05 00 00       	call   800f9f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800a24:	e8 70 1b 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  800a29:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800a2c:	89 c1                	mov    %eax,%ecx
  800a2e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800a31:	89 d0                	mov    %edx,%eax
  800a33:	01 c0                	add    %eax,%eax
  800a35:	01 d0                	add    %edx,%eax
  800a37:	01 c0                	add    %eax,%eax
  800a39:	85 c0                	test   %eax,%eax
  800a3b:	79 05                	jns    800a42 <_main+0xa0a>
  800a3d:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a42:	c1 f8 0c             	sar    $0xc,%eax
  800a45:	39 c1                	cmp    %eax,%ecx
  800a47:	74 17                	je     800a60 <_main+0xa28>
  800a49:	83 ec 04             	sub    $0x4,%esp
  800a4c:	68 18 2d 80 00       	push   $0x802d18
  800a51:	68 aa 00 00 00       	push   $0xaa
  800a56:	68 9c 2c 80 00       	push   $0x802c9c
  800a5b:	e8 3f 05 00 00       	call   800f9f <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800a60:	e8 b1 1a 00 00       	call   802516 <sys_calculate_free_frames>
  800a65:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  800a68:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800a6b:	89 d0                	mov    %edx,%eax
  800a6d:	01 c0                	add    %eax,%eax
  800a6f:	01 d0                	add    %edx,%eax
  800a71:	01 c0                	add    %eax,%eax
  800a73:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800a76:	48                   	dec    %eax
  800a77:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800a7d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  800a83:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
		byteArr2[0] = minByte ;
  800a89:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800a8f:	8a 55 df             	mov    -0x21(%ebp),%dl
  800a92:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800a94:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800a9a:	89 c2                	mov    %eax,%edx
  800a9c:	c1 ea 1f             	shr    $0x1f,%edx
  800a9f:	01 d0                	add    %edx,%eax
  800aa1:	d1 f8                	sar    %eax
  800aa3:	89 c2                	mov    %eax,%edx
  800aa5:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800aab:	01 c2                	add    %eax,%edx
  800aad:	8a 45 de             	mov    -0x22(%ebp),%al
  800ab0:	88 c1                	mov    %al,%cl
  800ab2:	c0 e9 07             	shr    $0x7,%cl
  800ab5:	01 c8                	add    %ecx,%eax
  800ab7:	d0 f8                	sar    %al
  800ab9:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  800abb:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
  800ac1:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800ac7:	01 c2                	add    %eax,%edx
  800ac9:	8a 45 de             	mov    -0x22(%ebp),%al
  800acc:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800ace:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800ad1:	e8 40 1a 00 00       	call   802516 <sys_calculate_free_frames>
  800ad6:	29 c3                	sub    %eax,%ebx
  800ad8:	89 d8                	mov    %ebx,%eax
  800ada:	83 f8 05             	cmp    $0x5,%eax
  800add:	74 17                	je     800af6 <_main+0xabe>
  800adf:	83 ec 04             	sub    $0x4,%esp
  800ae2:	68 48 2d 80 00       	push   $0x802d48
  800ae7:	68 b2 00 00 00       	push   $0xb2
  800aec:	68 9c 2c 80 00       	push   $0x802c9c
  800af1:	e8 a9 04 00 00       	call   800f9f <_panic>
		found = 0;
  800af6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800afd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800b04:	e9 f0 00 00 00       	jmp    800bf9 <_main+0xbc1>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800b09:	a1 20 40 80 00       	mov    0x804020,%eax
  800b0e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b14:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b17:	c1 e2 04             	shl    $0x4,%edx
  800b1a:	01 d0                	add    %edx,%eax
  800b1c:	8b 00                	mov    (%eax),%eax
  800b1e:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800b24:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b2a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b2f:	89 c2                	mov    %eax,%edx
  800b31:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b37:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b3d:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b43:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b48:	39 c2                	cmp    %eax,%edx
  800b4a:	75 03                	jne    800b4f <_main+0xb17>
				found++;
  800b4c:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800b4f:	a1 20 40 80 00       	mov    0x804020,%eax
  800b54:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b5a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b5d:	c1 e2 04             	shl    $0x4,%edx
  800b60:	01 d0                	add    %edx,%eax
  800b62:	8b 00                	mov    (%eax),%eax
  800b64:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b6a:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b70:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b75:	89 c2                	mov    %eax,%edx
  800b77:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800b7d:	89 c1                	mov    %eax,%ecx
  800b7f:	c1 e9 1f             	shr    $0x1f,%ecx
  800b82:	01 c8                	add    %ecx,%eax
  800b84:	d1 f8                	sar    %eax
  800b86:	89 c1                	mov    %eax,%ecx
  800b88:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b8e:	01 c8                	add    %ecx,%eax
  800b90:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800b96:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800b9c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ba1:	39 c2                	cmp    %eax,%edx
  800ba3:	75 03                	jne    800ba8 <_main+0xb70>
				found++;
  800ba5:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800ba8:	a1 20 40 80 00       	mov    0x804020,%eax
  800bad:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800bb3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800bb6:	c1 e2 04             	shl    $0x4,%edx
  800bb9:	01 d0                	add    %edx,%eax
  800bbb:	8b 00                	mov    (%eax),%eax
  800bbd:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800bc3:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800bc9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bce:	89 c1                	mov    %eax,%ecx
  800bd0:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
  800bd6:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800bdc:	01 d0                	add    %edx,%eax
  800bde:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800be4:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800bea:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bef:	39 c1                	cmp    %eax,%ecx
  800bf1:	75 03                	jne    800bf6 <_main+0xbbe>
				found++;
  800bf3:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800bf6:	ff 45 ec             	incl   -0x14(%ebp)
  800bf9:	a1 20 40 80 00       	mov    0x804020,%eax
  800bfe:	8b 50 74             	mov    0x74(%eax),%edx
  800c01:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c04:	39 c2                	cmp    %eax,%edx
  800c06:	0f 87 fd fe ff ff    	ja     800b09 <_main+0xad1>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  800c0c:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  800c10:	74 17                	je     800c29 <_main+0xbf1>
  800c12:	83 ec 04             	sub    $0x4,%esp
  800c15:	68 8c 2d 80 00       	push   $0x802d8c
  800c1a:	68 bd 00 00 00       	push   $0xbd
  800c1f:	68 9c 2c 80 00       	push   $0x802c9c
  800c24:	e8 76 03 00 00       	call   800f9f <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c29:	e8 6b 19 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  800c2e:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  800c31:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c34:	89 d0                	mov    %edx,%eax
  800c36:	01 c0                	add    %eax,%eax
  800c38:	01 d0                	add    %edx,%eax
  800c3a:	01 c0                	add    %eax,%eax
  800c3c:	01 d0                	add    %edx,%eax
  800c3e:	01 c0                	add    %eax,%eax
  800c40:	83 ec 0c             	sub    $0xc,%esp
  800c43:	50                   	push   %eax
  800c44:	e8 82 13 00 00       	call   801fcb <malloc>
  800c49:	83 c4 10             	add    $0x10,%esp
  800c4c:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 12*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 12*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800c52:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  800c58:	89 c1                	mov    %eax,%ecx
  800c5a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800c5d:	89 d0                	mov    %edx,%eax
  800c5f:	01 c0                	add    %eax,%eax
  800c61:	01 d0                	add    %edx,%eax
  800c63:	c1 e0 02             	shl    $0x2,%eax
  800c66:	01 d0                	add    %edx,%eax
  800c68:	89 c3                	mov    %eax,%ebx
  800c6a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c6d:	89 d0                	mov    %edx,%eax
  800c6f:	01 c0                	add    %eax,%eax
  800c71:	01 d0                	add    %edx,%eax
  800c73:	c1 e0 02             	shl    $0x2,%eax
  800c76:	01 d8                	add    %ebx,%eax
  800c78:	05 00 00 00 80       	add    $0x80000000,%eax
  800c7d:	39 c1                	cmp    %eax,%ecx
  800c7f:	72 2f                	jb     800cb0 <_main+0xc78>
  800c81:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  800c87:	89 c1                	mov    %eax,%ecx
  800c89:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800c8c:	89 d0                	mov    %edx,%eax
  800c8e:	01 c0                	add    %eax,%eax
  800c90:	01 d0                	add    %edx,%eax
  800c92:	c1 e0 02             	shl    $0x2,%eax
  800c95:	01 d0                	add    %edx,%eax
  800c97:	89 c3                	mov    %eax,%ebx
  800c99:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c9c:	89 d0                	mov    %edx,%eax
  800c9e:	01 c0                	add    %eax,%eax
  800ca0:	01 d0                	add    %edx,%eax
  800ca2:	c1 e0 02             	shl    $0x2,%eax
  800ca5:	01 d8                	add    %ebx,%eax
  800ca7:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800cac:	39 c1                	cmp    %eax,%ecx
  800cae:	76 17                	jbe    800cc7 <_main+0xc8f>
  800cb0:	83 ec 04             	sub    $0x4,%esp
  800cb3:	68 b0 2c 80 00       	push   $0x802cb0
  800cb8:	68 c2 00 00 00       	push   $0xc2
  800cbd:	68 9c 2c 80 00       	push   $0x802c9c
  800cc2:	e8 d8 02 00 00       	call   800f9f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800cc7:	e8 cd 18 00 00       	call   802599 <sys_pf_calculate_allocated_pages>
  800ccc:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800ccf:	83 f8 04             	cmp    $0x4,%eax
  800cd2:	74 17                	je     800ceb <_main+0xcb3>
  800cd4:	83 ec 04             	sub    $0x4,%esp
  800cd7:	68 18 2d 80 00       	push   $0x802d18
  800cdc:	68 c3 00 00 00       	push   $0xc3
  800ce1:	68 9c 2c 80 00       	push   $0x802c9c
  800ce6:	e8 b4 02 00 00       	call   800f9f <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800ceb:	e8 26 18 00 00       	call   802516 <sys_calculate_free_frames>
  800cf0:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800cf3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  800cf9:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  800cff:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d02:	89 d0                	mov    %edx,%eax
  800d04:	01 c0                	add    %eax,%eax
  800d06:	01 d0                	add    %edx,%eax
  800d08:	01 c0                	add    %eax,%eax
  800d0a:	01 d0                	add    %edx,%eax
  800d0c:	01 c0                	add    %eax,%eax
  800d0e:	d1 e8                	shr    %eax
  800d10:	48                   	dec    %eax
  800d11:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
		shortArr2[0] = minShort;
  800d17:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  800d1d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d20:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800d23:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d29:	01 c0                	add    %eax,%eax
  800d2b:	89 c2                	mov    %eax,%edx
  800d2d:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800d33:	01 c2                	add    %eax,%edx
  800d35:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  800d39:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800d3c:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800d3f:	e8 d2 17 00 00       	call   802516 <sys_calculate_free_frames>
  800d44:	29 c3                	sub    %eax,%ebx
  800d46:	89 d8                	mov    %ebx,%eax
  800d48:	83 f8 02             	cmp    $0x2,%eax
  800d4b:	74 17                	je     800d64 <_main+0xd2c>
  800d4d:	83 ec 04             	sub    $0x4,%esp
  800d50:	68 48 2d 80 00       	push   $0x802d48
  800d55:	68 ca 00 00 00       	push   $0xca
  800d5a:	68 9c 2c 80 00       	push   $0x802c9c
  800d5f:	e8 3b 02 00 00       	call   800f9f <_panic>
		found = 0;
  800d64:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d6b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800d72:	e9 9b 00 00 00       	jmp    800e12 <_main+0xdda>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800d77:	a1 20 40 80 00       	mov    0x804020,%eax
  800d7c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d82:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d85:	c1 e2 04             	shl    $0x4,%edx
  800d88:	01 d0                	add    %edx,%eax
  800d8a:	8b 00                	mov    (%eax),%eax
  800d8c:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800d92:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800d98:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d9d:	89 c2                	mov    %eax,%edx
  800d9f:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800da5:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800dab:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800db1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800db6:	39 c2                	cmp    %eax,%edx
  800db8:	75 03                	jne    800dbd <_main+0xd85>
				found++;
  800dba:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800dbd:	a1 20 40 80 00       	mov    0x804020,%eax
  800dc2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800dc8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dcb:	c1 e2 04             	shl    $0x4,%edx
  800dce:	01 d0                	add    %edx,%eax
  800dd0:	8b 00                	mov    (%eax),%eax
  800dd2:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800dd8:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800dde:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800de3:	89 c2                	mov    %eax,%edx
  800de5:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800deb:	01 c0                	add    %eax,%eax
  800ded:	89 c1                	mov    %eax,%ecx
  800def:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800df5:	01 c8                	add    %ecx,%eax
  800df7:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  800dfd:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  800e03:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e08:	39 c2                	cmp    %eax,%edx
  800e0a:	75 03                	jne    800e0f <_main+0xdd7>
				found++;
  800e0c:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800e0f:	ff 45 ec             	incl   -0x14(%ebp)
  800e12:	a1 20 40 80 00       	mov    0x804020,%eax
  800e17:	8b 50 74             	mov    0x74(%eax),%edx
  800e1a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e1d:	39 c2                	cmp    %eax,%edx
  800e1f:	0f 87 52 ff ff ff    	ja     800d77 <_main+0xd3f>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800e25:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800e29:	74 17                	je     800e42 <_main+0xe0a>
  800e2b:	83 ec 04             	sub    $0x4,%esp
  800e2e:	68 8c 2d 80 00       	push   $0x802d8c
  800e33:	68 d3 00 00 00       	push   $0xd3
  800e38:	68 9c 2c 80 00       	push   $0x802c9c
  800e3d:	e8 5d 01 00 00       	call   800f9f <_panic>
	}

	cprintf("Congratulations!! test malloc [6] completed successfully.\n");
  800e42:	83 ec 0c             	sub    $0xc,%esp
  800e45:	68 ac 2d 80 00       	push   $0x802dac
  800e4a:	e8 f2 03 00 00       	call   801241 <cprintf>
  800e4f:	83 c4 10             	add    $0x10,%esp

	return;
  800e52:	90                   	nop
}
  800e53:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800e56:	5b                   	pop    %ebx
  800e57:	5f                   	pop    %edi
  800e58:	5d                   	pop    %ebp
  800e59:	c3                   	ret    

00800e5a <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800e5a:	55                   	push   %ebp
  800e5b:	89 e5                	mov    %esp,%ebp
  800e5d:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800e60:	e8 e6 15 00 00       	call   80244b <sys_getenvindex>
  800e65:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800e68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e6b:	89 d0                	mov    %edx,%eax
  800e6d:	c1 e0 03             	shl    $0x3,%eax
  800e70:	01 d0                	add    %edx,%eax
  800e72:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800e79:	01 c8                	add    %ecx,%eax
  800e7b:	01 c0                	add    %eax,%eax
  800e7d:	01 d0                	add    %edx,%eax
  800e7f:	01 c0                	add    %eax,%eax
  800e81:	01 d0                	add    %edx,%eax
  800e83:	89 c2                	mov    %eax,%edx
  800e85:	c1 e2 05             	shl    $0x5,%edx
  800e88:	29 c2                	sub    %eax,%edx
  800e8a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800e91:	89 c2                	mov    %eax,%edx
  800e93:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800e99:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800e9e:	a1 20 40 80 00       	mov    0x804020,%eax
  800ea3:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800ea9:	84 c0                	test   %al,%al
  800eab:	74 0f                	je     800ebc <libmain+0x62>
		binaryname = myEnv->prog_name;
  800ead:	a1 20 40 80 00       	mov    0x804020,%eax
  800eb2:	05 40 3c 01 00       	add    $0x13c40,%eax
  800eb7:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800ebc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ec0:	7e 0a                	jle    800ecc <libmain+0x72>
		binaryname = argv[0];
  800ec2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec5:	8b 00                	mov    (%eax),%eax
  800ec7:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800ecc:	83 ec 08             	sub    $0x8,%esp
  800ecf:	ff 75 0c             	pushl  0xc(%ebp)
  800ed2:	ff 75 08             	pushl  0x8(%ebp)
  800ed5:	e8 5e f1 ff ff       	call   800038 <_main>
  800eda:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800edd:	e8 04 17 00 00       	call   8025e6 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800ee2:	83 ec 0c             	sub    $0xc,%esp
  800ee5:	68 00 2e 80 00       	push   $0x802e00
  800eea:	e8 52 03 00 00       	call   801241 <cprintf>
  800eef:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800ef2:	a1 20 40 80 00       	mov    0x804020,%eax
  800ef7:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800efd:	a1 20 40 80 00       	mov    0x804020,%eax
  800f02:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800f08:	83 ec 04             	sub    $0x4,%esp
  800f0b:	52                   	push   %edx
  800f0c:	50                   	push   %eax
  800f0d:	68 28 2e 80 00       	push   $0x802e28
  800f12:	e8 2a 03 00 00       	call   801241 <cprintf>
  800f17:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800f1a:	a1 20 40 80 00       	mov    0x804020,%eax
  800f1f:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800f25:	a1 20 40 80 00       	mov    0x804020,%eax
  800f2a:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800f30:	83 ec 04             	sub    $0x4,%esp
  800f33:	52                   	push   %edx
  800f34:	50                   	push   %eax
  800f35:	68 50 2e 80 00       	push   $0x802e50
  800f3a:	e8 02 03 00 00       	call   801241 <cprintf>
  800f3f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800f42:	a1 20 40 80 00       	mov    0x804020,%eax
  800f47:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800f4d:	83 ec 08             	sub    $0x8,%esp
  800f50:	50                   	push   %eax
  800f51:	68 91 2e 80 00       	push   $0x802e91
  800f56:	e8 e6 02 00 00       	call   801241 <cprintf>
  800f5b:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800f5e:	83 ec 0c             	sub    $0xc,%esp
  800f61:	68 00 2e 80 00       	push   $0x802e00
  800f66:	e8 d6 02 00 00       	call   801241 <cprintf>
  800f6b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800f6e:	e8 8d 16 00 00       	call   802600 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800f73:	e8 19 00 00 00       	call   800f91 <exit>
}
  800f78:	90                   	nop
  800f79:	c9                   	leave  
  800f7a:	c3                   	ret    

00800f7b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800f7b:	55                   	push   %ebp
  800f7c:	89 e5                	mov    %esp,%ebp
  800f7e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800f81:	83 ec 0c             	sub    $0xc,%esp
  800f84:	6a 00                	push   $0x0
  800f86:	e8 8c 14 00 00       	call   802417 <sys_env_destroy>
  800f8b:	83 c4 10             	add    $0x10,%esp
}
  800f8e:	90                   	nop
  800f8f:	c9                   	leave  
  800f90:	c3                   	ret    

00800f91 <exit>:

void
exit(void)
{
  800f91:	55                   	push   %ebp
  800f92:	89 e5                	mov    %esp,%ebp
  800f94:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800f97:	e8 e1 14 00 00       	call   80247d <sys_env_exit>
}
  800f9c:	90                   	nop
  800f9d:	c9                   	leave  
  800f9e:	c3                   	ret    

00800f9f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800f9f:	55                   	push   %ebp
  800fa0:	89 e5                	mov    %esp,%ebp
  800fa2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800fa5:	8d 45 10             	lea    0x10(%ebp),%eax
  800fa8:	83 c0 04             	add    $0x4,%eax
  800fab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800fae:	a1 18 41 80 00       	mov    0x804118,%eax
  800fb3:	85 c0                	test   %eax,%eax
  800fb5:	74 16                	je     800fcd <_panic+0x2e>
		cprintf("%s: ", argv0);
  800fb7:	a1 18 41 80 00       	mov    0x804118,%eax
  800fbc:	83 ec 08             	sub    $0x8,%esp
  800fbf:	50                   	push   %eax
  800fc0:	68 a8 2e 80 00       	push   $0x802ea8
  800fc5:	e8 77 02 00 00       	call   801241 <cprintf>
  800fca:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800fcd:	a1 00 40 80 00       	mov    0x804000,%eax
  800fd2:	ff 75 0c             	pushl  0xc(%ebp)
  800fd5:	ff 75 08             	pushl  0x8(%ebp)
  800fd8:	50                   	push   %eax
  800fd9:	68 ad 2e 80 00       	push   $0x802ead
  800fde:	e8 5e 02 00 00       	call   801241 <cprintf>
  800fe3:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800fe6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe9:	83 ec 08             	sub    $0x8,%esp
  800fec:	ff 75 f4             	pushl  -0xc(%ebp)
  800fef:	50                   	push   %eax
  800ff0:	e8 e1 01 00 00       	call   8011d6 <vcprintf>
  800ff5:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800ff8:	83 ec 08             	sub    $0x8,%esp
  800ffb:	6a 00                	push   $0x0
  800ffd:	68 c9 2e 80 00       	push   $0x802ec9
  801002:	e8 cf 01 00 00       	call   8011d6 <vcprintf>
  801007:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80100a:	e8 82 ff ff ff       	call   800f91 <exit>

	// should not return here
	while (1) ;
  80100f:	eb fe                	jmp    80100f <_panic+0x70>

00801011 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801011:	55                   	push   %ebp
  801012:	89 e5                	mov    %esp,%ebp
  801014:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801017:	a1 20 40 80 00       	mov    0x804020,%eax
  80101c:	8b 50 74             	mov    0x74(%eax),%edx
  80101f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801022:	39 c2                	cmp    %eax,%edx
  801024:	74 14                	je     80103a <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801026:	83 ec 04             	sub    $0x4,%esp
  801029:	68 cc 2e 80 00       	push   $0x802ecc
  80102e:	6a 26                	push   $0x26
  801030:	68 18 2f 80 00       	push   $0x802f18
  801035:	e8 65 ff ff ff       	call   800f9f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80103a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801041:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801048:	e9 b6 00 00 00       	jmp    801103 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80104d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801050:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801057:	8b 45 08             	mov    0x8(%ebp),%eax
  80105a:	01 d0                	add    %edx,%eax
  80105c:	8b 00                	mov    (%eax),%eax
  80105e:	85 c0                	test   %eax,%eax
  801060:	75 08                	jne    80106a <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801062:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801065:	e9 96 00 00 00       	jmp    801100 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80106a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801071:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801078:	eb 5d                	jmp    8010d7 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80107a:	a1 20 40 80 00       	mov    0x804020,%eax
  80107f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801085:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801088:	c1 e2 04             	shl    $0x4,%edx
  80108b:	01 d0                	add    %edx,%eax
  80108d:	8a 40 04             	mov    0x4(%eax),%al
  801090:	84 c0                	test   %al,%al
  801092:	75 40                	jne    8010d4 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801094:	a1 20 40 80 00       	mov    0x804020,%eax
  801099:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80109f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8010a2:	c1 e2 04             	shl    $0x4,%edx
  8010a5:	01 d0                	add    %edx,%eax
  8010a7:	8b 00                	mov    (%eax),%eax
  8010a9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8010ac:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8010af:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010b4:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8010b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010b9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8010c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c3:	01 c8                	add    %ecx,%eax
  8010c5:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8010c7:	39 c2                	cmp    %eax,%edx
  8010c9:	75 09                	jne    8010d4 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8010cb:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8010d2:	eb 12                	jmp    8010e6 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8010d4:	ff 45 e8             	incl   -0x18(%ebp)
  8010d7:	a1 20 40 80 00       	mov    0x804020,%eax
  8010dc:	8b 50 74             	mov    0x74(%eax),%edx
  8010df:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010e2:	39 c2                	cmp    %eax,%edx
  8010e4:	77 94                	ja     80107a <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8010e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010ea:	75 14                	jne    801100 <CheckWSWithoutLastIndex+0xef>
			panic(
  8010ec:	83 ec 04             	sub    $0x4,%esp
  8010ef:	68 24 2f 80 00       	push   $0x802f24
  8010f4:	6a 3a                	push   $0x3a
  8010f6:	68 18 2f 80 00       	push   $0x802f18
  8010fb:	e8 9f fe ff ff       	call   800f9f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801100:	ff 45 f0             	incl   -0x10(%ebp)
  801103:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801106:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801109:	0f 8c 3e ff ff ff    	jl     80104d <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80110f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801116:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80111d:	eb 20                	jmp    80113f <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80111f:	a1 20 40 80 00       	mov    0x804020,%eax
  801124:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80112a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80112d:	c1 e2 04             	shl    $0x4,%edx
  801130:	01 d0                	add    %edx,%eax
  801132:	8a 40 04             	mov    0x4(%eax),%al
  801135:	3c 01                	cmp    $0x1,%al
  801137:	75 03                	jne    80113c <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801139:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80113c:	ff 45 e0             	incl   -0x20(%ebp)
  80113f:	a1 20 40 80 00       	mov    0x804020,%eax
  801144:	8b 50 74             	mov    0x74(%eax),%edx
  801147:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80114a:	39 c2                	cmp    %eax,%edx
  80114c:	77 d1                	ja     80111f <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80114e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801151:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801154:	74 14                	je     80116a <CheckWSWithoutLastIndex+0x159>
		panic(
  801156:	83 ec 04             	sub    $0x4,%esp
  801159:	68 78 2f 80 00       	push   $0x802f78
  80115e:	6a 44                	push   $0x44
  801160:	68 18 2f 80 00       	push   $0x802f18
  801165:	e8 35 fe ff ff       	call   800f9f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80116a:	90                   	nop
  80116b:	c9                   	leave  
  80116c:	c3                   	ret    

0080116d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80116d:	55                   	push   %ebp
  80116e:	89 e5                	mov    %esp,%ebp
  801170:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801173:	8b 45 0c             	mov    0xc(%ebp),%eax
  801176:	8b 00                	mov    (%eax),%eax
  801178:	8d 48 01             	lea    0x1(%eax),%ecx
  80117b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80117e:	89 0a                	mov    %ecx,(%edx)
  801180:	8b 55 08             	mov    0x8(%ebp),%edx
  801183:	88 d1                	mov    %dl,%cl
  801185:	8b 55 0c             	mov    0xc(%ebp),%edx
  801188:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80118c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118f:	8b 00                	mov    (%eax),%eax
  801191:	3d ff 00 00 00       	cmp    $0xff,%eax
  801196:	75 2c                	jne    8011c4 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801198:	a0 24 40 80 00       	mov    0x804024,%al
  80119d:	0f b6 c0             	movzbl %al,%eax
  8011a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011a3:	8b 12                	mov    (%edx),%edx
  8011a5:	89 d1                	mov    %edx,%ecx
  8011a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011aa:	83 c2 08             	add    $0x8,%edx
  8011ad:	83 ec 04             	sub    $0x4,%esp
  8011b0:	50                   	push   %eax
  8011b1:	51                   	push   %ecx
  8011b2:	52                   	push   %edx
  8011b3:	e8 1d 12 00 00       	call   8023d5 <sys_cputs>
  8011b8:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8011bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8011c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c7:	8b 40 04             	mov    0x4(%eax),%eax
  8011ca:	8d 50 01             	lea    0x1(%eax),%edx
  8011cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d0:	89 50 04             	mov    %edx,0x4(%eax)
}
  8011d3:	90                   	nop
  8011d4:	c9                   	leave  
  8011d5:	c3                   	ret    

008011d6 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8011d6:	55                   	push   %ebp
  8011d7:	89 e5                	mov    %esp,%ebp
  8011d9:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8011df:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8011e6:	00 00 00 
	b.cnt = 0;
  8011e9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8011f0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8011f3:	ff 75 0c             	pushl  0xc(%ebp)
  8011f6:	ff 75 08             	pushl  0x8(%ebp)
  8011f9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8011ff:	50                   	push   %eax
  801200:	68 6d 11 80 00       	push   $0x80116d
  801205:	e8 11 02 00 00       	call   80141b <vprintfmt>
  80120a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80120d:	a0 24 40 80 00       	mov    0x804024,%al
  801212:	0f b6 c0             	movzbl %al,%eax
  801215:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80121b:	83 ec 04             	sub    $0x4,%esp
  80121e:	50                   	push   %eax
  80121f:	52                   	push   %edx
  801220:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801226:	83 c0 08             	add    $0x8,%eax
  801229:	50                   	push   %eax
  80122a:	e8 a6 11 00 00       	call   8023d5 <sys_cputs>
  80122f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801232:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801239:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80123f:	c9                   	leave  
  801240:	c3                   	ret    

00801241 <cprintf>:

int cprintf(const char *fmt, ...) {
  801241:	55                   	push   %ebp
  801242:	89 e5                	mov    %esp,%ebp
  801244:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801247:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  80124e:	8d 45 0c             	lea    0xc(%ebp),%eax
  801251:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801254:	8b 45 08             	mov    0x8(%ebp),%eax
  801257:	83 ec 08             	sub    $0x8,%esp
  80125a:	ff 75 f4             	pushl  -0xc(%ebp)
  80125d:	50                   	push   %eax
  80125e:	e8 73 ff ff ff       	call   8011d6 <vcprintf>
  801263:	83 c4 10             	add    $0x10,%esp
  801266:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801269:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80126c:	c9                   	leave  
  80126d:	c3                   	ret    

0080126e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80126e:	55                   	push   %ebp
  80126f:	89 e5                	mov    %esp,%ebp
  801271:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801274:	e8 6d 13 00 00       	call   8025e6 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801279:	8d 45 0c             	lea    0xc(%ebp),%eax
  80127c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80127f:	8b 45 08             	mov    0x8(%ebp),%eax
  801282:	83 ec 08             	sub    $0x8,%esp
  801285:	ff 75 f4             	pushl  -0xc(%ebp)
  801288:	50                   	push   %eax
  801289:	e8 48 ff ff ff       	call   8011d6 <vcprintf>
  80128e:	83 c4 10             	add    $0x10,%esp
  801291:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801294:	e8 67 13 00 00       	call   802600 <sys_enable_interrupt>
	return cnt;
  801299:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80129c:	c9                   	leave  
  80129d:	c3                   	ret    

0080129e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80129e:	55                   	push   %ebp
  80129f:	89 e5                	mov    %esp,%ebp
  8012a1:	53                   	push   %ebx
  8012a2:	83 ec 14             	sub    $0x14,%esp
  8012a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8012ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8012b1:	8b 45 18             	mov    0x18(%ebp),%eax
  8012b4:	ba 00 00 00 00       	mov    $0x0,%edx
  8012b9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8012bc:	77 55                	ja     801313 <printnum+0x75>
  8012be:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8012c1:	72 05                	jb     8012c8 <printnum+0x2a>
  8012c3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012c6:	77 4b                	ja     801313 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8012c8:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8012cb:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8012ce:	8b 45 18             	mov    0x18(%ebp),%eax
  8012d1:	ba 00 00 00 00       	mov    $0x0,%edx
  8012d6:	52                   	push   %edx
  8012d7:	50                   	push   %eax
  8012d8:	ff 75 f4             	pushl  -0xc(%ebp)
  8012db:	ff 75 f0             	pushl  -0x10(%ebp)
  8012de:	e8 25 17 00 00       	call   802a08 <__udivdi3>
  8012e3:	83 c4 10             	add    $0x10,%esp
  8012e6:	83 ec 04             	sub    $0x4,%esp
  8012e9:	ff 75 20             	pushl  0x20(%ebp)
  8012ec:	53                   	push   %ebx
  8012ed:	ff 75 18             	pushl  0x18(%ebp)
  8012f0:	52                   	push   %edx
  8012f1:	50                   	push   %eax
  8012f2:	ff 75 0c             	pushl  0xc(%ebp)
  8012f5:	ff 75 08             	pushl  0x8(%ebp)
  8012f8:	e8 a1 ff ff ff       	call   80129e <printnum>
  8012fd:	83 c4 20             	add    $0x20,%esp
  801300:	eb 1a                	jmp    80131c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801302:	83 ec 08             	sub    $0x8,%esp
  801305:	ff 75 0c             	pushl  0xc(%ebp)
  801308:	ff 75 20             	pushl  0x20(%ebp)
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	ff d0                	call   *%eax
  801310:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801313:	ff 4d 1c             	decl   0x1c(%ebp)
  801316:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80131a:	7f e6                	jg     801302 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80131c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80131f:	bb 00 00 00 00       	mov    $0x0,%ebx
  801324:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801327:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80132a:	53                   	push   %ebx
  80132b:	51                   	push   %ecx
  80132c:	52                   	push   %edx
  80132d:	50                   	push   %eax
  80132e:	e8 e5 17 00 00       	call   802b18 <__umoddi3>
  801333:	83 c4 10             	add    $0x10,%esp
  801336:	05 f4 31 80 00       	add    $0x8031f4,%eax
  80133b:	8a 00                	mov    (%eax),%al
  80133d:	0f be c0             	movsbl %al,%eax
  801340:	83 ec 08             	sub    $0x8,%esp
  801343:	ff 75 0c             	pushl  0xc(%ebp)
  801346:	50                   	push   %eax
  801347:	8b 45 08             	mov    0x8(%ebp),%eax
  80134a:	ff d0                	call   *%eax
  80134c:	83 c4 10             	add    $0x10,%esp
}
  80134f:	90                   	nop
  801350:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801353:	c9                   	leave  
  801354:	c3                   	ret    

00801355 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801355:	55                   	push   %ebp
  801356:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801358:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80135c:	7e 1c                	jle    80137a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80135e:	8b 45 08             	mov    0x8(%ebp),%eax
  801361:	8b 00                	mov    (%eax),%eax
  801363:	8d 50 08             	lea    0x8(%eax),%edx
  801366:	8b 45 08             	mov    0x8(%ebp),%eax
  801369:	89 10                	mov    %edx,(%eax)
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	8b 00                	mov    (%eax),%eax
  801370:	83 e8 08             	sub    $0x8,%eax
  801373:	8b 50 04             	mov    0x4(%eax),%edx
  801376:	8b 00                	mov    (%eax),%eax
  801378:	eb 40                	jmp    8013ba <getuint+0x65>
	else if (lflag)
  80137a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80137e:	74 1e                	je     80139e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801380:	8b 45 08             	mov    0x8(%ebp),%eax
  801383:	8b 00                	mov    (%eax),%eax
  801385:	8d 50 04             	lea    0x4(%eax),%edx
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	89 10                	mov    %edx,(%eax)
  80138d:	8b 45 08             	mov    0x8(%ebp),%eax
  801390:	8b 00                	mov    (%eax),%eax
  801392:	83 e8 04             	sub    $0x4,%eax
  801395:	8b 00                	mov    (%eax),%eax
  801397:	ba 00 00 00 00       	mov    $0x0,%edx
  80139c:	eb 1c                	jmp    8013ba <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	8b 00                	mov    (%eax),%eax
  8013a3:	8d 50 04             	lea    0x4(%eax),%edx
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a9:	89 10                	mov    %edx,(%eax)
  8013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ae:	8b 00                	mov    (%eax),%eax
  8013b0:	83 e8 04             	sub    $0x4,%eax
  8013b3:	8b 00                	mov    (%eax),%eax
  8013b5:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8013ba:	5d                   	pop    %ebp
  8013bb:	c3                   	ret    

008013bc <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8013bc:	55                   	push   %ebp
  8013bd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8013bf:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8013c3:	7e 1c                	jle    8013e1 <getint+0x25>
		return va_arg(*ap, long long);
  8013c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c8:	8b 00                	mov    (%eax),%eax
  8013ca:	8d 50 08             	lea    0x8(%eax),%edx
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	89 10                	mov    %edx,(%eax)
  8013d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d5:	8b 00                	mov    (%eax),%eax
  8013d7:	83 e8 08             	sub    $0x8,%eax
  8013da:	8b 50 04             	mov    0x4(%eax),%edx
  8013dd:	8b 00                	mov    (%eax),%eax
  8013df:	eb 38                	jmp    801419 <getint+0x5d>
	else if (lflag)
  8013e1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013e5:	74 1a                	je     801401 <getint+0x45>
		return va_arg(*ap, long);
  8013e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ea:	8b 00                	mov    (%eax),%eax
  8013ec:	8d 50 04             	lea    0x4(%eax),%edx
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f2:	89 10                	mov    %edx,(%eax)
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	8b 00                	mov    (%eax),%eax
  8013f9:	83 e8 04             	sub    $0x4,%eax
  8013fc:	8b 00                	mov    (%eax),%eax
  8013fe:	99                   	cltd   
  8013ff:	eb 18                	jmp    801419 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	8b 00                	mov    (%eax),%eax
  801406:	8d 50 04             	lea    0x4(%eax),%edx
  801409:	8b 45 08             	mov    0x8(%ebp),%eax
  80140c:	89 10                	mov    %edx,(%eax)
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	8b 00                	mov    (%eax),%eax
  801413:	83 e8 04             	sub    $0x4,%eax
  801416:	8b 00                	mov    (%eax),%eax
  801418:	99                   	cltd   
}
  801419:	5d                   	pop    %ebp
  80141a:	c3                   	ret    

0080141b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80141b:	55                   	push   %ebp
  80141c:	89 e5                	mov    %esp,%ebp
  80141e:	56                   	push   %esi
  80141f:	53                   	push   %ebx
  801420:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801423:	eb 17                	jmp    80143c <vprintfmt+0x21>
			if (ch == '\0')
  801425:	85 db                	test   %ebx,%ebx
  801427:	0f 84 af 03 00 00    	je     8017dc <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80142d:	83 ec 08             	sub    $0x8,%esp
  801430:	ff 75 0c             	pushl  0xc(%ebp)
  801433:	53                   	push   %ebx
  801434:	8b 45 08             	mov    0x8(%ebp),%eax
  801437:	ff d0                	call   *%eax
  801439:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80143c:	8b 45 10             	mov    0x10(%ebp),%eax
  80143f:	8d 50 01             	lea    0x1(%eax),%edx
  801442:	89 55 10             	mov    %edx,0x10(%ebp)
  801445:	8a 00                	mov    (%eax),%al
  801447:	0f b6 d8             	movzbl %al,%ebx
  80144a:	83 fb 25             	cmp    $0x25,%ebx
  80144d:	75 d6                	jne    801425 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80144f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801453:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80145a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801461:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801468:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80146f:	8b 45 10             	mov    0x10(%ebp),%eax
  801472:	8d 50 01             	lea    0x1(%eax),%edx
  801475:	89 55 10             	mov    %edx,0x10(%ebp)
  801478:	8a 00                	mov    (%eax),%al
  80147a:	0f b6 d8             	movzbl %al,%ebx
  80147d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801480:	83 f8 55             	cmp    $0x55,%eax
  801483:	0f 87 2b 03 00 00    	ja     8017b4 <vprintfmt+0x399>
  801489:	8b 04 85 18 32 80 00 	mov    0x803218(,%eax,4),%eax
  801490:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801492:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801496:	eb d7                	jmp    80146f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801498:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80149c:	eb d1                	jmp    80146f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80149e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8014a5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8014a8:	89 d0                	mov    %edx,%eax
  8014aa:	c1 e0 02             	shl    $0x2,%eax
  8014ad:	01 d0                	add    %edx,%eax
  8014af:	01 c0                	add    %eax,%eax
  8014b1:	01 d8                	add    %ebx,%eax
  8014b3:	83 e8 30             	sub    $0x30,%eax
  8014b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8014b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014bc:	8a 00                	mov    (%eax),%al
  8014be:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8014c1:	83 fb 2f             	cmp    $0x2f,%ebx
  8014c4:	7e 3e                	jle    801504 <vprintfmt+0xe9>
  8014c6:	83 fb 39             	cmp    $0x39,%ebx
  8014c9:	7f 39                	jg     801504 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8014cb:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8014ce:	eb d5                	jmp    8014a5 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8014d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d3:	83 c0 04             	add    $0x4,%eax
  8014d6:	89 45 14             	mov    %eax,0x14(%ebp)
  8014d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8014dc:	83 e8 04             	sub    $0x4,%eax
  8014df:	8b 00                	mov    (%eax),%eax
  8014e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8014e4:	eb 1f                	jmp    801505 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8014e6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8014ea:	79 83                	jns    80146f <vprintfmt+0x54>
				width = 0;
  8014ec:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8014f3:	e9 77 ff ff ff       	jmp    80146f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8014f8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8014ff:	e9 6b ff ff ff       	jmp    80146f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801504:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801505:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801509:	0f 89 60 ff ff ff    	jns    80146f <vprintfmt+0x54>
				width = precision, precision = -1;
  80150f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801512:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801515:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80151c:	e9 4e ff ff ff       	jmp    80146f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801521:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801524:	e9 46 ff ff ff       	jmp    80146f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801529:	8b 45 14             	mov    0x14(%ebp),%eax
  80152c:	83 c0 04             	add    $0x4,%eax
  80152f:	89 45 14             	mov    %eax,0x14(%ebp)
  801532:	8b 45 14             	mov    0x14(%ebp),%eax
  801535:	83 e8 04             	sub    $0x4,%eax
  801538:	8b 00                	mov    (%eax),%eax
  80153a:	83 ec 08             	sub    $0x8,%esp
  80153d:	ff 75 0c             	pushl  0xc(%ebp)
  801540:	50                   	push   %eax
  801541:	8b 45 08             	mov    0x8(%ebp),%eax
  801544:	ff d0                	call   *%eax
  801546:	83 c4 10             	add    $0x10,%esp
			break;
  801549:	e9 89 02 00 00       	jmp    8017d7 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80154e:	8b 45 14             	mov    0x14(%ebp),%eax
  801551:	83 c0 04             	add    $0x4,%eax
  801554:	89 45 14             	mov    %eax,0x14(%ebp)
  801557:	8b 45 14             	mov    0x14(%ebp),%eax
  80155a:	83 e8 04             	sub    $0x4,%eax
  80155d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80155f:	85 db                	test   %ebx,%ebx
  801561:	79 02                	jns    801565 <vprintfmt+0x14a>
				err = -err;
  801563:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801565:	83 fb 64             	cmp    $0x64,%ebx
  801568:	7f 0b                	jg     801575 <vprintfmt+0x15a>
  80156a:	8b 34 9d 60 30 80 00 	mov    0x803060(,%ebx,4),%esi
  801571:	85 f6                	test   %esi,%esi
  801573:	75 19                	jne    80158e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801575:	53                   	push   %ebx
  801576:	68 05 32 80 00       	push   $0x803205
  80157b:	ff 75 0c             	pushl  0xc(%ebp)
  80157e:	ff 75 08             	pushl  0x8(%ebp)
  801581:	e8 5e 02 00 00       	call   8017e4 <printfmt>
  801586:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801589:	e9 49 02 00 00       	jmp    8017d7 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80158e:	56                   	push   %esi
  80158f:	68 0e 32 80 00       	push   $0x80320e
  801594:	ff 75 0c             	pushl  0xc(%ebp)
  801597:	ff 75 08             	pushl  0x8(%ebp)
  80159a:	e8 45 02 00 00       	call   8017e4 <printfmt>
  80159f:	83 c4 10             	add    $0x10,%esp
			break;
  8015a2:	e9 30 02 00 00       	jmp    8017d7 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8015a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8015aa:	83 c0 04             	add    $0x4,%eax
  8015ad:	89 45 14             	mov    %eax,0x14(%ebp)
  8015b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8015b3:	83 e8 04             	sub    $0x4,%eax
  8015b6:	8b 30                	mov    (%eax),%esi
  8015b8:	85 f6                	test   %esi,%esi
  8015ba:	75 05                	jne    8015c1 <vprintfmt+0x1a6>
				p = "(null)";
  8015bc:	be 11 32 80 00       	mov    $0x803211,%esi
			if (width > 0 && padc != '-')
  8015c1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8015c5:	7e 6d                	jle    801634 <vprintfmt+0x219>
  8015c7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8015cb:	74 67                	je     801634 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8015cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015d0:	83 ec 08             	sub    $0x8,%esp
  8015d3:	50                   	push   %eax
  8015d4:	56                   	push   %esi
  8015d5:	e8 0c 03 00 00       	call   8018e6 <strnlen>
  8015da:	83 c4 10             	add    $0x10,%esp
  8015dd:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8015e0:	eb 16                	jmp    8015f8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8015e2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8015e6:	83 ec 08             	sub    $0x8,%esp
  8015e9:	ff 75 0c             	pushl  0xc(%ebp)
  8015ec:	50                   	push   %eax
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	ff d0                	call   *%eax
  8015f2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8015f5:	ff 4d e4             	decl   -0x1c(%ebp)
  8015f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8015fc:	7f e4                	jg     8015e2 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8015fe:	eb 34                	jmp    801634 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801600:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801604:	74 1c                	je     801622 <vprintfmt+0x207>
  801606:	83 fb 1f             	cmp    $0x1f,%ebx
  801609:	7e 05                	jle    801610 <vprintfmt+0x1f5>
  80160b:	83 fb 7e             	cmp    $0x7e,%ebx
  80160e:	7e 12                	jle    801622 <vprintfmt+0x207>
					putch('?', putdat);
  801610:	83 ec 08             	sub    $0x8,%esp
  801613:	ff 75 0c             	pushl  0xc(%ebp)
  801616:	6a 3f                	push   $0x3f
  801618:	8b 45 08             	mov    0x8(%ebp),%eax
  80161b:	ff d0                	call   *%eax
  80161d:	83 c4 10             	add    $0x10,%esp
  801620:	eb 0f                	jmp    801631 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801622:	83 ec 08             	sub    $0x8,%esp
  801625:	ff 75 0c             	pushl  0xc(%ebp)
  801628:	53                   	push   %ebx
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
  80162c:	ff d0                	call   *%eax
  80162e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801631:	ff 4d e4             	decl   -0x1c(%ebp)
  801634:	89 f0                	mov    %esi,%eax
  801636:	8d 70 01             	lea    0x1(%eax),%esi
  801639:	8a 00                	mov    (%eax),%al
  80163b:	0f be d8             	movsbl %al,%ebx
  80163e:	85 db                	test   %ebx,%ebx
  801640:	74 24                	je     801666 <vprintfmt+0x24b>
  801642:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801646:	78 b8                	js     801600 <vprintfmt+0x1e5>
  801648:	ff 4d e0             	decl   -0x20(%ebp)
  80164b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80164f:	79 af                	jns    801600 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801651:	eb 13                	jmp    801666 <vprintfmt+0x24b>
				putch(' ', putdat);
  801653:	83 ec 08             	sub    $0x8,%esp
  801656:	ff 75 0c             	pushl  0xc(%ebp)
  801659:	6a 20                	push   $0x20
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	ff d0                	call   *%eax
  801660:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801663:	ff 4d e4             	decl   -0x1c(%ebp)
  801666:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80166a:	7f e7                	jg     801653 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80166c:	e9 66 01 00 00       	jmp    8017d7 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801671:	83 ec 08             	sub    $0x8,%esp
  801674:	ff 75 e8             	pushl  -0x18(%ebp)
  801677:	8d 45 14             	lea    0x14(%ebp),%eax
  80167a:	50                   	push   %eax
  80167b:	e8 3c fd ff ff       	call   8013bc <getint>
  801680:	83 c4 10             	add    $0x10,%esp
  801683:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801686:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801689:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80168c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80168f:	85 d2                	test   %edx,%edx
  801691:	79 23                	jns    8016b6 <vprintfmt+0x29b>
				putch('-', putdat);
  801693:	83 ec 08             	sub    $0x8,%esp
  801696:	ff 75 0c             	pushl  0xc(%ebp)
  801699:	6a 2d                	push   $0x2d
  80169b:	8b 45 08             	mov    0x8(%ebp),%eax
  80169e:	ff d0                	call   *%eax
  8016a0:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8016a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016a9:	f7 d8                	neg    %eax
  8016ab:	83 d2 00             	adc    $0x0,%edx
  8016ae:	f7 da                	neg    %edx
  8016b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016b3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8016b6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8016bd:	e9 bc 00 00 00       	jmp    80177e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8016c2:	83 ec 08             	sub    $0x8,%esp
  8016c5:	ff 75 e8             	pushl  -0x18(%ebp)
  8016c8:	8d 45 14             	lea    0x14(%ebp),%eax
  8016cb:	50                   	push   %eax
  8016cc:	e8 84 fc ff ff       	call   801355 <getuint>
  8016d1:	83 c4 10             	add    $0x10,%esp
  8016d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8016da:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8016e1:	e9 98 00 00 00       	jmp    80177e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8016e6:	83 ec 08             	sub    $0x8,%esp
  8016e9:	ff 75 0c             	pushl  0xc(%ebp)
  8016ec:	6a 58                	push   $0x58
  8016ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f1:	ff d0                	call   *%eax
  8016f3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8016f6:	83 ec 08             	sub    $0x8,%esp
  8016f9:	ff 75 0c             	pushl  0xc(%ebp)
  8016fc:	6a 58                	push   $0x58
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	ff d0                	call   *%eax
  801703:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801706:	83 ec 08             	sub    $0x8,%esp
  801709:	ff 75 0c             	pushl  0xc(%ebp)
  80170c:	6a 58                	push   $0x58
  80170e:	8b 45 08             	mov    0x8(%ebp),%eax
  801711:	ff d0                	call   *%eax
  801713:	83 c4 10             	add    $0x10,%esp
			break;
  801716:	e9 bc 00 00 00       	jmp    8017d7 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80171b:	83 ec 08             	sub    $0x8,%esp
  80171e:	ff 75 0c             	pushl  0xc(%ebp)
  801721:	6a 30                	push   $0x30
  801723:	8b 45 08             	mov    0x8(%ebp),%eax
  801726:	ff d0                	call   *%eax
  801728:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80172b:	83 ec 08             	sub    $0x8,%esp
  80172e:	ff 75 0c             	pushl  0xc(%ebp)
  801731:	6a 78                	push   $0x78
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	ff d0                	call   *%eax
  801738:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80173b:	8b 45 14             	mov    0x14(%ebp),%eax
  80173e:	83 c0 04             	add    $0x4,%eax
  801741:	89 45 14             	mov    %eax,0x14(%ebp)
  801744:	8b 45 14             	mov    0x14(%ebp),%eax
  801747:	83 e8 04             	sub    $0x4,%eax
  80174a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80174c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80174f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801756:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80175d:	eb 1f                	jmp    80177e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80175f:	83 ec 08             	sub    $0x8,%esp
  801762:	ff 75 e8             	pushl  -0x18(%ebp)
  801765:	8d 45 14             	lea    0x14(%ebp),%eax
  801768:	50                   	push   %eax
  801769:	e8 e7 fb ff ff       	call   801355 <getuint>
  80176e:	83 c4 10             	add    $0x10,%esp
  801771:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801774:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801777:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80177e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801782:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801785:	83 ec 04             	sub    $0x4,%esp
  801788:	52                   	push   %edx
  801789:	ff 75 e4             	pushl  -0x1c(%ebp)
  80178c:	50                   	push   %eax
  80178d:	ff 75 f4             	pushl  -0xc(%ebp)
  801790:	ff 75 f0             	pushl  -0x10(%ebp)
  801793:	ff 75 0c             	pushl  0xc(%ebp)
  801796:	ff 75 08             	pushl  0x8(%ebp)
  801799:	e8 00 fb ff ff       	call   80129e <printnum>
  80179e:	83 c4 20             	add    $0x20,%esp
			break;
  8017a1:	eb 34                	jmp    8017d7 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8017a3:	83 ec 08             	sub    $0x8,%esp
  8017a6:	ff 75 0c             	pushl  0xc(%ebp)
  8017a9:	53                   	push   %ebx
  8017aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ad:	ff d0                	call   *%eax
  8017af:	83 c4 10             	add    $0x10,%esp
			break;
  8017b2:	eb 23                	jmp    8017d7 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8017b4:	83 ec 08             	sub    $0x8,%esp
  8017b7:	ff 75 0c             	pushl  0xc(%ebp)
  8017ba:	6a 25                	push   $0x25
  8017bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bf:	ff d0                	call   *%eax
  8017c1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8017c4:	ff 4d 10             	decl   0x10(%ebp)
  8017c7:	eb 03                	jmp    8017cc <vprintfmt+0x3b1>
  8017c9:	ff 4d 10             	decl   0x10(%ebp)
  8017cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8017cf:	48                   	dec    %eax
  8017d0:	8a 00                	mov    (%eax),%al
  8017d2:	3c 25                	cmp    $0x25,%al
  8017d4:	75 f3                	jne    8017c9 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8017d6:	90                   	nop
		}
	}
  8017d7:	e9 47 fc ff ff       	jmp    801423 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8017dc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8017dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017e0:	5b                   	pop    %ebx
  8017e1:	5e                   	pop    %esi
  8017e2:	5d                   	pop    %ebp
  8017e3:	c3                   	ret    

008017e4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
  8017e7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8017ea:	8d 45 10             	lea    0x10(%ebp),%eax
  8017ed:	83 c0 04             	add    $0x4,%eax
  8017f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8017f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8017f9:	50                   	push   %eax
  8017fa:	ff 75 0c             	pushl  0xc(%ebp)
  8017fd:	ff 75 08             	pushl  0x8(%ebp)
  801800:	e8 16 fc ff ff       	call   80141b <vprintfmt>
  801805:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801808:	90                   	nop
  801809:	c9                   	leave  
  80180a:	c3                   	ret    

0080180b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80180b:	55                   	push   %ebp
  80180c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80180e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801811:	8b 40 08             	mov    0x8(%eax),%eax
  801814:	8d 50 01             	lea    0x1(%eax),%edx
  801817:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80181d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801820:	8b 10                	mov    (%eax),%edx
  801822:	8b 45 0c             	mov    0xc(%ebp),%eax
  801825:	8b 40 04             	mov    0x4(%eax),%eax
  801828:	39 c2                	cmp    %eax,%edx
  80182a:	73 12                	jae    80183e <sprintputch+0x33>
		*b->buf++ = ch;
  80182c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182f:	8b 00                	mov    (%eax),%eax
  801831:	8d 48 01             	lea    0x1(%eax),%ecx
  801834:	8b 55 0c             	mov    0xc(%ebp),%edx
  801837:	89 0a                	mov    %ecx,(%edx)
  801839:	8b 55 08             	mov    0x8(%ebp),%edx
  80183c:	88 10                	mov    %dl,(%eax)
}
  80183e:	90                   	nop
  80183f:	5d                   	pop    %ebp
  801840:	c3                   	ret    

00801841 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801841:	55                   	push   %ebp
  801842:	89 e5                	mov    %esp,%ebp
  801844:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801847:	8b 45 08             	mov    0x8(%ebp),%eax
  80184a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80184d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801850:	8d 50 ff             	lea    -0x1(%eax),%edx
  801853:	8b 45 08             	mov    0x8(%ebp),%eax
  801856:	01 d0                	add    %edx,%eax
  801858:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80185b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801862:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801866:	74 06                	je     80186e <vsnprintf+0x2d>
  801868:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80186c:	7f 07                	jg     801875 <vsnprintf+0x34>
		return -E_INVAL;
  80186e:	b8 03 00 00 00       	mov    $0x3,%eax
  801873:	eb 20                	jmp    801895 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801875:	ff 75 14             	pushl  0x14(%ebp)
  801878:	ff 75 10             	pushl  0x10(%ebp)
  80187b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80187e:	50                   	push   %eax
  80187f:	68 0b 18 80 00       	push   $0x80180b
  801884:	e8 92 fb ff ff       	call   80141b <vprintfmt>
  801889:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80188c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80188f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801892:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
  80189a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80189d:	8d 45 10             	lea    0x10(%ebp),%eax
  8018a0:	83 c0 04             	add    $0x4,%eax
  8018a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8018a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8018ac:	50                   	push   %eax
  8018ad:	ff 75 0c             	pushl  0xc(%ebp)
  8018b0:	ff 75 08             	pushl  0x8(%ebp)
  8018b3:	e8 89 ff ff ff       	call   801841 <vsnprintf>
  8018b8:	83 c4 10             	add    $0x10,%esp
  8018bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8018be:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8018c1:	c9                   	leave  
  8018c2:	c3                   	ret    

008018c3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8018c3:	55                   	push   %ebp
  8018c4:	89 e5                	mov    %esp,%ebp
  8018c6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8018c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018d0:	eb 06                	jmp    8018d8 <strlen+0x15>
		n++;
  8018d2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8018d5:	ff 45 08             	incl   0x8(%ebp)
  8018d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018db:	8a 00                	mov    (%eax),%al
  8018dd:	84 c0                	test   %al,%al
  8018df:	75 f1                	jne    8018d2 <strlen+0xf>
		n++;
	return n;
  8018e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8018e4:	c9                   	leave  
  8018e5:	c3                   	ret    

008018e6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8018e6:	55                   	push   %ebp
  8018e7:	89 e5                	mov    %esp,%ebp
  8018e9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8018ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018f3:	eb 09                	jmp    8018fe <strnlen+0x18>
		n++;
  8018f5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8018f8:	ff 45 08             	incl   0x8(%ebp)
  8018fb:	ff 4d 0c             	decl   0xc(%ebp)
  8018fe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801902:	74 09                	je     80190d <strnlen+0x27>
  801904:	8b 45 08             	mov    0x8(%ebp),%eax
  801907:	8a 00                	mov    (%eax),%al
  801909:	84 c0                	test   %al,%al
  80190b:	75 e8                	jne    8018f5 <strnlen+0xf>
		n++;
	return n;
  80190d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801910:	c9                   	leave  
  801911:	c3                   	ret    

00801912 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801912:	55                   	push   %ebp
  801913:	89 e5                	mov    %esp,%ebp
  801915:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801918:	8b 45 08             	mov    0x8(%ebp),%eax
  80191b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80191e:	90                   	nop
  80191f:	8b 45 08             	mov    0x8(%ebp),%eax
  801922:	8d 50 01             	lea    0x1(%eax),%edx
  801925:	89 55 08             	mov    %edx,0x8(%ebp)
  801928:	8b 55 0c             	mov    0xc(%ebp),%edx
  80192b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80192e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801931:	8a 12                	mov    (%edx),%dl
  801933:	88 10                	mov    %dl,(%eax)
  801935:	8a 00                	mov    (%eax),%al
  801937:	84 c0                	test   %al,%al
  801939:	75 e4                	jne    80191f <strcpy+0xd>
		/* do nothing */;
	return ret;
  80193b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80193e:	c9                   	leave  
  80193f:	c3                   	ret    

00801940 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801940:	55                   	push   %ebp
  801941:	89 e5                	mov    %esp,%ebp
  801943:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801946:	8b 45 08             	mov    0x8(%ebp),%eax
  801949:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80194c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801953:	eb 1f                	jmp    801974 <strncpy+0x34>
		*dst++ = *src;
  801955:	8b 45 08             	mov    0x8(%ebp),%eax
  801958:	8d 50 01             	lea    0x1(%eax),%edx
  80195b:	89 55 08             	mov    %edx,0x8(%ebp)
  80195e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801961:	8a 12                	mov    (%edx),%dl
  801963:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801965:	8b 45 0c             	mov    0xc(%ebp),%eax
  801968:	8a 00                	mov    (%eax),%al
  80196a:	84 c0                	test   %al,%al
  80196c:	74 03                	je     801971 <strncpy+0x31>
			src++;
  80196e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801971:	ff 45 fc             	incl   -0x4(%ebp)
  801974:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801977:	3b 45 10             	cmp    0x10(%ebp),%eax
  80197a:	72 d9                	jb     801955 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80197c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80197f:	c9                   	leave  
  801980:	c3                   	ret    

00801981 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801981:	55                   	push   %ebp
  801982:	89 e5                	mov    %esp,%ebp
  801984:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801987:	8b 45 08             	mov    0x8(%ebp),%eax
  80198a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80198d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801991:	74 30                	je     8019c3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801993:	eb 16                	jmp    8019ab <strlcpy+0x2a>
			*dst++ = *src++;
  801995:	8b 45 08             	mov    0x8(%ebp),%eax
  801998:	8d 50 01             	lea    0x1(%eax),%edx
  80199b:	89 55 08             	mov    %edx,0x8(%ebp)
  80199e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019a1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8019a4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8019a7:	8a 12                	mov    (%edx),%dl
  8019a9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8019ab:	ff 4d 10             	decl   0x10(%ebp)
  8019ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019b2:	74 09                	je     8019bd <strlcpy+0x3c>
  8019b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b7:	8a 00                	mov    (%eax),%al
  8019b9:	84 c0                	test   %al,%al
  8019bb:	75 d8                	jne    801995 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8019bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8019c3:	8b 55 08             	mov    0x8(%ebp),%edx
  8019c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019c9:	29 c2                	sub    %eax,%edx
  8019cb:	89 d0                	mov    %edx,%eax
}
  8019cd:	c9                   	leave  
  8019ce:	c3                   	ret    

008019cf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8019cf:	55                   	push   %ebp
  8019d0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8019d2:	eb 06                	jmp    8019da <strcmp+0xb>
		p++, q++;
  8019d4:	ff 45 08             	incl   0x8(%ebp)
  8019d7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8019da:	8b 45 08             	mov    0x8(%ebp),%eax
  8019dd:	8a 00                	mov    (%eax),%al
  8019df:	84 c0                	test   %al,%al
  8019e1:	74 0e                	je     8019f1 <strcmp+0x22>
  8019e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e6:	8a 10                	mov    (%eax),%dl
  8019e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019eb:	8a 00                	mov    (%eax),%al
  8019ed:	38 c2                	cmp    %al,%dl
  8019ef:	74 e3                	je     8019d4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8019f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f4:	8a 00                	mov    (%eax),%al
  8019f6:	0f b6 d0             	movzbl %al,%edx
  8019f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019fc:	8a 00                	mov    (%eax),%al
  8019fe:	0f b6 c0             	movzbl %al,%eax
  801a01:	29 c2                	sub    %eax,%edx
  801a03:	89 d0                	mov    %edx,%eax
}
  801a05:	5d                   	pop    %ebp
  801a06:	c3                   	ret    

00801a07 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801a07:	55                   	push   %ebp
  801a08:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801a0a:	eb 09                	jmp    801a15 <strncmp+0xe>
		n--, p++, q++;
  801a0c:	ff 4d 10             	decl   0x10(%ebp)
  801a0f:	ff 45 08             	incl   0x8(%ebp)
  801a12:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801a15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a19:	74 17                	je     801a32 <strncmp+0x2b>
  801a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1e:	8a 00                	mov    (%eax),%al
  801a20:	84 c0                	test   %al,%al
  801a22:	74 0e                	je     801a32 <strncmp+0x2b>
  801a24:	8b 45 08             	mov    0x8(%ebp),%eax
  801a27:	8a 10                	mov    (%eax),%dl
  801a29:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a2c:	8a 00                	mov    (%eax),%al
  801a2e:	38 c2                	cmp    %al,%dl
  801a30:	74 da                	je     801a0c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801a32:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a36:	75 07                	jne    801a3f <strncmp+0x38>
		return 0;
  801a38:	b8 00 00 00 00       	mov    $0x0,%eax
  801a3d:	eb 14                	jmp    801a53 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a42:	8a 00                	mov    (%eax),%al
  801a44:	0f b6 d0             	movzbl %al,%edx
  801a47:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a4a:	8a 00                	mov    (%eax),%al
  801a4c:	0f b6 c0             	movzbl %al,%eax
  801a4f:	29 c2                	sub    %eax,%edx
  801a51:	89 d0                	mov    %edx,%eax
}
  801a53:	5d                   	pop    %ebp
  801a54:	c3                   	ret    

00801a55 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801a55:	55                   	push   %ebp
  801a56:	89 e5                	mov    %esp,%ebp
  801a58:	83 ec 04             	sub    $0x4,%esp
  801a5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a5e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801a61:	eb 12                	jmp    801a75 <strchr+0x20>
		if (*s == c)
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	8a 00                	mov    (%eax),%al
  801a68:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801a6b:	75 05                	jne    801a72 <strchr+0x1d>
			return (char *) s;
  801a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a70:	eb 11                	jmp    801a83 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801a72:	ff 45 08             	incl   0x8(%ebp)
  801a75:	8b 45 08             	mov    0x8(%ebp),%eax
  801a78:	8a 00                	mov    (%eax),%al
  801a7a:	84 c0                	test   %al,%al
  801a7c:	75 e5                	jne    801a63 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801a7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a83:	c9                   	leave  
  801a84:	c3                   	ret    

00801a85 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801a85:	55                   	push   %ebp
  801a86:	89 e5                	mov    %esp,%ebp
  801a88:	83 ec 04             	sub    $0x4,%esp
  801a8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a8e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801a91:	eb 0d                	jmp    801aa0 <strfind+0x1b>
		if (*s == c)
  801a93:	8b 45 08             	mov    0x8(%ebp),%eax
  801a96:	8a 00                	mov    (%eax),%al
  801a98:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801a9b:	74 0e                	je     801aab <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801a9d:	ff 45 08             	incl   0x8(%ebp)
  801aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa3:	8a 00                	mov    (%eax),%al
  801aa5:	84 c0                	test   %al,%al
  801aa7:	75 ea                	jne    801a93 <strfind+0xe>
  801aa9:	eb 01                	jmp    801aac <strfind+0x27>
		if (*s == c)
			break;
  801aab:	90                   	nop
	return (char *) s;
  801aac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801aaf:	c9                   	leave  
  801ab0:	c3                   	ret    

00801ab1 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801ab1:	55                   	push   %ebp
  801ab2:	89 e5                	mov    %esp,%ebp
  801ab4:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801abd:	8b 45 10             	mov    0x10(%ebp),%eax
  801ac0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801ac3:	eb 0e                	jmp    801ad3 <memset+0x22>
		*p++ = c;
  801ac5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ac8:	8d 50 01             	lea    0x1(%eax),%edx
  801acb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801ace:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad1:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801ad3:	ff 4d f8             	decl   -0x8(%ebp)
  801ad6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801ada:	79 e9                	jns    801ac5 <memset+0x14>
		*p++ = c;

	return v;
  801adc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801adf:	c9                   	leave  
  801ae0:	c3                   	ret    

00801ae1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801ae1:	55                   	push   %ebp
  801ae2:	89 e5                	mov    %esp,%ebp
  801ae4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801ae7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801aed:	8b 45 08             	mov    0x8(%ebp),%eax
  801af0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801af3:	eb 16                	jmp    801b0b <memcpy+0x2a>
		*d++ = *s++;
  801af5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801af8:	8d 50 01             	lea    0x1(%eax),%edx
  801afb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801afe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b01:	8d 4a 01             	lea    0x1(%edx),%ecx
  801b04:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801b07:	8a 12                	mov    (%edx),%dl
  801b09:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801b0b:	8b 45 10             	mov    0x10(%ebp),%eax
  801b0e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b11:	89 55 10             	mov    %edx,0x10(%ebp)
  801b14:	85 c0                	test   %eax,%eax
  801b16:	75 dd                	jne    801af5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801b18:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801b1b:	c9                   	leave  
  801b1c:	c3                   	ret    

00801b1d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801b1d:	55                   	push   %ebp
  801b1e:	89 e5                	mov    %esp,%ebp
  801b20:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801b23:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b26:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801b29:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801b2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b32:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801b35:	73 50                	jae    801b87 <memmove+0x6a>
  801b37:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b3a:	8b 45 10             	mov    0x10(%ebp),%eax
  801b3d:	01 d0                	add    %edx,%eax
  801b3f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801b42:	76 43                	jbe    801b87 <memmove+0x6a>
		s += n;
  801b44:	8b 45 10             	mov    0x10(%ebp),%eax
  801b47:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801b4a:	8b 45 10             	mov    0x10(%ebp),%eax
  801b4d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801b50:	eb 10                	jmp    801b62 <memmove+0x45>
			*--d = *--s;
  801b52:	ff 4d f8             	decl   -0x8(%ebp)
  801b55:	ff 4d fc             	decl   -0x4(%ebp)
  801b58:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b5b:	8a 10                	mov    (%eax),%dl
  801b5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b60:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801b62:	8b 45 10             	mov    0x10(%ebp),%eax
  801b65:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b68:	89 55 10             	mov    %edx,0x10(%ebp)
  801b6b:	85 c0                	test   %eax,%eax
  801b6d:	75 e3                	jne    801b52 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801b6f:	eb 23                	jmp    801b94 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801b71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b74:	8d 50 01             	lea    0x1(%eax),%edx
  801b77:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801b7a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b7d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801b80:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801b83:	8a 12                	mov    (%edx),%dl
  801b85:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801b87:	8b 45 10             	mov    0x10(%ebp),%eax
  801b8a:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b8d:	89 55 10             	mov    %edx,0x10(%ebp)
  801b90:	85 c0                	test   %eax,%eax
  801b92:	75 dd                	jne    801b71 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801b94:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801b97:	c9                   	leave  
  801b98:	c3                   	ret    

00801b99 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801b99:	55                   	push   %ebp
  801b9a:	89 e5                	mov    %esp,%ebp
  801b9c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801ba5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ba8:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801bab:	eb 2a                	jmp    801bd7 <memcmp+0x3e>
		if (*s1 != *s2)
  801bad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bb0:	8a 10                	mov    (%eax),%dl
  801bb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bb5:	8a 00                	mov    (%eax),%al
  801bb7:	38 c2                	cmp    %al,%dl
  801bb9:	74 16                	je     801bd1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801bbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bbe:	8a 00                	mov    (%eax),%al
  801bc0:	0f b6 d0             	movzbl %al,%edx
  801bc3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bc6:	8a 00                	mov    (%eax),%al
  801bc8:	0f b6 c0             	movzbl %al,%eax
  801bcb:	29 c2                	sub    %eax,%edx
  801bcd:	89 d0                	mov    %edx,%eax
  801bcf:	eb 18                	jmp    801be9 <memcmp+0x50>
		s1++, s2++;
  801bd1:	ff 45 fc             	incl   -0x4(%ebp)
  801bd4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801bd7:	8b 45 10             	mov    0x10(%ebp),%eax
  801bda:	8d 50 ff             	lea    -0x1(%eax),%edx
  801bdd:	89 55 10             	mov    %edx,0x10(%ebp)
  801be0:	85 c0                	test   %eax,%eax
  801be2:	75 c9                	jne    801bad <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801be4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801be9:	c9                   	leave  
  801bea:	c3                   	ret    

00801beb <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801beb:	55                   	push   %ebp
  801bec:	89 e5                	mov    %esp,%ebp
  801bee:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801bf1:	8b 55 08             	mov    0x8(%ebp),%edx
  801bf4:	8b 45 10             	mov    0x10(%ebp),%eax
  801bf7:	01 d0                	add    %edx,%eax
  801bf9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801bfc:	eb 15                	jmp    801c13 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  801c01:	8a 00                	mov    (%eax),%al
  801c03:	0f b6 d0             	movzbl %al,%edx
  801c06:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c09:	0f b6 c0             	movzbl %al,%eax
  801c0c:	39 c2                	cmp    %eax,%edx
  801c0e:	74 0d                	je     801c1d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801c10:	ff 45 08             	incl   0x8(%ebp)
  801c13:	8b 45 08             	mov    0x8(%ebp),%eax
  801c16:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801c19:	72 e3                	jb     801bfe <memfind+0x13>
  801c1b:	eb 01                	jmp    801c1e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801c1d:	90                   	nop
	return (void *) s;
  801c1e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801c21:	c9                   	leave  
  801c22:	c3                   	ret    

00801c23 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801c23:	55                   	push   %ebp
  801c24:	89 e5                	mov    %esp,%ebp
  801c26:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801c29:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801c30:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801c37:	eb 03                	jmp    801c3c <strtol+0x19>
		s++;
  801c39:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3f:	8a 00                	mov    (%eax),%al
  801c41:	3c 20                	cmp    $0x20,%al
  801c43:	74 f4                	je     801c39 <strtol+0x16>
  801c45:	8b 45 08             	mov    0x8(%ebp),%eax
  801c48:	8a 00                	mov    (%eax),%al
  801c4a:	3c 09                	cmp    $0x9,%al
  801c4c:	74 eb                	je     801c39 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c51:	8a 00                	mov    (%eax),%al
  801c53:	3c 2b                	cmp    $0x2b,%al
  801c55:	75 05                	jne    801c5c <strtol+0x39>
		s++;
  801c57:	ff 45 08             	incl   0x8(%ebp)
  801c5a:	eb 13                	jmp    801c6f <strtol+0x4c>
	else if (*s == '-')
  801c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5f:	8a 00                	mov    (%eax),%al
  801c61:	3c 2d                	cmp    $0x2d,%al
  801c63:	75 0a                	jne    801c6f <strtol+0x4c>
		s++, neg = 1;
  801c65:	ff 45 08             	incl   0x8(%ebp)
  801c68:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801c6f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c73:	74 06                	je     801c7b <strtol+0x58>
  801c75:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801c79:	75 20                	jne    801c9b <strtol+0x78>
  801c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7e:	8a 00                	mov    (%eax),%al
  801c80:	3c 30                	cmp    $0x30,%al
  801c82:	75 17                	jne    801c9b <strtol+0x78>
  801c84:	8b 45 08             	mov    0x8(%ebp),%eax
  801c87:	40                   	inc    %eax
  801c88:	8a 00                	mov    (%eax),%al
  801c8a:	3c 78                	cmp    $0x78,%al
  801c8c:	75 0d                	jne    801c9b <strtol+0x78>
		s += 2, base = 16;
  801c8e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801c92:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801c99:	eb 28                	jmp    801cc3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801c9b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c9f:	75 15                	jne    801cb6 <strtol+0x93>
  801ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca4:	8a 00                	mov    (%eax),%al
  801ca6:	3c 30                	cmp    $0x30,%al
  801ca8:	75 0c                	jne    801cb6 <strtol+0x93>
		s++, base = 8;
  801caa:	ff 45 08             	incl   0x8(%ebp)
  801cad:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801cb4:	eb 0d                	jmp    801cc3 <strtol+0xa0>
	else if (base == 0)
  801cb6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801cba:	75 07                	jne    801cc3 <strtol+0xa0>
		base = 10;
  801cbc:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc6:	8a 00                	mov    (%eax),%al
  801cc8:	3c 2f                	cmp    $0x2f,%al
  801cca:	7e 19                	jle    801ce5 <strtol+0xc2>
  801ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ccf:	8a 00                	mov    (%eax),%al
  801cd1:	3c 39                	cmp    $0x39,%al
  801cd3:	7f 10                	jg     801ce5 <strtol+0xc2>
			dig = *s - '0';
  801cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd8:	8a 00                	mov    (%eax),%al
  801cda:	0f be c0             	movsbl %al,%eax
  801cdd:	83 e8 30             	sub    $0x30,%eax
  801ce0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801ce3:	eb 42                	jmp    801d27 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce8:	8a 00                	mov    (%eax),%al
  801cea:	3c 60                	cmp    $0x60,%al
  801cec:	7e 19                	jle    801d07 <strtol+0xe4>
  801cee:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf1:	8a 00                	mov    (%eax),%al
  801cf3:	3c 7a                	cmp    $0x7a,%al
  801cf5:	7f 10                	jg     801d07 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfa:	8a 00                	mov    (%eax),%al
  801cfc:	0f be c0             	movsbl %al,%eax
  801cff:	83 e8 57             	sub    $0x57,%eax
  801d02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801d05:	eb 20                	jmp    801d27 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801d07:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0a:	8a 00                	mov    (%eax),%al
  801d0c:	3c 40                	cmp    $0x40,%al
  801d0e:	7e 39                	jle    801d49 <strtol+0x126>
  801d10:	8b 45 08             	mov    0x8(%ebp),%eax
  801d13:	8a 00                	mov    (%eax),%al
  801d15:	3c 5a                	cmp    $0x5a,%al
  801d17:	7f 30                	jg     801d49 <strtol+0x126>
			dig = *s - 'A' + 10;
  801d19:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1c:	8a 00                	mov    (%eax),%al
  801d1e:	0f be c0             	movsbl %al,%eax
  801d21:	83 e8 37             	sub    $0x37,%eax
  801d24:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801d27:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d2a:	3b 45 10             	cmp    0x10(%ebp),%eax
  801d2d:	7d 19                	jge    801d48 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801d2f:	ff 45 08             	incl   0x8(%ebp)
  801d32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d35:	0f af 45 10          	imul   0x10(%ebp),%eax
  801d39:	89 c2                	mov    %eax,%edx
  801d3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d3e:	01 d0                	add    %edx,%eax
  801d40:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801d43:	e9 7b ff ff ff       	jmp    801cc3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801d48:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801d49:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801d4d:	74 08                	je     801d57 <strtol+0x134>
		*endptr = (char *) s;
  801d4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d52:	8b 55 08             	mov    0x8(%ebp),%edx
  801d55:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801d57:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801d5b:	74 07                	je     801d64 <strtol+0x141>
  801d5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d60:	f7 d8                	neg    %eax
  801d62:	eb 03                	jmp    801d67 <strtol+0x144>
  801d64:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801d67:	c9                   	leave  
  801d68:	c3                   	ret    

00801d69 <ltostr>:

void
ltostr(long value, char *str)
{
  801d69:	55                   	push   %ebp
  801d6a:	89 e5                	mov    %esp,%ebp
  801d6c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801d6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801d76:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801d7d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801d81:	79 13                	jns    801d96 <ltostr+0x2d>
	{
		neg = 1;
  801d83:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d8d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801d90:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801d93:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801d96:	8b 45 08             	mov    0x8(%ebp),%eax
  801d99:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801d9e:	99                   	cltd   
  801d9f:	f7 f9                	idiv   %ecx
  801da1:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801da4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801da7:	8d 50 01             	lea    0x1(%eax),%edx
  801daa:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801dad:	89 c2                	mov    %eax,%edx
  801daf:	8b 45 0c             	mov    0xc(%ebp),%eax
  801db2:	01 d0                	add    %edx,%eax
  801db4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801db7:	83 c2 30             	add    $0x30,%edx
  801dba:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801dbc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801dbf:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801dc4:	f7 e9                	imul   %ecx
  801dc6:	c1 fa 02             	sar    $0x2,%edx
  801dc9:	89 c8                	mov    %ecx,%eax
  801dcb:	c1 f8 1f             	sar    $0x1f,%eax
  801dce:	29 c2                	sub    %eax,%edx
  801dd0:	89 d0                	mov    %edx,%eax
  801dd2:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801dd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801dd8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801ddd:	f7 e9                	imul   %ecx
  801ddf:	c1 fa 02             	sar    $0x2,%edx
  801de2:	89 c8                	mov    %ecx,%eax
  801de4:	c1 f8 1f             	sar    $0x1f,%eax
  801de7:	29 c2                	sub    %eax,%edx
  801de9:	89 d0                	mov    %edx,%eax
  801deb:	c1 e0 02             	shl    $0x2,%eax
  801dee:	01 d0                	add    %edx,%eax
  801df0:	01 c0                	add    %eax,%eax
  801df2:	29 c1                	sub    %eax,%ecx
  801df4:	89 ca                	mov    %ecx,%edx
  801df6:	85 d2                	test   %edx,%edx
  801df8:	75 9c                	jne    801d96 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801dfa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801e01:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e04:	48                   	dec    %eax
  801e05:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801e08:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801e0c:	74 3d                	je     801e4b <ltostr+0xe2>
		start = 1 ;
  801e0e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801e15:	eb 34                	jmp    801e4b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801e17:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e1d:	01 d0                	add    %edx,%eax
  801e1f:	8a 00                	mov    (%eax),%al
  801e21:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801e24:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e27:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e2a:	01 c2                	add    %eax,%edx
  801e2c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e32:	01 c8                	add    %ecx,%eax
  801e34:	8a 00                	mov    (%eax),%al
  801e36:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801e38:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e3e:	01 c2                	add    %eax,%edx
  801e40:	8a 45 eb             	mov    -0x15(%ebp),%al
  801e43:	88 02                	mov    %al,(%edx)
		start++ ;
  801e45:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801e48:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e4e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e51:	7c c4                	jl     801e17 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801e53:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801e56:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e59:	01 d0                	add    %edx,%eax
  801e5b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801e5e:	90                   	nop
  801e5f:	c9                   	leave  
  801e60:	c3                   	ret    

00801e61 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801e61:	55                   	push   %ebp
  801e62:	89 e5                	mov    %esp,%ebp
  801e64:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801e67:	ff 75 08             	pushl  0x8(%ebp)
  801e6a:	e8 54 fa ff ff       	call   8018c3 <strlen>
  801e6f:	83 c4 04             	add    $0x4,%esp
  801e72:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801e75:	ff 75 0c             	pushl  0xc(%ebp)
  801e78:	e8 46 fa ff ff       	call   8018c3 <strlen>
  801e7d:	83 c4 04             	add    $0x4,%esp
  801e80:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801e83:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801e8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801e91:	eb 17                	jmp    801eaa <strcconcat+0x49>
		final[s] = str1[s] ;
  801e93:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e96:	8b 45 10             	mov    0x10(%ebp),%eax
  801e99:	01 c2                	add    %eax,%edx
  801e9b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea1:	01 c8                	add    %ecx,%eax
  801ea3:	8a 00                	mov    (%eax),%al
  801ea5:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801ea7:	ff 45 fc             	incl   -0x4(%ebp)
  801eaa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ead:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801eb0:	7c e1                	jl     801e93 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801eb2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801eb9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801ec0:	eb 1f                	jmp    801ee1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801ec2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ec5:	8d 50 01             	lea    0x1(%eax),%edx
  801ec8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801ecb:	89 c2                	mov    %eax,%edx
  801ecd:	8b 45 10             	mov    0x10(%ebp),%eax
  801ed0:	01 c2                	add    %eax,%edx
  801ed2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801ed5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ed8:	01 c8                	add    %ecx,%eax
  801eda:	8a 00                	mov    (%eax),%al
  801edc:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801ede:	ff 45 f8             	incl   -0x8(%ebp)
  801ee1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ee4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ee7:	7c d9                	jl     801ec2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801ee9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801eec:	8b 45 10             	mov    0x10(%ebp),%eax
  801eef:	01 d0                	add    %edx,%eax
  801ef1:	c6 00 00             	movb   $0x0,(%eax)
}
  801ef4:	90                   	nop
  801ef5:	c9                   	leave  
  801ef6:	c3                   	ret    

00801ef7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801ef7:	55                   	push   %ebp
  801ef8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801efa:	8b 45 14             	mov    0x14(%ebp),%eax
  801efd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801f03:	8b 45 14             	mov    0x14(%ebp),%eax
  801f06:	8b 00                	mov    (%eax),%eax
  801f08:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f0f:	8b 45 10             	mov    0x10(%ebp),%eax
  801f12:	01 d0                	add    %edx,%eax
  801f14:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801f1a:	eb 0c                	jmp    801f28 <strsplit+0x31>
			*string++ = 0;
  801f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1f:	8d 50 01             	lea    0x1(%eax),%edx
  801f22:	89 55 08             	mov    %edx,0x8(%ebp)
  801f25:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801f28:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2b:	8a 00                	mov    (%eax),%al
  801f2d:	84 c0                	test   %al,%al
  801f2f:	74 18                	je     801f49 <strsplit+0x52>
  801f31:	8b 45 08             	mov    0x8(%ebp),%eax
  801f34:	8a 00                	mov    (%eax),%al
  801f36:	0f be c0             	movsbl %al,%eax
  801f39:	50                   	push   %eax
  801f3a:	ff 75 0c             	pushl  0xc(%ebp)
  801f3d:	e8 13 fb ff ff       	call   801a55 <strchr>
  801f42:	83 c4 08             	add    $0x8,%esp
  801f45:	85 c0                	test   %eax,%eax
  801f47:	75 d3                	jne    801f1c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801f49:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4c:	8a 00                	mov    (%eax),%al
  801f4e:	84 c0                	test   %al,%al
  801f50:	74 5a                	je     801fac <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801f52:	8b 45 14             	mov    0x14(%ebp),%eax
  801f55:	8b 00                	mov    (%eax),%eax
  801f57:	83 f8 0f             	cmp    $0xf,%eax
  801f5a:	75 07                	jne    801f63 <strsplit+0x6c>
		{
			return 0;
  801f5c:	b8 00 00 00 00       	mov    $0x0,%eax
  801f61:	eb 66                	jmp    801fc9 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801f63:	8b 45 14             	mov    0x14(%ebp),%eax
  801f66:	8b 00                	mov    (%eax),%eax
  801f68:	8d 48 01             	lea    0x1(%eax),%ecx
  801f6b:	8b 55 14             	mov    0x14(%ebp),%edx
  801f6e:	89 0a                	mov    %ecx,(%edx)
  801f70:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f77:	8b 45 10             	mov    0x10(%ebp),%eax
  801f7a:	01 c2                	add    %eax,%edx
  801f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801f81:	eb 03                	jmp    801f86 <strsplit+0x8f>
			string++;
  801f83:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801f86:	8b 45 08             	mov    0x8(%ebp),%eax
  801f89:	8a 00                	mov    (%eax),%al
  801f8b:	84 c0                	test   %al,%al
  801f8d:	74 8b                	je     801f1a <strsplit+0x23>
  801f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f92:	8a 00                	mov    (%eax),%al
  801f94:	0f be c0             	movsbl %al,%eax
  801f97:	50                   	push   %eax
  801f98:	ff 75 0c             	pushl  0xc(%ebp)
  801f9b:	e8 b5 fa ff ff       	call   801a55 <strchr>
  801fa0:	83 c4 08             	add    $0x8,%esp
  801fa3:	85 c0                	test   %eax,%eax
  801fa5:	74 dc                	je     801f83 <strsplit+0x8c>
			string++;
	}
  801fa7:	e9 6e ff ff ff       	jmp    801f1a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801fac:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801fad:	8b 45 14             	mov    0x14(%ebp),%eax
  801fb0:	8b 00                	mov    (%eax),%eax
  801fb2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801fb9:	8b 45 10             	mov    0x10(%ebp),%eax
  801fbc:	01 d0                	add    %edx,%eax
  801fbe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801fc4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801fc9:	c9                   	leave  
  801fca:	c3                   	ret    

00801fcb <malloc>:
//==================================================================================//
int FirstTimeFlag = 1;
int allocated[MAXN];

void* malloc(uint32 size)
{
  801fcb:	55                   	push   %ebp
  801fcc:	89 e5                	mov    %esp,%ebp
  801fce:	83 ec 28             	sub    $0x28,%esp
	//DON'T CHANGE THIS CODE
	if(FirstTimeFlag)
  801fd1:	a1 04 40 80 00       	mov    0x804004,%eax
  801fd6:	85 c0                	test   %eax,%eax
  801fd8:	74 0f                	je     801fe9 <malloc+0x1e>
	{
		initialize_buddy();
  801fda:	e8 a4 02 00 00       	call   802283 <initialize_buddy>
		FirstTimeFlag = 0;
  801fdf:	c7 05 04 40 80 00 00 	movl   $0x0,0x804004
  801fe6:	00 00 00 
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
  801fe9:	81 7d 08 00 08 00 00 	cmpl   $0x800,0x8(%ebp)
  801ff0:	0f 86 0b 01 00 00    	jbe    802101 <malloc+0x136>
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
  801ff6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  802000:	c1 e8 0c             	shr    $0xc,%eax
  802003:	89 c2                	mov    %eax,%edx
  802005:	8b 45 08             	mov    0x8(%ebp),%eax
  802008:	25 ff 0f 00 00       	and    $0xfff,%eax
  80200d:	85 c0                	test   %eax,%eax
  80200f:	74 07                	je     802018 <malloc+0x4d>
  802011:	b8 01 00 00 00       	mov    $0x1,%eax
  802016:	eb 05                	jmp    80201d <malloc+0x52>
  802018:	b8 00 00 00 00       	mov    $0x0,%eax
  80201d:	01 d0                	add    %edx,%eax
  80201f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  802022:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  802029:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
		for(i = 0; i < MAXN; i++) {
  802030:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  802037:	eb 5c                	jmp    802095 <malloc+0xca>
			if(allocated[i] != 0) continue;
  802039:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80203c:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802043:	85 c0                	test   %eax,%eax
  802045:	75 4a                	jne    802091 <malloc+0xc6>
			j = 1;
  802047:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
			i++;
  80204e:	ff 45 f4             	incl   -0xc(%ebp)
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  802051:	eb 06                	jmp    802059 <malloc+0x8e>
				i++;
  802053:	ff 45 f4             	incl   -0xc(%ebp)
				j++;
  802056:	ff 45 ec             	incl   -0x14(%ebp)
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
			j = 1;
			i++;
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  802059:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80205c:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802061:	77 16                	ja     802079 <malloc+0xae>
  802063:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802066:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  80206d:	85 c0                	test   %eax,%eax
  80206f:	75 08                	jne    802079 <malloc+0xae>
  802071:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802074:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  802077:	7c da                	jl     802053 <malloc+0x88>
				i++;
				j++;
			}
			if(j == sizeToPage) {
  802079:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80207c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80207f:	75 0b                	jne    80208c <malloc+0xc1>
				indx = i - j;
  802081:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802084:	2b 45 ec             	sub    -0x14(%ebp),%eax
  802087:	89 45 f0             	mov    %eax,-0x10(%ebp)
				break;
  80208a:	eb 13                	jmp    80209f <malloc+0xd4>
			}
			i--;
  80208c:	ff 4d f4             	decl   -0xc(%ebp)
  80208f:	eb 01                	jmp    802092 <malloc+0xc7>
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
  802091:	90                   	nop
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
  802092:	ff 45 f4             	incl   -0xc(%ebp)
  802095:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802098:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80209d:	76 9a                	jbe    802039 <malloc+0x6e>
				indx = i - j;
				break;
			}
			i--;
		}
		if(indx == -1) {
  80209f:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
  8020a3:	75 07                	jne    8020ac <malloc+0xe1>
			return NULL;
  8020a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8020aa:	eb 5a                	jmp    802106 <malloc+0x13b>
		}
		i = indx;
  8020ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020af:	89 45 f4             	mov    %eax,-0xc(%ebp)
		while(i < j + indx) {
  8020b2:	eb 13                	jmp    8020c7 <malloc+0xfc>
			allocated[i++] = j;
  8020b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8020b7:	8d 50 01             	lea    0x1(%eax),%edx
  8020ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8020bd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8020c0:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
		}
		if(indx == -1) {
			return NULL;
		}
		i = indx;
		while(i < j + indx) {
  8020c7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8020ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020cd:	01 d0                	add    %edx,%eax
  8020cf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8020d2:	7f e0                	jg     8020b4 <malloc+0xe9>
			allocated[i++] = j;
		}
		uint32 *address = (uint32 *)(USER_HEAP_START + (indx * PAGE_SIZE));
  8020d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020d7:	c1 e0 0c             	shl    $0xc,%eax
  8020da:	05 00 00 00 80       	add    $0x80000000,%eax
  8020df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		sys_allocateMem(USER_HEAP_START + (indx * PAGE_SIZE), size);
  8020e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020e5:	c1 e0 0c             	shl    $0xc,%eax
  8020e8:	05 00 00 00 80       	add    $0x80000000,%eax
  8020ed:	83 ec 08             	sub    $0x8,%esp
  8020f0:	ff 75 08             	pushl  0x8(%ebp)
  8020f3:	50                   	push   %eax
  8020f4:	e8 84 04 00 00       	call   80257d <sys_allocateMem>
  8020f9:	83 c4 10             	add    $0x10,%esp
		return address;
  8020fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8020ff:	eb 05                	jmp    802106 <malloc+0x13b>
	//1) FIRST FIT strategy (if size > 2 KB)
	//2) Buddy System (if size <= 2 KB)

	//refer to the project presentation and documentation for details

	return NULL;
  802101:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802106:	c9                   	leave  
  802107:	c3                   	ret    

00802108 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  802108:	55                   	push   %ebp
  802109:	89 e5                	mov    %esp,%ebp
  80210b:	83 ec 18             	sub    $0x18,%esp
	//TODO: [PROJECT 2020 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
  80210e:	8b 45 08             	mov    0x8(%ebp),%eax
  802111:	89 45 ec             	mov    %eax,-0x14(%ebp)
  802114:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802117:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80211c:	89 45 08             	mov    %eax,0x8(%ebp)
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
  80211f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  802126:	8b 45 08             	mov    0x8(%ebp),%eax
  802129:	05 00 00 00 80       	add    $0x80000000,%eax
  80212e:	c1 e8 0c             	shr    $0xc,%eax
  802131:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int removable_size = allocated[indx];
  802134:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802137:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  80213e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	size = allocated[indx];
  802141:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802144:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  80214b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while(size > 0) {
  80214e:	eb 17                	jmp    802167 <free+0x5f>
		allocated[indx++] = 0;
  802150:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802153:	8d 50 01             	lea    0x1(%eax),%edx
  802156:	89 55 f0             	mov    %edx,-0x10(%ebp)
  802159:	c7 04 85 20 41 80 00 	movl   $0x0,0x804120(,%eax,4)
  802160:	00 00 00 00 
		size--;
  802164:	ff 4d f4             	decl   -0xc(%ebp)
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
	int removable_size = allocated[indx];
	size = allocated[indx];
	while(size > 0) {
  802167:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80216b:	7f e3                	jg     802150 <free+0x48>
		allocated[indx++] = 0;
		size--;
	}
	sys_freeMem((uint32)virtual_address, removable_size);
  80216d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  802170:	8b 45 08             	mov    0x8(%ebp),%eax
  802173:	83 ec 08             	sub    $0x8,%esp
  802176:	52                   	push   %edx
  802177:	50                   	push   %eax
  802178:	e8 e4 03 00 00       	call   802561 <sys_freeMem>
  80217d:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details

}
  802180:	90                   	nop
  802181:	c9                   	leave  
  802182:	c3                   	ret    

00802183 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  802183:	55                   	push   %ebp
  802184:	89 e5                	mov    %esp,%ebp
  802186:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - BONUS2] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  802189:	83 ec 04             	sub    $0x4,%esp
  80218c:	68 70 33 80 00       	push   $0x803370
  802191:	6a 7a                	push   $0x7a
  802193:	68 96 33 80 00       	push   $0x803396
  802198:	e8 02 ee ff ff       	call   800f9f <_panic>

0080219d <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80219d:	55                   	push   %ebp
  80219e:	89 e5                	mov    %esp,%ebp
  8021a0:	83 ec 18             	sub    $0x18,%esp
  8021a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8021a6:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8021a9:	83 ec 04             	sub    $0x4,%esp
  8021ac:	68 a4 33 80 00       	push   $0x8033a4
  8021b1:	68 84 00 00 00       	push   $0x84
  8021b6:	68 96 33 80 00       	push   $0x803396
  8021bb:	e8 df ed ff ff       	call   800f9f <_panic>

008021c0 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8021c0:	55                   	push   %ebp
  8021c1:	89 e5                	mov    %esp,%ebp
  8021c3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8021c6:	83 ec 04             	sub    $0x4,%esp
  8021c9:	68 a4 33 80 00       	push   $0x8033a4
  8021ce:	68 8a 00 00 00       	push   $0x8a
  8021d3:	68 96 33 80 00       	push   $0x803396
  8021d8:	e8 c2 ed ff ff       	call   800f9f <_panic>

008021dd <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8021dd:	55                   	push   %ebp
  8021de:	89 e5                	mov    %esp,%ebp
  8021e0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8021e3:	83 ec 04             	sub    $0x4,%esp
  8021e6:	68 a4 33 80 00       	push   $0x8033a4
  8021eb:	68 90 00 00 00       	push   $0x90
  8021f0:	68 96 33 80 00       	push   $0x803396
  8021f5:	e8 a5 ed ff ff       	call   800f9f <_panic>

008021fa <expand>:
}

void expand(uint32 newSize)
{
  8021fa:	55                   	push   %ebp
  8021fb:	89 e5                	mov    %esp,%ebp
  8021fd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802200:	83 ec 04             	sub    $0x4,%esp
  802203:	68 a4 33 80 00       	push   $0x8033a4
  802208:	68 95 00 00 00       	push   $0x95
  80220d:	68 96 33 80 00       	push   $0x803396
  802212:	e8 88 ed ff ff       	call   800f9f <_panic>

00802217 <shrink>:
}
void shrink(uint32 newSize)
{
  802217:	55                   	push   %ebp
  802218:	89 e5                	mov    %esp,%ebp
  80221a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80221d:	83 ec 04             	sub    $0x4,%esp
  802220:	68 a4 33 80 00       	push   $0x8033a4
  802225:	68 99 00 00 00       	push   $0x99
  80222a:	68 96 33 80 00       	push   $0x803396
  80222f:	e8 6b ed ff ff       	call   800f9f <_panic>

00802234 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  802234:	55                   	push   %ebp
  802235:	89 e5                	mov    %esp,%ebp
  802237:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80223a:	83 ec 04             	sub    $0x4,%esp
  80223d:	68 a4 33 80 00       	push   $0x8033a4
  802242:	68 9e 00 00 00       	push   $0x9e
  802247:	68 96 33 80 00       	push   $0x803396
  80224c:	e8 4e ed ff ff       	call   800f9f <_panic>

00802251 <ClearNodeData>:
 * inside the user heap
 */
 
struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  802251:	55                   	push   %ebp
  802252:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  802254:	8b 45 08             	mov    0x8(%ebp),%eax
  802257:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  80225b:	8b 45 08             	mov    0x8(%ebp),%eax
  80225e:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  802262:	8b 45 08             	mov    0x8(%ebp),%eax
  802265:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  80226c:	8b 45 08             	mov    0x8(%ebp),%eax
  80226f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  802276:	8b 45 08             	mov    0x8(%ebp),%eax
  802279:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  802280:	90                   	nop
  802281:	5d                   	pop    %ebp
  802282:	c3                   	ret    

00802283 <initialize_buddy>:

void initialize_buddy()
{
  802283:	55                   	push   %ebp
  802284:	89 e5                	mov    %esp,%ebp
  802286:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  802289:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802290:	e9 b7 00 00 00       	jmp    80234c <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  802295:	8b 15 04 41 80 00    	mov    0x804104,%edx
  80229b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80229e:	89 c8                	mov    %ecx,%eax
  8022a0:	01 c0                	add    %eax,%eax
  8022a2:	01 c8                	add    %ecx,%eax
  8022a4:	c1 e0 03             	shl    $0x3,%eax
  8022a7:	05 20 41 88 00       	add    $0x884120,%eax
  8022ac:	89 10                	mov    %edx,(%eax)
  8022ae:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8022b1:	89 d0                	mov    %edx,%eax
  8022b3:	01 c0                	add    %eax,%eax
  8022b5:	01 d0                	add    %edx,%eax
  8022b7:	c1 e0 03             	shl    $0x3,%eax
  8022ba:	05 20 41 88 00       	add    $0x884120,%eax
  8022bf:	8b 00                	mov    (%eax),%eax
  8022c1:	85 c0                	test   %eax,%eax
  8022c3:	74 1c                	je     8022e1 <initialize_buddy+0x5e>
  8022c5:	8b 15 04 41 80 00    	mov    0x804104,%edx
  8022cb:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8022ce:	89 c8                	mov    %ecx,%eax
  8022d0:	01 c0                	add    %eax,%eax
  8022d2:	01 c8                	add    %ecx,%eax
  8022d4:	c1 e0 03             	shl    $0x3,%eax
  8022d7:	05 20 41 88 00       	add    $0x884120,%eax
  8022dc:	89 42 04             	mov    %eax,0x4(%edx)
  8022df:	eb 16                	jmp    8022f7 <initialize_buddy+0x74>
  8022e1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8022e4:	89 d0                	mov    %edx,%eax
  8022e6:	01 c0                	add    %eax,%eax
  8022e8:	01 d0                	add    %edx,%eax
  8022ea:	c1 e0 03             	shl    $0x3,%eax
  8022ed:	05 20 41 88 00       	add    $0x884120,%eax
  8022f2:	a3 08 41 80 00       	mov    %eax,0x804108
  8022f7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8022fa:	89 d0                	mov    %edx,%eax
  8022fc:	01 c0                	add    %eax,%eax
  8022fe:	01 d0                	add    %edx,%eax
  802300:	c1 e0 03             	shl    $0x3,%eax
  802303:	05 20 41 88 00       	add    $0x884120,%eax
  802308:	a3 04 41 80 00       	mov    %eax,0x804104
  80230d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802310:	89 d0                	mov    %edx,%eax
  802312:	01 c0                	add    %eax,%eax
  802314:	01 d0                	add    %edx,%eax
  802316:	c1 e0 03             	shl    $0x3,%eax
  802319:	05 24 41 88 00       	add    $0x884124,%eax
  80231e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802324:	a1 10 41 80 00       	mov    0x804110,%eax
  802329:	40                   	inc    %eax
  80232a:	a3 10 41 80 00       	mov    %eax,0x804110
		ClearNodeData(&(FreeNodes[i]));
  80232f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802332:	89 d0                	mov    %edx,%eax
  802334:	01 c0                	add    %eax,%eax
  802336:	01 d0                	add    %edx,%eax
  802338:	c1 e0 03             	shl    $0x3,%eax
  80233b:	05 20 41 88 00       	add    $0x884120,%eax
  802340:	50                   	push   %eax
  802341:	e8 0b ff ff ff       	call   802251 <ClearNodeData>
  802346:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  802349:	ff 45 fc             	incl   -0x4(%ebp)
  80234c:	81 7d fc 3f 9c 00 00 	cmpl   $0x9c3f,-0x4(%ebp)
  802353:	0f 8e 3c ff ff ff    	jle    802295 <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  802359:	90                   	nop
  80235a:	c9                   	leave  
  80235b:	c3                   	ret    

0080235c <CreateNewBuddySpace>:
/*===============================================================*/

//TODO: [PROJECT 2020 - BONUS4] Expand Buddy Free Node List

void CreateNewBuddySpace()
{
  80235c:	55                   	push   %ebp
  80235d:	89 e5                	mov    %esp,%ebp
  80235f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Create New Buddy Block]
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  802362:	83 ec 04             	sub    $0x4,%esp
  802365:	68 c8 33 80 00       	push   $0x8033c8
  80236a:	6a 22                	push   $0x22
  80236c:	68 fa 33 80 00       	push   $0x8033fa
  802371:	e8 29 ec ff ff       	call   800f9f <_panic>

00802376 <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  802376:	55                   	push   %ebp
  802377:	89 e5                	mov    %esp,%ebp
  802379:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Get Allocation]
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  80237c:	83 ec 04             	sub    $0x4,%esp
  80237f:	68 08 34 80 00       	push   $0x803408
  802384:	6a 2a                	push   $0x2a
  802386:	68 fa 33 80 00       	push   $0x8033fa
  80238b:	e8 0f ec ff ff       	call   800f9f <_panic>

00802390 <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  802390:	55                   	push   %ebp
  802391:	89 e5                	mov    %esp,%ebp
  802393:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Free Allocation]
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  802396:	83 ec 04             	sub    $0x4,%esp
  802399:	68 40 34 80 00       	push   $0x803440
  80239e:	6a 31                	push   $0x31
  8023a0:	68 fa 33 80 00       	push   $0x8033fa
  8023a5:	e8 f5 eb ff ff       	call   800f9f <_panic>

008023aa <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8023aa:	55                   	push   %ebp
  8023ab:	89 e5                	mov    %esp,%ebp
  8023ad:	57                   	push   %edi
  8023ae:	56                   	push   %esi
  8023af:	53                   	push   %ebx
  8023b0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8023b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8023b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023b9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023bc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8023bf:	8b 7d 18             	mov    0x18(%ebp),%edi
  8023c2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8023c5:	cd 30                	int    $0x30
  8023c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8023ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8023cd:	83 c4 10             	add    $0x10,%esp
  8023d0:	5b                   	pop    %ebx
  8023d1:	5e                   	pop    %esi
  8023d2:	5f                   	pop    %edi
  8023d3:	5d                   	pop    %ebp
  8023d4:	c3                   	ret    

008023d5 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8023d5:	55                   	push   %ebp
  8023d6:	89 e5                	mov    %esp,%ebp
  8023d8:	83 ec 04             	sub    $0x4,%esp
  8023db:	8b 45 10             	mov    0x10(%ebp),%eax
  8023de:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8023e1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8023e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e8:	6a 00                	push   $0x0
  8023ea:	6a 00                	push   $0x0
  8023ec:	52                   	push   %edx
  8023ed:	ff 75 0c             	pushl  0xc(%ebp)
  8023f0:	50                   	push   %eax
  8023f1:	6a 00                	push   $0x0
  8023f3:	e8 b2 ff ff ff       	call   8023aa <syscall>
  8023f8:	83 c4 18             	add    $0x18,%esp
}
  8023fb:	90                   	nop
  8023fc:	c9                   	leave  
  8023fd:	c3                   	ret    

008023fe <sys_cgetc>:

int
sys_cgetc(void)
{
  8023fe:	55                   	push   %ebp
  8023ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802401:	6a 00                	push   $0x0
  802403:	6a 00                	push   $0x0
  802405:	6a 00                	push   $0x0
  802407:	6a 00                	push   $0x0
  802409:	6a 00                	push   $0x0
  80240b:	6a 01                	push   $0x1
  80240d:	e8 98 ff ff ff       	call   8023aa <syscall>
  802412:	83 c4 18             	add    $0x18,%esp
}
  802415:	c9                   	leave  
  802416:	c3                   	ret    

00802417 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802417:	55                   	push   %ebp
  802418:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80241a:	8b 45 08             	mov    0x8(%ebp),%eax
  80241d:	6a 00                	push   $0x0
  80241f:	6a 00                	push   $0x0
  802421:	6a 00                	push   $0x0
  802423:	6a 00                	push   $0x0
  802425:	50                   	push   %eax
  802426:	6a 05                	push   $0x5
  802428:	e8 7d ff ff ff       	call   8023aa <syscall>
  80242d:	83 c4 18             	add    $0x18,%esp
}
  802430:	c9                   	leave  
  802431:	c3                   	ret    

00802432 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802432:	55                   	push   %ebp
  802433:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802435:	6a 00                	push   $0x0
  802437:	6a 00                	push   $0x0
  802439:	6a 00                	push   $0x0
  80243b:	6a 00                	push   $0x0
  80243d:	6a 00                	push   $0x0
  80243f:	6a 02                	push   $0x2
  802441:	e8 64 ff ff ff       	call   8023aa <syscall>
  802446:	83 c4 18             	add    $0x18,%esp
}
  802449:	c9                   	leave  
  80244a:	c3                   	ret    

0080244b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80244b:	55                   	push   %ebp
  80244c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80244e:	6a 00                	push   $0x0
  802450:	6a 00                	push   $0x0
  802452:	6a 00                	push   $0x0
  802454:	6a 00                	push   $0x0
  802456:	6a 00                	push   $0x0
  802458:	6a 03                	push   $0x3
  80245a:	e8 4b ff ff ff       	call   8023aa <syscall>
  80245f:	83 c4 18             	add    $0x18,%esp
}
  802462:	c9                   	leave  
  802463:	c3                   	ret    

00802464 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802464:	55                   	push   %ebp
  802465:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802467:	6a 00                	push   $0x0
  802469:	6a 00                	push   $0x0
  80246b:	6a 00                	push   $0x0
  80246d:	6a 00                	push   $0x0
  80246f:	6a 00                	push   $0x0
  802471:	6a 04                	push   $0x4
  802473:	e8 32 ff ff ff       	call   8023aa <syscall>
  802478:	83 c4 18             	add    $0x18,%esp
}
  80247b:	c9                   	leave  
  80247c:	c3                   	ret    

0080247d <sys_env_exit>:


void sys_env_exit(void)
{
  80247d:	55                   	push   %ebp
  80247e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802480:	6a 00                	push   $0x0
  802482:	6a 00                	push   $0x0
  802484:	6a 00                	push   $0x0
  802486:	6a 00                	push   $0x0
  802488:	6a 00                	push   $0x0
  80248a:	6a 06                	push   $0x6
  80248c:	e8 19 ff ff ff       	call   8023aa <syscall>
  802491:	83 c4 18             	add    $0x18,%esp
}
  802494:	90                   	nop
  802495:	c9                   	leave  
  802496:	c3                   	ret    

00802497 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802497:	55                   	push   %ebp
  802498:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80249a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80249d:	8b 45 08             	mov    0x8(%ebp),%eax
  8024a0:	6a 00                	push   $0x0
  8024a2:	6a 00                	push   $0x0
  8024a4:	6a 00                	push   $0x0
  8024a6:	52                   	push   %edx
  8024a7:	50                   	push   %eax
  8024a8:	6a 07                	push   $0x7
  8024aa:	e8 fb fe ff ff       	call   8023aa <syscall>
  8024af:	83 c4 18             	add    $0x18,%esp
}
  8024b2:	c9                   	leave  
  8024b3:	c3                   	ret    

008024b4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8024b4:	55                   	push   %ebp
  8024b5:	89 e5                	mov    %esp,%ebp
  8024b7:	56                   	push   %esi
  8024b8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8024b9:	8b 75 18             	mov    0x18(%ebp),%esi
  8024bc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8024bf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8024c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8024c8:	56                   	push   %esi
  8024c9:	53                   	push   %ebx
  8024ca:	51                   	push   %ecx
  8024cb:	52                   	push   %edx
  8024cc:	50                   	push   %eax
  8024cd:	6a 08                	push   $0x8
  8024cf:	e8 d6 fe ff ff       	call   8023aa <syscall>
  8024d4:	83 c4 18             	add    $0x18,%esp
}
  8024d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8024da:	5b                   	pop    %ebx
  8024db:	5e                   	pop    %esi
  8024dc:	5d                   	pop    %ebp
  8024dd:	c3                   	ret    

008024de <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8024de:	55                   	push   %ebp
  8024df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8024e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8024e7:	6a 00                	push   $0x0
  8024e9:	6a 00                	push   $0x0
  8024eb:	6a 00                	push   $0x0
  8024ed:	52                   	push   %edx
  8024ee:	50                   	push   %eax
  8024ef:	6a 09                	push   $0x9
  8024f1:	e8 b4 fe ff ff       	call   8023aa <syscall>
  8024f6:	83 c4 18             	add    $0x18,%esp
}
  8024f9:	c9                   	leave  
  8024fa:	c3                   	ret    

008024fb <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8024fb:	55                   	push   %ebp
  8024fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8024fe:	6a 00                	push   $0x0
  802500:	6a 00                	push   $0x0
  802502:	6a 00                	push   $0x0
  802504:	ff 75 0c             	pushl  0xc(%ebp)
  802507:	ff 75 08             	pushl  0x8(%ebp)
  80250a:	6a 0a                	push   $0xa
  80250c:	e8 99 fe ff ff       	call   8023aa <syscall>
  802511:	83 c4 18             	add    $0x18,%esp
}
  802514:	c9                   	leave  
  802515:	c3                   	ret    

00802516 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802516:	55                   	push   %ebp
  802517:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802519:	6a 00                	push   $0x0
  80251b:	6a 00                	push   $0x0
  80251d:	6a 00                	push   $0x0
  80251f:	6a 00                	push   $0x0
  802521:	6a 00                	push   $0x0
  802523:	6a 0b                	push   $0xb
  802525:	e8 80 fe ff ff       	call   8023aa <syscall>
  80252a:	83 c4 18             	add    $0x18,%esp
}
  80252d:	c9                   	leave  
  80252e:	c3                   	ret    

0080252f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80252f:	55                   	push   %ebp
  802530:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802532:	6a 00                	push   $0x0
  802534:	6a 00                	push   $0x0
  802536:	6a 00                	push   $0x0
  802538:	6a 00                	push   $0x0
  80253a:	6a 00                	push   $0x0
  80253c:	6a 0c                	push   $0xc
  80253e:	e8 67 fe ff ff       	call   8023aa <syscall>
  802543:	83 c4 18             	add    $0x18,%esp
}
  802546:	c9                   	leave  
  802547:	c3                   	ret    

00802548 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802548:	55                   	push   %ebp
  802549:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80254b:	6a 00                	push   $0x0
  80254d:	6a 00                	push   $0x0
  80254f:	6a 00                	push   $0x0
  802551:	6a 00                	push   $0x0
  802553:	6a 00                	push   $0x0
  802555:	6a 0d                	push   $0xd
  802557:	e8 4e fe ff ff       	call   8023aa <syscall>
  80255c:	83 c4 18             	add    $0x18,%esp
}
  80255f:	c9                   	leave  
  802560:	c3                   	ret    

00802561 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802561:	55                   	push   %ebp
  802562:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802564:	6a 00                	push   $0x0
  802566:	6a 00                	push   $0x0
  802568:	6a 00                	push   $0x0
  80256a:	ff 75 0c             	pushl  0xc(%ebp)
  80256d:	ff 75 08             	pushl  0x8(%ebp)
  802570:	6a 11                	push   $0x11
  802572:	e8 33 fe ff ff       	call   8023aa <syscall>
  802577:	83 c4 18             	add    $0x18,%esp
	return;
  80257a:	90                   	nop
}
  80257b:	c9                   	leave  
  80257c:	c3                   	ret    

0080257d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80257d:	55                   	push   %ebp
  80257e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802580:	6a 00                	push   $0x0
  802582:	6a 00                	push   $0x0
  802584:	6a 00                	push   $0x0
  802586:	ff 75 0c             	pushl  0xc(%ebp)
  802589:	ff 75 08             	pushl  0x8(%ebp)
  80258c:	6a 12                	push   $0x12
  80258e:	e8 17 fe ff ff       	call   8023aa <syscall>
  802593:	83 c4 18             	add    $0x18,%esp
	return ;
  802596:	90                   	nop
}
  802597:	c9                   	leave  
  802598:	c3                   	ret    

00802599 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802599:	55                   	push   %ebp
  80259a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80259c:	6a 00                	push   $0x0
  80259e:	6a 00                	push   $0x0
  8025a0:	6a 00                	push   $0x0
  8025a2:	6a 00                	push   $0x0
  8025a4:	6a 00                	push   $0x0
  8025a6:	6a 0e                	push   $0xe
  8025a8:	e8 fd fd ff ff       	call   8023aa <syscall>
  8025ad:	83 c4 18             	add    $0x18,%esp
}
  8025b0:	c9                   	leave  
  8025b1:	c3                   	ret    

008025b2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8025b2:	55                   	push   %ebp
  8025b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8025b5:	6a 00                	push   $0x0
  8025b7:	6a 00                	push   $0x0
  8025b9:	6a 00                	push   $0x0
  8025bb:	6a 00                	push   $0x0
  8025bd:	ff 75 08             	pushl  0x8(%ebp)
  8025c0:	6a 0f                	push   $0xf
  8025c2:	e8 e3 fd ff ff       	call   8023aa <syscall>
  8025c7:	83 c4 18             	add    $0x18,%esp
}
  8025ca:	c9                   	leave  
  8025cb:	c3                   	ret    

008025cc <sys_scarce_memory>:

void sys_scarce_memory()
{
  8025cc:	55                   	push   %ebp
  8025cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8025cf:	6a 00                	push   $0x0
  8025d1:	6a 00                	push   $0x0
  8025d3:	6a 00                	push   $0x0
  8025d5:	6a 00                	push   $0x0
  8025d7:	6a 00                	push   $0x0
  8025d9:	6a 10                	push   $0x10
  8025db:	e8 ca fd ff ff       	call   8023aa <syscall>
  8025e0:	83 c4 18             	add    $0x18,%esp
}
  8025e3:	90                   	nop
  8025e4:	c9                   	leave  
  8025e5:	c3                   	ret    

008025e6 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8025e6:	55                   	push   %ebp
  8025e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8025e9:	6a 00                	push   $0x0
  8025eb:	6a 00                	push   $0x0
  8025ed:	6a 00                	push   $0x0
  8025ef:	6a 00                	push   $0x0
  8025f1:	6a 00                	push   $0x0
  8025f3:	6a 14                	push   $0x14
  8025f5:	e8 b0 fd ff ff       	call   8023aa <syscall>
  8025fa:	83 c4 18             	add    $0x18,%esp
}
  8025fd:	90                   	nop
  8025fe:	c9                   	leave  
  8025ff:	c3                   	ret    

00802600 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802600:	55                   	push   %ebp
  802601:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802603:	6a 00                	push   $0x0
  802605:	6a 00                	push   $0x0
  802607:	6a 00                	push   $0x0
  802609:	6a 00                	push   $0x0
  80260b:	6a 00                	push   $0x0
  80260d:	6a 15                	push   $0x15
  80260f:	e8 96 fd ff ff       	call   8023aa <syscall>
  802614:	83 c4 18             	add    $0x18,%esp
}
  802617:	90                   	nop
  802618:	c9                   	leave  
  802619:	c3                   	ret    

0080261a <sys_cputc>:


void
sys_cputc(const char c)
{
  80261a:	55                   	push   %ebp
  80261b:	89 e5                	mov    %esp,%ebp
  80261d:	83 ec 04             	sub    $0x4,%esp
  802620:	8b 45 08             	mov    0x8(%ebp),%eax
  802623:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802626:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80262a:	6a 00                	push   $0x0
  80262c:	6a 00                	push   $0x0
  80262e:	6a 00                	push   $0x0
  802630:	6a 00                	push   $0x0
  802632:	50                   	push   %eax
  802633:	6a 16                	push   $0x16
  802635:	e8 70 fd ff ff       	call   8023aa <syscall>
  80263a:	83 c4 18             	add    $0x18,%esp
}
  80263d:	90                   	nop
  80263e:	c9                   	leave  
  80263f:	c3                   	ret    

00802640 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802640:	55                   	push   %ebp
  802641:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802643:	6a 00                	push   $0x0
  802645:	6a 00                	push   $0x0
  802647:	6a 00                	push   $0x0
  802649:	6a 00                	push   $0x0
  80264b:	6a 00                	push   $0x0
  80264d:	6a 17                	push   $0x17
  80264f:	e8 56 fd ff ff       	call   8023aa <syscall>
  802654:	83 c4 18             	add    $0x18,%esp
}
  802657:	90                   	nop
  802658:	c9                   	leave  
  802659:	c3                   	ret    

0080265a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80265a:	55                   	push   %ebp
  80265b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80265d:	8b 45 08             	mov    0x8(%ebp),%eax
  802660:	6a 00                	push   $0x0
  802662:	6a 00                	push   $0x0
  802664:	6a 00                	push   $0x0
  802666:	ff 75 0c             	pushl  0xc(%ebp)
  802669:	50                   	push   %eax
  80266a:	6a 18                	push   $0x18
  80266c:	e8 39 fd ff ff       	call   8023aa <syscall>
  802671:	83 c4 18             	add    $0x18,%esp
}
  802674:	c9                   	leave  
  802675:	c3                   	ret    

00802676 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802676:	55                   	push   %ebp
  802677:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802679:	8b 55 0c             	mov    0xc(%ebp),%edx
  80267c:	8b 45 08             	mov    0x8(%ebp),%eax
  80267f:	6a 00                	push   $0x0
  802681:	6a 00                	push   $0x0
  802683:	6a 00                	push   $0x0
  802685:	52                   	push   %edx
  802686:	50                   	push   %eax
  802687:	6a 1b                	push   $0x1b
  802689:	e8 1c fd ff ff       	call   8023aa <syscall>
  80268e:	83 c4 18             	add    $0x18,%esp
}
  802691:	c9                   	leave  
  802692:	c3                   	ret    

00802693 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802693:	55                   	push   %ebp
  802694:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802696:	8b 55 0c             	mov    0xc(%ebp),%edx
  802699:	8b 45 08             	mov    0x8(%ebp),%eax
  80269c:	6a 00                	push   $0x0
  80269e:	6a 00                	push   $0x0
  8026a0:	6a 00                	push   $0x0
  8026a2:	52                   	push   %edx
  8026a3:	50                   	push   %eax
  8026a4:	6a 19                	push   $0x19
  8026a6:	e8 ff fc ff ff       	call   8023aa <syscall>
  8026ab:	83 c4 18             	add    $0x18,%esp
}
  8026ae:	90                   	nop
  8026af:	c9                   	leave  
  8026b0:	c3                   	ret    

008026b1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8026b1:	55                   	push   %ebp
  8026b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8026b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8026ba:	6a 00                	push   $0x0
  8026bc:	6a 00                	push   $0x0
  8026be:	6a 00                	push   $0x0
  8026c0:	52                   	push   %edx
  8026c1:	50                   	push   %eax
  8026c2:	6a 1a                	push   $0x1a
  8026c4:	e8 e1 fc ff ff       	call   8023aa <syscall>
  8026c9:	83 c4 18             	add    $0x18,%esp
}
  8026cc:	90                   	nop
  8026cd:	c9                   	leave  
  8026ce:	c3                   	ret    

008026cf <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8026cf:	55                   	push   %ebp
  8026d0:	89 e5                	mov    %esp,%ebp
  8026d2:	83 ec 04             	sub    $0x4,%esp
  8026d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8026d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8026db:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8026de:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8026e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8026e5:	6a 00                	push   $0x0
  8026e7:	51                   	push   %ecx
  8026e8:	52                   	push   %edx
  8026e9:	ff 75 0c             	pushl  0xc(%ebp)
  8026ec:	50                   	push   %eax
  8026ed:	6a 1c                	push   $0x1c
  8026ef:	e8 b6 fc ff ff       	call   8023aa <syscall>
  8026f4:	83 c4 18             	add    $0x18,%esp
}
  8026f7:	c9                   	leave  
  8026f8:	c3                   	ret    

008026f9 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8026f9:	55                   	push   %ebp
  8026fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8026fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026ff:	8b 45 08             	mov    0x8(%ebp),%eax
  802702:	6a 00                	push   $0x0
  802704:	6a 00                	push   $0x0
  802706:	6a 00                	push   $0x0
  802708:	52                   	push   %edx
  802709:	50                   	push   %eax
  80270a:	6a 1d                	push   $0x1d
  80270c:	e8 99 fc ff ff       	call   8023aa <syscall>
  802711:	83 c4 18             	add    $0x18,%esp
}
  802714:	c9                   	leave  
  802715:	c3                   	ret    

00802716 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802716:	55                   	push   %ebp
  802717:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802719:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80271c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80271f:	8b 45 08             	mov    0x8(%ebp),%eax
  802722:	6a 00                	push   $0x0
  802724:	6a 00                	push   $0x0
  802726:	51                   	push   %ecx
  802727:	52                   	push   %edx
  802728:	50                   	push   %eax
  802729:	6a 1e                	push   $0x1e
  80272b:	e8 7a fc ff ff       	call   8023aa <syscall>
  802730:	83 c4 18             	add    $0x18,%esp
}
  802733:	c9                   	leave  
  802734:	c3                   	ret    

00802735 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802735:	55                   	push   %ebp
  802736:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802738:	8b 55 0c             	mov    0xc(%ebp),%edx
  80273b:	8b 45 08             	mov    0x8(%ebp),%eax
  80273e:	6a 00                	push   $0x0
  802740:	6a 00                	push   $0x0
  802742:	6a 00                	push   $0x0
  802744:	52                   	push   %edx
  802745:	50                   	push   %eax
  802746:	6a 1f                	push   $0x1f
  802748:	e8 5d fc ff ff       	call   8023aa <syscall>
  80274d:	83 c4 18             	add    $0x18,%esp
}
  802750:	c9                   	leave  
  802751:	c3                   	ret    

00802752 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802752:	55                   	push   %ebp
  802753:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802755:	6a 00                	push   $0x0
  802757:	6a 00                	push   $0x0
  802759:	6a 00                	push   $0x0
  80275b:	6a 00                	push   $0x0
  80275d:	6a 00                	push   $0x0
  80275f:	6a 20                	push   $0x20
  802761:	e8 44 fc ff ff       	call   8023aa <syscall>
  802766:	83 c4 18             	add    $0x18,%esp
}
  802769:	c9                   	leave  
  80276a:	c3                   	ret    

0080276b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80276b:	55                   	push   %ebp
  80276c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80276e:	8b 45 08             	mov    0x8(%ebp),%eax
  802771:	6a 00                	push   $0x0
  802773:	ff 75 14             	pushl  0x14(%ebp)
  802776:	ff 75 10             	pushl  0x10(%ebp)
  802779:	ff 75 0c             	pushl  0xc(%ebp)
  80277c:	50                   	push   %eax
  80277d:	6a 21                	push   $0x21
  80277f:	e8 26 fc ff ff       	call   8023aa <syscall>
  802784:	83 c4 18             	add    $0x18,%esp
}
  802787:	c9                   	leave  
  802788:	c3                   	ret    

00802789 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802789:	55                   	push   %ebp
  80278a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80278c:	8b 45 08             	mov    0x8(%ebp),%eax
  80278f:	6a 00                	push   $0x0
  802791:	6a 00                	push   $0x0
  802793:	6a 00                	push   $0x0
  802795:	6a 00                	push   $0x0
  802797:	50                   	push   %eax
  802798:	6a 22                	push   $0x22
  80279a:	e8 0b fc ff ff       	call   8023aa <syscall>
  80279f:	83 c4 18             	add    $0x18,%esp
}
  8027a2:	90                   	nop
  8027a3:	c9                   	leave  
  8027a4:	c3                   	ret    

008027a5 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8027a5:	55                   	push   %ebp
  8027a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8027a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8027ab:	6a 00                	push   $0x0
  8027ad:	6a 00                	push   $0x0
  8027af:	6a 00                	push   $0x0
  8027b1:	6a 00                	push   $0x0
  8027b3:	50                   	push   %eax
  8027b4:	6a 23                	push   $0x23
  8027b6:	e8 ef fb ff ff       	call   8023aa <syscall>
  8027bb:	83 c4 18             	add    $0x18,%esp
}
  8027be:	90                   	nop
  8027bf:	c9                   	leave  
  8027c0:	c3                   	ret    

008027c1 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8027c1:	55                   	push   %ebp
  8027c2:	89 e5                	mov    %esp,%ebp
  8027c4:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8027c7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8027ca:	8d 50 04             	lea    0x4(%eax),%edx
  8027cd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8027d0:	6a 00                	push   $0x0
  8027d2:	6a 00                	push   $0x0
  8027d4:	6a 00                	push   $0x0
  8027d6:	52                   	push   %edx
  8027d7:	50                   	push   %eax
  8027d8:	6a 24                	push   $0x24
  8027da:	e8 cb fb ff ff       	call   8023aa <syscall>
  8027df:	83 c4 18             	add    $0x18,%esp
	return result;
  8027e2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8027e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8027e8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8027eb:	89 01                	mov    %eax,(%ecx)
  8027ed:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8027f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8027f3:	c9                   	leave  
  8027f4:	c2 04 00             	ret    $0x4

008027f7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8027f7:	55                   	push   %ebp
  8027f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8027fa:	6a 00                	push   $0x0
  8027fc:	6a 00                	push   $0x0
  8027fe:	ff 75 10             	pushl  0x10(%ebp)
  802801:	ff 75 0c             	pushl  0xc(%ebp)
  802804:	ff 75 08             	pushl  0x8(%ebp)
  802807:	6a 13                	push   $0x13
  802809:	e8 9c fb ff ff       	call   8023aa <syscall>
  80280e:	83 c4 18             	add    $0x18,%esp
	return ;
  802811:	90                   	nop
}
  802812:	c9                   	leave  
  802813:	c3                   	ret    

00802814 <sys_rcr2>:
uint32 sys_rcr2()
{
  802814:	55                   	push   %ebp
  802815:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802817:	6a 00                	push   $0x0
  802819:	6a 00                	push   $0x0
  80281b:	6a 00                	push   $0x0
  80281d:	6a 00                	push   $0x0
  80281f:	6a 00                	push   $0x0
  802821:	6a 25                	push   $0x25
  802823:	e8 82 fb ff ff       	call   8023aa <syscall>
  802828:	83 c4 18             	add    $0x18,%esp
}
  80282b:	c9                   	leave  
  80282c:	c3                   	ret    

0080282d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80282d:	55                   	push   %ebp
  80282e:	89 e5                	mov    %esp,%ebp
  802830:	83 ec 04             	sub    $0x4,%esp
  802833:	8b 45 08             	mov    0x8(%ebp),%eax
  802836:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802839:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80283d:	6a 00                	push   $0x0
  80283f:	6a 00                	push   $0x0
  802841:	6a 00                	push   $0x0
  802843:	6a 00                	push   $0x0
  802845:	50                   	push   %eax
  802846:	6a 26                	push   $0x26
  802848:	e8 5d fb ff ff       	call   8023aa <syscall>
  80284d:	83 c4 18             	add    $0x18,%esp
	return ;
  802850:	90                   	nop
}
  802851:	c9                   	leave  
  802852:	c3                   	ret    

00802853 <rsttst>:
void rsttst()
{
  802853:	55                   	push   %ebp
  802854:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802856:	6a 00                	push   $0x0
  802858:	6a 00                	push   $0x0
  80285a:	6a 00                	push   $0x0
  80285c:	6a 00                	push   $0x0
  80285e:	6a 00                	push   $0x0
  802860:	6a 28                	push   $0x28
  802862:	e8 43 fb ff ff       	call   8023aa <syscall>
  802867:	83 c4 18             	add    $0x18,%esp
	return ;
  80286a:	90                   	nop
}
  80286b:	c9                   	leave  
  80286c:	c3                   	ret    

0080286d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80286d:	55                   	push   %ebp
  80286e:	89 e5                	mov    %esp,%ebp
  802870:	83 ec 04             	sub    $0x4,%esp
  802873:	8b 45 14             	mov    0x14(%ebp),%eax
  802876:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802879:	8b 55 18             	mov    0x18(%ebp),%edx
  80287c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802880:	52                   	push   %edx
  802881:	50                   	push   %eax
  802882:	ff 75 10             	pushl  0x10(%ebp)
  802885:	ff 75 0c             	pushl  0xc(%ebp)
  802888:	ff 75 08             	pushl  0x8(%ebp)
  80288b:	6a 27                	push   $0x27
  80288d:	e8 18 fb ff ff       	call   8023aa <syscall>
  802892:	83 c4 18             	add    $0x18,%esp
	return ;
  802895:	90                   	nop
}
  802896:	c9                   	leave  
  802897:	c3                   	ret    

00802898 <chktst>:
void chktst(uint32 n)
{
  802898:	55                   	push   %ebp
  802899:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80289b:	6a 00                	push   $0x0
  80289d:	6a 00                	push   $0x0
  80289f:	6a 00                	push   $0x0
  8028a1:	6a 00                	push   $0x0
  8028a3:	ff 75 08             	pushl  0x8(%ebp)
  8028a6:	6a 29                	push   $0x29
  8028a8:	e8 fd fa ff ff       	call   8023aa <syscall>
  8028ad:	83 c4 18             	add    $0x18,%esp
	return ;
  8028b0:	90                   	nop
}
  8028b1:	c9                   	leave  
  8028b2:	c3                   	ret    

008028b3 <inctst>:

void inctst()
{
  8028b3:	55                   	push   %ebp
  8028b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8028b6:	6a 00                	push   $0x0
  8028b8:	6a 00                	push   $0x0
  8028ba:	6a 00                	push   $0x0
  8028bc:	6a 00                	push   $0x0
  8028be:	6a 00                	push   $0x0
  8028c0:	6a 2a                	push   $0x2a
  8028c2:	e8 e3 fa ff ff       	call   8023aa <syscall>
  8028c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8028ca:	90                   	nop
}
  8028cb:	c9                   	leave  
  8028cc:	c3                   	ret    

008028cd <gettst>:
uint32 gettst()
{
  8028cd:	55                   	push   %ebp
  8028ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8028d0:	6a 00                	push   $0x0
  8028d2:	6a 00                	push   $0x0
  8028d4:	6a 00                	push   $0x0
  8028d6:	6a 00                	push   $0x0
  8028d8:	6a 00                	push   $0x0
  8028da:	6a 2b                	push   $0x2b
  8028dc:	e8 c9 fa ff ff       	call   8023aa <syscall>
  8028e1:	83 c4 18             	add    $0x18,%esp
}
  8028e4:	c9                   	leave  
  8028e5:	c3                   	ret    

008028e6 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8028e6:	55                   	push   %ebp
  8028e7:	89 e5                	mov    %esp,%ebp
  8028e9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8028ec:	6a 00                	push   $0x0
  8028ee:	6a 00                	push   $0x0
  8028f0:	6a 00                	push   $0x0
  8028f2:	6a 00                	push   $0x0
  8028f4:	6a 00                	push   $0x0
  8028f6:	6a 2c                	push   $0x2c
  8028f8:	e8 ad fa ff ff       	call   8023aa <syscall>
  8028fd:	83 c4 18             	add    $0x18,%esp
  802900:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802903:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802907:	75 07                	jne    802910 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802909:	b8 01 00 00 00       	mov    $0x1,%eax
  80290e:	eb 05                	jmp    802915 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802910:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802915:	c9                   	leave  
  802916:	c3                   	ret    

00802917 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802917:	55                   	push   %ebp
  802918:	89 e5                	mov    %esp,%ebp
  80291a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80291d:	6a 00                	push   $0x0
  80291f:	6a 00                	push   $0x0
  802921:	6a 00                	push   $0x0
  802923:	6a 00                	push   $0x0
  802925:	6a 00                	push   $0x0
  802927:	6a 2c                	push   $0x2c
  802929:	e8 7c fa ff ff       	call   8023aa <syscall>
  80292e:	83 c4 18             	add    $0x18,%esp
  802931:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802934:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802938:	75 07                	jne    802941 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80293a:	b8 01 00 00 00       	mov    $0x1,%eax
  80293f:	eb 05                	jmp    802946 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802941:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802946:	c9                   	leave  
  802947:	c3                   	ret    

00802948 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802948:	55                   	push   %ebp
  802949:	89 e5                	mov    %esp,%ebp
  80294b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80294e:	6a 00                	push   $0x0
  802950:	6a 00                	push   $0x0
  802952:	6a 00                	push   $0x0
  802954:	6a 00                	push   $0x0
  802956:	6a 00                	push   $0x0
  802958:	6a 2c                	push   $0x2c
  80295a:	e8 4b fa ff ff       	call   8023aa <syscall>
  80295f:	83 c4 18             	add    $0x18,%esp
  802962:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802965:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802969:	75 07                	jne    802972 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80296b:	b8 01 00 00 00       	mov    $0x1,%eax
  802970:	eb 05                	jmp    802977 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802972:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802977:	c9                   	leave  
  802978:	c3                   	ret    

00802979 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802979:	55                   	push   %ebp
  80297a:	89 e5                	mov    %esp,%ebp
  80297c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80297f:	6a 00                	push   $0x0
  802981:	6a 00                	push   $0x0
  802983:	6a 00                	push   $0x0
  802985:	6a 00                	push   $0x0
  802987:	6a 00                	push   $0x0
  802989:	6a 2c                	push   $0x2c
  80298b:	e8 1a fa ff ff       	call   8023aa <syscall>
  802990:	83 c4 18             	add    $0x18,%esp
  802993:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802996:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80299a:	75 07                	jne    8029a3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80299c:	b8 01 00 00 00       	mov    $0x1,%eax
  8029a1:	eb 05                	jmp    8029a8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8029a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8029a8:	c9                   	leave  
  8029a9:	c3                   	ret    

008029aa <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8029aa:	55                   	push   %ebp
  8029ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8029ad:	6a 00                	push   $0x0
  8029af:	6a 00                	push   $0x0
  8029b1:	6a 00                	push   $0x0
  8029b3:	6a 00                	push   $0x0
  8029b5:	ff 75 08             	pushl  0x8(%ebp)
  8029b8:	6a 2d                	push   $0x2d
  8029ba:	e8 eb f9 ff ff       	call   8023aa <syscall>
  8029bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8029c2:	90                   	nop
}
  8029c3:	c9                   	leave  
  8029c4:	c3                   	ret    

008029c5 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8029c5:	55                   	push   %ebp
  8029c6:	89 e5                	mov    %esp,%ebp
  8029c8:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8029c9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8029cc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8029cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8029d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8029d5:	6a 00                	push   $0x0
  8029d7:	53                   	push   %ebx
  8029d8:	51                   	push   %ecx
  8029d9:	52                   	push   %edx
  8029da:	50                   	push   %eax
  8029db:	6a 2e                	push   $0x2e
  8029dd:	e8 c8 f9 ff ff       	call   8023aa <syscall>
  8029e2:	83 c4 18             	add    $0x18,%esp
}
  8029e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8029e8:	c9                   	leave  
  8029e9:	c3                   	ret    

008029ea <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8029ea:	55                   	push   %ebp
  8029eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8029ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8029f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8029f3:	6a 00                	push   $0x0
  8029f5:	6a 00                	push   $0x0
  8029f7:	6a 00                	push   $0x0
  8029f9:	52                   	push   %edx
  8029fa:	50                   	push   %eax
  8029fb:	6a 2f                	push   $0x2f
  8029fd:	e8 a8 f9 ff ff       	call   8023aa <syscall>
  802a02:	83 c4 18             	add    $0x18,%esp
}
  802a05:	c9                   	leave  
  802a06:	c3                   	ret    
  802a07:	90                   	nop

00802a08 <__udivdi3>:
  802a08:	55                   	push   %ebp
  802a09:	57                   	push   %edi
  802a0a:	56                   	push   %esi
  802a0b:	53                   	push   %ebx
  802a0c:	83 ec 1c             	sub    $0x1c,%esp
  802a0f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802a13:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802a17:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802a1b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802a1f:	89 ca                	mov    %ecx,%edx
  802a21:	89 f8                	mov    %edi,%eax
  802a23:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802a27:	85 f6                	test   %esi,%esi
  802a29:	75 2d                	jne    802a58 <__udivdi3+0x50>
  802a2b:	39 cf                	cmp    %ecx,%edi
  802a2d:	77 65                	ja     802a94 <__udivdi3+0x8c>
  802a2f:	89 fd                	mov    %edi,%ebp
  802a31:	85 ff                	test   %edi,%edi
  802a33:	75 0b                	jne    802a40 <__udivdi3+0x38>
  802a35:	b8 01 00 00 00       	mov    $0x1,%eax
  802a3a:	31 d2                	xor    %edx,%edx
  802a3c:	f7 f7                	div    %edi
  802a3e:	89 c5                	mov    %eax,%ebp
  802a40:	31 d2                	xor    %edx,%edx
  802a42:	89 c8                	mov    %ecx,%eax
  802a44:	f7 f5                	div    %ebp
  802a46:	89 c1                	mov    %eax,%ecx
  802a48:	89 d8                	mov    %ebx,%eax
  802a4a:	f7 f5                	div    %ebp
  802a4c:	89 cf                	mov    %ecx,%edi
  802a4e:	89 fa                	mov    %edi,%edx
  802a50:	83 c4 1c             	add    $0x1c,%esp
  802a53:	5b                   	pop    %ebx
  802a54:	5e                   	pop    %esi
  802a55:	5f                   	pop    %edi
  802a56:	5d                   	pop    %ebp
  802a57:	c3                   	ret    
  802a58:	39 ce                	cmp    %ecx,%esi
  802a5a:	77 28                	ja     802a84 <__udivdi3+0x7c>
  802a5c:	0f bd fe             	bsr    %esi,%edi
  802a5f:	83 f7 1f             	xor    $0x1f,%edi
  802a62:	75 40                	jne    802aa4 <__udivdi3+0x9c>
  802a64:	39 ce                	cmp    %ecx,%esi
  802a66:	72 0a                	jb     802a72 <__udivdi3+0x6a>
  802a68:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802a6c:	0f 87 9e 00 00 00    	ja     802b10 <__udivdi3+0x108>
  802a72:	b8 01 00 00 00       	mov    $0x1,%eax
  802a77:	89 fa                	mov    %edi,%edx
  802a79:	83 c4 1c             	add    $0x1c,%esp
  802a7c:	5b                   	pop    %ebx
  802a7d:	5e                   	pop    %esi
  802a7e:	5f                   	pop    %edi
  802a7f:	5d                   	pop    %ebp
  802a80:	c3                   	ret    
  802a81:	8d 76 00             	lea    0x0(%esi),%esi
  802a84:	31 ff                	xor    %edi,%edi
  802a86:	31 c0                	xor    %eax,%eax
  802a88:	89 fa                	mov    %edi,%edx
  802a8a:	83 c4 1c             	add    $0x1c,%esp
  802a8d:	5b                   	pop    %ebx
  802a8e:	5e                   	pop    %esi
  802a8f:	5f                   	pop    %edi
  802a90:	5d                   	pop    %ebp
  802a91:	c3                   	ret    
  802a92:	66 90                	xchg   %ax,%ax
  802a94:	89 d8                	mov    %ebx,%eax
  802a96:	f7 f7                	div    %edi
  802a98:	31 ff                	xor    %edi,%edi
  802a9a:	89 fa                	mov    %edi,%edx
  802a9c:	83 c4 1c             	add    $0x1c,%esp
  802a9f:	5b                   	pop    %ebx
  802aa0:	5e                   	pop    %esi
  802aa1:	5f                   	pop    %edi
  802aa2:	5d                   	pop    %ebp
  802aa3:	c3                   	ret    
  802aa4:	bd 20 00 00 00       	mov    $0x20,%ebp
  802aa9:	89 eb                	mov    %ebp,%ebx
  802aab:	29 fb                	sub    %edi,%ebx
  802aad:	89 f9                	mov    %edi,%ecx
  802aaf:	d3 e6                	shl    %cl,%esi
  802ab1:	89 c5                	mov    %eax,%ebp
  802ab3:	88 d9                	mov    %bl,%cl
  802ab5:	d3 ed                	shr    %cl,%ebp
  802ab7:	89 e9                	mov    %ebp,%ecx
  802ab9:	09 f1                	or     %esi,%ecx
  802abb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802abf:	89 f9                	mov    %edi,%ecx
  802ac1:	d3 e0                	shl    %cl,%eax
  802ac3:	89 c5                	mov    %eax,%ebp
  802ac5:	89 d6                	mov    %edx,%esi
  802ac7:	88 d9                	mov    %bl,%cl
  802ac9:	d3 ee                	shr    %cl,%esi
  802acb:	89 f9                	mov    %edi,%ecx
  802acd:	d3 e2                	shl    %cl,%edx
  802acf:	8b 44 24 08          	mov    0x8(%esp),%eax
  802ad3:	88 d9                	mov    %bl,%cl
  802ad5:	d3 e8                	shr    %cl,%eax
  802ad7:	09 c2                	or     %eax,%edx
  802ad9:	89 d0                	mov    %edx,%eax
  802adb:	89 f2                	mov    %esi,%edx
  802add:	f7 74 24 0c          	divl   0xc(%esp)
  802ae1:	89 d6                	mov    %edx,%esi
  802ae3:	89 c3                	mov    %eax,%ebx
  802ae5:	f7 e5                	mul    %ebp
  802ae7:	39 d6                	cmp    %edx,%esi
  802ae9:	72 19                	jb     802b04 <__udivdi3+0xfc>
  802aeb:	74 0b                	je     802af8 <__udivdi3+0xf0>
  802aed:	89 d8                	mov    %ebx,%eax
  802aef:	31 ff                	xor    %edi,%edi
  802af1:	e9 58 ff ff ff       	jmp    802a4e <__udivdi3+0x46>
  802af6:	66 90                	xchg   %ax,%ax
  802af8:	8b 54 24 08          	mov    0x8(%esp),%edx
  802afc:	89 f9                	mov    %edi,%ecx
  802afe:	d3 e2                	shl    %cl,%edx
  802b00:	39 c2                	cmp    %eax,%edx
  802b02:	73 e9                	jae    802aed <__udivdi3+0xe5>
  802b04:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802b07:	31 ff                	xor    %edi,%edi
  802b09:	e9 40 ff ff ff       	jmp    802a4e <__udivdi3+0x46>
  802b0e:	66 90                	xchg   %ax,%ax
  802b10:	31 c0                	xor    %eax,%eax
  802b12:	e9 37 ff ff ff       	jmp    802a4e <__udivdi3+0x46>
  802b17:	90                   	nop

00802b18 <__umoddi3>:
  802b18:	55                   	push   %ebp
  802b19:	57                   	push   %edi
  802b1a:	56                   	push   %esi
  802b1b:	53                   	push   %ebx
  802b1c:	83 ec 1c             	sub    $0x1c,%esp
  802b1f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802b23:	8b 74 24 34          	mov    0x34(%esp),%esi
  802b27:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802b2b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802b2f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802b33:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802b37:	89 f3                	mov    %esi,%ebx
  802b39:	89 fa                	mov    %edi,%edx
  802b3b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802b3f:	89 34 24             	mov    %esi,(%esp)
  802b42:	85 c0                	test   %eax,%eax
  802b44:	75 1a                	jne    802b60 <__umoddi3+0x48>
  802b46:	39 f7                	cmp    %esi,%edi
  802b48:	0f 86 a2 00 00 00    	jbe    802bf0 <__umoddi3+0xd8>
  802b4e:	89 c8                	mov    %ecx,%eax
  802b50:	89 f2                	mov    %esi,%edx
  802b52:	f7 f7                	div    %edi
  802b54:	89 d0                	mov    %edx,%eax
  802b56:	31 d2                	xor    %edx,%edx
  802b58:	83 c4 1c             	add    $0x1c,%esp
  802b5b:	5b                   	pop    %ebx
  802b5c:	5e                   	pop    %esi
  802b5d:	5f                   	pop    %edi
  802b5e:	5d                   	pop    %ebp
  802b5f:	c3                   	ret    
  802b60:	39 f0                	cmp    %esi,%eax
  802b62:	0f 87 ac 00 00 00    	ja     802c14 <__umoddi3+0xfc>
  802b68:	0f bd e8             	bsr    %eax,%ebp
  802b6b:	83 f5 1f             	xor    $0x1f,%ebp
  802b6e:	0f 84 ac 00 00 00    	je     802c20 <__umoddi3+0x108>
  802b74:	bf 20 00 00 00       	mov    $0x20,%edi
  802b79:	29 ef                	sub    %ebp,%edi
  802b7b:	89 fe                	mov    %edi,%esi
  802b7d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802b81:	89 e9                	mov    %ebp,%ecx
  802b83:	d3 e0                	shl    %cl,%eax
  802b85:	89 d7                	mov    %edx,%edi
  802b87:	89 f1                	mov    %esi,%ecx
  802b89:	d3 ef                	shr    %cl,%edi
  802b8b:	09 c7                	or     %eax,%edi
  802b8d:	89 e9                	mov    %ebp,%ecx
  802b8f:	d3 e2                	shl    %cl,%edx
  802b91:	89 14 24             	mov    %edx,(%esp)
  802b94:	89 d8                	mov    %ebx,%eax
  802b96:	d3 e0                	shl    %cl,%eax
  802b98:	89 c2                	mov    %eax,%edx
  802b9a:	8b 44 24 08          	mov    0x8(%esp),%eax
  802b9e:	d3 e0                	shl    %cl,%eax
  802ba0:	89 44 24 04          	mov    %eax,0x4(%esp)
  802ba4:	8b 44 24 08          	mov    0x8(%esp),%eax
  802ba8:	89 f1                	mov    %esi,%ecx
  802baa:	d3 e8                	shr    %cl,%eax
  802bac:	09 d0                	or     %edx,%eax
  802bae:	d3 eb                	shr    %cl,%ebx
  802bb0:	89 da                	mov    %ebx,%edx
  802bb2:	f7 f7                	div    %edi
  802bb4:	89 d3                	mov    %edx,%ebx
  802bb6:	f7 24 24             	mull   (%esp)
  802bb9:	89 c6                	mov    %eax,%esi
  802bbb:	89 d1                	mov    %edx,%ecx
  802bbd:	39 d3                	cmp    %edx,%ebx
  802bbf:	0f 82 87 00 00 00    	jb     802c4c <__umoddi3+0x134>
  802bc5:	0f 84 91 00 00 00    	je     802c5c <__umoddi3+0x144>
  802bcb:	8b 54 24 04          	mov    0x4(%esp),%edx
  802bcf:	29 f2                	sub    %esi,%edx
  802bd1:	19 cb                	sbb    %ecx,%ebx
  802bd3:	89 d8                	mov    %ebx,%eax
  802bd5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802bd9:	d3 e0                	shl    %cl,%eax
  802bdb:	89 e9                	mov    %ebp,%ecx
  802bdd:	d3 ea                	shr    %cl,%edx
  802bdf:	09 d0                	or     %edx,%eax
  802be1:	89 e9                	mov    %ebp,%ecx
  802be3:	d3 eb                	shr    %cl,%ebx
  802be5:	89 da                	mov    %ebx,%edx
  802be7:	83 c4 1c             	add    $0x1c,%esp
  802bea:	5b                   	pop    %ebx
  802beb:	5e                   	pop    %esi
  802bec:	5f                   	pop    %edi
  802bed:	5d                   	pop    %ebp
  802bee:	c3                   	ret    
  802bef:	90                   	nop
  802bf0:	89 fd                	mov    %edi,%ebp
  802bf2:	85 ff                	test   %edi,%edi
  802bf4:	75 0b                	jne    802c01 <__umoddi3+0xe9>
  802bf6:	b8 01 00 00 00       	mov    $0x1,%eax
  802bfb:	31 d2                	xor    %edx,%edx
  802bfd:	f7 f7                	div    %edi
  802bff:	89 c5                	mov    %eax,%ebp
  802c01:	89 f0                	mov    %esi,%eax
  802c03:	31 d2                	xor    %edx,%edx
  802c05:	f7 f5                	div    %ebp
  802c07:	89 c8                	mov    %ecx,%eax
  802c09:	f7 f5                	div    %ebp
  802c0b:	89 d0                	mov    %edx,%eax
  802c0d:	e9 44 ff ff ff       	jmp    802b56 <__umoddi3+0x3e>
  802c12:	66 90                	xchg   %ax,%ax
  802c14:	89 c8                	mov    %ecx,%eax
  802c16:	89 f2                	mov    %esi,%edx
  802c18:	83 c4 1c             	add    $0x1c,%esp
  802c1b:	5b                   	pop    %ebx
  802c1c:	5e                   	pop    %esi
  802c1d:	5f                   	pop    %edi
  802c1e:	5d                   	pop    %ebp
  802c1f:	c3                   	ret    
  802c20:	3b 04 24             	cmp    (%esp),%eax
  802c23:	72 06                	jb     802c2b <__umoddi3+0x113>
  802c25:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802c29:	77 0f                	ja     802c3a <__umoddi3+0x122>
  802c2b:	89 f2                	mov    %esi,%edx
  802c2d:	29 f9                	sub    %edi,%ecx
  802c2f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802c33:	89 14 24             	mov    %edx,(%esp)
  802c36:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802c3a:	8b 44 24 04          	mov    0x4(%esp),%eax
  802c3e:	8b 14 24             	mov    (%esp),%edx
  802c41:	83 c4 1c             	add    $0x1c,%esp
  802c44:	5b                   	pop    %ebx
  802c45:	5e                   	pop    %esi
  802c46:	5f                   	pop    %edi
  802c47:	5d                   	pop    %ebp
  802c48:	c3                   	ret    
  802c49:	8d 76 00             	lea    0x0(%esi),%esi
  802c4c:	2b 04 24             	sub    (%esp),%eax
  802c4f:	19 fa                	sbb    %edi,%edx
  802c51:	89 d1                	mov    %edx,%ecx
  802c53:	89 c6                	mov    %eax,%esi
  802c55:	e9 71 ff ff ff       	jmp    802bcb <__umoddi3+0xb3>
  802c5a:	66 90                	xchg   %ax,%ax
  802c5c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802c60:	72 ea                	jb     802c4c <__umoddi3+0x134>
  802c62:	89 d9                	mov    %ebx,%ecx
  802c64:	e9 62 ff ff ff       	jmp    802bcb <__umoddi3+0xb3>
