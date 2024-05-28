import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards } from '@nestjs/common';
import { AdminFuncService } from './admin_func.service';
import { CreateAdminFuncDto } from './dto/create-admin_func.dto';
import { UpdateAdminFuncDto } from './dto/update-admin_func.dto';
import { AuthGuard } from 'src/auth/guards/auth.guard';
import { RolesGuard } from 'src/auth/guards/roles.guard';
import { UserRole } from 'src/auth/enums/roles.enum';
import { Roles } from 'src/auth/decorators/roles.decorator';

@Controller('admin-func')
export class AdminFuncController {
  constructor(private readonly adminFuncService: AdminFuncService) {}

  // @Post()
  // create(@Body() createAdminFuncDto: CreateAdminFuncDto) {
  //   return this.adminFuncService.create(createAdminFuncDto);
  // }

  @Get()
  findAll() {
    return 'here';
  }

  // @Get(':id')
  // findOne(@Param('id') id: string) {
  //   return this.adminFuncService.findOne(+id);
  // }

  @Patch('/ban/:username')
  @UseGuards(RolesGuard)
  @Roles(UserRole.ADMIN)
  ban(@Param('username') username: string) {
    return this.adminFuncService.ban(username);
  }

  @Patch('/unban/:username')
  @UseGuards(RolesGuard)
  @Roles(UserRole.ADMIN)
  unban(@Param('username') username: string) {
    return this.adminFuncService.unban(username);
  }

  // @Delete(':id')
  // remove(@Param('id') id: string) {
  //   return this.adminFuncService.remove(+id);
  // }
}
