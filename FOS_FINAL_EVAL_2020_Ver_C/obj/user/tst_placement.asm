
obj/user/tst_placement:     file format elf32-i386


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
  800031:	e8 a7 05 00 00       	call   8005dd <libmain>
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
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 9c 00 00 01    	sub    $0x100009c,%esp

	char arr[PAGE_SIZE*1024*4];

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800044:	a1 20 30 80 00       	mov    0x803020,%eax
  800049:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  80004f:	8b 00                	mov    (%eax),%eax
  800051:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800054:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800057:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80005c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800061:	74 14                	je     800077 <_main+0x3f>
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	68 40 20 80 00       	push   $0x802040
  80006b:	6a 10                	push   $0x10
  80006d:	68 81 20 80 00       	push   $0x802081
  800072:	e8 8e 06 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800077:	a1 20 30 80 00       	mov    0x803020,%eax
  80007c:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  800082:	83 c0 14             	add    $0x14,%eax
  800085:	8b 00                	mov    (%eax),%eax
  800087:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80008a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80008d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800092:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800097:	74 14                	je     8000ad <_main+0x75>
  800099:	83 ec 04             	sub    $0x4,%esp
  80009c:	68 40 20 80 00       	push   $0x802040
  8000a1:	6a 11                	push   $0x11
  8000a3:	68 81 20 80 00       	push   $0x802081
  8000a8:	e8 58 06 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b2:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  8000b8:	83 c0 28             	add    $0x28,%eax
  8000bb:	8b 00                	mov    (%eax),%eax
  8000bd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000cd:	74 14                	je     8000e3 <_main+0xab>
  8000cf:	83 ec 04             	sub    $0x4,%esp
  8000d2:	68 40 20 80 00       	push   $0x802040
  8000d7:	6a 12                	push   $0x12
  8000d9:	68 81 20 80 00       	push   $0x802081
  8000de:	e8 22 06 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e8:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  8000ee:	83 c0 3c             	add    $0x3c,%eax
  8000f1:	8b 00                	mov    (%eax),%eax
  8000f3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fe:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 40 20 80 00       	push   $0x802040
  80010d:	6a 13                	push   $0x13
  80010f:	68 81 20 80 00       	push   $0x802081
  800114:	e8 ec 05 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800119:	a1 20 30 80 00       	mov    0x803020,%eax
  80011e:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  800124:	83 c0 50             	add    $0x50,%eax
  800127:	8b 00                	mov    (%eax),%eax
  800129:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80012c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80012f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800134:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800139:	74 14                	je     80014f <_main+0x117>
  80013b:	83 ec 04             	sub    $0x4,%esp
  80013e:	68 40 20 80 00       	push   $0x802040
  800143:	6a 14                	push   $0x14
  800145:	68 81 20 80 00       	push   $0x802081
  80014a:	e8 b6 05 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014f:	a1 20 30 80 00       	mov    0x803020,%eax
  800154:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  80015a:	83 c0 64             	add    $0x64,%eax
  80015d:	8b 00                	mov    (%eax),%eax
  80015f:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800162:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800165:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80016a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016f:	74 14                	je     800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 40 20 80 00       	push   $0x802040
  800179:	6a 15                	push   $0x15
  80017b:	68 81 20 80 00       	push   $0x802081
  800180:	e8 80 05 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x206000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800185:	a1 20 30 80 00       	mov    0x803020,%eax
  80018a:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  800190:	83 c0 78             	add    $0x78,%eax
  800193:	8b 00                	mov    (%eax),%eax
  800195:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800198:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80019b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a0:	3d 00 60 20 00       	cmp    $0x206000,%eax
  8001a5:	74 14                	je     8001bb <_main+0x183>
  8001a7:	83 ec 04             	sub    $0x4,%esp
  8001aa:	68 40 20 80 00       	push   $0x802040
  8001af:	6a 16                	push   $0x16
  8001b1:	68 81 20 80 00       	push   $0x802081
  8001b6:	e8 4a 05 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c0:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  8001c6:	05 8c 00 00 00       	add    $0x8c,%eax
  8001cb:	8b 00                	mov    (%eax),%eax
  8001cd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001d0:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001d3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d8:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001dd:	74 14                	je     8001f3 <_main+0x1bb>
  8001df:	83 ec 04             	sub    $0x4,%esp
  8001e2:	68 40 20 80 00       	push   $0x802040
  8001e7:	6a 17                	push   $0x17
  8001e9:	68 81 20 80 00       	push   $0x802081
  8001ee:	e8 12 05 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f8:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  8001fe:	05 a0 00 00 00       	add    $0xa0,%eax
  800203:	8b 00                	mov    (%eax),%eax
  800205:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800208:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80020b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800210:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800215:	74 14                	je     80022b <_main+0x1f3>
  800217:	83 ec 04             	sub    $0x4,%esp
  80021a:	68 40 20 80 00       	push   $0x802040
  80021f:	6a 18                	push   $0x18
  800221:	68 81 20 80 00       	push   $0x802081
  800226:	e8 da 04 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80022b:	a1 20 30 80 00       	mov    0x803020,%eax
  800230:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  800236:	05 b4 00 00 00       	add    $0xb4,%eax
  80023b:	8b 00                	mov    (%eax),%eax
  80023d:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800240:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800243:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800248:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80024d:	74 14                	je     800263 <_main+0x22b>
  80024f:	83 ec 04             	sub    $0x4,%esp
  800252:	68 40 20 80 00       	push   $0x802040
  800257:	6a 19                	push   $0x19
  800259:	68 81 20 80 00       	push   $0x802081
  80025e:	e8 a2 04 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800263:	a1 20 30 80 00       	mov    0x803020,%eax
  800268:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  80026e:	05 c8 00 00 00       	add    $0xc8,%eax
  800273:	8b 00                	mov    (%eax),%eax
  800275:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800278:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80027b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800280:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800285:	74 14                	je     80029b <_main+0x263>
  800287:	83 ec 04             	sub    $0x4,%esp
  80028a:	68 40 20 80 00       	push   $0x802040
  80028f:	6a 1a                	push   $0x1a
  800291:	68 81 20 80 00       	push   $0x802081
  800296:	e8 6a 04 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80029b:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a0:	8b 80 30 ef 00 00    	mov    0xef30(%eax),%eax
  8002a6:	05 dc 00 00 00       	add    $0xdc,%eax
  8002ab:	8b 00                	mov    (%eax),%eax
  8002ad:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8002b0:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002b3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002b8:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8002bd:	74 14                	je     8002d3 <_main+0x29b>
  8002bf:	83 ec 04             	sub    $0x4,%esp
  8002c2:	68 40 20 80 00       	push   $0x802040
  8002c7:	6a 1b                	push   $0x1b
  8002c9:	68 81 20 80 00       	push   $0x802081
  8002ce:	e8 32 04 00 00       	call   800705 <_panic>

		for (int k = 12; k < 20; k++)
  8002d3:	c7 45 e4 0c 00 00 00 	movl   $0xc,-0x1c(%ebp)
  8002da:	eb 38                	jmp    800314 <_main+0x2dc>
			if( myEnv->__uptr_pws[k].empty !=  1)
  8002dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e1:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8002e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002ea:	89 d0                	mov    %edx,%eax
  8002ec:	c1 e0 02             	shl    $0x2,%eax
  8002ef:	01 d0                	add    %edx,%eax
  8002f1:	c1 e0 02             	shl    $0x2,%eax
  8002f4:	01 c8                	add    %ecx,%eax
  8002f6:	8a 40 04             	mov    0x4(%eax),%al
  8002f9:	3c 01                	cmp    $0x1,%al
  8002fb:	74 14                	je     800311 <_main+0x2d9>
				panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002fd:	83 ec 04             	sub    $0x4,%esp
  800300:	68 40 20 80 00       	push   $0x802040
  800305:	6a 1f                	push   $0x1f
  800307:	68 81 20 80 00       	push   $0x802081
  80030c:	e8 f4 03 00 00       	call   800705 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");

		for (int k = 12; k < 20; k++)
  800311:	ff 45 e4             	incl   -0x1c(%ebp)
  800314:	83 7d e4 13          	cmpl   $0x13,-0x1c(%ebp)
  800318:	7e c2                	jle    8002dc <_main+0x2a4>
			if( myEnv->__uptr_pws[k].empty !=  1)
				panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");

		if( myEnv->page_last_WS_index !=  12)  											panic("INITIAL PAGE last index checking failed! Review size of the WS..!!");
  80031a:	a1 20 30 80 00       	mov    0x803020,%eax
  80031f:	8b 80 c0 ee 00 00    	mov    0xeec0(%eax),%eax
  800325:	83 f8 0c             	cmp    $0xc,%eax
  800328:	74 14                	je     80033e <_main+0x306>
  80032a:	83 ec 04             	sub    $0x4,%esp
  80032d:	68 98 20 80 00       	push   $0x802098
  800332:	6a 21                	push   $0x21
  800334:	68 81 20 80 00       	push   $0x802081
  800339:	e8 c7 03 00 00       	call   800705 <_panic>
		/*====================================*/
	}

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80033e:	e8 f2 15 00 00       	call   801935 <sys_pf_calculate_allocated_pages>
  800343:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int freePages = sys_calculate_free_frames();
  800346:	e8 67 15 00 00       	call   8018b2 <sys_calculate_free_frames>
  80034b:	89 45 a8             	mov    %eax,-0x58(%ebp)

	int i=0;
  80034e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(;i<=PAGE_SIZE;i++)
  800355:	eb 11                	jmp    800368 <_main+0x330>
	{
		arr[i] = -1;
  800357:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  80035d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800360:	01 d0                	add    %edx,%eax
  800362:	c6 00 ff             	movb   $0xff,(%eax)

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
	int freePages = sys_calculate_free_frames();

	int i=0;
	for(;i<=PAGE_SIZE;i++)
  800365:	ff 45 e0             	incl   -0x20(%ebp)
  800368:	81 7d e0 00 10 00 00 	cmpl   $0x1000,-0x20(%ebp)
  80036f:	7e e6                	jle    800357 <_main+0x31f>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
  800371:	c7 45 e0 00 00 40 00 	movl   $0x400000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  800378:	eb 11                	jmp    80038b <_main+0x353>
	{
		arr[i] = -1;
  80037a:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  800380:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800383:	01 d0                	add    %edx,%eax
  800385:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  800388:	ff 45 e0             	incl   -0x20(%ebp)
  80038b:	81 7d e0 00 10 40 00 	cmpl   $0x401000,-0x20(%ebp)
  800392:	7e e6                	jle    80037a <_main+0x342>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
  800394:	c7 45 e0 00 00 80 00 	movl   $0x800000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  80039b:	eb 11                	jmp    8003ae <_main+0x376>
	{
		arr[i] = -1;
  80039d:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  8003a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003a6:	01 d0                	add    %edx,%eax
  8003a8:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  8003ab:	ff 45 e0             	incl   -0x20(%ebp)
  8003ae:	81 7d e0 00 10 80 00 	cmpl   $0x801000,-0x20(%ebp)
  8003b5:	7e e6                	jle    80039d <_main+0x365>
		arr[i] = -1;
	}



	cprintf("STEP A: checking PLACEMENT fault handling ... \n");
  8003b7:	83 ec 0c             	sub    $0xc,%esp
  8003ba:	68 dc 20 80 00       	push   $0x8020dc
  8003bf:	e8 f8 05 00 00       	call   8009bc <cprintf>
  8003c4:	83 c4 10             	add    $0x10,%esp
	{
		if( arr[0] !=  -1)  panic("PLACEMENT of stack page failed");
  8003c7:	8a 85 a8 ff ff fe    	mov    -0x1000058(%ebp),%al
  8003cd:	3c ff                	cmp    $0xff,%al
  8003cf:	74 14                	je     8003e5 <_main+0x3ad>
  8003d1:	83 ec 04             	sub    $0x4,%esp
  8003d4:	68 0c 21 80 00       	push   $0x80210c
  8003d9:	6a 3e                	push   $0x3e
  8003db:	68 81 20 80 00       	push   $0x802081
  8003e0:	e8 20 03 00 00       	call   800705 <_panic>
		if( arr[PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  8003e5:	8a 85 a8 0f 00 ff    	mov    -0xfff058(%ebp),%al
  8003eb:	3c ff                	cmp    $0xff,%al
  8003ed:	74 14                	je     800403 <_main+0x3cb>
  8003ef:	83 ec 04             	sub    $0x4,%esp
  8003f2:	68 0c 21 80 00       	push   $0x80210c
  8003f7:	6a 3f                	push   $0x3f
  8003f9:	68 81 20 80 00       	push   $0x802081
  8003fe:	e8 02 03 00 00       	call   800705 <_panic>

		if( arr[PAGE_SIZE*1024] !=  -1)  panic("PLACEMENT of stack page failed");
  800403:	8a 85 a8 ff 3f ff    	mov    -0xc00058(%ebp),%al
  800409:	3c ff                	cmp    $0xff,%al
  80040b:	74 14                	je     800421 <_main+0x3e9>
  80040d:	83 ec 04             	sub    $0x4,%esp
  800410:	68 0c 21 80 00       	push   $0x80210c
  800415:	6a 41                	push   $0x41
  800417:	68 81 20 80 00       	push   $0x802081
  80041c:	e8 e4 02 00 00       	call   800705 <_panic>
		if( arr[PAGE_SIZE*1025] !=  -1)  panic("PLACEMENT of stack page failed");
  800421:	8a 85 a8 0f 40 ff    	mov    -0xbff058(%ebp),%al
  800427:	3c ff                	cmp    $0xff,%al
  800429:	74 14                	je     80043f <_main+0x407>
  80042b:	83 ec 04             	sub    $0x4,%esp
  80042e:	68 0c 21 80 00       	push   $0x80210c
  800433:	6a 42                	push   $0x42
  800435:	68 81 20 80 00       	push   $0x802081
  80043a:	e8 c6 02 00 00       	call   800705 <_panic>

		if( arr[PAGE_SIZE*1024*2] !=  -1)  panic("PLACEMENT of stack page failed");
  80043f:	8a 85 a8 ff 7f ff    	mov    -0x800058(%ebp),%al
  800445:	3c ff                	cmp    $0xff,%al
  800447:	74 14                	je     80045d <_main+0x425>
  800449:	83 ec 04             	sub    $0x4,%esp
  80044c:	68 0c 21 80 00       	push   $0x80210c
  800451:	6a 44                	push   $0x44
  800453:	68 81 20 80 00       	push   $0x802081
  800458:	e8 a8 02 00 00       	call   800705 <_panic>
		if( arr[PAGE_SIZE*1024*2 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  80045d:	8a 85 a8 0f 80 ff    	mov    -0x7ff058(%ebp),%al
  800463:	3c ff                	cmp    $0xff,%al
  800465:	74 14                	je     80047b <_main+0x443>
  800467:	83 ec 04             	sub    $0x4,%esp
  80046a:	68 0c 21 80 00       	push   $0x80210c
  80046f:	6a 45                	push   $0x45
  800471:	68 81 20 80 00       	push   $0x802081
  800476:	e8 8a 02 00 00       	call   800705 <_panic>


		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5) panic("new stack pages are not written to Page File");
  80047b:	e8 b5 14 00 00       	call   801935 <sys_pf_calculate_allocated_pages>
  800480:	2b 45 ac             	sub    -0x54(%ebp),%eax
  800483:	83 f8 05             	cmp    $0x5,%eax
  800486:	74 14                	je     80049c <_main+0x464>
  800488:	83 ec 04             	sub    $0x4,%esp
  80048b:	68 2c 21 80 00       	push   $0x80212c
  800490:	6a 48                	push   $0x48
  800492:	68 81 20 80 00       	push   $0x802081
  800497:	e8 69 02 00 00       	call   800705 <_panic>

		if( (freePages - sys_calculate_free_frames() ) != 9 ) panic("allocated memory size incorrect");
  80049c:	8b 5d a8             	mov    -0x58(%ebp),%ebx
  80049f:	e8 0e 14 00 00       	call   8018b2 <sys_calculate_free_frames>
  8004a4:	29 c3                	sub    %eax,%ebx
  8004a6:	89 d8                	mov    %ebx,%eax
  8004a8:	83 f8 09             	cmp    $0x9,%eax
  8004ab:	74 14                	je     8004c1 <_main+0x489>
  8004ad:	83 ec 04             	sub    $0x4,%esp
  8004b0:	68 5c 21 80 00       	push   $0x80215c
  8004b5:	6a 4a                	push   $0x4a
  8004b7:	68 81 20 80 00       	push   $0x802081
  8004bc:	e8 44 02 00 00       	call   800705 <_panic>
	}
	cprintf("STEP A passed: PLACEMENT fault handling works!\n\n\n");
  8004c1:	83 ec 0c             	sub    $0xc,%esp
  8004c4:	68 7c 21 80 00       	push   $0x80217c
  8004c9:	e8 ee 04 00 00       	call   8009bc <cprintf>
  8004ce:	83 c4 10             	add    $0x10,%esp


	uint32 expectedPages[20] = {0x200000,0x201000,0x202000,0x203000,0x204000,0x205000,0x206000,0x800000,0x801000,0x802000,0x803000,0xeebfd000,0xedbfd000,0xedbfe000,0xedffd000,0xedffe000,0xee3fd000,0xee3fe000, 0, 0};
  8004d1:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  8004d7:	bb c0 22 80 00       	mov    $0x8022c0,%ebx
  8004dc:	ba 14 00 00 00       	mov    $0x14,%edx
  8004e1:	89 c7                	mov    %eax,%edi
  8004e3:	89 de                	mov    %ebx,%esi
  8004e5:	89 d1                	mov    %edx,%ecx
  8004e7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	cprintf("STEP B: checking WS entries ...\n");
  8004e9:	83 ec 0c             	sub    $0xc,%esp
  8004ec:	68 b0 21 80 00       	push   $0x8021b0
  8004f1:	e8 c6 04 00 00       	call   8009bc <cprintf>
  8004f6:	83 c4 10             	add    $0x10,%esp
	{
		CheckWSWithoutLastIndex(expectedPages, 20);
  8004f9:	83 ec 08             	sub    $0x8,%esp
  8004fc:	6a 14                	push   $0x14
  8004fe:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  800504:	50                   	push   %eax
  800505:	e8 6d 02 00 00       	call   800777 <CheckWSWithoutLastIndex>
  80050a:	83 c4 10             	add    $0x10,%esp
	//		if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=  0xedffd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=  0xedffe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[16].virtual_address,PAGE_SIZE) !=  0xee3fd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[17].virtual_address,PAGE_SIZE) !=  0xee3fe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
}
cprintf("STEP B passed: WS entries test are correct\n\n\n");
  80050d:	83 ec 0c             	sub    $0xc,%esp
  800510:	68 d4 21 80 00       	push   $0x8021d4
  800515:	e8 a2 04 00 00       	call   8009bc <cprintf>
  80051a:	83 c4 10             	add    $0x10,%esp

cprintf("STEP C: checking working sets WHEN BECOMES FULL...\n");
  80051d:	83 ec 0c             	sub    $0xc,%esp
  800520:	68 04 22 80 00       	push   $0x802204
  800525:	e8 92 04 00 00       	call   8009bc <cprintf>
  80052a:	83 c4 10             	add    $0x10,%esp
{
	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 18) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

	i=PAGE_SIZE*1024*3;
  80052d:	c7 45 e0 00 00 c0 00 	movl   $0xc00000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024*3+PAGE_SIZE);i++)
  800534:	eb 11                	jmp    800547 <_main+0x50f>
	{
		arr[i] = -1;
  800536:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  80053c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80053f:	01 d0                	add    %edx,%eax
  800541:	c6 00 ff             	movb   $0xff,(%eax)
{
	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 18) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

	i=PAGE_SIZE*1024*3;
	for(;i<=(PAGE_SIZE*1024*3+PAGE_SIZE);i++)
  800544:	ff 45 e0             	incl   -0x20(%ebp)
  800547:	81 7d e0 00 10 c0 00 	cmpl   $0xc01000,-0x20(%ebp)
  80054e:	7e e6                	jle    800536 <_main+0x4fe>
	{
		arr[i] = -1;
	}

	if( arr[PAGE_SIZE*1024*3] !=  -1)  panic("PLACEMENT of stack page failed");
  800550:	8a 85 a8 ff bf ff    	mov    -0x400058(%ebp),%al
  800556:	3c ff                	cmp    $0xff,%al
  800558:	74 14                	je     80056e <_main+0x536>
  80055a:	83 ec 04             	sub    $0x4,%esp
  80055d:	68 0c 21 80 00       	push   $0x80210c
  800562:	6a 73                	push   $0x73
  800564:	68 81 20 80 00       	push   $0x802081
  800569:	e8 97 01 00 00       	call   800705 <_panic>
	if( arr[PAGE_SIZE*1024*3 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  80056e:	8a 85 a8 0f c0 ff    	mov    -0x3ff058(%ebp),%al
  800574:	3c ff                	cmp    $0xff,%al
  800576:	74 14                	je     80058c <_main+0x554>
  800578:	83 ec 04             	sub    $0x4,%esp
  80057b:	68 0c 21 80 00       	push   $0x80210c
  800580:	6a 74                	push   $0x74
  800582:	68 81 20 80 00       	push   $0x802081
  800587:	e8 79 01 00 00       	call   800705 <_panic>

	expectedPages[18] = 0xee7fd000;
  80058c:	c7 85 a0 ff ff fe 00 	movl   $0xee7fd000,-0x1000060(%ebp)
  800593:	d0 7f ee 
	expectedPages[19] = 0xee7fe000;
  800596:	c7 85 a4 ff ff fe 00 	movl   $0xee7fe000,-0x100005c(%ebp)
  80059d:	e0 7f ee 

	CheckWSWithoutLastIndex(expectedPages, 20);
  8005a0:	83 ec 08             	sub    $0x8,%esp
  8005a3:	6a 14                	push   $0x14
  8005a5:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  8005ab:	50                   	push   %eax
  8005ac:	e8 c6 01 00 00       	call   800777 <CheckWSWithoutLastIndex>
  8005b1:	83 c4 10             	add    $0x10,%esp

	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 0) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

}
cprintf("STEP C passed: WS is FULL now\n\n\n");
  8005b4:	83 ec 0c             	sub    $0xc,%esp
  8005b7:	68 38 22 80 00       	push   $0x802238
  8005bc:	e8 fb 03 00 00       	call   8009bc <cprintf>
  8005c1:	83 c4 10             	add    $0x10,%esp

cprintf("Congratulations!! Test of PAGE PLACEMENT completed successfully!!\n\n\n");
  8005c4:	83 ec 0c             	sub    $0xc,%esp
  8005c7:	68 5c 22 80 00       	push   $0x80225c
  8005cc:	e8 eb 03 00 00       	call   8009bc <cprintf>
  8005d1:	83 c4 10             	add    $0x10,%esp
return;
  8005d4:	90                   	nop
}
  8005d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8005d8:	5b                   	pop    %ebx
  8005d9:	5e                   	pop    %esi
  8005da:	5f                   	pop    %edi
  8005db:	5d                   	pop    %ebp
  8005dc:	c3                   	ret    

008005dd <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005dd:	55                   	push   %ebp
  8005de:	89 e5                	mov    %esp,%ebp
  8005e0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005e3:	e8 ff 11 00 00       	call   8017e7 <sys_getenvindex>
  8005e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005ee:	89 d0                	mov    %edx,%eax
  8005f0:	01 c0                	add    %eax,%eax
  8005f2:	01 d0                	add    %edx,%eax
  8005f4:	c1 e0 07             	shl    $0x7,%eax
  8005f7:	29 d0                	sub    %edx,%eax
  8005f9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800600:	01 c8                	add    %ecx,%eax
  800602:	01 c0                	add    %eax,%eax
  800604:	01 d0                	add    %edx,%eax
  800606:	01 c0                	add    %eax,%eax
  800608:	01 d0                	add    %edx,%eax
  80060a:	c1 e0 03             	shl    $0x3,%eax
  80060d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800612:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800617:	a1 20 30 80 00       	mov    0x803020,%eax
  80061c:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800622:	84 c0                	test   %al,%al
  800624:	74 0f                	je     800635 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800626:	a1 20 30 80 00       	mov    0x803020,%eax
  80062b:	05 f0 ee 00 00       	add    $0xeef0,%eax
  800630:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800635:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800639:	7e 0a                	jle    800645 <libmain+0x68>
		binaryname = argv[0];
  80063b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80063e:	8b 00                	mov    (%eax),%eax
  800640:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800645:	83 ec 08             	sub    $0x8,%esp
  800648:	ff 75 0c             	pushl  0xc(%ebp)
  80064b:	ff 75 08             	pushl  0x8(%ebp)
  80064e:	e8 e5 f9 ff ff       	call   800038 <_main>
  800653:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800656:	e8 27 13 00 00       	call   801982 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80065b:	83 ec 0c             	sub    $0xc,%esp
  80065e:	68 28 23 80 00       	push   $0x802328
  800663:	e8 54 03 00 00       	call   8009bc <cprintf>
  800668:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80066b:	a1 20 30 80 00       	mov    0x803020,%eax
  800670:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800676:	a1 20 30 80 00       	mov    0x803020,%eax
  80067b:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  800681:	83 ec 04             	sub    $0x4,%esp
  800684:	52                   	push   %edx
  800685:	50                   	push   %eax
  800686:	68 50 23 80 00       	push   $0x802350
  80068b:	e8 2c 03 00 00       	call   8009bc <cprintf>
  800690:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800693:	a1 20 30 80 00       	mov    0x803020,%eax
  800698:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  80069e:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a3:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  8006a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ae:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  8006b4:	51                   	push   %ecx
  8006b5:	52                   	push   %edx
  8006b6:	50                   	push   %eax
  8006b7:	68 78 23 80 00       	push   $0x802378
  8006bc:	e8 fb 02 00 00       	call   8009bc <cprintf>
  8006c1:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006c4:	83 ec 0c             	sub    $0xc,%esp
  8006c7:	68 28 23 80 00       	push   $0x802328
  8006cc:	e8 eb 02 00 00       	call   8009bc <cprintf>
  8006d1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006d4:	e8 c3 12 00 00       	call   80199c <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006d9:	e8 19 00 00 00       	call   8006f7 <exit>
}
  8006de:	90                   	nop
  8006df:	c9                   	leave  
  8006e0:	c3                   	ret    

008006e1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006e1:	55                   	push   %ebp
  8006e2:	89 e5                	mov    %esp,%ebp
  8006e4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006e7:	83 ec 0c             	sub    $0xc,%esp
  8006ea:	6a 00                	push   $0x0
  8006ec:	e8 c2 10 00 00       	call   8017b3 <sys_env_destroy>
  8006f1:	83 c4 10             	add    $0x10,%esp
}
  8006f4:	90                   	nop
  8006f5:	c9                   	leave  
  8006f6:	c3                   	ret    

008006f7 <exit>:

void
exit(void)
{
  8006f7:	55                   	push   %ebp
  8006f8:	89 e5                	mov    %esp,%ebp
  8006fa:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006fd:	e8 17 11 00 00       	call   801819 <sys_env_exit>
}
  800702:	90                   	nop
  800703:	c9                   	leave  
  800704:	c3                   	ret    

00800705 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800705:	55                   	push   %ebp
  800706:	89 e5                	mov    %esp,%ebp
  800708:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80070b:	8d 45 10             	lea    0x10(%ebp),%eax
  80070e:	83 c0 04             	add    $0x4,%eax
  800711:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800714:	a1 18 31 80 00       	mov    0x803118,%eax
  800719:	85 c0                	test   %eax,%eax
  80071b:	74 16                	je     800733 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80071d:	a1 18 31 80 00       	mov    0x803118,%eax
  800722:	83 ec 08             	sub    $0x8,%esp
  800725:	50                   	push   %eax
  800726:	68 d0 23 80 00       	push   $0x8023d0
  80072b:	e8 8c 02 00 00       	call   8009bc <cprintf>
  800730:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800733:	a1 00 30 80 00       	mov    0x803000,%eax
  800738:	ff 75 0c             	pushl  0xc(%ebp)
  80073b:	ff 75 08             	pushl  0x8(%ebp)
  80073e:	50                   	push   %eax
  80073f:	68 d5 23 80 00       	push   $0x8023d5
  800744:	e8 73 02 00 00       	call   8009bc <cprintf>
  800749:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80074c:	8b 45 10             	mov    0x10(%ebp),%eax
  80074f:	83 ec 08             	sub    $0x8,%esp
  800752:	ff 75 f4             	pushl  -0xc(%ebp)
  800755:	50                   	push   %eax
  800756:	e8 f6 01 00 00       	call   800951 <vcprintf>
  80075b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80075e:	83 ec 08             	sub    $0x8,%esp
  800761:	6a 00                	push   $0x0
  800763:	68 f1 23 80 00       	push   $0x8023f1
  800768:	e8 e4 01 00 00       	call   800951 <vcprintf>
  80076d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800770:	e8 82 ff ff ff       	call   8006f7 <exit>

	// should not return here
	while (1) ;
  800775:	eb fe                	jmp    800775 <_panic+0x70>

00800777 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800777:	55                   	push   %ebp
  800778:	89 e5                	mov    %esp,%ebp
  80077a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80077d:	a1 20 30 80 00       	mov    0x803020,%eax
  800782:	8b 50 74             	mov    0x74(%eax),%edx
  800785:	8b 45 0c             	mov    0xc(%ebp),%eax
  800788:	39 c2                	cmp    %eax,%edx
  80078a:	74 14                	je     8007a0 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80078c:	83 ec 04             	sub    $0x4,%esp
  80078f:	68 f4 23 80 00       	push   $0x8023f4
  800794:	6a 26                	push   $0x26
  800796:	68 40 24 80 00       	push   $0x802440
  80079b:	e8 65 ff ff ff       	call   800705 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007a7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007ae:	e9 c4 00 00 00       	jmp    800877 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8007b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c0:	01 d0                	add    %edx,%eax
  8007c2:	8b 00                	mov    (%eax),%eax
  8007c4:	85 c0                	test   %eax,%eax
  8007c6:	75 08                	jne    8007d0 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007c8:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007cb:	e9 a4 00 00 00       	jmp    800874 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8007d0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007d7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007de:	eb 6b                	jmp    80084b <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e5:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8007eb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ee:	89 d0                	mov    %edx,%eax
  8007f0:	c1 e0 02             	shl    $0x2,%eax
  8007f3:	01 d0                	add    %edx,%eax
  8007f5:	c1 e0 02             	shl    $0x2,%eax
  8007f8:	01 c8                	add    %ecx,%eax
  8007fa:	8a 40 04             	mov    0x4(%eax),%al
  8007fd:	84 c0                	test   %al,%al
  8007ff:	75 47                	jne    800848 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800801:	a1 20 30 80 00       	mov    0x803020,%eax
  800806:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80080c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80080f:	89 d0                	mov    %edx,%eax
  800811:	c1 e0 02             	shl    $0x2,%eax
  800814:	01 d0                	add    %edx,%eax
  800816:	c1 e0 02             	shl    $0x2,%eax
  800819:	01 c8                	add    %ecx,%eax
  80081b:	8b 00                	mov    (%eax),%eax
  80081d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800820:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800823:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800828:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80082a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80082d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800834:	8b 45 08             	mov    0x8(%ebp),%eax
  800837:	01 c8                	add    %ecx,%eax
  800839:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80083b:	39 c2                	cmp    %eax,%edx
  80083d:	75 09                	jne    800848 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80083f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800846:	eb 12                	jmp    80085a <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800848:	ff 45 e8             	incl   -0x18(%ebp)
  80084b:	a1 20 30 80 00       	mov    0x803020,%eax
  800850:	8b 50 74             	mov    0x74(%eax),%edx
  800853:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800856:	39 c2                	cmp    %eax,%edx
  800858:	77 86                	ja     8007e0 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80085a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80085e:	75 14                	jne    800874 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800860:	83 ec 04             	sub    $0x4,%esp
  800863:	68 4c 24 80 00       	push   $0x80244c
  800868:	6a 3a                	push   $0x3a
  80086a:	68 40 24 80 00       	push   $0x802440
  80086f:	e8 91 fe ff ff       	call   800705 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800874:	ff 45 f0             	incl   -0x10(%ebp)
  800877:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80087a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80087d:	0f 8c 30 ff ff ff    	jl     8007b3 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800883:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80088a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800891:	eb 27                	jmp    8008ba <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800893:	a1 20 30 80 00       	mov    0x803020,%eax
  800898:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80089e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008a1:	89 d0                	mov    %edx,%eax
  8008a3:	c1 e0 02             	shl    $0x2,%eax
  8008a6:	01 d0                	add    %edx,%eax
  8008a8:	c1 e0 02             	shl    $0x2,%eax
  8008ab:	01 c8                	add    %ecx,%eax
  8008ad:	8a 40 04             	mov    0x4(%eax),%al
  8008b0:	3c 01                	cmp    $0x1,%al
  8008b2:	75 03                	jne    8008b7 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8008b4:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008b7:	ff 45 e0             	incl   -0x20(%ebp)
  8008ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8008bf:	8b 50 74             	mov    0x74(%eax),%edx
  8008c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c5:	39 c2                	cmp    %eax,%edx
  8008c7:	77 ca                	ja     800893 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008cc:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008cf:	74 14                	je     8008e5 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8008d1:	83 ec 04             	sub    $0x4,%esp
  8008d4:	68 a0 24 80 00       	push   $0x8024a0
  8008d9:	6a 44                	push   $0x44
  8008db:	68 40 24 80 00       	push   $0x802440
  8008e0:	e8 20 fe ff ff       	call   800705 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008e5:	90                   	nop
  8008e6:	c9                   	leave  
  8008e7:	c3                   	ret    

008008e8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008e8:	55                   	push   %ebp
  8008e9:	89 e5                	mov    %esp,%ebp
  8008eb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f1:	8b 00                	mov    (%eax),%eax
  8008f3:	8d 48 01             	lea    0x1(%eax),%ecx
  8008f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f9:	89 0a                	mov    %ecx,(%edx)
  8008fb:	8b 55 08             	mov    0x8(%ebp),%edx
  8008fe:	88 d1                	mov    %dl,%cl
  800900:	8b 55 0c             	mov    0xc(%ebp),%edx
  800903:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800907:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090a:	8b 00                	mov    (%eax),%eax
  80090c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800911:	75 2c                	jne    80093f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800913:	a0 24 30 80 00       	mov    0x803024,%al
  800918:	0f b6 c0             	movzbl %al,%eax
  80091b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091e:	8b 12                	mov    (%edx),%edx
  800920:	89 d1                	mov    %edx,%ecx
  800922:	8b 55 0c             	mov    0xc(%ebp),%edx
  800925:	83 c2 08             	add    $0x8,%edx
  800928:	83 ec 04             	sub    $0x4,%esp
  80092b:	50                   	push   %eax
  80092c:	51                   	push   %ecx
  80092d:	52                   	push   %edx
  80092e:	e8 3e 0e 00 00       	call   801771 <sys_cputs>
  800933:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800936:	8b 45 0c             	mov    0xc(%ebp),%eax
  800939:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80093f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800942:	8b 40 04             	mov    0x4(%eax),%eax
  800945:	8d 50 01             	lea    0x1(%eax),%edx
  800948:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80094e:	90                   	nop
  80094f:	c9                   	leave  
  800950:	c3                   	ret    

00800951 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800951:	55                   	push   %ebp
  800952:	89 e5                	mov    %esp,%ebp
  800954:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80095a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800961:	00 00 00 
	b.cnt = 0;
  800964:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80096b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80096e:	ff 75 0c             	pushl  0xc(%ebp)
  800971:	ff 75 08             	pushl  0x8(%ebp)
  800974:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80097a:	50                   	push   %eax
  80097b:	68 e8 08 80 00       	push   $0x8008e8
  800980:	e8 11 02 00 00       	call   800b96 <vprintfmt>
  800985:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800988:	a0 24 30 80 00       	mov    0x803024,%al
  80098d:	0f b6 c0             	movzbl %al,%eax
  800990:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800996:	83 ec 04             	sub    $0x4,%esp
  800999:	50                   	push   %eax
  80099a:	52                   	push   %edx
  80099b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009a1:	83 c0 08             	add    $0x8,%eax
  8009a4:	50                   	push   %eax
  8009a5:	e8 c7 0d 00 00       	call   801771 <sys_cputs>
  8009aa:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009ad:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009b4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009ba:	c9                   	leave  
  8009bb:	c3                   	ret    

008009bc <cprintf>:

int cprintf(const char *fmt, ...) {
  8009bc:	55                   	push   %ebp
  8009bd:	89 e5                	mov    %esp,%ebp
  8009bf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009c2:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009c9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d2:	83 ec 08             	sub    $0x8,%esp
  8009d5:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d8:	50                   	push   %eax
  8009d9:	e8 73 ff ff ff       	call   800951 <vcprintf>
  8009de:	83 c4 10             	add    $0x10,%esp
  8009e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009e7:	c9                   	leave  
  8009e8:	c3                   	ret    

008009e9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009e9:	55                   	push   %ebp
  8009ea:	89 e5                	mov    %esp,%ebp
  8009ec:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009ef:	e8 8e 0f 00 00       	call   801982 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009f4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fd:	83 ec 08             	sub    $0x8,%esp
  800a00:	ff 75 f4             	pushl  -0xc(%ebp)
  800a03:	50                   	push   %eax
  800a04:	e8 48 ff ff ff       	call   800951 <vcprintf>
  800a09:	83 c4 10             	add    $0x10,%esp
  800a0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a0f:	e8 88 0f 00 00       	call   80199c <sys_enable_interrupt>
	return cnt;
  800a14:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a17:	c9                   	leave  
  800a18:	c3                   	ret    

00800a19 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a19:	55                   	push   %ebp
  800a1a:	89 e5                	mov    %esp,%ebp
  800a1c:	53                   	push   %ebx
  800a1d:	83 ec 14             	sub    $0x14,%esp
  800a20:	8b 45 10             	mov    0x10(%ebp),%eax
  800a23:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a26:	8b 45 14             	mov    0x14(%ebp),%eax
  800a29:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a2c:	8b 45 18             	mov    0x18(%ebp),%eax
  800a2f:	ba 00 00 00 00       	mov    $0x0,%edx
  800a34:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a37:	77 55                	ja     800a8e <printnum+0x75>
  800a39:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a3c:	72 05                	jb     800a43 <printnum+0x2a>
  800a3e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a41:	77 4b                	ja     800a8e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a43:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a46:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a49:	8b 45 18             	mov    0x18(%ebp),%eax
  800a4c:	ba 00 00 00 00       	mov    $0x0,%edx
  800a51:	52                   	push   %edx
  800a52:	50                   	push   %eax
  800a53:	ff 75 f4             	pushl  -0xc(%ebp)
  800a56:	ff 75 f0             	pushl  -0x10(%ebp)
  800a59:	e8 62 13 00 00       	call   801dc0 <__udivdi3>
  800a5e:	83 c4 10             	add    $0x10,%esp
  800a61:	83 ec 04             	sub    $0x4,%esp
  800a64:	ff 75 20             	pushl  0x20(%ebp)
  800a67:	53                   	push   %ebx
  800a68:	ff 75 18             	pushl  0x18(%ebp)
  800a6b:	52                   	push   %edx
  800a6c:	50                   	push   %eax
  800a6d:	ff 75 0c             	pushl  0xc(%ebp)
  800a70:	ff 75 08             	pushl  0x8(%ebp)
  800a73:	e8 a1 ff ff ff       	call   800a19 <printnum>
  800a78:	83 c4 20             	add    $0x20,%esp
  800a7b:	eb 1a                	jmp    800a97 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a7d:	83 ec 08             	sub    $0x8,%esp
  800a80:	ff 75 0c             	pushl  0xc(%ebp)
  800a83:	ff 75 20             	pushl  0x20(%ebp)
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	ff d0                	call   *%eax
  800a8b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a8e:	ff 4d 1c             	decl   0x1c(%ebp)
  800a91:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a95:	7f e6                	jg     800a7d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a97:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a9a:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aa2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aa5:	53                   	push   %ebx
  800aa6:	51                   	push   %ecx
  800aa7:	52                   	push   %edx
  800aa8:	50                   	push   %eax
  800aa9:	e8 22 14 00 00       	call   801ed0 <__umoddi3>
  800aae:	83 c4 10             	add    $0x10,%esp
  800ab1:	05 14 27 80 00       	add    $0x802714,%eax
  800ab6:	8a 00                	mov    (%eax),%al
  800ab8:	0f be c0             	movsbl %al,%eax
  800abb:	83 ec 08             	sub    $0x8,%esp
  800abe:	ff 75 0c             	pushl  0xc(%ebp)
  800ac1:	50                   	push   %eax
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac5:	ff d0                	call   *%eax
  800ac7:	83 c4 10             	add    $0x10,%esp
}
  800aca:	90                   	nop
  800acb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ace:	c9                   	leave  
  800acf:	c3                   	ret    

00800ad0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ad0:	55                   	push   %ebp
  800ad1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ad3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ad7:	7e 1c                	jle    800af5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  800adc:	8b 00                	mov    (%eax),%eax
  800ade:	8d 50 08             	lea    0x8(%eax),%edx
  800ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae4:	89 10                	mov    %edx,(%eax)
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	8b 00                	mov    (%eax),%eax
  800aeb:	83 e8 08             	sub    $0x8,%eax
  800aee:	8b 50 04             	mov    0x4(%eax),%edx
  800af1:	8b 00                	mov    (%eax),%eax
  800af3:	eb 40                	jmp    800b35 <getuint+0x65>
	else if (lflag)
  800af5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800af9:	74 1e                	je     800b19 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	8b 00                	mov    (%eax),%eax
  800b00:	8d 50 04             	lea    0x4(%eax),%edx
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	89 10                	mov    %edx,(%eax)
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	8b 00                	mov    (%eax),%eax
  800b0d:	83 e8 04             	sub    $0x4,%eax
  800b10:	8b 00                	mov    (%eax),%eax
  800b12:	ba 00 00 00 00       	mov    $0x0,%edx
  800b17:	eb 1c                	jmp    800b35 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b19:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1c:	8b 00                	mov    (%eax),%eax
  800b1e:	8d 50 04             	lea    0x4(%eax),%edx
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	89 10                	mov    %edx,(%eax)
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	8b 00                	mov    (%eax),%eax
  800b2b:	83 e8 04             	sub    $0x4,%eax
  800b2e:	8b 00                	mov    (%eax),%eax
  800b30:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b35:	5d                   	pop    %ebp
  800b36:	c3                   	ret    

00800b37 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b37:	55                   	push   %ebp
  800b38:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b3a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b3e:	7e 1c                	jle    800b5c <getint+0x25>
		return va_arg(*ap, long long);
  800b40:	8b 45 08             	mov    0x8(%ebp),%eax
  800b43:	8b 00                	mov    (%eax),%eax
  800b45:	8d 50 08             	lea    0x8(%eax),%edx
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	89 10                	mov    %edx,(%eax)
  800b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b50:	8b 00                	mov    (%eax),%eax
  800b52:	83 e8 08             	sub    $0x8,%eax
  800b55:	8b 50 04             	mov    0x4(%eax),%edx
  800b58:	8b 00                	mov    (%eax),%eax
  800b5a:	eb 38                	jmp    800b94 <getint+0x5d>
	else if (lflag)
  800b5c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b60:	74 1a                	je     800b7c <getint+0x45>
		return va_arg(*ap, long);
  800b62:	8b 45 08             	mov    0x8(%ebp),%eax
  800b65:	8b 00                	mov    (%eax),%eax
  800b67:	8d 50 04             	lea    0x4(%eax),%edx
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	89 10                	mov    %edx,(%eax)
  800b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b72:	8b 00                	mov    (%eax),%eax
  800b74:	83 e8 04             	sub    $0x4,%eax
  800b77:	8b 00                	mov    (%eax),%eax
  800b79:	99                   	cltd   
  800b7a:	eb 18                	jmp    800b94 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7f:	8b 00                	mov    (%eax),%eax
  800b81:	8d 50 04             	lea    0x4(%eax),%edx
  800b84:	8b 45 08             	mov    0x8(%ebp),%eax
  800b87:	89 10                	mov    %edx,(%eax)
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	8b 00                	mov    (%eax),%eax
  800b8e:	83 e8 04             	sub    $0x4,%eax
  800b91:	8b 00                	mov    (%eax),%eax
  800b93:	99                   	cltd   
}
  800b94:	5d                   	pop    %ebp
  800b95:	c3                   	ret    

00800b96 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b96:	55                   	push   %ebp
  800b97:	89 e5                	mov    %esp,%ebp
  800b99:	56                   	push   %esi
  800b9a:	53                   	push   %ebx
  800b9b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b9e:	eb 17                	jmp    800bb7 <vprintfmt+0x21>
			if (ch == '\0')
  800ba0:	85 db                	test   %ebx,%ebx
  800ba2:	0f 84 af 03 00 00    	je     800f57 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ba8:	83 ec 08             	sub    $0x8,%esp
  800bab:	ff 75 0c             	pushl  0xc(%ebp)
  800bae:	53                   	push   %ebx
  800baf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb2:	ff d0                	call   *%eax
  800bb4:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bba:	8d 50 01             	lea    0x1(%eax),%edx
  800bbd:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc0:	8a 00                	mov    (%eax),%al
  800bc2:	0f b6 d8             	movzbl %al,%ebx
  800bc5:	83 fb 25             	cmp    $0x25,%ebx
  800bc8:	75 d6                	jne    800ba0 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bca:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bce:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bd5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bdc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800be3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bea:	8b 45 10             	mov    0x10(%ebp),%eax
  800bed:	8d 50 01             	lea    0x1(%eax),%edx
  800bf0:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf3:	8a 00                	mov    (%eax),%al
  800bf5:	0f b6 d8             	movzbl %al,%ebx
  800bf8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bfb:	83 f8 55             	cmp    $0x55,%eax
  800bfe:	0f 87 2b 03 00 00    	ja     800f2f <vprintfmt+0x399>
  800c04:	8b 04 85 38 27 80 00 	mov    0x802738(,%eax,4),%eax
  800c0b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c0d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c11:	eb d7                	jmp    800bea <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c13:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c17:	eb d1                	jmp    800bea <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c19:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c20:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c23:	89 d0                	mov    %edx,%eax
  800c25:	c1 e0 02             	shl    $0x2,%eax
  800c28:	01 d0                	add    %edx,%eax
  800c2a:	01 c0                	add    %eax,%eax
  800c2c:	01 d8                	add    %ebx,%eax
  800c2e:	83 e8 30             	sub    $0x30,%eax
  800c31:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c34:	8b 45 10             	mov    0x10(%ebp),%eax
  800c37:	8a 00                	mov    (%eax),%al
  800c39:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c3c:	83 fb 2f             	cmp    $0x2f,%ebx
  800c3f:	7e 3e                	jle    800c7f <vprintfmt+0xe9>
  800c41:	83 fb 39             	cmp    $0x39,%ebx
  800c44:	7f 39                	jg     800c7f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c46:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c49:	eb d5                	jmp    800c20 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c4b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4e:	83 c0 04             	add    $0x4,%eax
  800c51:	89 45 14             	mov    %eax,0x14(%ebp)
  800c54:	8b 45 14             	mov    0x14(%ebp),%eax
  800c57:	83 e8 04             	sub    $0x4,%eax
  800c5a:	8b 00                	mov    (%eax),%eax
  800c5c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c5f:	eb 1f                	jmp    800c80 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c61:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c65:	79 83                	jns    800bea <vprintfmt+0x54>
				width = 0;
  800c67:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c6e:	e9 77 ff ff ff       	jmp    800bea <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c73:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c7a:	e9 6b ff ff ff       	jmp    800bea <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c7f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c80:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c84:	0f 89 60 ff ff ff    	jns    800bea <vprintfmt+0x54>
				width = precision, precision = -1;
  800c8a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c8d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c90:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c97:	e9 4e ff ff ff       	jmp    800bea <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c9c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c9f:	e9 46 ff ff ff       	jmp    800bea <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ca4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca7:	83 c0 04             	add    $0x4,%eax
  800caa:	89 45 14             	mov    %eax,0x14(%ebp)
  800cad:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb0:	83 e8 04             	sub    $0x4,%eax
  800cb3:	8b 00                	mov    (%eax),%eax
  800cb5:	83 ec 08             	sub    $0x8,%esp
  800cb8:	ff 75 0c             	pushl  0xc(%ebp)
  800cbb:	50                   	push   %eax
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbf:	ff d0                	call   *%eax
  800cc1:	83 c4 10             	add    $0x10,%esp
			break;
  800cc4:	e9 89 02 00 00       	jmp    800f52 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cc9:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccc:	83 c0 04             	add    $0x4,%eax
  800ccf:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd2:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd5:	83 e8 04             	sub    $0x4,%eax
  800cd8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cda:	85 db                	test   %ebx,%ebx
  800cdc:	79 02                	jns    800ce0 <vprintfmt+0x14a>
				err = -err;
  800cde:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ce0:	83 fb 64             	cmp    $0x64,%ebx
  800ce3:	7f 0b                	jg     800cf0 <vprintfmt+0x15a>
  800ce5:	8b 34 9d 80 25 80 00 	mov    0x802580(,%ebx,4),%esi
  800cec:	85 f6                	test   %esi,%esi
  800cee:	75 19                	jne    800d09 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cf0:	53                   	push   %ebx
  800cf1:	68 25 27 80 00       	push   $0x802725
  800cf6:	ff 75 0c             	pushl  0xc(%ebp)
  800cf9:	ff 75 08             	pushl  0x8(%ebp)
  800cfc:	e8 5e 02 00 00       	call   800f5f <printfmt>
  800d01:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d04:	e9 49 02 00 00       	jmp    800f52 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d09:	56                   	push   %esi
  800d0a:	68 2e 27 80 00       	push   $0x80272e
  800d0f:	ff 75 0c             	pushl  0xc(%ebp)
  800d12:	ff 75 08             	pushl  0x8(%ebp)
  800d15:	e8 45 02 00 00       	call   800f5f <printfmt>
  800d1a:	83 c4 10             	add    $0x10,%esp
			break;
  800d1d:	e9 30 02 00 00       	jmp    800f52 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d22:	8b 45 14             	mov    0x14(%ebp),%eax
  800d25:	83 c0 04             	add    $0x4,%eax
  800d28:	89 45 14             	mov    %eax,0x14(%ebp)
  800d2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2e:	83 e8 04             	sub    $0x4,%eax
  800d31:	8b 30                	mov    (%eax),%esi
  800d33:	85 f6                	test   %esi,%esi
  800d35:	75 05                	jne    800d3c <vprintfmt+0x1a6>
				p = "(null)";
  800d37:	be 31 27 80 00       	mov    $0x802731,%esi
			if (width > 0 && padc != '-')
  800d3c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d40:	7e 6d                	jle    800daf <vprintfmt+0x219>
  800d42:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d46:	74 67                	je     800daf <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d48:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d4b:	83 ec 08             	sub    $0x8,%esp
  800d4e:	50                   	push   %eax
  800d4f:	56                   	push   %esi
  800d50:	e8 0c 03 00 00       	call   801061 <strnlen>
  800d55:	83 c4 10             	add    $0x10,%esp
  800d58:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d5b:	eb 16                	jmp    800d73 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d5d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d61:	83 ec 08             	sub    $0x8,%esp
  800d64:	ff 75 0c             	pushl  0xc(%ebp)
  800d67:	50                   	push   %eax
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6b:	ff d0                	call   *%eax
  800d6d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d70:	ff 4d e4             	decl   -0x1c(%ebp)
  800d73:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d77:	7f e4                	jg     800d5d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d79:	eb 34                	jmp    800daf <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d7b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d7f:	74 1c                	je     800d9d <vprintfmt+0x207>
  800d81:	83 fb 1f             	cmp    $0x1f,%ebx
  800d84:	7e 05                	jle    800d8b <vprintfmt+0x1f5>
  800d86:	83 fb 7e             	cmp    $0x7e,%ebx
  800d89:	7e 12                	jle    800d9d <vprintfmt+0x207>
					putch('?', putdat);
  800d8b:	83 ec 08             	sub    $0x8,%esp
  800d8e:	ff 75 0c             	pushl  0xc(%ebp)
  800d91:	6a 3f                	push   $0x3f
  800d93:	8b 45 08             	mov    0x8(%ebp),%eax
  800d96:	ff d0                	call   *%eax
  800d98:	83 c4 10             	add    $0x10,%esp
  800d9b:	eb 0f                	jmp    800dac <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d9d:	83 ec 08             	sub    $0x8,%esp
  800da0:	ff 75 0c             	pushl  0xc(%ebp)
  800da3:	53                   	push   %ebx
  800da4:	8b 45 08             	mov    0x8(%ebp),%eax
  800da7:	ff d0                	call   *%eax
  800da9:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dac:	ff 4d e4             	decl   -0x1c(%ebp)
  800daf:	89 f0                	mov    %esi,%eax
  800db1:	8d 70 01             	lea    0x1(%eax),%esi
  800db4:	8a 00                	mov    (%eax),%al
  800db6:	0f be d8             	movsbl %al,%ebx
  800db9:	85 db                	test   %ebx,%ebx
  800dbb:	74 24                	je     800de1 <vprintfmt+0x24b>
  800dbd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dc1:	78 b8                	js     800d7b <vprintfmt+0x1e5>
  800dc3:	ff 4d e0             	decl   -0x20(%ebp)
  800dc6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dca:	79 af                	jns    800d7b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dcc:	eb 13                	jmp    800de1 <vprintfmt+0x24b>
				putch(' ', putdat);
  800dce:	83 ec 08             	sub    $0x8,%esp
  800dd1:	ff 75 0c             	pushl  0xc(%ebp)
  800dd4:	6a 20                	push   $0x20
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	ff d0                	call   *%eax
  800ddb:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dde:	ff 4d e4             	decl   -0x1c(%ebp)
  800de1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de5:	7f e7                	jg     800dce <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800de7:	e9 66 01 00 00       	jmp    800f52 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dec:	83 ec 08             	sub    $0x8,%esp
  800def:	ff 75 e8             	pushl  -0x18(%ebp)
  800df2:	8d 45 14             	lea    0x14(%ebp),%eax
  800df5:	50                   	push   %eax
  800df6:	e8 3c fd ff ff       	call   800b37 <getint>
  800dfb:	83 c4 10             	add    $0x10,%esp
  800dfe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e01:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e04:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e07:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e0a:	85 d2                	test   %edx,%edx
  800e0c:	79 23                	jns    800e31 <vprintfmt+0x29b>
				putch('-', putdat);
  800e0e:	83 ec 08             	sub    $0x8,%esp
  800e11:	ff 75 0c             	pushl  0xc(%ebp)
  800e14:	6a 2d                	push   $0x2d
  800e16:	8b 45 08             	mov    0x8(%ebp),%eax
  800e19:	ff d0                	call   *%eax
  800e1b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e21:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e24:	f7 d8                	neg    %eax
  800e26:	83 d2 00             	adc    $0x0,%edx
  800e29:	f7 da                	neg    %edx
  800e2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e31:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e38:	e9 bc 00 00 00       	jmp    800ef9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e3d:	83 ec 08             	sub    $0x8,%esp
  800e40:	ff 75 e8             	pushl  -0x18(%ebp)
  800e43:	8d 45 14             	lea    0x14(%ebp),%eax
  800e46:	50                   	push   %eax
  800e47:	e8 84 fc ff ff       	call   800ad0 <getuint>
  800e4c:	83 c4 10             	add    $0x10,%esp
  800e4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e52:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e55:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e5c:	e9 98 00 00 00       	jmp    800ef9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e61:	83 ec 08             	sub    $0x8,%esp
  800e64:	ff 75 0c             	pushl  0xc(%ebp)
  800e67:	6a 58                	push   $0x58
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	ff d0                	call   *%eax
  800e6e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e71:	83 ec 08             	sub    $0x8,%esp
  800e74:	ff 75 0c             	pushl  0xc(%ebp)
  800e77:	6a 58                	push   $0x58
  800e79:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7c:	ff d0                	call   *%eax
  800e7e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e81:	83 ec 08             	sub    $0x8,%esp
  800e84:	ff 75 0c             	pushl  0xc(%ebp)
  800e87:	6a 58                	push   $0x58
  800e89:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8c:	ff d0                	call   *%eax
  800e8e:	83 c4 10             	add    $0x10,%esp
			break;
  800e91:	e9 bc 00 00 00       	jmp    800f52 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e96:	83 ec 08             	sub    $0x8,%esp
  800e99:	ff 75 0c             	pushl  0xc(%ebp)
  800e9c:	6a 30                	push   $0x30
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea1:	ff d0                	call   *%eax
  800ea3:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ea6:	83 ec 08             	sub    $0x8,%esp
  800ea9:	ff 75 0c             	pushl  0xc(%ebp)
  800eac:	6a 78                	push   $0x78
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	ff d0                	call   *%eax
  800eb3:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800eb6:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb9:	83 c0 04             	add    $0x4,%eax
  800ebc:	89 45 14             	mov    %eax,0x14(%ebp)
  800ebf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec2:	83 e8 04             	sub    $0x4,%eax
  800ec5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ec7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ed1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ed8:	eb 1f                	jmp    800ef9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800eda:	83 ec 08             	sub    $0x8,%esp
  800edd:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee0:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee3:	50                   	push   %eax
  800ee4:	e8 e7 fb ff ff       	call   800ad0 <getuint>
  800ee9:	83 c4 10             	add    $0x10,%esp
  800eec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eef:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ef2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ef9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800efd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f00:	83 ec 04             	sub    $0x4,%esp
  800f03:	52                   	push   %edx
  800f04:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f07:	50                   	push   %eax
  800f08:	ff 75 f4             	pushl  -0xc(%ebp)
  800f0b:	ff 75 f0             	pushl  -0x10(%ebp)
  800f0e:	ff 75 0c             	pushl  0xc(%ebp)
  800f11:	ff 75 08             	pushl  0x8(%ebp)
  800f14:	e8 00 fb ff ff       	call   800a19 <printnum>
  800f19:	83 c4 20             	add    $0x20,%esp
			break;
  800f1c:	eb 34                	jmp    800f52 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f1e:	83 ec 08             	sub    $0x8,%esp
  800f21:	ff 75 0c             	pushl  0xc(%ebp)
  800f24:	53                   	push   %ebx
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	ff d0                	call   *%eax
  800f2a:	83 c4 10             	add    $0x10,%esp
			break;
  800f2d:	eb 23                	jmp    800f52 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f2f:	83 ec 08             	sub    $0x8,%esp
  800f32:	ff 75 0c             	pushl  0xc(%ebp)
  800f35:	6a 25                	push   $0x25
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3a:	ff d0                	call   *%eax
  800f3c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f3f:	ff 4d 10             	decl   0x10(%ebp)
  800f42:	eb 03                	jmp    800f47 <vprintfmt+0x3b1>
  800f44:	ff 4d 10             	decl   0x10(%ebp)
  800f47:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4a:	48                   	dec    %eax
  800f4b:	8a 00                	mov    (%eax),%al
  800f4d:	3c 25                	cmp    $0x25,%al
  800f4f:	75 f3                	jne    800f44 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f51:	90                   	nop
		}
	}
  800f52:	e9 47 fc ff ff       	jmp    800b9e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f57:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f58:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f5b:	5b                   	pop    %ebx
  800f5c:	5e                   	pop    %esi
  800f5d:	5d                   	pop    %ebp
  800f5e:	c3                   	ret    

00800f5f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f5f:	55                   	push   %ebp
  800f60:	89 e5                	mov    %esp,%ebp
  800f62:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f65:	8d 45 10             	lea    0x10(%ebp),%eax
  800f68:	83 c0 04             	add    $0x4,%eax
  800f6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f6e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f71:	ff 75 f4             	pushl  -0xc(%ebp)
  800f74:	50                   	push   %eax
  800f75:	ff 75 0c             	pushl  0xc(%ebp)
  800f78:	ff 75 08             	pushl  0x8(%ebp)
  800f7b:	e8 16 fc ff ff       	call   800b96 <vprintfmt>
  800f80:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f83:	90                   	nop
  800f84:	c9                   	leave  
  800f85:	c3                   	ret    

00800f86 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f86:	55                   	push   %ebp
  800f87:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8c:	8b 40 08             	mov    0x8(%eax),%eax
  800f8f:	8d 50 01             	lea    0x1(%eax),%edx
  800f92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f95:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9b:	8b 10                	mov    (%eax),%edx
  800f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa0:	8b 40 04             	mov    0x4(%eax),%eax
  800fa3:	39 c2                	cmp    %eax,%edx
  800fa5:	73 12                	jae    800fb9 <sprintputch+0x33>
		*b->buf++ = ch;
  800fa7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800faa:	8b 00                	mov    (%eax),%eax
  800fac:	8d 48 01             	lea    0x1(%eax),%ecx
  800faf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fb2:	89 0a                	mov    %ecx,(%edx)
  800fb4:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb7:	88 10                	mov    %dl,(%eax)
}
  800fb9:	90                   	nop
  800fba:	5d                   	pop    %ebp
  800fbb:	c3                   	ret    

00800fbc <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fbc:	55                   	push   %ebp
  800fbd:	89 e5                	mov    %esp,%ebp
  800fbf:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	01 d0                	add    %edx,%eax
  800fd3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fdd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fe1:	74 06                	je     800fe9 <vsnprintf+0x2d>
  800fe3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fe7:	7f 07                	jg     800ff0 <vsnprintf+0x34>
		return -E_INVAL;
  800fe9:	b8 03 00 00 00       	mov    $0x3,%eax
  800fee:	eb 20                	jmp    801010 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ff0:	ff 75 14             	pushl  0x14(%ebp)
  800ff3:	ff 75 10             	pushl  0x10(%ebp)
  800ff6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ff9:	50                   	push   %eax
  800ffa:	68 86 0f 80 00       	push   $0x800f86
  800fff:	e8 92 fb ff ff       	call   800b96 <vprintfmt>
  801004:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801007:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80100a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80100d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801010:	c9                   	leave  
  801011:	c3                   	ret    

00801012 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801012:	55                   	push   %ebp
  801013:	89 e5                	mov    %esp,%ebp
  801015:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801018:	8d 45 10             	lea    0x10(%ebp),%eax
  80101b:	83 c0 04             	add    $0x4,%eax
  80101e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801021:	8b 45 10             	mov    0x10(%ebp),%eax
  801024:	ff 75 f4             	pushl  -0xc(%ebp)
  801027:	50                   	push   %eax
  801028:	ff 75 0c             	pushl  0xc(%ebp)
  80102b:	ff 75 08             	pushl  0x8(%ebp)
  80102e:	e8 89 ff ff ff       	call   800fbc <vsnprintf>
  801033:	83 c4 10             	add    $0x10,%esp
  801036:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801039:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80103c:	c9                   	leave  
  80103d:	c3                   	ret    

0080103e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80103e:	55                   	push   %ebp
  80103f:	89 e5                	mov    %esp,%ebp
  801041:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801044:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80104b:	eb 06                	jmp    801053 <strlen+0x15>
		n++;
  80104d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801050:	ff 45 08             	incl   0x8(%ebp)
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	8a 00                	mov    (%eax),%al
  801058:	84 c0                	test   %al,%al
  80105a:	75 f1                	jne    80104d <strlen+0xf>
		n++;
	return n;
  80105c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80105f:	c9                   	leave  
  801060:	c3                   	ret    

00801061 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801061:	55                   	push   %ebp
  801062:	89 e5                	mov    %esp,%ebp
  801064:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801067:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80106e:	eb 09                	jmp    801079 <strnlen+0x18>
		n++;
  801070:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801073:	ff 45 08             	incl   0x8(%ebp)
  801076:	ff 4d 0c             	decl   0xc(%ebp)
  801079:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80107d:	74 09                	je     801088 <strnlen+0x27>
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8a 00                	mov    (%eax),%al
  801084:	84 c0                	test   %al,%al
  801086:	75 e8                	jne    801070 <strnlen+0xf>
		n++;
	return n;
  801088:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80108b:	c9                   	leave  
  80108c:	c3                   	ret    

0080108d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80108d:	55                   	push   %ebp
  80108e:	89 e5                	mov    %esp,%ebp
  801090:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801093:	8b 45 08             	mov    0x8(%ebp),%eax
  801096:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801099:	90                   	nop
  80109a:	8b 45 08             	mov    0x8(%ebp),%eax
  80109d:	8d 50 01             	lea    0x1(%eax),%edx
  8010a0:	89 55 08             	mov    %edx,0x8(%ebp)
  8010a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010a9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010ac:	8a 12                	mov    (%edx),%dl
  8010ae:	88 10                	mov    %dl,(%eax)
  8010b0:	8a 00                	mov    (%eax),%al
  8010b2:	84 c0                	test   %al,%al
  8010b4:	75 e4                	jne    80109a <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010b9:	c9                   	leave  
  8010ba:	c3                   	ret    

008010bb <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010bb:	55                   	push   %ebp
  8010bc:	89 e5                	mov    %esp,%ebp
  8010be:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010ce:	eb 1f                	jmp    8010ef <strncpy+0x34>
		*dst++ = *src;
  8010d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d3:	8d 50 01             	lea    0x1(%eax),%edx
  8010d6:	89 55 08             	mov    %edx,0x8(%ebp)
  8010d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010dc:	8a 12                	mov    (%edx),%dl
  8010de:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e3:	8a 00                	mov    (%eax),%al
  8010e5:	84 c0                	test   %al,%al
  8010e7:	74 03                	je     8010ec <strncpy+0x31>
			src++;
  8010e9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010ec:	ff 45 fc             	incl   -0x4(%ebp)
  8010ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010f5:	72 d9                	jb     8010d0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010fa:	c9                   	leave  
  8010fb:	c3                   	ret    

008010fc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010fc:	55                   	push   %ebp
  8010fd:	89 e5                	mov    %esp,%ebp
  8010ff:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801102:	8b 45 08             	mov    0x8(%ebp),%eax
  801105:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801108:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80110c:	74 30                	je     80113e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80110e:	eb 16                	jmp    801126 <strlcpy+0x2a>
			*dst++ = *src++;
  801110:	8b 45 08             	mov    0x8(%ebp),%eax
  801113:	8d 50 01             	lea    0x1(%eax),%edx
  801116:	89 55 08             	mov    %edx,0x8(%ebp)
  801119:	8b 55 0c             	mov    0xc(%ebp),%edx
  80111c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80111f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801122:	8a 12                	mov    (%edx),%dl
  801124:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801126:	ff 4d 10             	decl   0x10(%ebp)
  801129:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80112d:	74 09                	je     801138 <strlcpy+0x3c>
  80112f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801132:	8a 00                	mov    (%eax),%al
  801134:	84 c0                	test   %al,%al
  801136:	75 d8                	jne    801110 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801138:	8b 45 08             	mov    0x8(%ebp),%eax
  80113b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80113e:	8b 55 08             	mov    0x8(%ebp),%edx
  801141:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801144:	29 c2                	sub    %eax,%edx
  801146:	89 d0                	mov    %edx,%eax
}
  801148:	c9                   	leave  
  801149:	c3                   	ret    

0080114a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80114a:	55                   	push   %ebp
  80114b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80114d:	eb 06                	jmp    801155 <strcmp+0xb>
		p++, q++;
  80114f:	ff 45 08             	incl   0x8(%ebp)
  801152:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801155:	8b 45 08             	mov    0x8(%ebp),%eax
  801158:	8a 00                	mov    (%eax),%al
  80115a:	84 c0                	test   %al,%al
  80115c:	74 0e                	je     80116c <strcmp+0x22>
  80115e:	8b 45 08             	mov    0x8(%ebp),%eax
  801161:	8a 10                	mov    (%eax),%dl
  801163:	8b 45 0c             	mov    0xc(%ebp),%eax
  801166:	8a 00                	mov    (%eax),%al
  801168:	38 c2                	cmp    %al,%dl
  80116a:	74 e3                	je     80114f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80116c:	8b 45 08             	mov    0x8(%ebp),%eax
  80116f:	8a 00                	mov    (%eax),%al
  801171:	0f b6 d0             	movzbl %al,%edx
  801174:	8b 45 0c             	mov    0xc(%ebp),%eax
  801177:	8a 00                	mov    (%eax),%al
  801179:	0f b6 c0             	movzbl %al,%eax
  80117c:	29 c2                	sub    %eax,%edx
  80117e:	89 d0                	mov    %edx,%eax
}
  801180:	5d                   	pop    %ebp
  801181:	c3                   	ret    

00801182 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801182:	55                   	push   %ebp
  801183:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801185:	eb 09                	jmp    801190 <strncmp+0xe>
		n--, p++, q++;
  801187:	ff 4d 10             	decl   0x10(%ebp)
  80118a:	ff 45 08             	incl   0x8(%ebp)
  80118d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801190:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801194:	74 17                	je     8011ad <strncmp+0x2b>
  801196:	8b 45 08             	mov    0x8(%ebp),%eax
  801199:	8a 00                	mov    (%eax),%al
  80119b:	84 c0                	test   %al,%al
  80119d:	74 0e                	je     8011ad <strncmp+0x2b>
  80119f:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a2:	8a 10                	mov    (%eax),%dl
  8011a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a7:	8a 00                	mov    (%eax),%al
  8011a9:	38 c2                	cmp    %al,%dl
  8011ab:	74 da                	je     801187 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b1:	75 07                	jne    8011ba <strncmp+0x38>
		return 0;
  8011b3:	b8 00 00 00 00       	mov    $0x0,%eax
  8011b8:	eb 14                	jmp    8011ce <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	8a 00                	mov    (%eax),%al
  8011bf:	0f b6 d0             	movzbl %al,%edx
  8011c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c5:	8a 00                	mov    (%eax),%al
  8011c7:	0f b6 c0             	movzbl %al,%eax
  8011ca:	29 c2                	sub    %eax,%edx
  8011cc:	89 d0                	mov    %edx,%eax
}
  8011ce:	5d                   	pop    %ebp
  8011cf:	c3                   	ret    

008011d0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011d0:	55                   	push   %ebp
  8011d1:	89 e5                	mov    %esp,%ebp
  8011d3:	83 ec 04             	sub    $0x4,%esp
  8011d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011dc:	eb 12                	jmp    8011f0 <strchr+0x20>
		if (*s == c)
  8011de:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e1:	8a 00                	mov    (%eax),%al
  8011e3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011e6:	75 05                	jne    8011ed <strchr+0x1d>
			return (char *) s;
  8011e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011eb:	eb 11                	jmp    8011fe <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011ed:	ff 45 08             	incl   0x8(%ebp)
  8011f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f3:	8a 00                	mov    (%eax),%al
  8011f5:	84 c0                	test   %al,%al
  8011f7:	75 e5                	jne    8011de <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011f9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011fe:	c9                   	leave  
  8011ff:	c3                   	ret    

00801200 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801200:	55                   	push   %ebp
  801201:	89 e5                	mov    %esp,%ebp
  801203:	83 ec 04             	sub    $0x4,%esp
  801206:	8b 45 0c             	mov    0xc(%ebp),%eax
  801209:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80120c:	eb 0d                	jmp    80121b <strfind+0x1b>
		if (*s == c)
  80120e:	8b 45 08             	mov    0x8(%ebp),%eax
  801211:	8a 00                	mov    (%eax),%al
  801213:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801216:	74 0e                	je     801226 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801218:	ff 45 08             	incl   0x8(%ebp)
  80121b:	8b 45 08             	mov    0x8(%ebp),%eax
  80121e:	8a 00                	mov    (%eax),%al
  801220:	84 c0                	test   %al,%al
  801222:	75 ea                	jne    80120e <strfind+0xe>
  801224:	eb 01                	jmp    801227 <strfind+0x27>
		if (*s == c)
			break;
  801226:	90                   	nop
	return (char *) s;
  801227:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80122a:	c9                   	leave  
  80122b:	c3                   	ret    

0080122c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80122c:	55                   	push   %ebp
  80122d:	89 e5                	mov    %esp,%ebp
  80122f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801232:	8b 45 08             	mov    0x8(%ebp),%eax
  801235:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801238:	8b 45 10             	mov    0x10(%ebp),%eax
  80123b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80123e:	eb 0e                	jmp    80124e <memset+0x22>
		*p++ = c;
  801240:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801243:	8d 50 01             	lea    0x1(%eax),%edx
  801246:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801249:	8b 55 0c             	mov    0xc(%ebp),%edx
  80124c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80124e:	ff 4d f8             	decl   -0x8(%ebp)
  801251:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801255:	79 e9                	jns    801240 <memset+0x14>
		*p++ = c;

	return v;
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80125a:	c9                   	leave  
  80125b:	c3                   	ret    

0080125c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80125c:	55                   	push   %ebp
  80125d:	89 e5                	mov    %esp,%ebp
  80125f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801262:	8b 45 0c             	mov    0xc(%ebp),%eax
  801265:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801268:	8b 45 08             	mov    0x8(%ebp),%eax
  80126b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80126e:	eb 16                	jmp    801286 <memcpy+0x2a>
		*d++ = *s++;
  801270:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801273:	8d 50 01             	lea    0x1(%eax),%edx
  801276:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801279:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80127c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80127f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801282:	8a 12                	mov    (%edx),%dl
  801284:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801286:	8b 45 10             	mov    0x10(%ebp),%eax
  801289:	8d 50 ff             	lea    -0x1(%eax),%edx
  80128c:	89 55 10             	mov    %edx,0x10(%ebp)
  80128f:	85 c0                	test   %eax,%eax
  801291:	75 dd                	jne    801270 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801296:	c9                   	leave  
  801297:	c3                   	ret    

00801298 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801298:	55                   	push   %ebp
  801299:	89 e5                	mov    %esp,%ebp
  80129b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80129e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ad:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012b0:	73 50                	jae    801302 <memmove+0x6a>
  8012b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b8:	01 d0                	add    %edx,%eax
  8012ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012bd:	76 43                	jbe    801302 <memmove+0x6a>
		s += n;
  8012bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012cb:	eb 10                	jmp    8012dd <memmove+0x45>
			*--d = *--s;
  8012cd:	ff 4d f8             	decl   -0x8(%ebp)
  8012d0:	ff 4d fc             	decl   -0x4(%ebp)
  8012d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d6:	8a 10                	mov    (%eax),%dl
  8012d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012db:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012e3:	89 55 10             	mov    %edx,0x10(%ebp)
  8012e6:	85 c0                	test   %eax,%eax
  8012e8:	75 e3                	jne    8012cd <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012ea:	eb 23                	jmp    80130f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ef:	8d 50 01             	lea    0x1(%eax),%edx
  8012f2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012f8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012fb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012fe:	8a 12                	mov    (%edx),%dl
  801300:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801302:	8b 45 10             	mov    0x10(%ebp),%eax
  801305:	8d 50 ff             	lea    -0x1(%eax),%edx
  801308:	89 55 10             	mov    %edx,0x10(%ebp)
  80130b:	85 c0                	test   %eax,%eax
  80130d:	75 dd                	jne    8012ec <memmove+0x54>
			*d++ = *s++;

	return dst;
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801312:	c9                   	leave  
  801313:	c3                   	ret    

00801314 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801314:	55                   	push   %ebp
  801315:	89 e5                	mov    %esp,%ebp
  801317:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80131a:	8b 45 08             	mov    0x8(%ebp),%eax
  80131d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801320:	8b 45 0c             	mov    0xc(%ebp),%eax
  801323:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801326:	eb 2a                	jmp    801352 <memcmp+0x3e>
		if (*s1 != *s2)
  801328:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80132b:	8a 10                	mov    (%eax),%dl
  80132d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801330:	8a 00                	mov    (%eax),%al
  801332:	38 c2                	cmp    %al,%dl
  801334:	74 16                	je     80134c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801336:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801339:	8a 00                	mov    (%eax),%al
  80133b:	0f b6 d0             	movzbl %al,%edx
  80133e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801341:	8a 00                	mov    (%eax),%al
  801343:	0f b6 c0             	movzbl %al,%eax
  801346:	29 c2                	sub    %eax,%edx
  801348:	89 d0                	mov    %edx,%eax
  80134a:	eb 18                	jmp    801364 <memcmp+0x50>
		s1++, s2++;
  80134c:	ff 45 fc             	incl   -0x4(%ebp)
  80134f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801352:	8b 45 10             	mov    0x10(%ebp),%eax
  801355:	8d 50 ff             	lea    -0x1(%eax),%edx
  801358:	89 55 10             	mov    %edx,0x10(%ebp)
  80135b:	85 c0                	test   %eax,%eax
  80135d:	75 c9                	jne    801328 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80135f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801364:	c9                   	leave  
  801365:	c3                   	ret    

00801366 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801366:	55                   	push   %ebp
  801367:	89 e5                	mov    %esp,%ebp
  801369:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80136c:	8b 55 08             	mov    0x8(%ebp),%edx
  80136f:	8b 45 10             	mov    0x10(%ebp),%eax
  801372:	01 d0                	add    %edx,%eax
  801374:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801377:	eb 15                	jmp    80138e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	8a 00                	mov    (%eax),%al
  80137e:	0f b6 d0             	movzbl %al,%edx
  801381:	8b 45 0c             	mov    0xc(%ebp),%eax
  801384:	0f b6 c0             	movzbl %al,%eax
  801387:	39 c2                	cmp    %eax,%edx
  801389:	74 0d                	je     801398 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80138b:	ff 45 08             	incl   0x8(%ebp)
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801394:	72 e3                	jb     801379 <memfind+0x13>
  801396:	eb 01                	jmp    801399 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801398:	90                   	nop
	return (void *) s;
  801399:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80139c:	c9                   	leave  
  80139d:	c3                   	ret    

0080139e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80139e:	55                   	push   %ebp
  80139f:	89 e5                	mov    %esp,%ebp
  8013a1:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013a4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013ab:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013b2:	eb 03                	jmp    8013b7 <strtol+0x19>
		s++;
  8013b4:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ba:	8a 00                	mov    (%eax),%al
  8013bc:	3c 20                	cmp    $0x20,%al
  8013be:	74 f4                	je     8013b4 <strtol+0x16>
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	8a 00                	mov    (%eax),%al
  8013c5:	3c 09                	cmp    $0x9,%al
  8013c7:	74 eb                	je     8013b4 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cc:	8a 00                	mov    (%eax),%al
  8013ce:	3c 2b                	cmp    $0x2b,%al
  8013d0:	75 05                	jne    8013d7 <strtol+0x39>
		s++;
  8013d2:	ff 45 08             	incl   0x8(%ebp)
  8013d5:	eb 13                	jmp    8013ea <strtol+0x4c>
	else if (*s == '-')
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	8a 00                	mov    (%eax),%al
  8013dc:	3c 2d                	cmp    $0x2d,%al
  8013de:	75 0a                	jne    8013ea <strtol+0x4c>
		s++, neg = 1;
  8013e0:	ff 45 08             	incl   0x8(%ebp)
  8013e3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013ea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ee:	74 06                	je     8013f6 <strtol+0x58>
  8013f0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013f4:	75 20                	jne    801416 <strtol+0x78>
  8013f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f9:	8a 00                	mov    (%eax),%al
  8013fb:	3c 30                	cmp    $0x30,%al
  8013fd:	75 17                	jne    801416 <strtol+0x78>
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	40                   	inc    %eax
  801403:	8a 00                	mov    (%eax),%al
  801405:	3c 78                	cmp    $0x78,%al
  801407:	75 0d                	jne    801416 <strtol+0x78>
		s += 2, base = 16;
  801409:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80140d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801414:	eb 28                	jmp    80143e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801416:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80141a:	75 15                	jne    801431 <strtol+0x93>
  80141c:	8b 45 08             	mov    0x8(%ebp),%eax
  80141f:	8a 00                	mov    (%eax),%al
  801421:	3c 30                	cmp    $0x30,%al
  801423:	75 0c                	jne    801431 <strtol+0x93>
		s++, base = 8;
  801425:	ff 45 08             	incl   0x8(%ebp)
  801428:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80142f:	eb 0d                	jmp    80143e <strtol+0xa0>
	else if (base == 0)
  801431:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801435:	75 07                	jne    80143e <strtol+0xa0>
		base = 10;
  801437:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	8a 00                	mov    (%eax),%al
  801443:	3c 2f                	cmp    $0x2f,%al
  801445:	7e 19                	jle    801460 <strtol+0xc2>
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	8a 00                	mov    (%eax),%al
  80144c:	3c 39                	cmp    $0x39,%al
  80144e:	7f 10                	jg     801460 <strtol+0xc2>
			dig = *s - '0';
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	8a 00                	mov    (%eax),%al
  801455:	0f be c0             	movsbl %al,%eax
  801458:	83 e8 30             	sub    $0x30,%eax
  80145b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80145e:	eb 42                	jmp    8014a2 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801460:	8b 45 08             	mov    0x8(%ebp),%eax
  801463:	8a 00                	mov    (%eax),%al
  801465:	3c 60                	cmp    $0x60,%al
  801467:	7e 19                	jle    801482 <strtol+0xe4>
  801469:	8b 45 08             	mov    0x8(%ebp),%eax
  80146c:	8a 00                	mov    (%eax),%al
  80146e:	3c 7a                	cmp    $0x7a,%al
  801470:	7f 10                	jg     801482 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801472:	8b 45 08             	mov    0x8(%ebp),%eax
  801475:	8a 00                	mov    (%eax),%al
  801477:	0f be c0             	movsbl %al,%eax
  80147a:	83 e8 57             	sub    $0x57,%eax
  80147d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801480:	eb 20                	jmp    8014a2 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801482:	8b 45 08             	mov    0x8(%ebp),%eax
  801485:	8a 00                	mov    (%eax),%al
  801487:	3c 40                	cmp    $0x40,%al
  801489:	7e 39                	jle    8014c4 <strtol+0x126>
  80148b:	8b 45 08             	mov    0x8(%ebp),%eax
  80148e:	8a 00                	mov    (%eax),%al
  801490:	3c 5a                	cmp    $0x5a,%al
  801492:	7f 30                	jg     8014c4 <strtol+0x126>
			dig = *s - 'A' + 10;
  801494:	8b 45 08             	mov    0x8(%ebp),%eax
  801497:	8a 00                	mov    (%eax),%al
  801499:	0f be c0             	movsbl %al,%eax
  80149c:	83 e8 37             	sub    $0x37,%eax
  80149f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8014a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014a5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014a8:	7d 19                	jge    8014c3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014aa:	ff 45 08             	incl   0x8(%ebp)
  8014ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b0:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014b4:	89 c2                	mov    %eax,%edx
  8014b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014b9:	01 d0                	add    %edx,%eax
  8014bb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014be:	e9 7b ff ff ff       	jmp    80143e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014c3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014c4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014c8:	74 08                	je     8014d2 <strtol+0x134>
		*endptr = (char *) s;
  8014ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014cd:	8b 55 08             	mov    0x8(%ebp),%edx
  8014d0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014d2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014d6:	74 07                	je     8014df <strtol+0x141>
  8014d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014db:	f7 d8                	neg    %eax
  8014dd:	eb 03                	jmp    8014e2 <strtol+0x144>
  8014df:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014e2:	c9                   	leave  
  8014e3:	c3                   	ret    

008014e4 <ltostr>:

void
ltostr(long value, char *str)
{
  8014e4:	55                   	push   %ebp
  8014e5:	89 e5                	mov    %esp,%ebp
  8014e7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014f1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014f8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014fc:	79 13                	jns    801511 <ltostr+0x2d>
	{
		neg = 1;
  8014fe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801505:	8b 45 0c             	mov    0xc(%ebp),%eax
  801508:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80150b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80150e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801511:	8b 45 08             	mov    0x8(%ebp),%eax
  801514:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801519:	99                   	cltd   
  80151a:	f7 f9                	idiv   %ecx
  80151c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80151f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801522:	8d 50 01             	lea    0x1(%eax),%edx
  801525:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801528:	89 c2                	mov    %eax,%edx
  80152a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152d:	01 d0                	add    %edx,%eax
  80152f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801532:	83 c2 30             	add    $0x30,%edx
  801535:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801537:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80153a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80153f:	f7 e9                	imul   %ecx
  801541:	c1 fa 02             	sar    $0x2,%edx
  801544:	89 c8                	mov    %ecx,%eax
  801546:	c1 f8 1f             	sar    $0x1f,%eax
  801549:	29 c2                	sub    %eax,%edx
  80154b:	89 d0                	mov    %edx,%eax
  80154d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801550:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801553:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801558:	f7 e9                	imul   %ecx
  80155a:	c1 fa 02             	sar    $0x2,%edx
  80155d:	89 c8                	mov    %ecx,%eax
  80155f:	c1 f8 1f             	sar    $0x1f,%eax
  801562:	29 c2                	sub    %eax,%edx
  801564:	89 d0                	mov    %edx,%eax
  801566:	c1 e0 02             	shl    $0x2,%eax
  801569:	01 d0                	add    %edx,%eax
  80156b:	01 c0                	add    %eax,%eax
  80156d:	29 c1                	sub    %eax,%ecx
  80156f:	89 ca                	mov    %ecx,%edx
  801571:	85 d2                	test   %edx,%edx
  801573:	75 9c                	jne    801511 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801575:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80157c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80157f:	48                   	dec    %eax
  801580:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801583:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801587:	74 3d                	je     8015c6 <ltostr+0xe2>
		start = 1 ;
  801589:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801590:	eb 34                	jmp    8015c6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801592:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801595:	8b 45 0c             	mov    0xc(%ebp),%eax
  801598:	01 d0                	add    %edx,%eax
  80159a:	8a 00                	mov    (%eax),%al
  80159c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80159f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a5:	01 c2                	add    %eax,%edx
  8015a7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ad:	01 c8                	add    %ecx,%eax
  8015af:	8a 00                	mov    (%eax),%al
  8015b1:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015b3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b9:	01 c2                	add    %eax,%edx
  8015bb:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015be:	88 02                	mov    %al,(%edx)
		start++ ;
  8015c0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015c3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015c9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015cc:	7c c4                	jl     801592 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015ce:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d4:	01 d0                	add    %edx,%eax
  8015d6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015d9:	90                   	nop
  8015da:	c9                   	leave  
  8015db:	c3                   	ret    

008015dc <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015dc:	55                   	push   %ebp
  8015dd:	89 e5                	mov    %esp,%ebp
  8015df:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015e2:	ff 75 08             	pushl  0x8(%ebp)
  8015e5:	e8 54 fa ff ff       	call   80103e <strlen>
  8015ea:	83 c4 04             	add    $0x4,%esp
  8015ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015f0:	ff 75 0c             	pushl  0xc(%ebp)
  8015f3:	e8 46 fa ff ff       	call   80103e <strlen>
  8015f8:	83 c4 04             	add    $0x4,%esp
  8015fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801605:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80160c:	eb 17                	jmp    801625 <strcconcat+0x49>
		final[s] = str1[s] ;
  80160e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801611:	8b 45 10             	mov    0x10(%ebp),%eax
  801614:	01 c2                	add    %eax,%edx
  801616:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801619:	8b 45 08             	mov    0x8(%ebp),%eax
  80161c:	01 c8                	add    %ecx,%eax
  80161e:	8a 00                	mov    (%eax),%al
  801620:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801622:	ff 45 fc             	incl   -0x4(%ebp)
  801625:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801628:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80162b:	7c e1                	jl     80160e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80162d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801634:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80163b:	eb 1f                	jmp    80165c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80163d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801640:	8d 50 01             	lea    0x1(%eax),%edx
  801643:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801646:	89 c2                	mov    %eax,%edx
  801648:	8b 45 10             	mov    0x10(%ebp),%eax
  80164b:	01 c2                	add    %eax,%edx
  80164d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801650:	8b 45 0c             	mov    0xc(%ebp),%eax
  801653:	01 c8                	add    %ecx,%eax
  801655:	8a 00                	mov    (%eax),%al
  801657:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801659:	ff 45 f8             	incl   -0x8(%ebp)
  80165c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80165f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801662:	7c d9                	jl     80163d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801664:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801667:	8b 45 10             	mov    0x10(%ebp),%eax
  80166a:	01 d0                	add    %edx,%eax
  80166c:	c6 00 00             	movb   $0x0,(%eax)
}
  80166f:	90                   	nop
  801670:	c9                   	leave  
  801671:	c3                   	ret    

00801672 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801672:	55                   	push   %ebp
  801673:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801675:	8b 45 14             	mov    0x14(%ebp),%eax
  801678:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80167e:	8b 45 14             	mov    0x14(%ebp),%eax
  801681:	8b 00                	mov    (%eax),%eax
  801683:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80168a:	8b 45 10             	mov    0x10(%ebp),%eax
  80168d:	01 d0                	add    %edx,%eax
  80168f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801695:	eb 0c                	jmp    8016a3 <strsplit+0x31>
			*string++ = 0;
  801697:	8b 45 08             	mov    0x8(%ebp),%eax
  80169a:	8d 50 01             	lea    0x1(%eax),%edx
  80169d:	89 55 08             	mov    %edx,0x8(%ebp)
  8016a0:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a6:	8a 00                	mov    (%eax),%al
  8016a8:	84 c0                	test   %al,%al
  8016aa:	74 18                	je     8016c4 <strsplit+0x52>
  8016ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8016af:	8a 00                	mov    (%eax),%al
  8016b1:	0f be c0             	movsbl %al,%eax
  8016b4:	50                   	push   %eax
  8016b5:	ff 75 0c             	pushl  0xc(%ebp)
  8016b8:	e8 13 fb ff ff       	call   8011d0 <strchr>
  8016bd:	83 c4 08             	add    $0x8,%esp
  8016c0:	85 c0                	test   %eax,%eax
  8016c2:	75 d3                	jne    801697 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c7:	8a 00                	mov    (%eax),%al
  8016c9:	84 c0                	test   %al,%al
  8016cb:	74 5a                	je     801727 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8016d0:	8b 00                	mov    (%eax),%eax
  8016d2:	83 f8 0f             	cmp    $0xf,%eax
  8016d5:	75 07                	jne    8016de <strsplit+0x6c>
		{
			return 0;
  8016d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8016dc:	eb 66                	jmp    801744 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016de:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e1:	8b 00                	mov    (%eax),%eax
  8016e3:	8d 48 01             	lea    0x1(%eax),%ecx
  8016e6:	8b 55 14             	mov    0x14(%ebp),%edx
  8016e9:	89 0a                	mov    %ecx,(%edx)
  8016eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f5:	01 c2                	add    %eax,%edx
  8016f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fa:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016fc:	eb 03                	jmp    801701 <strsplit+0x8f>
			string++;
  8016fe:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801701:	8b 45 08             	mov    0x8(%ebp),%eax
  801704:	8a 00                	mov    (%eax),%al
  801706:	84 c0                	test   %al,%al
  801708:	74 8b                	je     801695 <strsplit+0x23>
  80170a:	8b 45 08             	mov    0x8(%ebp),%eax
  80170d:	8a 00                	mov    (%eax),%al
  80170f:	0f be c0             	movsbl %al,%eax
  801712:	50                   	push   %eax
  801713:	ff 75 0c             	pushl  0xc(%ebp)
  801716:	e8 b5 fa ff ff       	call   8011d0 <strchr>
  80171b:	83 c4 08             	add    $0x8,%esp
  80171e:	85 c0                	test   %eax,%eax
  801720:	74 dc                	je     8016fe <strsplit+0x8c>
			string++;
	}
  801722:	e9 6e ff ff ff       	jmp    801695 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801727:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801728:	8b 45 14             	mov    0x14(%ebp),%eax
  80172b:	8b 00                	mov    (%eax),%eax
  80172d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801734:	8b 45 10             	mov    0x10(%ebp),%eax
  801737:	01 d0                	add    %edx,%eax
  801739:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80173f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801744:	c9                   	leave  
  801745:	c3                   	ret    

00801746 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801746:	55                   	push   %ebp
  801747:	89 e5                	mov    %esp,%ebp
  801749:	57                   	push   %edi
  80174a:	56                   	push   %esi
  80174b:	53                   	push   %ebx
  80174c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80174f:	8b 45 08             	mov    0x8(%ebp),%eax
  801752:	8b 55 0c             	mov    0xc(%ebp),%edx
  801755:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801758:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80175b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80175e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801761:	cd 30                	int    $0x30
  801763:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801766:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801769:	83 c4 10             	add    $0x10,%esp
  80176c:	5b                   	pop    %ebx
  80176d:	5e                   	pop    %esi
  80176e:	5f                   	pop    %edi
  80176f:	5d                   	pop    %ebp
  801770:	c3                   	ret    

00801771 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
  801774:	83 ec 04             	sub    $0x4,%esp
  801777:	8b 45 10             	mov    0x10(%ebp),%eax
  80177a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80177d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801781:	8b 45 08             	mov    0x8(%ebp),%eax
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	52                   	push   %edx
  801789:	ff 75 0c             	pushl  0xc(%ebp)
  80178c:	50                   	push   %eax
  80178d:	6a 00                	push   $0x0
  80178f:	e8 b2 ff ff ff       	call   801746 <syscall>
  801794:	83 c4 18             	add    $0x18,%esp
}
  801797:	90                   	nop
  801798:	c9                   	leave  
  801799:	c3                   	ret    

0080179a <sys_cgetc>:

int
sys_cgetc(void)
{
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 01                	push   $0x1
  8017a9:	e8 98 ff ff ff       	call   801746 <syscall>
  8017ae:	83 c4 18             	add    $0x18,%esp
}
  8017b1:	c9                   	leave  
  8017b2:	c3                   	ret    

008017b3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8017b3:	55                   	push   %ebp
  8017b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8017b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	50                   	push   %eax
  8017c2:	6a 05                	push   $0x5
  8017c4:	e8 7d ff ff ff       	call   801746 <syscall>
  8017c9:	83 c4 18             	add    $0x18,%esp
}
  8017cc:	c9                   	leave  
  8017cd:	c3                   	ret    

008017ce <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017ce:	55                   	push   %ebp
  8017cf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 02                	push   $0x2
  8017dd:	e8 64 ff ff ff       	call   801746 <syscall>
  8017e2:	83 c4 18             	add    $0x18,%esp
}
  8017e5:	c9                   	leave  
  8017e6:	c3                   	ret    

008017e7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017e7:	55                   	push   %ebp
  8017e8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 03                	push   $0x3
  8017f6:	e8 4b ff ff ff       	call   801746 <syscall>
  8017fb:	83 c4 18             	add    $0x18,%esp
}
  8017fe:	c9                   	leave  
  8017ff:	c3                   	ret    

00801800 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801800:	55                   	push   %ebp
  801801:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 04                	push   $0x4
  80180f:	e8 32 ff ff ff       	call   801746 <syscall>
  801814:	83 c4 18             	add    $0x18,%esp
}
  801817:	c9                   	leave  
  801818:	c3                   	ret    

00801819 <sys_env_exit>:


void sys_env_exit(void)
{
  801819:	55                   	push   %ebp
  80181a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 06                	push   $0x6
  801828:	e8 19 ff ff ff       	call   801746 <syscall>
  80182d:	83 c4 18             	add    $0x18,%esp
}
  801830:	90                   	nop
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801836:	8b 55 0c             	mov    0xc(%ebp),%edx
  801839:	8b 45 08             	mov    0x8(%ebp),%eax
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	52                   	push   %edx
  801843:	50                   	push   %eax
  801844:	6a 07                	push   $0x7
  801846:	e8 fb fe ff ff       	call   801746 <syscall>
  80184b:	83 c4 18             	add    $0x18,%esp
}
  80184e:	c9                   	leave  
  80184f:	c3                   	ret    

00801850 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801850:	55                   	push   %ebp
  801851:	89 e5                	mov    %esp,%ebp
  801853:	56                   	push   %esi
  801854:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801855:	8b 75 18             	mov    0x18(%ebp),%esi
  801858:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80185b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80185e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801861:	8b 45 08             	mov    0x8(%ebp),%eax
  801864:	56                   	push   %esi
  801865:	53                   	push   %ebx
  801866:	51                   	push   %ecx
  801867:	52                   	push   %edx
  801868:	50                   	push   %eax
  801869:	6a 08                	push   $0x8
  80186b:	e8 d6 fe ff ff       	call   801746 <syscall>
  801870:	83 c4 18             	add    $0x18,%esp
}
  801873:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801876:	5b                   	pop    %ebx
  801877:	5e                   	pop    %esi
  801878:	5d                   	pop    %ebp
  801879:	c3                   	ret    

0080187a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80187a:	55                   	push   %ebp
  80187b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80187d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801880:	8b 45 08             	mov    0x8(%ebp),%eax
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	52                   	push   %edx
  80188a:	50                   	push   %eax
  80188b:	6a 09                	push   $0x9
  80188d:	e8 b4 fe ff ff       	call   801746 <syscall>
  801892:	83 c4 18             	add    $0x18,%esp
}
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	ff 75 0c             	pushl  0xc(%ebp)
  8018a3:	ff 75 08             	pushl  0x8(%ebp)
  8018a6:	6a 0a                	push   $0xa
  8018a8:	e8 99 fe ff ff       	call   801746 <syscall>
  8018ad:	83 c4 18             	add    $0x18,%esp
}
  8018b0:	c9                   	leave  
  8018b1:	c3                   	ret    

008018b2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8018b2:	55                   	push   %ebp
  8018b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 0b                	push   $0xb
  8018c1:	e8 80 fe ff ff       	call   801746 <syscall>
  8018c6:	83 c4 18             	add    $0x18,%esp
}
  8018c9:	c9                   	leave  
  8018ca:	c3                   	ret    

008018cb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018cb:	55                   	push   %ebp
  8018cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 0c                	push   $0xc
  8018da:	e8 67 fe ff ff       	call   801746 <syscall>
  8018df:	83 c4 18             	add    $0x18,%esp
}
  8018e2:	c9                   	leave  
  8018e3:	c3                   	ret    

008018e4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018e4:	55                   	push   %ebp
  8018e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 0d                	push   $0xd
  8018f3:	e8 4e fe ff ff       	call   801746 <syscall>
  8018f8:	83 c4 18             	add    $0x18,%esp
}
  8018fb:	c9                   	leave  
  8018fc:	c3                   	ret    

008018fd <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018fd:	55                   	push   %ebp
  8018fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	ff 75 0c             	pushl  0xc(%ebp)
  801909:	ff 75 08             	pushl  0x8(%ebp)
  80190c:	6a 11                	push   $0x11
  80190e:	e8 33 fe ff ff       	call   801746 <syscall>
  801913:	83 c4 18             	add    $0x18,%esp
	return;
  801916:	90                   	nop
}
  801917:	c9                   	leave  
  801918:	c3                   	ret    

00801919 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801919:	55                   	push   %ebp
  80191a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	ff 75 0c             	pushl  0xc(%ebp)
  801925:	ff 75 08             	pushl  0x8(%ebp)
  801928:	6a 12                	push   $0x12
  80192a:	e8 17 fe ff ff       	call   801746 <syscall>
  80192f:	83 c4 18             	add    $0x18,%esp
	return ;
  801932:	90                   	nop
}
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 0e                	push   $0xe
  801944:	e8 fd fd ff ff       	call   801746 <syscall>
  801949:	83 c4 18             	add    $0x18,%esp
}
  80194c:	c9                   	leave  
  80194d:	c3                   	ret    

0080194e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80194e:	55                   	push   %ebp
  80194f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	ff 75 08             	pushl  0x8(%ebp)
  80195c:	6a 0f                	push   $0xf
  80195e:	e8 e3 fd ff ff       	call   801746 <syscall>
  801963:	83 c4 18             	add    $0x18,%esp
}
  801966:	c9                   	leave  
  801967:	c3                   	ret    

00801968 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801968:	55                   	push   %ebp
  801969:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 10                	push   $0x10
  801977:	e8 ca fd ff ff       	call   801746 <syscall>
  80197c:	83 c4 18             	add    $0x18,%esp
}
  80197f:	90                   	nop
  801980:	c9                   	leave  
  801981:	c3                   	ret    

00801982 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801982:	55                   	push   %ebp
  801983:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 14                	push   $0x14
  801991:	e8 b0 fd ff ff       	call   801746 <syscall>
  801996:	83 c4 18             	add    $0x18,%esp
}
  801999:	90                   	nop
  80199a:	c9                   	leave  
  80199b:	c3                   	ret    

0080199c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80199c:	55                   	push   %ebp
  80199d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 15                	push   $0x15
  8019ab:	e8 96 fd ff ff       	call   801746 <syscall>
  8019b0:	83 c4 18             	add    $0x18,%esp
}
  8019b3:	90                   	nop
  8019b4:	c9                   	leave  
  8019b5:	c3                   	ret    

008019b6 <sys_cputc>:


void
sys_cputc(const char c)
{
  8019b6:	55                   	push   %ebp
  8019b7:	89 e5                	mov    %esp,%ebp
  8019b9:	83 ec 04             	sub    $0x4,%esp
  8019bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019c2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 00                	push   $0x0
  8019ce:	50                   	push   %eax
  8019cf:	6a 16                	push   $0x16
  8019d1:	e8 70 fd ff ff       	call   801746 <syscall>
  8019d6:	83 c4 18             	add    $0x18,%esp
}
  8019d9:	90                   	nop
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 17                	push   $0x17
  8019eb:	e8 56 fd ff ff       	call   801746 <syscall>
  8019f0:	83 c4 18             	add    $0x18,%esp
}
  8019f3:	90                   	nop
  8019f4:	c9                   	leave  
  8019f5:	c3                   	ret    

008019f6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019f6:	55                   	push   %ebp
  8019f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	ff 75 0c             	pushl  0xc(%ebp)
  801a05:	50                   	push   %eax
  801a06:	6a 18                	push   $0x18
  801a08:	e8 39 fd ff ff       	call   801746 <syscall>
  801a0d:	83 c4 18             	add    $0x18,%esp
}
  801a10:	c9                   	leave  
  801a11:	c3                   	ret    

00801a12 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a12:	55                   	push   %ebp
  801a13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a15:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a18:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1b:	6a 00                	push   $0x0
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	52                   	push   %edx
  801a22:	50                   	push   %eax
  801a23:	6a 1b                	push   $0x1b
  801a25:	e8 1c fd ff ff       	call   801746 <syscall>
  801a2a:	83 c4 18             	add    $0x18,%esp
}
  801a2d:	c9                   	leave  
  801a2e:	c3                   	ret    

00801a2f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a2f:	55                   	push   %ebp
  801a30:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a32:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a35:	8b 45 08             	mov    0x8(%ebp),%eax
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	52                   	push   %edx
  801a3f:	50                   	push   %eax
  801a40:	6a 19                	push   $0x19
  801a42:	e8 ff fc ff ff       	call   801746 <syscall>
  801a47:	83 c4 18             	add    $0x18,%esp
}
  801a4a:	90                   	nop
  801a4b:	c9                   	leave  
  801a4c:	c3                   	ret    

00801a4d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a4d:	55                   	push   %ebp
  801a4e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a50:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a53:	8b 45 08             	mov    0x8(%ebp),%eax
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	52                   	push   %edx
  801a5d:	50                   	push   %eax
  801a5e:	6a 1a                	push   $0x1a
  801a60:	e8 e1 fc ff ff       	call   801746 <syscall>
  801a65:	83 c4 18             	add    $0x18,%esp
}
  801a68:	90                   	nop
  801a69:	c9                   	leave  
  801a6a:	c3                   	ret    

00801a6b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a6b:	55                   	push   %ebp
  801a6c:	89 e5                	mov    %esp,%ebp
  801a6e:	83 ec 04             	sub    $0x4,%esp
  801a71:	8b 45 10             	mov    0x10(%ebp),%eax
  801a74:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a77:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a7a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a81:	6a 00                	push   $0x0
  801a83:	51                   	push   %ecx
  801a84:	52                   	push   %edx
  801a85:	ff 75 0c             	pushl  0xc(%ebp)
  801a88:	50                   	push   %eax
  801a89:	6a 1c                	push   $0x1c
  801a8b:	e8 b6 fc ff ff       	call   801746 <syscall>
  801a90:	83 c4 18             	add    $0x18,%esp
}
  801a93:	c9                   	leave  
  801a94:	c3                   	ret    

00801a95 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a95:	55                   	push   %ebp
  801a96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a98:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	52                   	push   %edx
  801aa5:	50                   	push   %eax
  801aa6:	6a 1d                	push   $0x1d
  801aa8:	e8 99 fc ff ff       	call   801746 <syscall>
  801aad:	83 c4 18             	add    $0x18,%esp
}
  801ab0:	c9                   	leave  
  801ab1:	c3                   	ret    

00801ab2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ab2:	55                   	push   %ebp
  801ab3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801ab5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ab8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801abb:	8b 45 08             	mov    0x8(%ebp),%eax
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	51                   	push   %ecx
  801ac3:	52                   	push   %edx
  801ac4:	50                   	push   %eax
  801ac5:	6a 1e                	push   $0x1e
  801ac7:	e8 7a fc ff ff       	call   801746 <syscall>
  801acc:	83 c4 18             	add    $0x18,%esp
}
  801acf:	c9                   	leave  
  801ad0:	c3                   	ret    

00801ad1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ad1:	55                   	push   %ebp
  801ad2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ad4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  801ada:	6a 00                	push   $0x0
  801adc:	6a 00                	push   $0x0
  801ade:	6a 00                	push   $0x0
  801ae0:	52                   	push   %edx
  801ae1:	50                   	push   %eax
  801ae2:	6a 1f                	push   $0x1f
  801ae4:	e8 5d fc ff ff       	call   801746 <syscall>
  801ae9:	83 c4 18             	add    $0x18,%esp
}
  801aec:	c9                   	leave  
  801aed:	c3                   	ret    

00801aee <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801aee:	55                   	push   %ebp
  801aef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 20                	push   $0x20
  801afd:	e8 44 fc ff ff       	call   801746 <syscall>
  801b02:	83 c4 18             	add    $0x18,%esp
}
  801b05:	c9                   	leave  
  801b06:	c3                   	ret    

00801b07 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801b07:	55                   	push   %ebp
  801b08:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0d:	6a 00                	push   $0x0
  801b0f:	ff 75 14             	pushl  0x14(%ebp)
  801b12:	ff 75 10             	pushl  0x10(%ebp)
  801b15:	ff 75 0c             	pushl  0xc(%ebp)
  801b18:	50                   	push   %eax
  801b19:	6a 21                	push   $0x21
  801b1b:	e8 26 fc ff ff       	call   801746 <syscall>
  801b20:	83 c4 18             	add    $0x18,%esp
}
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b28:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	50                   	push   %eax
  801b34:	6a 22                	push   $0x22
  801b36:	e8 0b fc ff ff       	call   801746 <syscall>
  801b3b:	83 c4 18             	add    $0x18,%esp
}
  801b3e:	90                   	nop
  801b3f:	c9                   	leave  
  801b40:	c3                   	ret    

00801b41 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b44:	8b 45 08             	mov    0x8(%ebp),%eax
  801b47:	6a 00                	push   $0x0
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	50                   	push   %eax
  801b50:	6a 23                	push   $0x23
  801b52:	e8 ef fb ff ff       	call   801746 <syscall>
  801b57:	83 c4 18             	add    $0x18,%esp
}
  801b5a:	90                   	nop
  801b5b:	c9                   	leave  
  801b5c:	c3                   	ret    

00801b5d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b5d:	55                   	push   %ebp
  801b5e:	89 e5                	mov    %esp,%ebp
  801b60:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b63:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b66:	8d 50 04             	lea    0x4(%eax),%edx
  801b69:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b6c:	6a 00                	push   $0x0
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 00                	push   $0x0
  801b72:	52                   	push   %edx
  801b73:	50                   	push   %eax
  801b74:	6a 24                	push   $0x24
  801b76:	e8 cb fb ff ff       	call   801746 <syscall>
  801b7b:	83 c4 18             	add    $0x18,%esp
	return result;
  801b7e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b81:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b84:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b87:	89 01                	mov    %eax,(%ecx)
  801b89:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8f:	c9                   	leave  
  801b90:	c2 04 00             	ret    $0x4

00801b93 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b93:	55                   	push   %ebp
  801b94:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	ff 75 10             	pushl  0x10(%ebp)
  801b9d:	ff 75 0c             	pushl  0xc(%ebp)
  801ba0:	ff 75 08             	pushl  0x8(%ebp)
  801ba3:	6a 13                	push   $0x13
  801ba5:	e8 9c fb ff ff       	call   801746 <syscall>
  801baa:	83 c4 18             	add    $0x18,%esp
	return ;
  801bad:	90                   	nop
}
  801bae:	c9                   	leave  
  801baf:	c3                   	ret    

00801bb0 <sys_rcr2>:
uint32 sys_rcr2()
{
  801bb0:	55                   	push   %ebp
  801bb1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 25                	push   $0x25
  801bbf:	e8 82 fb ff ff       	call   801746 <syscall>
  801bc4:	83 c4 18             	add    $0x18,%esp
}
  801bc7:	c9                   	leave  
  801bc8:	c3                   	ret    

00801bc9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801bc9:	55                   	push   %ebp
  801bca:	89 e5                	mov    %esp,%ebp
  801bcc:	83 ec 04             	sub    $0x4,%esp
  801bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801bd5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	50                   	push   %eax
  801be2:	6a 26                	push   $0x26
  801be4:	e8 5d fb ff ff       	call   801746 <syscall>
  801be9:	83 c4 18             	add    $0x18,%esp
	return ;
  801bec:	90                   	nop
}
  801bed:	c9                   	leave  
  801bee:	c3                   	ret    

00801bef <rsttst>:
void rsttst()
{
  801bef:	55                   	push   %ebp
  801bf0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bf2:	6a 00                	push   $0x0
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 28                	push   $0x28
  801bfe:	e8 43 fb ff ff       	call   801746 <syscall>
  801c03:	83 c4 18             	add    $0x18,%esp
	return ;
  801c06:	90                   	nop
}
  801c07:	c9                   	leave  
  801c08:	c3                   	ret    

00801c09 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
  801c0c:	83 ec 04             	sub    $0x4,%esp
  801c0f:	8b 45 14             	mov    0x14(%ebp),%eax
  801c12:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c15:	8b 55 18             	mov    0x18(%ebp),%edx
  801c18:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c1c:	52                   	push   %edx
  801c1d:	50                   	push   %eax
  801c1e:	ff 75 10             	pushl  0x10(%ebp)
  801c21:	ff 75 0c             	pushl  0xc(%ebp)
  801c24:	ff 75 08             	pushl  0x8(%ebp)
  801c27:	6a 27                	push   $0x27
  801c29:	e8 18 fb ff ff       	call   801746 <syscall>
  801c2e:	83 c4 18             	add    $0x18,%esp
	return ;
  801c31:	90                   	nop
}
  801c32:	c9                   	leave  
  801c33:	c3                   	ret    

00801c34 <chktst>:
void chktst(uint32 n)
{
  801c34:	55                   	push   %ebp
  801c35:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	ff 75 08             	pushl  0x8(%ebp)
  801c42:	6a 29                	push   $0x29
  801c44:	e8 fd fa ff ff       	call   801746 <syscall>
  801c49:	83 c4 18             	add    $0x18,%esp
	return ;
  801c4c:	90                   	nop
}
  801c4d:	c9                   	leave  
  801c4e:	c3                   	ret    

00801c4f <inctst>:

void inctst()
{
  801c4f:	55                   	push   %ebp
  801c50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 2a                	push   $0x2a
  801c5e:	e8 e3 fa ff ff       	call   801746 <syscall>
  801c63:	83 c4 18             	add    $0x18,%esp
	return ;
  801c66:	90                   	nop
}
  801c67:	c9                   	leave  
  801c68:	c3                   	ret    

00801c69 <gettst>:
uint32 gettst()
{
  801c69:	55                   	push   %ebp
  801c6a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 2b                	push   $0x2b
  801c78:	e8 c9 fa ff ff       	call   801746 <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
}
  801c80:	c9                   	leave  
  801c81:	c3                   	ret    

00801c82 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c82:	55                   	push   %ebp
  801c83:	89 e5                	mov    %esp,%ebp
  801c85:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 2c                	push   $0x2c
  801c94:	e8 ad fa ff ff       	call   801746 <syscall>
  801c99:	83 c4 18             	add    $0x18,%esp
  801c9c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c9f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ca3:	75 07                	jne    801cac <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801ca5:	b8 01 00 00 00       	mov    $0x1,%eax
  801caa:	eb 05                	jmp    801cb1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801cac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cb1:	c9                   	leave  
  801cb2:	c3                   	ret    

00801cb3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801cb3:	55                   	push   %ebp
  801cb4:	89 e5                	mov    %esp,%ebp
  801cb6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 2c                	push   $0x2c
  801cc5:	e8 7c fa ff ff       	call   801746 <syscall>
  801cca:	83 c4 18             	add    $0x18,%esp
  801ccd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801cd0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801cd4:	75 07                	jne    801cdd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cd6:	b8 01 00 00 00       	mov    $0x1,%eax
  801cdb:	eb 05                	jmp    801ce2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cdd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ce2:	c9                   	leave  
  801ce3:	c3                   	ret    

00801ce4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ce4:	55                   	push   %ebp
  801ce5:	89 e5                	mov    %esp,%ebp
  801ce7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cea:	6a 00                	push   $0x0
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 2c                	push   $0x2c
  801cf6:	e8 4b fa ff ff       	call   801746 <syscall>
  801cfb:	83 c4 18             	add    $0x18,%esp
  801cfe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d01:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d05:	75 07                	jne    801d0e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d07:	b8 01 00 00 00       	mov    $0x1,%eax
  801d0c:	eb 05                	jmp    801d13 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d0e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d13:	c9                   	leave  
  801d14:	c3                   	ret    

00801d15 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d15:	55                   	push   %ebp
  801d16:	89 e5                	mov    %esp,%ebp
  801d18:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	6a 2c                	push   $0x2c
  801d27:	e8 1a fa ff ff       	call   801746 <syscall>
  801d2c:	83 c4 18             	add    $0x18,%esp
  801d2f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d32:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d36:	75 07                	jne    801d3f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d38:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3d:	eb 05                	jmp    801d44 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d3f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d44:	c9                   	leave  
  801d45:	c3                   	ret    

00801d46 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d46:	55                   	push   %ebp
  801d47:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d49:	6a 00                	push   $0x0
  801d4b:	6a 00                	push   $0x0
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 00                	push   $0x0
  801d51:	ff 75 08             	pushl  0x8(%ebp)
  801d54:	6a 2d                	push   $0x2d
  801d56:	e8 eb f9 ff ff       	call   801746 <syscall>
  801d5b:	83 c4 18             	add    $0x18,%esp
	return ;
  801d5e:	90                   	nop
}
  801d5f:	c9                   	leave  
  801d60:	c3                   	ret    

00801d61 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d61:	55                   	push   %ebp
  801d62:	89 e5                	mov    %esp,%ebp
  801d64:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d65:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d68:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d71:	6a 00                	push   $0x0
  801d73:	53                   	push   %ebx
  801d74:	51                   	push   %ecx
  801d75:	52                   	push   %edx
  801d76:	50                   	push   %eax
  801d77:	6a 2e                	push   $0x2e
  801d79:	e8 c8 f9 ff ff       	call   801746 <syscall>
  801d7e:	83 c4 18             	add    $0x18,%esp
}
  801d81:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d84:	c9                   	leave  
  801d85:	c3                   	ret    

00801d86 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d86:	55                   	push   %ebp
  801d87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d89:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	52                   	push   %edx
  801d96:	50                   	push   %eax
  801d97:	6a 2f                	push   $0x2f
  801d99:	e8 a8 f9 ff ff       	call   801746 <syscall>
  801d9e:	83 c4 18             	add    $0x18,%esp
}
  801da1:	c9                   	leave  
  801da2:	c3                   	ret    

00801da3 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801da3:	55                   	push   %ebp
  801da4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 00                	push   $0x0
  801dac:	ff 75 0c             	pushl  0xc(%ebp)
  801daf:	ff 75 08             	pushl  0x8(%ebp)
  801db2:	6a 30                	push   $0x30
  801db4:	e8 8d f9 ff ff       	call   801746 <syscall>
  801db9:	83 c4 18             	add    $0x18,%esp
	return ;
  801dbc:	90                   	nop
}
  801dbd:	c9                   	leave  
  801dbe:	c3                   	ret    
  801dbf:	90                   	nop

00801dc0 <__udivdi3>:
  801dc0:	55                   	push   %ebp
  801dc1:	57                   	push   %edi
  801dc2:	56                   	push   %esi
  801dc3:	53                   	push   %ebx
  801dc4:	83 ec 1c             	sub    $0x1c,%esp
  801dc7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801dcb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801dcf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801dd3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801dd7:	89 ca                	mov    %ecx,%edx
  801dd9:	89 f8                	mov    %edi,%eax
  801ddb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ddf:	85 f6                	test   %esi,%esi
  801de1:	75 2d                	jne    801e10 <__udivdi3+0x50>
  801de3:	39 cf                	cmp    %ecx,%edi
  801de5:	77 65                	ja     801e4c <__udivdi3+0x8c>
  801de7:	89 fd                	mov    %edi,%ebp
  801de9:	85 ff                	test   %edi,%edi
  801deb:	75 0b                	jne    801df8 <__udivdi3+0x38>
  801ded:	b8 01 00 00 00       	mov    $0x1,%eax
  801df2:	31 d2                	xor    %edx,%edx
  801df4:	f7 f7                	div    %edi
  801df6:	89 c5                	mov    %eax,%ebp
  801df8:	31 d2                	xor    %edx,%edx
  801dfa:	89 c8                	mov    %ecx,%eax
  801dfc:	f7 f5                	div    %ebp
  801dfe:	89 c1                	mov    %eax,%ecx
  801e00:	89 d8                	mov    %ebx,%eax
  801e02:	f7 f5                	div    %ebp
  801e04:	89 cf                	mov    %ecx,%edi
  801e06:	89 fa                	mov    %edi,%edx
  801e08:	83 c4 1c             	add    $0x1c,%esp
  801e0b:	5b                   	pop    %ebx
  801e0c:	5e                   	pop    %esi
  801e0d:	5f                   	pop    %edi
  801e0e:	5d                   	pop    %ebp
  801e0f:	c3                   	ret    
  801e10:	39 ce                	cmp    %ecx,%esi
  801e12:	77 28                	ja     801e3c <__udivdi3+0x7c>
  801e14:	0f bd fe             	bsr    %esi,%edi
  801e17:	83 f7 1f             	xor    $0x1f,%edi
  801e1a:	75 40                	jne    801e5c <__udivdi3+0x9c>
  801e1c:	39 ce                	cmp    %ecx,%esi
  801e1e:	72 0a                	jb     801e2a <__udivdi3+0x6a>
  801e20:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e24:	0f 87 9e 00 00 00    	ja     801ec8 <__udivdi3+0x108>
  801e2a:	b8 01 00 00 00       	mov    $0x1,%eax
  801e2f:	89 fa                	mov    %edi,%edx
  801e31:	83 c4 1c             	add    $0x1c,%esp
  801e34:	5b                   	pop    %ebx
  801e35:	5e                   	pop    %esi
  801e36:	5f                   	pop    %edi
  801e37:	5d                   	pop    %ebp
  801e38:	c3                   	ret    
  801e39:	8d 76 00             	lea    0x0(%esi),%esi
  801e3c:	31 ff                	xor    %edi,%edi
  801e3e:	31 c0                	xor    %eax,%eax
  801e40:	89 fa                	mov    %edi,%edx
  801e42:	83 c4 1c             	add    $0x1c,%esp
  801e45:	5b                   	pop    %ebx
  801e46:	5e                   	pop    %esi
  801e47:	5f                   	pop    %edi
  801e48:	5d                   	pop    %ebp
  801e49:	c3                   	ret    
  801e4a:	66 90                	xchg   %ax,%ax
  801e4c:	89 d8                	mov    %ebx,%eax
  801e4e:	f7 f7                	div    %edi
  801e50:	31 ff                	xor    %edi,%edi
  801e52:	89 fa                	mov    %edi,%edx
  801e54:	83 c4 1c             	add    $0x1c,%esp
  801e57:	5b                   	pop    %ebx
  801e58:	5e                   	pop    %esi
  801e59:	5f                   	pop    %edi
  801e5a:	5d                   	pop    %ebp
  801e5b:	c3                   	ret    
  801e5c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e61:	89 eb                	mov    %ebp,%ebx
  801e63:	29 fb                	sub    %edi,%ebx
  801e65:	89 f9                	mov    %edi,%ecx
  801e67:	d3 e6                	shl    %cl,%esi
  801e69:	89 c5                	mov    %eax,%ebp
  801e6b:	88 d9                	mov    %bl,%cl
  801e6d:	d3 ed                	shr    %cl,%ebp
  801e6f:	89 e9                	mov    %ebp,%ecx
  801e71:	09 f1                	or     %esi,%ecx
  801e73:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e77:	89 f9                	mov    %edi,%ecx
  801e79:	d3 e0                	shl    %cl,%eax
  801e7b:	89 c5                	mov    %eax,%ebp
  801e7d:	89 d6                	mov    %edx,%esi
  801e7f:	88 d9                	mov    %bl,%cl
  801e81:	d3 ee                	shr    %cl,%esi
  801e83:	89 f9                	mov    %edi,%ecx
  801e85:	d3 e2                	shl    %cl,%edx
  801e87:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e8b:	88 d9                	mov    %bl,%cl
  801e8d:	d3 e8                	shr    %cl,%eax
  801e8f:	09 c2                	or     %eax,%edx
  801e91:	89 d0                	mov    %edx,%eax
  801e93:	89 f2                	mov    %esi,%edx
  801e95:	f7 74 24 0c          	divl   0xc(%esp)
  801e99:	89 d6                	mov    %edx,%esi
  801e9b:	89 c3                	mov    %eax,%ebx
  801e9d:	f7 e5                	mul    %ebp
  801e9f:	39 d6                	cmp    %edx,%esi
  801ea1:	72 19                	jb     801ebc <__udivdi3+0xfc>
  801ea3:	74 0b                	je     801eb0 <__udivdi3+0xf0>
  801ea5:	89 d8                	mov    %ebx,%eax
  801ea7:	31 ff                	xor    %edi,%edi
  801ea9:	e9 58 ff ff ff       	jmp    801e06 <__udivdi3+0x46>
  801eae:	66 90                	xchg   %ax,%ax
  801eb0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801eb4:	89 f9                	mov    %edi,%ecx
  801eb6:	d3 e2                	shl    %cl,%edx
  801eb8:	39 c2                	cmp    %eax,%edx
  801eba:	73 e9                	jae    801ea5 <__udivdi3+0xe5>
  801ebc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ebf:	31 ff                	xor    %edi,%edi
  801ec1:	e9 40 ff ff ff       	jmp    801e06 <__udivdi3+0x46>
  801ec6:	66 90                	xchg   %ax,%ax
  801ec8:	31 c0                	xor    %eax,%eax
  801eca:	e9 37 ff ff ff       	jmp    801e06 <__udivdi3+0x46>
  801ecf:	90                   	nop

00801ed0 <__umoddi3>:
  801ed0:	55                   	push   %ebp
  801ed1:	57                   	push   %edi
  801ed2:	56                   	push   %esi
  801ed3:	53                   	push   %ebx
  801ed4:	83 ec 1c             	sub    $0x1c,%esp
  801ed7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801edb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801edf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ee3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ee7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801eeb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801eef:	89 f3                	mov    %esi,%ebx
  801ef1:	89 fa                	mov    %edi,%edx
  801ef3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ef7:	89 34 24             	mov    %esi,(%esp)
  801efa:	85 c0                	test   %eax,%eax
  801efc:	75 1a                	jne    801f18 <__umoddi3+0x48>
  801efe:	39 f7                	cmp    %esi,%edi
  801f00:	0f 86 a2 00 00 00    	jbe    801fa8 <__umoddi3+0xd8>
  801f06:	89 c8                	mov    %ecx,%eax
  801f08:	89 f2                	mov    %esi,%edx
  801f0a:	f7 f7                	div    %edi
  801f0c:	89 d0                	mov    %edx,%eax
  801f0e:	31 d2                	xor    %edx,%edx
  801f10:	83 c4 1c             	add    $0x1c,%esp
  801f13:	5b                   	pop    %ebx
  801f14:	5e                   	pop    %esi
  801f15:	5f                   	pop    %edi
  801f16:	5d                   	pop    %ebp
  801f17:	c3                   	ret    
  801f18:	39 f0                	cmp    %esi,%eax
  801f1a:	0f 87 ac 00 00 00    	ja     801fcc <__umoddi3+0xfc>
  801f20:	0f bd e8             	bsr    %eax,%ebp
  801f23:	83 f5 1f             	xor    $0x1f,%ebp
  801f26:	0f 84 ac 00 00 00    	je     801fd8 <__umoddi3+0x108>
  801f2c:	bf 20 00 00 00       	mov    $0x20,%edi
  801f31:	29 ef                	sub    %ebp,%edi
  801f33:	89 fe                	mov    %edi,%esi
  801f35:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f39:	89 e9                	mov    %ebp,%ecx
  801f3b:	d3 e0                	shl    %cl,%eax
  801f3d:	89 d7                	mov    %edx,%edi
  801f3f:	89 f1                	mov    %esi,%ecx
  801f41:	d3 ef                	shr    %cl,%edi
  801f43:	09 c7                	or     %eax,%edi
  801f45:	89 e9                	mov    %ebp,%ecx
  801f47:	d3 e2                	shl    %cl,%edx
  801f49:	89 14 24             	mov    %edx,(%esp)
  801f4c:	89 d8                	mov    %ebx,%eax
  801f4e:	d3 e0                	shl    %cl,%eax
  801f50:	89 c2                	mov    %eax,%edx
  801f52:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f56:	d3 e0                	shl    %cl,%eax
  801f58:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f5c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f60:	89 f1                	mov    %esi,%ecx
  801f62:	d3 e8                	shr    %cl,%eax
  801f64:	09 d0                	or     %edx,%eax
  801f66:	d3 eb                	shr    %cl,%ebx
  801f68:	89 da                	mov    %ebx,%edx
  801f6a:	f7 f7                	div    %edi
  801f6c:	89 d3                	mov    %edx,%ebx
  801f6e:	f7 24 24             	mull   (%esp)
  801f71:	89 c6                	mov    %eax,%esi
  801f73:	89 d1                	mov    %edx,%ecx
  801f75:	39 d3                	cmp    %edx,%ebx
  801f77:	0f 82 87 00 00 00    	jb     802004 <__umoddi3+0x134>
  801f7d:	0f 84 91 00 00 00    	je     802014 <__umoddi3+0x144>
  801f83:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f87:	29 f2                	sub    %esi,%edx
  801f89:	19 cb                	sbb    %ecx,%ebx
  801f8b:	89 d8                	mov    %ebx,%eax
  801f8d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f91:	d3 e0                	shl    %cl,%eax
  801f93:	89 e9                	mov    %ebp,%ecx
  801f95:	d3 ea                	shr    %cl,%edx
  801f97:	09 d0                	or     %edx,%eax
  801f99:	89 e9                	mov    %ebp,%ecx
  801f9b:	d3 eb                	shr    %cl,%ebx
  801f9d:	89 da                	mov    %ebx,%edx
  801f9f:	83 c4 1c             	add    $0x1c,%esp
  801fa2:	5b                   	pop    %ebx
  801fa3:	5e                   	pop    %esi
  801fa4:	5f                   	pop    %edi
  801fa5:	5d                   	pop    %ebp
  801fa6:	c3                   	ret    
  801fa7:	90                   	nop
  801fa8:	89 fd                	mov    %edi,%ebp
  801faa:	85 ff                	test   %edi,%edi
  801fac:	75 0b                	jne    801fb9 <__umoddi3+0xe9>
  801fae:	b8 01 00 00 00       	mov    $0x1,%eax
  801fb3:	31 d2                	xor    %edx,%edx
  801fb5:	f7 f7                	div    %edi
  801fb7:	89 c5                	mov    %eax,%ebp
  801fb9:	89 f0                	mov    %esi,%eax
  801fbb:	31 d2                	xor    %edx,%edx
  801fbd:	f7 f5                	div    %ebp
  801fbf:	89 c8                	mov    %ecx,%eax
  801fc1:	f7 f5                	div    %ebp
  801fc3:	89 d0                	mov    %edx,%eax
  801fc5:	e9 44 ff ff ff       	jmp    801f0e <__umoddi3+0x3e>
  801fca:	66 90                	xchg   %ax,%ax
  801fcc:	89 c8                	mov    %ecx,%eax
  801fce:	89 f2                	mov    %esi,%edx
  801fd0:	83 c4 1c             	add    $0x1c,%esp
  801fd3:	5b                   	pop    %ebx
  801fd4:	5e                   	pop    %esi
  801fd5:	5f                   	pop    %edi
  801fd6:	5d                   	pop    %ebp
  801fd7:	c3                   	ret    
  801fd8:	3b 04 24             	cmp    (%esp),%eax
  801fdb:	72 06                	jb     801fe3 <__umoddi3+0x113>
  801fdd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fe1:	77 0f                	ja     801ff2 <__umoddi3+0x122>
  801fe3:	89 f2                	mov    %esi,%edx
  801fe5:	29 f9                	sub    %edi,%ecx
  801fe7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801feb:	89 14 24             	mov    %edx,(%esp)
  801fee:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ff2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ff6:	8b 14 24             	mov    (%esp),%edx
  801ff9:	83 c4 1c             	add    $0x1c,%esp
  801ffc:	5b                   	pop    %ebx
  801ffd:	5e                   	pop    %esi
  801ffe:	5f                   	pop    %edi
  801fff:	5d                   	pop    %ebp
  802000:	c3                   	ret    
  802001:	8d 76 00             	lea    0x0(%esi),%esi
  802004:	2b 04 24             	sub    (%esp),%eax
  802007:	19 fa                	sbb    %edi,%edx
  802009:	89 d1                	mov    %edx,%ecx
  80200b:	89 c6                	mov    %eax,%esi
  80200d:	e9 71 ff ff ff       	jmp    801f83 <__umoddi3+0xb3>
  802012:	66 90                	xchg   %ax,%ax
  802014:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802018:	72 ea                	jb     802004 <__umoddi3+0x134>
  80201a:	89 d9                	mov    %ebx,%ecx
  80201c:	e9 62 ff ff ff       	jmp    801f83 <__umoddi3+0xb3>
