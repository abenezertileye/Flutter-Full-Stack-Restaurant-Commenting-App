import { Module } from '@nestjs/common';
import { AdminFuncService } from './admin_func.service';
import { AdminFuncController } from './admin_func.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { User, UserSchema } from 'src/schemas/user.schema';
import { Restaurant, RestaurantSchema } from 'src/schemas/restaurant.schema'; 
import { JwtService } from '@nestjs/jwt';
import { AuthGuard } from 'src/auth/guards/auth.guard';


@Module({
  imports: [
    MongooseModule.forFeature([
      { name: User.name, schema: UserSchema },
      { name: Restaurant.name, schema: RestaurantSchema }
    ]),
  ],  controllers: [AdminFuncController],
  providers: [AdminFuncService,JwtService, AuthGuard],
})
export class AdminFuncModule {}
