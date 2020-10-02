
obj/user/tst_buffer_2:     file format elf32-i386


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
  800031:	e8 52 08 00 00       	call   800888 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/*SHOULD be on User DATA not on the STACK*/
char arr[PAGE_SIZE*1024*14 + PAGE_SIZE];
//=========================================

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 6c             	sub    $0x6c,%esp



	/*[1] CHECK INITIAL WORKING SET*/
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800041:	a1 20 30 80 00       	mov    0x803020,%eax
  800046:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80004c:	8b 00                	mov    (%eax),%eax
  80004e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800051:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800054:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800059:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005e:	74 14                	je     800074 <_main+0x3c>
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	68 80 23 80 00       	push   $0x802380
  800068:	6a 17                	push   $0x17
  80006a:	68 c8 23 80 00       	push   $0x8023c8
  80006f:	e8 39 09 00 00       	call   8009ad <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800074:	a1 20 30 80 00       	mov    0x803020,%eax
  800079:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80007f:	83 c0 14             	add    $0x14,%eax
  800082:	8b 00                	mov    (%eax),%eax
  800084:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800087:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80008a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008f:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800094:	74 14                	je     8000aa <_main+0x72>
  800096:	83 ec 04             	sub    $0x4,%esp
  800099:	68 80 23 80 00       	push   $0x802380
  80009e:	6a 18                	push   $0x18
  8000a0:	68 c8 23 80 00       	push   $0x8023c8
  8000a5:	e8 03 09 00 00       	call   8009ad <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8000af:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000b5:	83 c0 28             	add    $0x28,%eax
  8000b8:	8b 00                	mov    (%eax),%eax
  8000ba:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000bd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c5:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000ca:	74 14                	je     8000e0 <_main+0xa8>
  8000cc:	83 ec 04             	sub    $0x4,%esp
  8000cf:	68 80 23 80 00       	push   $0x802380
  8000d4:	6a 19                	push   $0x19
  8000d6:	68 c8 23 80 00       	push   $0x8023c8
  8000db:	e8 cd 08 00 00       	call   8009ad <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e5:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000eb:	83 c0 3c             	add    $0x3c,%eax
  8000ee:	8b 00                	mov    (%eax),%eax
  8000f0:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fb:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800100:	74 14                	je     800116 <_main+0xde>
  800102:	83 ec 04             	sub    $0x4,%esp
  800105:	68 80 23 80 00       	push   $0x802380
  80010a:	6a 1a                	push   $0x1a
  80010c:	68 c8 23 80 00       	push   $0x8023c8
  800111:	e8 97 08 00 00       	call   8009ad <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800116:	a1 20 30 80 00       	mov    0x803020,%eax
  80011b:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800121:	83 c0 50             	add    $0x50,%eax
  800124:	8b 00                	mov    (%eax),%eax
  800126:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800129:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80012c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800131:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800136:	74 14                	je     80014c <_main+0x114>
  800138:	83 ec 04             	sub    $0x4,%esp
  80013b:	68 80 23 80 00       	push   $0x802380
  800140:	6a 1b                	push   $0x1b
  800142:	68 c8 23 80 00       	push   $0x8023c8
  800147:	e8 61 08 00 00       	call   8009ad <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80014c:	a1 20 30 80 00       	mov    0x803020,%eax
  800151:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800157:	83 c0 64             	add    $0x64,%eax
  80015a:	8b 00                	mov    (%eax),%eax
  80015c:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80015f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800162:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800167:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016c:	74 14                	je     800182 <_main+0x14a>
  80016e:	83 ec 04             	sub    $0x4,%esp
  800171:	68 80 23 80 00       	push   $0x802380
  800176:	6a 1c                	push   $0x1c
  800178:	68 c8 23 80 00       	push   $0x8023c8
  80017d:	e8 2b 08 00 00       	call   8009ad <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800182:	a1 20 30 80 00       	mov    0x803020,%eax
  800187:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80018d:	83 c0 78             	add    $0x78,%eax
  800190:	8b 00                	mov    (%eax),%eax
  800192:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800195:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800198:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019d:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a2:	74 14                	je     8001b8 <_main+0x180>
  8001a4:	83 ec 04             	sub    $0x4,%esp
  8001a7:	68 80 23 80 00       	push   $0x802380
  8001ac:	6a 1d                	push   $0x1d
  8001ae:	68 c8 23 80 00       	push   $0x8023c8
  8001b3:	e8 f5 07 00 00       	call   8009ad <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bd:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001c3:	05 8c 00 00 00       	add    $0x8c,%eax
  8001c8:	8b 00                	mov    (%eax),%eax
  8001ca:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001cd:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d5:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001da:	74 14                	je     8001f0 <_main+0x1b8>
  8001dc:	83 ec 04             	sub    $0x4,%esp
  8001df:	68 80 23 80 00       	push   $0x802380
  8001e4:	6a 1e                	push   $0x1e
  8001e6:	68 c8 23 80 00       	push   $0x8023c8
  8001eb:	e8 bd 07 00 00       	call   8009ad <_panic>
		//if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f5:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001fb:	05 a0 00 00 00       	add    $0xa0,%eax
  800200:	8b 00                	mov    (%eax),%eax
  800202:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800205:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800208:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020d:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800212:	74 14                	je     800228 <_main+0x1f0>
  800214:	83 ec 04             	sub    $0x4,%esp
  800217:	68 80 23 80 00       	push   $0x802380
  80021c:	6a 20                	push   $0x20
  80021e:	68 c8 23 80 00       	push   $0x8023c8
  800223:	e8 85 07 00 00       	call   8009ad <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800228:	a1 20 30 80 00       	mov    0x803020,%eax
  80022d:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800233:	05 b4 00 00 00       	add    $0xb4,%eax
  800238:	8b 00                	mov    (%eax),%eax
  80023a:	89 45 b8             	mov    %eax,-0x48(%ebp)
  80023d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800240:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800245:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80024a:	74 14                	je     800260 <_main+0x228>
  80024c:	83 ec 04             	sub    $0x4,%esp
  80024f:	68 80 23 80 00       	push   $0x802380
  800254:	6a 21                	push   $0x21
  800256:	68 c8 23 80 00       	push   $0x8023c8
  80025b:	e8 4d 07 00 00       	call   8009ad <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800260:	a1 20 30 80 00       	mov    0x803020,%eax
  800265:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80026b:	05 c8 00 00 00       	add    $0xc8,%eax
  800270:	8b 00                	mov    (%eax),%eax
  800272:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800275:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800278:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80027d:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800282:	74 14                	je     800298 <_main+0x260>
  800284:	83 ec 04             	sub    $0x4,%esp
  800287:	68 80 23 80 00       	push   $0x802380
  80028c:	6a 22                	push   $0x22
  80028e:	68 c8 23 80 00       	push   $0x8023c8
  800293:	e8 15 07 00 00       	call   8009ad <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  800298:	a1 20 30 80 00       	mov    0x803020,%eax
  80029d:	8b 80 80 52 00 00    	mov    0x5280(%eax),%eax
  8002a3:	85 c0                	test   %eax,%eax
  8002a5:	74 14                	je     8002bb <_main+0x283>
  8002a7:	83 ec 04             	sub    $0x4,%esp
  8002aa:	68 dc 23 80 00       	push   $0x8023dc
  8002af:	6a 23                	push   $0x23
  8002b1:	68 c8 23 80 00       	push   $0x8023c8
  8002b6:	e8 f2 06 00 00       	call   8009ad <_panic>

	/*[2] RUN THE SLAVE PROGRAM*/

	//****************************************************************************************************************
	//IMP: program name is placed statically on the stack to avoid PAGE FAULT on it during the sys call inside the Kernel
	char slaveProgName[10] = "tpb2slave";
  8002bb:	8d 45 92             	lea    -0x6e(%ebp),%eax
  8002be:	bb 63 27 80 00       	mov    $0x802763,%ebx
  8002c3:	ba 0a 00 00 00       	mov    $0xa,%edx
  8002c8:	89 c7                	mov    %eax,%edi
  8002ca:	89 de                	mov    %ebx,%esi
  8002cc:	89 d1                	mov    %edx,%ecx
  8002ce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	//****************************************************************************************************************

	int32 envIdSlave = sys_create_env(slaveProgName, (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8002d0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d5:	8b 90 f4 52 00 00    	mov    0x52f4(%eax),%edx
  8002db:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e0:	8b 80 34 53 00 00    	mov    0x5334(%eax),%eax
  8002e6:	89 c1                	mov    %eax,%ecx
  8002e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ed:	8b 40 74             	mov    0x74(%eax),%eax
  8002f0:	52                   	push   %edx
  8002f1:	51                   	push   %ecx
  8002f2:	50                   	push   %eax
  8002f3:	8d 45 92             	lea    -0x6e(%ebp),%eax
  8002f6:	50                   	push   %eax
  8002f7:	e8 b3 1a 00 00       	call   801daf <sys_create_env>
  8002fc:	83 c4 10             	add    $0x10,%esp
  8002ff:	89 45 b0             	mov    %eax,-0x50(%ebp)
	int initModBufCnt = sys_calculate_modified_frames();
  800302:	e8 6c 18 00 00       	call   801b73 <sys_calculate_modified_frames>
  800307:	89 45 ac             	mov    %eax,-0x54(%ebp)
	sys_run_env(envIdSlave);
  80030a:	83 ec 0c             	sub    $0xc,%esp
  80030d:	ff 75 b0             	pushl  -0x50(%ebp)
  800310:	e8 b8 1a 00 00       	call   801dcd <sys_run_env>
  800315:	83 c4 10             	add    $0x10,%esp

	/*[3] BUSY-WAIT FOR A WHILE TILL FINISHING IT*/
	env_sleep(5000);
  800318:	83 ec 0c             	sub    $0xc,%esp
  80031b:	68 88 13 00 00       	push   $0x1388
  800320:	e8 42 1d 00 00       	call   802067 <env_sleep>
  800325:	83 c4 10             	add    $0x10,%esp


	//NOW: modified list contains 7 pages from the slave program
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames of the slave ... WRONG number of buffered pages in MODIFIED frame list");
  800328:	e8 46 18 00 00       	call   801b73 <sys_calculate_modified_frames>
  80032d:	89 c2                	mov    %eax,%edx
  80032f:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800332:	29 c2                	sub    %eax,%edx
  800334:	89 d0                	mov    %edx,%eax
  800336:	83 f8 07             	cmp    $0x7,%eax
  800339:	74 14                	je     80034f <_main+0x317>
  80033b:	83 ec 04             	sub    $0x4,%esp
  80033e:	68 2c 24 80 00       	push   $0x80242c
  800343:	6a 36                	push   $0x36
  800345:	68 c8 23 80 00       	push   $0x8023c8
  80034a:	e8 5e 06 00 00       	call   8009ad <_panic>


	/*START OF TST_BUFFER_2*/
	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80034f:	e8 89 18 00 00       	call   801bdd <sys_pf_calculate_allocated_pages>
  800354:	89 45 a8             	mov    %eax,-0x58(%ebp)
	int freePages = sys_calculate_free_frames();
  800357:	e8 fe 17 00 00       	call   801b5a <sys_calculate_free_frames>
  80035c:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  80035f:	e8 0f 18 00 00       	call   801b73 <sys_calculate_modified_frames>
  800364:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int initFreeBufCnt = sys_calculate_notmod_frames();
  800367:	e8 20 18 00 00       	call   801b8c <sys_calculate_notmod_frames>
  80036c:	89 45 a0             	mov    %eax,-0x60(%ebp)
	int dummy = 0;
  80036f:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%ebp)
	//Fault #1
	int i=0;
  800376:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for(;i<1;i++)
  80037d:	eb 0e                	jmp    80038d <_main+0x355>
	{
		arr[i] = -1;
  80037f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800382:	05 40 30 80 00       	add    $0x803040,%eax
  800387:	c6 00 ff             	movb   $0xff,(%eax)
	initModBufCnt = sys_calculate_modified_frames();
	int initFreeBufCnt = sys_calculate_notmod_frames();
	int dummy = 0;
	//Fault #1
	int i=0;
	for(;i<1;i++)
  80038a:	ff 45 e4             	incl   -0x1c(%ebp)
  80038d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800391:	7e ec                	jle    80037f <_main+0x347>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800393:	e8 f4 17 00 00       	call   801b8c <sys_calculate_notmod_frames>
  800398:	89 c2                	mov    %eax,%edx
  80039a:	a1 20 30 80 00       	mov    0x803020,%eax
  80039f:	8b 40 4c             	mov    0x4c(%eax),%eax
  8003a2:	01 d0                	add    %edx,%eax
  8003a4:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #2
	i=PAGE_SIZE*1024;
  8003a7:	c7 45 e4 00 00 40 00 	movl   $0x400000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024+1;i++)
  8003ae:	eb 0e                	jmp    8003be <_main+0x386>
	{
		arr[i] = -1;
  8003b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003b3:	05 40 30 80 00       	add    $0x803040,%eax
  8003b8:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #2
	i=PAGE_SIZE*1024;
	for(;i<PAGE_SIZE*1024+1;i++)
  8003bb:	ff 45 e4             	incl   -0x1c(%ebp)
  8003be:	81 7d e4 00 00 40 00 	cmpl   $0x400000,-0x1c(%ebp)
  8003c5:	7e e9                	jle    8003b0 <_main+0x378>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8003c7:	e8 c0 17 00 00       	call   801b8c <sys_calculate_notmod_frames>
  8003cc:	89 c2                	mov    %eax,%edx
  8003ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d3:	8b 40 4c             	mov    0x4c(%eax),%eax
  8003d6:	01 d0                	add    %edx,%eax
  8003d8:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #3
	i=PAGE_SIZE*1024*2;
  8003db:	c7 45 e4 00 00 80 00 	movl   $0x800000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*2+1;i++)
  8003e2:	eb 0e                	jmp    8003f2 <_main+0x3ba>
	{
		arr[i] = -1;
  8003e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003e7:	05 40 30 80 00       	add    $0x803040,%eax
  8003ec:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #3
	i=PAGE_SIZE*1024*2;
	for(;i<PAGE_SIZE*1024*2+1;i++)
  8003ef:	ff 45 e4             	incl   -0x1c(%ebp)
  8003f2:	81 7d e4 00 00 80 00 	cmpl   $0x800000,-0x1c(%ebp)
  8003f9:	7e e9                	jle    8003e4 <_main+0x3ac>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8003fb:	e8 8c 17 00 00       	call   801b8c <sys_calculate_notmod_frames>
  800400:	89 c2                	mov    %eax,%edx
  800402:	a1 20 30 80 00       	mov    0x803020,%eax
  800407:	8b 40 4c             	mov    0x4c(%eax),%eax
  80040a:	01 d0                	add    %edx,%eax
  80040c:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #4
	i=PAGE_SIZE*1024*3;
  80040f:	c7 45 e4 00 00 c0 00 	movl   $0xc00000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*3+1;i++)
  800416:	eb 0e                	jmp    800426 <_main+0x3ee>
	{
		arr[i] = -1;
  800418:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80041b:	05 40 30 80 00       	add    $0x803040,%eax
  800420:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #4
	i=PAGE_SIZE*1024*3;
	for(;i<PAGE_SIZE*1024*3+1;i++)
  800423:	ff 45 e4             	incl   -0x1c(%ebp)
  800426:	81 7d e4 00 00 c0 00 	cmpl   $0xc00000,-0x1c(%ebp)
  80042d:	7e e9                	jle    800418 <_main+0x3e0>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80042f:	e8 58 17 00 00       	call   801b8c <sys_calculate_notmod_frames>
  800434:	89 c2                	mov    %eax,%edx
  800436:	a1 20 30 80 00       	mov    0x803020,%eax
  80043b:	8b 40 4c             	mov    0x4c(%eax),%eax
  80043e:	01 d0                	add    %edx,%eax
  800440:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #5
	i=PAGE_SIZE*1024*4;
  800443:	c7 45 e4 00 00 00 01 	movl   $0x1000000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*4+1;i++)
  80044a:	eb 0e                	jmp    80045a <_main+0x422>
	{
		arr[i] = -1;
  80044c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80044f:	05 40 30 80 00       	add    $0x803040,%eax
  800454:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #5
	i=PAGE_SIZE*1024*4;
	for(;i<PAGE_SIZE*1024*4+1;i++)
  800457:	ff 45 e4             	incl   -0x1c(%ebp)
  80045a:	81 7d e4 00 00 00 01 	cmpl   $0x1000000,-0x1c(%ebp)
  800461:	7e e9                	jle    80044c <_main+0x414>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800463:	e8 24 17 00 00       	call   801b8c <sys_calculate_notmod_frames>
  800468:	89 c2                	mov    %eax,%edx
  80046a:	a1 20 30 80 00       	mov    0x803020,%eax
  80046f:	8b 40 4c             	mov    0x4c(%eax),%eax
  800472:	01 d0                	add    %edx,%eax
  800474:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #6
	i=PAGE_SIZE*1024*5;
  800477:	c7 45 e4 00 00 40 01 	movl   $0x1400000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*5+1;i++)
  80047e:	eb 0e                	jmp    80048e <_main+0x456>
	{
		arr[i] = -1;
  800480:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800483:	05 40 30 80 00       	add    $0x803040,%eax
  800488:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #6
	i=PAGE_SIZE*1024*5;
	for(;i<PAGE_SIZE*1024*5+1;i++)
  80048b:	ff 45 e4             	incl   -0x1c(%ebp)
  80048e:	81 7d e4 00 00 40 01 	cmpl   $0x1400000,-0x1c(%ebp)
  800495:	7e e9                	jle    800480 <_main+0x448>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800497:	e8 f0 16 00 00       	call   801b8c <sys_calculate_notmod_frames>
  80049c:	89 c2                	mov    %eax,%edx
  80049e:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a3:	8b 40 4c             	mov    0x4c(%eax),%eax
  8004a6:	01 d0                	add    %edx,%eax
  8004a8:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #7
	i=PAGE_SIZE*1024*6;
  8004ab:	c7 45 e4 00 00 80 01 	movl   $0x1800000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*6+1;i++)
  8004b2:	eb 0e                	jmp    8004c2 <_main+0x48a>
	{
		arr[i] = -1;
  8004b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004b7:	05 40 30 80 00       	add    $0x803040,%eax
  8004bc:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #7
	i=PAGE_SIZE*1024*6;
	for(;i<PAGE_SIZE*1024*6+1;i++)
  8004bf:	ff 45 e4             	incl   -0x1c(%ebp)
  8004c2:	81 7d e4 00 00 80 01 	cmpl   $0x1800000,-0x1c(%ebp)
  8004c9:	7e e9                	jle    8004b4 <_main+0x47c>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8004cb:	e8 bc 16 00 00       	call   801b8c <sys_calculate_notmod_frames>
  8004d0:	89 c2                	mov    %eax,%edx
  8004d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d7:	8b 40 4c             	mov    0x4c(%eax),%eax
  8004da:	01 d0                	add    %edx,%eax
  8004dc:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #8
	i=PAGE_SIZE*1024*7;
  8004df:	c7 45 e4 00 00 c0 01 	movl   $0x1c00000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*7+1;i++)
  8004e6:	eb 0e                	jmp    8004f6 <_main+0x4be>
	{
		arr[i] = -1;
  8004e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004eb:	05 40 30 80 00       	add    $0x803040,%eax
  8004f0:	c6 00 ff             	movb   $0xff,(%eax)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #8
	i=PAGE_SIZE*1024*7;
	for(;i<PAGE_SIZE*1024*7+1;i++)
  8004f3:	ff 45 e4             	incl   -0x1c(%ebp)
  8004f6:	81 7d e4 00 00 c0 01 	cmpl   $0x1c00000,-0x1c(%ebp)
  8004fd:	7e e9                	jle    8004e8 <_main+0x4b0>
	{
		arr[i] = -1;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8004ff:	e8 88 16 00 00       	call   801b8c <sys_calculate_notmod_frames>
  800504:	89 c2                	mov    %eax,%edx
  800506:	a1 20 30 80 00       	mov    0x803020,%eax
  80050b:	8b 40 4c             	mov    0x4c(%eax),%eax
  80050e:	01 d0                	add    %edx,%eax
  800510:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//TILL NOW: 8 pages were brought into MEM and be modified (7 unmodified should be buffered)
	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)
  800513:	e8 74 16 00 00       	call   801b8c <sys_calculate_notmod_frames>
  800518:	89 c2                	mov    %eax,%edx
  80051a:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80051d:	29 c2                	sub    %eax,%edx
  80051f:	89 d0                	mov    %edx,%eax
  800521:	83 f8 07             	cmp    $0x7,%eax
  800524:	74 23                	je     800549 <_main+0x511>
	{
		//sys_env_destroy(envIdSlave);
		panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list %d",sys_calculate_notmod_frames()  - initFreeBufCnt);
  800526:	e8 61 16 00 00       	call   801b8c <sys_calculate_notmod_frames>
  80052b:	89 c2                	mov    %eax,%edx
  80052d:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800530:	29 c2                	sub    %eax,%edx
  800532:	89 d0                	mov    %edx,%eax
  800534:	50                   	push   %eax
  800535:	68 a4 24 80 00       	push   $0x8024a4
  80053a:	68 83 00 00 00       	push   $0x83
  80053f:	68 c8 23 80 00       	push   $0x8023c8
  800544:	e8 64 04 00 00       	call   8009ad <_panic>
	}
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)
  800549:	e8 25 16 00 00       	call   801b73 <sys_calculate_modified_frames>
  80054e:	89 c2                	mov    %eax,%edx
  800550:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800553:	39 c2                	cmp    %eax,%edx
  800555:	74 17                	je     80056e <_main+0x536>
	{
		//sys_env_destroy(envIdSlave);
		panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800557:	83 ec 04             	sub    $0x4,%esp
  80055a:	68 08 25 80 00       	push   $0x802508
  80055f:	68 88 00 00 00       	push   $0x88
  800564:	68 c8 23 80 00       	push   $0x8023c8
  800569:	e8 3f 04 00 00       	call   8009ad <_panic>
	}

	initFreeBufCnt = sys_calculate_notmod_frames();
  80056e:	e8 19 16 00 00       	call   801b8c <sys_calculate_notmod_frames>
  800573:	89 45 a0             	mov    %eax,-0x60(%ebp)

	//The following 7 faults should victimize the 7 previously modified pages
	//(i.e. the modified list should be freed after 3 faults... then, two modified frames will be added to it again)
	//Fault #7
	i=PAGE_SIZE*1024*8;
  800576:	c7 45 e4 00 00 00 02 	movl   $0x2000000,-0x1c(%ebp)
	int s = 0;
  80057d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(;i<PAGE_SIZE*1024*8+1;i++)
  800584:	eb 13                	jmp    800599 <_main+0x561>
	{
		s += arr[i] ;
  800586:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800589:	05 40 30 80 00       	add    $0x803040,%eax
  80058e:	8a 00                	mov    (%eax),%al
  800590:	0f be c0             	movsbl %al,%eax
  800593:	01 45 e0             	add    %eax,-0x20(%ebp)
	//The following 7 faults should victimize the 7 previously modified pages
	//(i.e. the modified list should be freed after 3 faults... then, two modified frames will be added to it again)
	//Fault #7
	i=PAGE_SIZE*1024*8;
	int s = 0;
	for(;i<PAGE_SIZE*1024*8+1;i++)
  800596:	ff 45 e4             	incl   -0x1c(%ebp)
  800599:	81 7d e4 00 00 00 02 	cmpl   $0x2000000,-0x1c(%ebp)
  8005a0:	7e e4                	jle    800586 <_main+0x54e>
	{
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8005a2:	e8 e5 15 00 00       	call   801b8c <sys_calculate_notmod_frames>
  8005a7:	89 c2                	mov    %eax,%edx
  8005a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ae:	8b 40 4c             	mov    0x4c(%eax),%eax
  8005b1:	01 d0                	add    %edx,%eax
  8005b3:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #8
	i=PAGE_SIZE*1024*9;
  8005b6:	c7 45 e4 00 00 40 02 	movl   $0x2400000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*9+1;i++)
  8005bd:	eb 13                	jmp    8005d2 <_main+0x59a>
	{
		s += arr[i] ;
  8005bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005c2:	05 40 30 80 00       	add    $0x803040,%eax
  8005c7:	8a 00                	mov    (%eax),%al
  8005c9:	0f be c0             	movsbl %al,%eax
  8005cc:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #8
	i=PAGE_SIZE*1024*9;
	for(;i<PAGE_SIZE*1024*9+1;i++)
  8005cf:	ff 45 e4             	incl   -0x1c(%ebp)
  8005d2:	81 7d e4 00 00 40 02 	cmpl   $0x2400000,-0x1c(%ebp)
  8005d9:	7e e4                	jle    8005bf <_main+0x587>
	{
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8005db:	e8 ac 15 00 00       	call   801b8c <sys_calculate_notmod_frames>
  8005e0:	89 c2                	mov    %eax,%edx
  8005e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e7:	8b 40 4c             	mov    0x4c(%eax),%eax
  8005ea:	01 d0                	add    %edx,%eax
  8005ec:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #9
	i=PAGE_SIZE*1024*10;
  8005ef:	c7 45 e4 00 00 80 02 	movl   $0x2800000,-0x1c(%ebp)
	for(;i<PAGE_SIZE*1024*10+1;i++)
  8005f6:	eb 13                	jmp    80060b <_main+0x5d3>
	{
		s += arr[i] ;
  8005f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005fb:	05 40 30 80 00       	add    $0x803040,%eax
  800600:	8a 00                	mov    (%eax),%al
  800602:	0f be c0             	movsbl %al,%eax
  800605:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #9
	i=PAGE_SIZE*1024*10;
	for(;i<PAGE_SIZE*1024*10+1;i++)
  800608:	ff 45 e4             	incl   -0x1c(%ebp)
  80060b:	81 7d e4 00 00 80 02 	cmpl   $0x2800000,-0x1c(%ebp)
  800612:	7e e4                	jle    8005f8 <_main+0x5c0>
	{
		s += arr[i] ;
	}

	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800614:	e8 73 15 00 00       	call   801b8c <sys_calculate_notmod_frames>
  800619:	89 c2                	mov    %eax,%edx
  80061b:	a1 20 30 80 00       	mov    0x803020,%eax
  800620:	8b 40 4c             	mov    0x4c(%eax),%eax
  800623:	01 d0                	add    %edx,%eax
  800625:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//HERE: modified list should be freed
	if (sys_calculate_modified_frames() != 0)
  800628:	e8 46 15 00 00       	call   801b73 <sys_calculate_modified_frames>
  80062d:	85 c0                	test   %eax,%eax
  80062f:	74 17                	je     800648 <_main+0x610>
	{
		//sys_env_destroy(envIdSlave);
		panic("Modified frames not removed from list (or not updated) correctly when the modified list reaches MAX");
  800631:	83 ec 04             	sub    $0x4,%esp
  800634:	68 74 25 80 00       	push   $0x802574
  800639:	68 ad 00 00 00       	push   $0xad
  80063e:	68 c8 23 80 00       	push   $0x8023c8
  800643:	e8 65 03 00 00       	call   8009ad <_panic>
	}
	if ((sys_calculate_notmod_frames() - initFreeBufCnt) != 10)
  800648:	e8 3f 15 00 00       	call   801b8c <sys_calculate_notmod_frames>
  80064d:	89 c2                	mov    %eax,%edx
  80064f:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800652:	29 c2                	sub    %eax,%edx
  800654:	89 d0                	mov    %edx,%eax
  800656:	83 f8 0a             	cmp    $0xa,%eax
  800659:	74 17                	je     800672 <_main+0x63a>
	{
		//sys_env_destroy(envIdSlave);
		panic("Modified frames not added to free frame list as BUFFERED when the modified list reaches MAX");
  80065b:	83 ec 04             	sub    $0x4,%esp
  80065e:	68 d8 25 80 00       	push   $0x8025d8
  800663:	68 b2 00 00 00       	push   $0xb2
  800668:	68 c8 23 80 00       	push   $0x8023c8
  80066d:	e8 3b 03 00 00       	call   8009ad <_panic>
	}

	//Three additional fault (i.e. three modified page will be added to modified list)
	//Fault #10
	i = PAGE_SIZE * 1024 * 11;
  800672:	c7 45 e4 00 00 c0 02 	movl   $0x2c00000,-0x1c(%ebp)
	for (; i < PAGE_SIZE * 1024*11 + 1; i++) {
  800679:	eb 13                	jmp    80068e <_main+0x656>
		s += arr[i] ;
  80067b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80067e:	05 40 30 80 00       	add    $0x803040,%eax
  800683:	8a 00                	mov    (%eax),%al
  800685:	0f be c0             	movsbl %al,%eax
  800688:	01 45 e0             	add    %eax,-0x20(%ebp)
	}

	//Three additional fault (i.e. three modified page will be added to modified list)
	//Fault #10
	i = PAGE_SIZE * 1024 * 11;
	for (; i < PAGE_SIZE * 1024*11 + 1; i++) {
  80068b:	ff 45 e4             	incl   -0x1c(%ebp)
  80068e:	81 7d e4 00 00 c0 02 	cmpl   $0x2c00000,-0x1c(%ebp)
  800695:	7e e4                	jle    80067b <_main+0x643>
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800697:	e8 f0 14 00 00       	call   801b8c <sys_calculate_notmod_frames>
  80069c:	89 c2                	mov    %eax,%edx
  80069e:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a3:	8b 40 4c             	mov    0x4c(%eax),%eax
  8006a6:	01 d0                	add    %edx,%eax
  8006a8:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #11
	i = PAGE_SIZE * 1024 * 12;
  8006ab:	c7 45 e4 00 00 00 03 	movl   $0x3000000,-0x1c(%ebp)
	for (; i < PAGE_SIZE * 1024*12 + 1; i++) {
  8006b2:	eb 13                	jmp    8006c7 <_main+0x68f>
		s += arr[i] ;
  8006b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006b7:	05 40 30 80 00       	add    $0x803040,%eax
  8006bc:	8a 00                	mov    (%eax),%al
  8006be:	0f be c0             	movsbl %al,%eax
  8006c1:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #11
	i = PAGE_SIZE * 1024 * 12;
	for (; i < PAGE_SIZE * 1024*12 + 1; i++) {
  8006c4:	ff 45 e4             	incl   -0x1c(%ebp)
  8006c7:	81 7d e4 00 00 00 03 	cmpl   $0x3000000,-0x1c(%ebp)
  8006ce:	7e e4                	jle    8006b4 <_main+0x67c>
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8006d0:	e8 b7 14 00 00       	call   801b8c <sys_calculate_notmod_frames>
  8006d5:	89 c2                	mov    %eax,%edx
  8006d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8006dc:	8b 40 4c             	mov    0x4c(%eax),%eax
  8006df:	01 d0                	add    %edx,%eax
  8006e1:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Fault #12
	i = PAGE_SIZE * 1024 * 13;
  8006e4:	c7 45 e4 00 00 40 03 	movl   $0x3400000,-0x1c(%ebp)
	for (; i < PAGE_SIZE * 1024*13 + 1; i++) {
  8006eb:	eb 13                	jmp    800700 <_main+0x6c8>
		s += arr[i] ;
  8006ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006f0:	05 40 30 80 00       	add    $0x803040,%eax
  8006f5:	8a 00                	mov    (%eax),%al
  8006f7:	0f be c0             	movsbl %al,%eax
  8006fa:	01 45 e0             	add    %eax,-0x20(%ebp)
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000

	//Fault #12
	i = PAGE_SIZE * 1024 * 13;
	for (; i < PAGE_SIZE * 1024*13 + 1; i++) {
  8006fd:	ff 45 e4             	incl   -0x1c(%ebp)
  800700:	81 7d e4 00 00 40 03 	cmpl   $0x3400000,-0x1c(%ebp)
  800707:	7e e4                	jle    8006ed <_main+0x6b5>
		s += arr[i] ;
	}
	dummy = sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800709:	e8 7e 14 00 00       	call   801b8c <sys_calculate_notmod_frames>
  80070e:	89 c2                	mov    %eax,%edx
  800710:	a1 20 30 80 00       	mov    0x803020,%eax
  800715:	8b 40 4c             	mov    0x4c(%eax),%eax
  800718:	01 d0                	add    %edx,%eax
  80071a:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//cprintf("testing...\n");
	{
		if (sys_calculate_modified_frames() != 3)
  80071d:	e8 51 14 00 00       	call   801b73 <sys_calculate_modified_frames>
  800722:	83 f8 03             	cmp    $0x3,%eax
  800725:	74 17                	je     80073e <_main+0x706>
		{
			//sys_env_destroy(envIdSlave);
			panic("Modified frames not removed from list (or not updated) correctly when the modified list reaches MAX");
  800727:	83 ec 04             	sub    $0x4,%esp
  80072a:	68 74 25 80 00       	push   $0x802574
  80072f:	68 d0 00 00 00       	push   $0xd0
  800734:	68 c8 23 80 00       	push   $0x8023c8
  800739:	e8 6f 02 00 00       	call   8009ad <_panic>
		}

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0)
  80073e:	e8 9a 14 00 00       	call   801bdd <sys_pf_calculate_allocated_pages>
  800743:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  800746:	74 17                	je     80075f <_main+0x727>
		{
			//sys_env_destroy(envIdSlave);
			panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  800748:	83 ec 04             	sub    $0x4,%esp
  80074b:	68 34 26 80 00       	push   $0x802634
  800750:	68 d6 00 00 00       	push   $0xd6
  800755:	68 c8 23 80 00       	push   $0x8023c8
  80075a:	e8 4e 02 00 00       	call   8009ad <_panic>
		}

		if( arr[0] != -1) 						{/*sys_env_destroy(envIdSlave);*/panic("modified page not updated on page file OR not reclaimed correctly");}
  80075f:	a0 40 30 80 00       	mov    0x803040,%al
  800764:	3c ff                	cmp    $0xff,%al
  800766:	74 17                	je     80077f <_main+0x747>
  800768:	83 ec 04             	sub    $0x4,%esp
  80076b:	68 a0 26 80 00       	push   $0x8026a0
  800770:	68 d9 00 00 00       	push   $0xd9
  800775:	68 c8 23 80 00       	push   $0x8023c8
  80077a:	e8 2e 02 00 00       	call   8009ad <_panic>
		if( arr[PAGE_SIZE * 1024 * 1] != -1) 	{/*sys_env_destroy(envIdSlave);*/panic("modified page not updated on page file OR not reclaimed correctly");}
  80077f:	a0 40 30 c0 00       	mov    0xc03040,%al
  800784:	3c ff                	cmp    $0xff,%al
  800786:	74 17                	je     80079f <_main+0x767>
  800788:	83 ec 04             	sub    $0x4,%esp
  80078b:	68 a0 26 80 00       	push   $0x8026a0
  800790:	68 da 00 00 00       	push   $0xda
  800795:	68 c8 23 80 00       	push   $0x8023c8
  80079a:	e8 0e 02 00 00       	call   8009ad <_panic>
		if( arr[PAGE_SIZE * 1024 * 2] != -1) 	{/*sys_env_destroy(envIdSlave);*/panic("modified page not updated on page file OR not reclaimed correctly");}
  80079f:	a0 40 30 00 01       	mov    0x1003040,%al
  8007a4:	3c ff                	cmp    $0xff,%al
  8007a6:	74 17                	je     8007bf <_main+0x787>
  8007a8:	83 ec 04             	sub    $0x4,%esp
  8007ab:	68 a0 26 80 00       	push   $0x8026a0
  8007b0:	68 db 00 00 00       	push   $0xdb
  8007b5:	68 c8 23 80 00       	push   $0x8023c8
  8007ba:	e8 ee 01 00 00       	call   8009ad <_panic>
		if( arr[PAGE_SIZE * 1024 * 3] != -1) 	{/*sys_env_destroy(envIdSlave);*/panic("modified page not updated on page file OR not reclaimed correctly");}
  8007bf:	a0 40 30 40 01       	mov    0x1403040,%al
  8007c4:	3c ff                	cmp    $0xff,%al
  8007c6:	74 17                	je     8007df <_main+0x7a7>
  8007c8:	83 ec 04             	sub    $0x4,%esp
  8007cb:	68 a0 26 80 00       	push   $0x8026a0
  8007d0:	68 dc 00 00 00       	push   $0xdc
  8007d5:	68 c8 23 80 00       	push   $0x8023c8
  8007da:	e8 ce 01 00 00       	call   8009ad <_panic>
		if( arr[PAGE_SIZE * 1024 * 4] != -1) 	{/*sys_env_destroy(envIdSlave);*/panic("modified page not updated on page file OR not reclaimed correctly");}
  8007df:	a0 40 30 80 01       	mov    0x1803040,%al
  8007e4:	3c ff                	cmp    $0xff,%al
  8007e6:	74 17                	je     8007ff <_main+0x7c7>
  8007e8:	83 ec 04             	sub    $0x4,%esp
  8007eb:	68 a0 26 80 00       	push   $0x8026a0
  8007f0:	68 dd 00 00 00       	push   $0xdd
  8007f5:	68 c8 23 80 00       	push   $0x8023c8
  8007fa:	e8 ae 01 00 00       	call   8009ad <_panic>
		if( arr[PAGE_SIZE * 1024 * 5] != -1) 	{/*sys_env_destroy(envIdSlave);*/panic("modified page not updated on page file OR not reclaimed correctly");}
  8007ff:	a0 40 30 c0 01       	mov    0x1c03040,%al
  800804:	3c ff                	cmp    $0xff,%al
  800806:	74 17                	je     80081f <_main+0x7e7>
  800808:	83 ec 04             	sub    $0x4,%esp
  80080b:	68 a0 26 80 00       	push   $0x8026a0
  800810:	68 de 00 00 00       	push   $0xde
  800815:	68 c8 23 80 00       	push   $0x8023c8
  80081a:	e8 8e 01 00 00       	call   8009ad <_panic>
		if( arr[PAGE_SIZE * 1024 * 6] != -1) 	{/*sys_env_destroy(envIdSlave);*/panic("modified page not updated on page file OR not reclaimed correctly");}
  80081f:	a0 40 30 00 02       	mov    0x2003040,%al
  800824:	3c ff                	cmp    $0xff,%al
  800826:	74 17                	je     80083f <_main+0x807>
  800828:	83 ec 04             	sub    $0x4,%esp
  80082b:	68 a0 26 80 00       	push   $0x8026a0
  800830:	68 df 00 00 00       	push   $0xdf
  800835:	68 c8 23 80 00       	push   $0x8023c8
  80083a:	e8 6e 01 00 00       	call   8009ad <_panic>
		if( arr[PAGE_SIZE * 1024 * 7] != -1) 	{/*sys_env_destroy(envIdSlave);*/panic("modified page not updated on page file OR not reclaimed correctly");}
  80083f:	a0 40 30 40 02       	mov    0x2403040,%al
  800844:	3c ff                	cmp    $0xff,%al
  800846:	74 17                	je     80085f <_main+0x827>
  800848:	83 ec 04             	sub    $0x4,%esp
  80084b:	68 a0 26 80 00       	push   $0x8026a0
  800850:	68 e0 00 00 00       	push   $0xe0
  800855:	68 c8 23 80 00       	push   $0x8023c8
  80085a:	e8 4e 01 00 00       	call   8009ad <_panic>

		if (sys_calculate_modified_frames() != 0) {/*sys_env_destroy(envIdSlave);*/panic("Modified frames not removed from list (or isModified/modified bit is not updated) correctly when the modified list reaches MAX");}
  80085f:	e8 0f 13 00 00       	call   801b73 <sys_calculate_modified_frames>
  800864:	85 c0                	test   %eax,%eax
  800866:	74 17                	je     80087f <_main+0x847>
  800868:	83 ec 04             	sub    $0x4,%esp
  80086b:	68 e4 26 80 00       	push   $0x8026e4
  800870:	68 e2 00 00 00       	push   $0xe2
  800875:	68 c8 23 80 00       	push   $0x8023c8
  80087a:	e8 2e 01 00 00       	call   8009ad <_panic>
	}

	return;
  80087f:	90                   	nop
}
  800880:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800883:	5b                   	pop    %ebx
  800884:	5e                   	pop    %esi
  800885:	5f                   	pop    %edi
  800886:	5d                   	pop    %ebp
  800887:	c3                   	ret    

00800888 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800888:	55                   	push   %ebp
  800889:	89 e5                	mov    %esp,%ebp
  80088b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80088e:	e8 fc 11 00 00       	call   801a8f <sys_getenvindex>
  800893:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800896:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800899:	89 d0                	mov    %edx,%eax
  80089b:	c1 e0 03             	shl    $0x3,%eax
  80089e:	01 d0                	add    %edx,%eax
  8008a0:	c1 e0 02             	shl    $0x2,%eax
  8008a3:	01 d0                	add    %edx,%eax
  8008a5:	c1 e0 06             	shl    $0x6,%eax
  8008a8:	29 d0                	sub    %edx,%eax
  8008aa:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8008b1:	01 c8                	add    %ecx,%eax
  8008b3:	01 d0                	add    %edx,%eax
  8008b5:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8008ba:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8008bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8008c4:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8008ca:	84 c0                	test   %al,%al
  8008cc:	74 0f                	je     8008dd <libmain+0x55>
		binaryname = myEnv->prog_name;
  8008ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8008d3:	05 b0 52 00 00       	add    $0x52b0,%eax
  8008d8:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8008dd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008e1:	7e 0a                	jle    8008ed <libmain+0x65>
		binaryname = argv[0];
  8008e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e6:	8b 00                	mov    (%eax),%eax
  8008e8:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8008ed:	83 ec 08             	sub    $0x8,%esp
  8008f0:	ff 75 0c             	pushl  0xc(%ebp)
  8008f3:	ff 75 08             	pushl  0x8(%ebp)
  8008f6:	e8 3d f7 ff ff       	call   800038 <_main>
  8008fb:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8008fe:	e8 27 13 00 00       	call   801c2a <sys_disable_interrupt>
	cprintf("**************************************\n");
  800903:	83 ec 0c             	sub    $0xc,%esp
  800906:	68 88 27 80 00       	push   $0x802788
  80090b:	e8 54 03 00 00       	call   800c64 <cprintf>
  800910:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800913:	a1 20 30 80 00       	mov    0x803020,%eax
  800918:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  80091e:	a1 20 30 80 00       	mov    0x803020,%eax
  800923:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800929:	83 ec 04             	sub    $0x4,%esp
  80092c:	52                   	push   %edx
  80092d:	50                   	push   %eax
  80092e:	68 b0 27 80 00       	push   $0x8027b0
  800933:	e8 2c 03 00 00       	call   800c64 <cprintf>
  800938:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80093b:	a1 20 30 80 00       	mov    0x803020,%eax
  800940:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800946:	a1 20 30 80 00       	mov    0x803020,%eax
  80094b:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800951:	a1 20 30 80 00       	mov    0x803020,%eax
  800956:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  80095c:	51                   	push   %ecx
  80095d:	52                   	push   %edx
  80095e:	50                   	push   %eax
  80095f:	68 d8 27 80 00       	push   $0x8027d8
  800964:	e8 fb 02 00 00       	call   800c64 <cprintf>
  800969:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80096c:	83 ec 0c             	sub    $0xc,%esp
  80096f:	68 88 27 80 00       	push   $0x802788
  800974:	e8 eb 02 00 00       	call   800c64 <cprintf>
  800979:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80097c:	e8 c3 12 00 00       	call   801c44 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800981:	e8 19 00 00 00       	call   80099f <exit>
}
  800986:	90                   	nop
  800987:	c9                   	leave  
  800988:	c3                   	ret    

00800989 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800989:	55                   	push   %ebp
  80098a:	89 e5                	mov    %esp,%ebp
  80098c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80098f:	83 ec 0c             	sub    $0xc,%esp
  800992:	6a 00                	push   $0x0
  800994:	e8 c2 10 00 00       	call   801a5b <sys_env_destroy>
  800999:	83 c4 10             	add    $0x10,%esp
}
  80099c:	90                   	nop
  80099d:	c9                   	leave  
  80099e:	c3                   	ret    

0080099f <exit>:

void
exit(void)
{
  80099f:	55                   	push   %ebp
  8009a0:	89 e5                	mov    %esp,%ebp
  8009a2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8009a5:	e8 17 11 00 00       	call   801ac1 <sys_env_exit>
}
  8009aa:	90                   	nop
  8009ab:	c9                   	leave  
  8009ac:	c3                   	ret    

008009ad <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8009ad:	55                   	push   %ebp
  8009ae:	89 e5                	mov    %esp,%ebp
  8009b0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8009b3:	8d 45 10             	lea    0x10(%ebp),%eax
  8009b6:	83 c0 04             	add    $0x4,%eax
  8009b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8009bc:	a1 18 41 00 04       	mov    0x4004118,%eax
  8009c1:	85 c0                	test   %eax,%eax
  8009c3:	74 16                	je     8009db <_panic+0x2e>
		cprintf("%s: ", argv0);
  8009c5:	a1 18 41 00 04       	mov    0x4004118,%eax
  8009ca:	83 ec 08             	sub    $0x8,%esp
  8009cd:	50                   	push   %eax
  8009ce:	68 30 28 80 00       	push   $0x802830
  8009d3:	e8 8c 02 00 00       	call   800c64 <cprintf>
  8009d8:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8009db:	a1 00 30 80 00       	mov    0x803000,%eax
  8009e0:	ff 75 0c             	pushl  0xc(%ebp)
  8009e3:	ff 75 08             	pushl  0x8(%ebp)
  8009e6:	50                   	push   %eax
  8009e7:	68 35 28 80 00       	push   $0x802835
  8009ec:	e8 73 02 00 00       	call   800c64 <cprintf>
  8009f1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8009f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f7:	83 ec 08             	sub    $0x8,%esp
  8009fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8009fd:	50                   	push   %eax
  8009fe:	e8 f6 01 00 00       	call   800bf9 <vcprintf>
  800a03:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a06:	83 ec 08             	sub    $0x8,%esp
  800a09:	6a 00                	push   $0x0
  800a0b:	68 51 28 80 00       	push   $0x802851
  800a10:	e8 e4 01 00 00       	call   800bf9 <vcprintf>
  800a15:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a18:	e8 82 ff ff ff       	call   80099f <exit>

	// should not return here
	while (1) ;
  800a1d:	eb fe                	jmp    800a1d <_panic+0x70>

00800a1f <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a1f:	55                   	push   %ebp
  800a20:	89 e5                	mov    %esp,%ebp
  800a22:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a25:	a1 20 30 80 00       	mov    0x803020,%eax
  800a2a:	8b 50 74             	mov    0x74(%eax),%edx
  800a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a30:	39 c2                	cmp    %eax,%edx
  800a32:	74 14                	je     800a48 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a34:	83 ec 04             	sub    $0x4,%esp
  800a37:	68 54 28 80 00       	push   $0x802854
  800a3c:	6a 26                	push   $0x26
  800a3e:	68 a0 28 80 00       	push   $0x8028a0
  800a43:	e8 65 ff ff ff       	call   8009ad <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a48:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a4f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a56:	e9 c4 00 00 00       	jmp    800b1f <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800a5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a5e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a65:	8b 45 08             	mov    0x8(%ebp),%eax
  800a68:	01 d0                	add    %edx,%eax
  800a6a:	8b 00                	mov    (%eax),%eax
  800a6c:	85 c0                	test   %eax,%eax
  800a6e:	75 08                	jne    800a78 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800a70:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a73:	e9 a4 00 00 00       	jmp    800b1c <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800a78:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a7f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a86:	eb 6b                	jmp    800af3 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a88:	a1 20 30 80 00       	mov    0x803020,%eax
  800a8d:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800a93:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a96:	89 d0                	mov    %edx,%eax
  800a98:	c1 e0 02             	shl    $0x2,%eax
  800a9b:	01 d0                	add    %edx,%eax
  800a9d:	c1 e0 02             	shl    $0x2,%eax
  800aa0:	01 c8                	add    %ecx,%eax
  800aa2:	8a 40 04             	mov    0x4(%eax),%al
  800aa5:	84 c0                	test   %al,%al
  800aa7:	75 47                	jne    800af0 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800aa9:	a1 20 30 80 00       	mov    0x803020,%eax
  800aae:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800ab4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800ab7:	89 d0                	mov    %edx,%eax
  800ab9:	c1 e0 02             	shl    $0x2,%eax
  800abc:	01 d0                	add    %edx,%eax
  800abe:	c1 e0 02             	shl    $0x2,%eax
  800ac1:	01 c8                	add    %ecx,%eax
  800ac3:	8b 00                	mov    (%eax),%eax
  800ac5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800ac8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800acb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ad0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800ad2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ad5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	01 c8                	add    %ecx,%eax
  800ae1:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800ae3:	39 c2                	cmp    %eax,%edx
  800ae5:	75 09                	jne    800af0 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800ae7:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800aee:	eb 12                	jmp    800b02 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800af0:	ff 45 e8             	incl   -0x18(%ebp)
  800af3:	a1 20 30 80 00       	mov    0x803020,%eax
  800af8:	8b 50 74             	mov    0x74(%eax),%edx
  800afb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800afe:	39 c2                	cmp    %eax,%edx
  800b00:	77 86                	ja     800a88 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b02:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b06:	75 14                	jne    800b1c <CheckWSWithoutLastIndex+0xfd>
			panic(
  800b08:	83 ec 04             	sub    $0x4,%esp
  800b0b:	68 ac 28 80 00       	push   $0x8028ac
  800b10:	6a 3a                	push   $0x3a
  800b12:	68 a0 28 80 00       	push   $0x8028a0
  800b17:	e8 91 fe ff ff       	call   8009ad <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b1c:	ff 45 f0             	incl   -0x10(%ebp)
  800b1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b22:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b25:	0f 8c 30 ff ff ff    	jl     800a5b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b2b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b32:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b39:	eb 27                	jmp    800b62 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b3b:	a1 20 30 80 00       	mov    0x803020,%eax
  800b40:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800b46:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b49:	89 d0                	mov    %edx,%eax
  800b4b:	c1 e0 02             	shl    $0x2,%eax
  800b4e:	01 d0                	add    %edx,%eax
  800b50:	c1 e0 02             	shl    $0x2,%eax
  800b53:	01 c8                	add    %ecx,%eax
  800b55:	8a 40 04             	mov    0x4(%eax),%al
  800b58:	3c 01                	cmp    $0x1,%al
  800b5a:	75 03                	jne    800b5f <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800b5c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b5f:	ff 45 e0             	incl   -0x20(%ebp)
  800b62:	a1 20 30 80 00       	mov    0x803020,%eax
  800b67:	8b 50 74             	mov    0x74(%eax),%edx
  800b6a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b6d:	39 c2                	cmp    %eax,%edx
  800b6f:	77 ca                	ja     800b3b <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b71:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b74:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b77:	74 14                	je     800b8d <CheckWSWithoutLastIndex+0x16e>
		panic(
  800b79:	83 ec 04             	sub    $0x4,%esp
  800b7c:	68 00 29 80 00       	push   $0x802900
  800b81:	6a 44                	push   $0x44
  800b83:	68 a0 28 80 00       	push   $0x8028a0
  800b88:	e8 20 fe ff ff       	call   8009ad <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b8d:	90                   	nop
  800b8e:	c9                   	leave  
  800b8f:	c3                   	ret    

00800b90 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800b90:	55                   	push   %ebp
  800b91:	89 e5                	mov    %esp,%ebp
  800b93:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800b96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b99:	8b 00                	mov    (%eax),%eax
  800b9b:	8d 48 01             	lea    0x1(%eax),%ecx
  800b9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ba1:	89 0a                	mov    %ecx,(%edx)
  800ba3:	8b 55 08             	mov    0x8(%ebp),%edx
  800ba6:	88 d1                	mov    %dl,%cl
  800ba8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bab:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800baf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb2:	8b 00                	mov    (%eax),%eax
  800bb4:	3d ff 00 00 00       	cmp    $0xff,%eax
  800bb9:	75 2c                	jne    800be7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800bbb:	a0 24 30 80 00       	mov    0x803024,%al
  800bc0:	0f b6 c0             	movzbl %al,%eax
  800bc3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc6:	8b 12                	mov    (%edx),%edx
  800bc8:	89 d1                	mov    %edx,%ecx
  800bca:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bcd:	83 c2 08             	add    $0x8,%edx
  800bd0:	83 ec 04             	sub    $0x4,%esp
  800bd3:	50                   	push   %eax
  800bd4:	51                   	push   %ecx
  800bd5:	52                   	push   %edx
  800bd6:	e8 3e 0e 00 00       	call   801a19 <sys_cputs>
  800bdb:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800bde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800be7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bea:	8b 40 04             	mov    0x4(%eax),%eax
  800bed:	8d 50 01             	lea    0x1(%eax),%edx
  800bf0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf3:	89 50 04             	mov    %edx,0x4(%eax)
}
  800bf6:	90                   	nop
  800bf7:	c9                   	leave  
  800bf8:	c3                   	ret    

00800bf9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800bf9:	55                   	push   %ebp
  800bfa:	89 e5                	mov    %esp,%ebp
  800bfc:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c02:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c09:	00 00 00 
	b.cnt = 0;
  800c0c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c13:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c16:	ff 75 0c             	pushl  0xc(%ebp)
  800c19:	ff 75 08             	pushl  0x8(%ebp)
  800c1c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c22:	50                   	push   %eax
  800c23:	68 90 0b 80 00       	push   $0x800b90
  800c28:	e8 11 02 00 00       	call   800e3e <vprintfmt>
  800c2d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c30:	a0 24 30 80 00       	mov    0x803024,%al
  800c35:	0f b6 c0             	movzbl %al,%eax
  800c38:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c3e:	83 ec 04             	sub    $0x4,%esp
  800c41:	50                   	push   %eax
  800c42:	52                   	push   %edx
  800c43:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c49:	83 c0 08             	add    $0x8,%eax
  800c4c:	50                   	push   %eax
  800c4d:	e8 c7 0d 00 00       	call   801a19 <sys_cputs>
  800c52:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c55:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800c5c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c62:	c9                   	leave  
  800c63:	c3                   	ret    

00800c64 <cprintf>:

int cprintf(const char *fmt, ...) {
  800c64:	55                   	push   %ebp
  800c65:	89 e5                	mov    %esp,%ebp
  800c67:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c6a:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800c71:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c74:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7a:	83 ec 08             	sub    $0x8,%esp
  800c7d:	ff 75 f4             	pushl  -0xc(%ebp)
  800c80:	50                   	push   %eax
  800c81:	e8 73 ff ff ff       	call   800bf9 <vcprintf>
  800c86:	83 c4 10             	add    $0x10,%esp
  800c89:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c8f:	c9                   	leave  
  800c90:	c3                   	ret    

00800c91 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800c91:	55                   	push   %ebp
  800c92:	89 e5                	mov    %esp,%ebp
  800c94:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800c97:	e8 8e 0f 00 00       	call   801c2a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800c9c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca5:	83 ec 08             	sub    $0x8,%esp
  800ca8:	ff 75 f4             	pushl  -0xc(%ebp)
  800cab:	50                   	push   %eax
  800cac:	e8 48 ff ff ff       	call   800bf9 <vcprintf>
  800cb1:	83 c4 10             	add    $0x10,%esp
  800cb4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800cb7:	e8 88 0f 00 00       	call   801c44 <sys_enable_interrupt>
	return cnt;
  800cbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cbf:	c9                   	leave  
  800cc0:	c3                   	ret    

00800cc1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800cc1:	55                   	push   %ebp
  800cc2:	89 e5                	mov    %esp,%ebp
  800cc4:	53                   	push   %ebx
  800cc5:	83 ec 14             	sub    $0x14,%esp
  800cc8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cce:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800cd4:	8b 45 18             	mov    0x18(%ebp),%eax
  800cd7:	ba 00 00 00 00       	mov    $0x0,%edx
  800cdc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800cdf:	77 55                	ja     800d36 <printnum+0x75>
  800ce1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ce4:	72 05                	jb     800ceb <printnum+0x2a>
  800ce6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ce9:	77 4b                	ja     800d36 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800ceb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800cee:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800cf1:	8b 45 18             	mov    0x18(%ebp),%eax
  800cf4:	ba 00 00 00 00       	mov    $0x0,%edx
  800cf9:	52                   	push   %edx
  800cfa:	50                   	push   %eax
  800cfb:	ff 75 f4             	pushl  -0xc(%ebp)
  800cfe:	ff 75 f0             	pushl  -0x10(%ebp)
  800d01:	e8 16 14 00 00       	call   80211c <__udivdi3>
  800d06:	83 c4 10             	add    $0x10,%esp
  800d09:	83 ec 04             	sub    $0x4,%esp
  800d0c:	ff 75 20             	pushl  0x20(%ebp)
  800d0f:	53                   	push   %ebx
  800d10:	ff 75 18             	pushl  0x18(%ebp)
  800d13:	52                   	push   %edx
  800d14:	50                   	push   %eax
  800d15:	ff 75 0c             	pushl  0xc(%ebp)
  800d18:	ff 75 08             	pushl  0x8(%ebp)
  800d1b:	e8 a1 ff ff ff       	call   800cc1 <printnum>
  800d20:	83 c4 20             	add    $0x20,%esp
  800d23:	eb 1a                	jmp    800d3f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d25:	83 ec 08             	sub    $0x8,%esp
  800d28:	ff 75 0c             	pushl  0xc(%ebp)
  800d2b:	ff 75 20             	pushl  0x20(%ebp)
  800d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d31:	ff d0                	call   *%eax
  800d33:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d36:	ff 4d 1c             	decl   0x1c(%ebp)
  800d39:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d3d:	7f e6                	jg     800d25 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d3f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d42:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d47:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d4d:	53                   	push   %ebx
  800d4e:	51                   	push   %ecx
  800d4f:	52                   	push   %edx
  800d50:	50                   	push   %eax
  800d51:	e8 d6 14 00 00       	call   80222c <__umoddi3>
  800d56:	83 c4 10             	add    $0x10,%esp
  800d59:	05 74 2b 80 00       	add    $0x802b74,%eax
  800d5e:	8a 00                	mov    (%eax),%al
  800d60:	0f be c0             	movsbl %al,%eax
  800d63:	83 ec 08             	sub    $0x8,%esp
  800d66:	ff 75 0c             	pushl  0xc(%ebp)
  800d69:	50                   	push   %eax
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	ff d0                	call   *%eax
  800d6f:	83 c4 10             	add    $0x10,%esp
}
  800d72:	90                   	nop
  800d73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800d76:	c9                   	leave  
  800d77:	c3                   	ret    

00800d78 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800d78:	55                   	push   %ebp
  800d79:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d7b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d7f:	7e 1c                	jle    800d9d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	8b 00                	mov    (%eax),%eax
  800d86:	8d 50 08             	lea    0x8(%eax),%edx
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	89 10                	mov    %edx,(%eax)
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	8b 00                	mov    (%eax),%eax
  800d93:	83 e8 08             	sub    $0x8,%eax
  800d96:	8b 50 04             	mov    0x4(%eax),%edx
  800d99:	8b 00                	mov    (%eax),%eax
  800d9b:	eb 40                	jmp    800ddd <getuint+0x65>
	else if (lflag)
  800d9d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800da1:	74 1e                	je     800dc1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
  800da6:	8b 00                	mov    (%eax),%eax
  800da8:	8d 50 04             	lea    0x4(%eax),%edx
  800dab:	8b 45 08             	mov    0x8(%ebp),%eax
  800dae:	89 10                	mov    %edx,(%eax)
  800db0:	8b 45 08             	mov    0x8(%ebp),%eax
  800db3:	8b 00                	mov    (%eax),%eax
  800db5:	83 e8 04             	sub    $0x4,%eax
  800db8:	8b 00                	mov    (%eax),%eax
  800dba:	ba 00 00 00 00       	mov    $0x0,%edx
  800dbf:	eb 1c                	jmp    800ddd <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	8b 00                	mov    (%eax),%eax
  800dc6:	8d 50 04             	lea    0x4(%eax),%edx
  800dc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcc:	89 10                	mov    %edx,(%eax)
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	8b 00                	mov    (%eax),%eax
  800dd3:	83 e8 04             	sub    $0x4,%eax
  800dd6:	8b 00                	mov    (%eax),%eax
  800dd8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800ddd:	5d                   	pop    %ebp
  800dde:	c3                   	ret    

00800ddf <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ddf:	55                   	push   %ebp
  800de0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800de2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800de6:	7e 1c                	jle    800e04 <getint+0x25>
		return va_arg(*ap, long long);
  800de8:	8b 45 08             	mov    0x8(%ebp),%eax
  800deb:	8b 00                	mov    (%eax),%eax
  800ded:	8d 50 08             	lea    0x8(%eax),%edx
  800df0:	8b 45 08             	mov    0x8(%ebp),%eax
  800df3:	89 10                	mov    %edx,(%eax)
  800df5:	8b 45 08             	mov    0x8(%ebp),%eax
  800df8:	8b 00                	mov    (%eax),%eax
  800dfa:	83 e8 08             	sub    $0x8,%eax
  800dfd:	8b 50 04             	mov    0x4(%eax),%edx
  800e00:	8b 00                	mov    (%eax),%eax
  800e02:	eb 38                	jmp    800e3c <getint+0x5d>
	else if (lflag)
  800e04:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e08:	74 1a                	je     800e24 <getint+0x45>
		return va_arg(*ap, long);
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0d:	8b 00                	mov    (%eax),%eax
  800e0f:	8d 50 04             	lea    0x4(%eax),%edx
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	89 10                	mov    %edx,(%eax)
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1a:	8b 00                	mov    (%eax),%eax
  800e1c:	83 e8 04             	sub    $0x4,%eax
  800e1f:	8b 00                	mov    (%eax),%eax
  800e21:	99                   	cltd   
  800e22:	eb 18                	jmp    800e3c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
  800e27:	8b 00                	mov    (%eax),%eax
  800e29:	8d 50 04             	lea    0x4(%eax),%edx
  800e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2f:	89 10                	mov    %edx,(%eax)
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	8b 00                	mov    (%eax),%eax
  800e36:	83 e8 04             	sub    $0x4,%eax
  800e39:	8b 00                	mov    (%eax),%eax
  800e3b:	99                   	cltd   
}
  800e3c:	5d                   	pop    %ebp
  800e3d:	c3                   	ret    

00800e3e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e3e:	55                   	push   %ebp
  800e3f:	89 e5                	mov    %esp,%ebp
  800e41:	56                   	push   %esi
  800e42:	53                   	push   %ebx
  800e43:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e46:	eb 17                	jmp    800e5f <vprintfmt+0x21>
			if (ch == '\0')
  800e48:	85 db                	test   %ebx,%ebx
  800e4a:	0f 84 af 03 00 00    	je     8011ff <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800e50:	83 ec 08             	sub    $0x8,%esp
  800e53:	ff 75 0c             	pushl  0xc(%ebp)
  800e56:	53                   	push   %ebx
  800e57:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5a:	ff d0                	call   *%eax
  800e5c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e62:	8d 50 01             	lea    0x1(%eax),%edx
  800e65:	89 55 10             	mov    %edx,0x10(%ebp)
  800e68:	8a 00                	mov    (%eax),%al
  800e6a:	0f b6 d8             	movzbl %al,%ebx
  800e6d:	83 fb 25             	cmp    $0x25,%ebx
  800e70:	75 d6                	jne    800e48 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800e72:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800e76:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800e7d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800e84:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800e8b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800e92:	8b 45 10             	mov    0x10(%ebp),%eax
  800e95:	8d 50 01             	lea    0x1(%eax),%edx
  800e98:	89 55 10             	mov    %edx,0x10(%ebp)
  800e9b:	8a 00                	mov    (%eax),%al
  800e9d:	0f b6 d8             	movzbl %al,%ebx
  800ea0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ea3:	83 f8 55             	cmp    $0x55,%eax
  800ea6:	0f 87 2b 03 00 00    	ja     8011d7 <vprintfmt+0x399>
  800eac:	8b 04 85 98 2b 80 00 	mov    0x802b98(,%eax,4),%eax
  800eb3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800eb5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800eb9:	eb d7                	jmp    800e92 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ebb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ebf:	eb d1                	jmp    800e92 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ec1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ec8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ecb:	89 d0                	mov    %edx,%eax
  800ecd:	c1 e0 02             	shl    $0x2,%eax
  800ed0:	01 d0                	add    %edx,%eax
  800ed2:	01 c0                	add    %eax,%eax
  800ed4:	01 d8                	add    %ebx,%eax
  800ed6:	83 e8 30             	sub    $0x30,%eax
  800ed9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800edc:	8b 45 10             	mov    0x10(%ebp),%eax
  800edf:	8a 00                	mov    (%eax),%al
  800ee1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ee4:	83 fb 2f             	cmp    $0x2f,%ebx
  800ee7:	7e 3e                	jle    800f27 <vprintfmt+0xe9>
  800ee9:	83 fb 39             	cmp    $0x39,%ebx
  800eec:	7f 39                	jg     800f27 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800eee:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ef1:	eb d5                	jmp    800ec8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ef3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef6:	83 c0 04             	add    $0x4,%eax
  800ef9:	89 45 14             	mov    %eax,0x14(%ebp)
  800efc:	8b 45 14             	mov    0x14(%ebp),%eax
  800eff:	83 e8 04             	sub    $0x4,%eax
  800f02:	8b 00                	mov    (%eax),%eax
  800f04:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f07:	eb 1f                	jmp    800f28 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f09:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f0d:	79 83                	jns    800e92 <vprintfmt+0x54>
				width = 0;
  800f0f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f16:	e9 77 ff ff ff       	jmp    800e92 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f1b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f22:	e9 6b ff ff ff       	jmp    800e92 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f27:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f28:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f2c:	0f 89 60 ff ff ff    	jns    800e92 <vprintfmt+0x54>
				width = precision, precision = -1;
  800f32:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f38:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f3f:	e9 4e ff ff ff       	jmp    800e92 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f44:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f47:	e9 46 ff ff ff       	jmp    800e92 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4f:	83 c0 04             	add    $0x4,%eax
  800f52:	89 45 14             	mov    %eax,0x14(%ebp)
  800f55:	8b 45 14             	mov    0x14(%ebp),%eax
  800f58:	83 e8 04             	sub    $0x4,%eax
  800f5b:	8b 00                	mov    (%eax),%eax
  800f5d:	83 ec 08             	sub    $0x8,%esp
  800f60:	ff 75 0c             	pushl  0xc(%ebp)
  800f63:	50                   	push   %eax
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	ff d0                	call   *%eax
  800f69:	83 c4 10             	add    $0x10,%esp
			break;
  800f6c:	e9 89 02 00 00       	jmp    8011fa <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800f71:	8b 45 14             	mov    0x14(%ebp),%eax
  800f74:	83 c0 04             	add    $0x4,%eax
  800f77:	89 45 14             	mov    %eax,0x14(%ebp)
  800f7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f7d:	83 e8 04             	sub    $0x4,%eax
  800f80:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800f82:	85 db                	test   %ebx,%ebx
  800f84:	79 02                	jns    800f88 <vprintfmt+0x14a>
				err = -err;
  800f86:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800f88:	83 fb 64             	cmp    $0x64,%ebx
  800f8b:	7f 0b                	jg     800f98 <vprintfmt+0x15a>
  800f8d:	8b 34 9d e0 29 80 00 	mov    0x8029e0(,%ebx,4),%esi
  800f94:	85 f6                	test   %esi,%esi
  800f96:	75 19                	jne    800fb1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800f98:	53                   	push   %ebx
  800f99:	68 85 2b 80 00       	push   $0x802b85
  800f9e:	ff 75 0c             	pushl  0xc(%ebp)
  800fa1:	ff 75 08             	pushl  0x8(%ebp)
  800fa4:	e8 5e 02 00 00       	call   801207 <printfmt>
  800fa9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800fac:	e9 49 02 00 00       	jmp    8011fa <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800fb1:	56                   	push   %esi
  800fb2:	68 8e 2b 80 00       	push   $0x802b8e
  800fb7:	ff 75 0c             	pushl  0xc(%ebp)
  800fba:	ff 75 08             	pushl  0x8(%ebp)
  800fbd:	e8 45 02 00 00       	call   801207 <printfmt>
  800fc2:	83 c4 10             	add    $0x10,%esp
			break;
  800fc5:	e9 30 02 00 00       	jmp    8011fa <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800fca:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcd:	83 c0 04             	add    $0x4,%eax
  800fd0:	89 45 14             	mov    %eax,0x14(%ebp)
  800fd3:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd6:	83 e8 04             	sub    $0x4,%eax
  800fd9:	8b 30                	mov    (%eax),%esi
  800fdb:	85 f6                	test   %esi,%esi
  800fdd:	75 05                	jne    800fe4 <vprintfmt+0x1a6>
				p = "(null)";
  800fdf:	be 91 2b 80 00       	mov    $0x802b91,%esi
			if (width > 0 && padc != '-')
  800fe4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fe8:	7e 6d                	jle    801057 <vprintfmt+0x219>
  800fea:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800fee:	74 67                	je     801057 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800ff0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ff3:	83 ec 08             	sub    $0x8,%esp
  800ff6:	50                   	push   %eax
  800ff7:	56                   	push   %esi
  800ff8:	e8 0c 03 00 00       	call   801309 <strnlen>
  800ffd:	83 c4 10             	add    $0x10,%esp
  801000:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801003:	eb 16                	jmp    80101b <vprintfmt+0x1dd>
					putch(padc, putdat);
  801005:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801009:	83 ec 08             	sub    $0x8,%esp
  80100c:	ff 75 0c             	pushl  0xc(%ebp)
  80100f:	50                   	push   %eax
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	ff d0                	call   *%eax
  801015:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801018:	ff 4d e4             	decl   -0x1c(%ebp)
  80101b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80101f:	7f e4                	jg     801005 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801021:	eb 34                	jmp    801057 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801023:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801027:	74 1c                	je     801045 <vprintfmt+0x207>
  801029:	83 fb 1f             	cmp    $0x1f,%ebx
  80102c:	7e 05                	jle    801033 <vprintfmt+0x1f5>
  80102e:	83 fb 7e             	cmp    $0x7e,%ebx
  801031:	7e 12                	jle    801045 <vprintfmt+0x207>
					putch('?', putdat);
  801033:	83 ec 08             	sub    $0x8,%esp
  801036:	ff 75 0c             	pushl  0xc(%ebp)
  801039:	6a 3f                	push   $0x3f
  80103b:	8b 45 08             	mov    0x8(%ebp),%eax
  80103e:	ff d0                	call   *%eax
  801040:	83 c4 10             	add    $0x10,%esp
  801043:	eb 0f                	jmp    801054 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801045:	83 ec 08             	sub    $0x8,%esp
  801048:	ff 75 0c             	pushl  0xc(%ebp)
  80104b:	53                   	push   %ebx
  80104c:	8b 45 08             	mov    0x8(%ebp),%eax
  80104f:	ff d0                	call   *%eax
  801051:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801054:	ff 4d e4             	decl   -0x1c(%ebp)
  801057:	89 f0                	mov    %esi,%eax
  801059:	8d 70 01             	lea    0x1(%eax),%esi
  80105c:	8a 00                	mov    (%eax),%al
  80105e:	0f be d8             	movsbl %al,%ebx
  801061:	85 db                	test   %ebx,%ebx
  801063:	74 24                	je     801089 <vprintfmt+0x24b>
  801065:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801069:	78 b8                	js     801023 <vprintfmt+0x1e5>
  80106b:	ff 4d e0             	decl   -0x20(%ebp)
  80106e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801072:	79 af                	jns    801023 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801074:	eb 13                	jmp    801089 <vprintfmt+0x24b>
				putch(' ', putdat);
  801076:	83 ec 08             	sub    $0x8,%esp
  801079:	ff 75 0c             	pushl  0xc(%ebp)
  80107c:	6a 20                	push   $0x20
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
  801081:	ff d0                	call   *%eax
  801083:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801086:	ff 4d e4             	decl   -0x1c(%ebp)
  801089:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80108d:	7f e7                	jg     801076 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80108f:	e9 66 01 00 00       	jmp    8011fa <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801094:	83 ec 08             	sub    $0x8,%esp
  801097:	ff 75 e8             	pushl  -0x18(%ebp)
  80109a:	8d 45 14             	lea    0x14(%ebp),%eax
  80109d:	50                   	push   %eax
  80109e:	e8 3c fd ff ff       	call   800ddf <getint>
  8010a3:	83 c4 10             	add    $0x10,%esp
  8010a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010a9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8010ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010af:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b2:	85 d2                	test   %edx,%edx
  8010b4:	79 23                	jns    8010d9 <vprintfmt+0x29b>
				putch('-', putdat);
  8010b6:	83 ec 08             	sub    $0x8,%esp
  8010b9:	ff 75 0c             	pushl  0xc(%ebp)
  8010bc:	6a 2d                	push   $0x2d
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c1:	ff d0                	call   *%eax
  8010c3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8010c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010cc:	f7 d8                	neg    %eax
  8010ce:	83 d2 00             	adc    $0x0,%edx
  8010d1:	f7 da                	neg    %edx
  8010d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010d6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8010d9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010e0:	e9 bc 00 00 00       	jmp    8011a1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8010e5:	83 ec 08             	sub    $0x8,%esp
  8010e8:	ff 75 e8             	pushl  -0x18(%ebp)
  8010eb:	8d 45 14             	lea    0x14(%ebp),%eax
  8010ee:	50                   	push   %eax
  8010ef:	e8 84 fc ff ff       	call   800d78 <getuint>
  8010f4:	83 c4 10             	add    $0x10,%esp
  8010f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8010fd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801104:	e9 98 00 00 00       	jmp    8011a1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801109:	83 ec 08             	sub    $0x8,%esp
  80110c:	ff 75 0c             	pushl  0xc(%ebp)
  80110f:	6a 58                	push   $0x58
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	ff d0                	call   *%eax
  801116:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801119:	83 ec 08             	sub    $0x8,%esp
  80111c:	ff 75 0c             	pushl  0xc(%ebp)
  80111f:	6a 58                	push   $0x58
  801121:	8b 45 08             	mov    0x8(%ebp),%eax
  801124:	ff d0                	call   *%eax
  801126:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801129:	83 ec 08             	sub    $0x8,%esp
  80112c:	ff 75 0c             	pushl  0xc(%ebp)
  80112f:	6a 58                	push   $0x58
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	ff d0                	call   *%eax
  801136:	83 c4 10             	add    $0x10,%esp
			break;
  801139:	e9 bc 00 00 00       	jmp    8011fa <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80113e:	83 ec 08             	sub    $0x8,%esp
  801141:	ff 75 0c             	pushl  0xc(%ebp)
  801144:	6a 30                	push   $0x30
  801146:	8b 45 08             	mov    0x8(%ebp),%eax
  801149:	ff d0                	call   *%eax
  80114b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80114e:	83 ec 08             	sub    $0x8,%esp
  801151:	ff 75 0c             	pushl  0xc(%ebp)
  801154:	6a 78                	push   $0x78
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	ff d0                	call   *%eax
  80115b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80115e:	8b 45 14             	mov    0x14(%ebp),%eax
  801161:	83 c0 04             	add    $0x4,%eax
  801164:	89 45 14             	mov    %eax,0x14(%ebp)
  801167:	8b 45 14             	mov    0x14(%ebp),%eax
  80116a:	83 e8 04             	sub    $0x4,%eax
  80116d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80116f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801172:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801179:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801180:	eb 1f                	jmp    8011a1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801182:	83 ec 08             	sub    $0x8,%esp
  801185:	ff 75 e8             	pushl  -0x18(%ebp)
  801188:	8d 45 14             	lea    0x14(%ebp),%eax
  80118b:	50                   	push   %eax
  80118c:	e8 e7 fb ff ff       	call   800d78 <getuint>
  801191:	83 c4 10             	add    $0x10,%esp
  801194:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801197:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80119a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011a1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011a8:	83 ec 04             	sub    $0x4,%esp
  8011ab:	52                   	push   %edx
  8011ac:	ff 75 e4             	pushl  -0x1c(%ebp)
  8011af:	50                   	push   %eax
  8011b0:	ff 75 f4             	pushl  -0xc(%ebp)
  8011b3:	ff 75 f0             	pushl  -0x10(%ebp)
  8011b6:	ff 75 0c             	pushl  0xc(%ebp)
  8011b9:	ff 75 08             	pushl  0x8(%ebp)
  8011bc:	e8 00 fb ff ff       	call   800cc1 <printnum>
  8011c1:	83 c4 20             	add    $0x20,%esp
			break;
  8011c4:	eb 34                	jmp    8011fa <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8011c6:	83 ec 08             	sub    $0x8,%esp
  8011c9:	ff 75 0c             	pushl  0xc(%ebp)
  8011cc:	53                   	push   %ebx
  8011cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d0:	ff d0                	call   *%eax
  8011d2:	83 c4 10             	add    $0x10,%esp
			break;
  8011d5:	eb 23                	jmp    8011fa <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8011d7:	83 ec 08             	sub    $0x8,%esp
  8011da:	ff 75 0c             	pushl  0xc(%ebp)
  8011dd:	6a 25                	push   $0x25
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e2:	ff d0                	call   *%eax
  8011e4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8011e7:	ff 4d 10             	decl   0x10(%ebp)
  8011ea:	eb 03                	jmp    8011ef <vprintfmt+0x3b1>
  8011ec:	ff 4d 10             	decl   0x10(%ebp)
  8011ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f2:	48                   	dec    %eax
  8011f3:	8a 00                	mov    (%eax),%al
  8011f5:	3c 25                	cmp    $0x25,%al
  8011f7:	75 f3                	jne    8011ec <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8011f9:	90                   	nop
		}
	}
  8011fa:	e9 47 fc ff ff       	jmp    800e46 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8011ff:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801200:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801203:	5b                   	pop    %ebx
  801204:	5e                   	pop    %esi
  801205:	5d                   	pop    %ebp
  801206:	c3                   	ret    

00801207 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801207:	55                   	push   %ebp
  801208:	89 e5                	mov    %esp,%ebp
  80120a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80120d:	8d 45 10             	lea    0x10(%ebp),%eax
  801210:	83 c0 04             	add    $0x4,%eax
  801213:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801216:	8b 45 10             	mov    0x10(%ebp),%eax
  801219:	ff 75 f4             	pushl  -0xc(%ebp)
  80121c:	50                   	push   %eax
  80121d:	ff 75 0c             	pushl  0xc(%ebp)
  801220:	ff 75 08             	pushl  0x8(%ebp)
  801223:	e8 16 fc ff ff       	call   800e3e <vprintfmt>
  801228:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80122b:	90                   	nop
  80122c:	c9                   	leave  
  80122d:	c3                   	ret    

0080122e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80122e:	55                   	push   %ebp
  80122f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801231:	8b 45 0c             	mov    0xc(%ebp),%eax
  801234:	8b 40 08             	mov    0x8(%eax),%eax
  801237:	8d 50 01             	lea    0x1(%eax),%edx
  80123a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801240:	8b 45 0c             	mov    0xc(%ebp),%eax
  801243:	8b 10                	mov    (%eax),%edx
  801245:	8b 45 0c             	mov    0xc(%ebp),%eax
  801248:	8b 40 04             	mov    0x4(%eax),%eax
  80124b:	39 c2                	cmp    %eax,%edx
  80124d:	73 12                	jae    801261 <sprintputch+0x33>
		*b->buf++ = ch;
  80124f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801252:	8b 00                	mov    (%eax),%eax
  801254:	8d 48 01             	lea    0x1(%eax),%ecx
  801257:	8b 55 0c             	mov    0xc(%ebp),%edx
  80125a:	89 0a                	mov    %ecx,(%edx)
  80125c:	8b 55 08             	mov    0x8(%ebp),%edx
  80125f:	88 10                	mov    %dl,(%eax)
}
  801261:	90                   	nop
  801262:	5d                   	pop    %ebp
  801263:	c3                   	ret    

00801264 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801264:	55                   	push   %ebp
  801265:	89 e5                	mov    %esp,%ebp
  801267:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80126a:	8b 45 08             	mov    0x8(%ebp),%eax
  80126d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801270:	8b 45 0c             	mov    0xc(%ebp),%eax
  801273:	8d 50 ff             	lea    -0x1(%eax),%edx
  801276:	8b 45 08             	mov    0x8(%ebp),%eax
  801279:	01 d0                	add    %edx,%eax
  80127b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80127e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801285:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801289:	74 06                	je     801291 <vsnprintf+0x2d>
  80128b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80128f:	7f 07                	jg     801298 <vsnprintf+0x34>
		return -E_INVAL;
  801291:	b8 03 00 00 00       	mov    $0x3,%eax
  801296:	eb 20                	jmp    8012b8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801298:	ff 75 14             	pushl  0x14(%ebp)
  80129b:	ff 75 10             	pushl  0x10(%ebp)
  80129e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012a1:	50                   	push   %eax
  8012a2:	68 2e 12 80 00       	push   $0x80122e
  8012a7:	e8 92 fb ff ff       	call   800e3e <vprintfmt>
  8012ac:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8012af:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012b2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8012b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
  8012bd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8012c0:	8d 45 10             	lea    0x10(%ebp),%eax
  8012c3:	83 c0 04             	add    $0x4,%eax
  8012c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8012c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cc:	ff 75 f4             	pushl  -0xc(%ebp)
  8012cf:	50                   	push   %eax
  8012d0:	ff 75 0c             	pushl  0xc(%ebp)
  8012d3:	ff 75 08             	pushl  0x8(%ebp)
  8012d6:	e8 89 ff ff ff       	call   801264 <vsnprintf>
  8012db:	83 c4 10             	add    $0x10,%esp
  8012de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8012e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012e4:	c9                   	leave  
  8012e5:	c3                   	ret    

008012e6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012e6:	55                   	push   %ebp
  8012e7:	89 e5                	mov    %esp,%ebp
  8012e9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012f3:	eb 06                	jmp    8012fb <strlen+0x15>
		n++;
  8012f5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012f8:	ff 45 08             	incl   0x8(%ebp)
  8012fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fe:	8a 00                	mov    (%eax),%al
  801300:	84 c0                	test   %al,%al
  801302:	75 f1                	jne    8012f5 <strlen+0xf>
		n++;
	return n;
  801304:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801307:	c9                   	leave  
  801308:	c3                   	ret    

00801309 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801309:	55                   	push   %ebp
  80130a:	89 e5                	mov    %esp,%ebp
  80130c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80130f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801316:	eb 09                	jmp    801321 <strnlen+0x18>
		n++;
  801318:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80131b:	ff 45 08             	incl   0x8(%ebp)
  80131e:	ff 4d 0c             	decl   0xc(%ebp)
  801321:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801325:	74 09                	je     801330 <strnlen+0x27>
  801327:	8b 45 08             	mov    0x8(%ebp),%eax
  80132a:	8a 00                	mov    (%eax),%al
  80132c:	84 c0                	test   %al,%al
  80132e:	75 e8                	jne    801318 <strnlen+0xf>
		n++;
	return n;
  801330:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801333:	c9                   	leave  
  801334:	c3                   	ret    

00801335 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801335:	55                   	push   %ebp
  801336:	89 e5                	mov    %esp,%ebp
  801338:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80133b:	8b 45 08             	mov    0x8(%ebp),%eax
  80133e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801341:	90                   	nop
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	8d 50 01             	lea    0x1(%eax),%edx
  801348:	89 55 08             	mov    %edx,0x8(%ebp)
  80134b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801351:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801354:	8a 12                	mov    (%edx),%dl
  801356:	88 10                	mov    %dl,(%eax)
  801358:	8a 00                	mov    (%eax),%al
  80135a:	84 c0                	test   %al,%al
  80135c:	75 e4                	jne    801342 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80135e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801361:	c9                   	leave  
  801362:	c3                   	ret    

00801363 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801363:	55                   	push   %ebp
  801364:	89 e5                	mov    %esp,%ebp
  801366:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801369:	8b 45 08             	mov    0x8(%ebp),%eax
  80136c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80136f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801376:	eb 1f                	jmp    801397 <strncpy+0x34>
		*dst++ = *src;
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	8d 50 01             	lea    0x1(%eax),%edx
  80137e:	89 55 08             	mov    %edx,0x8(%ebp)
  801381:	8b 55 0c             	mov    0xc(%ebp),%edx
  801384:	8a 12                	mov    (%edx),%dl
  801386:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801388:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138b:	8a 00                	mov    (%eax),%al
  80138d:	84 c0                	test   %al,%al
  80138f:	74 03                	je     801394 <strncpy+0x31>
			src++;
  801391:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801394:	ff 45 fc             	incl   -0x4(%ebp)
  801397:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80139a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80139d:	72 d9                	jb     801378 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80139f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013a2:	c9                   	leave  
  8013a3:	c3                   	ret    

008013a4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013a4:	55                   	push   %ebp
  8013a5:	89 e5                	mov    %esp,%ebp
  8013a7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013b0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b4:	74 30                	je     8013e6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013b6:	eb 16                	jmp    8013ce <strlcpy+0x2a>
			*dst++ = *src++;
  8013b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bb:	8d 50 01             	lea    0x1(%eax),%edx
  8013be:	89 55 08             	mov    %edx,0x8(%ebp)
  8013c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013c7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013ca:	8a 12                	mov    (%edx),%dl
  8013cc:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013ce:	ff 4d 10             	decl   0x10(%ebp)
  8013d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d5:	74 09                	je     8013e0 <strlcpy+0x3c>
  8013d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013da:	8a 00                	mov    (%eax),%al
  8013dc:	84 c0                	test   %al,%al
  8013de:	75 d8                	jne    8013b8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013e6:	8b 55 08             	mov    0x8(%ebp),%edx
  8013e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ec:	29 c2                	sub    %eax,%edx
  8013ee:	89 d0                	mov    %edx,%eax
}
  8013f0:	c9                   	leave  
  8013f1:	c3                   	ret    

008013f2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013f2:	55                   	push   %ebp
  8013f3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013f5:	eb 06                	jmp    8013fd <strcmp+0xb>
		p++, q++;
  8013f7:	ff 45 08             	incl   0x8(%ebp)
  8013fa:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	8a 00                	mov    (%eax),%al
  801402:	84 c0                	test   %al,%al
  801404:	74 0e                	je     801414 <strcmp+0x22>
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	8a 10                	mov    (%eax),%dl
  80140b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140e:	8a 00                	mov    (%eax),%al
  801410:	38 c2                	cmp    %al,%dl
  801412:	74 e3                	je     8013f7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	8a 00                	mov    (%eax),%al
  801419:	0f b6 d0             	movzbl %al,%edx
  80141c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141f:	8a 00                	mov    (%eax),%al
  801421:	0f b6 c0             	movzbl %al,%eax
  801424:	29 c2                	sub    %eax,%edx
  801426:	89 d0                	mov    %edx,%eax
}
  801428:	5d                   	pop    %ebp
  801429:	c3                   	ret    

0080142a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80142a:	55                   	push   %ebp
  80142b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80142d:	eb 09                	jmp    801438 <strncmp+0xe>
		n--, p++, q++;
  80142f:	ff 4d 10             	decl   0x10(%ebp)
  801432:	ff 45 08             	incl   0x8(%ebp)
  801435:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801438:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80143c:	74 17                	je     801455 <strncmp+0x2b>
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	8a 00                	mov    (%eax),%al
  801443:	84 c0                	test   %al,%al
  801445:	74 0e                	je     801455 <strncmp+0x2b>
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	8a 10                	mov    (%eax),%dl
  80144c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144f:	8a 00                	mov    (%eax),%al
  801451:	38 c2                	cmp    %al,%dl
  801453:	74 da                	je     80142f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801455:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801459:	75 07                	jne    801462 <strncmp+0x38>
		return 0;
  80145b:	b8 00 00 00 00       	mov    $0x0,%eax
  801460:	eb 14                	jmp    801476 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	8a 00                	mov    (%eax),%al
  801467:	0f b6 d0             	movzbl %al,%edx
  80146a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146d:	8a 00                	mov    (%eax),%al
  80146f:	0f b6 c0             	movzbl %al,%eax
  801472:	29 c2                	sub    %eax,%edx
  801474:	89 d0                	mov    %edx,%eax
}
  801476:	5d                   	pop    %ebp
  801477:	c3                   	ret    

00801478 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801478:	55                   	push   %ebp
  801479:	89 e5                	mov    %esp,%ebp
  80147b:	83 ec 04             	sub    $0x4,%esp
  80147e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801481:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801484:	eb 12                	jmp    801498 <strchr+0x20>
		if (*s == c)
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	8a 00                	mov    (%eax),%al
  80148b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80148e:	75 05                	jne    801495 <strchr+0x1d>
			return (char *) s;
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	eb 11                	jmp    8014a6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801495:	ff 45 08             	incl   0x8(%ebp)
  801498:	8b 45 08             	mov    0x8(%ebp),%eax
  80149b:	8a 00                	mov    (%eax),%al
  80149d:	84 c0                	test   %al,%al
  80149f:	75 e5                	jne    801486 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014a6:	c9                   	leave  
  8014a7:	c3                   	ret    

008014a8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014a8:	55                   	push   %ebp
  8014a9:	89 e5                	mov    %esp,%ebp
  8014ab:	83 ec 04             	sub    $0x4,%esp
  8014ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014b4:	eb 0d                	jmp    8014c3 <strfind+0x1b>
		if (*s == c)
  8014b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b9:	8a 00                	mov    (%eax),%al
  8014bb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014be:	74 0e                	je     8014ce <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014c0:	ff 45 08             	incl   0x8(%ebp)
  8014c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c6:	8a 00                	mov    (%eax),%al
  8014c8:	84 c0                	test   %al,%al
  8014ca:	75 ea                	jne    8014b6 <strfind+0xe>
  8014cc:	eb 01                	jmp    8014cf <strfind+0x27>
		if (*s == c)
			break;
  8014ce:	90                   	nop
	return (char *) s;
  8014cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014d2:	c9                   	leave  
  8014d3:	c3                   	ret    

008014d4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
  8014d7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014da:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014e6:	eb 0e                	jmp    8014f6 <memset+0x22>
		*p++ = c;
  8014e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014eb:	8d 50 01             	lea    0x1(%eax),%edx
  8014ee:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f4:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014f6:	ff 4d f8             	decl   -0x8(%ebp)
  8014f9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014fd:	79 e9                	jns    8014e8 <memset+0x14>
		*p++ = c;

	return v;
  8014ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
  801507:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80150a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801510:	8b 45 08             	mov    0x8(%ebp),%eax
  801513:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801516:	eb 16                	jmp    80152e <memcpy+0x2a>
		*d++ = *s++;
  801518:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80151b:	8d 50 01             	lea    0x1(%eax),%edx
  80151e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801521:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801524:	8d 4a 01             	lea    0x1(%edx),%ecx
  801527:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80152a:	8a 12                	mov    (%edx),%dl
  80152c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80152e:	8b 45 10             	mov    0x10(%ebp),%eax
  801531:	8d 50 ff             	lea    -0x1(%eax),%edx
  801534:	89 55 10             	mov    %edx,0x10(%ebp)
  801537:	85 c0                	test   %eax,%eax
  801539:	75 dd                	jne    801518 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80153b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80153e:	c9                   	leave  
  80153f:	c3                   	ret    

00801540 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801540:	55                   	push   %ebp
  801541:	89 e5                	mov    %esp,%ebp
  801543:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801546:	8b 45 0c             	mov    0xc(%ebp),%eax
  801549:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801552:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801555:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801558:	73 50                	jae    8015aa <memmove+0x6a>
  80155a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80155d:	8b 45 10             	mov    0x10(%ebp),%eax
  801560:	01 d0                	add    %edx,%eax
  801562:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801565:	76 43                	jbe    8015aa <memmove+0x6a>
		s += n;
  801567:	8b 45 10             	mov    0x10(%ebp),%eax
  80156a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80156d:	8b 45 10             	mov    0x10(%ebp),%eax
  801570:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801573:	eb 10                	jmp    801585 <memmove+0x45>
			*--d = *--s;
  801575:	ff 4d f8             	decl   -0x8(%ebp)
  801578:	ff 4d fc             	decl   -0x4(%ebp)
  80157b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80157e:	8a 10                	mov    (%eax),%dl
  801580:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801583:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801585:	8b 45 10             	mov    0x10(%ebp),%eax
  801588:	8d 50 ff             	lea    -0x1(%eax),%edx
  80158b:	89 55 10             	mov    %edx,0x10(%ebp)
  80158e:	85 c0                	test   %eax,%eax
  801590:	75 e3                	jne    801575 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801592:	eb 23                	jmp    8015b7 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801594:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801597:	8d 50 01             	lea    0x1(%eax),%edx
  80159a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80159d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015a3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015a6:	8a 12                	mov    (%edx),%dl
  8015a8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015b0:	89 55 10             	mov    %edx,0x10(%ebp)
  8015b3:	85 c0                	test   %eax,%eax
  8015b5:	75 dd                	jne    801594 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
  8015bf:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015cb:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015ce:	eb 2a                	jmp    8015fa <memcmp+0x3e>
		if (*s1 != *s2)
  8015d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d3:	8a 10                	mov    (%eax),%dl
  8015d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d8:	8a 00                	mov    (%eax),%al
  8015da:	38 c2                	cmp    %al,%dl
  8015dc:	74 16                	je     8015f4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015de:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e1:	8a 00                	mov    (%eax),%al
  8015e3:	0f b6 d0             	movzbl %al,%edx
  8015e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e9:	8a 00                	mov    (%eax),%al
  8015eb:	0f b6 c0             	movzbl %al,%eax
  8015ee:	29 c2                	sub    %eax,%edx
  8015f0:	89 d0                	mov    %edx,%eax
  8015f2:	eb 18                	jmp    80160c <memcmp+0x50>
		s1++, s2++;
  8015f4:	ff 45 fc             	incl   -0x4(%ebp)
  8015f7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8015fd:	8d 50 ff             	lea    -0x1(%eax),%edx
  801600:	89 55 10             	mov    %edx,0x10(%ebp)
  801603:	85 c0                	test   %eax,%eax
  801605:	75 c9                	jne    8015d0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801607:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80160c:	c9                   	leave  
  80160d:	c3                   	ret    

0080160e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80160e:	55                   	push   %ebp
  80160f:	89 e5                	mov    %esp,%ebp
  801611:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801614:	8b 55 08             	mov    0x8(%ebp),%edx
  801617:	8b 45 10             	mov    0x10(%ebp),%eax
  80161a:	01 d0                	add    %edx,%eax
  80161c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80161f:	eb 15                	jmp    801636 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801621:	8b 45 08             	mov    0x8(%ebp),%eax
  801624:	8a 00                	mov    (%eax),%al
  801626:	0f b6 d0             	movzbl %al,%edx
  801629:	8b 45 0c             	mov    0xc(%ebp),%eax
  80162c:	0f b6 c0             	movzbl %al,%eax
  80162f:	39 c2                	cmp    %eax,%edx
  801631:	74 0d                	je     801640 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801633:	ff 45 08             	incl   0x8(%ebp)
  801636:	8b 45 08             	mov    0x8(%ebp),%eax
  801639:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80163c:	72 e3                	jb     801621 <memfind+0x13>
  80163e:	eb 01                	jmp    801641 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801640:	90                   	nop
	return (void *) s;
  801641:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
  801649:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80164c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801653:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80165a:	eb 03                	jmp    80165f <strtol+0x19>
		s++;
  80165c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	3c 20                	cmp    $0x20,%al
  801666:	74 f4                	je     80165c <strtol+0x16>
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	8a 00                	mov    (%eax),%al
  80166d:	3c 09                	cmp    $0x9,%al
  80166f:	74 eb                	je     80165c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	3c 2b                	cmp    $0x2b,%al
  801678:	75 05                	jne    80167f <strtol+0x39>
		s++;
  80167a:	ff 45 08             	incl   0x8(%ebp)
  80167d:	eb 13                	jmp    801692 <strtol+0x4c>
	else if (*s == '-')
  80167f:	8b 45 08             	mov    0x8(%ebp),%eax
  801682:	8a 00                	mov    (%eax),%al
  801684:	3c 2d                	cmp    $0x2d,%al
  801686:	75 0a                	jne    801692 <strtol+0x4c>
		s++, neg = 1;
  801688:	ff 45 08             	incl   0x8(%ebp)
  80168b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801692:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801696:	74 06                	je     80169e <strtol+0x58>
  801698:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80169c:	75 20                	jne    8016be <strtol+0x78>
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	8a 00                	mov    (%eax),%al
  8016a3:	3c 30                	cmp    $0x30,%al
  8016a5:	75 17                	jne    8016be <strtol+0x78>
  8016a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016aa:	40                   	inc    %eax
  8016ab:	8a 00                	mov    (%eax),%al
  8016ad:	3c 78                	cmp    $0x78,%al
  8016af:	75 0d                	jne    8016be <strtol+0x78>
		s += 2, base = 16;
  8016b1:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016b5:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016bc:	eb 28                	jmp    8016e6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016c2:	75 15                	jne    8016d9 <strtol+0x93>
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c7:	8a 00                	mov    (%eax),%al
  8016c9:	3c 30                	cmp    $0x30,%al
  8016cb:	75 0c                	jne    8016d9 <strtol+0x93>
		s++, base = 8;
  8016cd:	ff 45 08             	incl   0x8(%ebp)
  8016d0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016d7:	eb 0d                	jmp    8016e6 <strtol+0xa0>
	else if (base == 0)
  8016d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016dd:	75 07                	jne    8016e6 <strtol+0xa0>
		base = 10;
  8016df:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	8a 00                	mov    (%eax),%al
  8016eb:	3c 2f                	cmp    $0x2f,%al
  8016ed:	7e 19                	jle    801708 <strtol+0xc2>
  8016ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f2:	8a 00                	mov    (%eax),%al
  8016f4:	3c 39                	cmp    $0x39,%al
  8016f6:	7f 10                	jg     801708 <strtol+0xc2>
			dig = *s - '0';
  8016f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fb:	8a 00                	mov    (%eax),%al
  8016fd:	0f be c0             	movsbl %al,%eax
  801700:	83 e8 30             	sub    $0x30,%eax
  801703:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801706:	eb 42                	jmp    80174a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801708:	8b 45 08             	mov    0x8(%ebp),%eax
  80170b:	8a 00                	mov    (%eax),%al
  80170d:	3c 60                	cmp    $0x60,%al
  80170f:	7e 19                	jle    80172a <strtol+0xe4>
  801711:	8b 45 08             	mov    0x8(%ebp),%eax
  801714:	8a 00                	mov    (%eax),%al
  801716:	3c 7a                	cmp    $0x7a,%al
  801718:	7f 10                	jg     80172a <strtol+0xe4>
			dig = *s - 'a' + 10;
  80171a:	8b 45 08             	mov    0x8(%ebp),%eax
  80171d:	8a 00                	mov    (%eax),%al
  80171f:	0f be c0             	movsbl %al,%eax
  801722:	83 e8 57             	sub    $0x57,%eax
  801725:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801728:	eb 20                	jmp    80174a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80172a:	8b 45 08             	mov    0x8(%ebp),%eax
  80172d:	8a 00                	mov    (%eax),%al
  80172f:	3c 40                	cmp    $0x40,%al
  801731:	7e 39                	jle    80176c <strtol+0x126>
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	8a 00                	mov    (%eax),%al
  801738:	3c 5a                	cmp    $0x5a,%al
  80173a:	7f 30                	jg     80176c <strtol+0x126>
			dig = *s - 'A' + 10;
  80173c:	8b 45 08             	mov    0x8(%ebp),%eax
  80173f:	8a 00                	mov    (%eax),%al
  801741:	0f be c0             	movsbl %al,%eax
  801744:	83 e8 37             	sub    $0x37,%eax
  801747:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80174a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80174d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801750:	7d 19                	jge    80176b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801752:	ff 45 08             	incl   0x8(%ebp)
  801755:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801758:	0f af 45 10          	imul   0x10(%ebp),%eax
  80175c:	89 c2                	mov    %eax,%edx
  80175e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801761:	01 d0                	add    %edx,%eax
  801763:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801766:	e9 7b ff ff ff       	jmp    8016e6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80176b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80176c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801770:	74 08                	je     80177a <strtol+0x134>
		*endptr = (char *) s;
  801772:	8b 45 0c             	mov    0xc(%ebp),%eax
  801775:	8b 55 08             	mov    0x8(%ebp),%edx
  801778:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80177a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80177e:	74 07                	je     801787 <strtol+0x141>
  801780:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801783:	f7 d8                	neg    %eax
  801785:	eb 03                	jmp    80178a <strtol+0x144>
  801787:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <ltostr>:

void
ltostr(long value, char *str)
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
  80178f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801792:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801799:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017a0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017a4:	79 13                	jns    8017b9 <ltostr+0x2d>
	{
		neg = 1;
  8017a6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b0:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017b3:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017b6:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017c1:	99                   	cltd   
  8017c2:	f7 f9                	idiv   %ecx
  8017c4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ca:	8d 50 01             	lea    0x1(%eax),%edx
  8017cd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017d0:	89 c2                	mov    %eax,%edx
  8017d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d5:	01 d0                	add    %edx,%eax
  8017d7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017da:	83 c2 30             	add    $0x30,%edx
  8017dd:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017e2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017e7:	f7 e9                	imul   %ecx
  8017e9:	c1 fa 02             	sar    $0x2,%edx
  8017ec:	89 c8                	mov    %ecx,%eax
  8017ee:	c1 f8 1f             	sar    $0x1f,%eax
  8017f1:	29 c2                	sub    %eax,%edx
  8017f3:	89 d0                	mov    %edx,%eax
  8017f5:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017fb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801800:	f7 e9                	imul   %ecx
  801802:	c1 fa 02             	sar    $0x2,%edx
  801805:	89 c8                	mov    %ecx,%eax
  801807:	c1 f8 1f             	sar    $0x1f,%eax
  80180a:	29 c2                	sub    %eax,%edx
  80180c:	89 d0                	mov    %edx,%eax
  80180e:	c1 e0 02             	shl    $0x2,%eax
  801811:	01 d0                	add    %edx,%eax
  801813:	01 c0                	add    %eax,%eax
  801815:	29 c1                	sub    %eax,%ecx
  801817:	89 ca                	mov    %ecx,%edx
  801819:	85 d2                	test   %edx,%edx
  80181b:	75 9c                	jne    8017b9 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80181d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801824:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801827:	48                   	dec    %eax
  801828:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80182b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80182f:	74 3d                	je     80186e <ltostr+0xe2>
		start = 1 ;
  801831:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801838:	eb 34                	jmp    80186e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80183a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80183d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801840:	01 d0                	add    %edx,%eax
  801842:	8a 00                	mov    (%eax),%al
  801844:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801847:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80184a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184d:	01 c2                	add    %eax,%edx
  80184f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801852:	8b 45 0c             	mov    0xc(%ebp),%eax
  801855:	01 c8                	add    %ecx,%eax
  801857:	8a 00                	mov    (%eax),%al
  801859:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80185b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80185e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801861:	01 c2                	add    %eax,%edx
  801863:	8a 45 eb             	mov    -0x15(%ebp),%al
  801866:	88 02                	mov    %al,(%edx)
		start++ ;
  801868:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80186b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80186e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801871:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801874:	7c c4                	jl     80183a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801876:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801879:	8b 45 0c             	mov    0xc(%ebp),%eax
  80187c:	01 d0                	add    %edx,%eax
  80187e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801881:	90                   	nop
  801882:	c9                   	leave  
  801883:	c3                   	ret    

00801884 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
  801887:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80188a:	ff 75 08             	pushl  0x8(%ebp)
  80188d:	e8 54 fa ff ff       	call   8012e6 <strlen>
  801892:	83 c4 04             	add    $0x4,%esp
  801895:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801898:	ff 75 0c             	pushl  0xc(%ebp)
  80189b:	e8 46 fa ff ff       	call   8012e6 <strlen>
  8018a0:	83 c4 04             	add    $0x4,%esp
  8018a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018b4:	eb 17                	jmp    8018cd <strcconcat+0x49>
		final[s] = str1[s] ;
  8018b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018bc:	01 c2                	add    %eax,%edx
  8018be:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c4:	01 c8                	add    %ecx,%eax
  8018c6:	8a 00                	mov    (%eax),%al
  8018c8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018ca:	ff 45 fc             	incl   -0x4(%ebp)
  8018cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018d0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018d3:	7c e1                	jl     8018b6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018d5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018e3:	eb 1f                	jmp    801904 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018e8:	8d 50 01             	lea    0x1(%eax),%edx
  8018eb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018ee:	89 c2                	mov    %eax,%edx
  8018f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f3:	01 c2                	add    %eax,%edx
  8018f5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018fb:	01 c8                	add    %ecx,%eax
  8018fd:	8a 00                	mov    (%eax),%al
  8018ff:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801901:	ff 45 f8             	incl   -0x8(%ebp)
  801904:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801907:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80190a:	7c d9                	jl     8018e5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80190c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80190f:	8b 45 10             	mov    0x10(%ebp),%eax
  801912:	01 d0                	add    %edx,%eax
  801914:	c6 00 00             	movb   $0x0,(%eax)
}
  801917:	90                   	nop
  801918:	c9                   	leave  
  801919:	c3                   	ret    

0080191a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80191a:	55                   	push   %ebp
  80191b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80191d:	8b 45 14             	mov    0x14(%ebp),%eax
  801920:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801926:	8b 45 14             	mov    0x14(%ebp),%eax
  801929:	8b 00                	mov    (%eax),%eax
  80192b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801932:	8b 45 10             	mov    0x10(%ebp),%eax
  801935:	01 d0                	add    %edx,%eax
  801937:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80193d:	eb 0c                	jmp    80194b <strsplit+0x31>
			*string++ = 0;
  80193f:	8b 45 08             	mov    0x8(%ebp),%eax
  801942:	8d 50 01             	lea    0x1(%eax),%edx
  801945:	89 55 08             	mov    %edx,0x8(%ebp)
  801948:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80194b:	8b 45 08             	mov    0x8(%ebp),%eax
  80194e:	8a 00                	mov    (%eax),%al
  801950:	84 c0                	test   %al,%al
  801952:	74 18                	je     80196c <strsplit+0x52>
  801954:	8b 45 08             	mov    0x8(%ebp),%eax
  801957:	8a 00                	mov    (%eax),%al
  801959:	0f be c0             	movsbl %al,%eax
  80195c:	50                   	push   %eax
  80195d:	ff 75 0c             	pushl  0xc(%ebp)
  801960:	e8 13 fb ff ff       	call   801478 <strchr>
  801965:	83 c4 08             	add    $0x8,%esp
  801968:	85 c0                	test   %eax,%eax
  80196a:	75 d3                	jne    80193f <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80196c:	8b 45 08             	mov    0x8(%ebp),%eax
  80196f:	8a 00                	mov    (%eax),%al
  801971:	84 c0                	test   %al,%al
  801973:	74 5a                	je     8019cf <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801975:	8b 45 14             	mov    0x14(%ebp),%eax
  801978:	8b 00                	mov    (%eax),%eax
  80197a:	83 f8 0f             	cmp    $0xf,%eax
  80197d:	75 07                	jne    801986 <strsplit+0x6c>
		{
			return 0;
  80197f:	b8 00 00 00 00       	mov    $0x0,%eax
  801984:	eb 66                	jmp    8019ec <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801986:	8b 45 14             	mov    0x14(%ebp),%eax
  801989:	8b 00                	mov    (%eax),%eax
  80198b:	8d 48 01             	lea    0x1(%eax),%ecx
  80198e:	8b 55 14             	mov    0x14(%ebp),%edx
  801991:	89 0a                	mov    %ecx,(%edx)
  801993:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80199a:	8b 45 10             	mov    0x10(%ebp),%eax
  80199d:	01 c2                	add    %eax,%edx
  80199f:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019a4:	eb 03                	jmp    8019a9 <strsplit+0x8f>
			string++;
  8019a6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ac:	8a 00                	mov    (%eax),%al
  8019ae:	84 c0                	test   %al,%al
  8019b0:	74 8b                	je     80193d <strsplit+0x23>
  8019b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b5:	8a 00                	mov    (%eax),%al
  8019b7:	0f be c0             	movsbl %al,%eax
  8019ba:	50                   	push   %eax
  8019bb:	ff 75 0c             	pushl  0xc(%ebp)
  8019be:	e8 b5 fa ff ff       	call   801478 <strchr>
  8019c3:	83 c4 08             	add    $0x8,%esp
  8019c6:	85 c0                	test   %eax,%eax
  8019c8:	74 dc                	je     8019a6 <strsplit+0x8c>
			string++;
	}
  8019ca:	e9 6e ff ff ff       	jmp    80193d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019cf:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8019d3:	8b 00                	mov    (%eax),%eax
  8019d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8019df:	01 d0                	add    %edx,%eax
  8019e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019e7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019ec:	c9                   	leave  
  8019ed:	c3                   	ret    

008019ee <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8019ee:	55                   	push   %ebp
  8019ef:	89 e5                	mov    %esp,%ebp
  8019f1:	57                   	push   %edi
  8019f2:	56                   	push   %esi
  8019f3:	53                   	push   %ebx
  8019f4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8019f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019fd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a00:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a03:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a06:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a09:	cd 30                	int    $0x30
  801a0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a11:	83 c4 10             	add    $0x10,%esp
  801a14:	5b                   	pop    %ebx
  801a15:	5e                   	pop    %esi
  801a16:	5f                   	pop    %edi
  801a17:	5d                   	pop    %ebp
  801a18:	c3                   	ret    

00801a19 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a19:	55                   	push   %ebp
  801a1a:	89 e5                	mov    %esp,%ebp
  801a1c:	83 ec 04             	sub    $0x4,%esp
  801a1f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a22:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a25:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a29:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	52                   	push   %edx
  801a31:	ff 75 0c             	pushl  0xc(%ebp)
  801a34:	50                   	push   %eax
  801a35:	6a 00                	push   $0x0
  801a37:	e8 b2 ff ff ff       	call   8019ee <syscall>
  801a3c:	83 c4 18             	add    $0x18,%esp
}
  801a3f:	90                   	nop
  801a40:	c9                   	leave  
  801a41:	c3                   	ret    

00801a42 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a42:	55                   	push   %ebp
  801a43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 01                	push   $0x1
  801a51:	e8 98 ff ff ff       	call   8019ee <syscall>
  801a56:	83 c4 18             	add    $0x18,%esp
}
  801a59:	c9                   	leave  
  801a5a:	c3                   	ret    

00801a5b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a5b:	55                   	push   %ebp
  801a5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	50                   	push   %eax
  801a6a:	6a 05                	push   $0x5
  801a6c:	e8 7d ff ff ff       	call   8019ee <syscall>
  801a71:	83 c4 18             	add    $0x18,%esp
}
  801a74:	c9                   	leave  
  801a75:	c3                   	ret    

00801a76 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a76:	55                   	push   %ebp
  801a77:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	6a 02                	push   $0x2
  801a85:	e8 64 ff ff ff       	call   8019ee <syscall>
  801a8a:	83 c4 18             	add    $0x18,%esp
}
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    

00801a8f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a8f:	55                   	push   %ebp
  801a90:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 03                	push   $0x3
  801a9e:	e8 4b ff ff ff       	call   8019ee <syscall>
  801aa3:	83 c4 18             	add    $0x18,%esp
}
  801aa6:	c9                   	leave  
  801aa7:	c3                   	ret    

00801aa8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801aa8:	55                   	push   %ebp
  801aa9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801aab:	6a 00                	push   $0x0
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 04                	push   $0x4
  801ab7:	e8 32 ff ff ff       	call   8019ee <syscall>
  801abc:	83 c4 18             	add    $0x18,%esp
}
  801abf:	c9                   	leave  
  801ac0:	c3                   	ret    

00801ac1 <sys_env_exit>:


void sys_env_exit(void)
{
  801ac1:	55                   	push   %ebp
  801ac2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 06                	push   $0x6
  801ad0:	e8 19 ff ff ff       	call   8019ee <syscall>
  801ad5:	83 c4 18             	add    $0x18,%esp
}
  801ad8:	90                   	nop
  801ad9:	c9                   	leave  
  801ada:	c3                   	ret    

00801adb <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801adb:	55                   	push   %ebp
  801adc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ade:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	52                   	push   %edx
  801aeb:	50                   	push   %eax
  801aec:	6a 07                	push   $0x7
  801aee:	e8 fb fe ff ff       	call   8019ee <syscall>
  801af3:	83 c4 18             	add    $0x18,%esp
}
  801af6:	c9                   	leave  
  801af7:	c3                   	ret    

00801af8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801af8:	55                   	push   %ebp
  801af9:	89 e5                	mov    %esp,%ebp
  801afb:	56                   	push   %esi
  801afc:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801afd:	8b 75 18             	mov    0x18(%ebp),%esi
  801b00:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b03:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b06:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b09:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0c:	56                   	push   %esi
  801b0d:	53                   	push   %ebx
  801b0e:	51                   	push   %ecx
  801b0f:	52                   	push   %edx
  801b10:	50                   	push   %eax
  801b11:	6a 08                	push   $0x8
  801b13:	e8 d6 fe ff ff       	call   8019ee <syscall>
  801b18:	83 c4 18             	add    $0x18,%esp
}
  801b1b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b1e:	5b                   	pop    %ebx
  801b1f:	5e                   	pop    %esi
  801b20:	5d                   	pop    %ebp
  801b21:	c3                   	ret    

00801b22 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b22:	55                   	push   %ebp
  801b23:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b25:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b28:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	52                   	push   %edx
  801b32:	50                   	push   %eax
  801b33:	6a 09                	push   $0x9
  801b35:	e8 b4 fe ff ff       	call   8019ee <syscall>
  801b3a:	83 c4 18             	add    $0x18,%esp
}
  801b3d:	c9                   	leave  
  801b3e:	c3                   	ret    

00801b3f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b3f:	55                   	push   %ebp
  801b40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	ff 75 0c             	pushl  0xc(%ebp)
  801b4b:	ff 75 08             	pushl  0x8(%ebp)
  801b4e:	6a 0a                	push   $0xa
  801b50:	e8 99 fe ff ff       	call   8019ee <syscall>
  801b55:	83 c4 18             	add    $0x18,%esp
}
  801b58:	c9                   	leave  
  801b59:	c3                   	ret    

00801b5a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b5a:	55                   	push   %ebp
  801b5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 0b                	push   $0xb
  801b69:	e8 80 fe ff ff       	call   8019ee <syscall>
  801b6e:	83 c4 18             	add    $0x18,%esp
}
  801b71:	c9                   	leave  
  801b72:	c3                   	ret    

00801b73 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b73:	55                   	push   %ebp
  801b74:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 0c                	push   $0xc
  801b82:	e8 67 fe ff ff       	call   8019ee <syscall>
  801b87:	83 c4 18             	add    $0x18,%esp
}
  801b8a:	c9                   	leave  
  801b8b:	c3                   	ret    

00801b8c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b8c:	55                   	push   %ebp
  801b8d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 0d                	push   $0xd
  801b9b:	e8 4e fe ff ff       	call   8019ee <syscall>
  801ba0:	83 c4 18             	add    $0x18,%esp
}
  801ba3:	c9                   	leave  
  801ba4:	c3                   	ret    

00801ba5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	ff 75 0c             	pushl  0xc(%ebp)
  801bb1:	ff 75 08             	pushl  0x8(%ebp)
  801bb4:	6a 11                	push   $0x11
  801bb6:	e8 33 fe ff ff       	call   8019ee <syscall>
  801bbb:	83 c4 18             	add    $0x18,%esp
	return;
  801bbe:	90                   	nop
}
  801bbf:	c9                   	leave  
  801bc0:	c3                   	ret    

00801bc1 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801bc1:	55                   	push   %ebp
  801bc2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	ff 75 0c             	pushl  0xc(%ebp)
  801bcd:	ff 75 08             	pushl  0x8(%ebp)
  801bd0:	6a 12                	push   $0x12
  801bd2:	e8 17 fe ff ff       	call   8019ee <syscall>
  801bd7:	83 c4 18             	add    $0x18,%esp
	return ;
  801bda:	90                   	nop
}
  801bdb:	c9                   	leave  
  801bdc:	c3                   	ret    

00801bdd <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801bdd:	55                   	push   %ebp
  801bde:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	6a 0e                	push   $0xe
  801bec:	e8 fd fd ff ff       	call   8019ee <syscall>
  801bf1:	83 c4 18             	add    $0x18,%esp
}
  801bf4:	c9                   	leave  
  801bf5:	c3                   	ret    

00801bf6 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801bf6:	55                   	push   %ebp
  801bf7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	ff 75 08             	pushl  0x8(%ebp)
  801c04:	6a 0f                	push   $0xf
  801c06:	e8 e3 fd ff ff       	call   8019ee <syscall>
  801c0b:	83 c4 18             	add    $0x18,%esp
}
  801c0e:	c9                   	leave  
  801c0f:	c3                   	ret    

00801c10 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c10:	55                   	push   %ebp
  801c11:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 10                	push   $0x10
  801c1f:	e8 ca fd ff ff       	call   8019ee <syscall>
  801c24:	83 c4 18             	add    $0x18,%esp
}
  801c27:	90                   	nop
  801c28:	c9                   	leave  
  801c29:	c3                   	ret    

00801c2a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c2a:	55                   	push   %ebp
  801c2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 00                	push   $0x0
  801c37:	6a 14                	push   $0x14
  801c39:	e8 b0 fd ff ff       	call   8019ee <syscall>
  801c3e:	83 c4 18             	add    $0x18,%esp
}
  801c41:	90                   	nop
  801c42:	c9                   	leave  
  801c43:	c3                   	ret    

00801c44 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c44:	55                   	push   %ebp
  801c45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 15                	push   $0x15
  801c53:	e8 96 fd ff ff       	call   8019ee <syscall>
  801c58:	83 c4 18             	add    $0x18,%esp
}
  801c5b:	90                   	nop
  801c5c:	c9                   	leave  
  801c5d:	c3                   	ret    

00801c5e <sys_cputc>:


void
sys_cputc(const char c)
{
  801c5e:	55                   	push   %ebp
  801c5f:	89 e5                	mov    %esp,%ebp
  801c61:	83 ec 04             	sub    $0x4,%esp
  801c64:	8b 45 08             	mov    0x8(%ebp),%eax
  801c67:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c6a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	50                   	push   %eax
  801c77:	6a 16                	push   $0x16
  801c79:	e8 70 fd ff ff       	call   8019ee <syscall>
  801c7e:	83 c4 18             	add    $0x18,%esp
}
  801c81:	90                   	nop
  801c82:	c9                   	leave  
  801c83:	c3                   	ret    

00801c84 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c84:	55                   	push   %ebp
  801c85:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 17                	push   $0x17
  801c93:	e8 56 fd ff ff       	call   8019ee <syscall>
  801c98:	83 c4 18             	add    $0x18,%esp
}
  801c9b:	90                   	nop
  801c9c:	c9                   	leave  
  801c9d:	c3                   	ret    

00801c9e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801c9e:	55                   	push   %ebp
  801c9f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	ff 75 0c             	pushl  0xc(%ebp)
  801cad:	50                   	push   %eax
  801cae:	6a 18                	push   $0x18
  801cb0:	e8 39 fd ff ff       	call   8019ee <syscall>
  801cb5:	83 c4 18             	add    $0x18,%esp
}
  801cb8:	c9                   	leave  
  801cb9:	c3                   	ret    

00801cba <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801cba:	55                   	push   %ebp
  801cbb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cbd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	52                   	push   %edx
  801cca:	50                   	push   %eax
  801ccb:	6a 1b                	push   $0x1b
  801ccd:	e8 1c fd ff ff       	call   8019ee <syscall>
  801cd2:	83 c4 18             	add    $0x18,%esp
}
  801cd5:	c9                   	leave  
  801cd6:	c3                   	ret    

00801cd7 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cd7:	55                   	push   %ebp
  801cd8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cda:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	52                   	push   %edx
  801ce7:	50                   	push   %eax
  801ce8:	6a 19                	push   $0x19
  801cea:	e8 ff fc ff ff       	call   8019ee <syscall>
  801cef:	83 c4 18             	add    $0x18,%esp
}
  801cf2:	90                   	nop
  801cf3:	c9                   	leave  
  801cf4:	c3                   	ret    

00801cf5 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cf5:	55                   	push   %ebp
  801cf6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cf8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	52                   	push   %edx
  801d05:	50                   	push   %eax
  801d06:	6a 1a                	push   $0x1a
  801d08:	e8 e1 fc ff ff       	call   8019ee <syscall>
  801d0d:	83 c4 18             	add    $0x18,%esp
}
  801d10:	90                   	nop
  801d11:	c9                   	leave  
  801d12:	c3                   	ret    

00801d13 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d13:	55                   	push   %ebp
  801d14:	89 e5                	mov    %esp,%ebp
  801d16:	83 ec 04             	sub    $0x4,%esp
  801d19:	8b 45 10             	mov    0x10(%ebp),%eax
  801d1c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d1f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d22:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d26:	8b 45 08             	mov    0x8(%ebp),%eax
  801d29:	6a 00                	push   $0x0
  801d2b:	51                   	push   %ecx
  801d2c:	52                   	push   %edx
  801d2d:	ff 75 0c             	pushl  0xc(%ebp)
  801d30:	50                   	push   %eax
  801d31:	6a 1c                	push   $0x1c
  801d33:	e8 b6 fc ff ff       	call   8019ee <syscall>
  801d38:	83 c4 18             	add    $0x18,%esp
}
  801d3b:	c9                   	leave  
  801d3c:	c3                   	ret    

00801d3d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d3d:	55                   	push   %ebp
  801d3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d40:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d43:	8b 45 08             	mov    0x8(%ebp),%eax
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	52                   	push   %edx
  801d4d:	50                   	push   %eax
  801d4e:	6a 1d                	push   $0x1d
  801d50:	e8 99 fc ff ff       	call   8019ee <syscall>
  801d55:	83 c4 18             	add    $0x18,%esp
}
  801d58:	c9                   	leave  
  801d59:	c3                   	ret    

00801d5a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d5a:	55                   	push   %ebp
  801d5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d5d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d63:	8b 45 08             	mov    0x8(%ebp),%eax
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	51                   	push   %ecx
  801d6b:	52                   	push   %edx
  801d6c:	50                   	push   %eax
  801d6d:	6a 1e                	push   $0x1e
  801d6f:	e8 7a fc ff ff       	call   8019ee <syscall>
  801d74:	83 c4 18             	add    $0x18,%esp
}
  801d77:	c9                   	leave  
  801d78:	c3                   	ret    

00801d79 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d79:	55                   	push   %ebp
  801d7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d82:	6a 00                	push   $0x0
  801d84:	6a 00                	push   $0x0
  801d86:	6a 00                	push   $0x0
  801d88:	52                   	push   %edx
  801d89:	50                   	push   %eax
  801d8a:	6a 1f                	push   $0x1f
  801d8c:	e8 5d fc ff ff       	call   8019ee <syscall>
  801d91:	83 c4 18             	add    $0x18,%esp
}
  801d94:	c9                   	leave  
  801d95:	c3                   	ret    

00801d96 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801d96:	55                   	push   %ebp
  801d97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801d99:	6a 00                	push   $0x0
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	6a 20                	push   $0x20
  801da5:	e8 44 fc ff ff       	call   8019ee <syscall>
  801daa:	83 c4 18             	add    $0x18,%esp
}
  801dad:	c9                   	leave  
  801dae:	c3                   	ret    

00801daf <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801daf:	55                   	push   %ebp
  801db0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801db2:	8b 45 08             	mov    0x8(%ebp),%eax
  801db5:	6a 00                	push   $0x0
  801db7:	ff 75 14             	pushl  0x14(%ebp)
  801dba:	ff 75 10             	pushl  0x10(%ebp)
  801dbd:	ff 75 0c             	pushl  0xc(%ebp)
  801dc0:	50                   	push   %eax
  801dc1:	6a 21                	push   $0x21
  801dc3:	e8 26 fc ff ff       	call   8019ee <syscall>
  801dc8:	83 c4 18             	add    $0x18,%esp
}
  801dcb:	c9                   	leave  
  801dcc:	c3                   	ret    

00801dcd <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801dcd:	55                   	push   %ebp
  801dce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	50                   	push   %eax
  801ddc:	6a 22                	push   $0x22
  801dde:	e8 0b fc ff ff       	call   8019ee <syscall>
  801de3:	83 c4 18             	add    $0x18,%esp
}
  801de6:	90                   	nop
  801de7:	c9                   	leave  
  801de8:	c3                   	ret    

00801de9 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801de9:	55                   	push   %ebp
  801dea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801dec:	8b 45 08             	mov    0x8(%ebp),%eax
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	50                   	push   %eax
  801df8:	6a 23                	push   $0x23
  801dfa:	e8 ef fb ff ff       	call   8019ee <syscall>
  801dff:	83 c4 18             	add    $0x18,%esp
}
  801e02:	90                   	nop
  801e03:	c9                   	leave  
  801e04:	c3                   	ret    

00801e05 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e05:	55                   	push   %ebp
  801e06:	89 e5                	mov    %esp,%ebp
  801e08:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e0b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e0e:	8d 50 04             	lea    0x4(%eax),%edx
  801e11:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	52                   	push   %edx
  801e1b:	50                   	push   %eax
  801e1c:	6a 24                	push   $0x24
  801e1e:	e8 cb fb ff ff       	call   8019ee <syscall>
  801e23:	83 c4 18             	add    $0x18,%esp
	return result;
  801e26:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e29:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e2c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e2f:	89 01                	mov    %eax,(%ecx)
  801e31:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e34:	8b 45 08             	mov    0x8(%ebp),%eax
  801e37:	c9                   	leave  
  801e38:	c2 04 00             	ret    $0x4

00801e3b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e3b:	55                   	push   %ebp
  801e3c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	ff 75 10             	pushl  0x10(%ebp)
  801e45:	ff 75 0c             	pushl  0xc(%ebp)
  801e48:	ff 75 08             	pushl  0x8(%ebp)
  801e4b:	6a 13                	push   $0x13
  801e4d:	e8 9c fb ff ff       	call   8019ee <syscall>
  801e52:	83 c4 18             	add    $0x18,%esp
	return ;
  801e55:	90                   	nop
}
  801e56:	c9                   	leave  
  801e57:	c3                   	ret    

00801e58 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e58:	55                   	push   %ebp
  801e59:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 25                	push   $0x25
  801e67:	e8 82 fb ff ff       	call   8019ee <syscall>
  801e6c:	83 c4 18             	add    $0x18,%esp
}
  801e6f:	c9                   	leave  
  801e70:	c3                   	ret    

00801e71 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e71:	55                   	push   %ebp
  801e72:	89 e5                	mov    %esp,%ebp
  801e74:	83 ec 04             	sub    $0x4,%esp
  801e77:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e7d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	50                   	push   %eax
  801e8a:	6a 26                	push   $0x26
  801e8c:	e8 5d fb ff ff       	call   8019ee <syscall>
  801e91:	83 c4 18             	add    $0x18,%esp
	return ;
  801e94:	90                   	nop
}
  801e95:	c9                   	leave  
  801e96:	c3                   	ret    

00801e97 <rsttst>:
void rsttst()
{
  801e97:	55                   	push   %ebp
  801e98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 28                	push   $0x28
  801ea6:	e8 43 fb ff ff       	call   8019ee <syscall>
  801eab:	83 c4 18             	add    $0x18,%esp
	return ;
  801eae:	90                   	nop
}
  801eaf:	c9                   	leave  
  801eb0:	c3                   	ret    

00801eb1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801eb1:	55                   	push   %ebp
  801eb2:	89 e5                	mov    %esp,%ebp
  801eb4:	83 ec 04             	sub    $0x4,%esp
  801eb7:	8b 45 14             	mov    0x14(%ebp),%eax
  801eba:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ebd:	8b 55 18             	mov    0x18(%ebp),%edx
  801ec0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ec4:	52                   	push   %edx
  801ec5:	50                   	push   %eax
  801ec6:	ff 75 10             	pushl  0x10(%ebp)
  801ec9:	ff 75 0c             	pushl  0xc(%ebp)
  801ecc:	ff 75 08             	pushl  0x8(%ebp)
  801ecf:	6a 27                	push   $0x27
  801ed1:	e8 18 fb ff ff       	call   8019ee <syscall>
  801ed6:	83 c4 18             	add    $0x18,%esp
	return ;
  801ed9:	90                   	nop
}
  801eda:	c9                   	leave  
  801edb:	c3                   	ret    

00801edc <chktst>:
void chktst(uint32 n)
{
  801edc:	55                   	push   %ebp
  801edd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 00                	push   $0x0
  801ee5:	6a 00                	push   $0x0
  801ee7:	ff 75 08             	pushl  0x8(%ebp)
  801eea:	6a 29                	push   $0x29
  801eec:	e8 fd fa ff ff       	call   8019ee <syscall>
  801ef1:	83 c4 18             	add    $0x18,%esp
	return ;
  801ef4:	90                   	nop
}
  801ef5:	c9                   	leave  
  801ef6:	c3                   	ret    

00801ef7 <inctst>:

void inctst()
{
  801ef7:	55                   	push   %ebp
  801ef8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 2a                	push   $0x2a
  801f06:	e8 e3 fa ff ff       	call   8019ee <syscall>
  801f0b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f0e:	90                   	nop
}
  801f0f:	c9                   	leave  
  801f10:	c3                   	ret    

00801f11 <gettst>:
uint32 gettst()
{
  801f11:	55                   	push   %ebp
  801f12:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 2b                	push   $0x2b
  801f20:	e8 c9 fa ff ff       	call   8019ee <syscall>
  801f25:	83 c4 18             	add    $0x18,%esp
}
  801f28:	c9                   	leave  
  801f29:	c3                   	ret    

00801f2a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f2a:	55                   	push   %ebp
  801f2b:	89 e5                	mov    %esp,%ebp
  801f2d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 2c                	push   $0x2c
  801f3c:	e8 ad fa ff ff       	call   8019ee <syscall>
  801f41:	83 c4 18             	add    $0x18,%esp
  801f44:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f47:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f4b:	75 07                	jne    801f54 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f4d:	b8 01 00 00 00       	mov    $0x1,%eax
  801f52:	eb 05                	jmp    801f59 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f54:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f59:	c9                   	leave  
  801f5a:	c3                   	ret    

00801f5b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f5b:	55                   	push   %ebp
  801f5c:	89 e5                	mov    %esp,%ebp
  801f5e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f61:	6a 00                	push   $0x0
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 2c                	push   $0x2c
  801f6d:	e8 7c fa ff ff       	call   8019ee <syscall>
  801f72:	83 c4 18             	add    $0x18,%esp
  801f75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f78:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f7c:	75 07                	jne    801f85 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801f83:	eb 05                	jmp    801f8a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f85:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f8a:	c9                   	leave  
  801f8b:	c3                   	ret    

00801f8c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801f8c:	55                   	push   %ebp
  801f8d:	89 e5                	mov    %esp,%ebp
  801f8f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 2c                	push   $0x2c
  801f9e:	e8 4b fa ff ff       	call   8019ee <syscall>
  801fa3:	83 c4 18             	add    $0x18,%esp
  801fa6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801fa9:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801fad:	75 07                	jne    801fb6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801faf:	b8 01 00 00 00       	mov    $0x1,%eax
  801fb4:	eb 05                	jmp    801fbb <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801fb6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fbb:	c9                   	leave  
  801fbc:	c3                   	ret    

00801fbd <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801fbd:	55                   	push   %ebp
  801fbe:	89 e5                	mov    %esp,%ebp
  801fc0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 2c                	push   $0x2c
  801fcf:	e8 1a fa ff ff       	call   8019ee <syscall>
  801fd4:	83 c4 18             	add    $0x18,%esp
  801fd7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801fda:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801fde:	75 07                	jne    801fe7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801fe0:	b8 01 00 00 00       	mov    $0x1,%eax
  801fe5:	eb 05                	jmp    801fec <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801fe7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fec:	c9                   	leave  
  801fed:	c3                   	ret    

00801fee <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801fee:	55                   	push   %ebp
  801fef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	ff 75 08             	pushl  0x8(%ebp)
  801ffc:	6a 2d                	push   $0x2d
  801ffe:	e8 eb f9 ff ff       	call   8019ee <syscall>
  802003:	83 c4 18             	add    $0x18,%esp
	return ;
  802006:	90                   	nop
}
  802007:	c9                   	leave  
  802008:	c3                   	ret    

00802009 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802009:	55                   	push   %ebp
  80200a:	89 e5                	mov    %esp,%ebp
  80200c:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80200d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802010:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802013:	8b 55 0c             	mov    0xc(%ebp),%edx
  802016:	8b 45 08             	mov    0x8(%ebp),%eax
  802019:	6a 00                	push   $0x0
  80201b:	53                   	push   %ebx
  80201c:	51                   	push   %ecx
  80201d:	52                   	push   %edx
  80201e:	50                   	push   %eax
  80201f:	6a 2e                	push   $0x2e
  802021:	e8 c8 f9 ff ff       	call   8019ee <syscall>
  802026:	83 c4 18             	add    $0x18,%esp
}
  802029:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80202c:	c9                   	leave  
  80202d:	c3                   	ret    

0080202e <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80202e:	55                   	push   %ebp
  80202f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802031:	8b 55 0c             	mov    0xc(%ebp),%edx
  802034:	8b 45 08             	mov    0x8(%ebp),%eax
  802037:	6a 00                	push   $0x0
  802039:	6a 00                	push   $0x0
  80203b:	6a 00                	push   $0x0
  80203d:	52                   	push   %edx
  80203e:	50                   	push   %eax
  80203f:	6a 2f                	push   $0x2f
  802041:	e8 a8 f9 ff ff       	call   8019ee <syscall>
  802046:	83 c4 18             	add    $0x18,%esp
}
  802049:	c9                   	leave  
  80204a:	c3                   	ret    

0080204b <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80204b:	55                   	push   %ebp
  80204c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80204e:	6a 00                	push   $0x0
  802050:	6a 00                	push   $0x0
  802052:	6a 00                	push   $0x0
  802054:	ff 75 0c             	pushl  0xc(%ebp)
  802057:	ff 75 08             	pushl  0x8(%ebp)
  80205a:	6a 30                	push   $0x30
  80205c:	e8 8d f9 ff ff       	call   8019ee <syscall>
  802061:	83 c4 18             	add    $0x18,%esp
	return ;
  802064:	90                   	nop
}
  802065:	c9                   	leave  
  802066:	c3                   	ret    

00802067 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  802067:	55                   	push   %ebp
  802068:	89 e5                	mov    %esp,%ebp
  80206a:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80206d:	8b 55 08             	mov    0x8(%ebp),%edx
  802070:	89 d0                	mov    %edx,%eax
  802072:	c1 e0 02             	shl    $0x2,%eax
  802075:	01 d0                	add    %edx,%eax
  802077:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80207e:	01 d0                	add    %edx,%eax
  802080:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802087:	01 d0                	add    %edx,%eax
  802089:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802090:	01 d0                	add    %edx,%eax
  802092:	c1 e0 04             	shl    $0x4,%eax
  802095:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  802098:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80209f:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8020a2:	83 ec 0c             	sub    $0xc,%esp
  8020a5:	50                   	push   %eax
  8020a6:	e8 5a fd ff ff       	call   801e05 <sys_get_virtual_time>
  8020ab:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8020ae:	eb 41                	jmp    8020f1 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8020b0:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8020b3:	83 ec 0c             	sub    $0xc,%esp
  8020b6:	50                   	push   %eax
  8020b7:	e8 49 fd ff ff       	call   801e05 <sys_get_virtual_time>
  8020bc:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8020bf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8020c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8020c5:	29 c2                	sub    %eax,%edx
  8020c7:	89 d0                	mov    %edx,%eax
  8020c9:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8020cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8020cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8020d2:	89 d1                	mov    %edx,%ecx
  8020d4:	29 c1                	sub    %eax,%ecx
  8020d6:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8020d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8020dc:	39 c2                	cmp    %eax,%edx
  8020de:	0f 97 c0             	seta   %al
  8020e1:	0f b6 c0             	movzbl %al,%eax
  8020e4:	29 c1                	sub    %eax,%ecx
  8020e6:	89 c8                	mov    %ecx,%eax
  8020e8:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8020eb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8020ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8020f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8020f4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8020f7:	72 b7                	jb     8020b0 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  8020f9:	90                   	nop
  8020fa:	c9                   	leave  
  8020fb:	c3                   	ret    

008020fc <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8020fc:	55                   	push   %ebp
  8020fd:	89 e5                	mov    %esp,%ebp
  8020ff:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  802102:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  802109:	eb 03                	jmp    80210e <busy_wait+0x12>
  80210b:	ff 45 fc             	incl   -0x4(%ebp)
  80210e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802111:	3b 45 08             	cmp    0x8(%ebp),%eax
  802114:	72 f5                	jb     80210b <busy_wait+0xf>
	return i;
  802116:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802119:	c9                   	leave  
  80211a:	c3                   	ret    
  80211b:	90                   	nop

0080211c <__udivdi3>:
  80211c:	55                   	push   %ebp
  80211d:	57                   	push   %edi
  80211e:	56                   	push   %esi
  80211f:	53                   	push   %ebx
  802120:	83 ec 1c             	sub    $0x1c,%esp
  802123:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802127:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80212b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80212f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802133:	89 ca                	mov    %ecx,%edx
  802135:	89 f8                	mov    %edi,%eax
  802137:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80213b:	85 f6                	test   %esi,%esi
  80213d:	75 2d                	jne    80216c <__udivdi3+0x50>
  80213f:	39 cf                	cmp    %ecx,%edi
  802141:	77 65                	ja     8021a8 <__udivdi3+0x8c>
  802143:	89 fd                	mov    %edi,%ebp
  802145:	85 ff                	test   %edi,%edi
  802147:	75 0b                	jne    802154 <__udivdi3+0x38>
  802149:	b8 01 00 00 00       	mov    $0x1,%eax
  80214e:	31 d2                	xor    %edx,%edx
  802150:	f7 f7                	div    %edi
  802152:	89 c5                	mov    %eax,%ebp
  802154:	31 d2                	xor    %edx,%edx
  802156:	89 c8                	mov    %ecx,%eax
  802158:	f7 f5                	div    %ebp
  80215a:	89 c1                	mov    %eax,%ecx
  80215c:	89 d8                	mov    %ebx,%eax
  80215e:	f7 f5                	div    %ebp
  802160:	89 cf                	mov    %ecx,%edi
  802162:	89 fa                	mov    %edi,%edx
  802164:	83 c4 1c             	add    $0x1c,%esp
  802167:	5b                   	pop    %ebx
  802168:	5e                   	pop    %esi
  802169:	5f                   	pop    %edi
  80216a:	5d                   	pop    %ebp
  80216b:	c3                   	ret    
  80216c:	39 ce                	cmp    %ecx,%esi
  80216e:	77 28                	ja     802198 <__udivdi3+0x7c>
  802170:	0f bd fe             	bsr    %esi,%edi
  802173:	83 f7 1f             	xor    $0x1f,%edi
  802176:	75 40                	jne    8021b8 <__udivdi3+0x9c>
  802178:	39 ce                	cmp    %ecx,%esi
  80217a:	72 0a                	jb     802186 <__udivdi3+0x6a>
  80217c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802180:	0f 87 9e 00 00 00    	ja     802224 <__udivdi3+0x108>
  802186:	b8 01 00 00 00       	mov    $0x1,%eax
  80218b:	89 fa                	mov    %edi,%edx
  80218d:	83 c4 1c             	add    $0x1c,%esp
  802190:	5b                   	pop    %ebx
  802191:	5e                   	pop    %esi
  802192:	5f                   	pop    %edi
  802193:	5d                   	pop    %ebp
  802194:	c3                   	ret    
  802195:	8d 76 00             	lea    0x0(%esi),%esi
  802198:	31 ff                	xor    %edi,%edi
  80219a:	31 c0                	xor    %eax,%eax
  80219c:	89 fa                	mov    %edi,%edx
  80219e:	83 c4 1c             	add    $0x1c,%esp
  8021a1:	5b                   	pop    %ebx
  8021a2:	5e                   	pop    %esi
  8021a3:	5f                   	pop    %edi
  8021a4:	5d                   	pop    %ebp
  8021a5:	c3                   	ret    
  8021a6:	66 90                	xchg   %ax,%ax
  8021a8:	89 d8                	mov    %ebx,%eax
  8021aa:	f7 f7                	div    %edi
  8021ac:	31 ff                	xor    %edi,%edi
  8021ae:	89 fa                	mov    %edi,%edx
  8021b0:	83 c4 1c             	add    $0x1c,%esp
  8021b3:	5b                   	pop    %ebx
  8021b4:	5e                   	pop    %esi
  8021b5:	5f                   	pop    %edi
  8021b6:	5d                   	pop    %ebp
  8021b7:	c3                   	ret    
  8021b8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8021bd:	89 eb                	mov    %ebp,%ebx
  8021bf:	29 fb                	sub    %edi,%ebx
  8021c1:	89 f9                	mov    %edi,%ecx
  8021c3:	d3 e6                	shl    %cl,%esi
  8021c5:	89 c5                	mov    %eax,%ebp
  8021c7:	88 d9                	mov    %bl,%cl
  8021c9:	d3 ed                	shr    %cl,%ebp
  8021cb:	89 e9                	mov    %ebp,%ecx
  8021cd:	09 f1                	or     %esi,%ecx
  8021cf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8021d3:	89 f9                	mov    %edi,%ecx
  8021d5:	d3 e0                	shl    %cl,%eax
  8021d7:	89 c5                	mov    %eax,%ebp
  8021d9:	89 d6                	mov    %edx,%esi
  8021db:	88 d9                	mov    %bl,%cl
  8021dd:	d3 ee                	shr    %cl,%esi
  8021df:	89 f9                	mov    %edi,%ecx
  8021e1:	d3 e2                	shl    %cl,%edx
  8021e3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021e7:	88 d9                	mov    %bl,%cl
  8021e9:	d3 e8                	shr    %cl,%eax
  8021eb:	09 c2                	or     %eax,%edx
  8021ed:	89 d0                	mov    %edx,%eax
  8021ef:	89 f2                	mov    %esi,%edx
  8021f1:	f7 74 24 0c          	divl   0xc(%esp)
  8021f5:	89 d6                	mov    %edx,%esi
  8021f7:	89 c3                	mov    %eax,%ebx
  8021f9:	f7 e5                	mul    %ebp
  8021fb:	39 d6                	cmp    %edx,%esi
  8021fd:	72 19                	jb     802218 <__udivdi3+0xfc>
  8021ff:	74 0b                	je     80220c <__udivdi3+0xf0>
  802201:	89 d8                	mov    %ebx,%eax
  802203:	31 ff                	xor    %edi,%edi
  802205:	e9 58 ff ff ff       	jmp    802162 <__udivdi3+0x46>
  80220a:	66 90                	xchg   %ax,%ax
  80220c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802210:	89 f9                	mov    %edi,%ecx
  802212:	d3 e2                	shl    %cl,%edx
  802214:	39 c2                	cmp    %eax,%edx
  802216:	73 e9                	jae    802201 <__udivdi3+0xe5>
  802218:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80221b:	31 ff                	xor    %edi,%edi
  80221d:	e9 40 ff ff ff       	jmp    802162 <__udivdi3+0x46>
  802222:	66 90                	xchg   %ax,%ax
  802224:	31 c0                	xor    %eax,%eax
  802226:	e9 37 ff ff ff       	jmp    802162 <__udivdi3+0x46>
  80222b:	90                   	nop

0080222c <__umoddi3>:
  80222c:	55                   	push   %ebp
  80222d:	57                   	push   %edi
  80222e:	56                   	push   %esi
  80222f:	53                   	push   %ebx
  802230:	83 ec 1c             	sub    $0x1c,%esp
  802233:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802237:	8b 74 24 34          	mov    0x34(%esp),%esi
  80223b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80223f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802243:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802247:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80224b:	89 f3                	mov    %esi,%ebx
  80224d:	89 fa                	mov    %edi,%edx
  80224f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802253:	89 34 24             	mov    %esi,(%esp)
  802256:	85 c0                	test   %eax,%eax
  802258:	75 1a                	jne    802274 <__umoddi3+0x48>
  80225a:	39 f7                	cmp    %esi,%edi
  80225c:	0f 86 a2 00 00 00    	jbe    802304 <__umoddi3+0xd8>
  802262:	89 c8                	mov    %ecx,%eax
  802264:	89 f2                	mov    %esi,%edx
  802266:	f7 f7                	div    %edi
  802268:	89 d0                	mov    %edx,%eax
  80226a:	31 d2                	xor    %edx,%edx
  80226c:	83 c4 1c             	add    $0x1c,%esp
  80226f:	5b                   	pop    %ebx
  802270:	5e                   	pop    %esi
  802271:	5f                   	pop    %edi
  802272:	5d                   	pop    %ebp
  802273:	c3                   	ret    
  802274:	39 f0                	cmp    %esi,%eax
  802276:	0f 87 ac 00 00 00    	ja     802328 <__umoddi3+0xfc>
  80227c:	0f bd e8             	bsr    %eax,%ebp
  80227f:	83 f5 1f             	xor    $0x1f,%ebp
  802282:	0f 84 ac 00 00 00    	je     802334 <__umoddi3+0x108>
  802288:	bf 20 00 00 00       	mov    $0x20,%edi
  80228d:	29 ef                	sub    %ebp,%edi
  80228f:	89 fe                	mov    %edi,%esi
  802291:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802295:	89 e9                	mov    %ebp,%ecx
  802297:	d3 e0                	shl    %cl,%eax
  802299:	89 d7                	mov    %edx,%edi
  80229b:	89 f1                	mov    %esi,%ecx
  80229d:	d3 ef                	shr    %cl,%edi
  80229f:	09 c7                	or     %eax,%edi
  8022a1:	89 e9                	mov    %ebp,%ecx
  8022a3:	d3 e2                	shl    %cl,%edx
  8022a5:	89 14 24             	mov    %edx,(%esp)
  8022a8:	89 d8                	mov    %ebx,%eax
  8022aa:	d3 e0                	shl    %cl,%eax
  8022ac:	89 c2                	mov    %eax,%edx
  8022ae:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022b2:	d3 e0                	shl    %cl,%eax
  8022b4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8022b8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022bc:	89 f1                	mov    %esi,%ecx
  8022be:	d3 e8                	shr    %cl,%eax
  8022c0:	09 d0                	or     %edx,%eax
  8022c2:	d3 eb                	shr    %cl,%ebx
  8022c4:	89 da                	mov    %ebx,%edx
  8022c6:	f7 f7                	div    %edi
  8022c8:	89 d3                	mov    %edx,%ebx
  8022ca:	f7 24 24             	mull   (%esp)
  8022cd:	89 c6                	mov    %eax,%esi
  8022cf:	89 d1                	mov    %edx,%ecx
  8022d1:	39 d3                	cmp    %edx,%ebx
  8022d3:	0f 82 87 00 00 00    	jb     802360 <__umoddi3+0x134>
  8022d9:	0f 84 91 00 00 00    	je     802370 <__umoddi3+0x144>
  8022df:	8b 54 24 04          	mov    0x4(%esp),%edx
  8022e3:	29 f2                	sub    %esi,%edx
  8022e5:	19 cb                	sbb    %ecx,%ebx
  8022e7:	89 d8                	mov    %ebx,%eax
  8022e9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8022ed:	d3 e0                	shl    %cl,%eax
  8022ef:	89 e9                	mov    %ebp,%ecx
  8022f1:	d3 ea                	shr    %cl,%edx
  8022f3:	09 d0                	or     %edx,%eax
  8022f5:	89 e9                	mov    %ebp,%ecx
  8022f7:	d3 eb                	shr    %cl,%ebx
  8022f9:	89 da                	mov    %ebx,%edx
  8022fb:	83 c4 1c             	add    $0x1c,%esp
  8022fe:	5b                   	pop    %ebx
  8022ff:	5e                   	pop    %esi
  802300:	5f                   	pop    %edi
  802301:	5d                   	pop    %ebp
  802302:	c3                   	ret    
  802303:	90                   	nop
  802304:	89 fd                	mov    %edi,%ebp
  802306:	85 ff                	test   %edi,%edi
  802308:	75 0b                	jne    802315 <__umoddi3+0xe9>
  80230a:	b8 01 00 00 00       	mov    $0x1,%eax
  80230f:	31 d2                	xor    %edx,%edx
  802311:	f7 f7                	div    %edi
  802313:	89 c5                	mov    %eax,%ebp
  802315:	89 f0                	mov    %esi,%eax
  802317:	31 d2                	xor    %edx,%edx
  802319:	f7 f5                	div    %ebp
  80231b:	89 c8                	mov    %ecx,%eax
  80231d:	f7 f5                	div    %ebp
  80231f:	89 d0                	mov    %edx,%eax
  802321:	e9 44 ff ff ff       	jmp    80226a <__umoddi3+0x3e>
  802326:	66 90                	xchg   %ax,%ax
  802328:	89 c8                	mov    %ecx,%eax
  80232a:	89 f2                	mov    %esi,%edx
  80232c:	83 c4 1c             	add    $0x1c,%esp
  80232f:	5b                   	pop    %ebx
  802330:	5e                   	pop    %esi
  802331:	5f                   	pop    %edi
  802332:	5d                   	pop    %ebp
  802333:	c3                   	ret    
  802334:	3b 04 24             	cmp    (%esp),%eax
  802337:	72 06                	jb     80233f <__umoddi3+0x113>
  802339:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80233d:	77 0f                	ja     80234e <__umoddi3+0x122>
  80233f:	89 f2                	mov    %esi,%edx
  802341:	29 f9                	sub    %edi,%ecx
  802343:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802347:	89 14 24             	mov    %edx,(%esp)
  80234a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80234e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802352:	8b 14 24             	mov    (%esp),%edx
  802355:	83 c4 1c             	add    $0x1c,%esp
  802358:	5b                   	pop    %ebx
  802359:	5e                   	pop    %esi
  80235a:	5f                   	pop    %edi
  80235b:	5d                   	pop    %ebp
  80235c:	c3                   	ret    
  80235d:	8d 76 00             	lea    0x0(%esi),%esi
  802360:	2b 04 24             	sub    (%esp),%eax
  802363:	19 fa                	sbb    %edi,%edx
  802365:	89 d1                	mov    %edx,%ecx
  802367:	89 c6                	mov    %eax,%esi
  802369:	e9 71 ff ff ff       	jmp    8022df <__umoddi3+0xb3>
  80236e:	66 90                	xchg   %ax,%ax
  802370:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802374:	72 ea                	jb     802360 <__umoddi3+0x134>
  802376:	89 d9                	mov    %ebx,%ecx
  802378:	e9 62 ff ff ff       	jmp    8022df <__umoddi3+0xb3>
