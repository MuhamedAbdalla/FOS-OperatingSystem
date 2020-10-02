
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
  800031:	e8 b6 05 00 00       	call   8005ec <libmain>
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
  80004b:	eb 23                	jmp    800070 <_main+0x38>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004d:	a1 20 30 80 00       	mov    0x803020,%eax
  800052:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800058:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005b:	c1 e2 04             	shl    $0x4,%edx
  80005e:	01 d0                	add    %edx,%eax
  800060:	8a 40 04             	mov    0x4(%eax),%al
  800063:	84 c0                	test   %al,%al
  800065:	74 06                	je     80006d <_main+0x35>
			{
				fullWS = 0;
  800067:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006b:	eb 12                	jmp    80007f <_main+0x47>
void _main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80006d:	ff 45 f0             	incl   -0x10(%ebp)
  800070:	a1 20 30 80 00       	mov    0x803020,%eax
  800075:	8b 50 74             	mov    0x74(%eax),%edx
  800078:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007b:	39 c2                	cmp    %eax,%edx
  80007d:	77 ce                	ja     80004d <_main+0x15>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80007f:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800083:	74 14                	je     800099 <_main+0x61>
  800085:	83 ec 04             	sub    $0x4,%esp
  800088:	68 00 24 80 00       	push   $0x802400
  80008d:	6a 14                	push   $0x14
  80008f:	68 1c 24 80 00       	push   $0x80241c
  800094:	e8 98 06 00 00       	call   800731 <_panic>
	}


	int Mega = 1024*1024;
  800099:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000a0:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)

	void* ptr_allocations[20] = {0};
  8000a7:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000aa:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000af:	b8 00 00 00 00       	mov    $0x0,%eax
  8000b4:	89 d7                	mov    %edx,%edi
  8000b6:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		int freeFrames = sys_calculate_free_frames() ;
  8000b8:	e8 eb 1b 00 00       	call   801ca8 <sys_calculate_free_frames>
  8000bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000c0:	e8 66 1c 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  8000c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000cb:	01 c0                	add    %eax,%eax
  8000cd:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	50                   	push   %eax
  8000d4:	e8 84 16 00 00       	call   80175d <malloc>
  8000d9:	83 c4 10             	add    $0x10,%esp
  8000dc:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8000df:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e2:	85 c0                	test   %eax,%eax
  8000e4:	79 0a                	jns    8000f0 <_main+0xb8>
  8000e6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e9:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  8000ee:	76 14                	jbe    800104 <_main+0xcc>
  8000f0:	83 ec 04             	sub    $0x4,%esp
  8000f3:	68 30 24 80 00       	push   $0x802430
  8000f8:	6a 20                	push   $0x20
  8000fa:	68 1c 24 80 00       	push   $0x80241c
  8000ff:	e8 2d 06 00 00       	call   800731 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800104:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800107:	e8 9c 1b 00 00       	call   801ca8 <sys_calculate_free_frames>
  80010c:	29 c3                	sub    %eax,%ebx
  80010e:	89 d8                	mov    %ebx,%eax
  800110:	83 f8 01             	cmp    $0x1,%eax
  800113:	74 14                	je     800129 <_main+0xf1>
  800115:	83 ec 04             	sub    $0x4,%esp
  800118:	68 60 24 80 00       	push   $0x802460
  80011d:	6a 22                	push   $0x22
  80011f:	68 1c 24 80 00       	push   $0x80241c
  800124:	e8 08 06 00 00       	call   800731 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800129:	e8 fd 1b 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  80012e:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800131:	3d 00 02 00 00       	cmp    $0x200,%eax
  800136:	74 14                	je     80014c <_main+0x114>
  800138:	83 ec 04             	sub    $0x4,%esp
  80013b:	68 cc 24 80 00       	push   $0x8024cc
  800140:	6a 23                	push   $0x23
  800142:	68 1c 24 80 00       	push   $0x80241c
  800147:	e8 e5 05 00 00       	call   800731 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80014c:	e8 57 1b 00 00       	call   801ca8 <sys_calculate_free_frames>
  800151:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800154:	e8 d2 1b 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  800159:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80015c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80015f:	01 c0                	add    %eax,%eax
  800161:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800164:	83 ec 0c             	sub    $0xc,%esp
  800167:	50                   	push   %eax
  800168:	e8 f0 15 00 00       	call   80175d <malloc>
  80016d:	83 c4 10             	add    $0x10,%esp
  800170:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START + 2*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800173:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800176:	89 c2                	mov    %eax,%edx
  800178:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80017b:	01 c0                	add    %eax,%eax
  80017d:	05 00 00 00 80       	add    $0x80000000,%eax
  800182:	39 c2                	cmp    %eax,%edx
  800184:	72 13                	jb     800199 <_main+0x161>
  800186:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800189:	89 c2                	mov    %eax,%edx
  80018b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018e:	01 c0                	add    %eax,%eax
  800190:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800195:	39 c2                	cmp    %eax,%edx
  800197:	76 14                	jbe    8001ad <_main+0x175>
  800199:	83 ec 04             	sub    $0x4,%esp
  80019c:	68 30 24 80 00       	push   $0x802430
  8001a1:	6a 28                	push   $0x28
  8001a3:	68 1c 24 80 00       	push   $0x80241c
  8001a8:	e8 84 05 00 00       	call   800731 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		cprintf("wrong %d\n", (freeFrames - sys_calculate_free_frames()));
  8001ad:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8001b0:	e8 f3 1a 00 00       	call   801ca8 <sys_calculate_free_frames>
  8001b5:	29 c3                	sub    %eax,%ebx
  8001b7:	89 d8                	mov    %ebx,%eax
  8001b9:	83 ec 08             	sub    $0x8,%esp
  8001bc:	50                   	push   %eax
  8001bd:	68 fa 24 80 00       	push   $0x8024fa
  8001c2:	e8 0c 08 00 00       	call   8009d3 <cprintf>
  8001c7:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001ca:	e8 d9 1a 00 00       	call   801ca8 <sys_calculate_free_frames>
  8001cf:	89 c2                	mov    %eax,%edx
  8001d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001d4:	39 c2                	cmp    %eax,%edx
  8001d6:	74 14                	je     8001ec <_main+0x1b4>
  8001d8:	83 ec 04             	sub    $0x4,%esp
  8001db:	68 60 24 80 00       	push   $0x802460
  8001e0:	6a 2b                	push   $0x2b
  8001e2:	68 1c 24 80 00       	push   $0x80241c
  8001e7:	e8 45 05 00 00       	call   800731 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8001ec:	e8 3a 1b 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  8001f1:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001f4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001f9:	74 14                	je     80020f <_main+0x1d7>
  8001fb:	83 ec 04             	sub    $0x4,%esp
  8001fe:	68 cc 24 80 00       	push   $0x8024cc
  800203:	6a 2c                	push   $0x2c
  800205:	68 1c 24 80 00       	push   $0x80241c
  80020a:	e8 22 05 00 00       	call   800731 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80020f:	e8 94 1a 00 00       	call   801ca8 <sys_calculate_free_frames>
  800214:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800217:	e8 0f 1b 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  80021c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(3*kilo);
  80021f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800222:	89 c2                	mov    %eax,%edx
  800224:	01 d2                	add    %edx,%edx
  800226:	01 d0                	add    %edx,%eax
  800228:	83 ec 0c             	sub    $0xc,%esp
  80022b:	50                   	push   %eax
  80022c:	e8 2c 15 00 00       	call   80175d <malloc>
  800231:	83 c4 10             	add    $0x10,%esp
  800234:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START + 4*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800237:	8b 45 98             	mov    -0x68(%ebp),%eax
  80023a:	89 c2                	mov    %eax,%edx
  80023c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80023f:	c1 e0 02             	shl    $0x2,%eax
  800242:	05 00 00 00 80       	add    $0x80000000,%eax
  800247:	39 c2                	cmp    %eax,%edx
  800249:	72 14                	jb     80025f <_main+0x227>
  80024b:	8b 45 98             	mov    -0x68(%ebp),%eax
  80024e:	89 c2                	mov    %eax,%edx
  800250:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800253:	c1 e0 02             	shl    $0x2,%eax
  800256:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80025b:	39 c2                	cmp    %eax,%edx
  80025d:	76 14                	jbe    800273 <_main+0x23b>
  80025f:	83 ec 04             	sub    $0x4,%esp
  800262:	68 30 24 80 00       	push   $0x802430
  800267:	6a 31                	push   $0x31
  800269:	68 1c 24 80 00       	push   $0x80241c
  80026e:	e8 be 04 00 00       	call   800731 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800273:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800276:	e8 2d 1a 00 00       	call   801ca8 <sys_calculate_free_frames>
  80027b:	29 c3                	sub    %eax,%ebx
  80027d:	89 d8                	mov    %ebx,%eax
  80027f:	83 f8 01             	cmp    $0x1,%eax
  800282:	74 14                	je     800298 <_main+0x260>
  800284:	83 ec 04             	sub    $0x4,%esp
  800287:	68 60 24 80 00       	push   $0x802460
  80028c:	6a 33                	push   $0x33
  80028e:	68 1c 24 80 00       	push   $0x80241c
  800293:	e8 99 04 00 00       	call   800731 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800298:	e8 8e 1a 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  80029d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002a0:	83 f8 01             	cmp    $0x1,%eax
  8002a3:	74 14                	je     8002b9 <_main+0x281>
  8002a5:	83 ec 04             	sub    $0x4,%esp
  8002a8:	68 cc 24 80 00       	push   $0x8024cc
  8002ad:	6a 34                	push   $0x34
  8002af:	68 1c 24 80 00       	push   $0x80241c
  8002b4:	e8 78 04 00 00       	call   800731 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8002b9:	e8 ea 19 00 00       	call   801ca8 <sys_calculate_free_frames>
  8002be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002c1:	e8 65 1a 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  8002c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(3*kilo);
  8002c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002cc:	89 c2                	mov    %eax,%edx
  8002ce:	01 d2                	add    %edx,%edx
  8002d0:	01 d0                	add    %edx,%eax
  8002d2:	83 ec 0c             	sub    $0xc,%esp
  8002d5:	50                   	push   %eax
  8002d6:	e8 82 14 00 00       	call   80175d <malloc>
  8002db:	83 c4 10             	add    $0x10,%esp
  8002de:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START + 4*Mega + 4*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8002e1:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002e4:	89 c2                	mov    %eax,%edx
  8002e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002e9:	c1 e0 02             	shl    $0x2,%eax
  8002ec:	89 c1                	mov    %eax,%ecx
  8002ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002f1:	c1 e0 02             	shl    $0x2,%eax
  8002f4:	01 c8                	add    %ecx,%eax
  8002f6:	05 00 00 00 80       	add    $0x80000000,%eax
  8002fb:	39 c2                	cmp    %eax,%edx
  8002fd:	72 1e                	jb     80031d <_main+0x2e5>
  8002ff:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800302:	89 c2                	mov    %eax,%edx
  800304:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800307:	c1 e0 02             	shl    $0x2,%eax
  80030a:	89 c1                	mov    %eax,%ecx
  80030c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80030f:	c1 e0 02             	shl    $0x2,%eax
  800312:	01 c8                	add    %ecx,%eax
  800314:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800319:	39 c2                	cmp    %eax,%edx
  80031b:	76 14                	jbe    800331 <_main+0x2f9>
  80031d:	83 ec 04             	sub    $0x4,%esp
  800320:	68 30 24 80 00       	push   $0x802430
  800325:	6a 39                	push   $0x39
  800327:	68 1c 24 80 00       	push   $0x80241c
  80032c:	e8 00 04 00 00       	call   800731 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800331:	e8 72 19 00 00       	call   801ca8 <sys_calculate_free_frames>
  800336:	89 c2                	mov    %eax,%edx
  800338:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80033b:	39 c2                	cmp    %eax,%edx
  80033d:	74 14                	je     800353 <_main+0x31b>
  80033f:	83 ec 04             	sub    $0x4,%esp
  800342:	68 60 24 80 00       	push   $0x802460
  800347:	6a 3b                	push   $0x3b
  800349:	68 1c 24 80 00       	push   $0x80241c
  80034e:	e8 de 03 00 00       	call   800731 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800353:	e8 d3 19 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  800358:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80035b:	83 f8 01             	cmp    $0x1,%eax
  80035e:	74 14                	je     800374 <_main+0x33c>
  800360:	83 ec 04             	sub    $0x4,%esp
  800363:	68 cc 24 80 00       	push   $0x8024cc
  800368:	6a 3c                	push   $0x3c
  80036a:	68 1c 24 80 00       	push   $0x80241c
  80036f:	e8 bd 03 00 00       	call   800731 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800374:	e8 2f 19 00 00       	call   801ca8 <sys_calculate_free_frames>
  800379:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80037c:	e8 aa 19 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  800381:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800384:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800387:	89 d0                	mov    %edx,%eax
  800389:	01 c0                	add    %eax,%eax
  80038b:	01 d0                	add    %edx,%eax
  80038d:	01 c0                	add    %eax,%eax
  80038f:	01 d0                	add    %edx,%eax
  800391:	83 ec 0c             	sub    $0xc,%esp
  800394:	50                   	push   %eax
  800395:	e8 c3 13 00 00       	call   80175d <malloc>
  80039a:	83 c4 10             	add    $0x10,%esp
  80039d:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo) || (uint32) ptr_allocations[4] > (USER_HEAP_START + 4*Mega + 8*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8003a0:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003a3:	89 c2                	mov    %eax,%edx
  8003a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003a8:	c1 e0 02             	shl    $0x2,%eax
  8003ab:	89 c1                	mov    %eax,%ecx
  8003ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003b0:	c1 e0 03             	shl    $0x3,%eax
  8003b3:	01 c8                	add    %ecx,%eax
  8003b5:	05 00 00 00 80       	add    $0x80000000,%eax
  8003ba:	39 c2                	cmp    %eax,%edx
  8003bc:	72 1e                	jb     8003dc <_main+0x3a4>
  8003be:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003c1:	89 c2                	mov    %eax,%edx
  8003c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003c6:	c1 e0 02             	shl    $0x2,%eax
  8003c9:	89 c1                	mov    %eax,%ecx
  8003cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003ce:	c1 e0 03             	shl    $0x3,%eax
  8003d1:	01 c8                	add    %ecx,%eax
  8003d3:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8003d8:	39 c2                	cmp    %eax,%edx
  8003da:	76 14                	jbe    8003f0 <_main+0x3b8>
  8003dc:	83 ec 04             	sub    $0x4,%esp
  8003df:	68 30 24 80 00       	push   $0x802430
  8003e4:	6a 41                	push   $0x41
  8003e6:	68 1c 24 80 00       	push   $0x80241c
  8003eb:	e8 41 03 00 00       	call   800731 <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8003f0:	e8 b3 18 00 00       	call   801ca8 <sys_calculate_free_frames>
  8003f5:	89 c2                	mov    %eax,%edx
  8003f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003fa:	39 c2                	cmp    %eax,%edx
  8003fc:	74 14                	je     800412 <_main+0x3da>
  8003fe:	83 ec 04             	sub    $0x4,%esp
  800401:	68 60 24 80 00       	push   $0x802460
  800406:	6a 43                	push   $0x43
  800408:	68 1c 24 80 00       	push   $0x80241c
  80040d:	e8 1f 03 00 00       	call   800731 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  800412:	e8 14 19 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  800417:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80041a:	83 f8 02             	cmp    $0x2,%eax
  80041d:	74 14                	je     800433 <_main+0x3fb>
  80041f:	83 ec 04             	sub    $0x4,%esp
  800422:	68 cc 24 80 00       	push   $0x8024cc
  800427:	6a 44                	push   $0x44
  800429:	68 1c 24 80 00       	push   $0x80241c
  80042e:	e8 fe 02 00 00       	call   800731 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800433:	e8 70 18 00 00       	call   801ca8 <sys_calculate_free_frames>
  800438:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80043b:	e8 eb 18 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  800440:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800443:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800446:	89 c2                	mov    %eax,%edx
  800448:	01 d2                	add    %edx,%edx
  80044a:	01 d0                	add    %edx,%eax
  80044c:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80044f:	83 ec 0c             	sub    $0xc,%esp
  800452:	50                   	push   %eax
  800453:	e8 05 13 00 00       	call   80175d <malloc>
  800458:	83 c4 10             	add    $0x10,%esp
  80045b:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START + 4*Mega + 16*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  80045e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800461:	89 c2                	mov    %eax,%edx
  800463:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800466:	c1 e0 02             	shl    $0x2,%eax
  800469:	89 c1                	mov    %eax,%ecx
  80046b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80046e:	c1 e0 04             	shl    $0x4,%eax
  800471:	01 c8                	add    %ecx,%eax
  800473:	05 00 00 00 80       	add    $0x80000000,%eax
  800478:	39 c2                	cmp    %eax,%edx
  80047a:	72 1e                	jb     80049a <_main+0x462>
  80047c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80047f:	89 c2                	mov    %eax,%edx
  800481:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800484:	c1 e0 02             	shl    $0x2,%eax
  800487:	89 c1                	mov    %eax,%ecx
  800489:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80048c:	c1 e0 04             	shl    $0x4,%eax
  80048f:	01 c8                	add    %ecx,%eax
  800491:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800496:	39 c2                	cmp    %eax,%edx
  800498:	76 14                	jbe    8004ae <_main+0x476>
  80049a:	83 ec 04             	sub    $0x4,%esp
  80049d:	68 30 24 80 00       	push   $0x802430
  8004a2:	6a 49                	push   $0x49
  8004a4:	68 1c 24 80 00       	push   $0x80241c
  8004a9:	e8 83 02 00 00       	call   800731 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8004ae:	e8 f5 17 00 00       	call   801ca8 <sys_calculate_free_frames>
  8004b3:	89 c2                	mov    %eax,%edx
  8004b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004b8:	39 c2                	cmp    %eax,%edx
  8004ba:	74 14                	je     8004d0 <_main+0x498>
  8004bc:	83 ec 04             	sub    $0x4,%esp
  8004bf:	68 04 25 80 00       	push   $0x802504
  8004c4:	6a 4a                	push   $0x4a
  8004c6:	68 1c 24 80 00       	push   $0x80241c
  8004cb:	e8 61 02 00 00       	call   800731 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  8004d0:	e8 56 18 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  8004d5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004d8:	89 c2                	mov    %eax,%edx
  8004da:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004dd:	89 c1                	mov    %eax,%ecx
  8004df:	01 c9                	add    %ecx,%ecx
  8004e1:	01 c8                	add    %ecx,%eax
  8004e3:	85 c0                	test   %eax,%eax
  8004e5:	79 05                	jns    8004ec <_main+0x4b4>
  8004e7:	05 ff 0f 00 00       	add    $0xfff,%eax
  8004ec:	c1 f8 0c             	sar    $0xc,%eax
  8004ef:	39 c2                	cmp    %eax,%edx
  8004f1:	74 14                	je     800507 <_main+0x4cf>
  8004f3:	83 ec 04             	sub    $0x4,%esp
  8004f6:	68 cc 24 80 00       	push   $0x8024cc
  8004fb:	6a 4b                	push   $0x4b
  8004fd:	68 1c 24 80 00       	push   $0x80241c
  800502:	e8 2a 02 00 00       	call   800731 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800507:	e8 9c 17 00 00       	call   801ca8 <sys_calculate_free_frames>
  80050c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80050f:	e8 17 18 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  800514:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  800517:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80051a:	01 c0                	add    %eax,%eax
  80051c:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80051f:	83 ec 0c             	sub    $0xc,%esp
  800522:	50                   	push   %eax
  800523:	e8 35 12 00 00       	call   80175d <malloc>
  800528:	83 c4 10             	add    $0x10,%esp
  80052b:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START + 7*Mega + 16*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  80052e:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800531:	89 c1                	mov    %eax,%ecx
  800533:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800536:	89 d0                	mov    %edx,%eax
  800538:	01 c0                	add    %eax,%eax
  80053a:	01 d0                	add    %edx,%eax
  80053c:	01 c0                	add    %eax,%eax
  80053e:	01 d0                	add    %edx,%eax
  800540:	89 c2                	mov    %eax,%edx
  800542:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800545:	c1 e0 04             	shl    $0x4,%eax
  800548:	01 d0                	add    %edx,%eax
  80054a:	05 00 00 00 80       	add    $0x80000000,%eax
  80054f:	39 c1                	cmp    %eax,%ecx
  800551:	72 25                	jb     800578 <_main+0x540>
  800553:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800556:	89 c1                	mov    %eax,%ecx
  800558:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80055b:	89 d0                	mov    %edx,%eax
  80055d:	01 c0                	add    %eax,%eax
  80055f:	01 d0                	add    %edx,%eax
  800561:	01 c0                	add    %eax,%eax
  800563:	01 d0                	add    %edx,%eax
  800565:	89 c2                	mov    %eax,%edx
  800567:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80056a:	c1 e0 04             	shl    $0x4,%eax
  80056d:	01 d0                	add    %edx,%eax
  80056f:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800574:	39 c1                	cmp    %eax,%ecx
  800576:	76 14                	jbe    80058c <_main+0x554>
  800578:	83 ec 04             	sub    $0x4,%esp
  80057b:	68 30 24 80 00       	push   $0x802430
  800580:	6a 50                	push   $0x50
  800582:	68 1c 24 80 00       	push   $0x80241c
  800587:	e8 a5 01 00 00       	call   800731 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  80058c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80058f:	e8 14 17 00 00       	call   801ca8 <sys_calculate_free_frames>
  800594:	29 c3                	sub    %eax,%ebx
  800596:	89 d8                	mov    %ebx,%eax
  800598:	83 f8 01             	cmp    $0x1,%eax
  80059b:	74 14                	je     8005b1 <_main+0x579>
  80059d:	83 ec 04             	sub    $0x4,%esp
  8005a0:	68 04 25 80 00       	push   $0x802504
  8005a5:	6a 51                	push   $0x51
  8005a7:	68 1c 24 80 00       	push   $0x80241c
  8005ac:	e8 80 01 00 00       	call   800731 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8005b1:	e8 75 17 00 00       	call   801d2b <sys_pf_calculate_allocated_pages>
  8005b6:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8005b9:	3d 00 02 00 00       	cmp    $0x200,%eax
  8005be:	74 14                	je     8005d4 <_main+0x59c>
  8005c0:	83 ec 04             	sub    $0x4,%esp
  8005c3:	68 cc 24 80 00       	push   $0x8024cc
  8005c8:	6a 52                	push   $0x52
  8005ca:	68 1c 24 80 00       	push   $0x80241c
  8005cf:	e8 5d 01 00 00       	call   800731 <_panic>
	}

	cprintf("Congratulations!! test malloc (1) completed successfully.\n");
  8005d4:	83 ec 0c             	sub    $0xc,%esp
  8005d7:	68 18 25 80 00       	push   $0x802518
  8005dc:	e8 f2 03 00 00       	call   8009d3 <cprintf>
  8005e1:	83 c4 10             	add    $0x10,%esp

	return;
  8005e4:	90                   	nop
}
  8005e5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8005e8:	5b                   	pop    %ebx
  8005e9:	5f                   	pop    %edi
  8005ea:	5d                   	pop    %ebp
  8005eb:	c3                   	ret    

008005ec <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005ec:	55                   	push   %ebp
  8005ed:	89 e5                	mov    %esp,%ebp
  8005ef:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005f2:	e8 e6 15 00 00       	call   801bdd <sys_getenvindex>
  8005f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005fd:	89 d0                	mov    %edx,%eax
  8005ff:	c1 e0 03             	shl    $0x3,%eax
  800602:	01 d0                	add    %edx,%eax
  800604:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80060b:	01 c8                	add    %ecx,%eax
  80060d:	01 c0                	add    %eax,%eax
  80060f:	01 d0                	add    %edx,%eax
  800611:	01 c0                	add    %eax,%eax
  800613:	01 d0                	add    %edx,%eax
  800615:	89 c2                	mov    %eax,%edx
  800617:	c1 e2 05             	shl    $0x5,%edx
  80061a:	29 c2                	sub    %eax,%edx
  80061c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800623:	89 c2                	mov    %eax,%edx
  800625:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80062b:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800630:	a1 20 30 80 00       	mov    0x803020,%eax
  800635:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80063b:	84 c0                	test   %al,%al
  80063d:	74 0f                	je     80064e <libmain+0x62>
		binaryname = myEnv->prog_name;
  80063f:	a1 20 30 80 00       	mov    0x803020,%eax
  800644:	05 40 3c 01 00       	add    $0x13c40,%eax
  800649:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80064e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800652:	7e 0a                	jle    80065e <libmain+0x72>
		binaryname = argv[0];
  800654:	8b 45 0c             	mov    0xc(%ebp),%eax
  800657:	8b 00                	mov    (%eax),%eax
  800659:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80065e:	83 ec 08             	sub    $0x8,%esp
  800661:	ff 75 0c             	pushl  0xc(%ebp)
  800664:	ff 75 08             	pushl  0x8(%ebp)
  800667:	e8 cc f9 ff ff       	call   800038 <_main>
  80066c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80066f:	e8 04 17 00 00       	call   801d78 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800674:	83 ec 0c             	sub    $0xc,%esp
  800677:	68 6c 25 80 00       	push   $0x80256c
  80067c:	e8 52 03 00 00       	call   8009d3 <cprintf>
  800681:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800684:	a1 20 30 80 00       	mov    0x803020,%eax
  800689:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80068f:	a1 20 30 80 00       	mov    0x803020,%eax
  800694:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80069a:	83 ec 04             	sub    $0x4,%esp
  80069d:	52                   	push   %edx
  80069e:	50                   	push   %eax
  80069f:	68 94 25 80 00       	push   $0x802594
  8006a4:	e8 2a 03 00 00       	call   8009d3 <cprintf>
  8006a9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8006ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8006b1:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8006bc:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006c2:	83 ec 04             	sub    $0x4,%esp
  8006c5:	52                   	push   %edx
  8006c6:	50                   	push   %eax
  8006c7:	68 bc 25 80 00       	push   $0x8025bc
  8006cc:	e8 02 03 00 00       	call   8009d3 <cprintf>
  8006d1:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8006d9:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8006df:	83 ec 08             	sub    $0x8,%esp
  8006e2:	50                   	push   %eax
  8006e3:	68 fd 25 80 00       	push   $0x8025fd
  8006e8:	e8 e6 02 00 00       	call   8009d3 <cprintf>
  8006ed:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006f0:	83 ec 0c             	sub    $0xc,%esp
  8006f3:	68 6c 25 80 00       	push   $0x80256c
  8006f8:	e8 d6 02 00 00       	call   8009d3 <cprintf>
  8006fd:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800700:	e8 8d 16 00 00       	call   801d92 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800705:	e8 19 00 00 00       	call   800723 <exit>
}
  80070a:	90                   	nop
  80070b:	c9                   	leave  
  80070c:	c3                   	ret    

0080070d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80070d:	55                   	push   %ebp
  80070e:	89 e5                	mov    %esp,%ebp
  800710:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800713:	83 ec 0c             	sub    $0xc,%esp
  800716:	6a 00                	push   $0x0
  800718:	e8 8c 14 00 00       	call   801ba9 <sys_env_destroy>
  80071d:	83 c4 10             	add    $0x10,%esp
}
  800720:	90                   	nop
  800721:	c9                   	leave  
  800722:	c3                   	ret    

00800723 <exit>:

void
exit(void)
{
  800723:	55                   	push   %ebp
  800724:	89 e5                	mov    %esp,%ebp
  800726:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800729:	e8 e1 14 00 00       	call   801c0f <sys_env_exit>
}
  80072e:	90                   	nop
  80072f:	c9                   	leave  
  800730:	c3                   	ret    

00800731 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800731:	55                   	push   %ebp
  800732:	89 e5                	mov    %esp,%ebp
  800734:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800737:	8d 45 10             	lea    0x10(%ebp),%eax
  80073a:	83 c0 04             	add    $0x4,%eax
  80073d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800740:	a1 18 31 80 00       	mov    0x803118,%eax
  800745:	85 c0                	test   %eax,%eax
  800747:	74 16                	je     80075f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800749:	a1 18 31 80 00       	mov    0x803118,%eax
  80074e:	83 ec 08             	sub    $0x8,%esp
  800751:	50                   	push   %eax
  800752:	68 14 26 80 00       	push   $0x802614
  800757:	e8 77 02 00 00       	call   8009d3 <cprintf>
  80075c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80075f:	a1 00 30 80 00       	mov    0x803000,%eax
  800764:	ff 75 0c             	pushl  0xc(%ebp)
  800767:	ff 75 08             	pushl  0x8(%ebp)
  80076a:	50                   	push   %eax
  80076b:	68 19 26 80 00       	push   $0x802619
  800770:	e8 5e 02 00 00       	call   8009d3 <cprintf>
  800775:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800778:	8b 45 10             	mov    0x10(%ebp),%eax
  80077b:	83 ec 08             	sub    $0x8,%esp
  80077e:	ff 75 f4             	pushl  -0xc(%ebp)
  800781:	50                   	push   %eax
  800782:	e8 e1 01 00 00       	call   800968 <vcprintf>
  800787:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80078a:	83 ec 08             	sub    $0x8,%esp
  80078d:	6a 00                	push   $0x0
  80078f:	68 35 26 80 00       	push   $0x802635
  800794:	e8 cf 01 00 00       	call   800968 <vcprintf>
  800799:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80079c:	e8 82 ff ff ff       	call   800723 <exit>

	// should not return here
	while (1) ;
  8007a1:	eb fe                	jmp    8007a1 <_panic+0x70>

008007a3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007a3:	55                   	push   %ebp
  8007a4:	89 e5                	mov    %esp,%ebp
  8007a6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ae:	8b 50 74             	mov    0x74(%eax),%edx
  8007b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007b4:	39 c2                	cmp    %eax,%edx
  8007b6:	74 14                	je     8007cc <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007b8:	83 ec 04             	sub    $0x4,%esp
  8007bb:	68 38 26 80 00       	push   $0x802638
  8007c0:	6a 26                	push   $0x26
  8007c2:	68 84 26 80 00       	push   $0x802684
  8007c7:	e8 65 ff ff ff       	call   800731 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007da:	e9 b6 00 00 00       	jmp    800895 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8007df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ec:	01 d0                	add    %edx,%eax
  8007ee:	8b 00                	mov    (%eax),%eax
  8007f0:	85 c0                	test   %eax,%eax
  8007f2:	75 08                	jne    8007fc <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007f4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007f7:	e9 96 00 00 00       	jmp    800892 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8007fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800803:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80080a:	eb 5d                	jmp    800869 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80080c:	a1 20 30 80 00       	mov    0x803020,%eax
  800811:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800817:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80081a:	c1 e2 04             	shl    $0x4,%edx
  80081d:	01 d0                	add    %edx,%eax
  80081f:	8a 40 04             	mov    0x4(%eax),%al
  800822:	84 c0                	test   %al,%al
  800824:	75 40                	jne    800866 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800826:	a1 20 30 80 00       	mov    0x803020,%eax
  80082b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800831:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800834:	c1 e2 04             	shl    $0x4,%edx
  800837:	01 d0                	add    %edx,%eax
  800839:	8b 00                	mov    (%eax),%eax
  80083b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80083e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800841:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800846:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800848:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80084b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800852:	8b 45 08             	mov    0x8(%ebp),%eax
  800855:	01 c8                	add    %ecx,%eax
  800857:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800859:	39 c2                	cmp    %eax,%edx
  80085b:	75 09                	jne    800866 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80085d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800864:	eb 12                	jmp    800878 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800866:	ff 45 e8             	incl   -0x18(%ebp)
  800869:	a1 20 30 80 00       	mov    0x803020,%eax
  80086e:	8b 50 74             	mov    0x74(%eax),%edx
  800871:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800874:	39 c2                	cmp    %eax,%edx
  800876:	77 94                	ja     80080c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800878:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80087c:	75 14                	jne    800892 <CheckWSWithoutLastIndex+0xef>
			panic(
  80087e:	83 ec 04             	sub    $0x4,%esp
  800881:	68 90 26 80 00       	push   $0x802690
  800886:	6a 3a                	push   $0x3a
  800888:	68 84 26 80 00       	push   $0x802684
  80088d:	e8 9f fe ff ff       	call   800731 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800892:	ff 45 f0             	incl   -0x10(%ebp)
  800895:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800898:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80089b:	0f 8c 3e ff ff ff    	jl     8007df <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008a1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008a8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008af:	eb 20                	jmp    8008d1 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8008b6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008bc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008bf:	c1 e2 04             	shl    $0x4,%edx
  8008c2:	01 d0                	add    %edx,%eax
  8008c4:	8a 40 04             	mov    0x4(%eax),%al
  8008c7:	3c 01                	cmp    $0x1,%al
  8008c9:	75 03                	jne    8008ce <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008cb:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ce:	ff 45 e0             	incl   -0x20(%ebp)
  8008d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8008d6:	8b 50 74             	mov    0x74(%eax),%edx
  8008d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008dc:	39 c2                	cmp    %eax,%edx
  8008de:	77 d1                	ja     8008b1 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008e3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008e6:	74 14                	je     8008fc <CheckWSWithoutLastIndex+0x159>
		panic(
  8008e8:	83 ec 04             	sub    $0x4,%esp
  8008eb:	68 e4 26 80 00       	push   $0x8026e4
  8008f0:	6a 44                	push   $0x44
  8008f2:	68 84 26 80 00       	push   $0x802684
  8008f7:	e8 35 fe ff ff       	call   800731 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008fc:	90                   	nop
  8008fd:	c9                   	leave  
  8008fe:	c3                   	ret    

008008ff <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008ff:	55                   	push   %ebp
  800900:	89 e5                	mov    %esp,%ebp
  800902:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800905:	8b 45 0c             	mov    0xc(%ebp),%eax
  800908:	8b 00                	mov    (%eax),%eax
  80090a:	8d 48 01             	lea    0x1(%eax),%ecx
  80090d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800910:	89 0a                	mov    %ecx,(%edx)
  800912:	8b 55 08             	mov    0x8(%ebp),%edx
  800915:	88 d1                	mov    %dl,%cl
  800917:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80091e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800921:	8b 00                	mov    (%eax),%eax
  800923:	3d ff 00 00 00       	cmp    $0xff,%eax
  800928:	75 2c                	jne    800956 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80092a:	a0 24 30 80 00       	mov    0x803024,%al
  80092f:	0f b6 c0             	movzbl %al,%eax
  800932:	8b 55 0c             	mov    0xc(%ebp),%edx
  800935:	8b 12                	mov    (%edx),%edx
  800937:	89 d1                	mov    %edx,%ecx
  800939:	8b 55 0c             	mov    0xc(%ebp),%edx
  80093c:	83 c2 08             	add    $0x8,%edx
  80093f:	83 ec 04             	sub    $0x4,%esp
  800942:	50                   	push   %eax
  800943:	51                   	push   %ecx
  800944:	52                   	push   %edx
  800945:	e8 1d 12 00 00       	call   801b67 <sys_cputs>
  80094a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80094d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800950:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800956:	8b 45 0c             	mov    0xc(%ebp),%eax
  800959:	8b 40 04             	mov    0x4(%eax),%eax
  80095c:	8d 50 01             	lea    0x1(%eax),%edx
  80095f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800962:	89 50 04             	mov    %edx,0x4(%eax)
}
  800965:	90                   	nop
  800966:	c9                   	leave  
  800967:	c3                   	ret    

00800968 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800968:	55                   	push   %ebp
  800969:	89 e5                	mov    %esp,%ebp
  80096b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800971:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800978:	00 00 00 
	b.cnt = 0;
  80097b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800982:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800985:	ff 75 0c             	pushl  0xc(%ebp)
  800988:	ff 75 08             	pushl  0x8(%ebp)
  80098b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800991:	50                   	push   %eax
  800992:	68 ff 08 80 00       	push   $0x8008ff
  800997:	e8 11 02 00 00       	call   800bad <vprintfmt>
  80099c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80099f:	a0 24 30 80 00       	mov    0x803024,%al
  8009a4:	0f b6 c0             	movzbl %al,%eax
  8009a7:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009ad:	83 ec 04             	sub    $0x4,%esp
  8009b0:	50                   	push   %eax
  8009b1:	52                   	push   %edx
  8009b2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009b8:	83 c0 08             	add    $0x8,%eax
  8009bb:	50                   	push   %eax
  8009bc:	e8 a6 11 00 00       	call   801b67 <sys_cputs>
  8009c1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009c4:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009cb:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009d1:	c9                   	leave  
  8009d2:	c3                   	ret    

008009d3 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009d3:	55                   	push   %ebp
  8009d4:	89 e5                	mov    %esp,%ebp
  8009d6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009d9:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009e0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e9:	83 ec 08             	sub    $0x8,%esp
  8009ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ef:	50                   	push   %eax
  8009f0:	e8 73 ff ff ff       	call   800968 <vcprintf>
  8009f5:	83 c4 10             	add    $0x10,%esp
  8009f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009fe:	c9                   	leave  
  8009ff:	c3                   	ret    

00800a00 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a00:	55                   	push   %ebp
  800a01:	89 e5                	mov    %esp,%ebp
  800a03:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a06:	e8 6d 13 00 00       	call   801d78 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a0b:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a11:	8b 45 08             	mov    0x8(%ebp),%eax
  800a14:	83 ec 08             	sub    $0x8,%esp
  800a17:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1a:	50                   	push   %eax
  800a1b:	e8 48 ff ff ff       	call   800968 <vcprintf>
  800a20:	83 c4 10             	add    $0x10,%esp
  800a23:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a26:	e8 67 13 00 00       	call   801d92 <sys_enable_interrupt>
	return cnt;
  800a2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a2e:	c9                   	leave  
  800a2f:	c3                   	ret    

00800a30 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a30:	55                   	push   %ebp
  800a31:	89 e5                	mov    %esp,%ebp
  800a33:	53                   	push   %ebx
  800a34:	83 ec 14             	sub    $0x14,%esp
  800a37:	8b 45 10             	mov    0x10(%ebp),%eax
  800a3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a40:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a43:	8b 45 18             	mov    0x18(%ebp),%eax
  800a46:	ba 00 00 00 00       	mov    $0x0,%edx
  800a4b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a4e:	77 55                	ja     800aa5 <printnum+0x75>
  800a50:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a53:	72 05                	jb     800a5a <printnum+0x2a>
  800a55:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a58:	77 4b                	ja     800aa5 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a5a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a5d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a60:	8b 45 18             	mov    0x18(%ebp),%eax
  800a63:	ba 00 00 00 00       	mov    $0x0,%edx
  800a68:	52                   	push   %edx
  800a69:	50                   	push   %eax
  800a6a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a6d:	ff 75 f0             	pushl  -0x10(%ebp)
  800a70:	e8 27 17 00 00       	call   80219c <__udivdi3>
  800a75:	83 c4 10             	add    $0x10,%esp
  800a78:	83 ec 04             	sub    $0x4,%esp
  800a7b:	ff 75 20             	pushl  0x20(%ebp)
  800a7e:	53                   	push   %ebx
  800a7f:	ff 75 18             	pushl  0x18(%ebp)
  800a82:	52                   	push   %edx
  800a83:	50                   	push   %eax
  800a84:	ff 75 0c             	pushl  0xc(%ebp)
  800a87:	ff 75 08             	pushl  0x8(%ebp)
  800a8a:	e8 a1 ff ff ff       	call   800a30 <printnum>
  800a8f:	83 c4 20             	add    $0x20,%esp
  800a92:	eb 1a                	jmp    800aae <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a94:	83 ec 08             	sub    $0x8,%esp
  800a97:	ff 75 0c             	pushl  0xc(%ebp)
  800a9a:	ff 75 20             	pushl  0x20(%ebp)
  800a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa0:	ff d0                	call   *%eax
  800aa2:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800aa5:	ff 4d 1c             	decl   0x1c(%ebp)
  800aa8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800aac:	7f e6                	jg     800a94 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800aae:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ab1:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ab6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ab9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800abc:	53                   	push   %ebx
  800abd:	51                   	push   %ecx
  800abe:	52                   	push   %edx
  800abf:	50                   	push   %eax
  800ac0:	e8 e7 17 00 00       	call   8022ac <__umoddi3>
  800ac5:	83 c4 10             	add    $0x10,%esp
  800ac8:	05 54 29 80 00       	add    $0x802954,%eax
  800acd:	8a 00                	mov    (%eax),%al
  800acf:	0f be c0             	movsbl %al,%eax
  800ad2:	83 ec 08             	sub    $0x8,%esp
  800ad5:	ff 75 0c             	pushl  0xc(%ebp)
  800ad8:	50                   	push   %eax
  800ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  800adc:	ff d0                	call   *%eax
  800ade:	83 c4 10             	add    $0x10,%esp
}
  800ae1:	90                   	nop
  800ae2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ae5:	c9                   	leave  
  800ae6:	c3                   	ret    

00800ae7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ae7:	55                   	push   %ebp
  800ae8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800aea:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800aee:	7e 1c                	jle    800b0c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	8b 00                	mov    (%eax),%eax
  800af5:	8d 50 08             	lea    0x8(%eax),%edx
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	89 10                	mov    %edx,(%eax)
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	8b 00                	mov    (%eax),%eax
  800b02:	83 e8 08             	sub    $0x8,%eax
  800b05:	8b 50 04             	mov    0x4(%eax),%edx
  800b08:	8b 00                	mov    (%eax),%eax
  800b0a:	eb 40                	jmp    800b4c <getuint+0x65>
	else if (lflag)
  800b0c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b10:	74 1e                	je     800b30 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	8b 00                	mov    (%eax),%eax
  800b17:	8d 50 04             	lea    0x4(%eax),%edx
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	89 10                	mov    %edx,(%eax)
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	8b 00                	mov    (%eax),%eax
  800b24:	83 e8 04             	sub    $0x4,%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	ba 00 00 00 00       	mov    $0x0,%edx
  800b2e:	eb 1c                	jmp    800b4c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	8b 00                	mov    (%eax),%eax
  800b35:	8d 50 04             	lea    0x4(%eax),%edx
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	89 10                	mov    %edx,(%eax)
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	8b 00                	mov    (%eax),%eax
  800b42:	83 e8 04             	sub    $0x4,%eax
  800b45:	8b 00                	mov    (%eax),%eax
  800b47:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b4c:	5d                   	pop    %ebp
  800b4d:	c3                   	ret    

00800b4e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b4e:	55                   	push   %ebp
  800b4f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b51:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b55:	7e 1c                	jle    800b73 <getint+0x25>
		return va_arg(*ap, long long);
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5a:	8b 00                	mov    (%eax),%eax
  800b5c:	8d 50 08             	lea    0x8(%eax),%edx
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	89 10                	mov    %edx,(%eax)
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	8b 00                	mov    (%eax),%eax
  800b69:	83 e8 08             	sub    $0x8,%eax
  800b6c:	8b 50 04             	mov    0x4(%eax),%edx
  800b6f:	8b 00                	mov    (%eax),%eax
  800b71:	eb 38                	jmp    800bab <getint+0x5d>
	else if (lflag)
  800b73:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b77:	74 1a                	je     800b93 <getint+0x45>
		return va_arg(*ap, long);
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	8b 00                	mov    (%eax),%eax
  800b7e:	8d 50 04             	lea    0x4(%eax),%edx
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	89 10                	mov    %edx,(%eax)
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
  800b89:	8b 00                	mov    (%eax),%eax
  800b8b:	83 e8 04             	sub    $0x4,%eax
  800b8e:	8b 00                	mov    (%eax),%eax
  800b90:	99                   	cltd   
  800b91:	eb 18                	jmp    800bab <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	8b 00                	mov    (%eax),%eax
  800b98:	8d 50 04             	lea    0x4(%eax),%edx
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	89 10                	mov    %edx,(%eax)
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	8b 00                	mov    (%eax),%eax
  800ba5:	83 e8 04             	sub    $0x4,%eax
  800ba8:	8b 00                	mov    (%eax),%eax
  800baa:	99                   	cltd   
}
  800bab:	5d                   	pop    %ebp
  800bac:	c3                   	ret    

00800bad <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bad:	55                   	push   %ebp
  800bae:	89 e5                	mov    %esp,%ebp
  800bb0:	56                   	push   %esi
  800bb1:	53                   	push   %ebx
  800bb2:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb5:	eb 17                	jmp    800bce <vprintfmt+0x21>
			if (ch == '\0')
  800bb7:	85 db                	test   %ebx,%ebx
  800bb9:	0f 84 af 03 00 00    	je     800f6e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bbf:	83 ec 08             	sub    $0x8,%esp
  800bc2:	ff 75 0c             	pushl  0xc(%ebp)
  800bc5:	53                   	push   %ebx
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc9:	ff d0                	call   *%eax
  800bcb:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bce:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd1:	8d 50 01             	lea    0x1(%eax),%edx
  800bd4:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd7:	8a 00                	mov    (%eax),%al
  800bd9:	0f b6 d8             	movzbl %al,%ebx
  800bdc:	83 fb 25             	cmp    $0x25,%ebx
  800bdf:	75 d6                	jne    800bb7 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800be1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800be5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bec:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bf3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bfa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c01:	8b 45 10             	mov    0x10(%ebp),%eax
  800c04:	8d 50 01             	lea    0x1(%eax),%edx
  800c07:	89 55 10             	mov    %edx,0x10(%ebp)
  800c0a:	8a 00                	mov    (%eax),%al
  800c0c:	0f b6 d8             	movzbl %al,%ebx
  800c0f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c12:	83 f8 55             	cmp    $0x55,%eax
  800c15:	0f 87 2b 03 00 00    	ja     800f46 <vprintfmt+0x399>
  800c1b:	8b 04 85 78 29 80 00 	mov    0x802978(,%eax,4),%eax
  800c22:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c24:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c28:	eb d7                	jmp    800c01 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c2a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c2e:	eb d1                	jmp    800c01 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c30:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c37:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c3a:	89 d0                	mov    %edx,%eax
  800c3c:	c1 e0 02             	shl    $0x2,%eax
  800c3f:	01 d0                	add    %edx,%eax
  800c41:	01 c0                	add    %eax,%eax
  800c43:	01 d8                	add    %ebx,%eax
  800c45:	83 e8 30             	sub    $0x30,%eax
  800c48:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4e:	8a 00                	mov    (%eax),%al
  800c50:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c53:	83 fb 2f             	cmp    $0x2f,%ebx
  800c56:	7e 3e                	jle    800c96 <vprintfmt+0xe9>
  800c58:	83 fb 39             	cmp    $0x39,%ebx
  800c5b:	7f 39                	jg     800c96 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c5d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c60:	eb d5                	jmp    800c37 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c62:	8b 45 14             	mov    0x14(%ebp),%eax
  800c65:	83 c0 04             	add    $0x4,%eax
  800c68:	89 45 14             	mov    %eax,0x14(%ebp)
  800c6b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6e:	83 e8 04             	sub    $0x4,%eax
  800c71:	8b 00                	mov    (%eax),%eax
  800c73:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c76:	eb 1f                	jmp    800c97 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c7c:	79 83                	jns    800c01 <vprintfmt+0x54>
				width = 0;
  800c7e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c85:	e9 77 ff ff ff       	jmp    800c01 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c8a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c91:	e9 6b ff ff ff       	jmp    800c01 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c96:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c97:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c9b:	0f 89 60 ff ff ff    	jns    800c01 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ca1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ca4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ca7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cae:	e9 4e ff ff ff       	jmp    800c01 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cb3:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cb6:	e9 46 ff ff ff       	jmp    800c01 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cbb:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbe:	83 c0 04             	add    $0x4,%eax
  800cc1:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc4:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc7:	83 e8 04             	sub    $0x4,%eax
  800cca:	8b 00                	mov    (%eax),%eax
  800ccc:	83 ec 08             	sub    $0x8,%esp
  800ccf:	ff 75 0c             	pushl  0xc(%ebp)
  800cd2:	50                   	push   %eax
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	ff d0                	call   *%eax
  800cd8:	83 c4 10             	add    $0x10,%esp
			break;
  800cdb:	e9 89 02 00 00       	jmp    800f69 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ce0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce3:	83 c0 04             	add    $0x4,%eax
  800ce6:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce9:	8b 45 14             	mov    0x14(%ebp),%eax
  800cec:	83 e8 04             	sub    $0x4,%eax
  800cef:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cf1:	85 db                	test   %ebx,%ebx
  800cf3:	79 02                	jns    800cf7 <vprintfmt+0x14a>
				err = -err;
  800cf5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cf7:	83 fb 64             	cmp    $0x64,%ebx
  800cfa:	7f 0b                	jg     800d07 <vprintfmt+0x15a>
  800cfc:	8b 34 9d c0 27 80 00 	mov    0x8027c0(,%ebx,4),%esi
  800d03:	85 f6                	test   %esi,%esi
  800d05:	75 19                	jne    800d20 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d07:	53                   	push   %ebx
  800d08:	68 65 29 80 00       	push   $0x802965
  800d0d:	ff 75 0c             	pushl  0xc(%ebp)
  800d10:	ff 75 08             	pushl  0x8(%ebp)
  800d13:	e8 5e 02 00 00       	call   800f76 <printfmt>
  800d18:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d1b:	e9 49 02 00 00       	jmp    800f69 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d20:	56                   	push   %esi
  800d21:	68 6e 29 80 00       	push   $0x80296e
  800d26:	ff 75 0c             	pushl  0xc(%ebp)
  800d29:	ff 75 08             	pushl  0x8(%ebp)
  800d2c:	e8 45 02 00 00       	call   800f76 <printfmt>
  800d31:	83 c4 10             	add    $0x10,%esp
			break;
  800d34:	e9 30 02 00 00       	jmp    800f69 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d39:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3c:	83 c0 04             	add    $0x4,%eax
  800d3f:	89 45 14             	mov    %eax,0x14(%ebp)
  800d42:	8b 45 14             	mov    0x14(%ebp),%eax
  800d45:	83 e8 04             	sub    $0x4,%eax
  800d48:	8b 30                	mov    (%eax),%esi
  800d4a:	85 f6                	test   %esi,%esi
  800d4c:	75 05                	jne    800d53 <vprintfmt+0x1a6>
				p = "(null)";
  800d4e:	be 71 29 80 00       	mov    $0x802971,%esi
			if (width > 0 && padc != '-')
  800d53:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d57:	7e 6d                	jle    800dc6 <vprintfmt+0x219>
  800d59:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d5d:	74 67                	je     800dc6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d5f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d62:	83 ec 08             	sub    $0x8,%esp
  800d65:	50                   	push   %eax
  800d66:	56                   	push   %esi
  800d67:	e8 0c 03 00 00       	call   801078 <strnlen>
  800d6c:	83 c4 10             	add    $0x10,%esp
  800d6f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d72:	eb 16                	jmp    800d8a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d74:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d78:	83 ec 08             	sub    $0x8,%esp
  800d7b:	ff 75 0c             	pushl  0xc(%ebp)
  800d7e:	50                   	push   %eax
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	ff d0                	call   *%eax
  800d84:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d87:	ff 4d e4             	decl   -0x1c(%ebp)
  800d8a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d8e:	7f e4                	jg     800d74 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d90:	eb 34                	jmp    800dc6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d92:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d96:	74 1c                	je     800db4 <vprintfmt+0x207>
  800d98:	83 fb 1f             	cmp    $0x1f,%ebx
  800d9b:	7e 05                	jle    800da2 <vprintfmt+0x1f5>
  800d9d:	83 fb 7e             	cmp    $0x7e,%ebx
  800da0:	7e 12                	jle    800db4 <vprintfmt+0x207>
					putch('?', putdat);
  800da2:	83 ec 08             	sub    $0x8,%esp
  800da5:	ff 75 0c             	pushl  0xc(%ebp)
  800da8:	6a 3f                	push   $0x3f
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	ff d0                	call   *%eax
  800daf:	83 c4 10             	add    $0x10,%esp
  800db2:	eb 0f                	jmp    800dc3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800db4:	83 ec 08             	sub    $0x8,%esp
  800db7:	ff 75 0c             	pushl  0xc(%ebp)
  800dba:	53                   	push   %ebx
  800dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbe:	ff d0                	call   *%eax
  800dc0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dc3:	ff 4d e4             	decl   -0x1c(%ebp)
  800dc6:	89 f0                	mov    %esi,%eax
  800dc8:	8d 70 01             	lea    0x1(%eax),%esi
  800dcb:	8a 00                	mov    (%eax),%al
  800dcd:	0f be d8             	movsbl %al,%ebx
  800dd0:	85 db                	test   %ebx,%ebx
  800dd2:	74 24                	je     800df8 <vprintfmt+0x24b>
  800dd4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dd8:	78 b8                	js     800d92 <vprintfmt+0x1e5>
  800dda:	ff 4d e0             	decl   -0x20(%ebp)
  800ddd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800de1:	79 af                	jns    800d92 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800de3:	eb 13                	jmp    800df8 <vprintfmt+0x24b>
				putch(' ', putdat);
  800de5:	83 ec 08             	sub    $0x8,%esp
  800de8:	ff 75 0c             	pushl  0xc(%ebp)
  800deb:	6a 20                	push   $0x20
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
  800df0:	ff d0                	call   *%eax
  800df2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800df5:	ff 4d e4             	decl   -0x1c(%ebp)
  800df8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dfc:	7f e7                	jg     800de5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dfe:	e9 66 01 00 00       	jmp    800f69 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e03:	83 ec 08             	sub    $0x8,%esp
  800e06:	ff 75 e8             	pushl  -0x18(%ebp)
  800e09:	8d 45 14             	lea    0x14(%ebp),%eax
  800e0c:	50                   	push   %eax
  800e0d:	e8 3c fd ff ff       	call   800b4e <getint>
  800e12:	83 c4 10             	add    $0x10,%esp
  800e15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e18:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e1e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e21:	85 d2                	test   %edx,%edx
  800e23:	79 23                	jns    800e48 <vprintfmt+0x29b>
				putch('-', putdat);
  800e25:	83 ec 08             	sub    $0x8,%esp
  800e28:	ff 75 0c             	pushl  0xc(%ebp)
  800e2b:	6a 2d                	push   $0x2d
  800e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e30:	ff d0                	call   *%eax
  800e32:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e35:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e38:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e3b:	f7 d8                	neg    %eax
  800e3d:	83 d2 00             	adc    $0x0,%edx
  800e40:	f7 da                	neg    %edx
  800e42:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e45:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e48:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e4f:	e9 bc 00 00 00       	jmp    800f10 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e54:	83 ec 08             	sub    $0x8,%esp
  800e57:	ff 75 e8             	pushl  -0x18(%ebp)
  800e5a:	8d 45 14             	lea    0x14(%ebp),%eax
  800e5d:	50                   	push   %eax
  800e5e:	e8 84 fc ff ff       	call   800ae7 <getuint>
  800e63:	83 c4 10             	add    $0x10,%esp
  800e66:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e69:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e6c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e73:	e9 98 00 00 00       	jmp    800f10 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e78:	83 ec 08             	sub    $0x8,%esp
  800e7b:	ff 75 0c             	pushl  0xc(%ebp)
  800e7e:	6a 58                	push   $0x58
  800e80:	8b 45 08             	mov    0x8(%ebp),%eax
  800e83:	ff d0                	call   *%eax
  800e85:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e88:	83 ec 08             	sub    $0x8,%esp
  800e8b:	ff 75 0c             	pushl  0xc(%ebp)
  800e8e:	6a 58                	push   $0x58
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
  800e93:	ff d0                	call   *%eax
  800e95:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e98:	83 ec 08             	sub    $0x8,%esp
  800e9b:	ff 75 0c             	pushl  0xc(%ebp)
  800e9e:	6a 58                	push   $0x58
  800ea0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea3:	ff d0                	call   *%eax
  800ea5:	83 c4 10             	add    $0x10,%esp
			break;
  800ea8:	e9 bc 00 00 00       	jmp    800f69 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ead:	83 ec 08             	sub    $0x8,%esp
  800eb0:	ff 75 0c             	pushl  0xc(%ebp)
  800eb3:	6a 30                	push   $0x30
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	ff d0                	call   *%eax
  800eba:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ebd:	83 ec 08             	sub    $0x8,%esp
  800ec0:	ff 75 0c             	pushl  0xc(%ebp)
  800ec3:	6a 78                	push   $0x78
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	ff d0                	call   *%eax
  800eca:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ecd:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed0:	83 c0 04             	add    $0x4,%eax
  800ed3:	89 45 14             	mov    %eax,0x14(%ebp)
  800ed6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed9:	83 e8 04             	sub    $0x4,%eax
  800edc:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ede:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ee8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800eef:	eb 1f                	jmp    800f10 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ef1:	83 ec 08             	sub    $0x8,%esp
  800ef4:	ff 75 e8             	pushl  -0x18(%ebp)
  800ef7:	8d 45 14             	lea    0x14(%ebp),%eax
  800efa:	50                   	push   %eax
  800efb:	e8 e7 fb ff ff       	call   800ae7 <getuint>
  800f00:	83 c4 10             	add    $0x10,%esp
  800f03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f06:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f09:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f10:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f14:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f17:	83 ec 04             	sub    $0x4,%esp
  800f1a:	52                   	push   %edx
  800f1b:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f1e:	50                   	push   %eax
  800f1f:	ff 75 f4             	pushl  -0xc(%ebp)
  800f22:	ff 75 f0             	pushl  -0x10(%ebp)
  800f25:	ff 75 0c             	pushl  0xc(%ebp)
  800f28:	ff 75 08             	pushl  0x8(%ebp)
  800f2b:	e8 00 fb ff ff       	call   800a30 <printnum>
  800f30:	83 c4 20             	add    $0x20,%esp
			break;
  800f33:	eb 34                	jmp    800f69 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f35:	83 ec 08             	sub    $0x8,%esp
  800f38:	ff 75 0c             	pushl  0xc(%ebp)
  800f3b:	53                   	push   %ebx
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	ff d0                	call   *%eax
  800f41:	83 c4 10             	add    $0x10,%esp
			break;
  800f44:	eb 23                	jmp    800f69 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f46:	83 ec 08             	sub    $0x8,%esp
  800f49:	ff 75 0c             	pushl  0xc(%ebp)
  800f4c:	6a 25                	push   $0x25
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	ff d0                	call   *%eax
  800f53:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f56:	ff 4d 10             	decl   0x10(%ebp)
  800f59:	eb 03                	jmp    800f5e <vprintfmt+0x3b1>
  800f5b:	ff 4d 10             	decl   0x10(%ebp)
  800f5e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f61:	48                   	dec    %eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	3c 25                	cmp    $0x25,%al
  800f66:	75 f3                	jne    800f5b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f68:	90                   	nop
		}
	}
  800f69:	e9 47 fc ff ff       	jmp    800bb5 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f6e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f72:	5b                   	pop    %ebx
  800f73:	5e                   	pop    %esi
  800f74:	5d                   	pop    %ebp
  800f75:	c3                   	ret    

00800f76 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f76:	55                   	push   %ebp
  800f77:	89 e5                	mov    %esp,%ebp
  800f79:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f7c:	8d 45 10             	lea    0x10(%ebp),%eax
  800f7f:	83 c0 04             	add    $0x4,%eax
  800f82:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f85:	8b 45 10             	mov    0x10(%ebp),%eax
  800f88:	ff 75 f4             	pushl  -0xc(%ebp)
  800f8b:	50                   	push   %eax
  800f8c:	ff 75 0c             	pushl  0xc(%ebp)
  800f8f:	ff 75 08             	pushl  0x8(%ebp)
  800f92:	e8 16 fc ff ff       	call   800bad <vprintfmt>
  800f97:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f9a:	90                   	nop
  800f9b:	c9                   	leave  
  800f9c:	c3                   	ret    

00800f9d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f9d:	55                   	push   %ebp
  800f9e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fa0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa3:	8b 40 08             	mov    0x8(%eax),%eax
  800fa6:	8d 50 01             	lea    0x1(%eax),%edx
  800fa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fac:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800faf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb2:	8b 10                	mov    (%eax),%edx
  800fb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb7:	8b 40 04             	mov    0x4(%eax),%eax
  800fba:	39 c2                	cmp    %eax,%edx
  800fbc:	73 12                	jae    800fd0 <sprintputch+0x33>
		*b->buf++ = ch;
  800fbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc1:	8b 00                	mov    (%eax),%eax
  800fc3:	8d 48 01             	lea    0x1(%eax),%ecx
  800fc6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fc9:	89 0a                	mov    %ecx,(%edx)
  800fcb:	8b 55 08             	mov    0x8(%ebp),%edx
  800fce:	88 10                	mov    %dl,(%eax)
}
  800fd0:	90                   	nop
  800fd1:	5d                   	pop    %ebp
  800fd2:	c3                   	ret    

00800fd3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fd3:	55                   	push   %ebp
  800fd4:	89 e5                	mov    %esp,%ebp
  800fd6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe8:	01 d0                	add    %edx,%eax
  800fea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ff4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ff8:	74 06                	je     801000 <vsnprintf+0x2d>
  800ffa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ffe:	7f 07                	jg     801007 <vsnprintf+0x34>
		return -E_INVAL;
  801000:	b8 03 00 00 00       	mov    $0x3,%eax
  801005:	eb 20                	jmp    801027 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801007:	ff 75 14             	pushl  0x14(%ebp)
  80100a:	ff 75 10             	pushl  0x10(%ebp)
  80100d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801010:	50                   	push   %eax
  801011:	68 9d 0f 80 00       	push   $0x800f9d
  801016:	e8 92 fb ff ff       	call   800bad <vprintfmt>
  80101b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80101e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801021:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801024:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801027:	c9                   	leave  
  801028:	c3                   	ret    

00801029 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801029:	55                   	push   %ebp
  80102a:	89 e5                	mov    %esp,%ebp
  80102c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80102f:	8d 45 10             	lea    0x10(%ebp),%eax
  801032:	83 c0 04             	add    $0x4,%eax
  801035:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801038:	8b 45 10             	mov    0x10(%ebp),%eax
  80103b:	ff 75 f4             	pushl  -0xc(%ebp)
  80103e:	50                   	push   %eax
  80103f:	ff 75 0c             	pushl  0xc(%ebp)
  801042:	ff 75 08             	pushl  0x8(%ebp)
  801045:	e8 89 ff ff ff       	call   800fd3 <vsnprintf>
  80104a:	83 c4 10             	add    $0x10,%esp
  80104d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801050:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801053:	c9                   	leave  
  801054:	c3                   	ret    

00801055 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801055:	55                   	push   %ebp
  801056:	89 e5                	mov    %esp,%ebp
  801058:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80105b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801062:	eb 06                	jmp    80106a <strlen+0x15>
		n++;
  801064:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801067:	ff 45 08             	incl   0x8(%ebp)
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	84 c0                	test   %al,%al
  801071:	75 f1                	jne    801064 <strlen+0xf>
		n++;
	return n;
  801073:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801076:	c9                   	leave  
  801077:	c3                   	ret    

00801078 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801078:	55                   	push   %ebp
  801079:	89 e5                	mov    %esp,%ebp
  80107b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80107e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801085:	eb 09                	jmp    801090 <strnlen+0x18>
		n++;
  801087:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80108a:	ff 45 08             	incl   0x8(%ebp)
  80108d:	ff 4d 0c             	decl   0xc(%ebp)
  801090:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801094:	74 09                	je     80109f <strnlen+0x27>
  801096:	8b 45 08             	mov    0x8(%ebp),%eax
  801099:	8a 00                	mov    (%eax),%al
  80109b:	84 c0                	test   %al,%al
  80109d:	75 e8                	jne    801087 <strnlen+0xf>
		n++;
	return n;
  80109f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
  8010a7:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8010b0:	90                   	nop
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b4:	8d 50 01             	lea    0x1(%eax),%edx
  8010b7:	89 55 08             	mov    %edx,0x8(%ebp)
  8010ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010bd:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010c0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010c3:	8a 12                	mov    (%edx),%dl
  8010c5:	88 10                	mov    %dl,(%eax)
  8010c7:	8a 00                	mov    (%eax),%al
  8010c9:	84 c0                	test   %al,%al
  8010cb:	75 e4                	jne    8010b1 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010d0:	c9                   	leave  
  8010d1:	c3                   	ret    

008010d2 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010d2:	55                   	push   %ebp
  8010d3:	89 e5                	mov    %esp,%ebp
  8010d5:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010db:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010e5:	eb 1f                	jmp    801106 <strncpy+0x34>
		*dst++ = *src;
  8010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ea:	8d 50 01             	lea    0x1(%eax),%edx
  8010ed:	89 55 08             	mov    %edx,0x8(%ebp)
  8010f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f3:	8a 12                	mov    (%edx),%dl
  8010f5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fa:	8a 00                	mov    (%eax),%al
  8010fc:	84 c0                	test   %al,%al
  8010fe:	74 03                	je     801103 <strncpy+0x31>
			src++;
  801100:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801103:	ff 45 fc             	incl   -0x4(%ebp)
  801106:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801109:	3b 45 10             	cmp    0x10(%ebp),%eax
  80110c:	72 d9                	jb     8010e7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80110e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801111:	c9                   	leave  
  801112:	c3                   	ret    

00801113 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801113:	55                   	push   %ebp
  801114:	89 e5                	mov    %esp,%ebp
  801116:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
  80111c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80111f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801123:	74 30                	je     801155 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801125:	eb 16                	jmp    80113d <strlcpy+0x2a>
			*dst++ = *src++;
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	8d 50 01             	lea    0x1(%eax),%edx
  80112d:	89 55 08             	mov    %edx,0x8(%ebp)
  801130:	8b 55 0c             	mov    0xc(%ebp),%edx
  801133:	8d 4a 01             	lea    0x1(%edx),%ecx
  801136:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801139:	8a 12                	mov    (%edx),%dl
  80113b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80113d:	ff 4d 10             	decl   0x10(%ebp)
  801140:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801144:	74 09                	je     80114f <strlcpy+0x3c>
  801146:	8b 45 0c             	mov    0xc(%ebp),%eax
  801149:	8a 00                	mov    (%eax),%al
  80114b:	84 c0                	test   %al,%al
  80114d:	75 d8                	jne    801127 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80114f:	8b 45 08             	mov    0x8(%ebp),%eax
  801152:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801155:	8b 55 08             	mov    0x8(%ebp),%edx
  801158:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80115b:	29 c2                	sub    %eax,%edx
  80115d:	89 d0                	mov    %edx,%eax
}
  80115f:	c9                   	leave  
  801160:	c3                   	ret    

00801161 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801161:	55                   	push   %ebp
  801162:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801164:	eb 06                	jmp    80116c <strcmp+0xb>
		p++, q++;
  801166:	ff 45 08             	incl   0x8(%ebp)
  801169:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80116c:	8b 45 08             	mov    0x8(%ebp),%eax
  80116f:	8a 00                	mov    (%eax),%al
  801171:	84 c0                	test   %al,%al
  801173:	74 0e                	je     801183 <strcmp+0x22>
  801175:	8b 45 08             	mov    0x8(%ebp),%eax
  801178:	8a 10                	mov    (%eax),%dl
  80117a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117d:	8a 00                	mov    (%eax),%al
  80117f:	38 c2                	cmp    %al,%dl
  801181:	74 e3                	je     801166 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
  801186:	8a 00                	mov    (%eax),%al
  801188:	0f b6 d0             	movzbl %al,%edx
  80118b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118e:	8a 00                	mov    (%eax),%al
  801190:	0f b6 c0             	movzbl %al,%eax
  801193:	29 c2                	sub    %eax,%edx
  801195:	89 d0                	mov    %edx,%eax
}
  801197:	5d                   	pop    %ebp
  801198:	c3                   	ret    

00801199 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801199:	55                   	push   %ebp
  80119a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80119c:	eb 09                	jmp    8011a7 <strncmp+0xe>
		n--, p++, q++;
  80119e:	ff 4d 10             	decl   0x10(%ebp)
  8011a1:	ff 45 08             	incl   0x8(%ebp)
  8011a4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8011a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011ab:	74 17                	je     8011c4 <strncmp+0x2b>
  8011ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b0:	8a 00                	mov    (%eax),%al
  8011b2:	84 c0                	test   %al,%al
  8011b4:	74 0e                	je     8011c4 <strncmp+0x2b>
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b9:	8a 10                	mov    (%eax),%dl
  8011bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011be:	8a 00                	mov    (%eax),%al
  8011c0:	38 c2                	cmp    %al,%dl
  8011c2:	74 da                	je     80119e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011c4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011c8:	75 07                	jne    8011d1 <strncmp+0x38>
		return 0;
  8011ca:	b8 00 00 00 00       	mov    $0x0,%eax
  8011cf:	eb 14                	jmp    8011e5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d4:	8a 00                	mov    (%eax),%al
  8011d6:	0f b6 d0             	movzbl %al,%edx
  8011d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dc:	8a 00                	mov    (%eax),%al
  8011de:	0f b6 c0             	movzbl %al,%eax
  8011e1:	29 c2                	sub    %eax,%edx
  8011e3:	89 d0                	mov    %edx,%eax
}
  8011e5:	5d                   	pop    %ebp
  8011e6:	c3                   	ret    

008011e7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011e7:	55                   	push   %ebp
  8011e8:	89 e5                	mov    %esp,%ebp
  8011ea:	83 ec 04             	sub    $0x4,%esp
  8011ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011f3:	eb 12                	jmp    801207 <strchr+0x20>
		if (*s == c)
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011fd:	75 05                	jne    801204 <strchr+0x1d>
			return (char *) s;
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801202:	eb 11                	jmp    801215 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801204:	ff 45 08             	incl   0x8(%ebp)
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	8a 00                	mov    (%eax),%al
  80120c:	84 c0                	test   %al,%al
  80120e:	75 e5                	jne    8011f5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801210:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801215:	c9                   	leave  
  801216:	c3                   	ret    

00801217 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801217:	55                   	push   %ebp
  801218:	89 e5                	mov    %esp,%ebp
  80121a:	83 ec 04             	sub    $0x4,%esp
  80121d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801220:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801223:	eb 0d                	jmp    801232 <strfind+0x1b>
		if (*s == c)
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	8a 00                	mov    (%eax),%al
  80122a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80122d:	74 0e                	je     80123d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80122f:	ff 45 08             	incl   0x8(%ebp)
  801232:	8b 45 08             	mov    0x8(%ebp),%eax
  801235:	8a 00                	mov    (%eax),%al
  801237:	84 c0                	test   %al,%al
  801239:	75 ea                	jne    801225 <strfind+0xe>
  80123b:	eb 01                	jmp    80123e <strfind+0x27>
		if (*s == c)
			break;
  80123d:	90                   	nop
	return (char *) s;
  80123e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801241:	c9                   	leave  
  801242:	c3                   	ret    

00801243 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801243:	55                   	push   %ebp
  801244:	89 e5                	mov    %esp,%ebp
  801246:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801249:	8b 45 08             	mov    0x8(%ebp),%eax
  80124c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80124f:	8b 45 10             	mov    0x10(%ebp),%eax
  801252:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801255:	eb 0e                	jmp    801265 <memset+0x22>
		*p++ = c;
  801257:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80125a:	8d 50 01             	lea    0x1(%eax),%edx
  80125d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801260:	8b 55 0c             	mov    0xc(%ebp),%edx
  801263:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801265:	ff 4d f8             	decl   -0x8(%ebp)
  801268:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80126c:	79 e9                	jns    801257 <memset+0x14>
		*p++ = c;

	return v;
  80126e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801271:	c9                   	leave  
  801272:	c3                   	ret    

00801273 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801273:	55                   	push   %ebp
  801274:	89 e5                	mov    %esp,%ebp
  801276:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801279:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80127f:	8b 45 08             	mov    0x8(%ebp),%eax
  801282:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801285:	eb 16                	jmp    80129d <memcpy+0x2a>
		*d++ = *s++;
  801287:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80128a:	8d 50 01             	lea    0x1(%eax),%edx
  80128d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801290:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801293:	8d 4a 01             	lea    0x1(%edx),%ecx
  801296:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801299:	8a 12                	mov    (%edx),%dl
  80129b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80129d:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012a3:	89 55 10             	mov    %edx,0x10(%ebp)
  8012a6:	85 c0                	test   %eax,%eax
  8012a8:	75 dd                	jne    801287 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8012aa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012ad:	c9                   	leave  
  8012ae:	c3                   	ret    

008012af <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8012af:	55                   	push   %ebp
  8012b0:	89 e5                	mov    %esp,%ebp
  8012b2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8012b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012c7:	73 50                	jae    801319 <memmove+0x6a>
  8012c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cf:	01 d0                	add    %edx,%eax
  8012d1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012d4:	76 43                	jbe    801319 <memmove+0x6a>
		s += n;
  8012d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d9:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012df:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012e2:	eb 10                	jmp    8012f4 <memmove+0x45>
			*--d = *--s;
  8012e4:	ff 4d f8             	decl   -0x8(%ebp)
  8012e7:	ff 4d fc             	decl   -0x4(%ebp)
  8012ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ed:	8a 10                	mov    (%eax),%dl
  8012ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012fa:	89 55 10             	mov    %edx,0x10(%ebp)
  8012fd:	85 c0                	test   %eax,%eax
  8012ff:	75 e3                	jne    8012e4 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801301:	eb 23                	jmp    801326 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801303:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801306:	8d 50 01             	lea    0x1(%eax),%edx
  801309:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80130c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80130f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801312:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801315:	8a 12                	mov    (%edx),%dl
  801317:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801319:	8b 45 10             	mov    0x10(%ebp),%eax
  80131c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80131f:	89 55 10             	mov    %edx,0x10(%ebp)
  801322:	85 c0                	test   %eax,%eax
  801324:	75 dd                	jne    801303 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801326:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801329:	c9                   	leave  
  80132a:	c3                   	ret    

0080132b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80132b:	55                   	push   %ebp
  80132c:	89 e5                	mov    %esp,%ebp
  80132e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801337:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80133d:	eb 2a                	jmp    801369 <memcmp+0x3e>
		if (*s1 != *s2)
  80133f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801342:	8a 10                	mov    (%eax),%dl
  801344:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801347:	8a 00                	mov    (%eax),%al
  801349:	38 c2                	cmp    %al,%dl
  80134b:	74 16                	je     801363 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80134d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801350:	8a 00                	mov    (%eax),%al
  801352:	0f b6 d0             	movzbl %al,%edx
  801355:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801358:	8a 00                	mov    (%eax),%al
  80135a:	0f b6 c0             	movzbl %al,%eax
  80135d:	29 c2                	sub    %eax,%edx
  80135f:	89 d0                	mov    %edx,%eax
  801361:	eb 18                	jmp    80137b <memcmp+0x50>
		s1++, s2++;
  801363:	ff 45 fc             	incl   -0x4(%ebp)
  801366:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801369:	8b 45 10             	mov    0x10(%ebp),%eax
  80136c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80136f:	89 55 10             	mov    %edx,0x10(%ebp)
  801372:	85 c0                	test   %eax,%eax
  801374:	75 c9                	jne    80133f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801376:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80137b:	c9                   	leave  
  80137c:	c3                   	ret    

0080137d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80137d:	55                   	push   %ebp
  80137e:	89 e5                	mov    %esp,%ebp
  801380:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801383:	8b 55 08             	mov    0x8(%ebp),%edx
  801386:	8b 45 10             	mov    0x10(%ebp),%eax
  801389:	01 d0                	add    %edx,%eax
  80138b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80138e:	eb 15                	jmp    8013a5 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	8a 00                	mov    (%eax),%al
  801395:	0f b6 d0             	movzbl %al,%edx
  801398:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139b:	0f b6 c0             	movzbl %al,%eax
  80139e:	39 c2                	cmp    %eax,%edx
  8013a0:	74 0d                	je     8013af <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8013a2:	ff 45 08             	incl   0x8(%ebp)
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8013ab:	72 e3                	jb     801390 <memfind+0x13>
  8013ad:	eb 01                	jmp    8013b0 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8013af:	90                   	nop
	return (void *) s;
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013b3:	c9                   	leave  
  8013b4:	c3                   	ret    

008013b5 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8013b5:	55                   	push   %ebp
  8013b6:	89 e5                	mov    %esp,%ebp
  8013b8:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013c2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013c9:	eb 03                	jmp    8013ce <strtol+0x19>
		s++;
  8013cb:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	8a 00                	mov    (%eax),%al
  8013d3:	3c 20                	cmp    $0x20,%al
  8013d5:	74 f4                	je     8013cb <strtol+0x16>
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	8a 00                	mov    (%eax),%al
  8013dc:	3c 09                	cmp    $0x9,%al
  8013de:	74 eb                	je     8013cb <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e3:	8a 00                	mov    (%eax),%al
  8013e5:	3c 2b                	cmp    $0x2b,%al
  8013e7:	75 05                	jne    8013ee <strtol+0x39>
		s++;
  8013e9:	ff 45 08             	incl   0x8(%ebp)
  8013ec:	eb 13                	jmp    801401 <strtol+0x4c>
	else if (*s == '-')
  8013ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f1:	8a 00                	mov    (%eax),%al
  8013f3:	3c 2d                	cmp    $0x2d,%al
  8013f5:	75 0a                	jne    801401 <strtol+0x4c>
		s++, neg = 1;
  8013f7:	ff 45 08             	incl   0x8(%ebp)
  8013fa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801401:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801405:	74 06                	je     80140d <strtol+0x58>
  801407:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80140b:	75 20                	jne    80142d <strtol+0x78>
  80140d:	8b 45 08             	mov    0x8(%ebp),%eax
  801410:	8a 00                	mov    (%eax),%al
  801412:	3c 30                	cmp    $0x30,%al
  801414:	75 17                	jne    80142d <strtol+0x78>
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	40                   	inc    %eax
  80141a:	8a 00                	mov    (%eax),%al
  80141c:	3c 78                	cmp    $0x78,%al
  80141e:	75 0d                	jne    80142d <strtol+0x78>
		s += 2, base = 16;
  801420:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801424:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80142b:	eb 28                	jmp    801455 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80142d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801431:	75 15                	jne    801448 <strtol+0x93>
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	8a 00                	mov    (%eax),%al
  801438:	3c 30                	cmp    $0x30,%al
  80143a:	75 0c                	jne    801448 <strtol+0x93>
		s++, base = 8;
  80143c:	ff 45 08             	incl   0x8(%ebp)
  80143f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801446:	eb 0d                	jmp    801455 <strtol+0xa0>
	else if (base == 0)
  801448:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80144c:	75 07                	jne    801455 <strtol+0xa0>
		base = 10;
  80144e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	8a 00                	mov    (%eax),%al
  80145a:	3c 2f                	cmp    $0x2f,%al
  80145c:	7e 19                	jle    801477 <strtol+0xc2>
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	8a 00                	mov    (%eax),%al
  801463:	3c 39                	cmp    $0x39,%al
  801465:	7f 10                	jg     801477 <strtol+0xc2>
			dig = *s - '0';
  801467:	8b 45 08             	mov    0x8(%ebp),%eax
  80146a:	8a 00                	mov    (%eax),%al
  80146c:	0f be c0             	movsbl %al,%eax
  80146f:	83 e8 30             	sub    $0x30,%eax
  801472:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801475:	eb 42                	jmp    8014b9 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801477:	8b 45 08             	mov    0x8(%ebp),%eax
  80147a:	8a 00                	mov    (%eax),%al
  80147c:	3c 60                	cmp    $0x60,%al
  80147e:	7e 19                	jle    801499 <strtol+0xe4>
  801480:	8b 45 08             	mov    0x8(%ebp),%eax
  801483:	8a 00                	mov    (%eax),%al
  801485:	3c 7a                	cmp    $0x7a,%al
  801487:	7f 10                	jg     801499 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	8a 00                	mov    (%eax),%al
  80148e:	0f be c0             	movsbl %al,%eax
  801491:	83 e8 57             	sub    $0x57,%eax
  801494:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801497:	eb 20                	jmp    8014b9 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801499:	8b 45 08             	mov    0x8(%ebp),%eax
  80149c:	8a 00                	mov    (%eax),%al
  80149e:	3c 40                	cmp    $0x40,%al
  8014a0:	7e 39                	jle    8014db <strtol+0x126>
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a5:	8a 00                	mov    (%eax),%al
  8014a7:	3c 5a                	cmp    $0x5a,%al
  8014a9:	7f 30                	jg     8014db <strtol+0x126>
			dig = *s - 'A' + 10;
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	8a 00                	mov    (%eax),%al
  8014b0:	0f be c0             	movsbl %al,%eax
  8014b3:	83 e8 37             	sub    $0x37,%eax
  8014b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8014b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014bc:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014bf:	7d 19                	jge    8014da <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014c1:	ff 45 08             	incl   0x8(%ebp)
  8014c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014c7:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014cb:	89 c2                	mov    %eax,%edx
  8014cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014d0:	01 d0                	add    %edx,%eax
  8014d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014d5:	e9 7b ff ff ff       	jmp    801455 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014da:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014db:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014df:	74 08                	je     8014e9 <strtol+0x134>
		*endptr = (char *) s;
  8014e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e4:	8b 55 08             	mov    0x8(%ebp),%edx
  8014e7:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014e9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014ed:	74 07                	je     8014f6 <strtol+0x141>
  8014ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f2:	f7 d8                	neg    %eax
  8014f4:	eb 03                	jmp    8014f9 <strtol+0x144>
  8014f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <ltostr>:

void
ltostr(long value, char *str)
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
  8014fe:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801501:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801508:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80150f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801513:	79 13                	jns    801528 <ltostr+0x2d>
	{
		neg = 1;
  801515:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80151c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801522:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801525:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801528:	8b 45 08             	mov    0x8(%ebp),%eax
  80152b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801530:	99                   	cltd   
  801531:	f7 f9                	idiv   %ecx
  801533:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801536:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801539:	8d 50 01             	lea    0x1(%eax),%edx
  80153c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80153f:	89 c2                	mov    %eax,%edx
  801541:	8b 45 0c             	mov    0xc(%ebp),%eax
  801544:	01 d0                	add    %edx,%eax
  801546:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801549:	83 c2 30             	add    $0x30,%edx
  80154c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80154e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801551:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801556:	f7 e9                	imul   %ecx
  801558:	c1 fa 02             	sar    $0x2,%edx
  80155b:	89 c8                	mov    %ecx,%eax
  80155d:	c1 f8 1f             	sar    $0x1f,%eax
  801560:	29 c2                	sub    %eax,%edx
  801562:	89 d0                	mov    %edx,%eax
  801564:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801567:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80156a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80156f:	f7 e9                	imul   %ecx
  801571:	c1 fa 02             	sar    $0x2,%edx
  801574:	89 c8                	mov    %ecx,%eax
  801576:	c1 f8 1f             	sar    $0x1f,%eax
  801579:	29 c2                	sub    %eax,%edx
  80157b:	89 d0                	mov    %edx,%eax
  80157d:	c1 e0 02             	shl    $0x2,%eax
  801580:	01 d0                	add    %edx,%eax
  801582:	01 c0                	add    %eax,%eax
  801584:	29 c1                	sub    %eax,%ecx
  801586:	89 ca                	mov    %ecx,%edx
  801588:	85 d2                	test   %edx,%edx
  80158a:	75 9c                	jne    801528 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80158c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801593:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801596:	48                   	dec    %eax
  801597:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80159a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80159e:	74 3d                	je     8015dd <ltostr+0xe2>
		start = 1 ;
  8015a0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8015a7:	eb 34                	jmp    8015dd <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8015a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015af:	01 d0                	add    %edx,%eax
  8015b1:	8a 00                	mov    (%eax),%al
  8015b3:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8015b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bc:	01 c2                	add    %eax,%edx
  8015be:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c4:	01 c8                	add    %ecx,%eax
  8015c6:	8a 00                	mov    (%eax),%al
  8015c8:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015ca:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d0:	01 c2                	add    %eax,%edx
  8015d2:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015d5:	88 02                	mov    %al,(%edx)
		start++ ;
  8015d7:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015da:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015e0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015e3:	7c c4                	jl     8015a9 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015e5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015eb:	01 d0                	add    %edx,%eax
  8015ed:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015f0:	90                   	nop
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
  8015f6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015f9:	ff 75 08             	pushl  0x8(%ebp)
  8015fc:	e8 54 fa ff ff       	call   801055 <strlen>
  801601:	83 c4 04             	add    $0x4,%esp
  801604:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801607:	ff 75 0c             	pushl  0xc(%ebp)
  80160a:	e8 46 fa ff ff       	call   801055 <strlen>
  80160f:	83 c4 04             	add    $0x4,%esp
  801612:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801615:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80161c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801623:	eb 17                	jmp    80163c <strcconcat+0x49>
		final[s] = str1[s] ;
  801625:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801628:	8b 45 10             	mov    0x10(%ebp),%eax
  80162b:	01 c2                	add    %eax,%edx
  80162d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801630:	8b 45 08             	mov    0x8(%ebp),%eax
  801633:	01 c8                	add    %ecx,%eax
  801635:	8a 00                	mov    (%eax),%al
  801637:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801639:	ff 45 fc             	incl   -0x4(%ebp)
  80163c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80163f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801642:	7c e1                	jl     801625 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801644:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80164b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801652:	eb 1f                	jmp    801673 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801654:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801657:	8d 50 01             	lea    0x1(%eax),%edx
  80165a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80165d:	89 c2                	mov    %eax,%edx
  80165f:	8b 45 10             	mov    0x10(%ebp),%eax
  801662:	01 c2                	add    %eax,%edx
  801664:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801667:	8b 45 0c             	mov    0xc(%ebp),%eax
  80166a:	01 c8                	add    %ecx,%eax
  80166c:	8a 00                	mov    (%eax),%al
  80166e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801670:	ff 45 f8             	incl   -0x8(%ebp)
  801673:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801676:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801679:	7c d9                	jl     801654 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80167b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80167e:	8b 45 10             	mov    0x10(%ebp),%eax
  801681:	01 d0                	add    %edx,%eax
  801683:	c6 00 00             	movb   $0x0,(%eax)
}
  801686:	90                   	nop
  801687:	c9                   	leave  
  801688:	c3                   	ret    

00801689 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801689:	55                   	push   %ebp
  80168a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80168c:	8b 45 14             	mov    0x14(%ebp),%eax
  80168f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801695:	8b 45 14             	mov    0x14(%ebp),%eax
  801698:	8b 00                	mov    (%eax),%eax
  80169a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a4:	01 d0                	add    %edx,%eax
  8016a6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016ac:	eb 0c                	jmp    8016ba <strsplit+0x31>
			*string++ = 0;
  8016ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b1:	8d 50 01             	lea    0x1(%eax),%edx
  8016b4:	89 55 08             	mov    %edx,0x8(%ebp)
  8016b7:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bd:	8a 00                	mov    (%eax),%al
  8016bf:	84 c0                	test   %al,%al
  8016c1:	74 18                	je     8016db <strsplit+0x52>
  8016c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c6:	8a 00                	mov    (%eax),%al
  8016c8:	0f be c0             	movsbl %al,%eax
  8016cb:	50                   	push   %eax
  8016cc:	ff 75 0c             	pushl  0xc(%ebp)
  8016cf:	e8 13 fb ff ff       	call   8011e7 <strchr>
  8016d4:	83 c4 08             	add    $0x8,%esp
  8016d7:	85 c0                	test   %eax,%eax
  8016d9:	75 d3                	jne    8016ae <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
  8016de:	8a 00                	mov    (%eax),%al
  8016e0:	84 c0                	test   %al,%al
  8016e2:	74 5a                	je     80173e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e7:	8b 00                	mov    (%eax),%eax
  8016e9:	83 f8 0f             	cmp    $0xf,%eax
  8016ec:	75 07                	jne    8016f5 <strsplit+0x6c>
		{
			return 0;
  8016ee:	b8 00 00 00 00       	mov    $0x0,%eax
  8016f3:	eb 66                	jmp    80175b <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8016f8:	8b 00                	mov    (%eax),%eax
  8016fa:	8d 48 01             	lea    0x1(%eax),%ecx
  8016fd:	8b 55 14             	mov    0x14(%ebp),%edx
  801700:	89 0a                	mov    %ecx,(%edx)
  801702:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801709:	8b 45 10             	mov    0x10(%ebp),%eax
  80170c:	01 c2                	add    %eax,%edx
  80170e:	8b 45 08             	mov    0x8(%ebp),%eax
  801711:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801713:	eb 03                	jmp    801718 <strsplit+0x8f>
			string++;
  801715:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801718:	8b 45 08             	mov    0x8(%ebp),%eax
  80171b:	8a 00                	mov    (%eax),%al
  80171d:	84 c0                	test   %al,%al
  80171f:	74 8b                	je     8016ac <strsplit+0x23>
  801721:	8b 45 08             	mov    0x8(%ebp),%eax
  801724:	8a 00                	mov    (%eax),%al
  801726:	0f be c0             	movsbl %al,%eax
  801729:	50                   	push   %eax
  80172a:	ff 75 0c             	pushl  0xc(%ebp)
  80172d:	e8 b5 fa ff ff       	call   8011e7 <strchr>
  801732:	83 c4 08             	add    $0x8,%esp
  801735:	85 c0                	test   %eax,%eax
  801737:	74 dc                	je     801715 <strsplit+0x8c>
			string++;
	}
  801739:	e9 6e ff ff ff       	jmp    8016ac <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80173e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80173f:	8b 45 14             	mov    0x14(%ebp),%eax
  801742:	8b 00                	mov    (%eax),%eax
  801744:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80174b:	8b 45 10             	mov    0x10(%ebp),%eax
  80174e:	01 d0                	add    %edx,%eax
  801750:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801756:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80175b:	c9                   	leave  
  80175c:	c3                   	ret    

0080175d <malloc>:
//==================================================================================//
int FirstTimeFlag = 1;
int allocated[MAXN];

void* malloc(uint32 size)
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
  801760:	83 ec 28             	sub    $0x28,%esp
	//DON'T CHANGE THIS CODE
	if(FirstTimeFlag)
  801763:	a1 04 30 80 00       	mov    0x803004,%eax
  801768:	85 c0                	test   %eax,%eax
  80176a:	74 0f                	je     80177b <malloc+0x1e>
	{
		initialize_buddy();
  80176c:	e8 a4 02 00 00       	call   801a15 <initialize_buddy>
		FirstTimeFlag = 0;
  801771:	c7 05 04 30 80 00 00 	movl   $0x0,0x803004
  801778:	00 00 00 
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
  80177b:	81 7d 08 00 08 00 00 	cmpl   $0x800,0x8(%ebp)
  801782:	0f 86 0b 01 00 00    	jbe    801893 <malloc+0x136>
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
  801788:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80178f:	8b 45 08             	mov    0x8(%ebp),%eax
  801792:	c1 e8 0c             	shr    $0xc,%eax
  801795:	89 c2                	mov    %eax,%edx
  801797:	8b 45 08             	mov    0x8(%ebp),%eax
  80179a:	25 ff 0f 00 00       	and    $0xfff,%eax
  80179f:	85 c0                	test   %eax,%eax
  8017a1:	74 07                	je     8017aa <malloc+0x4d>
  8017a3:	b8 01 00 00 00       	mov    $0x1,%eax
  8017a8:	eb 05                	jmp    8017af <malloc+0x52>
  8017aa:	b8 00 00 00 00       	mov    $0x0,%eax
  8017af:	01 d0                	add    %edx,%eax
  8017b1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8017b4:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  8017bb:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
		for(i = 0; i < MAXN; i++) {
  8017c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8017c9:	eb 5c                	jmp    801827 <malloc+0xca>
			if(allocated[i] != 0) continue;
  8017cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ce:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8017d5:	85 c0                	test   %eax,%eax
  8017d7:	75 4a                	jne    801823 <malloc+0xc6>
			j = 1;
  8017d9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
			i++;
  8017e0:	ff 45 f4             	incl   -0xc(%ebp)
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  8017e3:	eb 06                	jmp    8017eb <malloc+0x8e>
				i++;
  8017e5:	ff 45 f4             	incl   -0xc(%ebp)
				j++;
  8017e8:	ff 45 ec             	incl   -0x14(%ebp)
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
			j = 1;
			i++;
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  8017eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ee:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8017f3:	77 16                	ja     80180b <malloc+0xae>
  8017f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017f8:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8017ff:	85 c0                	test   %eax,%eax
  801801:	75 08                	jne    80180b <malloc+0xae>
  801803:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801806:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801809:	7c da                	jl     8017e5 <malloc+0x88>
				i++;
				j++;
			}
			if(j == sizeToPage) {
  80180b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80180e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801811:	75 0b                	jne    80181e <malloc+0xc1>
				indx = i - j;
  801813:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801816:	2b 45 ec             	sub    -0x14(%ebp),%eax
  801819:	89 45 f0             	mov    %eax,-0x10(%ebp)
				break;
  80181c:	eb 13                	jmp    801831 <malloc+0xd4>
			}
			i--;
  80181e:	ff 4d f4             	decl   -0xc(%ebp)
  801821:	eb 01                	jmp    801824 <malloc+0xc7>
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
  801823:	90                   	nop
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
  801824:	ff 45 f4             	incl   -0xc(%ebp)
  801827:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80182a:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80182f:	76 9a                	jbe    8017cb <malloc+0x6e>
				indx = i - j;
				break;
			}
			i--;
		}
		if(indx == -1) {
  801831:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
  801835:	75 07                	jne    80183e <malloc+0xe1>
			return NULL;
  801837:	b8 00 00 00 00       	mov    $0x0,%eax
  80183c:	eb 5a                	jmp    801898 <malloc+0x13b>
		}
		i = indx;
  80183e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801841:	89 45 f4             	mov    %eax,-0xc(%ebp)
		while(i < j + indx) {
  801844:	eb 13                	jmp    801859 <malloc+0xfc>
			allocated[i++] = j;
  801846:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801849:	8d 50 01             	lea    0x1(%eax),%edx
  80184c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80184f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801852:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		}
		if(indx == -1) {
			return NULL;
		}
		i = indx;
		while(i < j + indx) {
  801859:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80185c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80185f:	01 d0                	add    %edx,%eax
  801861:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801864:	7f e0                	jg     801846 <malloc+0xe9>
			allocated[i++] = j;
		}
		uint32 *address = (uint32 *)(USER_HEAP_START + (indx * PAGE_SIZE));
  801866:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801869:	c1 e0 0c             	shl    $0xc,%eax
  80186c:	05 00 00 00 80       	add    $0x80000000,%eax
  801871:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		sys_allocateMem(USER_HEAP_START + (indx * PAGE_SIZE), size);
  801874:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801877:	c1 e0 0c             	shl    $0xc,%eax
  80187a:	05 00 00 00 80       	add    $0x80000000,%eax
  80187f:	83 ec 08             	sub    $0x8,%esp
  801882:	ff 75 08             	pushl  0x8(%ebp)
  801885:	50                   	push   %eax
  801886:	e8 84 04 00 00       	call   801d0f <sys_allocateMem>
  80188b:	83 c4 10             	add    $0x10,%esp
		return address;
  80188e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801891:	eb 05                	jmp    801898 <malloc+0x13b>
	//1) FIRST FIT strategy (if size > 2 KB)
	//2) Buddy System (if size <= 2 KB)

	//refer to the project presentation and documentation for details

	return NULL;
  801893:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801898:	c9                   	leave  
  801899:	c3                   	ret    

0080189a <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80189a:	55                   	push   %ebp
  80189b:	89 e5                	mov    %esp,%ebp
  80189d:	83 ec 18             	sub    $0x18,%esp
	//TODO: [PROJECT 2020 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
  8018a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8018a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8018a9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8018ae:	89 45 08             	mov    %eax,0x8(%ebp)
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
  8018b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8018b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bb:	05 00 00 00 80       	add    $0x80000000,%eax
  8018c0:	c1 e8 0c             	shr    $0xc,%eax
  8018c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int removable_size = allocated[indx];
  8018c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018c9:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8018d0:	89 45 e8             	mov    %eax,-0x18(%ebp)
	size = allocated[indx];
  8018d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018d6:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8018dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while(size > 0) {
  8018e0:	eb 17                	jmp    8018f9 <free+0x5f>
		allocated[indx++] = 0;
  8018e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018e5:	8d 50 01             	lea    0x1(%eax),%edx
  8018e8:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8018eb:	c7 04 85 20 31 80 00 	movl   $0x0,0x803120(,%eax,4)
  8018f2:	00 00 00 00 
		size--;
  8018f6:	ff 4d f4             	decl   -0xc(%ebp)
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
	int removable_size = allocated[indx];
	size = allocated[indx];
	while(size > 0) {
  8018f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8018fd:	7f e3                	jg     8018e2 <free+0x48>
		allocated[indx++] = 0;
		size--;
	}
	sys_freeMem((uint32)virtual_address, removable_size);
  8018ff:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801902:	8b 45 08             	mov    0x8(%ebp),%eax
  801905:	83 ec 08             	sub    $0x8,%esp
  801908:	52                   	push   %edx
  801909:	50                   	push   %eax
  80190a:	e8 e4 03 00 00       	call   801cf3 <sys_freeMem>
  80190f:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details

}
  801912:	90                   	nop
  801913:	c9                   	leave  
  801914:	c3                   	ret    

00801915 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801915:	55                   	push   %ebp
  801916:	89 e5                	mov    %esp,%ebp
  801918:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - BONUS2] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  80191b:	83 ec 04             	sub    $0x4,%esp
  80191e:	68 d0 2a 80 00       	push   $0x802ad0
  801923:	6a 7a                	push   $0x7a
  801925:	68 f6 2a 80 00       	push   $0x802af6
  80192a:	e8 02 ee ff ff       	call   800731 <_panic>

0080192f <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
  801932:	83 ec 18             	sub    $0x18,%esp
  801935:	8b 45 10             	mov    0x10(%ebp),%eax
  801938:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80193b:	83 ec 04             	sub    $0x4,%esp
  80193e:	68 04 2b 80 00       	push   $0x802b04
  801943:	68 84 00 00 00       	push   $0x84
  801948:	68 f6 2a 80 00       	push   $0x802af6
  80194d:	e8 df ed ff ff       	call   800731 <_panic>

00801952 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801952:	55                   	push   %ebp
  801953:	89 e5                	mov    %esp,%ebp
  801955:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801958:	83 ec 04             	sub    $0x4,%esp
  80195b:	68 04 2b 80 00       	push   $0x802b04
  801960:	68 8a 00 00 00       	push   $0x8a
  801965:	68 f6 2a 80 00       	push   $0x802af6
  80196a:	e8 c2 ed ff ff       	call   800731 <_panic>

0080196f <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
  801972:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801975:	83 ec 04             	sub    $0x4,%esp
  801978:	68 04 2b 80 00       	push   $0x802b04
  80197d:	68 90 00 00 00       	push   $0x90
  801982:	68 f6 2a 80 00       	push   $0x802af6
  801987:	e8 a5 ed ff ff       	call   800731 <_panic>

0080198c <expand>:
}

void expand(uint32 newSize)
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
  80198f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801992:	83 ec 04             	sub    $0x4,%esp
  801995:	68 04 2b 80 00       	push   $0x802b04
  80199a:	68 95 00 00 00       	push   $0x95
  80199f:	68 f6 2a 80 00       	push   $0x802af6
  8019a4:	e8 88 ed ff ff       	call   800731 <_panic>

008019a9 <shrink>:
}
void shrink(uint32 newSize)
{
  8019a9:	55                   	push   %ebp
  8019aa:	89 e5                	mov    %esp,%ebp
  8019ac:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019af:	83 ec 04             	sub    $0x4,%esp
  8019b2:	68 04 2b 80 00       	push   $0x802b04
  8019b7:	68 99 00 00 00       	push   $0x99
  8019bc:	68 f6 2a 80 00       	push   $0x802af6
  8019c1:	e8 6b ed ff ff       	call   800731 <_panic>

008019c6 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8019c6:	55                   	push   %ebp
  8019c7:	89 e5                	mov    %esp,%ebp
  8019c9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019cc:	83 ec 04             	sub    $0x4,%esp
  8019cf:	68 04 2b 80 00       	push   $0x802b04
  8019d4:	68 9e 00 00 00       	push   $0x9e
  8019d9:	68 f6 2a 80 00       	push   $0x802af6
  8019de:	e8 4e ed ff ff       	call   800731 <_panic>

008019e3 <ClearNodeData>:
 * inside the user heap
 */
 
struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  8019e3:	55                   	push   %ebp
  8019e4:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  8019e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e9:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  8019ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f0:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  8019f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f7:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  8019fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801a01:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  801a08:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  801a12:	90                   	nop
  801a13:	5d                   	pop    %ebp
  801a14:	c3                   	ret    

00801a15 <initialize_buddy>:

void initialize_buddy()
{
  801a15:	55                   	push   %ebp
  801a16:	89 e5                	mov    %esp,%ebp
  801a18:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801a1b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a22:	e9 b7 00 00 00       	jmp    801ade <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  801a27:	8b 15 04 31 80 00    	mov    0x803104,%edx
  801a2d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a30:	89 c8                	mov    %ecx,%eax
  801a32:	01 c0                	add    %eax,%eax
  801a34:	01 c8                	add    %ecx,%eax
  801a36:	c1 e0 03             	shl    $0x3,%eax
  801a39:	05 20 31 88 00       	add    $0x883120,%eax
  801a3e:	89 10                	mov    %edx,(%eax)
  801a40:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a43:	89 d0                	mov    %edx,%eax
  801a45:	01 c0                	add    %eax,%eax
  801a47:	01 d0                	add    %edx,%eax
  801a49:	c1 e0 03             	shl    $0x3,%eax
  801a4c:	05 20 31 88 00       	add    $0x883120,%eax
  801a51:	8b 00                	mov    (%eax),%eax
  801a53:	85 c0                	test   %eax,%eax
  801a55:	74 1c                	je     801a73 <initialize_buddy+0x5e>
  801a57:	8b 15 04 31 80 00    	mov    0x803104,%edx
  801a5d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a60:	89 c8                	mov    %ecx,%eax
  801a62:	01 c0                	add    %eax,%eax
  801a64:	01 c8                	add    %ecx,%eax
  801a66:	c1 e0 03             	shl    $0x3,%eax
  801a69:	05 20 31 88 00       	add    $0x883120,%eax
  801a6e:	89 42 04             	mov    %eax,0x4(%edx)
  801a71:	eb 16                	jmp    801a89 <initialize_buddy+0x74>
  801a73:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a76:	89 d0                	mov    %edx,%eax
  801a78:	01 c0                	add    %eax,%eax
  801a7a:	01 d0                	add    %edx,%eax
  801a7c:	c1 e0 03             	shl    $0x3,%eax
  801a7f:	05 20 31 88 00       	add    $0x883120,%eax
  801a84:	a3 08 31 80 00       	mov    %eax,0x803108
  801a89:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a8c:	89 d0                	mov    %edx,%eax
  801a8e:	01 c0                	add    %eax,%eax
  801a90:	01 d0                	add    %edx,%eax
  801a92:	c1 e0 03             	shl    $0x3,%eax
  801a95:	05 20 31 88 00       	add    $0x883120,%eax
  801a9a:	a3 04 31 80 00       	mov    %eax,0x803104
  801a9f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801aa2:	89 d0                	mov    %edx,%eax
  801aa4:	01 c0                	add    %eax,%eax
  801aa6:	01 d0                	add    %edx,%eax
  801aa8:	c1 e0 03             	shl    $0x3,%eax
  801aab:	05 24 31 88 00       	add    $0x883124,%eax
  801ab0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801ab6:	a1 10 31 80 00       	mov    0x803110,%eax
  801abb:	40                   	inc    %eax
  801abc:	a3 10 31 80 00       	mov    %eax,0x803110
		ClearNodeData(&(FreeNodes[i]));
  801ac1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ac4:	89 d0                	mov    %edx,%eax
  801ac6:	01 c0                	add    %eax,%eax
  801ac8:	01 d0                	add    %edx,%eax
  801aca:	c1 e0 03             	shl    $0x3,%eax
  801acd:	05 20 31 88 00       	add    $0x883120,%eax
  801ad2:	50                   	push   %eax
  801ad3:	e8 0b ff ff ff       	call   8019e3 <ClearNodeData>
  801ad8:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801adb:	ff 45 fc             	incl   -0x4(%ebp)
  801ade:	81 7d fc 3f 9c 00 00 	cmpl   $0x9c3f,-0x4(%ebp)
  801ae5:	0f 8e 3c ff ff ff    	jle    801a27 <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  801aeb:	90                   	nop
  801aec:	c9                   	leave  
  801aed:	c3                   	ret    

00801aee <CreateNewBuddySpace>:
/*===============================================================*/

//TODO: [PROJECT 2020 - BONUS4] Expand Buddy Free Node List

void CreateNewBuddySpace()
{
  801aee:	55                   	push   %ebp
  801aef:	89 e5                	mov    %esp,%ebp
  801af1:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Create New Buddy Block]
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  801af4:	83 ec 04             	sub    $0x4,%esp
  801af7:	68 28 2b 80 00       	push   $0x802b28
  801afc:	6a 22                	push   $0x22
  801afe:	68 5a 2b 80 00       	push   $0x802b5a
  801b03:	e8 29 ec ff ff       	call   800731 <_panic>

00801b08 <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  801b08:	55                   	push   %ebp
  801b09:	89 e5                	mov    %esp,%ebp
  801b0b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Get Allocation]
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  801b0e:	83 ec 04             	sub    $0x4,%esp
  801b11:	68 68 2b 80 00       	push   $0x802b68
  801b16:	6a 2a                	push   $0x2a
  801b18:	68 5a 2b 80 00       	push   $0x802b5a
  801b1d:	e8 0f ec ff ff       	call   800731 <_panic>

00801b22 <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  801b22:	55                   	push   %ebp
  801b23:	89 e5                	mov    %esp,%ebp
  801b25:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Free Allocation]
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  801b28:	83 ec 04             	sub    $0x4,%esp
  801b2b:	68 a0 2b 80 00       	push   $0x802ba0
  801b30:	6a 31                	push   $0x31
  801b32:	68 5a 2b 80 00       	push   $0x802b5a
  801b37:	e8 f5 eb ff ff       	call   800731 <_panic>

00801b3c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b3c:	55                   	push   %ebp
  801b3d:	89 e5                	mov    %esp,%ebp
  801b3f:	57                   	push   %edi
  801b40:	56                   	push   %esi
  801b41:	53                   	push   %ebx
  801b42:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b45:	8b 45 08             	mov    0x8(%ebp),%eax
  801b48:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b4b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b4e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b51:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b54:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b57:	cd 30                	int    $0x30
  801b59:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b5f:	83 c4 10             	add    $0x10,%esp
  801b62:	5b                   	pop    %ebx
  801b63:	5e                   	pop    %esi
  801b64:	5f                   	pop    %edi
  801b65:	5d                   	pop    %ebp
  801b66:	c3                   	ret    

00801b67 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b67:	55                   	push   %ebp
  801b68:	89 e5                	mov    %esp,%ebp
  801b6a:	83 ec 04             	sub    $0x4,%esp
  801b6d:	8b 45 10             	mov    0x10(%ebp),%eax
  801b70:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b73:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b77:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	52                   	push   %edx
  801b7f:	ff 75 0c             	pushl  0xc(%ebp)
  801b82:	50                   	push   %eax
  801b83:	6a 00                	push   $0x0
  801b85:	e8 b2 ff ff ff       	call   801b3c <syscall>
  801b8a:	83 c4 18             	add    $0x18,%esp
}
  801b8d:	90                   	nop
  801b8e:	c9                   	leave  
  801b8f:	c3                   	ret    

00801b90 <sys_cgetc>:

int
sys_cgetc(void)
{
  801b90:	55                   	push   %ebp
  801b91:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 01                	push   $0x1
  801b9f:	e8 98 ff ff ff       	call   801b3c <syscall>
  801ba4:	83 c4 18             	add    $0x18,%esp
}
  801ba7:	c9                   	leave  
  801ba8:	c3                   	ret    

00801ba9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ba9:	55                   	push   %ebp
  801baa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801bac:	8b 45 08             	mov    0x8(%ebp),%eax
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	50                   	push   %eax
  801bb8:	6a 05                	push   $0x5
  801bba:	e8 7d ff ff ff       	call   801b3c <syscall>
  801bbf:	83 c4 18             	add    $0x18,%esp
}
  801bc2:	c9                   	leave  
  801bc3:	c3                   	ret    

00801bc4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801bc4:	55                   	push   %ebp
  801bc5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 02                	push   $0x2
  801bd3:	e8 64 ff ff ff       	call   801b3c <syscall>
  801bd8:	83 c4 18             	add    $0x18,%esp
}
  801bdb:	c9                   	leave  
  801bdc:	c3                   	ret    

00801bdd <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801bdd:	55                   	push   %ebp
  801bde:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	6a 03                	push   $0x3
  801bec:	e8 4b ff ff ff       	call   801b3c <syscall>
  801bf1:	83 c4 18             	add    $0x18,%esp
}
  801bf4:	c9                   	leave  
  801bf5:	c3                   	ret    

00801bf6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801bf6:	55                   	push   %ebp
  801bf7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 04                	push   $0x4
  801c05:	e8 32 ff ff ff       	call   801b3c <syscall>
  801c0a:	83 c4 18             	add    $0x18,%esp
}
  801c0d:	c9                   	leave  
  801c0e:	c3                   	ret    

00801c0f <sys_env_exit>:


void sys_env_exit(void)
{
  801c0f:	55                   	push   %ebp
  801c10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 06                	push   $0x6
  801c1e:	e8 19 ff ff ff       	call   801b3c <syscall>
  801c23:	83 c4 18             	add    $0x18,%esp
}
  801c26:	90                   	nop
  801c27:	c9                   	leave  
  801c28:	c3                   	ret    

00801c29 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c29:	55                   	push   %ebp
  801c2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	52                   	push   %edx
  801c39:	50                   	push   %eax
  801c3a:	6a 07                	push   $0x7
  801c3c:	e8 fb fe ff ff       	call   801b3c <syscall>
  801c41:	83 c4 18             	add    $0x18,%esp
}
  801c44:	c9                   	leave  
  801c45:	c3                   	ret    

00801c46 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c46:	55                   	push   %ebp
  801c47:	89 e5                	mov    %esp,%ebp
  801c49:	56                   	push   %esi
  801c4a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c4b:	8b 75 18             	mov    0x18(%ebp),%esi
  801c4e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c51:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c57:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5a:	56                   	push   %esi
  801c5b:	53                   	push   %ebx
  801c5c:	51                   	push   %ecx
  801c5d:	52                   	push   %edx
  801c5e:	50                   	push   %eax
  801c5f:	6a 08                	push   $0x8
  801c61:	e8 d6 fe ff ff       	call   801b3c <syscall>
  801c66:	83 c4 18             	add    $0x18,%esp
}
  801c69:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c6c:	5b                   	pop    %ebx
  801c6d:	5e                   	pop    %esi
  801c6e:	5d                   	pop    %ebp
  801c6f:	c3                   	ret    

00801c70 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c70:	55                   	push   %ebp
  801c71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c73:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c76:	8b 45 08             	mov    0x8(%ebp),%eax
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	52                   	push   %edx
  801c80:	50                   	push   %eax
  801c81:	6a 09                	push   $0x9
  801c83:	e8 b4 fe ff ff       	call   801b3c <syscall>
  801c88:	83 c4 18             	add    $0x18,%esp
}
  801c8b:	c9                   	leave  
  801c8c:	c3                   	ret    

00801c8d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c8d:	55                   	push   %ebp
  801c8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	ff 75 0c             	pushl  0xc(%ebp)
  801c99:	ff 75 08             	pushl  0x8(%ebp)
  801c9c:	6a 0a                	push   $0xa
  801c9e:	e8 99 fe ff ff       	call   801b3c <syscall>
  801ca3:	83 c4 18             	add    $0x18,%esp
}
  801ca6:	c9                   	leave  
  801ca7:	c3                   	ret    

00801ca8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ca8:	55                   	push   %ebp
  801ca9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 0b                	push   $0xb
  801cb7:	e8 80 fe ff ff       	call   801b3c <syscall>
  801cbc:	83 c4 18             	add    $0x18,%esp
}
  801cbf:	c9                   	leave  
  801cc0:	c3                   	ret    

00801cc1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801cc1:	55                   	push   %ebp
  801cc2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 0c                	push   $0xc
  801cd0:	e8 67 fe ff ff       	call   801b3c <syscall>
  801cd5:	83 c4 18             	add    $0x18,%esp
}
  801cd8:	c9                   	leave  
  801cd9:	c3                   	ret    

00801cda <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801cda:	55                   	push   %ebp
  801cdb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 0d                	push   $0xd
  801ce9:	e8 4e fe ff ff       	call   801b3c <syscall>
  801cee:	83 c4 18             	add    $0x18,%esp
}
  801cf1:	c9                   	leave  
  801cf2:	c3                   	ret    

00801cf3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801cf3:	55                   	push   %ebp
  801cf4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 00                	push   $0x0
  801cfc:	ff 75 0c             	pushl  0xc(%ebp)
  801cff:	ff 75 08             	pushl  0x8(%ebp)
  801d02:	6a 11                	push   $0x11
  801d04:	e8 33 fe ff ff       	call   801b3c <syscall>
  801d09:	83 c4 18             	add    $0x18,%esp
	return;
  801d0c:	90                   	nop
}
  801d0d:	c9                   	leave  
  801d0e:	c3                   	ret    

00801d0f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d0f:	55                   	push   %ebp
  801d10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	ff 75 0c             	pushl  0xc(%ebp)
  801d1b:	ff 75 08             	pushl  0x8(%ebp)
  801d1e:	6a 12                	push   $0x12
  801d20:	e8 17 fe ff ff       	call   801b3c <syscall>
  801d25:	83 c4 18             	add    $0x18,%esp
	return ;
  801d28:	90                   	nop
}
  801d29:	c9                   	leave  
  801d2a:	c3                   	ret    

00801d2b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d2b:	55                   	push   %ebp
  801d2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 00                	push   $0x0
  801d34:	6a 00                	push   $0x0
  801d36:	6a 00                	push   $0x0
  801d38:	6a 0e                	push   $0xe
  801d3a:	e8 fd fd ff ff       	call   801b3c <syscall>
  801d3f:	83 c4 18             	add    $0x18,%esp
}
  801d42:	c9                   	leave  
  801d43:	c3                   	ret    

00801d44 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d44:	55                   	push   %ebp
  801d45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d47:	6a 00                	push   $0x0
  801d49:	6a 00                	push   $0x0
  801d4b:	6a 00                	push   $0x0
  801d4d:	6a 00                	push   $0x0
  801d4f:	ff 75 08             	pushl  0x8(%ebp)
  801d52:	6a 0f                	push   $0xf
  801d54:	e8 e3 fd ff ff       	call   801b3c <syscall>
  801d59:	83 c4 18             	add    $0x18,%esp
}
  801d5c:	c9                   	leave  
  801d5d:	c3                   	ret    

00801d5e <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d5e:	55                   	push   %ebp
  801d5f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801d61:	6a 00                	push   $0x0
  801d63:	6a 00                	push   $0x0
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 10                	push   $0x10
  801d6d:	e8 ca fd ff ff       	call   801b3c <syscall>
  801d72:	83 c4 18             	add    $0x18,%esp
}
  801d75:	90                   	nop
  801d76:	c9                   	leave  
  801d77:	c3                   	ret    

00801d78 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d78:	55                   	push   %ebp
  801d79:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 14                	push   $0x14
  801d87:	e8 b0 fd ff ff       	call   801b3c <syscall>
  801d8c:	83 c4 18             	add    $0x18,%esp
}
  801d8f:	90                   	nop
  801d90:	c9                   	leave  
  801d91:	c3                   	ret    

00801d92 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d92:	55                   	push   %ebp
  801d93:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d95:	6a 00                	push   $0x0
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 15                	push   $0x15
  801da1:	e8 96 fd ff ff       	call   801b3c <syscall>
  801da6:	83 c4 18             	add    $0x18,%esp
}
  801da9:	90                   	nop
  801daa:	c9                   	leave  
  801dab:	c3                   	ret    

00801dac <sys_cputc>:


void
sys_cputc(const char c)
{
  801dac:	55                   	push   %ebp
  801dad:	89 e5                	mov    %esp,%ebp
  801daf:	83 ec 04             	sub    $0x4,%esp
  801db2:	8b 45 08             	mov    0x8(%ebp),%eax
  801db5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801db8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	50                   	push   %eax
  801dc5:	6a 16                	push   $0x16
  801dc7:	e8 70 fd ff ff       	call   801b3c <syscall>
  801dcc:	83 c4 18             	add    $0x18,%esp
}
  801dcf:	90                   	nop
  801dd0:	c9                   	leave  
  801dd1:	c3                   	ret    

00801dd2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801dd2:	55                   	push   %ebp
  801dd3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 17                	push   $0x17
  801de1:	e8 56 fd ff ff       	call   801b3c <syscall>
  801de6:	83 c4 18             	add    $0x18,%esp
}
  801de9:	90                   	nop
  801dea:	c9                   	leave  
  801deb:	c3                   	ret    

00801dec <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801dec:	55                   	push   %ebp
  801ded:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801def:	8b 45 08             	mov    0x8(%ebp),%eax
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	ff 75 0c             	pushl  0xc(%ebp)
  801dfb:	50                   	push   %eax
  801dfc:	6a 18                	push   $0x18
  801dfe:	e8 39 fd ff ff       	call   801b3c <syscall>
  801e03:	83 c4 18             	add    $0x18,%esp
}
  801e06:	c9                   	leave  
  801e07:	c3                   	ret    

00801e08 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e08:	55                   	push   %ebp
  801e09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	6a 00                	push   $0x0
  801e17:	52                   	push   %edx
  801e18:	50                   	push   %eax
  801e19:	6a 1b                	push   $0x1b
  801e1b:	e8 1c fd ff ff       	call   801b3c <syscall>
  801e20:	83 c4 18             	add    $0x18,%esp
}
  801e23:	c9                   	leave  
  801e24:	c3                   	ret    

00801e25 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e25:	55                   	push   %ebp
  801e26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e28:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	52                   	push   %edx
  801e35:	50                   	push   %eax
  801e36:	6a 19                	push   $0x19
  801e38:	e8 ff fc ff ff       	call   801b3c <syscall>
  801e3d:	83 c4 18             	add    $0x18,%esp
}
  801e40:	90                   	nop
  801e41:	c9                   	leave  
  801e42:	c3                   	ret    

00801e43 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e43:	55                   	push   %ebp
  801e44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e46:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e49:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	52                   	push   %edx
  801e53:	50                   	push   %eax
  801e54:	6a 1a                	push   $0x1a
  801e56:	e8 e1 fc ff ff       	call   801b3c <syscall>
  801e5b:	83 c4 18             	add    $0x18,%esp
}
  801e5e:	90                   	nop
  801e5f:	c9                   	leave  
  801e60:	c3                   	ret    

00801e61 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801e61:	55                   	push   %ebp
  801e62:	89 e5                	mov    %esp,%ebp
  801e64:	83 ec 04             	sub    $0x4,%esp
  801e67:	8b 45 10             	mov    0x10(%ebp),%eax
  801e6a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e6d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e70:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e74:	8b 45 08             	mov    0x8(%ebp),%eax
  801e77:	6a 00                	push   $0x0
  801e79:	51                   	push   %ecx
  801e7a:	52                   	push   %edx
  801e7b:	ff 75 0c             	pushl  0xc(%ebp)
  801e7e:	50                   	push   %eax
  801e7f:	6a 1c                	push   $0x1c
  801e81:	e8 b6 fc ff ff       	call   801b3c <syscall>
  801e86:	83 c4 18             	add    $0x18,%esp
}
  801e89:	c9                   	leave  
  801e8a:	c3                   	ret    

00801e8b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e8b:	55                   	push   %ebp
  801e8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e91:	8b 45 08             	mov    0x8(%ebp),%eax
  801e94:	6a 00                	push   $0x0
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	52                   	push   %edx
  801e9b:	50                   	push   %eax
  801e9c:	6a 1d                	push   $0x1d
  801e9e:	e8 99 fc ff ff       	call   801b3c <syscall>
  801ea3:	83 c4 18             	add    $0x18,%esp
}
  801ea6:	c9                   	leave  
  801ea7:	c3                   	ret    

00801ea8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ea8:	55                   	push   %ebp
  801ea9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801eab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801eae:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb4:	6a 00                	push   $0x0
  801eb6:	6a 00                	push   $0x0
  801eb8:	51                   	push   %ecx
  801eb9:	52                   	push   %edx
  801eba:	50                   	push   %eax
  801ebb:	6a 1e                	push   $0x1e
  801ebd:	e8 7a fc ff ff       	call   801b3c <syscall>
  801ec2:	83 c4 18             	add    $0x18,%esp
}
  801ec5:	c9                   	leave  
  801ec6:	c3                   	ret    

00801ec7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ec7:	55                   	push   %ebp
  801ec8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801eca:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed0:	6a 00                	push   $0x0
  801ed2:	6a 00                	push   $0x0
  801ed4:	6a 00                	push   $0x0
  801ed6:	52                   	push   %edx
  801ed7:	50                   	push   %eax
  801ed8:	6a 1f                	push   $0x1f
  801eda:	e8 5d fc ff ff       	call   801b3c <syscall>
  801edf:	83 c4 18             	add    $0x18,%esp
}
  801ee2:	c9                   	leave  
  801ee3:	c3                   	ret    

00801ee4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ee4:	55                   	push   %ebp
  801ee5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 00                	push   $0x0
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 20                	push   $0x20
  801ef3:	e8 44 fc ff ff       	call   801b3c <syscall>
  801ef8:	83 c4 18             	add    $0x18,%esp
}
  801efb:	c9                   	leave  
  801efc:	c3                   	ret    

00801efd <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801efd:	55                   	push   %ebp
  801efe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f00:	8b 45 08             	mov    0x8(%ebp),%eax
  801f03:	6a 00                	push   $0x0
  801f05:	ff 75 14             	pushl  0x14(%ebp)
  801f08:	ff 75 10             	pushl  0x10(%ebp)
  801f0b:	ff 75 0c             	pushl  0xc(%ebp)
  801f0e:	50                   	push   %eax
  801f0f:	6a 21                	push   $0x21
  801f11:	e8 26 fc ff ff       	call   801b3c <syscall>
  801f16:	83 c4 18             	add    $0x18,%esp
}
  801f19:	c9                   	leave  
  801f1a:	c3                   	ret    

00801f1b <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801f1b:	55                   	push   %ebp
  801f1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f21:	6a 00                	push   $0x0
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	50                   	push   %eax
  801f2a:	6a 22                	push   $0x22
  801f2c:	e8 0b fc ff ff       	call   801b3c <syscall>
  801f31:	83 c4 18             	add    $0x18,%esp
}
  801f34:	90                   	nop
  801f35:	c9                   	leave  
  801f36:	c3                   	ret    

00801f37 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f37:	55                   	push   %ebp
  801f38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3d:	6a 00                	push   $0x0
  801f3f:	6a 00                	push   $0x0
  801f41:	6a 00                	push   $0x0
  801f43:	6a 00                	push   $0x0
  801f45:	50                   	push   %eax
  801f46:	6a 23                	push   $0x23
  801f48:	e8 ef fb ff ff       	call   801b3c <syscall>
  801f4d:	83 c4 18             	add    $0x18,%esp
}
  801f50:	90                   	nop
  801f51:	c9                   	leave  
  801f52:	c3                   	ret    

00801f53 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f53:	55                   	push   %ebp
  801f54:	89 e5                	mov    %esp,%ebp
  801f56:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f59:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f5c:	8d 50 04             	lea    0x4(%eax),%edx
  801f5f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	52                   	push   %edx
  801f69:	50                   	push   %eax
  801f6a:	6a 24                	push   $0x24
  801f6c:	e8 cb fb ff ff       	call   801b3c <syscall>
  801f71:	83 c4 18             	add    $0x18,%esp
	return result;
  801f74:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f77:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f7a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f7d:	89 01                	mov    %eax,(%ecx)
  801f7f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f82:	8b 45 08             	mov    0x8(%ebp),%eax
  801f85:	c9                   	leave  
  801f86:	c2 04 00             	ret    $0x4

00801f89 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f89:	55                   	push   %ebp
  801f8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	ff 75 10             	pushl  0x10(%ebp)
  801f93:	ff 75 0c             	pushl  0xc(%ebp)
  801f96:	ff 75 08             	pushl  0x8(%ebp)
  801f99:	6a 13                	push   $0x13
  801f9b:	e8 9c fb ff ff       	call   801b3c <syscall>
  801fa0:	83 c4 18             	add    $0x18,%esp
	return ;
  801fa3:	90                   	nop
}
  801fa4:	c9                   	leave  
  801fa5:	c3                   	ret    

00801fa6 <sys_rcr2>:
uint32 sys_rcr2()
{
  801fa6:	55                   	push   %ebp
  801fa7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801fa9:	6a 00                	push   $0x0
  801fab:	6a 00                	push   $0x0
  801fad:	6a 00                	push   $0x0
  801faf:	6a 00                	push   $0x0
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 25                	push   $0x25
  801fb5:	e8 82 fb ff ff       	call   801b3c <syscall>
  801fba:	83 c4 18             	add    $0x18,%esp
}
  801fbd:	c9                   	leave  
  801fbe:	c3                   	ret    

00801fbf <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801fbf:	55                   	push   %ebp
  801fc0:	89 e5                	mov    %esp,%ebp
  801fc2:	83 ec 04             	sub    $0x4,%esp
  801fc5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801fcb:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	50                   	push   %eax
  801fd8:	6a 26                	push   $0x26
  801fda:	e8 5d fb ff ff       	call   801b3c <syscall>
  801fdf:	83 c4 18             	add    $0x18,%esp
	return ;
  801fe2:	90                   	nop
}
  801fe3:	c9                   	leave  
  801fe4:	c3                   	ret    

00801fe5 <rsttst>:
void rsttst()
{
  801fe5:	55                   	push   %ebp
  801fe6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 28                	push   $0x28
  801ff4:	e8 43 fb ff ff       	call   801b3c <syscall>
  801ff9:	83 c4 18             	add    $0x18,%esp
	return ;
  801ffc:	90                   	nop
}
  801ffd:	c9                   	leave  
  801ffe:	c3                   	ret    

00801fff <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801fff:	55                   	push   %ebp
  802000:	89 e5                	mov    %esp,%ebp
  802002:	83 ec 04             	sub    $0x4,%esp
  802005:	8b 45 14             	mov    0x14(%ebp),%eax
  802008:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80200b:	8b 55 18             	mov    0x18(%ebp),%edx
  80200e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802012:	52                   	push   %edx
  802013:	50                   	push   %eax
  802014:	ff 75 10             	pushl  0x10(%ebp)
  802017:	ff 75 0c             	pushl  0xc(%ebp)
  80201a:	ff 75 08             	pushl  0x8(%ebp)
  80201d:	6a 27                	push   $0x27
  80201f:	e8 18 fb ff ff       	call   801b3c <syscall>
  802024:	83 c4 18             	add    $0x18,%esp
	return ;
  802027:	90                   	nop
}
  802028:	c9                   	leave  
  802029:	c3                   	ret    

0080202a <chktst>:
void chktst(uint32 n)
{
  80202a:	55                   	push   %ebp
  80202b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	ff 75 08             	pushl  0x8(%ebp)
  802038:	6a 29                	push   $0x29
  80203a:	e8 fd fa ff ff       	call   801b3c <syscall>
  80203f:	83 c4 18             	add    $0x18,%esp
	return ;
  802042:	90                   	nop
}
  802043:	c9                   	leave  
  802044:	c3                   	ret    

00802045 <inctst>:

void inctst()
{
  802045:	55                   	push   %ebp
  802046:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	6a 00                	push   $0x0
  802050:	6a 00                	push   $0x0
  802052:	6a 2a                	push   $0x2a
  802054:	e8 e3 fa ff ff       	call   801b3c <syscall>
  802059:	83 c4 18             	add    $0x18,%esp
	return ;
  80205c:	90                   	nop
}
  80205d:	c9                   	leave  
  80205e:	c3                   	ret    

0080205f <gettst>:
uint32 gettst()
{
  80205f:	55                   	push   %ebp
  802060:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	6a 00                	push   $0x0
  80206c:	6a 2b                	push   $0x2b
  80206e:	e8 c9 fa ff ff       	call   801b3c <syscall>
  802073:	83 c4 18             	add    $0x18,%esp
}
  802076:	c9                   	leave  
  802077:	c3                   	ret    

00802078 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802078:	55                   	push   %ebp
  802079:	89 e5                	mov    %esp,%ebp
  80207b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 2c                	push   $0x2c
  80208a:	e8 ad fa ff ff       	call   801b3c <syscall>
  80208f:	83 c4 18             	add    $0x18,%esp
  802092:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802095:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802099:	75 07                	jne    8020a2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80209b:	b8 01 00 00 00       	mov    $0x1,%eax
  8020a0:	eb 05                	jmp    8020a7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8020a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020a7:	c9                   	leave  
  8020a8:	c3                   	ret    

008020a9 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8020a9:	55                   	push   %ebp
  8020aa:	89 e5                	mov    %esp,%ebp
  8020ac:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 2c                	push   $0x2c
  8020bb:	e8 7c fa ff ff       	call   801b3c <syscall>
  8020c0:	83 c4 18             	add    $0x18,%esp
  8020c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8020c6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8020ca:	75 07                	jne    8020d3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8020cc:	b8 01 00 00 00       	mov    $0x1,%eax
  8020d1:	eb 05                	jmp    8020d8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8020d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020d8:	c9                   	leave  
  8020d9:	c3                   	ret    

008020da <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8020da:	55                   	push   %ebp
  8020db:	89 e5                	mov    %esp,%ebp
  8020dd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020e0:	6a 00                	push   $0x0
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 00                	push   $0x0
  8020ea:	6a 2c                	push   $0x2c
  8020ec:	e8 4b fa ff ff       	call   801b3c <syscall>
  8020f1:	83 c4 18             	add    $0x18,%esp
  8020f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8020f7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8020fb:	75 07                	jne    802104 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8020fd:	b8 01 00 00 00       	mov    $0x1,%eax
  802102:	eb 05                	jmp    802109 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802104:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802109:	c9                   	leave  
  80210a:	c3                   	ret    

0080210b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80210b:	55                   	push   %ebp
  80210c:	89 e5                	mov    %esp,%ebp
  80210e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	6a 00                	push   $0x0
  80211b:	6a 2c                	push   $0x2c
  80211d:	e8 1a fa ff ff       	call   801b3c <syscall>
  802122:	83 c4 18             	add    $0x18,%esp
  802125:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802128:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80212c:	75 07                	jne    802135 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80212e:	b8 01 00 00 00       	mov    $0x1,%eax
  802133:	eb 05                	jmp    80213a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802135:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80213a:	c9                   	leave  
  80213b:	c3                   	ret    

0080213c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80213c:	55                   	push   %ebp
  80213d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80213f:	6a 00                	push   $0x0
  802141:	6a 00                	push   $0x0
  802143:	6a 00                	push   $0x0
  802145:	6a 00                	push   $0x0
  802147:	ff 75 08             	pushl  0x8(%ebp)
  80214a:	6a 2d                	push   $0x2d
  80214c:	e8 eb f9 ff ff       	call   801b3c <syscall>
  802151:	83 c4 18             	add    $0x18,%esp
	return ;
  802154:	90                   	nop
}
  802155:	c9                   	leave  
  802156:	c3                   	ret    

00802157 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802157:	55                   	push   %ebp
  802158:	89 e5                	mov    %esp,%ebp
  80215a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80215b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80215e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802161:	8b 55 0c             	mov    0xc(%ebp),%edx
  802164:	8b 45 08             	mov    0x8(%ebp),%eax
  802167:	6a 00                	push   $0x0
  802169:	53                   	push   %ebx
  80216a:	51                   	push   %ecx
  80216b:	52                   	push   %edx
  80216c:	50                   	push   %eax
  80216d:	6a 2e                	push   $0x2e
  80216f:	e8 c8 f9 ff ff       	call   801b3c <syscall>
  802174:	83 c4 18             	add    $0x18,%esp
}
  802177:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80217a:	c9                   	leave  
  80217b:	c3                   	ret    

0080217c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80217c:	55                   	push   %ebp
  80217d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80217f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802182:	8b 45 08             	mov    0x8(%ebp),%eax
  802185:	6a 00                	push   $0x0
  802187:	6a 00                	push   $0x0
  802189:	6a 00                	push   $0x0
  80218b:	52                   	push   %edx
  80218c:	50                   	push   %eax
  80218d:	6a 2f                	push   $0x2f
  80218f:	e8 a8 f9 ff ff       	call   801b3c <syscall>
  802194:	83 c4 18             	add    $0x18,%esp
}
  802197:	c9                   	leave  
  802198:	c3                   	ret    
  802199:	66 90                	xchg   %ax,%ax
  80219b:	90                   	nop

0080219c <__udivdi3>:
  80219c:	55                   	push   %ebp
  80219d:	57                   	push   %edi
  80219e:	56                   	push   %esi
  80219f:	53                   	push   %ebx
  8021a0:	83 ec 1c             	sub    $0x1c,%esp
  8021a3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021a7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021ab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021af:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021b3:	89 ca                	mov    %ecx,%edx
  8021b5:	89 f8                	mov    %edi,%eax
  8021b7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021bb:	85 f6                	test   %esi,%esi
  8021bd:	75 2d                	jne    8021ec <__udivdi3+0x50>
  8021bf:	39 cf                	cmp    %ecx,%edi
  8021c1:	77 65                	ja     802228 <__udivdi3+0x8c>
  8021c3:	89 fd                	mov    %edi,%ebp
  8021c5:	85 ff                	test   %edi,%edi
  8021c7:	75 0b                	jne    8021d4 <__udivdi3+0x38>
  8021c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8021ce:	31 d2                	xor    %edx,%edx
  8021d0:	f7 f7                	div    %edi
  8021d2:	89 c5                	mov    %eax,%ebp
  8021d4:	31 d2                	xor    %edx,%edx
  8021d6:	89 c8                	mov    %ecx,%eax
  8021d8:	f7 f5                	div    %ebp
  8021da:	89 c1                	mov    %eax,%ecx
  8021dc:	89 d8                	mov    %ebx,%eax
  8021de:	f7 f5                	div    %ebp
  8021e0:	89 cf                	mov    %ecx,%edi
  8021e2:	89 fa                	mov    %edi,%edx
  8021e4:	83 c4 1c             	add    $0x1c,%esp
  8021e7:	5b                   	pop    %ebx
  8021e8:	5e                   	pop    %esi
  8021e9:	5f                   	pop    %edi
  8021ea:	5d                   	pop    %ebp
  8021eb:	c3                   	ret    
  8021ec:	39 ce                	cmp    %ecx,%esi
  8021ee:	77 28                	ja     802218 <__udivdi3+0x7c>
  8021f0:	0f bd fe             	bsr    %esi,%edi
  8021f3:	83 f7 1f             	xor    $0x1f,%edi
  8021f6:	75 40                	jne    802238 <__udivdi3+0x9c>
  8021f8:	39 ce                	cmp    %ecx,%esi
  8021fa:	72 0a                	jb     802206 <__udivdi3+0x6a>
  8021fc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802200:	0f 87 9e 00 00 00    	ja     8022a4 <__udivdi3+0x108>
  802206:	b8 01 00 00 00       	mov    $0x1,%eax
  80220b:	89 fa                	mov    %edi,%edx
  80220d:	83 c4 1c             	add    $0x1c,%esp
  802210:	5b                   	pop    %ebx
  802211:	5e                   	pop    %esi
  802212:	5f                   	pop    %edi
  802213:	5d                   	pop    %ebp
  802214:	c3                   	ret    
  802215:	8d 76 00             	lea    0x0(%esi),%esi
  802218:	31 ff                	xor    %edi,%edi
  80221a:	31 c0                	xor    %eax,%eax
  80221c:	89 fa                	mov    %edi,%edx
  80221e:	83 c4 1c             	add    $0x1c,%esp
  802221:	5b                   	pop    %ebx
  802222:	5e                   	pop    %esi
  802223:	5f                   	pop    %edi
  802224:	5d                   	pop    %ebp
  802225:	c3                   	ret    
  802226:	66 90                	xchg   %ax,%ax
  802228:	89 d8                	mov    %ebx,%eax
  80222a:	f7 f7                	div    %edi
  80222c:	31 ff                	xor    %edi,%edi
  80222e:	89 fa                	mov    %edi,%edx
  802230:	83 c4 1c             	add    $0x1c,%esp
  802233:	5b                   	pop    %ebx
  802234:	5e                   	pop    %esi
  802235:	5f                   	pop    %edi
  802236:	5d                   	pop    %ebp
  802237:	c3                   	ret    
  802238:	bd 20 00 00 00       	mov    $0x20,%ebp
  80223d:	89 eb                	mov    %ebp,%ebx
  80223f:	29 fb                	sub    %edi,%ebx
  802241:	89 f9                	mov    %edi,%ecx
  802243:	d3 e6                	shl    %cl,%esi
  802245:	89 c5                	mov    %eax,%ebp
  802247:	88 d9                	mov    %bl,%cl
  802249:	d3 ed                	shr    %cl,%ebp
  80224b:	89 e9                	mov    %ebp,%ecx
  80224d:	09 f1                	or     %esi,%ecx
  80224f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802253:	89 f9                	mov    %edi,%ecx
  802255:	d3 e0                	shl    %cl,%eax
  802257:	89 c5                	mov    %eax,%ebp
  802259:	89 d6                	mov    %edx,%esi
  80225b:	88 d9                	mov    %bl,%cl
  80225d:	d3 ee                	shr    %cl,%esi
  80225f:	89 f9                	mov    %edi,%ecx
  802261:	d3 e2                	shl    %cl,%edx
  802263:	8b 44 24 08          	mov    0x8(%esp),%eax
  802267:	88 d9                	mov    %bl,%cl
  802269:	d3 e8                	shr    %cl,%eax
  80226b:	09 c2                	or     %eax,%edx
  80226d:	89 d0                	mov    %edx,%eax
  80226f:	89 f2                	mov    %esi,%edx
  802271:	f7 74 24 0c          	divl   0xc(%esp)
  802275:	89 d6                	mov    %edx,%esi
  802277:	89 c3                	mov    %eax,%ebx
  802279:	f7 e5                	mul    %ebp
  80227b:	39 d6                	cmp    %edx,%esi
  80227d:	72 19                	jb     802298 <__udivdi3+0xfc>
  80227f:	74 0b                	je     80228c <__udivdi3+0xf0>
  802281:	89 d8                	mov    %ebx,%eax
  802283:	31 ff                	xor    %edi,%edi
  802285:	e9 58 ff ff ff       	jmp    8021e2 <__udivdi3+0x46>
  80228a:	66 90                	xchg   %ax,%ax
  80228c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802290:	89 f9                	mov    %edi,%ecx
  802292:	d3 e2                	shl    %cl,%edx
  802294:	39 c2                	cmp    %eax,%edx
  802296:	73 e9                	jae    802281 <__udivdi3+0xe5>
  802298:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80229b:	31 ff                	xor    %edi,%edi
  80229d:	e9 40 ff ff ff       	jmp    8021e2 <__udivdi3+0x46>
  8022a2:	66 90                	xchg   %ax,%ax
  8022a4:	31 c0                	xor    %eax,%eax
  8022a6:	e9 37 ff ff ff       	jmp    8021e2 <__udivdi3+0x46>
  8022ab:	90                   	nop

008022ac <__umoddi3>:
  8022ac:	55                   	push   %ebp
  8022ad:	57                   	push   %edi
  8022ae:	56                   	push   %esi
  8022af:	53                   	push   %ebx
  8022b0:	83 ec 1c             	sub    $0x1c,%esp
  8022b3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022b7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022bb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022bf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022c3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022c7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022cb:	89 f3                	mov    %esi,%ebx
  8022cd:	89 fa                	mov    %edi,%edx
  8022cf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022d3:	89 34 24             	mov    %esi,(%esp)
  8022d6:	85 c0                	test   %eax,%eax
  8022d8:	75 1a                	jne    8022f4 <__umoddi3+0x48>
  8022da:	39 f7                	cmp    %esi,%edi
  8022dc:	0f 86 a2 00 00 00    	jbe    802384 <__umoddi3+0xd8>
  8022e2:	89 c8                	mov    %ecx,%eax
  8022e4:	89 f2                	mov    %esi,%edx
  8022e6:	f7 f7                	div    %edi
  8022e8:	89 d0                	mov    %edx,%eax
  8022ea:	31 d2                	xor    %edx,%edx
  8022ec:	83 c4 1c             	add    $0x1c,%esp
  8022ef:	5b                   	pop    %ebx
  8022f0:	5e                   	pop    %esi
  8022f1:	5f                   	pop    %edi
  8022f2:	5d                   	pop    %ebp
  8022f3:	c3                   	ret    
  8022f4:	39 f0                	cmp    %esi,%eax
  8022f6:	0f 87 ac 00 00 00    	ja     8023a8 <__umoddi3+0xfc>
  8022fc:	0f bd e8             	bsr    %eax,%ebp
  8022ff:	83 f5 1f             	xor    $0x1f,%ebp
  802302:	0f 84 ac 00 00 00    	je     8023b4 <__umoddi3+0x108>
  802308:	bf 20 00 00 00       	mov    $0x20,%edi
  80230d:	29 ef                	sub    %ebp,%edi
  80230f:	89 fe                	mov    %edi,%esi
  802311:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802315:	89 e9                	mov    %ebp,%ecx
  802317:	d3 e0                	shl    %cl,%eax
  802319:	89 d7                	mov    %edx,%edi
  80231b:	89 f1                	mov    %esi,%ecx
  80231d:	d3 ef                	shr    %cl,%edi
  80231f:	09 c7                	or     %eax,%edi
  802321:	89 e9                	mov    %ebp,%ecx
  802323:	d3 e2                	shl    %cl,%edx
  802325:	89 14 24             	mov    %edx,(%esp)
  802328:	89 d8                	mov    %ebx,%eax
  80232a:	d3 e0                	shl    %cl,%eax
  80232c:	89 c2                	mov    %eax,%edx
  80232e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802332:	d3 e0                	shl    %cl,%eax
  802334:	89 44 24 04          	mov    %eax,0x4(%esp)
  802338:	8b 44 24 08          	mov    0x8(%esp),%eax
  80233c:	89 f1                	mov    %esi,%ecx
  80233e:	d3 e8                	shr    %cl,%eax
  802340:	09 d0                	or     %edx,%eax
  802342:	d3 eb                	shr    %cl,%ebx
  802344:	89 da                	mov    %ebx,%edx
  802346:	f7 f7                	div    %edi
  802348:	89 d3                	mov    %edx,%ebx
  80234a:	f7 24 24             	mull   (%esp)
  80234d:	89 c6                	mov    %eax,%esi
  80234f:	89 d1                	mov    %edx,%ecx
  802351:	39 d3                	cmp    %edx,%ebx
  802353:	0f 82 87 00 00 00    	jb     8023e0 <__umoddi3+0x134>
  802359:	0f 84 91 00 00 00    	je     8023f0 <__umoddi3+0x144>
  80235f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802363:	29 f2                	sub    %esi,%edx
  802365:	19 cb                	sbb    %ecx,%ebx
  802367:	89 d8                	mov    %ebx,%eax
  802369:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80236d:	d3 e0                	shl    %cl,%eax
  80236f:	89 e9                	mov    %ebp,%ecx
  802371:	d3 ea                	shr    %cl,%edx
  802373:	09 d0                	or     %edx,%eax
  802375:	89 e9                	mov    %ebp,%ecx
  802377:	d3 eb                	shr    %cl,%ebx
  802379:	89 da                	mov    %ebx,%edx
  80237b:	83 c4 1c             	add    $0x1c,%esp
  80237e:	5b                   	pop    %ebx
  80237f:	5e                   	pop    %esi
  802380:	5f                   	pop    %edi
  802381:	5d                   	pop    %ebp
  802382:	c3                   	ret    
  802383:	90                   	nop
  802384:	89 fd                	mov    %edi,%ebp
  802386:	85 ff                	test   %edi,%edi
  802388:	75 0b                	jne    802395 <__umoddi3+0xe9>
  80238a:	b8 01 00 00 00       	mov    $0x1,%eax
  80238f:	31 d2                	xor    %edx,%edx
  802391:	f7 f7                	div    %edi
  802393:	89 c5                	mov    %eax,%ebp
  802395:	89 f0                	mov    %esi,%eax
  802397:	31 d2                	xor    %edx,%edx
  802399:	f7 f5                	div    %ebp
  80239b:	89 c8                	mov    %ecx,%eax
  80239d:	f7 f5                	div    %ebp
  80239f:	89 d0                	mov    %edx,%eax
  8023a1:	e9 44 ff ff ff       	jmp    8022ea <__umoddi3+0x3e>
  8023a6:	66 90                	xchg   %ax,%ax
  8023a8:	89 c8                	mov    %ecx,%eax
  8023aa:	89 f2                	mov    %esi,%edx
  8023ac:	83 c4 1c             	add    $0x1c,%esp
  8023af:	5b                   	pop    %ebx
  8023b0:	5e                   	pop    %esi
  8023b1:	5f                   	pop    %edi
  8023b2:	5d                   	pop    %ebp
  8023b3:	c3                   	ret    
  8023b4:	3b 04 24             	cmp    (%esp),%eax
  8023b7:	72 06                	jb     8023bf <__umoddi3+0x113>
  8023b9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023bd:	77 0f                	ja     8023ce <__umoddi3+0x122>
  8023bf:	89 f2                	mov    %esi,%edx
  8023c1:	29 f9                	sub    %edi,%ecx
  8023c3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023c7:	89 14 24             	mov    %edx,(%esp)
  8023ca:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023ce:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023d2:	8b 14 24             	mov    (%esp),%edx
  8023d5:	83 c4 1c             	add    $0x1c,%esp
  8023d8:	5b                   	pop    %ebx
  8023d9:	5e                   	pop    %esi
  8023da:	5f                   	pop    %edi
  8023db:	5d                   	pop    %ebp
  8023dc:	c3                   	ret    
  8023dd:	8d 76 00             	lea    0x0(%esi),%esi
  8023e0:	2b 04 24             	sub    (%esp),%eax
  8023e3:	19 fa                	sbb    %edi,%edx
  8023e5:	89 d1                	mov    %edx,%ecx
  8023e7:	89 c6                	mov    %eax,%esi
  8023e9:	e9 71 ff ff ff       	jmp    80235f <__umoddi3+0xb3>
  8023ee:	66 90                	xchg   %ax,%ax
  8023f0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023f4:	72 ea                	jb     8023e0 <__umoddi3+0x134>
  8023f6:	89 d9                	mov    %ebx,%ecx
  8023f8:	e9 62 ff ff ff       	jmp    80235f <__umoddi3+0xb3>
