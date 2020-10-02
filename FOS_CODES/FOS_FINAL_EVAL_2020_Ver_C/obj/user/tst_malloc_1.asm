
obj/user/tst_malloc_1:     file format elf32-i386


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
  800031:	e8 98 05 00 00       	call   8005ce <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800040:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800044:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004b:	eb 2a                	jmp    800077 <_main+0x3f>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004d:	a1 20 30 80 00       	mov    0x803020,%eax
  800052:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800058:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005b:	89 d0                	mov    %edx,%eax
  80005d:	c1 e0 02             	shl    $0x2,%eax
  800060:	01 d0                	add    %edx,%eax
  800062:	c1 e0 02             	shl    $0x2,%eax
  800065:	01 c8                	add    %ecx,%eax
  800067:	8a 40 04             	mov    0x4(%eax),%al
  80006a:	84 c0                	test   %al,%al
  80006c:	74 06                	je     800074 <_main+0x3c>
			{
				fullWS = 0;
  80006e:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800072:	eb 12                	jmp    800086 <_main+0x4e>
void _main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800074:	ff 45 f0             	incl   -0x10(%ebp)
  800077:	a1 20 30 80 00       	mov    0x803020,%eax
  80007c:	8b 50 74             	mov    0x74(%eax),%edx
  80007f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800082:	39 c2                	cmp    %eax,%edx
  800084:	77 c7                	ja     80004d <_main+0x15>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800086:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80008a:	74 14                	je     8000a0 <_main+0x68>
  80008c:	83 ec 04             	sub    $0x4,%esp
  80008f:	68 20 24 80 00       	push   $0x802420
  800094:	6a 14                	push   $0x14
  800096:	68 3c 24 80 00       	push   $0x80243c
  80009b:	e8 56 06 00 00       	call   8006f6 <_panic>
	}


	int Mega = 1024*1024;
  8000a0:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000a7:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)

	void* ptr_allocations[20] = {0};
  8000ae:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000b1:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000b6:	b8 00 00 00 00       	mov    $0x0,%eax
  8000bb:	89 d7                	mov    %edx,%edi
  8000bd:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		int freeFrames = sys_calculate_free_frames() ;
  8000bf:	e8 e9 1b 00 00       	call   801cad <sys_calculate_free_frames>
  8000c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000c7:	e8 64 1c 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  8000cc:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000d2:	01 c0                	add    %eax,%eax
  8000d4:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d7:	83 ec 0c             	sub    $0xc,%esp
  8000da:	50                   	push   %eax
  8000db:	e8 57 16 00 00       	call   801737 <malloc>
  8000e0:	83 c4 10             	add    $0x10,%esp
  8000e3:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8000e6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e9:	85 c0                	test   %eax,%eax
  8000eb:	79 0a                	jns    8000f7 <_main+0xbf>
  8000ed:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000f0:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  8000f5:	76 14                	jbe    80010b <_main+0xd3>
  8000f7:	83 ec 04             	sub    $0x4,%esp
  8000fa:	68 50 24 80 00       	push   $0x802450
  8000ff:	6a 20                	push   $0x20
  800101:	68 3c 24 80 00       	push   $0x80243c
  800106:	e8 eb 05 00 00       	call   8006f6 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80010b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80010e:	e8 9a 1b 00 00       	call   801cad <sys_calculate_free_frames>
  800113:	29 c3                	sub    %eax,%ebx
  800115:	89 d8                	mov    %ebx,%eax
  800117:	83 f8 01             	cmp    $0x1,%eax
  80011a:	74 14                	je     800130 <_main+0xf8>
  80011c:	83 ec 04             	sub    $0x4,%esp
  80011f:	68 80 24 80 00       	push   $0x802480
  800124:	6a 22                	push   $0x22
  800126:	68 3c 24 80 00       	push   $0x80243c
  80012b:	e8 c6 05 00 00       	call   8006f6 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800130:	e8 fb 1b 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  800135:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800138:	3d 00 02 00 00       	cmp    $0x200,%eax
  80013d:	74 14                	je     800153 <_main+0x11b>
  80013f:	83 ec 04             	sub    $0x4,%esp
  800142:	68 ec 24 80 00       	push   $0x8024ec
  800147:	6a 23                	push   $0x23
  800149:	68 3c 24 80 00       	push   $0x80243c
  80014e:	e8 a3 05 00 00       	call   8006f6 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800153:	e8 55 1b 00 00       	call   801cad <sys_calculate_free_frames>
  800158:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80015b:	e8 d0 1b 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  800160:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800163:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800166:	01 c0                	add    %eax,%eax
  800168:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80016b:	83 ec 0c             	sub    $0xc,%esp
  80016e:	50                   	push   %eax
  80016f:	e8 c3 15 00 00       	call   801737 <malloc>
  800174:	83 c4 10             	add    $0x10,%esp
  800177:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START + 2*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  80017a:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80017d:	89 c2                	mov    %eax,%edx
  80017f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800182:	01 c0                	add    %eax,%eax
  800184:	05 00 00 00 80       	add    $0x80000000,%eax
  800189:	39 c2                	cmp    %eax,%edx
  80018b:	72 13                	jb     8001a0 <_main+0x168>
  80018d:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800190:	89 c2                	mov    %eax,%edx
  800192:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800195:	01 c0                	add    %eax,%eax
  800197:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80019c:	39 c2                	cmp    %eax,%edx
  80019e:	76 14                	jbe    8001b4 <_main+0x17c>
  8001a0:	83 ec 04             	sub    $0x4,%esp
  8001a3:	68 50 24 80 00       	push   $0x802450
  8001a8:	6a 28                	push   $0x28
  8001aa:	68 3c 24 80 00       	push   $0x80243c
  8001af:	e8 42 05 00 00       	call   8006f6 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001b4:	e8 f4 1a 00 00       	call   801cad <sys_calculate_free_frames>
  8001b9:	89 c2                	mov    %eax,%edx
  8001bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001be:	39 c2                	cmp    %eax,%edx
  8001c0:	74 14                	je     8001d6 <_main+0x19e>
  8001c2:	83 ec 04             	sub    $0x4,%esp
  8001c5:	68 80 24 80 00       	push   $0x802480
  8001ca:	6a 2a                	push   $0x2a
  8001cc:	68 3c 24 80 00       	push   $0x80243c
  8001d1:	e8 20 05 00 00       	call   8006f6 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8001d6:	e8 55 1b 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  8001db:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001de:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001e3:	74 14                	je     8001f9 <_main+0x1c1>
  8001e5:	83 ec 04             	sub    $0x4,%esp
  8001e8:	68 ec 24 80 00       	push   $0x8024ec
  8001ed:	6a 2b                	push   $0x2b
  8001ef:	68 3c 24 80 00       	push   $0x80243c
  8001f4:	e8 fd 04 00 00       	call   8006f6 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8001f9:	e8 af 1a 00 00       	call   801cad <sys_calculate_free_frames>
  8001fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800201:	e8 2a 1b 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  800206:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800209:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80020c:	01 c0                	add    %eax,%eax
  80020e:	83 ec 0c             	sub    $0xc,%esp
  800211:	50                   	push   %eax
  800212:	e8 20 15 00 00       	call   801737 <malloc>
  800217:	83 c4 10             	add    $0x10,%esp
  80021a:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START + 4*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  80021d:	8b 45 98             	mov    -0x68(%ebp),%eax
  800220:	89 c2                	mov    %eax,%edx
  800222:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800225:	c1 e0 02             	shl    $0x2,%eax
  800228:	05 00 00 00 80       	add    $0x80000000,%eax
  80022d:	39 c2                	cmp    %eax,%edx
  80022f:	72 14                	jb     800245 <_main+0x20d>
  800231:	8b 45 98             	mov    -0x68(%ebp),%eax
  800234:	89 c2                	mov    %eax,%edx
  800236:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800239:	c1 e0 02             	shl    $0x2,%eax
  80023c:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800241:	39 c2                	cmp    %eax,%edx
  800243:	76 14                	jbe    800259 <_main+0x221>
  800245:	83 ec 04             	sub    $0x4,%esp
  800248:	68 50 24 80 00       	push   $0x802450
  80024d:	6a 30                	push   $0x30
  80024f:	68 3c 24 80 00       	push   $0x80243c
  800254:	e8 9d 04 00 00       	call   8006f6 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800259:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80025c:	e8 4c 1a 00 00       	call   801cad <sys_calculate_free_frames>
  800261:	29 c3                	sub    %eax,%ebx
  800263:	89 d8                	mov    %ebx,%eax
  800265:	83 f8 01             	cmp    $0x1,%eax
  800268:	74 14                	je     80027e <_main+0x246>
  80026a:	83 ec 04             	sub    $0x4,%esp
  80026d:	68 80 24 80 00       	push   $0x802480
  800272:	6a 32                	push   $0x32
  800274:	68 3c 24 80 00       	push   $0x80243c
  800279:	e8 78 04 00 00       	call   8006f6 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80027e:	e8 ad 1a 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  800283:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800286:	83 f8 01             	cmp    $0x1,%eax
  800289:	74 14                	je     80029f <_main+0x267>
  80028b:	83 ec 04             	sub    $0x4,%esp
  80028e:	68 ec 24 80 00       	push   $0x8024ec
  800293:	6a 33                	push   $0x33
  800295:	68 3c 24 80 00       	push   $0x80243c
  80029a:	e8 57 04 00 00       	call   8006f6 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80029f:	e8 09 1a 00 00       	call   801cad <sys_calculate_free_frames>
  8002a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002a7:	e8 84 1a 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  8002ac:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8002af:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002b2:	01 c0                	add    %eax,%eax
  8002b4:	83 ec 0c             	sub    $0xc,%esp
  8002b7:	50                   	push   %eax
  8002b8:	e8 7a 14 00 00       	call   801737 <malloc>
  8002bd:	83 c4 10             	add    $0x10,%esp
  8002c0:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START + 4*Mega + 4*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8002c3:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002c6:	89 c2                	mov    %eax,%edx
  8002c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002cb:	c1 e0 02             	shl    $0x2,%eax
  8002ce:	89 c1                	mov    %eax,%ecx
  8002d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002d3:	c1 e0 02             	shl    $0x2,%eax
  8002d6:	01 c8                	add    %ecx,%eax
  8002d8:	05 00 00 00 80       	add    $0x80000000,%eax
  8002dd:	39 c2                	cmp    %eax,%edx
  8002df:	72 1e                	jb     8002ff <_main+0x2c7>
  8002e1:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002e4:	89 c2                	mov    %eax,%edx
  8002e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002e9:	c1 e0 02             	shl    $0x2,%eax
  8002ec:	89 c1                	mov    %eax,%ecx
  8002ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002f1:	c1 e0 02             	shl    $0x2,%eax
  8002f4:	01 c8                	add    %ecx,%eax
  8002f6:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002fb:	39 c2                	cmp    %eax,%edx
  8002fd:	76 14                	jbe    800313 <_main+0x2db>
  8002ff:	83 ec 04             	sub    $0x4,%esp
  800302:	68 50 24 80 00       	push   $0x802450
  800307:	6a 38                	push   $0x38
  800309:	68 3c 24 80 00       	push   $0x80243c
  80030e:	e8 e3 03 00 00       	call   8006f6 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800313:	e8 95 19 00 00       	call   801cad <sys_calculate_free_frames>
  800318:	89 c2                	mov    %eax,%edx
  80031a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80031d:	39 c2                	cmp    %eax,%edx
  80031f:	74 14                	je     800335 <_main+0x2fd>
  800321:	83 ec 04             	sub    $0x4,%esp
  800324:	68 80 24 80 00       	push   $0x802480
  800329:	6a 3a                	push   $0x3a
  80032b:	68 3c 24 80 00       	push   $0x80243c
  800330:	e8 c1 03 00 00       	call   8006f6 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800335:	e8 f6 19 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  80033a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80033d:	83 f8 01             	cmp    $0x1,%eax
  800340:	74 14                	je     800356 <_main+0x31e>
  800342:	83 ec 04             	sub    $0x4,%esp
  800345:	68 ec 24 80 00       	push   $0x8024ec
  80034a:	6a 3b                	push   $0x3b
  80034c:	68 3c 24 80 00       	push   $0x80243c
  800351:	e8 a0 03 00 00       	call   8006f6 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800356:	e8 52 19 00 00       	call   801cad <sys_calculate_free_frames>
  80035b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80035e:	e8 cd 19 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  800363:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800366:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800369:	89 d0                	mov    %edx,%eax
  80036b:	01 c0                	add    %eax,%eax
  80036d:	01 d0                	add    %edx,%eax
  80036f:	01 c0                	add    %eax,%eax
  800371:	01 d0                	add    %edx,%eax
  800373:	83 ec 0c             	sub    $0xc,%esp
  800376:	50                   	push   %eax
  800377:	e8 bb 13 00 00       	call   801737 <malloc>
  80037c:	83 c4 10             	add    $0x10,%esp
  80037f:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo) || (uint32) ptr_allocations[4] > (USER_HEAP_START + 4*Mega + 8*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800382:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800385:	89 c2                	mov    %eax,%edx
  800387:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80038a:	c1 e0 02             	shl    $0x2,%eax
  80038d:	89 c1                	mov    %eax,%ecx
  80038f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800392:	c1 e0 03             	shl    $0x3,%eax
  800395:	01 c8                	add    %ecx,%eax
  800397:	05 00 00 00 80       	add    $0x80000000,%eax
  80039c:	39 c2                	cmp    %eax,%edx
  80039e:	72 1e                	jb     8003be <_main+0x386>
  8003a0:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003a3:	89 c2                	mov    %eax,%edx
  8003a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003a8:	c1 e0 02             	shl    $0x2,%eax
  8003ab:	89 c1                	mov    %eax,%ecx
  8003ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003b0:	c1 e0 03             	shl    $0x3,%eax
  8003b3:	01 c8                	add    %ecx,%eax
  8003b5:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8003ba:	39 c2                	cmp    %eax,%edx
  8003bc:	76 14                	jbe    8003d2 <_main+0x39a>
  8003be:	83 ec 04             	sub    $0x4,%esp
  8003c1:	68 50 24 80 00       	push   $0x802450
  8003c6:	6a 40                	push   $0x40
  8003c8:	68 3c 24 80 00       	push   $0x80243c
  8003cd:	e8 24 03 00 00       	call   8006f6 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8003d2:	e8 d6 18 00 00       	call   801cad <sys_calculate_free_frames>
  8003d7:	89 c2                	mov    %eax,%edx
  8003d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003dc:	39 c2                	cmp    %eax,%edx
  8003de:	74 14                	je     8003f4 <_main+0x3bc>
  8003e0:	83 ec 04             	sub    $0x4,%esp
  8003e3:	68 80 24 80 00       	push   $0x802480
  8003e8:	6a 42                	push   $0x42
  8003ea:	68 3c 24 80 00       	push   $0x80243c
  8003ef:	e8 02 03 00 00       	call   8006f6 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8003f4:	e8 37 19 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  8003f9:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8003fc:	83 f8 02             	cmp    $0x2,%eax
  8003ff:	74 14                	je     800415 <_main+0x3dd>
  800401:	83 ec 04             	sub    $0x4,%esp
  800404:	68 ec 24 80 00       	push   $0x8024ec
  800409:	6a 43                	push   $0x43
  80040b:	68 3c 24 80 00       	push   $0x80243c
  800410:	e8 e1 02 00 00       	call   8006f6 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800415:	e8 93 18 00 00       	call   801cad <sys_calculate_free_frames>
  80041a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80041d:	e8 0e 19 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  800422:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800425:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800428:	89 c2                	mov    %eax,%edx
  80042a:	01 d2                	add    %edx,%edx
  80042c:	01 d0                	add    %edx,%eax
  80042e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800431:	83 ec 0c             	sub    $0xc,%esp
  800434:	50                   	push   %eax
  800435:	e8 fd 12 00 00       	call   801737 <malloc>
  80043a:	83 c4 10             	add    $0x10,%esp
  80043d:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START + 4*Mega + 16*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800440:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800443:	89 c2                	mov    %eax,%edx
  800445:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800448:	c1 e0 02             	shl    $0x2,%eax
  80044b:	89 c1                	mov    %eax,%ecx
  80044d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800450:	c1 e0 04             	shl    $0x4,%eax
  800453:	01 c8                	add    %ecx,%eax
  800455:	05 00 00 00 80       	add    $0x80000000,%eax
  80045a:	39 c2                	cmp    %eax,%edx
  80045c:	72 1e                	jb     80047c <_main+0x444>
  80045e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800461:	89 c2                	mov    %eax,%edx
  800463:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800466:	c1 e0 02             	shl    $0x2,%eax
  800469:	89 c1                	mov    %eax,%ecx
  80046b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80046e:	c1 e0 04             	shl    $0x4,%eax
  800471:	01 c8                	add    %ecx,%eax
  800473:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800478:	39 c2                	cmp    %eax,%edx
  80047a:	76 14                	jbe    800490 <_main+0x458>
  80047c:	83 ec 04             	sub    $0x4,%esp
  80047f:	68 50 24 80 00       	push   $0x802450
  800484:	6a 48                	push   $0x48
  800486:	68 3c 24 80 00       	push   $0x80243c
  80048b:	e8 66 02 00 00       	call   8006f6 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  800490:	e8 18 18 00 00       	call   801cad <sys_calculate_free_frames>
  800495:	89 c2                	mov    %eax,%edx
  800497:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80049a:	39 c2                	cmp    %eax,%edx
  80049c:	74 14                	je     8004b2 <_main+0x47a>
  80049e:	83 ec 04             	sub    $0x4,%esp
  8004a1:	68 1a 25 80 00       	push   $0x80251a
  8004a6:	6a 49                	push   $0x49
  8004a8:	68 3c 24 80 00       	push   $0x80243c
  8004ad:	e8 44 02 00 00       	call   8006f6 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  8004b2:	e8 79 18 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  8004b7:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004ba:	89 c2                	mov    %eax,%edx
  8004bc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004bf:	89 c1                	mov    %eax,%ecx
  8004c1:	01 c9                	add    %ecx,%ecx
  8004c3:	01 c8                	add    %ecx,%eax
  8004c5:	85 c0                	test   %eax,%eax
  8004c7:	79 05                	jns    8004ce <_main+0x496>
  8004c9:	05 ff 0f 00 00       	add    $0xfff,%eax
  8004ce:	c1 f8 0c             	sar    $0xc,%eax
  8004d1:	39 c2                	cmp    %eax,%edx
  8004d3:	74 14                	je     8004e9 <_main+0x4b1>
  8004d5:	83 ec 04             	sub    $0x4,%esp
  8004d8:	68 ec 24 80 00       	push   $0x8024ec
  8004dd:	6a 4a                	push   $0x4a
  8004df:	68 3c 24 80 00       	push   $0x80243c
  8004e4:	e8 0d 02 00 00       	call   8006f6 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8004e9:	e8 bf 17 00 00       	call   801cad <sys_calculate_free_frames>
  8004ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8004f1:	e8 3a 18 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  8004f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  8004f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004fc:	01 c0                	add    %eax,%eax
  8004fe:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800501:	83 ec 0c             	sub    $0xc,%esp
  800504:	50                   	push   %eax
  800505:	e8 2d 12 00 00       	call   801737 <malloc>
  80050a:	83 c4 10             	add    $0x10,%esp
  80050d:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START + 7*Mega + 16*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800510:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800513:	89 c1                	mov    %eax,%ecx
  800515:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800518:	89 d0                	mov    %edx,%eax
  80051a:	01 c0                	add    %eax,%eax
  80051c:	01 d0                	add    %edx,%eax
  80051e:	01 c0                	add    %eax,%eax
  800520:	01 d0                	add    %edx,%eax
  800522:	89 c2                	mov    %eax,%edx
  800524:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800527:	c1 e0 04             	shl    $0x4,%eax
  80052a:	01 d0                	add    %edx,%eax
  80052c:	05 00 00 00 80       	add    $0x80000000,%eax
  800531:	39 c1                	cmp    %eax,%ecx
  800533:	72 25                	jb     80055a <_main+0x522>
  800535:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800538:	89 c1                	mov    %eax,%ecx
  80053a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80053d:	89 d0                	mov    %edx,%eax
  80053f:	01 c0                	add    %eax,%eax
  800541:	01 d0                	add    %edx,%eax
  800543:	01 c0                	add    %eax,%eax
  800545:	01 d0                	add    %edx,%eax
  800547:	89 c2                	mov    %eax,%edx
  800549:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80054c:	c1 e0 04             	shl    $0x4,%eax
  80054f:	01 d0                	add    %edx,%eax
  800551:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800556:	39 c1                	cmp    %eax,%ecx
  800558:	76 14                	jbe    80056e <_main+0x536>
  80055a:	83 ec 04             	sub    $0x4,%esp
  80055d:	68 50 24 80 00       	push   $0x802450
  800562:	6a 4f                	push   $0x4f
  800564:	68 3c 24 80 00       	push   $0x80243c
  800569:	e8 88 01 00 00       	call   8006f6 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  80056e:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800571:	e8 37 17 00 00       	call   801cad <sys_calculate_free_frames>
  800576:	29 c3                	sub    %eax,%ebx
  800578:	89 d8                	mov    %ebx,%eax
  80057a:	83 f8 01             	cmp    $0x1,%eax
  80057d:	74 14                	je     800593 <_main+0x55b>
  80057f:	83 ec 04             	sub    $0x4,%esp
  800582:	68 1a 25 80 00       	push   $0x80251a
  800587:	6a 50                	push   $0x50
  800589:	68 3c 24 80 00       	push   $0x80243c
  80058e:	e8 63 01 00 00       	call   8006f6 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800593:	e8 98 17 00 00       	call   801d30 <sys_pf_calculate_allocated_pages>
  800598:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80059b:	3d 00 02 00 00       	cmp    $0x200,%eax
  8005a0:	74 14                	je     8005b6 <_main+0x57e>
  8005a2:	83 ec 04             	sub    $0x4,%esp
  8005a5:	68 ec 24 80 00       	push   $0x8024ec
  8005aa:	6a 51                	push   $0x51
  8005ac:	68 3c 24 80 00       	push   $0x80243c
  8005b1:	e8 40 01 00 00       	call   8006f6 <_panic>
	}

	cprintf("Congratulations!! test malloc (1) completed successfully.\n");
  8005b6:	83 ec 0c             	sub    $0xc,%esp
  8005b9:	68 30 25 80 00       	push   $0x802530
  8005be:	e8 ea 03 00 00       	call   8009ad <cprintf>
  8005c3:	83 c4 10             	add    $0x10,%esp

	return;
  8005c6:	90                   	nop
}
  8005c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8005ca:	5b                   	pop    %ebx
  8005cb:	5f                   	pop    %edi
  8005cc:	5d                   	pop    %ebp
  8005cd:	c3                   	ret    

008005ce <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005ce:	55                   	push   %ebp
  8005cf:	89 e5                	mov    %esp,%ebp
  8005d1:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005d4:	e8 09 16 00 00       	call   801be2 <sys_getenvindex>
  8005d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005df:	89 d0                	mov    %edx,%eax
  8005e1:	01 c0                	add    %eax,%eax
  8005e3:	01 d0                	add    %edx,%eax
  8005e5:	c1 e0 07             	shl    $0x7,%eax
  8005e8:	29 d0                	sub    %edx,%eax
  8005ea:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005f1:	01 c8                	add    %ecx,%eax
  8005f3:	01 c0                	add    %eax,%eax
  8005f5:	01 d0                	add    %edx,%eax
  8005f7:	01 c0                	add    %eax,%eax
  8005f9:	01 d0                	add    %edx,%eax
  8005fb:	c1 e0 03             	shl    $0x3,%eax
  8005fe:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800603:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800608:	a1 20 30 80 00       	mov    0x803020,%eax
  80060d:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800613:	84 c0                	test   %al,%al
  800615:	74 0f                	je     800626 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800617:	a1 20 30 80 00       	mov    0x803020,%eax
  80061c:	05 f0 ee 00 00       	add    $0xeef0,%eax
  800621:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800626:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80062a:	7e 0a                	jle    800636 <libmain+0x68>
		binaryname = argv[0];
  80062c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80062f:	8b 00                	mov    (%eax),%eax
  800631:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800636:	83 ec 08             	sub    $0x8,%esp
  800639:	ff 75 0c             	pushl  0xc(%ebp)
  80063c:	ff 75 08             	pushl  0x8(%ebp)
  80063f:	e8 f4 f9 ff ff       	call   800038 <_main>
  800644:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800647:	e8 31 17 00 00       	call   801d7d <sys_disable_interrupt>
	cprintf("**************************************\n");
  80064c:	83 ec 0c             	sub    $0xc,%esp
  80064f:	68 84 25 80 00       	push   $0x802584
  800654:	e8 54 03 00 00       	call   8009ad <cprintf>
  800659:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80065c:	a1 20 30 80 00       	mov    0x803020,%eax
  800661:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800667:	a1 20 30 80 00       	mov    0x803020,%eax
  80066c:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  800672:	83 ec 04             	sub    $0x4,%esp
  800675:	52                   	push   %edx
  800676:	50                   	push   %eax
  800677:	68 ac 25 80 00       	push   $0x8025ac
  80067c:	e8 2c 03 00 00       	call   8009ad <cprintf>
  800681:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800684:	a1 20 30 80 00       	mov    0x803020,%eax
  800689:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  80068f:	a1 20 30 80 00       	mov    0x803020,%eax
  800694:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  80069a:	a1 20 30 80 00       	mov    0x803020,%eax
  80069f:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  8006a5:	51                   	push   %ecx
  8006a6:	52                   	push   %edx
  8006a7:	50                   	push   %eax
  8006a8:	68 d4 25 80 00       	push   $0x8025d4
  8006ad:	e8 fb 02 00 00       	call   8009ad <cprintf>
  8006b2:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006b5:	83 ec 0c             	sub    $0xc,%esp
  8006b8:	68 84 25 80 00       	push   $0x802584
  8006bd:	e8 eb 02 00 00       	call   8009ad <cprintf>
  8006c2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006c5:	e8 cd 16 00 00       	call   801d97 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006ca:	e8 19 00 00 00       	call   8006e8 <exit>
}
  8006cf:	90                   	nop
  8006d0:	c9                   	leave  
  8006d1:	c3                   	ret    

008006d2 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006d2:	55                   	push   %ebp
  8006d3:	89 e5                	mov    %esp,%ebp
  8006d5:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006d8:	83 ec 0c             	sub    $0xc,%esp
  8006db:	6a 00                	push   $0x0
  8006dd:	e8 cc 14 00 00       	call   801bae <sys_env_destroy>
  8006e2:	83 c4 10             	add    $0x10,%esp
}
  8006e5:	90                   	nop
  8006e6:	c9                   	leave  
  8006e7:	c3                   	ret    

008006e8 <exit>:

void
exit(void)
{
  8006e8:	55                   	push   %ebp
  8006e9:	89 e5                	mov    %esp,%ebp
  8006eb:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006ee:	e8 21 15 00 00       	call   801c14 <sys_env_exit>
}
  8006f3:	90                   	nop
  8006f4:	c9                   	leave  
  8006f5:	c3                   	ret    

008006f6 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006f6:	55                   	push   %ebp
  8006f7:	89 e5                	mov    %esp,%ebp
  8006f9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006fc:	8d 45 10             	lea    0x10(%ebp),%eax
  8006ff:	83 c0 04             	add    $0x4,%eax
  800702:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800705:	a1 18 31 80 00       	mov    0x803118,%eax
  80070a:	85 c0                	test   %eax,%eax
  80070c:	74 16                	je     800724 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80070e:	a1 18 31 80 00       	mov    0x803118,%eax
  800713:	83 ec 08             	sub    $0x8,%esp
  800716:	50                   	push   %eax
  800717:	68 2c 26 80 00       	push   $0x80262c
  80071c:	e8 8c 02 00 00       	call   8009ad <cprintf>
  800721:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800724:	a1 00 30 80 00       	mov    0x803000,%eax
  800729:	ff 75 0c             	pushl  0xc(%ebp)
  80072c:	ff 75 08             	pushl  0x8(%ebp)
  80072f:	50                   	push   %eax
  800730:	68 31 26 80 00       	push   $0x802631
  800735:	e8 73 02 00 00       	call   8009ad <cprintf>
  80073a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80073d:	8b 45 10             	mov    0x10(%ebp),%eax
  800740:	83 ec 08             	sub    $0x8,%esp
  800743:	ff 75 f4             	pushl  -0xc(%ebp)
  800746:	50                   	push   %eax
  800747:	e8 f6 01 00 00       	call   800942 <vcprintf>
  80074c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80074f:	83 ec 08             	sub    $0x8,%esp
  800752:	6a 00                	push   $0x0
  800754:	68 4d 26 80 00       	push   $0x80264d
  800759:	e8 e4 01 00 00       	call   800942 <vcprintf>
  80075e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800761:	e8 82 ff ff ff       	call   8006e8 <exit>

	// should not return here
	while (1) ;
  800766:	eb fe                	jmp    800766 <_panic+0x70>

00800768 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800768:	55                   	push   %ebp
  800769:	89 e5                	mov    %esp,%ebp
  80076b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80076e:	a1 20 30 80 00       	mov    0x803020,%eax
  800773:	8b 50 74             	mov    0x74(%eax),%edx
  800776:	8b 45 0c             	mov    0xc(%ebp),%eax
  800779:	39 c2                	cmp    %eax,%edx
  80077b:	74 14                	je     800791 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80077d:	83 ec 04             	sub    $0x4,%esp
  800780:	68 50 26 80 00       	push   $0x802650
  800785:	6a 26                	push   $0x26
  800787:	68 9c 26 80 00       	push   $0x80269c
  80078c:	e8 65 ff ff ff       	call   8006f6 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800791:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800798:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80079f:	e9 c4 00 00 00       	jmp    800868 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8007a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b1:	01 d0                	add    %edx,%eax
  8007b3:	8b 00                	mov    (%eax),%eax
  8007b5:	85 c0                	test   %eax,%eax
  8007b7:	75 08                	jne    8007c1 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007b9:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007bc:	e9 a4 00 00 00       	jmp    800865 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8007c1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007c8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007cf:	eb 6b                	jmp    80083c <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8007d6:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8007dc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007df:	89 d0                	mov    %edx,%eax
  8007e1:	c1 e0 02             	shl    $0x2,%eax
  8007e4:	01 d0                	add    %edx,%eax
  8007e6:	c1 e0 02             	shl    $0x2,%eax
  8007e9:	01 c8                	add    %ecx,%eax
  8007eb:	8a 40 04             	mov    0x4(%eax),%al
  8007ee:	84 c0                	test   %al,%al
  8007f0:	75 47                	jne    800839 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007f2:	a1 20 30 80 00       	mov    0x803020,%eax
  8007f7:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8007fd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800800:	89 d0                	mov    %edx,%eax
  800802:	c1 e0 02             	shl    $0x2,%eax
  800805:	01 d0                	add    %edx,%eax
  800807:	c1 e0 02             	shl    $0x2,%eax
  80080a:	01 c8                	add    %ecx,%eax
  80080c:	8b 00                	mov    (%eax),%eax
  80080e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800811:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800814:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800819:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80081b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80081e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	01 c8                	add    %ecx,%eax
  80082a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80082c:	39 c2                	cmp    %eax,%edx
  80082e:	75 09                	jne    800839 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800830:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800837:	eb 12                	jmp    80084b <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800839:	ff 45 e8             	incl   -0x18(%ebp)
  80083c:	a1 20 30 80 00       	mov    0x803020,%eax
  800841:	8b 50 74             	mov    0x74(%eax),%edx
  800844:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800847:	39 c2                	cmp    %eax,%edx
  800849:	77 86                	ja     8007d1 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80084b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80084f:	75 14                	jne    800865 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800851:	83 ec 04             	sub    $0x4,%esp
  800854:	68 a8 26 80 00       	push   $0x8026a8
  800859:	6a 3a                	push   $0x3a
  80085b:	68 9c 26 80 00       	push   $0x80269c
  800860:	e8 91 fe ff ff       	call   8006f6 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800865:	ff 45 f0             	incl   -0x10(%ebp)
  800868:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80086e:	0f 8c 30 ff ff ff    	jl     8007a4 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800874:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80087b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800882:	eb 27                	jmp    8008ab <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800884:	a1 20 30 80 00       	mov    0x803020,%eax
  800889:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80088f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800892:	89 d0                	mov    %edx,%eax
  800894:	c1 e0 02             	shl    $0x2,%eax
  800897:	01 d0                	add    %edx,%eax
  800899:	c1 e0 02             	shl    $0x2,%eax
  80089c:	01 c8                	add    %ecx,%eax
  80089e:	8a 40 04             	mov    0x4(%eax),%al
  8008a1:	3c 01                	cmp    $0x1,%al
  8008a3:	75 03                	jne    8008a8 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8008a5:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008a8:	ff 45 e0             	incl   -0x20(%ebp)
  8008ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8008b0:	8b 50 74             	mov    0x74(%eax),%edx
  8008b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008b6:	39 c2                	cmp    %eax,%edx
  8008b8:	77 ca                	ja     800884 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008bd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008c0:	74 14                	je     8008d6 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8008c2:	83 ec 04             	sub    $0x4,%esp
  8008c5:	68 fc 26 80 00       	push   $0x8026fc
  8008ca:	6a 44                	push   $0x44
  8008cc:	68 9c 26 80 00       	push   $0x80269c
  8008d1:	e8 20 fe ff ff       	call   8006f6 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008d6:	90                   	nop
  8008d7:	c9                   	leave  
  8008d8:	c3                   	ret    

008008d9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008d9:	55                   	push   %ebp
  8008da:	89 e5                	mov    %esp,%ebp
  8008dc:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e2:	8b 00                	mov    (%eax),%eax
  8008e4:	8d 48 01             	lea    0x1(%eax),%ecx
  8008e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ea:	89 0a                	mov    %ecx,(%edx)
  8008ec:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ef:	88 d1                	mov    %dl,%cl
  8008f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fb:	8b 00                	mov    (%eax),%eax
  8008fd:	3d ff 00 00 00       	cmp    $0xff,%eax
  800902:	75 2c                	jne    800930 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800904:	a0 24 30 80 00       	mov    0x803024,%al
  800909:	0f b6 c0             	movzbl %al,%eax
  80090c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80090f:	8b 12                	mov    (%edx),%edx
  800911:	89 d1                	mov    %edx,%ecx
  800913:	8b 55 0c             	mov    0xc(%ebp),%edx
  800916:	83 c2 08             	add    $0x8,%edx
  800919:	83 ec 04             	sub    $0x4,%esp
  80091c:	50                   	push   %eax
  80091d:	51                   	push   %ecx
  80091e:	52                   	push   %edx
  80091f:	e8 48 12 00 00       	call   801b6c <sys_cputs>
  800924:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800927:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800930:	8b 45 0c             	mov    0xc(%ebp),%eax
  800933:	8b 40 04             	mov    0x4(%eax),%eax
  800936:	8d 50 01             	lea    0x1(%eax),%edx
  800939:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80093f:	90                   	nop
  800940:	c9                   	leave  
  800941:	c3                   	ret    

00800942 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800942:	55                   	push   %ebp
  800943:	89 e5                	mov    %esp,%ebp
  800945:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80094b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800952:	00 00 00 
	b.cnt = 0;
  800955:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80095c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80095f:	ff 75 0c             	pushl  0xc(%ebp)
  800962:	ff 75 08             	pushl  0x8(%ebp)
  800965:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80096b:	50                   	push   %eax
  80096c:	68 d9 08 80 00       	push   $0x8008d9
  800971:	e8 11 02 00 00       	call   800b87 <vprintfmt>
  800976:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800979:	a0 24 30 80 00       	mov    0x803024,%al
  80097e:	0f b6 c0             	movzbl %al,%eax
  800981:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800987:	83 ec 04             	sub    $0x4,%esp
  80098a:	50                   	push   %eax
  80098b:	52                   	push   %edx
  80098c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800992:	83 c0 08             	add    $0x8,%eax
  800995:	50                   	push   %eax
  800996:	e8 d1 11 00 00       	call   801b6c <sys_cputs>
  80099b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80099e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009a5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009ab:	c9                   	leave  
  8009ac:	c3                   	ret    

008009ad <cprintf>:

int cprintf(const char *fmt, ...) {
  8009ad:	55                   	push   %ebp
  8009ae:	89 e5                	mov    %esp,%ebp
  8009b0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009b3:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009ba:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c3:	83 ec 08             	sub    $0x8,%esp
  8009c6:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c9:	50                   	push   %eax
  8009ca:	e8 73 ff ff ff       	call   800942 <vcprintf>
  8009cf:	83 c4 10             	add    $0x10,%esp
  8009d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009d8:	c9                   	leave  
  8009d9:	c3                   	ret    

008009da <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009da:	55                   	push   %ebp
  8009db:	89 e5                	mov    %esp,%ebp
  8009dd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009e0:	e8 98 13 00 00       	call   801d7d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009e5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ee:	83 ec 08             	sub    $0x8,%esp
  8009f1:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f4:	50                   	push   %eax
  8009f5:	e8 48 ff ff ff       	call   800942 <vcprintf>
  8009fa:	83 c4 10             	add    $0x10,%esp
  8009fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a00:	e8 92 13 00 00       	call   801d97 <sys_enable_interrupt>
	return cnt;
  800a05:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a08:	c9                   	leave  
  800a09:	c3                   	ret    

00800a0a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a0a:	55                   	push   %ebp
  800a0b:	89 e5                	mov    %esp,%ebp
  800a0d:	53                   	push   %ebx
  800a0e:	83 ec 14             	sub    $0x14,%esp
  800a11:	8b 45 10             	mov    0x10(%ebp),%eax
  800a14:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a17:	8b 45 14             	mov    0x14(%ebp),%eax
  800a1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a1d:	8b 45 18             	mov    0x18(%ebp),%eax
  800a20:	ba 00 00 00 00       	mov    $0x0,%edx
  800a25:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a28:	77 55                	ja     800a7f <printnum+0x75>
  800a2a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a2d:	72 05                	jb     800a34 <printnum+0x2a>
  800a2f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a32:	77 4b                	ja     800a7f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a34:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a37:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a3a:	8b 45 18             	mov    0x18(%ebp),%eax
  800a3d:	ba 00 00 00 00       	mov    $0x0,%edx
  800a42:	52                   	push   %edx
  800a43:	50                   	push   %eax
  800a44:	ff 75 f4             	pushl  -0xc(%ebp)
  800a47:	ff 75 f0             	pushl  -0x10(%ebp)
  800a4a:	e8 6d 17 00 00       	call   8021bc <__udivdi3>
  800a4f:	83 c4 10             	add    $0x10,%esp
  800a52:	83 ec 04             	sub    $0x4,%esp
  800a55:	ff 75 20             	pushl  0x20(%ebp)
  800a58:	53                   	push   %ebx
  800a59:	ff 75 18             	pushl  0x18(%ebp)
  800a5c:	52                   	push   %edx
  800a5d:	50                   	push   %eax
  800a5e:	ff 75 0c             	pushl  0xc(%ebp)
  800a61:	ff 75 08             	pushl  0x8(%ebp)
  800a64:	e8 a1 ff ff ff       	call   800a0a <printnum>
  800a69:	83 c4 20             	add    $0x20,%esp
  800a6c:	eb 1a                	jmp    800a88 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a6e:	83 ec 08             	sub    $0x8,%esp
  800a71:	ff 75 0c             	pushl  0xc(%ebp)
  800a74:	ff 75 20             	pushl  0x20(%ebp)
  800a77:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7a:	ff d0                	call   *%eax
  800a7c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a7f:	ff 4d 1c             	decl   0x1c(%ebp)
  800a82:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a86:	7f e6                	jg     800a6e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a88:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a8b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a90:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a93:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a96:	53                   	push   %ebx
  800a97:	51                   	push   %ecx
  800a98:	52                   	push   %edx
  800a99:	50                   	push   %eax
  800a9a:	e8 2d 18 00 00       	call   8022cc <__umoddi3>
  800a9f:	83 c4 10             	add    $0x10,%esp
  800aa2:	05 74 29 80 00       	add    $0x802974,%eax
  800aa7:	8a 00                	mov    (%eax),%al
  800aa9:	0f be c0             	movsbl %al,%eax
  800aac:	83 ec 08             	sub    $0x8,%esp
  800aaf:	ff 75 0c             	pushl  0xc(%ebp)
  800ab2:	50                   	push   %eax
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	ff d0                	call   *%eax
  800ab8:	83 c4 10             	add    $0x10,%esp
}
  800abb:	90                   	nop
  800abc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800abf:	c9                   	leave  
  800ac0:	c3                   	ret    

00800ac1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ac1:	55                   	push   %ebp
  800ac2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ac4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ac8:	7e 1c                	jle    800ae6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	8b 00                	mov    (%eax),%eax
  800acf:	8d 50 08             	lea    0x8(%eax),%edx
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	89 10                	mov    %edx,(%eax)
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	8b 00                	mov    (%eax),%eax
  800adc:	83 e8 08             	sub    $0x8,%eax
  800adf:	8b 50 04             	mov    0x4(%eax),%edx
  800ae2:	8b 00                	mov    (%eax),%eax
  800ae4:	eb 40                	jmp    800b26 <getuint+0x65>
	else if (lflag)
  800ae6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aea:	74 1e                	je     800b0a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800aec:	8b 45 08             	mov    0x8(%ebp),%eax
  800aef:	8b 00                	mov    (%eax),%eax
  800af1:	8d 50 04             	lea    0x4(%eax),%edx
  800af4:	8b 45 08             	mov    0x8(%ebp),%eax
  800af7:	89 10                	mov    %edx,(%eax)
  800af9:	8b 45 08             	mov    0x8(%ebp),%eax
  800afc:	8b 00                	mov    (%eax),%eax
  800afe:	83 e8 04             	sub    $0x4,%eax
  800b01:	8b 00                	mov    (%eax),%eax
  800b03:	ba 00 00 00 00       	mov    $0x0,%edx
  800b08:	eb 1c                	jmp    800b26 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	8b 00                	mov    (%eax),%eax
  800b0f:	8d 50 04             	lea    0x4(%eax),%edx
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	89 10                	mov    %edx,(%eax)
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1a:	8b 00                	mov    (%eax),%eax
  800b1c:	83 e8 04             	sub    $0x4,%eax
  800b1f:	8b 00                	mov    (%eax),%eax
  800b21:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b26:	5d                   	pop    %ebp
  800b27:	c3                   	ret    

00800b28 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b28:	55                   	push   %ebp
  800b29:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b2b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b2f:	7e 1c                	jle    800b4d <getint+0x25>
		return va_arg(*ap, long long);
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	8d 50 08             	lea    0x8(%eax),%edx
  800b39:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3c:	89 10                	mov    %edx,(%eax)
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	8b 00                	mov    (%eax),%eax
  800b43:	83 e8 08             	sub    $0x8,%eax
  800b46:	8b 50 04             	mov    0x4(%eax),%edx
  800b49:	8b 00                	mov    (%eax),%eax
  800b4b:	eb 38                	jmp    800b85 <getint+0x5d>
	else if (lflag)
  800b4d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b51:	74 1a                	je     800b6d <getint+0x45>
		return va_arg(*ap, long);
  800b53:	8b 45 08             	mov    0x8(%ebp),%eax
  800b56:	8b 00                	mov    (%eax),%eax
  800b58:	8d 50 04             	lea    0x4(%eax),%edx
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	89 10                	mov    %edx,(%eax)
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	8b 00                	mov    (%eax),%eax
  800b65:	83 e8 04             	sub    $0x4,%eax
  800b68:	8b 00                	mov    (%eax),%eax
  800b6a:	99                   	cltd   
  800b6b:	eb 18                	jmp    800b85 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	8b 00                	mov    (%eax),%eax
  800b72:	8d 50 04             	lea    0x4(%eax),%edx
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	89 10                	mov    %edx,(%eax)
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	8b 00                	mov    (%eax),%eax
  800b7f:	83 e8 04             	sub    $0x4,%eax
  800b82:	8b 00                	mov    (%eax),%eax
  800b84:	99                   	cltd   
}
  800b85:	5d                   	pop    %ebp
  800b86:	c3                   	ret    

00800b87 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b87:	55                   	push   %ebp
  800b88:	89 e5                	mov    %esp,%ebp
  800b8a:	56                   	push   %esi
  800b8b:	53                   	push   %ebx
  800b8c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b8f:	eb 17                	jmp    800ba8 <vprintfmt+0x21>
			if (ch == '\0')
  800b91:	85 db                	test   %ebx,%ebx
  800b93:	0f 84 af 03 00 00    	je     800f48 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b99:	83 ec 08             	sub    $0x8,%esp
  800b9c:	ff 75 0c             	pushl  0xc(%ebp)
  800b9f:	53                   	push   %ebx
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	ff d0                	call   *%eax
  800ba5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ba8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bab:	8d 50 01             	lea    0x1(%eax),%edx
  800bae:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb1:	8a 00                	mov    (%eax),%al
  800bb3:	0f b6 d8             	movzbl %al,%ebx
  800bb6:	83 fb 25             	cmp    $0x25,%ebx
  800bb9:	75 d6                	jne    800b91 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bbb:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bbf:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bc6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bcd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bd4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bdb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bde:	8d 50 01             	lea    0x1(%eax),%edx
  800be1:	89 55 10             	mov    %edx,0x10(%ebp)
  800be4:	8a 00                	mov    (%eax),%al
  800be6:	0f b6 d8             	movzbl %al,%ebx
  800be9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bec:	83 f8 55             	cmp    $0x55,%eax
  800bef:	0f 87 2b 03 00 00    	ja     800f20 <vprintfmt+0x399>
  800bf5:	8b 04 85 98 29 80 00 	mov    0x802998(,%eax,4),%eax
  800bfc:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bfe:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c02:	eb d7                	jmp    800bdb <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c04:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c08:	eb d1                	jmp    800bdb <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c0a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c11:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c14:	89 d0                	mov    %edx,%eax
  800c16:	c1 e0 02             	shl    $0x2,%eax
  800c19:	01 d0                	add    %edx,%eax
  800c1b:	01 c0                	add    %eax,%eax
  800c1d:	01 d8                	add    %ebx,%eax
  800c1f:	83 e8 30             	sub    $0x30,%eax
  800c22:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c25:	8b 45 10             	mov    0x10(%ebp),%eax
  800c28:	8a 00                	mov    (%eax),%al
  800c2a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c2d:	83 fb 2f             	cmp    $0x2f,%ebx
  800c30:	7e 3e                	jle    800c70 <vprintfmt+0xe9>
  800c32:	83 fb 39             	cmp    $0x39,%ebx
  800c35:	7f 39                	jg     800c70 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c37:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c3a:	eb d5                	jmp    800c11 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c3f:	83 c0 04             	add    $0x4,%eax
  800c42:	89 45 14             	mov    %eax,0x14(%ebp)
  800c45:	8b 45 14             	mov    0x14(%ebp),%eax
  800c48:	83 e8 04             	sub    $0x4,%eax
  800c4b:	8b 00                	mov    (%eax),%eax
  800c4d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c50:	eb 1f                	jmp    800c71 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c52:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c56:	79 83                	jns    800bdb <vprintfmt+0x54>
				width = 0;
  800c58:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c5f:	e9 77 ff ff ff       	jmp    800bdb <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c64:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c6b:	e9 6b ff ff ff       	jmp    800bdb <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c70:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c71:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c75:	0f 89 60 ff ff ff    	jns    800bdb <vprintfmt+0x54>
				width = precision, precision = -1;
  800c7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c7e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c81:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c88:	e9 4e ff ff ff       	jmp    800bdb <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c8d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c90:	e9 46 ff ff ff       	jmp    800bdb <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c95:	8b 45 14             	mov    0x14(%ebp),%eax
  800c98:	83 c0 04             	add    $0x4,%eax
  800c9b:	89 45 14             	mov    %eax,0x14(%ebp)
  800c9e:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca1:	83 e8 04             	sub    $0x4,%eax
  800ca4:	8b 00                	mov    (%eax),%eax
  800ca6:	83 ec 08             	sub    $0x8,%esp
  800ca9:	ff 75 0c             	pushl  0xc(%ebp)
  800cac:	50                   	push   %eax
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	ff d0                	call   *%eax
  800cb2:	83 c4 10             	add    $0x10,%esp
			break;
  800cb5:	e9 89 02 00 00       	jmp    800f43 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cba:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbd:	83 c0 04             	add    $0x4,%eax
  800cc0:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc6:	83 e8 04             	sub    $0x4,%eax
  800cc9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ccb:	85 db                	test   %ebx,%ebx
  800ccd:	79 02                	jns    800cd1 <vprintfmt+0x14a>
				err = -err;
  800ccf:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cd1:	83 fb 64             	cmp    $0x64,%ebx
  800cd4:	7f 0b                	jg     800ce1 <vprintfmt+0x15a>
  800cd6:	8b 34 9d e0 27 80 00 	mov    0x8027e0(,%ebx,4),%esi
  800cdd:	85 f6                	test   %esi,%esi
  800cdf:	75 19                	jne    800cfa <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ce1:	53                   	push   %ebx
  800ce2:	68 85 29 80 00       	push   $0x802985
  800ce7:	ff 75 0c             	pushl  0xc(%ebp)
  800cea:	ff 75 08             	pushl  0x8(%ebp)
  800ced:	e8 5e 02 00 00       	call   800f50 <printfmt>
  800cf2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cf5:	e9 49 02 00 00       	jmp    800f43 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cfa:	56                   	push   %esi
  800cfb:	68 8e 29 80 00       	push   $0x80298e
  800d00:	ff 75 0c             	pushl  0xc(%ebp)
  800d03:	ff 75 08             	pushl  0x8(%ebp)
  800d06:	e8 45 02 00 00       	call   800f50 <printfmt>
  800d0b:	83 c4 10             	add    $0x10,%esp
			break;
  800d0e:	e9 30 02 00 00       	jmp    800f43 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d13:	8b 45 14             	mov    0x14(%ebp),%eax
  800d16:	83 c0 04             	add    $0x4,%eax
  800d19:	89 45 14             	mov    %eax,0x14(%ebp)
  800d1c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1f:	83 e8 04             	sub    $0x4,%eax
  800d22:	8b 30                	mov    (%eax),%esi
  800d24:	85 f6                	test   %esi,%esi
  800d26:	75 05                	jne    800d2d <vprintfmt+0x1a6>
				p = "(null)";
  800d28:	be 91 29 80 00       	mov    $0x802991,%esi
			if (width > 0 && padc != '-')
  800d2d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d31:	7e 6d                	jle    800da0 <vprintfmt+0x219>
  800d33:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d37:	74 67                	je     800da0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d39:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d3c:	83 ec 08             	sub    $0x8,%esp
  800d3f:	50                   	push   %eax
  800d40:	56                   	push   %esi
  800d41:	e8 0c 03 00 00       	call   801052 <strnlen>
  800d46:	83 c4 10             	add    $0x10,%esp
  800d49:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d4c:	eb 16                	jmp    800d64 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d4e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d52:	83 ec 08             	sub    $0x8,%esp
  800d55:	ff 75 0c             	pushl  0xc(%ebp)
  800d58:	50                   	push   %eax
  800d59:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5c:	ff d0                	call   *%eax
  800d5e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d61:	ff 4d e4             	decl   -0x1c(%ebp)
  800d64:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d68:	7f e4                	jg     800d4e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d6a:	eb 34                	jmp    800da0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d6c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d70:	74 1c                	je     800d8e <vprintfmt+0x207>
  800d72:	83 fb 1f             	cmp    $0x1f,%ebx
  800d75:	7e 05                	jle    800d7c <vprintfmt+0x1f5>
  800d77:	83 fb 7e             	cmp    $0x7e,%ebx
  800d7a:	7e 12                	jle    800d8e <vprintfmt+0x207>
					putch('?', putdat);
  800d7c:	83 ec 08             	sub    $0x8,%esp
  800d7f:	ff 75 0c             	pushl  0xc(%ebp)
  800d82:	6a 3f                	push   $0x3f
  800d84:	8b 45 08             	mov    0x8(%ebp),%eax
  800d87:	ff d0                	call   *%eax
  800d89:	83 c4 10             	add    $0x10,%esp
  800d8c:	eb 0f                	jmp    800d9d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d8e:	83 ec 08             	sub    $0x8,%esp
  800d91:	ff 75 0c             	pushl  0xc(%ebp)
  800d94:	53                   	push   %ebx
  800d95:	8b 45 08             	mov    0x8(%ebp),%eax
  800d98:	ff d0                	call   *%eax
  800d9a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d9d:	ff 4d e4             	decl   -0x1c(%ebp)
  800da0:	89 f0                	mov    %esi,%eax
  800da2:	8d 70 01             	lea    0x1(%eax),%esi
  800da5:	8a 00                	mov    (%eax),%al
  800da7:	0f be d8             	movsbl %al,%ebx
  800daa:	85 db                	test   %ebx,%ebx
  800dac:	74 24                	je     800dd2 <vprintfmt+0x24b>
  800dae:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800db2:	78 b8                	js     800d6c <vprintfmt+0x1e5>
  800db4:	ff 4d e0             	decl   -0x20(%ebp)
  800db7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dbb:	79 af                	jns    800d6c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dbd:	eb 13                	jmp    800dd2 <vprintfmt+0x24b>
				putch(' ', putdat);
  800dbf:	83 ec 08             	sub    $0x8,%esp
  800dc2:	ff 75 0c             	pushl  0xc(%ebp)
  800dc5:	6a 20                	push   $0x20
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	ff d0                	call   *%eax
  800dcc:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dcf:	ff 4d e4             	decl   -0x1c(%ebp)
  800dd2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dd6:	7f e7                	jg     800dbf <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dd8:	e9 66 01 00 00       	jmp    800f43 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ddd:	83 ec 08             	sub    $0x8,%esp
  800de0:	ff 75 e8             	pushl  -0x18(%ebp)
  800de3:	8d 45 14             	lea    0x14(%ebp),%eax
  800de6:	50                   	push   %eax
  800de7:	e8 3c fd ff ff       	call   800b28 <getint>
  800dec:	83 c4 10             	add    $0x10,%esp
  800def:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800df2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800df5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800df8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dfb:	85 d2                	test   %edx,%edx
  800dfd:	79 23                	jns    800e22 <vprintfmt+0x29b>
				putch('-', putdat);
  800dff:	83 ec 08             	sub    $0x8,%esp
  800e02:	ff 75 0c             	pushl  0xc(%ebp)
  800e05:	6a 2d                	push   $0x2d
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	ff d0                	call   *%eax
  800e0c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e12:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e15:	f7 d8                	neg    %eax
  800e17:	83 d2 00             	adc    $0x0,%edx
  800e1a:	f7 da                	neg    %edx
  800e1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e1f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e22:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e29:	e9 bc 00 00 00       	jmp    800eea <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e2e:	83 ec 08             	sub    $0x8,%esp
  800e31:	ff 75 e8             	pushl  -0x18(%ebp)
  800e34:	8d 45 14             	lea    0x14(%ebp),%eax
  800e37:	50                   	push   %eax
  800e38:	e8 84 fc ff ff       	call   800ac1 <getuint>
  800e3d:	83 c4 10             	add    $0x10,%esp
  800e40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e43:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e46:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e4d:	e9 98 00 00 00       	jmp    800eea <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e52:	83 ec 08             	sub    $0x8,%esp
  800e55:	ff 75 0c             	pushl  0xc(%ebp)
  800e58:	6a 58                	push   $0x58
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	ff d0                	call   *%eax
  800e5f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e62:	83 ec 08             	sub    $0x8,%esp
  800e65:	ff 75 0c             	pushl  0xc(%ebp)
  800e68:	6a 58                	push   $0x58
  800e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6d:	ff d0                	call   *%eax
  800e6f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e72:	83 ec 08             	sub    $0x8,%esp
  800e75:	ff 75 0c             	pushl  0xc(%ebp)
  800e78:	6a 58                	push   $0x58
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	ff d0                	call   *%eax
  800e7f:	83 c4 10             	add    $0x10,%esp
			break;
  800e82:	e9 bc 00 00 00       	jmp    800f43 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e87:	83 ec 08             	sub    $0x8,%esp
  800e8a:	ff 75 0c             	pushl  0xc(%ebp)
  800e8d:	6a 30                	push   $0x30
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	ff d0                	call   *%eax
  800e94:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e97:	83 ec 08             	sub    $0x8,%esp
  800e9a:	ff 75 0c             	pushl  0xc(%ebp)
  800e9d:	6a 78                	push   $0x78
  800e9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea2:	ff d0                	call   *%eax
  800ea4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ea7:	8b 45 14             	mov    0x14(%ebp),%eax
  800eaa:	83 c0 04             	add    $0x4,%eax
  800ead:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb0:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb3:	83 e8 04             	sub    $0x4,%eax
  800eb6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800eb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ebb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ec2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ec9:	eb 1f                	jmp    800eea <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ecb:	83 ec 08             	sub    $0x8,%esp
  800ece:	ff 75 e8             	pushl  -0x18(%ebp)
  800ed1:	8d 45 14             	lea    0x14(%ebp),%eax
  800ed4:	50                   	push   %eax
  800ed5:	e8 e7 fb ff ff       	call   800ac1 <getuint>
  800eda:	83 c4 10             	add    $0x10,%esp
  800edd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ee3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eea:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800eee:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ef1:	83 ec 04             	sub    $0x4,%esp
  800ef4:	52                   	push   %edx
  800ef5:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ef8:	50                   	push   %eax
  800ef9:	ff 75 f4             	pushl  -0xc(%ebp)
  800efc:	ff 75 f0             	pushl  -0x10(%ebp)
  800eff:	ff 75 0c             	pushl  0xc(%ebp)
  800f02:	ff 75 08             	pushl  0x8(%ebp)
  800f05:	e8 00 fb ff ff       	call   800a0a <printnum>
  800f0a:	83 c4 20             	add    $0x20,%esp
			break;
  800f0d:	eb 34                	jmp    800f43 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f0f:	83 ec 08             	sub    $0x8,%esp
  800f12:	ff 75 0c             	pushl  0xc(%ebp)
  800f15:	53                   	push   %ebx
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
  800f19:	ff d0                	call   *%eax
  800f1b:	83 c4 10             	add    $0x10,%esp
			break;
  800f1e:	eb 23                	jmp    800f43 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f20:	83 ec 08             	sub    $0x8,%esp
  800f23:	ff 75 0c             	pushl  0xc(%ebp)
  800f26:	6a 25                	push   $0x25
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	ff d0                	call   *%eax
  800f2d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f30:	ff 4d 10             	decl   0x10(%ebp)
  800f33:	eb 03                	jmp    800f38 <vprintfmt+0x3b1>
  800f35:	ff 4d 10             	decl   0x10(%ebp)
  800f38:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3b:	48                   	dec    %eax
  800f3c:	8a 00                	mov    (%eax),%al
  800f3e:	3c 25                	cmp    $0x25,%al
  800f40:	75 f3                	jne    800f35 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f42:	90                   	nop
		}
	}
  800f43:	e9 47 fc ff ff       	jmp    800b8f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f48:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f49:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f4c:	5b                   	pop    %ebx
  800f4d:	5e                   	pop    %esi
  800f4e:	5d                   	pop    %ebp
  800f4f:	c3                   	ret    

00800f50 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f50:	55                   	push   %ebp
  800f51:	89 e5                	mov    %esp,%ebp
  800f53:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f56:	8d 45 10             	lea    0x10(%ebp),%eax
  800f59:	83 c0 04             	add    $0x4,%eax
  800f5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f62:	ff 75 f4             	pushl  -0xc(%ebp)
  800f65:	50                   	push   %eax
  800f66:	ff 75 0c             	pushl  0xc(%ebp)
  800f69:	ff 75 08             	pushl  0x8(%ebp)
  800f6c:	e8 16 fc ff ff       	call   800b87 <vprintfmt>
  800f71:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f74:	90                   	nop
  800f75:	c9                   	leave  
  800f76:	c3                   	ret    

00800f77 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f77:	55                   	push   %ebp
  800f78:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7d:	8b 40 08             	mov    0x8(%eax),%eax
  800f80:	8d 50 01             	lea    0x1(%eax),%edx
  800f83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f86:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8c:	8b 10                	mov    (%eax),%edx
  800f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f91:	8b 40 04             	mov    0x4(%eax),%eax
  800f94:	39 c2                	cmp    %eax,%edx
  800f96:	73 12                	jae    800faa <sprintputch+0x33>
		*b->buf++ = ch;
  800f98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9b:	8b 00                	mov    (%eax),%eax
  800f9d:	8d 48 01             	lea    0x1(%eax),%ecx
  800fa0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fa3:	89 0a                	mov    %ecx,(%edx)
  800fa5:	8b 55 08             	mov    0x8(%ebp),%edx
  800fa8:	88 10                	mov    %dl,(%eax)
}
  800faa:	90                   	nop
  800fab:	5d                   	pop    %ebp
  800fac:	c3                   	ret    

00800fad <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fad:	55                   	push   %ebp
  800fae:	89 e5                	mov    %esp,%ebp
  800fb0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc2:	01 d0                	add    %edx,%eax
  800fc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fce:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fd2:	74 06                	je     800fda <vsnprintf+0x2d>
  800fd4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fd8:	7f 07                	jg     800fe1 <vsnprintf+0x34>
		return -E_INVAL;
  800fda:	b8 03 00 00 00       	mov    $0x3,%eax
  800fdf:	eb 20                	jmp    801001 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fe1:	ff 75 14             	pushl  0x14(%ebp)
  800fe4:	ff 75 10             	pushl  0x10(%ebp)
  800fe7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fea:	50                   	push   %eax
  800feb:	68 77 0f 80 00       	push   $0x800f77
  800ff0:	e8 92 fb ff ff       	call   800b87 <vprintfmt>
  800ff5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ff8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ffb:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ffe:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801001:	c9                   	leave  
  801002:	c3                   	ret    

00801003 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801003:	55                   	push   %ebp
  801004:	89 e5                	mov    %esp,%ebp
  801006:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801009:	8d 45 10             	lea    0x10(%ebp),%eax
  80100c:	83 c0 04             	add    $0x4,%eax
  80100f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801012:	8b 45 10             	mov    0x10(%ebp),%eax
  801015:	ff 75 f4             	pushl  -0xc(%ebp)
  801018:	50                   	push   %eax
  801019:	ff 75 0c             	pushl  0xc(%ebp)
  80101c:	ff 75 08             	pushl  0x8(%ebp)
  80101f:	e8 89 ff ff ff       	call   800fad <vsnprintf>
  801024:	83 c4 10             	add    $0x10,%esp
  801027:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80102a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80102d:	c9                   	leave  
  80102e:	c3                   	ret    

0080102f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80102f:	55                   	push   %ebp
  801030:	89 e5                	mov    %esp,%ebp
  801032:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801035:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80103c:	eb 06                	jmp    801044 <strlen+0x15>
		n++;
  80103e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801041:	ff 45 08             	incl   0x8(%ebp)
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	8a 00                	mov    (%eax),%al
  801049:	84 c0                	test   %al,%al
  80104b:	75 f1                	jne    80103e <strlen+0xf>
		n++;
	return n;
  80104d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801050:	c9                   	leave  
  801051:	c3                   	ret    

00801052 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801052:	55                   	push   %ebp
  801053:	89 e5                	mov    %esp,%ebp
  801055:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801058:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80105f:	eb 09                	jmp    80106a <strnlen+0x18>
		n++;
  801061:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801064:	ff 45 08             	incl   0x8(%ebp)
  801067:	ff 4d 0c             	decl   0xc(%ebp)
  80106a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80106e:	74 09                	je     801079 <strnlen+0x27>
  801070:	8b 45 08             	mov    0x8(%ebp),%eax
  801073:	8a 00                	mov    (%eax),%al
  801075:	84 c0                	test   %al,%al
  801077:	75 e8                	jne    801061 <strnlen+0xf>
		n++;
	return n;
  801079:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80107c:	c9                   	leave  
  80107d:	c3                   	ret    

0080107e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80107e:	55                   	push   %ebp
  80107f:	89 e5                	mov    %esp,%ebp
  801081:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801084:	8b 45 08             	mov    0x8(%ebp),%eax
  801087:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80108a:	90                   	nop
  80108b:	8b 45 08             	mov    0x8(%ebp),%eax
  80108e:	8d 50 01             	lea    0x1(%eax),%edx
  801091:	89 55 08             	mov    %edx,0x8(%ebp)
  801094:	8b 55 0c             	mov    0xc(%ebp),%edx
  801097:	8d 4a 01             	lea    0x1(%edx),%ecx
  80109a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80109d:	8a 12                	mov    (%edx),%dl
  80109f:	88 10                	mov    %dl,(%eax)
  8010a1:	8a 00                	mov    (%eax),%al
  8010a3:	84 c0                	test   %al,%al
  8010a5:	75 e4                	jne    80108b <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010aa:	c9                   	leave  
  8010ab:	c3                   	ret    

008010ac <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010ac:	55                   	push   %ebp
  8010ad:	89 e5                	mov    %esp,%ebp
  8010af:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010bf:	eb 1f                	jmp    8010e0 <strncpy+0x34>
		*dst++ = *src;
  8010c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c4:	8d 50 01             	lea    0x1(%eax),%edx
  8010c7:	89 55 08             	mov    %edx,0x8(%ebp)
  8010ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010cd:	8a 12                	mov    (%edx),%dl
  8010cf:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d4:	8a 00                	mov    (%eax),%al
  8010d6:	84 c0                	test   %al,%al
  8010d8:	74 03                	je     8010dd <strncpy+0x31>
			src++;
  8010da:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010dd:	ff 45 fc             	incl   -0x4(%ebp)
  8010e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010e6:	72 d9                	jb     8010c1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010eb:	c9                   	leave  
  8010ec:	c3                   	ret    

008010ed <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010ed:	55                   	push   %ebp
  8010ee:	89 e5                	mov    %esp,%ebp
  8010f0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010fd:	74 30                	je     80112f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010ff:	eb 16                	jmp    801117 <strlcpy+0x2a>
			*dst++ = *src++;
  801101:	8b 45 08             	mov    0x8(%ebp),%eax
  801104:	8d 50 01             	lea    0x1(%eax),%edx
  801107:	89 55 08             	mov    %edx,0x8(%ebp)
  80110a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80110d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801110:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801113:	8a 12                	mov    (%edx),%dl
  801115:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801117:	ff 4d 10             	decl   0x10(%ebp)
  80111a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80111e:	74 09                	je     801129 <strlcpy+0x3c>
  801120:	8b 45 0c             	mov    0xc(%ebp),%eax
  801123:	8a 00                	mov    (%eax),%al
  801125:	84 c0                	test   %al,%al
  801127:	75 d8                	jne    801101 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80112f:	8b 55 08             	mov    0x8(%ebp),%edx
  801132:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801135:	29 c2                	sub    %eax,%edx
  801137:	89 d0                	mov    %edx,%eax
}
  801139:	c9                   	leave  
  80113a:	c3                   	ret    

0080113b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80113b:	55                   	push   %ebp
  80113c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80113e:	eb 06                	jmp    801146 <strcmp+0xb>
		p++, q++;
  801140:	ff 45 08             	incl   0x8(%ebp)
  801143:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801146:	8b 45 08             	mov    0x8(%ebp),%eax
  801149:	8a 00                	mov    (%eax),%al
  80114b:	84 c0                	test   %al,%al
  80114d:	74 0e                	je     80115d <strcmp+0x22>
  80114f:	8b 45 08             	mov    0x8(%ebp),%eax
  801152:	8a 10                	mov    (%eax),%dl
  801154:	8b 45 0c             	mov    0xc(%ebp),%eax
  801157:	8a 00                	mov    (%eax),%al
  801159:	38 c2                	cmp    %al,%dl
  80115b:	74 e3                	je     801140 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80115d:	8b 45 08             	mov    0x8(%ebp),%eax
  801160:	8a 00                	mov    (%eax),%al
  801162:	0f b6 d0             	movzbl %al,%edx
  801165:	8b 45 0c             	mov    0xc(%ebp),%eax
  801168:	8a 00                	mov    (%eax),%al
  80116a:	0f b6 c0             	movzbl %al,%eax
  80116d:	29 c2                	sub    %eax,%edx
  80116f:	89 d0                	mov    %edx,%eax
}
  801171:	5d                   	pop    %ebp
  801172:	c3                   	ret    

00801173 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801173:	55                   	push   %ebp
  801174:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801176:	eb 09                	jmp    801181 <strncmp+0xe>
		n--, p++, q++;
  801178:	ff 4d 10             	decl   0x10(%ebp)
  80117b:	ff 45 08             	incl   0x8(%ebp)
  80117e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801181:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801185:	74 17                	je     80119e <strncmp+0x2b>
  801187:	8b 45 08             	mov    0x8(%ebp),%eax
  80118a:	8a 00                	mov    (%eax),%al
  80118c:	84 c0                	test   %al,%al
  80118e:	74 0e                	je     80119e <strncmp+0x2b>
  801190:	8b 45 08             	mov    0x8(%ebp),%eax
  801193:	8a 10                	mov    (%eax),%dl
  801195:	8b 45 0c             	mov    0xc(%ebp),%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	38 c2                	cmp    %al,%dl
  80119c:	74 da                	je     801178 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80119e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011a2:	75 07                	jne    8011ab <strncmp+0x38>
		return 0;
  8011a4:	b8 00 00 00 00       	mov    $0x0,%eax
  8011a9:	eb 14                	jmp    8011bf <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	8a 00                	mov    (%eax),%al
  8011b0:	0f b6 d0             	movzbl %al,%edx
  8011b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b6:	8a 00                	mov    (%eax),%al
  8011b8:	0f b6 c0             	movzbl %al,%eax
  8011bb:	29 c2                	sub    %eax,%edx
  8011bd:	89 d0                	mov    %edx,%eax
}
  8011bf:	5d                   	pop    %ebp
  8011c0:	c3                   	ret    

008011c1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011c1:	55                   	push   %ebp
  8011c2:	89 e5                	mov    %esp,%ebp
  8011c4:	83 ec 04             	sub    $0x4,%esp
  8011c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ca:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011cd:	eb 12                	jmp    8011e1 <strchr+0x20>
		if (*s == c)
  8011cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d2:	8a 00                	mov    (%eax),%al
  8011d4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011d7:	75 05                	jne    8011de <strchr+0x1d>
			return (char *) s;
  8011d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dc:	eb 11                	jmp    8011ef <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011de:	ff 45 08             	incl   0x8(%ebp)
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	8a 00                	mov    (%eax),%al
  8011e6:	84 c0                	test   %al,%al
  8011e8:	75 e5                	jne    8011cf <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011ef:	c9                   	leave  
  8011f0:	c3                   	ret    

008011f1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011f1:	55                   	push   %ebp
  8011f2:	89 e5                	mov    %esp,%ebp
  8011f4:	83 ec 04             	sub    $0x4,%esp
  8011f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fa:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011fd:	eb 0d                	jmp    80120c <strfind+0x1b>
		if (*s == c)
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801202:	8a 00                	mov    (%eax),%al
  801204:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801207:	74 0e                	je     801217 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801209:	ff 45 08             	incl   0x8(%ebp)
  80120c:	8b 45 08             	mov    0x8(%ebp),%eax
  80120f:	8a 00                	mov    (%eax),%al
  801211:	84 c0                	test   %al,%al
  801213:	75 ea                	jne    8011ff <strfind+0xe>
  801215:	eb 01                	jmp    801218 <strfind+0x27>
		if (*s == c)
			break;
  801217:	90                   	nop
	return (char *) s;
  801218:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80121b:	c9                   	leave  
  80121c:	c3                   	ret    

0080121d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80121d:	55                   	push   %ebp
  80121e:	89 e5                	mov    %esp,%ebp
  801220:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801223:	8b 45 08             	mov    0x8(%ebp),%eax
  801226:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801229:	8b 45 10             	mov    0x10(%ebp),%eax
  80122c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80122f:	eb 0e                	jmp    80123f <memset+0x22>
		*p++ = c;
  801231:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801234:	8d 50 01             	lea    0x1(%eax),%edx
  801237:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80123a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80123d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80123f:	ff 4d f8             	decl   -0x8(%ebp)
  801242:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801246:	79 e9                	jns    801231 <memset+0x14>
		*p++ = c;

	return v;
  801248:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80124b:	c9                   	leave  
  80124c:	c3                   	ret    

0080124d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80124d:	55                   	push   %ebp
  80124e:	89 e5                	mov    %esp,%ebp
  801250:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801253:	8b 45 0c             	mov    0xc(%ebp),%eax
  801256:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801259:	8b 45 08             	mov    0x8(%ebp),%eax
  80125c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80125f:	eb 16                	jmp    801277 <memcpy+0x2a>
		*d++ = *s++;
  801261:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801264:	8d 50 01             	lea    0x1(%eax),%edx
  801267:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80126a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80126d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801270:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801273:	8a 12                	mov    (%edx),%dl
  801275:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801277:	8b 45 10             	mov    0x10(%ebp),%eax
  80127a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80127d:	89 55 10             	mov    %edx,0x10(%ebp)
  801280:	85 c0                	test   %eax,%eax
  801282:	75 dd                	jne    801261 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801284:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801287:	c9                   	leave  
  801288:	c3                   	ret    

00801289 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801289:	55                   	push   %ebp
  80128a:	89 e5                	mov    %esp,%ebp
  80128c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80128f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801292:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801295:	8b 45 08             	mov    0x8(%ebp),%eax
  801298:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80129b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80129e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012a1:	73 50                	jae    8012f3 <memmove+0x6a>
  8012a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a9:	01 d0                	add    %edx,%eax
  8012ab:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012ae:	76 43                	jbe    8012f3 <memmove+0x6a>
		s += n;
  8012b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012bc:	eb 10                	jmp    8012ce <memmove+0x45>
			*--d = *--s;
  8012be:	ff 4d f8             	decl   -0x8(%ebp)
  8012c1:	ff 4d fc             	decl   -0x4(%ebp)
  8012c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c7:	8a 10                	mov    (%eax),%dl
  8012c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012cc:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012d4:	89 55 10             	mov    %edx,0x10(%ebp)
  8012d7:	85 c0                	test   %eax,%eax
  8012d9:	75 e3                	jne    8012be <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012db:	eb 23                	jmp    801300 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e0:	8d 50 01             	lea    0x1(%eax),%edx
  8012e3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012e9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012ec:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012ef:	8a 12                	mov    (%edx),%dl
  8012f1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012f9:	89 55 10             	mov    %edx,0x10(%ebp)
  8012fc:	85 c0                	test   %eax,%eax
  8012fe:	75 dd                	jne    8012dd <memmove+0x54>
			*d++ = *s++;

	return dst;
  801300:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
  801308:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801311:	8b 45 0c             	mov    0xc(%ebp),%eax
  801314:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801317:	eb 2a                	jmp    801343 <memcmp+0x3e>
		if (*s1 != *s2)
  801319:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80131c:	8a 10                	mov    (%eax),%dl
  80131e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801321:	8a 00                	mov    (%eax),%al
  801323:	38 c2                	cmp    %al,%dl
  801325:	74 16                	je     80133d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801327:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80132a:	8a 00                	mov    (%eax),%al
  80132c:	0f b6 d0             	movzbl %al,%edx
  80132f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801332:	8a 00                	mov    (%eax),%al
  801334:	0f b6 c0             	movzbl %al,%eax
  801337:	29 c2                	sub    %eax,%edx
  801339:	89 d0                	mov    %edx,%eax
  80133b:	eb 18                	jmp    801355 <memcmp+0x50>
		s1++, s2++;
  80133d:	ff 45 fc             	incl   -0x4(%ebp)
  801340:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801343:	8b 45 10             	mov    0x10(%ebp),%eax
  801346:	8d 50 ff             	lea    -0x1(%eax),%edx
  801349:	89 55 10             	mov    %edx,0x10(%ebp)
  80134c:	85 c0                	test   %eax,%eax
  80134e:	75 c9                	jne    801319 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801350:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801355:	c9                   	leave  
  801356:	c3                   	ret    

00801357 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801357:	55                   	push   %ebp
  801358:	89 e5                	mov    %esp,%ebp
  80135a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80135d:	8b 55 08             	mov    0x8(%ebp),%edx
  801360:	8b 45 10             	mov    0x10(%ebp),%eax
  801363:	01 d0                	add    %edx,%eax
  801365:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801368:	eb 15                	jmp    80137f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	8a 00                	mov    (%eax),%al
  80136f:	0f b6 d0             	movzbl %al,%edx
  801372:	8b 45 0c             	mov    0xc(%ebp),%eax
  801375:	0f b6 c0             	movzbl %al,%eax
  801378:	39 c2                	cmp    %eax,%edx
  80137a:	74 0d                	je     801389 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80137c:	ff 45 08             	incl   0x8(%ebp)
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801385:	72 e3                	jb     80136a <memfind+0x13>
  801387:	eb 01                	jmp    80138a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801389:	90                   	nop
	return (void *) s;
  80138a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80138d:	c9                   	leave  
  80138e:	c3                   	ret    

0080138f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80138f:	55                   	push   %ebp
  801390:	89 e5                	mov    %esp,%ebp
  801392:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801395:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80139c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013a3:	eb 03                	jmp    8013a8 <strtol+0x19>
		s++;
  8013a5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ab:	8a 00                	mov    (%eax),%al
  8013ad:	3c 20                	cmp    $0x20,%al
  8013af:	74 f4                	je     8013a5 <strtol+0x16>
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	8a 00                	mov    (%eax),%al
  8013b6:	3c 09                	cmp    $0x9,%al
  8013b8:	74 eb                	je     8013a5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	8a 00                	mov    (%eax),%al
  8013bf:	3c 2b                	cmp    $0x2b,%al
  8013c1:	75 05                	jne    8013c8 <strtol+0x39>
		s++;
  8013c3:	ff 45 08             	incl   0x8(%ebp)
  8013c6:	eb 13                	jmp    8013db <strtol+0x4c>
	else if (*s == '-')
  8013c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cb:	8a 00                	mov    (%eax),%al
  8013cd:	3c 2d                	cmp    $0x2d,%al
  8013cf:	75 0a                	jne    8013db <strtol+0x4c>
		s++, neg = 1;
  8013d1:	ff 45 08             	incl   0x8(%ebp)
  8013d4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013db:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013df:	74 06                	je     8013e7 <strtol+0x58>
  8013e1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013e5:	75 20                	jne    801407 <strtol+0x78>
  8013e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ea:	8a 00                	mov    (%eax),%al
  8013ec:	3c 30                	cmp    $0x30,%al
  8013ee:	75 17                	jne    801407 <strtol+0x78>
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	40                   	inc    %eax
  8013f4:	8a 00                	mov    (%eax),%al
  8013f6:	3c 78                	cmp    $0x78,%al
  8013f8:	75 0d                	jne    801407 <strtol+0x78>
		s += 2, base = 16;
  8013fa:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013fe:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801405:	eb 28                	jmp    80142f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801407:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80140b:	75 15                	jne    801422 <strtol+0x93>
  80140d:	8b 45 08             	mov    0x8(%ebp),%eax
  801410:	8a 00                	mov    (%eax),%al
  801412:	3c 30                	cmp    $0x30,%al
  801414:	75 0c                	jne    801422 <strtol+0x93>
		s++, base = 8;
  801416:	ff 45 08             	incl   0x8(%ebp)
  801419:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801420:	eb 0d                	jmp    80142f <strtol+0xa0>
	else if (base == 0)
  801422:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801426:	75 07                	jne    80142f <strtol+0xa0>
		base = 10;
  801428:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80142f:	8b 45 08             	mov    0x8(%ebp),%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	3c 2f                	cmp    $0x2f,%al
  801436:	7e 19                	jle    801451 <strtol+0xc2>
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	8a 00                	mov    (%eax),%al
  80143d:	3c 39                	cmp    $0x39,%al
  80143f:	7f 10                	jg     801451 <strtol+0xc2>
			dig = *s - '0';
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	8a 00                	mov    (%eax),%al
  801446:	0f be c0             	movsbl %al,%eax
  801449:	83 e8 30             	sub    $0x30,%eax
  80144c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80144f:	eb 42                	jmp    801493 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801451:	8b 45 08             	mov    0x8(%ebp),%eax
  801454:	8a 00                	mov    (%eax),%al
  801456:	3c 60                	cmp    $0x60,%al
  801458:	7e 19                	jle    801473 <strtol+0xe4>
  80145a:	8b 45 08             	mov    0x8(%ebp),%eax
  80145d:	8a 00                	mov    (%eax),%al
  80145f:	3c 7a                	cmp    $0x7a,%al
  801461:	7f 10                	jg     801473 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801463:	8b 45 08             	mov    0x8(%ebp),%eax
  801466:	8a 00                	mov    (%eax),%al
  801468:	0f be c0             	movsbl %al,%eax
  80146b:	83 e8 57             	sub    $0x57,%eax
  80146e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801471:	eb 20                	jmp    801493 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801473:	8b 45 08             	mov    0x8(%ebp),%eax
  801476:	8a 00                	mov    (%eax),%al
  801478:	3c 40                	cmp    $0x40,%al
  80147a:	7e 39                	jle    8014b5 <strtol+0x126>
  80147c:	8b 45 08             	mov    0x8(%ebp),%eax
  80147f:	8a 00                	mov    (%eax),%al
  801481:	3c 5a                	cmp    $0x5a,%al
  801483:	7f 30                	jg     8014b5 <strtol+0x126>
			dig = *s - 'A' + 10;
  801485:	8b 45 08             	mov    0x8(%ebp),%eax
  801488:	8a 00                	mov    (%eax),%al
  80148a:	0f be c0             	movsbl %al,%eax
  80148d:	83 e8 37             	sub    $0x37,%eax
  801490:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801493:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801496:	3b 45 10             	cmp    0x10(%ebp),%eax
  801499:	7d 19                	jge    8014b4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80149b:	ff 45 08             	incl   0x8(%ebp)
  80149e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a1:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014a5:	89 c2                	mov    %eax,%edx
  8014a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014aa:	01 d0                	add    %edx,%eax
  8014ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014af:	e9 7b ff ff ff       	jmp    80142f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014b4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014b5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014b9:	74 08                	je     8014c3 <strtol+0x134>
		*endptr = (char *) s;
  8014bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014be:	8b 55 08             	mov    0x8(%ebp),%edx
  8014c1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014c3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014c7:	74 07                	je     8014d0 <strtol+0x141>
  8014c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014cc:	f7 d8                	neg    %eax
  8014ce:	eb 03                	jmp    8014d3 <strtol+0x144>
  8014d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014d3:	c9                   	leave  
  8014d4:	c3                   	ret    

008014d5 <ltostr>:

void
ltostr(long value, char *str)
{
  8014d5:	55                   	push   %ebp
  8014d6:	89 e5                	mov    %esp,%ebp
  8014d8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014e2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014e9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014ed:	79 13                	jns    801502 <ltostr+0x2d>
	{
		neg = 1;
  8014ef:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014fc:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014ff:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801502:	8b 45 08             	mov    0x8(%ebp),%eax
  801505:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80150a:	99                   	cltd   
  80150b:	f7 f9                	idiv   %ecx
  80150d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801510:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801513:	8d 50 01             	lea    0x1(%eax),%edx
  801516:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801519:	89 c2                	mov    %eax,%edx
  80151b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151e:	01 d0                	add    %edx,%eax
  801520:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801523:	83 c2 30             	add    $0x30,%edx
  801526:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801528:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80152b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801530:	f7 e9                	imul   %ecx
  801532:	c1 fa 02             	sar    $0x2,%edx
  801535:	89 c8                	mov    %ecx,%eax
  801537:	c1 f8 1f             	sar    $0x1f,%eax
  80153a:	29 c2                	sub    %eax,%edx
  80153c:	89 d0                	mov    %edx,%eax
  80153e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801541:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801544:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801549:	f7 e9                	imul   %ecx
  80154b:	c1 fa 02             	sar    $0x2,%edx
  80154e:	89 c8                	mov    %ecx,%eax
  801550:	c1 f8 1f             	sar    $0x1f,%eax
  801553:	29 c2                	sub    %eax,%edx
  801555:	89 d0                	mov    %edx,%eax
  801557:	c1 e0 02             	shl    $0x2,%eax
  80155a:	01 d0                	add    %edx,%eax
  80155c:	01 c0                	add    %eax,%eax
  80155e:	29 c1                	sub    %eax,%ecx
  801560:	89 ca                	mov    %ecx,%edx
  801562:	85 d2                	test   %edx,%edx
  801564:	75 9c                	jne    801502 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801566:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80156d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801570:	48                   	dec    %eax
  801571:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801574:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801578:	74 3d                	je     8015b7 <ltostr+0xe2>
		start = 1 ;
  80157a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801581:	eb 34                	jmp    8015b7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801583:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801586:	8b 45 0c             	mov    0xc(%ebp),%eax
  801589:	01 d0                	add    %edx,%eax
  80158b:	8a 00                	mov    (%eax),%al
  80158d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801590:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801593:	8b 45 0c             	mov    0xc(%ebp),%eax
  801596:	01 c2                	add    %eax,%edx
  801598:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80159b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159e:	01 c8                	add    %ecx,%eax
  8015a0:	8a 00                	mov    (%eax),%al
  8015a2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015a4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015aa:	01 c2                	add    %eax,%edx
  8015ac:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015af:	88 02                	mov    %al,(%edx)
		start++ ;
  8015b1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015b4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ba:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015bd:	7c c4                	jl     801583 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015bf:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c5:	01 d0                	add    %edx,%eax
  8015c7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015ca:	90                   	nop
  8015cb:	c9                   	leave  
  8015cc:	c3                   	ret    

008015cd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015cd:	55                   	push   %ebp
  8015ce:	89 e5                	mov    %esp,%ebp
  8015d0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015d3:	ff 75 08             	pushl  0x8(%ebp)
  8015d6:	e8 54 fa ff ff       	call   80102f <strlen>
  8015db:	83 c4 04             	add    $0x4,%esp
  8015de:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015e1:	ff 75 0c             	pushl  0xc(%ebp)
  8015e4:	e8 46 fa ff ff       	call   80102f <strlen>
  8015e9:	83 c4 04             	add    $0x4,%esp
  8015ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015fd:	eb 17                	jmp    801616 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801602:	8b 45 10             	mov    0x10(%ebp),%eax
  801605:	01 c2                	add    %eax,%edx
  801607:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80160a:	8b 45 08             	mov    0x8(%ebp),%eax
  80160d:	01 c8                	add    %ecx,%eax
  80160f:	8a 00                	mov    (%eax),%al
  801611:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801613:	ff 45 fc             	incl   -0x4(%ebp)
  801616:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801619:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80161c:	7c e1                	jl     8015ff <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80161e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801625:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80162c:	eb 1f                	jmp    80164d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80162e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801631:	8d 50 01             	lea    0x1(%eax),%edx
  801634:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801637:	89 c2                	mov    %eax,%edx
  801639:	8b 45 10             	mov    0x10(%ebp),%eax
  80163c:	01 c2                	add    %eax,%edx
  80163e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801641:	8b 45 0c             	mov    0xc(%ebp),%eax
  801644:	01 c8                	add    %ecx,%eax
  801646:	8a 00                	mov    (%eax),%al
  801648:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80164a:	ff 45 f8             	incl   -0x8(%ebp)
  80164d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801650:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801653:	7c d9                	jl     80162e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801655:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801658:	8b 45 10             	mov    0x10(%ebp),%eax
  80165b:	01 d0                	add    %edx,%eax
  80165d:	c6 00 00             	movb   $0x0,(%eax)
}
  801660:	90                   	nop
  801661:	c9                   	leave  
  801662:	c3                   	ret    

00801663 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801663:	55                   	push   %ebp
  801664:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801666:	8b 45 14             	mov    0x14(%ebp),%eax
  801669:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80166f:	8b 45 14             	mov    0x14(%ebp),%eax
  801672:	8b 00                	mov    (%eax),%eax
  801674:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80167b:	8b 45 10             	mov    0x10(%ebp),%eax
  80167e:	01 d0                	add    %edx,%eax
  801680:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801686:	eb 0c                	jmp    801694 <strsplit+0x31>
			*string++ = 0;
  801688:	8b 45 08             	mov    0x8(%ebp),%eax
  80168b:	8d 50 01             	lea    0x1(%eax),%edx
  80168e:	89 55 08             	mov    %edx,0x8(%ebp)
  801691:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801694:	8b 45 08             	mov    0x8(%ebp),%eax
  801697:	8a 00                	mov    (%eax),%al
  801699:	84 c0                	test   %al,%al
  80169b:	74 18                	je     8016b5 <strsplit+0x52>
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	8a 00                	mov    (%eax),%al
  8016a2:	0f be c0             	movsbl %al,%eax
  8016a5:	50                   	push   %eax
  8016a6:	ff 75 0c             	pushl  0xc(%ebp)
  8016a9:	e8 13 fb ff ff       	call   8011c1 <strchr>
  8016ae:	83 c4 08             	add    $0x8,%esp
  8016b1:	85 c0                	test   %eax,%eax
  8016b3:	75 d3                	jne    801688 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b8:	8a 00                	mov    (%eax),%al
  8016ba:	84 c0                	test   %al,%al
  8016bc:	74 5a                	je     801718 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016be:	8b 45 14             	mov    0x14(%ebp),%eax
  8016c1:	8b 00                	mov    (%eax),%eax
  8016c3:	83 f8 0f             	cmp    $0xf,%eax
  8016c6:	75 07                	jne    8016cf <strsplit+0x6c>
		{
			return 0;
  8016c8:	b8 00 00 00 00       	mov    $0x0,%eax
  8016cd:	eb 66                	jmp    801735 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8016d2:	8b 00                	mov    (%eax),%eax
  8016d4:	8d 48 01             	lea    0x1(%eax),%ecx
  8016d7:	8b 55 14             	mov    0x14(%ebp),%edx
  8016da:	89 0a                	mov    %ecx,(%edx)
  8016dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e6:	01 c2                	add    %eax,%edx
  8016e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016eb:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016ed:	eb 03                	jmp    8016f2 <strsplit+0x8f>
			string++;
  8016ef:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f5:	8a 00                	mov    (%eax),%al
  8016f7:	84 c0                	test   %al,%al
  8016f9:	74 8b                	je     801686 <strsplit+0x23>
  8016fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fe:	8a 00                	mov    (%eax),%al
  801700:	0f be c0             	movsbl %al,%eax
  801703:	50                   	push   %eax
  801704:	ff 75 0c             	pushl  0xc(%ebp)
  801707:	e8 b5 fa ff ff       	call   8011c1 <strchr>
  80170c:	83 c4 08             	add    $0x8,%esp
  80170f:	85 c0                	test   %eax,%eax
  801711:	74 dc                	je     8016ef <strsplit+0x8c>
			string++;
	}
  801713:	e9 6e ff ff ff       	jmp    801686 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801718:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801719:	8b 45 14             	mov    0x14(%ebp),%eax
  80171c:	8b 00                	mov    (%eax),%eax
  80171e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801725:	8b 45 10             	mov    0x10(%ebp),%eax
  801728:	01 d0                	add    %edx,%eax
  80172a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801730:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801735:	c9                   	leave  
  801736:	c3                   	ret    

00801737 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801737:	55                   	push   %ebp
  801738:	89 e5                	mov    %esp,%ebp
  80173a:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  80173d:	e8 3b 09 00 00       	call   80207d <sys_isUHeapPlacementStrategyFIRSTFIT>
  801742:	85 c0                	test   %eax,%eax
  801744:	0f 84 3a 01 00 00    	je     801884 <malloc+0x14d>

		if(pl == 0){
  80174a:	a1 28 30 80 00       	mov    0x803028,%eax
  80174f:	85 c0                	test   %eax,%eax
  801751:	75 24                	jne    801777 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801753:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80175a:	eb 11                	jmp    80176d <malloc+0x36>
				arr[k] = -10000;
  80175c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80175f:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801766:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  80176a:	ff 45 f4             	incl   -0xc(%ebp)
  80176d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801770:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801775:	76 e5                	jbe    80175c <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801777:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  80177e:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801781:	8b 45 08             	mov    0x8(%ebp),%eax
  801784:	c1 e8 0c             	shr    $0xc,%eax
  801787:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  80178a:	8b 45 08             	mov    0x8(%ebp),%eax
  80178d:	25 ff 0f 00 00       	and    $0xfff,%eax
  801792:	85 c0                	test   %eax,%eax
  801794:	74 03                	je     801799 <malloc+0x62>
			x++;
  801796:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801799:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  8017a0:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  8017a7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8017ae:	eb 66                	jmp    801816 <malloc+0xdf>
			if( arr[k] == -10000){
  8017b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8017b3:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8017ba:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  8017bf:	75 52                	jne    801813 <malloc+0xdc>
				uint32 w = 0 ;
  8017c1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  8017c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8017cb:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  8017ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8017d1:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8017d4:	eb 09                	jmp    8017df <malloc+0xa8>
  8017d6:	ff 45 e0             	incl   -0x20(%ebp)
  8017d9:	ff 45 dc             	incl   -0x24(%ebp)
  8017dc:	ff 45 e4             	incl   -0x1c(%ebp)
  8017df:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8017e2:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8017e7:	77 19                	ja     801802 <malloc+0xcb>
  8017e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8017ec:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8017f3:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  8017f8:	75 08                	jne    801802 <malloc+0xcb>
  8017fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8017fd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801800:	72 d4                	jb     8017d6 <malloc+0x9f>
				if(w >= x){
  801802:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801805:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801808:	72 09                	jb     801813 <malloc+0xdc>
					p = 1 ;
  80180a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801811:	eb 0d                	jmp    801820 <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801813:	ff 45 e4             	incl   -0x1c(%ebp)
  801816:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801819:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80181e:	76 90                	jbe    8017b0 <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801820:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801824:	75 0a                	jne    801830 <malloc+0xf9>
  801826:	b8 00 00 00 00       	mov    $0x0,%eax
  80182b:	e9 ca 01 00 00       	jmp    8019fa <malloc+0x2c3>
		int q = idx;
  801830:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801833:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801836:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  80183d:	eb 16                	jmp    801855 <malloc+0x11e>
			arr[q++] = x;
  80183f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801842:	8d 50 01             	lea    0x1(%eax),%edx
  801845:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801848:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80184b:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801852:	ff 45 d4             	incl   -0x2c(%ebp)
  801855:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801858:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80185b:	72 e2                	jb     80183f <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  80185d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801860:	05 00 00 08 00       	add    $0x80000,%eax
  801865:	c1 e0 0c             	shl    $0xc,%eax
  801868:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  80186b:	83 ec 08             	sub    $0x8,%esp
  80186e:	ff 75 f0             	pushl  -0x10(%ebp)
  801871:	ff 75 ac             	pushl  -0x54(%ebp)
  801874:	e8 9b 04 00 00       	call   801d14 <sys_allocateMem>
  801879:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  80187c:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80187f:	e9 76 01 00 00       	jmp    8019fa <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801884:	e8 25 08 00 00       	call   8020ae <sys_isUHeapPlacementStrategyBESTFIT>
  801889:	85 c0                	test   %eax,%eax
  80188b:	0f 84 64 01 00 00    	je     8019f5 <malloc+0x2be>
		if(pl == 0){
  801891:	a1 28 30 80 00       	mov    0x803028,%eax
  801896:	85 c0                	test   %eax,%eax
  801898:	75 24                	jne    8018be <malloc+0x187>
			for(int k = 0; k < Size; k++){
  80189a:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  8018a1:	eb 11                	jmp    8018b4 <malloc+0x17d>
				arr[k] = -10000;
  8018a3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018a6:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  8018ad:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  8018b1:	ff 45 d0             	incl   -0x30(%ebp)
  8018b4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018b7:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8018bc:	76 e5                	jbe    8018a3 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  8018be:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  8018c5:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  8018c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cb:	c1 e8 0c             	shr    $0xc,%eax
  8018ce:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  8018d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d4:	25 ff 0f 00 00       	and    $0xfff,%eax
  8018d9:	85 c0                	test   %eax,%eax
  8018db:	74 03                	je     8018e0 <malloc+0x1a9>
			x++;
  8018dd:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  8018e0:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  8018e7:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  8018ee:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  8018f5:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  8018fc:	e9 88 00 00 00       	jmp    801989 <malloc+0x252>
			if(arr[k] == -10000){
  801901:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801904:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80190b:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801910:	75 64                	jne    801976 <malloc+0x23f>
				uint32 w = 0 , i;
  801912:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801919:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80191c:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80191f:	eb 06                	jmp    801927 <malloc+0x1f0>
  801921:	ff 45 b8             	incl   -0x48(%ebp)
  801924:	ff 45 b4             	incl   -0x4c(%ebp)
  801927:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  80192e:	77 11                	ja     801941 <malloc+0x20a>
  801930:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801933:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80193a:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  80193f:	74 e0                	je     801921 <malloc+0x1ea>
				if(w <q && w >= x){
  801941:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801944:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801947:	73 24                	jae    80196d <malloc+0x236>
  801949:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80194c:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  80194f:	72 1c                	jb     80196d <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801951:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801954:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801957:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  80195e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801961:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801964:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801967:	48                   	dec    %eax
  801968:	89 45 bc             	mov    %eax,-0x44(%ebp)
  80196b:	eb 19                	jmp    801986 <malloc+0x24f>
				}
				else {
					k = i - 1;
  80196d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801970:	48                   	dec    %eax
  801971:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801974:	eb 10                	jmp    801986 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801976:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801979:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801980:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801983:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801986:	ff 45 bc             	incl   -0x44(%ebp)
  801989:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80198c:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801991:	0f 86 6a ff ff ff    	jbe    801901 <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801997:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  80199b:	75 07                	jne    8019a4 <malloc+0x26d>
  80199d:	b8 00 00 00 00       	mov    $0x0,%eax
  8019a2:	eb 56                	jmp    8019fa <malloc+0x2c3>
	    q = idx;
  8019a4:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8019a7:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  8019aa:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  8019b1:	eb 16                	jmp    8019c9 <malloc+0x292>
			arr[q++] = x;
  8019b3:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8019b6:	8d 50 01             	lea    0x1(%eax),%edx
  8019b9:	89 55 c8             	mov    %edx,-0x38(%ebp)
  8019bc:	8b 55 cc             	mov    -0x34(%ebp),%edx
  8019bf:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  8019c6:	ff 45 b0             	incl   -0x50(%ebp)
  8019c9:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8019cc:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  8019cf:	72 e2                	jb     8019b3 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  8019d1:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8019d4:	05 00 00 08 00       	add    $0x80000,%eax
  8019d9:	c1 e0 0c             	shl    $0xc,%eax
  8019dc:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  8019df:	83 ec 08             	sub    $0x8,%esp
  8019e2:	ff 75 cc             	pushl  -0x34(%ebp)
  8019e5:	ff 75 a8             	pushl  -0x58(%ebp)
  8019e8:	e8 27 03 00 00       	call   801d14 <sys_allocateMem>
  8019ed:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  8019f0:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8019f3:	eb 05                	jmp    8019fa <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  8019f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019fa:	c9                   	leave  
  8019fb:	c3                   	ret    

008019fc <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
  8019ff:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801a02:	8b 45 08             	mov    0x8(%ebp),%eax
  801a05:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801a08:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a0b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801a10:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801a13:	8b 45 08             	mov    0x8(%ebp),%eax
  801a16:	05 00 00 00 80       	add    $0x80000000,%eax
  801a1b:	c1 e8 0c             	shr    $0xc,%eax
  801a1e:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801a25:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801a28:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801a2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a32:	05 00 00 00 80       	add    $0x80000000,%eax
  801a37:	c1 e8 0c             	shr    $0xc,%eax
  801a3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a3d:	eb 14                	jmp    801a53 <free+0x57>
		arr[j] = -10000;
  801a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a42:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801a49:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801a4d:	ff 45 f4             	incl   -0xc(%ebp)
  801a50:	ff 45 f0             	incl   -0x10(%ebp)
  801a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a56:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801a59:	72 e4                	jb     801a3f <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5e:	83 ec 08             	sub    $0x8,%esp
  801a61:	ff 75 e8             	pushl  -0x18(%ebp)
  801a64:	50                   	push   %eax
  801a65:	e8 8e 02 00 00       	call   801cf8 <sys_freeMem>
  801a6a:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801a6d:	90                   	nop
  801a6e:	c9                   	leave  
  801a6f:	c3                   	ret    

00801a70 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801a70:	55                   	push   %ebp
  801a71:	89 e5                	mov    %esp,%ebp
  801a73:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a76:	83 ec 04             	sub    $0x4,%esp
  801a79:	68 f0 2a 80 00       	push   $0x802af0
  801a7e:	68 9e 00 00 00       	push   $0x9e
  801a83:	68 13 2b 80 00       	push   $0x802b13
  801a88:	e8 69 ec ff ff       	call   8006f6 <_panic>

00801a8d <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a8d:	55                   	push   %ebp
  801a8e:	89 e5                	mov    %esp,%ebp
  801a90:	83 ec 18             	sub    $0x18,%esp
  801a93:	8b 45 10             	mov    0x10(%ebp),%eax
  801a96:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a99:	83 ec 04             	sub    $0x4,%esp
  801a9c:	68 f0 2a 80 00       	push   $0x802af0
  801aa1:	68 a9 00 00 00       	push   $0xa9
  801aa6:	68 13 2b 80 00       	push   $0x802b13
  801aab:	e8 46 ec ff ff       	call   8006f6 <_panic>

00801ab0 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801ab0:	55                   	push   %ebp
  801ab1:	89 e5                	mov    %esp,%ebp
  801ab3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ab6:	83 ec 04             	sub    $0x4,%esp
  801ab9:	68 f0 2a 80 00       	push   $0x802af0
  801abe:	68 af 00 00 00       	push   $0xaf
  801ac3:	68 13 2b 80 00       	push   $0x802b13
  801ac8:	e8 29 ec ff ff       	call   8006f6 <_panic>

00801acd <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801acd:	55                   	push   %ebp
  801ace:	89 e5                	mov    %esp,%ebp
  801ad0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ad3:	83 ec 04             	sub    $0x4,%esp
  801ad6:	68 f0 2a 80 00       	push   $0x802af0
  801adb:	68 b5 00 00 00       	push   $0xb5
  801ae0:	68 13 2b 80 00       	push   $0x802b13
  801ae5:	e8 0c ec ff ff       	call   8006f6 <_panic>

00801aea <expand>:
}

void expand(uint32 newSize)
{
  801aea:	55                   	push   %ebp
  801aeb:	89 e5                	mov    %esp,%ebp
  801aed:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801af0:	83 ec 04             	sub    $0x4,%esp
  801af3:	68 f0 2a 80 00       	push   $0x802af0
  801af8:	68 ba 00 00 00       	push   $0xba
  801afd:	68 13 2b 80 00       	push   $0x802b13
  801b02:	e8 ef eb ff ff       	call   8006f6 <_panic>

00801b07 <shrink>:
}
void shrink(uint32 newSize)
{
  801b07:	55                   	push   %ebp
  801b08:	89 e5                	mov    %esp,%ebp
  801b0a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b0d:	83 ec 04             	sub    $0x4,%esp
  801b10:	68 f0 2a 80 00       	push   $0x802af0
  801b15:	68 be 00 00 00       	push   $0xbe
  801b1a:	68 13 2b 80 00       	push   $0x802b13
  801b1f:	e8 d2 eb ff ff       	call   8006f6 <_panic>

00801b24 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801b24:	55                   	push   %ebp
  801b25:	89 e5                	mov    %esp,%ebp
  801b27:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b2a:	83 ec 04             	sub    $0x4,%esp
  801b2d:	68 f0 2a 80 00       	push   $0x802af0
  801b32:	68 c3 00 00 00       	push   $0xc3
  801b37:	68 13 2b 80 00       	push   $0x802b13
  801b3c:	e8 b5 eb ff ff       	call   8006f6 <_panic>

00801b41 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
  801b44:	57                   	push   %edi
  801b45:	56                   	push   %esi
  801b46:	53                   	push   %ebx
  801b47:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b50:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b53:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b56:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b59:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b5c:	cd 30                	int    $0x30
  801b5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b61:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b64:	83 c4 10             	add    $0x10,%esp
  801b67:	5b                   	pop    %ebx
  801b68:	5e                   	pop    %esi
  801b69:	5f                   	pop    %edi
  801b6a:	5d                   	pop    %ebp
  801b6b:	c3                   	ret    

00801b6c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b6c:	55                   	push   %ebp
  801b6d:	89 e5                	mov    %esp,%ebp
  801b6f:	83 ec 04             	sub    $0x4,%esp
  801b72:	8b 45 10             	mov    0x10(%ebp),%eax
  801b75:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b78:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 00                	push   $0x0
  801b83:	52                   	push   %edx
  801b84:	ff 75 0c             	pushl  0xc(%ebp)
  801b87:	50                   	push   %eax
  801b88:	6a 00                	push   $0x0
  801b8a:	e8 b2 ff ff ff       	call   801b41 <syscall>
  801b8f:	83 c4 18             	add    $0x18,%esp
}
  801b92:	90                   	nop
  801b93:	c9                   	leave  
  801b94:	c3                   	ret    

00801b95 <sys_cgetc>:

int
sys_cgetc(void)
{
  801b95:	55                   	push   %ebp
  801b96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 01                	push   $0x1
  801ba4:	e8 98 ff ff ff       	call   801b41 <syscall>
  801ba9:	83 c4 18             	add    $0x18,%esp
}
  801bac:	c9                   	leave  
  801bad:	c3                   	ret    

00801bae <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801bae:	55                   	push   %ebp
  801baf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	50                   	push   %eax
  801bbd:	6a 05                	push   $0x5
  801bbf:	e8 7d ff ff ff       	call   801b41 <syscall>
  801bc4:	83 c4 18             	add    $0x18,%esp
}
  801bc7:	c9                   	leave  
  801bc8:	c3                   	ret    

00801bc9 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801bc9:	55                   	push   %ebp
  801bca:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 02                	push   $0x2
  801bd8:	e8 64 ff ff ff       	call   801b41 <syscall>
  801bdd:	83 c4 18             	add    $0x18,%esp
}
  801be0:	c9                   	leave  
  801be1:	c3                   	ret    

00801be2 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801be2:	55                   	push   %ebp
  801be3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	6a 03                	push   $0x3
  801bf1:	e8 4b ff ff ff       	call   801b41 <syscall>
  801bf6:	83 c4 18             	add    $0x18,%esp
}
  801bf9:	c9                   	leave  
  801bfa:	c3                   	ret    

00801bfb <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801bfb:	55                   	push   %ebp
  801bfc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	6a 04                	push   $0x4
  801c0a:	e8 32 ff ff ff       	call   801b41 <syscall>
  801c0f:	83 c4 18             	add    $0x18,%esp
}
  801c12:	c9                   	leave  
  801c13:	c3                   	ret    

00801c14 <sys_env_exit>:


void sys_env_exit(void)
{
  801c14:	55                   	push   %ebp
  801c15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 06                	push   $0x6
  801c23:	e8 19 ff ff ff       	call   801b41 <syscall>
  801c28:	83 c4 18             	add    $0x18,%esp
}
  801c2b:	90                   	nop
  801c2c:	c9                   	leave  
  801c2d:	c3                   	ret    

00801c2e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c2e:	55                   	push   %ebp
  801c2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c31:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c34:	8b 45 08             	mov    0x8(%ebp),%eax
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	52                   	push   %edx
  801c3e:	50                   	push   %eax
  801c3f:	6a 07                	push   $0x7
  801c41:	e8 fb fe ff ff       	call   801b41 <syscall>
  801c46:	83 c4 18             	add    $0x18,%esp
}
  801c49:	c9                   	leave  
  801c4a:	c3                   	ret    

00801c4b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c4b:	55                   	push   %ebp
  801c4c:	89 e5                	mov    %esp,%ebp
  801c4e:	56                   	push   %esi
  801c4f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c50:	8b 75 18             	mov    0x18(%ebp),%esi
  801c53:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c56:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c59:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5f:	56                   	push   %esi
  801c60:	53                   	push   %ebx
  801c61:	51                   	push   %ecx
  801c62:	52                   	push   %edx
  801c63:	50                   	push   %eax
  801c64:	6a 08                	push   $0x8
  801c66:	e8 d6 fe ff ff       	call   801b41 <syscall>
  801c6b:	83 c4 18             	add    $0x18,%esp
}
  801c6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c71:	5b                   	pop    %ebx
  801c72:	5e                   	pop    %esi
  801c73:	5d                   	pop    %ebp
  801c74:	c3                   	ret    

00801c75 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c75:	55                   	push   %ebp
  801c76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c78:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 00                	push   $0x0
  801c82:	6a 00                	push   $0x0
  801c84:	52                   	push   %edx
  801c85:	50                   	push   %eax
  801c86:	6a 09                	push   $0x9
  801c88:	e8 b4 fe ff ff       	call   801b41 <syscall>
  801c8d:	83 c4 18             	add    $0x18,%esp
}
  801c90:	c9                   	leave  
  801c91:	c3                   	ret    

00801c92 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c92:	55                   	push   %ebp
  801c93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	ff 75 0c             	pushl  0xc(%ebp)
  801c9e:	ff 75 08             	pushl  0x8(%ebp)
  801ca1:	6a 0a                	push   $0xa
  801ca3:	e8 99 fe ff ff       	call   801b41 <syscall>
  801ca8:	83 c4 18             	add    $0x18,%esp
}
  801cab:	c9                   	leave  
  801cac:	c3                   	ret    

00801cad <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801cad:	55                   	push   %ebp
  801cae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 0b                	push   $0xb
  801cbc:	e8 80 fe ff ff       	call   801b41 <syscall>
  801cc1:	83 c4 18             	add    $0x18,%esp
}
  801cc4:	c9                   	leave  
  801cc5:	c3                   	ret    

00801cc6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801cc6:	55                   	push   %ebp
  801cc7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 0c                	push   $0xc
  801cd5:	e8 67 fe ff ff       	call   801b41 <syscall>
  801cda:	83 c4 18             	add    $0x18,%esp
}
  801cdd:	c9                   	leave  
  801cde:	c3                   	ret    

00801cdf <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801cdf:	55                   	push   %ebp
  801ce0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 0d                	push   $0xd
  801cee:	e8 4e fe ff ff       	call   801b41 <syscall>
  801cf3:	83 c4 18             	add    $0x18,%esp
}
  801cf6:	c9                   	leave  
  801cf7:	c3                   	ret    

00801cf8 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801cf8:	55                   	push   %ebp
  801cf9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	ff 75 0c             	pushl  0xc(%ebp)
  801d04:	ff 75 08             	pushl  0x8(%ebp)
  801d07:	6a 11                	push   $0x11
  801d09:	e8 33 fe ff ff       	call   801b41 <syscall>
  801d0e:	83 c4 18             	add    $0x18,%esp
	return;
  801d11:	90                   	nop
}
  801d12:	c9                   	leave  
  801d13:	c3                   	ret    

00801d14 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d14:	55                   	push   %ebp
  801d15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d17:	6a 00                	push   $0x0
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	ff 75 0c             	pushl  0xc(%ebp)
  801d20:	ff 75 08             	pushl  0x8(%ebp)
  801d23:	6a 12                	push   $0x12
  801d25:	e8 17 fe ff ff       	call   801b41 <syscall>
  801d2a:	83 c4 18             	add    $0x18,%esp
	return ;
  801d2d:	90                   	nop
}
  801d2e:	c9                   	leave  
  801d2f:	c3                   	ret    

00801d30 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d30:	55                   	push   %ebp
  801d31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 0e                	push   $0xe
  801d3f:	e8 fd fd ff ff       	call   801b41 <syscall>
  801d44:	83 c4 18             	add    $0x18,%esp
}
  801d47:	c9                   	leave  
  801d48:	c3                   	ret    

00801d49 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d49:	55                   	push   %ebp
  801d4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	6a 00                	push   $0x0
  801d54:	ff 75 08             	pushl  0x8(%ebp)
  801d57:	6a 0f                	push   $0xf
  801d59:	e8 e3 fd ff ff       	call   801b41 <syscall>
  801d5e:	83 c4 18             	add    $0x18,%esp
}
  801d61:	c9                   	leave  
  801d62:	c3                   	ret    

00801d63 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d63:	55                   	push   %ebp
  801d64:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 10                	push   $0x10
  801d72:	e8 ca fd ff ff       	call   801b41 <syscall>
  801d77:	83 c4 18             	add    $0x18,%esp
}
  801d7a:	90                   	nop
  801d7b:	c9                   	leave  
  801d7c:	c3                   	ret    

00801d7d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d7d:	55                   	push   %ebp
  801d7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d80:	6a 00                	push   $0x0
  801d82:	6a 00                	push   $0x0
  801d84:	6a 00                	push   $0x0
  801d86:	6a 00                	push   $0x0
  801d88:	6a 00                	push   $0x0
  801d8a:	6a 14                	push   $0x14
  801d8c:	e8 b0 fd ff ff       	call   801b41 <syscall>
  801d91:	83 c4 18             	add    $0x18,%esp
}
  801d94:	90                   	nop
  801d95:	c9                   	leave  
  801d96:	c3                   	ret    

00801d97 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d97:	55                   	push   %ebp
  801d98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 15                	push   $0x15
  801da6:	e8 96 fd ff ff       	call   801b41 <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
}
  801dae:	90                   	nop
  801daf:	c9                   	leave  
  801db0:	c3                   	ret    

00801db1 <sys_cputc>:


void
sys_cputc(const char c)
{
  801db1:	55                   	push   %ebp
  801db2:	89 e5                	mov    %esp,%ebp
  801db4:	83 ec 04             	sub    $0x4,%esp
  801db7:	8b 45 08             	mov    0x8(%ebp),%eax
  801dba:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801dbd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	50                   	push   %eax
  801dca:	6a 16                	push   $0x16
  801dcc:	e8 70 fd ff ff       	call   801b41 <syscall>
  801dd1:	83 c4 18             	add    $0x18,%esp
}
  801dd4:	90                   	nop
  801dd5:	c9                   	leave  
  801dd6:	c3                   	ret    

00801dd7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801dd7:	55                   	push   %ebp
  801dd8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	6a 17                	push   $0x17
  801de6:	e8 56 fd ff ff       	call   801b41 <syscall>
  801deb:	83 c4 18             	add    $0x18,%esp
}
  801dee:	90                   	nop
  801def:	c9                   	leave  
  801df0:	c3                   	ret    

00801df1 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801df1:	55                   	push   %ebp
  801df2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801df4:	8b 45 08             	mov    0x8(%ebp),%eax
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	ff 75 0c             	pushl  0xc(%ebp)
  801e00:	50                   	push   %eax
  801e01:	6a 18                	push   $0x18
  801e03:	e8 39 fd ff ff       	call   801b41 <syscall>
  801e08:	83 c4 18             	add    $0x18,%esp
}
  801e0b:	c9                   	leave  
  801e0c:	c3                   	ret    

00801e0d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e0d:	55                   	push   %ebp
  801e0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e10:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e13:	8b 45 08             	mov    0x8(%ebp),%eax
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	52                   	push   %edx
  801e1d:	50                   	push   %eax
  801e1e:	6a 1b                	push   $0x1b
  801e20:	e8 1c fd ff ff       	call   801b41 <syscall>
  801e25:	83 c4 18             	add    $0x18,%esp
}
  801e28:	c9                   	leave  
  801e29:	c3                   	ret    

00801e2a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e2a:	55                   	push   %ebp
  801e2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e30:	8b 45 08             	mov    0x8(%ebp),%eax
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	6a 00                	push   $0x0
  801e39:	52                   	push   %edx
  801e3a:	50                   	push   %eax
  801e3b:	6a 19                	push   $0x19
  801e3d:	e8 ff fc ff ff       	call   801b41 <syscall>
  801e42:	83 c4 18             	add    $0x18,%esp
}
  801e45:	90                   	nop
  801e46:	c9                   	leave  
  801e47:	c3                   	ret    

00801e48 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e48:	55                   	push   %ebp
  801e49:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	52                   	push   %edx
  801e58:	50                   	push   %eax
  801e59:	6a 1a                	push   $0x1a
  801e5b:	e8 e1 fc ff ff       	call   801b41 <syscall>
  801e60:	83 c4 18             	add    $0x18,%esp
}
  801e63:	90                   	nop
  801e64:	c9                   	leave  
  801e65:	c3                   	ret    

00801e66 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801e66:	55                   	push   %ebp
  801e67:	89 e5                	mov    %esp,%ebp
  801e69:	83 ec 04             	sub    $0x4,%esp
  801e6c:	8b 45 10             	mov    0x10(%ebp),%eax
  801e6f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e72:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e75:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e79:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7c:	6a 00                	push   $0x0
  801e7e:	51                   	push   %ecx
  801e7f:	52                   	push   %edx
  801e80:	ff 75 0c             	pushl  0xc(%ebp)
  801e83:	50                   	push   %eax
  801e84:	6a 1c                	push   $0x1c
  801e86:	e8 b6 fc ff ff       	call   801b41 <syscall>
  801e8b:	83 c4 18             	add    $0x18,%esp
}
  801e8e:	c9                   	leave  
  801e8f:	c3                   	ret    

00801e90 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e90:	55                   	push   %ebp
  801e91:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e93:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e96:	8b 45 08             	mov    0x8(%ebp),%eax
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 00                	push   $0x0
  801e9f:	52                   	push   %edx
  801ea0:	50                   	push   %eax
  801ea1:	6a 1d                	push   $0x1d
  801ea3:	e8 99 fc ff ff       	call   801b41 <syscall>
  801ea8:	83 c4 18             	add    $0x18,%esp
}
  801eab:	c9                   	leave  
  801eac:	c3                   	ret    

00801ead <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ead:	55                   	push   %ebp
  801eae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801eb0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801eb3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb9:	6a 00                	push   $0x0
  801ebb:	6a 00                	push   $0x0
  801ebd:	51                   	push   %ecx
  801ebe:	52                   	push   %edx
  801ebf:	50                   	push   %eax
  801ec0:	6a 1e                	push   $0x1e
  801ec2:	e8 7a fc ff ff       	call   801b41 <syscall>
  801ec7:	83 c4 18             	add    $0x18,%esp
}
  801eca:	c9                   	leave  
  801ecb:	c3                   	ret    

00801ecc <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ecc:	55                   	push   %ebp
  801ecd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ecf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 00                	push   $0x0
  801edb:	52                   	push   %edx
  801edc:	50                   	push   %eax
  801edd:	6a 1f                	push   $0x1f
  801edf:	e8 5d fc ff ff       	call   801b41 <syscall>
  801ee4:	83 c4 18             	add    $0x18,%esp
}
  801ee7:	c9                   	leave  
  801ee8:	c3                   	ret    

00801ee9 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ee9:	55                   	push   %ebp
  801eea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 20                	push   $0x20
  801ef8:	e8 44 fc ff ff       	call   801b41 <syscall>
  801efd:	83 c4 18             	add    $0x18,%esp
}
  801f00:	c9                   	leave  
  801f01:	c3                   	ret    

00801f02 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801f02:	55                   	push   %ebp
  801f03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f05:	8b 45 08             	mov    0x8(%ebp),%eax
  801f08:	6a 00                	push   $0x0
  801f0a:	ff 75 14             	pushl  0x14(%ebp)
  801f0d:	ff 75 10             	pushl  0x10(%ebp)
  801f10:	ff 75 0c             	pushl  0xc(%ebp)
  801f13:	50                   	push   %eax
  801f14:	6a 21                	push   $0x21
  801f16:	e8 26 fc ff ff       	call   801b41 <syscall>
  801f1b:	83 c4 18             	add    $0x18,%esp
}
  801f1e:	c9                   	leave  
  801f1f:	c3                   	ret    

00801f20 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801f20:	55                   	push   %ebp
  801f21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f23:	8b 45 08             	mov    0x8(%ebp),%eax
  801f26:	6a 00                	push   $0x0
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	50                   	push   %eax
  801f2f:	6a 22                	push   $0x22
  801f31:	e8 0b fc ff ff       	call   801b41 <syscall>
  801f36:	83 c4 18             	add    $0x18,%esp
}
  801f39:	90                   	nop
  801f3a:	c9                   	leave  
  801f3b:	c3                   	ret    

00801f3c <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f3c:	55                   	push   %ebp
  801f3d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	50                   	push   %eax
  801f4b:	6a 23                	push   $0x23
  801f4d:	e8 ef fb ff ff       	call   801b41 <syscall>
  801f52:	83 c4 18             	add    $0x18,%esp
}
  801f55:	90                   	nop
  801f56:	c9                   	leave  
  801f57:	c3                   	ret    

00801f58 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f58:	55                   	push   %ebp
  801f59:	89 e5                	mov    %esp,%ebp
  801f5b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f5e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f61:	8d 50 04             	lea    0x4(%eax),%edx
  801f64:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	52                   	push   %edx
  801f6e:	50                   	push   %eax
  801f6f:	6a 24                	push   $0x24
  801f71:	e8 cb fb ff ff       	call   801b41 <syscall>
  801f76:	83 c4 18             	add    $0x18,%esp
	return result;
  801f79:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f7f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f82:	89 01                	mov    %eax,(%ecx)
  801f84:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f87:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8a:	c9                   	leave  
  801f8b:	c2 04 00             	ret    $0x4

00801f8e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f8e:	55                   	push   %ebp
  801f8f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	ff 75 10             	pushl  0x10(%ebp)
  801f98:	ff 75 0c             	pushl  0xc(%ebp)
  801f9b:	ff 75 08             	pushl  0x8(%ebp)
  801f9e:	6a 13                	push   $0x13
  801fa0:	e8 9c fb ff ff       	call   801b41 <syscall>
  801fa5:	83 c4 18             	add    $0x18,%esp
	return ;
  801fa8:	90                   	nop
}
  801fa9:	c9                   	leave  
  801faa:	c3                   	ret    

00801fab <sys_rcr2>:
uint32 sys_rcr2()
{
  801fab:	55                   	push   %ebp
  801fac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 25                	push   $0x25
  801fba:	e8 82 fb ff ff       	call   801b41 <syscall>
  801fbf:	83 c4 18             	add    $0x18,%esp
}
  801fc2:	c9                   	leave  
  801fc3:	c3                   	ret    

00801fc4 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801fc4:	55                   	push   %ebp
  801fc5:	89 e5                	mov    %esp,%ebp
  801fc7:	83 ec 04             	sub    $0x4,%esp
  801fca:	8b 45 08             	mov    0x8(%ebp),%eax
  801fcd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801fd0:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	50                   	push   %eax
  801fdd:	6a 26                	push   $0x26
  801fdf:	e8 5d fb ff ff       	call   801b41 <syscall>
  801fe4:	83 c4 18             	add    $0x18,%esp
	return ;
  801fe7:	90                   	nop
}
  801fe8:	c9                   	leave  
  801fe9:	c3                   	ret    

00801fea <rsttst>:
void rsttst()
{
  801fea:	55                   	push   %ebp
  801feb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 28                	push   $0x28
  801ff9:	e8 43 fb ff ff       	call   801b41 <syscall>
  801ffe:	83 c4 18             	add    $0x18,%esp
	return ;
  802001:	90                   	nop
}
  802002:	c9                   	leave  
  802003:	c3                   	ret    

00802004 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802004:	55                   	push   %ebp
  802005:	89 e5                	mov    %esp,%ebp
  802007:	83 ec 04             	sub    $0x4,%esp
  80200a:	8b 45 14             	mov    0x14(%ebp),%eax
  80200d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802010:	8b 55 18             	mov    0x18(%ebp),%edx
  802013:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802017:	52                   	push   %edx
  802018:	50                   	push   %eax
  802019:	ff 75 10             	pushl  0x10(%ebp)
  80201c:	ff 75 0c             	pushl  0xc(%ebp)
  80201f:	ff 75 08             	pushl  0x8(%ebp)
  802022:	6a 27                	push   $0x27
  802024:	e8 18 fb ff ff       	call   801b41 <syscall>
  802029:	83 c4 18             	add    $0x18,%esp
	return ;
  80202c:	90                   	nop
}
  80202d:	c9                   	leave  
  80202e:	c3                   	ret    

0080202f <chktst>:
void chktst(uint32 n)
{
  80202f:	55                   	push   %ebp
  802030:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802032:	6a 00                	push   $0x0
  802034:	6a 00                	push   $0x0
  802036:	6a 00                	push   $0x0
  802038:	6a 00                	push   $0x0
  80203a:	ff 75 08             	pushl  0x8(%ebp)
  80203d:	6a 29                	push   $0x29
  80203f:	e8 fd fa ff ff       	call   801b41 <syscall>
  802044:	83 c4 18             	add    $0x18,%esp
	return ;
  802047:	90                   	nop
}
  802048:	c9                   	leave  
  802049:	c3                   	ret    

0080204a <inctst>:

void inctst()
{
  80204a:	55                   	push   %ebp
  80204b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	6a 00                	push   $0x0
  802055:	6a 00                	push   $0x0
  802057:	6a 2a                	push   $0x2a
  802059:	e8 e3 fa ff ff       	call   801b41 <syscall>
  80205e:	83 c4 18             	add    $0x18,%esp
	return ;
  802061:	90                   	nop
}
  802062:	c9                   	leave  
  802063:	c3                   	ret    

00802064 <gettst>:
uint32 gettst()
{
  802064:	55                   	push   %ebp
  802065:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	6a 00                	push   $0x0
  80206d:	6a 00                	push   $0x0
  80206f:	6a 00                	push   $0x0
  802071:	6a 2b                	push   $0x2b
  802073:	e8 c9 fa ff ff       	call   801b41 <syscall>
  802078:	83 c4 18             	add    $0x18,%esp
}
  80207b:	c9                   	leave  
  80207c:	c3                   	ret    

0080207d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80207d:	55                   	push   %ebp
  80207e:	89 e5                	mov    %esp,%ebp
  802080:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802083:	6a 00                	push   $0x0
  802085:	6a 00                	push   $0x0
  802087:	6a 00                	push   $0x0
  802089:	6a 00                	push   $0x0
  80208b:	6a 00                	push   $0x0
  80208d:	6a 2c                	push   $0x2c
  80208f:	e8 ad fa ff ff       	call   801b41 <syscall>
  802094:	83 c4 18             	add    $0x18,%esp
  802097:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80209a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80209e:	75 07                	jne    8020a7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8020a0:	b8 01 00 00 00       	mov    $0x1,%eax
  8020a5:	eb 05                	jmp    8020ac <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8020a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020ac:	c9                   	leave  
  8020ad:	c3                   	ret    

008020ae <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8020ae:	55                   	push   %ebp
  8020af:	89 e5                	mov    %esp,%ebp
  8020b1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 2c                	push   $0x2c
  8020c0:	e8 7c fa ff ff       	call   801b41 <syscall>
  8020c5:	83 c4 18             	add    $0x18,%esp
  8020c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8020cb:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8020cf:	75 07                	jne    8020d8 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8020d1:	b8 01 00 00 00       	mov    $0x1,%eax
  8020d6:	eb 05                	jmp    8020dd <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8020d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020dd:	c9                   	leave  
  8020de:	c3                   	ret    

008020df <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8020df:	55                   	push   %ebp
  8020e0:	89 e5                	mov    %esp,%ebp
  8020e2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 2c                	push   $0x2c
  8020f1:	e8 4b fa ff ff       	call   801b41 <syscall>
  8020f6:	83 c4 18             	add    $0x18,%esp
  8020f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8020fc:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802100:	75 07                	jne    802109 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802102:	b8 01 00 00 00       	mov    $0x1,%eax
  802107:	eb 05                	jmp    80210e <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802109:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80210e:	c9                   	leave  
  80210f:	c3                   	ret    

00802110 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802110:	55                   	push   %ebp
  802111:	89 e5                	mov    %esp,%ebp
  802113:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	6a 00                	push   $0x0
  80211c:	6a 00                	push   $0x0
  80211e:	6a 00                	push   $0x0
  802120:	6a 2c                	push   $0x2c
  802122:	e8 1a fa ff ff       	call   801b41 <syscall>
  802127:	83 c4 18             	add    $0x18,%esp
  80212a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80212d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802131:	75 07                	jne    80213a <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802133:	b8 01 00 00 00       	mov    $0x1,%eax
  802138:	eb 05                	jmp    80213f <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80213a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80213f:	c9                   	leave  
  802140:	c3                   	ret    

00802141 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802141:	55                   	push   %ebp
  802142:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	ff 75 08             	pushl  0x8(%ebp)
  80214f:	6a 2d                	push   $0x2d
  802151:	e8 eb f9 ff ff       	call   801b41 <syscall>
  802156:	83 c4 18             	add    $0x18,%esp
	return ;
  802159:	90                   	nop
}
  80215a:	c9                   	leave  
  80215b:	c3                   	ret    

0080215c <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80215c:	55                   	push   %ebp
  80215d:	89 e5                	mov    %esp,%ebp
  80215f:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802160:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802163:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802166:	8b 55 0c             	mov    0xc(%ebp),%edx
  802169:	8b 45 08             	mov    0x8(%ebp),%eax
  80216c:	6a 00                	push   $0x0
  80216e:	53                   	push   %ebx
  80216f:	51                   	push   %ecx
  802170:	52                   	push   %edx
  802171:	50                   	push   %eax
  802172:	6a 2e                	push   $0x2e
  802174:	e8 c8 f9 ff ff       	call   801b41 <syscall>
  802179:	83 c4 18             	add    $0x18,%esp
}
  80217c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80217f:	c9                   	leave  
  802180:	c3                   	ret    

00802181 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802181:	55                   	push   %ebp
  802182:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802184:	8b 55 0c             	mov    0xc(%ebp),%edx
  802187:	8b 45 08             	mov    0x8(%ebp),%eax
  80218a:	6a 00                	push   $0x0
  80218c:	6a 00                	push   $0x0
  80218e:	6a 00                	push   $0x0
  802190:	52                   	push   %edx
  802191:	50                   	push   %eax
  802192:	6a 2f                	push   $0x2f
  802194:	e8 a8 f9 ff ff       	call   801b41 <syscall>
  802199:	83 c4 18             	add    $0x18,%esp
}
  80219c:	c9                   	leave  
  80219d:	c3                   	ret    

0080219e <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80219e:	55                   	push   %ebp
  80219f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8021a1:	6a 00                	push   $0x0
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 00                	push   $0x0
  8021a7:	ff 75 0c             	pushl  0xc(%ebp)
  8021aa:	ff 75 08             	pushl  0x8(%ebp)
  8021ad:	6a 30                	push   $0x30
  8021af:	e8 8d f9 ff ff       	call   801b41 <syscall>
  8021b4:	83 c4 18             	add    $0x18,%esp
	return ;
  8021b7:	90                   	nop
}
  8021b8:	c9                   	leave  
  8021b9:	c3                   	ret    
  8021ba:	66 90                	xchg   %ax,%ax

008021bc <__udivdi3>:
  8021bc:	55                   	push   %ebp
  8021bd:	57                   	push   %edi
  8021be:	56                   	push   %esi
  8021bf:	53                   	push   %ebx
  8021c0:	83 ec 1c             	sub    $0x1c,%esp
  8021c3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021c7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021cb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021cf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021d3:	89 ca                	mov    %ecx,%edx
  8021d5:	89 f8                	mov    %edi,%eax
  8021d7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021db:	85 f6                	test   %esi,%esi
  8021dd:	75 2d                	jne    80220c <__udivdi3+0x50>
  8021df:	39 cf                	cmp    %ecx,%edi
  8021e1:	77 65                	ja     802248 <__udivdi3+0x8c>
  8021e3:	89 fd                	mov    %edi,%ebp
  8021e5:	85 ff                	test   %edi,%edi
  8021e7:	75 0b                	jne    8021f4 <__udivdi3+0x38>
  8021e9:	b8 01 00 00 00       	mov    $0x1,%eax
  8021ee:	31 d2                	xor    %edx,%edx
  8021f0:	f7 f7                	div    %edi
  8021f2:	89 c5                	mov    %eax,%ebp
  8021f4:	31 d2                	xor    %edx,%edx
  8021f6:	89 c8                	mov    %ecx,%eax
  8021f8:	f7 f5                	div    %ebp
  8021fa:	89 c1                	mov    %eax,%ecx
  8021fc:	89 d8                	mov    %ebx,%eax
  8021fe:	f7 f5                	div    %ebp
  802200:	89 cf                	mov    %ecx,%edi
  802202:	89 fa                	mov    %edi,%edx
  802204:	83 c4 1c             	add    $0x1c,%esp
  802207:	5b                   	pop    %ebx
  802208:	5e                   	pop    %esi
  802209:	5f                   	pop    %edi
  80220a:	5d                   	pop    %ebp
  80220b:	c3                   	ret    
  80220c:	39 ce                	cmp    %ecx,%esi
  80220e:	77 28                	ja     802238 <__udivdi3+0x7c>
  802210:	0f bd fe             	bsr    %esi,%edi
  802213:	83 f7 1f             	xor    $0x1f,%edi
  802216:	75 40                	jne    802258 <__udivdi3+0x9c>
  802218:	39 ce                	cmp    %ecx,%esi
  80221a:	72 0a                	jb     802226 <__udivdi3+0x6a>
  80221c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802220:	0f 87 9e 00 00 00    	ja     8022c4 <__udivdi3+0x108>
  802226:	b8 01 00 00 00       	mov    $0x1,%eax
  80222b:	89 fa                	mov    %edi,%edx
  80222d:	83 c4 1c             	add    $0x1c,%esp
  802230:	5b                   	pop    %ebx
  802231:	5e                   	pop    %esi
  802232:	5f                   	pop    %edi
  802233:	5d                   	pop    %ebp
  802234:	c3                   	ret    
  802235:	8d 76 00             	lea    0x0(%esi),%esi
  802238:	31 ff                	xor    %edi,%edi
  80223a:	31 c0                	xor    %eax,%eax
  80223c:	89 fa                	mov    %edi,%edx
  80223e:	83 c4 1c             	add    $0x1c,%esp
  802241:	5b                   	pop    %ebx
  802242:	5e                   	pop    %esi
  802243:	5f                   	pop    %edi
  802244:	5d                   	pop    %ebp
  802245:	c3                   	ret    
  802246:	66 90                	xchg   %ax,%ax
  802248:	89 d8                	mov    %ebx,%eax
  80224a:	f7 f7                	div    %edi
  80224c:	31 ff                	xor    %edi,%edi
  80224e:	89 fa                	mov    %edi,%edx
  802250:	83 c4 1c             	add    $0x1c,%esp
  802253:	5b                   	pop    %ebx
  802254:	5e                   	pop    %esi
  802255:	5f                   	pop    %edi
  802256:	5d                   	pop    %ebp
  802257:	c3                   	ret    
  802258:	bd 20 00 00 00       	mov    $0x20,%ebp
  80225d:	89 eb                	mov    %ebp,%ebx
  80225f:	29 fb                	sub    %edi,%ebx
  802261:	89 f9                	mov    %edi,%ecx
  802263:	d3 e6                	shl    %cl,%esi
  802265:	89 c5                	mov    %eax,%ebp
  802267:	88 d9                	mov    %bl,%cl
  802269:	d3 ed                	shr    %cl,%ebp
  80226b:	89 e9                	mov    %ebp,%ecx
  80226d:	09 f1                	or     %esi,%ecx
  80226f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802273:	89 f9                	mov    %edi,%ecx
  802275:	d3 e0                	shl    %cl,%eax
  802277:	89 c5                	mov    %eax,%ebp
  802279:	89 d6                	mov    %edx,%esi
  80227b:	88 d9                	mov    %bl,%cl
  80227d:	d3 ee                	shr    %cl,%esi
  80227f:	89 f9                	mov    %edi,%ecx
  802281:	d3 e2                	shl    %cl,%edx
  802283:	8b 44 24 08          	mov    0x8(%esp),%eax
  802287:	88 d9                	mov    %bl,%cl
  802289:	d3 e8                	shr    %cl,%eax
  80228b:	09 c2                	or     %eax,%edx
  80228d:	89 d0                	mov    %edx,%eax
  80228f:	89 f2                	mov    %esi,%edx
  802291:	f7 74 24 0c          	divl   0xc(%esp)
  802295:	89 d6                	mov    %edx,%esi
  802297:	89 c3                	mov    %eax,%ebx
  802299:	f7 e5                	mul    %ebp
  80229b:	39 d6                	cmp    %edx,%esi
  80229d:	72 19                	jb     8022b8 <__udivdi3+0xfc>
  80229f:	74 0b                	je     8022ac <__udivdi3+0xf0>
  8022a1:	89 d8                	mov    %ebx,%eax
  8022a3:	31 ff                	xor    %edi,%edi
  8022a5:	e9 58 ff ff ff       	jmp    802202 <__udivdi3+0x46>
  8022aa:	66 90                	xchg   %ax,%ax
  8022ac:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022b0:	89 f9                	mov    %edi,%ecx
  8022b2:	d3 e2                	shl    %cl,%edx
  8022b4:	39 c2                	cmp    %eax,%edx
  8022b6:	73 e9                	jae    8022a1 <__udivdi3+0xe5>
  8022b8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022bb:	31 ff                	xor    %edi,%edi
  8022bd:	e9 40 ff ff ff       	jmp    802202 <__udivdi3+0x46>
  8022c2:	66 90                	xchg   %ax,%ax
  8022c4:	31 c0                	xor    %eax,%eax
  8022c6:	e9 37 ff ff ff       	jmp    802202 <__udivdi3+0x46>
  8022cb:	90                   	nop

008022cc <__umoddi3>:
  8022cc:	55                   	push   %ebp
  8022cd:	57                   	push   %edi
  8022ce:	56                   	push   %esi
  8022cf:	53                   	push   %ebx
  8022d0:	83 ec 1c             	sub    $0x1c,%esp
  8022d3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022d7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022db:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022df:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022e3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022e7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022eb:	89 f3                	mov    %esi,%ebx
  8022ed:	89 fa                	mov    %edi,%edx
  8022ef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022f3:	89 34 24             	mov    %esi,(%esp)
  8022f6:	85 c0                	test   %eax,%eax
  8022f8:	75 1a                	jne    802314 <__umoddi3+0x48>
  8022fa:	39 f7                	cmp    %esi,%edi
  8022fc:	0f 86 a2 00 00 00    	jbe    8023a4 <__umoddi3+0xd8>
  802302:	89 c8                	mov    %ecx,%eax
  802304:	89 f2                	mov    %esi,%edx
  802306:	f7 f7                	div    %edi
  802308:	89 d0                	mov    %edx,%eax
  80230a:	31 d2                	xor    %edx,%edx
  80230c:	83 c4 1c             	add    $0x1c,%esp
  80230f:	5b                   	pop    %ebx
  802310:	5e                   	pop    %esi
  802311:	5f                   	pop    %edi
  802312:	5d                   	pop    %ebp
  802313:	c3                   	ret    
  802314:	39 f0                	cmp    %esi,%eax
  802316:	0f 87 ac 00 00 00    	ja     8023c8 <__umoddi3+0xfc>
  80231c:	0f bd e8             	bsr    %eax,%ebp
  80231f:	83 f5 1f             	xor    $0x1f,%ebp
  802322:	0f 84 ac 00 00 00    	je     8023d4 <__umoddi3+0x108>
  802328:	bf 20 00 00 00       	mov    $0x20,%edi
  80232d:	29 ef                	sub    %ebp,%edi
  80232f:	89 fe                	mov    %edi,%esi
  802331:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802335:	89 e9                	mov    %ebp,%ecx
  802337:	d3 e0                	shl    %cl,%eax
  802339:	89 d7                	mov    %edx,%edi
  80233b:	89 f1                	mov    %esi,%ecx
  80233d:	d3 ef                	shr    %cl,%edi
  80233f:	09 c7                	or     %eax,%edi
  802341:	89 e9                	mov    %ebp,%ecx
  802343:	d3 e2                	shl    %cl,%edx
  802345:	89 14 24             	mov    %edx,(%esp)
  802348:	89 d8                	mov    %ebx,%eax
  80234a:	d3 e0                	shl    %cl,%eax
  80234c:	89 c2                	mov    %eax,%edx
  80234e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802352:	d3 e0                	shl    %cl,%eax
  802354:	89 44 24 04          	mov    %eax,0x4(%esp)
  802358:	8b 44 24 08          	mov    0x8(%esp),%eax
  80235c:	89 f1                	mov    %esi,%ecx
  80235e:	d3 e8                	shr    %cl,%eax
  802360:	09 d0                	or     %edx,%eax
  802362:	d3 eb                	shr    %cl,%ebx
  802364:	89 da                	mov    %ebx,%edx
  802366:	f7 f7                	div    %edi
  802368:	89 d3                	mov    %edx,%ebx
  80236a:	f7 24 24             	mull   (%esp)
  80236d:	89 c6                	mov    %eax,%esi
  80236f:	89 d1                	mov    %edx,%ecx
  802371:	39 d3                	cmp    %edx,%ebx
  802373:	0f 82 87 00 00 00    	jb     802400 <__umoddi3+0x134>
  802379:	0f 84 91 00 00 00    	je     802410 <__umoddi3+0x144>
  80237f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802383:	29 f2                	sub    %esi,%edx
  802385:	19 cb                	sbb    %ecx,%ebx
  802387:	89 d8                	mov    %ebx,%eax
  802389:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80238d:	d3 e0                	shl    %cl,%eax
  80238f:	89 e9                	mov    %ebp,%ecx
  802391:	d3 ea                	shr    %cl,%edx
  802393:	09 d0                	or     %edx,%eax
  802395:	89 e9                	mov    %ebp,%ecx
  802397:	d3 eb                	shr    %cl,%ebx
  802399:	89 da                	mov    %ebx,%edx
  80239b:	83 c4 1c             	add    $0x1c,%esp
  80239e:	5b                   	pop    %ebx
  80239f:	5e                   	pop    %esi
  8023a0:	5f                   	pop    %edi
  8023a1:	5d                   	pop    %ebp
  8023a2:	c3                   	ret    
  8023a3:	90                   	nop
  8023a4:	89 fd                	mov    %edi,%ebp
  8023a6:	85 ff                	test   %edi,%edi
  8023a8:	75 0b                	jne    8023b5 <__umoddi3+0xe9>
  8023aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8023af:	31 d2                	xor    %edx,%edx
  8023b1:	f7 f7                	div    %edi
  8023b3:	89 c5                	mov    %eax,%ebp
  8023b5:	89 f0                	mov    %esi,%eax
  8023b7:	31 d2                	xor    %edx,%edx
  8023b9:	f7 f5                	div    %ebp
  8023bb:	89 c8                	mov    %ecx,%eax
  8023bd:	f7 f5                	div    %ebp
  8023bf:	89 d0                	mov    %edx,%eax
  8023c1:	e9 44 ff ff ff       	jmp    80230a <__umoddi3+0x3e>
  8023c6:	66 90                	xchg   %ax,%ax
  8023c8:	89 c8                	mov    %ecx,%eax
  8023ca:	89 f2                	mov    %esi,%edx
  8023cc:	83 c4 1c             	add    $0x1c,%esp
  8023cf:	5b                   	pop    %ebx
  8023d0:	5e                   	pop    %esi
  8023d1:	5f                   	pop    %edi
  8023d2:	5d                   	pop    %ebp
  8023d3:	c3                   	ret    
  8023d4:	3b 04 24             	cmp    (%esp),%eax
  8023d7:	72 06                	jb     8023df <__umoddi3+0x113>
  8023d9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023dd:	77 0f                	ja     8023ee <__umoddi3+0x122>
  8023df:	89 f2                	mov    %esi,%edx
  8023e1:	29 f9                	sub    %edi,%ecx
  8023e3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023e7:	89 14 24             	mov    %edx,(%esp)
  8023ea:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023ee:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023f2:	8b 14 24             	mov    (%esp),%edx
  8023f5:	83 c4 1c             	add    $0x1c,%esp
  8023f8:	5b                   	pop    %ebx
  8023f9:	5e                   	pop    %esi
  8023fa:	5f                   	pop    %edi
  8023fb:	5d                   	pop    %ebp
  8023fc:	c3                   	ret    
  8023fd:	8d 76 00             	lea    0x0(%esi),%esi
  802400:	2b 04 24             	sub    (%esp),%eax
  802403:	19 fa                	sbb    %edi,%edx
  802405:	89 d1                	mov    %edx,%ecx
  802407:	89 c6                	mov    %eax,%esi
  802409:	e9 71 ff ff ff       	jmp    80237f <__umoddi3+0xb3>
  80240e:	66 90                	xchg   %ax,%ax
  802410:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802414:	72 ea                	jb     802400 <__umoddi3+0x134>
  802416:	89 d9                	mov    %ebx,%ecx
  802418:	e9 62 ff ff ff       	jmp    80237f <__umoddi3+0xb3>
