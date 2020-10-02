
obj/user/tst_free_2:     file format elf32-i386


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
  800031:	e8 b1 09 00 00       	call   8009e7 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* MAKE SURE PAGE_WS_MAX_SIZE = 1000 */
/* *********************************************************** */
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	81 ec d4 00 00 00    	sub    $0xd4,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800042:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800046:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004d:	eb 2a                	jmp    800079 <_main+0x41>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004f:	a1 20 30 80 00       	mov    0x803020,%eax
  800054:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80005a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005d:	89 d0                	mov    %edx,%eax
  80005f:	c1 e0 02             	shl    $0x2,%eax
  800062:	01 d0                	add    %edx,%eax
  800064:	c1 e0 02             	shl    $0x2,%eax
  800067:	01 c8                	add    %ecx,%eax
  800069:	8a 40 04             	mov    0x4(%eax),%al
  80006c:	84 c0                	test   %al,%al
  80006e:	74 06                	je     800076 <_main+0x3e>
			{
				fullWS = 0;
  800070:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800074:	eb 12                	jmp    800088 <_main+0x50>
{

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800076:	ff 45 f0             	incl   -0x10(%ebp)
  800079:	a1 20 30 80 00       	mov    0x803020,%eax
  80007e:	8b 50 74             	mov    0x74(%eax),%edx
  800081:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800084:	39 c2                	cmp    %eax,%edx
  800086:	77 c7                	ja     80004f <_main+0x17>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800088:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80008c:	74 14                	je     8000a2 <_main+0x6a>
  80008e:	83 ec 04             	sub    $0x4,%esp
  800091:	68 40 28 80 00       	push   $0x802840
  800096:	6a 14                	push   $0x14
  800098:	68 5c 28 80 00       	push   $0x80285c
  80009d:	e8 6d 0a 00 00       	call   800b0f <_panic>
	}

	//Bypass the PAGE FAULT on <MOVB immediate, reg> instruction by setting its length
	//and continue executing the remaining code
	sys_bypassPageFault(3);
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	6a 03                	push   $0x3
  8000a7:	e8 31 23 00 00       	call   8023dd <sys_bypassPageFault>
  8000ac:	83 c4 10             	add    $0x10,%esp





	int Mega = 1024*1024;
  8000af:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000b6:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)

	int start_freeFrames = sys_calculate_free_frames() ;
  8000bd:	e8 04 20 00 00       	call   8020c6 <sys_calculate_free_frames>
  8000c2:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//ALLOCATE ALL
	void* ptr_allocations[20] = {0};
  8000c5:	8d 55 80             	lea    -0x80(%ebp),%edx
  8000c8:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000cd:	b8 00 00 00 00       	mov    $0x0,%eax
  8000d2:	89 d7                	mov    %edx,%edi
  8000d4:	f3 ab                	rep stos %eax,%es:(%edi)
	int lastIndices[20] = {0};
  8000d6:	8d 95 30 ff ff ff    	lea    -0xd0(%ebp),%edx
  8000dc:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000e1:	b8 00 00 00 00       	mov    $0x0,%eax
  8000e6:	89 d7                	mov    %edx,%edi
  8000e8:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		int freeFrames = sys_calculate_free_frames() ;
  8000ea:	e8 d7 1f 00 00       	call   8020c6 <sys_calculate_free_frames>
  8000ef:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000f2:	e8 52 20 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  8000f7:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000fd:	01 c0                	add    %eax,%eax
  8000ff:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800102:	83 ec 0c             	sub    $0xc,%esp
  800105:	50                   	push   %eax
  800106:	e8 45 1a 00 00       	call   801b50 <malloc>
  80010b:	83 c4 10             	add    $0x10,%esp
  80010e:	89 45 80             	mov    %eax,-0x80(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800111:	8b 45 80             	mov    -0x80(%ebp),%eax
  800114:	85 c0                	test   %eax,%eax
  800116:	78 14                	js     80012c <_main+0xf4>
  800118:	83 ec 04             	sub    $0x4,%esp
  80011b:	68 70 28 80 00       	push   $0x802870
  800120:	6a 2b                	push   $0x2b
  800122:	68 5c 28 80 00       	push   $0x80285c
  800127:	e8 e3 09 00 00       	call   800b0f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80012c:	e8 18 20 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  800131:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800134:	3d 00 02 00 00       	cmp    $0x200,%eax
  800139:	74 14                	je     80014f <_main+0x117>
  80013b:	83 ec 04             	sub    $0x4,%esp
  80013e:	68 d8 28 80 00       	push   $0x8028d8
  800143:	6a 2c                	push   $0x2c
  800145:	68 5c 28 80 00       	push   $0x80285c
  80014a:	e8 c0 09 00 00       	call   800b0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		lastIndices[0] = (2*Mega-kilo)/sizeof(char) - 1;
  80014f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800152:	01 c0                	add    %eax,%eax
  800154:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800157:	48                   	dec    %eax
  800158:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  80015e:	e8 63 1f 00 00       	call   8020c6 <sys_calculate_free_frames>
  800163:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800166:	e8 de 1f 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  80016b:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80016e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800171:	01 c0                	add    %eax,%eax
  800173:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800176:	83 ec 0c             	sub    $0xc,%esp
  800179:	50                   	push   %eax
  80017a:	e8 d1 19 00 00       	call   801b50 <malloc>
  80017f:	83 c4 10             	add    $0x10,%esp
  800182:	89 45 84             	mov    %eax,-0x7c(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800185:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800188:	89 c2                	mov    %eax,%edx
  80018a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018d:	01 c0                	add    %eax,%eax
  80018f:	05 00 00 00 80       	add    $0x80000000,%eax
  800194:	39 c2                	cmp    %eax,%edx
  800196:	73 14                	jae    8001ac <_main+0x174>
  800198:	83 ec 04             	sub    $0x4,%esp
  80019b:	68 70 28 80 00       	push   $0x802870
  8001a0:	6a 33                	push   $0x33
  8001a2:	68 5c 28 80 00       	push   $0x80285c
  8001a7:	e8 63 09 00 00       	call   800b0f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8001ac:	e8 98 1f 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  8001b1:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8001b4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001b9:	74 14                	je     8001cf <_main+0x197>
  8001bb:	83 ec 04             	sub    $0x4,%esp
  8001be:	68 d8 28 80 00       	push   $0x8028d8
  8001c3:	6a 34                	push   $0x34
  8001c5:	68 5c 28 80 00       	push   $0x80285c
  8001ca:	e8 40 09 00 00       	call   800b0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		lastIndices[1] = (2*Mega-kilo)/sizeof(char) - 1;
  8001cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001d2:	01 c0                	add    %eax,%eax
  8001d4:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8001d7:	48                   	dec    %eax
  8001d8:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  8001de:	e8 e3 1e 00 00       	call   8020c6 <sys_calculate_free_frames>
  8001e3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8001e6:	e8 5e 1f 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  8001eb:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  8001ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001f1:	01 c0                	add    %eax,%eax
  8001f3:	83 ec 0c             	sub    $0xc,%esp
  8001f6:	50                   	push   %eax
  8001f7:	e8 54 19 00 00       	call   801b50 <malloc>
  8001fc:	83 c4 10             	add    $0x10,%esp
  8001ff:	89 45 88             	mov    %eax,-0x78(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800202:	8b 45 88             	mov    -0x78(%ebp),%eax
  800205:	89 c2                	mov    %eax,%edx
  800207:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80020a:	c1 e0 02             	shl    $0x2,%eax
  80020d:	05 00 00 00 80       	add    $0x80000000,%eax
  800212:	39 c2                	cmp    %eax,%edx
  800214:	73 14                	jae    80022a <_main+0x1f2>
  800216:	83 ec 04             	sub    $0x4,%esp
  800219:	68 70 28 80 00       	push   $0x802870
  80021e:	6a 3b                	push   $0x3b
  800220:	68 5c 28 80 00       	push   $0x80285c
  800225:	e8 e5 08 00 00       	call   800b0f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80022a:	e8 1a 1f 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  80022f:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800232:	83 f8 01             	cmp    $0x1,%eax
  800235:	74 14                	je     80024b <_main+0x213>
  800237:	83 ec 04             	sub    $0x4,%esp
  80023a:	68 d8 28 80 00       	push   $0x8028d8
  80023f:	6a 3c                	push   $0x3c
  800241:	68 5c 28 80 00       	push   $0x80285c
  800246:	e8 c4 08 00 00       	call   800b0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		lastIndices[2] = (2*kilo)/sizeof(char) - 1;
  80024b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80024e:	01 c0                	add    %eax,%eax
  800250:	48                   	dec    %eax
  800251:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  800257:	e8 6a 1e 00 00       	call   8020c6 <sys_calculate_free_frames>
  80025c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80025f:	e8 e5 1e 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  800264:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  800267:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80026a:	01 c0                	add    %eax,%eax
  80026c:	83 ec 0c             	sub    $0xc,%esp
  80026f:	50                   	push   %eax
  800270:	e8 db 18 00 00       	call   801b50 <malloc>
  800275:	83 c4 10             	add    $0x10,%esp
  800278:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80027b:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80027e:	89 c2                	mov    %eax,%edx
  800280:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800283:	c1 e0 02             	shl    $0x2,%eax
  800286:	89 c1                	mov    %eax,%ecx
  800288:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80028b:	c1 e0 02             	shl    $0x2,%eax
  80028e:	01 c8                	add    %ecx,%eax
  800290:	05 00 00 00 80       	add    $0x80000000,%eax
  800295:	39 c2                	cmp    %eax,%edx
  800297:	73 14                	jae    8002ad <_main+0x275>
  800299:	83 ec 04             	sub    $0x4,%esp
  80029c:	68 70 28 80 00       	push   $0x802870
  8002a1:	6a 43                	push   $0x43
  8002a3:	68 5c 28 80 00       	push   $0x80285c
  8002a8:	e8 62 08 00 00       	call   800b0f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  8002ad:	e8 97 1e 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  8002b2:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8002b5:	83 f8 01             	cmp    $0x1,%eax
  8002b8:	74 14                	je     8002ce <_main+0x296>
  8002ba:	83 ec 04             	sub    $0x4,%esp
  8002bd:	68 d8 28 80 00       	push   $0x8028d8
  8002c2:	6a 44                	push   $0x44
  8002c4:	68 5c 28 80 00       	push   $0x80285c
  8002c9:	e8 41 08 00 00       	call   800b0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		lastIndices[3] = (2*kilo)/sizeof(char) - 1;
  8002ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002d1:	01 c0                	add    %eax,%eax
  8002d3:	48                   	dec    %eax
  8002d4:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  8002da:	e8 e7 1d 00 00       	call   8020c6 <sys_calculate_free_frames>
  8002df:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002e2:	e8 62 1e 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  8002e7:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  8002ea:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002ed:	89 d0                	mov    %edx,%eax
  8002ef:	01 c0                	add    %eax,%eax
  8002f1:	01 d0                	add    %edx,%eax
  8002f3:	01 c0                	add    %eax,%eax
  8002f5:	01 d0                	add    %edx,%eax
  8002f7:	83 ec 0c             	sub    $0xc,%esp
  8002fa:	50                   	push   %eax
  8002fb:	e8 50 18 00 00       	call   801b50 <malloc>
  800300:	83 c4 10             	add    $0x10,%esp
  800303:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800306:	8b 45 90             	mov    -0x70(%ebp),%eax
  800309:	89 c2                	mov    %eax,%edx
  80030b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80030e:	c1 e0 02             	shl    $0x2,%eax
  800311:	89 c1                	mov    %eax,%ecx
  800313:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800316:	c1 e0 03             	shl    $0x3,%eax
  800319:	01 c8                	add    %ecx,%eax
  80031b:	05 00 00 00 80       	add    $0x80000000,%eax
  800320:	39 c2                	cmp    %eax,%edx
  800322:	73 14                	jae    800338 <_main+0x300>
  800324:	83 ec 04             	sub    $0x4,%esp
  800327:	68 70 28 80 00       	push   $0x802870
  80032c:	6a 4b                	push   $0x4b
  80032e:	68 5c 28 80 00       	push   $0x80285c
  800333:	e8 d7 07 00 00       	call   800b0f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  800338:	e8 0c 1e 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  80033d:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800340:	83 f8 02             	cmp    $0x2,%eax
  800343:	74 14                	je     800359 <_main+0x321>
  800345:	83 ec 04             	sub    $0x4,%esp
  800348:	68 d8 28 80 00       	push   $0x8028d8
  80034d:	6a 4c                	push   $0x4c
  80034f:	68 5c 28 80 00       	push   $0x80285c
  800354:	e8 b6 07 00 00       	call   800b0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		lastIndices[4] = (7*kilo)/sizeof(char) - 1;
  800359:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80035c:	89 d0                	mov    %edx,%eax
  80035e:	01 c0                	add    %eax,%eax
  800360:	01 d0                	add    %edx,%eax
  800362:	01 c0                	add    %eax,%eax
  800364:	01 d0                	add    %edx,%eax
  800366:	48                   	dec    %eax
  800367:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  80036d:	e8 54 1d 00 00       	call   8020c6 <sys_calculate_free_frames>
  800372:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800375:	e8 cf 1d 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  80037a:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  80037d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800380:	89 c2                	mov    %eax,%edx
  800382:	01 d2                	add    %edx,%edx
  800384:	01 d0                	add    %edx,%eax
  800386:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800389:	83 ec 0c             	sub    $0xc,%esp
  80038c:	50                   	push   %eax
  80038d:	e8 be 17 00 00       	call   801b50 <malloc>
  800392:	83 c4 10             	add    $0x10,%esp
  800395:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800398:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80039b:	89 c2                	mov    %eax,%edx
  80039d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003a0:	c1 e0 02             	shl    $0x2,%eax
  8003a3:	89 c1                	mov    %eax,%ecx
  8003a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003a8:	c1 e0 04             	shl    $0x4,%eax
  8003ab:	01 c8                	add    %ecx,%eax
  8003ad:	05 00 00 00 80       	add    $0x80000000,%eax
  8003b2:	39 c2                	cmp    %eax,%edx
  8003b4:	73 14                	jae    8003ca <_main+0x392>
  8003b6:	83 ec 04             	sub    $0x4,%esp
  8003b9:	68 70 28 80 00       	push   $0x802870
  8003be:	6a 53                	push   $0x53
  8003c0:	68 5c 28 80 00       	push   $0x80285c
  8003c5:	e8 45 07 00 00       	call   800b0f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  8003ca:	e8 7a 1d 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  8003cf:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8003d2:	89 c2                	mov    %eax,%edx
  8003d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d7:	89 c1                	mov    %eax,%ecx
  8003d9:	01 c9                	add    %ecx,%ecx
  8003db:	01 c8                	add    %ecx,%eax
  8003dd:	85 c0                	test   %eax,%eax
  8003df:	79 05                	jns    8003e6 <_main+0x3ae>
  8003e1:	05 ff 0f 00 00       	add    $0xfff,%eax
  8003e6:	c1 f8 0c             	sar    $0xc,%eax
  8003e9:	39 c2                	cmp    %eax,%edx
  8003eb:	74 14                	je     800401 <_main+0x3c9>
  8003ed:	83 ec 04             	sub    $0x4,%esp
  8003f0:	68 d8 28 80 00       	push   $0x8028d8
  8003f5:	6a 54                	push   $0x54
  8003f7:	68 5c 28 80 00       	push   $0x80285c
  8003fc:	e8 0e 07 00 00       	call   800b0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		lastIndices[5] = (3*Mega - kilo)/sizeof(char) - 1;
  800401:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800404:	89 c2                	mov    %eax,%edx
  800406:	01 d2                	add    %edx,%edx
  800408:	01 d0                	add    %edx,%eax
  80040a:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80040d:	48                   	dec    %eax
  80040e:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  800414:	e8 ad 1c 00 00       	call   8020c6 <sys_calculate_free_frames>
  800419:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80041c:	e8 28 1d 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  800421:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  800424:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800427:	01 c0                	add    %eax,%eax
  800429:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80042c:	83 ec 0c             	sub    $0xc,%esp
  80042f:	50                   	push   %eax
  800430:	e8 1b 17 00 00       	call   801b50 <malloc>
  800435:	83 c4 10             	add    $0x10,%esp
  800438:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80043b:	8b 45 98             	mov    -0x68(%ebp),%eax
  80043e:	89 c1                	mov    %eax,%ecx
  800440:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800443:	89 d0                	mov    %edx,%eax
  800445:	01 c0                	add    %eax,%eax
  800447:	01 d0                	add    %edx,%eax
  800449:	01 c0                	add    %eax,%eax
  80044b:	01 d0                	add    %edx,%eax
  80044d:	89 c2                	mov    %eax,%edx
  80044f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800452:	c1 e0 04             	shl    $0x4,%eax
  800455:	01 d0                	add    %edx,%eax
  800457:	05 00 00 00 80       	add    $0x80000000,%eax
  80045c:	39 c1                	cmp    %eax,%ecx
  80045e:	73 14                	jae    800474 <_main+0x43c>
  800460:	83 ec 04             	sub    $0x4,%esp
  800463:	68 70 28 80 00       	push   $0x802870
  800468:	6a 5b                	push   $0x5b
  80046a:	68 5c 28 80 00       	push   $0x80285c
  80046f:	e8 9b 06 00 00       	call   800b0f <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800474:	e8 d0 1c 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  800479:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80047c:	3d 00 02 00 00       	cmp    $0x200,%eax
  800481:	74 14                	je     800497 <_main+0x45f>
  800483:	83 ec 04             	sub    $0x4,%esp
  800486:	68 d8 28 80 00       	push   $0x8028d8
  80048b:	6a 5c                	push   $0x5c
  80048d:	68 5c 28 80 00       	push   $0x80285c
  800492:	e8 78 06 00 00       	call   800b0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		lastIndices[6] = (2*Mega - kilo)/sizeof(char) - 1;
  800497:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80049a:	01 c0                	add    %eax,%eax
  80049c:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80049f:	48                   	dec    %eax
  8004a0:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
	char x ;
	int y;
	char *byteArr ;
	//FREE ALL
	{
		int freeFrames = sys_calculate_free_frames() ;
  8004a6:	e8 1b 1c 00 00       	call   8020c6 <sys_calculate_free_frames>
  8004ab:	89 45 d8             	mov    %eax,-0x28(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8004ae:	e8 96 1c 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  8004b3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[0]);
  8004b6:	8b 45 80             	mov    -0x80(%ebp),%eax
  8004b9:	83 ec 0c             	sub    $0xc,%esp
  8004bc:	50                   	push   %eax
  8004bd:	e8 53 19 00 00       	call   801e15 <free>
  8004c2:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  8004c5:	e8 7f 1c 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  8004ca:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004cd:	29 c2                	sub    %eax,%edx
  8004cf:	89 d0                	mov    %edx,%eax
  8004d1:	3d 00 02 00 00       	cmp    $0x200,%eax
  8004d6:	74 14                	je     8004ec <_main+0x4b4>
  8004d8:	83 ec 04             	sub    $0x4,%esp
  8004db:	68 08 29 80 00       	push   $0x802908
  8004e0:	6a 69                	push   $0x69
  8004e2:	68 5c 28 80 00       	push   $0x80285c
  8004e7:	e8 23 06 00 00       	call   800b0f <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 512 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[0];
  8004ec:	8b 45 80             	mov    -0x80(%ebp),%eax
  8004ef:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  8004f2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004f5:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  8004f8:	e8 c7 1e 00 00       	call   8023c4 <sys_rcr2>
  8004fd:	89 c2                	mov    %eax,%edx
  8004ff:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800502:	39 c2                	cmp    %eax,%edx
  800504:	74 14                	je     80051a <_main+0x4e2>
  800506:	83 ec 04             	sub    $0x4,%esp
  800509:	68 44 29 80 00       	push   $0x802944
  80050e:	6a 6d                	push   $0x6d
  800510:	68 5c 28 80 00       	push   $0x80285c
  800515:	e8 f5 05 00 00       	call   800b0f <_panic>
		byteArr[lastIndices[0]] = 10;
  80051a:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800520:	89 c2                	mov    %eax,%edx
  800522:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800525:	01 d0                	add    %edx,%eax
  800527:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[0]])) panic("Free: successful access to freed space!! it should not be succeeded");
  80052a:	e8 95 1e 00 00       	call   8023c4 <sys_rcr2>
  80052f:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
  800535:	89 d1                	mov    %edx,%ecx
  800537:	8b 55 d0             	mov    -0x30(%ebp),%edx
  80053a:	01 ca                	add    %ecx,%edx
  80053c:	39 d0                	cmp    %edx,%eax
  80053e:	74 14                	je     800554 <_main+0x51c>
  800540:	83 ec 04             	sub    $0x4,%esp
  800543:	68 44 29 80 00       	push   $0x802944
  800548:	6a 6f                	push   $0x6f
  80054a:	68 5c 28 80 00       	push   $0x80285c
  80054f:	e8 bb 05 00 00       	call   800b0f <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800554:	e8 6d 1b 00 00       	call   8020c6 <sys_calculate_free_frames>
  800559:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80055c:	e8 e8 1b 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  800561:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[1]);
  800564:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800567:	83 ec 0c             	sub    $0xc,%esp
  80056a:	50                   	push   %eax
  80056b:	e8 a5 18 00 00       	call   801e15 <free>
  800570:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800573:	e8 d1 1b 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  800578:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80057b:	29 c2                	sub    %eax,%edx
  80057d:	89 d0                	mov    %edx,%eax
  80057f:	3d 00 02 00 00       	cmp    $0x200,%eax
  800584:	74 14                	je     80059a <_main+0x562>
  800586:	83 ec 04             	sub    $0x4,%esp
  800589:	68 08 29 80 00       	push   $0x802908
  80058e:	6a 74                	push   $0x74
  800590:	68 5c 28 80 00       	push   $0x80285c
  800595:	e8 75 05 00 00       	call   800b0f <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 512 + 1 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[1];
  80059a:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80059d:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  8005a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005a3:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  8005a6:	e8 19 1e 00 00       	call   8023c4 <sys_rcr2>
  8005ab:	89 c2                	mov    %eax,%edx
  8005ad:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005b0:	39 c2                	cmp    %eax,%edx
  8005b2:	74 14                	je     8005c8 <_main+0x590>
  8005b4:	83 ec 04             	sub    $0x4,%esp
  8005b7:	68 44 29 80 00       	push   $0x802944
  8005bc:	6a 78                	push   $0x78
  8005be:	68 5c 28 80 00       	push   $0x80285c
  8005c3:	e8 47 05 00 00       	call   800b0f <_panic>
		byteArr[lastIndices[1]] = 10;
  8005c8:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  8005ce:	89 c2                	mov    %eax,%edx
  8005d0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005d3:	01 d0                	add    %edx,%eax
  8005d5:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[1]])) panic("Free: successful access to freed space!! it should not be succeeded");
  8005d8:	e8 e7 1d 00 00       	call   8023c4 <sys_rcr2>
  8005dd:	8b 95 34 ff ff ff    	mov    -0xcc(%ebp),%edx
  8005e3:	89 d1                	mov    %edx,%ecx
  8005e5:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8005e8:	01 ca                	add    %ecx,%edx
  8005ea:	39 d0                	cmp    %edx,%eax
  8005ec:	74 14                	je     800602 <_main+0x5ca>
  8005ee:	83 ec 04             	sub    $0x4,%esp
  8005f1:	68 44 29 80 00       	push   $0x802944
  8005f6:	6a 7a                	push   $0x7a
  8005f8:	68 5c 28 80 00       	push   $0x80285c
  8005fd:	e8 0d 05 00 00       	call   800b0f <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800602:	e8 bf 1a 00 00       	call   8020c6 <sys_calculate_free_frames>
  800607:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80060a:	e8 3a 1b 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  80060f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[2]);
  800612:	8b 45 88             	mov    -0x78(%ebp),%eax
  800615:	83 ec 0c             	sub    $0xc,%esp
  800618:	50                   	push   %eax
  800619:	e8 f7 17 00 00       	call   801e15 <free>
  80061e:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  800621:	e8 23 1b 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  800626:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800629:	29 c2                	sub    %eax,%edx
  80062b:	89 d0                	mov    %edx,%eax
  80062d:	83 f8 01             	cmp    $0x1,%eax
  800630:	74 14                	je     800646 <_main+0x60e>
  800632:	83 ec 04             	sub    $0x4,%esp
  800635:	68 08 29 80 00       	push   $0x802908
  80063a:	6a 7f                	push   $0x7f
  80063c:	68 5c 28 80 00       	push   $0x80285c
  800641:	e8 c9 04 00 00       	call   800b0f <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 1 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[2];
  800646:	8b 45 88             	mov    -0x78(%ebp),%eax
  800649:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  80064c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80064f:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  800652:	e8 6d 1d 00 00       	call   8023c4 <sys_rcr2>
  800657:	89 c2                	mov    %eax,%edx
  800659:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80065c:	39 c2                	cmp    %eax,%edx
  80065e:	74 17                	je     800677 <_main+0x63f>
  800660:	83 ec 04             	sub    $0x4,%esp
  800663:	68 44 29 80 00       	push   $0x802944
  800668:	68 83 00 00 00       	push   $0x83
  80066d:	68 5c 28 80 00       	push   $0x80285c
  800672:	e8 98 04 00 00       	call   800b0f <_panic>
		byteArr[lastIndices[2]] = 10;
  800677:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  80067d:	89 c2                	mov    %eax,%edx
  80067f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800682:	01 d0                	add    %edx,%eax
  800684:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[2]])) panic("Free: successful access to freed space!! it should not be succeeded");
  800687:	e8 38 1d 00 00       	call   8023c4 <sys_rcr2>
  80068c:	8b 95 38 ff ff ff    	mov    -0xc8(%ebp),%edx
  800692:	89 d1                	mov    %edx,%ecx
  800694:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800697:	01 ca                	add    %ecx,%edx
  800699:	39 d0                	cmp    %edx,%eax
  80069b:	74 17                	je     8006b4 <_main+0x67c>
  80069d:	83 ec 04             	sub    $0x4,%esp
  8006a0:	68 44 29 80 00       	push   $0x802944
  8006a5:	68 85 00 00 00       	push   $0x85
  8006aa:	68 5c 28 80 00       	push   $0x80285c
  8006af:	e8 5b 04 00 00       	call   800b0f <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8006b4:	e8 0d 1a 00 00       	call   8020c6 <sys_calculate_free_frames>
  8006b9:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8006bc:	e8 88 1a 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  8006c1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[3]);
  8006c4:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8006c7:	83 ec 0c             	sub    $0xc,%esp
  8006ca:	50                   	push   %eax
  8006cb:	e8 45 17 00 00       	call   801e15 <free>
  8006d0:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  8006d3:	e8 71 1a 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  8006d8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8006db:	29 c2                	sub    %eax,%edx
  8006dd:	89 d0                	mov    %edx,%eax
  8006df:	83 f8 01             	cmp    $0x1,%eax
  8006e2:	74 17                	je     8006fb <_main+0x6c3>
  8006e4:	83 ec 04             	sub    $0x4,%esp
  8006e7:	68 08 29 80 00       	push   $0x802908
  8006ec:	68 8a 00 00 00       	push   $0x8a
  8006f1:	68 5c 28 80 00       	push   $0x80285c
  8006f6:	e8 14 04 00 00       	call   800b0f <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 1 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[3];
  8006fb:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8006fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  800701:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800704:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  800707:	e8 b8 1c 00 00       	call   8023c4 <sys_rcr2>
  80070c:	89 c2                	mov    %eax,%edx
  80070e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800711:	39 c2                	cmp    %eax,%edx
  800713:	74 17                	je     80072c <_main+0x6f4>
  800715:	83 ec 04             	sub    $0x4,%esp
  800718:	68 44 29 80 00       	push   $0x802944
  80071d:	68 8e 00 00 00       	push   $0x8e
  800722:	68 5c 28 80 00       	push   $0x80285c
  800727:	e8 e3 03 00 00       	call   800b0f <_panic>
		byteArr[lastIndices[3]] = 10;
  80072c:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800732:	89 c2                	mov    %eax,%edx
  800734:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800737:	01 d0                	add    %edx,%eax
  800739:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[3]])) panic("Free: successful access to freed space!! it should not be succeeded");
  80073c:	e8 83 1c 00 00       	call   8023c4 <sys_rcr2>
  800741:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  800747:	89 d1                	mov    %edx,%ecx
  800749:	8b 55 d0             	mov    -0x30(%ebp),%edx
  80074c:	01 ca                	add    %ecx,%edx
  80074e:	39 d0                	cmp    %edx,%eax
  800750:	74 17                	je     800769 <_main+0x731>
  800752:	83 ec 04             	sub    $0x4,%esp
  800755:	68 44 29 80 00       	push   $0x802944
  80075a:	68 90 00 00 00       	push   $0x90
  80075f:	68 5c 28 80 00       	push   $0x80285c
  800764:	e8 a6 03 00 00       	call   800b0f <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800769:	e8 58 19 00 00       	call   8020c6 <sys_calculate_free_frames>
  80076e:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800771:	e8 d3 19 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  800776:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[4]);
  800779:	8b 45 90             	mov    -0x70(%ebp),%eax
  80077c:	83 ec 0c             	sub    $0xc,%esp
  80077f:	50                   	push   %eax
  800780:	e8 90 16 00 00       	call   801e15 <free>
  800785:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  800788:	e8 bc 19 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  80078d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800790:	29 c2                	sub    %eax,%edx
  800792:	89 d0                	mov    %edx,%eax
  800794:	83 f8 02             	cmp    $0x2,%eax
  800797:	74 17                	je     8007b0 <_main+0x778>
  800799:	83 ec 04             	sub    $0x4,%esp
  80079c:	68 08 29 80 00       	push   $0x802908
  8007a1:	68 95 00 00 00       	push   $0x95
  8007a6:	68 5c 28 80 00       	push   $0x80285c
  8007ab:	e8 5f 03 00 00       	call   800b0f <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[4];
  8007b0:	8b 45 90             	mov    -0x70(%ebp),%eax
  8007b3:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  8007b6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007b9:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  8007bc:	e8 03 1c 00 00       	call   8023c4 <sys_rcr2>
  8007c1:	89 c2                	mov    %eax,%edx
  8007c3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007c6:	39 c2                	cmp    %eax,%edx
  8007c8:	74 17                	je     8007e1 <_main+0x7a9>
  8007ca:	83 ec 04             	sub    $0x4,%esp
  8007cd:	68 44 29 80 00       	push   $0x802944
  8007d2:	68 99 00 00 00       	push   $0x99
  8007d7:	68 5c 28 80 00       	push   $0x80285c
  8007dc:	e8 2e 03 00 00       	call   800b0f <_panic>
		byteArr[lastIndices[4]] = 10;
  8007e1:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  8007e7:	89 c2                	mov    %eax,%edx
  8007e9:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007ec:	01 d0                	add    %edx,%eax
  8007ee:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[4]])) panic("Free: successful access to freed space!! it should not be succeeded");
  8007f1:	e8 ce 1b 00 00       	call   8023c4 <sys_rcr2>
  8007f6:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
  8007fc:	89 d1                	mov    %edx,%ecx
  8007fe:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800801:	01 ca                	add    %ecx,%edx
  800803:	39 d0                	cmp    %edx,%eax
  800805:	74 17                	je     80081e <_main+0x7e6>
  800807:	83 ec 04             	sub    $0x4,%esp
  80080a:	68 44 29 80 00       	push   $0x802944
  80080f:	68 9b 00 00 00       	push   $0x9b
  800814:	68 5c 28 80 00       	push   $0x80285c
  800819:	e8 f1 02 00 00       	call   800b0f <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80081e:	e8 a3 18 00 00       	call   8020c6 <sys_calculate_free_frames>
  800823:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800826:	e8 1e 19 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  80082b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[5]);
  80082e:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800831:	83 ec 0c             	sub    $0xc,%esp
  800834:	50                   	push   %eax
  800835:	e8 db 15 00 00       	call   801e15 <free>
  80083a:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096 ) panic("Wrong free: Extra or less pages are removed from PageFile");
  80083d:	e8 07 19 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  800842:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800845:	89 d1                	mov    %edx,%ecx
  800847:	29 c1                	sub    %eax,%ecx
  800849:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80084c:	89 c2                	mov    %eax,%edx
  80084e:	01 d2                	add    %edx,%edx
  800850:	01 d0                	add    %edx,%eax
  800852:	85 c0                	test   %eax,%eax
  800854:	79 05                	jns    80085b <_main+0x823>
  800856:	05 ff 0f 00 00       	add    $0xfff,%eax
  80085b:	c1 f8 0c             	sar    $0xc,%eax
  80085e:	39 c1                	cmp    %eax,%ecx
  800860:	74 17                	je     800879 <_main+0x841>
  800862:	83 ec 04             	sub    $0x4,%esp
  800865:	68 08 29 80 00       	push   $0x802908
  80086a:	68 a0 00 00 00       	push   $0xa0
  80086f:	68 5c 28 80 00       	push   $0x80285c
  800874:	e8 96 02 00 00       	call   800b0f <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 3*Mega/4096 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[5];
  800879:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80087c:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  80087f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800882:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  800885:	e8 3a 1b 00 00       	call   8023c4 <sys_rcr2>
  80088a:	89 c2                	mov    %eax,%edx
  80088c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80088f:	39 c2                	cmp    %eax,%edx
  800891:	74 17                	je     8008aa <_main+0x872>
  800893:	83 ec 04             	sub    $0x4,%esp
  800896:	68 44 29 80 00       	push   $0x802944
  80089b:	68 a4 00 00 00       	push   $0xa4
  8008a0:	68 5c 28 80 00       	push   $0x80285c
  8008a5:	e8 65 02 00 00       	call   800b0f <_panic>
		byteArr[lastIndices[5]] = 10;
  8008aa:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  8008b0:	89 c2                	mov    %eax,%edx
  8008b2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8008b5:	01 d0                	add    %edx,%eax
  8008b7:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[5]])) panic("Free: successful access to freed space!! it should not be succeeded");
  8008ba:	e8 05 1b 00 00       	call   8023c4 <sys_rcr2>
  8008bf:	8b 95 44 ff ff ff    	mov    -0xbc(%ebp),%edx
  8008c5:	89 d1                	mov    %edx,%ecx
  8008c7:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8008ca:	01 ca                	add    %ecx,%edx
  8008cc:	39 d0                	cmp    %edx,%eax
  8008ce:	74 17                	je     8008e7 <_main+0x8af>
  8008d0:	83 ec 04             	sub    $0x4,%esp
  8008d3:	68 44 29 80 00       	push   $0x802944
  8008d8:	68 a6 00 00 00       	push   $0xa6
  8008dd:	68 5c 28 80 00       	push   $0x80285c
  8008e2:	e8 28 02 00 00       	call   800b0f <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8008e7:	e8 da 17 00 00       	call   8020c6 <sys_calculate_free_frames>
  8008ec:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008ef:	e8 55 18 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  8008f4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[6]);
  8008f7:	8b 45 98             	mov    -0x68(%ebp),%eax
  8008fa:	83 ec 0c             	sub    $0xc,%esp
  8008fd:	50                   	push   %eax
  8008fe:	e8 12 15 00 00       	call   801e15 <free>
  800903:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800906:	e8 3e 18 00 00       	call   802149 <sys_pf_calculate_allocated_pages>
  80090b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80090e:	29 c2                	sub    %eax,%edx
  800910:	89 d0                	mov    %edx,%eax
  800912:	3d 00 02 00 00       	cmp    $0x200,%eax
  800917:	74 17                	je     800930 <_main+0x8f8>
  800919:	83 ec 04             	sub    $0x4,%esp
  80091c:	68 08 29 80 00       	push   $0x802908
  800921:	68 ab 00 00 00       	push   $0xab
  800926:	68 5c 28 80 00       	push   $0x80285c
  80092b:	e8 df 01 00 00       	call   800b0f <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 512 + 2) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[6];
  800930:	8b 45 98             	mov    -0x68(%ebp),%eax
  800933:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  800936:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800939:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  80093c:	e8 83 1a 00 00       	call   8023c4 <sys_rcr2>
  800941:	89 c2                	mov    %eax,%edx
  800943:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800946:	39 c2                	cmp    %eax,%edx
  800948:	74 17                	je     800961 <_main+0x929>
  80094a:	83 ec 04             	sub    $0x4,%esp
  80094d:	68 44 29 80 00       	push   $0x802944
  800952:	68 af 00 00 00       	push   $0xaf
  800957:	68 5c 28 80 00       	push   $0x80285c
  80095c:	e8 ae 01 00 00       	call   800b0f <_panic>
		byteArr[lastIndices[6]] = 10;
  800961:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800967:	89 c2                	mov    %eax,%edx
  800969:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80096c:	01 d0                	add    %edx,%eax
  80096e:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[6]])) panic("Free: successful access to freed space!! it should not be succeeded");
  800971:	e8 4e 1a 00 00       	call   8023c4 <sys_rcr2>
  800976:	8b 95 48 ff ff ff    	mov    -0xb8(%ebp),%edx
  80097c:	89 d1                	mov    %edx,%ecx
  80097e:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800981:	01 ca                	add    %ecx,%edx
  800983:	39 d0                	cmp    %edx,%eax
  800985:	74 17                	je     80099e <_main+0x966>
  800987:	83 ec 04             	sub    $0x4,%esp
  80098a:	68 44 29 80 00       	push   $0x802944
  80098f:	68 b1 00 00 00       	push   $0xb1
  800994:	68 5c 28 80 00       	push   $0x80285c
  800999:	e8 71 01 00 00       	call   800b0f <_panic>

		if(start_freeFrames != (sys_calculate_free_frames() + 3) ) {panic("Wrong free: not all pages removed correctly at end");}
  80099e:	e8 23 17 00 00       	call   8020c6 <sys_calculate_free_frames>
  8009a3:	8d 50 03             	lea    0x3(%eax),%edx
  8009a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009a9:	39 c2                	cmp    %eax,%edx
  8009ab:	74 17                	je     8009c4 <_main+0x98c>
  8009ad:	83 ec 04             	sub    $0x4,%esp
  8009b0:	68 88 29 80 00       	push   $0x802988
  8009b5:	68 b3 00 00 00       	push   $0xb3
  8009ba:	68 5c 28 80 00       	push   $0x80285c
  8009bf:	e8 4b 01 00 00       	call   800b0f <_panic>
	}

	//set it to 0 again to cancel the bypassing option
	sys_bypassPageFault(0);
  8009c4:	83 ec 0c             	sub    $0xc,%esp
  8009c7:	6a 00                	push   $0x0
  8009c9:	e8 0f 1a 00 00       	call   8023dd <sys_bypassPageFault>
  8009ce:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! test free [2] completed successfully.\n");
  8009d1:	83 ec 0c             	sub    $0xc,%esp
  8009d4:	68 bc 29 80 00       	push   $0x8029bc
  8009d9:	e8 e8 03 00 00       	call   800dc6 <cprintf>
  8009de:	83 c4 10             	add    $0x10,%esp

	return;
  8009e1:	90                   	nop
}
  8009e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
  8009e5:	c9                   	leave  
  8009e6:	c3                   	ret    

008009e7 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8009e7:	55                   	push   %ebp
  8009e8:	89 e5                	mov    %esp,%ebp
  8009ea:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8009ed:	e8 09 16 00 00       	call   801ffb <sys_getenvindex>
  8009f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8009f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009f8:	89 d0                	mov    %edx,%eax
  8009fa:	01 c0                	add    %eax,%eax
  8009fc:	01 d0                	add    %edx,%eax
  8009fe:	c1 e0 07             	shl    $0x7,%eax
  800a01:	29 d0                	sub    %edx,%eax
  800a03:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a0a:	01 c8                	add    %ecx,%eax
  800a0c:	01 c0                	add    %eax,%eax
  800a0e:	01 d0                	add    %edx,%eax
  800a10:	01 c0                	add    %eax,%eax
  800a12:	01 d0                	add    %edx,%eax
  800a14:	c1 e0 03             	shl    $0x3,%eax
  800a17:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800a1c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800a21:	a1 20 30 80 00       	mov    0x803020,%eax
  800a26:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800a2c:	84 c0                	test   %al,%al
  800a2e:	74 0f                	je     800a3f <libmain+0x58>
		binaryname = myEnv->prog_name;
  800a30:	a1 20 30 80 00       	mov    0x803020,%eax
  800a35:	05 f0 ee 00 00       	add    $0xeef0,%eax
  800a3a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800a3f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a43:	7e 0a                	jle    800a4f <libmain+0x68>
		binaryname = argv[0];
  800a45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a48:	8b 00                	mov    (%eax),%eax
  800a4a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800a4f:	83 ec 08             	sub    $0x8,%esp
  800a52:	ff 75 0c             	pushl  0xc(%ebp)
  800a55:	ff 75 08             	pushl  0x8(%ebp)
  800a58:	e8 db f5 ff ff       	call   800038 <_main>
  800a5d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800a60:	e8 31 17 00 00       	call   802196 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800a65:	83 ec 0c             	sub    $0xc,%esp
  800a68:	68 10 2a 80 00       	push   $0x802a10
  800a6d:	e8 54 03 00 00       	call   800dc6 <cprintf>
  800a72:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800a75:	a1 20 30 80 00       	mov    0x803020,%eax
  800a7a:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800a80:	a1 20 30 80 00       	mov    0x803020,%eax
  800a85:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  800a8b:	83 ec 04             	sub    $0x4,%esp
  800a8e:	52                   	push   %edx
  800a8f:	50                   	push   %eax
  800a90:	68 38 2a 80 00       	push   $0x802a38
  800a95:	e8 2c 03 00 00       	call   800dc6 <cprintf>
  800a9a:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800a9d:	a1 20 30 80 00       	mov    0x803020,%eax
  800aa2:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800aa8:	a1 20 30 80 00       	mov    0x803020,%eax
  800aad:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800ab3:	a1 20 30 80 00       	mov    0x803020,%eax
  800ab8:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  800abe:	51                   	push   %ecx
  800abf:	52                   	push   %edx
  800ac0:	50                   	push   %eax
  800ac1:	68 60 2a 80 00       	push   $0x802a60
  800ac6:	e8 fb 02 00 00       	call   800dc6 <cprintf>
  800acb:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800ace:	83 ec 0c             	sub    $0xc,%esp
  800ad1:	68 10 2a 80 00       	push   $0x802a10
  800ad6:	e8 eb 02 00 00       	call   800dc6 <cprintf>
  800adb:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800ade:	e8 cd 16 00 00       	call   8021b0 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800ae3:	e8 19 00 00 00       	call   800b01 <exit>
}
  800ae8:	90                   	nop
  800ae9:	c9                   	leave  
  800aea:	c3                   	ret    

00800aeb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800aeb:	55                   	push   %ebp
  800aec:	89 e5                	mov    %esp,%ebp
  800aee:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800af1:	83 ec 0c             	sub    $0xc,%esp
  800af4:	6a 00                	push   $0x0
  800af6:	e8 cc 14 00 00       	call   801fc7 <sys_env_destroy>
  800afb:	83 c4 10             	add    $0x10,%esp
}
  800afe:	90                   	nop
  800aff:	c9                   	leave  
  800b00:	c3                   	ret    

00800b01 <exit>:

void
exit(void)
{
  800b01:	55                   	push   %ebp
  800b02:	89 e5                	mov    %esp,%ebp
  800b04:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800b07:	e8 21 15 00 00       	call   80202d <sys_env_exit>
}
  800b0c:	90                   	nop
  800b0d:	c9                   	leave  
  800b0e:	c3                   	ret    

00800b0f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800b0f:	55                   	push   %ebp
  800b10:	89 e5                	mov    %esp,%ebp
  800b12:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800b15:	8d 45 10             	lea    0x10(%ebp),%eax
  800b18:	83 c0 04             	add    $0x4,%eax
  800b1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800b1e:	a1 18 31 80 00       	mov    0x803118,%eax
  800b23:	85 c0                	test   %eax,%eax
  800b25:	74 16                	je     800b3d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800b27:	a1 18 31 80 00       	mov    0x803118,%eax
  800b2c:	83 ec 08             	sub    $0x8,%esp
  800b2f:	50                   	push   %eax
  800b30:	68 b8 2a 80 00       	push   $0x802ab8
  800b35:	e8 8c 02 00 00       	call   800dc6 <cprintf>
  800b3a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800b3d:	a1 00 30 80 00       	mov    0x803000,%eax
  800b42:	ff 75 0c             	pushl  0xc(%ebp)
  800b45:	ff 75 08             	pushl  0x8(%ebp)
  800b48:	50                   	push   %eax
  800b49:	68 bd 2a 80 00       	push   $0x802abd
  800b4e:	e8 73 02 00 00       	call   800dc6 <cprintf>
  800b53:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800b56:	8b 45 10             	mov    0x10(%ebp),%eax
  800b59:	83 ec 08             	sub    $0x8,%esp
  800b5c:	ff 75 f4             	pushl  -0xc(%ebp)
  800b5f:	50                   	push   %eax
  800b60:	e8 f6 01 00 00       	call   800d5b <vcprintf>
  800b65:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800b68:	83 ec 08             	sub    $0x8,%esp
  800b6b:	6a 00                	push   $0x0
  800b6d:	68 d9 2a 80 00       	push   $0x802ad9
  800b72:	e8 e4 01 00 00       	call   800d5b <vcprintf>
  800b77:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800b7a:	e8 82 ff ff ff       	call   800b01 <exit>

	// should not return here
	while (1) ;
  800b7f:	eb fe                	jmp    800b7f <_panic+0x70>

00800b81 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800b81:	55                   	push   %ebp
  800b82:	89 e5                	mov    %esp,%ebp
  800b84:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800b87:	a1 20 30 80 00       	mov    0x803020,%eax
  800b8c:	8b 50 74             	mov    0x74(%eax),%edx
  800b8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b92:	39 c2                	cmp    %eax,%edx
  800b94:	74 14                	je     800baa <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800b96:	83 ec 04             	sub    $0x4,%esp
  800b99:	68 dc 2a 80 00       	push   $0x802adc
  800b9e:	6a 26                	push   $0x26
  800ba0:	68 28 2b 80 00       	push   $0x802b28
  800ba5:	e8 65 ff ff ff       	call   800b0f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800baa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800bb1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800bb8:	e9 c4 00 00 00       	jmp    800c81 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800bbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bc0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800bc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bca:	01 d0                	add    %edx,%eax
  800bcc:	8b 00                	mov    (%eax),%eax
  800bce:	85 c0                	test   %eax,%eax
  800bd0:	75 08                	jne    800bda <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800bd2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800bd5:	e9 a4 00 00 00       	jmp    800c7e <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800bda:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800be1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800be8:	eb 6b                	jmp    800c55 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800bea:	a1 20 30 80 00       	mov    0x803020,%eax
  800bef:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800bf5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800bf8:	89 d0                	mov    %edx,%eax
  800bfa:	c1 e0 02             	shl    $0x2,%eax
  800bfd:	01 d0                	add    %edx,%eax
  800bff:	c1 e0 02             	shl    $0x2,%eax
  800c02:	01 c8                	add    %ecx,%eax
  800c04:	8a 40 04             	mov    0x4(%eax),%al
  800c07:	84 c0                	test   %al,%al
  800c09:	75 47                	jne    800c52 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800c0b:	a1 20 30 80 00       	mov    0x803020,%eax
  800c10:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800c16:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800c19:	89 d0                	mov    %edx,%eax
  800c1b:	c1 e0 02             	shl    $0x2,%eax
  800c1e:	01 d0                	add    %edx,%eax
  800c20:	c1 e0 02             	shl    $0x2,%eax
  800c23:	01 c8                	add    %ecx,%eax
  800c25:	8b 00                	mov    (%eax),%eax
  800c27:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800c2a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800c2d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c32:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800c34:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c37:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c41:	01 c8                	add    %ecx,%eax
  800c43:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800c45:	39 c2                	cmp    %eax,%edx
  800c47:	75 09                	jne    800c52 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800c49:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800c50:	eb 12                	jmp    800c64 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800c52:	ff 45 e8             	incl   -0x18(%ebp)
  800c55:	a1 20 30 80 00       	mov    0x803020,%eax
  800c5a:	8b 50 74             	mov    0x74(%eax),%edx
  800c5d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800c60:	39 c2                	cmp    %eax,%edx
  800c62:	77 86                	ja     800bea <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800c64:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800c68:	75 14                	jne    800c7e <CheckWSWithoutLastIndex+0xfd>
			panic(
  800c6a:	83 ec 04             	sub    $0x4,%esp
  800c6d:	68 34 2b 80 00       	push   $0x802b34
  800c72:	6a 3a                	push   $0x3a
  800c74:	68 28 2b 80 00       	push   $0x802b28
  800c79:	e8 91 fe ff ff       	call   800b0f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800c7e:	ff 45 f0             	incl   -0x10(%ebp)
  800c81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c84:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800c87:	0f 8c 30 ff ff ff    	jl     800bbd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800c8d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800c94:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800c9b:	eb 27                	jmp    800cc4 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800c9d:	a1 20 30 80 00       	mov    0x803020,%eax
  800ca2:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800ca8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cab:	89 d0                	mov    %edx,%eax
  800cad:	c1 e0 02             	shl    $0x2,%eax
  800cb0:	01 d0                	add    %edx,%eax
  800cb2:	c1 e0 02             	shl    $0x2,%eax
  800cb5:	01 c8                	add    %ecx,%eax
  800cb7:	8a 40 04             	mov    0x4(%eax),%al
  800cba:	3c 01                	cmp    $0x1,%al
  800cbc:	75 03                	jne    800cc1 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800cbe:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800cc1:	ff 45 e0             	incl   -0x20(%ebp)
  800cc4:	a1 20 30 80 00       	mov    0x803020,%eax
  800cc9:	8b 50 74             	mov    0x74(%eax),%edx
  800ccc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ccf:	39 c2                	cmp    %eax,%edx
  800cd1:	77 ca                	ja     800c9d <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800cd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800cd6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800cd9:	74 14                	je     800cef <CheckWSWithoutLastIndex+0x16e>
		panic(
  800cdb:	83 ec 04             	sub    $0x4,%esp
  800cde:	68 88 2b 80 00       	push   $0x802b88
  800ce3:	6a 44                	push   $0x44
  800ce5:	68 28 2b 80 00       	push   $0x802b28
  800cea:	e8 20 fe ff ff       	call   800b0f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800cef:	90                   	nop
  800cf0:	c9                   	leave  
  800cf1:	c3                   	ret    

00800cf2 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800cf2:	55                   	push   %ebp
  800cf3:	89 e5                	mov    %esp,%ebp
  800cf5:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800cf8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfb:	8b 00                	mov    (%eax),%eax
  800cfd:	8d 48 01             	lea    0x1(%eax),%ecx
  800d00:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d03:	89 0a                	mov    %ecx,(%edx)
  800d05:	8b 55 08             	mov    0x8(%ebp),%edx
  800d08:	88 d1                	mov    %dl,%cl
  800d0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d0d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800d11:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d14:	8b 00                	mov    (%eax),%eax
  800d16:	3d ff 00 00 00       	cmp    $0xff,%eax
  800d1b:	75 2c                	jne    800d49 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800d1d:	a0 24 30 80 00       	mov    0x803024,%al
  800d22:	0f b6 c0             	movzbl %al,%eax
  800d25:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d28:	8b 12                	mov    (%edx),%edx
  800d2a:	89 d1                	mov    %edx,%ecx
  800d2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d2f:	83 c2 08             	add    $0x8,%edx
  800d32:	83 ec 04             	sub    $0x4,%esp
  800d35:	50                   	push   %eax
  800d36:	51                   	push   %ecx
  800d37:	52                   	push   %edx
  800d38:	e8 48 12 00 00       	call   801f85 <sys_cputs>
  800d3d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800d40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d43:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800d49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4c:	8b 40 04             	mov    0x4(%eax),%eax
  800d4f:	8d 50 01             	lea    0x1(%eax),%edx
  800d52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d55:	89 50 04             	mov    %edx,0x4(%eax)
}
  800d58:	90                   	nop
  800d59:	c9                   	leave  
  800d5a:	c3                   	ret    

00800d5b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800d5b:	55                   	push   %ebp
  800d5c:	89 e5                	mov    %esp,%ebp
  800d5e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800d64:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800d6b:	00 00 00 
	b.cnt = 0;
  800d6e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800d75:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800d78:	ff 75 0c             	pushl  0xc(%ebp)
  800d7b:	ff 75 08             	pushl  0x8(%ebp)
  800d7e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800d84:	50                   	push   %eax
  800d85:	68 f2 0c 80 00       	push   $0x800cf2
  800d8a:	e8 11 02 00 00       	call   800fa0 <vprintfmt>
  800d8f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800d92:	a0 24 30 80 00       	mov    0x803024,%al
  800d97:	0f b6 c0             	movzbl %al,%eax
  800d9a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800da0:	83 ec 04             	sub    $0x4,%esp
  800da3:	50                   	push   %eax
  800da4:	52                   	push   %edx
  800da5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800dab:	83 c0 08             	add    $0x8,%eax
  800dae:	50                   	push   %eax
  800daf:	e8 d1 11 00 00       	call   801f85 <sys_cputs>
  800db4:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800db7:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800dbe:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800dc4:	c9                   	leave  
  800dc5:	c3                   	ret    

00800dc6 <cprintf>:

int cprintf(const char *fmt, ...) {
  800dc6:	55                   	push   %ebp
  800dc7:	89 e5                	mov    %esp,%ebp
  800dc9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800dcc:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800dd3:	8d 45 0c             	lea    0xc(%ebp),%eax
  800dd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	83 ec 08             	sub    $0x8,%esp
  800ddf:	ff 75 f4             	pushl  -0xc(%ebp)
  800de2:	50                   	push   %eax
  800de3:	e8 73 ff ff ff       	call   800d5b <vcprintf>
  800de8:	83 c4 10             	add    $0x10,%esp
  800deb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800dee:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800df1:	c9                   	leave  
  800df2:	c3                   	ret    

00800df3 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800df3:	55                   	push   %ebp
  800df4:	89 e5                	mov    %esp,%ebp
  800df6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800df9:	e8 98 13 00 00       	call   802196 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800dfe:	8d 45 0c             	lea    0xc(%ebp),%eax
  800e01:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800e04:	8b 45 08             	mov    0x8(%ebp),%eax
  800e07:	83 ec 08             	sub    $0x8,%esp
  800e0a:	ff 75 f4             	pushl  -0xc(%ebp)
  800e0d:	50                   	push   %eax
  800e0e:	e8 48 ff ff ff       	call   800d5b <vcprintf>
  800e13:	83 c4 10             	add    $0x10,%esp
  800e16:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800e19:	e8 92 13 00 00       	call   8021b0 <sys_enable_interrupt>
	return cnt;
  800e1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e21:	c9                   	leave  
  800e22:	c3                   	ret    

00800e23 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800e23:	55                   	push   %ebp
  800e24:	89 e5                	mov    %esp,%ebp
  800e26:	53                   	push   %ebx
  800e27:	83 ec 14             	sub    $0x14,%esp
  800e2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e30:	8b 45 14             	mov    0x14(%ebp),%eax
  800e33:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800e36:	8b 45 18             	mov    0x18(%ebp),%eax
  800e39:	ba 00 00 00 00       	mov    $0x0,%edx
  800e3e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800e41:	77 55                	ja     800e98 <printnum+0x75>
  800e43:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800e46:	72 05                	jb     800e4d <printnum+0x2a>
  800e48:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e4b:	77 4b                	ja     800e98 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800e4d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800e50:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800e53:	8b 45 18             	mov    0x18(%ebp),%eax
  800e56:	ba 00 00 00 00       	mov    $0x0,%edx
  800e5b:	52                   	push   %edx
  800e5c:	50                   	push   %eax
  800e5d:	ff 75 f4             	pushl  -0xc(%ebp)
  800e60:	ff 75 f0             	pushl  -0x10(%ebp)
  800e63:	e8 6c 17 00 00       	call   8025d4 <__udivdi3>
  800e68:	83 c4 10             	add    $0x10,%esp
  800e6b:	83 ec 04             	sub    $0x4,%esp
  800e6e:	ff 75 20             	pushl  0x20(%ebp)
  800e71:	53                   	push   %ebx
  800e72:	ff 75 18             	pushl  0x18(%ebp)
  800e75:	52                   	push   %edx
  800e76:	50                   	push   %eax
  800e77:	ff 75 0c             	pushl  0xc(%ebp)
  800e7a:	ff 75 08             	pushl  0x8(%ebp)
  800e7d:	e8 a1 ff ff ff       	call   800e23 <printnum>
  800e82:	83 c4 20             	add    $0x20,%esp
  800e85:	eb 1a                	jmp    800ea1 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800e87:	83 ec 08             	sub    $0x8,%esp
  800e8a:	ff 75 0c             	pushl  0xc(%ebp)
  800e8d:	ff 75 20             	pushl  0x20(%ebp)
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
  800e93:	ff d0                	call   *%eax
  800e95:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800e98:	ff 4d 1c             	decl   0x1c(%ebp)
  800e9b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800e9f:	7f e6                	jg     800e87 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ea1:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ea4:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ea9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eaf:	53                   	push   %ebx
  800eb0:	51                   	push   %ecx
  800eb1:	52                   	push   %edx
  800eb2:	50                   	push   %eax
  800eb3:	e8 2c 18 00 00       	call   8026e4 <__umoddi3>
  800eb8:	83 c4 10             	add    $0x10,%esp
  800ebb:	05 f4 2d 80 00       	add    $0x802df4,%eax
  800ec0:	8a 00                	mov    (%eax),%al
  800ec2:	0f be c0             	movsbl %al,%eax
  800ec5:	83 ec 08             	sub    $0x8,%esp
  800ec8:	ff 75 0c             	pushl  0xc(%ebp)
  800ecb:	50                   	push   %eax
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecf:	ff d0                	call   *%eax
  800ed1:	83 c4 10             	add    $0x10,%esp
}
  800ed4:	90                   	nop
  800ed5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ed8:	c9                   	leave  
  800ed9:	c3                   	ret    

00800eda <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800eda:	55                   	push   %ebp
  800edb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800edd:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ee1:	7e 1c                	jle    800eff <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ee3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee6:	8b 00                	mov    (%eax),%eax
  800ee8:	8d 50 08             	lea    0x8(%eax),%edx
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	89 10                	mov    %edx,(%eax)
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	8b 00                	mov    (%eax),%eax
  800ef5:	83 e8 08             	sub    $0x8,%eax
  800ef8:	8b 50 04             	mov    0x4(%eax),%edx
  800efb:	8b 00                	mov    (%eax),%eax
  800efd:	eb 40                	jmp    800f3f <getuint+0x65>
	else if (lflag)
  800eff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f03:	74 1e                	je     800f23 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	8b 00                	mov    (%eax),%eax
  800f0a:	8d 50 04             	lea    0x4(%eax),%edx
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	89 10                	mov    %edx,(%eax)
  800f12:	8b 45 08             	mov    0x8(%ebp),%eax
  800f15:	8b 00                	mov    (%eax),%eax
  800f17:	83 e8 04             	sub    $0x4,%eax
  800f1a:	8b 00                	mov    (%eax),%eax
  800f1c:	ba 00 00 00 00       	mov    $0x0,%edx
  800f21:	eb 1c                	jmp    800f3f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	8b 00                	mov    (%eax),%eax
  800f28:	8d 50 04             	lea    0x4(%eax),%edx
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	89 10                	mov    %edx,(%eax)
  800f30:	8b 45 08             	mov    0x8(%ebp),%eax
  800f33:	8b 00                	mov    (%eax),%eax
  800f35:	83 e8 04             	sub    $0x4,%eax
  800f38:	8b 00                	mov    (%eax),%eax
  800f3a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800f3f:	5d                   	pop    %ebp
  800f40:	c3                   	ret    

00800f41 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800f41:	55                   	push   %ebp
  800f42:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800f44:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800f48:	7e 1c                	jle    800f66 <getint+0x25>
		return va_arg(*ap, long long);
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	8b 00                	mov    (%eax),%eax
  800f4f:	8d 50 08             	lea    0x8(%eax),%edx
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	89 10                	mov    %edx,(%eax)
  800f57:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5a:	8b 00                	mov    (%eax),%eax
  800f5c:	83 e8 08             	sub    $0x8,%eax
  800f5f:	8b 50 04             	mov    0x4(%eax),%edx
  800f62:	8b 00                	mov    (%eax),%eax
  800f64:	eb 38                	jmp    800f9e <getint+0x5d>
	else if (lflag)
  800f66:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f6a:	74 1a                	je     800f86 <getint+0x45>
		return va_arg(*ap, long);
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	8b 00                	mov    (%eax),%eax
  800f71:	8d 50 04             	lea    0x4(%eax),%edx
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	89 10                	mov    %edx,(%eax)
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8b 00                	mov    (%eax),%eax
  800f7e:	83 e8 04             	sub    $0x4,%eax
  800f81:	8b 00                	mov    (%eax),%eax
  800f83:	99                   	cltd   
  800f84:	eb 18                	jmp    800f9e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	8b 00                	mov    (%eax),%eax
  800f8b:	8d 50 04             	lea    0x4(%eax),%edx
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	89 10                	mov    %edx,(%eax)
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	8b 00                	mov    (%eax),%eax
  800f98:	83 e8 04             	sub    $0x4,%eax
  800f9b:	8b 00                	mov    (%eax),%eax
  800f9d:	99                   	cltd   
}
  800f9e:	5d                   	pop    %ebp
  800f9f:	c3                   	ret    

00800fa0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800fa0:	55                   	push   %ebp
  800fa1:	89 e5                	mov    %esp,%ebp
  800fa3:	56                   	push   %esi
  800fa4:	53                   	push   %ebx
  800fa5:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800fa8:	eb 17                	jmp    800fc1 <vprintfmt+0x21>
			if (ch == '\0')
  800faa:	85 db                	test   %ebx,%ebx
  800fac:	0f 84 af 03 00 00    	je     801361 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800fb2:	83 ec 08             	sub    $0x8,%esp
  800fb5:	ff 75 0c             	pushl  0xc(%ebp)
  800fb8:	53                   	push   %ebx
  800fb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbc:	ff d0                	call   *%eax
  800fbe:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800fc1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc4:	8d 50 01             	lea    0x1(%eax),%edx
  800fc7:	89 55 10             	mov    %edx,0x10(%ebp)
  800fca:	8a 00                	mov    (%eax),%al
  800fcc:	0f b6 d8             	movzbl %al,%ebx
  800fcf:	83 fb 25             	cmp    $0x25,%ebx
  800fd2:	75 d6                	jne    800faa <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800fd4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800fd8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800fdf:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800fe6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800fed:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ff4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff7:	8d 50 01             	lea    0x1(%eax),%edx
  800ffa:	89 55 10             	mov    %edx,0x10(%ebp)
  800ffd:	8a 00                	mov    (%eax),%al
  800fff:	0f b6 d8             	movzbl %al,%ebx
  801002:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801005:	83 f8 55             	cmp    $0x55,%eax
  801008:	0f 87 2b 03 00 00    	ja     801339 <vprintfmt+0x399>
  80100e:	8b 04 85 18 2e 80 00 	mov    0x802e18(,%eax,4),%eax
  801015:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801017:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80101b:	eb d7                	jmp    800ff4 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80101d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801021:	eb d1                	jmp    800ff4 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801023:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80102a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80102d:	89 d0                	mov    %edx,%eax
  80102f:	c1 e0 02             	shl    $0x2,%eax
  801032:	01 d0                	add    %edx,%eax
  801034:	01 c0                	add    %eax,%eax
  801036:	01 d8                	add    %ebx,%eax
  801038:	83 e8 30             	sub    $0x30,%eax
  80103b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80103e:	8b 45 10             	mov    0x10(%ebp),%eax
  801041:	8a 00                	mov    (%eax),%al
  801043:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801046:	83 fb 2f             	cmp    $0x2f,%ebx
  801049:	7e 3e                	jle    801089 <vprintfmt+0xe9>
  80104b:	83 fb 39             	cmp    $0x39,%ebx
  80104e:	7f 39                	jg     801089 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801050:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801053:	eb d5                	jmp    80102a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801055:	8b 45 14             	mov    0x14(%ebp),%eax
  801058:	83 c0 04             	add    $0x4,%eax
  80105b:	89 45 14             	mov    %eax,0x14(%ebp)
  80105e:	8b 45 14             	mov    0x14(%ebp),%eax
  801061:	83 e8 04             	sub    $0x4,%eax
  801064:	8b 00                	mov    (%eax),%eax
  801066:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801069:	eb 1f                	jmp    80108a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80106b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80106f:	79 83                	jns    800ff4 <vprintfmt+0x54>
				width = 0;
  801071:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801078:	e9 77 ff ff ff       	jmp    800ff4 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80107d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801084:	e9 6b ff ff ff       	jmp    800ff4 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801089:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80108a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80108e:	0f 89 60 ff ff ff    	jns    800ff4 <vprintfmt+0x54>
				width = precision, precision = -1;
  801094:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801097:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80109a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8010a1:	e9 4e ff ff ff       	jmp    800ff4 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8010a6:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8010a9:	e9 46 ff ff ff       	jmp    800ff4 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8010ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8010b1:	83 c0 04             	add    $0x4,%eax
  8010b4:	89 45 14             	mov    %eax,0x14(%ebp)
  8010b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8010ba:	83 e8 04             	sub    $0x4,%eax
  8010bd:	8b 00                	mov    (%eax),%eax
  8010bf:	83 ec 08             	sub    $0x8,%esp
  8010c2:	ff 75 0c             	pushl  0xc(%ebp)
  8010c5:	50                   	push   %eax
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	ff d0                	call   *%eax
  8010cb:	83 c4 10             	add    $0x10,%esp
			break;
  8010ce:	e9 89 02 00 00       	jmp    80135c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8010d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8010d6:	83 c0 04             	add    $0x4,%eax
  8010d9:	89 45 14             	mov    %eax,0x14(%ebp)
  8010dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8010df:	83 e8 04             	sub    $0x4,%eax
  8010e2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8010e4:	85 db                	test   %ebx,%ebx
  8010e6:	79 02                	jns    8010ea <vprintfmt+0x14a>
				err = -err;
  8010e8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8010ea:	83 fb 64             	cmp    $0x64,%ebx
  8010ed:	7f 0b                	jg     8010fa <vprintfmt+0x15a>
  8010ef:	8b 34 9d 60 2c 80 00 	mov    0x802c60(,%ebx,4),%esi
  8010f6:	85 f6                	test   %esi,%esi
  8010f8:	75 19                	jne    801113 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8010fa:	53                   	push   %ebx
  8010fb:	68 05 2e 80 00       	push   $0x802e05
  801100:	ff 75 0c             	pushl  0xc(%ebp)
  801103:	ff 75 08             	pushl  0x8(%ebp)
  801106:	e8 5e 02 00 00       	call   801369 <printfmt>
  80110b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80110e:	e9 49 02 00 00       	jmp    80135c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801113:	56                   	push   %esi
  801114:	68 0e 2e 80 00       	push   $0x802e0e
  801119:	ff 75 0c             	pushl  0xc(%ebp)
  80111c:	ff 75 08             	pushl  0x8(%ebp)
  80111f:	e8 45 02 00 00       	call   801369 <printfmt>
  801124:	83 c4 10             	add    $0x10,%esp
			break;
  801127:	e9 30 02 00 00       	jmp    80135c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80112c:	8b 45 14             	mov    0x14(%ebp),%eax
  80112f:	83 c0 04             	add    $0x4,%eax
  801132:	89 45 14             	mov    %eax,0x14(%ebp)
  801135:	8b 45 14             	mov    0x14(%ebp),%eax
  801138:	83 e8 04             	sub    $0x4,%eax
  80113b:	8b 30                	mov    (%eax),%esi
  80113d:	85 f6                	test   %esi,%esi
  80113f:	75 05                	jne    801146 <vprintfmt+0x1a6>
				p = "(null)";
  801141:	be 11 2e 80 00       	mov    $0x802e11,%esi
			if (width > 0 && padc != '-')
  801146:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80114a:	7e 6d                	jle    8011b9 <vprintfmt+0x219>
  80114c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801150:	74 67                	je     8011b9 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801152:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801155:	83 ec 08             	sub    $0x8,%esp
  801158:	50                   	push   %eax
  801159:	56                   	push   %esi
  80115a:	e8 0c 03 00 00       	call   80146b <strnlen>
  80115f:	83 c4 10             	add    $0x10,%esp
  801162:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801165:	eb 16                	jmp    80117d <vprintfmt+0x1dd>
					putch(padc, putdat);
  801167:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80116b:	83 ec 08             	sub    $0x8,%esp
  80116e:	ff 75 0c             	pushl  0xc(%ebp)
  801171:	50                   	push   %eax
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	ff d0                	call   *%eax
  801177:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80117a:	ff 4d e4             	decl   -0x1c(%ebp)
  80117d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801181:	7f e4                	jg     801167 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801183:	eb 34                	jmp    8011b9 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801185:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801189:	74 1c                	je     8011a7 <vprintfmt+0x207>
  80118b:	83 fb 1f             	cmp    $0x1f,%ebx
  80118e:	7e 05                	jle    801195 <vprintfmt+0x1f5>
  801190:	83 fb 7e             	cmp    $0x7e,%ebx
  801193:	7e 12                	jle    8011a7 <vprintfmt+0x207>
					putch('?', putdat);
  801195:	83 ec 08             	sub    $0x8,%esp
  801198:	ff 75 0c             	pushl  0xc(%ebp)
  80119b:	6a 3f                	push   $0x3f
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	ff d0                	call   *%eax
  8011a2:	83 c4 10             	add    $0x10,%esp
  8011a5:	eb 0f                	jmp    8011b6 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8011a7:	83 ec 08             	sub    $0x8,%esp
  8011aa:	ff 75 0c             	pushl  0xc(%ebp)
  8011ad:	53                   	push   %ebx
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	ff d0                	call   *%eax
  8011b3:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8011b6:	ff 4d e4             	decl   -0x1c(%ebp)
  8011b9:	89 f0                	mov    %esi,%eax
  8011bb:	8d 70 01             	lea    0x1(%eax),%esi
  8011be:	8a 00                	mov    (%eax),%al
  8011c0:	0f be d8             	movsbl %al,%ebx
  8011c3:	85 db                	test   %ebx,%ebx
  8011c5:	74 24                	je     8011eb <vprintfmt+0x24b>
  8011c7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8011cb:	78 b8                	js     801185 <vprintfmt+0x1e5>
  8011cd:	ff 4d e0             	decl   -0x20(%ebp)
  8011d0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8011d4:	79 af                	jns    801185 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8011d6:	eb 13                	jmp    8011eb <vprintfmt+0x24b>
				putch(' ', putdat);
  8011d8:	83 ec 08             	sub    $0x8,%esp
  8011db:	ff 75 0c             	pushl  0xc(%ebp)
  8011de:	6a 20                	push   $0x20
  8011e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e3:	ff d0                	call   *%eax
  8011e5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8011e8:	ff 4d e4             	decl   -0x1c(%ebp)
  8011eb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011ef:	7f e7                	jg     8011d8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8011f1:	e9 66 01 00 00       	jmp    80135c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8011f6:	83 ec 08             	sub    $0x8,%esp
  8011f9:	ff 75 e8             	pushl  -0x18(%ebp)
  8011fc:	8d 45 14             	lea    0x14(%ebp),%eax
  8011ff:	50                   	push   %eax
  801200:	e8 3c fd ff ff       	call   800f41 <getint>
  801205:	83 c4 10             	add    $0x10,%esp
  801208:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80120b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80120e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801211:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801214:	85 d2                	test   %edx,%edx
  801216:	79 23                	jns    80123b <vprintfmt+0x29b>
				putch('-', putdat);
  801218:	83 ec 08             	sub    $0x8,%esp
  80121b:	ff 75 0c             	pushl  0xc(%ebp)
  80121e:	6a 2d                	push   $0x2d
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	ff d0                	call   *%eax
  801225:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801228:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80122b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80122e:	f7 d8                	neg    %eax
  801230:	83 d2 00             	adc    $0x0,%edx
  801233:	f7 da                	neg    %edx
  801235:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801238:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80123b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801242:	e9 bc 00 00 00       	jmp    801303 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801247:	83 ec 08             	sub    $0x8,%esp
  80124a:	ff 75 e8             	pushl  -0x18(%ebp)
  80124d:	8d 45 14             	lea    0x14(%ebp),%eax
  801250:	50                   	push   %eax
  801251:	e8 84 fc ff ff       	call   800eda <getuint>
  801256:	83 c4 10             	add    $0x10,%esp
  801259:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80125c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80125f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801266:	e9 98 00 00 00       	jmp    801303 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80126b:	83 ec 08             	sub    $0x8,%esp
  80126e:	ff 75 0c             	pushl  0xc(%ebp)
  801271:	6a 58                	push   $0x58
  801273:	8b 45 08             	mov    0x8(%ebp),%eax
  801276:	ff d0                	call   *%eax
  801278:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80127b:	83 ec 08             	sub    $0x8,%esp
  80127e:	ff 75 0c             	pushl  0xc(%ebp)
  801281:	6a 58                	push   $0x58
  801283:	8b 45 08             	mov    0x8(%ebp),%eax
  801286:	ff d0                	call   *%eax
  801288:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80128b:	83 ec 08             	sub    $0x8,%esp
  80128e:	ff 75 0c             	pushl  0xc(%ebp)
  801291:	6a 58                	push   $0x58
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
  801296:	ff d0                	call   *%eax
  801298:	83 c4 10             	add    $0x10,%esp
			break;
  80129b:	e9 bc 00 00 00       	jmp    80135c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8012a0:	83 ec 08             	sub    $0x8,%esp
  8012a3:	ff 75 0c             	pushl  0xc(%ebp)
  8012a6:	6a 30                	push   $0x30
  8012a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ab:	ff d0                	call   *%eax
  8012ad:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8012b0:	83 ec 08             	sub    $0x8,%esp
  8012b3:	ff 75 0c             	pushl  0xc(%ebp)
  8012b6:	6a 78                	push   $0x78
  8012b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bb:	ff d0                	call   *%eax
  8012bd:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8012c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8012c3:	83 c0 04             	add    $0x4,%eax
  8012c6:	89 45 14             	mov    %eax,0x14(%ebp)
  8012c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8012cc:	83 e8 04             	sub    $0x4,%eax
  8012cf:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8012d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8012db:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8012e2:	eb 1f                	jmp    801303 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8012e4:	83 ec 08             	sub    $0x8,%esp
  8012e7:	ff 75 e8             	pushl  -0x18(%ebp)
  8012ea:	8d 45 14             	lea    0x14(%ebp),%eax
  8012ed:	50                   	push   %eax
  8012ee:	e8 e7 fb ff ff       	call   800eda <getuint>
  8012f3:	83 c4 10             	add    $0x10,%esp
  8012f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012f9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8012fc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801303:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801307:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80130a:	83 ec 04             	sub    $0x4,%esp
  80130d:	52                   	push   %edx
  80130e:	ff 75 e4             	pushl  -0x1c(%ebp)
  801311:	50                   	push   %eax
  801312:	ff 75 f4             	pushl  -0xc(%ebp)
  801315:	ff 75 f0             	pushl  -0x10(%ebp)
  801318:	ff 75 0c             	pushl  0xc(%ebp)
  80131b:	ff 75 08             	pushl  0x8(%ebp)
  80131e:	e8 00 fb ff ff       	call   800e23 <printnum>
  801323:	83 c4 20             	add    $0x20,%esp
			break;
  801326:	eb 34                	jmp    80135c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801328:	83 ec 08             	sub    $0x8,%esp
  80132b:	ff 75 0c             	pushl  0xc(%ebp)
  80132e:	53                   	push   %ebx
  80132f:	8b 45 08             	mov    0x8(%ebp),%eax
  801332:	ff d0                	call   *%eax
  801334:	83 c4 10             	add    $0x10,%esp
			break;
  801337:	eb 23                	jmp    80135c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801339:	83 ec 08             	sub    $0x8,%esp
  80133c:	ff 75 0c             	pushl  0xc(%ebp)
  80133f:	6a 25                	push   $0x25
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	ff d0                	call   *%eax
  801346:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801349:	ff 4d 10             	decl   0x10(%ebp)
  80134c:	eb 03                	jmp    801351 <vprintfmt+0x3b1>
  80134e:	ff 4d 10             	decl   0x10(%ebp)
  801351:	8b 45 10             	mov    0x10(%ebp),%eax
  801354:	48                   	dec    %eax
  801355:	8a 00                	mov    (%eax),%al
  801357:	3c 25                	cmp    $0x25,%al
  801359:	75 f3                	jne    80134e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80135b:	90                   	nop
		}
	}
  80135c:	e9 47 fc ff ff       	jmp    800fa8 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801361:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801362:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801365:	5b                   	pop    %ebx
  801366:	5e                   	pop    %esi
  801367:	5d                   	pop    %ebp
  801368:	c3                   	ret    

00801369 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801369:	55                   	push   %ebp
  80136a:	89 e5                	mov    %esp,%ebp
  80136c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80136f:	8d 45 10             	lea    0x10(%ebp),%eax
  801372:	83 c0 04             	add    $0x4,%eax
  801375:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801378:	8b 45 10             	mov    0x10(%ebp),%eax
  80137b:	ff 75 f4             	pushl  -0xc(%ebp)
  80137e:	50                   	push   %eax
  80137f:	ff 75 0c             	pushl  0xc(%ebp)
  801382:	ff 75 08             	pushl  0x8(%ebp)
  801385:	e8 16 fc ff ff       	call   800fa0 <vprintfmt>
  80138a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80138d:	90                   	nop
  80138e:	c9                   	leave  
  80138f:	c3                   	ret    

00801390 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801390:	55                   	push   %ebp
  801391:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801393:	8b 45 0c             	mov    0xc(%ebp),%eax
  801396:	8b 40 08             	mov    0x8(%eax),%eax
  801399:	8d 50 01             	lea    0x1(%eax),%edx
  80139c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8013a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a5:	8b 10                	mov    (%eax),%edx
  8013a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013aa:	8b 40 04             	mov    0x4(%eax),%eax
  8013ad:	39 c2                	cmp    %eax,%edx
  8013af:	73 12                	jae    8013c3 <sprintputch+0x33>
		*b->buf++ = ch;
  8013b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b4:	8b 00                	mov    (%eax),%eax
  8013b6:	8d 48 01             	lea    0x1(%eax),%ecx
  8013b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013bc:	89 0a                	mov    %ecx,(%edx)
  8013be:	8b 55 08             	mov    0x8(%ebp),%edx
  8013c1:	88 10                	mov    %dl,(%eax)
}
  8013c3:	90                   	nop
  8013c4:	5d                   	pop    %ebp
  8013c5:	c3                   	ret    

008013c6 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8013c6:	55                   	push   %ebp
  8013c7:	89 e5                	mov    %esp,%ebp
  8013c9:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8013d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013db:	01 d0                	add    %edx,%eax
  8013dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8013e7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013eb:	74 06                	je     8013f3 <vsnprintf+0x2d>
  8013ed:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013f1:	7f 07                	jg     8013fa <vsnprintf+0x34>
		return -E_INVAL;
  8013f3:	b8 03 00 00 00       	mov    $0x3,%eax
  8013f8:	eb 20                	jmp    80141a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8013fa:	ff 75 14             	pushl  0x14(%ebp)
  8013fd:	ff 75 10             	pushl  0x10(%ebp)
  801400:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801403:	50                   	push   %eax
  801404:	68 90 13 80 00       	push   $0x801390
  801409:	e8 92 fb ff ff       	call   800fa0 <vprintfmt>
  80140e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801411:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801414:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801417:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80141a:	c9                   	leave  
  80141b:	c3                   	ret    

0080141c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80141c:	55                   	push   %ebp
  80141d:	89 e5                	mov    %esp,%ebp
  80141f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801422:	8d 45 10             	lea    0x10(%ebp),%eax
  801425:	83 c0 04             	add    $0x4,%eax
  801428:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80142b:	8b 45 10             	mov    0x10(%ebp),%eax
  80142e:	ff 75 f4             	pushl  -0xc(%ebp)
  801431:	50                   	push   %eax
  801432:	ff 75 0c             	pushl  0xc(%ebp)
  801435:	ff 75 08             	pushl  0x8(%ebp)
  801438:	e8 89 ff ff ff       	call   8013c6 <vsnprintf>
  80143d:	83 c4 10             	add    $0x10,%esp
  801440:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801443:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801446:	c9                   	leave  
  801447:	c3                   	ret    

00801448 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801448:	55                   	push   %ebp
  801449:	89 e5                	mov    %esp,%ebp
  80144b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80144e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801455:	eb 06                	jmp    80145d <strlen+0x15>
		n++;
  801457:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80145a:	ff 45 08             	incl   0x8(%ebp)
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	8a 00                	mov    (%eax),%al
  801462:	84 c0                	test   %al,%al
  801464:	75 f1                	jne    801457 <strlen+0xf>
		n++;
	return n;
  801466:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801469:	c9                   	leave  
  80146a:	c3                   	ret    

0080146b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80146b:	55                   	push   %ebp
  80146c:	89 e5                	mov    %esp,%ebp
  80146e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801471:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801478:	eb 09                	jmp    801483 <strnlen+0x18>
		n++;
  80147a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80147d:	ff 45 08             	incl   0x8(%ebp)
  801480:	ff 4d 0c             	decl   0xc(%ebp)
  801483:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801487:	74 09                	je     801492 <strnlen+0x27>
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	8a 00                	mov    (%eax),%al
  80148e:	84 c0                	test   %al,%al
  801490:	75 e8                	jne    80147a <strnlen+0xf>
		n++;
	return n;
  801492:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801495:	c9                   	leave  
  801496:	c3                   	ret    

00801497 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
  80149a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80149d:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8014a3:	90                   	nop
  8014a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a7:	8d 50 01             	lea    0x1(%eax),%edx
  8014aa:	89 55 08             	mov    %edx,0x8(%ebp)
  8014ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014b3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014b6:	8a 12                	mov    (%edx),%dl
  8014b8:	88 10                	mov    %dl,(%eax)
  8014ba:	8a 00                	mov    (%eax),%al
  8014bc:	84 c0                	test   %al,%al
  8014be:	75 e4                	jne    8014a4 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8014c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
  8014c8:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8014cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8014d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014d8:	eb 1f                	jmp    8014f9 <strncpy+0x34>
		*dst++ = *src;
  8014da:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dd:	8d 50 01             	lea    0x1(%eax),%edx
  8014e0:	89 55 08             	mov    %edx,0x8(%ebp)
  8014e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e6:	8a 12                	mov    (%edx),%dl
  8014e8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ed:	8a 00                	mov    (%eax),%al
  8014ef:	84 c0                	test   %al,%al
  8014f1:	74 03                	je     8014f6 <strncpy+0x31>
			src++;
  8014f3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014f6:	ff 45 fc             	incl   -0x4(%ebp)
  8014f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014fc:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014ff:	72 d9                	jb     8014da <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801501:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801504:	c9                   	leave  
  801505:	c3                   	ret    

00801506 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
  801509:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80150c:	8b 45 08             	mov    0x8(%ebp),%eax
  80150f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801512:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801516:	74 30                	je     801548 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801518:	eb 16                	jmp    801530 <strlcpy+0x2a>
			*dst++ = *src++;
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	8d 50 01             	lea    0x1(%eax),%edx
  801520:	89 55 08             	mov    %edx,0x8(%ebp)
  801523:	8b 55 0c             	mov    0xc(%ebp),%edx
  801526:	8d 4a 01             	lea    0x1(%edx),%ecx
  801529:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80152c:	8a 12                	mov    (%edx),%dl
  80152e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801530:	ff 4d 10             	decl   0x10(%ebp)
  801533:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801537:	74 09                	je     801542 <strlcpy+0x3c>
  801539:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153c:	8a 00                	mov    (%eax),%al
  80153e:	84 c0                	test   %al,%al
  801540:	75 d8                	jne    80151a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801542:	8b 45 08             	mov    0x8(%ebp),%eax
  801545:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801548:	8b 55 08             	mov    0x8(%ebp),%edx
  80154b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80154e:	29 c2                	sub    %eax,%edx
  801550:	89 d0                	mov    %edx,%eax
}
  801552:	c9                   	leave  
  801553:	c3                   	ret    

00801554 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801554:	55                   	push   %ebp
  801555:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801557:	eb 06                	jmp    80155f <strcmp+0xb>
		p++, q++;
  801559:	ff 45 08             	incl   0x8(%ebp)
  80155c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80155f:	8b 45 08             	mov    0x8(%ebp),%eax
  801562:	8a 00                	mov    (%eax),%al
  801564:	84 c0                	test   %al,%al
  801566:	74 0e                	je     801576 <strcmp+0x22>
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
  80156b:	8a 10                	mov    (%eax),%dl
  80156d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801570:	8a 00                	mov    (%eax),%al
  801572:	38 c2                	cmp    %al,%dl
  801574:	74 e3                	je     801559 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801576:	8b 45 08             	mov    0x8(%ebp),%eax
  801579:	8a 00                	mov    (%eax),%al
  80157b:	0f b6 d0             	movzbl %al,%edx
  80157e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801581:	8a 00                	mov    (%eax),%al
  801583:	0f b6 c0             	movzbl %al,%eax
  801586:	29 c2                	sub    %eax,%edx
  801588:	89 d0                	mov    %edx,%eax
}
  80158a:	5d                   	pop    %ebp
  80158b:	c3                   	ret    

0080158c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80158c:	55                   	push   %ebp
  80158d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80158f:	eb 09                	jmp    80159a <strncmp+0xe>
		n--, p++, q++;
  801591:	ff 4d 10             	decl   0x10(%ebp)
  801594:	ff 45 08             	incl   0x8(%ebp)
  801597:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80159a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80159e:	74 17                	je     8015b7 <strncmp+0x2b>
  8015a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a3:	8a 00                	mov    (%eax),%al
  8015a5:	84 c0                	test   %al,%al
  8015a7:	74 0e                	je     8015b7 <strncmp+0x2b>
  8015a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ac:	8a 10                	mov    (%eax),%dl
  8015ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b1:	8a 00                	mov    (%eax),%al
  8015b3:	38 c2                	cmp    %al,%dl
  8015b5:	74 da                	je     801591 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8015b7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015bb:	75 07                	jne    8015c4 <strncmp+0x38>
		return 0;
  8015bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8015c2:	eb 14                	jmp    8015d8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c7:	8a 00                	mov    (%eax),%al
  8015c9:	0f b6 d0             	movzbl %al,%edx
  8015cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015cf:	8a 00                	mov    (%eax),%al
  8015d1:	0f b6 c0             	movzbl %al,%eax
  8015d4:	29 c2                	sub    %eax,%edx
  8015d6:	89 d0                	mov    %edx,%eax
}
  8015d8:	5d                   	pop    %ebp
  8015d9:	c3                   	ret    

008015da <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015da:	55                   	push   %ebp
  8015db:	89 e5                	mov    %esp,%ebp
  8015dd:	83 ec 04             	sub    $0x4,%esp
  8015e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015e6:	eb 12                	jmp    8015fa <strchr+0x20>
		if (*s == c)
  8015e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015eb:	8a 00                	mov    (%eax),%al
  8015ed:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015f0:	75 05                	jne    8015f7 <strchr+0x1d>
			return (char *) s;
  8015f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f5:	eb 11                	jmp    801608 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015f7:	ff 45 08             	incl   0x8(%ebp)
  8015fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fd:	8a 00                	mov    (%eax),%al
  8015ff:	84 c0                	test   %al,%al
  801601:	75 e5                	jne    8015e8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801603:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801608:	c9                   	leave  
  801609:	c3                   	ret    

0080160a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80160a:	55                   	push   %ebp
  80160b:	89 e5                	mov    %esp,%ebp
  80160d:	83 ec 04             	sub    $0x4,%esp
  801610:	8b 45 0c             	mov    0xc(%ebp),%eax
  801613:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801616:	eb 0d                	jmp    801625 <strfind+0x1b>
		if (*s == c)
  801618:	8b 45 08             	mov    0x8(%ebp),%eax
  80161b:	8a 00                	mov    (%eax),%al
  80161d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801620:	74 0e                	je     801630 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801622:	ff 45 08             	incl   0x8(%ebp)
  801625:	8b 45 08             	mov    0x8(%ebp),%eax
  801628:	8a 00                	mov    (%eax),%al
  80162a:	84 c0                	test   %al,%al
  80162c:	75 ea                	jne    801618 <strfind+0xe>
  80162e:	eb 01                	jmp    801631 <strfind+0x27>
		if (*s == c)
			break;
  801630:	90                   	nop
	return (char *) s;
  801631:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801634:	c9                   	leave  
  801635:	c3                   	ret    

00801636 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801636:	55                   	push   %ebp
  801637:	89 e5                	mov    %esp,%ebp
  801639:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80163c:	8b 45 08             	mov    0x8(%ebp),%eax
  80163f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801642:	8b 45 10             	mov    0x10(%ebp),%eax
  801645:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801648:	eb 0e                	jmp    801658 <memset+0x22>
		*p++ = c;
  80164a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80164d:	8d 50 01             	lea    0x1(%eax),%edx
  801650:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801653:	8b 55 0c             	mov    0xc(%ebp),%edx
  801656:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801658:	ff 4d f8             	decl   -0x8(%ebp)
  80165b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80165f:	79 e9                	jns    80164a <memset+0x14>
		*p++ = c;

	return v;
  801661:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
  801669:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80166c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80166f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801672:	8b 45 08             	mov    0x8(%ebp),%eax
  801675:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801678:	eb 16                	jmp    801690 <memcpy+0x2a>
		*d++ = *s++;
  80167a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80167d:	8d 50 01             	lea    0x1(%eax),%edx
  801680:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801683:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801686:	8d 4a 01             	lea    0x1(%edx),%ecx
  801689:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80168c:	8a 12                	mov    (%edx),%dl
  80168e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801690:	8b 45 10             	mov    0x10(%ebp),%eax
  801693:	8d 50 ff             	lea    -0x1(%eax),%edx
  801696:	89 55 10             	mov    %edx,0x10(%ebp)
  801699:	85 c0                	test   %eax,%eax
  80169b:	75 dd                	jne    80167a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    

008016a2 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
  8016a5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8016a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8016ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8016b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016b7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8016ba:	73 50                	jae    80170c <memmove+0x6a>
  8016bc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c2:	01 d0                	add    %edx,%eax
  8016c4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8016c7:	76 43                	jbe    80170c <memmove+0x6a>
		s += n;
  8016c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016cc:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8016cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8016d5:	eb 10                	jmp    8016e7 <memmove+0x45>
			*--d = *--s;
  8016d7:	ff 4d f8             	decl   -0x8(%ebp)
  8016da:	ff 4d fc             	decl   -0x4(%ebp)
  8016dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016e0:	8a 10                	mov    (%eax),%dl
  8016e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016e5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ea:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016ed:	89 55 10             	mov    %edx,0x10(%ebp)
  8016f0:	85 c0                	test   %eax,%eax
  8016f2:	75 e3                	jne    8016d7 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016f4:	eb 23                	jmp    801719 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f9:	8d 50 01             	lea    0x1(%eax),%edx
  8016fc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801702:	8d 4a 01             	lea    0x1(%edx),%ecx
  801705:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801708:	8a 12                	mov    (%edx),%dl
  80170a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80170c:	8b 45 10             	mov    0x10(%ebp),%eax
  80170f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801712:	89 55 10             	mov    %edx,0x10(%ebp)
  801715:	85 c0                	test   %eax,%eax
  801717:	75 dd                	jne    8016f6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801719:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80171c:	c9                   	leave  
  80171d:	c3                   	ret    

0080171e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80171e:	55                   	push   %ebp
  80171f:	89 e5                	mov    %esp,%ebp
  801721:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801724:	8b 45 08             	mov    0x8(%ebp),%eax
  801727:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80172a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801730:	eb 2a                	jmp    80175c <memcmp+0x3e>
		if (*s1 != *s2)
  801732:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801735:	8a 10                	mov    (%eax),%dl
  801737:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80173a:	8a 00                	mov    (%eax),%al
  80173c:	38 c2                	cmp    %al,%dl
  80173e:	74 16                	je     801756 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801740:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801743:	8a 00                	mov    (%eax),%al
  801745:	0f b6 d0             	movzbl %al,%edx
  801748:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80174b:	8a 00                	mov    (%eax),%al
  80174d:	0f b6 c0             	movzbl %al,%eax
  801750:	29 c2                	sub    %eax,%edx
  801752:	89 d0                	mov    %edx,%eax
  801754:	eb 18                	jmp    80176e <memcmp+0x50>
		s1++, s2++;
  801756:	ff 45 fc             	incl   -0x4(%ebp)
  801759:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80175c:	8b 45 10             	mov    0x10(%ebp),%eax
  80175f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801762:	89 55 10             	mov    %edx,0x10(%ebp)
  801765:	85 c0                	test   %eax,%eax
  801767:	75 c9                	jne    801732 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801769:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
  801773:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801776:	8b 55 08             	mov    0x8(%ebp),%edx
  801779:	8b 45 10             	mov    0x10(%ebp),%eax
  80177c:	01 d0                	add    %edx,%eax
  80177e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801781:	eb 15                	jmp    801798 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801783:	8b 45 08             	mov    0x8(%ebp),%eax
  801786:	8a 00                	mov    (%eax),%al
  801788:	0f b6 d0             	movzbl %al,%edx
  80178b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178e:	0f b6 c0             	movzbl %al,%eax
  801791:	39 c2                	cmp    %eax,%edx
  801793:	74 0d                	je     8017a2 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801795:	ff 45 08             	incl   0x8(%ebp)
  801798:	8b 45 08             	mov    0x8(%ebp),%eax
  80179b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80179e:	72 e3                	jb     801783 <memfind+0x13>
  8017a0:	eb 01                	jmp    8017a3 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8017a2:	90                   	nop
	return (void *) s;
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017a6:	c9                   	leave  
  8017a7:	c3                   	ret    

008017a8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8017a8:	55                   	push   %ebp
  8017a9:	89 e5                	mov    %esp,%ebp
  8017ab:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8017ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8017b5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017bc:	eb 03                	jmp    8017c1 <strtol+0x19>
		s++;
  8017be:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c4:	8a 00                	mov    (%eax),%al
  8017c6:	3c 20                	cmp    $0x20,%al
  8017c8:	74 f4                	je     8017be <strtol+0x16>
  8017ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cd:	8a 00                	mov    (%eax),%al
  8017cf:	3c 09                	cmp    $0x9,%al
  8017d1:	74 eb                	je     8017be <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8017d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d6:	8a 00                	mov    (%eax),%al
  8017d8:	3c 2b                	cmp    $0x2b,%al
  8017da:	75 05                	jne    8017e1 <strtol+0x39>
		s++;
  8017dc:	ff 45 08             	incl   0x8(%ebp)
  8017df:	eb 13                	jmp    8017f4 <strtol+0x4c>
	else if (*s == '-')
  8017e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e4:	8a 00                	mov    (%eax),%al
  8017e6:	3c 2d                	cmp    $0x2d,%al
  8017e8:	75 0a                	jne    8017f4 <strtol+0x4c>
		s++, neg = 1;
  8017ea:	ff 45 08             	incl   0x8(%ebp)
  8017ed:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017f4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017f8:	74 06                	je     801800 <strtol+0x58>
  8017fa:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017fe:	75 20                	jne    801820 <strtol+0x78>
  801800:	8b 45 08             	mov    0x8(%ebp),%eax
  801803:	8a 00                	mov    (%eax),%al
  801805:	3c 30                	cmp    $0x30,%al
  801807:	75 17                	jne    801820 <strtol+0x78>
  801809:	8b 45 08             	mov    0x8(%ebp),%eax
  80180c:	40                   	inc    %eax
  80180d:	8a 00                	mov    (%eax),%al
  80180f:	3c 78                	cmp    $0x78,%al
  801811:	75 0d                	jne    801820 <strtol+0x78>
		s += 2, base = 16;
  801813:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801817:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80181e:	eb 28                	jmp    801848 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801820:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801824:	75 15                	jne    80183b <strtol+0x93>
  801826:	8b 45 08             	mov    0x8(%ebp),%eax
  801829:	8a 00                	mov    (%eax),%al
  80182b:	3c 30                	cmp    $0x30,%al
  80182d:	75 0c                	jne    80183b <strtol+0x93>
		s++, base = 8;
  80182f:	ff 45 08             	incl   0x8(%ebp)
  801832:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801839:	eb 0d                	jmp    801848 <strtol+0xa0>
	else if (base == 0)
  80183b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80183f:	75 07                	jne    801848 <strtol+0xa0>
		base = 10;
  801841:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801848:	8b 45 08             	mov    0x8(%ebp),%eax
  80184b:	8a 00                	mov    (%eax),%al
  80184d:	3c 2f                	cmp    $0x2f,%al
  80184f:	7e 19                	jle    80186a <strtol+0xc2>
  801851:	8b 45 08             	mov    0x8(%ebp),%eax
  801854:	8a 00                	mov    (%eax),%al
  801856:	3c 39                	cmp    $0x39,%al
  801858:	7f 10                	jg     80186a <strtol+0xc2>
			dig = *s - '0';
  80185a:	8b 45 08             	mov    0x8(%ebp),%eax
  80185d:	8a 00                	mov    (%eax),%al
  80185f:	0f be c0             	movsbl %al,%eax
  801862:	83 e8 30             	sub    $0x30,%eax
  801865:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801868:	eb 42                	jmp    8018ac <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80186a:	8b 45 08             	mov    0x8(%ebp),%eax
  80186d:	8a 00                	mov    (%eax),%al
  80186f:	3c 60                	cmp    $0x60,%al
  801871:	7e 19                	jle    80188c <strtol+0xe4>
  801873:	8b 45 08             	mov    0x8(%ebp),%eax
  801876:	8a 00                	mov    (%eax),%al
  801878:	3c 7a                	cmp    $0x7a,%al
  80187a:	7f 10                	jg     80188c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80187c:	8b 45 08             	mov    0x8(%ebp),%eax
  80187f:	8a 00                	mov    (%eax),%al
  801881:	0f be c0             	movsbl %al,%eax
  801884:	83 e8 57             	sub    $0x57,%eax
  801887:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80188a:	eb 20                	jmp    8018ac <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80188c:	8b 45 08             	mov    0x8(%ebp),%eax
  80188f:	8a 00                	mov    (%eax),%al
  801891:	3c 40                	cmp    $0x40,%al
  801893:	7e 39                	jle    8018ce <strtol+0x126>
  801895:	8b 45 08             	mov    0x8(%ebp),%eax
  801898:	8a 00                	mov    (%eax),%al
  80189a:	3c 5a                	cmp    $0x5a,%al
  80189c:	7f 30                	jg     8018ce <strtol+0x126>
			dig = *s - 'A' + 10;
  80189e:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a1:	8a 00                	mov    (%eax),%al
  8018a3:	0f be c0             	movsbl %al,%eax
  8018a6:	83 e8 37             	sub    $0x37,%eax
  8018a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8018ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018af:	3b 45 10             	cmp    0x10(%ebp),%eax
  8018b2:	7d 19                	jge    8018cd <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8018b4:	ff 45 08             	incl   0x8(%ebp)
  8018b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ba:	0f af 45 10          	imul   0x10(%ebp),%eax
  8018be:	89 c2                	mov    %eax,%edx
  8018c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c3:	01 d0                	add    %edx,%eax
  8018c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8018c8:	e9 7b ff ff ff       	jmp    801848 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8018cd:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8018ce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018d2:	74 08                	je     8018dc <strtol+0x134>
		*endptr = (char *) s;
  8018d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d7:	8b 55 08             	mov    0x8(%ebp),%edx
  8018da:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018dc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018e0:	74 07                	je     8018e9 <strtol+0x141>
  8018e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018e5:	f7 d8                	neg    %eax
  8018e7:	eb 03                	jmp    8018ec <strtol+0x144>
  8018e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018ec:	c9                   	leave  
  8018ed:	c3                   	ret    

008018ee <ltostr>:

void
ltostr(long value, char *str)
{
  8018ee:	55                   	push   %ebp
  8018ef:	89 e5                	mov    %esp,%ebp
  8018f1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018fb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801902:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801906:	79 13                	jns    80191b <ltostr+0x2d>
	{
		neg = 1;
  801908:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80190f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801912:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801915:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801918:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80191b:	8b 45 08             	mov    0x8(%ebp),%eax
  80191e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801923:	99                   	cltd   
  801924:	f7 f9                	idiv   %ecx
  801926:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801929:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80192c:	8d 50 01             	lea    0x1(%eax),%edx
  80192f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801932:	89 c2                	mov    %eax,%edx
  801934:	8b 45 0c             	mov    0xc(%ebp),%eax
  801937:	01 d0                	add    %edx,%eax
  801939:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80193c:	83 c2 30             	add    $0x30,%edx
  80193f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801941:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801944:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801949:	f7 e9                	imul   %ecx
  80194b:	c1 fa 02             	sar    $0x2,%edx
  80194e:	89 c8                	mov    %ecx,%eax
  801950:	c1 f8 1f             	sar    $0x1f,%eax
  801953:	29 c2                	sub    %eax,%edx
  801955:	89 d0                	mov    %edx,%eax
  801957:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80195a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80195d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801962:	f7 e9                	imul   %ecx
  801964:	c1 fa 02             	sar    $0x2,%edx
  801967:	89 c8                	mov    %ecx,%eax
  801969:	c1 f8 1f             	sar    $0x1f,%eax
  80196c:	29 c2                	sub    %eax,%edx
  80196e:	89 d0                	mov    %edx,%eax
  801970:	c1 e0 02             	shl    $0x2,%eax
  801973:	01 d0                	add    %edx,%eax
  801975:	01 c0                	add    %eax,%eax
  801977:	29 c1                	sub    %eax,%ecx
  801979:	89 ca                	mov    %ecx,%edx
  80197b:	85 d2                	test   %edx,%edx
  80197d:	75 9c                	jne    80191b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80197f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801986:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801989:	48                   	dec    %eax
  80198a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80198d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801991:	74 3d                	je     8019d0 <ltostr+0xe2>
		start = 1 ;
  801993:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80199a:	eb 34                	jmp    8019d0 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80199c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80199f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a2:	01 d0                	add    %edx,%eax
  8019a4:	8a 00                	mov    (%eax),%al
  8019a6:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8019a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019af:	01 c2                	add    %eax,%edx
  8019b1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8019b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b7:	01 c8                	add    %ecx,%eax
  8019b9:	8a 00                	mov    (%eax),%al
  8019bb:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8019bd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019c3:	01 c2                	add    %eax,%edx
  8019c5:	8a 45 eb             	mov    -0x15(%ebp),%al
  8019c8:	88 02                	mov    %al,(%edx)
		start++ ;
  8019ca:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8019cd:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8019d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019d3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019d6:	7c c4                	jl     80199c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8019d8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8019db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019de:	01 d0                	add    %edx,%eax
  8019e0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019e3:	90                   	nop
  8019e4:	c9                   	leave  
  8019e5:	c3                   	ret    

008019e6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019e6:	55                   	push   %ebp
  8019e7:	89 e5                	mov    %esp,%ebp
  8019e9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019ec:	ff 75 08             	pushl  0x8(%ebp)
  8019ef:	e8 54 fa ff ff       	call   801448 <strlen>
  8019f4:	83 c4 04             	add    $0x4,%esp
  8019f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019fa:	ff 75 0c             	pushl  0xc(%ebp)
  8019fd:	e8 46 fa ff ff       	call   801448 <strlen>
  801a02:	83 c4 04             	add    $0x4,%esp
  801a05:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801a08:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801a0f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a16:	eb 17                	jmp    801a2f <strcconcat+0x49>
		final[s] = str1[s] ;
  801a18:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a1b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a1e:	01 c2                	add    %eax,%edx
  801a20:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a23:	8b 45 08             	mov    0x8(%ebp),%eax
  801a26:	01 c8                	add    %ecx,%eax
  801a28:	8a 00                	mov    (%eax),%al
  801a2a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a2c:	ff 45 fc             	incl   -0x4(%ebp)
  801a2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a32:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a35:	7c e1                	jl     801a18 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a37:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a3e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a45:	eb 1f                	jmp    801a66 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a47:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a4a:	8d 50 01             	lea    0x1(%eax),%edx
  801a4d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a50:	89 c2                	mov    %eax,%edx
  801a52:	8b 45 10             	mov    0x10(%ebp),%eax
  801a55:	01 c2                	add    %eax,%edx
  801a57:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a5d:	01 c8                	add    %ecx,%eax
  801a5f:	8a 00                	mov    (%eax),%al
  801a61:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a63:	ff 45 f8             	incl   -0x8(%ebp)
  801a66:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a69:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a6c:	7c d9                	jl     801a47 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a6e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a71:	8b 45 10             	mov    0x10(%ebp),%eax
  801a74:	01 d0                	add    %edx,%eax
  801a76:	c6 00 00             	movb   $0x0,(%eax)
}
  801a79:	90                   	nop
  801a7a:	c9                   	leave  
  801a7b:	c3                   	ret    

00801a7c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a7c:	55                   	push   %ebp
  801a7d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a7f:	8b 45 14             	mov    0x14(%ebp),%eax
  801a82:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a88:	8b 45 14             	mov    0x14(%ebp),%eax
  801a8b:	8b 00                	mov    (%eax),%eax
  801a8d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a94:	8b 45 10             	mov    0x10(%ebp),%eax
  801a97:	01 d0                	add    %edx,%eax
  801a99:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a9f:	eb 0c                	jmp    801aad <strsplit+0x31>
			*string++ = 0;
  801aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa4:	8d 50 01             	lea    0x1(%eax),%edx
  801aa7:	89 55 08             	mov    %edx,0x8(%ebp)
  801aaa:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801aad:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab0:	8a 00                	mov    (%eax),%al
  801ab2:	84 c0                	test   %al,%al
  801ab4:	74 18                	je     801ace <strsplit+0x52>
  801ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab9:	8a 00                	mov    (%eax),%al
  801abb:	0f be c0             	movsbl %al,%eax
  801abe:	50                   	push   %eax
  801abf:	ff 75 0c             	pushl  0xc(%ebp)
  801ac2:	e8 13 fb ff ff       	call   8015da <strchr>
  801ac7:	83 c4 08             	add    $0x8,%esp
  801aca:	85 c0                	test   %eax,%eax
  801acc:	75 d3                	jne    801aa1 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801ace:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad1:	8a 00                	mov    (%eax),%al
  801ad3:	84 c0                	test   %al,%al
  801ad5:	74 5a                	je     801b31 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801ad7:	8b 45 14             	mov    0x14(%ebp),%eax
  801ada:	8b 00                	mov    (%eax),%eax
  801adc:	83 f8 0f             	cmp    $0xf,%eax
  801adf:	75 07                	jne    801ae8 <strsplit+0x6c>
		{
			return 0;
  801ae1:	b8 00 00 00 00       	mov    $0x0,%eax
  801ae6:	eb 66                	jmp    801b4e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801ae8:	8b 45 14             	mov    0x14(%ebp),%eax
  801aeb:	8b 00                	mov    (%eax),%eax
  801aed:	8d 48 01             	lea    0x1(%eax),%ecx
  801af0:	8b 55 14             	mov    0x14(%ebp),%edx
  801af3:	89 0a                	mov    %ecx,(%edx)
  801af5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801afc:	8b 45 10             	mov    0x10(%ebp),%eax
  801aff:	01 c2                	add    %eax,%edx
  801b01:	8b 45 08             	mov    0x8(%ebp),%eax
  801b04:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b06:	eb 03                	jmp    801b0b <strsplit+0x8f>
			string++;
  801b08:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0e:	8a 00                	mov    (%eax),%al
  801b10:	84 c0                	test   %al,%al
  801b12:	74 8b                	je     801a9f <strsplit+0x23>
  801b14:	8b 45 08             	mov    0x8(%ebp),%eax
  801b17:	8a 00                	mov    (%eax),%al
  801b19:	0f be c0             	movsbl %al,%eax
  801b1c:	50                   	push   %eax
  801b1d:	ff 75 0c             	pushl  0xc(%ebp)
  801b20:	e8 b5 fa ff ff       	call   8015da <strchr>
  801b25:	83 c4 08             	add    $0x8,%esp
  801b28:	85 c0                	test   %eax,%eax
  801b2a:	74 dc                	je     801b08 <strsplit+0x8c>
			string++;
	}
  801b2c:	e9 6e ff ff ff       	jmp    801a9f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b31:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b32:	8b 45 14             	mov    0x14(%ebp),%eax
  801b35:	8b 00                	mov    (%eax),%eax
  801b37:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b3e:	8b 45 10             	mov    0x10(%ebp),%eax
  801b41:	01 d0                	add    %edx,%eax
  801b43:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b49:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b4e:	c9                   	leave  
  801b4f:	c3                   	ret    

00801b50 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801b50:	55                   	push   %ebp
  801b51:	89 e5                	mov    %esp,%ebp
  801b53:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  801b56:	e8 3b 09 00 00       	call   802496 <sys_isUHeapPlacementStrategyFIRSTFIT>
  801b5b:	85 c0                	test   %eax,%eax
  801b5d:	0f 84 3a 01 00 00    	je     801c9d <malloc+0x14d>

		if(pl == 0){
  801b63:	a1 28 30 80 00       	mov    0x803028,%eax
  801b68:	85 c0                	test   %eax,%eax
  801b6a:	75 24                	jne    801b90 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801b6c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b73:	eb 11                	jmp    801b86 <malloc+0x36>
				arr[k] = -10000;
  801b75:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b78:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801b7f:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801b83:	ff 45 f4             	incl   -0xc(%ebp)
  801b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b89:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801b8e:	76 e5                	jbe    801b75 <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801b90:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  801b97:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9d:	c1 e8 0c             	shr    $0xc,%eax
  801ba0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  801ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba6:	25 ff 0f 00 00       	and    $0xfff,%eax
  801bab:	85 c0                	test   %eax,%eax
  801bad:	74 03                	je     801bb2 <malloc+0x62>
			x++;
  801baf:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801bb2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  801bb9:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801bc0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801bc7:	eb 66                	jmp    801c2f <malloc+0xdf>
			if( arr[k] == -10000){
  801bc9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801bcc:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801bd3:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801bd8:	75 52                	jne    801c2c <malloc+0xdc>
				uint32 w = 0 ;
  801bda:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  801be1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801be4:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  801be7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801bea:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801bed:	eb 09                	jmp    801bf8 <malloc+0xa8>
  801bef:	ff 45 e0             	incl   -0x20(%ebp)
  801bf2:	ff 45 dc             	incl   -0x24(%ebp)
  801bf5:	ff 45 e4             	incl   -0x1c(%ebp)
  801bf8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801bfb:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c00:	77 19                	ja     801c1b <malloc+0xcb>
  801c02:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c05:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c0c:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801c11:	75 08                	jne    801c1b <malloc+0xcb>
  801c13:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c16:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c19:	72 d4                	jb     801bef <malloc+0x9f>
				if(w >= x){
  801c1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c1e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c21:	72 09                	jb     801c2c <malloc+0xdc>
					p = 1 ;
  801c23:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801c2a:	eb 0d                	jmp    801c39 <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801c2c:	ff 45 e4             	incl   -0x1c(%ebp)
  801c2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c32:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c37:	76 90                	jbe    801bc9 <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801c39:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801c3d:	75 0a                	jne    801c49 <malloc+0xf9>
  801c3f:	b8 00 00 00 00       	mov    $0x0,%eax
  801c44:	e9 ca 01 00 00       	jmp    801e13 <malloc+0x2c3>
		int q = idx;
  801c49:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c4c:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801c4f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801c56:	eb 16                	jmp    801c6e <malloc+0x11e>
			arr[q++] = x;
  801c58:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801c5b:	8d 50 01             	lea    0x1(%eax),%edx
  801c5e:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801c61:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801c64:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801c6b:	ff 45 d4             	incl   -0x2c(%ebp)
  801c6e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801c71:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c74:	72 e2                	jb     801c58 <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801c76:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c79:	05 00 00 08 00       	add    $0x80000,%eax
  801c7e:	c1 e0 0c             	shl    $0xc,%eax
  801c81:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801c84:	83 ec 08             	sub    $0x8,%esp
  801c87:	ff 75 f0             	pushl  -0x10(%ebp)
  801c8a:	ff 75 ac             	pushl  -0x54(%ebp)
  801c8d:	e8 9b 04 00 00       	call   80212d <sys_allocateMem>
  801c92:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801c95:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801c98:	e9 76 01 00 00       	jmp    801e13 <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801c9d:	e8 25 08 00 00       	call   8024c7 <sys_isUHeapPlacementStrategyBESTFIT>
  801ca2:	85 c0                	test   %eax,%eax
  801ca4:	0f 84 64 01 00 00    	je     801e0e <malloc+0x2be>
		if(pl == 0){
  801caa:	a1 28 30 80 00       	mov    0x803028,%eax
  801caf:	85 c0                	test   %eax,%eax
  801cb1:	75 24                	jne    801cd7 <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801cb3:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801cba:	eb 11                	jmp    801ccd <malloc+0x17d>
				arr[k] = -10000;
  801cbc:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cbf:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801cc6:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801cca:	ff 45 d0             	incl   -0x30(%ebp)
  801ccd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cd0:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801cd5:	76 e5                	jbe    801cbc <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801cd7:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  801cde:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce4:	c1 e8 0c             	shr    $0xc,%eax
  801ce7:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801cea:	8b 45 08             	mov    0x8(%ebp),%eax
  801ced:	25 ff 0f 00 00       	and    $0xfff,%eax
  801cf2:	85 c0                	test   %eax,%eax
  801cf4:	74 03                	je     801cf9 <malloc+0x1a9>
			x++;
  801cf6:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801cf9:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801d00:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801d07:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801d0e:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801d15:	e9 88 00 00 00       	jmp    801da2 <malloc+0x252>
			if(arr[k] == -10000){
  801d1a:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801d1d:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801d24:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801d29:	75 64                	jne    801d8f <malloc+0x23f>
				uint32 w = 0 , i;
  801d2b:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801d32:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801d35:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801d38:	eb 06                	jmp    801d40 <malloc+0x1f0>
  801d3a:	ff 45 b8             	incl   -0x48(%ebp)
  801d3d:	ff 45 b4             	incl   -0x4c(%ebp)
  801d40:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801d47:	77 11                	ja     801d5a <malloc+0x20a>
  801d49:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801d4c:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801d53:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801d58:	74 e0                	je     801d3a <malloc+0x1ea>
				if(w <q && w >= x){
  801d5a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801d5d:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801d60:	73 24                	jae    801d86 <malloc+0x236>
  801d62:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801d65:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801d68:	72 1c                	jb     801d86 <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801d6a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801d6d:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801d70:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801d77:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801d7a:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801d7d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801d80:	48                   	dec    %eax
  801d81:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801d84:	eb 19                	jmp    801d9f <malloc+0x24f>
				}
				else {
					k = i - 1;
  801d86:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801d89:	48                   	dec    %eax
  801d8a:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801d8d:	eb 10                	jmp    801d9f <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801d8f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801d92:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801d99:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801d9c:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801d9f:	ff 45 bc             	incl   -0x44(%ebp)
  801da2:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801da5:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801daa:	0f 86 6a ff ff ff    	jbe    801d1a <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801db0:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801db4:	75 07                	jne    801dbd <malloc+0x26d>
  801db6:	b8 00 00 00 00       	mov    $0x0,%eax
  801dbb:	eb 56                	jmp    801e13 <malloc+0x2c3>
	    q = idx;
  801dbd:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801dc0:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801dc3:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801dca:	eb 16                	jmp    801de2 <malloc+0x292>
			arr[q++] = x;
  801dcc:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801dcf:	8d 50 01             	lea    0x1(%eax),%edx
  801dd2:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801dd5:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801dd8:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801ddf:	ff 45 b0             	incl   -0x50(%ebp)
  801de2:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801de5:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801de8:	72 e2                	jb     801dcc <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801dea:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801ded:	05 00 00 08 00       	add    $0x80000,%eax
  801df2:	c1 e0 0c             	shl    $0xc,%eax
  801df5:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801df8:	83 ec 08             	sub    $0x8,%esp
  801dfb:	ff 75 cc             	pushl  -0x34(%ebp)
  801dfe:	ff 75 a8             	pushl  -0x58(%ebp)
  801e01:	e8 27 03 00 00       	call   80212d <sys_allocateMem>
  801e06:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801e09:	8b 45 a8             	mov    -0x58(%ebp),%eax
  801e0c:	eb 05                	jmp    801e13 <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801e0e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e13:	c9                   	leave  
  801e14:	c3                   	ret    

00801e15 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801e15:	55                   	push   %ebp
  801e16:	89 e5                	mov    %esp,%ebp
  801e18:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801e21:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e24:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801e29:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2f:	05 00 00 00 80       	add    $0x80000000,%eax
  801e34:	c1 e8 0c             	shr    $0xc,%eax
  801e37:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801e3e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801e41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801e48:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4b:	05 00 00 00 80       	add    $0x80000000,%eax
  801e50:	c1 e8 0c             	shr    $0xc,%eax
  801e53:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e56:	eb 14                	jmp    801e6c <free+0x57>
		arr[j] = -10000;
  801e58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e5b:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801e62:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801e66:	ff 45 f4             	incl   -0xc(%ebp)
  801e69:	ff 45 f0             	incl   -0x10(%ebp)
  801e6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e6f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801e72:	72 e4                	jb     801e58 <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801e74:	8b 45 08             	mov    0x8(%ebp),%eax
  801e77:	83 ec 08             	sub    $0x8,%esp
  801e7a:	ff 75 e8             	pushl  -0x18(%ebp)
  801e7d:	50                   	push   %eax
  801e7e:	e8 8e 02 00 00       	call   802111 <sys_freeMem>
  801e83:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801e86:	90                   	nop
  801e87:	c9                   	leave  
  801e88:	c3                   	ret    

00801e89 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801e89:	55                   	push   %ebp
  801e8a:	89 e5                	mov    %esp,%ebp
  801e8c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e8f:	83 ec 04             	sub    $0x4,%esp
  801e92:	68 70 2f 80 00       	push   $0x802f70
  801e97:	68 9e 00 00 00       	push   $0x9e
  801e9c:	68 93 2f 80 00       	push   $0x802f93
  801ea1:	e8 69 ec ff ff       	call   800b0f <_panic>

00801ea6 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801ea6:	55                   	push   %ebp
  801ea7:	89 e5                	mov    %esp,%ebp
  801ea9:	83 ec 18             	sub    $0x18,%esp
  801eac:	8b 45 10             	mov    0x10(%ebp),%eax
  801eaf:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801eb2:	83 ec 04             	sub    $0x4,%esp
  801eb5:	68 70 2f 80 00       	push   $0x802f70
  801eba:	68 a9 00 00 00       	push   $0xa9
  801ebf:	68 93 2f 80 00       	push   $0x802f93
  801ec4:	e8 46 ec ff ff       	call   800b0f <_panic>

00801ec9 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801ec9:	55                   	push   %ebp
  801eca:	89 e5                	mov    %esp,%ebp
  801ecc:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ecf:	83 ec 04             	sub    $0x4,%esp
  801ed2:	68 70 2f 80 00       	push   $0x802f70
  801ed7:	68 af 00 00 00       	push   $0xaf
  801edc:	68 93 2f 80 00       	push   $0x802f93
  801ee1:	e8 29 ec ff ff       	call   800b0f <_panic>

00801ee6 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801ee6:	55                   	push   %ebp
  801ee7:	89 e5                	mov    %esp,%ebp
  801ee9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801eec:	83 ec 04             	sub    $0x4,%esp
  801eef:	68 70 2f 80 00       	push   $0x802f70
  801ef4:	68 b5 00 00 00       	push   $0xb5
  801ef9:	68 93 2f 80 00       	push   $0x802f93
  801efe:	e8 0c ec ff ff       	call   800b0f <_panic>

00801f03 <expand>:
}

void expand(uint32 newSize)
{
  801f03:	55                   	push   %ebp
  801f04:	89 e5                	mov    %esp,%ebp
  801f06:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f09:	83 ec 04             	sub    $0x4,%esp
  801f0c:	68 70 2f 80 00       	push   $0x802f70
  801f11:	68 ba 00 00 00       	push   $0xba
  801f16:	68 93 2f 80 00       	push   $0x802f93
  801f1b:	e8 ef eb ff ff       	call   800b0f <_panic>

00801f20 <shrink>:
}
void shrink(uint32 newSize)
{
  801f20:	55                   	push   %ebp
  801f21:	89 e5                	mov    %esp,%ebp
  801f23:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f26:	83 ec 04             	sub    $0x4,%esp
  801f29:	68 70 2f 80 00       	push   $0x802f70
  801f2e:	68 be 00 00 00       	push   $0xbe
  801f33:	68 93 2f 80 00       	push   $0x802f93
  801f38:	e8 d2 eb ff ff       	call   800b0f <_panic>

00801f3d <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801f3d:	55                   	push   %ebp
  801f3e:	89 e5                	mov    %esp,%ebp
  801f40:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f43:	83 ec 04             	sub    $0x4,%esp
  801f46:	68 70 2f 80 00       	push   $0x802f70
  801f4b:	68 c3 00 00 00       	push   $0xc3
  801f50:	68 93 2f 80 00       	push   $0x802f93
  801f55:	e8 b5 eb ff ff       	call   800b0f <_panic>

00801f5a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801f5a:	55                   	push   %ebp
  801f5b:	89 e5                	mov    %esp,%ebp
  801f5d:	57                   	push   %edi
  801f5e:	56                   	push   %esi
  801f5f:	53                   	push   %ebx
  801f60:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801f63:	8b 45 08             	mov    0x8(%ebp),%eax
  801f66:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f69:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f6c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f6f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801f72:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801f75:	cd 30                	int    $0x30
  801f77:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801f7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801f7d:	83 c4 10             	add    $0x10,%esp
  801f80:	5b                   	pop    %ebx
  801f81:	5e                   	pop    %esi
  801f82:	5f                   	pop    %edi
  801f83:	5d                   	pop    %ebp
  801f84:	c3                   	ret    

00801f85 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801f85:	55                   	push   %ebp
  801f86:	89 e5                	mov    %esp,%ebp
  801f88:	83 ec 04             	sub    $0x4,%esp
  801f8b:	8b 45 10             	mov    0x10(%ebp),%eax
  801f8e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801f91:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f95:	8b 45 08             	mov    0x8(%ebp),%eax
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	52                   	push   %edx
  801f9d:	ff 75 0c             	pushl  0xc(%ebp)
  801fa0:	50                   	push   %eax
  801fa1:	6a 00                	push   $0x0
  801fa3:	e8 b2 ff ff ff       	call   801f5a <syscall>
  801fa8:	83 c4 18             	add    $0x18,%esp
}
  801fab:	90                   	nop
  801fac:	c9                   	leave  
  801fad:	c3                   	ret    

00801fae <sys_cgetc>:

int
sys_cgetc(void)
{
  801fae:	55                   	push   %ebp
  801faf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 01                	push   $0x1
  801fbd:	e8 98 ff ff ff       	call   801f5a <syscall>
  801fc2:	83 c4 18             	add    $0x18,%esp
}
  801fc5:	c9                   	leave  
  801fc6:	c3                   	ret    

00801fc7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801fc7:	55                   	push   %ebp
  801fc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801fca:	8b 45 08             	mov    0x8(%ebp),%eax
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	50                   	push   %eax
  801fd6:	6a 05                	push   $0x5
  801fd8:	e8 7d ff ff ff       	call   801f5a <syscall>
  801fdd:	83 c4 18             	add    $0x18,%esp
}
  801fe0:	c9                   	leave  
  801fe1:	c3                   	ret    

00801fe2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801fe2:	55                   	push   %ebp
  801fe3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 00                	push   $0x0
  801fed:	6a 00                	push   $0x0
  801fef:	6a 02                	push   $0x2
  801ff1:	e8 64 ff ff ff       	call   801f5a <syscall>
  801ff6:	83 c4 18             	add    $0x18,%esp
}
  801ff9:	c9                   	leave  
  801ffa:	c3                   	ret    

00801ffb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ffb:	55                   	push   %ebp
  801ffc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	6a 03                	push   $0x3
  80200a:	e8 4b ff ff ff       	call   801f5a <syscall>
  80200f:	83 c4 18             	add    $0x18,%esp
}
  802012:	c9                   	leave  
  802013:	c3                   	ret    

00802014 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802014:	55                   	push   %ebp
  802015:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802017:	6a 00                	push   $0x0
  802019:	6a 00                	push   $0x0
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	6a 04                	push   $0x4
  802023:	e8 32 ff ff ff       	call   801f5a <syscall>
  802028:	83 c4 18             	add    $0x18,%esp
}
  80202b:	c9                   	leave  
  80202c:	c3                   	ret    

0080202d <sys_env_exit>:


void sys_env_exit(void)
{
  80202d:	55                   	push   %ebp
  80202e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802030:	6a 00                	push   $0x0
  802032:	6a 00                	push   $0x0
  802034:	6a 00                	push   $0x0
  802036:	6a 00                	push   $0x0
  802038:	6a 00                	push   $0x0
  80203a:	6a 06                	push   $0x6
  80203c:	e8 19 ff ff ff       	call   801f5a <syscall>
  802041:	83 c4 18             	add    $0x18,%esp
}
  802044:	90                   	nop
  802045:	c9                   	leave  
  802046:	c3                   	ret    

00802047 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802047:	55                   	push   %ebp
  802048:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80204a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80204d:	8b 45 08             	mov    0x8(%ebp),%eax
  802050:	6a 00                	push   $0x0
  802052:	6a 00                	push   $0x0
  802054:	6a 00                	push   $0x0
  802056:	52                   	push   %edx
  802057:	50                   	push   %eax
  802058:	6a 07                	push   $0x7
  80205a:	e8 fb fe ff ff       	call   801f5a <syscall>
  80205f:	83 c4 18             	add    $0x18,%esp
}
  802062:	c9                   	leave  
  802063:	c3                   	ret    

00802064 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802064:	55                   	push   %ebp
  802065:	89 e5                	mov    %esp,%ebp
  802067:	56                   	push   %esi
  802068:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802069:	8b 75 18             	mov    0x18(%ebp),%esi
  80206c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80206f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802072:	8b 55 0c             	mov    0xc(%ebp),%edx
  802075:	8b 45 08             	mov    0x8(%ebp),%eax
  802078:	56                   	push   %esi
  802079:	53                   	push   %ebx
  80207a:	51                   	push   %ecx
  80207b:	52                   	push   %edx
  80207c:	50                   	push   %eax
  80207d:	6a 08                	push   $0x8
  80207f:	e8 d6 fe ff ff       	call   801f5a <syscall>
  802084:	83 c4 18             	add    $0x18,%esp
}
  802087:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80208a:	5b                   	pop    %ebx
  80208b:	5e                   	pop    %esi
  80208c:	5d                   	pop    %ebp
  80208d:	c3                   	ret    

0080208e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80208e:	55                   	push   %ebp
  80208f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802091:	8b 55 0c             	mov    0xc(%ebp),%edx
  802094:	8b 45 08             	mov    0x8(%ebp),%eax
  802097:	6a 00                	push   $0x0
  802099:	6a 00                	push   $0x0
  80209b:	6a 00                	push   $0x0
  80209d:	52                   	push   %edx
  80209e:	50                   	push   %eax
  80209f:	6a 09                	push   $0x9
  8020a1:	e8 b4 fe ff ff       	call   801f5a <syscall>
  8020a6:	83 c4 18             	add    $0x18,%esp
}
  8020a9:	c9                   	leave  
  8020aa:	c3                   	ret    

008020ab <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8020ab:	55                   	push   %ebp
  8020ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 00                	push   $0x0
  8020b4:	ff 75 0c             	pushl  0xc(%ebp)
  8020b7:	ff 75 08             	pushl  0x8(%ebp)
  8020ba:	6a 0a                	push   $0xa
  8020bc:	e8 99 fe ff ff       	call   801f5a <syscall>
  8020c1:	83 c4 18             	add    $0x18,%esp
}
  8020c4:	c9                   	leave  
  8020c5:	c3                   	ret    

008020c6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8020c6:	55                   	push   %ebp
  8020c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 0b                	push   $0xb
  8020d5:	e8 80 fe ff ff       	call   801f5a <syscall>
  8020da:	83 c4 18             	add    $0x18,%esp
}
  8020dd:	c9                   	leave  
  8020de:	c3                   	ret    

008020df <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8020df:	55                   	push   %ebp
  8020e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 00                	push   $0x0
  8020ea:	6a 00                	push   $0x0
  8020ec:	6a 0c                	push   $0xc
  8020ee:	e8 67 fe ff ff       	call   801f5a <syscall>
  8020f3:	83 c4 18             	add    $0x18,%esp
}
  8020f6:	c9                   	leave  
  8020f7:	c3                   	ret    

008020f8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8020f8:	55                   	push   %ebp
  8020f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8020fb:	6a 00                	push   $0x0
  8020fd:	6a 00                	push   $0x0
  8020ff:	6a 00                	push   $0x0
  802101:	6a 00                	push   $0x0
  802103:	6a 00                	push   $0x0
  802105:	6a 0d                	push   $0xd
  802107:	e8 4e fe ff ff       	call   801f5a <syscall>
  80210c:	83 c4 18             	add    $0x18,%esp
}
  80210f:	c9                   	leave  
  802110:	c3                   	ret    

00802111 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802111:	55                   	push   %ebp
  802112:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	ff 75 0c             	pushl  0xc(%ebp)
  80211d:	ff 75 08             	pushl  0x8(%ebp)
  802120:	6a 11                	push   $0x11
  802122:	e8 33 fe ff ff       	call   801f5a <syscall>
  802127:	83 c4 18             	add    $0x18,%esp
	return;
  80212a:	90                   	nop
}
  80212b:	c9                   	leave  
  80212c:	c3                   	ret    

0080212d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80212d:	55                   	push   %ebp
  80212e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802130:	6a 00                	push   $0x0
  802132:	6a 00                	push   $0x0
  802134:	6a 00                	push   $0x0
  802136:	ff 75 0c             	pushl  0xc(%ebp)
  802139:	ff 75 08             	pushl  0x8(%ebp)
  80213c:	6a 12                	push   $0x12
  80213e:	e8 17 fe ff ff       	call   801f5a <syscall>
  802143:	83 c4 18             	add    $0x18,%esp
	return ;
  802146:	90                   	nop
}
  802147:	c9                   	leave  
  802148:	c3                   	ret    

00802149 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802149:	55                   	push   %ebp
  80214a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80214c:	6a 00                	push   $0x0
  80214e:	6a 00                	push   $0x0
  802150:	6a 00                	push   $0x0
  802152:	6a 00                	push   $0x0
  802154:	6a 00                	push   $0x0
  802156:	6a 0e                	push   $0xe
  802158:	e8 fd fd ff ff       	call   801f5a <syscall>
  80215d:	83 c4 18             	add    $0x18,%esp
}
  802160:	c9                   	leave  
  802161:	c3                   	ret    

00802162 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802162:	55                   	push   %ebp
  802163:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802165:	6a 00                	push   $0x0
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	6a 00                	push   $0x0
  80216d:	ff 75 08             	pushl  0x8(%ebp)
  802170:	6a 0f                	push   $0xf
  802172:	e8 e3 fd ff ff       	call   801f5a <syscall>
  802177:	83 c4 18             	add    $0x18,%esp
}
  80217a:	c9                   	leave  
  80217b:	c3                   	ret    

0080217c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80217c:	55                   	push   %ebp
  80217d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80217f:	6a 00                	push   $0x0
  802181:	6a 00                	push   $0x0
  802183:	6a 00                	push   $0x0
  802185:	6a 00                	push   $0x0
  802187:	6a 00                	push   $0x0
  802189:	6a 10                	push   $0x10
  80218b:	e8 ca fd ff ff       	call   801f5a <syscall>
  802190:	83 c4 18             	add    $0x18,%esp
}
  802193:	90                   	nop
  802194:	c9                   	leave  
  802195:	c3                   	ret    

00802196 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802196:	55                   	push   %ebp
  802197:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 00                	push   $0x0
  8021a3:	6a 14                	push   $0x14
  8021a5:	e8 b0 fd ff ff       	call   801f5a <syscall>
  8021aa:	83 c4 18             	add    $0x18,%esp
}
  8021ad:	90                   	nop
  8021ae:	c9                   	leave  
  8021af:	c3                   	ret    

008021b0 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8021b0:	55                   	push   %ebp
  8021b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8021b3:	6a 00                	push   $0x0
  8021b5:	6a 00                	push   $0x0
  8021b7:	6a 00                	push   $0x0
  8021b9:	6a 00                	push   $0x0
  8021bb:	6a 00                	push   $0x0
  8021bd:	6a 15                	push   $0x15
  8021bf:	e8 96 fd ff ff       	call   801f5a <syscall>
  8021c4:	83 c4 18             	add    $0x18,%esp
}
  8021c7:	90                   	nop
  8021c8:	c9                   	leave  
  8021c9:	c3                   	ret    

008021ca <sys_cputc>:


void
sys_cputc(const char c)
{
  8021ca:	55                   	push   %ebp
  8021cb:	89 e5                	mov    %esp,%ebp
  8021cd:	83 ec 04             	sub    $0x4,%esp
  8021d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8021d6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021da:	6a 00                	push   $0x0
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 00                	push   $0x0
  8021e0:	6a 00                	push   $0x0
  8021e2:	50                   	push   %eax
  8021e3:	6a 16                	push   $0x16
  8021e5:	e8 70 fd ff ff       	call   801f5a <syscall>
  8021ea:	83 c4 18             	add    $0x18,%esp
}
  8021ed:	90                   	nop
  8021ee:	c9                   	leave  
  8021ef:	c3                   	ret    

008021f0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8021f0:	55                   	push   %ebp
  8021f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8021f3:	6a 00                	push   $0x0
  8021f5:	6a 00                	push   $0x0
  8021f7:	6a 00                	push   $0x0
  8021f9:	6a 00                	push   $0x0
  8021fb:	6a 00                	push   $0x0
  8021fd:	6a 17                	push   $0x17
  8021ff:	e8 56 fd ff ff       	call   801f5a <syscall>
  802204:	83 c4 18             	add    $0x18,%esp
}
  802207:	90                   	nop
  802208:	c9                   	leave  
  802209:	c3                   	ret    

0080220a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80220a:	55                   	push   %ebp
  80220b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80220d:	8b 45 08             	mov    0x8(%ebp),%eax
  802210:	6a 00                	push   $0x0
  802212:	6a 00                	push   $0x0
  802214:	6a 00                	push   $0x0
  802216:	ff 75 0c             	pushl  0xc(%ebp)
  802219:	50                   	push   %eax
  80221a:	6a 18                	push   $0x18
  80221c:	e8 39 fd ff ff       	call   801f5a <syscall>
  802221:	83 c4 18             	add    $0x18,%esp
}
  802224:	c9                   	leave  
  802225:	c3                   	ret    

00802226 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802226:	55                   	push   %ebp
  802227:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802229:	8b 55 0c             	mov    0xc(%ebp),%edx
  80222c:	8b 45 08             	mov    0x8(%ebp),%eax
  80222f:	6a 00                	push   $0x0
  802231:	6a 00                	push   $0x0
  802233:	6a 00                	push   $0x0
  802235:	52                   	push   %edx
  802236:	50                   	push   %eax
  802237:	6a 1b                	push   $0x1b
  802239:	e8 1c fd ff ff       	call   801f5a <syscall>
  80223e:	83 c4 18             	add    $0x18,%esp
}
  802241:	c9                   	leave  
  802242:	c3                   	ret    

00802243 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802243:	55                   	push   %ebp
  802244:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802246:	8b 55 0c             	mov    0xc(%ebp),%edx
  802249:	8b 45 08             	mov    0x8(%ebp),%eax
  80224c:	6a 00                	push   $0x0
  80224e:	6a 00                	push   $0x0
  802250:	6a 00                	push   $0x0
  802252:	52                   	push   %edx
  802253:	50                   	push   %eax
  802254:	6a 19                	push   $0x19
  802256:	e8 ff fc ff ff       	call   801f5a <syscall>
  80225b:	83 c4 18             	add    $0x18,%esp
}
  80225e:	90                   	nop
  80225f:	c9                   	leave  
  802260:	c3                   	ret    

00802261 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802261:	55                   	push   %ebp
  802262:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802264:	8b 55 0c             	mov    0xc(%ebp),%edx
  802267:	8b 45 08             	mov    0x8(%ebp),%eax
  80226a:	6a 00                	push   $0x0
  80226c:	6a 00                	push   $0x0
  80226e:	6a 00                	push   $0x0
  802270:	52                   	push   %edx
  802271:	50                   	push   %eax
  802272:	6a 1a                	push   $0x1a
  802274:	e8 e1 fc ff ff       	call   801f5a <syscall>
  802279:	83 c4 18             	add    $0x18,%esp
}
  80227c:	90                   	nop
  80227d:	c9                   	leave  
  80227e:	c3                   	ret    

0080227f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80227f:	55                   	push   %ebp
  802280:	89 e5                	mov    %esp,%ebp
  802282:	83 ec 04             	sub    $0x4,%esp
  802285:	8b 45 10             	mov    0x10(%ebp),%eax
  802288:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80228b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80228e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802292:	8b 45 08             	mov    0x8(%ebp),%eax
  802295:	6a 00                	push   $0x0
  802297:	51                   	push   %ecx
  802298:	52                   	push   %edx
  802299:	ff 75 0c             	pushl  0xc(%ebp)
  80229c:	50                   	push   %eax
  80229d:	6a 1c                	push   $0x1c
  80229f:	e8 b6 fc ff ff       	call   801f5a <syscall>
  8022a4:	83 c4 18             	add    $0x18,%esp
}
  8022a7:	c9                   	leave  
  8022a8:	c3                   	ret    

008022a9 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8022a9:	55                   	push   %ebp
  8022aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8022ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022af:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b2:	6a 00                	push   $0x0
  8022b4:	6a 00                	push   $0x0
  8022b6:	6a 00                	push   $0x0
  8022b8:	52                   	push   %edx
  8022b9:	50                   	push   %eax
  8022ba:	6a 1d                	push   $0x1d
  8022bc:	e8 99 fc ff ff       	call   801f5a <syscall>
  8022c1:	83 c4 18             	add    $0x18,%esp
}
  8022c4:	c9                   	leave  
  8022c5:	c3                   	ret    

008022c6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8022c6:	55                   	push   %ebp
  8022c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8022c9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8022cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d2:	6a 00                	push   $0x0
  8022d4:	6a 00                	push   $0x0
  8022d6:	51                   	push   %ecx
  8022d7:	52                   	push   %edx
  8022d8:	50                   	push   %eax
  8022d9:	6a 1e                	push   $0x1e
  8022db:	e8 7a fc ff ff       	call   801f5a <syscall>
  8022e0:	83 c4 18             	add    $0x18,%esp
}
  8022e3:	c9                   	leave  
  8022e4:	c3                   	ret    

008022e5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8022e5:	55                   	push   %ebp
  8022e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8022e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ee:	6a 00                	push   $0x0
  8022f0:	6a 00                	push   $0x0
  8022f2:	6a 00                	push   $0x0
  8022f4:	52                   	push   %edx
  8022f5:	50                   	push   %eax
  8022f6:	6a 1f                	push   $0x1f
  8022f8:	e8 5d fc ff ff       	call   801f5a <syscall>
  8022fd:	83 c4 18             	add    $0x18,%esp
}
  802300:	c9                   	leave  
  802301:	c3                   	ret    

00802302 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802302:	55                   	push   %ebp
  802303:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802305:	6a 00                	push   $0x0
  802307:	6a 00                	push   $0x0
  802309:	6a 00                	push   $0x0
  80230b:	6a 00                	push   $0x0
  80230d:	6a 00                	push   $0x0
  80230f:	6a 20                	push   $0x20
  802311:	e8 44 fc ff ff       	call   801f5a <syscall>
  802316:	83 c4 18             	add    $0x18,%esp
}
  802319:	c9                   	leave  
  80231a:	c3                   	ret    

0080231b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80231b:	55                   	push   %ebp
  80231c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80231e:	8b 45 08             	mov    0x8(%ebp),%eax
  802321:	6a 00                	push   $0x0
  802323:	ff 75 14             	pushl  0x14(%ebp)
  802326:	ff 75 10             	pushl  0x10(%ebp)
  802329:	ff 75 0c             	pushl  0xc(%ebp)
  80232c:	50                   	push   %eax
  80232d:	6a 21                	push   $0x21
  80232f:	e8 26 fc ff ff       	call   801f5a <syscall>
  802334:	83 c4 18             	add    $0x18,%esp
}
  802337:	c9                   	leave  
  802338:	c3                   	ret    

00802339 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802339:	55                   	push   %ebp
  80233a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80233c:	8b 45 08             	mov    0x8(%ebp),%eax
  80233f:	6a 00                	push   $0x0
  802341:	6a 00                	push   $0x0
  802343:	6a 00                	push   $0x0
  802345:	6a 00                	push   $0x0
  802347:	50                   	push   %eax
  802348:	6a 22                	push   $0x22
  80234a:	e8 0b fc ff ff       	call   801f5a <syscall>
  80234f:	83 c4 18             	add    $0x18,%esp
}
  802352:	90                   	nop
  802353:	c9                   	leave  
  802354:	c3                   	ret    

00802355 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802355:	55                   	push   %ebp
  802356:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802358:	8b 45 08             	mov    0x8(%ebp),%eax
  80235b:	6a 00                	push   $0x0
  80235d:	6a 00                	push   $0x0
  80235f:	6a 00                	push   $0x0
  802361:	6a 00                	push   $0x0
  802363:	50                   	push   %eax
  802364:	6a 23                	push   $0x23
  802366:	e8 ef fb ff ff       	call   801f5a <syscall>
  80236b:	83 c4 18             	add    $0x18,%esp
}
  80236e:	90                   	nop
  80236f:	c9                   	leave  
  802370:	c3                   	ret    

00802371 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802371:	55                   	push   %ebp
  802372:	89 e5                	mov    %esp,%ebp
  802374:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802377:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80237a:	8d 50 04             	lea    0x4(%eax),%edx
  80237d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802380:	6a 00                	push   $0x0
  802382:	6a 00                	push   $0x0
  802384:	6a 00                	push   $0x0
  802386:	52                   	push   %edx
  802387:	50                   	push   %eax
  802388:	6a 24                	push   $0x24
  80238a:	e8 cb fb ff ff       	call   801f5a <syscall>
  80238f:	83 c4 18             	add    $0x18,%esp
	return result;
  802392:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802395:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802398:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80239b:	89 01                	mov    %eax,(%ecx)
  80239d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8023a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8023a3:	c9                   	leave  
  8023a4:	c2 04 00             	ret    $0x4

008023a7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8023a7:	55                   	push   %ebp
  8023a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8023aa:	6a 00                	push   $0x0
  8023ac:	6a 00                	push   $0x0
  8023ae:	ff 75 10             	pushl  0x10(%ebp)
  8023b1:	ff 75 0c             	pushl  0xc(%ebp)
  8023b4:	ff 75 08             	pushl  0x8(%ebp)
  8023b7:	6a 13                	push   $0x13
  8023b9:	e8 9c fb ff ff       	call   801f5a <syscall>
  8023be:	83 c4 18             	add    $0x18,%esp
	return ;
  8023c1:	90                   	nop
}
  8023c2:	c9                   	leave  
  8023c3:	c3                   	ret    

008023c4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8023c4:	55                   	push   %ebp
  8023c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8023c7:	6a 00                	push   $0x0
  8023c9:	6a 00                	push   $0x0
  8023cb:	6a 00                	push   $0x0
  8023cd:	6a 00                	push   $0x0
  8023cf:	6a 00                	push   $0x0
  8023d1:	6a 25                	push   $0x25
  8023d3:	e8 82 fb ff ff       	call   801f5a <syscall>
  8023d8:	83 c4 18             	add    $0x18,%esp
}
  8023db:	c9                   	leave  
  8023dc:	c3                   	ret    

008023dd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8023dd:	55                   	push   %ebp
  8023de:	89 e5                	mov    %esp,%ebp
  8023e0:	83 ec 04             	sub    $0x4,%esp
  8023e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8023e9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8023ed:	6a 00                	push   $0x0
  8023ef:	6a 00                	push   $0x0
  8023f1:	6a 00                	push   $0x0
  8023f3:	6a 00                	push   $0x0
  8023f5:	50                   	push   %eax
  8023f6:	6a 26                	push   $0x26
  8023f8:	e8 5d fb ff ff       	call   801f5a <syscall>
  8023fd:	83 c4 18             	add    $0x18,%esp
	return ;
  802400:	90                   	nop
}
  802401:	c9                   	leave  
  802402:	c3                   	ret    

00802403 <rsttst>:
void rsttst()
{
  802403:	55                   	push   %ebp
  802404:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802406:	6a 00                	push   $0x0
  802408:	6a 00                	push   $0x0
  80240a:	6a 00                	push   $0x0
  80240c:	6a 00                	push   $0x0
  80240e:	6a 00                	push   $0x0
  802410:	6a 28                	push   $0x28
  802412:	e8 43 fb ff ff       	call   801f5a <syscall>
  802417:	83 c4 18             	add    $0x18,%esp
	return ;
  80241a:	90                   	nop
}
  80241b:	c9                   	leave  
  80241c:	c3                   	ret    

0080241d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80241d:	55                   	push   %ebp
  80241e:	89 e5                	mov    %esp,%ebp
  802420:	83 ec 04             	sub    $0x4,%esp
  802423:	8b 45 14             	mov    0x14(%ebp),%eax
  802426:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802429:	8b 55 18             	mov    0x18(%ebp),%edx
  80242c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802430:	52                   	push   %edx
  802431:	50                   	push   %eax
  802432:	ff 75 10             	pushl  0x10(%ebp)
  802435:	ff 75 0c             	pushl  0xc(%ebp)
  802438:	ff 75 08             	pushl  0x8(%ebp)
  80243b:	6a 27                	push   $0x27
  80243d:	e8 18 fb ff ff       	call   801f5a <syscall>
  802442:	83 c4 18             	add    $0x18,%esp
	return ;
  802445:	90                   	nop
}
  802446:	c9                   	leave  
  802447:	c3                   	ret    

00802448 <chktst>:
void chktst(uint32 n)
{
  802448:	55                   	push   %ebp
  802449:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80244b:	6a 00                	push   $0x0
  80244d:	6a 00                	push   $0x0
  80244f:	6a 00                	push   $0x0
  802451:	6a 00                	push   $0x0
  802453:	ff 75 08             	pushl  0x8(%ebp)
  802456:	6a 29                	push   $0x29
  802458:	e8 fd fa ff ff       	call   801f5a <syscall>
  80245d:	83 c4 18             	add    $0x18,%esp
	return ;
  802460:	90                   	nop
}
  802461:	c9                   	leave  
  802462:	c3                   	ret    

00802463 <inctst>:

void inctst()
{
  802463:	55                   	push   %ebp
  802464:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802466:	6a 00                	push   $0x0
  802468:	6a 00                	push   $0x0
  80246a:	6a 00                	push   $0x0
  80246c:	6a 00                	push   $0x0
  80246e:	6a 00                	push   $0x0
  802470:	6a 2a                	push   $0x2a
  802472:	e8 e3 fa ff ff       	call   801f5a <syscall>
  802477:	83 c4 18             	add    $0x18,%esp
	return ;
  80247a:	90                   	nop
}
  80247b:	c9                   	leave  
  80247c:	c3                   	ret    

0080247d <gettst>:
uint32 gettst()
{
  80247d:	55                   	push   %ebp
  80247e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802480:	6a 00                	push   $0x0
  802482:	6a 00                	push   $0x0
  802484:	6a 00                	push   $0x0
  802486:	6a 00                	push   $0x0
  802488:	6a 00                	push   $0x0
  80248a:	6a 2b                	push   $0x2b
  80248c:	e8 c9 fa ff ff       	call   801f5a <syscall>
  802491:	83 c4 18             	add    $0x18,%esp
}
  802494:	c9                   	leave  
  802495:	c3                   	ret    

00802496 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802496:	55                   	push   %ebp
  802497:	89 e5                	mov    %esp,%ebp
  802499:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80249c:	6a 00                	push   $0x0
  80249e:	6a 00                	push   $0x0
  8024a0:	6a 00                	push   $0x0
  8024a2:	6a 00                	push   $0x0
  8024a4:	6a 00                	push   $0x0
  8024a6:	6a 2c                	push   $0x2c
  8024a8:	e8 ad fa ff ff       	call   801f5a <syscall>
  8024ad:	83 c4 18             	add    $0x18,%esp
  8024b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8024b3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8024b7:	75 07                	jne    8024c0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8024b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8024be:	eb 05                	jmp    8024c5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8024c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024c5:	c9                   	leave  
  8024c6:	c3                   	ret    

008024c7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8024c7:	55                   	push   %ebp
  8024c8:	89 e5                	mov    %esp,%ebp
  8024ca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024cd:	6a 00                	push   $0x0
  8024cf:	6a 00                	push   $0x0
  8024d1:	6a 00                	push   $0x0
  8024d3:	6a 00                	push   $0x0
  8024d5:	6a 00                	push   $0x0
  8024d7:	6a 2c                	push   $0x2c
  8024d9:	e8 7c fa ff ff       	call   801f5a <syscall>
  8024de:	83 c4 18             	add    $0x18,%esp
  8024e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8024e4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8024e8:	75 07                	jne    8024f1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8024ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8024ef:	eb 05                	jmp    8024f6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8024f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024f6:	c9                   	leave  
  8024f7:	c3                   	ret    

008024f8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8024f8:	55                   	push   %ebp
  8024f9:	89 e5                	mov    %esp,%ebp
  8024fb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024fe:	6a 00                	push   $0x0
  802500:	6a 00                	push   $0x0
  802502:	6a 00                	push   $0x0
  802504:	6a 00                	push   $0x0
  802506:	6a 00                	push   $0x0
  802508:	6a 2c                	push   $0x2c
  80250a:	e8 4b fa ff ff       	call   801f5a <syscall>
  80250f:	83 c4 18             	add    $0x18,%esp
  802512:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802515:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802519:	75 07                	jne    802522 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80251b:	b8 01 00 00 00       	mov    $0x1,%eax
  802520:	eb 05                	jmp    802527 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802522:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802527:	c9                   	leave  
  802528:	c3                   	ret    

00802529 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802529:	55                   	push   %ebp
  80252a:	89 e5                	mov    %esp,%ebp
  80252c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80252f:	6a 00                	push   $0x0
  802531:	6a 00                	push   $0x0
  802533:	6a 00                	push   $0x0
  802535:	6a 00                	push   $0x0
  802537:	6a 00                	push   $0x0
  802539:	6a 2c                	push   $0x2c
  80253b:	e8 1a fa ff ff       	call   801f5a <syscall>
  802540:	83 c4 18             	add    $0x18,%esp
  802543:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802546:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80254a:	75 07                	jne    802553 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80254c:	b8 01 00 00 00       	mov    $0x1,%eax
  802551:	eb 05                	jmp    802558 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802553:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802558:	c9                   	leave  
  802559:	c3                   	ret    

0080255a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80255a:	55                   	push   %ebp
  80255b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80255d:	6a 00                	push   $0x0
  80255f:	6a 00                	push   $0x0
  802561:	6a 00                	push   $0x0
  802563:	6a 00                	push   $0x0
  802565:	ff 75 08             	pushl  0x8(%ebp)
  802568:	6a 2d                	push   $0x2d
  80256a:	e8 eb f9 ff ff       	call   801f5a <syscall>
  80256f:	83 c4 18             	add    $0x18,%esp
	return ;
  802572:	90                   	nop
}
  802573:	c9                   	leave  
  802574:	c3                   	ret    

00802575 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802575:	55                   	push   %ebp
  802576:	89 e5                	mov    %esp,%ebp
  802578:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802579:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80257c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80257f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802582:	8b 45 08             	mov    0x8(%ebp),%eax
  802585:	6a 00                	push   $0x0
  802587:	53                   	push   %ebx
  802588:	51                   	push   %ecx
  802589:	52                   	push   %edx
  80258a:	50                   	push   %eax
  80258b:	6a 2e                	push   $0x2e
  80258d:	e8 c8 f9 ff ff       	call   801f5a <syscall>
  802592:	83 c4 18             	add    $0x18,%esp
}
  802595:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802598:	c9                   	leave  
  802599:	c3                   	ret    

0080259a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80259a:	55                   	push   %ebp
  80259b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80259d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8025a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8025a3:	6a 00                	push   $0x0
  8025a5:	6a 00                	push   $0x0
  8025a7:	6a 00                	push   $0x0
  8025a9:	52                   	push   %edx
  8025aa:	50                   	push   %eax
  8025ab:	6a 2f                	push   $0x2f
  8025ad:	e8 a8 f9 ff ff       	call   801f5a <syscall>
  8025b2:	83 c4 18             	add    $0x18,%esp
}
  8025b5:	c9                   	leave  
  8025b6:	c3                   	ret    

008025b7 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8025b7:	55                   	push   %ebp
  8025b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8025ba:	6a 00                	push   $0x0
  8025bc:	6a 00                	push   $0x0
  8025be:	6a 00                	push   $0x0
  8025c0:	ff 75 0c             	pushl  0xc(%ebp)
  8025c3:	ff 75 08             	pushl  0x8(%ebp)
  8025c6:	6a 30                	push   $0x30
  8025c8:	e8 8d f9 ff ff       	call   801f5a <syscall>
  8025cd:	83 c4 18             	add    $0x18,%esp
	return ;
  8025d0:	90                   	nop
}
  8025d1:	c9                   	leave  
  8025d2:	c3                   	ret    
  8025d3:	90                   	nop

008025d4 <__udivdi3>:
  8025d4:	55                   	push   %ebp
  8025d5:	57                   	push   %edi
  8025d6:	56                   	push   %esi
  8025d7:	53                   	push   %ebx
  8025d8:	83 ec 1c             	sub    $0x1c,%esp
  8025db:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8025df:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8025e3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025e7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8025eb:	89 ca                	mov    %ecx,%edx
  8025ed:	89 f8                	mov    %edi,%eax
  8025ef:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8025f3:	85 f6                	test   %esi,%esi
  8025f5:	75 2d                	jne    802624 <__udivdi3+0x50>
  8025f7:	39 cf                	cmp    %ecx,%edi
  8025f9:	77 65                	ja     802660 <__udivdi3+0x8c>
  8025fb:	89 fd                	mov    %edi,%ebp
  8025fd:	85 ff                	test   %edi,%edi
  8025ff:	75 0b                	jne    80260c <__udivdi3+0x38>
  802601:	b8 01 00 00 00       	mov    $0x1,%eax
  802606:	31 d2                	xor    %edx,%edx
  802608:	f7 f7                	div    %edi
  80260a:	89 c5                	mov    %eax,%ebp
  80260c:	31 d2                	xor    %edx,%edx
  80260e:	89 c8                	mov    %ecx,%eax
  802610:	f7 f5                	div    %ebp
  802612:	89 c1                	mov    %eax,%ecx
  802614:	89 d8                	mov    %ebx,%eax
  802616:	f7 f5                	div    %ebp
  802618:	89 cf                	mov    %ecx,%edi
  80261a:	89 fa                	mov    %edi,%edx
  80261c:	83 c4 1c             	add    $0x1c,%esp
  80261f:	5b                   	pop    %ebx
  802620:	5e                   	pop    %esi
  802621:	5f                   	pop    %edi
  802622:	5d                   	pop    %ebp
  802623:	c3                   	ret    
  802624:	39 ce                	cmp    %ecx,%esi
  802626:	77 28                	ja     802650 <__udivdi3+0x7c>
  802628:	0f bd fe             	bsr    %esi,%edi
  80262b:	83 f7 1f             	xor    $0x1f,%edi
  80262e:	75 40                	jne    802670 <__udivdi3+0x9c>
  802630:	39 ce                	cmp    %ecx,%esi
  802632:	72 0a                	jb     80263e <__udivdi3+0x6a>
  802634:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802638:	0f 87 9e 00 00 00    	ja     8026dc <__udivdi3+0x108>
  80263e:	b8 01 00 00 00       	mov    $0x1,%eax
  802643:	89 fa                	mov    %edi,%edx
  802645:	83 c4 1c             	add    $0x1c,%esp
  802648:	5b                   	pop    %ebx
  802649:	5e                   	pop    %esi
  80264a:	5f                   	pop    %edi
  80264b:	5d                   	pop    %ebp
  80264c:	c3                   	ret    
  80264d:	8d 76 00             	lea    0x0(%esi),%esi
  802650:	31 ff                	xor    %edi,%edi
  802652:	31 c0                	xor    %eax,%eax
  802654:	89 fa                	mov    %edi,%edx
  802656:	83 c4 1c             	add    $0x1c,%esp
  802659:	5b                   	pop    %ebx
  80265a:	5e                   	pop    %esi
  80265b:	5f                   	pop    %edi
  80265c:	5d                   	pop    %ebp
  80265d:	c3                   	ret    
  80265e:	66 90                	xchg   %ax,%ax
  802660:	89 d8                	mov    %ebx,%eax
  802662:	f7 f7                	div    %edi
  802664:	31 ff                	xor    %edi,%edi
  802666:	89 fa                	mov    %edi,%edx
  802668:	83 c4 1c             	add    $0x1c,%esp
  80266b:	5b                   	pop    %ebx
  80266c:	5e                   	pop    %esi
  80266d:	5f                   	pop    %edi
  80266e:	5d                   	pop    %ebp
  80266f:	c3                   	ret    
  802670:	bd 20 00 00 00       	mov    $0x20,%ebp
  802675:	89 eb                	mov    %ebp,%ebx
  802677:	29 fb                	sub    %edi,%ebx
  802679:	89 f9                	mov    %edi,%ecx
  80267b:	d3 e6                	shl    %cl,%esi
  80267d:	89 c5                	mov    %eax,%ebp
  80267f:	88 d9                	mov    %bl,%cl
  802681:	d3 ed                	shr    %cl,%ebp
  802683:	89 e9                	mov    %ebp,%ecx
  802685:	09 f1                	or     %esi,%ecx
  802687:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80268b:	89 f9                	mov    %edi,%ecx
  80268d:	d3 e0                	shl    %cl,%eax
  80268f:	89 c5                	mov    %eax,%ebp
  802691:	89 d6                	mov    %edx,%esi
  802693:	88 d9                	mov    %bl,%cl
  802695:	d3 ee                	shr    %cl,%esi
  802697:	89 f9                	mov    %edi,%ecx
  802699:	d3 e2                	shl    %cl,%edx
  80269b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80269f:	88 d9                	mov    %bl,%cl
  8026a1:	d3 e8                	shr    %cl,%eax
  8026a3:	09 c2                	or     %eax,%edx
  8026a5:	89 d0                	mov    %edx,%eax
  8026a7:	89 f2                	mov    %esi,%edx
  8026a9:	f7 74 24 0c          	divl   0xc(%esp)
  8026ad:	89 d6                	mov    %edx,%esi
  8026af:	89 c3                	mov    %eax,%ebx
  8026b1:	f7 e5                	mul    %ebp
  8026b3:	39 d6                	cmp    %edx,%esi
  8026b5:	72 19                	jb     8026d0 <__udivdi3+0xfc>
  8026b7:	74 0b                	je     8026c4 <__udivdi3+0xf0>
  8026b9:	89 d8                	mov    %ebx,%eax
  8026bb:	31 ff                	xor    %edi,%edi
  8026bd:	e9 58 ff ff ff       	jmp    80261a <__udivdi3+0x46>
  8026c2:	66 90                	xchg   %ax,%ax
  8026c4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8026c8:	89 f9                	mov    %edi,%ecx
  8026ca:	d3 e2                	shl    %cl,%edx
  8026cc:	39 c2                	cmp    %eax,%edx
  8026ce:	73 e9                	jae    8026b9 <__udivdi3+0xe5>
  8026d0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8026d3:	31 ff                	xor    %edi,%edi
  8026d5:	e9 40 ff ff ff       	jmp    80261a <__udivdi3+0x46>
  8026da:	66 90                	xchg   %ax,%ax
  8026dc:	31 c0                	xor    %eax,%eax
  8026de:	e9 37 ff ff ff       	jmp    80261a <__udivdi3+0x46>
  8026e3:	90                   	nop

008026e4 <__umoddi3>:
  8026e4:	55                   	push   %ebp
  8026e5:	57                   	push   %edi
  8026e6:	56                   	push   %esi
  8026e7:	53                   	push   %ebx
  8026e8:	83 ec 1c             	sub    $0x1c,%esp
  8026eb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8026ef:	8b 74 24 34          	mov    0x34(%esp),%esi
  8026f3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026f7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8026fb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8026ff:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802703:	89 f3                	mov    %esi,%ebx
  802705:	89 fa                	mov    %edi,%edx
  802707:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80270b:	89 34 24             	mov    %esi,(%esp)
  80270e:	85 c0                	test   %eax,%eax
  802710:	75 1a                	jne    80272c <__umoddi3+0x48>
  802712:	39 f7                	cmp    %esi,%edi
  802714:	0f 86 a2 00 00 00    	jbe    8027bc <__umoddi3+0xd8>
  80271a:	89 c8                	mov    %ecx,%eax
  80271c:	89 f2                	mov    %esi,%edx
  80271e:	f7 f7                	div    %edi
  802720:	89 d0                	mov    %edx,%eax
  802722:	31 d2                	xor    %edx,%edx
  802724:	83 c4 1c             	add    $0x1c,%esp
  802727:	5b                   	pop    %ebx
  802728:	5e                   	pop    %esi
  802729:	5f                   	pop    %edi
  80272a:	5d                   	pop    %ebp
  80272b:	c3                   	ret    
  80272c:	39 f0                	cmp    %esi,%eax
  80272e:	0f 87 ac 00 00 00    	ja     8027e0 <__umoddi3+0xfc>
  802734:	0f bd e8             	bsr    %eax,%ebp
  802737:	83 f5 1f             	xor    $0x1f,%ebp
  80273a:	0f 84 ac 00 00 00    	je     8027ec <__umoddi3+0x108>
  802740:	bf 20 00 00 00       	mov    $0x20,%edi
  802745:	29 ef                	sub    %ebp,%edi
  802747:	89 fe                	mov    %edi,%esi
  802749:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80274d:	89 e9                	mov    %ebp,%ecx
  80274f:	d3 e0                	shl    %cl,%eax
  802751:	89 d7                	mov    %edx,%edi
  802753:	89 f1                	mov    %esi,%ecx
  802755:	d3 ef                	shr    %cl,%edi
  802757:	09 c7                	or     %eax,%edi
  802759:	89 e9                	mov    %ebp,%ecx
  80275b:	d3 e2                	shl    %cl,%edx
  80275d:	89 14 24             	mov    %edx,(%esp)
  802760:	89 d8                	mov    %ebx,%eax
  802762:	d3 e0                	shl    %cl,%eax
  802764:	89 c2                	mov    %eax,%edx
  802766:	8b 44 24 08          	mov    0x8(%esp),%eax
  80276a:	d3 e0                	shl    %cl,%eax
  80276c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802770:	8b 44 24 08          	mov    0x8(%esp),%eax
  802774:	89 f1                	mov    %esi,%ecx
  802776:	d3 e8                	shr    %cl,%eax
  802778:	09 d0                	or     %edx,%eax
  80277a:	d3 eb                	shr    %cl,%ebx
  80277c:	89 da                	mov    %ebx,%edx
  80277e:	f7 f7                	div    %edi
  802780:	89 d3                	mov    %edx,%ebx
  802782:	f7 24 24             	mull   (%esp)
  802785:	89 c6                	mov    %eax,%esi
  802787:	89 d1                	mov    %edx,%ecx
  802789:	39 d3                	cmp    %edx,%ebx
  80278b:	0f 82 87 00 00 00    	jb     802818 <__umoddi3+0x134>
  802791:	0f 84 91 00 00 00    	je     802828 <__umoddi3+0x144>
  802797:	8b 54 24 04          	mov    0x4(%esp),%edx
  80279b:	29 f2                	sub    %esi,%edx
  80279d:	19 cb                	sbb    %ecx,%ebx
  80279f:	89 d8                	mov    %ebx,%eax
  8027a1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8027a5:	d3 e0                	shl    %cl,%eax
  8027a7:	89 e9                	mov    %ebp,%ecx
  8027a9:	d3 ea                	shr    %cl,%edx
  8027ab:	09 d0                	or     %edx,%eax
  8027ad:	89 e9                	mov    %ebp,%ecx
  8027af:	d3 eb                	shr    %cl,%ebx
  8027b1:	89 da                	mov    %ebx,%edx
  8027b3:	83 c4 1c             	add    $0x1c,%esp
  8027b6:	5b                   	pop    %ebx
  8027b7:	5e                   	pop    %esi
  8027b8:	5f                   	pop    %edi
  8027b9:	5d                   	pop    %ebp
  8027ba:	c3                   	ret    
  8027bb:	90                   	nop
  8027bc:	89 fd                	mov    %edi,%ebp
  8027be:	85 ff                	test   %edi,%edi
  8027c0:	75 0b                	jne    8027cd <__umoddi3+0xe9>
  8027c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8027c7:	31 d2                	xor    %edx,%edx
  8027c9:	f7 f7                	div    %edi
  8027cb:	89 c5                	mov    %eax,%ebp
  8027cd:	89 f0                	mov    %esi,%eax
  8027cf:	31 d2                	xor    %edx,%edx
  8027d1:	f7 f5                	div    %ebp
  8027d3:	89 c8                	mov    %ecx,%eax
  8027d5:	f7 f5                	div    %ebp
  8027d7:	89 d0                	mov    %edx,%eax
  8027d9:	e9 44 ff ff ff       	jmp    802722 <__umoddi3+0x3e>
  8027de:	66 90                	xchg   %ax,%ax
  8027e0:	89 c8                	mov    %ecx,%eax
  8027e2:	89 f2                	mov    %esi,%edx
  8027e4:	83 c4 1c             	add    $0x1c,%esp
  8027e7:	5b                   	pop    %ebx
  8027e8:	5e                   	pop    %esi
  8027e9:	5f                   	pop    %edi
  8027ea:	5d                   	pop    %ebp
  8027eb:	c3                   	ret    
  8027ec:	3b 04 24             	cmp    (%esp),%eax
  8027ef:	72 06                	jb     8027f7 <__umoddi3+0x113>
  8027f1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8027f5:	77 0f                	ja     802806 <__umoddi3+0x122>
  8027f7:	89 f2                	mov    %esi,%edx
  8027f9:	29 f9                	sub    %edi,%ecx
  8027fb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8027ff:	89 14 24             	mov    %edx,(%esp)
  802802:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802806:	8b 44 24 04          	mov    0x4(%esp),%eax
  80280a:	8b 14 24             	mov    (%esp),%edx
  80280d:	83 c4 1c             	add    $0x1c,%esp
  802810:	5b                   	pop    %ebx
  802811:	5e                   	pop    %esi
  802812:	5f                   	pop    %edi
  802813:	5d                   	pop    %ebp
  802814:	c3                   	ret    
  802815:	8d 76 00             	lea    0x0(%esi),%esi
  802818:	2b 04 24             	sub    (%esp),%eax
  80281b:	19 fa                	sbb    %edi,%edx
  80281d:	89 d1                	mov    %edx,%ecx
  80281f:	89 c6                	mov    %eax,%esi
  802821:	e9 71 ff ff ff       	jmp    802797 <__umoddi3+0xb3>
  802826:	66 90                	xchg   %ax,%ax
  802828:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80282c:	72 ea                	jb     802818 <__umoddi3+0x134>
  80282e:	89 d9                	mov    %ebx,%ecx
  802830:	e9 62 ff ff ff       	jmp    802797 <__umoddi3+0xb3>
