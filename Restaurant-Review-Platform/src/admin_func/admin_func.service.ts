import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from 'src/schemas/user.schema';
import { Restaurant } from 'src/schemas/restaurant.schema';


@Injectable()
export class AdminFuncService {
  constructor(
    @InjectModel(User.name) private userModel: Model<User>,
    @InjectModel(Restaurant.name) private restaurantModel: Model<Restaurant>
  ) {}
  // create(createAdminFuncDto: CreateAdminFuncDto) {
  //   return 'This action adds a new adminFunc';
  // }

  // findAll() {
  //   return `This action returns all adminFunc`;
  // }

  // findOne(id: number) {
  //   return `This action returns a #${id} adminFunc`;
  // }

 async ban(username: string) {
  const user = await this.userModel.findOneAndUpdate({ username }, { isBanned: true }, { new: true }).exec();
  const restaurant = await this.restaurantModel.findOneAndUpdate({ ownerId: user._id }, { isBanned: true }, { new: true }).exec();
  

    return 'user/owner is banned. dont forget to erase the token from the front end';
  }

 async unban(username: string) {
  const user = await this.userModel.findOneAndUpdate({ username }, { isBanned: false }, { new: true }).exec();
  const restaurant = await this.restaurantModel.findOneAndUpdate({ ownerId: user._id }, { isBanned: false }, { new: true }).exec();

    return 'user/owner is unbanned';
  }

  // remove(id: number) {
  //   return `This action removes a #${id} adminFunc`;
  // }
}