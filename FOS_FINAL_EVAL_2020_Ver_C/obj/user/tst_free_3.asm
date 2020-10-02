
obj/user/tst_free_3:     file format elf32-i386


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
  800031:	e8 22 14 00 00       	call   801458 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

#define numOfAccessesFor3MB 7
#define numOfAccessesFor8MB 4
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 7c 01 00 00    	sub    $0x17c,%esp



	int Mega = 1024*1024;
  800044:	c7 45 d4 00 00 10 00 	movl   $0x100000,-0x2c(%ebp)
	int kilo = 1024;
  80004b:	c7 45 d0 00 04 00 00 	movl   $0x400,-0x30(%ebp)
	char minByte = 1<<7;
  800052:	c6 45 cf 80          	movb   $0x80,-0x31(%ebp)
	char maxByte = 0x7F;
  800056:	c6 45 ce 7f          	movb   $0x7f,-0x32(%ebp)
	short minShort = 1<<15 ;
  80005a:	66 c7 45 cc 00 80    	movw   $0x8000,-0x34(%ebp)
	short maxShort = 0x7FFF;
  800060:	66 c7 45 ca ff 7f    	movw   $0x7fff,-0x36(%ebp)
	int minInt = 1<<31 ;
  800066:	c7 45 c4 00 00 00 80 	movl   $0x80000000,-0x3c(%ebp)
	int maxInt = 0x7FFFFFFF;
  80006d:	c7 45 c0 ff ff ff 7f 	movl   $0x7fffffff,-0x40(%ebp)
	int *intArr;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800074:	a1 20 40 80 00       	mov    0x804020,%eax
  800079:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800084:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 c0 32 80 00       	push   $0x8032c0
  80009b:	6a 1e                	push   $0x1e
  80009d:	68 01 33 80 00       	push   $0x803301
  8000a2:	e8 d9 14 00 00       	call   801580 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 20 40 80 00       	mov    0x804020,%eax
  8000ac:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  8000b2:	83 c0 14             	add    $0x14,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8000ba:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 10 20 00       	cmp    $0x201000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 c0 32 80 00       	push   $0x8032c0
  8000d1:	6a 1f                	push   $0x1f
  8000d3:	68 01 33 80 00       	push   $0x803301
  8000d8:	e8 a3 14 00 00       	call   801580 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000dd:	a1 20 40 80 00       	mov    0x804020,%eax
  8000e2:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  8000e8:	83 c0 28             	add    $0x28,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8000f0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 c0 32 80 00       	push   $0x8032c0
  800107:	6a 20                	push   $0x20
  800109:	68 01 33 80 00       	push   $0x803301
  80010e:	e8 6d 14 00 00       	call   801580 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800113:	a1 20 40 80 00       	mov    0x804020,%eax
  800118:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  80011e:	83 c0 3c             	add    $0x3c,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800126:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 c0 32 80 00       	push   $0x8032c0
  80013d:	6a 21                	push   $0x21
  80013f:	68 01 33 80 00       	push   $0x803301
  800144:	e8 37 14 00 00       	call   801580 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800149:	a1 20 40 80 00       	mov    0x804020,%eax
  80014e:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  800154:	83 c0 50             	add    $0x50,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80015c:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 c0 32 80 00       	push   $0x8032c0
  800173:	6a 22                	push   $0x22
  800175:	68 01 33 80 00       	push   $0x803301
  80017a:	e8 01 14 00 00       	call   801580 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017f:	a1 20 40 80 00       	mov    0x804020,%eax
  800184:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  80018a:	83 c0 64             	add    $0x64,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800192:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 c0 32 80 00       	push   $0x8032c0
  8001a9:	6a 23                	push   $0x23
  8001ab:	68 01 33 80 00       	push   $0x803301
  8001b0:	e8 cb 13 00 00       	call   801580 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b5:	a1 20 40 80 00       	mov    0x804020,%eax
  8001ba:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  8001c0:	83 c0 78             	add    $0x78,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8001c8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 c0 32 80 00       	push   $0x8032c0
  8001df:	6a 24                	push   $0x24
  8001e1:	68 01 33 80 00       	push   $0x803301
  8001e6:	e8 95 13 00 00       	call   801580 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 20 40 80 00       	mov    0x804020,%eax
  8001f0:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  8001f6:	05 8c 00 00 00       	add    $0x8c,%eax
  8001fb:	8b 00                	mov    (%eax),%eax
  8001fd:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800200:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800203:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800208:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80020d:	74 14                	je     800223 <_main+0x1eb>
  80020f:	83 ec 04             	sub    $0x4,%esp
  800212:	68 c0 32 80 00       	push   $0x8032c0
  800217:	6a 25                	push   $0x25
  800219:	68 01 33 80 00       	push   $0x803301
  80021e:	e8 5d 13 00 00       	call   801580 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800223:	a1 20 40 80 00       	mov    0x804020,%eax
  800228:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  80022e:	05 a0 00 00 00       	add    $0xa0,%eax
  800233:	8b 00                	mov    (%eax),%eax
  800235:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800238:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80023b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800240:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800245:	74 14                	je     80025b <_main+0x223>
  800247:	83 ec 04             	sub    $0x4,%esp
  80024a:	68 c0 32 80 00       	push   $0x8032c0
  80024f:	6a 26                	push   $0x26
  800251:	68 01 33 80 00       	push   $0x803301
  800256:	e8 25 13 00 00       	call   801580 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025b:	a1 20 40 80 00       	mov    0x804020,%eax
  800260:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  800266:	05 b4 00 00 00       	add    $0xb4,%eax
  80026b:	8b 00                	mov    (%eax),%eax
  80026d:	89 45 98             	mov    %eax,-0x68(%ebp)
  800270:	8b 45 98             	mov    -0x68(%ebp),%eax
  800273:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800278:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027d:	74 14                	je     800293 <_main+0x25b>
  80027f:	83 ec 04             	sub    $0x4,%esp
  800282:	68 c0 32 80 00       	push   $0x8032c0
  800287:	6a 27                	push   $0x27
  800289:	68 01 33 80 00       	push   $0x803301
  80028e:	e8 ed 12 00 00       	call   801580 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800293:	a1 20 40 80 00       	mov    0x804020,%eax
  800298:	8b 80 c0 ee 00 00    	mov    0xeec0(%eax),%eax
  80029e:	85 c0                	test   %eax,%eax
  8002a0:	74 14                	je     8002b6 <_main+0x27e>
  8002a2:	83 ec 04             	sub    $0x4,%esp
  8002a5:	68 14 33 80 00       	push   $0x803314
  8002aa:	6a 28                	push   $0x28
  8002ac:	68 01 33 80 00       	push   $0x803301
  8002b1:	e8 ca 12 00 00       	call   801580 <_panic>
	}

	int start_freeFrames = sys_calculate_free_frames() ;
  8002b6:	e8 7c 28 00 00       	call   802b37 <sys_calculate_free_frames>
  8002bb:	89 45 94             	mov    %eax,-0x6c(%ebp)

	int indicesOf3MB[numOfAccessesFor3MB];
	int indicesOf8MB[numOfAccessesFor8MB];
	int var, i, j;

	void* ptr_allocations[20] = {0};
  8002be:	8d 95 80 fe ff ff    	lea    -0x180(%ebp),%edx
  8002c4:	b9 14 00 00 00       	mov    $0x14,%ecx
  8002c9:	b8 00 00 00 00       	mov    $0x0,%eax
  8002ce:	89 d7                	mov    %edx,%edi
  8002d0:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		/*ALLOCATE 2 MB*/
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002d2:	e8 e3 28 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  8002d7:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8002da:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8002dd:	01 c0                	add    %eax,%eax
  8002df:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8002e2:	83 ec 0c             	sub    $0xc,%esp
  8002e5:	50                   	push   %eax
  8002e6:	e8 d6 22 00 00       	call   8025c1 <malloc>
  8002eb:	83 c4 10             	add    $0x10,%esp
  8002ee:	89 85 80 fe ff ff    	mov    %eax,-0x180(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8002f4:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8002fa:	85 c0                	test   %eax,%eax
  8002fc:	79 0d                	jns    80030b <_main+0x2d3>
  8002fe:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  800304:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  800309:	76 14                	jbe    80031f <_main+0x2e7>
  80030b:	83 ec 04             	sub    $0x4,%esp
  80030e:	68 5c 33 80 00       	push   $0x80335c
  800313:	6a 37                	push   $0x37
  800315:	68 01 33 80 00       	push   $0x803301
  80031a:	e8 61 12 00 00       	call   801580 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80031f:	e8 96 28 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800324:	2b 45 90             	sub    -0x70(%ebp),%eax
  800327:	3d 00 02 00 00       	cmp    $0x200,%eax
  80032c:	74 14                	je     800342 <_main+0x30a>
  80032e:	83 ec 04             	sub    $0x4,%esp
  800331:	68 c4 33 80 00       	push   $0x8033c4
  800336:	6a 38                	push   $0x38
  800338:	68 01 33 80 00       	push   $0x803301
  80033d:	e8 3e 12 00 00       	call   801580 <_panic>

		/*ALLOCATE 3 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800342:	e8 73 28 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800347:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[1] = malloc(3*Mega-kilo);
  80034a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80034d:	89 c2                	mov    %eax,%edx
  80034f:	01 d2                	add    %edx,%edx
  800351:	01 d0                	add    %edx,%eax
  800353:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800356:	83 ec 0c             	sub    $0xc,%esp
  800359:	50                   	push   %eax
  80035a:	e8 62 22 00 00       	call   8025c1 <malloc>
  80035f:	83 c4 10             	add    $0x10,%esp
  800362:	89 85 84 fe ff ff    	mov    %eax,-0x17c(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800368:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  80036e:	89 c2                	mov    %eax,%edx
  800370:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800373:	01 c0                	add    %eax,%eax
  800375:	05 00 00 00 80       	add    $0x80000000,%eax
  80037a:	39 c2                	cmp    %eax,%edx
  80037c:	72 16                	jb     800394 <_main+0x35c>
  80037e:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800384:	89 c2                	mov    %eax,%edx
  800386:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800389:	01 c0                	add    %eax,%eax
  80038b:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800390:	39 c2                	cmp    %eax,%edx
  800392:	76 14                	jbe    8003a8 <_main+0x370>
  800394:	83 ec 04             	sub    $0x4,%esp
  800397:	68 5c 33 80 00       	push   $0x80335c
  80039c:	6a 3e                	push   $0x3e
  80039e:	68 01 33 80 00       	push   $0x803301
  8003a3:	e8 d8 11 00 00       	call   801580 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  8003a8:	e8 0d 28 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  8003ad:	2b 45 90             	sub    -0x70(%ebp),%eax
  8003b0:	89 c2                	mov    %eax,%edx
  8003b2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003b5:	89 c1                	mov    %eax,%ecx
  8003b7:	01 c9                	add    %ecx,%ecx
  8003b9:	01 c8                	add    %ecx,%eax
  8003bb:	85 c0                	test   %eax,%eax
  8003bd:	79 05                	jns    8003c4 <_main+0x38c>
  8003bf:	05 ff 0f 00 00       	add    $0xfff,%eax
  8003c4:	c1 f8 0c             	sar    $0xc,%eax
  8003c7:	39 c2                	cmp    %eax,%edx
  8003c9:	74 14                	je     8003df <_main+0x3a7>
  8003cb:	83 ec 04             	sub    $0x4,%esp
  8003ce:	68 c4 33 80 00       	push   $0x8033c4
  8003d3:	6a 3f                	push   $0x3f
  8003d5:	68 01 33 80 00       	push   $0x803301
  8003da:	e8 a1 11 00 00       	call   801580 <_panic>

		/*ALLOCATE 8 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003df:	e8 d6 27 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  8003e4:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[2] = malloc(8*Mega-kilo);
  8003e7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003ea:	c1 e0 03             	shl    $0x3,%eax
  8003ed:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8003f0:	83 ec 0c             	sub    $0xc,%esp
  8003f3:	50                   	push   %eax
  8003f4:	e8 c8 21 00 00       	call   8025c1 <malloc>
  8003f9:	83 c4 10             	add    $0x10,%esp
  8003fc:	89 85 88 fe ff ff    	mov    %eax,-0x178(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 5*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 5*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800402:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800408:	89 c1                	mov    %eax,%ecx
  80040a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80040d:	89 d0                	mov    %edx,%eax
  80040f:	c1 e0 02             	shl    $0x2,%eax
  800412:	01 d0                	add    %edx,%eax
  800414:	05 00 00 00 80       	add    $0x80000000,%eax
  800419:	39 c1                	cmp    %eax,%ecx
  80041b:	72 1b                	jb     800438 <_main+0x400>
  80041d:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800423:	89 c1                	mov    %eax,%ecx
  800425:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800428:	89 d0                	mov    %edx,%eax
  80042a:	c1 e0 02             	shl    $0x2,%eax
  80042d:	01 d0                	add    %edx,%eax
  80042f:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800434:	39 c1                	cmp    %eax,%ecx
  800436:	76 14                	jbe    80044c <_main+0x414>
  800438:	83 ec 04             	sub    $0x4,%esp
  80043b:	68 5c 33 80 00       	push   $0x80335c
  800440:	6a 45                	push   $0x45
  800442:	68 01 33 80 00       	push   $0x803301
  800447:	e8 34 11 00 00       	call   801580 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 8*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  80044c:	e8 69 27 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800451:	2b 45 90             	sub    -0x70(%ebp),%eax
  800454:	89 c2                	mov    %eax,%edx
  800456:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800459:	c1 e0 03             	shl    $0x3,%eax
  80045c:	85 c0                	test   %eax,%eax
  80045e:	79 05                	jns    800465 <_main+0x42d>
  800460:	05 ff 0f 00 00       	add    $0xfff,%eax
  800465:	c1 f8 0c             	sar    $0xc,%eax
  800468:	39 c2                	cmp    %eax,%edx
  80046a:	74 14                	je     800480 <_main+0x448>
  80046c:	83 ec 04             	sub    $0x4,%esp
  80046f:	68 c4 33 80 00       	push   $0x8033c4
  800474:	6a 46                	push   $0x46
  800476:	68 01 33 80 00       	push   $0x803301
  80047b:	e8 00 11 00 00       	call   801580 <_panic>

		/*ALLOCATE 7 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800480:	e8 35 27 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800485:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[3] = malloc(7*Mega-kilo);
  800488:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80048b:	89 d0                	mov    %edx,%eax
  80048d:	01 c0                	add    %eax,%eax
  80048f:	01 d0                	add    %edx,%eax
  800491:	01 c0                	add    %eax,%eax
  800493:	01 d0                	add    %edx,%eax
  800495:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800498:	83 ec 0c             	sub    $0xc,%esp
  80049b:	50                   	push   %eax
  80049c:	e8 20 21 00 00       	call   8025c1 <malloc>
  8004a1:	83 c4 10             	add    $0x10,%esp
  8004a4:	89 85 8c fe ff ff    	mov    %eax,-0x174(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 13*Mega) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 13*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8004aa:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  8004b0:	89 c1                	mov    %eax,%ecx
  8004b2:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004b5:	89 d0                	mov    %edx,%eax
  8004b7:	01 c0                	add    %eax,%eax
  8004b9:	01 d0                	add    %edx,%eax
  8004bb:	c1 e0 02             	shl    $0x2,%eax
  8004be:	01 d0                	add    %edx,%eax
  8004c0:	05 00 00 00 80       	add    $0x80000000,%eax
  8004c5:	39 c1                	cmp    %eax,%ecx
  8004c7:	72 1f                	jb     8004e8 <_main+0x4b0>
  8004c9:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  8004cf:	89 c1                	mov    %eax,%ecx
  8004d1:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004d4:	89 d0                	mov    %edx,%eax
  8004d6:	01 c0                	add    %eax,%eax
  8004d8:	01 d0                	add    %edx,%eax
  8004da:	c1 e0 02             	shl    $0x2,%eax
  8004dd:	01 d0                	add    %edx,%eax
  8004df:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8004e4:	39 c1                	cmp    %eax,%ecx
  8004e6:	76 14                	jbe    8004fc <_main+0x4c4>
  8004e8:	83 ec 04             	sub    $0x4,%esp
  8004eb:	68 5c 33 80 00       	push   $0x80335c
  8004f0:	6a 4c                	push   $0x4c
  8004f2:	68 01 33 80 00       	push   $0x803301
  8004f7:	e8 84 10 00 00       	call   801580 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 7*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  8004fc:	e8 b9 26 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800501:	2b 45 90             	sub    -0x70(%ebp),%eax
  800504:	89 c1                	mov    %eax,%ecx
  800506:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800509:	89 d0                	mov    %edx,%eax
  80050b:	01 c0                	add    %eax,%eax
  80050d:	01 d0                	add    %edx,%eax
  80050f:	01 c0                	add    %eax,%eax
  800511:	01 d0                	add    %edx,%eax
  800513:	85 c0                	test   %eax,%eax
  800515:	79 05                	jns    80051c <_main+0x4e4>
  800517:	05 ff 0f 00 00       	add    $0xfff,%eax
  80051c:	c1 f8 0c             	sar    $0xc,%eax
  80051f:	39 c1                	cmp    %eax,%ecx
  800521:	74 14                	je     800537 <_main+0x4ff>
  800523:	83 ec 04             	sub    $0x4,%esp
  800526:	68 c4 33 80 00       	push   $0x8033c4
  80052b:	6a 4d                	push   $0x4d
  80052d:	68 01 33 80 00       	push   $0x803301
  800532:	e8 49 10 00 00       	call   801580 <_panic>

		/*access 3 MB*/// should bring 6 pages into WS (3 r, 4 w)
		int freeFrames = sys_calculate_free_frames() ;
  800537:	e8 fb 25 00 00       	call   802b37 <sys_calculate_free_frames>
  80053c:	89 45 8c             	mov    %eax,-0x74(%ebp)
		int modFrames = sys_calculate_modified_frames();
  80053f:	e8 0c 26 00 00       	call   802b50 <sys_calculate_modified_frames>
  800544:	89 45 88             	mov    %eax,-0x78(%ebp)
		lastIndexOfByte = (3*Mega-kilo)/sizeof(char) - 1;
  800547:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80054a:	89 c2                	mov    %eax,%edx
  80054c:	01 d2                	add    %edx,%edx
  80054e:	01 d0                	add    %edx,%eax
  800550:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800553:	48                   	dec    %eax
  800554:	89 45 84             	mov    %eax,-0x7c(%ebp)
		int inc = lastIndexOfByte / numOfAccessesFor3MB;
  800557:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80055a:	bf 07 00 00 00       	mov    $0x7,%edi
  80055f:	99                   	cltd   
  800560:	f7 ff                	idiv   %edi
  800562:	89 45 80             	mov    %eax,-0x80(%ebp)
		for (var = 0; var < numOfAccessesFor3MB; ++var)
  800565:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80056c:	eb 16                	jmp    800584 <_main+0x54c>
		{
			indicesOf3MB[var] = var * inc ;
  80056e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800571:	0f af 45 80          	imul   -0x80(%ebp),%eax
  800575:	89 c2                	mov    %eax,%edx
  800577:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80057a:	89 94 85 e0 fe ff ff 	mov    %edx,-0x120(%ebp,%eax,4)
		/*access 3 MB*/// should bring 6 pages into WS (3 r, 4 w)
		int freeFrames = sys_calculate_free_frames() ;
		int modFrames = sys_calculate_modified_frames();
		lastIndexOfByte = (3*Mega-kilo)/sizeof(char) - 1;
		int inc = lastIndexOfByte / numOfAccessesFor3MB;
		for (var = 0; var < numOfAccessesFor3MB; ++var)
  800581:	ff 45 e4             	incl   -0x1c(%ebp)
  800584:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  800588:	7e e4                	jle    80056e <_main+0x536>
		{
			indicesOf3MB[var] = var * inc ;
		}
		byteArr = (char *) ptr_allocations[1];
  80058a:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800590:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
		//3 reads
		int sum = 0;
  800596:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
  80059d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8005a4:	eb 1f                	jmp    8005c5 <_main+0x58d>
		{
			sum += byteArr[indicesOf3MB[var]] ;
  8005a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005a9:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8005b0:	89 c2                	mov    %eax,%edx
  8005b2:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005b8:	01 d0                	add    %edx,%eax
  8005ba:	8a 00                	mov    (%eax),%al
  8005bc:	0f be c0             	movsbl %al,%eax
  8005bf:	01 45 dc             	add    %eax,-0x24(%ebp)
			indicesOf3MB[var] = var * inc ;
		}
		byteArr = (char *) ptr_allocations[1];
		//3 reads
		int sum = 0;
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
  8005c2:	ff 45 e4             	incl   -0x1c(%ebp)
  8005c5:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  8005c9:	7e db                	jle    8005a6 <_main+0x56e>
		{
			sum += byteArr[indicesOf3MB[var]] ;
		}
		//4 writes
		for (var = numOfAccessesFor3MB/2; var < numOfAccessesFor3MB; ++var)
  8005cb:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
  8005d2:	eb 1c                	jmp    8005f0 <_main+0x5b8>
		{
			byteArr[indicesOf3MB[var]] = maxByte ;
  8005d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005d7:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8005de:	89 c2                	mov    %eax,%edx
  8005e0:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005e6:	01 c2                	add    %eax,%edx
  8005e8:	8a 45 ce             	mov    -0x32(%ebp),%al
  8005eb:	88 02                	mov    %al,(%edx)
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
		{
			sum += byteArr[indicesOf3MB[var]] ;
		}
		//4 writes
		for (var = numOfAccessesFor3MB/2; var < numOfAccessesFor3MB; ++var)
  8005ed:	ff 45 e4             	incl   -0x1c(%ebp)
  8005f0:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  8005f4:	7e de                	jle    8005d4 <_main+0x59c>
		{
			byteArr[indicesOf3MB[var]] = maxByte ;
		}
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8005f6:	8b 55 8c             	mov    -0x74(%ebp),%edx
  8005f9:	8b 45 88             	mov    -0x78(%ebp),%eax
  8005fc:	01 d0                	add    %edx,%eax
  8005fe:	89 c6                	mov    %eax,%esi
  800600:	e8 32 25 00 00       	call   802b37 <sys_calculate_free_frames>
  800605:	89 c3                	mov    %eax,%ebx
  800607:	e8 44 25 00 00       	call   802b50 <sys_calculate_modified_frames>
  80060c:	01 d8                	add    %ebx,%eax
  80060e:	29 c6                	sub    %eax,%esi
  800610:	89 f0                	mov    %esi,%eax
  800612:	83 f8 02             	cmp    $0x2,%eax
  800615:	74 14                	je     80062b <_main+0x5f3>
  800617:	83 ec 04             	sub    $0x4,%esp
  80061a:	68 f4 33 80 00       	push   $0x8033f4
  80061f:	6a 65                	push   $0x65
  800621:	68 01 33 80 00       	push   $0x803301
  800626:	e8 55 0f 00 00       	call   801580 <_panic>
		int found = 0;
  80062b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  800632:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800639:	eb 79                	jmp    8006b4 <_main+0x67c>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  80063b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800642:	eb 5e                	jmp    8006a2 <_main+0x66a>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[indicesOf3MB[var]])), PAGE_SIZE))
  800644:	a1 20 40 80 00       	mov    0x804020,%eax
  800649:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80064f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800652:	89 d0                	mov    %edx,%eax
  800654:	c1 e0 02             	shl    $0x2,%eax
  800657:	01 d0                	add    %edx,%eax
  800659:	c1 e0 02             	shl    $0x2,%eax
  80065c:	01 c8                	add    %ecx,%eax
  80065e:	8b 00                	mov    (%eax),%eax
  800660:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  800666:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80066c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800671:	89 c2                	mov    %eax,%edx
  800673:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800676:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  80067d:	89 c1                	mov    %eax,%ecx
  80067f:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800685:	01 c8                	add    %ecx,%eax
  800687:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  80068d:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800693:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800698:	39 c2                	cmp    %eax,%edx
  80069a:	75 03                	jne    80069f <_main+0x667>
				{
					found++;
  80069c:	ff 45 d8             	incl   -0x28(%ebp)
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int found = 0;
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  80069f:	ff 45 e0             	incl   -0x20(%ebp)
  8006a2:	a1 20 40 80 00       	mov    0x804020,%eax
  8006a7:	8b 50 74             	mov    0x74(%eax),%edx
  8006aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006ad:	39 c2                	cmp    %eax,%edx
  8006af:	77 93                	ja     800644 <_main+0x60c>
			byteArr[indicesOf3MB[var]] = maxByte ;
		}
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int found = 0;
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  8006b1:	ff 45 e4             	incl   -0x1c(%ebp)
  8006b4:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  8006b8:	7e 81                	jle    80063b <_main+0x603>
				{
					found++;
				}
			}
		}
		if (found != numOfAccessesFor3MB) panic("malloc: page is not added to WS");
  8006ba:	83 7d d8 07          	cmpl   $0x7,-0x28(%ebp)
  8006be:	74 14                	je     8006d4 <_main+0x69c>
  8006c0:	83 ec 04             	sub    $0x4,%esp
  8006c3:	68 38 34 80 00       	push   $0x803438
  8006c8:	6a 71                	push   $0x71
  8006ca:	68 01 33 80 00       	push   $0x803301
  8006cf:	e8 ac 0e 00 00       	call   801580 <_panic>

		/*access 8 MB*/// should bring 4 pages into WS (2 r, 2 w) and victimize 4 pages from 3 MB allocation
		freeFrames = sys_calculate_free_frames() ;
  8006d4:	e8 5e 24 00 00       	call   802b37 <sys_calculate_free_frames>
  8006d9:	89 45 8c             	mov    %eax,-0x74(%ebp)
		modFrames = sys_calculate_modified_frames();
  8006dc:	e8 6f 24 00 00       	call   802b50 <sys_calculate_modified_frames>
  8006e1:	89 45 88             	mov    %eax,-0x78(%ebp)
		lastIndexOfShort = (8*Mega-kilo)/sizeof(short) - 1;
  8006e4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e7:	c1 e0 03             	shl    $0x3,%eax
  8006ea:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8006ed:	d1 e8                	shr    %eax
  8006ef:	48                   	dec    %eax
  8006f0:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		indicesOf8MB[0] = lastIndexOfShort * 1 / 2;
  8006f6:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8006fc:	89 c2                	mov    %eax,%edx
  8006fe:	c1 ea 1f             	shr    $0x1f,%edx
  800701:	01 d0                	add    %edx,%eax
  800703:	d1 f8                	sar    %eax
  800705:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
		indicesOf8MB[1] = lastIndexOfShort * 2 / 3;
  80070b:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800711:	01 c0                	add    %eax,%eax
  800713:	89 c1                	mov    %eax,%ecx
  800715:	b8 56 55 55 55       	mov    $0x55555556,%eax
  80071a:	f7 e9                	imul   %ecx
  80071c:	c1 f9 1f             	sar    $0x1f,%ecx
  80071f:	89 d0                	mov    %edx,%eax
  800721:	29 c8                	sub    %ecx,%eax
  800723:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
		indicesOf8MB[2] = lastIndexOfShort * 3 / 4;
  800729:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80072f:	89 c2                	mov    %eax,%edx
  800731:	01 d2                	add    %edx,%edx
  800733:	01 d0                	add    %edx,%eax
  800735:	85 c0                	test   %eax,%eax
  800737:	79 03                	jns    80073c <_main+0x704>
  800739:	83 c0 03             	add    $0x3,%eax
  80073c:	c1 f8 02             	sar    $0x2,%eax
  80073f:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
		indicesOf8MB[3] = lastIndexOfShort ;
  800745:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80074b:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)

		//use one of the read pages from 3 MB to avoid victimizing it
		sum += byteArr[indicesOf3MB[0]] ;
  800751:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800757:	89 c2                	mov    %eax,%edx
  800759:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80075f:	01 d0                	add    %edx,%eax
  800761:	8a 00                	mov    (%eax),%al
  800763:	0f be c0             	movsbl %al,%eax
  800766:	01 45 dc             	add    %eax,-0x24(%ebp)

		shortArr = (short *) ptr_allocations[2];
  800769:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  80076f:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		//2 reads
		sum = 0;
  800775:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
  80077c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800783:	eb 20                	jmp    8007a5 <_main+0x76d>
		{
			sum += shortArr[indicesOf8MB[var]] ;
  800785:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800788:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  80078f:	01 c0                	add    %eax,%eax
  800791:	89 c2                	mov    %eax,%edx
  800793:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800799:	01 d0                	add    %edx,%eax
  80079b:	66 8b 00             	mov    (%eax),%ax
  80079e:	98                   	cwtl   
  80079f:	01 45 dc             	add    %eax,-0x24(%ebp)
		sum += byteArr[indicesOf3MB[0]] ;

		shortArr = (short *) ptr_allocations[2];
		//2 reads
		sum = 0;
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
  8007a2:	ff 45 e4             	incl   -0x1c(%ebp)
  8007a5:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  8007a9:	7e da                	jle    800785 <_main+0x74d>
		{
			sum += shortArr[indicesOf8MB[var]] ;
		}
		//2 writes
		for (var = numOfAccessesFor8MB/2; var < numOfAccessesFor8MB; ++var)
  8007ab:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
  8007b2:	eb 20                	jmp    8007d4 <_main+0x79c>
		{
			shortArr[indicesOf8MB[var]] = maxShort ;
  8007b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007b7:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  8007be:	01 c0                	add    %eax,%eax
  8007c0:	89 c2                	mov    %eax,%edx
  8007c2:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8007c8:	01 c2                	add    %eax,%edx
  8007ca:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  8007ce:	66 89 02             	mov    %ax,(%edx)
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
		{
			sum += shortArr[indicesOf8MB[var]] ;
		}
		//2 writes
		for (var = numOfAccessesFor8MB/2; var < numOfAccessesFor8MB; ++var)
  8007d1:	ff 45 e4             	incl   -0x1c(%ebp)
  8007d4:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8007d8:	7e da                	jle    8007b4 <_main+0x77c>
		{
			shortArr[indicesOf8MB[var]] = maxShort ;
		}
		//check memory & WS
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007da:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  8007dd:	e8 55 23 00 00       	call   802b37 <sys_calculate_free_frames>
  8007e2:	29 c3                	sub    %eax,%ebx
  8007e4:	89 d8                	mov    %ebx,%eax
  8007e6:	83 f8 04             	cmp    $0x4,%eax
  8007e9:	74 17                	je     800802 <_main+0x7ca>
  8007eb:	83 ec 04             	sub    $0x4,%esp
  8007ee:	68 f4 33 80 00       	push   $0x8033f4
  8007f3:	68 8c 00 00 00       	push   $0x8c
  8007f8:	68 01 33 80 00       	push   $0x803301
  8007fd:	e8 7e 0d 00 00       	call   801580 <_panic>
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800802:	8b 5d 88             	mov    -0x78(%ebp),%ebx
  800805:	e8 46 23 00 00       	call   802b50 <sys_calculate_modified_frames>
  80080a:	29 c3                	sub    %eax,%ebx
  80080c:	89 d8                	mov    %ebx,%eax
  80080e:	83 f8 fe             	cmp    $0xfffffffe,%eax
  800811:	74 17                	je     80082a <_main+0x7f2>
  800813:	83 ec 04             	sub    $0x4,%esp
  800816:	68 f4 33 80 00       	push   $0x8033f4
  80081b:	68 8d 00 00 00       	push   $0x8d
  800820:	68 01 33 80 00       	push   $0x803301
  800825:	e8 56 0d 00 00       	call   801580 <_panic>
		found = 0;
  80082a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
  800831:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800838:	eb 7b                	jmp    8008b5 <_main+0x87d>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  80083a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800841:	eb 60                	jmp    8008a3 <_main+0x86b>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[indicesOf8MB[var]])), PAGE_SIZE))
  800843:	a1 20 40 80 00       	mov    0x804020,%eax
  800848:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80084e:	8b 55 e0             	mov    -0x20(%ebp),%edx
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
  800872:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800875:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  80087c:	01 c0                	add    %eax,%eax
  80087e:	89 c1                	mov    %eax,%ecx
  800880:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800886:	01 c8                	add    %ecx,%eax
  800888:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  80088e:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800894:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800899:	39 c2                	cmp    %eax,%edx
  80089b:	75 03                	jne    8008a0 <_main+0x868>
				{
					found++;
  80089d:	ff 45 d8             	incl   -0x28(%ebp)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  8008a0:	ff 45 e0             	incl   -0x20(%ebp)
  8008a3:	a1 20 40 80 00       	mov    0x804020,%eax
  8008a8:	8b 50 74             	mov    0x74(%eax),%edx
  8008ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008ae:	39 c2                	cmp    %eax,%edx
  8008b0:	77 91                	ja     800843 <_main+0x80b>
		}
		//check memory & WS
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
  8008b2:	ff 45 e4             	incl   -0x1c(%ebp)
  8008b5:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8008b9:	0f 8e 7b ff ff ff    	jle    80083a <_main+0x802>
				{
					found++;
				}
			}
		}
		if (found != numOfAccessesFor8MB) panic("malloc: page is not added to WS");
  8008bf:	83 7d d8 04          	cmpl   $0x4,-0x28(%ebp)
  8008c3:	74 17                	je     8008dc <_main+0x8a4>
  8008c5:	83 ec 04             	sub    $0x4,%esp
  8008c8:	68 38 34 80 00       	push   $0x803438
  8008cd:	68 99 00 00 00       	push   $0x99
  8008d2:	68 01 33 80 00       	push   $0x803301
  8008d7:	e8 a4 0c 00 00       	call   801580 <_panic>

		/* Free 3 MB */// remove 3 pages from WS, 2 from free buffer, 2 from mod buffer and 2 tables
		freeFrames = sys_calculate_free_frames() ;
  8008dc:	e8 56 22 00 00       	call   802b37 <sys_calculate_free_frames>
  8008e1:	89 45 8c             	mov    %eax,-0x74(%ebp)
		modFrames = sys_calculate_modified_frames();
  8008e4:	e8 67 22 00 00       	call   802b50 <sys_calculate_modified_frames>
  8008e9:	89 45 88             	mov    %eax,-0x78(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008ec:	e8 c9 22 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  8008f1:	89 45 90             	mov    %eax,-0x70(%ebp)

		free(ptr_allocations[1]);
  8008f4:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  8008fa:	83 ec 0c             	sub    $0xc,%esp
  8008fd:	50                   	push   %eax
  8008fe:	e8 83 1f 00 00       	call   802886 <free>
  800903:	83 c4 10             	add    $0x10,%esp

		//check page file
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  800906:	e8 af 22 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  80090b:	8b 55 90             	mov    -0x70(%ebp),%edx
  80090e:	89 d1                	mov    %edx,%ecx
  800910:	29 c1                	sub    %eax,%ecx
  800912:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800915:	89 c2                	mov    %eax,%edx
  800917:	01 d2                	add    %edx,%edx
  800919:	01 d0                	add    %edx,%eax
  80091b:	85 c0                	test   %eax,%eax
  80091d:	79 05                	jns    800924 <_main+0x8ec>
  80091f:	05 ff 0f 00 00       	add    $0xfff,%eax
  800924:	c1 f8 0c             	sar    $0xc,%eax
  800927:	39 c1                	cmp    %eax,%ecx
  800929:	74 17                	je     800942 <_main+0x90a>
  80092b:	83 ec 04             	sub    $0x4,%esp
  80092e:	68 58 34 80 00       	push   $0x803458
  800933:	68 a3 00 00 00       	push   $0xa3
  800938:	68 01 33 80 00       	push   $0x803301
  80093d:	e8 3e 0c 00 00       	call   801580 <_panic>
		//check memory and buffers
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
  800942:	e8 f0 21 00 00       	call   802b37 <sys_calculate_free_frames>
  800947:	89 c2                	mov    %eax,%edx
  800949:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80094c:	29 c2                	sub    %eax,%edx
  80094e:	89 d0                	mov    %edx,%eax
  800950:	83 f8 07             	cmp    $0x7,%eax
  800953:	74 17                	je     80096c <_main+0x934>
  800955:	83 ec 04             	sub    $0x4,%esp
  800958:	68 94 34 80 00       	push   $0x803494
  80095d:	68 a5 00 00 00       	push   $0xa5
  800962:	68 01 33 80 00       	push   $0x803301
  800967:	e8 14 0c 00 00       	call   801580 <_panic>
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
  80096c:	e8 df 21 00 00       	call   802b50 <sys_calculate_modified_frames>
  800971:	89 c2                	mov    %eax,%edx
  800973:	8b 45 88             	mov    -0x78(%ebp),%eax
  800976:	29 c2                	sub    %eax,%edx
  800978:	89 d0                	mov    %edx,%eax
  80097a:	83 f8 02             	cmp    $0x2,%eax
  80097d:	74 17                	je     800996 <_main+0x95e>
  80097f:	83 ec 04             	sub    $0x4,%esp
  800982:	68 e8 34 80 00       	push   $0x8034e8
  800987:	68 a6 00 00 00       	push   $0xa6
  80098c:	68 01 33 80 00       	push   $0x803301
  800991:	e8 ea 0b 00 00       	call   801580 <_panic>
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  800996:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80099d:	e9 91 00 00 00       	jmp    800a33 <_main+0x9fb>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  8009a2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8009a9:	eb 72                	jmp    800a1d <_main+0x9e5>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[indicesOf3MB[var]])), PAGE_SIZE))
  8009ab:	a1 20 40 80 00       	mov    0x804020,%eax
  8009b0:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8009b6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009b9:	89 d0                	mov    %edx,%eax
  8009bb:	c1 e0 02             	shl    $0x2,%eax
  8009be:	01 d0                	add    %edx,%eax
  8009c0:	c1 e0 02             	shl    $0x2,%eax
  8009c3:	01 c8                	add    %ecx,%eax
  8009c5:	8b 00                	mov    (%eax),%eax
  8009c7:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  8009cd:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  8009d3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009d8:	89 c2                	mov    %eax,%edx
  8009da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009dd:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8009e4:	89 c1                	mov    %eax,%ecx
  8009e6:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8009ec:	01 c8                	add    %ecx,%eax
  8009ee:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  8009f4:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  8009fa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009ff:	39 c2                	cmp    %eax,%edx
  800a01:	75 17                	jne    800a1a <_main+0x9e2>
				{
					panic("free: page is not removed from WS");
  800a03:	83 ec 04             	sub    $0x4,%esp
  800a06:	68 20 35 80 00       	push   $0x803520
  800a0b:	68 ae 00 00 00       	push   $0xae
  800a10:	68 01 33 80 00       	push   $0x803301
  800a15:	e8 66 0b 00 00       	call   801580 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800a1a:	ff 45 e0             	incl   -0x20(%ebp)
  800a1d:	a1 20 40 80 00       	mov    0x804020,%eax
  800a22:	8b 50 74             	mov    0x74(%eax),%edx
  800a25:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a28:	39 c2                	cmp    %eax,%edx
  800a2a:	0f 87 7b ff ff ff    	ja     8009ab <_main+0x973>
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
		//check memory and buffers
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  800a30:	ff 45 e4             	incl   -0x1c(%ebp)
  800a33:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  800a37:	0f 8e 65 ff ff ff    	jle    8009a2 <_main+0x96a>
			}
		}



		freeFrames = sys_calculate_free_frames() ;
  800a3d:	e8 f5 20 00 00       	call   802b37 <sys_calculate_free_frames>
  800a42:	89 45 8c             	mov    %eax,-0x74(%ebp)
		shortArr = (short *) ptr_allocations[2];
  800a45:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800a4b:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  800a51:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a54:	01 c0                	add    %eax,%eax
  800a56:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800a59:	d1 e8                	shr    %eax
  800a5b:	48                   	dec    %eax
  800a5c:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		shortArr[0] = minShort;
  800a62:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
  800a68:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800a6b:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800a6e:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800a74:	01 c0                	add    %eax,%eax
  800a76:	89 c2                	mov    %eax,%edx
  800a78:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800a7e:	01 c2                	add    %eax,%edx
  800a80:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  800a84:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800a87:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  800a8a:	e8 a8 20 00 00       	call   802b37 <sys_calculate_free_frames>
  800a8f:	29 c3                	sub    %eax,%ebx
  800a91:	89 d8                	mov    %ebx,%eax
  800a93:	83 f8 02             	cmp    $0x2,%eax
  800a96:	74 17                	je     800aaf <_main+0xa77>
  800a98:	83 ec 04             	sub    $0x4,%esp
  800a9b:	68 f4 33 80 00       	push   $0x8033f4
  800aa0:	68 ba 00 00 00       	push   $0xba
  800aa5:	68 01 33 80 00       	push   $0x803301
  800aaa:	e8 d1 0a 00 00       	call   801580 <_panic>
		found = 0;
  800aaf:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800ab6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800abd:	e9 a9 00 00 00       	jmp    800b6b <_main+0xb33>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  800ac2:	a1 20 40 80 00       	mov    0x804020,%eax
  800ac7:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800acd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ad0:	89 d0                	mov    %edx,%eax
  800ad2:	c1 e0 02             	shl    $0x2,%eax
  800ad5:	01 d0                	add    %edx,%eax
  800ad7:	c1 e0 02             	shl    $0x2,%eax
  800ada:	01 c8                	add    %ecx,%eax
  800adc:	8b 00                	mov    (%eax),%eax
  800ade:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  800ae4:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800aea:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800aef:	89 c2                	mov    %eax,%edx
  800af1:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800af7:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800afd:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b03:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b08:	39 c2                	cmp    %eax,%edx
  800b0a:	75 03                	jne    800b0f <_main+0xad7>
				found++;
  800b0c:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  800b0f:	a1 20 40 80 00       	mov    0x804020,%eax
  800b14:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800b1a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800b1d:	89 d0                	mov    %edx,%eax
  800b1f:	c1 e0 02             	shl    $0x2,%eax
  800b22:	01 d0                	add    %edx,%eax
  800b24:	c1 e0 02             	shl    $0x2,%eax
  800b27:	01 c8                	add    %ecx,%eax
  800b29:	8b 00                	mov    (%eax),%eax
  800b2b:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b31:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b37:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b3c:	89 c2                	mov    %eax,%edx
  800b3e:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800b44:	01 c0                	add    %eax,%eax
  800b46:	89 c1                	mov    %eax,%ecx
  800b48:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800b4e:	01 c8                	add    %ecx,%eax
  800b50:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b56:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b5c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b61:	39 c2                	cmp    %eax,%edx
  800b63:	75 03                	jne    800b68 <_main+0xb30>
				found++;
  800b65:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
		shortArr[0] = minShort;
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800b68:	ff 45 e4             	incl   -0x1c(%ebp)
  800b6b:	a1 20 40 80 00       	mov    0x804020,%eax
  800b70:	8b 50 74             	mov    0x74(%eax),%edx
  800b73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b76:	39 c2                	cmp    %eax,%edx
  800b78:	0f 87 44 ff ff ff    	ja     800ac2 <_main+0xa8a>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800b7e:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  800b82:	74 17                	je     800b9b <_main+0xb63>
  800b84:	83 ec 04             	sub    $0x4,%esp
  800b87:	68 38 34 80 00       	push   $0x803438
  800b8c:	68 c3 00 00 00       	push   $0xc3
  800b91:	68 01 33 80 00       	push   $0x803301
  800b96:	e8 e5 09 00 00       	call   801580 <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800b9b:	e8 1a 20 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800ba0:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800ba3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800ba6:	01 c0                	add    %eax,%eax
  800ba8:	83 ec 0c             	sub    $0xc,%esp
  800bab:	50                   	push   %eax
  800bac:	e8 10 1a 00 00       	call   8025c1 <malloc>
  800bb1:	83 c4 10             	add    $0x10,%esp
  800bb4:	89 85 88 fe ff ff    	mov    %eax,-0x178(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800bba:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800bc0:	89 c2                	mov    %eax,%edx
  800bc2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800bc5:	c1 e0 02             	shl    $0x2,%eax
  800bc8:	05 00 00 00 80       	add    $0x80000000,%eax
  800bcd:	39 c2                	cmp    %eax,%edx
  800bcf:	72 17                	jb     800be8 <_main+0xbb0>
  800bd1:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800bd7:	89 c2                	mov    %eax,%edx
  800bd9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800bdc:	c1 e0 02             	shl    $0x2,%eax
  800bdf:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800be4:	39 c2                	cmp    %eax,%edx
  800be6:	76 17                	jbe    800bff <_main+0xbc7>
  800be8:	83 ec 04             	sub    $0x4,%esp
  800beb:	68 5c 33 80 00       	push   $0x80335c
  800bf0:	68 c8 00 00 00       	push   $0xc8
  800bf5:	68 01 33 80 00       	push   $0x803301
  800bfa:	e8 81 09 00 00       	call   801580 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800bff:	e8 b6 1f 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800c04:	2b 45 90             	sub    -0x70(%ebp),%eax
  800c07:	83 f8 01             	cmp    $0x1,%eax
  800c0a:	74 17                	je     800c23 <_main+0xbeb>
  800c0c:	83 ec 04             	sub    $0x4,%esp
  800c0f:	68 c4 33 80 00       	push   $0x8033c4
  800c14:	68 c9 00 00 00       	push   $0xc9
  800c19:	68 01 33 80 00       	push   $0x803301
  800c1e:	e8 5d 09 00 00       	call   801580 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800c23:	e8 0f 1f 00 00       	call   802b37 <sys_calculate_free_frames>
  800c28:	89 45 8c             	mov    %eax,-0x74(%ebp)
		intArr = (int *) ptr_allocations[2];
  800c2b:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800c31:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  800c37:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800c3a:	01 c0                	add    %eax,%eax
  800c3c:	c1 e8 02             	shr    $0x2,%eax
  800c3f:	48                   	dec    %eax
  800c40:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
		intArr[0] = minInt;
  800c46:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800c4c:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  800c4f:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  800c51:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800c57:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800c5e:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800c64:	01 c2                	add    %eax,%edx
  800c66:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800c69:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800c6b:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  800c6e:	e8 c4 1e 00 00       	call   802b37 <sys_calculate_free_frames>
  800c73:	29 c3                	sub    %eax,%ebx
  800c75:	89 d8                	mov    %ebx,%eax
  800c77:	83 f8 02             	cmp    $0x2,%eax
  800c7a:	74 17                	je     800c93 <_main+0xc5b>
  800c7c:	83 ec 04             	sub    $0x4,%esp
  800c7f:	68 f4 33 80 00       	push   $0x8033f4
  800c84:	68 d0 00 00 00       	push   $0xd0
  800c89:	68 01 33 80 00       	push   $0x803301
  800c8e:	e8 ed 08 00 00       	call   801580 <_panic>
		found = 0;
  800c93:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800c9a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800ca1:	e9 ac 00 00 00       	jmp    800d52 <_main+0xd1a>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  800ca6:	a1 20 40 80 00       	mov    0x804020,%eax
  800cab:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800cb1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800cb4:	89 d0                	mov    %edx,%eax
  800cb6:	c1 e0 02             	shl    $0x2,%eax
  800cb9:	01 d0                	add    %edx,%eax
  800cbb:	c1 e0 02             	shl    $0x2,%eax
  800cbe:	01 c8                	add    %ecx,%eax
  800cc0:	8b 00                	mov    (%eax),%eax
  800cc2:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800cc8:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800cce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800cd3:	89 c2                	mov    %eax,%edx
  800cd5:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800cdb:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
  800ce1:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800ce7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800cec:	39 c2                	cmp    %eax,%edx
  800cee:	75 03                	jne    800cf3 <_main+0xcbb>
				found++;
  800cf0:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  800cf3:	a1 20 40 80 00       	mov    0x804020,%eax
  800cf8:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800cfe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800d01:	89 d0                	mov    %edx,%eax
  800d03:	c1 e0 02             	shl    $0x2,%eax
  800d06:	01 d0                	add    %edx,%eax
  800d08:	c1 e0 02             	shl    $0x2,%eax
  800d0b:	01 c8                	add    %ecx,%eax
  800d0d:	8b 00                	mov    (%eax),%eax
  800d0f:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
  800d15:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d1b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d20:	89 c2                	mov    %eax,%edx
  800d22:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800d28:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800d2f:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800d35:	01 c8                	add    %ecx,%eax
  800d37:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800d3d:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800d43:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d48:	39 c2                	cmp    %eax,%edx
  800d4a:	75 03                	jne    800d4f <_main+0xd17>
				found++;
  800d4c:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d4f:	ff 45 e4             	incl   -0x1c(%ebp)
  800d52:	a1 20 40 80 00       	mov    0x804020,%eax
  800d57:	8b 50 74             	mov    0x74(%eax),%edx
  800d5a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800d5d:	39 c2                	cmp    %eax,%edx
  800d5f:	0f 87 41 ff ff ff    	ja     800ca6 <_main+0xc6e>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800d65:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  800d69:	74 17                	je     800d82 <_main+0xd4a>
  800d6b:	83 ec 04             	sub    $0x4,%esp
  800d6e:	68 38 34 80 00       	push   $0x803438
  800d73:	68 d9 00 00 00       	push   $0xd9
  800d78:	68 01 33 80 00       	push   $0x803301
  800d7d:	e8 fe 07 00 00       	call   801580 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  800d82:	e8 b0 1d 00 00       	call   802b37 <sys_calculate_free_frames>
  800d87:	89 45 8c             	mov    %eax,-0x74(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800d8a:	e8 2b 1e 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800d8f:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  800d92:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d95:	01 c0                	add    %eax,%eax
  800d97:	83 ec 0c             	sub    $0xc,%esp
  800d9a:	50                   	push   %eax
  800d9b:	e8 21 18 00 00       	call   8025c1 <malloc>
  800da0:	83 c4 10             	add    $0x10,%esp
  800da3:	89 85 8c fe ff ff    	mov    %eax,-0x174(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800da9:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  800daf:	89 c2                	mov    %eax,%edx
  800db1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800db4:	c1 e0 02             	shl    $0x2,%eax
  800db7:	89 c1                	mov    %eax,%ecx
  800db9:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800dbc:	c1 e0 02             	shl    $0x2,%eax
  800dbf:	01 c8                	add    %ecx,%eax
  800dc1:	05 00 00 00 80       	add    $0x80000000,%eax
  800dc6:	39 c2                	cmp    %eax,%edx
  800dc8:	72 21                	jb     800deb <_main+0xdb3>
  800dca:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  800dd0:	89 c2                	mov    %eax,%edx
  800dd2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800dd5:	c1 e0 02             	shl    $0x2,%eax
  800dd8:	89 c1                	mov    %eax,%ecx
  800dda:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800ddd:	c1 e0 02             	shl    $0x2,%eax
  800de0:	01 c8                	add    %ecx,%eax
  800de2:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800de7:	39 c2                	cmp    %eax,%edx
  800de9:	76 17                	jbe    800e02 <_main+0xdca>
  800deb:	83 ec 04             	sub    $0x4,%esp
  800dee:	68 5c 33 80 00       	push   $0x80335c
  800df3:	68 df 00 00 00       	push   $0xdf
  800df8:	68 01 33 80 00       	push   $0x803301
  800dfd:	e8 7e 07 00 00       	call   801580 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800e02:	e8 b3 1d 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800e07:	2b 45 90             	sub    -0x70(%ebp),%eax
  800e0a:	83 f8 01             	cmp    $0x1,%eax
  800e0d:	74 17                	je     800e26 <_main+0xdee>
  800e0f:	83 ec 04             	sub    $0x4,%esp
  800e12:	68 c4 33 80 00       	push   $0x8033c4
  800e17:	68 e0 00 00 00       	push   $0xe0
  800e1c:	68 01 33 80 00       	push   $0x803301
  800e21:	e8 5a 07 00 00       	call   801580 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e26:	e8 8f 1d 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800e2b:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800e2e:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800e31:	89 d0                	mov    %edx,%eax
  800e33:	01 c0                	add    %eax,%eax
  800e35:	01 d0                	add    %edx,%eax
  800e37:	01 c0                	add    %eax,%eax
  800e39:	01 d0                	add    %edx,%eax
  800e3b:	83 ec 0c             	sub    $0xc,%esp
  800e3e:	50                   	push   %eax
  800e3f:	e8 7d 17 00 00       	call   8025c1 <malloc>
  800e44:	83 c4 10             	add    $0x10,%esp
  800e47:	89 85 90 fe ff ff    	mov    %eax,-0x170(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800e4d:	8b 85 90 fe ff ff    	mov    -0x170(%ebp),%eax
  800e53:	89 c2                	mov    %eax,%edx
  800e55:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800e58:	c1 e0 02             	shl    $0x2,%eax
  800e5b:	89 c1                	mov    %eax,%ecx
  800e5d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e60:	c1 e0 03             	shl    $0x3,%eax
  800e63:	01 c8                	add    %ecx,%eax
  800e65:	05 00 00 00 80       	add    $0x80000000,%eax
  800e6a:	39 c2                	cmp    %eax,%edx
  800e6c:	72 21                	jb     800e8f <_main+0xe57>
  800e6e:	8b 85 90 fe ff ff    	mov    -0x170(%ebp),%eax
  800e74:	89 c2                	mov    %eax,%edx
  800e76:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800e79:	c1 e0 02             	shl    $0x2,%eax
  800e7c:	89 c1                	mov    %eax,%ecx
  800e7e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e81:	c1 e0 03             	shl    $0x3,%eax
  800e84:	01 c8                	add    %ecx,%eax
  800e86:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800e8b:	39 c2                	cmp    %eax,%edx
  800e8d:	76 17                	jbe    800ea6 <_main+0xe6e>
  800e8f:	83 ec 04             	sub    $0x4,%esp
  800e92:	68 5c 33 80 00       	push   $0x80335c
  800e97:	68 e6 00 00 00       	push   $0xe6
  800e9c:	68 01 33 80 00       	push   $0x803301
  800ea1:	e8 da 06 00 00       	call   801580 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  800ea6:	e8 0f 1d 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800eab:	2b 45 90             	sub    -0x70(%ebp),%eax
  800eae:	83 f8 02             	cmp    $0x2,%eax
  800eb1:	74 17                	je     800eca <_main+0xe92>
  800eb3:	83 ec 04             	sub    $0x4,%esp
  800eb6:	68 c4 33 80 00       	push   $0x8033c4
  800ebb:	68 e7 00 00 00       	push   $0xe7
  800ec0:	68 01 33 80 00       	push   $0x803301
  800ec5:	e8 b6 06 00 00       	call   801580 <_panic>


		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  800eca:	e8 68 1c 00 00       	call   802b37 <sys_calculate_free_frames>
  800ecf:	89 45 8c             	mov    %eax,-0x74(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800ed2:	e8 e3 1c 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800ed7:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800eda:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800edd:	89 c2                	mov    %eax,%edx
  800edf:	01 d2                	add    %edx,%edx
  800ee1:	01 d0                	add    %edx,%eax
  800ee3:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800ee6:	83 ec 0c             	sub    $0xc,%esp
  800ee9:	50                   	push   %eax
  800eea:	e8 d2 16 00 00       	call   8025c1 <malloc>
  800eef:	83 c4 10             	add    $0x10,%esp
  800ef2:	89 85 94 fe ff ff    	mov    %eax,-0x16c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800ef8:	8b 85 94 fe ff ff    	mov    -0x16c(%ebp),%eax
  800efe:	89 c2                	mov    %eax,%edx
  800f00:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800f03:	c1 e0 02             	shl    $0x2,%eax
  800f06:	89 c1                	mov    %eax,%ecx
  800f08:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800f0b:	c1 e0 04             	shl    $0x4,%eax
  800f0e:	01 c8                	add    %ecx,%eax
  800f10:	05 00 00 00 80       	add    $0x80000000,%eax
  800f15:	39 c2                	cmp    %eax,%edx
  800f17:	72 21                	jb     800f3a <_main+0xf02>
  800f19:	8b 85 94 fe ff ff    	mov    -0x16c(%ebp),%eax
  800f1f:	89 c2                	mov    %eax,%edx
  800f21:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800f24:	c1 e0 02             	shl    $0x2,%eax
  800f27:	89 c1                	mov    %eax,%ecx
  800f29:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800f2c:	c1 e0 04             	shl    $0x4,%eax
  800f2f:	01 c8                	add    %ecx,%eax
  800f31:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800f36:	39 c2                	cmp    %eax,%edx
  800f38:	76 17                	jbe    800f51 <_main+0xf19>
  800f3a:	83 ec 04             	sub    $0x4,%esp
  800f3d:	68 5c 33 80 00       	push   $0x80335c
  800f42:	68 ee 00 00 00       	push   $0xee
  800f47:	68 01 33 80 00       	push   $0x803301
  800f4c:	e8 2f 06 00 00       	call   801580 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800f51:	e8 64 1c 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800f56:	2b 45 90             	sub    -0x70(%ebp),%eax
  800f59:	89 c2                	mov    %eax,%edx
  800f5b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800f5e:	89 c1                	mov    %eax,%ecx
  800f60:	01 c9                	add    %ecx,%ecx
  800f62:	01 c8                	add    %ecx,%eax
  800f64:	85 c0                	test   %eax,%eax
  800f66:	79 05                	jns    800f6d <_main+0xf35>
  800f68:	05 ff 0f 00 00       	add    $0xfff,%eax
  800f6d:	c1 f8 0c             	sar    $0xc,%eax
  800f70:	39 c2                	cmp    %eax,%edx
  800f72:	74 17                	je     800f8b <_main+0xf53>
  800f74:	83 ec 04             	sub    $0x4,%esp
  800f77:	68 c4 33 80 00       	push   $0x8033c4
  800f7c:	68 ef 00 00 00       	push   $0xef
  800f81:	68 01 33 80 00       	push   $0x803301
  800f86:	e8 f5 05 00 00       	call   801580 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800f8b:	e8 2a 1c 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  800f90:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  800f93:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800f96:	89 d0                	mov    %edx,%eax
  800f98:	01 c0                	add    %eax,%eax
  800f9a:	01 d0                	add    %edx,%eax
  800f9c:	01 c0                	add    %eax,%eax
  800f9e:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800fa1:	83 ec 0c             	sub    $0xc,%esp
  800fa4:	50                   	push   %eax
  800fa5:	e8 17 16 00 00       	call   8025c1 <malloc>
  800faa:	83 c4 10             	add    $0x10,%esp
  800fad:	89 85 98 fe ff ff    	mov    %eax,-0x168(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800fb3:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  800fb9:	89 c1                	mov    %eax,%ecx
  800fbb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800fbe:	89 d0                	mov    %edx,%eax
  800fc0:	01 c0                	add    %eax,%eax
  800fc2:	01 d0                	add    %edx,%eax
  800fc4:	01 c0                	add    %eax,%eax
  800fc6:	01 d0                	add    %edx,%eax
  800fc8:	89 c2                	mov    %eax,%edx
  800fca:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fcd:	c1 e0 04             	shl    $0x4,%eax
  800fd0:	01 d0                	add    %edx,%eax
  800fd2:	05 00 00 00 80       	add    $0x80000000,%eax
  800fd7:	39 c1                	cmp    %eax,%ecx
  800fd9:	72 28                	jb     801003 <_main+0xfcb>
  800fdb:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  800fe1:	89 c1                	mov    %eax,%ecx
  800fe3:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800fe6:	89 d0                	mov    %edx,%eax
  800fe8:	01 c0                	add    %eax,%eax
  800fea:	01 d0                	add    %edx,%eax
  800fec:	01 c0                	add    %eax,%eax
  800fee:	01 d0                	add    %edx,%eax
  800ff0:	89 c2                	mov    %eax,%edx
  800ff2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800ff5:	c1 e0 04             	shl    $0x4,%eax
  800ff8:	01 d0                	add    %edx,%eax
  800ffa:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800fff:	39 c1                	cmp    %eax,%ecx
  801001:	76 17                	jbe    80101a <_main+0xfe2>
  801003:	83 ec 04             	sub    $0x4,%esp
  801006:	68 5c 33 80 00       	push   $0x80335c
  80100b:	68 f5 00 00 00       	push   $0xf5
  801010:	68 01 33 80 00       	push   $0x803301
  801015:	e8 66 05 00 00       	call   801580 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  80101a:	e8 9b 1b 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  80101f:	2b 45 90             	sub    -0x70(%ebp),%eax
  801022:	89 c1                	mov    %eax,%ecx
  801024:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801027:	89 d0                	mov    %edx,%eax
  801029:	01 c0                	add    %eax,%eax
  80102b:	01 d0                	add    %edx,%eax
  80102d:	01 c0                	add    %eax,%eax
  80102f:	85 c0                	test   %eax,%eax
  801031:	79 05                	jns    801038 <_main+0x1000>
  801033:	05 ff 0f 00 00       	add    $0xfff,%eax
  801038:	c1 f8 0c             	sar    $0xc,%eax
  80103b:	39 c1                	cmp    %eax,%ecx
  80103d:	74 17                	je     801056 <_main+0x101e>
  80103f:	83 ec 04             	sub    $0x4,%esp
  801042:	68 c4 33 80 00       	push   $0x8033c4
  801047:	68 f6 00 00 00       	push   $0xf6
  80104c:	68 01 33 80 00       	push   $0x803301
  801051:	e8 2a 05 00 00       	call   801580 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  801056:	e8 dc 1a 00 00       	call   802b37 <sys_calculate_free_frames>
  80105b:	89 45 8c             	mov    %eax,-0x74(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  80105e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801061:	89 d0                	mov    %edx,%eax
  801063:	01 c0                	add    %eax,%eax
  801065:	01 d0                	add    %edx,%eax
  801067:	01 c0                	add    %eax,%eax
  801069:	2b 45 d0             	sub    -0x30(%ebp),%eax
  80106c:	48                   	dec    %eax
  80106d:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  801073:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  801079:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		byteArr2[0] = minByte ;
  80107f:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801085:	8a 55 cf             	mov    -0x31(%ebp),%dl
  801088:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  80108a:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  801090:	89 c2                	mov    %eax,%edx
  801092:	c1 ea 1f             	shr    $0x1f,%edx
  801095:	01 d0                	add    %edx,%eax
  801097:	d1 f8                	sar    %eax
  801099:	89 c2                	mov    %eax,%edx
  80109b:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  8010a1:	01 c2                	add    %eax,%edx
  8010a3:	8a 45 ce             	mov    -0x32(%ebp),%al
  8010a6:	88 c1                	mov    %al,%cl
  8010a8:	c0 e9 07             	shr    $0x7,%cl
  8010ab:	01 c8                	add    %ecx,%eax
  8010ad:	d0 f8                	sar    %al
  8010af:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  8010b1:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
  8010b7:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  8010bd:	01 c2                	add    %eax,%edx
  8010bf:	8a 45 ce             	mov    -0x32(%ebp),%al
  8010c2:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8010c4:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  8010c7:	e8 6b 1a 00 00       	call   802b37 <sys_calculate_free_frames>
  8010cc:	29 c3                	sub    %eax,%ebx
  8010ce:	89 d8                	mov    %ebx,%eax
  8010d0:	83 f8 05             	cmp    $0x5,%eax
  8010d3:	74 17                	je     8010ec <_main+0x10b4>
  8010d5:	83 ec 04             	sub    $0x4,%esp
  8010d8:	68 f4 33 80 00       	push   $0x8033f4
  8010dd:	68 fe 00 00 00       	push   $0xfe
  8010e2:	68 01 33 80 00       	push   $0x803301
  8010e7:	e8 94 04 00 00       	call   801580 <_panic>
		found = 0;
  8010ec:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8010f3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8010fa:	e9 05 01 00 00       	jmp    801204 <_main+0x11cc>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  8010ff:	a1 20 40 80 00       	mov    0x804020,%eax
  801104:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80110a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80110d:	89 d0                	mov    %edx,%eax
  80110f:	c1 e0 02             	shl    $0x2,%eax
  801112:	01 d0                	add    %edx,%eax
  801114:	c1 e0 02             	shl    $0x2,%eax
  801117:	01 c8                	add    %ecx,%eax
  801119:	8b 00                	mov    (%eax),%eax
  80111b:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  801121:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  801127:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80112c:	89 c2                	mov    %eax,%edx
  80112e:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801134:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
  80113a:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  801140:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801145:	39 c2                	cmp    %eax,%edx
  801147:	75 03                	jne    80114c <_main+0x1114>
				found++;
  801149:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  80114c:	a1 20 40 80 00       	mov    0x804020,%eax
  801151:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801157:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80115a:	89 d0                	mov    %edx,%eax
  80115c:	c1 e0 02             	shl    $0x2,%eax
  80115f:	01 d0                	add    %edx,%eax
  801161:	c1 e0 02             	shl    $0x2,%eax
  801164:	01 c8                	add    %ecx,%eax
  801166:	8b 00                	mov    (%eax),%eax
  801168:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
  80116e:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801174:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801179:	89 c2                	mov    %eax,%edx
  80117b:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  801181:	89 c1                	mov    %eax,%ecx
  801183:	c1 e9 1f             	shr    $0x1f,%ecx
  801186:	01 c8                	add    %ecx,%eax
  801188:	d1 f8                	sar    %eax
  80118a:	89 c1                	mov    %eax,%ecx
  80118c:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801192:	01 c8                	add    %ecx,%eax
  801194:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
  80119a:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  8011a0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8011a5:	39 c2                	cmp    %eax,%edx
  8011a7:	75 03                	jne    8011ac <_main+0x1174>
				found++;
  8011a9:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  8011ac:	a1 20 40 80 00       	mov    0x804020,%eax
  8011b1:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8011b7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8011ba:	89 d0                	mov    %edx,%eax
  8011bc:	c1 e0 02             	shl    $0x2,%eax
  8011bf:	01 d0                	add    %edx,%eax
  8011c1:	c1 e0 02             	shl    $0x2,%eax
  8011c4:	01 c8                	add    %ecx,%eax
  8011c6:	8b 00                	mov    (%eax),%eax
  8011c8:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  8011ce:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  8011d4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8011d9:	89 c1                	mov    %eax,%ecx
  8011db:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
  8011e1:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  8011e7:	01 d0                	add    %edx,%eax
  8011e9:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  8011ef:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  8011f5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8011fa:	39 c1                	cmp    %eax,%ecx
  8011fc:	75 03                	jne    801201 <_main+0x11c9>
				found++;
  8011fe:	ff 45 d8             	incl   -0x28(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801201:	ff 45 e4             	incl   -0x1c(%ebp)
  801204:	a1 20 40 80 00       	mov    0x804020,%eax
  801209:	8b 50 74             	mov    0x74(%eax),%edx
  80120c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80120f:	39 c2                	cmp    %eax,%edx
  801211:	0f 87 e8 fe ff ff    	ja     8010ff <_main+0x10c7>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  801217:	83 7d d8 03          	cmpl   $0x3,-0x28(%ebp)
  80121b:	74 17                	je     801234 <_main+0x11fc>
  80121d:	83 ec 04             	sub    $0x4,%esp
  801220:	68 38 34 80 00       	push   $0x803438
  801225:	68 09 01 00 00       	push   $0x109
  80122a:	68 01 33 80 00       	push   $0x803301
  80122f:	e8 4c 03 00 00       	call   801580 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801234:	e8 81 19 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  801239:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  80123c:	8b 55 d0             	mov    -0x30(%ebp),%edx
  80123f:	89 d0                	mov    %edx,%eax
  801241:	01 c0                	add    %eax,%eax
  801243:	01 d0                	add    %edx,%eax
  801245:	01 c0                	add    %eax,%eax
  801247:	01 d0                	add    %edx,%eax
  801249:	01 c0                	add    %eax,%eax
  80124b:	83 ec 0c             	sub    $0xc,%esp
  80124e:	50                   	push   %eax
  80124f:	e8 6d 13 00 00       	call   8025c1 <malloc>
  801254:	83 c4 10             	add    $0x10,%esp
  801257:	89 85 9c fe ff ff    	mov    %eax,-0x164(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80125d:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  801263:	89 c1                	mov    %eax,%ecx
  801265:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801268:	89 d0                	mov    %edx,%eax
  80126a:	01 c0                	add    %eax,%eax
  80126c:	01 d0                	add    %edx,%eax
  80126e:	c1 e0 02             	shl    $0x2,%eax
  801271:	01 d0                	add    %edx,%eax
  801273:	89 c2                	mov    %eax,%edx
  801275:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801278:	c1 e0 04             	shl    $0x4,%eax
  80127b:	01 d0                	add    %edx,%eax
  80127d:	05 00 00 00 80       	add    $0x80000000,%eax
  801282:	39 c1                	cmp    %eax,%ecx
  801284:	72 29                	jb     8012af <_main+0x1277>
  801286:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  80128c:	89 c1                	mov    %eax,%ecx
  80128e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801291:	89 d0                	mov    %edx,%eax
  801293:	01 c0                	add    %eax,%eax
  801295:	01 d0                	add    %edx,%eax
  801297:	c1 e0 02             	shl    $0x2,%eax
  80129a:	01 d0                	add    %edx,%eax
  80129c:	89 c2                	mov    %eax,%edx
  80129e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8012a1:	c1 e0 04             	shl    $0x4,%eax
  8012a4:	01 d0                	add    %edx,%eax
  8012a6:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8012ab:	39 c1                	cmp    %eax,%ecx
  8012ad:	76 17                	jbe    8012c6 <_main+0x128e>
  8012af:	83 ec 04             	sub    $0x4,%esp
  8012b2:	68 5c 33 80 00       	push   $0x80335c
  8012b7:	68 0e 01 00 00       	push   $0x10e
  8012bc:	68 01 33 80 00       	push   $0x803301
  8012c1:	e8 ba 02 00 00       	call   801580 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  8012c6:	e8 ef 18 00 00       	call   802bba <sys_pf_calculate_allocated_pages>
  8012cb:	2b 45 90             	sub    -0x70(%ebp),%eax
  8012ce:	83 f8 04             	cmp    $0x4,%eax
  8012d1:	74 17                	je     8012ea <_main+0x12b2>
  8012d3:	83 ec 04             	sub    $0x4,%esp
  8012d6:	68 c4 33 80 00       	push   $0x8033c4
  8012db:	68 0f 01 00 00       	push   $0x10f
  8012e0:	68 01 33 80 00       	push   $0x803301
  8012e5:	e8 96 02 00 00       	call   801580 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8012ea:	e8 48 18 00 00       	call   802b37 <sys_calculate_free_frames>
  8012ef:	89 45 8c             	mov    %eax,-0x74(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  8012f2:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  8012f8:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  8012fe:	8b 55 d0             	mov    -0x30(%ebp),%edx
  801301:	89 d0                	mov    %edx,%eax
  801303:	01 c0                	add    %eax,%eax
  801305:	01 d0                	add    %edx,%eax
  801307:	01 c0                	add    %eax,%eax
  801309:	01 d0                	add    %edx,%eax
  80130b:	01 c0                	add    %eax,%eax
  80130d:	d1 e8                	shr    %eax
  80130f:	48                   	dec    %eax
  801310:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
		shortArr2[0] = minShort;
  801316:	8b 95 10 ff ff ff    	mov    -0xf0(%ebp),%edx
  80131c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80131f:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  801322:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  801328:	01 c0                	add    %eax,%eax
  80132a:	89 c2                	mov    %eax,%edx
  80132c:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  801332:	01 c2                	add    %eax,%edx
  801334:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  801338:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  80133b:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  80133e:	e8 f4 17 00 00       	call   802b37 <sys_calculate_free_frames>
  801343:	29 c3                	sub    %eax,%ebx
  801345:	89 d8                	mov    %ebx,%eax
  801347:	83 f8 02             	cmp    $0x2,%eax
  80134a:	74 17                	je     801363 <_main+0x132b>
  80134c:	83 ec 04             	sub    $0x4,%esp
  80134f:	68 f4 33 80 00       	push   $0x8033f4
  801354:	68 16 01 00 00       	push   $0x116
  801359:	68 01 33 80 00       	push   $0x803301
  80135e:	e8 1d 02 00 00       	call   801580 <_panic>
		found = 0;
  801363:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80136a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801371:	e9 a9 00 00 00       	jmp    80141f <_main+0x13e7>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  801376:	a1 20 40 80 00       	mov    0x804020,%eax
  80137b:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801381:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801384:	89 d0                	mov    %edx,%eax
  801386:	c1 e0 02             	shl    $0x2,%eax
  801389:	01 d0                	add    %edx,%eax
  80138b:	c1 e0 02             	shl    $0x2,%eax
  80138e:	01 c8                	add    %ecx,%eax
  801390:	8b 00                	mov    (%eax),%eax
  801392:	89 85 08 ff ff ff    	mov    %eax,-0xf8(%ebp)
  801398:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
  80139e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013a3:	89 c2                	mov    %eax,%edx
  8013a5:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  8013ab:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  8013b1:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
  8013b7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013bc:	39 c2                	cmp    %eax,%edx
  8013be:	75 03                	jne    8013c3 <_main+0x138b>
				found++;
  8013c0:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  8013c3:	a1 20 40 80 00       	mov    0x804020,%eax
  8013c8:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8013ce:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8013d1:	89 d0                	mov    %edx,%eax
  8013d3:	c1 e0 02             	shl    $0x2,%eax
  8013d6:	01 d0                	add    %edx,%eax
  8013d8:	c1 e0 02             	shl    $0x2,%eax
  8013db:	01 c8                	add    %ecx,%eax
  8013dd:	8b 00                	mov    (%eax),%eax
  8013df:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  8013e5:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
  8013eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013f0:	89 c2                	mov    %eax,%edx
  8013f2:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  8013f8:	01 c0                	add    %eax,%eax
  8013fa:	89 c1                	mov    %eax,%ecx
  8013fc:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  801402:	01 c8                	add    %ecx,%eax
  801404:	89 85 fc fe ff ff    	mov    %eax,-0x104(%ebp)
  80140a:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
  801410:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801415:	39 c2                	cmp    %eax,%edx
  801417:	75 03                	jne    80141c <_main+0x13e4>
				found++;
  801419:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80141c:	ff 45 e4             	incl   -0x1c(%ebp)
  80141f:	a1 20 40 80 00       	mov    0x804020,%eax
  801424:	8b 50 74             	mov    0x74(%eax),%edx
  801427:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80142a:	39 c2                	cmp    %eax,%edx
  80142c:	0f 87 44 ff ff ff    	ja     801376 <_main+0x133e>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  801432:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  801436:	74 17                	je     80144f <_main+0x1417>
  801438:	83 ec 04             	sub    $0x4,%esp
  80143b:	68 38 34 80 00       	push   $0x803438
  801440:	68 1f 01 00 00       	push   $0x11f
  801445:	68 01 33 80 00       	push   $0x803301
  80144a:	e8 31 01 00 00       	call   801580 <_panic>
		if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
	}

	cprintf("Congratulations!! test free [1] completed successfully.\n");
*/
	return;
  80144f:	90                   	nop
}
  801450:	8d 65 f4             	lea    -0xc(%ebp),%esp
  801453:	5b                   	pop    %ebx
  801454:	5e                   	pop    %esi
  801455:	5f                   	pop    %edi
  801456:	5d                   	pop    %ebp
  801457:	c3                   	ret    

00801458 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  801458:	55                   	push   %ebp
  801459:	89 e5                	mov    %esp,%ebp
  80145b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80145e:	e8 09 16 00 00       	call   802a6c <sys_getenvindex>
  801463:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  801466:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801469:	89 d0                	mov    %edx,%eax
  80146b:	01 c0                	add    %eax,%eax
  80146d:	01 d0                	add    %edx,%eax
  80146f:	c1 e0 07             	shl    $0x7,%eax
  801472:	29 d0                	sub    %edx,%eax
  801474:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80147b:	01 c8                	add    %ecx,%eax
  80147d:	01 c0                	add    %eax,%eax
  80147f:	01 d0                	add    %edx,%eax
  801481:	01 c0                	add    %eax,%eax
  801483:	01 d0                	add    %edx,%eax
  801485:	c1 e0 03             	shl    $0x3,%eax
  801488:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80148d:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  801492:	a1 20 40 80 00       	mov    0x804020,%eax
  801497:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  80149d:	84 c0                	test   %al,%al
  80149f:	74 0f                	je     8014b0 <libmain+0x58>
		binaryname = myEnv->prog_name;
  8014a1:	a1 20 40 80 00       	mov    0x804020,%eax
  8014a6:	05 f0 ee 00 00       	add    $0xeef0,%eax
  8014ab:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8014b0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014b4:	7e 0a                	jle    8014c0 <libmain+0x68>
		binaryname = argv[0];
  8014b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b9:	8b 00                	mov    (%eax),%eax
  8014bb:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8014c0:	83 ec 08             	sub    $0x8,%esp
  8014c3:	ff 75 0c             	pushl  0xc(%ebp)
  8014c6:	ff 75 08             	pushl  0x8(%ebp)
  8014c9:	e8 6a eb ff ff       	call   800038 <_main>
  8014ce:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8014d1:	e8 31 17 00 00       	call   802c07 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8014d6:	83 ec 0c             	sub    $0xc,%esp
  8014d9:	68 5c 35 80 00       	push   $0x80355c
  8014de:	e8 54 03 00 00       	call   801837 <cprintf>
  8014e3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8014e6:	a1 20 40 80 00       	mov    0x804020,%eax
  8014eb:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  8014f1:	a1 20 40 80 00       	mov    0x804020,%eax
  8014f6:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  8014fc:	83 ec 04             	sub    $0x4,%esp
  8014ff:	52                   	push   %edx
  801500:	50                   	push   %eax
  801501:	68 84 35 80 00       	push   $0x803584
  801506:	e8 2c 03 00 00       	call   801837 <cprintf>
  80150b:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80150e:	a1 20 40 80 00       	mov    0x804020,%eax
  801513:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  801519:	a1 20 40 80 00       	mov    0x804020,%eax
  80151e:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  801524:	a1 20 40 80 00       	mov    0x804020,%eax
  801529:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  80152f:	51                   	push   %ecx
  801530:	52                   	push   %edx
  801531:	50                   	push   %eax
  801532:	68 ac 35 80 00       	push   $0x8035ac
  801537:	e8 fb 02 00 00       	call   801837 <cprintf>
  80153c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80153f:	83 ec 0c             	sub    $0xc,%esp
  801542:	68 5c 35 80 00       	push   $0x80355c
  801547:	e8 eb 02 00 00       	call   801837 <cprintf>
  80154c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80154f:	e8 cd 16 00 00       	call   802c21 <sys_enable_interrupt>

	// exit gracefully
	exit();
  801554:	e8 19 00 00 00       	call   801572 <exit>
}
  801559:	90                   	nop
  80155a:	c9                   	leave  
  80155b:	c3                   	ret    

0080155c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80155c:	55                   	push   %ebp
  80155d:	89 e5                	mov    %esp,%ebp
  80155f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  801562:	83 ec 0c             	sub    $0xc,%esp
  801565:	6a 00                	push   $0x0
  801567:	e8 cc 14 00 00       	call   802a38 <sys_env_destroy>
  80156c:	83 c4 10             	add    $0x10,%esp
}
  80156f:	90                   	nop
  801570:	c9                   	leave  
  801571:	c3                   	ret    

00801572 <exit>:

void
exit(void)
{
  801572:	55                   	push   %ebp
  801573:	89 e5                	mov    %esp,%ebp
  801575:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  801578:	e8 21 15 00 00       	call   802a9e <sys_env_exit>
}
  80157d:	90                   	nop
  80157e:	c9                   	leave  
  80157f:	c3                   	ret    

00801580 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
  801583:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801586:	8d 45 10             	lea    0x10(%ebp),%eax
  801589:	83 c0 04             	add    $0x4,%eax
  80158c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80158f:	a1 18 41 80 00       	mov    0x804118,%eax
  801594:	85 c0                	test   %eax,%eax
  801596:	74 16                	je     8015ae <_panic+0x2e>
		cprintf("%s: ", argv0);
  801598:	a1 18 41 80 00       	mov    0x804118,%eax
  80159d:	83 ec 08             	sub    $0x8,%esp
  8015a0:	50                   	push   %eax
  8015a1:	68 04 36 80 00       	push   $0x803604
  8015a6:	e8 8c 02 00 00       	call   801837 <cprintf>
  8015ab:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8015ae:	a1 00 40 80 00       	mov    0x804000,%eax
  8015b3:	ff 75 0c             	pushl  0xc(%ebp)
  8015b6:	ff 75 08             	pushl  0x8(%ebp)
  8015b9:	50                   	push   %eax
  8015ba:	68 09 36 80 00       	push   $0x803609
  8015bf:	e8 73 02 00 00       	call   801837 <cprintf>
  8015c4:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8015c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ca:	83 ec 08             	sub    $0x8,%esp
  8015cd:	ff 75 f4             	pushl  -0xc(%ebp)
  8015d0:	50                   	push   %eax
  8015d1:	e8 f6 01 00 00       	call   8017cc <vcprintf>
  8015d6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8015d9:	83 ec 08             	sub    $0x8,%esp
  8015dc:	6a 00                	push   $0x0
  8015de:	68 25 36 80 00       	push   $0x803625
  8015e3:	e8 e4 01 00 00       	call   8017cc <vcprintf>
  8015e8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8015eb:	e8 82 ff ff ff       	call   801572 <exit>

	// should not return here
	while (1) ;
  8015f0:	eb fe                	jmp    8015f0 <_panic+0x70>

008015f2 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
  8015f5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8015f8:	a1 20 40 80 00       	mov    0x804020,%eax
  8015fd:	8b 50 74             	mov    0x74(%eax),%edx
  801600:	8b 45 0c             	mov    0xc(%ebp),%eax
  801603:	39 c2                	cmp    %eax,%edx
  801605:	74 14                	je     80161b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801607:	83 ec 04             	sub    $0x4,%esp
  80160a:	68 28 36 80 00       	push   $0x803628
  80160f:	6a 26                	push   $0x26
  801611:	68 74 36 80 00       	push   $0x803674
  801616:	e8 65 ff ff ff       	call   801580 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80161b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801622:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801629:	e9 c4 00 00 00       	jmp    8016f2 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  80162e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801631:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801638:	8b 45 08             	mov    0x8(%ebp),%eax
  80163b:	01 d0                	add    %edx,%eax
  80163d:	8b 00                	mov    (%eax),%eax
  80163f:	85 c0                	test   %eax,%eax
  801641:	75 08                	jne    80164b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801643:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801646:	e9 a4 00 00 00       	jmp    8016ef <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  80164b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801652:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801659:	eb 6b                	jmp    8016c6 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80165b:	a1 20 40 80 00       	mov    0x804020,%eax
  801660:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801666:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801669:	89 d0                	mov    %edx,%eax
  80166b:	c1 e0 02             	shl    $0x2,%eax
  80166e:	01 d0                	add    %edx,%eax
  801670:	c1 e0 02             	shl    $0x2,%eax
  801673:	01 c8                	add    %ecx,%eax
  801675:	8a 40 04             	mov    0x4(%eax),%al
  801678:	84 c0                	test   %al,%al
  80167a:	75 47                	jne    8016c3 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80167c:	a1 20 40 80 00       	mov    0x804020,%eax
  801681:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801687:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80168a:	89 d0                	mov    %edx,%eax
  80168c:	c1 e0 02             	shl    $0x2,%eax
  80168f:	01 d0                	add    %edx,%eax
  801691:	c1 e0 02             	shl    $0x2,%eax
  801694:	01 c8                	add    %ecx,%eax
  801696:	8b 00                	mov    (%eax),%eax
  801698:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80169b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80169e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8016a3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8016a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016a8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	01 c8                	add    %ecx,%eax
  8016b4:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8016b6:	39 c2                	cmp    %eax,%edx
  8016b8:	75 09                	jne    8016c3 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  8016ba:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8016c1:	eb 12                	jmp    8016d5 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8016c3:	ff 45 e8             	incl   -0x18(%ebp)
  8016c6:	a1 20 40 80 00       	mov    0x804020,%eax
  8016cb:	8b 50 74             	mov    0x74(%eax),%edx
  8016ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016d1:	39 c2                	cmp    %eax,%edx
  8016d3:	77 86                	ja     80165b <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8016d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8016d9:	75 14                	jne    8016ef <CheckWSWithoutLastIndex+0xfd>
			panic(
  8016db:	83 ec 04             	sub    $0x4,%esp
  8016de:	68 80 36 80 00       	push   $0x803680
  8016e3:	6a 3a                	push   $0x3a
  8016e5:	68 74 36 80 00       	push   $0x803674
  8016ea:	e8 91 fe ff ff       	call   801580 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8016ef:	ff 45 f0             	incl   -0x10(%ebp)
  8016f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016f5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8016f8:	0f 8c 30 ff ff ff    	jl     80162e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8016fe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801705:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80170c:	eb 27                	jmp    801735 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80170e:	a1 20 40 80 00       	mov    0x804020,%eax
  801713:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  801719:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80171c:	89 d0                	mov    %edx,%eax
  80171e:	c1 e0 02             	shl    $0x2,%eax
  801721:	01 d0                	add    %edx,%eax
  801723:	c1 e0 02             	shl    $0x2,%eax
  801726:	01 c8                	add    %ecx,%eax
  801728:	8a 40 04             	mov    0x4(%eax),%al
  80172b:	3c 01                	cmp    $0x1,%al
  80172d:	75 03                	jne    801732 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  80172f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801732:	ff 45 e0             	incl   -0x20(%ebp)
  801735:	a1 20 40 80 00       	mov    0x804020,%eax
  80173a:	8b 50 74             	mov    0x74(%eax),%edx
  80173d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801740:	39 c2                	cmp    %eax,%edx
  801742:	77 ca                	ja     80170e <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801744:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801747:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80174a:	74 14                	je     801760 <CheckWSWithoutLastIndex+0x16e>
		panic(
  80174c:	83 ec 04             	sub    $0x4,%esp
  80174f:	68 d4 36 80 00       	push   $0x8036d4
  801754:	6a 44                	push   $0x44
  801756:	68 74 36 80 00       	push   $0x803674
  80175b:	e8 20 fe ff ff       	call   801580 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801760:	90                   	nop
  801761:	c9                   	leave  
  801762:	c3                   	ret    

00801763 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801763:	55                   	push   %ebp
  801764:	89 e5                	mov    %esp,%ebp
  801766:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801769:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176c:	8b 00                	mov    (%eax),%eax
  80176e:	8d 48 01             	lea    0x1(%eax),%ecx
  801771:	8b 55 0c             	mov    0xc(%ebp),%edx
  801774:	89 0a                	mov    %ecx,(%edx)
  801776:	8b 55 08             	mov    0x8(%ebp),%edx
  801779:	88 d1                	mov    %dl,%cl
  80177b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801782:	8b 45 0c             	mov    0xc(%ebp),%eax
  801785:	8b 00                	mov    (%eax),%eax
  801787:	3d ff 00 00 00       	cmp    $0xff,%eax
  80178c:	75 2c                	jne    8017ba <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80178e:	a0 24 40 80 00       	mov    0x804024,%al
  801793:	0f b6 c0             	movzbl %al,%eax
  801796:	8b 55 0c             	mov    0xc(%ebp),%edx
  801799:	8b 12                	mov    (%edx),%edx
  80179b:	89 d1                	mov    %edx,%ecx
  80179d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a0:	83 c2 08             	add    $0x8,%edx
  8017a3:	83 ec 04             	sub    $0x4,%esp
  8017a6:	50                   	push   %eax
  8017a7:	51                   	push   %ecx
  8017a8:	52                   	push   %edx
  8017a9:	e8 48 12 00 00       	call   8029f6 <sys_cputs>
  8017ae:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8017b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8017ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bd:	8b 40 04             	mov    0x4(%eax),%eax
  8017c0:	8d 50 01             	lea    0x1(%eax),%edx
  8017c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c6:	89 50 04             	mov    %edx,0x4(%eax)
}
  8017c9:	90                   	nop
  8017ca:	c9                   	leave  
  8017cb:	c3                   	ret    

008017cc <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8017cc:	55                   	push   %ebp
  8017cd:	89 e5                	mov    %esp,%ebp
  8017cf:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8017d5:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8017dc:	00 00 00 
	b.cnt = 0;
  8017df:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8017e6:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8017e9:	ff 75 0c             	pushl  0xc(%ebp)
  8017ec:	ff 75 08             	pushl  0x8(%ebp)
  8017ef:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8017f5:	50                   	push   %eax
  8017f6:	68 63 17 80 00       	push   $0x801763
  8017fb:	e8 11 02 00 00       	call   801a11 <vprintfmt>
  801800:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801803:	a0 24 40 80 00       	mov    0x804024,%al
  801808:	0f b6 c0             	movzbl %al,%eax
  80180b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801811:	83 ec 04             	sub    $0x4,%esp
  801814:	50                   	push   %eax
  801815:	52                   	push   %edx
  801816:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80181c:	83 c0 08             	add    $0x8,%eax
  80181f:	50                   	push   %eax
  801820:	e8 d1 11 00 00       	call   8029f6 <sys_cputs>
  801825:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801828:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  80182f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801835:	c9                   	leave  
  801836:	c3                   	ret    

00801837 <cprintf>:

int cprintf(const char *fmt, ...) {
  801837:	55                   	push   %ebp
  801838:	89 e5                	mov    %esp,%ebp
  80183a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80183d:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801844:	8d 45 0c             	lea    0xc(%ebp),%eax
  801847:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80184a:	8b 45 08             	mov    0x8(%ebp),%eax
  80184d:	83 ec 08             	sub    $0x8,%esp
  801850:	ff 75 f4             	pushl  -0xc(%ebp)
  801853:	50                   	push   %eax
  801854:	e8 73 ff ff ff       	call   8017cc <vcprintf>
  801859:	83 c4 10             	add    $0x10,%esp
  80185c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80185f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801862:	c9                   	leave  
  801863:	c3                   	ret    

00801864 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
  801867:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80186a:	e8 98 13 00 00       	call   802c07 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80186f:	8d 45 0c             	lea    0xc(%ebp),%eax
  801872:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801875:	8b 45 08             	mov    0x8(%ebp),%eax
  801878:	83 ec 08             	sub    $0x8,%esp
  80187b:	ff 75 f4             	pushl  -0xc(%ebp)
  80187e:	50                   	push   %eax
  80187f:	e8 48 ff ff ff       	call   8017cc <vcprintf>
  801884:	83 c4 10             	add    $0x10,%esp
  801887:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80188a:	e8 92 13 00 00       	call   802c21 <sys_enable_interrupt>
	return cnt;
  80188f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801892:	c9                   	leave  
  801893:	c3                   	ret    

00801894 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801894:	55                   	push   %ebp
  801895:	89 e5                	mov    %esp,%ebp
  801897:	53                   	push   %ebx
  801898:	83 ec 14             	sub    $0x14,%esp
  80189b:	8b 45 10             	mov    0x10(%ebp),%eax
  80189e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8018a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8018a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8018a7:	8b 45 18             	mov    0x18(%ebp),%eax
  8018aa:	ba 00 00 00 00       	mov    $0x0,%edx
  8018af:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8018b2:	77 55                	ja     801909 <printnum+0x75>
  8018b4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8018b7:	72 05                	jb     8018be <printnum+0x2a>
  8018b9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018bc:	77 4b                	ja     801909 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8018be:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8018c1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8018c4:	8b 45 18             	mov    0x18(%ebp),%eax
  8018c7:	ba 00 00 00 00       	mov    $0x0,%edx
  8018cc:	52                   	push   %edx
  8018cd:	50                   	push   %eax
  8018ce:	ff 75 f4             	pushl  -0xc(%ebp)
  8018d1:	ff 75 f0             	pushl  -0x10(%ebp)
  8018d4:	e8 6b 17 00 00       	call   803044 <__udivdi3>
  8018d9:	83 c4 10             	add    $0x10,%esp
  8018dc:	83 ec 04             	sub    $0x4,%esp
  8018df:	ff 75 20             	pushl  0x20(%ebp)
  8018e2:	53                   	push   %ebx
  8018e3:	ff 75 18             	pushl  0x18(%ebp)
  8018e6:	52                   	push   %edx
  8018e7:	50                   	push   %eax
  8018e8:	ff 75 0c             	pushl  0xc(%ebp)
  8018eb:	ff 75 08             	pushl  0x8(%ebp)
  8018ee:	e8 a1 ff ff ff       	call   801894 <printnum>
  8018f3:	83 c4 20             	add    $0x20,%esp
  8018f6:	eb 1a                	jmp    801912 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8018f8:	83 ec 08             	sub    $0x8,%esp
  8018fb:	ff 75 0c             	pushl  0xc(%ebp)
  8018fe:	ff 75 20             	pushl  0x20(%ebp)
  801901:	8b 45 08             	mov    0x8(%ebp),%eax
  801904:	ff d0                	call   *%eax
  801906:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801909:	ff 4d 1c             	decl   0x1c(%ebp)
  80190c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801910:	7f e6                	jg     8018f8 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801912:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801915:	bb 00 00 00 00       	mov    $0x0,%ebx
  80191a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80191d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801920:	53                   	push   %ebx
  801921:	51                   	push   %ecx
  801922:	52                   	push   %edx
  801923:	50                   	push   %eax
  801924:	e8 2b 18 00 00       	call   803154 <__umoddi3>
  801929:	83 c4 10             	add    $0x10,%esp
  80192c:	05 34 39 80 00       	add    $0x803934,%eax
  801931:	8a 00                	mov    (%eax),%al
  801933:	0f be c0             	movsbl %al,%eax
  801936:	83 ec 08             	sub    $0x8,%esp
  801939:	ff 75 0c             	pushl  0xc(%ebp)
  80193c:	50                   	push   %eax
  80193d:	8b 45 08             	mov    0x8(%ebp),%eax
  801940:	ff d0                	call   *%eax
  801942:	83 c4 10             	add    $0x10,%esp
}
  801945:	90                   	nop
  801946:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801949:	c9                   	leave  
  80194a:	c3                   	ret    

0080194b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80194b:	55                   	push   %ebp
  80194c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80194e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801952:	7e 1c                	jle    801970 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801954:	8b 45 08             	mov    0x8(%ebp),%eax
  801957:	8b 00                	mov    (%eax),%eax
  801959:	8d 50 08             	lea    0x8(%eax),%edx
  80195c:	8b 45 08             	mov    0x8(%ebp),%eax
  80195f:	89 10                	mov    %edx,(%eax)
  801961:	8b 45 08             	mov    0x8(%ebp),%eax
  801964:	8b 00                	mov    (%eax),%eax
  801966:	83 e8 08             	sub    $0x8,%eax
  801969:	8b 50 04             	mov    0x4(%eax),%edx
  80196c:	8b 00                	mov    (%eax),%eax
  80196e:	eb 40                	jmp    8019b0 <getuint+0x65>
	else if (lflag)
  801970:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801974:	74 1e                	je     801994 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801976:	8b 45 08             	mov    0x8(%ebp),%eax
  801979:	8b 00                	mov    (%eax),%eax
  80197b:	8d 50 04             	lea    0x4(%eax),%edx
  80197e:	8b 45 08             	mov    0x8(%ebp),%eax
  801981:	89 10                	mov    %edx,(%eax)
  801983:	8b 45 08             	mov    0x8(%ebp),%eax
  801986:	8b 00                	mov    (%eax),%eax
  801988:	83 e8 04             	sub    $0x4,%eax
  80198b:	8b 00                	mov    (%eax),%eax
  80198d:	ba 00 00 00 00       	mov    $0x0,%edx
  801992:	eb 1c                	jmp    8019b0 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801994:	8b 45 08             	mov    0x8(%ebp),%eax
  801997:	8b 00                	mov    (%eax),%eax
  801999:	8d 50 04             	lea    0x4(%eax),%edx
  80199c:	8b 45 08             	mov    0x8(%ebp),%eax
  80199f:	89 10                	mov    %edx,(%eax)
  8019a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a4:	8b 00                	mov    (%eax),%eax
  8019a6:	83 e8 04             	sub    $0x4,%eax
  8019a9:	8b 00                	mov    (%eax),%eax
  8019ab:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8019b0:	5d                   	pop    %ebp
  8019b1:	c3                   	ret    

008019b2 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8019b5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8019b9:	7e 1c                	jle    8019d7 <getint+0x25>
		return va_arg(*ap, long long);
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	8b 00                	mov    (%eax),%eax
  8019c0:	8d 50 08             	lea    0x8(%eax),%edx
  8019c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c6:	89 10                	mov    %edx,(%eax)
  8019c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cb:	8b 00                	mov    (%eax),%eax
  8019cd:	83 e8 08             	sub    $0x8,%eax
  8019d0:	8b 50 04             	mov    0x4(%eax),%edx
  8019d3:	8b 00                	mov    (%eax),%eax
  8019d5:	eb 38                	jmp    801a0f <getint+0x5d>
	else if (lflag)
  8019d7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8019db:	74 1a                	je     8019f7 <getint+0x45>
		return va_arg(*ap, long);
  8019dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e0:	8b 00                	mov    (%eax),%eax
  8019e2:	8d 50 04             	lea    0x4(%eax),%edx
  8019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e8:	89 10                	mov    %edx,(%eax)
  8019ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ed:	8b 00                	mov    (%eax),%eax
  8019ef:	83 e8 04             	sub    $0x4,%eax
  8019f2:	8b 00                	mov    (%eax),%eax
  8019f4:	99                   	cltd   
  8019f5:	eb 18                	jmp    801a0f <getint+0x5d>
	else
		return va_arg(*ap, int);
  8019f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fa:	8b 00                	mov    (%eax),%eax
  8019fc:	8d 50 04             	lea    0x4(%eax),%edx
  8019ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801a02:	89 10                	mov    %edx,(%eax)
  801a04:	8b 45 08             	mov    0x8(%ebp),%eax
  801a07:	8b 00                	mov    (%eax),%eax
  801a09:	83 e8 04             	sub    $0x4,%eax
  801a0c:	8b 00                	mov    (%eax),%eax
  801a0e:	99                   	cltd   
}
  801a0f:	5d                   	pop    %ebp
  801a10:	c3                   	ret    

00801a11 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801a11:	55                   	push   %ebp
  801a12:	89 e5                	mov    %esp,%ebp
  801a14:	56                   	push   %esi
  801a15:	53                   	push   %ebx
  801a16:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801a19:	eb 17                	jmp    801a32 <vprintfmt+0x21>
			if (ch == '\0')
  801a1b:	85 db                	test   %ebx,%ebx
  801a1d:	0f 84 af 03 00 00    	je     801dd2 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801a23:	83 ec 08             	sub    $0x8,%esp
  801a26:	ff 75 0c             	pushl  0xc(%ebp)
  801a29:	53                   	push   %ebx
  801a2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2d:	ff d0                	call   *%eax
  801a2f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801a32:	8b 45 10             	mov    0x10(%ebp),%eax
  801a35:	8d 50 01             	lea    0x1(%eax),%edx
  801a38:	89 55 10             	mov    %edx,0x10(%ebp)
  801a3b:	8a 00                	mov    (%eax),%al
  801a3d:	0f b6 d8             	movzbl %al,%ebx
  801a40:	83 fb 25             	cmp    $0x25,%ebx
  801a43:	75 d6                	jne    801a1b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801a45:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801a49:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801a50:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801a57:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801a5e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801a65:	8b 45 10             	mov    0x10(%ebp),%eax
  801a68:	8d 50 01             	lea    0x1(%eax),%edx
  801a6b:	89 55 10             	mov    %edx,0x10(%ebp)
  801a6e:	8a 00                	mov    (%eax),%al
  801a70:	0f b6 d8             	movzbl %al,%ebx
  801a73:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801a76:	83 f8 55             	cmp    $0x55,%eax
  801a79:	0f 87 2b 03 00 00    	ja     801daa <vprintfmt+0x399>
  801a7f:	8b 04 85 58 39 80 00 	mov    0x803958(,%eax,4),%eax
  801a86:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801a88:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801a8c:	eb d7                	jmp    801a65 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801a8e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801a92:	eb d1                	jmp    801a65 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801a94:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801a9b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a9e:	89 d0                	mov    %edx,%eax
  801aa0:	c1 e0 02             	shl    $0x2,%eax
  801aa3:	01 d0                	add    %edx,%eax
  801aa5:	01 c0                	add    %eax,%eax
  801aa7:	01 d8                	add    %ebx,%eax
  801aa9:	83 e8 30             	sub    $0x30,%eax
  801aac:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801aaf:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab2:	8a 00                	mov    (%eax),%al
  801ab4:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801ab7:	83 fb 2f             	cmp    $0x2f,%ebx
  801aba:	7e 3e                	jle    801afa <vprintfmt+0xe9>
  801abc:	83 fb 39             	cmp    $0x39,%ebx
  801abf:	7f 39                	jg     801afa <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801ac1:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801ac4:	eb d5                	jmp    801a9b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801ac6:	8b 45 14             	mov    0x14(%ebp),%eax
  801ac9:	83 c0 04             	add    $0x4,%eax
  801acc:	89 45 14             	mov    %eax,0x14(%ebp)
  801acf:	8b 45 14             	mov    0x14(%ebp),%eax
  801ad2:	83 e8 04             	sub    $0x4,%eax
  801ad5:	8b 00                	mov    (%eax),%eax
  801ad7:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801ada:	eb 1f                	jmp    801afb <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801adc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801ae0:	79 83                	jns    801a65 <vprintfmt+0x54>
				width = 0;
  801ae2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801ae9:	e9 77 ff ff ff       	jmp    801a65 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801aee:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801af5:	e9 6b ff ff ff       	jmp    801a65 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801afa:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801afb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801aff:	0f 89 60 ff ff ff    	jns    801a65 <vprintfmt+0x54>
				width = precision, precision = -1;
  801b05:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801b0b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801b12:	e9 4e ff ff ff       	jmp    801a65 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801b17:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801b1a:	e9 46 ff ff ff       	jmp    801a65 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801b1f:	8b 45 14             	mov    0x14(%ebp),%eax
  801b22:	83 c0 04             	add    $0x4,%eax
  801b25:	89 45 14             	mov    %eax,0x14(%ebp)
  801b28:	8b 45 14             	mov    0x14(%ebp),%eax
  801b2b:	83 e8 04             	sub    $0x4,%eax
  801b2e:	8b 00                	mov    (%eax),%eax
  801b30:	83 ec 08             	sub    $0x8,%esp
  801b33:	ff 75 0c             	pushl  0xc(%ebp)
  801b36:	50                   	push   %eax
  801b37:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3a:	ff d0                	call   *%eax
  801b3c:	83 c4 10             	add    $0x10,%esp
			break;
  801b3f:	e9 89 02 00 00       	jmp    801dcd <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801b44:	8b 45 14             	mov    0x14(%ebp),%eax
  801b47:	83 c0 04             	add    $0x4,%eax
  801b4a:	89 45 14             	mov    %eax,0x14(%ebp)
  801b4d:	8b 45 14             	mov    0x14(%ebp),%eax
  801b50:	83 e8 04             	sub    $0x4,%eax
  801b53:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801b55:	85 db                	test   %ebx,%ebx
  801b57:	79 02                	jns    801b5b <vprintfmt+0x14a>
				err = -err;
  801b59:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801b5b:	83 fb 64             	cmp    $0x64,%ebx
  801b5e:	7f 0b                	jg     801b6b <vprintfmt+0x15a>
  801b60:	8b 34 9d a0 37 80 00 	mov    0x8037a0(,%ebx,4),%esi
  801b67:	85 f6                	test   %esi,%esi
  801b69:	75 19                	jne    801b84 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801b6b:	53                   	push   %ebx
  801b6c:	68 45 39 80 00       	push   $0x803945
  801b71:	ff 75 0c             	pushl  0xc(%ebp)
  801b74:	ff 75 08             	pushl  0x8(%ebp)
  801b77:	e8 5e 02 00 00       	call   801dda <printfmt>
  801b7c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801b7f:	e9 49 02 00 00       	jmp    801dcd <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801b84:	56                   	push   %esi
  801b85:	68 4e 39 80 00       	push   $0x80394e
  801b8a:	ff 75 0c             	pushl  0xc(%ebp)
  801b8d:	ff 75 08             	pushl  0x8(%ebp)
  801b90:	e8 45 02 00 00       	call   801dda <printfmt>
  801b95:	83 c4 10             	add    $0x10,%esp
			break;
  801b98:	e9 30 02 00 00       	jmp    801dcd <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801b9d:	8b 45 14             	mov    0x14(%ebp),%eax
  801ba0:	83 c0 04             	add    $0x4,%eax
  801ba3:	89 45 14             	mov    %eax,0x14(%ebp)
  801ba6:	8b 45 14             	mov    0x14(%ebp),%eax
  801ba9:	83 e8 04             	sub    $0x4,%eax
  801bac:	8b 30                	mov    (%eax),%esi
  801bae:	85 f6                	test   %esi,%esi
  801bb0:	75 05                	jne    801bb7 <vprintfmt+0x1a6>
				p = "(null)";
  801bb2:	be 51 39 80 00       	mov    $0x803951,%esi
			if (width > 0 && padc != '-')
  801bb7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801bbb:	7e 6d                	jle    801c2a <vprintfmt+0x219>
  801bbd:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801bc1:	74 67                	je     801c2a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801bc3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bc6:	83 ec 08             	sub    $0x8,%esp
  801bc9:	50                   	push   %eax
  801bca:	56                   	push   %esi
  801bcb:	e8 0c 03 00 00       	call   801edc <strnlen>
  801bd0:	83 c4 10             	add    $0x10,%esp
  801bd3:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801bd6:	eb 16                	jmp    801bee <vprintfmt+0x1dd>
					putch(padc, putdat);
  801bd8:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801bdc:	83 ec 08             	sub    $0x8,%esp
  801bdf:	ff 75 0c             	pushl  0xc(%ebp)
  801be2:	50                   	push   %eax
  801be3:	8b 45 08             	mov    0x8(%ebp),%eax
  801be6:	ff d0                	call   *%eax
  801be8:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801beb:	ff 4d e4             	decl   -0x1c(%ebp)
  801bee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801bf2:	7f e4                	jg     801bd8 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801bf4:	eb 34                	jmp    801c2a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801bf6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801bfa:	74 1c                	je     801c18 <vprintfmt+0x207>
  801bfc:	83 fb 1f             	cmp    $0x1f,%ebx
  801bff:	7e 05                	jle    801c06 <vprintfmt+0x1f5>
  801c01:	83 fb 7e             	cmp    $0x7e,%ebx
  801c04:	7e 12                	jle    801c18 <vprintfmt+0x207>
					putch('?', putdat);
  801c06:	83 ec 08             	sub    $0x8,%esp
  801c09:	ff 75 0c             	pushl  0xc(%ebp)
  801c0c:	6a 3f                	push   $0x3f
  801c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c11:	ff d0                	call   *%eax
  801c13:	83 c4 10             	add    $0x10,%esp
  801c16:	eb 0f                	jmp    801c27 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801c18:	83 ec 08             	sub    $0x8,%esp
  801c1b:	ff 75 0c             	pushl  0xc(%ebp)
  801c1e:	53                   	push   %ebx
  801c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c22:	ff d0                	call   *%eax
  801c24:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801c27:	ff 4d e4             	decl   -0x1c(%ebp)
  801c2a:	89 f0                	mov    %esi,%eax
  801c2c:	8d 70 01             	lea    0x1(%eax),%esi
  801c2f:	8a 00                	mov    (%eax),%al
  801c31:	0f be d8             	movsbl %al,%ebx
  801c34:	85 db                	test   %ebx,%ebx
  801c36:	74 24                	je     801c5c <vprintfmt+0x24b>
  801c38:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801c3c:	78 b8                	js     801bf6 <vprintfmt+0x1e5>
  801c3e:	ff 4d e0             	decl   -0x20(%ebp)
  801c41:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801c45:	79 af                	jns    801bf6 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c47:	eb 13                	jmp    801c5c <vprintfmt+0x24b>
				putch(' ', putdat);
  801c49:	83 ec 08             	sub    $0x8,%esp
  801c4c:	ff 75 0c             	pushl  0xc(%ebp)
  801c4f:	6a 20                	push   $0x20
  801c51:	8b 45 08             	mov    0x8(%ebp),%eax
  801c54:	ff d0                	call   *%eax
  801c56:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c59:	ff 4d e4             	decl   -0x1c(%ebp)
  801c5c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801c60:	7f e7                	jg     801c49 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801c62:	e9 66 01 00 00       	jmp    801dcd <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801c67:	83 ec 08             	sub    $0x8,%esp
  801c6a:	ff 75 e8             	pushl  -0x18(%ebp)
  801c6d:	8d 45 14             	lea    0x14(%ebp),%eax
  801c70:	50                   	push   %eax
  801c71:	e8 3c fd ff ff       	call   8019b2 <getint>
  801c76:	83 c4 10             	add    $0x10,%esp
  801c79:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c7c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801c7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c82:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c85:	85 d2                	test   %edx,%edx
  801c87:	79 23                	jns    801cac <vprintfmt+0x29b>
				putch('-', putdat);
  801c89:	83 ec 08             	sub    $0x8,%esp
  801c8c:	ff 75 0c             	pushl  0xc(%ebp)
  801c8f:	6a 2d                	push   $0x2d
  801c91:	8b 45 08             	mov    0x8(%ebp),%eax
  801c94:	ff d0                	call   *%eax
  801c96:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801c99:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c9c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c9f:	f7 d8                	neg    %eax
  801ca1:	83 d2 00             	adc    $0x0,%edx
  801ca4:	f7 da                	neg    %edx
  801ca6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ca9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801cac:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801cb3:	e9 bc 00 00 00       	jmp    801d74 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801cb8:	83 ec 08             	sub    $0x8,%esp
  801cbb:	ff 75 e8             	pushl  -0x18(%ebp)
  801cbe:	8d 45 14             	lea    0x14(%ebp),%eax
  801cc1:	50                   	push   %eax
  801cc2:	e8 84 fc ff ff       	call   80194b <getuint>
  801cc7:	83 c4 10             	add    $0x10,%esp
  801cca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ccd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801cd0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801cd7:	e9 98 00 00 00       	jmp    801d74 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801cdc:	83 ec 08             	sub    $0x8,%esp
  801cdf:	ff 75 0c             	pushl  0xc(%ebp)
  801ce2:	6a 58                	push   $0x58
  801ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce7:	ff d0                	call   *%eax
  801ce9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801cec:	83 ec 08             	sub    $0x8,%esp
  801cef:	ff 75 0c             	pushl  0xc(%ebp)
  801cf2:	6a 58                	push   $0x58
  801cf4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf7:	ff d0                	call   *%eax
  801cf9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801cfc:	83 ec 08             	sub    $0x8,%esp
  801cff:	ff 75 0c             	pushl  0xc(%ebp)
  801d02:	6a 58                	push   $0x58
  801d04:	8b 45 08             	mov    0x8(%ebp),%eax
  801d07:	ff d0                	call   *%eax
  801d09:	83 c4 10             	add    $0x10,%esp
			break;
  801d0c:	e9 bc 00 00 00       	jmp    801dcd <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801d11:	83 ec 08             	sub    $0x8,%esp
  801d14:	ff 75 0c             	pushl  0xc(%ebp)
  801d17:	6a 30                	push   $0x30
  801d19:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1c:	ff d0                	call   *%eax
  801d1e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801d21:	83 ec 08             	sub    $0x8,%esp
  801d24:	ff 75 0c             	pushl  0xc(%ebp)
  801d27:	6a 78                	push   $0x78
  801d29:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2c:	ff d0                	call   *%eax
  801d2e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801d31:	8b 45 14             	mov    0x14(%ebp),%eax
  801d34:	83 c0 04             	add    $0x4,%eax
  801d37:	89 45 14             	mov    %eax,0x14(%ebp)
  801d3a:	8b 45 14             	mov    0x14(%ebp),%eax
  801d3d:	83 e8 04             	sub    $0x4,%eax
  801d40:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801d42:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d45:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801d4c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801d53:	eb 1f                	jmp    801d74 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801d55:	83 ec 08             	sub    $0x8,%esp
  801d58:	ff 75 e8             	pushl  -0x18(%ebp)
  801d5b:	8d 45 14             	lea    0x14(%ebp),%eax
  801d5e:	50                   	push   %eax
  801d5f:	e8 e7 fb ff ff       	call   80194b <getuint>
  801d64:	83 c4 10             	add    $0x10,%esp
  801d67:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d6a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801d6d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801d74:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801d78:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d7b:	83 ec 04             	sub    $0x4,%esp
  801d7e:	52                   	push   %edx
  801d7f:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d82:	50                   	push   %eax
  801d83:	ff 75 f4             	pushl  -0xc(%ebp)
  801d86:	ff 75 f0             	pushl  -0x10(%ebp)
  801d89:	ff 75 0c             	pushl  0xc(%ebp)
  801d8c:	ff 75 08             	pushl  0x8(%ebp)
  801d8f:	e8 00 fb ff ff       	call   801894 <printnum>
  801d94:	83 c4 20             	add    $0x20,%esp
			break;
  801d97:	eb 34                	jmp    801dcd <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801d99:	83 ec 08             	sub    $0x8,%esp
  801d9c:	ff 75 0c             	pushl  0xc(%ebp)
  801d9f:	53                   	push   %ebx
  801da0:	8b 45 08             	mov    0x8(%ebp),%eax
  801da3:	ff d0                	call   *%eax
  801da5:	83 c4 10             	add    $0x10,%esp
			break;
  801da8:	eb 23                	jmp    801dcd <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801daa:	83 ec 08             	sub    $0x8,%esp
  801dad:	ff 75 0c             	pushl  0xc(%ebp)
  801db0:	6a 25                	push   $0x25
  801db2:	8b 45 08             	mov    0x8(%ebp),%eax
  801db5:	ff d0                	call   *%eax
  801db7:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801dba:	ff 4d 10             	decl   0x10(%ebp)
  801dbd:	eb 03                	jmp    801dc2 <vprintfmt+0x3b1>
  801dbf:	ff 4d 10             	decl   0x10(%ebp)
  801dc2:	8b 45 10             	mov    0x10(%ebp),%eax
  801dc5:	48                   	dec    %eax
  801dc6:	8a 00                	mov    (%eax),%al
  801dc8:	3c 25                	cmp    $0x25,%al
  801dca:	75 f3                	jne    801dbf <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801dcc:	90                   	nop
		}
	}
  801dcd:	e9 47 fc ff ff       	jmp    801a19 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801dd2:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801dd3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801dd6:	5b                   	pop    %ebx
  801dd7:	5e                   	pop    %esi
  801dd8:	5d                   	pop    %ebp
  801dd9:	c3                   	ret    

00801dda <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801dda:	55                   	push   %ebp
  801ddb:	89 e5                	mov    %esp,%ebp
  801ddd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801de0:	8d 45 10             	lea    0x10(%ebp),%eax
  801de3:	83 c0 04             	add    $0x4,%eax
  801de6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801de9:	8b 45 10             	mov    0x10(%ebp),%eax
  801dec:	ff 75 f4             	pushl  -0xc(%ebp)
  801def:	50                   	push   %eax
  801df0:	ff 75 0c             	pushl  0xc(%ebp)
  801df3:	ff 75 08             	pushl  0x8(%ebp)
  801df6:	e8 16 fc ff ff       	call   801a11 <vprintfmt>
  801dfb:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801dfe:	90                   	nop
  801dff:	c9                   	leave  
  801e00:	c3                   	ret    

00801e01 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801e01:	55                   	push   %ebp
  801e02:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801e04:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e07:	8b 40 08             	mov    0x8(%eax),%eax
  801e0a:	8d 50 01             	lea    0x1(%eax),%edx
  801e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e10:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801e13:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e16:	8b 10                	mov    (%eax),%edx
  801e18:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e1b:	8b 40 04             	mov    0x4(%eax),%eax
  801e1e:	39 c2                	cmp    %eax,%edx
  801e20:	73 12                	jae    801e34 <sprintputch+0x33>
		*b->buf++ = ch;
  801e22:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e25:	8b 00                	mov    (%eax),%eax
  801e27:	8d 48 01             	lea    0x1(%eax),%ecx
  801e2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e2d:	89 0a                	mov    %ecx,(%edx)
  801e2f:	8b 55 08             	mov    0x8(%ebp),%edx
  801e32:	88 10                	mov    %dl,(%eax)
}
  801e34:	90                   	nop
  801e35:	5d                   	pop    %ebp
  801e36:	c3                   	ret    

00801e37 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801e37:	55                   	push   %ebp
  801e38:	89 e5                	mov    %esp,%ebp
  801e3a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e40:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801e43:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e46:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e49:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4c:	01 d0                	add    %edx,%eax
  801e4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e51:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801e58:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801e5c:	74 06                	je     801e64 <vsnprintf+0x2d>
  801e5e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801e62:	7f 07                	jg     801e6b <vsnprintf+0x34>
		return -E_INVAL;
  801e64:	b8 03 00 00 00       	mov    $0x3,%eax
  801e69:	eb 20                	jmp    801e8b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801e6b:	ff 75 14             	pushl  0x14(%ebp)
  801e6e:	ff 75 10             	pushl  0x10(%ebp)
  801e71:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801e74:	50                   	push   %eax
  801e75:	68 01 1e 80 00       	push   $0x801e01
  801e7a:	e8 92 fb ff ff       	call   801a11 <vprintfmt>
  801e7f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801e82:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e85:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801e88:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801e8b:	c9                   	leave  
  801e8c:	c3                   	ret    

00801e8d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801e8d:	55                   	push   %ebp
  801e8e:	89 e5                	mov    %esp,%ebp
  801e90:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801e93:	8d 45 10             	lea    0x10(%ebp),%eax
  801e96:	83 c0 04             	add    $0x4,%eax
  801e99:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801e9c:	8b 45 10             	mov    0x10(%ebp),%eax
  801e9f:	ff 75 f4             	pushl  -0xc(%ebp)
  801ea2:	50                   	push   %eax
  801ea3:	ff 75 0c             	pushl  0xc(%ebp)
  801ea6:	ff 75 08             	pushl  0x8(%ebp)
  801ea9:	e8 89 ff ff ff       	call   801e37 <vsnprintf>
  801eae:	83 c4 10             	add    $0x10,%esp
  801eb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801eb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801eb7:	c9                   	leave  
  801eb8:	c3                   	ret    

00801eb9 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801eb9:	55                   	push   %ebp
  801eba:	89 e5                	mov    %esp,%ebp
  801ebc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801ebf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ec6:	eb 06                	jmp    801ece <strlen+0x15>
		n++;
  801ec8:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801ecb:	ff 45 08             	incl   0x8(%ebp)
  801ece:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed1:	8a 00                	mov    (%eax),%al
  801ed3:	84 c0                	test   %al,%al
  801ed5:	75 f1                	jne    801ec8 <strlen+0xf>
		n++;
	return n;
  801ed7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801eda:	c9                   	leave  
  801edb:	c3                   	ret    

00801edc <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801edc:	55                   	push   %ebp
  801edd:	89 e5                	mov    %esp,%ebp
  801edf:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801ee2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ee9:	eb 09                	jmp    801ef4 <strnlen+0x18>
		n++;
  801eeb:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801eee:	ff 45 08             	incl   0x8(%ebp)
  801ef1:	ff 4d 0c             	decl   0xc(%ebp)
  801ef4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801ef8:	74 09                	je     801f03 <strnlen+0x27>
  801efa:	8b 45 08             	mov    0x8(%ebp),%eax
  801efd:	8a 00                	mov    (%eax),%al
  801eff:	84 c0                	test   %al,%al
  801f01:	75 e8                	jne    801eeb <strnlen+0xf>
		n++;
	return n;
  801f03:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801f06:	c9                   	leave  
  801f07:	c3                   	ret    

00801f08 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801f08:	55                   	push   %ebp
  801f09:	89 e5                	mov    %esp,%ebp
  801f0b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f11:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801f14:	90                   	nop
  801f15:	8b 45 08             	mov    0x8(%ebp),%eax
  801f18:	8d 50 01             	lea    0x1(%eax),%edx
  801f1b:	89 55 08             	mov    %edx,0x8(%ebp)
  801f1e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f21:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f24:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801f27:	8a 12                	mov    (%edx),%dl
  801f29:	88 10                	mov    %dl,(%eax)
  801f2b:	8a 00                	mov    (%eax),%al
  801f2d:	84 c0                	test   %al,%al
  801f2f:	75 e4                	jne    801f15 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801f31:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801f34:	c9                   	leave  
  801f35:	c3                   	ret    

00801f36 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801f36:	55                   	push   %ebp
  801f37:	89 e5                	mov    %esp,%ebp
  801f39:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801f42:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801f49:	eb 1f                	jmp    801f6a <strncpy+0x34>
		*dst++ = *src;
  801f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4e:	8d 50 01             	lea    0x1(%eax),%edx
  801f51:	89 55 08             	mov    %edx,0x8(%ebp)
  801f54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f57:	8a 12                	mov    (%edx),%dl
  801f59:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801f5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f5e:	8a 00                	mov    (%eax),%al
  801f60:	84 c0                	test   %al,%al
  801f62:	74 03                	je     801f67 <strncpy+0x31>
			src++;
  801f64:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801f67:	ff 45 fc             	incl   -0x4(%ebp)
  801f6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f6d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801f70:	72 d9                	jb     801f4b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801f72:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801f75:	c9                   	leave  
  801f76:	c3                   	ret    

00801f77 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801f77:	55                   	push   %ebp
  801f78:	89 e5                	mov    %esp,%ebp
  801f7a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f80:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801f83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f87:	74 30                	je     801fb9 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801f89:	eb 16                	jmp    801fa1 <strlcpy+0x2a>
			*dst++ = *src++;
  801f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8e:	8d 50 01             	lea    0x1(%eax),%edx
  801f91:	89 55 08             	mov    %edx,0x8(%ebp)
  801f94:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f97:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f9a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801f9d:	8a 12                	mov    (%edx),%dl
  801f9f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801fa1:	ff 4d 10             	decl   0x10(%ebp)
  801fa4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801fa8:	74 09                	je     801fb3 <strlcpy+0x3c>
  801faa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fad:	8a 00                	mov    (%eax),%al
  801faf:	84 c0                	test   %al,%al
  801fb1:	75 d8                	jne    801f8b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb6:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801fb9:	8b 55 08             	mov    0x8(%ebp),%edx
  801fbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801fbf:	29 c2                	sub    %eax,%edx
  801fc1:	89 d0                	mov    %edx,%eax
}
  801fc3:	c9                   	leave  
  801fc4:	c3                   	ret    

00801fc5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801fc5:	55                   	push   %ebp
  801fc6:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801fc8:	eb 06                	jmp    801fd0 <strcmp+0xb>
		p++, q++;
  801fca:	ff 45 08             	incl   0x8(%ebp)
  801fcd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd3:	8a 00                	mov    (%eax),%al
  801fd5:	84 c0                	test   %al,%al
  801fd7:	74 0e                	je     801fe7 <strcmp+0x22>
  801fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fdc:	8a 10                	mov    (%eax),%dl
  801fde:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fe1:	8a 00                	mov    (%eax),%al
  801fe3:	38 c2                	cmp    %al,%dl
  801fe5:	74 e3                	je     801fca <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801fe7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fea:	8a 00                	mov    (%eax),%al
  801fec:	0f b6 d0             	movzbl %al,%edx
  801fef:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ff2:	8a 00                	mov    (%eax),%al
  801ff4:	0f b6 c0             	movzbl %al,%eax
  801ff7:	29 c2                	sub    %eax,%edx
  801ff9:	89 d0                	mov    %edx,%eax
}
  801ffb:	5d                   	pop    %ebp
  801ffc:	c3                   	ret    

00801ffd <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801ffd:	55                   	push   %ebp
  801ffe:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  802000:	eb 09                	jmp    80200b <strncmp+0xe>
		n--, p++, q++;
  802002:	ff 4d 10             	decl   0x10(%ebp)
  802005:	ff 45 08             	incl   0x8(%ebp)
  802008:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80200b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80200f:	74 17                	je     802028 <strncmp+0x2b>
  802011:	8b 45 08             	mov    0x8(%ebp),%eax
  802014:	8a 00                	mov    (%eax),%al
  802016:	84 c0                	test   %al,%al
  802018:	74 0e                	je     802028 <strncmp+0x2b>
  80201a:	8b 45 08             	mov    0x8(%ebp),%eax
  80201d:	8a 10                	mov    (%eax),%dl
  80201f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802022:	8a 00                	mov    (%eax),%al
  802024:	38 c2                	cmp    %al,%dl
  802026:	74 da                	je     802002 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  802028:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80202c:	75 07                	jne    802035 <strncmp+0x38>
		return 0;
  80202e:	b8 00 00 00 00       	mov    $0x0,%eax
  802033:	eb 14                	jmp    802049 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  802035:	8b 45 08             	mov    0x8(%ebp),%eax
  802038:	8a 00                	mov    (%eax),%al
  80203a:	0f b6 d0             	movzbl %al,%edx
  80203d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802040:	8a 00                	mov    (%eax),%al
  802042:	0f b6 c0             	movzbl %al,%eax
  802045:	29 c2                	sub    %eax,%edx
  802047:	89 d0                	mov    %edx,%eax
}
  802049:	5d                   	pop    %ebp
  80204a:	c3                   	ret    

0080204b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80204b:	55                   	push   %ebp
  80204c:	89 e5                	mov    %esp,%ebp
  80204e:	83 ec 04             	sub    $0x4,%esp
  802051:	8b 45 0c             	mov    0xc(%ebp),%eax
  802054:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802057:	eb 12                	jmp    80206b <strchr+0x20>
		if (*s == c)
  802059:	8b 45 08             	mov    0x8(%ebp),%eax
  80205c:	8a 00                	mov    (%eax),%al
  80205e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802061:	75 05                	jne    802068 <strchr+0x1d>
			return (char *) s;
  802063:	8b 45 08             	mov    0x8(%ebp),%eax
  802066:	eb 11                	jmp    802079 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802068:	ff 45 08             	incl   0x8(%ebp)
  80206b:	8b 45 08             	mov    0x8(%ebp),%eax
  80206e:	8a 00                	mov    (%eax),%al
  802070:	84 c0                	test   %al,%al
  802072:	75 e5                	jne    802059 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  802074:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802079:	c9                   	leave  
  80207a:	c3                   	ret    

0080207b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80207b:	55                   	push   %ebp
  80207c:	89 e5                	mov    %esp,%ebp
  80207e:	83 ec 04             	sub    $0x4,%esp
  802081:	8b 45 0c             	mov    0xc(%ebp),%eax
  802084:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802087:	eb 0d                	jmp    802096 <strfind+0x1b>
		if (*s == c)
  802089:	8b 45 08             	mov    0x8(%ebp),%eax
  80208c:	8a 00                	mov    (%eax),%al
  80208e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802091:	74 0e                	je     8020a1 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  802093:	ff 45 08             	incl   0x8(%ebp)
  802096:	8b 45 08             	mov    0x8(%ebp),%eax
  802099:	8a 00                	mov    (%eax),%al
  80209b:	84 c0                	test   %al,%al
  80209d:	75 ea                	jne    802089 <strfind+0xe>
  80209f:	eb 01                	jmp    8020a2 <strfind+0x27>
		if (*s == c)
			break;
  8020a1:	90                   	nop
	return (char *) s;
  8020a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8020a5:	c9                   	leave  
  8020a6:	c3                   	ret    

008020a7 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8020a7:	55                   	push   %ebp
  8020a8:	89 e5                	mov    %esp,%ebp
  8020aa:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8020ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8020b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8020b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8020b9:	eb 0e                	jmp    8020c9 <memset+0x22>
		*p++ = c;
  8020bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020be:	8d 50 01             	lea    0x1(%eax),%edx
  8020c1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8020c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020c7:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8020c9:	ff 4d f8             	decl   -0x8(%ebp)
  8020cc:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8020d0:	79 e9                	jns    8020bb <memset+0x14>
		*p++ = c;

	return v;
  8020d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8020d5:	c9                   	leave  
  8020d6:	c3                   	ret    

008020d7 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8020d7:	55                   	push   %ebp
  8020d8:	89 e5                	mov    %esp,%ebp
  8020da:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8020dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8020e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8020e9:	eb 16                	jmp    802101 <memcpy+0x2a>
		*d++ = *s++;
  8020eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020ee:	8d 50 01             	lea    0x1(%eax),%edx
  8020f1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8020f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020f7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8020fa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8020fd:	8a 12                	mov    (%edx),%dl
  8020ff:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  802101:	8b 45 10             	mov    0x10(%ebp),%eax
  802104:	8d 50 ff             	lea    -0x1(%eax),%edx
  802107:	89 55 10             	mov    %edx,0x10(%ebp)
  80210a:	85 c0                	test   %eax,%eax
  80210c:	75 dd                	jne    8020eb <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80210e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802111:	c9                   	leave  
  802112:	c3                   	ret    

00802113 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  802113:	55                   	push   %ebp
  802114:	89 e5                	mov    %esp,%ebp
  802116:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  802119:	8b 45 0c             	mov    0xc(%ebp),%eax
  80211c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80211f:	8b 45 08             	mov    0x8(%ebp),%eax
  802122:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  802125:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802128:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80212b:	73 50                	jae    80217d <memmove+0x6a>
  80212d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802130:	8b 45 10             	mov    0x10(%ebp),%eax
  802133:	01 d0                	add    %edx,%eax
  802135:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802138:	76 43                	jbe    80217d <memmove+0x6a>
		s += n;
  80213a:	8b 45 10             	mov    0x10(%ebp),%eax
  80213d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  802140:	8b 45 10             	mov    0x10(%ebp),%eax
  802143:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  802146:	eb 10                	jmp    802158 <memmove+0x45>
			*--d = *--s;
  802148:	ff 4d f8             	decl   -0x8(%ebp)
  80214b:	ff 4d fc             	decl   -0x4(%ebp)
  80214e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802151:	8a 10                	mov    (%eax),%dl
  802153:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802156:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  802158:	8b 45 10             	mov    0x10(%ebp),%eax
  80215b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80215e:	89 55 10             	mov    %edx,0x10(%ebp)
  802161:	85 c0                	test   %eax,%eax
  802163:	75 e3                	jne    802148 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  802165:	eb 23                	jmp    80218a <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  802167:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80216a:	8d 50 01             	lea    0x1(%eax),%edx
  80216d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802170:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802173:	8d 4a 01             	lea    0x1(%edx),%ecx
  802176:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802179:	8a 12                	mov    (%edx),%dl
  80217b:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80217d:	8b 45 10             	mov    0x10(%ebp),%eax
  802180:	8d 50 ff             	lea    -0x1(%eax),%edx
  802183:	89 55 10             	mov    %edx,0x10(%ebp)
  802186:	85 c0                	test   %eax,%eax
  802188:	75 dd                	jne    802167 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80218a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80218d:	c9                   	leave  
  80218e:	c3                   	ret    

0080218f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80218f:	55                   	push   %ebp
  802190:	89 e5                	mov    %esp,%ebp
  802192:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  802195:	8b 45 08             	mov    0x8(%ebp),%eax
  802198:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80219b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80219e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8021a1:	eb 2a                	jmp    8021cd <memcmp+0x3e>
		if (*s1 != *s2)
  8021a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021a6:	8a 10                	mov    (%eax),%dl
  8021a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021ab:	8a 00                	mov    (%eax),%al
  8021ad:	38 c2                	cmp    %al,%dl
  8021af:	74 16                	je     8021c7 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8021b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021b4:	8a 00                	mov    (%eax),%al
  8021b6:	0f b6 d0             	movzbl %al,%edx
  8021b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021bc:	8a 00                	mov    (%eax),%al
  8021be:	0f b6 c0             	movzbl %al,%eax
  8021c1:	29 c2                	sub    %eax,%edx
  8021c3:	89 d0                	mov    %edx,%eax
  8021c5:	eb 18                	jmp    8021df <memcmp+0x50>
		s1++, s2++;
  8021c7:	ff 45 fc             	incl   -0x4(%ebp)
  8021ca:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8021cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8021d0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8021d3:	89 55 10             	mov    %edx,0x10(%ebp)
  8021d6:	85 c0                	test   %eax,%eax
  8021d8:	75 c9                	jne    8021a3 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8021da:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021df:	c9                   	leave  
  8021e0:	c3                   	ret    

008021e1 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8021e1:	55                   	push   %ebp
  8021e2:	89 e5                	mov    %esp,%ebp
  8021e4:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8021e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8021ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8021ed:	01 d0                	add    %edx,%eax
  8021ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8021f2:	eb 15                	jmp    802209 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8021f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f7:	8a 00                	mov    (%eax),%al
  8021f9:	0f b6 d0             	movzbl %al,%edx
  8021fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021ff:	0f b6 c0             	movzbl %al,%eax
  802202:	39 c2                	cmp    %eax,%edx
  802204:	74 0d                	je     802213 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  802206:	ff 45 08             	incl   0x8(%ebp)
  802209:	8b 45 08             	mov    0x8(%ebp),%eax
  80220c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80220f:	72 e3                	jb     8021f4 <memfind+0x13>
  802211:	eb 01                	jmp    802214 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  802213:	90                   	nop
	return (void *) s;
  802214:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802217:	c9                   	leave  
  802218:	c3                   	ret    

00802219 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  802219:	55                   	push   %ebp
  80221a:	89 e5                	mov    %esp,%ebp
  80221c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80221f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  802226:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80222d:	eb 03                	jmp    802232 <strtol+0x19>
		s++;
  80222f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802232:	8b 45 08             	mov    0x8(%ebp),%eax
  802235:	8a 00                	mov    (%eax),%al
  802237:	3c 20                	cmp    $0x20,%al
  802239:	74 f4                	je     80222f <strtol+0x16>
  80223b:	8b 45 08             	mov    0x8(%ebp),%eax
  80223e:	8a 00                	mov    (%eax),%al
  802240:	3c 09                	cmp    $0x9,%al
  802242:	74 eb                	je     80222f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  802244:	8b 45 08             	mov    0x8(%ebp),%eax
  802247:	8a 00                	mov    (%eax),%al
  802249:	3c 2b                	cmp    $0x2b,%al
  80224b:	75 05                	jne    802252 <strtol+0x39>
		s++;
  80224d:	ff 45 08             	incl   0x8(%ebp)
  802250:	eb 13                	jmp    802265 <strtol+0x4c>
	else if (*s == '-')
  802252:	8b 45 08             	mov    0x8(%ebp),%eax
  802255:	8a 00                	mov    (%eax),%al
  802257:	3c 2d                	cmp    $0x2d,%al
  802259:	75 0a                	jne    802265 <strtol+0x4c>
		s++, neg = 1;
  80225b:	ff 45 08             	incl   0x8(%ebp)
  80225e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  802265:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802269:	74 06                	je     802271 <strtol+0x58>
  80226b:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80226f:	75 20                	jne    802291 <strtol+0x78>
  802271:	8b 45 08             	mov    0x8(%ebp),%eax
  802274:	8a 00                	mov    (%eax),%al
  802276:	3c 30                	cmp    $0x30,%al
  802278:	75 17                	jne    802291 <strtol+0x78>
  80227a:	8b 45 08             	mov    0x8(%ebp),%eax
  80227d:	40                   	inc    %eax
  80227e:	8a 00                	mov    (%eax),%al
  802280:	3c 78                	cmp    $0x78,%al
  802282:	75 0d                	jne    802291 <strtol+0x78>
		s += 2, base = 16;
  802284:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  802288:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80228f:	eb 28                	jmp    8022b9 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  802291:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802295:	75 15                	jne    8022ac <strtol+0x93>
  802297:	8b 45 08             	mov    0x8(%ebp),%eax
  80229a:	8a 00                	mov    (%eax),%al
  80229c:	3c 30                	cmp    $0x30,%al
  80229e:	75 0c                	jne    8022ac <strtol+0x93>
		s++, base = 8;
  8022a0:	ff 45 08             	incl   0x8(%ebp)
  8022a3:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8022aa:	eb 0d                	jmp    8022b9 <strtol+0xa0>
	else if (base == 0)
  8022ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8022b0:	75 07                	jne    8022b9 <strtol+0xa0>
		base = 10;
  8022b2:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8022b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022bc:	8a 00                	mov    (%eax),%al
  8022be:	3c 2f                	cmp    $0x2f,%al
  8022c0:	7e 19                	jle    8022db <strtol+0xc2>
  8022c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8022c5:	8a 00                	mov    (%eax),%al
  8022c7:	3c 39                	cmp    $0x39,%al
  8022c9:	7f 10                	jg     8022db <strtol+0xc2>
			dig = *s - '0';
  8022cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ce:	8a 00                	mov    (%eax),%al
  8022d0:	0f be c0             	movsbl %al,%eax
  8022d3:	83 e8 30             	sub    $0x30,%eax
  8022d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8022d9:	eb 42                	jmp    80231d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8022db:	8b 45 08             	mov    0x8(%ebp),%eax
  8022de:	8a 00                	mov    (%eax),%al
  8022e0:	3c 60                	cmp    $0x60,%al
  8022e2:	7e 19                	jle    8022fd <strtol+0xe4>
  8022e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e7:	8a 00                	mov    (%eax),%al
  8022e9:	3c 7a                	cmp    $0x7a,%al
  8022eb:	7f 10                	jg     8022fd <strtol+0xe4>
			dig = *s - 'a' + 10;
  8022ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8022f0:	8a 00                	mov    (%eax),%al
  8022f2:	0f be c0             	movsbl %al,%eax
  8022f5:	83 e8 57             	sub    $0x57,%eax
  8022f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8022fb:	eb 20                	jmp    80231d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8022fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802300:	8a 00                	mov    (%eax),%al
  802302:	3c 40                	cmp    $0x40,%al
  802304:	7e 39                	jle    80233f <strtol+0x126>
  802306:	8b 45 08             	mov    0x8(%ebp),%eax
  802309:	8a 00                	mov    (%eax),%al
  80230b:	3c 5a                	cmp    $0x5a,%al
  80230d:	7f 30                	jg     80233f <strtol+0x126>
			dig = *s - 'A' + 10;
  80230f:	8b 45 08             	mov    0x8(%ebp),%eax
  802312:	8a 00                	mov    (%eax),%al
  802314:	0f be c0             	movsbl %al,%eax
  802317:	83 e8 37             	sub    $0x37,%eax
  80231a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80231d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802320:	3b 45 10             	cmp    0x10(%ebp),%eax
  802323:	7d 19                	jge    80233e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802325:	ff 45 08             	incl   0x8(%ebp)
  802328:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80232b:	0f af 45 10          	imul   0x10(%ebp),%eax
  80232f:	89 c2                	mov    %eax,%edx
  802331:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802334:	01 d0                	add    %edx,%eax
  802336:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  802339:	e9 7b ff ff ff       	jmp    8022b9 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80233e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80233f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802343:	74 08                	je     80234d <strtol+0x134>
		*endptr = (char *) s;
  802345:	8b 45 0c             	mov    0xc(%ebp),%eax
  802348:	8b 55 08             	mov    0x8(%ebp),%edx
  80234b:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80234d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802351:	74 07                	je     80235a <strtol+0x141>
  802353:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802356:	f7 d8                	neg    %eax
  802358:	eb 03                	jmp    80235d <strtol+0x144>
  80235a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80235d:	c9                   	leave  
  80235e:	c3                   	ret    

0080235f <ltostr>:

void
ltostr(long value, char *str)
{
  80235f:	55                   	push   %ebp
  802360:	89 e5                	mov    %esp,%ebp
  802362:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802365:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80236c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  802373:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802377:	79 13                	jns    80238c <ltostr+0x2d>
	{
		neg = 1;
  802379:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  802380:	8b 45 0c             	mov    0xc(%ebp),%eax
  802383:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  802386:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802389:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80238c:	8b 45 08             	mov    0x8(%ebp),%eax
  80238f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  802394:	99                   	cltd   
  802395:	f7 f9                	idiv   %ecx
  802397:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80239a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80239d:	8d 50 01             	lea    0x1(%eax),%edx
  8023a0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8023a3:	89 c2                	mov    %eax,%edx
  8023a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023a8:	01 d0                	add    %edx,%eax
  8023aa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8023ad:	83 c2 30             	add    $0x30,%edx
  8023b0:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8023b2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8023b5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8023ba:	f7 e9                	imul   %ecx
  8023bc:	c1 fa 02             	sar    $0x2,%edx
  8023bf:	89 c8                	mov    %ecx,%eax
  8023c1:	c1 f8 1f             	sar    $0x1f,%eax
  8023c4:	29 c2                	sub    %eax,%edx
  8023c6:	89 d0                	mov    %edx,%eax
  8023c8:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8023cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8023ce:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8023d3:	f7 e9                	imul   %ecx
  8023d5:	c1 fa 02             	sar    $0x2,%edx
  8023d8:	89 c8                	mov    %ecx,%eax
  8023da:	c1 f8 1f             	sar    $0x1f,%eax
  8023dd:	29 c2                	sub    %eax,%edx
  8023df:	89 d0                	mov    %edx,%eax
  8023e1:	c1 e0 02             	shl    $0x2,%eax
  8023e4:	01 d0                	add    %edx,%eax
  8023e6:	01 c0                	add    %eax,%eax
  8023e8:	29 c1                	sub    %eax,%ecx
  8023ea:	89 ca                	mov    %ecx,%edx
  8023ec:	85 d2                	test   %edx,%edx
  8023ee:	75 9c                	jne    80238c <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8023f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8023f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023fa:	48                   	dec    %eax
  8023fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8023fe:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802402:	74 3d                	je     802441 <ltostr+0xe2>
		start = 1 ;
  802404:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80240b:	eb 34                	jmp    802441 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80240d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802410:	8b 45 0c             	mov    0xc(%ebp),%eax
  802413:	01 d0                	add    %edx,%eax
  802415:	8a 00                	mov    (%eax),%al
  802417:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80241a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80241d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802420:	01 c2                	add    %eax,%edx
  802422:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802425:	8b 45 0c             	mov    0xc(%ebp),%eax
  802428:	01 c8                	add    %ecx,%eax
  80242a:	8a 00                	mov    (%eax),%al
  80242c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80242e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802431:	8b 45 0c             	mov    0xc(%ebp),%eax
  802434:	01 c2                	add    %eax,%edx
  802436:	8a 45 eb             	mov    -0x15(%ebp),%al
  802439:	88 02                	mov    %al,(%edx)
		start++ ;
  80243b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80243e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  802441:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802444:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802447:	7c c4                	jl     80240d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802449:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80244c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80244f:	01 d0                	add    %edx,%eax
  802451:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  802454:	90                   	nop
  802455:	c9                   	leave  
  802456:	c3                   	ret    

00802457 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802457:	55                   	push   %ebp
  802458:	89 e5                	mov    %esp,%ebp
  80245a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80245d:	ff 75 08             	pushl  0x8(%ebp)
  802460:	e8 54 fa ff ff       	call   801eb9 <strlen>
  802465:	83 c4 04             	add    $0x4,%esp
  802468:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80246b:	ff 75 0c             	pushl  0xc(%ebp)
  80246e:	e8 46 fa ff ff       	call   801eb9 <strlen>
  802473:	83 c4 04             	add    $0x4,%esp
  802476:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802479:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  802480:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802487:	eb 17                	jmp    8024a0 <strcconcat+0x49>
		final[s] = str1[s] ;
  802489:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80248c:	8b 45 10             	mov    0x10(%ebp),%eax
  80248f:	01 c2                	add    %eax,%edx
  802491:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  802494:	8b 45 08             	mov    0x8(%ebp),%eax
  802497:	01 c8                	add    %ecx,%eax
  802499:	8a 00                	mov    (%eax),%al
  80249b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80249d:	ff 45 fc             	incl   -0x4(%ebp)
  8024a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024a3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8024a6:	7c e1                	jl     802489 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8024a8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8024af:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8024b6:	eb 1f                	jmp    8024d7 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8024b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024bb:	8d 50 01             	lea    0x1(%eax),%edx
  8024be:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8024c1:	89 c2                	mov    %eax,%edx
  8024c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8024c6:	01 c2                	add    %eax,%edx
  8024c8:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8024cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024ce:	01 c8                	add    %ecx,%eax
  8024d0:	8a 00                	mov    (%eax),%al
  8024d2:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8024d4:	ff 45 f8             	incl   -0x8(%ebp)
  8024d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8024da:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8024dd:	7c d9                	jl     8024b8 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8024df:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8024e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8024e5:	01 d0                	add    %edx,%eax
  8024e7:	c6 00 00             	movb   $0x0,(%eax)
}
  8024ea:	90                   	nop
  8024eb:	c9                   	leave  
  8024ec:	c3                   	ret    

008024ed <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8024ed:	55                   	push   %ebp
  8024ee:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8024f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8024f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8024f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8024fc:	8b 00                	mov    (%eax),%eax
  8024fe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802505:	8b 45 10             	mov    0x10(%ebp),%eax
  802508:	01 d0                	add    %edx,%eax
  80250a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802510:	eb 0c                	jmp    80251e <strsplit+0x31>
			*string++ = 0;
  802512:	8b 45 08             	mov    0x8(%ebp),%eax
  802515:	8d 50 01             	lea    0x1(%eax),%edx
  802518:	89 55 08             	mov    %edx,0x8(%ebp)
  80251b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80251e:	8b 45 08             	mov    0x8(%ebp),%eax
  802521:	8a 00                	mov    (%eax),%al
  802523:	84 c0                	test   %al,%al
  802525:	74 18                	je     80253f <strsplit+0x52>
  802527:	8b 45 08             	mov    0x8(%ebp),%eax
  80252a:	8a 00                	mov    (%eax),%al
  80252c:	0f be c0             	movsbl %al,%eax
  80252f:	50                   	push   %eax
  802530:	ff 75 0c             	pushl  0xc(%ebp)
  802533:	e8 13 fb ff ff       	call   80204b <strchr>
  802538:	83 c4 08             	add    $0x8,%esp
  80253b:	85 c0                	test   %eax,%eax
  80253d:	75 d3                	jne    802512 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80253f:	8b 45 08             	mov    0x8(%ebp),%eax
  802542:	8a 00                	mov    (%eax),%al
  802544:	84 c0                	test   %al,%al
  802546:	74 5a                	je     8025a2 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  802548:	8b 45 14             	mov    0x14(%ebp),%eax
  80254b:	8b 00                	mov    (%eax),%eax
  80254d:	83 f8 0f             	cmp    $0xf,%eax
  802550:	75 07                	jne    802559 <strsplit+0x6c>
		{
			return 0;
  802552:	b8 00 00 00 00       	mov    $0x0,%eax
  802557:	eb 66                	jmp    8025bf <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802559:	8b 45 14             	mov    0x14(%ebp),%eax
  80255c:	8b 00                	mov    (%eax),%eax
  80255e:	8d 48 01             	lea    0x1(%eax),%ecx
  802561:	8b 55 14             	mov    0x14(%ebp),%edx
  802564:	89 0a                	mov    %ecx,(%edx)
  802566:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80256d:	8b 45 10             	mov    0x10(%ebp),%eax
  802570:	01 c2                	add    %eax,%edx
  802572:	8b 45 08             	mov    0x8(%ebp),%eax
  802575:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802577:	eb 03                	jmp    80257c <strsplit+0x8f>
			string++;
  802579:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80257c:	8b 45 08             	mov    0x8(%ebp),%eax
  80257f:	8a 00                	mov    (%eax),%al
  802581:	84 c0                	test   %al,%al
  802583:	74 8b                	je     802510 <strsplit+0x23>
  802585:	8b 45 08             	mov    0x8(%ebp),%eax
  802588:	8a 00                	mov    (%eax),%al
  80258a:	0f be c0             	movsbl %al,%eax
  80258d:	50                   	push   %eax
  80258e:	ff 75 0c             	pushl  0xc(%ebp)
  802591:	e8 b5 fa ff ff       	call   80204b <strchr>
  802596:	83 c4 08             	add    $0x8,%esp
  802599:	85 c0                	test   %eax,%eax
  80259b:	74 dc                	je     802579 <strsplit+0x8c>
			string++;
	}
  80259d:	e9 6e ff ff ff       	jmp    802510 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8025a2:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8025a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8025a6:	8b 00                	mov    (%eax),%eax
  8025a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8025af:	8b 45 10             	mov    0x10(%ebp),%eax
  8025b2:	01 d0                	add    %edx,%eax
  8025b4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8025ba:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8025bf:	c9                   	leave  
  8025c0:	c3                   	ret    

008025c1 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8025c1:	55                   	push   %ebp
  8025c2:	89 e5                	mov    %esp,%ebp
  8025c4:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  8025c7:	e8 3b 09 00 00       	call   802f07 <sys_isUHeapPlacementStrategyFIRSTFIT>
  8025cc:	85 c0                	test   %eax,%eax
  8025ce:	0f 84 3a 01 00 00    	je     80270e <malloc+0x14d>

		if(pl == 0){
  8025d4:	a1 28 40 80 00       	mov    0x804028,%eax
  8025d9:	85 c0                	test   %eax,%eax
  8025db:	75 24                	jne    802601 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  8025dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8025e4:	eb 11                	jmp    8025f7 <malloc+0x36>
				arr[k] = -10000;
  8025e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8025e9:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  8025f0:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  8025f4:	ff 45 f4             	incl   -0xc(%ebp)
  8025f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8025fa:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8025ff:	76 e5                	jbe    8025e6 <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  802601:	c7 05 28 40 80 00 01 	movl   $0x1,0x804028
  802608:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  80260b:	8b 45 08             	mov    0x8(%ebp),%eax
  80260e:	c1 e8 0c             	shr    $0xc,%eax
  802611:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  802614:	8b 45 08             	mov    0x8(%ebp),%eax
  802617:	25 ff 0f 00 00       	and    $0xfff,%eax
  80261c:	85 c0                	test   %eax,%eax
  80261e:	74 03                	je     802623 <malloc+0x62>
			x++;
  802620:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  802623:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  80262a:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  802631:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  802638:	eb 66                	jmp    8026a0 <malloc+0xdf>
			if( arr[k] == -10000){
  80263a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80263d:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802644:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  802649:	75 52                	jne    80269d <malloc+0xdc>
				uint32 w = 0 ;
  80264b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  802652:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802655:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  802658:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80265b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80265e:	eb 09                	jmp    802669 <malloc+0xa8>
  802660:	ff 45 e0             	incl   -0x20(%ebp)
  802663:	ff 45 dc             	incl   -0x24(%ebp)
  802666:	ff 45 e4             	incl   -0x1c(%ebp)
  802669:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80266c:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802671:	77 19                	ja     80268c <malloc+0xcb>
  802673:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802676:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  80267d:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  802682:	75 08                	jne    80268c <malloc+0xcb>
  802684:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802687:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80268a:	72 d4                	jb     802660 <malloc+0x9f>
				if(w >= x){
  80268c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80268f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802692:	72 09                	jb     80269d <malloc+0xdc>
					p = 1 ;
  802694:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  80269b:	eb 0d                	jmp    8026aa <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  80269d:	ff 45 e4             	incl   -0x1c(%ebp)
  8026a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8026a3:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8026a8:	76 90                	jbe    80263a <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  8026aa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8026ae:	75 0a                	jne    8026ba <malloc+0xf9>
  8026b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8026b5:	e9 ca 01 00 00       	jmp    802884 <malloc+0x2c3>
		int q = idx;
  8026ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8026bd:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  8026c0:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8026c7:	eb 16                	jmp    8026df <malloc+0x11e>
			arr[q++] = x;
  8026c9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8026cc:	8d 50 01             	lea    0x1(%eax),%edx
  8026cf:	89 55 d8             	mov    %edx,-0x28(%ebp)
  8026d2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8026d5:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  8026dc:	ff 45 d4             	incl   -0x2c(%ebp)
  8026df:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8026e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8026e5:	72 e2                	jb     8026c9 <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  8026e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8026ea:	05 00 00 08 00       	add    $0x80000,%eax
  8026ef:	c1 e0 0c             	shl    $0xc,%eax
  8026f2:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  8026f5:	83 ec 08             	sub    $0x8,%esp
  8026f8:	ff 75 f0             	pushl  -0x10(%ebp)
  8026fb:	ff 75 ac             	pushl  -0x54(%ebp)
  8026fe:	e8 9b 04 00 00       	call   802b9e <sys_allocateMem>
  802703:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  802706:	8b 45 ac             	mov    -0x54(%ebp),%eax
  802709:	e9 76 01 00 00       	jmp    802884 <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  80270e:	e8 25 08 00 00       	call   802f38 <sys_isUHeapPlacementStrategyBESTFIT>
  802713:	85 c0                	test   %eax,%eax
  802715:	0f 84 64 01 00 00    	je     80287f <malloc+0x2be>
		if(pl == 0){
  80271b:	a1 28 40 80 00       	mov    0x804028,%eax
  802720:	85 c0                	test   %eax,%eax
  802722:	75 24                	jne    802748 <malloc+0x187>
			for(int k = 0; k < Size; k++){
  802724:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  80272b:	eb 11                	jmp    80273e <malloc+0x17d>
				arr[k] = -10000;
  80272d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  802730:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  802737:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  80273b:	ff 45 d0             	incl   -0x30(%ebp)
  80273e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  802741:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802746:	76 e5                	jbe    80272d <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  802748:	c7 05 28 40 80 00 01 	movl   $0x1,0x804028
  80274f:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  802752:	8b 45 08             	mov    0x8(%ebp),%eax
  802755:	c1 e8 0c             	shr    $0xc,%eax
  802758:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  80275b:	8b 45 08             	mov    0x8(%ebp),%eax
  80275e:	25 ff 0f 00 00       	and    $0xfff,%eax
  802763:	85 c0                	test   %eax,%eax
  802765:	74 03                	je     80276a <malloc+0x1a9>
			x++;
  802767:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  80276a:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  802771:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  802778:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  80277f:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  802786:	e9 88 00 00 00       	jmp    802813 <malloc+0x252>
			if(arr[k] == -10000){
  80278b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80278e:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802795:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  80279a:	75 64                	jne    802800 <malloc+0x23f>
				uint32 w = 0 , i;
  80279c:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  8027a3:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8027a6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8027a9:	eb 06                	jmp    8027b1 <malloc+0x1f0>
  8027ab:	ff 45 b8             	incl   -0x48(%ebp)
  8027ae:	ff 45 b4             	incl   -0x4c(%ebp)
  8027b1:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  8027b8:	77 11                	ja     8027cb <malloc+0x20a>
  8027ba:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8027bd:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8027c4:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  8027c9:	74 e0                	je     8027ab <malloc+0x1ea>
				if(w <q && w >= x){
  8027cb:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8027ce:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  8027d1:	73 24                	jae    8027f7 <malloc+0x236>
  8027d3:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8027d6:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  8027d9:	72 1c                	jb     8027f7 <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  8027db:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8027de:	89 45 c8             	mov    %eax,-0x38(%ebp)
  8027e1:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  8027e8:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8027eb:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8027ee:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8027f1:	48                   	dec    %eax
  8027f2:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8027f5:	eb 19                	jmp    802810 <malloc+0x24f>
				}
				else {
					k = i - 1;
  8027f7:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8027fa:	48                   	dec    %eax
  8027fb:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8027fe:	eb 10                	jmp    802810 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  802800:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802803:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  80280a:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  80280d:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  802810:	ff 45 bc             	incl   -0x44(%ebp)
  802813:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802816:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80281b:	0f 86 6a ff ff ff    	jbe    80278b <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  802821:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  802825:	75 07                	jne    80282e <malloc+0x26d>
  802827:	b8 00 00 00 00       	mov    $0x0,%eax
  80282c:	eb 56                	jmp    802884 <malloc+0x2c3>
	    q = idx;
  80282e:	8b 45 c0             	mov    -0x40(%ebp),%eax
  802831:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  802834:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  80283b:	eb 16                	jmp    802853 <malloc+0x292>
			arr[q++] = x;
  80283d:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802840:	8d 50 01             	lea    0x1(%eax),%edx
  802843:	89 55 c8             	mov    %edx,-0x38(%ebp)
  802846:	8b 55 cc             	mov    -0x34(%ebp),%edx
  802849:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  802850:	ff 45 b0             	incl   -0x50(%ebp)
  802853:	8b 45 b0             	mov    -0x50(%ebp),%eax
  802856:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  802859:	72 e2                	jb     80283d <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  80285b:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80285e:	05 00 00 08 00       	add    $0x80000,%eax
  802863:	c1 e0 0c             	shl    $0xc,%eax
  802866:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  802869:	83 ec 08             	sub    $0x8,%esp
  80286c:	ff 75 cc             	pushl  -0x34(%ebp)
  80286f:	ff 75 a8             	pushl  -0x58(%ebp)
  802872:	e8 27 03 00 00       	call   802b9e <sys_allocateMem>
  802877:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  80287a:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80287d:	eb 05                	jmp    802884 <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  80287f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802884:	c9                   	leave  
  802885:	c3                   	ret    

00802886 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  802886:	55                   	push   %ebp
  802887:	89 e5                	mov    %esp,%ebp
  802889:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  80288c:	8b 45 08             	mov    0x8(%ebp),%eax
  80288f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  802892:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802895:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80289a:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  80289d:	8b 45 08             	mov    0x8(%ebp),%eax
  8028a0:	05 00 00 00 80       	add    $0x80000000,%eax
  8028a5:	c1 e8 0c             	shr    $0xc,%eax
  8028a8:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8028af:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  8028b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8028b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8028bc:	05 00 00 00 80       	add    $0x80000000,%eax
  8028c1:	c1 e8 0c             	shr    $0xc,%eax
  8028c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8028c7:	eb 14                	jmp    8028dd <free+0x57>
		arr[j] = -10000;
  8028c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8028cc:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  8028d3:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  8028d7:	ff 45 f4             	incl   -0xc(%ebp)
  8028da:	ff 45 f0             	incl   -0x10(%ebp)
  8028dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8028e0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8028e3:	72 e4                	jb     8028c9 <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  8028e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8028e8:	83 ec 08             	sub    $0x8,%esp
  8028eb:	ff 75 e8             	pushl  -0x18(%ebp)
  8028ee:	50                   	push   %eax
  8028ef:	e8 8e 02 00 00       	call   802b82 <sys_freeMem>
  8028f4:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  8028f7:	90                   	nop
  8028f8:	c9                   	leave  
  8028f9:	c3                   	ret    

008028fa <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8028fa:	55                   	push   %ebp
  8028fb:	89 e5                	mov    %esp,%ebp
  8028fd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802900:	83 ec 04             	sub    $0x4,%esp
  802903:	68 b0 3a 80 00       	push   $0x803ab0
  802908:	68 9e 00 00 00       	push   $0x9e
  80290d:	68 d3 3a 80 00       	push   $0x803ad3
  802912:	e8 69 ec ff ff       	call   801580 <_panic>

00802917 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  802917:	55                   	push   %ebp
  802918:	89 e5                	mov    %esp,%ebp
  80291a:	83 ec 18             	sub    $0x18,%esp
  80291d:	8b 45 10             	mov    0x10(%ebp),%eax
  802920:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802923:	83 ec 04             	sub    $0x4,%esp
  802926:	68 b0 3a 80 00       	push   $0x803ab0
  80292b:	68 a9 00 00 00       	push   $0xa9
  802930:	68 d3 3a 80 00       	push   $0x803ad3
  802935:	e8 46 ec ff ff       	call   801580 <_panic>

0080293a <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80293a:	55                   	push   %ebp
  80293b:	89 e5                	mov    %esp,%ebp
  80293d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802940:	83 ec 04             	sub    $0x4,%esp
  802943:	68 b0 3a 80 00       	push   $0x803ab0
  802948:	68 af 00 00 00       	push   $0xaf
  80294d:	68 d3 3a 80 00       	push   $0x803ad3
  802952:	e8 29 ec ff ff       	call   801580 <_panic>

00802957 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  802957:	55                   	push   %ebp
  802958:	89 e5                	mov    %esp,%ebp
  80295a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80295d:	83 ec 04             	sub    $0x4,%esp
  802960:	68 b0 3a 80 00       	push   $0x803ab0
  802965:	68 b5 00 00 00       	push   $0xb5
  80296a:	68 d3 3a 80 00       	push   $0x803ad3
  80296f:	e8 0c ec ff ff       	call   801580 <_panic>

00802974 <expand>:
}

void expand(uint32 newSize)
{
  802974:	55                   	push   %ebp
  802975:	89 e5                	mov    %esp,%ebp
  802977:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80297a:	83 ec 04             	sub    $0x4,%esp
  80297d:	68 b0 3a 80 00       	push   $0x803ab0
  802982:	68 ba 00 00 00       	push   $0xba
  802987:	68 d3 3a 80 00       	push   $0x803ad3
  80298c:	e8 ef eb ff ff       	call   801580 <_panic>

00802991 <shrink>:
}
void shrink(uint32 newSize)
{
  802991:	55                   	push   %ebp
  802992:	89 e5                	mov    %esp,%ebp
  802994:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802997:	83 ec 04             	sub    $0x4,%esp
  80299a:	68 b0 3a 80 00       	push   $0x803ab0
  80299f:	68 be 00 00 00       	push   $0xbe
  8029a4:	68 d3 3a 80 00       	push   $0x803ad3
  8029a9:	e8 d2 eb ff ff       	call   801580 <_panic>

008029ae <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8029ae:	55                   	push   %ebp
  8029af:	89 e5                	mov    %esp,%ebp
  8029b1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8029b4:	83 ec 04             	sub    $0x4,%esp
  8029b7:	68 b0 3a 80 00       	push   $0x803ab0
  8029bc:	68 c3 00 00 00       	push   $0xc3
  8029c1:	68 d3 3a 80 00       	push   $0x803ad3
  8029c6:	e8 b5 eb ff ff       	call   801580 <_panic>

008029cb <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8029cb:	55                   	push   %ebp
  8029cc:	89 e5                	mov    %esp,%ebp
  8029ce:	57                   	push   %edi
  8029cf:	56                   	push   %esi
  8029d0:	53                   	push   %ebx
  8029d1:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8029d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8029d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8029da:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8029dd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8029e0:	8b 7d 18             	mov    0x18(%ebp),%edi
  8029e3:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8029e6:	cd 30                	int    $0x30
  8029e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8029eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8029ee:	83 c4 10             	add    $0x10,%esp
  8029f1:	5b                   	pop    %ebx
  8029f2:	5e                   	pop    %esi
  8029f3:	5f                   	pop    %edi
  8029f4:	5d                   	pop    %ebp
  8029f5:	c3                   	ret    

008029f6 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8029f6:	55                   	push   %ebp
  8029f7:	89 e5                	mov    %esp,%ebp
  8029f9:	83 ec 04             	sub    $0x4,%esp
  8029fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8029ff:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802a02:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802a06:	8b 45 08             	mov    0x8(%ebp),%eax
  802a09:	6a 00                	push   $0x0
  802a0b:	6a 00                	push   $0x0
  802a0d:	52                   	push   %edx
  802a0e:	ff 75 0c             	pushl  0xc(%ebp)
  802a11:	50                   	push   %eax
  802a12:	6a 00                	push   $0x0
  802a14:	e8 b2 ff ff ff       	call   8029cb <syscall>
  802a19:	83 c4 18             	add    $0x18,%esp
}
  802a1c:	90                   	nop
  802a1d:	c9                   	leave  
  802a1e:	c3                   	ret    

00802a1f <sys_cgetc>:

int
sys_cgetc(void)
{
  802a1f:	55                   	push   %ebp
  802a20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802a22:	6a 00                	push   $0x0
  802a24:	6a 00                	push   $0x0
  802a26:	6a 00                	push   $0x0
  802a28:	6a 00                	push   $0x0
  802a2a:	6a 00                	push   $0x0
  802a2c:	6a 01                	push   $0x1
  802a2e:	e8 98 ff ff ff       	call   8029cb <syscall>
  802a33:	83 c4 18             	add    $0x18,%esp
}
  802a36:	c9                   	leave  
  802a37:	c3                   	ret    

00802a38 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802a38:	55                   	push   %ebp
  802a39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802a3b:	8b 45 08             	mov    0x8(%ebp),%eax
  802a3e:	6a 00                	push   $0x0
  802a40:	6a 00                	push   $0x0
  802a42:	6a 00                	push   $0x0
  802a44:	6a 00                	push   $0x0
  802a46:	50                   	push   %eax
  802a47:	6a 05                	push   $0x5
  802a49:	e8 7d ff ff ff       	call   8029cb <syscall>
  802a4e:	83 c4 18             	add    $0x18,%esp
}
  802a51:	c9                   	leave  
  802a52:	c3                   	ret    

00802a53 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802a53:	55                   	push   %ebp
  802a54:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802a56:	6a 00                	push   $0x0
  802a58:	6a 00                	push   $0x0
  802a5a:	6a 00                	push   $0x0
  802a5c:	6a 00                	push   $0x0
  802a5e:	6a 00                	push   $0x0
  802a60:	6a 02                	push   $0x2
  802a62:	e8 64 ff ff ff       	call   8029cb <syscall>
  802a67:	83 c4 18             	add    $0x18,%esp
}
  802a6a:	c9                   	leave  
  802a6b:	c3                   	ret    

00802a6c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802a6c:	55                   	push   %ebp
  802a6d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802a6f:	6a 00                	push   $0x0
  802a71:	6a 00                	push   $0x0
  802a73:	6a 00                	push   $0x0
  802a75:	6a 00                	push   $0x0
  802a77:	6a 00                	push   $0x0
  802a79:	6a 03                	push   $0x3
  802a7b:	e8 4b ff ff ff       	call   8029cb <syscall>
  802a80:	83 c4 18             	add    $0x18,%esp
}
  802a83:	c9                   	leave  
  802a84:	c3                   	ret    

00802a85 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802a85:	55                   	push   %ebp
  802a86:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802a88:	6a 00                	push   $0x0
  802a8a:	6a 00                	push   $0x0
  802a8c:	6a 00                	push   $0x0
  802a8e:	6a 00                	push   $0x0
  802a90:	6a 00                	push   $0x0
  802a92:	6a 04                	push   $0x4
  802a94:	e8 32 ff ff ff       	call   8029cb <syscall>
  802a99:	83 c4 18             	add    $0x18,%esp
}
  802a9c:	c9                   	leave  
  802a9d:	c3                   	ret    

00802a9e <sys_env_exit>:


void sys_env_exit(void)
{
  802a9e:	55                   	push   %ebp
  802a9f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802aa1:	6a 00                	push   $0x0
  802aa3:	6a 00                	push   $0x0
  802aa5:	6a 00                	push   $0x0
  802aa7:	6a 00                	push   $0x0
  802aa9:	6a 00                	push   $0x0
  802aab:	6a 06                	push   $0x6
  802aad:	e8 19 ff ff ff       	call   8029cb <syscall>
  802ab2:	83 c4 18             	add    $0x18,%esp
}
  802ab5:	90                   	nop
  802ab6:	c9                   	leave  
  802ab7:	c3                   	ret    

00802ab8 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802ab8:	55                   	push   %ebp
  802ab9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802abb:	8b 55 0c             	mov    0xc(%ebp),%edx
  802abe:	8b 45 08             	mov    0x8(%ebp),%eax
  802ac1:	6a 00                	push   $0x0
  802ac3:	6a 00                	push   $0x0
  802ac5:	6a 00                	push   $0x0
  802ac7:	52                   	push   %edx
  802ac8:	50                   	push   %eax
  802ac9:	6a 07                	push   $0x7
  802acb:	e8 fb fe ff ff       	call   8029cb <syscall>
  802ad0:	83 c4 18             	add    $0x18,%esp
}
  802ad3:	c9                   	leave  
  802ad4:	c3                   	ret    

00802ad5 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802ad5:	55                   	push   %ebp
  802ad6:	89 e5                	mov    %esp,%ebp
  802ad8:	56                   	push   %esi
  802ad9:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802ada:	8b 75 18             	mov    0x18(%ebp),%esi
  802add:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802ae0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802ae3:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  802ae9:	56                   	push   %esi
  802aea:	53                   	push   %ebx
  802aeb:	51                   	push   %ecx
  802aec:	52                   	push   %edx
  802aed:	50                   	push   %eax
  802aee:	6a 08                	push   $0x8
  802af0:	e8 d6 fe ff ff       	call   8029cb <syscall>
  802af5:	83 c4 18             	add    $0x18,%esp
}
  802af8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802afb:	5b                   	pop    %ebx
  802afc:	5e                   	pop    %esi
  802afd:	5d                   	pop    %ebp
  802afe:	c3                   	ret    

00802aff <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802aff:	55                   	push   %ebp
  802b00:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802b02:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b05:	8b 45 08             	mov    0x8(%ebp),%eax
  802b08:	6a 00                	push   $0x0
  802b0a:	6a 00                	push   $0x0
  802b0c:	6a 00                	push   $0x0
  802b0e:	52                   	push   %edx
  802b0f:	50                   	push   %eax
  802b10:	6a 09                	push   $0x9
  802b12:	e8 b4 fe ff ff       	call   8029cb <syscall>
  802b17:	83 c4 18             	add    $0x18,%esp
}
  802b1a:	c9                   	leave  
  802b1b:	c3                   	ret    

00802b1c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802b1c:	55                   	push   %ebp
  802b1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802b1f:	6a 00                	push   $0x0
  802b21:	6a 00                	push   $0x0
  802b23:	6a 00                	push   $0x0
  802b25:	ff 75 0c             	pushl  0xc(%ebp)
  802b28:	ff 75 08             	pushl  0x8(%ebp)
  802b2b:	6a 0a                	push   $0xa
  802b2d:	e8 99 fe ff ff       	call   8029cb <syscall>
  802b32:	83 c4 18             	add    $0x18,%esp
}
  802b35:	c9                   	leave  
  802b36:	c3                   	ret    

00802b37 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802b37:	55                   	push   %ebp
  802b38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802b3a:	6a 00                	push   $0x0
  802b3c:	6a 00                	push   $0x0
  802b3e:	6a 00                	push   $0x0
  802b40:	6a 00                	push   $0x0
  802b42:	6a 00                	push   $0x0
  802b44:	6a 0b                	push   $0xb
  802b46:	e8 80 fe ff ff       	call   8029cb <syscall>
  802b4b:	83 c4 18             	add    $0x18,%esp
}
  802b4e:	c9                   	leave  
  802b4f:	c3                   	ret    

00802b50 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802b50:	55                   	push   %ebp
  802b51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802b53:	6a 00                	push   $0x0
  802b55:	6a 00                	push   $0x0
  802b57:	6a 00                	push   $0x0
  802b59:	6a 00                	push   $0x0
  802b5b:	6a 00                	push   $0x0
  802b5d:	6a 0c                	push   $0xc
  802b5f:	e8 67 fe ff ff       	call   8029cb <syscall>
  802b64:	83 c4 18             	add    $0x18,%esp
}
  802b67:	c9                   	leave  
  802b68:	c3                   	ret    

00802b69 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802b69:	55                   	push   %ebp
  802b6a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802b6c:	6a 00                	push   $0x0
  802b6e:	6a 00                	push   $0x0
  802b70:	6a 00                	push   $0x0
  802b72:	6a 00                	push   $0x0
  802b74:	6a 00                	push   $0x0
  802b76:	6a 0d                	push   $0xd
  802b78:	e8 4e fe ff ff       	call   8029cb <syscall>
  802b7d:	83 c4 18             	add    $0x18,%esp
}
  802b80:	c9                   	leave  
  802b81:	c3                   	ret    

00802b82 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802b82:	55                   	push   %ebp
  802b83:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802b85:	6a 00                	push   $0x0
  802b87:	6a 00                	push   $0x0
  802b89:	6a 00                	push   $0x0
  802b8b:	ff 75 0c             	pushl  0xc(%ebp)
  802b8e:	ff 75 08             	pushl  0x8(%ebp)
  802b91:	6a 11                	push   $0x11
  802b93:	e8 33 fe ff ff       	call   8029cb <syscall>
  802b98:	83 c4 18             	add    $0x18,%esp
	return;
  802b9b:	90                   	nop
}
  802b9c:	c9                   	leave  
  802b9d:	c3                   	ret    

00802b9e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802b9e:	55                   	push   %ebp
  802b9f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802ba1:	6a 00                	push   $0x0
  802ba3:	6a 00                	push   $0x0
  802ba5:	6a 00                	push   $0x0
  802ba7:	ff 75 0c             	pushl  0xc(%ebp)
  802baa:	ff 75 08             	pushl  0x8(%ebp)
  802bad:	6a 12                	push   $0x12
  802baf:	e8 17 fe ff ff       	call   8029cb <syscall>
  802bb4:	83 c4 18             	add    $0x18,%esp
	return ;
  802bb7:	90                   	nop
}
  802bb8:	c9                   	leave  
  802bb9:	c3                   	ret    

00802bba <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802bba:	55                   	push   %ebp
  802bbb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802bbd:	6a 00                	push   $0x0
  802bbf:	6a 00                	push   $0x0
  802bc1:	6a 00                	push   $0x0
  802bc3:	6a 00                	push   $0x0
  802bc5:	6a 00                	push   $0x0
  802bc7:	6a 0e                	push   $0xe
  802bc9:	e8 fd fd ff ff       	call   8029cb <syscall>
  802bce:	83 c4 18             	add    $0x18,%esp
}
  802bd1:	c9                   	leave  
  802bd2:	c3                   	ret    

00802bd3 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802bd3:	55                   	push   %ebp
  802bd4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802bd6:	6a 00                	push   $0x0
  802bd8:	6a 00                	push   $0x0
  802bda:	6a 00                	push   $0x0
  802bdc:	6a 00                	push   $0x0
  802bde:	ff 75 08             	pushl  0x8(%ebp)
  802be1:	6a 0f                	push   $0xf
  802be3:	e8 e3 fd ff ff       	call   8029cb <syscall>
  802be8:	83 c4 18             	add    $0x18,%esp
}
  802beb:	c9                   	leave  
  802bec:	c3                   	ret    

00802bed <sys_scarce_memory>:

void sys_scarce_memory()
{
  802bed:	55                   	push   %ebp
  802bee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802bf0:	6a 00                	push   $0x0
  802bf2:	6a 00                	push   $0x0
  802bf4:	6a 00                	push   $0x0
  802bf6:	6a 00                	push   $0x0
  802bf8:	6a 00                	push   $0x0
  802bfa:	6a 10                	push   $0x10
  802bfc:	e8 ca fd ff ff       	call   8029cb <syscall>
  802c01:	83 c4 18             	add    $0x18,%esp
}
  802c04:	90                   	nop
  802c05:	c9                   	leave  
  802c06:	c3                   	ret    

00802c07 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802c07:	55                   	push   %ebp
  802c08:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802c0a:	6a 00                	push   $0x0
  802c0c:	6a 00                	push   $0x0
  802c0e:	6a 00                	push   $0x0
  802c10:	6a 00                	push   $0x0
  802c12:	6a 00                	push   $0x0
  802c14:	6a 14                	push   $0x14
  802c16:	e8 b0 fd ff ff       	call   8029cb <syscall>
  802c1b:	83 c4 18             	add    $0x18,%esp
}
  802c1e:	90                   	nop
  802c1f:	c9                   	leave  
  802c20:	c3                   	ret    

00802c21 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802c21:	55                   	push   %ebp
  802c22:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802c24:	6a 00                	push   $0x0
  802c26:	6a 00                	push   $0x0
  802c28:	6a 00                	push   $0x0
  802c2a:	6a 00                	push   $0x0
  802c2c:	6a 00                	push   $0x0
  802c2e:	6a 15                	push   $0x15
  802c30:	e8 96 fd ff ff       	call   8029cb <syscall>
  802c35:	83 c4 18             	add    $0x18,%esp
}
  802c38:	90                   	nop
  802c39:	c9                   	leave  
  802c3a:	c3                   	ret    

00802c3b <sys_cputc>:


void
sys_cputc(const char c)
{
  802c3b:	55                   	push   %ebp
  802c3c:	89 e5                	mov    %esp,%ebp
  802c3e:	83 ec 04             	sub    $0x4,%esp
  802c41:	8b 45 08             	mov    0x8(%ebp),%eax
  802c44:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802c47:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802c4b:	6a 00                	push   $0x0
  802c4d:	6a 00                	push   $0x0
  802c4f:	6a 00                	push   $0x0
  802c51:	6a 00                	push   $0x0
  802c53:	50                   	push   %eax
  802c54:	6a 16                	push   $0x16
  802c56:	e8 70 fd ff ff       	call   8029cb <syscall>
  802c5b:	83 c4 18             	add    $0x18,%esp
}
  802c5e:	90                   	nop
  802c5f:	c9                   	leave  
  802c60:	c3                   	ret    

00802c61 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802c61:	55                   	push   %ebp
  802c62:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802c64:	6a 00                	push   $0x0
  802c66:	6a 00                	push   $0x0
  802c68:	6a 00                	push   $0x0
  802c6a:	6a 00                	push   $0x0
  802c6c:	6a 00                	push   $0x0
  802c6e:	6a 17                	push   $0x17
  802c70:	e8 56 fd ff ff       	call   8029cb <syscall>
  802c75:	83 c4 18             	add    $0x18,%esp
}
  802c78:	90                   	nop
  802c79:	c9                   	leave  
  802c7a:	c3                   	ret    

00802c7b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802c7b:	55                   	push   %ebp
  802c7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  802c81:	6a 00                	push   $0x0
  802c83:	6a 00                	push   $0x0
  802c85:	6a 00                	push   $0x0
  802c87:	ff 75 0c             	pushl  0xc(%ebp)
  802c8a:	50                   	push   %eax
  802c8b:	6a 18                	push   $0x18
  802c8d:	e8 39 fd ff ff       	call   8029cb <syscall>
  802c92:	83 c4 18             	add    $0x18,%esp
}
  802c95:	c9                   	leave  
  802c96:	c3                   	ret    

00802c97 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802c97:	55                   	push   %ebp
  802c98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802c9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  802ca0:	6a 00                	push   $0x0
  802ca2:	6a 00                	push   $0x0
  802ca4:	6a 00                	push   $0x0
  802ca6:	52                   	push   %edx
  802ca7:	50                   	push   %eax
  802ca8:	6a 1b                	push   $0x1b
  802caa:	e8 1c fd ff ff       	call   8029cb <syscall>
  802caf:	83 c4 18             	add    $0x18,%esp
}
  802cb2:	c9                   	leave  
  802cb3:	c3                   	ret    

00802cb4 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802cb4:	55                   	push   %ebp
  802cb5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802cb7:	8b 55 0c             	mov    0xc(%ebp),%edx
  802cba:	8b 45 08             	mov    0x8(%ebp),%eax
  802cbd:	6a 00                	push   $0x0
  802cbf:	6a 00                	push   $0x0
  802cc1:	6a 00                	push   $0x0
  802cc3:	52                   	push   %edx
  802cc4:	50                   	push   %eax
  802cc5:	6a 19                	push   $0x19
  802cc7:	e8 ff fc ff ff       	call   8029cb <syscall>
  802ccc:	83 c4 18             	add    $0x18,%esp
}
  802ccf:	90                   	nop
  802cd0:	c9                   	leave  
  802cd1:	c3                   	ret    

00802cd2 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802cd2:	55                   	push   %ebp
  802cd3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802cd5:	8b 55 0c             	mov    0xc(%ebp),%edx
  802cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  802cdb:	6a 00                	push   $0x0
  802cdd:	6a 00                	push   $0x0
  802cdf:	6a 00                	push   $0x0
  802ce1:	52                   	push   %edx
  802ce2:	50                   	push   %eax
  802ce3:	6a 1a                	push   $0x1a
  802ce5:	e8 e1 fc ff ff       	call   8029cb <syscall>
  802cea:	83 c4 18             	add    $0x18,%esp
}
  802ced:	90                   	nop
  802cee:	c9                   	leave  
  802cef:	c3                   	ret    

00802cf0 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802cf0:	55                   	push   %ebp
  802cf1:	89 e5                	mov    %esp,%ebp
  802cf3:	83 ec 04             	sub    $0x4,%esp
  802cf6:	8b 45 10             	mov    0x10(%ebp),%eax
  802cf9:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802cfc:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802cff:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802d03:	8b 45 08             	mov    0x8(%ebp),%eax
  802d06:	6a 00                	push   $0x0
  802d08:	51                   	push   %ecx
  802d09:	52                   	push   %edx
  802d0a:	ff 75 0c             	pushl  0xc(%ebp)
  802d0d:	50                   	push   %eax
  802d0e:	6a 1c                	push   $0x1c
  802d10:	e8 b6 fc ff ff       	call   8029cb <syscall>
  802d15:	83 c4 18             	add    $0x18,%esp
}
  802d18:	c9                   	leave  
  802d19:	c3                   	ret    

00802d1a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802d1a:	55                   	push   %ebp
  802d1b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802d1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d20:	8b 45 08             	mov    0x8(%ebp),%eax
  802d23:	6a 00                	push   $0x0
  802d25:	6a 00                	push   $0x0
  802d27:	6a 00                	push   $0x0
  802d29:	52                   	push   %edx
  802d2a:	50                   	push   %eax
  802d2b:	6a 1d                	push   $0x1d
  802d2d:	e8 99 fc ff ff       	call   8029cb <syscall>
  802d32:	83 c4 18             	add    $0x18,%esp
}
  802d35:	c9                   	leave  
  802d36:	c3                   	ret    

00802d37 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802d37:	55                   	push   %ebp
  802d38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802d3a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802d3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d40:	8b 45 08             	mov    0x8(%ebp),%eax
  802d43:	6a 00                	push   $0x0
  802d45:	6a 00                	push   $0x0
  802d47:	51                   	push   %ecx
  802d48:	52                   	push   %edx
  802d49:	50                   	push   %eax
  802d4a:	6a 1e                	push   $0x1e
  802d4c:	e8 7a fc ff ff       	call   8029cb <syscall>
  802d51:	83 c4 18             	add    $0x18,%esp
}
  802d54:	c9                   	leave  
  802d55:	c3                   	ret    

00802d56 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802d56:	55                   	push   %ebp
  802d57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802d59:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  802d5f:	6a 00                	push   $0x0
  802d61:	6a 00                	push   $0x0
  802d63:	6a 00                	push   $0x0
  802d65:	52                   	push   %edx
  802d66:	50                   	push   %eax
  802d67:	6a 1f                	push   $0x1f
  802d69:	e8 5d fc ff ff       	call   8029cb <syscall>
  802d6e:	83 c4 18             	add    $0x18,%esp
}
  802d71:	c9                   	leave  
  802d72:	c3                   	ret    

00802d73 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802d73:	55                   	push   %ebp
  802d74:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802d76:	6a 00                	push   $0x0
  802d78:	6a 00                	push   $0x0
  802d7a:	6a 00                	push   $0x0
  802d7c:	6a 00                	push   $0x0
  802d7e:	6a 00                	push   $0x0
  802d80:	6a 20                	push   $0x20
  802d82:	e8 44 fc ff ff       	call   8029cb <syscall>
  802d87:	83 c4 18             	add    $0x18,%esp
}
  802d8a:	c9                   	leave  
  802d8b:	c3                   	ret    

00802d8c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802d8c:	55                   	push   %ebp
  802d8d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  802d92:	6a 00                	push   $0x0
  802d94:	ff 75 14             	pushl  0x14(%ebp)
  802d97:	ff 75 10             	pushl  0x10(%ebp)
  802d9a:	ff 75 0c             	pushl  0xc(%ebp)
  802d9d:	50                   	push   %eax
  802d9e:	6a 21                	push   $0x21
  802da0:	e8 26 fc ff ff       	call   8029cb <syscall>
  802da5:	83 c4 18             	add    $0x18,%esp
}
  802da8:	c9                   	leave  
  802da9:	c3                   	ret    

00802daa <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802daa:	55                   	push   %ebp
  802dab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802dad:	8b 45 08             	mov    0x8(%ebp),%eax
  802db0:	6a 00                	push   $0x0
  802db2:	6a 00                	push   $0x0
  802db4:	6a 00                	push   $0x0
  802db6:	6a 00                	push   $0x0
  802db8:	50                   	push   %eax
  802db9:	6a 22                	push   $0x22
  802dbb:	e8 0b fc ff ff       	call   8029cb <syscall>
  802dc0:	83 c4 18             	add    $0x18,%esp
}
  802dc3:	90                   	nop
  802dc4:	c9                   	leave  
  802dc5:	c3                   	ret    

00802dc6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802dc6:	55                   	push   %ebp
  802dc7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802dc9:	8b 45 08             	mov    0x8(%ebp),%eax
  802dcc:	6a 00                	push   $0x0
  802dce:	6a 00                	push   $0x0
  802dd0:	6a 00                	push   $0x0
  802dd2:	6a 00                	push   $0x0
  802dd4:	50                   	push   %eax
  802dd5:	6a 23                	push   $0x23
  802dd7:	e8 ef fb ff ff       	call   8029cb <syscall>
  802ddc:	83 c4 18             	add    $0x18,%esp
}
  802ddf:	90                   	nop
  802de0:	c9                   	leave  
  802de1:	c3                   	ret    

00802de2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802de2:	55                   	push   %ebp
  802de3:	89 e5                	mov    %esp,%ebp
  802de5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802de8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802deb:	8d 50 04             	lea    0x4(%eax),%edx
  802dee:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802df1:	6a 00                	push   $0x0
  802df3:	6a 00                	push   $0x0
  802df5:	6a 00                	push   $0x0
  802df7:	52                   	push   %edx
  802df8:	50                   	push   %eax
  802df9:	6a 24                	push   $0x24
  802dfb:	e8 cb fb ff ff       	call   8029cb <syscall>
  802e00:	83 c4 18             	add    $0x18,%esp
	return result;
  802e03:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802e06:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802e09:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802e0c:	89 01                	mov    %eax,(%ecx)
  802e0e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802e11:	8b 45 08             	mov    0x8(%ebp),%eax
  802e14:	c9                   	leave  
  802e15:	c2 04 00             	ret    $0x4

00802e18 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802e18:	55                   	push   %ebp
  802e19:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802e1b:	6a 00                	push   $0x0
  802e1d:	6a 00                	push   $0x0
  802e1f:	ff 75 10             	pushl  0x10(%ebp)
  802e22:	ff 75 0c             	pushl  0xc(%ebp)
  802e25:	ff 75 08             	pushl  0x8(%ebp)
  802e28:	6a 13                	push   $0x13
  802e2a:	e8 9c fb ff ff       	call   8029cb <syscall>
  802e2f:	83 c4 18             	add    $0x18,%esp
	return ;
  802e32:	90                   	nop
}
  802e33:	c9                   	leave  
  802e34:	c3                   	ret    

00802e35 <sys_rcr2>:
uint32 sys_rcr2()
{
  802e35:	55                   	push   %ebp
  802e36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802e38:	6a 00                	push   $0x0
  802e3a:	6a 00                	push   $0x0
  802e3c:	6a 00                	push   $0x0
  802e3e:	6a 00                	push   $0x0
  802e40:	6a 00                	push   $0x0
  802e42:	6a 25                	push   $0x25
  802e44:	e8 82 fb ff ff       	call   8029cb <syscall>
  802e49:	83 c4 18             	add    $0x18,%esp
}
  802e4c:	c9                   	leave  
  802e4d:	c3                   	ret    

00802e4e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802e4e:	55                   	push   %ebp
  802e4f:	89 e5                	mov    %esp,%ebp
  802e51:	83 ec 04             	sub    $0x4,%esp
  802e54:	8b 45 08             	mov    0x8(%ebp),%eax
  802e57:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802e5a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802e5e:	6a 00                	push   $0x0
  802e60:	6a 00                	push   $0x0
  802e62:	6a 00                	push   $0x0
  802e64:	6a 00                	push   $0x0
  802e66:	50                   	push   %eax
  802e67:	6a 26                	push   $0x26
  802e69:	e8 5d fb ff ff       	call   8029cb <syscall>
  802e6e:	83 c4 18             	add    $0x18,%esp
	return ;
  802e71:	90                   	nop
}
  802e72:	c9                   	leave  
  802e73:	c3                   	ret    

00802e74 <rsttst>:
void rsttst()
{
  802e74:	55                   	push   %ebp
  802e75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802e77:	6a 00                	push   $0x0
  802e79:	6a 00                	push   $0x0
  802e7b:	6a 00                	push   $0x0
  802e7d:	6a 00                	push   $0x0
  802e7f:	6a 00                	push   $0x0
  802e81:	6a 28                	push   $0x28
  802e83:	e8 43 fb ff ff       	call   8029cb <syscall>
  802e88:	83 c4 18             	add    $0x18,%esp
	return ;
  802e8b:	90                   	nop
}
  802e8c:	c9                   	leave  
  802e8d:	c3                   	ret    

00802e8e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802e8e:	55                   	push   %ebp
  802e8f:	89 e5                	mov    %esp,%ebp
  802e91:	83 ec 04             	sub    $0x4,%esp
  802e94:	8b 45 14             	mov    0x14(%ebp),%eax
  802e97:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802e9a:	8b 55 18             	mov    0x18(%ebp),%edx
  802e9d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802ea1:	52                   	push   %edx
  802ea2:	50                   	push   %eax
  802ea3:	ff 75 10             	pushl  0x10(%ebp)
  802ea6:	ff 75 0c             	pushl  0xc(%ebp)
  802ea9:	ff 75 08             	pushl  0x8(%ebp)
  802eac:	6a 27                	push   $0x27
  802eae:	e8 18 fb ff ff       	call   8029cb <syscall>
  802eb3:	83 c4 18             	add    $0x18,%esp
	return ;
  802eb6:	90                   	nop
}
  802eb7:	c9                   	leave  
  802eb8:	c3                   	ret    

00802eb9 <chktst>:
void chktst(uint32 n)
{
  802eb9:	55                   	push   %ebp
  802eba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802ebc:	6a 00                	push   $0x0
  802ebe:	6a 00                	push   $0x0
  802ec0:	6a 00                	push   $0x0
  802ec2:	6a 00                	push   $0x0
  802ec4:	ff 75 08             	pushl  0x8(%ebp)
  802ec7:	6a 29                	push   $0x29
  802ec9:	e8 fd fa ff ff       	call   8029cb <syscall>
  802ece:	83 c4 18             	add    $0x18,%esp
	return ;
  802ed1:	90                   	nop
}
  802ed2:	c9                   	leave  
  802ed3:	c3                   	ret    

00802ed4 <inctst>:

void inctst()
{
  802ed4:	55                   	push   %ebp
  802ed5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802ed7:	6a 00                	push   $0x0
  802ed9:	6a 00                	push   $0x0
  802edb:	6a 00                	push   $0x0
  802edd:	6a 00                	push   $0x0
  802edf:	6a 00                	push   $0x0
  802ee1:	6a 2a                	push   $0x2a
  802ee3:	e8 e3 fa ff ff       	call   8029cb <syscall>
  802ee8:	83 c4 18             	add    $0x18,%esp
	return ;
  802eeb:	90                   	nop
}
  802eec:	c9                   	leave  
  802eed:	c3                   	ret    

00802eee <gettst>:
uint32 gettst()
{
  802eee:	55                   	push   %ebp
  802eef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802ef1:	6a 00                	push   $0x0
  802ef3:	6a 00                	push   $0x0
  802ef5:	6a 00                	push   $0x0
  802ef7:	6a 00                	push   $0x0
  802ef9:	6a 00                	push   $0x0
  802efb:	6a 2b                	push   $0x2b
  802efd:	e8 c9 fa ff ff       	call   8029cb <syscall>
  802f02:	83 c4 18             	add    $0x18,%esp
}
  802f05:	c9                   	leave  
  802f06:	c3                   	ret    

00802f07 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802f07:	55                   	push   %ebp
  802f08:	89 e5                	mov    %esp,%ebp
  802f0a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802f0d:	6a 00                	push   $0x0
  802f0f:	6a 00                	push   $0x0
  802f11:	6a 00                	push   $0x0
  802f13:	6a 00                	push   $0x0
  802f15:	6a 00                	push   $0x0
  802f17:	6a 2c                	push   $0x2c
  802f19:	e8 ad fa ff ff       	call   8029cb <syscall>
  802f1e:	83 c4 18             	add    $0x18,%esp
  802f21:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802f24:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802f28:	75 07                	jne    802f31 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802f2a:	b8 01 00 00 00       	mov    $0x1,%eax
  802f2f:	eb 05                	jmp    802f36 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802f31:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802f36:	c9                   	leave  
  802f37:	c3                   	ret    

00802f38 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802f38:	55                   	push   %ebp
  802f39:	89 e5                	mov    %esp,%ebp
  802f3b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802f3e:	6a 00                	push   $0x0
  802f40:	6a 00                	push   $0x0
  802f42:	6a 00                	push   $0x0
  802f44:	6a 00                	push   $0x0
  802f46:	6a 00                	push   $0x0
  802f48:	6a 2c                	push   $0x2c
  802f4a:	e8 7c fa ff ff       	call   8029cb <syscall>
  802f4f:	83 c4 18             	add    $0x18,%esp
  802f52:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802f55:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802f59:	75 07                	jne    802f62 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802f5b:	b8 01 00 00 00       	mov    $0x1,%eax
  802f60:	eb 05                	jmp    802f67 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802f62:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802f67:	c9                   	leave  
  802f68:	c3                   	ret    

00802f69 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802f69:	55                   	push   %ebp
  802f6a:	89 e5                	mov    %esp,%ebp
  802f6c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802f6f:	6a 00                	push   $0x0
  802f71:	6a 00                	push   $0x0
  802f73:	6a 00                	push   $0x0
  802f75:	6a 00                	push   $0x0
  802f77:	6a 00                	push   $0x0
  802f79:	6a 2c                	push   $0x2c
  802f7b:	e8 4b fa ff ff       	call   8029cb <syscall>
  802f80:	83 c4 18             	add    $0x18,%esp
  802f83:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802f86:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802f8a:	75 07                	jne    802f93 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802f8c:	b8 01 00 00 00       	mov    $0x1,%eax
  802f91:	eb 05                	jmp    802f98 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802f93:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802f98:	c9                   	leave  
  802f99:	c3                   	ret    

00802f9a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802f9a:	55                   	push   %ebp
  802f9b:	89 e5                	mov    %esp,%ebp
  802f9d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802fa0:	6a 00                	push   $0x0
  802fa2:	6a 00                	push   $0x0
  802fa4:	6a 00                	push   $0x0
  802fa6:	6a 00                	push   $0x0
  802fa8:	6a 00                	push   $0x0
  802faa:	6a 2c                	push   $0x2c
  802fac:	e8 1a fa ff ff       	call   8029cb <syscall>
  802fb1:	83 c4 18             	add    $0x18,%esp
  802fb4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802fb7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802fbb:	75 07                	jne    802fc4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802fbd:	b8 01 00 00 00       	mov    $0x1,%eax
  802fc2:	eb 05                	jmp    802fc9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802fc4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802fc9:	c9                   	leave  
  802fca:	c3                   	ret    

00802fcb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802fcb:	55                   	push   %ebp
  802fcc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802fce:	6a 00                	push   $0x0
  802fd0:	6a 00                	push   $0x0
  802fd2:	6a 00                	push   $0x0
  802fd4:	6a 00                	push   $0x0
  802fd6:	ff 75 08             	pushl  0x8(%ebp)
  802fd9:	6a 2d                	push   $0x2d
  802fdb:	e8 eb f9 ff ff       	call   8029cb <syscall>
  802fe0:	83 c4 18             	add    $0x18,%esp
	return ;
  802fe3:	90                   	nop
}
  802fe4:	c9                   	leave  
  802fe5:	c3                   	ret    

00802fe6 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802fe6:	55                   	push   %ebp
  802fe7:	89 e5                	mov    %esp,%ebp
  802fe9:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802fea:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802fed:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802ff0:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  802ff6:	6a 00                	push   $0x0
  802ff8:	53                   	push   %ebx
  802ff9:	51                   	push   %ecx
  802ffa:	52                   	push   %edx
  802ffb:	50                   	push   %eax
  802ffc:	6a 2e                	push   $0x2e
  802ffe:	e8 c8 f9 ff ff       	call   8029cb <syscall>
  803003:	83 c4 18             	add    $0x18,%esp
}
  803006:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  803009:	c9                   	leave  
  80300a:	c3                   	ret    

0080300b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80300b:	55                   	push   %ebp
  80300c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80300e:	8b 55 0c             	mov    0xc(%ebp),%edx
  803011:	8b 45 08             	mov    0x8(%ebp),%eax
  803014:	6a 00                	push   $0x0
  803016:	6a 00                	push   $0x0
  803018:	6a 00                	push   $0x0
  80301a:	52                   	push   %edx
  80301b:	50                   	push   %eax
  80301c:	6a 2f                	push   $0x2f
  80301e:	e8 a8 f9 ff ff       	call   8029cb <syscall>
  803023:	83 c4 18             	add    $0x18,%esp
}
  803026:	c9                   	leave  
  803027:	c3                   	ret    

00803028 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  803028:	55                   	push   %ebp
  803029:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80302b:	6a 00                	push   $0x0
  80302d:	6a 00                	push   $0x0
  80302f:	6a 00                	push   $0x0
  803031:	ff 75 0c             	pushl  0xc(%ebp)
  803034:	ff 75 08             	pushl  0x8(%ebp)
  803037:	6a 30                	push   $0x30
  803039:	e8 8d f9 ff ff       	call   8029cb <syscall>
  80303e:	83 c4 18             	add    $0x18,%esp
	return ;
  803041:	90                   	nop
}
  803042:	c9                   	leave  
  803043:	c3                   	ret    

00803044 <__udivdi3>:
  803044:	55                   	push   %ebp
  803045:	57                   	push   %edi
  803046:	56                   	push   %esi
  803047:	53                   	push   %ebx
  803048:	83 ec 1c             	sub    $0x1c,%esp
  80304b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80304f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  803053:	8b 7c 24 38          	mov    0x38(%esp),%edi
  803057:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80305b:	89 ca                	mov    %ecx,%edx
  80305d:	89 f8                	mov    %edi,%eax
  80305f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  803063:	85 f6                	test   %esi,%esi
  803065:	75 2d                	jne    803094 <__udivdi3+0x50>
  803067:	39 cf                	cmp    %ecx,%edi
  803069:	77 65                	ja     8030d0 <__udivdi3+0x8c>
  80306b:	89 fd                	mov    %edi,%ebp
  80306d:	85 ff                	test   %edi,%edi
  80306f:	75 0b                	jne    80307c <__udivdi3+0x38>
  803071:	b8 01 00 00 00       	mov    $0x1,%eax
  803076:	31 d2                	xor    %edx,%edx
  803078:	f7 f7                	div    %edi
  80307a:	89 c5                	mov    %eax,%ebp
  80307c:	31 d2                	xor    %edx,%edx
  80307e:	89 c8                	mov    %ecx,%eax
  803080:	f7 f5                	div    %ebp
  803082:	89 c1                	mov    %eax,%ecx
  803084:	89 d8                	mov    %ebx,%eax
  803086:	f7 f5                	div    %ebp
  803088:	89 cf                	mov    %ecx,%edi
  80308a:	89 fa                	mov    %edi,%edx
  80308c:	83 c4 1c             	add    $0x1c,%esp
  80308f:	5b                   	pop    %ebx
  803090:	5e                   	pop    %esi
  803091:	5f                   	pop    %edi
  803092:	5d                   	pop    %ebp
  803093:	c3                   	ret    
  803094:	39 ce                	cmp    %ecx,%esi
  803096:	77 28                	ja     8030c0 <__udivdi3+0x7c>
  803098:	0f bd fe             	bsr    %esi,%edi
  80309b:	83 f7 1f             	xor    $0x1f,%edi
  80309e:	75 40                	jne    8030e0 <__udivdi3+0x9c>
  8030a0:	39 ce                	cmp    %ecx,%esi
  8030a2:	72 0a                	jb     8030ae <__udivdi3+0x6a>
  8030a4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8030a8:	0f 87 9e 00 00 00    	ja     80314c <__udivdi3+0x108>
  8030ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8030b3:	89 fa                	mov    %edi,%edx
  8030b5:	83 c4 1c             	add    $0x1c,%esp
  8030b8:	5b                   	pop    %ebx
  8030b9:	5e                   	pop    %esi
  8030ba:	5f                   	pop    %edi
  8030bb:	5d                   	pop    %ebp
  8030bc:	c3                   	ret    
  8030bd:	8d 76 00             	lea    0x0(%esi),%esi
  8030c0:	31 ff                	xor    %edi,%edi
  8030c2:	31 c0                	xor    %eax,%eax
  8030c4:	89 fa                	mov    %edi,%edx
  8030c6:	83 c4 1c             	add    $0x1c,%esp
  8030c9:	5b                   	pop    %ebx
  8030ca:	5e                   	pop    %esi
  8030cb:	5f                   	pop    %edi
  8030cc:	5d                   	pop    %ebp
  8030cd:	c3                   	ret    
  8030ce:	66 90                	xchg   %ax,%ax
  8030d0:	89 d8                	mov    %ebx,%eax
  8030d2:	f7 f7                	div    %edi
  8030d4:	31 ff                	xor    %edi,%edi
  8030d6:	89 fa                	mov    %edi,%edx
  8030d8:	83 c4 1c             	add    $0x1c,%esp
  8030db:	5b                   	pop    %ebx
  8030dc:	5e                   	pop    %esi
  8030dd:	5f                   	pop    %edi
  8030de:	5d                   	pop    %ebp
  8030df:	c3                   	ret    
  8030e0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8030e5:	89 eb                	mov    %ebp,%ebx
  8030e7:	29 fb                	sub    %edi,%ebx
  8030e9:	89 f9                	mov    %edi,%ecx
  8030eb:	d3 e6                	shl    %cl,%esi
  8030ed:	89 c5                	mov    %eax,%ebp
  8030ef:	88 d9                	mov    %bl,%cl
  8030f1:	d3 ed                	shr    %cl,%ebp
  8030f3:	89 e9                	mov    %ebp,%ecx
  8030f5:	09 f1                	or     %esi,%ecx
  8030f7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8030fb:	89 f9                	mov    %edi,%ecx
  8030fd:	d3 e0                	shl    %cl,%eax
  8030ff:	89 c5                	mov    %eax,%ebp
  803101:	89 d6                	mov    %edx,%esi
  803103:	88 d9                	mov    %bl,%cl
  803105:	d3 ee                	shr    %cl,%esi
  803107:	89 f9                	mov    %edi,%ecx
  803109:	d3 e2                	shl    %cl,%edx
  80310b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80310f:	88 d9                	mov    %bl,%cl
  803111:	d3 e8                	shr    %cl,%eax
  803113:	09 c2                	or     %eax,%edx
  803115:	89 d0                	mov    %edx,%eax
  803117:	89 f2                	mov    %esi,%edx
  803119:	f7 74 24 0c          	divl   0xc(%esp)
  80311d:	89 d6                	mov    %edx,%esi
  80311f:	89 c3                	mov    %eax,%ebx
  803121:	f7 e5                	mul    %ebp
  803123:	39 d6                	cmp    %edx,%esi
  803125:	72 19                	jb     803140 <__udivdi3+0xfc>
  803127:	74 0b                	je     803134 <__udivdi3+0xf0>
  803129:	89 d8                	mov    %ebx,%eax
  80312b:	31 ff                	xor    %edi,%edi
  80312d:	e9 58 ff ff ff       	jmp    80308a <__udivdi3+0x46>
  803132:	66 90                	xchg   %ax,%ax
  803134:	8b 54 24 08          	mov    0x8(%esp),%edx
  803138:	89 f9                	mov    %edi,%ecx
  80313a:	d3 e2                	shl    %cl,%edx
  80313c:	39 c2                	cmp    %eax,%edx
  80313e:	73 e9                	jae    803129 <__udivdi3+0xe5>
  803140:	8d 43 ff             	lea    -0x1(%ebx),%eax
  803143:	31 ff                	xor    %edi,%edi
  803145:	e9 40 ff ff ff       	jmp    80308a <__udivdi3+0x46>
  80314a:	66 90                	xchg   %ax,%ax
  80314c:	31 c0                	xor    %eax,%eax
  80314e:	e9 37 ff ff ff       	jmp    80308a <__udivdi3+0x46>
  803153:	90                   	nop

00803154 <__umoddi3>:
  803154:	55                   	push   %ebp
  803155:	57                   	push   %edi
  803156:	56                   	push   %esi
  803157:	53                   	push   %ebx
  803158:	83 ec 1c             	sub    $0x1c,%esp
  80315b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80315f:	8b 74 24 34          	mov    0x34(%esp),%esi
  803163:	8b 7c 24 38          	mov    0x38(%esp),%edi
  803167:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80316b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80316f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  803173:	89 f3                	mov    %esi,%ebx
  803175:	89 fa                	mov    %edi,%edx
  803177:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80317b:	89 34 24             	mov    %esi,(%esp)
  80317e:	85 c0                	test   %eax,%eax
  803180:	75 1a                	jne    80319c <__umoddi3+0x48>
  803182:	39 f7                	cmp    %esi,%edi
  803184:	0f 86 a2 00 00 00    	jbe    80322c <__umoddi3+0xd8>
  80318a:	89 c8                	mov    %ecx,%eax
  80318c:	89 f2                	mov    %esi,%edx
  80318e:	f7 f7                	div    %edi
  803190:	89 d0                	mov    %edx,%eax
  803192:	31 d2                	xor    %edx,%edx
  803194:	83 c4 1c             	add    $0x1c,%esp
  803197:	5b                   	pop    %ebx
  803198:	5e                   	pop    %esi
  803199:	5f                   	pop    %edi
  80319a:	5d                   	pop    %ebp
  80319b:	c3                   	ret    
  80319c:	39 f0                	cmp    %esi,%eax
  80319e:	0f 87 ac 00 00 00    	ja     803250 <__umoddi3+0xfc>
  8031a4:	0f bd e8             	bsr    %eax,%ebp
  8031a7:	83 f5 1f             	xor    $0x1f,%ebp
  8031aa:	0f 84 ac 00 00 00    	je     80325c <__umoddi3+0x108>
  8031b0:	bf 20 00 00 00       	mov    $0x20,%edi
  8031b5:	29 ef                	sub    %ebp,%edi
  8031b7:	89 fe                	mov    %edi,%esi
  8031b9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8031bd:	89 e9                	mov    %ebp,%ecx
  8031bf:	d3 e0                	shl    %cl,%eax
  8031c1:	89 d7                	mov    %edx,%edi
  8031c3:	89 f1                	mov    %esi,%ecx
  8031c5:	d3 ef                	shr    %cl,%edi
  8031c7:	09 c7                	or     %eax,%edi
  8031c9:	89 e9                	mov    %ebp,%ecx
  8031cb:	d3 e2                	shl    %cl,%edx
  8031cd:	89 14 24             	mov    %edx,(%esp)
  8031d0:	89 d8                	mov    %ebx,%eax
  8031d2:	d3 e0                	shl    %cl,%eax
  8031d4:	89 c2                	mov    %eax,%edx
  8031d6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8031da:	d3 e0                	shl    %cl,%eax
  8031dc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8031e0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8031e4:	89 f1                	mov    %esi,%ecx
  8031e6:	d3 e8                	shr    %cl,%eax
  8031e8:	09 d0                	or     %edx,%eax
  8031ea:	d3 eb                	shr    %cl,%ebx
  8031ec:	89 da                	mov    %ebx,%edx
  8031ee:	f7 f7                	div    %edi
  8031f0:	89 d3                	mov    %edx,%ebx
  8031f2:	f7 24 24             	mull   (%esp)
  8031f5:	89 c6                	mov    %eax,%esi
  8031f7:	89 d1                	mov    %edx,%ecx
  8031f9:	39 d3                	cmp    %edx,%ebx
  8031fb:	0f 82 87 00 00 00    	jb     803288 <__umoddi3+0x134>
  803201:	0f 84 91 00 00 00    	je     803298 <__umoddi3+0x144>
  803207:	8b 54 24 04          	mov    0x4(%esp),%edx
  80320b:	29 f2                	sub    %esi,%edx
  80320d:	19 cb                	sbb    %ecx,%ebx
  80320f:	89 d8                	mov    %ebx,%eax
  803211:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  803215:	d3 e0                	shl    %cl,%eax
  803217:	89 e9                	mov    %ebp,%ecx
  803219:	d3 ea                	shr    %cl,%edx
  80321b:	09 d0                	or     %edx,%eax
  80321d:	89 e9                	mov    %ebp,%ecx
  80321f:	d3 eb                	shr    %cl,%ebx
  803221:	89 da                	mov    %ebx,%edx
  803223:	83 c4 1c             	add    $0x1c,%esp
  803226:	5b                   	pop    %ebx
  803227:	5e                   	pop    %esi
  803228:	5f                   	pop    %edi
  803229:	5d                   	pop    %ebp
  80322a:	c3                   	ret    
  80322b:	90                   	nop
  80322c:	89 fd                	mov    %edi,%ebp
  80322e:	85 ff                	test   %edi,%edi
  803230:	75 0b                	jne    80323d <__umoddi3+0xe9>
  803232:	b8 01 00 00 00       	mov    $0x1,%eax
  803237:	31 d2                	xor    %edx,%edx
  803239:	f7 f7                	div    %edi
  80323b:	89 c5                	mov    %eax,%ebp
  80323d:	89 f0                	mov    %esi,%eax
  80323f:	31 d2                	xor    %edx,%edx
  803241:	f7 f5                	div    %ebp
  803243:	89 c8                	mov    %ecx,%eax
  803245:	f7 f5                	div    %ebp
  803247:	89 d0                	mov    %edx,%eax
  803249:	e9 44 ff ff ff       	jmp    803192 <__umoddi3+0x3e>
  80324e:	66 90                	xchg   %ax,%ax
  803250:	89 c8                	mov    %ecx,%eax
  803252:	89 f2                	mov    %esi,%edx
  803254:	83 c4 1c             	add    $0x1c,%esp
  803257:	5b                   	pop    %ebx
  803258:	5e                   	pop    %esi
  803259:	5f                   	pop    %edi
  80325a:	5d                   	pop    %ebp
  80325b:	c3                   	ret    
  80325c:	3b 04 24             	cmp    (%esp),%eax
  80325f:	72 06                	jb     803267 <__umoddi3+0x113>
  803261:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  803265:	77 0f                	ja     803276 <__umoddi3+0x122>
  803267:	89 f2                	mov    %esi,%edx
  803269:	29 f9                	sub    %edi,%ecx
  80326b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80326f:	89 14 24             	mov    %edx,(%esp)
  803272:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  803276:	8b 44 24 04          	mov    0x4(%esp),%eax
  80327a:	8b 14 24             	mov    (%esp),%edx
  80327d:	83 c4 1c             	add    $0x1c,%esp
  803280:	5b                   	pop    %ebx
  803281:	5e                   	pop    %esi
  803282:	5f                   	pop    %edi
  803283:	5d                   	pop    %ebp
  803284:	c3                   	ret    
  803285:	8d 76 00             	lea    0x0(%esi),%esi
  803288:	2b 04 24             	sub    (%esp),%eax
  80328b:	19 fa                	sbb    %edi,%edx
  80328d:	89 d1                	mov    %edx,%ecx
  80328f:	89 c6                	mov    %eax,%esi
  803291:	e9 71 ff ff ff       	jmp    803207 <__umoddi3+0xb3>
  803296:	66 90                	xchg   %ax,%ax
  803298:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80329c:	72 ea                	jb     803288 <__umoddi3+0x134>
  80329e:	89 d9                	mov    %ebx,%ecx
  8032a0:	e9 62 ff ff ff       	jmp    803207 <__umoddi3+0xb3>
