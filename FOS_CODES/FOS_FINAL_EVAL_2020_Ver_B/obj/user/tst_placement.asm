
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
  800049:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80004f:	8b 00                	mov    (%eax),%eax
  800051:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800054:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800057:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80005c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800061:	74 14                	je     800077 <_main+0x3f>
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	68 20 20 80 00       	push   $0x802020
  80006b:	6a 10                	push   $0x10
  80006d:	68 61 20 80 00       	push   $0x802061
  800072:	e8 8b 06 00 00       	call   800702 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800077:	a1 20 30 80 00       	mov    0x803020,%eax
  80007c:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800082:	83 c0 14             	add    $0x14,%eax
  800085:	8b 00                	mov    (%eax),%eax
  800087:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80008a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80008d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800092:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800097:	74 14                	je     8000ad <_main+0x75>
  800099:	83 ec 04             	sub    $0x4,%esp
  80009c:	68 20 20 80 00       	push   $0x802020
  8000a1:	6a 11                	push   $0x11
  8000a3:	68 61 20 80 00       	push   $0x802061
  8000a8:	e8 55 06 00 00       	call   800702 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b2:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000b8:	83 c0 28             	add    $0x28,%eax
  8000bb:	8b 00                	mov    (%eax),%eax
  8000bd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000cd:	74 14                	je     8000e3 <_main+0xab>
  8000cf:	83 ec 04             	sub    $0x4,%esp
  8000d2:	68 20 20 80 00       	push   $0x802020
  8000d7:	6a 12                	push   $0x12
  8000d9:	68 61 20 80 00       	push   $0x802061
  8000de:	e8 1f 06 00 00       	call   800702 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e8:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000ee:	83 c0 3c             	add    $0x3c,%eax
  8000f1:	8b 00                	mov    (%eax),%eax
  8000f3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fe:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 20 20 80 00       	push   $0x802020
  80010d:	6a 13                	push   $0x13
  80010f:	68 61 20 80 00       	push   $0x802061
  800114:	e8 e9 05 00 00       	call   800702 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800119:	a1 20 30 80 00       	mov    0x803020,%eax
  80011e:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800124:	83 c0 50             	add    $0x50,%eax
  800127:	8b 00                	mov    (%eax),%eax
  800129:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80012c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80012f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800134:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800139:	74 14                	je     80014f <_main+0x117>
  80013b:	83 ec 04             	sub    $0x4,%esp
  80013e:	68 20 20 80 00       	push   $0x802020
  800143:	6a 14                	push   $0x14
  800145:	68 61 20 80 00       	push   $0x802061
  80014a:	e8 b3 05 00 00       	call   800702 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014f:	a1 20 30 80 00       	mov    0x803020,%eax
  800154:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80015a:	83 c0 64             	add    $0x64,%eax
  80015d:	8b 00                	mov    (%eax),%eax
  80015f:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800162:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800165:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80016a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016f:	74 14                	je     800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 20 20 80 00       	push   $0x802020
  800179:	6a 15                	push   $0x15
  80017b:	68 61 20 80 00       	push   $0x802061
  800180:	e8 7d 05 00 00       	call   800702 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x206000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800185:	a1 20 30 80 00       	mov    0x803020,%eax
  80018a:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800190:	83 c0 78             	add    $0x78,%eax
  800193:	8b 00                	mov    (%eax),%eax
  800195:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800198:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80019b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a0:	3d 00 60 20 00       	cmp    $0x206000,%eax
  8001a5:	74 14                	je     8001bb <_main+0x183>
  8001a7:	83 ec 04             	sub    $0x4,%esp
  8001aa:	68 20 20 80 00       	push   $0x802020
  8001af:	6a 16                	push   $0x16
  8001b1:	68 61 20 80 00       	push   $0x802061
  8001b6:	e8 47 05 00 00       	call   800702 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c0:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001c6:	05 8c 00 00 00       	add    $0x8c,%eax
  8001cb:	8b 00                	mov    (%eax),%eax
  8001cd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001d0:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001d3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d8:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001dd:	74 14                	je     8001f3 <_main+0x1bb>
  8001df:	83 ec 04             	sub    $0x4,%esp
  8001e2:	68 20 20 80 00       	push   $0x802020
  8001e7:	6a 17                	push   $0x17
  8001e9:	68 61 20 80 00       	push   $0x802061
  8001ee:	e8 0f 05 00 00       	call   800702 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f8:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001fe:	05 a0 00 00 00       	add    $0xa0,%eax
  800203:	8b 00                	mov    (%eax),%eax
  800205:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800208:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80020b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800210:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800215:	74 14                	je     80022b <_main+0x1f3>
  800217:	83 ec 04             	sub    $0x4,%esp
  80021a:	68 20 20 80 00       	push   $0x802020
  80021f:	6a 18                	push   $0x18
  800221:	68 61 20 80 00       	push   $0x802061
  800226:	e8 d7 04 00 00       	call   800702 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80022b:	a1 20 30 80 00       	mov    0x803020,%eax
  800230:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800236:	05 b4 00 00 00       	add    $0xb4,%eax
  80023b:	8b 00                	mov    (%eax),%eax
  80023d:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800240:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800243:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800248:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80024d:	74 14                	je     800263 <_main+0x22b>
  80024f:	83 ec 04             	sub    $0x4,%esp
  800252:	68 20 20 80 00       	push   $0x802020
  800257:	6a 19                	push   $0x19
  800259:	68 61 20 80 00       	push   $0x802061
  80025e:	e8 9f 04 00 00       	call   800702 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800263:	a1 20 30 80 00       	mov    0x803020,%eax
  800268:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80026e:	05 c8 00 00 00       	add    $0xc8,%eax
  800273:	8b 00                	mov    (%eax),%eax
  800275:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800278:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80027b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800280:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800285:	74 14                	je     80029b <_main+0x263>
  800287:	83 ec 04             	sub    $0x4,%esp
  80028a:	68 20 20 80 00       	push   $0x802020
  80028f:	6a 1a                	push   $0x1a
  800291:	68 61 20 80 00       	push   $0x802061
  800296:	e8 67 04 00 00       	call   800702 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80029b:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a0:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8002a6:	05 dc 00 00 00       	add    $0xdc,%eax
  8002ab:	8b 00                	mov    (%eax),%eax
  8002ad:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8002b0:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002b3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002b8:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8002bd:	74 14                	je     8002d3 <_main+0x29b>
  8002bf:	83 ec 04             	sub    $0x4,%esp
  8002c2:	68 20 20 80 00       	push   $0x802020
  8002c7:	6a 1b                	push   $0x1b
  8002c9:	68 61 20 80 00       	push   $0x802061
  8002ce:	e8 2f 04 00 00       	call   800702 <_panic>

		for (int k = 12; k < 20; k++)
  8002d3:	c7 45 e4 0c 00 00 00 	movl   $0xc,-0x1c(%ebp)
  8002da:	eb 38                	jmp    800314 <_main+0x2dc>
			if( myEnv->__uptr_pws[k].empty !=  1)
  8002dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e1:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
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
  800300:	68 20 20 80 00       	push   $0x802020
  800305:	6a 1f                	push   $0x1f
  800307:	68 61 20 80 00       	push   $0x802061
  80030c:	e8 f1 03 00 00       	call   800702 <_panic>
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
  80031f:	8b 80 80 52 00 00    	mov    0x5280(%eax),%eax
  800325:	83 f8 0c             	cmp    $0xc,%eax
  800328:	74 14                	je     80033e <_main+0x306>
  80032a:	83 ec 04             	sub    $0x4,%esp
  80032d:	68 78 20 80 00       	push   $0x802078
  800332:	6a 21                	push   $0x21
  800334:	68 61 20 80 00       	push   $0x802061
  800339:	e8 c4 03 00 00       	call   800702 <_panic>
		/*====================================*/
	}

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80033e:	e8 ef 15 00 00       	call   801932 <sys_pf_calculate_allocated_pages>
  800343:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int freePages = sys_calculate_free_frames();
  800346:	e8 64 15 00 00       	call   8018af <sys_calculate_free_frames>
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
  8003ba:	68 bc 20 80 00       	push   $0x8020bc
  8003bf:	e8 f5 05 00 00       	call   8009b9 <cprintf>
  8003c4:	83 c4 10             	add    $0x10,%esp
	{
		if( arr[0] !=  -1)  panic("PLACEMENT of stack page failed");
  8003c7:	8a 85 a8 ff ff fe    	mov    -0x1000058(%ebp),%al
  8003cd:	3c ff                	cmp    $0xff,%al
  8003cf:	74 14                	je     8003e5 <_main+0x3ad>
  8003d1:	83 ec 04             	sub    $0x4,%esp
  8003d4:	68 ec 20 80 00       	push   $0x8020ec
  8003d9:	6a 3e                	push   $0x3e
  8003db:	68 61 20 80 00       	push   $0x802061
  8003e0:	e8 1d 03 00 00       	call   800702 <_panic>
		if( arr[PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  8003e5:	8a 85 a8 0f 00 ff    	mov    -0xfff058(%ebp),%al
  8003eb:	3c ff                	cmp    $0xff,%al
  8003ed:	74 14                	je     800403 <_main+0x3cb>
  8003ef:	83 ec 04             	sub    $0x4,%esp
  8003f2:	68 ec 20 80 00       	push   $0x8020ec
  8003f7:	6a 3f                	push   $0x3f
  8003f9:	68 61 20 80 00       	push   $0x802061
  8003fe:	e8 ff 02 00 00       	call   800702 <_panic>

		if( arr[PAGE_SIZE*1024] !=  -1)  panic("PLACEMENT of stack page failed");
  800403:	8a 85 a8 ff 3f ff    	mov    -0xc00058(%ebp),%al
  800409:	3c ff                	cmp    $0xff,%al
  80040b:	74 14                	je     800421 <_main+0x3e9>
  80040d:	83 ec 04             	sub    $0x4,%esp
  800410:	68 ec 20 80 00       	push   $0x8020ec
  800415:	6a 41                	push   $0x41
  800417:	68 61 20 80 00       	push   $0x802061
  80041c:	e8 e1 02 00 00       	call   800702 <_panic>
		if( arr[PAGE_SIZE*1025] !=  -1)  panic("PLACEMENT of stack page failed");
  800421:	8a 85 a8 0f 40 ff    	mov    -0xbff058(%ebp),%al
  800427:	3c ff                	cmp    $0xff,%al
  800429:	74 14                	je     80043f <_main+0x407>
  80042b:	83 ec 04             	sub    $0x4,%esp
  80042e:	68 ec 20 80 00       	push   $0x8020ec
  800433:	6a 42                	push   $0x42
  800435:	68 61 20 80 00       	push   $0x802061
  80043a:	e8 c3 02 00 00       	call   800702 <_panic>

		if( arr[PAGE_SIZE*1024*2] !=  -1)  panic("PLACEMENT of stack page failed");
  80043f:	8a 85 a8 ff 7f ff    	mov    -0x800058(%ebp),%al
  800445:	3c ff                	cmp    $0xff,%al
  800447:	74 14                	je     80045d <_main+0x425>
  800449:	83 ec 04             	sub    $0x4,%esp
  80044c:	68 ec 20 80 00       	push   $0x8020ec
  800451:	6a 44                	push   $0x44
  800453:	68 61 20 80 00       	push   $0x802061
  800458:	e8 a5 02 00 00       	call   800702 <_panic>
		if( arr[PAGE_SIZE*1024*2 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  80045d:	8a 85 a8 0f 80 ff    	mov    -0x7ff058(%ebp),%al
  800463:	3c ff                	cmp    $0xff,%al
  800465:	74 14                	je     80047b <_main+0x443>
  800467:	83 ec 04             	sub    $0x4,%esp
  80046a:	68 ec 20 80 00       	push   $0x8020ec
  80046f:	6a 45                	push   $0x45
  800471:	68 61 20 80 00       	push   $0x802061
  800476:	e8 87 02 00 00       	call   800702 <_panic>


		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5) panic("new stack pages are not written to Page File");
  80047b:	e8 b2 14 00 00       	call   801932 <sys_pf_calculate_allocated_pages>
  800480:	2b 45 ac             	sub    -0x54(%ebp),%eax
  800483:	83 f8 05             	cmp    $0x5,%eax
  800486:	74 14                	je     80049c <_main+0x464>
  800488:	83 ec 04             	sub    $0x4,%esp
  80048b:	68 0c 21 80 00       	push   $0x80210c
  800490:	6a 48                	push   $0x48
  800492:	68 61 20 80 00       	push   $0x802061
  800497:	e8 66 02 00 00       	call   800702 <_panic>

		if( (freePages - sys_calculate_free_frames() ) != 9 ) panic("allocated memory size incorrect");
  80049c:	8b 5d a8             	mov    -0x58(%ebp),%ebx
  80049f:	e8 0b 14 00 00       	call   8018af <sys_calculate_free_frames>
  8004a4:	29 c3                	sub    %eax,%ebx
  8004a6:	89 d8                	mov    %ebx,%eax
  8004a8:	83 f8 09             	cmp    $0x9,%eax
  8004ab:	74 14                	je     8004c1 <_main+0x489>
  8004ad:	83 ec 04             	sub    $0x4,%esp
  8004b0:	68 3c 21 80 00       	push   $0x80213c
  8004b5:	6a 4a                	push   $0x4a
  8004b7:	68 61 20 80 00       	push   $0x802061
  8004bc:	e8 41 02 00 00       	call   800702 <_panic>
	}
	cprintf("STEP A passed: PLACEMENT fault handling works!\n\n\n");
  8004c1:	83 ec 0c             	sub    $0xc,%esp
  8004c4:	68 5c 21 80 00       	push   $0x80215c
  8004c9:	e8 eb 04 00 00       	call   8009b9 <cprintf>
  8004ce:	83 c4 10             	add    $0x10,%esp


	uint32 expectedPages[20] = {0x200000,0x201000,0x202000,0x203000,0x204000,0x205000,0x206000,0x800000,0x801000,0x802000,0x803000,0xeebfd000,0xedbfd000,0xedbfe000,0xedffd000,0xedffe000,0xee3fd000,0xee3fe000, 0, 0};
  8004d1:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  8004d7:	bb a0 22 80 00       	mov    $0x8022a0,%ebx
  8004dc:	ba 14 00 00 00       	mov    $0x14,%edx
  8004e1:	89 c7                	mov    %eax,%edi
  8004e3:	89 de                	mov    %ebx,%esi
  8004e5:	89 d1                	mov    %edx,%ecx
  8004e7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	cprintf("STEP B: checking WS entries ...\n");
  8004e9:	83 ec 0c             	sub    $0xc,%esp
  8004ec:	68 90 21 80 00       	push   $0x802190
  8004f1:	e8 c3 04 00 00       	call   8009b9 <cprintf>
  8004f6:	83 c4 10             	add    $0x10,%esp
	{
		CheckWSWithoutLastIndex(expectedPages, 20);
  8004f9:	83 ec 08             	sub    $0x8,%esp
  8004fc:	6a 14                	push   $0x14
  8004fe:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  800504:	50                   	push   %eax
  800505:	e8 6a 02 00 00       	call   800774 <CheckWSWithoutLastIndex>
  80050a:	83 c4 10             	add    $0x10,%esp
	//		if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=  0xedffd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=  0xedffe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[16].virtual_address,PAGE_SIZE) !=  0xee3fd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[17].virtual_address,PAGE_SIZE) !=  0xee3fe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
}
cprintf("STEP B passed: WS entries test are correct\n\n\n");
  80050d:	83 ec 0c             	sub    $0xc,%esp
  800510:	68 b4 21 80 00       	push   $0x8021b4
  800515:	e8 9f 04 00 00       	call   8009b9 <cprintf>
  80051a:	83 c4 10             	add    $0x10,%esp

cprintf("STEP C: checking working sets WHEN BECOMES FULL...\n");
  80051d:	83 ec 0c             	sub    $0xc,%esp
  800520:	68 e4 21 80 00       	push   $0x8021e4
  800525:	e8 8f 04 00 00       	call   8009b9 <cprintf>
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
  80055d:	68 ec 20 80 00       	push   $0x8020ec
  800562:	6a 73                	push   $0x73
  800564:	68 61 20 80 00       	push   $0x802061
  800569:	e8 94 01 00 00       	call   800702 <_panic>
	if( arr[PAGE_SIZE*1024*3 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  80056e:	8a 85 a8 0f c0 ff    	mov    -0x3ff058(%ebp),%al
  800574:	3c ff                	cmp    $0xff,%al
  800576:	74 14                	je     80058c <_main+0x554>
  800578:	83 ec 04             	sub    $0x4,%esp
  80057b:	68 ec 20 80 00       	push   $0x8020ec
  800580:	6a 74                	push   $0x74
  800582:	68 61 20 80 00       	push   $0x802061
  800587:	e8 76 01 00 00       	call   800702 <_panic>

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
  8005ac:	e8 c3 01 00 00       	call   800774 <CheckWSWithoutLastIndex>
  8005b1:	83 c4 10             	add    $0x10,%esp

	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 0) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

}
cprintf("STEP C passed: WS is FULL now\n\n\n");
  8005b4:	83 ec 0c             	sub    $0xc,%esp
  8005b7:	68 18 22 80 00       	push   $0x802218
  8005bc:	e8 f8 03 00 00       	call   8009b9 <cprintf>
  8005c1:	83 c4 10             	add    $0x10,%esp

cprintf("Congratulations!! Test of PAGE PLACEMENT completed successfully!!\n\n\n");
  8005c4:	83 ec 0c             	sub    $0xc,%esp
  8005c7:	68 3c 22 80 00       	push   $0x80223c
  8005cc:	e8 e8 03 00 00       	call   8009b9 <cprintf>
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
  8005e3:	e8 fc 11 00 00       	call   8017e4 <sys_getenvindex>
  8005e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005ee:	89 d0                	mov    %edx,%eax
  8005f0:	c1 e0 03             	shl    $0x3,%eax
  8005f3:	01 d0                	add    %edx,%eax
  8005f5:	c1 e0 02             	shl    $0x2,%eax
  8005f8:	01 d0                	add    %edx,%eax
  8005fa:	c1 e0 06             	shl    $0x6,%eax
  8005fd:	29 d0                	sub    %edx,%eax
  8005ff:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800606:	01 c8                	add    %ecx,%eax
  800608:	01 d0                	add    %edx,%eax
  80060a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80060f:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800614:	a1 20 30 80 00       	mov    0x803020,%eax
  800619:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  80061f:	84 c0                	test   %al,%al
  800621:	74 0f                	je     800632 <libmain+0x55>
		binaryname = myEnv->prog_name;
  800623:	a1 20 30 80 00       	mov    0x803020,%eax
  800628:	05 b0 52 00 00       	add    $0x52b0,%eax
  80062d:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800632:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800636:	7e 0a                	jle    800642 <libmain+0x65>
		binaryname = argv[0];
  800638:	8b 45 0c             	mov    0xc(%ebp),%eax
  80063b:	8b 00                	mov    (%eax),%eax
  80063d:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800642:	83 ec 08             	sub    $0x8,%esp
  800645:	ff 75 0c             	pushl  0xc(%ebp)
  800648:	ff 75 08             	pushl  0x8(%ebp)
  80064b:	e8 e8 f9 ff ff       	call   800038 <_main>
  800650:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800653:	e8 27 13 00 00       	call   80197f <sys_disable_interrupt>
	cprintf("**************************************\n");
  800658:	83 ec 0c             	sub    $0xc,%esp
  80065b:	68 08 23 80 00       	push   $0x802308
  800660:	e8 54 03 00 00       	call   8009b9 <cprintf>
  800665:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800668:	a1 20 30 80 00       	mov    0x803020,%eax
  80066d:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800673:	a1 20 30 80 00       	mov    0x803020,%eax
  800678:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  80067e:	83 ec 04             	sub    $0x4,%esp
  800681:	52                   	push   %edx
  800682:	50                   	push   %eax
  800683:	68 30 23 80 00       	push   $0x802330
  800688:	e8 2c 03 00 00       	call   8009b9 <cprintf>
  80068d:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800690:	a1 20 30 80 00       	mov    0x803020,%eax
  800695:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  80069b:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a0:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  8006a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ab:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  8006b1:	51                   	push   %ecx
  8006b2:	52                   	push   %edx
  8006b3:	50                   	push   %eax
  8006b4:	68 58 23 80 00       	push   $0x802358
  8006b9:	e8 fb 02 00 00       	call   8009b9 <cprintf>
  8006be:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006c1:	83 ec 0c             	sub    $0xc,%esp
  8006c4:	68 08 23 80 00       	push   $0x802308
  8006c9:	e8 eb 02 00 00       	call   8009b9 <cprintf>
  8006ce:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006d1:	e8 c3 12 00 00       	call   801999 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006d6:	e8 19 00 00 00       	call   8006f4 <exit>
}
  8006db:	90                   	nop
  8006dc:	c9                   	leave  
  8006dd:	c3                   	ret    

008006de <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006de:	55                   	push   %ebp
  8006df:	89 e5                	mov    %esp,%ebp
  8006e1:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006e4:	83 ec 0c             	sub    $0xc,%esp
  8006e7:	6a 00                	push   $0x0
  8006e9:	e8 c2 10 00 00       	call   8017b0 <sys_env_destroy>
  8006ee:	83 c4 10             	add    $0x10,%esp
}
  8006f1:	90                   	nop
  8006f2:	c9                   	leave  
  8006f3:	c3                   	ret    

008006f4 <exit>:

void
exit(void)
{
  8006f4:	55                   	push   %ebp
  8006f5:	89 e5                	mov    %esp,%ebp
  8006f7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006fa:	e8 17 11 00 00       	call   801816 <sys_env_exit>
}
  8006ff:	90                   	nop
  800700:	c9                   	leave  
  800701:	c3                   	ret    

00800702 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800702:	55                   	push   %ebp
  800703:	89 e5                	mov    %esp,%ebp
  800705:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800708:	8d 45 10             	lea    0x10(%ebp),%eax
  80070b:	83 c0 04             	add    $0x4,%eax
  80070e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800711:	a1 18 31 80 00       	mov    0x803118,%eax
  800716:	85 c0                	test   %eax,%eax
  800718:	74 16                	je     800730 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80071a:	a1 18 31 80 00       	mov    0x803118,%eax
  80071f:	83 ec 08             	sub    $0x8,%esp
  800722:	50                   	push   %eax
  800723:	68 b0 23 80 00       	push   $0x8023b0
  800728:	e8 8c 02 00 00       	call   8009b9 <cprintf>
  80072d:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800730:	a1 00 30 80 00       	mov    0x803000,%eax
  800735:	ff 75 0c             	pushl  0xc(%ebp)
  800738:	ff 75 08             	pushl  0x8(%ebp)
  80073b:	50                   	push   %eax
  80073c:	68 b5 23 80 00       	push   $0x8023b5
  800741:	e8 73 02 00 00       	call   8009b9 <cprintf>
  800746:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800749:	8b 45 10             	mov    0x10(%ebp),%eax
  80074c:	83 ec 08             	sub    $0x8,%esp
  80074f:	ff 75 f4             	pushl  -0xc(%ebp)
  800752:	50                   	push   %eax
  800753:	e8 f6 01 00 00       	call   80094e <vcprintf>
  800758:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80075b:	83 ec 08             	sub    $0x8,%esp
  80075e:	6a 00                	push   $0x0
  800760:	68 d1 23 80 00       	push   $0x8023d1
  800765:	e8 e4 01 00 00       	call   80094e <vcprintf>
  80076a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80076d:	e8 82 ff ff ff       	call   8006f4 <exit>

	// should not return here
	while (1) ;
  800772:	eb fe                	jmp    800772 <_panic+0x70>

00800774 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800774:	55                   	push   %ebp
  800775:	89 e5                	mov    %esp,%ebp
  800777:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80077a:	a1 20 30 80 00       	mov    0x803020,%eax
  80077f:	8b 50 74             	mov    0x74(%eax),%edx
  800782:	8b 45 0c             	mov    0xc(%ebp),%eax
  800785:	39 c2                	cmp    %eax,%edx
  800787:	74 14                	je     80079d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800789:	83 ec 04             	sub    $0x4,%esp
  80078c:	68 d4 23 80 00       	push   $0x8023d4
  800791:	6a 26                	push   $0x26
  800793:	68 20 24 80 00       	push   $0x802420
  800798:	e8 65 ff ff ff       	call   800702 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80079d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007a4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007ab:	e9 c4 00 00 00       	jmp    800874 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8007b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bd:	01 d0                	add    %edx,%eax
  8007bf:	8b 00                	mov    (%eax),%eax
  8007c1:	85 c0                	test   %eax,%eax
  8007c3:	75 08                	jne    8007cd <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007c5:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007c8:	e9 a4 00 00 00       	jmp    800871 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8007cd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007d4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007db:	eb 6b                	jmp    800848 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e2:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8007e8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007eb:	89 d0                	mov    %edx,%eax
  8007ed:	c1 e0 02             	shl    $0x2,%eax
  8007f0:	01 d0                	add    %edx,%eax
  8007f2:	c1 e0 02             	shl    $0x2,%eax
  8007f5:	01 c8                	add    %ecx,%eax
  8007f7:	8a 40 04             	mov    0x4(%eax),%al
  8007fa:	84 c0                	test   %al,%al
  8007fc:	75 47                	jne    800845 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800803:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800809:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80080c:	89 d0                	mov    %edx,%eax
  80080e:	c1 e0 02             	shl    $0x2,%eax
  800811:	01 d0                	add    %edx,%eax
  800813:	c1 e0 02             	shl    $0x2,%eax
  800816:	01 c8                	add    %ecx,%eax
  800818:	8b 00                	mov    (%eax),%eax
  80081a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80081d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800820:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800825:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800827:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80082a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800831:	8b 45 08             	mov    0x8(%ebp),%eax
  800834:	01 c8                	add    %ecx,%eax
  800836:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800838:	39 c2                	cmp    %eax,%edx
  80083a:	75 09                	jne    800845 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80083c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800843:	eb 12                	jmp    800857 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800845:	ff 45 e8             	incl   -0x18(%ebp)
  800848:	a1 20 30 80 00       	mov    0x803020,%eax
  80084d:	8b 50 74             	mov    0x74(%eax),%edx
  800850:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800853:	39 c2                	cmp    %eax,%edx
  800855:	77 86                	ja     8007dd <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800857:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80085b:	75 14                	jne    800871 <CheckWSWithoutLastIndex+0xfd>
			panic(
  80085d:	83 ec 04             	sub    $0x4,%esp
  800860:	68 2c 24 80 00       	push   $0x80242c
  800865:	6a 3a                	push   $0x3a
  800867:	68 20 24 80 00       	push   $0x802420
  80086c:	e8 91 fe ff ff       	call   800702 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800871:	ff 45 f0             	incl   -0x10(%ebp)
  800874:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800877:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80087a:	0f 8c 30 ff ff ff    	jl     8007b0 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800880:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800887:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80088e:	eb 27                	jmp    8008b7 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800890:	a1 20 30 80 00       	mov    0x803020,%eax
  800895:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80089b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80089e:	89 d0                	mov    %edx,%eax
  8008a0:	c1 e0 02             	shl    $0x2,%eax
  8008a3:	01 d0                	add    %edx,%eax
  8008a5:	c1 e0 02             	shl    $0x2,%eax
  8008a8:	01 c8                	add    %ecx,%eax
  8008aa:	8a 40 04             	mov    0x4(%eax),%al
  8008ad:	3c 01                	cmp    $0x1,%al
  8008af:	75 03                	jne    8008b4 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8008b1:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008b4:	ff 45 e0             	incl   -0x20(%ebp)
  8008b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8008bc:	8b 50 74             	mov    0x74(%eax),%edx
  8008bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c2:	39 c2                	cmp    %eax,%edx
  8008c4:	77 ca                	ja     800890 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008c9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008cc:	74 14                	je     8008e2 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8008ce:	83 ec 04             	sub    $0x4,%esp
  8008d1:	68 80 24 80 00       	push   $0x802480
  8008d6:	6a 44                	push   $0x44
  8008d8:	68 20 24 80 00       	push   $0x802420
  8008dd:	e8 20 fe ff ff       	call   800702 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008e2:	90                   	nop
  8008e3:	c9                   	leave  
  8008e4:	c3                   	ret    

008008e5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008e5:	55                   	push   %ebp
  8008e6:	89 e5                	mov    %esp,%ebp
  8008e8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ee:	8b 00                	mov    (%eax),%eax
  8008f0:	8d 48 01             	lea    0x1(%eax),%ecx
  8008f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f6:	89 0a                	mov    %ecx,(%edx)
  8008f8:	8b 55 08             	mov    0x8(%ebp),%edx
  8008fb:	88 d1                	mov    %dl,%cl
  8008fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800900:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800904:	8b 45 0c             	mov    0xc(%ebp),%eax
  800907:	8b 00                	mov    (%eax),%eax
  800909:	3d ff 00 00 00       	cmp    $0xff,%eax
  80090e:	75 2c                	jne    80093c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800910:	a0 24 30 80 00       	mov    0x803024,%al
  800915:	0f b6 c0             	movzbl %al,%eax
  800918:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091b:	8b 12                	mov    (%edx),%edx
  80091d:	89 d1                	mov    %edx,%ecx
  80091f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800922:	83 c2 08             	add    $0x8,%edx
  800925:	83 ec 04             	sub    $0x4,%esp
  800928:	50                   	push   %eax
  800929:	51                   	push   %ecx
  80092a:	52                   	push   %edx
  80092b:	e8 3e 0e 00 00       	call   80176e <sys_cputs>
  800930:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800933:	8b 45 0c             	mov    0xc(%ebp),%eax
  800936:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80093c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093f:	8b 40 04             	mov    0x4(%eax),%eax
  800942:	8d 50 01             	lea    0x1(%eax),%edx
  800945:	8b 45 0c             	mov    0xc(%ebp),%eax
  800948:	89 50 04             	mov    %edx,0x4(%eax)
}
  80094b:	90                   	nop
  80094c:	c9                   	leave  
  80094d:	c3                   	ret    

0080094e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80094e:	55                   	push   %ebp
  80094f:	89 e5                	mov    %esp,%ebp
  800951:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800957:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80095e:	00 00 00 
	b.cnt = 0;
  800961:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800968:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80096b:	ff 75 0c             	pushl  0xc(%ebp)
  80096e:	ff 75 08             	pushl  0x8(%ebp)
  800971:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800977:	50                   	push   %eax
  800978:	68 e5 08 80 00       	push   $0x8008e5
  80097d:	e8 11 02 00 00       	call   800b93 <vprintfmt>
  800982:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800985:	a0 24 30 80 00       	mov    0x803024,%al
  80098a:	0f b6 c0             	movzbl %al,%eax
  80098d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800993:	83 ec 04             	sub    $0x4,%esp
  800996:	50                   	push   %eax
  800997:	52                   	push   %edx
  800998:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80099e:	83 c0 08             	add    $0x8,%eax
  8009a1:	50                   	push   %eax
  8009a2:	e8 c7 0d 00 00       	call   80176e <sys_cputs>
  8009a7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009aa:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009b1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009b7:	c9                   	leave  
  8009b8:	c3                   	ret    

008009b9 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009b9:	55                   	push   %ebp
  8009ba:	89 e5                	mov    %esp,%ebp
  8009bc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009bf:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009c6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cf:	83 ec 08             	sub    $0x8,%esp
  8009d2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d5:	50                   	push   %eax
  8009d6:	e8 73 ff ff ff       	call   80094e <vcprintf>
  8009db:	83 c4 10             	add    $0x10,%esp
  8009de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009e4:	c9                   	leave  
  8009e5:	c3                   	ret    

008009e6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009e6:	55                   	push   %ebp
  8009e7:	89 e5                	mov    %esp,%ebp
  8009e9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009ec:	e8 8e 0f 00 00       	call   80197f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009f1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fa:	83 ec 08             	sub    $0x8,%esp
  8009fd:	ff 75 f4             	pushl  -0xc(%ebp)
  800a00:	50                   	push   %eax
  800a01:	e8 48 ff ff ff       	call   80094e <vcprintf>
  800a06:	83 c4 10             	add    $0x10,%esp
  800a09:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a0c:	e8 88 0f 00 00       	call   801999 <sys_enable_interrupt>
	return cnt;
  800a11:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a14:	c9                   	leave  
  800a15:	c3                   	ret    

00800a16 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a16:	55                   	push   %ebp
  800a17:	89 e5                	mov    %esp,%ebp
  800a19:	53                   	push   %ebx
  800a1a:	83 ec 14             	sub    $0x14,%esp
  800a1d:	8b 45 10             	mov    0x10(%ebp),%eax
  800a20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a23:	8b 45 14             	mov    0x14(%ebp),%eax
  800a26:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a29:	8b 45 18             	mov    0x18(%ebp),%eax
  800a2c:	ba 00 00 00 00       	mov    $0x0,%edx
  800a31:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a34:	77 55                	ja     800a8b <printnum+0x75>
  800a36:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a39:	72 05                	jb     800a40 <printnum+0x2a>
  800a3b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a3e:	77 4b                	ja     800a8b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a40:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a43:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a46:	8b 45 18             	mov    0x18(%ebp),%eax
  800a49:	ba 00 00 00 00       	mov    $0x0,%edx
  800a4e:	52                   	push   %edx
  800a4f:	50                   	push   %eax
  800a50:	ff 75 f4             	pushl  -0xc(%ebp)
  800a53:	ff 75 f0             	pushl  -0x10(%ebp)
  800a56:	e8 61 13 00 00       	call   801dbc <__udivdi3>
  800a5b:	83 c4 10             	add    $0x10,%esp
  800a5e:	83 ec 04             	sub    $0x4,%esp
  800a61:	ff 75 20             	pushl  0x20(%ebp)
  800a64:	53                   	push   %ebx
  800a65:	ff 75 18             	pushl  0x18(%ebp)
  800a68:	52                   	push   %edx
  800a69:	50                   	push   %eax
  800a6a:	ff 75 0c             	pushl  0xc(%ebp)
  800a6d:	ff 75 08             	pushl  0x8(%ebp)
  800a70:	e8 a1 ff ff ff       	call   800a16 <printnum>
  800a75:	83 c4 20             	add    $0x20,%esp
  800a78:	eb 1a                	jmp    800a94 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a7a:	83 ec 08             	sub    $0x8,%esp
  800a7d:	ff 75 0c             	pushl  0xc(%ebp)
  800a80:	ff 75 20             	pushl  0x20(%ebp)
  800a83:	8b 45 08             	mov    0x8(%ebp),%eax
  800a86:	ff d0                	call   *%eax
  800a88:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a8b:	ff 4d 1c             	decl   0x1c(%ebp)
  800a8e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a92:	7f e6                	jg     800a7a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a94:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a97:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a9f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aa2:	53                   	push   %ebx
  800aa3:	51                   	push   %ecx
  800aa4:	52                   	push   %edx
  800aa5:	50                   	push   %eax
  800aa6:	e8 21 14 00 00       	call   801ecc <__umoddi3>
  800aab:	83 c4 10             	add    $0x10,%esp
  800aae:	05 f4 26 80 00       	add    $0x8026f4,%eax
  800ab3:	8a 00                	mov    (%eax),%al
  800ab5:	0f be c0             	movsbl %al,%eax
  800ab8:	83 ec 08             	sub    $0x8,%esp
  800abb:	ff 75 0c             	pushl  0xc(%ebp)
  800abe:	50                   	push   %eax
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	ff d0                	call   *%eax
  800ac4:	83 c4 10             	add    $0x10,%esp
}
  800ac7:	90                   	nop
  800ac8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800acb:	c9                   	leave  
  800acc:	c3                   	ret    

00800acd <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800acd:	55                   	push   %ebp
  800ace:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ad0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ad4:	7e 1c                	jle    800af2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad9:	8b 00                	mov    (%eax),%eax
  800adb:	8d 50 08             	lea    0x8(%eax),%edx
  800ade:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae1:	89 10                	mov    %edx,(%eax)
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	8b 00                	mov    (%eax),%eax
  800ae8:	83 e8 08             	sub    $0x8,%eax
  800aeb:	8b 50 04             	mov    0x4(%eax),%edx
  800aee:	8b 00                	mov    (%eax),%eax
  800af0:	eb 40                	jmp    800b32 <getuint+0x65>
	else if (lflag)
  800af2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800af6:	74 1e                	je     800b16 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	8b 00                	mov    (%eax),%eax
  800afd:	8d 50 04             	lea    0x4(%eax),%edx
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	89 10                	mov    %edx,(%eax)
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	8b 00                	mov    (%eax),%eax
  800b0a:	83 e8 04             	sub    $0x4,%eax
  800b0d:	8b 00                	mov    (%eax),%eax
  800b0f:	ba 00 00 00 00       	mov    $0x0,%edx
  800b14:	eb 1c                	jmp    800b32 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b16:	8b 45 08             	mov    0x8(%ebp),%eax
  800b19:	8b 00                	mov    (%eax),%eax
  800b1b:	8d 50 04             	lea    0x4(%eax),%edx
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	89 10                	mov    %edx,(%eax)
  800b23:	8b 45 08             	mov    0x8(%ebp),%eax
  800b26:	8b 00                	mov    (%eax),%eax
  800b28:	83 e8 04             	sub    $0x4,%eax
  800b2b:	8b 00                	mov    (%eax),%eax
  800b2d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b32:	5d                   	pop    %ebp
  800b33:	c3                   	ret    

00800b34 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b34:	55                   	push   %ebp
  800b35:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b37:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b3b:	7e 1c                	jle    800b59 <getint+0x25>
		return va_arg(*ap, long long);
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	8b 00                	mov    (%eax),%eax
  800b42:	8d 50 08             	lea    0x8(%eax),%edx
  800b45:	8b 45 08             	mov    0x8(%ebp),%eax
  800b48:	89 10                	mov    %edx,(%eax)
  800b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4d:	8b 00                	mov    (%eax),%eax
  800b4f:	83 e8 08             	sub    $0x8,%eax
  800b52:	8b 50 04             	mov    0x4(%eax),%edx
  800b55:	8b 00                	mov    (%eax),%eax
  800b57:	eb 38                	jmp    800b91 <getint+0x5d>
	else if (lflag)
  800b59:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b5d:	74 1a                	je     800b79 <getint+0x45>
		return va_arg(*ap, long);
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	8b 00                	mov    (%eax),%eax
  800b64:	8d 50 04             	lea    0x4(%eax),%edx
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	89 10                	mov    %edx,(%eax)
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	8b 00                	mov    (%eax),%eax
  800b71:	83 e8 04             	sub    $0x4,%eax
  800b74:	8b 00                	mov    (%eax),%eax
  800b76:	99                   	cltd   
  800b77:	eb 18                	jmp    800b91 <getint+0x5d>
	else
		return va_arg(*ap, int);
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
}
  800b91:	5d                   	pop    %ebp
  800b92:	c3                   	ret    

00800b93 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b93:	55                   	push   %ebp
  800b94:	89 e5                	mov    %esp,%ebp
  800b96:	56                   	push   %esi
  800b97:	53                   	push   %ebx
  800b98:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b9b:	eb 17                	jmp    800bb4 <vprintfmt+0x21>
			if (ch == '\0')
  800b9d:	85 db                	test   %ebx,%ebx
  800b9f:	0f 84 af 03 00 00    	je     800f54 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ba5:	83 ec 08             	sub    $0x8,%esp
  800ba8:	ff 75 0c             	pushl  0xc(%ebp)
  800bab:	53                   	push   %ebx
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	ff d0                	call   *%eax
  800bb1:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb7:	8d 50 01             	lea    0x1(%eax),%edx
  800bba:	89 55 10             	mov    %edx,0x10(%ebp)
  800bbd:	8a 00                	mov    (%eax),%al
  800bbf:	0f b6 d8             	movzbl %al,%ebx
  800bc2:	83 fb 25             	cmp    $0x25,%ebx
  800bc5:	75 d6                	jne    800b9d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bc7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bcb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bd2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bd9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800be0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800be7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bea:	8d 50 01             	lea    0x1(%eax),%edx
  800bed:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf0:	8a 00                	mov    (%eax),%al
  800bf2:	0f b6 d8             	movzbl %al,%ebx
  800bf5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bf8:	83 f8 55             	cmp    $0x55,%eax
  800bfb:	0f 87 2b 03 00 00    	ja     800f2c <vprintfmt+0x399>
  800c01:	8b 04 85 18 27 80 00 	mov    0x802718(,%eax,4),%eax
  800c08:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c0a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c0e:	eb d7                	jmp    800be7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c10:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c14:	eb d1                	jmp    800be7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c16:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c1d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c20:	89 d0                	mov    %edx,%eax
  800c22:	c1 e0 02             	shl    $0x2,%eax
  800c25:	01 d0                	add    %edx,%eax
  800c27:	01 c0                	add    %eax,%eax
  800c29:	01 d8                	add    %ebx,%eax
  800c2b:	83 e8 30             	sub    $0x30,%eax
  800c2e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c31:	8b 45 10             	mov    0x10(%ebp),%eax
  800c34:	8a 00                	mov    (%eax),%al
  800c36:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c39:	83 fb 2f             	cmp    $0x2f,%ebx
  800c3c:	7e 3e                	jle    800c7c <vprintfmt+0xe9>
  800c3e:	83 fb 39             	cmp    $0x39,%ebx
  800c41:	7f 39                	jg     800c7c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c43:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c46:	eb d5                	jmp    800c1d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c48:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4b:	83 c0 04             	add    $0x4,%eax
  800c4e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c51:	8b 45 14             	mov    0x14(%ebp),%eax
  800c54:	83 e8 04             	sub    $0x4,%eax
  800c57:	8b 00                	mov    (%eax),%eax
  800c59:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c5c:	eb 1f                	jmp    800c7d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c5e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c62:	79 83                	jns    800be7 <vprintfmt+0x54>
				width = 0;
  800c64:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c6b:	e9 77 ff ff ff       	jmp    800be7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c70:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c77:	e9 6b ff ff ff       	jmp    800be7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c7c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c7d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c81:	0f 89 60 ff ff ff    	jns    800be7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c87:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c8a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c8d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c94:	e9 4e ff ff ff       	jmp    800be7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c99:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c9c:	e9 46 ff ff ff       	jmp    800be7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ca1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca4:	83 c0 04             	add    $0x4,%eax
  800ca7:	89 45 14             	mov    %eax,0x14(%ebp)
  800caa:	8b 45 14             	mov    0x14(%ebp),%eax
  800cad:	83 e8 04             	sub    $0x4,%eax
  800cb0:	8b 00                	mov    (%eax),%eax
  800cb2:	83 ec 08             	sub    $0x8,%esp
  800cb5:	ff 75 0c             	pushl  0xc(%ebp)
  800cb8:	50                   	push   %eax
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	ff d0                	call   *%eax
  800cbe:	83 c4 10             	add    $0x10,%esp
			break;
  800cc1:	e9 89 02 00 00       	jmp    800f4f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cc6:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc9:	83 c0 04             	add    $0x4,%eax
  800ccc:	89 45 14             	mov    %eax,0x14(%ebp)
  800ccf:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd2:	83 e8 04             	sub    $0x4,%eax
  800cd5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cd7:	85 db                	test   %ebx,%ebx
  800cd9:	79 02                	jns    800cdd <vprintfmt+0x14a>
				err = -err;
  800cdb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cdd:	83 fb 64             	cmp    $0x64,%ebx
  800ce0:	7f 0b                	jg     800ced <vprintfmt+0x15a>
  800ce2:	8b 34 9d 60 25 80 00 	mov    0x802560(,%ebx,4),%esi
  800ce9:	85 f6                	test   %esi,%esi
  800ceb:	75 19                	jne    800d06 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ced:	53                   	push   %ebx
  800cee:	68 05 27 80 00       	push   $0x802705
  800cf3:	ff 75 0c             	pushl  0xc(%ebp)
  800cf6:	ff 75 08             	pushl  0x8(%ebp)
  800cf9:	e8 5e 02 00 00       	call   800f5c <printfmt>
  800cfe:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d01:	e9 49 02 00 00       	jmp    800f4f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d06:	56                   	push   %esi
  800d07:	68 0e 27 80 00       	push   $0x80270e
  800d0c:	ff 75 0c             	pushl  0xc(%ebp)
  800d0f:	ff 75 08             	pushl  0x8(%ebp)
  800d12:	e8 45 02 00 00       	call   800f5c <printfmt>
  800d17:	83 c4 10             	add    $0x10,%esp
			break;
  800d1a:	e9 30 02 00 00       	jmp    800f4f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d22:	83 c0 04             	add    $0x4,%eax
  800d25:	89 45 14             	mov    %eax,0x14(%ebp)
  800d28:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2b:	83 e8 04             	sub    $0x4,%eax
  800d2e:	8b 30                	mov    (%eax),%esi
  800d30:	85 f6                	test   %esi,%esi
  800d32:	75 05                	jne    800d39 <vprintfmt+0x1a6>
				p = "(null)";
  800d34:	be 11 27 80 00       	mov    $0x802711,%esi
			if (width > 0 && padc != '-')
  800d39:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d3d:	7e 6d                	jle    800dac <vprintfmt+0x219>
  800d3f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d43:	74 67                	je     800dac <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d45:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d48:	83 ec 08             	sub    $0x8,%esp
  800d4b:	50                   	push   %eax
  800d4c:	56                   	push   %esi
  800d4d:	e8 0c 03 00 00       	call   80105e <strnlen>
  800d52:	83 c4 10             	add    $0x10,%esp
  800d55:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d58:	eb 16                	jmp    800d70 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d5a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d5e:	83 ec 08             	sub    $0x8,%esp
  800d61:	ff 75 0c             	pushl  0xc(%ebp)
  800d64:	50                   	push   %eax
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	ff d0                	call   *%eax
  800d6a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d6d:	ff 4d e4             	decl   -0x1c(%ebp)
  800d70:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d74:	7f e4                	jg     800d5a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d76:	eb 34                	jmp    800dac <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d78:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d7c:	74 1c                	je     800d9a <vprintfmt+0x207>
  800d7e:	83 fb 1f             	cmp    $0x1f,%ebx
  800d81:	7e 05                	jle    800d88 <vprintfmt+0x1f5>
  800d83:	83 fb 7e             	cmp    $0x7e,%ebx
  800d86:	7e 12                	jle    800d9a <vprintfmt+0x207>
					putch('?', putdat);
  800d88:	83 ec 08             	sub    $0x8,%esp
  800d8b:	ff 75 0c             	pushl  0xc(%ebp)
  800d8e:	6a 3f                	push   $0x3f
  800d90:	8b 45 08             	mov    0x8(%ebp),%eax
  800d93:	ff d0                	call   *%eax
  800d95:	83 c4 10             	add    $0x10,%esp
  800d98:	eb 0f                	jmp    800da9 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d9a:	83 ec 08             	sub    $0x8,%esp
  800d9d:	ff 75 0c             	pushl  0xc(%ebp)
  800da0:	53                   	push   %ebx
  800da1:	8b 45 08             	mov    0x8(%ebp),%eax
  800da4:	ff d0                	call   *%eax
  800da6:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800da9:	ff 4d e4             	decl   -0x1c(%ebp)
  800dac:	89 f0                	mov    %esi,%eax
  800dae:	8d 70 01             	lea    0x1(%eax),%esi
  800db1:	8a 00                	mov    (%eax),%al
  800db3:	0f be d8             	movsbl %al,%ebx
  800db6:	85 db                	test   %ebx,%ebx
  800db8:	74 24                	je     800dde <vprintfmt+0x24b>
  800dba:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dbe:	78 b8                	js     800d78 <vprintfmt+0x1e5>
  800dc0:	ff 4d e0             	decl   -0x20(%ebp)
  800dc3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dc7:	79 af                	jns    800d78 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dc9:	eb 13                	jmp    800dde <vprintfmt+0x24b>
				putch(' ', putdat);
  800dcb:	83 ec 08             	sub    $0x8,%esp
  800dce:	ff 75 0c             	pushl  0xc(%ebp)
  800dd1:	6a 20                	push   $0x20
  800dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd6:	ff d0                	call   *%eax
  800dd8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ddb:	ff 4d e4             	decl   -0x1c(%ebp)
  800dde:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de2:	7f e7                	jg     800dcb <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800de4:	e9 66 01 00 00       	jmp    800f4f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800de9:	83 ec 08             	sub    $0x8,%esp
  800dec:	ff 75 e8             	pushl  -0x18(%ebp)
  800def:	8d 45 14             	lea    0x14(%ebp),%eax
  800df2:	50                   	push   %eax
  800df3:	e8 3c fd ff ff       	call   800b34 <getint>
  800df8:	83 c4 10             	add    $0x10,%esp
  800dfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dfe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e01:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e04:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e07:	85 d2                	test   %edx,%edx
  800e09:	79 23                	jns    800e2e <vprintfmt+0x29b>
				putch('-', putdat);
  800e0b:	83 ec 08             	sub    $0x8,%esp
  800e0e:	ff 75 0c             	pushl  0xc(%ebp)
  800e11:	6a 2d                	push   $0x2d
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	ff d0                	call   *%eax
  800e18:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e1e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e21:	f7 d8                	neg    %eax
  800e23:	83 d2 00             	adc    $0x0,%edx
  800e26:	f7 da                	neg    %edx
  800e28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e2e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e35:	e9 bc 00 00 00       	jmp    800ef6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e3a:	83 ec 08             	sub    $0x8,%esp
  800e3d:	ff 75 e8             	pushl  -0x18(%ebp)
  800e40:	8d 45 14             	lea    0x14(%ebp),%eax
  800e43:	50                   	push   %eax
  800e44:	e8 84 fc ff ff       	call   800acd <getuint>
  800e49:	83 c4 10             	add    $0x10,%esp
  800e4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e4f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e52:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e59:	e9 98 00 00 00       	jmp    800ef6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e5e:	83 ec 08             	sub    $0x8,%esp
  800e61:	ff 75 0c             	pushl  0xc(%ebp)
  800e64:	6a 58                	push   $0x58
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	ff d0                	call   *%eax
  800e6b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e6e:	83 ec 08             	sub    $0x8,%esp
  800e71:	ff 75 0c             	pushl  0xc(%ebp)
  800e74:	6a 58                	push   $0x58
  800e76:	8b 45 08             	mov    0x8(%ebp),%eax
  800e79:	ff d0                	call   *%eax
  800e7b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e7e:	83 ec 08             	sub    $0x8,%esp
  800e81:	ff 75 0c             	pushl  0xc(%ebp)
  800e84:	6a 58                	push   $0x58
  800e86:	8b 45 08             	mov    0x8(%ebp),%eax
  800e89:	ff d0                	call   *%eax
  800e8b:	83 c4 10             	add    $0x10,%esp
			break;
  800e8e:	e9 bc 00 00 00       	jmp    800f4f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e93:	83 ec 08             	sub    $0x8,%esp
  800e96:	ff 75 0c             	pushl  0xc(%ebp)
  800e99:	6a 30                	push   $0x30
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9e:	ff d0                	call   *%eax
  800ea0:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ea3:	83 ec 08             	sub    $0x8,%esp
  800ea6:	ff 75 0c             	pushl  0xc(%ebp)
  800ea9:	6a 78                	push   $0x78
  800eab:	8b 45 08             	mov    0x8(%ebp),%eax
  800eae:	ff d0                	call   *%eax
  800eb0:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800eb3:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb6:	83 c0 04             	add    $0x4,%eax
  800eb9:	89 45 14             	mov    %eax,0x14(%ebp)
  800ebc:	8b 45 14             	mov    0x14(%ebp),%eax
  800ebf:	83 e8 04             	sub    $0x4,%eax
  800ec2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ec4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ece:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ed5:	eb 1f                	jmp    800ef6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ed7:	83 ec 08             	sub    $0x8,%esp
  800eda:	ff 75 e8             	pushl  -0x18(%ebp)
  800edd:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee0:	50                   	push   %eax
  800ee1:	e8 e7 fb ff ff       	call   800acd <getuint>
  800ee6:	83 c4 10             	add    $0x10,%esp
  800ee9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eec:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eef:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ef6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800efa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800efd:	83 ec 04             	sub    $0x4,%esp
  800f00:	52                   	push   %edx
  800f01:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f04:	50                   	push   %eax
  800f05:	ff 75 f4             	pushl  -0xc(%ebp)
  800f08:	ff 75 f0             	pushl  -0x10(%ebp)
  800f0b:	ff 75 0c             	pushl  0xc(%ebp)
  800f0e:	ff 75 08             	pushl  0x8(%ebp)
  800f11:	e8 00 fb ff ff       	call   800a16 <printnum>
  800f16:	83 c4 20             	add    $0x20,%esp
			break;
  800f19:	eb 34                	jmp    800f4f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f1b:	83 ec 08             	sub    $0x8,%esp
  800f1e:	ff 75 0c             	pushl  0xc(%ebp)
  800f21:	53                   	push   %ebx
  800f22:	8b 45 08             	mov    0x8(%ebp),%eax
  800f25:	ff d0                	call   *%eax
  800f27:	83 c4 10             	add    $0x10,%esp
			break;
  800f2a:	eb 23                	jmp    800f4f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f2c:	83 ec 08             	sub    $0x8,%esp
  800f2f:	ff 75 0c             	pushl  0xc(%ebp)
  800f32:	6a 25                	push   $0x25
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	ff d0                	call   *%eax
  800f39:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f3c:	ff 4d 10             	decl   0x10(%ebp)
  800f3f:	eb 03                	jmp    800f44 <vprintfmt+0x3b1>
  800f41:	ff 4d 10             	decl   0x10(%ebp)
  800f44:	8b 45 10             	mov    0x10(%ebp),%eax
  800f47:	48                   	dec    %eax
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	3c 25                	cmp    $0x25,%al
  800f4c:	75 f3                	jne    800f41 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f4e:	90                   	nop
		}
	}
  800f4f:	e9 47 fc ff ff       	jmp    800b9b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f54:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f55:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f58:	5b                   	pop    %ebx
  800f59:	5e                   	pop    %esi
  800f5a:	5d                   	pop    %ebp
  800f5b:	c3                   	ret    

00800f5c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f5c:	55                   	push   %ebp
  800f5d:	89 e5                	mov    %esp,%ebp
  800f5f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f62:	8d 45 10             	lea    0x10(%ebp),%eax
  800f65:	83 c0 04             	add    $0x4,%eax
  800f68:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6e:	ff 75 f4             	pushl  -0xc(%ebp)
  800f71:	50                   	push   %eax
  800f72:	ff 75 0c             	pushl  0xc(%ebp)
  800f75:	ff 75 08             	pushl  0x8(%ebp)
  800f78:	e8 16 fc ff ff       	call   800b93 <vprintfmt>
  800f7d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f80:	90                   	nop
  800f81:	c9                   	leave  
  800f82:	c3                   	ret    

00800f83 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f83:	55                   	push   %ebp
  800f84:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f89:	8b 40 08             	mov    0x8(%eax),%eax
  800f8c:	8d 50 01             	lea    0x1(%eax),%edx
  800f8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f92:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f98:	8b 10                	mov    (%eax),%edx
  800f9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9d:	8b 40 04             	mov    0x4(%eax),%eax
  800fa0:	39 c2                	cmp    %eax,%edx
  800fa2:	73 12                	jae    800fb6 <sprintputch+0x33>
		*b->buf++ = ch;
  800fa4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa7:	8b 00                	mov    (%eax),%eax
  800fa9:	8d 48 01             	lea    0x1(%eax),%ecx
  800fac:	8b 55 0c             	mov    0xc(%ebp),%edx
  800faf:	89 0a                	mov    %ecx,(%edx)
  800fb1:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb4:	88 10                	mov    %dl,(%eax)
}
  800fb6:	90                   	nop
  800fb7:	5d                   	pop    %ebp
  800fb8:	c3                   	ret    

00800fb9 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fb9:	55                   	push   %ebp
  800fba:	89 e5                	mov    %esp,%ebp
  800fbc:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fce:	01 d0                	add    %edx,%eax
  800fd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fda:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fde:	74 06                	je     800fe6 <vsnprintf+0x2d>
  800fe0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fe4:	7f 07                	jg     800fed <vsnprintf+0x34>
		return -E_INVAL;
  800fe6:	b8 03 00 00 00       	mov    $0x3,%eax
  800feb:	eb 20                	jmp    80100d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fed:	ff 75 14             	pushl  0x14(%ebp)
  800ff0:	ff 75 10             	pushl  0x10(%ebp)
  800ff3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ff6:	50                   	push   %eax
  800ff7:	68 83 0f 80 00       	push   $0x800f83
  800ffc:	e8 92 fb ff ff       	call   800b93 <vprintfmt>
  801001:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801004:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801007:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80100a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80100d:	c9                   	leave  
  80100e:	c3                   	ret    

0080100f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80100f:	55                   	push   %ebp
  801010:	89 e5                	mov    %esp,%ebp
  801012:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801015:	8d 45 10             	lea    0x10(%ebp),%eax
  801018:	83 c0 04             	add    $0x4,%eax
  80101b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80101e:	8b 45 10             	mov    0x10(%ebp),%eax
  801021:	ff 75 f4             	pushl  -0xc(%ebp)
  801024:	50                   	push   %eax
  801025:	ff 75 0c             	pushl  0xc(%ebp)
  801028:	ff 75 08             	pushl  0x8(%ebp)
  80102b:	e8 89 ff ff ff       	call   800fb9 <vsnprintf>
  801030:	83 c4 10             	add    $0x10,%esp
  801033:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801036:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801039:	c9                   	leave  
  80103a:	c3                   	ret    

0080103b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80103b:	55                   	push   %ebp
  80103c:	89 e5                	mov    %esp,%ebp
  80103e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801041:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801048:	eb 06                	jmp    801050 <strlen+0x15>
		n++;
  80104a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80104d:	ff 45 08             	incl   0x8(%ebp)
  801050:	8b 45 08             	mov    0x8(%ebp),%eax
  801053:	8a 00                	mov    (%eax),%al
  801055:	84 c0                	test   %al,%al
  801057:	75 f1                	jne    80104a <strlen+0xf>
		n++;
	return n;
  801059:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80105c:	c9                   	leave  
  80105d:	c3                   	ret    

0080105e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80105e:	55                   	push   %ebp
  80105f:	89 e5                	mov    %esp,%ebp
  801061:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801064:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80106b:	eb 09                	jmp    801076 <strnlen+0x18>
		n++;
  80106d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801070:	ff 45 08             	incl   0x8(%ebp)
  801073:	ff 4d 0c             	decl   0xc(%ebp)
  801076:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80107a:	74 09                	je     801085 <strnlen+0x27>
  80107c:	8b 45 08             	mov    0x8(%ebp),%eax
  80107f:	8a 00                	mov    (%eax),%al
  801081:	84 c0                	test   %al,%al
  801083:	75 e8                	jne    80106d <strnlen+0xf>
		n++;
	return n;
  801085:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801088:	c9                   	leave  
  801089:	c3                   	ret    

0080108a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80108a:	55                   	push   %ebp
  80108b:	89 e5                	mov    %esp,%ebp
  80108d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801096:	90                   	nop
  801097:	8b 45 08             	mov    0x8(%ebp),%eax
  80109a:	8d 50 01             	lea    0x1(%eax),%edx
  80109d:	89 55 08             	mov    %edx,0x8(%ebp)
  8010a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010a6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010a9:	8a 12                	mov    (%edx),%dl
  8010ab:	88 10                	mov    %dl,(%eax)
  8010ad:	8a 00                	mov    (%eax),%al
  8010af:	84 c0                	test   %al,%al
  8010b1:	75 e4                	jne    801097 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010b6:	c9                   	leave  
  8010b7:	c3                   	ret    

008010b8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010b8:	55                   	push   %ebp
  8010b9:	89 e5                	mov    %esp,%ebp
  8010bb:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010cb:	eb 1f                	jmp    8010ec <strncpy+0x34>
		*dst++ = *src;
  8010cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d0:	8d 50 01             	lea    0x1(%eax),%edx
  8010d3:	89 55 08             	mov    %edx,0x8(%ebp)
  8010d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d9:	8a 12                	mov    (%edx),%dl
  8010db:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e0:	8a 00                	mov    (%eax),%al
  8010e2:	84 c0                	test   %al,%al
  8010e4:	74 03                	je     8010e9 <strncpy+0x31>
			src++;
  8010e6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010e9:	ff 45 fc             	incl   -0x4(%ebp)
  8010ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ef:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010f2:	72 d9                	jb     8010cd <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010f7:	c9                   	leave  
  8010f8:	c3                   	ret    

008010f9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010f9:	55                   	push   %ebp
  8010fa:	89 e5                	mov    %esp,%ebp
  8010fc:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801102:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801105:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801109:	74 30                	je     80113b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80110b:	eb 16                	jmp    801123 <strlcpy+0x2a>
			*dst++ = *src++;
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	8d 50 01             	lea    0x1(%eax),%edx
  801113:	89 55 08             	mov    %edx,0x8(%ebp)
  801116:	8b 55 0c             	mov    0xc(%ebp),%edx
  801119:	8d 4a 01             	lea    0x1(%edx),%ecx
  80111c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80111f:	8a 12                	mov    (%edx),%dl
  801121:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801123:	ff 4d 10             	decl   0x10(%ebp)
  801126:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80112a:	74 09                	je     801135 <strlcpy+0x3c>
  80112c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112f:	8a 00                	mov    (%eax),%al
  801131:	84 c0                	test   %al,%al
  801133:	75 d8                	jne    80110d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801135:	8b 45 08             	mov    0x8(%ebp),%eax
  801138:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80113b:	8b 55 08             	mov    0x8(%ebp),%edx
  80113e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801141:	29 c2                	sub    %eax,%edx
  801143:	89 d0                	mov    %edx,%eax
}
  801145:	c9                   	leave  
  801146:	c3                   	ret    

00801147 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801147:	55                   	push   %ebp
  801148:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80114a:	eb 06                	jmp    801152 <strcmp+0xb>
		p++, q++;
  80114c:	ff 45 08             	incl   0x8(%ebp)
  80114f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801152:	8b 45 08             	mov    0x8(%ebp),%eax
  801155:	8a 00                	mov    (%eax),%al
  801157:	84 c0                	test   %al,%al
  801159:	74 0e                	je     801169 <strcmp+0x22>
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	8a 10                	mov    (%eax),%dl
  801160:	8b 45 0c             	mov    0xc(%ebp),%eax
  801163:	8a 00                	mov    (%eax),%al
  801165:	38 c2                	cmp    %al,%dl
  801167:	74 e3                	je     80114c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801169:	8b 45 08             	mov    0x8(%ebp),%eax
  80116c:	8a 00                	mov    (%eax),%al
  80116e:	0f b6 d0             	movzbl %al,%edx
  801171:	8b 45 0c             	mov    0xc(%ebp),%eax
  801174:	8a 00                	mov    (%eax),%al
  801176:	0f b6 c0             	movzbl %al,%eax
  801179:	29 c2                	sub    %eax,%edx
  80117b:	89 d0                	mov    %edx,%eax
}
  80117d:	5d                   	pop    %ebp
  80117e:	c3                   	ret    

0080117f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80117f:	55                   	push   %ebp
  801180:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801182:	eb 09                	jmp    80118d <strncmp+0xe>
		n--, p++, q++;
  801184:	ff 4d 10             	decl   0x10(%ebp)
  801187:	ff 45 08             	incl   0x8(%ebp)
  80118a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80118d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801191:	74 17                	je     8011aa <strncmp+0x2b>
  801193:	8b 45 08             	mov    0x8(%ebp),%eax
  801196:	8a 00                	mov    (%eax),%al
  801198:	84 c0                	test   %al,%al
  80119a:	74 0e                	je     8011aa <strncmp+0x2b>
  80119c:	8b 45 08             	mov    0x8(%ebp),%eax
  80119f:	8a 10                	mov    (%eax),%dl
  8011a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a4:	8a 00                	mov    (%eax),%al
  8011a6:	38 c2                	cmp    %al,%dl
  8011a8:	74 da                	je     801184 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011ae:	75 07                	jne    8011b7 <strncmp+0x38>
		return 0;
  8011b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8011b5:	eb 14                	jmp    8011cb <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ba:	8a 00                	mov    (%eax),%al
  8011bc:	0f b6 d0             	movzbl %al,%edx
  8011bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c2:	8a 00                	mov    (%eax),%al
  8011c4:	0f b6 c0             	movzbl %al,%eax
  8011c7:	29 c2                	sub    %eax,%edx
  8011c9:	89 d0                	mov    %edx,%eax
}
  8011cb:	5d                   	pop    %ebp
  8011cc:	c3                   	ret    

008011cd <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011cd:	55                   	push   %ebp
  8011ce:	89 e5                	mov    %esp,%ebp
  8011d0:	83 ec 04             	sub    $0x4,%esp
  8011d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011d9:	eb 12                	jmp    8011ed <strchr+0x20>
		if (*s == c)
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	8a 00                	mov    (%eax),%al
  8011e0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011e3:	75 05                	jne    8011ea <strchr+0x1d>
			return (char *) s;
  8011e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e8:	eb 11                	jmp    8011fb <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011ea:	ff 45 08             	incl   0x8(%ebp)
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f0:	8a 00                	mov    (%eax),%al
  8011f2:	84 c0                	test   %al,%al
  8011f4:	75 e5                	jne    8011db <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011f6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011fb:	c9                   	leave  
  8011fc:	c3                   	ret    

008011fd <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011fd:	55                   	push   %ebp
  8011fe:	89 e5                	mov    %esp,%ebp
  801200:	83 ec 04             	sub    $0x4,%esp
  801203:	8b 45 0c             	mov    0xc(%ebp),%eax
  801206:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801209:	eb 0d                	jmp    801218 <strfind+0x1b>
		if (*s == c)
  80120b:	8b 45 08             	mov    0x8(%ebp),%eax
  80120e:	8a 00                	mov    (%eax),%al
  801210:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801213:	74 0e                	je     801223 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801215:	ff 45 08             	incl   0x8(%ebp)
  801218:	8b 45 08             	mov    0x8(%ebp),%eax
  80121b:	8a 00                	mov    (%eax),%al
  80121d:	84 c0                	test   %al,%al
  80121f:	75 ea                	jne    80120b <strfind+0xe>
  801221:	eb 01                	jmp    801224 <strfind+0x27>
		if (*s == c)
			break;
  801223:	90                   	nop
	return (char *) s;
  801224:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801227:	c9                   	leave  
  801228:	c3                   	ret    

00801229 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801229:	55                   	push   %ebp
  80122a:	89 e5                	mov    %esp,%ebp
  80122c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80122f:	8b 45 08             	mov    0x8(%ebp),%eax
  801232:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801235:	8b 45 10             	mov    0x10(%ebp),%eax
  801238:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80123b:	eb 0e                	jmp    80124b <memset+0x22>
		*p++ = c;
  80123d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801240:	8d 50 01             	lea    0x1(%eax),%edx
  801243:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801246:	8b 55 0c             	mov    0xc(%ebp),%edx
  801249:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80124b:	ff 4d f8             	decl   -0x8(%ebp)
  80124e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801252:	79 e9                	jns    80123d <memset+0x14>
		*p++ = c;

	return v;
  801254:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801257:	c9                   	leave  
  801258:	c3                   	ret    

00801259 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801259:	55                   	push   %ebp
  80125a:	89 e5                	mov    %esp,%ebp
  80125c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80125f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801262:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801265:	8b 45 08             	mov    0x8(%ebp),%eax
  801268:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80126b:	eb 16                	jmp    801283 <memcpy+0x2a>
		*d++ = *s++;
  80126d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801270:	8d 50 01             	lea    0x1(%eax),%edx
  801273:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801276:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801279:	8d 4a 01             	lea    0x1(%edx),%ecx
  80127c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80127f:	8a 12                	mov    (%edx),%dl
  801281:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801283:	8b 45 10             	mov    0x10(%ebp),%eax
  801286:	8d 50 ff             	lea    -0x1(%eax),%edx
  801289:	89 55 10             	mov    %edx,0x10(%ebp)
  80128c:	85 c0                	test   %eax,%eax
  80128e:	75 dd                	jne    80126d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801290:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801293:	c9                   	leave  
  801294:	c3                   	ret    

00801295 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801295:	55                   	push   %ebp
  801296:	89 e5                	mov    %esp,%ebp
  801298:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80129b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012ad:	73 50                	jae    8012ff <memmove+0x6a>
  8012af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b5:	01 d0                	add    %edx,%eax
  8012b7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012ba:	76 43                	jbe    8012ff <memmove+0x6a>
		s += n;
  8012bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bf:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012c8:	eb 10                	jmp    8012da <memmove+0x45>
			*--d = *--s;
  8012ca:	ff 4d f8             	decl   -0x8(%ebp)
  8012cd:	ff 4d fc             	decl   -0x4(%ebp)
  8012d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d3:	8a 10                	mov    (%eax),%dl
  8012d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012da:	8b 45 10             	mov    0x10(%ebp),%eax
  8012dd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012e0:	89 55 10             	mov    %edx,0x10(%ebp)
  8012e3:	85 c0                	test   %eax,%eax
  8012e5:	75 e3                	jne    8012ca <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012e7:	eb 23                	jmp    80130c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ec:	8d 50 01             	lea    0x1(%eax),%edx
  8012ef:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012f5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012f8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012fb:	8a 12                	mov    (%edx),%dl
  8012fd:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801302:	8d 50 ff             	lea    -0x1(%eax),%edx
  801305:	89 55 10             	mov    %edx,0x10(%ebp)
  801308:	85 c0                	test   %eax,%eax
  80130a:	75 dd                	jne    8012e9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80130c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80130f:	c9                   	leave  
  801310:	c3                   	ret    

00801311 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801311:	55                   	push   %ebp
  801312:	89 e5                	mov    %esp,%ebp
  801314:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801317:	8b 45 08             	mov    0x8(%ebp),%eax
  80131a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80131d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801320:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801323:	eb 2a                	jmp    80134f <memcmp+0x3e>
		if (*s1 != *s2)
  801325:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801328:	8a 10                	mov    (%eax),%dl
  80132a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80132d:	8a 00                	mov    (%eax),%al
  80132f:	38 c2                	cmp    %al,%dl
  801331:	74 16                	je     801349 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801333:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801336:	8a 00                	mov    (%eax),%al
  801338:	0f b6 d0             	movzbl %al,%edx
  80133b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80133e:	8a 00                	mov    (%eax),%al
  801340:	0f b6 c0             	movzbl %al,%eax
  801343:	29 c2                	sub    %eax,%edx
  801345:	89 d0                	mov    %edx,%eax
  801347:	eb 18                	jmp    801361 <memcmp+0x50>
		s1++, s2++;
  801349:	ff 45 fc             	incl   -0x4(%ebp)
  80134c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80134f:	8b 45 10             	mov    0x10(%ebp),%eax
  801352:	8d 50 ff             	lea    -0x1(%eax),%edx
  801355:	89 55 10             	mov    %edx,0x10(%ebp)
  801358:	85 c0                	test   %eax,%eax
  80135a:	75 c9                	jne    801325 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80135c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801361:	c9                   	leave  
  801362:	c3                   	ret    

00801363 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801363:	55                   	push   %ebp
  801364:	89 e5                	mov    %esp,%ebp
  801366:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801369:	8b 55 08             	mov    0x8(%ebp),%edx
  80136c:	8b 45 10             	mov    0x10(%ebp),%eax
  80136f:	01 d0                	add    %edx,%eax
  801371:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801374:	eb 15                	jmp    80138b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	8a 00                	mov    (%eax),%al
  80137b:	0f b6 d0             	movzbl %al,%edx
  80137e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801381:	0f b6 c0             	movzbl %al,%eax
  801384:	39 c2                	cmp    %eax,%edx
  801386:	74 0d                	je     801395 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801388:	ff 45 08             	incl   0x8(%ebp)
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
  80138e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801391:	72 e3                	jb     801376 <memfind+0x13>
  801393:	eb 01                	jmp    801396 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801395:	90                   	nop
	return (void *) s;
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801399:	c9                   	leave  
  80139a:	c3                   	ret    

0080139b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80139b:	55                   	push   %ebp
  80139c:	89 e5                	mov    %esp,%ebp
  80139e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013a8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013af:	eb 03                	jmp    8013b4 <strtol+0x19>
		s++;
  8013b1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	8a 00                	mov    (%eax),%al
  8013b9:	3c 20                	cmp    $0x20,%al
  8013bb:	74 f4                	je     8013b1 <strtol+0x16>
  8013bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c0:	8a 00                	mov    (%eax),%al
  8013c2:	3c 09                	cmp    $0x9,%al
  8013c4:	74 eb                	je     8013b1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	8a 00                	mov    (%eax),%al
  8013cb:	3c 2b                	cmp    $0x2b,%al
  8013cd:	75 05                	jne    8013d4 <strtol+0x39>
		s++;
  8013cf:	ff 45 08             	incl   0x8(%ebp)
  8013d2:	eb 13                	jmp    8013e7 <strtol+0x4c>
	else if (*s == '-')
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	3c 2d                	cmp    $0x2d,%al
  8013db:	75 0a                	jne    8013e7 <strtol+0x4c>
		s++, neg = 1;
  8013dd:	ff 45 08             	incl   0x8(%ebp)
  8013e0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013e7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013eb:	74 06                	je     8013f3 <strtol+0x58>
  8013ed:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013f1:	75 20                	jne    801413 <strtol+0x78>
  8013f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f6:	8a 00                	mov    (%eax),%al
  8013f8:	3c 30                	cmp    $0x30,%al
  8013fa:	75 17                	jne    801413 <strtol+0x78>
  8013fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ff:	40                   	inc    %eax
  801400:	8a 00                	mov    (%eax),%al
  801402:	3c 78                	cmp    $0x78,%al
  801404:	75 0d                	jne    801413 <strtol+0x78>
		s += 2, base = 16;
  801406:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80140a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801411:	eb 28                	jmp    80143b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801413:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801417:	75 15                	jne    80142e <strtol+0x93>
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	8a 00                	mov    (%eax),%al
  80141e:	3c 30                	cmp    $0x30,%al
  801420:	75 0c                	jne    80142e <strtol+0x93>
		s++, base = 8;
  801422:	ff 45 08             	incl   0x8(%ebp)
  801425:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80142c:	eb 0d                	jmp    80143b <strtol+0xa0>
	else if (base == 0)
  80142e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801432:	75 07                	jne    80143b <strtol+0xa0>
		base = 10;
  801434:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80143b:	8b 45 08             	mov    0x8(%ebp),%eax
  80143e:	8a 00                	mov    (%eax),%al
  801440:	3c 2f                	cmp    $0x2f,%al
  801442:	7e 19                	jle    80145d <strtol+0xc2>
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	8a 00                	mov    (%eax),%al
  801449:	3c 39                	cmp    $0x39,%al
  80144b:	7f 10                	jg     80145d <strtol+0xc2>
			dig = *s - '0';
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	8a 00                	mov    (%eax),%al
  801452:	0f be c0             	movsbl %al,%eax
  801455:	83 e8 30             	sub    $0x30,%eax
  801458:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80145b:	eb 42                	jmp    80149f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	8a 00                	mov    (%eax),%al
  801462:	3c 60                	cmp    $0x60,%al
  801464:	7e 19                	jle    80147f <strtol+0xe4>
  801466:	8b 45 08             	mov    0x8(%ebp),%eax
  801469:	8a 00                	mov    (%eax),%al
  80146b:	3c 7a                	cmp    $0x7a,%al
  80146d:	7f 10                	jg     80147f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80146f:	8b 45 08             	mov    0x8(%ebp),%eax
  801472:	8a 00                	mov    (%eax),%al
  801474:	0f be c0             	movsbl %al,%eax
  801477:	83 e8 57             	sub    $0x57,%eax
  80147a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80147d:	eb 20                	jmp    80149f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80147f:	8b 45 08             	mov    0x8(%ebp),%eax
  801482:	8a 00                	mov    (%eax),%al
  801484:	3c 40                	cmp    $0x40,%al
  801486:	7e 39                	jle    8014c1 <strtol+0x126>
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	8a 00                	mov    (%eax),%al
  80148d:	3c 5a                	cmp    $0x5a,%al
  80148f:	7f 30                	jg     8014c1 <strtol+0x126>
			dig = *s - 'A' + 10;
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
  801494:	8a 00                	mov    (%eax),%al
  801496:	0f be c0             	movsbl %al,%eax
  801499:	83 e8 37             	sub    $0x37,%eax
  80149c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80149f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014a2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014a5:	7d 19                	jge    8014c0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014a7:	ff 45 08             	incl   0x8(%ebp)
  8014aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ad:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014b1:	89 c2                	mov    %eax,%edx
  8014b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014b6:	01 d0                	add    %edx,%eax
  8014b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014bb:	e9 7b ff ff ff       	jmp    80143b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014c0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014c5:	74 08                	je     8014cf <strtol+0x134>
		*endptr = (char *) s;
  8014c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ca:	8b 55 08             	mov    0x8(%ebp),%edx
  8014cd:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014d3:	74 07                	je     8014dc <strtol+0x141>
  8014d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d8:	f7 d8                	neg    %eax
  8014da:	eb 03                	jmp    8014df <strtol+0x144>
  8014dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014df:	c9                   	leave  
  8014e0:	c3                   	ret    

008014e1 <ltostr>:

void
ltostr(long value, char *str)
{
  8014e1:	55                   	push   %ebp
  8014e2:	89 e5                	mov    %esp,%ebp
  8014e4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014f5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014f9:	79 13                	jns    80150e <ltostr+0x2d>
	{
		neg = 1;
  8014fb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801502:	8b 45 0c             	mov    0xc(%ebp),%eax
  801505:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801508:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80150b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80150e:	8b 45 08             	mov    0x8(%ebp),%eax
  801511:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801516:	99                   	cltd   
  801517:	f7 f9                	idiv   %ecx
  801519:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80151c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80151f:	8d 50 01             	lea    0x1(%eax),%edx
  801522:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801525:	89 c2                	mov    %eax,%edx
  801527:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152a:	01 d0                	add    %edx,%eax
  80152c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80152f:	83 c2 30             	add    $0x30,%edx
  801532:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801534:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801537:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80153c:	f7 e9                	imul   %ecx
  80153e:	c1 fa 02             	sar    $0x2,%edx
  801541:	89 c8                	mov    %ecx,%eax
  801543:	c1 f8 1f             	sar    $0x1f,%eax
  801546:	29 c2                	sub    %eax,%edx
  801548:	89 d0                	mov    %edx,%eax
  80154a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80154d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801550:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801555:	f7 e9                	imul   %ecx
  801557:	c1 fa 02             	sar    $0x2,%edx
  80155a:	89 c8                	mov    %ecx,%eax
  80155c:	c1 f8 1f             	sar    $0x1f,%eax
  80155f:	29 c2                	sub    %eax,%edx
  801561:	89 d0                	mov    %edx,%eax
  801563:	c1 e0 02             	shl    $0x2,%eax
  801566:	01 d0                	add    %edx,%eax
  801568:	01 c0                	add    %eax,%eax
  80156a:	29 c1                	sub    %eax,%ecx
  80156c:	89 ca                	mov    %ecx,%edx
  80156e:	85 d2                	test   %edx,%edx
  801570:	75 9c                	jne    80150e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801572:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801579:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80157c:	48                   	dec    %eax
  80157d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801580:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801584:	74 3d                	je     8015c3 <ltostr+0xe2>
		start = 1 ;
  801586:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80158d:	eb 34                	jmp    8015c3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80158f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801592:	8b 45 0c             	mov    0xc(%ebp),%eax
  801595:	01 d0                	add    %edx,%eax
  801597:	8a 00                	mov    (%eax),%al
  801599:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80159c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80159f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a2:	01 c2                	add    %eax,%edx
  8015a4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015aa:	01 c8                	add    %ecx,%eax
  8015ac:	8a 00                	mov    (%eax),%al
  8015ae:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015b0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b6:	01 c2                	add    %eax,%edx
  8015b8:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015bb:	88 02                	mov    %al,(%edx)
		start++ ;
  8015bd:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015c0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015c6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015c9:	7c c4                	jl     80158f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015cb:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d1:	01 d0                	add    %edx,%eax
  8015d3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015d6:	90                   	nop
  8015d7:	c9                   	leave  
  8015d8:	c3                   	ret    

008015d9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015d9:	55                   	push   %ebp
  8015da:	89 e5                	mov    %esp,%ebp
  8015dc:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015df:	ff 75 08             	pushl  0x8(%ebp)
  8015e2:	e8 54 fa ff ff       	call   80103b <strlen>
  8015e7:	83 c4 04             	add    $0x4,%esp
  8015ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015ed:	ff 75 0c             	pushl  0xc(%ebp)
  8015f0:	e8 46 fa ff ff       	call   80103b <strlen>
  8015f5:	83 c4 04             	add    $0x4,%esp
  8015f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801602:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801609:	eb 17                	jmp    801622 <strcconcat+0x49>
		final[s] = str1[s] ;
  80160b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80160e:	8b 45 10             	mov    0x10(%ebp),%eax
  801611:	01 c2                	add    %eax,%edx
  801613:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	01 c8                	add    %ecx,%eax
  80161b:	8a 00                	mov    (%eax),%al
  80161d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80161f:	ff 45 fc             	incl   -0x4(%ebp)
  801622:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801625:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801628:	7c e1                	jl     80160b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80162a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801631:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801638:	eb 1f                	jmp    801659 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80163a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80163d:	8d 50 01             	lea    0x1(%eax),%edx
  801640:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801643:	89 c2                	mov    %eax,%edx
  801645:	8b 45 10             	mov    0x10(%ebp),%eax
  801648:	01 c2                	add    %eax,%edx
  80164a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80164d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801650:	01 c8                	add    %ecx,%eax
  801652:	8a 00                	mov    (%eax),%al
  801654:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801656:	ff 45 f8             	incl   -0x8(%ebp)
  801659:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80165c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80165f:	7c d9                	jl     80163a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801661:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801664:	8b 45 10             	mov    0x10(%ebp),%eax
  801667:	01 d0                	add    %edx,%eax
  801669:	c6 00 00             	movb   $0x0,(%eax)
}
  80166c:	90                   	nop
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801672:	8b 45 14             	mov    0x14(%ebp),%eax
  801675:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80167b:	8b 45 14             	mov    0x14(%ebp),%eax
  80167e:	8b 00                	mov    (%eax),%eax
  801680:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801687:	8b 45 10             	mov    0x10(%ebp),%eax
  80168a:	01 d0                	add    %edx,%eax
  80168c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801692:	eb 0c                	jmp    8016a0 <strsplit+0x31>
			*string++ = 0;
  801694:	8b 45 08             	mov    0x8(%ebp),%eax
  801697:	8d 50 01             	lea    0x1(%eax),%edx
  80169a:	89 55 08             	mov    %edx,0x8(%ebp)
  80169d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a3:	8a 00                	mov    (%eax),%al
  8016a5:	84 c0                	test   %al,%al
  8016a7:	74 18                	je     8016c1 <strsplit+0x52>
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	8a 00                	mov    (%eax),%al
  8016ae:	0f be c0             	movsbl %al,%eax
  8016b1:	50                   	push   %eax
  8016b2:	ff 75 0c             	pushl  0xc(%ebp)
  8016b5:	e8 13 fb ff ff       	call   8011cd <strchr>
  8016ba:	83 c4 08             	add    $0x8,%esp
  8016bd:	85 c0                	test   %eax,%eax
  8016bf:	75 d3                	jne    801694 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c4:	8a 00                	mov    (%eax),%al
  8016c6:	84 c0                	test   %al,%al
  8016c8:	74 5a                	je     801724 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8016cd:	8b 00                	mov    (%eax),%eax
  8016cf:	83 f8 0f             	cmp    $0xf,%eax
  8016d2:	75 07                	jne    8016db <strsplit+0x6c>
		{
			return 0;
  8016d4:	b8 00 00 00 00       	mov    $0x0,%eax
  8016d9:	eb 66                	jmp    801741 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016db:	8b 45 14             	mov    0x14(%ebp),%eax
  8016de:	8b 00                	mov    (%eax),%eax
  8016e0:	8d 48 01             	lea    0x1(%eax),%ecx
  8016e3:	8b 55 14             	mov    0x14(%ebp),%edx
  8016e6:	89 0a                	mov    %ecx,(%edx)
  8016e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f2:	01 c2                	add    %eax,%edx
  8016f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016f9:	eb 03                	jmp    8016fe <strsplit+0x8f>
			string++;
  8016fb:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	8a 00                	mov    (%eax),%al
  801703:	84 c0                	test   %al,%al
  801705:	74 8b                	je     801692 <strsplit+0x23>
  801707:	8b 45 08             	mov    0x8(%ebp),%eax
  80170a:	8a 00                	mov    (%eax),%al
  80170c:	0f be c0             	movsbl %al,%eax
  80170f:	50                   	push   %eax
  801710:	ff 75 0c             	pushl  0xc(%ebp)
  801713:	e8 b5 fa ff ff       	call   8011cd <strchr>
  801718:	83 c4 08             	add    $0x8,%esp
  80171b:	85 c0                	test   %eax,%eax
  80171d:	74 dc                	je     8016fb <strsplit+0x8c>
			string++;
	}
  80171f:	e9 6e ff ff ff       	jmp    801692 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801724:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801725:	8b 45 14             	mov    0x14(%ebp),%eax
  801728:	8b 00                	mov    (%eax),%eax
  80172a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801731:	8b 45 10             	mov    0x10(%ebp),%eax
  801734:	01 d0                	add    %edx,%eax
  801736:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80173c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801741:	c9                   	leave  
  801742:	c3                   	ret    

00801743 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801743:	55                   	push   %ebp
  801744:	89 e5                	mov    %esp,%ebp
  801746:	57                   	push   %edi
  801747:	56                   	push   %esi
  801748:	53                   	push   %ebx
  801749:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80174c:	8b 45 08             	mov    0x8(%ebp),%eax
  80174f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801752:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801755:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801758:	8b 7d 18             	mov    0x18(%ebp),%edi
  80175b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80175e:	cd 30                	int    $0x30
  801760:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801763:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801766:	83 c4 10             	add    $0x10,%esp
  801769:	5b                   	pop    %ebx
  80176a:	5e                   	pop    %esi
  80176b:	5f                   	pop    %edi
  80176c:	5d                   	pop    %ebp
  80176d:	c3                   	ret    

0080176e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80176e:	55                   	push   %ebp
  80176f:	89 e5                	mov    %esp,%ebp
  801771:	83 ec 04             	sub    $0x4,%esp
  801774:	8b 45 10             	mov    0x10(%ebp),%eax
  801777:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80177a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80177e:	8b 45 08             	mov    0x8(%ebp),%eax
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	52                   	push   %edx
  801786:	ff 75 0c             	pushl  0xc(%ebp)
  801789:	50                   	push   %eax
  80178a:	6a 00                	push   $0x0
  80178c:	e8 b2 ff ff ff       	call   801743 <syscall>
  801791:	83 c4 18             	add    $0x18,%esp
}
  801794:	90                   	nop
  801795:	c9                   	leave  
  801796:	c3                   	ret    

00801797 <sys_cgetc>:

int
sys_cgetc(void)
{
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 01                	push   $0x1
  8017a6:	e8 98 ff ff ff       	call   801743 <syscall>
  8017ab:	83 c4 18             	add    $0x18,%esp
}
  8017ae:	c9                   	leave  
  8017af:	c3                   	ret    

008017b0 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8017b0:	55                   	push   %ebp
  8017b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8017b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	50                   	push   %eax
  8017bf:	6a 05                	push   $0x5
  8017c1:	e8 7d ff ff ff       	call   801743 <syscall>
  8017c6:	83 c4 18             	add    $0x18,%esp
}
  8017c9:	c9                   	leave  
  8017ca:	c3                   	ret    

008017cb <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017cb:	55                   	push   %ebp
  8017cc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 02                	push   $0x2
  8017da:	e8 64 ff ff ff       	call   801743 <syscall>
  8017df:	83 c4 18             	add    $0x18,%esp
}
  8017e2:	c9                   	leave  
  8017e3:	c3                   	ret    

008017e4 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 03                	push   $0x3
  8017f3:	e8 4b ff ff ff       	call   801743 <syscall>
  8017f8:	83 c4 18             	add    $0x18,%esp
}
  8017fb:	c9                   	leave  
  8017fc:	c3                   	ret    

008017fd <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017fd:	55                   	push   %ebp
  8017fe:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 04                	push   $0x4
  80180c:	e8 32 ff ff ff       	call   801743 <syscall>
  801811:	83 c4 18             	add    $0x18,%esp
}
  801814:	c9                   	leave  
  801815:	c3                   	ret    

00801816 <sys_env_exit>:


void sys_env_exit(void)
{
  801816:	55                   	push   %ebp
  801817:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 06                	push   $0x6
  801825:	e8 19 ff ff ff       	call   801743 <syscall>
  80182a:	83 c4 18             	add    $0x18,%esp
}
  80182d:	90                   	nop
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801833:	8b 55 0c             	mov    0xc(%ebp),%edx
  801836:	8b 45 08             	mov    0x8(%ebp),%eax
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	52                   	push   %edx
  801840:	50                   	push   %eax
  801841:	6a 07                	push   $0x7
  801843:	e8 fb fe ff ff       	call   801743 <syscall>
  801848:	83 c4 18             	add    $0x18,%esp
}
  80184b:	c9                   	leave  
  80184c:	c3                   	ret    

0080184d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80184d:	55                   	push   %ebp
  80184e:	89 e5                	mov    %esp,%ebp
  801850:	56                   	push   %esi
  801851:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801852:	8b 75 18             	mov    0x18(%ebp),%esi
  801855:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801858:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80185b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185e:	8b 45 08             	mov    0x8(%ebp),%eax
  801861:	56                   	push   %esi
  801862:	53                   	push   %ebx
  801863:	51                   	push   %ecx
  801864:	52                   	push   %edx
  801865:	50                   	push   %eax
  801866:	6a 08                	push   $0x8
  801868:	e8 d6 fe ff ff       	call   801743 <syscall>
  80186d:	83 c4 18             	add    $0x18,%esp
}
  801870:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801873:	5b                   	pop    %ebx
  801874:	5e                   	pop    %esi
  801875:	5d                   	pop    %ebp
  801876:	c3                   	ret    

00801877 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801877:	55                   	push   %ebp
  801878:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80187a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80187d:	8b 45 08             	mov    0x8(%ebp),%eax
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	52                   	push   %edx
  801887:	50                   	push   %eax
  801888:	6a 09                	push   $0x9
  80188a:	e8 b4 fe ff ff       	call   801743 <syscall>
  80188f:	83 c4 18             	add    $0x18,%esp
}
  801892:	c9                   	leave  
  801893:	c3                   	ret    

00801894 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801894:	55                   	push   %ebp
  801895:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	ff 75 0c             	pushl  0xc(%ebp)
  8018a0:	ff 75 08             	pushl  0x8(%ebp)
  8018a3:	6a 0a                	push   $0xa
  8018a5:	e8 99 fe ff ff       	call   801743 <syscall>
  8018aa:	83 c4 18             	add    $0x18,%esp
}
  8018ad:	c9                   	leave  
  8018ae:	c3                   	ret    

008018af <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8018af:	55                   	push   %ebp
  8018b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 0b                	push   $0xb
  8018be:	e8 80 fe ff ff       	call   801743 <syscall>
  8018c3:	83 c4 18             	add    $0x18,%esp
}
  8018c6:	c9                   	leave  
  8018c7:	c3                   	ret    

008018c8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018c8:	55                   	push   %ebp
  8018c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 0c                	push   $0xc
  8018d7:	e8 67 fe ff ff       	call   801743 <syscall>
  8018dc:	83 c4 18             	add    $0x18,%esp
}
  8018df:	c9                   	leave  
  8018e0:	c3                   	ret    

008018e1 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018e1:	55                   	push   %ebp
  8018e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 0d                	push   $0xd
  8018f0:	e8 4e fe ff ff       	call   801743 <syscall>
  8018f5:	83 c4 18             	add    $0x18,%esp
}
  8018f8:	c9                   	leave  
  8018f9:	c3                   	ret    

008018fa <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018fa:	55                   	push   %ebp
  8018fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	ff 75 0c             	pushl  0xc(%ebp)
  801906:	ff 75 08             	pushl  0x8(%ebp)
  801909:	6a 11                	push   $0x11
  80190b:	e8 33 fe ff ff       	call   801743 <syscall>
  801910:	83 c4 18             	add    $0x18,%esp
	return;
  801913:	90                   	nop
}
  801914:	c9                   	leave  
  801915:	c3                   	ret    

00801916 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801916:	55                   	push   %ebp
  801917:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	ff 75 0c             	pushl  0xc(%ebp)
  801922:	ff 75 08             	pushl  0x8(%ebp)
  801925:	6a 12                	push   $0x12
  801927:	e8 17 fe ff ff       	call   801743 <syscall>
  80192c:	83 c4 18             	add    $0x18,%esp
	return ;
  80192f:	90                   	nop
}
  801930:	c9                   	leave  
  801931:	c3                   	ret    

00801932 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 0e                	push   $0xe
  801941:	e8 fd fd ff ff       	call   801743 <syscall>
  801946:	83 c4 18             	add    $0x18,%esp
}
  801949:	c9                   	leave  
  80194a:	c3                   	ret    

0080194b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80194b:	55                   	push   %ebp
  80194c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	ff 75 08             	pushl  0x8(%ebp)
  801959:	6a 0f                	push   $0xf
  80195b:	e8 e3 fd ff ff       	call   801743 <syscall>
  801960:	83 c4 18             	add    $0x18,%esp
}
  801963:	c9                   	leave  
  801964:	c3                   	ret    

00801965 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801965:	55                   	push   %ebp
  801966:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 10                	push   $0x10
  801974:	e8 ca fd ff ff       	call   801743 <syscall>
  801979:	83 c4 18             	add    $0x18,%esp
}
  80197c:	90                   	nop
  80197d:	c9                   	leave  
  80197e:	c3                   	ret    

0080197f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 14                	push   $0x14
  80198e:	e8 b0 fd ff ff       	call   801743 <syscall>
  801993:	83 c4 18             	add    $0x18,%esp
}
  801996:	90                   	nop
  801997:	c9                   	leave  
  801998:	c3                   	ret    

00801999 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 15                	push   $0x15
  8019a8:	e8 96 fd ff ff       	call   801743 <syscall>
  8019ad:	83 c4 18             	add    $0x18,%esp
}
  8019b0:	90                   	nop
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <sys_cputc>:


void
sys_cputc(const char c)
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
  8019b6:	83 ec 04             	sub    $0x4,%esp
  8019b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019bf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	50                   	push   %eax
  8019cc:	6a 16                	push   $0x16
  8019ce:	e8 70 fd ff ff       	call   801743 <syscall>
  8019d3:	83 c4 18             	add    $0x18,%esp
}
  8019d6:	90                   	nop
  8019d7:	c9                   	leave  
  8019d8:	c3                   	ret    

008019d9 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019d9:	55                   	push   %ebp
  8019da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 17                	push   $0x17
  8019e8:	e8 56 fd ff ff       	call   801743 <syscall>
  8019ed:	83 c4 18             	add    $0x18,%esp
}
  8019f0:	90                   	nop
  8019f1:	c9                   	leave  
  8019f2:	c3                   	ret    

008019f3 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019f3:	55                   	push   %ebp
  8019f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	ff 75 0c             	pushl  0xc(%ebp)
  801a02:	50                   	push   %eax
  801a03:	6a 18                	push   $0x18
  801a05:	e8 39 fd ff ff       	call   801743 <syscall>
  801a0a:	83 c4 18             	add    $0x18,%esp
}
  801a0d:	c9                   	leave  
  801a0e:	c3                   	ret    

00801a0f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a0f:	55                   	push   %ebp
  801a10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a12:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a15:	8b 45 08             	mov    0x8(%ebp),%eax
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	52                   	push   %edx
  801a1f:	50                   	push   %eax
  801a20:	6a 1b                	push   $0x1b
  801a22:	e8 1c fd ff ff       	call   801743 <syscall>
  801a27:	83 c4 18             	add    $0x18,%esp
}
  801a2a:	c9                   	leave  
  801a2b:	c3                   	ret    

00801a2c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a2c:	55                   	push   %ebp
  801a2d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a2f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a32:	8b 45 08             	mov    0x8(%ebp),%eax
  801a35:	6a 00                	push   $0x0
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	52                   	push   %edx
  801a3c:	50                   	push   %eax
  801a3d:	6a 19                	push   $0x19
  801a3f:	e8 ff fc ff ff       	call   801743 <syscall>
  801a44:	83 c4 18             	add    $0x18,%esp
}
  801a47:	90                   	nop
  801a48:	c9                   	leave  
  801a49:	c3                   	ret    

00801a4a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a4a:	55                   	push   %ebp
  801a4b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a50:	8b 45 08             	mov    0x8(%ebp),%eax
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	52                   	push   %edx
  801a5a:	50                   	push   %eax
  801a5b:	6a 1a                	push   $0x1a
  801a5d:	e8 e1 fc ff ff       	call   801743 <syscall>
  801a62:	83 c4 18             	add    $0x18,%esp
}
  801a65:	90                   	nop
  801a66:	c9                   	leave  
  801a67:	c3                   	ret    

00801a68 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a68:	55                   	push   %ebp
  801a69:	89 e5                	mov    %esp,%ebp
  801a6b:	83 ec 04             	sub    $0x4,%esp
  801a6e:	8b 45 10             	mov    0x10(%ebp),%eax
  801a71:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a74:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a77:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7e:	6a 00                	push   $0x0
  801a80:	51                   	push   %ecx
  801a81:	52                   	push   %edx
  801a82:	ff 75 0c             	pushl  0xc(%ebp)
  801a85:	50                   	push   %eax
  801a86:	6a 1c                	push   $0x1c
  801a88:	e8 b6 fc ff ff       	call   801743 <syscall>
  801a8d:	83 c4 18             	add    $0x18,%esp
}
  801a90:	c9                   	leave  
  801a91:	c3                   	ret    

00801a92 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a92:	55                   	push   %ebp
  801a93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a95:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a98:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	52                   	push   %edx
  801aa2:	50                   	push   %eax
  801aa3:	6a 1d                	push   $0x1d
  801aa5:	e8 99 fc ff ff       	call   801743 <syscall>
  801aaa:	83 c4 18             	add    $0x18,%esp
}
  801aad:	c9                   	leave  
  801aae:	c3                   	ret    

00801aaf <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801aaf:	55                   	push   %ebp
  801ab0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801ab2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ab5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  801abb:	6a 00                	push   $0x0
  801abd:	6a 00                	push   $0x0
  801abf:	51                   	push   %ecx
  801ac0:	52                   	push   %edx
  801ac1:	50                   	push   %eax
  801ac2:	6a 1e                	push   $0x1e
  801ac4:	e8 7a fc ff ff       	call   801743 <syscall>
  801ac9:	83 c4 18             	add    $0x18,%esp
}
  801acc:	c9                   	leave  
  801acd:	c3                   	ret    

00801ace <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ace:	55                   	push   %ebp
  801acf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ad1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	52                   	push   %edx
  801ade:	50                   	push   %eax
  801adf:	6a 1f                	push   $0x1f
  801ae1:	e8 5d fc ff ff       	call   801743 <syscall>
  801ae6:	83 c4 18             	add    $0x18,%esp
}
  801ae9:	c9                   	leave  
  801aea:	c3                   	ret    

00801aeb <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801aeb:	55                   	push   %ebp
  801aec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 20                	push   $0x20
  801afa:	e8 44 fc ff ff       	call   801743 <syscall>
  801aff:	83 c4 18             	add    $0x18,%esp
}
  801b02:	c9                   	leave  
  801b03:	c3                   	ret    

00801b04 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801b04:	55                   	push   %ebp
  801b05:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b07:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0a:	6a 00                	push   $0x0
  801b0c:	ff 75 14             	pushl  0x14(%ebp)
  801b0f:	ff 75 10             	pushl  0x10(%ebp)
  801b12:	ff 75 0c             	pushl  0xc(%ebp)
  801b15:	50                   	push   %eax
  801b16:	6a 21                	push   $0x21
  801b18:	e8 26 fc ff ff       	call   801743 <syscall>
  801b1d:	83 c4 18             	add    $0x18,%esp
}
  801b20:	c9                   	leave  
  801b21:	c3                   	ret    

00801b22 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801b22:	55                   	push   %ebp
  801b23:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b25:	8b 45 08             	mov    0x8(%ebp),%eax
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	50                   	push   %eax
  801b31:	6a 22                	push   $0x22
  801b33:	e8 0b fc ff ff       	call   801743 <syscall>
  801b38:	83 c4 18             	add    $0x18,%esp
}
  801b3b:	90                   	nop
  801b3c:	c9                   	leave  
  801b3d:	c3                   	ret    

00801b3e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b3e:	55                   	push   %ebp
  801b3f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b41:	8b 45 08             	mov    0x8(%ebp),%eax
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	50                   	push   %eax
  801b4d:	6a 23                	push   $0x23
  801b4f:	e8 ef fb ff ff       	call   801743 <syscall>
  801b54:	83 c4 18             	add    $0x18,%esp
}
  801b57:	90                   	nop
  801b58:	c9                   	leave  
  801b59:	c3                   	ret    

00801b5a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b5a:	55                   	push   %ebp
  801b5b:	89 e5                	mov    %esp,%ebp
  801b5d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b60:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b63:	8d 50 04             	lea    0x4(%eax),%edx
  801b66:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	52                   	push   %edx
  801b70:	50                   	push   %eax
  801b71:	6a 24                	push   $0x24
  801b73:	e8 cb fb ff ff       	call   801743 <syscall>
  801b78:	83 c4 18             	add    $0x18,%esp
	return result;
  801b7b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b7e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b81:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b84:	89 01                	mov    %eax,(%ecx)
  801b86:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b89:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8c:	c9                   	leave  
  801b8d:	c2 04 00             	ret    $0x4

00801b90 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b90:	55                   	push   %ebp
  801b91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	ff 75 10             	pushl  0x10(%ebp)
  801b9a:	ff 75 0c             	pushl  0xc(%ebp)
  801b9d:	ff 75 08             	pushl  0x8(%ebp)
  801ba0:	6a 13                	push   $0x13
  801ba2:	e8 9c fb ff ff       	call   801743 <syscall>
  801ba7:	83 c4 18             	add    $0x18,%esp
	return ;
  801baa:	90                   	nop
}
  801bab:	c9                   	leave  
  801bac:	c3                   	ret    

00801bad <sys_rcr2>:
uint32 sys_rcr2()
{
  801bad:	55                   	push   %ebp
  801bae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 25                	push   $0x25
  801bbc:	e8 82 fb ff ff       	call   801743 <syscall>
  801bc1:	83 c4 18             	add    $0x18,%esp
}
  801bc4:	c9                   	leave  
  801bc5:	c3                   	ret    

00801bc6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801bc6:	55                   	push   %ebp
  801bc7:	89 e5                	mov    %esp,%ebp
  801bc9:	83 ec 04             	sub    $0x4,%esp
  801bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801bd2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	50                   	push   %eax
  801bdf:	6a 26                	push   $0x26
  801be1:	e8 5d fb ff ff       	call   801743 <syscall>
  801be6:	83 c4 18             	add    $0x18,%esp
	return ;
  801be9:	90                   	nop
}
  801bea:	c9                   	leave  
  801beb:	c3                   	ret    

00801bec <rsttst>:
void rsttst()
{
  801bec:	55                   	push   %ebp
  801bed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 28                	push   $0x28
  801bfb:	e8 43 fb ff ff       	call   801743 <syscall>
  801c00:	83 c4 18             	add    $0x18,%esp
	return ;
  801c03:	90                   	nop
}
  801c04:	c9                   	leave  
  801c05:	c3                   	ret    

00801c06 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c06:	55                   	push   %ebp
  801c07:	89 e5                	mov    %esp,%ebp
  801c09:	83 ec 04             	sub    $0x4,%esp
  801c0c:	8b 45 14             	mov    0x14(%ebp),%eax
  801c0f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c12:	8b 55 18             	mov    0x18(%ebp),%edx
  801c15:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c19:	52                   	push   %edx
  801c1a:	50                   	push   %eax
  801c1b:	ff 75 10             	pushl  0x10(%ebp)
  801c1e:	ff 75 0c             	pushl  0xc(%ebp)
  801c21:	ff 75 08             	pushl  0x8(%ebp)
  801c24:	6a 27                	push   $0x27
  801c26:	e8 18 fb ff ff       	call   801743 <syscall>
  801c2b:	83 c4 18             	add    $0x18,%esp
	return ;
  801c2e:	90                   	nop
}
  801c2f:	c9                   	leave  
  801c30:	c3                   	ret    

00801c31 <chktst>:
void chktst(uint32 n)
{
  801c31:	55                   	push   %ebp
  801c32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	ff 75 08             	pushl  0x8(%ebp)
  801c3f:	6a 29                	push   $0x29
  801c41:	e8 fd fa ff ff       	call   801743 <syscall>
  801c46:	83 c4 18             	add    $0x18,%esp
	return ;
  801c49:	90                   	nop
}
  801c4a:	c9                   	leave  
  801c4b:	c3                   	ret    

00801c4c <inctst>:

void inctst()
{
  801c4c:	55                   	push   %ebp
  801c4d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 00                	push   $0x0
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 2a                	push   $0x2a
  801c5b:	e8 e3 fa ff ff       	call   801743 <syscall>
  801c60:	83 c4 18             	add    $0x18,%esp
	return ;
  801c63:	90                   	nop
}
  801c64:	c9                   	leave  
  801c65:	c3                   	ret    

00801c66 <gettst>:
uint32 gettst()
{
  801c66:	55                   	push   %ebp
  801c67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 2b                	push   $0x2b
  801c75:	e8 c9 fa ff ff       	call   801743 <syscall>
  801c7a:	83 c4 18             	add    $0x18,%esp
}
  801c7d:	c9                   	leave  
  801c7e:	c3                   	ret    

00801c7f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c7f:	55                   	push   %ebp
  801c80:	89 e5                	mov    %esp,%ebp
  801c82:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 2c                	push   $0x2c
  801c91:	e8 ad fa ff ff       	call   801743 <syscall>
  801c96:	83 c4 18             	add    $0x18,%esp
  801c99:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c9c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ca0:	75 07                	jne    801ca9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801ca2:	b8 01 00 00 00       	mov    $0x1,%eax
  801ca7:	eb 05                	jmp    801cae <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801ca9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cae:	c9                   	leave  
  801caf:	c3                   	ret    

00801cb0 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801cb0:	55                   	push   %ebp
  801cb1:	89 e5                	mov    %esp,%ebp
  801cb3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 2c                	push   $0x2c
  801cc2:	e8 7c fa ff ff       	call   801743 <syscall>
  801cc7:	83 c4 18             	add    $0x18,%esp
  801cca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ccd:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801cd1:	75 07                	jne    801cda <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cd3:	b8 01 00 00 00       	mov    $0x1,%eax
  801cd8:	eb 05                	jmp    801cdf <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cda:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cdf:	c9                   	leave  
  801ce0:	c3                   	ret    

00801ce1 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ce1:	55                   	push   %ebp
  801ce2:	89 e5                	mov    %esp,%ebp
  801ce4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 2c                	push   $0x2c
  801cf3:	e8 4b fa ff ff       	call   801743 <syscall>
  801cf8:	83 c4 18             	add    $0x18,%esp
  801cfb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cfe:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d02:	75 07                	jne    801d0b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d04:	b8 01 00 00 00       	mov    $0x1,%eax
  801d09:	eb 05                	jmp    801d10 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d0b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d10:	c9                   	leave  
  801d11:	c3                   	ret    

00801d12 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d12:	55                   	push   %ebp
  801d13:	89 e5                	mov    %esp,%ebp
  801d15:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 2c                	push   $0x2c
  801d24:	e8 1a fa ff ff       	call   801743 <syscall>
  801d29:	83 c4 18             	add    $0x18,%esp
  801d2c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d2f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d33:	75 07                	jne    801d3c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d35:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3a:	eb 05                	jmp    801d41 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d3c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d41:	c9                   	leave  
  801d42:	c3                   	ret    

00801d43 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d43:	55                   	push   %ebp
  801d44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	ff 75 08             	pushl  0x8(%ebp)
  801d51:	6a 2d                	push   $0x2d
  801d53:	e8 eb f9 ff ff       	call   801743 <syscall>
  801d58:	83 c4 18             	add    $0x18,%esp
	return ;
  801d5b:	90                   	nop
}
  801d5c:	c9                   	leave  
  801d5d:	c3                   	ret    

00801d5e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d5e:	55                   	push   %ebp
  801d5f:	89 e5                	mov    %esp,%ebp
  801d61:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d62:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d65:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d68:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6e:	6a 00                	push   $0x0
  801d70:	53                   	push   %ebx
  801d71:	51                   	push   %ecx
  801d72:	52                   	push   %edx
  801d73:	50                   	push   %eax
  801d74:	6a 2e                	push   $0x2e
  801d76:	e8 c8 f9 ff ff       	call   801743 <syscall>
  801d7b:	83 c4 18             	add    $0x18,%esp
}
  801d7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d81:	c9                   	leave  
  801d82:	c3                   	ret    

00801d83 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d83:	55                   	push   %ebp
  801d84:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d86:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d89:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	52                   	push   %edx
  801d93:	50                   	push   %eax
  801d94:	6a 2f                	push   $0x2f
  801d96:	e8 a8 f9 ff ff       	call   801743 <syscall>
  801d9b:	83 c4 18             	add    $0x18,%esp
}
  801d9e:	c9                   	leave  
  801d9f:	c3                   	ret    

00801da0 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801da0:	55                   	push   %ebp
  801da1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	6a 00                	push   $0x0
  801da9:	ff 75 0c             	pushl  0xc(%ebp)
  801dac:	ff 75 08             	pushl  0x8(%ebp)
  801daf:	6a 30                	push   $0x30
  801db1:	e8 8d f9 ff ff       	call   801743 <syscall>
  801db6:	83 c4 18             	add    $0x18,%esp
	return ;
  801db9:	90                   	nop
}
  801dba:	c9                   	leave  
  801dbb:	c3                   	ret    

00801dbc <__udivdi3>:
  801dbc:	55                   	push   %ebp
  801dbd:	57                   	push   %edi
  801dbe:	56                   	push   %esi
  801dbf:	53                   	push   %ebx
  801dc0:	83 ec 1c             	sub    $0x1c,%esp
  801dc3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801dc7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801dcb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801dcf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801dd3:	89 ca                	mov    %ecx,%edx
  801dd5:	89 f8                	mov    %edi,%eax
  801dd7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ddb:	85 f6                	test   %esi,%esi
  801ddd:	75 2d                	jne    801e0c <__udivdi3+0x50>
  801ddf:	39 cf                	cmp    %ecx,%edi
  801de1:	77 65                	ja     801e48 <__udivdi3+0x8c>
  801de3:	89 fd                	mov    %edi,%ebp
  801de5:	85 ff                	test   %edi,%edi
  801de7:	75 0b                	jne    801df4 <__udivdi3+0x38>
  801de9:	b8 01 00 00 00       	mov    $0x1,%eax
  801dee:	31 d2                	xor    %edx,%edx
  801df0:	f7 f7                	div    %edi
  801df2:	89 c5                	mov    %eax,%ebp
  801df4:	31 d2                	xor    %edx,%edx
  801df6:	89 c8                	mov    %ecx,%eax
  801df8:	f7 f5                	div    %ebp
  801dfa:	89 c1                	mov    %eax,%ecx
  801dfc:	89 d8                	mov    %ebx,%eax
  801dfe:	f7 f5                	div    %ebp
  801e00:	89 cf                	mov    %ecx,%edi
  801e02:	89 fa                	mov    %edi,%edx
  801e04:	83 c4 1c             	add    $0x1c,%esp
  801e07:	5b                   	pop    %ebx
  801e08:	5e                   	pop    %esi
  801e09:	5f                   	pop    %edi
  801e0a:	5d                   	pop    %ebp
  801e0b:	c3                   	ret    
  801e0c:	39 ce                	cmp    %ecx,%esi
  801e0e:	77 28                	ja     801e38 <__udivdi3+0x7c>
  801e10:	0f bd fe             	bsr    %esi,%edi
  801e13:	83 f7 1f             	xor    $0x1f,%edi
  801e16:	75 40                	jne    801e58 <__udivdi3+0x9c>
  801e18:	39 ce                	cmp    %ecx,%esi
  801e1a:	72 0a                	jb     801e26 <__udivdi3+0x6a>
  801e1c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e20:	0f 87 9e 00 00 00    	ja     801ec4 <__udivdi3+0x108>
  801e26:	b8 01 00 00 00       	mov    $0x1,%eax
  801e2b:	89 fa                	mov    %edi,%edx
  801e2d:	83 c4 1c             	add    $0x1c,%esp
  801e30:	5b                   	pop    %ebx
  801e31:	5e                   	pop    %esi
  801e32:	5f                   	pop    %edi
  801e33:	5d                   	pop    %ebp
  801e34:	c3                   	ret    
  801e35:	8d 76 00             	lea    0x0(%esi),%esi
  801e38:	31 ff                	xor    %edi,%edi
  801e3a:	31 c0                	xor    %eax,%eax
  801e3c:	89 fa                	mov    %edi,%edx
  801e3e:	83 c4 1c             	add    $0x1c,%esp
  801e41:	5b                   	pop    %ebx
  801e42:	5e                   	pop    %esi
  801e43:	5f                   	pop    %edi
  801e44:	5d                   	pop    %ebp
  801e45:	c3                   	ret    
  801e46:	66 90                	xchg   %ax,%ax
  801e48:	89 d8                	mov    %ebx,%eax
  801e4a:	f7 f7                	div    %edi
  801e4c:	31 ff                	xor    %edi,%edi
  801e4e:	89 fa                	mov    %edi,%edx
  801e50:	83 c4 1c             	add    $0x1c,%esp
  801e53:	5b                   	pop    %ebx
  801e54:	5e                   	pop    %esi
  801e55:	5f                   	pop    %edi
  801e56:	5d                   	pop    %ebp
  801e57:	c3                   	ret    
  801e58:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e5d:	89 eb                	mov    %ebp,%ebx
  801e5f:	29 fb                	sub    %edi,%ebx
  801e61:	89 f9                	mov    %edi,%ecx
  801e63:	d3 e6                	shl    %cl,%esi
  801e65:	89 c5                	mov    %eax,%ebp
  801e67:	88 d9                	mov    %bl,%cl
  801e69:	d3 ed                	shr    %cl,%ebp
  801e6b:	89 e9                	mov    %ebp,%ecx
  801e6d:	09 f1                	or     %esi,%ecx
  801e6f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e73:	89 f9                	mov    %edi,%ecx
  801e75:	d3 e0                	shl    %cl,%eax
  801e77:	89 c5                	mov    %eax,%ebp
  801e79:	89 d6                	mov    %edx,%esi
  801e7b:	88 d9                	mov    %bl,%cl
  801e7d:	d3 ee                	shr    %cl,%esi
  801e7f:	89 f9                	mov    %edi,%ecx
  801e81:	d3 e2                	shl    %cl,%edx
  801e83:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e87:	88 d9                	mov    %bl,%cl
  801e89:	d3 e8                	shr    %cl,%eax
  801e8b:	09 c2                	or     %eax,%edx
  801e8d:	89 d0                	mov    %edx,%eax
  801e8f:	89 f2                	mov    %esi,%edx
  801e91:	f7 74 24 0c          	divl   0xc(%esp)
  801e95:	89 d6                	mov    %edx,%esi
  801e97:	89 c3                	mov    %eax,%ebx
  801e99:	f7 e5                	mul    %ebp
  801e9b:	39 d6                	cmp    %edx,%esi
  801e9d:	72 19                	jb     801eb8 <__udivdi3+0xfc>
  801e9f:	74 0b                	je     801eac <__udivdi3+0xf0>
  801ea1:	89 d8                	mov    %ebx,%eax
  801ea3:	31 ff                	xor    %edi,%edi
  801ea5:	e9 58 ff ff ff       	jmp    801e02 <__udivdi3+0x46>
  801eaa:	66 90                	xchg   %ax,%ax
  801eac:	8b 54 24 08          	mov    0x8(%esp),%edx
  801eb0:	89 f9                	mov    %edi,%ecx
  801eb2:	d3 e2                	shl    %cl,%edx
  801eb4:	39 c2                	cmp    %eax,%edx
  801eb6:	73 e9                	jae    801ea1 <__udivdi3+0xe5>
  801eb8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ebb:	31 ff                	xor    %edi,%edi
  801ebd:	e9 40 ff ff ff       	jmp    801e02 <__udivdi3+0x46>
  801ec2:	66 90                	xchg   %ax,%ax
  801ec4:	31 c0                	xor    %eax,%eax
  801ec6:	e9 37 ff ff ff       	jmp    801e02 <__udivdi3+0x46>
  801ecb:	90                   	nop

00801ecc <__umoddi3>:
  801ecc:	55                   	push   %ebp
  801ecd:	57                   	push   %edi
  801ece:	56                   	push   %esi
  801ecf:	53                   	push   %ebx
  801ed0:	83 ec 1c             	sub    $0x1c,%esp
  801ed3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ed7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801edb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801edf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ee3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ee7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801eeb:	89 f3                	mov    %esi,%ebx
  801eed:	89 fa                	mov    %edi,%edx
  801eef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ef3:	89 34 24             	mov    %esi,(%esp)
  801ef6:	85 c0                	test   %eax,%eax
  801ef8:	75 1a                	jne    801f14 <__umoddi3+0x48>
  801efa:	39 f7                	cmp    %esi,%edi
  801efc:	0f 86 a2 00 00 00    	jbe    801fa4 <__umoddi3+0xd8>
  801f02:	89 c8                	mov    %ecx,%eax
  801f04:	89 f2                	mov    %esi,%edx
  801f06:	f7 f7                	div    %edi
  801f08:	89 d0                	mov    %edx,%eax
  801f0a:	31 d2                	xor    %edx,%edx
  801f0c:	83 c4 1c             	add    $0x1c,%esp
  801f0f:	5b                   	pop    %ebx
  801f10:	5e                   	pop    %esi
  801f11:	5f                   	pop    %edi
  801f12:	5d                   	pop    %ebp
  801f13:	c3                   	ret    
  801f14:	39 f0                	cmp    %esi,%eax
  801f16:	0f 87 ac 00 00 00    	ja     801fc8 <__umoddi3+0xfc>
  801f1c:	0f bd e8             	bsr    %eax,%ebp
  801f1f:	83 f5 1f             	xor    $0x1f,%ebp
  801f22:	0f 84 ac 00 00 00    	je     801fd4 <__umoddi3+0x108>
  801f28:	bf 20 00 00 00       	mov    $0x20,%edi
  801f2d:	29 ef                	sub    %ebp,%edi
  801f2f:	89 fe                	mov    %edi,%esi
  801f31:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f35:	89 e9                	mov    %ebp,%ecx
  801f37:	d3 e0                	shl    %cl,%eax
  801f39:	89 d7                	mov    %edx,%edi
  801f3b:	89 f1                	mov    %esi,%ecx
  801f3d:	d3 ef                	shr    %cl,%edi
  801f3f:	09 c7                	or     %eax,%edi
  801f41:	89 e9                	mov    %ebp,%ecx
  801f43:	d3 e2                	shl    %cl,%edx
  801f45:	89 14 24             	mov    %edx,(%esp)
  801f48:	89 d8                	mov    %ebx,%eax
  801f4a:	d3 e0                	shl    %cl,%eax
  801f4c:	89 c2                	mov    %eax,%edx
  801f4e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f52:	d3 e0                	shl    %cl,%eax
  801f54:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f58:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f5c:	89 f1                	mov    %esi,%ecx
  801f5e:	d3 e8                	shr    %cl,%eax
  801f60:	09 d0                	or     %edx,%eax
  801f62:	d3 eb                	shr    %cl,%ebx
  801f64:	89 da                	mov    %ebx,%edx
  801f66:	f7 f7                	div    %edi
  801f68:	89 d3                	mov    %edx,%ebx
  801f6a:	f7 24 24             	mull   (%esp)
  801f6d:	89 c6                	mov    %eax,%esi
  801f6f:	89 d1                	mov    %edx,%ecx
  801f71:	39 d3                	cmp    %edx,%ebx
  801f73:	0f 82 87 00 00 00    	jb     802000 <__umoddi3+0x134>
  801f79:	0f 84 91 00 00 00    	je     802010 <__umoddi3+0x144>
  801f7f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f83:	29 f2                	sub    %esi,%edx
  801f85:	19 cb                	sbb    %ecx,%ebx
  801f87:	89 d8                	mov    %ebx,%eax
  801f89:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f8d:	d3 e0                	shl    %cl,%eax
  801f8f:	89 e9                	mov    %ebp,%ecx
  801f91:	d3 ea                	shr    %cl,%edx
  801f93:	09 d0                	or     %edx,%eax
  801f95:	89 e9                	mov    %ebp,%ecx
  801f97:	d3 eb                	shr    %cl,%ebx
  801f99:	89 da                	mov    %ebx,%edx
  801f9b:	83 c4 1c             	add    $0x1c,%esp
  801f9e:	5b                   	pop    %ebx
  801f9f:	5e                   	pop    %esi
  801fa0:	5f                   	pop    %edi
  801fa1:	5d                   	pop    %ebp
  801fa2:	c3                   	ret    
  801fa3:	90                   	nop
  801fa4:	89 fd                	mov    %edi,%ebp
  801fa6:	85 ff                	test   %edi,%edi
  801fa8:	75 0b                	jne    801fb5 <__umoddi3+0xe9>
  801faa:	b8 01 00 00 00       	mov    $0x1,%eax
  801faf:	31 d2                	xor    %edx,%edx
  801fb1:	f7 f7                	div    %edi
  801fb3:	89 c5                	mov    %eax,%ebp
  801fb5:	89 f0                	mov    %esi,%eax
  801fb7:	31 d2                	xor    %edx,%edx
  801fb9:	f7 f5                	div    %ebp
  801fbb:	89 c8                	mov    %ecx,%eax
  801fbd:	f7 f5                	div    %ebp
  801fbf:	89 d0                	mov    %edx,%eax
  801fc1:	e9 44 ff ff ff       	jmp    801f0a <__umoddi3+0x3e>
  801fc6:	66 90                	xchg   %ax,%ax
  801fc8:	89 c8                	mov    %ecx,%eax
  801fca:	89 f2                	mov    %esi,%edx
  801fcc:	83 c4 1c             	add    $0x1c,%esp
  801fcf:	5b                   	pop    %ebx
  801fd0:	5e                   	pop    %esi
  801fd1:	5f                   	pop    %edi
  801fd2:	5d                   	pop    %ebp
  801fd3:	c3                   	ret    
  801fd4:	3b 04 24             	cmp    (%esp),%eax
  801fd7:	72 06                	jb     801fdf <__umoddi3+0x113>
  801fd9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fdd:	77 0f                	ja     801fee <__umoddi3+0x122>
  801fdf:	89 f2                	mov    %esi,%edx
  801fe1:	29 f9                	sub    %edi,%ecx
  801fe3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801fe7:	89 14 24             	mov    %edx,(%esp)
  801fea:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fee:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ff2:	8b 14 24             	mov    (%esp),%edx
  801ff5:	83 c4 1c             	add    $0x1c,%esp
  801ff8:	5b                   	pop    %ebx
  801ff9:	5e                   	pop    %esi
  801ffa:	5f                   	pop    %edi
  801ffb:	5d                   	pop    %ebp
  801ffc:	c3                   	ret    
  801ffd:	8d 76 00             	lea    0x0(%esi),%esi
  802000:	2b 04 24             	sub    (%esp),%eax
  802003:	19 fa                	sbb    %edi,%edx
  802005:	89 d1                	mov    %edx,%ecx
  802007:	89 c6                	mov    %eax,%esi
  802009:	e9 71 ff ff ff       	jmp    801f7f <__umoddi3+0xb3>
  80200e:	66 90                	xchg   %ax,%ax
  802010:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802014:	72 ea                	jb     802000 <__umoddi3+0x134>
  802016:	89 d9                	mov    %ebx,%ecx
  802018:	e9 62 ff ff ff       	jmp    801f7f <__umoddi3+0xb3>
