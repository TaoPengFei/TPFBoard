package org.tpfboard.service;

import org.tpfboard.model.User;

import java.util.List;

/**
 * Created by 陶鹏飞 on 2017/7/12.
 */
public interface UserService {
    List<User> getAllUser();
    User getUserByPhoneOrEmail(String emailOrPhone, Short state);

    User getUserById(Long userId);
}
